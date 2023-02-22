#!/usr/bin/env bash

tacshVer="0.1"
tacshGenDirPath="./src"
tacshDirPath="\$HOME/.config/tacsh"
msgReadme="Read the README.md for build options."

funcTitle() { echo -e "$1 ______         ______ \n$1/_  __/__ _____/ __/ / \n$1 / / / _ \`/ __/\\ \\/ _ \\ \n$1/_/  \\_,_/\\__/___/_//_/ ver $tacshVer \n$1                        by leelsey \n" ; }
funcRmFile() { if [ -f $taschGenFilePath ] ; then rm -rf $taschGenFilePath ; fi ; }
funcMkFile() { mkdir -p $taschGenDirPath ; touch $taschGenFilePath && chmod 600 $taschGenFilePath ; funcTitle "# " >> $taschGenFilePath ; }
funcAddFile() { echo -e $1 >> $taschGenFilePath ; }
funcWrong() { echo " • Wrong usage. Please try again." ; exit 1 ; }
funcGen() {
    funcRmFile
    funcMkFile

    # Funtional command part
    funcAddFile "# TACTICAL COMMAND"

    # About TacSh
    funcAddFile "\n# ABOUT TACSH"
    funcAddFile "tacsh () {"
    funcAddFile "\ttacshVer=\"$tacshVer\""
    funcAddFile "\ttacshPath=\"\$HOME/.config/tacsh/tac.sh\""
    funcAddFile "\tif [[ \$1 == ver ]] || [[ \$1 == version ]]; then"
    funcAddFile "\t\techo \"ver \$tacshVer\" ;"
    funcAddFile "\telif [[ \$1 == ls ]] || [[ \$1 == list ]]; then"
    funcAddFile "\t\tcat \"\$tacshPath\" ;"
    funcAddFile "\telif [[ \$1 == conf ]] || [[ \$1 == config ]] || [[ \$1 == configure ]]; then"
    funcAddFile "\t\tvi \"\$tacshPath\" ;"
    funcAddFile "\telse"
    funcAddFile "\t\techo \"try 'tacsh ver' or 'tacsh ls' or 'tacsh conf'\""
    funcAddFile "\tfi"
    funcAddFile "}"

    # About Shell and Evironments
    funcAddFile "\n# ABOUT ENVIRONMENTS"
    if [ \$EUID != 0 ]; then
        funcAddFile "admin () { sudo -i ; } "
    fi
    funcAddFile "shrl () { echo \"reloaded shell\" && exec -l \$SHELL ; }"
    if [ $keName = "Darwin" ]; then
        funcAddFile "macrl () { killall SystemUIServer ; killall Dock ; killall Finder ; echo \"reloaded macOS GUI\"}"
    fi
    funcAddFile "rlsh () {"
    funcAddFile "\tif [ -f \"\$HOME/.$shPf\" ] || [ -f \"\$HOME/.$shRc\" ]; then"
    funcAddFile "\t\tsource \"\$HOME/.$shPf\" && source \"\$HOME/.$shRc\" ;"
    funcAddFile "\t\techo \"reloaded .$shPf and .$shRc\" ;"
    funcAddFile "\telif [ -f \"\$HOME/.$shRc\" ]; then"
    funcAddFile "\t\tcommand source \"\$HOME/.$shRc\" ;"
    funcAddFile "\t\techo \"reloaded .$shRc\" ;"
    funcAddFile "\telif [ -f \"\$HOME/$shPf\" ]; then"
    funcAddFile "\t\tcommand source \"\$HOME/.$shPf\" ;"
    funcAddFile "\t\techo \"reloaded .$shPf\" ;"
    funcAddFile "\telse"
    funcAddFile "\t\techo \"shrl: No environment file found\""
    funcAddFile "\tfi"
    funcAddFile "}"
    funcAddFile "vienv () { vi \"\$HOME/.$shEnv\" ; }"
    funcAddFile "viprofile () { vi \"\$HOME/.$shPf\" ; }"
    funcAddFile "virc () { vi \"\$HOME/.$shRc\" ; }"
    funcAddFile "vilogin () { vi \"\$HOME/.$shLin\" ; }"
    funcAddFile "vilogout () { vi \"\$HOME/.$shLout\" ; }"
    funcAddFile "whichos () { echo \$(uname) ; }"
    if [ $keName = "Linux" ]; then
        funcAddFile "\n# FIREWALL MANAGEMENT TOOL"
        if [[ $osName = "Ubuntu" ]]; then
            funcAddFile "#alias firewall='sudo firewall-cmd' # firewall (firewalld)"
            funcAddFile "alias ufw='sudo ufw'                # ufw (uncomplicated firewall)"
            funcAddFile "#alias nft='sudo nft'               # nftables (netfilter table)"
            funcAddFile "alias iptables='sudo iptables'      # iptables (old netfilter)"
        elif [[ $osName = "Debian" ]] || [[ $osName = "Kali" ]]; then
            funcAddFile "#alias firewall='sudo firewall-cmd' # firewall (firewalld)"
            funcAddFile "#alias ufw='sudo ufw'               # ufw (uncomplicated firewall)"
            funcAddFile "alias nft='sudo nft'                # nftables (netfilter table)"
            funcAddFile "alias iptables='sudo iptables'      # iptables (old netfilter)"
        elif [[ $osName = "Fedora" ]] || [[ $osName = "CentOS" ]] || [[ $osName = "RHEL" ]] || [[ $osName = "SUSE" ]]; then
            funcAddFile "alias firewall='sudo firewall-cmd'  # firewall (firewalld)"
            funcAddFile "#alias ufw='sudo ufw'               # ufw (uncomplicated firewall)"
            funcAddFile "#alias nft='sudo nft'               # nftables (netfilter table)"
            funcAddFile "alias iptables='sudo iptables'      # iptables (old netfilter)"
        elif [[ $osName = "Arch" ]]; then
            funcAddFile "#alias firewall='sudo firewall-cmd' # firewall (firewalld)"
            funcAddFile "#alias ufw='sudo ufw'               # ufw (uncomplicated firewall)"
            funcAddFile "#alias nft='sudo nft'               # nftables (netfilter table)"
            funcAddFile "alias iptables='sudo iptables'      # iptables (old netfilter)"
        else
            funcAddFile "#alias firewall='sudo firewall-cmd' # firewall (firewalld)"
            funcAddFile "#alias ufw='sudo ufw'               # ufw (uncomplicated firewall)"
            funcAddFile "#alias nft='sudo nft'               # nftables (netfilter table)"
            funcAddFile "#alias iptables='sudo iptables'     # iptables (old netfilter)"
        fi
        funcAddFile "\n# PACKAGE MANAGEMENT TOOL"
        if [[ $osName = "Ubuntu" ]] || [[ $osName = "Debian" ]] || [[ $osName = "Kali" ]]; then
            funcAddFile "#alias dpkg='sudo dpkg'             # Debian Package Manager for Debian-based"
            funcAddFile "#alias apt='sudo apt'               # Advanced Package Tool for Debian-based"
            funcAddFile "#alias apt-get='sudo apt-get'       # Advanced Package Tool (old) for Debian-based"
        elif [[ $osName = "Fedora" ]] || [[ $osName = "CentOS" ]] || [[ $osName = "RHEL" ]]; then
            funcAddFile "#alias rpm='sudo rpm'               # Red Hat Package Manager for RHEL-based"
            funcAddFile "#alias dnf='sudo dnf'               # Dandified YUM for RHEL-based"
            funcAddFile "#alias yum='sudo yum'               # Yellowdog Updater, Modified (old) for RHEL-based"
        elif [[ $osName = "SUSE" ]]; then
            funcAddFile "#alias zypper='sudo zypper'         # Zen / YaST Packages Patches Patterns Products for SUSE-based"
        elif [[ $osName = "Arch" ]]; then
            funcAddFile "#alias pacman='sudo pacman'         # Pacman for arch-based family"
        else
            funcAddFile "#alias dpkg='sudo dpkg'             # Debian Package Manager for Debian-based"
            funcAddFile "#alias apt='sudo apt'               # Advanced Package Tool for Debian-based"
            funcAddFile "#alias apt-get='sudo apt-get'       # Advanced Package Tool (old) for Debian-based"
            funcAddFile "#alias rpm='sudo rpm'               # Red Hat Package Manager for RHEL-based"
            funcAddFile "#alias dnf='sudo dnf'               # Dandified YUM for RHEL-based"
            funcAddFile "#alias yum='sudo yum'               # Yellowdog Updater, Modified (old) for RHEL-based"
            funcAddFile "#alias zypper='sudo zypper'         # Zen / YaST Packages Patches Patterns Products for SUSE-based"
            funcAddFile "#alias pacman='sudo pacman'         # Pacman for arch-based family"
            funcAddFile "#alias emerge='sudo emerge'         # Portage for gentoo-based"
        fi
    fi

    # About Default Commands Options & Colourising
    funcAddFile "\n# ABOUT DEFAULT OPTIONS WITH COLOURISING"
    if [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then 
        funcAddFile "rm () { command rm -iv \"\$@\" ; } "
        funcAddFile "mv () { command mv -iv \"\$@\" ; } "
        funcAddFile "cp () { command cp -iv \"\$@\" ; } "
        funcAddFile "ln () { command ln -iv \"\$@\" ; } "
        funcAddFile "#chmod () { command chmod --preserve-root \"\$@\" ; }"
        funcAddFile "#chown () { command chown --preserve-root \"\$@\" ; }"
        funcAddFile "#chgrp () { command chgrp --preserve-root \"\$@\" ; }"
        funcAddFile "#mkdir () { command mkdir -v \"\$@\" ; } "
        funcAddFile "#rmdir () { command rmdir -v \"\$@\" ; } "
        funcAddFile "#vi () { command vim \"\$@\" ; }"
        funcAddFile "#emcs () { emacs \"\$@\" ; }"
        funcAddFile "#semcs () { sudo emacs \"\$@\" ; }"
        funcAddFile "#semacs () { sudo emacs \"\$@\" ; }"
        funcAddFile "#dfh () { df -h \"\$@\" ; }"
        funcAddFile "#duh () { du -h \"\$@\" ; }"
    fi
    if [ $keName = "Darwin" ]; then
        funcAddFile "grep () { command grep --color=auto \"\$@\" ; }"
        funcAddFile "egrep () { command egrep --color=auto \"\$@\" ; }"
        funcAddFile "fgrep () { command fgrep --color=auto \"\$@\" ; }"
        funcAddFile "xzegrep () { command xzegrep --color=auto \"\$@\" ; }"
        funcAddFile "xzfgrep () { command xzfgrep --color=auto \"\$@\" ; }"
        funcAddFile "xzgrep () { command xzgrep --color=auto \"\$@\" ; }"
        funcAddFile "zegrep () { command zegrep --color=auto \"\$@\" ; }"
        funcAddFile "zfgrep () { command zfgrep --color=auto \"\$@\" ; }"
        funcAddFile "zgrep () { command zgrep --color=auto \"\$@\" ; }"
        funcAddFile "ls () { command ls -G \"\$@\" ; }"
        funcAddFile "gls () { command gls --color=auto \"\$@\" ; }"
        funcAddFile "dir () { gls -Ao --group-directories-first \"\$@\" ; }"
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        if [ $shName = "zsh" ]; then
            funcAddFile "grep () { command grep --color=auto \"\$@\" ; }"
            funcAddFile "ls () { command ls --color=auto \"\$@\" ; }"
        elif [ $shName = "bash" ]; then
            funcAddFile "#grep () { command grep --color=auto \"\$@\" ; }"
            funcAddFile "#ls () { command ls --color=auto \"\$@\" ; }"
        fi
        funcAddFile "dir () { command dir -Ao --color=auto --group-directories-first \"\$@\" ; }"
        funcAddFile "vdir () { command vdir -Ao --color=auto --group-directories-first \"\$@\" ; }"
    fi
    if [ $keName = "Linux" ]; then
        funcAddFile "ip () { command ip -c \"\$@\" ; }"
    fi
    funcAddFile "tree () { command tree -C \"\$@\" ; }"

    # About Extended Command
    funcAddFile "\n# ABOUT EXTENDED COMMAND"
    if [ $keName = "Darwin" ]; then
        funcAddFile "l () { ls -C \"\$@\" ; }"
        funcAddFile "ll () { ls -l \"\$@\" ; }"
        funcAddFile "la () { ls -A \"\$@\" ; }"
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        if [ $shName = "zsh" ]; then
            funcAddFile "l () { ls -C \"\$@\" ; }"
            funcAddFile "ll () { ls -l \"\$@\" ; }"
            funcAddFile "la () { ls -A \"\$@\" ; }"
        elif [ $shName = "bash" ]; then
            funcAddFile "#l () { ls -C \"\$@\" ; }"
            funcAddFile "#ll () { ls -l \"\$@\" ; }"
            funcAddFile "#la () { ls -A \"\$@\" ; }"
        fi
    fi
    funcAddFile "ld () { ls -Cd .* \"\$@\" ; }"
    funcAddFile "lal () { ls -Al \"\$@\" ; }"
    funcAddFile "lla () { ls -al \"\$@\" ; }"
    funcAddFile "llo () { ls -alO \"\$@\" ; }"
    funcAddFile "lsf () { ls -F \"\$@\" ; }"
    funcAddFile "lld () { ls -ld .* \"\$@\" ; }"
    funcAddFile "lsv () { ls -alh \$@ | grep -v \"^[d|b|c|l|p|s|-]\" \"\$@\" ; }"
    funcAddFile "ltr () { ls -lR \"\$@\" ; }"
    funcAddFile "cl () { cd \"\$@\" && ls ; }"
    funcAddFile "cla () { cd \"\$@\" && ls -A ; }"
    funcAddFile "cll () { cd \"\$@\" && ls -al ; }"
    funcAddFile "cdp () { cd \"\$@\" && pwd ; }"
    funcAddFile "cdr () { cd /\"\$@\" ; }"
    funcAddFile "cdh () { cd ~/\"\$@\" ; }"
    funcAddFile "his () { history \"\$@\" ; }"
    funcAddFile "cls () { clear ; }"
    if [ $shName = "zsh" ]; then
        funcAddFile "clh () { echo -n > ~/.zsh_history && history -p  && exec \$SHELL -l; }"
        funcAddFile "clha () { echo -n > ~/.zsh_history && history -p && rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec \$SHELL -l; }"
    elif [ $shName = "bash" ]; then
        funcAddFile "clh () { history -c  && exec \$SHELL -l; }"
        funcAddFile "clha () { rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec \$SHELL -l; }"
    fi
    if [ $keName = "Darwin" ]; then 
        funcAddFile "clmac () { defaults delete com.apple.dock ; defaults write com.apple.dock ResetLaunchPad -bool true ; killall Dock ; echo \"reseted dock and launchpad\" ; }"
        funcAddFile "cldock () { defaults delete com.apple.dock ; killall Dock ; echo \"reseted dock\" ; }"
        funcAddFile "cllaunchpad () { defaults write com.apple.dock ResetLaunchPad -bool true ; killall Dock ; echo \"reseted launchpad\" ; }"
    fi
    funcAddFile "shdn () { sudo shutdown \"\$@\" ; } "
    funcAddFile "shdnh () { sudo shutdown -h now ; } "
    funcAddFile "shdnr () { sudo shutdown -r now ; } "
    funcAddFile "vin () { vi \"+set nu\" \"\$@\" ; }"
    funcAddFile "svi () { sudo vi \"\$@\" ; }"
    funcAddFile "svim () { sudo vim \"\$@\" ; }"
    funcAddFile "nvi () { nvim \"\$@\" ; }"
    funcAddFile "snvi () { sudo nvim \"\$@\" ; }"
    funcAddFile "snvim () { sudo nvim \"\$@\" ; }"
    funcAddFile "pings () { ping -a \"\$@\" ; }"
    funcAddFile "pingt () { ping -a -c 10 \"\$@\" ; }"
    if [ $keName = "Darwin" ]; then
        funcAddFile "pinga () { ping -a --apple-connect --apple-time \"\$@\" ; }"
        funcAddFile "macslp () {"
        funcAddFile "\tif [ \"\$#\" -eq 1 ]; then"
        funcAddFile "\t\tif [[ \$1 =~ on ]]; then"
        funcAddFile "\t\t\tsudo pmset -c disablesleep 0 ;"
        funcAddFile "\t\telif [[ \$1 =~ off ]]; then"
        funcAddFile "\t\t\tsudo pmset -c disablesleep 1 ;"
        funcAddFile "\t\telse"
        funcAddFile "\t\t\techo \"usage: macslp on/off \" ;"
        funcAddFile "\t\tfi"
        funcAddFile "\telse"
        funcAddFile "\t\techo \"usage: macslp on/off \" ;"
        funcAddFile "\tfi"
        funcAddFile "}"
        funcAddFile "icloud () { cd $iCloudPath ; ls -A ; }"
        funcAddFile "if [ -d $dropboxPath ]; then"
        funcAddFile "\tdropbox () { cd $dropboxPath ; ls -A ; }"
        funcAddFile "fi"
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        funcAddFile "if [ -d $dropboxPath ]; then"
        funcAddFile "\tdropbox () { cd $dropboxPath ; ls -A ; }"
        funcAddFile "fi"
    fi
    if [ $keName = "Darwin" ] || [ $keName = "MinGW64" ]; then
        funcAddFile "ip () { command ipconfig \"\$@\" ;  }" 
    fi
    funcAddFile "dif () { diff \$1 \$2 | bat -l diff ; }"
    funcAddFile "dfr () { diff -u \$1 \$2 | diffr --line-numbers ; }"
    funcAddFile "gsdif () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | bat -l diff ; shift ; done ; }"
    funcAddFile "gsdfr () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | diffr --line-numbers ; shift ; done ; }"
    if [ $keName = "Darwin" ]; then
        funcAddFile "sy () { pbcopy < \"\$1\" ; }"
        funcAddFile "sp () { pbpaste > \"\$1\" ; }"
        funcAddFile "pwdc () { pwd | pbcopy ; }"
    elif [ $keName = "Linux" ]; then
        funcAddFile "sy () { xclip -selection clipboard < \"\$1\" ; }"
        funcAddFile "sp () { xclip -selection clipboard > \"\$1\" ; }"
        funcAddFile "pwdc () { pwd | xclip -selection clipboard ; }"
    fi
    funcAddFile "p () {"
    funcAddFile "\tif [ \$# -eq 0 ]; then"
    funcAddFile "\t\tcd .. ;"
    funcAddFile "\telif [ \$# -eq 1 ]; then"
    funcAddFile "\t\tif [[ \$1 =~ '^[0-9]+$' ]]; then"
    funcAddFile "\t\t\tif [[ \$1 == 0 ]]; then"
    funcAddFile "\t\t\t\tpwd ;"
    funcAddFile "\t\t\telse"
    funcAddFile "\t\t\t\tprintf -v cdpFull '%*s' \$1 ;"
    funcAddFile "\t\t\t\tcd \"\${cdpFull// /\"../\"}\" ;"
    funcAddFile "\t\t\tfi"
    funcAddFile "\t\telif [[ \$1 =~ '^[y]+$' ]]; then"
    funcAddFile "\t\t\tpwd | pbcopy ;"
    funcAddFile "\t\telif [[ \$1 =~ '^[p]+$' ]]; then"
    funcAddFile "\t\t\tpwd ;"
    funcAddFile "\t\telif [[ \$1 =~ '^[b]+$' ]] || [[ \$1 == - ]]; then"
    funcAddFile "\t\t\tcd - ;"
    funcAddFile "\t\telif [[ \$1 =~ '^[r]+$' ]] || [[ \$1 == / ]]; then"
    funcAddFile "\t\t\tcd / ;"
    funcAddFile "\t\telif [[ \$1 =~ '^[h]+$' ]] || [[ \$1 == ~ ]]; then"
    funcAddFile "\t\t\tcd ~ ;"
    if [ $keName = "Darwin" ]; then
        funcAddFile "\t\telif [[ \$1 == ap ]] || [[ \$1 == app ]] || [[ \$1 == App ]]; then"
        funcAddFile "\t\t\tcd /Applications ;"
    fi
    funcAddFile "\t\telif [[ \$1 == ds ]] || [[ \$1 == des ]] || [[ \$1 == Des ]]; then"
    funcAddFile "\t\t\tcd ~/Desktop ;"
    funcAddFile "\t\telif [[ \$1 == dc ]] || [[ \$1 == doc ]] || [[ \$1 == Doc ]]; then"
    funcAddFile "\t\t\tcd ~/Documents ;"
    funcAddFile "\t\telif [[ \$1 == dw ]] || [[ \$1 == dow ]] || [[ \$1 == Dow ]]; then"
    funcAddFile "\t\t\tcd ~/Downloads ;"
    if [ $keName = "Darwin" ]; then
        funcAddFile "\t\telif [[ \$1 == lb ]] || [[ \$1 == lib ]] || [[ \$1 == Lib ]]; then"
        funcAddFile "\t\t\tcd ~/Library ;"
        funcAddFile "\t\telif [[ \$1 == mv ]] || [[ \$1 == mov ]] || [[ \$1 == Mov ]]; then"
        funcAddFile "\t\t\tcd ~/Movies ;"
    fi
    funcAddFile "\t\telif [[ \$1 == ms ]] || [[ \$1 == mus ]] || [[ \$1 == Mus ]]; then"
    funcAddFile "\t\t\tcd ~/Music ;"
    funcAddFile "\t\telif [[ \$1 == pc ]] || [[ \$1 == pic ]] || [[ \$1 == Pic ]]; then"
    funcAddFile "\t\t\tcd ~/Pictures ;"
    if [ $keName = "Darwin" ]; then
        funcAddFile "\t elif [[ \$1 == ic ]] || [[ \$1 == icl ]] || [[ \$1 == iCl ]] || [[ \$1 == cl ]] || [[ \$1 == clo ]] || [[ \$1 == Clo ]] ; then"
        funcAddFile "\t\t\tcd '$iCloudPath' ;"
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        funcAddFile "\t\telif [[ \$1 == vd ]] || [[ \$1 == vid ]] || [[ \$1 == Vid ]]; then"
        funcAddFile "\t\t\tcd ~/Videos ;"
    fi
    funcAddFile "\t\telif [[ \$1 == dr ]] || [[ \$1 == dro ]] || [[ \$1 == Dro ]] || [[ \$1 == drp ]] || [[ \$1 == Drp ]] ; then"
    funcAddFile "\t\t\tif [ -d $dropboxPath ]; then"
    funcAddFile "\t\t\t\tcd '$dropboxPath' ;"
    funcAddFile "\t\t\telse"
    funcAddFile "\t\t\t\techo \"p: wrong usage, try p -h\" ;"
    funcAddFile "\t\t\tfi"
    funcAddFile "\t\telif [[ \$1 == --help ]] || [[ \$1 == -help ]] || [[ \$1 == -h ]]; then"
    funcAddFile "\t\t\techo \"p: change direcotry to parent directory\""
    funcAddFile "\t\t\techo \"p [number]: change direcotry to parent [number]th directory\""
    funcAddFile "\t\t\techo \"p p: output current directory\""
    funcAddFile "\t\t\techo \"p b(-): change direcotry to previous directory\""
    funcAddFile "\t\t\techo \"p r(/): change direcotry to root directory\""
    funcAddFile "\t\t\techo \"p h(~): change direcotry to home directory\""
    if [ $keName = "Darwin" ]; then
        funcAddFile "\t\t\techo \"p ap, app: change direcotry to applications directory\""
    fi
    funcAddFile "\t\t\techo \"p ds, des: change direcotry to desktop directory\""
    funcAddFile "\t\t\techo \"p dc, doc: change direcotry to documents directory\""
    funcAddFile "\t\t\techo \"p dw, dow: change direcotry to downloads directory\""
    if [ $keName = "Darwin" ]; then
        funcAddFile "\t\t\techo \"p lb, lib: change direcotry to movies directory\""
        funcAddFile "\t\t\techo \"p mv, mov: change direcotry to movies directory\""
    fi
    funcAddFile "\t\t\techo \"p ms, mus: change direcotry to music directory\""
    funcAddFile "\t\t\techo \"p pc, pic: change direcotry to pictures directory\""
    if [ $keName = "Darwin" ]; then
        funcAddFile "\t\t\techo \"p ic, cl, icl, clo: change direcotry to icloud directory\""
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        funcAddFile "\t\t\techo \"p vd, vid: change direcotry to videos directory\""
    fi
    funcAddFile "\t\t\techo \"p dr, dro, drp: change direcotry to dropbox directory\""
    funcAddFile "\t\t\techo \"p -h: output usage\""
    funcAddFile "\t\telse"
    funcAddFile "\t\t\techo \"p: wrong usage, try p -h\" ;"
    funcAddFile "\t\tfi"
    funcAddFile "\telse"
    funcAddFile "\t\techo \"p: wrong usage, try p -h\" ;"
    funcAddFile "\tfi"
    funcAddFile "}"
    funcAddFile "jctl () {"
    funcAddFile "\tif [ \"\$#\" -eq 0 ]; then"
    funcAddFile "\t\t/usr/libexec/java_home -V ;"
    funcAddFile "\telif [ \"\$#\" -eq 1 ]; then"
    funcAddFile "\t\tunset JAVA_HOME ;"
    funcAddFile "\t\texport JAVA_HOME=\$(/usr/libexec/java_home -v \"\$1\") ;"
    funcAddFile "\t\tjava -version ;"
    funcAddFile "\telse"
    funcAddFile "\t\techo \"javahome: wrong usage\""
    funcAddFile "\tfi"
    funcAddFile "}"
    funcAddFile "dockerun () {"
    funcAddFile "\tif ! docker info > /dev/null 2>&1; then"
    funcAddFile "\t\techo \"dockerun false: Docker isn't running\""
    funcAddFile "\telse"
    funcAddFile "\t\techo \"dockerun true: Docker is running\""
    funcAddFile "\tfi"
    funcAddFile "}"
    if [ $keName = "Darwin" ]; then
        funcAddFile "chicn () {"
        funcAddFile "\tif [ \$# -eq 2 ]; then"
        funcAddFile "\t\tif [[ \"\$1\" =~ ^https?:// ]]; then"
        funcAddFile "\t\t\tcurl -sLo /tmp/ic \"\$1\" ;"
        funcAddFile "\t\t\t1=/tmp/iconchange"
        funcAddFile "\t\tfi"
        funcAddFile "\t\tif ! [ -f \$1 ]; then"
        funcAddFile "\t\t\techo \"chicn: cannot stat '\$1': No such file\""
        funcAddFile "\t\telif ! [ -d \$2 ]; then"
        funcAddFile "\t\t\techo \"chicn: cannot stat '\$2': No such directory\""
        funcAddFile "\t\telse"
        funcAddFile "\t\t\tsudo rm -rf \"\$2\"\$'/Icon\\\r'"
        funcAddFile "\t\t\tsips -i \"\$1\" > /dev/null"
        funcAddFile "\t\t\tDeRez -only icns \"\$1\" > /tmp/icnch.rsrc"
        funcAddFile "\t\t\tsudo Rez -append /tmp/icnch.rsrc -o \"\$2\"\$'/Icon\\\r'"
        funcAddFile "\t\t\tsudo SetFile -a C \"\$2\""
        funcAddFile "\t\t\tsudo SetFile -a V \"\$2\"\$'/Icon\\\r'"
        funcAddFile "\t\tfi"
        funcAddFile "\t\trm -rf /tmp/icnch /tmp/icnch.rsrc"
        funcAddFile "\telse"
        funcAddFile "\t\techo \"chicn: wrong usage\""
        funcAddFile "\tfi"
        funcAddFile "}"
    fi

    # Alias commands for user (custom)
    if [ $keName = "Linux" ]; then
        funcAddFile "\n# USER COMMANDS"
        funcAddFile "#alias top='htop'"
        funcAddFile "#alias wget='wget -c'"
        funcAddFile "#alias curl='curl -w \"\\\n\"'"
        funcAddFile "#alias ca='cal'"
        funcAddFile "#alias da='date'"
        funcAddFile "#alias c='clear'"
        funcAddFile "#alias f='finger'"
        funcAddFile "#alias j='jobs -l'"
        funcAddFile "#alias bc='bc -l'"
    fi
}

# MAIN
funcTitle ""

if [ $1 = 1 ]; then osCode=1
elif [ $1 = 2 ]; then osCode=2
    if [ $2 = 1 ]; then luCode=1
    elif [ $2 = 2 ]; then luCode=2
    elif [ $2 = 3 ]; then luCode=3
    elif [ $2 = 4 ]; then luCode=4
    elif [ $2 = 5 ]; then luCode=5
    elif [ $2 = 6 ]; then luCode=6
    elif [ $2 = 7 ]; then luCode=7
    elif [ $2 = 8 ]; then luCode=8
    elif [ $2 = 9 ]; then luCode=9
    else echo "$msgReadme"; read -p "- Build Linux type: " luCode; fi
    if [ $3 = 1 ]; then shCode=1
    elif [ $3 = 2 ]; then shCode=2
    else echo "$msgReadme"; read -p "- Build shell type: " shCode; fi
elif [ $1 = 3 ]; then osCode=3
else echo "$msgReadme"; read -p "- Build OS type: " osCode
fi

if [ $osCode = 1 ]; then
    keName="Darwin"
    osName="macOS"
    shName="zsh"
    taschGenDirPath="$tacshGenDirPath/$osName"
    taschGenFilePath="$taschGenDirPath/tac.sh"
    tacshFilePath="\"$tacshDirPath/tac.sh\""
    iCloudPath="\"\$HOME/Library/Mobile Documents/com~apple~CloudDocs\""
    dropboxPath="\"\$HOME/Library/CloudStorage/Dropbox\""
elif [ $osCode = 2 ]; then keName="Linux"
    if [ -z $luCode ]; then read -p "- Build Linux type: " luCode; fi
    if [ -z $shCode ]; then read -p "- Build shell type: " shCode; fi
    if [ $luCode = 1 ]; then osName="Ubuntu"
    elif [ $luCode = 2 ]; then osName="Debain"
    elif [ $luCode = 3 ]; then osName="Fedora"
    elif [ $luCode = 4 ]; then osName="CentOS"
    elif [ $luCode = 5 ]; then osName="REHL"
    elif [ $luCode = 6 ]; then osName="SUSE"
    elif [ $luCode = 7 ]; then osName="Arch"
    elif [ $luCode = 8 ]; then osName="Kali"
    elif [ $luCode = 9 ]; then osName="Other Linux"
    else funcWrong; fi
    if [ $luCode = 9 ]; then taschGenDirPath="$tacshGenDirPath/Linux"
    else taschGenDirPath="$tacshGenDirPath/Linux/$osName"; fi
    if [ $shCode = 1 ]; then shName="zsh"
        taschGenFilePath="$taschGenDirPath/tac.zsh"
        tacshFilePath="\"$tacshDirPath/tac.zsh\""
    elif [ $shCode = 2 ]; then shName="bash"
        taschGenFilePath="$taschGenDirPath/tac.bash"
        tacshFilePath="$tacshDirPath/tac.bash"
    else funcWrong; fi
    dropboxPath="\"\$HOME/Dropbox\""
elif [ $osCode = 3 ]; then
    keName="MINGW64"
    osName="Windows"
    shName="bash"
    taschGenDirPath="$tacshGenDirPath/$osName"
    taschGenFilePath="$taschGenDirPath/tac.sh"
    tacshFilePath="\"$tacshDirPath/tac.bash\""
else
    funcWrong
fi

if [ $shName = "zsh" ]; then
    shType="zsh"
    shEnv="zshenv"
    shPf="zprofile"
    shRc="zshrc"
    shLin="zlogin"
    shLout="zlogout"
elif [ $shName = "bash" ]; then
    shType="bash"
    shEnv="bash_env"
    shPf="bash_profile"
    shRc="bashrc"
    shLin="bash_login"
    shLout="bash_logout"
fi

echo "- Selected Enironment: $osName($keName) & $shName"
funcGen
echo "- Generated tacsh file: $taschGenFilePath"
