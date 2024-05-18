#!/bin/bash

#scriptLogLocationPathOnly=test/
scriptLogLocation=test/chapter-error-log.txt
scriptTempLogLocation=test/temp-chapter-error-log.txt

pathToJellyLogs="path/to/file" ## Make sure to not end this path with a foward slash "/"
todaysLog=$(date +"log_%Y%m%d.log")

fullPathToTodaysLog=$pathToJellyLogs/$todaysLog

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

    echo "Error: Jellyfin chapter extraction stopped for:" >> $scriptTempLogLocation
    echo "" >> $scriptTempLogLocation
    awk '{print $0}' <(awk -F "|" '{print $2}' <(grep -i "stopping chapter extraction for" $fullPathToTodaysLog | sed 's/topping chapter extraction for \"/topping chapter extraction for \|\"/g')) | sort | uniq >> $scriptTempLogLocation

    echo "" >> $scriptTempLogLocation
    echo "" >> $scriptTempLogLocation

    if [[ $(wc -l < $scriptTempLogLocation) -gt 7 ]]; then
        cat $scriptTempLogLocation >> $scriptLogLocation
        cat $scriptTempLogLocation
    fi

    rm $scriptTempLogLocation
else
    echo "This script will check Jellyfin's current daily logfile for any chapter errors and do the following:"
    echo "   1. Print out any found chapter errors"
    echo "   2. Store any found chapter errors at $scriptLogLocation"
    echo ""
    echo "Note: Jellyfin make a new logfile daily. This script only checks today's logfile."
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

        echo "Error: Jellyfin chapter extraction stopped for:" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation
        awk -F "|" '{print $2}' <(grep -i "stopping chapter extraction for" $fullPathToTodaysLog | sed 's/topping chapter extraction for \"/topping chapter extraction for \|\"/g') | sort | uniq >> $scriptTempLogLocation

        echo "" >> $scriptTempLogLocation
        echo "" >> $scriptTempLogLocation

        if [[ $(wc -l < $scriptTempLogLocation) -gt 7 ]]; then
            cat $scriptTempLogLocation >> $scriptLogLocation
            echo ""
            cat $scriptTempLogLocation
        fi

        rm $scriptTempLogLocation
        echo "...Exiting..."
    else
        echo "...Exiting..."
    fi
fi