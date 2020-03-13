echo "If you have run this setup before and the computer was reset press 2 and enter, otherwise press 1 and enter"
select yn in "FirstInstall" "ContinueInstall"; do
    case $yn in
        FirstInstall )
        if [[ $(which java) ]]; then
    echo "Java is installed"
else
    apt -qq update
    apt -qq install default-jre -y
fi
clear
echo "Do you have Firefox installed? Select number and press Enter"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) apt -qq update; apt -qq install firefox -y; break;;
    esac
done 
clear
 apt upgrade -y
 apt -qq install libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 libnss3-tools xterm openssl -y
 mkdir vpnInstaller
 cd ./vpnInstaller
 wget -q https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/cshell_install.sh --no-check-certificate
 wget -q https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/snx_install.sh --no-check-certificate
 read -p "After rebooting the computer, reopen the setup file and select number 2"
 reboot -f
        break;;
ContinueInstall ) 
        cd ./vpnInstaller
         bash ./snx_install.sh;
        bash ./cshell_install.sh;
        sleep 3;
        cd ..;
        rm -r vpnInstaller;
        clear;
        read -p "After rebooting the computer, follow the remaining steps to finish the setup. Press enter to reboot your computer.";
        shutdown -r now; 
         break;;
    esac
done 
