#!/bin/bash

# Ignore the echo "" at the top of each function, they are only there to provide spacing and make everything pretty. Sometimes there is one, sometimes two.

upgrade() {
    if [ "$UPGRADE_FLAG" = true ]; then
        echo ""
        # while updating is necessary to be sure we are downloading the most recent versions of the dependencies,
        # I don't think we should upgrade the already installed software on the users computer (except for the stuff we are going to use ofc)
        # because they might want to use an older version of something
        echo -e "\e[33mUpgrading system...\e[0m"
        if [ "$VERBOSE_FLAG" = true ]; then
			pacman -Syu --noconfirm
        else
			pacman -Syu --noconfirm
        fi

        if [ $? = 0 ]; then
            echo -e "\e[32mSystem has been upgraded!\e[0m"
            return 0
        else
            echo -e "\e[31mSystem upgrade has failed!\e[0m"
            return 1
        fi
    fi
}

install_java() {
    echo ""
    if [[ $(which java) ]]; then
        echo -e "\e[7m1/7\e[27m - \e[32mJava is installed.\e[0m"
    else
        echo -e "\e[7m1/7\e[27m - \e[31mJava not found.\e[0m"
        echo -e "\e[7m1/7\e[27m - \e[33mInstalling Java...\e[0m"

		pacman -S jre-openjdk --noconfirm >$STDOUT 2>&1
		installMessage $? "Java"
		return
    fi
}

install_firefox() {
    echo ""
    if [[ $(which firefox) ]]; then
        echo -e "\e[7m2/7\e[27m - \e[32mFirefox is installed.\e[0m"
    else
        echo -e "\e[7m2/7\e[27m - \e[31mFirefox not found.\e[0m"
        echo -e "\e[7m2/7\e[27m - \e[33mInstalling Firefox...\e[0m"

        pacman -S firefox --noconfirm>$STDOUT 2>&1
		installMessage $? "Firefox"
		return
    fi
}

install_dependencies() {
    echo ""
    echo -e "\e[7m3/7\e[27m - \e[33mInstalling dependencies...\e[0m"


	id -u aur-user-qzwsxedc &>/dev/null || useradd --system --create-home aur-user-qzwsxedc &&
	echo 'aur-user-qzwsxedc ALL=NOPASSWD: /usr/bin/pacman' > /etc/sudoers.d/aur-user-qzwsxedc &&

	pacman -S lib32-libx11 lib32-pam openssl libnss_nis xterm --noconfirm >$STDOUT 2>&1 &&
		echo '      This step might take a bit' &&
		su -p -c 'yay -S lib32-libstdc++5 --norebuild --noconfirm' - aur-user-qzwsxedc >$STDOUT 2>&1
	installMessage $? "Dependency set"
	return
}

make_temp_dir() {
    mkdir -p vpnInstaller
    if [ $? != 0 ]; then
        echo -e "\e[31mFailed at creating temporary folder! (A folder called vpnInstaller already exists)\e[0m"
        return 1
    fi
    cd ./vpnInstaller
}

install_snx() {
    echo ""
    echo -e "\e[7m4/7\e[27m - \e[33mInstalling snx...\e[0m"

	wget -q -O snx_install.sh https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/snx_install.sh --no-check-certificate >$STDOUT 2>&1
	chmod +x ./snx_install.sh >$STDOUT 2>&1
	./snx_install.sh >$STDOUT 2>&1
	installMessage $? "snx"
	return
}

setup_firefox() {
    echo ""

    echo -e "\e[7m5/7\e[27m - Firefox needs to have been opened at least once in this machine for the install to work, so we are opening and closing it just to be sure. Don't worry about it not showing up when we open it because we are going to open it in headless mode.\e[0m"
    echo -e "\e[7m5/7\e[27m - \e[33mOpening firefox...\e[0m"
        su -p -c 'firefox --headless&' - $SUDO_USER >$STDOUT 2>&1
    if [ "$VERBOSE_FLAG" = true ]; then
        echo "Closing in 5..."
        sleep 1
        echo "Closing in 4..."
        sleep 1
        echo "Closing in 3..."
        sleep 1
        echo "Closing in 2..."
        sleep 1
        echo "Closing in 1..."
        sleep 1
    else
        sleep 5
    fi
    echo -e "\e[7m5/7\e[27m - \e[33mClosing firefox...\e[0m"
    pkill -f firefox

    if [ $? = 0 ]; then
        echo -e "\e[7m5/7\e[27m - \e[32mFirefox setup succeded!\e[0m"
        return 0
    else
        echo -e "\e[7m5/7\e[27m - \e[31mFirefox setup failed!\e[0m"
        return 1
    fi
}

install_cshell() {
    echo ""
    echo -e "\e[7m6/7\e[27m - \e[33mInstalling cshell...\e[0m"

	wget -q -O cshell_install.sh https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/cshell_install.sh --no-check-certificate >$STDOUT 2>&1 &&
	chmod +x ./cshell_install.sh >$STDOUT 2>&1 &&
	./cshell_install.sh >$STDOUT 2>&1

	installMessage $? "cshell"
	return
}

installMessage(){
	if [ $1 = 0 ]; then
        echo -e "\e[7m6/7\e[27m - \e[32m$2 has been installed!\e[0m"
    else
        echo -e "\e[7m6/7\e[27m - \e[31m$2 install has failed!\e[0m"
    fi
	return $1
}


cleanup() {
    echo ""
    echo -e "\e[7m7/7\e[27m - \e[33mStarting cleanup...\e[0m"
    cd ..
    rm -r vpnInstaller
    if [ $? != 0 ]; then
        echo -e "\e[7m7/7\e[27m - \e[31mFailed at deleting temporary folder! (Couldn't delete the vpnInstaller folder)\e[0m"
        return 1
    fi
    # TODO MAYBE DELETE ITSELF?

	userdel --remove aur-user-qzwsxedc
	rm /etc/sudoers.d/aur-user-qzwsxedc
    echo -e "\e[7m7/7\e[27m - \e[32mCleanup complete!\e[0m"
}


helpMessage() {
    echo -e """
$(basename "$0") [-h] [-d] [-g] [-v]
Installs the Check Point's VPN software used by FCT-UNL.
Requires root privileges to run!

where:
 -h  show this help message
 -d  don't run apt update
 -g  run apt upgrade
 -v  explain what is being done
"""
    exit 0
}

main() {
    clear

    echo "This script checks if java and firefox are installed, if not it installs them, then it will install the needed dependencies, and then the vpn software."
    echo ""
    echo -e "\e[31mThe installation process will interfere with browsers, specially \e[4mfirefox\e[24m, so its advised to save anything you might have to and close your browser before starting, \e[1m\e[4mor you might lose your work!\e[0m"
    echo -e "\e[1m\e[41mLAST WARNING: CLOSE YOUR BROWSERS\e[0m"
    echo ""
    echo ""
    echo "Follow the on-screen instructions and go back to the guide when told to."
    echo -e "Press \e[32mEnter to start\e[0m the installation, or \e[31mCTRL-C to cancel\e[0m."
    read

    #update
    #upgrade

    #install_java
    #install_firefox
    #install_dependencies

    #make_temp_dir
    #install_snx
    #setup_firefox
    #install_cshell
    #cleanup

    #try
    upgrade && install_java && install_firefox && install_dependencies && make_temp_dir && install_snx && setup_firefox && install_cshell && cleanup || {
        #catch
        echo -e "\e[31mVPN install failed! Please try again!\e[0m"
        return 1
    }

    echo ""
    echo ""
    echo -e "\e[1m\e[4mNow go back to the guide.\e[0m You may also delete this script, and uninstall firefox if it was installed during this setup and you have no use for it."

    return 0
}

UPDATE_FLAG=true
UPGRADE_FLAG=false
VERBOSE_FLAG=false
STDOUT="/dev/null"

while getopts ":hdgv" opt; do
    case $opt in
    h) helpMessage ;;
    d) UPDATE_FLAG=false ;;
    g) UPGRADE_FLAG=true ;;
    v) VERBOSE_FLAG=true; STDOUT="/dev/stdout";;
    esac
done

if [ "$EUID" -ne 0 ]; then
    echo -e "\e[31mThis script needs root privileges! Please run with sudo!\e[0m"
    exit
fi
if [ -z $(grep "^\[multilib" "/etc/pacman.conf") ]; then
    echo -e "\e[31mPlease enable multilib in /etc/pacman.conf\e[0m"
	exit
fi


main
