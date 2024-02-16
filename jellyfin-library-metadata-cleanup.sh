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
    if grep -s "removed " $scriptLogLocation | grep -svEi '.jpg|.bif|-manifest.json|.nfo' -; then
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
        echo ">>> Detailed list of removed items appeneded to this file: $scriptLogLocation <<<"
        echo "...Ending Script..."
    else
        echo "--------------------------------" >> $scriptTempLogLocation
        date >> $scriptTempLogLocation
        echo "--------------------------------" >> $scriptTempLogLocation

        grep -vFf <(find $library1* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library1* -type f \( -name "*.jpg" -o -name "*.nfo" \) | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg|cover.jpg|tvshow.nfo|season.nfo' -) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library1* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library1* -type f \( -name "*.bif" -o -name "*-manifest.json" \)) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation

        grep -vFf <(find $library2* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library2* -type f \( -name "*.jpg" -o -name "*.nfo" \) | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg|cover.jpg|tvshow.nfo|season.nfo' -) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library2* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library2* -type f \( -name "*.bif" -o -name "*-manifest.json" \)) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation

        grep -vFf <(find $library3* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library3* -type f \( -name "*.jpg" -o -name "*.nfo" \) | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg|cover.jpg|tvshow.nfo|season.nfo' -) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation
        grep -vFf <(find $library3* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library3* -type f \( -name "*.bif" -o -name "*-manifest.json" \)) | sed 's/\(.*\)/"\1"/g' | xargs rm -vf >> $scriptTempLogLocation

        echo "" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation

        if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
            cat $scriptTempLogLocation >> $scriptLogLocation
        fi

        rm $scriptTempLogLocation

        if grep -s "removed " $scriptLogLocation | grep -svEi '.jpg|.bif|-manifest.json|.nfo' -; then
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
            echo ">>> Detailed list of removed items appeneded to this file: $scriptLogLocation <<<"
            echo ""
            echo "---Feel free to delete this log file for whatever reason (ex. log got too big, free up space).---"
            echo "---This log file will be recreated on the next launch of this script.---"
            echo "...Ending Script..."
        fi
    fi
else
    if grep -s "removed " $scriptLogLocation | grep -svEi '.jpg|.bif|-manifest.json|.nfo' -; then
        echo "!!!---WARNING---!!!"
        echo "Incorrect file removal has been detected from the removal log!"
        echo "Check removal log for more info of when this occured."
        echo "Please recover file(s) from snapshots/backups!"
        echo ""
        echo "This script will not run until the incorrect file has been deleted from the removal log."
        echo "Please edit the removal log or delete it to get this script working again."
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
            
            echo "-----Cleaning $library1Name (rm uneeded .jpg + .bif + -manifest.json files)-----"
            grep -vFf <(find $library1* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library1* -type f \( -name "*.jpg" -o -name "*.nfo" \) | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg|cover.jpg|tvshow.nfo|season.nfo' -) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library1* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library1* -type f \( -name "*.bif" -o -name "*-manifest.json" \)) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            
            echo ""
            
            echo "-----Cleaning $library2Name (rm uneeded .jpg + .bif + -manifest.json files)-----"
            grep -vFf <(find $library2* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library2* -type f \( -name "*.jpg" -o -name "*.nfo" \) | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg|cover.jpg|tvshow.nfo|season.nfo' -) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library2* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library2* -type f \( -name "*.bif" -o -name "*-manifest.json" \)) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            
            echo ""
            
            echo "-----Cleaning $library3Name (rm uneeded .jpg + .bif + -manifest.json files)-----"
            grep -vFf <(find $library3* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/./gm') <(find $library3* -type f \( -name "*.jpg" -o -name "*.nfo" \) | grep -vEi 'folder.jpg|banner.jpg|backdrop.jpg|logo.jpg|cover.jpg|tvshow.nfo|season.nfo' -) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation
            grep -vFf <(find $library3* -type f \( -iname "*.mkv" -o -iname "*.mk3d" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mov" -o -iname "*.qt" -o -iname "*.asf" -o -iname "*.wmv" -o -iname "*.avi" -o -iname "*.mxf" -o -iname "*.m2p" -o -iname "*.ps" -o -iname "*.ts" -o -iname "*.tsv" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.vob" -o -iname "*.evo" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.f4v" -o -iname "*.flv" -o -iname "*.ogv" -o -iname "*.ogx" -o -iname "*.webm" -o -iname "*.rmvb" -o -iname "*.divx" -o -iname "*.xvid" \) -exec basename {} \; | sed 's/\.[^.]*$/-/gm') <(find $library3* -type f \( -name "*.bif" -o -name "*-manifest.json" \)) | sed 's/\(.*\)/"\1"/g' | xargs -t rm -vf >> $scriptTempLogLocation

            echo "" >> $scriptTempLogLocation
            echo "" >> $scriptTempLogLocation
            echo ""

            if [[ $(wc -l < $scriptTempLogLocation) -gt 5 ]]; then
                cat $scriptTempLogLocation >> $scriptLogLocation
            fi

            rm $scriptTempLogLocation

            if grep -s "removed " $scriptLogLocation | grep -svEi '.jpg|.bif|-manifest.json|.nfo' -; then
                echo ""
                echo "!!!---WARNING---!!!"
                echo "Incorrect file removal has been detected from the removal log!"
                echo "Check removal log for more info of when this occured."
                echo "Please recover file(s) from snapshots/backups!"
                echo ""
                echo "This script will not run until the incorrect file has been deleted from the removal log."
                echo "Please edit the removal log or delete it to get this script working again."
                echo ""
                echo ">>> Detailed list of removed items appeneded to this file: $scriptLogLocation <<<"
                echo "---Feel free to delete this log file for whatever reason (ex. log got too big, free up space).---"
                echo "---This log file will be recreated on the next launch of this script.---"
            else 
                echo ""
                echo "Note: If both \"rm -vf\" instances are followed by nothing, no leftover metadata was found and erased."
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