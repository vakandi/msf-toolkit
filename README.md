[![Top Languages](https://img.shields.io/github/languages/top/vakandi/msf?color=green&label=shell&logo=github)](https://github.com/vakandi/vakandi)
# MSF Automatic Tools (Termux/Linux)

This script is used to generate a reverse shell payload that can be used to gain remote access to a device. The payload is stored in a DD file that can be transferred to the target device using RubberDucky or RaspberryPico.

## Installation

1. Clone the repository to your local machine using `git clone https://github.com/your-username/repo-name.git`
2. Change into the repository directory with `cd repo-name`
3. Run the script with `./start.sh`

# Ngrok Reverse Shell Script

This is a shell script that sets up a reverse shell using Ngrok. 

## Usage

1. Run `ngrok tcp 5656` to start Ngrok on port 5656 in the background.
2. Run the script.
3. When prompted, type `y` if you want to kill any existing Ngrok servers or `n` if you don't.
4. Wait for the script to start Ngrok, if it's not already running.
5. The script will create a reverse shell and save it to `~/msf/tmp/`. 
6. If a previous Ngrok URL was found, it will be saved to `~/msf/tmp/old_link.txt` and the new URL will be saved to `~/msf/tmp/new_link.txt`.


## Features


### Automatic Ducky Script and Raspberry Pico preparation with the dd file loaded with the url of the reverse shell payload (encrypted or not)


Compatible with **Linux Only**



### DuckyScript Ready-to-go 
1. Windows Fully working, desactivate the firewall and create a exception folder in %temp% to store, decompress and run the payload.
2. Linux needs to update the .dd file in `~/msf/dd/` for linux with the right macro (do a pull request)
3. MacOS needs to update the .dd file in `~/msf/dd/` for macos with the right macro  (do a pull request)
4. Android needs to update the .dd file in `~/msf/dd/` for android with the right macro (do a pull request)


## How it works

1. The script reads the Ngrok URL and IP address from a temporary file located at `$HOME/msf/tmp/.temp_ip_ngrok-tcp.txt`.
2. It sets the port to `5656` and generates a random 5-character string for the archive name.
3. It saves the archive to `$HOME/msf/tmp/reverse-$RANDOMLETTER.zip`.
4. It prompts the user to kill any existing Ngrok servers, and starts a new one if needed.
5. It waits for Ngrok to start and stabilize.
6. It creates a reverse shell using Metasploit
7. It encrypts the reverse shell and upload it to `https://transfer.sh`
9. If a previous Ngrok URL was found, it will be saved to `~/msf/tmp/old_link.txt` and the new URL will be saved to `~/msf/tmp/new_link.txt`.
10. The script displays the Ngrok URL for the reverse shell.

## Requirements

- Ngrok
- Metasploit
- jq
- whiptail



### (The Ducky script is only ready for Windows 10, not working on Linux Macos IOS or Android)
