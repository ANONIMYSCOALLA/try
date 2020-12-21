#!/bin/bash

file_path="$1"
only_file_path=$(dirname "$file_path"); file_name=$(basename "$file_path"); path_script=$(pwd)
command="$2"
if [[ "$command" == "check" ]]; then
	if [[ ! -d "$path_script/.as_git" ]]; then
		mkdir "$path_script/.as_git"
	fi
	if [[ -f "$path_script/.as_git/$file_name" ]]; then
		size_one=$(du "$file_path" | awk -F " " '{print $1}')
		size_two=$(du "$file_name" | awk -F " " '{print $1}')
		if [[ "size_one" == "$size_two" ]]; then
			echo "$(date) : files are the same size" >> "/$path_script/.as_git/$file_name.log"
		fi
	else
		cp -a "$file_path" "/$path_script/.as_git/$file_name"
	fi
fi
if [[ "$command" == "recover" ]]; then
	rm "$file_path"
	ln "/$script_path/.as_git/$file_name/$only_file_path/$file_name"
fi
