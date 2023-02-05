#!/usr/bin/env bash

tacshVer="ver 0.1"
tacshGenDirPath="./src"
taschGenFilePath="$tacshGenDirPath/tacshgen.sh"
tacshDirPath="\$HOME/.config/tacsh"

funcTitle() {
    echo -e "$1 ______         ______ \n$1/_  __/__ _____/ __/ / \n$1 / / / _ \`/ __/\\ \\/ _ \\ \n$1/_/  \\_,_/\\__/___/_//_/ $tacshVer \n$1\t\t\tby leelsey \n"
}
funcTitle ""

read -p "- Build Env (1: macOS, 2: Linux, 3: Windows):" osCode
if [ $osCode = 1 ]; then
    osName="Darwin"
    shName="zsh"
    tacshFilePath="$tacshDirPath/tac.sh"
    iCloudPath="\$HOME/Library/Mobile Documents/com~apple~CloudDocs"
    dropboxPath="\$HOME/Library/CloudStorage/Dropbox"
elif [ $osCode = 2 ]; then
    osName="Linux"
    read -p shCode "Shell (1: zsh, 2: bash):"
    if [ $shCode = 1 ]; then
        shName="zsh"
        tacshFilePath="$tacshDirPath/tac.zsh"
    elif [ $shCode = 2 ]; then
        shName="bash"
        tacshFilePath="$tacshDirPath/tac.bash"
    fi
    dropboxPath="\$HOME/Dropbox"
elif [ $osCode = 3 ]; then
    osName="MINGW64"
    shName="bash"
    tacshFilePath="$tacshDirPath/tac.bash"
else
    echo "Choose 1, 2 or 3."
    exit 1
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

funNewFile() {
    mkdir -p $tacshGenDirPath
    touch $taschGenFilePath && chmod 600 $taschGenFilePath
    funcTitle "# " >> $taschGenFilePath
}

funcAddFile() {
    echo -e $1 >> $taschGenFilePath
}


funcGen() {
    if [ -f $taschGenFilePath ]; then
        rm -rf $taschGenFilePath
    fi
    funNewFile

    # Funtional command part
    funcAddFile "\n# TACTICAL COMMAND"

    # About Shell and Evironments
    funcAddFile "## For Enviroments"
    if [ \$EUID != 0 ]; then
        funcAddFile "  admin () { sudo -i ; } "
    fi
    funcAddFile "shrl () { echo \"reloaded shell\" && exec -l $SHELL ; }"
    if [ osName = "Darwin" ]; then
        funcAddFile "macrl () { killall SystemUIServer ; killall Dock ; killall Finder ; echo \"reloaded macOS GUI\"}"
    fi
    funcAddFile "rlsh () {"
    funcAddFile "  if [ -f \$HOME/.$shPf ] || [ -f \$HOME/.$shRc ]; then"
    funcAddFile "    source \$HOME/.$shPf && source \$HOME/.$shRc ;"
    funcAddFile "    echo \"reloaded .$shPf and .$shRc\" ;"
    funcAddFile "  elif [ -f \$HOME/.$shRc ]; then"
    funcAddFile "    command source \$HOME/.$shRc ;"
    funcAddFile "    echo \"reloaded .$shRc\" ;"
    funcAddFile "  elif [ -f \$HOME/$shPf ]; then"
    funcAddFile "    command source \$HOME/.$shPf ;"
    funcAddFile "    echo \"reloaded .$shPf\" ;"
    funcAddFile "  else"
    funcAddFile "    echo \"shrl: No environment file found\""
    funcAddFile "  fi"
    funcAddFile "}"
    funcAddFile "vienv () { vi \$HOME/.$shEnv ; }"
    funcAddFile "viprofile () { vi \$HOME/.$shPf ; }"
    funcAddFile "virc () { vi \$HOME/.$shRc ; }"
    funcAddFile "vilogin () { vi \$HOME/.$shLin ; }"
    funcAddFile "vilogout () { vi \$HOME/.$shLout ; }"
    funcAddFile "whichos () { echo $(uname) ; }"
    funcAddFile "tacsh () {"
    funcAddFile "  if [[ \$1 == ver ]] || [[ \$1 == version ]]; then"
    funcAddFile "    echo $tacshVer ;"
    funcAddFile "  elif [[ \$1 == ls ]] || [[ \$1 == list ]]; then"
    funcAddFile "    cat $tacshFilePath ;"
    funcAddFile "  elif [[ \$1 == conf ]] || [[ \$1 == config ]] || [[ \$1 == configure ]]; then"
    funcAddFile "    vi $tacshFilePath ;"
    funcAddFile "  else"
    funcAddFile "    echo \"try 'tacsh ver' or 'tacsh ls' or 'tacsh conf'\""
    funcAddFile "  fi"
    funcAddFile "}"

    # About Default Commands Options & Colourising
    funcAddFile "## For Default Options with Colourising"
    if [ $osName = "Linux" ] || [[ $osName =~ "MINGW64" ]]; then 
        funcAddFile "rm () { command rm -iv \"\$@\" ; } "
        funcAddFile "mv () { command mv -iv \"\$@\" ; } "
        funcAddFile "cp () { command cp -iv \"\$@\" ; } "
        funcAddFile "ln () { command ln -iv \"\$@\" ; } "
    fi
    if [ $osName = "Darwin" ]; then
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
    elif [ $osName = "Linux" ] || [[ $osName =~ "MINGW64" ]]; then
        if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
            funcAddFile "grep () { command grep --color=auto \"\$@\" ; }"
            funcAddFile "ls () { command ls --color=auto \"\$@\" ; }"
        elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
            funcAddFile "#grep () { command grep --color=auto \"\$@\" ; }"
            funcAddFile "#ls () { command ls --color=auto \"\$@\" ; }"
        fi
        funcAddFile "dir () { command dir -Ao --color=auto --group-directories-first \"\$@\" ; }"
        funcAddFile "vdir () { command vdir -Ao --color=auto --group-directories-first \"\$@\" ; }"
    fi
    if [ $osName = "Linux" ]; then
        funcAddFile "ip () { command ip -c \"\$@\" ; }"
    fi
    funcAddFile "tree () { command tree -C \"\$@\" ; }"

    # About Extended Command
    funcAddFile "## For Extended Command"
    if [ $osName = "Darwin" ]; then
        funcAddFile "l () { ls -C \"\$@\" ; }"
        funcAddFile "ll () { ls -l \"\$@\" ; }"
        funcAddFile "la () { ls -A \"\$@\" ; }"
    elif [ $osName = "Linux" ] || [[ $osName =~ "MINGW64" ]]; then
        if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
            funcAddFile "l () { ls -C \"\$@\" ; }"
            funcAddFile "ll () { ls -l \"\$@\" ; }"
            funcAddFile "la () { ls -A \"\$@\" ; }"
        elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
            source /etc/os-release
            if [ "$ID" = "ubuntu" ]; then
                funcAddFile "#l () { ls -C \"\$@\" ; }"
                funcAddFile "#ll () { ls -l \"\$@\" ; }"
                funcAddFile "#la () { ls -A \"\$@\" ; }"
            else
                funcAddFile "l () { ls -C \"\$@\" ; }"
                funcAddFile "#ll () { ls -l \"\$@\" ; }"
                funcAddFile "la () { ls -A \"\$@\" ; }"
            fi
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
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        funcAddFile "clh () { echo -n > ~/.zsh_history && history -p  && exec $SHELL -l; }"
        funcAddFile "clha () { echo -n > ~/.zsh_history && history -p && rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        funcAddFile "clh () { history -c  && exec $SHELL -l; }"
        funcAddFile "clha () { rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }"
    fi
    if [ $osName = "Darwin" ]; then 
        funcAddFile "clmac () {"
        funcAddFile "  defaults delete com.apple.dock ;"
        funcAddFile "  defaults write com.apple.dock ResetLaunchPad -bool true ;"
        funcAddFile "  killall Dock ; echo \"reseted dock and launchpad\" ;"
        funcAddFile "}"
        funcAddFile "cldock () {"
        funcAddFile "  defaults delete com.apple.dock ;"
        funcAddFile "  killall Dock ; echo \"reseted dock\" ;"
        funcAddFile "}"
        funcAddFile "cllaunchpad () {"
        funcAddFile "  defaults write com.apple.dock ResetLaunchPad -bool true ;"
        funcAddFile "  killall Dock ; echo \"reseted launchpad\" ;"
        funcAddFile "}"
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
    if [ $osName = "Darwin" ]; then
        funcAddFile "pinga () { ping -a --apple-connect --apple-time \"\$@\" ; }"
        funcAddFile "macslp () {"
        funcAddFile "  if [ \"\$#\" -eq 1 ]; then"
        funcAddFile "    if [[ \$1 =~ on ]]; then"
        funcAddFile "      sudo pmset -c disablesleep 0 ;"
        funcAddFile "    elif [[ \$1 =~ off ]]; then"
        funcAddFile "      sudo pmset -c disablesleep 1 ;"
        funcAddFile "    else"
        funcAddFile "      echo \"usage: macslp on/off \" ;"        
        funcAddFile "    fi"
        funcAddFile "  else"
        funcAddFile "    echo \"usage: macslp on/off \" ;"
        funcAddFile "  fi"
        funcAddFile "}"
        funcAddFile "icloud () { cd '$iCloudPath' ;}"
        funcAddFile "if [ -d $dropboxPath ]; then"
        funcAddFile "  dropbox () { cd '$dropboxPath' ;}" 
        funcAddFile "fi"
    elif [ $osName = "Linux" ] || [[ $osName =~ "MINGW64" ]]; then
        funcAddFile "if [ -d $dropboxPath ]; then"
        funcAddFile "  dropbox () { cd '$dropboxPath' ;}" 
        funcAddFile "fi"
    fi
    if [ $osName = "Darwin" ] || [[ $osName =~ "MINGW64" ]]; then
        funcAddFile "ip () { command ipconfig \"\$@\" ;  }" 
    fi
    funcAddFile "dif () { diff \$1 \$2 | bat -l diff ; }"
    funcAddFile "dfr () { diff -u \$1 \$2 | diffr --line-numbers ; }"
    funcAddFile "gsdif () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | bat -l diff ; shift ; done ; }"
    funcAddFile "gsdfr () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | diffr --line-numbers ; shift ; done ; }"
    if [ $osName = "Darwin" ]; then
        funcAddFile "sy () { pbcopy < \"\$1\" ; }"
        funcAddFile "sp () { pbpaste > \"\$1\" ; }"
        funcAddFile "pwdc () { pwd | pbcopy ; }"
    elif [ $osName = "Linux" ]; then
        funcAddFile "sy () { xclip -selection clipboard < \"\$1\" ; }"
        funcAddFile "sp () { xclip -selection clipboard > \"\$1\" ; }"
        funcAddFile "pwdc () { pwd | xclip -selection clipboard ; }"
    fi
    funcAddFile "p () {"
    funcAddFile "  if [ \$# -eq 0 ]; then"
    funcAddFile "    cd .. ;"
    funcAddFile "  elif [ \$# -eq 1 ]; then"
    funcAddFile "    if [[ \$1 =~ '^[0-9]+$' ]]; then"
    funcAddFile "      if [[ \$1 == 0 ]]; then"
    funcAddFile "        pwd ;"
    funcAddFile "      else"
    funcAddFile "        printf -v cdpFull '%*s' \$1 ;"
    funcAddFile "        cd \"\${cdpFull// /\"../\"}\" ;"
    funcAddFile "      fi"
    funcAddFile "    elif [[ \$1 =~ '^[y]+$' ]]; then"
    funcAddFile "      pwd | pbcopy ;"
    funcAddFile "    elif [[ \$1 =~ '^[p]+$' ]]; then"
    funcAddFile "      pwd ;"
    funcAddFile "    elif [[ \$1 =~ '^[b]+$' ]] || [[ \$1 == - ]]; then"
    funcAddFile "      cd - ;"
    funcAddFile "    elif [[ \$1 =~ '^[r]+$' ]] || [[ \$1 == / ]]; then"
    funcAddFile "      cd / ;"
    funcAddFile "    elif [[ \$1 =~ '^[h]+$' ]] || [[ \$1 == ~ ]]; then"
    funcAddFile "      cd ~ ;"
    if [ $osName = "Darwin" ]; then
        funcAddFile "    elif [[ \$1 == ap ]] || [[ \$1 == app ]] || [[ \$1 == App ]]; then"
        funcAddFile "      cd /Applications ;"
    fi
    funcAddFile "    elif [[ \$1 == ds ]] || [[ \$1 == des ]] || [[ \$1 == Des ]]; then"
    funcAddFile "      cd ~/Desktop ;"
    funcAddFile "    elif [[ \$1 == dc ]] || [[ \$1 == doc ]] || [[ \$1 == Doc ]]; then"
    funcAddFile "      cd ~/Documents ;"
    funcAddFile "    elif [[ \$1 == dw ]] || [[ \$1 == dow ]] || [[ \$1 == Dow ]]; then"
    funcAddFile "      cd ~/Downloads ;"
    if [ $osName = "Darwin" ]; then
        funcAddFile "    elif [[ \$1 == lb ]] || [[ \$1 == lib ]] || [[ \$1 == Lib ]]; then"
        funcAddFile "      cd ~/Library ;"
        funcAddFile "    elif [[ \$1 == mv ]] || [[ \$1 == mov ]] || [[ \$1 == Mov ]]; then"
        funcAddFile "      cd ~/Movies ;"
    fi
    funcAddFile "    elif [[ \$1 == ms ]] || [[ \$1 == mus ]] || [[ \$1 == Mus ]]; then"
    funcAddFile "      cd ~/Music ;"
    funcAddFile "    elif [[ \$1 == pc ]] || [[ \$1 == pic ]] || [[ \$1 == Pic ]]; then"
    funcAddFile "      cd ~/Pictures ;"
    if [ $osName = "Darwin" ]; then
        funcAddFile "   elif [[ \$1 == ic ]] || [[ \$1 == icl ]] || [[ \$1 == iCl ]] || [[ \$1 == cl ]] || [[ \$1 == clo ]] || [[ \$1 == Clo ]] ; then"
        funcAddFile "      cd '$iCloudPath' ;"
    elif [ $osName = "Linux" ] || [[ $osName =~ "MINGW64" ]]; then
        funcAddFile "    elif [[ \$1 == vd ]] || [[ \$1 == vid ]] || [[ \$1 == Vid ]]; then"
        funcAddFile "      cd ~/Videos ;"
    fi
    funcAddFile "    elif [[ \$1 == dr ]] || [[ \$1 == dro ]] || [[ \$1 == Dro ]] || [[ \$1 == drp ]] || [[ \$1 == Drp ]] ; then"
    funcAddFile "      if [ -d $dropboxPath ]; then"
    funcAddFile "        cd '$dropboxPath' ;"
    funcAddFile "      else"
    funcAddFile "        echo \"p: wrong usage, try p -h\" ;"
    funcAddFile "      fi"
    funcAddFile "    elif [[ \$1 == --help ]] || [[ \$1 == -help ]] || [[ \$1 == -h ]]; then"
    funcAddFile "      echo \"p: change direcotry to parent directory\""
    funcAddFile "      echo \"p [number]: change direcotry to parent [number]th directory\""
    funcAddFile "      echo \"p p: output current directory\""
    funcAddFile "      echo \"p b(-): change direcotry to previous directory\""
    funcAddFile "      echo \"p r(/): change direcotry to root directory\""    
    funcAddFile "      echo \"p h(~): change direcotry to home directory\""
    if [ $osName = "Darwin" ]; then
        funcAddFile "      echo \"p ap, app: change direcotry to applications directory\""
    fi
    funcAddFile "      echo \"p ds, des: change direcotry to desktop directory\""
    funcAddFile "      echo \"p dc, doc: change direcotry to documents directory\""
    funcAddFile "      echo \"p dw, dow: change direcotry to downloads directory\""
    if [ $osName = "Darwin" ]; then
        funcAddFile "      echo \"p lb, lib: change direcotry to movies directory\""
        funcAddFile "      echo \"p mv, mov: change direcotry to movies directory\""
    fi
    funcAddFile "      echo \"p ms, mus: change direcotry to music directory\""
    funcAddFile "      echo \"p pc, pic: change direcotry to pictures directory\""
    if [ $osName = "Darwin" ]; then
        funcAddFile "      echo \"p ic, cl, icl, clo: change direcotry to icloud directory\""    
    elif [ $osName = "Linux" ] || [[ $osName =~ "MINGW64" ]]; then
        funcAddFile "      echo \"p vd, vid: change direcotry to videos directory\""
    fi
    funcAddFile "      echo \"p dr, dro, drp: change direcotry to dropbox directory\""
    funcAddFile "      echo \"p -h: output usage\""
    funcAddFile "    else"
    funcAddFile "      echo \"p: wrong usage, try p -h\" ;"
    funcAddFile "    fi"
    funcAddFile "  else"
    funcAddFile "    echo \"p: wrong usage, try p -h\" ;"
    funcAddFile "  fi"
    funcAddFile "}"
    funcAddFile "jctl () {"
    funcAddFile "  if [ \"\$#\" -eq 0 ]; then"
    funcAddFile "    /usr/libexec/java_home -V ;"
    funcAddFile "  elif [ \"\$#\" -eq 1 ]; then"
    funcAddFile "    unset JAVA_HOME ;"
    funcAddFile "    export JAVA_HOME=\$(/usr/libexec/java_home -v \"\$1\") ;"
    funcAddFile "    java -version ;"
    funcAddFile "  else"
    funcAddFile "    echo \"javahome: wrong usage\""
    funcAddFile "  fi"
    funcAddFile "}"
    funcAddFile "dockerun () {"
    funcAddFile "  if ! docker info > /dev/null 2>&1; then"
    funcAddFile "    echo \"dockerun false: Docker isn't running\""
    funcAddFile "  else"
    funcAddFile "    echo \"dockerun true: Docker is running\""
    funcAddFile "  fi"
    funcAddFile "}"
    if [ $osName = "Darwin" ]; then
        funcAddFile "chicn () {"
        funcAddFile "  if [ \$# -eq 2 ]; then"
        funcAddFile "    if [[ \"\$1\" =~ ^https?:// ]]; then"
        funcAddFile "      curl -sLo /tmp/ic \"\$1\" ;"
        funcAddFile "      1=/tmp/iconchange"
        funcAddFile "    fi"
        funcAddFile "    if ! [ -f \$1 ]; then"
        funcAddFile "      echo \"chicn: cannot stat '\$1': No such file\""
        funcAddFile "    elif ! [ -d \$2 ]; then"
        funcAddFile "      echo \"chicn: cannot stat '\$2': No such directory\""
        funcAddFile "    else"
        funcAddFile "      sudo rm -rf \"\$2\"\$'/Icon\\\r'"
        funcAddFile "      sips -i \"\$1\" > /dev/null"
        funcAddFile "      DeRez -only icns \"\$1\" > /tmp/icnch.rsrc"
        funcAddFile "      sudo Rez -append /tmp/icnch.rsrc -o \"\$2\"\$'/Icon\\\r'"
        funcAddFile "      sudo SetFile -a C \"\$2\""
        funcAddFile "      sudo SetFile -a V \"\$2\"\$'/Icon\\\r'"
        funcAddFile "    fi"
        funcAddFile "    rm -rf /tmp/icnch /tmp/icnch.rsrc"
        funcAddFile " else"
        funcAddFile "   echo \"chicn: wrong usage\""
        funcAddFile " fi"
        funcAddFile "}"
    fi

    # Alias command part
    if [ $osName = "Linux" ]; then
        funcAddFile "\n# ALIAS COMMAND"
        funcAddFile "alias iptables='sudo iptables'    # legacy of nefirewall management tool"
        source /etc/os-release
        if [ "$ID" = "ubuntu" ]; then
            funcAddFile "alias ufw='sudo ufw'               # firewall management tool: ufw (uncomplicated firewall)"
            funcAddFile "alias apt='sudo apt'               # for debian-based family"
            funcAddFile "alias apt-get='sudo apt-get'       # legacy of debian-based family"
        elif [ "$ID" = "debian" ]; then
            funcAddFile "alias nft='sudo nft'               # firewall management tool: nftables (netfilter table)"
            funcAddFile "alias apt='sudo apt'               # for debian-based family"
            funcAddFile "alias apt-get='sudo apt-get'       # legacy of debian-based family"
        elif [ "$ID" = "fedora" ] || [ "$ID" = "centos" ] || [ "$ID" = "rhel" ]; then
            funcAddFile "alias firewall='sudo firewall-cmd' # firewall management tool: firewall"
            funcAddFile "alias dnf='sudo dnf'               # for redhat-based family"
            funcAddFile "alias yum='sudo yum'               # legacy of redhat-based family"
        elif [ "$ID" = "arch" ]; then
            funcAddFile "alias pacman='sudo pacman'         # for arch-based family"
        elif [ "$ID" = "opensuse" ]; then
            funcAddFile "alias zypper='sudo zypper'         # for suse-based family"
        fi
    fi

    # Disabed funtional/alias command part
    if [ $osName = "Linux" ]; then
        funcAddFile "\n# OPTIONAL COMMAND"
        source /etc/os-release
        if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ] || [ "$ID" = "fedora" ] || [ "$ID" = "centos" ] || [ "$ID" = "rhel" ] || [ "$ID" = "arch" ] || [ "$ID" = "opensuse" ]; then
            funcAddFile "#rmdir () { command rmdir -v \"\$@\" ; } "
            funcAddFile "#mkdir () { command mkdir -v \"\$@\" ; } "
            funcAddFile "#chmod () { command chmod --preserve-root \"\$@\" ; }"
            funcAddFile "#chown () { command chown --preserve-root \"\$@\" ; }"
            funcAddFile "#chgrp () { command chgrp --preserve-root \"\$@\" ; }"
            funcAddFile "#vi () { command vim \"\$@\" ; }"
            funcAddFile "#emcs () { emacs \"\$@\" ; }"
            funcAddFile "#semcs () { sudo emacs \"\$@\" ; }"
            funcAddFile "#semacs () { sudo emacs \"\$@\" ; }"
            funcAddFile "#dfh () { df -h \"\$@\" ; }"
            funcAddFile "#duh () { du -h \"\$@\" ; }"
            funcAddFile "#alias vi='vim'"
            funcAddFile "#alias top='htop'"
            funcAddFile "#alias wget='wget -c'"
            funcAddFile "#alias curl='curl -w \"\\\n\"'"
            funcAddFile "#alias da='date'"
            funcAddFile "#alias ca='cal'"
            funcAddFile "#alias c='clear'"
            funcAddFile "#alias f='finger'"
            funcAddFile "#alias j='jobs -l'"
            funcAddFile "#alias bc='bc -l'"
        else
            funcAddFile "#alias nft='sudo nft'              # firewall management tool: nftables (netfilter table)"
            funcAddFile "#alias ufw='sudo ufw'              # firewall management tool: ufw (uncomplicated firewall)"
            funcAddFile "#alias firewall='sudo firewall-cmd'# firewall management tool: firewall"
            funcAddFile "#alias apt='sudo apt'              # for debian-based family"
            funcAddFile "#alias apt-get='sudo apt-get'      # legacy of debian-based family"
            funcAddFile "#alias dnf='sudo dnf'              # for redhat-based family"
            funcAddFile "#alias yum='sudo yum'              # legacy of redhat-based family"
            funcAddFile "#alias pacman='sudo pacman'        # for arch-based family"
            funcAddFile "#alias zypper='sudo zypper'        # for suse-based family"
        fi
    fi
}


echo "- Generating tacsh file"
funcGen
echo " • Finish, check the file in ./src/tacsh.sh"