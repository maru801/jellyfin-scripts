# jellyfin-scripts

### -- jellyfin-library-metadata-cleanup.sh --
This will find and delete all left-over jpg thumbnails and trickplay related files (.bif, -manifest.json) that no longer have an accompanying video file.
The script by default will look through three libraries. Modify the path name variables on top of the script to get it working for your server.

If you have less than three libraries, either delete all the lines in the script for the uneeded library, or point the left-over library paths to the same library (the script will iterate again through them again catching nothing).

If you need more, just copy-paste the lines needed in the script and place them right after the grouping of where they're all originally located. Don't forget to also make new variable names and replace the variable names of the lines too.

Keep in mind that the script has two locations for doing the main logic of a single library. This is due to having an if-statement check if "-h" was passed as a flag to silence the output of the script (useful for running when no output is desired, warnings will still be outputed however).
Change both if you're modyfing one to make the script consistent with all the built-in flags.

The script shouldn't delete anything that's not a .jpg, .bif, or -manifest.json file. However, just in case any other file type gets deleted, the script will output that an "incorrect" file has been deleted and won't work until the situation has been dealt with.

All deletions are sent to a log as described in the script.
