#!/bin/bash

distro=$(grep -oP "(?<=^ID=).*" /etc/os-release)

echo $distro 'detected!'
sleep 2

case $distro in 
	ubuntu|debian)
		sudo apt update
		sudo apt install tmux wget openjdk-17-jdk -y
		;;
	ol|oraclelinux)
		sudo yum update -y
		sudo yum install tmux wget java-17-openjdk -y
		;;
	*)
		echo 'Could not detect distro, packages not installed. Install tmux, wget, and java manually and run the script again'
		;;
esac

clear

echo 'Packages installed, server will be configured now'
	
mkdir $HOME/server
cd $HOME/server

echo 'eula=true' > eula.txt

cat << EOF > start.sh
#!/bin/bash
java -jar -Xmx4G -Xms4G myserver.jar
EOF

chmod +x start.sh

read -p "Are you insalling a Fabric server?(y/n)" fabric
if [ "$fabric" = "y" ] || [ "$fabric" = "yes" ]; then
	echo "Enter the current Fabric installer download link (Universal Jar version)"
	read installer
	echo "Enter desired MC version, example 1.19.2"
	read mcversion
	wget -cO - $installer > fabricinstaller.jar
	java -jar fabricinstaller.jar server -downloadMinecraft -mcversion $mcversion
	mv fabric-server-launch.jar myserver.jar

elif [ "$fabric" = "n" ] || [ "$fabric" = "no" ]; then
	echo "Enter the download link to the server jar then"
	read link
	wget -cO - $link > myserver.jar

else
	echo "Invalid response. Set up server jar manually later."
	exit 1
fi

echo "The server is now configured and ready to run! The script installed tmux for you, so that the server can run without you keeping the ssh session open"
echo "Read the documentation on my Github page for this script if you need help using tmux."
echo "You can enter 'tmux' and then 'tmux attach' to create and access a window and then in there cd to the server directory and do ./start.sh, the hotkey ctrl b+d will exit the window"
