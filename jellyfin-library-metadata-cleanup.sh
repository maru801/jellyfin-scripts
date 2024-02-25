#!/bin/bash

serverName=YourServerName

#######################################################################################
######################################## Paths ########################################
## Use full paths relative to this script, or absolute paths relative to the system ##

## Removal Log Location Info ##
## Filename doesn't matter for both permanent & temp removal logs ##
## Make sure other files in given path don't conflict with the filename you provide. ##
scriptLogLocationPathOnly=test/
scriptLogLocation=test/removed-log.txt
scriptTempLogLocation=test/temp-removed-log.txt

## Library Paths ##
## IMPORTANT: Make sure library paths end with "/" ##
library1=test1/
library2=test2/
library3=test3/

## Library Names ##
library1Name="Test1 Library"
library2Name="Test2 Library"
library3Name="Test3 Library"
#######################################################################################

######################################################################
###################### File Types to Clean Out #######################
# Note: Make sure to declare BIF files only on the "bifType" variables
fileType1=".jpg"
fileType2=".nfo"

bifType1=".bif"
bifType2="-manifest.json"
######################################################################

#####################################################
############## BIF Resolutions to Keep ##############
## Note: All other BIF resolutions will be deleted ##
bifResolutionToKeep1="320"
bifResolutionToKeep2="0"
bifResolutionToKeep3="0"
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
videoType1=".mkv"
videoType2=".mk3d"
videoType3=".mp4"
videoType4=".m4v"
videoType5=".mov"
videoType6=".qt"
videoType7=".asf"
videoType8=".wmv"
videoType9=".avi"
videoType10=".mxf"
videoType11=".m2p"
videoType12=".ps"
videoType13=".ts"
videoType14=".tsv"
videoType15=".m2ts"
videoType16=".mts"
videoType17=".vob"
videoType18=".evo"
videoType19=".3gp"
videoType20=".3g2"
videoType21=".f4v"
videoType22=".flv"
videoType23=".ogv"
videoType24=".ogx"
videoType25=".webm" 
videoType26=".rmvb"
videoType27=".divx"
videoType28=".xvid"
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

        grep -vFf <(find $library1* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library1* -type f \( -name "*$fileType1" -o -name "*$fileType2" \) | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6|$ignoreFile7" -) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library1* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library1* -type f \( -name "*$bifType1" -o -name "*$bifType2" \)) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library1* -type f \( -iname "*-$bifResolutionToKeep1.bif" -o -iname "*-$bifResolutionToKeep2.bif" -o -iname "*-$bifResolutionToKeep3.bif" \)) <(find $library1* -iname "*.bif") | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation

        grep -vFf <(find $library2* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library2* -type f \( -name "*$fileType1" -o -name "*$fileType2" \) | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6|$ignoreFile7" -) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library2* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library2* -type f \( -name "*$bifType1" -o -name "*$bifType2" \)) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library2* -type f \( -iname "*-$bifResolutionToKeep1.bif" -o -iname "*-$bifResolutionToKeep2.bif" -o -iname "*-$bifResolutionToKeep3.bif" \)) <(find $library2* -iname "*.bif") | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation

        grep -vFf <(find $library3* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library3* -type f \( -name "*$fileType1" -o -name "*$fileType2" \) | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6|$ignoreFile7" -) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library3* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library3* -type f \( -name "*$bifType1" -o -name "*$bifType2" \)) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library3* -type f \( -iname "*-$bifResolutionToKeep1.bif" -o -iname "*-$bifResolutionToKeep2.bif" -o -iname "*-$bifResolutionToKeep3.bif" \)) <(find $library3* -iname "*.bif") | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation

        echo "" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation

        if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
            cat $scriptTempLogLocation >> $scriptLogLocation
        fi

        rm $scriptTempLogLocation

        if grep -s "removed " $scriptLogLocation | grep -svEi "$fileType1|$fileType2|$bifType1|$bifType2" -; then
            echo ""
            echo "jellyfin-library-metadata-cleanup.sh"
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
        echo "$scriptLogLocationPathOnly {Removal Log Storage Location}"
        echo "$library1 {$library1Name}"
        echo "$library2 {$library2Name}"
        echo "$library3 {$library3Name}"

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

            echo ""
            
            echo "-----Cleaning $library1Name (rm uneeded $fileType1 + $fileType2 + $bifType1 + $bifType2 files)-----"
            grep -vFf <(find $library1* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library1* -type f \( -name "*$fileType1" -o -name "*$fileType2" \) | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6|$ignoreFile7" -) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library1* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library1* -type f \( -name "*$bifType1" -o -name "*$bifType2" \)) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library1* -type f \( -iname "*-$bifResolutionToKeep1.bif" -o -iname "*-$bifResolutionToKeep2.bif" -o -iname "*-$bifResolutionToKeep3.bif" \)) <(find $library1* -iname "*.bif") | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation

            echo ""
            
            echo "-----Cleaning $library2Name (rm uneeded $fileType1 + $fileType2 + $bifType1 + $bifType2 files)-----"
            grep -vFf <(find $library2* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library2* -type f \( -name "*$fileType1" -o -name "*$fileType2" \) | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6|$ignoreFile7" -) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library2* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library2* -type f \( -name "*$bifType1" -o -name "*$bifType2" \)) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library2* -type f \( -iname "*-$bifResolutionToKeep1.bif" -o -iname "*-$bifResolutionToKeep2.bif" -o -iname "*-$bifResolutionToKeep3.bif" \)) <(find $library2* -iname "*.bif") | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation

            echo ""
            
            echo "-----Cleaning $library3Name (rm uneeded $fileType1 + $fileType2 + $bifType1 + $bifType2 files)-----"
            grep -vFf <(find $library3* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library3* -type f \( -name "*$fileType1" -o -name "*$fileType2" \) | grep -vEi "$ignoreFile1|$ignoreFile2|$ignoreFile3|$ignoreFile4|$ignoreFile5|$ignoreFile6|$ignoreFile7" -) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library3* -type f \( -iname "*$videoType1" -o -iname "*$videoType2" -o -iname "*$videoType3" -o -iname "*$videoType4" -o -iname "*$videoType5" -o -iname "*$videoType6" -o -iname "*$videoType7" -o -iname "*$videoType8" -o -iname "*$videoType9" -o -iname "*$videoType10" -o -iname "*$videoType11" -o -iname "*$videoType12" -o -iname "*$videoType13" -o -iname "*$videoType14" -o -iname "*$videoType15" -o -iname "*$videoType16" -o -iname "*$videoType17" -o -iname "*$videoType18" -o -iname "*$videoType19" -o -iname "*$videoType20" -o -iname "*$videoType21" -o -iname "*$videoType22" -o -iname "*$videoType23" -o -iname "*$videoType24" -o -iname "*$videoType25" -o -iname "*$videoType26" -o -iname "*$videoType27" -o -iname "*$videoType28" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library3* -type f \( -name "*$bifType1" -o -name "*$bifType2" \)) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library3* -type f \( -iname "*-$bifResolutionToKeep1.bif" -o -iname "*-$bifResolutionToKeep2.bif" -o -iname "*-$bifResolutionToKeep3.bif" \)) <(find $library3* -iname "*.bif") | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation

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