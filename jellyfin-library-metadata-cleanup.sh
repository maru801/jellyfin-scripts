#!/bin/bash

## Note: For all variables, use "quotes" when adding things with spaces or special characters
serverName="YourServerName"

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

pathTokenToIgnore=""         ## Token to ignore within found file paths (all files that contain this token in path will not be checked/removed)

library1="test1"             ## Path to library (enclose in "quotes" to avoid issues with spaces and special characters)
library1Enabled=false        ## enable with "true" (all lower-case)
library1Name="Test1 Library" ## Name of your library

library2="test2"
library2Enabled=false
library2Name="Test2 Library"

library3="test3"
library3Enabled=false
library3Name="Test3 Library"

library4="test folder4"
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
# Note: Make sure to declare BIF files only on the "bifType" variables
fileType1=.jpg
fileType2=.nfo

bifType1=.bif
bifType2=-manifest.json
######################################################################

#####################################################
############## BIF Resolutions to Keep ##############
## Note: All other BIF resolutions will be deleted ##
bifResolutionToKeep1=320
bifResolutionToKeep2=0
bifResolutionToKeep3=0
#####################################################

################################
## Files to Ignore/Not Delete ##
ignoreFile1="folder.jpg"
ignoreFile2="banner.jpg"
ignoreFile3="backdrop.jpg"
ignoreFile4="logo.jpg"
ignoreFile5="cover.jpg"
ignoreFile6="tvshow.nfo"
ignoreFile7="season.nfo"
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
    if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2|$bifType1|$bifType2" -; then
        echo ""
        echo "jellyfin-library-metadata-cleanup.sh"
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
                grep -vFf <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" -o -iname "*$videoType29" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -name "*$fileType1" -o -name "*$fileType2" \) -print | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6|$ignoreFile7" -) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
                grep -vFf <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" -o -iname "*$videoType29" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -name "*$bifType1" -o -name "*$bifType2" \) -print) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
                grep -vFf <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -iname "*-$bifResolutionToKeep1.bif" -o -iname "*-$bifResolutionToKeep2.bif" -o -iname "*-$bifResolutionToKeep3.bif" \) -print) <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -iname "*.bif" -print) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
            fi
        done

        echo "" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation

        if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
            cat $scriptTempLogLocation >> $scriptLogLocation
        fi

        rm $scriptTempLogLocation

        if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2|$bifType1|$bifType2" -; then
            echo ""
            echo "jellyfin-library-metadata-cleanup.sh"
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
    if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2|$bifType1|$bifType2" -; then
        echo ""
        echo "jellyfin-library-metadata-cleanup.sh"
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

        echo "---Script made during Jellyfin v10.8.13 & Jellyscrub v1.1.1.0---"
        echo "---Any future changes to automatic metadata naming by either service may break this script.---"
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

        echo "All files with the following token in their paths will be ignored: [$pathTokenToIgnore]"

        echo ""

        echo "This bash script will delete leftover nfo, jpg thumbnails, and trickplay related files from the linked libraries in the script."
        echo ""
        echo "The user running this script needs to have the correct permissions set to access all three libraries and delete files."
        echo ""
        echo "Note: BIF files with the following resolutions will be preserved: [$bifResolutionToKeep1, $bifResolutionToKeep2, $bifResolutionToKeep3]"
        echo "Note: All other BIF file resolutions will be deleted from your libraries."
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
                    echo "-----Cleaning \"${libraryNameArray[i]//,/}\" (rm uneeded $fileType1 + $fileType2 + $bifType1 + $bifType2 files)-----"
                    grep -vFf <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" -o -iname "*$videoType29" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -name "*$fileType1" -o -name "*$fileType2" \) -print | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6|$ignoreFile7" -) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
                    grep -vFf <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" -o -iname "*$videoType29" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -name "*$bifType1" -o -name "*$bifType2" \) -print) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
                    grep -vFf <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -type f \( -iname "*-$bifResolutionToKeep1.bif" -o -iname "*-$bifResolutionToKeep2.bif" -o -iname "*-$bifResolutionToKeep3.bif" \) -print) <(find "${libraryPathArray[i]//,/}" -iname "$pathTokenToIgnore" -prune -o -iname "*.bif" -print) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
                fi
            done

            echo "" >> $scriptTempLogLocation
            echo "" >> $scriptTempLogLocation
            echo ""

            if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
                cat $scriptTempLogLocation >> $scriptLogLocation
            fi

            rm $scriptTempLogLocation

            if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2|$bifType1|$bifType2" -; then
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