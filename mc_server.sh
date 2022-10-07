#!/bin/bash
#Update your packages, and install the ones we need

sudo apt update
sudo apt upgrade -y
sudo apt install nano wget openjdk-17-jdk screen
clear
#Create a directory for your server with a custom name

cd
#Lets you pick a directory name
echo "what do you want your server directory to be called? if you don't know just call it server"
read dir_name
mkdir $dir_name
cd $dir_name

#Makes your server launch script

cat << EOF > start.sh
java -jar -Xmx4G -Xms4G server.jar nogui
EOF
#Grants execute perms to our launch script
chmod +x start.sh

#Asks the user if they agree to MC Eula, if they do makes a file that agrees to eula easier

read -p "Do you agree to Minecraft Eula? (You do) (yes/no) " eula
case $eula in
#Wites the Eula file before the server jar generates it
yes ) echo Blindly agreeing to terms for you...;
echo 'eula=true' > eula.txt;;

no ) echo Ok do it yourself later...;;

* ) echo invalid response, do it yourself later;;
esac

#Lets you install the server jar quickly with just including a download link. If this is skipped you will have to install the server jar manually later

read -p "Do you want to install your minecraft server jar now? (yes/no) " install
case $install in
#asks the user wether they want to use easy server jar installation
 yes ) echo Moving to server jar installation...;;

 no ) echo All done! Make sure to add your Minecraft server jar, and name it server.jar, or change the name in the launch script;
exit;;

 * ) echo invalid response! You will have to do it yourself later or try running the script again,everything else is setup for you already;
exit;;
esac

#Check wether this is a fabric server which uses an installer, or a normal server jar download
#If fabric it will run the installer for you, if not it just downloads the jar from the link you give it

read -p "Is this a fabric server? (yes/no) " fabric
case $fabric in
#If you are installing a fabric server you have to use the Fabric installer, using this option lets you put the link to the fabric installer and the script runs it automatically, and asks for the MC version
yes ) echo Enter the Fabric installer download link;
read fabric_link;
echo Enter your desired MC version;
read mcversion;
wget -cO - $fabric_link > fabric-installer.jar;
java -jar fabric-installer.jar server -downloadMinecraft -mcversion $mcversion;;
#If not using fabric enter the download link to your server jar
no ) echo enter your server download link, if you leave this empty it will make an empty file you need to delete;
read server_download;
wget -cO -  $server_download > server.jar;;

 * ) echo Invalid response, add your server jar manually later;;
 esac

#Everything is done. There should be a server jar, a start script and a eula.txt file made if you answered yes to everything in the script

echo "Your server is ready to go! Read the docs if you are not sure how to use it"
