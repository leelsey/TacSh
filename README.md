# TacSh

### Tactical Shell Command

## Support Shell
- Bash
- ZSH
### Will be supported
- Csh
- Ksh
- Dash
- Fish
- Tcsh

## Support Operating System
- macOS
- Linux
### Tesed Linux
- Ubuntu
- Debian
- Fedora
- CentOS
- Arch

## How to install TacSh
### 1) Install TacSh
Download and install TacSh.
Before install, you should have bash.
#### Use stable release
```bash
wget -c https://github.com/leelsey/TacSh/releases/download/v0.1/install.sh -O tacsh-installer
./tacsh-installer
```
#### Use git release
```bash
git clone https://github.com/leelsey/TacSh.git
cd TacSh
./install.sh
```
### 2) Reload shell resource file
Reload shell resource file.
#### Bash
```bash
source ~/.bash_profile
```
#### Zsh
```bash
source ~/.zprofile
```
### 3) If you change option, try this
```bash
vitacsh
```

## Usage of TacSh
Command List

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
|p|Pass command|macOS/Linux|
|jctl|Java control|macOS/Linux|
|dockerun|Docker run check|macOS/Linux|

### Alias command
|Command|Usage|
|---|---|
|apt|sudo apt|Linux|
|apt-get|sudo apt-get|Linux|
|dnf|sudo dnf|Linux|
|yum|sudo yum|Linux|
|pacman|sudo pacman|Linux|
|zypper|sudo zypper|Linux|
|ufw|sudo ufw|Linux|
|nft|sudo nft|Linux|
|firewall-cmd|sudo firewall-cmd|Linux|
|iptables|sudo iptables|Linux|
|da|date|
|ca|cal|
|c|clear|
|f|finger|
|j|job -l|
|bc| bc -l|
