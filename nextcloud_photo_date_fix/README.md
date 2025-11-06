# Installation Instructions
1. **Download the script**  
   Download the file `nextcloud_photo_date_fix.sh` and edit it as described within the file.

2. **Move the script to your desired location**  
   Move the file to a location of your choice (e.g., `/usr/local/bin/`).

3. **Configure the cron job**  
   Open your root crontab (by running `sudo crontab -e`).

   Then, add the following line to your crontab (replace `YOUR_PATH_HERE` with the path you used in the previous step):

   ```bash
   * * * * * YOUR_PATH_HERE/nextcloud_photo_date_fix.sh >> /var/log/nextcloud_photo_date_fix.log 2>&1
