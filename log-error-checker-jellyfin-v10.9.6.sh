#!/bin/bash

## scriptLogLocationPathOnly=test/
scriptLogLocation=test/chapter-error-log.txt
scriptTempLogLocation=test/temp-chapter-error-log.txt

pathToJellyLogs="path/to/file" ## Make sure to not end this path with a foward slash "/"
yesterdaysLog=$(date -d "-1 day" +"log_%Y%m%d.log")
fullPathToYesterdaysJellyLogs=$pathToJellyLogs/$yesterdaysLog

if [ "$1" == "-c" ]; then
    echo "Delete the \"chapter-error-log.txt\" file?"
    echo "---Enter [Y] to Proceed---"
    read userExitChoice

    if [ "$userExitChoice" == "Y" ]; then
        rm -f $scriptLogLocation
    else
        echo "...Exiting..."
    fi
elif [ "$1" == "-C" ]; then
    rm -f $scriptLogLocation
elif [ "$1" == "-d" ]; then
    cat $scriptLogLocation
elif [ "$1" == "-h" ]; then
    echo "--------------------------------" >> $scriptTempLogLocation
    date >> $scriptTempLogLocation
    echo "--------------------------------" >> $scriptTempLogLocation

    echo "-- Errors Found in Yesterday's Logfile --" >> $scriptTempLogLocation
    echo "" >> $scriptTempLogLocation
    #awk '{print $0}' <(awk -F "|" '{print $2}' <(grep -i "stopping chapter extraction for" $fullPathToYesterdaysJellyLogs | sed 's/stopping chapter extraction for \"/stopping chapter extraction for \|Chapter extraction stopped for\"/g')) | sort | uniq >> $scriptTempLogLocation
    awk -F "splithere123" '{print $2}' <(grep -i "cleanupcollectionandplaylistpathstask" $fullPathToYesterdaysJellyLogs | grep -i "item in" | grep -i "cannot be found at" | sed 's/Task: Item/Task: splithere123Item/g' | sed 's/Item in/Item in the/g' | sed 's/cannot be found at/collection.xml cannot be found:/g') | sort | uniq >> $scriptTempLogLocation
    awk -F "123splithere123" '{print $2}' <(grep -i "creating season \"season unknown\"" $fullPathToYesterdaysJellyLogs | sed 's/SeriesMetadataService: Creating/SeriesMetadataService: 123splithere123Creating/g') | sort | uniq >> $scriptTempLogLocation

    echo "" >> $scriptTempLogLocation
    echo "" >> $scriptTempLogLocation

    if [[ $(wc -l < $scriptTempLogLocation) -gt 7 ]]; then
        cat $scriptTempLogLocation >> $scriptLogLocation
        cat $scriptTempLogLocation
    fi

    rm $scriptTempLogLocation
else
    echo "This script will check Jellyfin's logfile from yesterday for any chapter, collection, and playlist errors and do the following:"
    echo "   1. Print out any found errors"
    echo "   2. Store any found errors at $scriptLogLocation"
    echo ""
    echo "Note: Jellyfin makes a new logfile daily. The log cleanup task found in the dashboard only deletes log files older than 3 days."
    echo ""
    echo "Flags available to use with this script:"
    echo "----------------------------------------"
    echo "[-c] : Delete the chapter error log."
    echo "[-C] : Force delete the chapter error log (don't ask for user confirmation)."
    echo "[-h] : Don't display this script's intro and run it without user confirmation (useful for running as a cron job that alerts user when error is found and printed to standard output)."
    echo ""
    echo "---Enter [Y] to Proceed---"
    read userExitChoice

    if [ "$userExitChoice" == "Y" ]; then 
        echo "--------------------------------" >> $scriptTempLogLocation
        date >> $scriptTempLogLocation
        echo "--------------------------------" >> $scriptTempLogLocation

        echo "-- Errors Found in Yesterday's Logfile --" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation
        #awk -F "|" '{print $2}' <(grep -i "stopping chapter extraction for" $fullPathToYesterdaysJellyLogs | sed 's/stopping chapter extraction for \"/stopping chapter extraction for \|Chapter extraction stopped for\"/g') | sort | uniq >> $scriptTempLogLocation
        awk -F "splithere123" '{print $2}' <(grep -i "cleanupcollectionandplaylistpathstask" $fullPathToYesterdaysJellyLogs | grep -i "item in" | grep -i "cannot be found at" | sed 's/Task: Item/Task: splithere123Item/g' | sed 's/Item in/Item in the/g' | sed 's/cannot be found at/collection.xml cannot be found:/g') | sort | uniq >> $scriptTempLogLocation
        awk -F "123splithere123" '{print $2}' <(grep -i "creating season \"season unknown\"" $fullPathToYesterdaysJellyLogs | sed 's/SeriesMetadataService: Creating/SeriesMetadataService: 123splithere123Creating/g') | sort | uniq >> $scriptTempLogLocation

        echo "" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation

        if [[ $(wc -l < $scriptTempLogLocation) -gt 7 ]]; then
            cat $scriptTempLogLocation >> $scriptLogLocation
            echo ""
            cat $scriptTempLogLocation
        else
            echo ""
            echo "-- No Errors Found --"
            echo ""
        fi

        rm $scriptTempLogLocation
        echo "...Exiting..."
    else
        echo "...Exiting..."
    fi
fi
