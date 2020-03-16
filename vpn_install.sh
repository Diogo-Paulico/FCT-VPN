#!/bin/bash

clear
read -p "This script checks for java and firefox and installs them if they're not installed already, then it will install the dependencies needed, and then the vpn programs. Follow the on-screen instructions and go back to the guide when told to. Press Enter to start the installation."

apt -qq update
# apt upgrade -y
# while updating is necessary to be sure we are downloading the most recent versions of the dependencies,
# I don't think we should upgrade the already installed software on the users computer (except for the stuff we are going to use ofc)
# because they migth want to use an older version of something

echo""
if [[ $(which java) ]]; then
    echo "1/6 - Java is installed"
else
    echo "1/6 - Java not found"
    echo "1/6 - Installing Java"
    apt -qq update
    apt -qq install default-jre -y
    echo "1/6 - Java has been installed"
fi

echo""
if [[ $(which firefox) ]]; then
    echo "2/6 - Firefox is installed"
else
    echo "2/6 - Firefox not found"
    echo "2/6 - Installing Firefox"
    apt -qq update
    apt -qq install firefox -y
    echo "2/6 - Firefox has been installed"
fi

echo""
echo "3/6 - Installing dependencies"
apt -qq install libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 libnss3-tools xterm openssl -y
echo "3/6 - Dependencies have been installed"

mkdir vpnInstaller
cd ./vpnInstaller

echo""
echo "4/6 - Installing snx"
wget -q -O snx_install.sh https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/snx_install.sh --no-check-certificate
chmod +x ./snx_install.sh
./snx_install.sh
echo "4/6 - snx installed"

echo""
read -p "Firefox needs to be opened as part of the setup (if you never opened it before), please open and close it and then press Enter to continue."

echo""
echo "5/6 - Installing cshell"
wget -q -O cshell_install.sh https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/cshell_install.sh --no-check-certificate
chmod +x ./cshell_install.sh
./cshell_install.sh
echo "5/6 - cshell installed"

echo""
echo "6/6 - Starting cleanup"
cd ..
rm -r vpnInstaller
echo "6/6 - Cleanup complete"

echo "Now go back to the guide. You may also delete this script, and uninstall firefox if it was installed during this setup and you have no use for it."
