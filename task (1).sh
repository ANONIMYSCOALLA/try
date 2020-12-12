#!/bin/bash

if [[ $# -ne 2 ]]
then
	echo "Incorrect number of arguments. Had to be 2: A file path and a command (check/recover)."
	exit 1
fi

filePath=$1
fileName=$(basename -- $1)
userCommand=$2

if [[ ! -f $filePath ]]
then
    echo "No such file exists. Please check and try again."
    exit 1
fi

case "$userCommand" in
    "check")
        if [[ ! -d ./.as_git ]]
        then
            mkdir ./.as_git
            cp "$filePath" ./.as_git/"$fileName"
        else
            if [[ -f ./.as_git/$fileName ]]
            then
                str=$(diff -y "$filePath" ./.as_git/"$fileName")
                if [[ -z $str ]]
                then
                    echo "Files are identical" >> ./.as_git/"$fileName.log"
                else
                    echo "$str" >> ./.as_git/"$fileName.log"
                    cp "$filePath" ./.as_git/"$fileName"
                fi
            else
                cp "$filePath" ./.as_git/"$fileName"
            fi
        fi
        ;;
    "recover")
        rm "$filePath"
        ln ./.as_git/"$fileName" "$filePath"
        ;;
    *)
        echo "No such command exists in this program"
        exit 1
        ;;
esac