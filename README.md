# jellyfin-scripts

### -- jellyfin-library-metadata-cleanup.sh --
This script is meant to only be used on Jellyfin media libraries that also hold Jellyfin's metadata.

This script works with Jellyfin v10.8.13 and Jellyscrub v1.1.1.0.
If any changes are made to either that change how metadata is automatically named, this script might need to be remade/reworked.

This will find and delete all left-over jpg thumbnails and trickplay related files (.bif, -manifest.json) that no longer have an accompanying video file.
The script will loop through libraries looking for leftover metadata. Modify the path name variables on top of the script to get it working for your server.

By default, this script has 10 spots to enable library paths to be cleaned. If you need more, you'll need to add more variables to hold the new library paths, then you'll need to modify the library arrays to include the new variables.
It should be straight-foward what you need to copy and paste to add more libraries by looking at the lines of code from 5-101.

If you want to modify the scrip logic, keep in mind the script has two locations for doing the main logic of a single library.
This is due to having an if-statement check if "-h" was passed as a flag to silence the output of the script (useful for running when no output is desired, warnings will still be outputed however).
Change both if you're modyfing one to make the script consistent with all the built-in flags.

The script shouldn't delete anything that's not a .jpg, .bif, or -manifest.json file. However, just in case any other file type gets deleted, the script will output that an "incorrect" file has been deleted and won't work until the situation has been dealt with.

All deletions are sent to a log as described in the script.

Also, don't forget to link the correct paths in the script.
### THIS SCRIPT WILL ERASE ALL JPG FILES THAT DON'T MATCH A VIDEO FILE NAME IN THE SAME LINKED DIRECTORIES.
Don't lose your stored images by accident.

The following are files that are excluded from being deleted:
- folder.jpg
- banner.jpg
- backdrop.jpg
- logo.jpg
- cover.jpg
- tvshow.nfo
- season.nfo

If your server has extra jpg files that are used for metadata purposes that don't match with this list, they will be deleted.
You will have to modify the script to ignore other jpg metadata that you want to keep.

Note:
- I separated file types from the logic and into variables to make editing the script easier. Just creating a new variable for your new metadata won't be enough. You need to modifiy the actual logic to include your new variable.

The main lines that contain the logic to edit the libraries are located at lines 201-203 (for -h flag, not-verbose output), and lines 310-312 (for all other verbose output).

Notes on why I created this:
  - I manually delete files a lot on my server. I sometimes forget to delete the related metadata files that Jellyfin and Jellyscrub place in my libraries.
  - These left-over metadata files are useless, take up space, and stick around forever unless I find and delete them.
