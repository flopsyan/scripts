#!/usr/bin/env bash
set -euo pipefail


############################
### edit these variables ###
############################

NC_USER=""     # your nextcloud username
PHOTO_DIR=""   # the path to your nextcloud photo folder
LOOKBACK=""    # how often to check for new files (in minutes; e.g. 60)
CONTAINER=""   # name of your Nextcloud docker container
OCC_PATH=""    # full path to occ inside the container (e.g. /var/www/html/occ)

############################
############################
############################


# applies the EXIF time to new files
find "$PHOTO_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' \) -mmin "-$LOOKBACK" -exec exiftool -overwrite_original_in_place -if 'defined $DateTimeOriginal' -m -P -q '-FileModifyDate<DateTimeOriginal' {} +

# scans the Nextcloud files to apply the changes
docker exec -u www-data "$CONTAINER" php -f "$OCC_PATH" files:scan "$NC_USER" --path="$PHOTO_DIR" --quiet
