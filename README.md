# jellyfin-scripts

### -- jellyfin-library-metadata-cleanup.sh --
This script is meant for those that store metadata alongside their Jellyfin media libraries.

This will find and delete all left-over jpg thumbnails and trickplay related files (.bif, -manifest.json) that no longer have an accompanying video file.
The script by default will look through three libraries. Modify the path name variables on top of the script to get it working for your server.

If you have less than three libraries, either delete all the lines in the script for the uneeded library, or point the left-over library paths to the same library (the script will iterate again through them again catching nothing).

If you need more, just copy-paste the lines needed in the script and place them right after the grouping of where they're all originally located. Don't forget to also make new variable names and replace the variable names of the lines too.

Keep in mind that the script has two locations for doing the main logic of a single library. This is due to having an if-statement check if "-h" was passed as a flag to silence the output of the script (useful for running when no output is desired, warnings will still be outputed however).
Change both if you're modyfing one to make the script consistent with all the built-in flags.

The script shouldn't delete anything that's not a .jpg, .bif, or -manifest.json file. However, just in case any other file type gets deleted, the script will output that an "incorrect" file has been deleted and won't work until the situation has been dealt with.

All deletions are sent to a log as described in the script.

```
Notes on left-over detection:
1. As the script is, it's meant to deal with metadata files that Jellyfin handled in naming.
2. This script handles detection well when adding to video file names.
3. This script doesn't handle well (won't detect) when you remove from video file names.

As an example with six files:
    EP1 [12345678].mkv
    EP1 [12345678].jpg
    EP1 [87654321].jpg
    EP2 [12345678].mkv
    EP2 [12345678].jpg
    EP2.jpg
results in these files remaining:
    EP1 [12345678].mkv
    EP1 [12345678].jpg
    EP2 [12345678].mkv
    EP2 [12345678].jpg

However:
    EP1.mkv
    EP1.jpg
    EP1 [87654321].jpg
    EP2 [12345678]New.mkv
    EP2 [12345678]New.jpg
    EP2 [12345678].jpg
results in these files remaining:
    EP1.mkv
    EP1.jpg
    EP1 [87654321].jpg
    EP2 [12345678]New.mkv
    EP2 [12345678]New.jpg

4. I also found that this scrip will not detect files that have a copy made by Windows.
    detected ------> oldThumbnail.jpg
    not detected --> oldThumbnail-Copy.jpg

```

Also, don't forget to link the correct paths in the script.
### THIS SCRIPT WILL ERASE ALL JPG FILES THAT DON'T MATCH A VIDEO FILE NAME IN THE SAME LINKED DIRECTORIES.
Don't lose your stored images by accident.

The following list are jpg files that are excluded from being deleted:
- folder.jpg
- banner.jpg
- backdrop.jpg
- logo.jpg
- cover.jpg

If your server has extra jpg files that are used for metadata purposes that don't match with this list, they will be deleted.
You will have to modify the script to ignore other jpg metadata that you want to keep.

Notes on why I created this:
  - I manually delete files a lot on my server. I sometimes forget to delete the related metadata files that Jellyfin and Jellyscrub place in my libraries.
  - These left-over metadata files are useless, take up space, and stick around forever unless I find and delete them.
