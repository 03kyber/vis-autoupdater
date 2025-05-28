#!/bin/bash
#System check

option=0
loop=1
fullName=$(cat /etc/os-release | grep PRETTY_NAME | cut -d "\"" -f 2)
logFolder=$HOME/visLogs
logFile=$HOME/visLogs/default.txt
latestAssetName=".AppImage"

echo "------------------"
echo "Running: $fullName"
echo "------------------"
echo " "
echo " "

function choose {

	echo "Select release version: "
	echo " - Latest Stable Release (1)"
	echo " - Pre-release testing version (2)"
	echo " "
	read option
}

if [ -d $logFolder ]; then

	if [ -f $logFile ]; then
		echo "Default Option Found."
		option=$(cat $logFile | cut -d ":" -f 2)
	else
		choose
		echo "default: $option" > $logFile
	fi
else

	mkdir $logFolder
	choose
	echo "default: $option" > $logFile

fi



if [ $option -eq 1 ]; then

	echo "Downloading Latest Version..."
	loop=0
	apiUrl="https://api.github.com/repos/VI-Software/vis-launcher/releases/latest"
	releaseJson=$(curl -sL "$apiUrl")
	#echo "$releaseJson"
	downloadUrl=$(echo "$releaseJson" | jq -r '.assets[] | select(.name | endswith(".AppImage")) | .browser_download_url')
	echo "$downloadUrl"
	wget -O updater.AppImage $downloadUrl
	updater.AppImage

elif [ $option -eq 2 ]; then
	apiUrl="https://api.github.com/repos/VI-Software/vis-launcher/releases"
	apiJson=$(curl -sL "$apiUrl")
	nightlyUrl=$(echo "$apiJson" | jq -r '.[] | select(.name (".nightly")) | .html_url')
	echo "$nightlyUrl"
else
	echo "Invalid option"
fi
