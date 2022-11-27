# Wordpress Locally

Bash script for running wordpress site locally.

With a GUI that looks like this!
![image](https://user-images.githubusercontent.com/100642899/204152751-2c350f10-a509-451c-a982-ea35a5e09539.png)


## What it does

This script will allow you to run wordpress locally and easily access it. Once the bash script has started
it will give you a GUI made with Yad, you may start/restart containers I.E compose down and then compose up. 
You can check container logs, which will show in the command line, and all the refresh requests & etc. will appear once you compose down the containers. 

Basically, once the script is initiated, it will give you that GUI, and once you press on a button, it will trigger a bash script which will trigger an ansible script which will start the containers. the ansible scripts are hidden so there's less to look at in the command line. but using
```
ls -a
```
You should be able to see them.

## Changing ports

Within the script there is this portion

```
$(ss -tulpn | grep 5080)
```
which checks to see if port 5080 is allocated.
if you'd like to run your sites locally from a different port, change 5080 to that port, this will also need to be changed in the hidden ansible scripts, 
the docker-compose.yml file with the wordpress directory, and within the bash script itself.

## Getting started

First clone the repo

```
git clone https://github.com/<Your User>/Wordpress-locally.git
```

cd into the directory

```
cd /path/to/Wordpress-locally
```
Afterwards,
if needed,
```
chmod +x install.sh
```
```
chmod +x gui.sh
```
This will make the scripts executable.

To install all the needed packages simply run the .install.sh command like so,
```
./install.sh
```
The script uses SUDO so you will likely have to enter your password before proceeding. This will only work for Linux.

after the packages are installed. We can try the script.
```
./gui.sh
```
From within the repo's directory.
If Yad is not supported on your device you can also use 
```
./nogui.sh
```
which is the version I created that is all text based with no graphical user interface.
