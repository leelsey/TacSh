#!/usr/bin/env bash

tacshVer="ver 0.1"
tacshDirPath="$HOME/.config/tacsh"
if [ "$(uname)" = "Darwin" ]; then
    tacshFilePath="$tacshDirPath/tac.sh"
elif [ "$(uname)" = "Linux" ]; then
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        tacshFilePath="$tacshDirPath/tac.zsh"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        tacshFilePath="$tacshDirPath/tac.bash"
    fi
fi

funTitle() {
    echo -e "$1 ______         ______ \n$1/_  __/__ _____/ __/ / \n$1 / / / _ \`/ __/\\ \\/ _ \\ \n$1/_/  \\_,_/\\__/___/_//_/ $tacshVer \n$1\t\t\tby leelsey \n"
}

addFile() {
    echo -e $1 >> $tacshFilePath
}

funMain() {
    mkdir -p $tacshDirPath
    touch $tacshFilePath && chmod 600 $tacshFilePath
    funTitle "# " >> $tacshFilePath

    if [ "$(uname)" = "Darwin" ]; then
        iCloudPath="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
        dropboxPath="$HOME/Library/CloudStorage/Dropbox"
    elif [ "$(uname)" = "Linux" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
        dropboxPath="$HOME/Dropbox"
    fi
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        shType="zsh"
        shEnv="zshenv"
        shPf="zprofile"
        shRc="zshrc"
        shLin="zlogin"
        shLout="zlogout"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        shType="bash"
        shEnv="bash_env"
        shPf="bash_profile"
        shRc="bashrc"
        shLin="bash_login"
        shLout="bash_logout"
    fi

    # Funtional command part
    addFile "# TACTICAL COMMAND"

    # About Shell and Evironments
    addFile "## For Enviroments"
    if [ \$EUID != 0 ]; then
        addFile "  admin () { sudo -i ; } "
    fi
    addFile "shrl () { echo \"reloaded shell\" && exec -l $SHELL ; }"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "macrl () { killall SystemUIServer ; killall Dock ; killall Finder ; echo \"reloaded macOS GUI\"}"
    fi
    addFile "rlsh () {"
    addFile "  if [ -f $HOME/.$shPf ] || [ -f $HOME/.$shRc ]; then"
    addFile "    source $HOME/.$shPf && source $HOME/.$shRc ;"
    addFile "    echo \"reloaded .$shPf and .$shRc\" ;"
    addFile "  elif [ -f $HOME/.$shRc ]; then"
    addFile "    command source $HOME/.$shRc ;"
    addFile "    echo \"reloaded .$shRc\" ;"
    addFile "  elif [ -f $HOME/$shPf ]; then"
    addFile "    command source $HOME/.$shPf ;"
    addFile "    echo \"reloaded .$shPf\" ;"
    addFile "  else"
    addFile "    echo \"shrl: No environment file found\""
    addFile "  fi"
    addFile "}"
    addFile "vienv () { vi $HOME/.$shEnv ; }"
    addFile "viprofile () { vi $HOME/.$shPf ; }"
    addFile "virc () { vi $HOME/.$shRc ; }"
    addFile "vilogin () { vi $HOME/.$shLin ; }"
    addFile "vilogout () { vi $HOME/.$shLout ; }"
    addFile "whichos () { echo $(uname) ; }"
    addFile "tacsh () {"
    addFile "  if [[ \$1 == ver ]] || [[ \$1 == version ]]; then"
    addFile "    echo $tacshVer ;"
    addFile "  elif [[ \$1 == ls ]] || [[ \$1 == list ]]; then"
    addFile "    cat $tacshFilePath ;"
    addFile "  elif [[ \$1 == conf ]] || [[ \$1 == config ]] || [[ \$1 == configure ]]; then"
    addFile "    vi $tacshFilePath ;"
    addFile "  else"
    addFile "    echo \"try 'tacsh ver' or 'tacsh ls' or 'tacsh conf'\""
    addFile "  fi"
    addFile "}"

    # About Default Commands Options & Colourising
    addFile "## For Default Options with Colourising"
    if [ "$(uname)" = "Linux" ] || [[ "$(uname)" =~ "MINGW64" ]]; then 
        addFile "rm () { command rm -iv \"\$@\" ; } "
        addFile "mv () { command mv -iv \"\$@\" ; } "
        addFile "cp () { command cp -iv \"\$@\" ; } "
        addFile "ln () { command ln -iv \"\$@\" ; } "
    fi
    if [ "$(uname)" = "Darwin" ]; then
        addFile "grep () { command grep --color=auto \"\$@\" ; }"
        addFile "egrep () { command egrep --color=auto \"\$@\" ; }"
        addFile "fgrep () { command fgrep --color=auto \"\$@\" ; }"
        addFile "xzegrep () { command xzegrep --color=auto \"\$@\" ; }"
        addFile "xzfgrep () { command xzfgrep --color=auto \"\$@\" ; }"
        addFile "xzgrep () { command xzgrep --color=auto \"\$@\" ; }"
        addFile "zegrep () { command zegrep --color=auto \"\$@\" ; }"
        addFile "zfgrep () { command zfgrep --color=auto \"\$@\" ; }"
        addFile "zgrep () { command zgrep --color=auto \"\$@\" ; }"
        addFile "ls () { command ls -G \"\$@\" ; }"
        addFile "gls () { command gls --color=auto \"\$@\" ; }"
        addFile "dir () { gls -Ao --group-directories-first \"\$@\" ; }"
    elif [ "$(uname)" = "Linux" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
        if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
            addFile "grep () { command grep --color=auto \"\$@\" ; }"
            addFile "ls () { command ls --color=auto \"\$@\" ; }"
        elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
            addFile "#grep () { command grep --color=auto \"\$@\" ; }"
            addFile "#ls () { command ls --color=auto \"\$@\" ; }"
        fi
        addFile "dir () { command dir -Ao --color=auto --group-directories-first \"\$@\" ; }"
        addFile "vdir () { command vdir -Ao --color=auto --group-directories-first \"\$@\" ; }"
    fi
    if [ "$(uname)" = "Linux" ]; then
        addFile "ip () { command ip -c \"\$@\" ; }"
    fi
    addFile "tree () { command tree -C \"\$@\" ; }"

    # About Extended Command
    addFile "## For Extended Command"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "l () { ls -C \"\$@\" ; }"
        addFile "ll () { ls -l \"\$@\" ; }"
        addFile "la () { ls -A \"\$@\" ; }"
    elif [ "$(uname)" = "Linux" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
        if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
            addFile "l () { ls -C \"\$@\" ; }"
            addFile "ll () { ls -l \"\$@\" ; }"
            addFile "la () { ls -A \"\$@\" ; }"
        elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
            source /etc/os-release
            if [ "$ID" = "ubuntu" ]; then
                addFile "#l () { ls -C \"\$@\" ; }"
                addFile "#ll () { ls -l \"\$@\" ; }"
                addFile "#la () { ls -A \"\$@\" ; }"
            else
                addFile "l () { ls -C \"\$@\" ; }"
                addFile "#ll () { ls -l \"\$@\" ; }"
                addFile "la () { ls -A \"\$@\" ; }"
            fi
        fi
    fi
    addFile "ld () { ls -Cd .* \"\$@\" ; }"
    addFile "lal () { ls -Al \"\$@\" ; }"
    addFile "lla () { ls -al \"\$@\" ; }"
    addFile "llo () { ls -alO \"\$@\" ; }"
    addFile "lsf () { ls -F \"\$@\" ; }"
    addFile "lld () { ls -ld .* \"\$@\" ; }"
    addFile "lsv () { ls -alh \$@ | grep -v \"^[d|b|c|l|p|s|-]\" \"\$@\" ; }"
    addFile "ltr () { ls -lR \"\$@\" ; }"
    addFile "cl () { cd \"\$@\" && ls ; }"
    addFile "cla () { cd \"\$@\" && ls -A ; }"
    addFile "cll () { cd \"\$@\" && ls -al ; }"
    addFile "cdp () { cd \"\$@\" && pwd ; }"
    addFile "cdr () { cd /\"\$@\" ; }"
    addFile "cdh () { cd ~/\"\$@\" ; }"
    addFile "his () { history \"\$@\" ; }"
    addFile "cls () { clear ; }"
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        addFile "clh () { echo -n > ~/.zsh_history && history -p  && exec $SHELL -l; }"
        addFile "clha () { echo -n > ~/.zsh_history && history -p && rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        addFile "clh () { history -c  && exec $SHELL -l; }"
        addFile "clha () { rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }"
    fi
    if [ "$(uname)" = "Darwin" ]; then 
        addFile "clmac () {"
        addFile "  defaults delete com.apple.dock ;"
        addFile "  defaults write com.apple.dock ResetLaunchPad -bool true ;"
        addFile "  killall Dock ; echo \"reseted dock and launchpad\" ;"
        addFile "}"
        addFile "cldock () {"
        addFile "  defaults delete com.apple.dock ;"
        addFile "  killall Dock ; echo \"reseted dock\" ;"
        addFile "}"
        addFile "cllaunchpad () {"
        addFile "  defaults write com.apple.dock ResetLaunchPad -bool true ;"
        addFile "  killall Dock ; echo \"reseted launchpad\" ;"
        addFile "}"
    fi
    addFile "shdn () { sudo shutdown \"\$@\" ; } "
    addFile "shdnh () { sudo shutdown -h now ; } "
    addFile "shdnr () { sudo shutdown -r now ; } "
    addFile "vin () { vi \"+set nu\" \"\$@\" ; }"
    addFile "svi () { sudo vi \"\$@\" ; }"
    addFile "svim () { sudo vim \"\$@\" ; }"
    addFile "nvi () { nvim \"\$@\" ; }"
    addFile "snvi () { sudo nvim \"\$@\" ; }"
    addFile "snvim () { sudo nvim \"\$@\" ; }"
    addFile "pings () { ping -a \"\$@\" ; }"
    addFile "pingt () { ping -a -c 10 \"\$@\" ; }"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "pinga () { ping -a --apple-connect --apple-time \"\$@\" ; }"
        addFile "macslp () {"
        addFile "  if [ \"\$#\" -eq 1 ]; then"
        addFile "    if [[ \$1 =~ on ]]; then"
        addFile "      sudo pmset -c disablesleep 0 ;"
        addFile "    elif [[ \$1 =~ off ]]; then"
        addFile "      sudo pmset -c disablesleep 1 ;"
        addFile "    else"
        addFile "      echo \"usage: macslp on/off \" ;"        
        addFile "    fi"
        addFile "  else"
        addFile "    echo \"usage: macslp on/off \" ;"
        addFile "  fi"
        addFile "}"
        addFile "icloud () { cd '$iCloudPath' ;}"
        addFile "if [ -d $dropboxPath ]; then"
        addFile "  dropbox () { cd '$dropboxPath' ;}" 
        addFile "fi"
    elif [ "$(uname)" = "Linux" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
        addFile "if [ -d $dropboxPath ]; then"
        addFile "  dropbox () { cd '$dropboxPath' ;}" 
        addFile "fi"
    fi
    if [ "$(uname)" = "Darwin" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
        addFile "ip () { command ipconfig \"\$@\" ;  }" 
    fi
    addFile "dif () { diff \$1 \$2 | bat -l diff ; }"
    addFile "dfr () { diff -u \$1 \$2 | diffr --line-numbers ; }"
    addFile "gsdif () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | bat -l diff ; shift ; done ; }"
    addFile "gsdfr () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | diffr --line-numbers ; shift ; done ; }"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "sy () { pbcopy < \"\$1\" ; }"
        addFile "sp () { pbpaste > \"\$1\" ; }"
        addFile "pwdc () { pwd | pbcopy ; }"
    elif [ "$(uname)" = "Linux" ]; then
        addFile "sy () { xclip -selection clipboard < \"\$1\" ; }"
        addFile "sp () { xclip -selection clipboard > \"\$1\" ; }"
        addFile "pwdc () { pwd | xclip -selection clipboard ; }"
    fi
    addFile "p () {"
    addFile "  if [ \$# -eq 0 ]; then"
    addFile "    cd .. ;"
    addFile "  elif [ \$# -eq 1 ]; then"
    addFile "    if [[ \$1 =~ '^[0-9]+$' ]]; then"
    addFile "      if [[ \$1 == 0 ]]; then"
    addFile "        pwd ;"
    addFile "      else"
    addFile "        printf -v cdpFull '%*s' \$1 ;"
    addFile "        cd \"\${cdpFull// /\"../\"}\" ;"
    addFile "      fi"
    addFile "    elif [[ \$1 =~ '^[y]+$' ]]; then"
    addFile "      pwd | pbcopy ;"
    addFile "    elif [[ \$1 =~ '^[p]+$' ]]; then"
    addFile "      pwd ;"
    addFile "    elif [[ \$1 =~ '^[b]+$' ]] || [[ \$1 == - ]]; then"
    addFile "      cd - ;"
    addFile "    elif [[ \$1 =~ '^[r]+$' ]] || [[ \$1 == / ]]; then"
    addFile "      cd / ;"
    addFile "    elif [[ \$1 =~ '^[h]+$' ]] || [[ \$1 == ~ ]]; then"
    addFile "      cd ~ ;"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "    elif [[ \$1 == ap ]] || [[ \$1 == app ]] || [[ \$1 == App ]]; then"
        addFile "      cd /Applications ;"
    fi
    addFile "    elif [[ \$1 == ds ]] || [[ \$1 == des ]] || [[ \$1 == Des ]]; then"
    addFile "      cd ~/Desktop ;"
    addFile "    elif [[ \$1 == dc ]] || [[ \$1 == doc ]] || [[ \$1 == Doc ]]; then"
    addFile "      cd ~/Documents ;"
    addFile "    elif [[ \$1 == dw ]] || [[ \$1 == dow ]] || [[ \$1 == Dow ]]; then"
    addFile "      cd ~/Downloads ;"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "    elif [[ \$1 == lb ]] || [[ \$1 == lib ]] || [[ \$1 == Lib ]]; then"
        addFile "      cd ~/Library ;"
        addFile "    elif [[ \$1 == mv ]] || [[ \$1 == mov ]] || [[ \$1 == Mov ]]; then"
        addFile "      cd ~/Movies ;"
    fi
    addFile "    elif [[ \$1 == ms ]] || [[ \$1 == mus ]] || [[ \$1 == Mus ]]; then"
    addFile "      cd ~/Music ;"
    addFile "    elif [[ \$1 == pc ]] || [[ \$1 == pic ]] || [[ \$1 == Pic ]]; then"
    addFile "      cd ~/Pictures ;"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "   elif [[ \$1 == ic ]] || [[ \$1 == icl ]] || [[ \$1 == iCl ]] || [[ \$1 == cl ]] || [[ \$1 == clo ]] || [[ \$1 == Clo ]] ; then"
        addFile "      cd '$iCloudPath' ;"
    elif [ "$(uname)" = "Linux" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
        addFile "    elif [[ \$1 == vd ]] || [[ \$1 == vid ]] || [[ \$1 == Vid ]]; then"
        addFile "      cd ~/Videos ;"
    fi
    addFile "    elif [[ \$1 == dr ]] || [[ \$1 == dro ]] || [[ \$1 == Dro ]] || [[ \$1 == drp ]] || [[ \$1 == Drp ]] ; then"
    addFile "      if [ -d $dropboxPath ]; then"
    addFile "        cd '$dropboxPath' ;"
    addFile "      else"
    addFile "        echo \"p: wrong usage, try p -h\" ;"
    addFile "      fi"
    addFile "    elif [[ \$1 == --help ]] || [[ \$1 == -help ]] || [[ \$1 == -h ]]; then"
    addFile "      echo \"p: change direcotry to parent directory\""
    addFile "      echo \"p [number]: change direcotry to parent [number]th directory\""
    addFile "      echo \"p p: output current directory\""
    addFile "      echo \"p b(-): change direcotry to previous directory\""
    addFile "      echo \"p r(/): change direcotry to root directory\""    
    addFile "      echo \"p h(~): change direcotry to home directory\""
    if [ "$(uname)" = "Darwin" ]; then
        addFile "      echo \"p ap, app: change direcotry to applications directory\""
    fi
    addFile "      echo \"p ds, des: change direcotry to desktop directory\""
    addFile "      echo \"p dc, doc: change direcotry to documents directory\""
    addFile "      echo \"p dw, dow: change direcotry to downloads directory\""
    if [ "$(uname)" = "Darwin" ]; then
        addFile "      echo \"p lb, lib: change direcotry to movies directory\""
        addFile "      echo \"p mv, mov: change direcotry to movies directory\""
    fi
    addFile "      echo \"p ms, mus: change direcotry to music directory\""
    addFile "      echo \"p pc, pic: change direcotry to pictures directory\""
    if [ "$(uname)" = "Darwin" ]; then
        addFile "      echo \"p ic, cl, icl, clo: change direcotry to icloud directory\""    
    elif [ "$(uname)" = "Linux" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
        addFile "      echo \"p vd, vid: change direcotry to videos directory\""
    fi
    addFile "      echo \"p dr, dro, drp: change direcotry to dropbox directory\""
    addFile "      echo \"p -h: output usage\""
    addFile "    else"
    addFile "      echo \"p: wrong usage, try p -h\" ;"
    addFile "    fi"
    addFile "  else"
    addFile "    echo \"p: wrong usage, try p -h\" ;"
    addFile "  fi"
    addFile "}"
    addFile "jctl () {"
    addFile "  if [ \"\$#\" -eq 0 ]; then"
    addFile "    /usr/libexec/java_home -V ;"
    addFile "  elif [ \"\$#\" -eq 1 ]; then"
    addFile "    unset JAVA_HOME ;"
    addFile "    export JAVA_HOME=\$(/usr/libexec/java_home -v \"\$1\") ;"
    addFile "    java -version ;"
    addFile "  else"
    addFile "    echo \"javahome: wrong usage\""
    addFile "  fi"
    addFile "}"
    addFile "dockerun () {"
    addFile "  if ! docker info > /dev/null 2>&1; then"
    addFile "    echo \"dockerun false: Docker isn't running\""
    addFile "  else"
    addFile "    echo \"dockerun true: Docker is running\""
    addFile "  fi"
    addFile "}"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "chicn () {"
        addFile "  if [ \$# -eq 2 ]; then"
        addFile "    if [[ \"\$1\" =~ ^https?:// ]]; then"
        addFile "      curl -sLo /tmp/ic \"\$1\" ;"
        addFile "      1=/tmp/iconchange"
        addFile "    fi"
        addFile "    if ! [ -f \$1 ]; then"
        addFile "      echo \"chicn: cannot stat '\$1': No such file\""
        addFile "    elif ! [ -d \$2 ]; then"
        addFile "      echo \"chicn: cannot stat '\$2': No such directory\""
        addFile "    else"
        addFile "      sudo rm -rf \"\$2\"\$'/Icon\\\r'"
        addFile "      sips -i \"\$1\" > /dev/null"
        addFile "      DeRez -only icns \"\$1\" > /tmp/icnch.rsrc"
        addFile "      sudo Rez -append /tmp/icnch.rsrc -o \"\$2\"\$'/Icon\\\r'"
        addFile "      sudo SetFile -a C \"\$2\""
        addFile "      sudo SetFile -a V \"\$2\"\$'/Icon\\\r'"
        addFile "    fi"
        addFile "    rm -rf /tmp/icnch /tmp/icnch.rsrc"
        addFile " else"
        addFile "   echo \"chicn: wrong usage\""
        addFile " fi"
        addFile "}"
    fi

    # Alias command part
    if [ "$(uname)" = "Linux" ]; then
        addFile "\n# ALIAS COMMAND"
        addFile "alias iptables='sudo iptables'    # legacy of nefirewall management tool"
        source /etc/os-release
        if [ "$ID" = "ubuntu" ]; then
            addFile "alias ufw='sudo ufw'               # firewall management tool: ufw (uncomplicated firewall)"
            addFile "alias apt='sudo apt'               # for debian-based family"
            addFile "alias apt-get='sudo apt-get'       # legacy of debian-based family"
        elif [ "$ID" = "debian" ]; then
            addFile "alias nft='sudo nft'               # firewall management tool: nftables (netfilter table)"
            addFile "alias apt='sudo apt'               # for debian-based family"
            addFile "alias apt-get='sudo apt-get'       # legacy of debian-based family"
        elif [ "$ID" = "fedora" ] || [ "$ID" = "centos" ] || [ "$ID" = "rhel" ]; then
            addFile "alias firewall='sudo firewall-cmd' # firewall management tool: firewall"
            addFile "alias dnf='sudo dnf'               # for redhat-based family"
            addFile "alias yum='sudo yum'               # legacy of redhat-based family"
        elif [ "$ID" = "arch" ]; then
            addFile "alias pacman='sudo pacman'         # for arch-based family"
        elif [ "$ID" = "opensuse" ]; then
            addFile "alias zypper='sudo zypper'         # for suse-based family"
        fi
    fi

    # Disabed funtional/alias command part
    if [ "$(uname)" = "Linux" ]; then
        addFile "\n# OPTIONAL COMMAND"
        source /etc/os-release
        if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ] || [ "$ID" = "fedora" ] || [ "$ID" = "centos" ] || [ "$ID" = "rhel" ] || [ "$ID" = "arch" ] || [ "$ID" = "opensuse" ]; then
            addFile "#rmdir () { command rmdir -v \"\$@\" ; } "
            addFile "#mkdir () { command mkdir -v \"\$@\" ; } "
            addFile "#chmod () { command chmod --preserve-root \"\$@\" ; }"
            addFile "#chown () { command chown --preserve-root \"\$@\" ; }"
            addFile "#chgrp () { command chgrp --preserve-root \"\$@\" ; }"
            addFile "#vi () { command vim \"\$@\" ; }"
            addFile "#emcs () { emacs \"\$@\" ; }"
            addFile "#semcs () { sudo emacs \"\$@\" ; }"
            addFile "#semacs () { sudo emacs \"\$@\" ; }"
            addFile "#dfh () { df -h \"\$@\" ; }"
            addFile "#duh () { du -h \"\$@\" ; }"
            addFile "#alias vi='vim'"
            addFile "#alias top='htop'"
            addFile "#alias wget='wget -c'"
            addFile "#alias curl='curl -w \"\\\n\"'"
            addFile "#alias da='date'"
            addFile "#alias ca='cal'"
            addFile "#alias c='clear'"
            addFile "#alias f='finger'"
            addFile "#alias j='jobs -l'"
            addFile "#alias bc='bc -l'"
        else
            addFile "#alias nft='sudo nft'              # firewall management tool: nftables (netfilter table)"
            addFile "#alias ufw='sudo ufw'              # firewall management tool: ufw (uncomplicated firewall)"
            addFile "#alias firewall='sudo firewall-cmd'# firewall management tool: firewall"
            addFile "#alias apt='sudo apt'              # for debian-based family"
            addFile "#alias apt-get='sudo apt-get'      # legacy of debian-based family"
            addFile "#alias dnf='sudo dnf'              # for redhat-based family"
            addFile "#alias yum='sudo yum'              # legacy of redhat-based family"
            addFile "#alias pacman='sudo pacman'        # for arch-based family"
            addFile "#alias zypper='sudo zypper'        # for suse-based family"
        fi
    fi
}


# MAIN
funTitle ""
echo -e "- Check your shell type ... \c"
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ] || [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    echo -e "OK \n- Check your OS type ... \c"
    if [ "$(uname)" = "Darwin" ] || [ "$(uname)" = "Linux" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
        echo -e "OK "
        if [ "$(uname)" = "Darwin" ]; then
            profileName=".zprofile"
        elif [ "$(uname)" = "Linux" ]; then
            if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
                profileName=".zshrc"
            elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
                profileName=".bashrc"
            fi
        elif [[ "$(uname)" =~ "MINGW64" ]]; then
            profileName=".bashrc"
        fi
        if ! [ -f "$tacshFilePath" ]; then
            echo -e "- Installing TacSh ... \c"
            funMain
            echo -e "OK \n- Add on $profileName file ... \c"
            echo -e "\n# TacSh\nsource $tacshFilePath\n" >> $HOME/$profileName
            echo -e "OK \n\nFinish"
            echo -e "• Try \"source ~/$profileName\" or restart Terminal to load the TacSh.\n"
        elif [ -f "$tacshFilePath" ]; then
            echo -e "- Renstall TacSh ... \c"
            rm -f $tacshFilePath
            funMain
            echo -e "OK \n\nFinish"
            echo -e " • Restart your shell use \"shrl\" or \"source ~/$profileName\""
            echo -e " • If not work, check \"source $tacshFilePath\" code in \"$profileName\".\n"
        else
            echo -e "NO \n • Someting wrong. Please check persmission or file path."
        fi
    else
        echo -e "NO \n • Sorry, this OS isn't support OS. Only supoort macOS and Linux.\n"
    fi
else
    echo -e "NO \n • Sorry, this sehll isn't support. Only support Bash and Zsh."
fi
