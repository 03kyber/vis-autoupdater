#!/bin/bash

#System check
option=0
fullName=$(cat /etc/os-release | grep PRETTY_NAME | cut -d "\"" -f 2)
echo "------------------"
echo "Running: $fullName"
echo "------------------"
echo " "
echo " "
while [ $option -ne 1 -o $option -ne 2 ]; do
	echo "Select release version: "
	echo " - Latest Stable Release (1)"
	echo " - Pre-release testing version (2)"

	read option

	if [ $option -ne 1 -o $option -ne 2 ]; then
		echo " "
		echo "Invalid Option"
		echo " "
		sleep 1

	else
		if [ $option -eq 1 ]; then
			echo "Downloading Latest Stable Version."
	fi
	echo $option
done
