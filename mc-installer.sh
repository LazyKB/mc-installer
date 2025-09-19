#!/bin/bash

#Input a linux distro for package installation of java wget and tmux
printf "Enter your Linux distro for pakage installation.\n You can enter manual if you have already installed the required packages yourself\nSupported distros are currently: debian, ubuntu, alpine\n"
read distro
if [ "$distro" = "debian" ] || [ "$distro" = "ubuntu" ]; then
	echo "Debian/Ubuntu entered, using apt package manager"
    sudo apt update && sudo apt install nano wget tmux openjdk-21-jdk

elif [ "$distro" = "alpine" ]; then
	echo "Alpine entered, using apk package manager"
    sudo apk update && sudo apk add nano wget tmux openjdk21

elif [ "$distro" = "manual" ]; then
    echo "Assuming packages are manually installed, continuing script"

else
	printf "unsupported distro entered. Install wget tmux and java seperately, then enter manual as your distro to continue. "
    sleep 3
	exit 1
fi

printf 'Packages installed, server will be configured now'
sleep 5
clear

#setup the file structure for the minecraft server by creating a server directory under the active users home dir, then creates a basic start script as well as setting the eula file to true so that the server works

mkdir $HOME/server
cd $HOME/server

echo 'eula=true' > eula.txt

cat << EOF > start.sh
#!/bin/bash
java -jar -Xmx4G -Xms4G myserver.jar
EOF

chmod +x start.sh
sleep 3
clear

#extra logic to handle the fabric server installer for the user, asks for manual input of the desired installer version. If not using fabric asks for the download link IE from papermc. If it fails user will have to try again or manually set it up

printf "Are you insalling a Fabric server?(y/n):"
read fabric
if [ "$fabric" = "y" ] || [ "$fabric" = "yes" ]; then
	printf "Enter the current Fabric installer download link (Universal Jar version)\n"
	read installer
	printf "Enter desired MC version, example '1.21.8'\nWARNING: Older MC versions may require installation of a different java version\n"
	read mcversion
	wget -cO - $installer > fabricinstaller.jar
	java -jar fabricinstaller.jar server -downloadMinecraft -mcversion $mcversion
	mv fabric-server-launch.jar myserver.jar

elif [ "$fabric" = "n" ] || [ "$fabric" = "no" ]; then
	printf "Enter the download link to the server jar then"
	read link
	wget -cO - $link > myserver.jar

else
	printf "Invalid response. Set up server jar manually later, or run script again if needed."
	exit 1
fi

#Some usage advice after server is setup for newer users
printf "\nThe server is now configured and ready to run! The script installed tmux for you, so that the server can run without you keeping the ssh session open\n\n"
printf "Read the documentation on my Github page for this script if you need help using tmux.\n\n"
printf "Enter 'tmux' and then 'tmux attach' to create and access a window and run './start.sh', the hotkey ctrl b+d will exit the window without closing the server\n\n"
printf "Your server files are located in the server directory, to access them enter cd && cd server, read the README for advice to optimize your server files"
