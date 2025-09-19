# MCserver-script
This is a script which simplifies installing a Minecraft server on Linux. Below will be information on requirements to run it and how to use it after you run the script.
# Prerequisites
This script is designed to work on Ubuntu, to run it on other Distros you will need to run a few things manually however most of the script should still work. If you use Debian you will need to manually install Java. You should also be logged in as a user with sudo access, however not the root user itself.

# What does the script do?
You can read through the script in a text editor, but a high level view is that it downloads the needed packages, then creates a server directory for you, and creates some files automatically including a launch script and the eula file so you don't have to do that by hand. After this it asks if you are using Fabric or not, this is because the Fabric server jar is installed using an installer, if you say yes it will ask you for a link to the Fabric Installer jar, when you enter it you are prompted for the MC version you want and the script handles the rest! If you say no and are not using Fabric it will ask for the download link to your server jar and download it with a file name to work with our launch script.

# Installation
You can install the script in 4 simple commands! Just copy and paste. If the first command says it cannot find the command you need to install git with your package manager (sudo apt install git or sudo yum install git)

`git clone https://github.com/LazyKB/mc-installer/`

`cd mc-installer`

`chmod +x mc_server.sh`

`./mc_server.sh`

# How to use the server after running the script (tmux)

### Why we use tmux?
At the start of the script we installed tmux which allows us to keep the server running in its own instance. This is important when using ssh to control your server since without the server running would be tied to your ssh session and thus close when the ssh session is ended.

### How to operate tmux
Tmux works in a very simple way. If you are not using tmux for anything else you simply enter `tmux` to start a new window, doing so will also automatically attach you to it, you shold see a bar at the bottom of the terminal indicating you are in a tmux window. From here you will want to enter your server directory by using `cd server`. If you are ever lost in what directory you are in you can enter `cd $HOME/server` to get back to your server directory. Once you are there do ./start.sh and the server will launch and you will be put into the Minecraft console. To escape the tmux window you can do the key combination `ctrl b+d` if it doesn't work type the d after the b.

# After Installation

### Server running slow?
It is HIGHLY reccommended for most servers to change the `sync-chunk-writes` setting to false in server.properties. To do so enter `cd server` and then `nano server.properties` if you can't find the `server` directory, enter `cd` and try again, this returns you to your home directory where `server` is located.

This setting makes it so that the game does not batch huge amounts of disk writes together, which reduces lag spikes when loading chunks, however introduces a small chance for corruption in the event of a sudden shutdown during a write. Backups are always reccommended!

### Adding mods or plugins with wget
To add mods or plugins to the server you will want to add the .jar files to the `mods` or `plugins` directory depending on your server type. Some sites like Modrinth allow copying the link from their download buttons, and using wget to download it directly from the CLI, IE `wget <pasted download link.jar>`
This doesn't always work though, and can be slow if you want to add a lot of mods.

### Adding mods or plugins using Filezilla
If you want a GUI for adding files from your own computer to the server you can make use of [Filezilla](https://filezilla-project.org/)
