# jellyfin-scripts

## -- library-metadata-cleanup-jellyfin-v10.10.sh --

This script is meant to only be used on Jellyfin media libraries that also hold Jellyfin's metadata.
I recommend testing this script on a small copy of your actual libraries first before using it on whole libraries.

This script works with Jellyfin v10.10
If any changes are made to Jellyfin that change how metadata is automatically named, this script might need to be remade/reworked.

Run the script with the "-h" flag to skip all verbose output and only print out errors.
You can enable or disable leftover trickplay deletion by editing line 117.

This will find and delete all left-over .nfo and jpg thumbnails that no longer have an accompanying video file.
The script will loop through libraries looking for leftover metadata. Modify the path name variables on top of the script to get it working for your server.

By default, this script has 10 spots to enable library paths to be cleaned. If you need more, you'll need to add more variables to hold the new library paths, then you'll need to modify the library arrays to include the new variables.
It should be straight-foward what you need to copy and paste to add more libraries by looking at the lines of code from 7-105.

If you want to modify the script logic, keep in mind the script has two locations for doing the main logic of a single library.
This is due to having an if-statement check if "-h" was passed as a flag to silence the output of the script (useful for running when no output is desired, warnings will still be outputed however).
Change both if you're modyfing one to make the script consistent with all the built-in flags.

The script shouldn't delete anything that's not a .jpg or extra .nfo file. However, just in case any other file type gets deleted, the script will output that an "incorrect" file has been deleted and won't work until the situation has been dealt with.

All deletions are sent to a log as described in the script.
If a video file is deleted due to a fault in this script, it will get marked down in the deletion log.
The script will refuse to run until the deletion log is cleared/deleted.
This is to avoid further loses of any more video media until the cause is figured out.

Don't forget to link the correct paths in the script.

### THIS SCRIPT WILL ERASE ALL JPG, NFO, & TRICKPLAY FILES THAT DON'T MATCH A VIDEO FILE NAME IN THE SAME LINKED DIRECTORIES

Don't lose your stored images and other metadata files by accident.

The following are files that are excluded from being deleted:

- tvshow.nfo
- season.nfo
- movie.nfo
- VIDEO_TS.nfo
- artist.nfo
- album.nfo
- folder.jpg
- banner.jpg
- backdrop.jpg
- logo.jpg
- cover.jpg
- landscape.jpg
- "-poster.*"

If your server has extra jpg files that are used for metadata purposes that don't match with this list, they will be deleted.
You will have to modify the script to ignore other jpg metadata that you want to keep.

Notes on why I created this:

- I manually delete files a lot on my server. I sometimes forget to delete the related metadata files that Jellyfin and Jellyscrub place in my libraries.
- These left-over metadata files are useless, take up space, and stick around forever unless I find and delete them.
- I created this to run on my TrueNAS server, thus why I set the script to ignore paths with ".zfs".
