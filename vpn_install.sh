#!/bin/bash

# Ignore the echo "" at the top of each function, they are only there to provide spacing and make everything pretty. Sometimes there is one, sometimes two.

update() {
    if [ "$UPDATE_FLAG" = true ]; then
        echo ""
        echo -e "\e[33mUpdating system...\e[0m"
        if [ "$VERBOSE_FLAG" = true ]; then
            apt update
        else
            apt update >/dev/null 2>&1
        fi

        if [ $? = 0 ]; then
            echo -e "\e[32mSystem has been updated!\e[0m"
            return 0
        else
            echo -e "\e[31mSystem update as failed!\e[0m"
            return 1
        fi
    fi
}

upgrade() {
    if [ "$UPGRADE_FLAG" = true ]; then
        echo ""
        # while updating is necessary to be sure we are downloading the most recent versions of the dependencies,
        # I don't think we should upgrade the already installed software on the users computer (except for the stuff we are going to use ofc)
        # because they migth want to use an older version of something
        echo -e "\e[33mUpgrading system...\e[0m"
        if [ "$VERBOSE_FLAG" = true ]; then
            apt upgrade -y
        else
            apt upgrade -y >/dev/null 2>&1
        fi

        if [ $? = 0 ]; then
            echo -e "\e[32mSystem has been upgraded!\e[0m"
            return 0
        else
            echo -e "\e[31mSystem upgrade as failed!\e[0m"
            return 1
        fi
    fi
}

install_java() {
    echo ""
    if [[ $(which java) ]]; then
        echo -e "\e[7m1/6\e[27m - \e[32mJava is installed.\e[0m"
    else
        echo -e "\e[7m1/6\e[27m - \e[31mJava not found.\e[0m"
        echo -e "\e[7m1/6\e[27m - \e[33mInstalling Java...\e[0m"

        if [ "$VERBOSE_FLAG" = true ]; then
            apt install default-jre -y
        else
            apt install default-jre -y >/dev/null 2>&1
        fi

        if [ $? = 0 ]; then
            echo -e "\e[7m1/6\e[27m - \e[32mJava has been installed!\e[0m"
            return 0
        else
            echo -e "\e[7m1/6\e[27m - \e[31mJava install has failed!\e[0m"
            return 1
        fi
    fi
}

install_firefox() {
    echo ""
    if [[ $(which firefox) ]]; then
        echo -e "\e[7m2/6\e[27m - \e[32mFirefox is installed.\e[0m"
    else
        echo -e "\e[7m2/6\e[27m - \e[31mFirefox not found.\e[0m"
        echo -e "\e[7m2/6\e[27m - \e[33mInstalling Firefox...\e[0m"

        if [ "$VERBOSE_FLAG" = true ]; then
            apt install firefox -y
        else
            apt install firefox -y >/dev/null 2>&1
        fi

        if [ $? = 0 ]; then
            echo -e "\e[7m2/6\e[27m - \e[32mFirefox has been installed!\e[0m"
            return 0
        else
            echo -e "\e[7m2/6\e[27m - \e[31mFirefox install has failed!\e[0m"
            return 1
        fi
    fi
}

install_dependencies() {
    echo ""
    echo -e "\e[7m3/6\e[27m - \e[33mInstalling dependencies...\e[0m"

    if [ "$VERBOSE_FLAG" = true ]; then
        apt install libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 libnss3-tools xterm openssl -y
    else
        apt install libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 libnss3-tools xterm openssl -y >/dev/null 2>&1
    fi

    if [ $? = 0 ]; then
        echo -e "\e[7m3/6\e[27m - \e[32mDependencies have been installed!\e[0m"
        return 0
    else
        echo -e "\e[7m3/6\e[27m - \e[31mDependencies install has failed!\e[0m"
        return 1
    fi
}

make_temp_dir() {
    mkdir vpnInstaller
    if [ $? != 0 ]; then
        echo -e "\e[31mFailed at creating temporary folder! (A folder called vpnInstaller already exists)\e[0m"
        return 1
    fi
    cd ./vpnInstaller
}

install_snx() {
    echo ""
    echo -e "\e[7m4/6\e[27m - \e[33mInstalling snx...\e[0m"

    if [ "$VERBOSE_FLAG" = true ]; then
        wget -q -O snx_install.sh https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/snx_install.sh --no-check-certificate
        chmod +x ./snx_install.sh
        ./snx_install.sh
    else
        wget -q -O snx_install.sh https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/snx_install.sh --no-check-certificate >/dev/null 2>&1
        chmod +x ./snx_install.sh >/dev/null 2>&1
        ./snx_install.sh >/dev/null 2>&1
    fi

    if [ $? = 0 ]; then
        echo -e "\e[7m4/6\e[27m - \e[32msnx has been installed!\e[0m"
        return 0
    else
        echo -e "\e[7m4/6\e[27m - \e[31msnx install has failed!\e[0m"
        return 1
    fi
}

setup_firefox() {
    echo ""
    echo ""
    echo -e "\e[1m\e[4mFirefox needs to have been opened at least once in this machine for the install to work, so please \e[32mopen\e[39m and \e[31mclose\e[39m it and then press \e[32mEnter to continue\e[0m."
    read
}

install_cshell() {
    echo ""
    echo -e "\e[7m5/6\e[27m - \e[33mInstalling cshell...\e[0m"

    if [ "$VERBOSE_FLAG" = true ]; then
        wget -q -O cshell_install.sh https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/cshell_install.sh --no-check-certificate
        chmod +x ./cshell_install.sh
        ./cshell_install.sh
    else
        wget -q -O cshell_install.sh https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/cshell_install.sh --no-check-certificate >/dev/null 2>&1
        chmod +x ./cshell_install.sh >/dev/null 2>&1
        ./cshell_install.sh >/dev/null 2>&1
    fi

    if [ $? = 0 ]; then
        echo -e "\e[7m5/6\e[27m - \e[32mcshell has been installed!\e[0m"
        return 0
    else
        echo -e "\e[7m5/6\e[27m - \e[31mcshell install has failed!\e[0m"
        return 1
    fi
}

cleanup() {
    echo ""
    echo -e "\e[7m6/6\e[27m - \e[33mStarting cleanup...\e[0m"
    cd ..
    rm -r vpnInstaller
    if [ $? != 0 ]; then
        echo -e "\e[7m6/6\e[27m - \e[31mFailed at deleting temporary folder! (Couldn't delete the vpnInstaller folder)\e[0m"
        return 1
    fi
    # TODO MAYBE DELETE ITSELF?
    echo -e "\e[7m6/6\e[27m - \e[32mCleanup complete!\e[0m"
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
    echo -e "\e[31mThe installation process will interfere with browsers, specially \e[4mfirefox\e[24m, so it's advised to save anything you might have to and close your browser before starting, \e[1m\e[4mor you might loose your work!\e[0m"
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
    update&&upgrade&&install_java&&install_firefox&&install_dependencies&&make_temp_dir&&install_snx&&setup_firefox&&install_cshell&&cleanup || {
        #catch
        echo -e "\e[31mVPN install failled! Please retry!\e[0m"
        return 1
    }

    echo ""
    echo -e "\e[1m\e[4mNow go back to the guide.\e[0m You may also delete this script, and uninstall firefox if it was installed during this setup and you have no use for it."

    return 0
}

UPDATE_FLAG=true
UPGRADE_FLAG=false
VERBOSE_FLAG=false

while getopts ":hdgv" opt; do
    case $opt in
    h) helpMessage ;;
    d) UPDATE_FLAG=false ;;
    g) UPGRADE_FLAG=true ;;
    v) VERBOSE_FLAG=true ;;
    esac
done

if [ "$EUID" -ne 0 ]
  then echo -e "\e[31mThis script needs root privileges! Please run with sudo!\e[0m"
  exit
fi

main
