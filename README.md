# VPN FCT - Linux
This guide intends to allow the use of FCT's VPN on Linux. Any issues, post them in the issues tab

# Index
1. [Compatibility](#compatibility)
2. [VMs](#vms)
3. [Script Installation](#script-installation)
4. [Manual Installation](#manual-installation)
5. [Normal Access](#normal-access)
6. [Known issues](#known-issues)

## Compatibility
 * Tested and working on Ubuntu 16.04 LTS (32 & 64 bits) with Firefox 45 installed
 * Tested and working on Ubuntu 18.04 LTS (64 bits) with Firefox 72 installed
 * Tested and working on Ubuntu 19.10 (64 bits) with Firefox 73 installed
 * Should work for all Ubuntu distros (Ubuntu, Kubuntu, Lubuntu, Xubuntu, Pop Os!, Elementary OS, Linux Mint, ...)

## VMs
These VMs contain the VPN already installed, the website is bookmarked on firefox
 * Virtual machine with gcc and java installed (Lubuntu 18.04 32 bits) : https://drive.google.com/file/d/1Hu9sg8IwZ9ZX_jeraHorOeNilWPwPXq6/view?usp=sharing
 * Virtual machine with Eclipse and OCaml installed (Lubuntu 18.04 64 bits): https://drive.google.com/file/d/1BunnK3Sk6bq4ATfK613Z4AArjQ__uObr/view?usp=sharing


## Script Installation
 Download this script: https://drive.google.com/file/d/13cZTdzsjyqSW3h8y9vDaKCa3pdXYppo4/view?usp=sharing and save it in an easy to reach location (ie. Desktop, Documents, Downloads), then open a terminal window (press <kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>T</kbd> or search for it in the application menu) and type:

 ```
     cd ~/(location where it was saved (ie. Documents, Downloads, Desktop)) && sudo bash ./vpn_install.sh
 ```
  Follow the instructions on-screen until asked to consult this guide again.

 ### Step 2: During installation
  * Open firefox
  * Go to https://vpn.fct.unl.pt/
  * You should see this ![window](https://github.com/Diogo-Paulico/FCT-VPN/blob/master/3VPN.png)
  * Press Advanced > Accept the risk and proceed
  * Return to the installation window and press Enter

 ### Step 3: During installation
  * Open firefox
  * Go to https://vpn.fct.unl.pt/
  * Log in using your CLIP credentials
  * Accept pop-ups from this website
  * When a new window pops up, return to the installation window, press Enter and follow the instructions presented

You can delete the installation file after the computer reboots.

## Manual Installation

### Java

You need to have Oracle JRE or Oracle OpenJDK installed, to check if it is, open a terminal window (press <kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>T</kbd> or search for it in the application menu) and type
 ```
  java -version
  ```
  if your output looks anything like this:
  ```
  openjdk version "1.8.0_242"
  OpenJDK Runtime Environment (build 1.8.0_242-8u242-b08-0ubuntu3~19.10-b08)
  OpenJDK 64-Bit Server VM (build 25.242-b08, mixed mode)
  ```
  Java is installed. 
  
  If it looks like this:
  ```
    The program ‘java’ can be found in the following packages:
    * default-jre
    * gcj-4.6-jre-headless
    * openjdk-6-jre-headless
    * gcj-4.5-jre-headless
    * openjdk-7-jre-headless
    Try: sudo apt-get install
```
  Type in the terminal:

  ```
  sudo apt install default-jre
  ```
  Check if it was correctly installed by typing again:
  ```
  java -version
  ```
  The output should now look like the one presented previously.

 ### Firefox

 To check if you have Firefox installed either look for it in the applications menu or type in terminal:

 ```
  firefox
  ```
  if you don't, type:

  ```
  sudo apt install firefox
  ```
### Libraries required by the VPN
 
 To install them type in the terminal:
 
  ```
  sudo apt-get install libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 libnss3-tools xterm openssl 	
  ```

### SSL network extender
 Download it from the vpn's website: https://vpn.fct.unl.pt/sslvpn/SNX/INSTALL/snx_install.sh
 <br/>Save it in an easy to reach location (ie. Desktop, Documents, Downloads)
 <br/>Open a terminal window and type:
 ```
  cd ~/(location where it was saved (ie. Documents, Downloads, Desktop)) && sudo bash ./snx_install.sh
```
Afterwards reboot your computer or VM.

## Finishing setup

 * Open Firefox and go to https://vpn.fct.unl.pt/  
 * Sign-in using your CLIP credentials
 * You should see a window like this ![window](https://github.com/Diogo-Paulico/FCT-VPN/blob/master/1VPN.png)
 * Press <kbd>Connect</kbd>
 * A window like this should pop up ![window](https://github.com/Diogo-Paulico/FCT-VPN/blob/master/2VPN.png)
 * Press "Click here to download the Mobile Access Portal Agent."
 * Save it in an easy to reach location (ie. Desktop, Documents, Downloads)
 * Open a terminal window and type:
    ```
     cd ~/(location where it was saved (ie. Documents, Downloads, Desktop)) && sudo bash ./cshell_install.sh
    ```
 * Close all Firefox windows when it asks
 * Once it finishes installing you can close the terminal and open Firefox
 * Go to https://localhost:14186/id/
 * You should see this ![window](https://github.com/Diogo-Paulico/FCT-VPN/blob/master/3VPN.png)
 * Press Advanced > Accept the risk and proceed
 * You should see a random string of digits, meaning it is working as intended.
 * Restart Firefox and open https://vpn.fct.unl.pt/
 * Login and press connect
 * Press <kbd>Trust</kbd> in the window that pops up, and <kbd>Yes</kbd> in the next one
 * You should now be connected. 
 * Attempt to access Mooshak:
    http://mooshak.di.fct.unl.pt/~mooshak/
    OR
    http://193.136.122.90/~mooshak/
   
   The first one should take a while, it's normal.

## Normal access:
 After all these steps are done all you have to do to use it on a daily basis is access the VPN's website, login, click connect and you should be able to acess Mooshak from outside the FCT

 ## Known issues:
  * Can only acess Mooshak, none other of the FCT's websites seem to work
