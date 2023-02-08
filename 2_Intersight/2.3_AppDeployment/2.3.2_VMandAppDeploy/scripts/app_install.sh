#!/usr/bin/bash

# Prepares a Ubuntu Server guest operating system and deploys app from GitHub

### Update the guest operating system. 
echo '> Updating the guest operating system ...'
sudo apt-get update
sudo NEEDRESTART_MODE=a apt-get -y upgrade

### Clone App Code from Github
echo '> Cloning App Code from Github ...'
git clone https://github.com/jara-o/BRKCLD1973-SampleApp.git

cd BRKCLD1973-SampleApp

### Create Python virtual environment
echo '> Creating Python virtual environment ...'
python3 -m venv venv

echo '> Activating Python virtual environment ...'
source venv/bin/activate

### Install requirements
echo '> Installing requirements ...'
pip install -r requirements.txt

### Start App
echo '> Starting App in the background...'
screen -S flask -d -m -L flask run --host=10.61.124.7
sleep 1

echo "> Complete. Go to the VM's local IP on port 5000."