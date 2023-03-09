# TacSh
### Tactical Shell Command

## Support Shell
- Zsh
- Bash

## Support Operating System
- macOS
- Linux
- Windows(MinGW)

## Support Environment Table
|OS|Zsh|Bash|
|---|---|---|
|macOS|YES|NO|
|Ubuntu|YES|YES|
|Debian|YES|YES|
|Fedora|YES|YES|
|CentOS|YES|YES|
|RHEL|YES|YES|
|SUSE|YES|YES|
|Arch|YES|YES|
|Kali|YES|YES|
|Windows|NO|YES|
Also, support other Linux distribution and Unix-like OS. Try run `./installer`!

## How to install TacSh
### 1) Install TacSh
Download and install TacSh. Before install, you should have bash.
#### Use stable release
```bash
wget -c https://github.com/leelsey/TacSh/releases/download/v0.1/installer -O tacsh-installer && ./tacsh-installer
```
#### Use git release
```bash
git clone https://github.com/leelsey/TacSh.git && cd TacSh && ./installer
```
#### Manually
Check `src` direcotry and copy to `~/.config/tacsh` directory.
### 2) Reload shell resource file
Reload shell resource file.
#### macOS
```bash
source ~/.zprofile
```
#### Linux (Zsh)
```bash
source ~/.zshrc
```
#### Linux (Bash)
```bash
source ~/.bashrc
```
#### Windows(MinGW)
```bash
source ~/.bashrc
```
### 3) If you change option, try this
```bash
tacsh conf
```
### 4) Uninstall TacSh
#### Use stable release
```bash
wget -c https://github.com/leelsey/TacSh/releases/download/v0.1/uninstaller -O tacsh-uninstaller && ./tacsh-uninstaller
# Remove TacSh from shell resource file
```
#### Use git release
```bash
git clone https://github.com/leelsey/TacSh.git && cd TacSh && ./uninstaller
# Remove TacSh from shell resource file
```
#### Manually
Try `rm -rf ~/.config/tacsh` and remove TacSh from shell resource file.

## Usage of TacSh
#### Command List
Windows(MinGW) is same to Linux.

### About TacSh Control
|Command|Usage|OS|
|---|---|---|
|tacsh|TacSh Control|macOS/Linux|

### About Shell and Evironments
|Command|Usage|OS|
|---|---|---|
|admin|Login super user (sudo -i)|macOS/Linux|
|shrl|Shell Reload|macOS/Linux|
|macrl|Reload macOS GUI|macOS|
|rlsh|Relaod shell configuration files|macOS/Linux|
|vienv|Edit sehll's env configuration file|macOS/Linux|
|viprofile|Edit shell's profile configuration file|macOS/Linux|
|virc|Edit shell's run command configuration file|macOS/Linux|
|vilogin|Edit shell's login configuration file|macOS/Linux|
|vilogout|Edit shell's logout file|macOS/Linux|
|vitacsh|Edit TacSh configure file|macOS/Linux|
|whichos|Output OS name|macOS/Linux|

### About Firewall
|Command|Usage|OS|
|---|---|---|
|firewall|Default add sudo|Linux|
|ufw|Default add sudo|Linux|
|nft|Default add sudo|Linux|
|iptables|Default add sudo|Linux|

### About Package Manager
|Command|Usage|OS|
|---|---|---|
|dpkg|Default add sudo|Linux|
|apt|Default add sudo|Linux|
|apt-get|Default add sudo|Linux|
|rpm|Default add sudo|Linux|
|dnf|Default add sudo|Linux|
|yum|Default add sudo|Linux|
|zypper|Default add sudo|Linux|
|pacman|Default add sudo|Linux|
|emerge|Default add sudo|Linux|

### About Default Commands Options & Colourising
|Command|Usage|OS|
|---|---|---|
|rm|Default add "-iv"|Linux|
|mv|Default add "-iv"|Linux|
|cp|Default add "-iv"|Linux|
|ln|Default add "-iv"|Linux|
|ls|Colourising|macOS/Linux|
|gls|Colourising|macOS|
|grep|Colourising|macOS/Linux|
|egrep|Colourising|macOS|
|fgrep|Colourising|macOS|
|xzegrep|Colourising|macOS|
|xzfgrep|Colourising|macOS|
|xzgrep|Colourising|macOS|
|zegrep|Colourising|macOS|
|zfgrep|Colourising|macOS|
|zgrep|Colourising|macOS|
|dir|Colourising with directory first|macOS/Linux|
|vdir|Colourising with directory first|Linux|
|ip|Colourising|Linux|
|tree|Colourising|macOS/Linux|

### About Extended Command
|Command|Usage|OS|
|---|---|---|
|l|ls -C|macOS/Linux|
|ll|ls -l|macOS/Linux|
|la|ls -A|macOS/Linux|
|ld|ls -Cd .*|macOS/Linux|
|lal|ls -Al|macOS/Linux|
|lla|ls -al|macOS/Linux|
|lsf|ls -F|macOS/Linux|
|lld|ls -ld .*|macOS/Linux|
|lsv|Total files number|macOS/Linux|
|ltr|tree through ls|macOS/Linux|
|cl|cd with ls|macOS/Linux|
|cla|cd with ls -A|macOS/Linux|
|cll|cd with ls -al|macOS/Linux|
|cdp|cd with pwd|macOS/Linux|
|cdr|cd /|macOS/Linux|
|cdh|cd ~|macOS/Linux|
|his|History|macOS/Linux|
|cls|Clear sreen (clear)|macOS/Linux|
|clh|Clear shell's history|macOS/Linux|
|clha|Clear shell's history with node, python|macOS/Linux|
|clmac|Reset macOS's dock and launchpad|macOS|
|cldock|Reset macOS's dock|macOS|
|cllaunchpad|Reset macOS's launchpad|macOS|
|shdn|sudo shutdown|macOS/Linux|
|shdnh|Shut Down OS|macOS/Linux|
|shdnr|Restart OS|macOS/Linux|
|vin|vi with number|macOS/Linux|
|svi|sudo vi|macOS/Linux|
|svim|sudo vim|macOS/Linux|
|nvi|nvim|macOS/Linux|
|snvi|sudo nvim|macOS/Linux|
|snvim|sudo nvim|macOS/Linux|
|pings|ping -a|macOS/Linux|
|pingt|ping send 10 time|macOS/Linux|
|ip|ipcofig|macOS|
|macslp|macOS sleep on/off|macOS|
|icloud|Change directory to iCloud|macOS|
|dropbox|Change directory to Dropbox|macOS/Linux|
|dif|diff a b with a b "bat -l diff"|macOS/Linux|
|dfr|diff -u a b with "diffr --line-numbers"|macOS/Linux|
|gsdif|same dif command use git|macOS/Linux|
|gsdfr|same dfr command use git|macOS/Linux|
|sy|Copy(yank) in shell|macOS|
|sp|Paste in shell|macOS/Linux|
|pwdc|Copy pwd|macOS/Linux|
|shspeed|Shell speed test|macOS/Linux|
|p|Pass command|macOS/Linux|
|jctl|Java control|macOS/Linux|
|dockerun|Docker run check|macOS/Linux|
|chicn|Change icon|macOS|

### About user command
|Command|Usage|OS|
|---|---|---|
|top|htop|Linux|
|wget|wget -c|Linux|
|curl|curl -w "\n"|Linux|
|ca|cal|Linux|
|da|date|Linux|
|c|clear|Linux|
|f|finger|Linux|
|j|job -l|Linux|
|bc| bc -l|Linux|
