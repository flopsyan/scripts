# Unzip Subfolders
Extracts every ZIP file inside the subfolders of the current directory into the subfolder it came from.

Useful when a bulk download leaves you with one archive per folder - the script unpacks them all in one go, in parallel.

## How it works
1. Matches all archives one level deep (`*/*.zip`)
2. Extracts each one into its own subfolder, overwriting existing files (`unzip -o`)
3. Runs all extractions in parallel and waits until every one has finished

## Requirements
- Any Linux distribution with `bash` and `unzip`

## Usage
Run the script from the parent directory that contains the subfolders:

```bash
./unzip_subfolders.sh
```

Given `photos/a.zip` and `docs/b.zip`, the contents end up in `photos/` and `docs/`. The ZIP files themselves are kept.
