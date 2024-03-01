#!/bin/bash

if [ "$1" == "-c" ]; then
    rm -rf test
    rm -rf test1
    rm -rf test2
    rm -rf test3
elif [ "$1" == "-r" ]; then
    rm -rf test
    rm -rf test1
    rm -rf test2
    rm -rf test3
    
    mkdir test
    cp -r testHold test1
    cp -r testHold test2
    cp -r testHold test3
else
    echo "Use flag -c to clean test dummy folders."
    echo "Use flag -r to remake test dummy folders."
    echo "Note: Will delete/overwrite the following folders: {test/, test1/, test2/, test3/}"
fi