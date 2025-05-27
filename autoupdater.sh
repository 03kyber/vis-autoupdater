#!/bin/bash

#System check
loop=1
fullName=$(cat /etc/os-release | grep PRETTY_NAME | cut -d "\"" -f 2)
latestAssetName=".*AppImage"
echo "------------------"
echo "Running: $fullName"
echo "------------------"
echo " "
echo " "
while [ $loop -eq 1 ]; do

	echo "Select release version: "
	echo " - Latest Stable Release (1)"
	echo " - Pre-release testing version (2)"
	echo " "

	read option

	if [ $option -eq 1 ]; then

		echo "Downloading Latest Version..."
		loop=0
		apiUrl="https://api.github.com/repos/VI-Software/vis-launcher/releases/latest"
		releaseJson=$(curl -sL "$apiUrl")
		#echo "$releaseJson"
		downloadUrl=$(echo "$releaseJson" | jq -r '.assets[] | select(.name | endswith(".AppImage")) | .browser_download_url')
		echo "$downloadUrl"
		wget -O updater.AppImage $downloadUrl


	elif [ $option -eq 2 ]; then

		echo "Downloading Pre-release version..."
		loop=0

	else
		echo " "
		echo "Invalid Release Option."
		echo " "
	fi

done
