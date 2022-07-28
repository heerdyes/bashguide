#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n'

clear
echo -e "bashguide - version 0.1"

while true
do
	echo -e "\n\n----------- Topics -----------\n"
	echo "1. FS   - file system"
	echo "2. SH   - using the shell"
	echo "3. FLTR - filters"
	echo "4. PROG - shell programming"
	echo -n "-> select topic [1-4]: "
	read uch
	
	if [ "$uch" == "1" ]
	then
		clear
		echo "# ---- FS ---- #"
		cat usages/fs
	elif [ "$uch" == "2" ]
	then
		clear
		echo "# ---- SH ---- #"
		cat usages/sh
	elif [ "$uch" == "3" ]
	then
		clear
		echo "# ---- FLTR ---- #"
		cat usages/fltr
	elif [ "$uch" == "4" ]
	then
		clear
		echo "# ---- PROG ---- #"
		cat usages/prog
	else
		echo "no such option! exiting..."
		break
	fi
done
