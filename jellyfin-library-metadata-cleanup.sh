#!/bin/bash

serverName=YourServerName

scriptLogLocationPathOnly=test/
scriptLogLocation=test/removed-log.txt
scriptTempLogLocation=test/temp-removed-log.txt

# !!!IMPORTANT: Make sure paths end with "/"
library1=test1/
library2=test2/
library3=test3/

library1Name="Test1 Library"
library2Name="Test2 Library"
library3Name="Test3 Library"

if [ "$1" == "-c" ]; then
    rm -f $scriptLogLocation
elif [ "$1" == "-d" ]; then
    cat $scriptLogLocation
elif [ "$1" == "-h" ]; then
    if grep -s "removed " $scriptLogLocation | grep -svEi '.jpg|.bif|-manifest.json' -; then
        echo ""
        echo "jellyfin-library-metadata-cleanup.sh"
        echo "!!!---WARNING---!!!"
        echo "Incorrect file removal has been detected from the removal log!"
        echo "Check removal log for more info of when this occured."
        echo "Please recover file(s) from snapshots/backups!"
        echo ""
        echo "This script will not run until the incorrect file has been deleted from the removal log."
        echo "Please edit the removal log or delete it to get this script working again."
        echo ""
        echo "---Detailed list of removed items is found in this file: $scriptLogLocation---"
        echo "...Ending Script..."
    else
        echo "--------------------------------" >> $scriptTempLogLocation
        date >> $scriptTempLogLocation
        echo "--------------------------------" >> $scriptTempLogLocation

        grep -vf <(find $library1* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | sed 's/\.[^.]*$//gm') <(find $library1* -type f \( -name "*.jpg" -o -name "*.bif" -o -name "*-manifest.json" \) | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg' -) | sed 's/-I1L2B-/\\[/g' | sed 's/-I1R2B-/\\]/g' | sed 's/ /\\ /g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vf <(find $library2* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | sed 's/\.[^.]*$//gm') <(find $library2* -type f \( -name "*.jpg" -o -name "*.bif" -o -name "*-manifest.json" \) | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg' -) | sed 's/-I1L2B-/\\[/g' | sed 's/-I1R2B-/\\]/g' | sed 's/ /\\ /g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vf <(find $library3* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | sed 's/\.[^.]*$//gm') <(find $library3* -type f \( -name "*.jpg" -o -name "*.bif" -o -name "*-manifest.json" \) | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg' -) | sed 's/-I1L2B-/\\[/g' | sed 's/-I1R2B-/\\]/g' | sed 's/ /\\ /g' | xargs rm -vf >> $scriptTempLogLocation

        echo "" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation

        if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
            cat $scriptTempLogLocation >> $scriptLogLocation
        fi

        rm $scriptTempLogLocation

        if grep -s "removed " $scriptLogLocation | grep -svEi '.jpg|.bif|-manifest.json' -; then
            echo ""
            echo "jellyfin-library-metadata-cleanup.sh"
            echo "!!!---WARNING---!!!"
            echo "Incorrect file removal has been detected from the removal log!"
            echo "Check removal log for more info of when this occured."
            echo "Please recover file(s) from snapshots/backups!"
            echo ""
            echo "This script will not run until the incorrect file has been deleted from the removal log."
            echo "Please edit the removal log or delete it to get this script working again."
            echo ""
            echo "---Detailed list of removed items is found in this file: $scriptLogLocation---"
            echo "---Feel free to delete this log file for whatever reason (ex. log got too big, free up space).---"
            echo "---This log file will be recreated on the next launch of this script.---"
            echo "...Ending Script..."
        fi
    fi
else
    if grep -s "removed " $scriptLogLocation | grep -svEi '.jpg|.bif|-manifest.json' -; then
        echo "!!!---WARNING---!!!"
        echo "Incorrect file removal has been detected from the removal log!"
        echo "Check removal log for more info of when this occured."
        echo "Please recover file(s) from snapshots/backups!"
        echo ""
        echo "This script will not run until the incorrect file has been deleted from the removal log."
        echo "Please edit the removal log or delete it to get this script working again."
        echo ""
        echo "---Detailed list of removed items is found in this file: $scriptLogLocation---"
        echo "...Ending Script..."
    else
        echo "Start-up Flags (Use at Runtime):"
        echo "[-h]: Hide non-error verbose output."
        echo "[-c]: Delete current \"removed-log.txt\" file, then exit script."
        echo "[-C]: Delete current \"removed-log.txt\" file AND run this script afterwards."
        echo "[-d]: Print out the romoval log."
        echo "--Note: This script currently only supports one flag at a time.--"
        echo ""
        echo "--Script designed for \"$serverName\"--"

        echo "This script expects the following paths to exist on the system:"
        echo "$scriptLogLocationPathOnly {Location of this Script}"
        echo "$library1 {$library1Name}"
        echo "$library2 {$library2Name}"
        echo "$library3 {$library3Name}"

        echo ""

        echo "This bash script will delete leftover jpg thumbnails and trickplay related files from the linked libraries in the script."
        echo ""
        echo "The user running this script needs to have the correct permissions set to access all three libraries and delete files."
        echo ""

        echo "---Continue?---"
        echo "[To Cancel: Enter Anything]"
        echo "[To Continue: Enter Nothing]"
        read userExitChoice

        if [[ $userExitChoice == "" || $userExitChoice == "" ]]; then
            if [ "$1" == "-C" ]; then
                rm -f $scriptLogLocation
            fi

            echo "--------------------------------" >> $scriptTempLogLocation
            date >> $scriptTempLogLocation
            echo "--------------------------------" >> $scriptTempLogLocation

            echo "-----Cleaning $library1Name (rm uneeded .jpg + .bif + -manifest.json files)-----"
            grep -vf <(find $library1* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | sed 's/\.[^.]*$//gm') <(find $library1* -type f \( -name "*.jpg" -o -name "*.bif" -o -name "*-manifest.json" \) | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg' -) | sed 's/-I1L2B-/\\[/g' | sed 's/-I1R2B-/\\]/g' | sed 's/ /\\ /g' | xargs -t rm -vf >> $scriptTempLogLocation
            echo ""
            echo "-----Cleaning $library2Name (rm uneeded .jpg + .bif + -manifest.json files)-----"
            grep -vf <(find $library2* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | sed 's/\.[^.]*$//gm') <(find $library2* -type f \( -name "*.jpg" -o -name "*.bif" -o -name "*-manifest.json" \) | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg' -) | sed 's/-I1L2B-/\\[/g' | sed 's/-I1R2B-/\\]/g' | sed 's/ /\\ /g' | xargs -t rm -vf >> $scriptTempLogLocation
            echo ""
            echo "-----Cleaning $library3Name (rm uneeded .jpg + .bif + -manifest.json files)-----"
            grep -vf <(find $library3* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | sed 's/\.[^.]*$//gm') <(find $library3* -type f \( -name "*.jpg" -o -name "*.bif" -o -name "*-manifest.json" \) | sed 's/\[/-I1L2B-/g' | sed 's/\]/-I1R2B-/g' | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg' -) | sed 's/-I1L2B-/\\[/g' | sed 's/-I1R2B-/\\]/g' | sed 's/ /\\ /g' | xargs -t rm -vf >> $scriptTempLogLocation

            echo "" >> $scriptTempLogLocation
            echo "" >> $scriptTempLogLocation
            echo ""

            if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
                cat $scriptTempLogLocation >> $scriptLogLocation
            fi

            rm $scriptTempLogLocation

            if grep -s "removed " $scriptLogLocation | grep -svEi '.jpg|.bif|-manifest.json' -; then
                echo ""
                echo "!!!---WARNING---!!!"
                echo "Incorrect file removal has been detected from the removal log!"
                echo "Check removal log for more info of when this occured."
                echo "Please recover file(s) from snapshots/backups!"
                echo ""
                echo "This script will not run until the incorrect file has been deleted from the removal log."
                echo "Please edit the removal log or delete it to get this script working again."
                echo ""
                echo "---Detailed list of removed items was appeneded to the end of this file: $scriptLogLocation---"
                echo "---Feel free to delete this log file for whatever reason (ex. log got too big, free up space).---"
                echo "---This log file will be recreated on the next launch of this script.---"
            else 
                echo ""
                echo "Note: If \"rm -vf\" is followed by nothing, nothing was erased from that library (no leftover metadata was found)."
                echo ""
                echo "---Detailed list of removed items (if any) was appeneded to the end of this file: $scriptLogLocation---"
                echo "---Feel free to delete this log file for whatever reason (ex. log got too big, free up space).---"
                echo "---This log file will be recreated on the next launch of this script (only when a removal occurs).---"
                echo "...Ending Script..."
            fi
        else
            echo "...Ending Script..."
        fi
    fi
fi