if [[ $(which java) ]]; then
    echo "Java is installed"
else
    apt update
    apt install default-jre -y
fi

echo "Do you have Firefox installed?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) ;;
        No ) apt update; apt install firefox -y;;
    esac
done
 apt install libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 libnss3-tools xterm openssl -y
 mkdir vpn
 cd ~/vpn
 wget https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/cshell_install.sh --no-check-certificate
 wget https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/snx_install.sh --no-check-certificate
 bash ./snx_install.sh
 bash ./cshell_install.sh
 read -p "After rebooting the computer, follow the remaining steps to finish the setup. Press enter to reboot your computer."
 shutdown -r now
