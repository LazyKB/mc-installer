# MCserver-script
This is a script which simplifies installing a Minecraft server on Linux. Below will be information on requirements to run it and how to use it after you run the script.
# Prerequisites
This script is designed to work on Ubuntu, to run it on other Distros you will need to run a few things manually however most of the script should still work. If you use Debian you will need to manually install Java. You should also be logged in as a user with sudo access, however not the root user itself.

# What does the script do?
You can read through the script in a text editor, but a high level view is that it downloads the needed packages, then creates a server directory for you. After that it starts optional parts, including creating a file that agrees to the MC eula, downloading a server jar directly from a link, as well as working with the fabric installer. It also creates a start script for you.

# Installation
You can install the script in 5 simple commands! Just copy and paste

Install the Git commands packages

`sudo apt update && sudo apt install git`

Clone this repository

`git clone https://github.com/LazyKB/MCserver-script/`

CD in to the directory

`cd MCserver-script`

Make the script executable

`chmod +x mc_server.sh`

Run the Script!

`./mc_server.sh`

# How to use the server after running the script

Once the server is installed it is ready to use! There are multiple ways to do this but the simplest way to do it is with a screen instance. The script install screen for you automatically, so all you have to do is cd into your server directory and start a screen instance. The screen name does not have to match the directory name.

`cd <directory>`
`screen -S server`

This will open a new window, and in this window you can run your start script

`./start.sh`

Your server should start! After you're done with looking at the Minecraft logs you can press `ctrl A+D`

Whenever you need to look at the Minecraft logs again you need to run `screen -r server` to reconnect. Running -S will make a new screen with the same name and be annoying so make sure you use the right command!
