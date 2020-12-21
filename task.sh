#!/bin/bash

path=$1
cmd=$2
name=$(basename $path)
gitPath=//home/user/.as_git
changeLog=$gitPath/

case $cmd in
"check")
;;
"recover")
;;
*)
	echo "ERROR: unknown comand $cmd"
	exit 1
;;
esac

if [[ $# != 2 ]]
then exit 1
fi

if [[ ! -d $gitPath ]]
then
	mkdir $gitPath
fi

if [[ ! -e $path ]]
then
	echo "ERROR: file $path doesn't exist."
	exit 1
fi

if [[ $cmd == "check" ]]
then
	if [[ -e $gitPath"/"$name ]]
	then
		currFile=$gitPath"/"$name
		if [[ -e $gitPath"/."$name".logcnt" ]]
		then
			count=$(cat $gitPath"/."$name".logcnt")
		else
			count=0
		fi
		((count++))
		echo $count > $gitPath"/."$name".logcnt"
  		echo "$count)" >> $changeLog$name".log"
		grep -v -F -x -f $currFile $path >> $changeLog$name".log"
	else
		cp $path $gitPath"/"$name
	fi
else
	if [[ -e $gitPath"/"$name ]]
	then
		rm -R $path
		ln $gitPath"/"$name $path
	else
		echo "ERROR: recover for file $name doesn't exist"
	fi
fi
