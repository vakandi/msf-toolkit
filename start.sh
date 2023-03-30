#!/bin/sh
userr="vakandi"
folder_rasp="/media/$userr/CIRCUITPY"
sh script/createpayload-automaticngrok.sh
echo "Do you want to upload the payload and prepare the Raspberry Pico now?"
echo "Type 'y' for yes, Enter for exiting"
read choice
if [ $choice = "y" ]
then
	sh pico-ducky/setup_auto.sh
	cp utiles/payload.dd $folder_rasp/
else
	echo "Exiting..."
	exit
fi
