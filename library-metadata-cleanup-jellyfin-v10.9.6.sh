#!/bin/bash

## Note: For all variables, use "quotes" when adding things with spaces or special characters
serverName="YourServerName"
serverVersion=10.9.6

#######################################################################################
######################################## Paths ########################################
## Removal Log Location Info ##
## Filename doesn't matter for both permanent & temp removal logs ##
## Make sure other files in given path don't conflict with the filename you provide. ##
scriptLogLocationPathOnly=test/
scriptLogLocation=test/removed-log.txt
scriptTempLogLocation=test/temp-removed-log.txt

## Library Paths ##
## Enable libraries by setting to "true" ##
## Use absolute paths, or relative paths to where this script will be stored ##

library1="test1"             ## Path to library (enclose in "quotes" to avoid issues with spaces and special characters)
library1Enabled=false        ## enable with "true" (all lower-case)
library1Name="Test1 Library" ## Name of your library

library2="test2"
library2Enabled=false
library2Name="Test2 Library"

library3="test3"
library3Enabled=false
library3Name="Test3 Library"

library4="test4"
library4Enabled=false
library4Name="Test4 Library"

library5="test5"
library5Enabled=false
library5Name="Test5 Library"

library6="test6"
library6Enabled=false
library6Name="Test6 Library"

library7="test7"
library7Enabled=false
library7Name="Test7 Library"

library8="test8"
library8Enabled=false
library8Name="Test8 Library"

library9="test9"
library9Enabled=false
library9Name="Test9 Library"

library10="test10"
library10Enabled=false
library10Name="Test10 Library"

## Make sure libraryCount is set to the same number of libraries that you create. ##
libraryCount=10

## Make sure to add to the following arrays if you're creating extra libraries. ##

## Enclose array variables in "quotes" to avoid space and special character issues ##
libraryPathArray=(
    "$library1"
    "$library2"
    "$library3"
    "$library4"
    "$library5"
    "$library6"
    "$library7"
    "$library8"
    "$library9"
    "$library10"
)

LibraryEnabledArray=(
    $library1Enabled
    $library2Enabled
    $library3Enabled
    $library4Enabled
    $library5Enabled
    $library6Enabled
    $library7Enabled
    $library8Enabled
    $library9Enabled
    $library10Enabled
)

## Enclose array variables in "quotes" to avoid space and special character issues ##
libraryNameArray=(
    "$library1Name"
    "$library2Name"
    "$library3Name"
    "$library4Name"
    "$library5Name"
    "$library6Name"
    "$library7Name"
    "$library8Name"
    "$library9Name"
    "$library10Name"
)
#######################################################################################

######################################################################
###################### File Types to Clean Out #######################
fileType1=.nfo
fileType2=-thumb  ## Make sure to not add anything else after "thumb". This needs to match with anything containing "-thumb", not just "*-thumb.*", but "*-thumb*".
######################################################################

################################
## Files to Ignore/Not Delete ##
ignoreFile1="tvshow.nfo"
ignoreFile2="season.nfo"
ignoreFile3="movie.nfo" ## New addition for v10.9, all movies will have their .nfo files named like this instead of their full file name.
ignoreFile4=VIDEO_TS.nfo
ignoreFile5=artist.nfo ## Music library metadata
ignoreFile6=album.nfo ## Music library metadata
## Note: The bottom variables are not used with this script as of version 10.9.6, I'm keeping theme declared here in case their needed later on.
ignoreFile7="folder.*"
ignoreFile8="banner.*"
ignoreFile9="backdrop.*"
ignoreFile10="logo.*"
ignoreFile11="cover.*"
ignoreFile12="landscape.*" ## These are named "thumbs" in the Jellyfin UI.
ignoreFile13="-poster.*"  ## New addition for v10.9, all seasons will now save "folder.jpg" covers as "season##-poster.jpg".
################################

#########################################
## List of Video File Types to Compare ##
videoType1=.mkv
videoType2=.mk3d
videoType3=.mp4
videoType4=.m4v
videoType5=.mov
videoType6=.qt
videoType7=.asf
videoType8=.wmv
videoType9=.avi
videoType10=.mxf
videoType11=.m2p
videoType12=.ps
videoType13=.ts
videoType14=.tsv
videoType15=.m2ts
videoType16=.mts
videoType17=.vob
videoType18=.evo
videoType19=.3gp
videoType20=.3g2
videoType21=.f4v
videoType22=.flv
videoType23=.ogv
videoType24=.ogx
videoType25=.webm
videoType26=.rmvb
videoType27=.divx
videoType28=.xvid
videoType29=.mpg
#########################################

if [ "$1" == "-c" ]; then
    echo "Delete the removal log? Enter [Y] to delete..."
    read userDeleteChoice

    if [ "$userDeleteChoice" == "Y" ]; then
        rm -f $scriptLogLocation
    else
        echo "...Deletion of Removal Log Aborted..."
    fi
elif [ "$1" == "-C" ]; then
    rm -f $scriptLogLocation
elif [ "$1" == "-d" ]; then
    cat $scriptLogLocation
elif [ "$1" == "-h" ]; then
    if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2" -; then
        echo ""
        echo "jellyfin-library-metadata-cleanup-v$serverVersion.sh"
        echo ""
        echo "!!!---WARNING---!!!"
        echo "Incorrect file removal has been detected from the removal log!"
        echo "Check removal log for more info of when this occured."
        echo "Please recover file(s) from snapshots/backups!"
        echo ""
        echo "This script will not run until the incorrect file has been deleted from the removal log."
        echo "Please edit the removal log or delete it to get this script working again."
        echo "-- Note: Use the [-c] flag during script runtime to delete the removal log. --"
        echo ""
        echo ">>> Detailed list of removed items appeneded to this file: $scriptLogLocation <<<"
        echo "...Ending Script..."
    else
        echo "--------------------------------" >> $scriptTempLogLocation
        date >> $scriptTempLogLocation
        echo "--------------------------------" >> $scriptTempLogLocation

        # Note: Left the "//,/" part in calls to array variables in case user creates comma separated array
        for((i = 0 ; i <= ($libraryCount - 1); i++)); do
            if [ ${LibraryEnabledArray[i]//,/} == true ]; then
                grep -vFf <(find "${libraryPathArray[i]//,/}" -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" -o -iname "*$videoType29" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find "${libraryPathArray[i]//,/}" -type f \( -iname "*$fileType1" \) | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6" -) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
                grep -vFf <(find "${libraryPathArray[i]//,/}" -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" -o -iname "*$videoType29" \) -exec basename {} \; | sed 's/\.[^.]*$/-thumb./gm') <(find "${libraryPathArray[i]//,/}" -type f \( -iname "*$fileType2*" \) | grep -Ei ".jpg|.jpeg|.png|.svg|.webp" - ) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
            fi
        done

        echo "" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation

        if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
            cat $scriptTempLogLocation >> $scriptLogLocation
        fi

        rm $scriptTempLogLocation

        if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2" -; then
            echo ""
            echo "jellyfin-library-metadata-cleanup-v$serverVersion.sh"
            echo ""
            echo "!!!---WARNING---!!!"
            echo "Incorrect file removal has been detected from the removal log!"
            echo "Check removal log for more info of when this occured."
            echo "Please recover file(s) from snapshots/backups!"
            echo ""
            echo "This script will not run until the incorrect file has been deleted from the removal log."
            echo "Please edit the removal log or delete it to get this script working again."
            echo "-- Note: Use the [-c] flag during script runtime to delete the removal log. --"
            echo ""
            echo ">>> Detailed list of removed items appeneded to this file: $scriptLogLocation <<<"
            echo ""
            echo "---Feel free to delete this log file for whatever reason (ex. log got too big, free up space).---"
            echo "---This log file will be recreated on the next launch of this script.---"
            echo "...Ending Script..."
        fi
    fi
else
    if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2" -; then
        echo ""
        echo "jellyfin-library-metadata-cleanup-v$serverVersion.sh"
        echo ""
        echo "!!!---WARNING---!!!"
        echo "Incorrect file removal has been detected from the removal log!"
        echo "Check removal log for more info of when this occured."
        echo "Please recover file(s) from snapshots/backups!"
        echo ""
        echo "This script will not run until the incorrect file has been deleted from the removal log."
        echo "Please edit the removal log or delete it to get this script working again."
        echo "-- Note: Use the [-c] flag during script runtime to delete the removal log. --"
        echo ""
        echo ">>> Detailed list of removed items appeneded to this file: $scriptLogLocation <<<"
        echo "...Ending Script..."
    else
        echo "Start-up Flags (Use at Runtime):"
        echo "[-c]: Delete the current removal log file."
        echo "[-C]: Force delete the current removal log file."
        echo "[-x]: Delete the current removal log file AND run the script after."
        echo "[-X]: Force delete the current removal log file AND run the script after."
        echo "[-d]: Print out the romoval log."
        echo "[-h]: Hide non-error verbose output."
        echo "--Note: This script currently only supports one flag at a time.--"
        echo ""
        echo "--Script designed for \"$serverName\"--"

        echo "---Script made for Jellyfin v$serverVersion---"
        echo "---Any future changes to automatic metadata naming/sorting convention by Jellyfin may break this script.---"
        echo ""
        echo "This script currently only supports libraries that contain videos. Music libraries are not supported (have not been tested) by this script."
        echo ""
        echo "This script expects the following paths to exist on the system:"
        echo "1: $scriptLogLocationPathOnly {Removal Log Storage Location}"

        # Note: Left the "//,/" part in calls to array variables in case user creates comma separated array
        for((i = 0 ; i <= ($libraryCount - 1); i++)); do
            if [ ${LibraryEnabledArray[i]//,/} == true ]; then
                echo "$[i+2]: ${libraryPathArray[i]//,/} {${libraryNameArray[i]//,/}}"
            fi
        done

        echo ""

        echo "This bash script will delete leftover jpg thumbnails and nfo related files from the linked libraries in the script."
        echo ""
        echo "The user running this script needs to have the correct permissions set to access all three libraries and delete files."
        echo ""

        echo "---Enter [Y] to Proceed---"
        read userExitChoice

        if [ "$userExitChoice" == "Y" ]; then
            if [ "$1" == "-x" ]; then
                echo "Delete the removal log? Enter [Y] to delete..."
                read userDeleteChoice

                if [ "$userDeleteChoice" == "Y" ]; then
                    rm -f $scriptLogLocation
                else
                    echo "...Deletion of Removal Log Aborted..."
                fi
            elif [ "$1" == "-X" ]; then
                rm -f $scriptLogLocation
            fi

            echo "--------------------------------" >> $scriptTempLogLocation
            date >> $scriptTempLogLocation
            echo "--------------------------------" >> $scriptTempLogLocation

            # Note: Left the "//,/" part in calls to array variables in case user creates comma separated array
            for((i = 0 ; i <= ($libraryCount - 1); i++)); do
                if [ ${LibraryEnabledArray[i]//,/} == true ]; then
                    echo ""
                    echo "-----Cleaning \"${libraryNameArray[i]//,/}\" (rm uneeded $fileType1 + $fileType2 files)-----"
                    grep -vFf <(find "${libraryPathArray[i]//,/}" -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" -o -iname "*$videoType29" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find "${libraryPathArray[i]//,/}" -type f \( -iname "*$fileType1" \) | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6" -) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
                    grep -vFf <(find "${libraryPathArray[i]//,/}" -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" -o -iname "*$videoType29" \) -exec basename {} \; | sed 's/\.[^.]*$/-thumb./gm') <(find "${libraryPathArray[i]//,/}" -type f \( -iname "*$fileType2*" \) | grep -Ei ".jpg|.jpeg|.png|.svg|.webp" - ) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
                fi
            done

            echo "" >> $scriptTempLogLocation
            echo "" >> $scriptTempLogLocation
            echo ""

            if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
                cat $scriptTempLogLocation >> $scriptLogLocation
            fi

            rm $scriptTempLogLocation

            if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2" -; then
                echo ""
                echo "jellyfin-library-metadata-cleanup-v$serverVersion.sh"
                echo ""
                echo "!!!---WARNING---!!!"
                echo "Incorrect file removal has been detected from the removal log!"
                echo "Check removal log for more info of when this occured."
                echo "Please recover file(s) from snapshots/backups!"
                echo ""
                echo "This script will not run until the incorrect file has been deleted from the removal log."
                echo "Please edit the removal log or delete it to get this script working again."
                echo "-- Note: Use the [-c] flag during script runtime to delete the removal log. --"
                echo ""
                echo ">>> Detailed list of removed items appeneded to this file: $scriptLogLocation <<<"
                echo "---Feel free to delete this log file for whatever reason (ex. log got too big, free up space).---"
                echo "---This log file will be recreated on the next launch of this script.---"
            else 
                echo ""
                echo "Note: If all \"rm -vf\" instances are followed by nothing, no leftover metadata was found and erased."
                echo ""
                echo ">>> Detailed list of removed items (if any) appeneded to this file: $scriptLogLocation <<<"
                echo ""
                echo "---Feel free to delete this log file for whatever reason (ex. log got too big, free up space).---"
                echo "---This log file will be recreated on the next launch of this script (only when a removal occurs).---"
                echo "...Ending Script..."
            fi
        else
            echo "...Ending Script..."
        fi
    fi
fi
