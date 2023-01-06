#!/usr/bin/env bash

tacshVer="ver 0.1"
tacshDirPath="$HOME/.config/tacsh"
tacshFilePath="$tacshDirPath/tac.sh"

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
        icloudPath="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
        dropboxPath="$HOME/Library/CloudStorage/Dropbox"
    elif [ "$(uname)" = "Linux" ]; then
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
    addFile "zshrl () {"
    addFile "  if [ -f $HOME/.zprofile ] || [ -f $HOME/.zshrc ]; then"
    addFile "    source $HOME/.zprofile && source $HOME/.zshrc ;"
    addFile "    echo \"reloaded zprofile and zshrc\" ;"
    addFile "  elif [ -f $HOME/.zshrc ]; then"
    addFile "    command source $HOME/.zshrc ;"
    addFile "    echo \"reloaded zshrc\" ;"
    addFile "  elif [ -f $HOME/.zprofile ]; then"
    addFile "    command source $HOME/.zprofile ;"
    addFile "    echo \"reloaded zprofile\" ;"
    addFile "  else"
    addFile "    echo \"shrl: No environment file found\""
    addFile "  fi"
    addFile "}"
    addFile "vi$shEnv () { vi $HOME/.$shEnv ; }"
    addFile "vi$shPf () { vi $HOME/.$shPf ; }"
    addFile "vi$shRc () { vi $HOME/.$shRc ; }"
    addFile "vi$shLin () { vi $HOME/.$shLin ; }"
    addFile "vi$shLout () { vi $HOME/.$shLout ; }"
    addFile "vitacsh () { vi $tacshFilePath ; }"
    addFile "whichos () { echo $(uname) ; }"
    
    # About Default Commands Options & Colourising
    addFile "## For Default Options"
    addFile "rm () { command rm -I \"\$@\" ; } "
    addFile "mv () { command mv -i \"\$@\" ; } "
    addFile "cp () { command cp -i \"\$@\" ; } "
    addFile "ln () { command ln -i \"\$@\" ; } "
    addFile "## For Colourising"
    addFile "ls () { command ls --color=auto \"\$@\" ; }"
    if [ "$(uname)" = "Linux" ]; then
        addFile "dir () { command dir --color=auto \"\$@\" ; }"
        addFile "vdir () { command vdir --color=auto \"\$@\" ; }"
        addFile "ip () { command ip -c \"\$@\" ; }"
    fi
    addFile "tree () { command tree -C \"\$@\" ; }"
    addFile "grep () { command grep --color=auto \"\$@\" ; }"
    addFile "egrep () { command egrep --color=auto \"\$@\" ; }"
    addFile "fgrep () { command fgrep --color=auto \"\$@\" ; }"
    addFile "xzegrep () { command xzegrep --color=auto \"\$@\" ; }"
    addFile "xzfgrep () { command xzfgrep --color=auto \"\$@\" ; }"
    addFile "xzgrep () { command xzgrep --color=auto \"\$@\" ; }"
    addFile "zegrep () { command zegrep --color=auto \"\$@\" ; }"
    addFile "zfgrep () { command zfgrep --color=auto \"\$@\" ; }"
    addFile "zgrep () { command zgrep --color=auto \"\$@\" ; }"

    # About Extended Command
    addFile "## For Extended Command"
    addFile "l () { ls -C \"\$@\" ; }"
    addFile "l. () { ls -Cd .* \"\$@\" ; }"
    addFile "ll () { ls -l \"\$@\" ; }"
    addFile "ll. () { ls -ld .* \"\$@\" ; }"
    addFile "la () { ls -A \"\$@\" ; }"
    addFile "lal () { ls -Al \"\$@\" ; }"
    addFile "lla () { ls -al \"\$@\" ; }"
    addFile "lsf () { ls -F \"\$@\" ; }"
    addFile "lst () { ls -alh \$@ | grep -v \"^[d|b|c|l|p|s|-]\" \"\$@\" ; }"
    addFile "ltr () { ls -lR \"\$@\" ; }"
    addFile "cdr () { cd /\"\$@\" ; }"
    addFile "cdh () { cd ~/\"\$@\" ; }"
    addFile "cdl () { cd \"\$@\" | ls -A ; }"
    addFile "cdla () { cd \"\$@\" | ls -al ; }"
    addFile "his () { history \"\$@\" ; }"
    addFile "cls () { clear ; }"
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        addFile "clh () { echo -n > ~/.zsh_history && history -p  && exec $SHELL -l; }"
        addFile "clha () { echo -n > ~/.zsh_history && history -p && rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        addFile "clh () { history -c  && exec $SHELL -l; }"
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
        addFile "ip () { command ipconfig \"\$@\" ;  }"
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
        addFile "iCloud () { cd '$iCloudPath' ;}"
        addFile "icloud () { cd '$iCloudPath' ;}"
        addFile "if [ -d $macDropboxPath ]; then"
        addFile "  Dropbox () { cd '$macDropboxPath' ;}"
        addFile "  dropbox () { cd '$macDropboxPath' ;}" 
        addFile "fi"
    elif [ "$(uname)" = "Linux" ]; then
        addFile "if [ -d $linuxDropboxPath ]; then"
        addFile "  Dropbox () { cd '$linuxDropboxPath' ;}"
        addFile "  dropbox () { cd '$linuxDropboxPath' ;}" 
        addFile "fi"
    fi
    addFile "dif () { diff \$1 \$2 | bat -l diff ; }"
    addFile "dfr () { diff -u \$1 \$2 | diffr --line-numbers ; }"
    addFile "gsdif () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | bat -l diff ; shift ; done ; }"
    addFile "gsdfr () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | diffr --line-numbers ; shift ; done ; }"
    if [ "$(uname)" = "Darwin" ]; then
        addFile "shy () { pbcopy < \"\$1\" ; }"
        addFile "shp () { pbpaste > \"\$1\" ; }"
        addFile "pwdc () { pbcopy < \"\$1\" ; }"
    elif [ "$(uname)" = "Linux" ]; then
        addFile "shy () { xclip -selection clipboard < \"\$1\" ; }"
        addFile "shp () { xclip -selection clipboard > \"\$1\" ; }"
    fi
    addFile "p () {"
    addFile "  if [ \$# -eq 0 ]; then"
    addFile "    cd ..;"
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
    elif [ "$(uname)" = "Linux" ]; then
        addFile "    elif [[ \$1 == vd ]] || [[ \$1 == vid ]] || [[ \$1 == Vid ]]; then"
        addFile "      cd ~/Videos ;"
    fi
    addFile "    elif [[ \$1 == dr ]] || [[ \$1 == dro ]] || [[ \$1 == Dro ]] || [[ \$1 == drp ]] || [[ \$1 == Drp ]] ; then"
    addFile "      if [ -d $macDropboxPath ]; then"
    addFile "        cd '$macDropboxPath' ;"
    addFile "      elsle"
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
    elif [ "$(uname)" = "Linux" ]; then
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
    addFile "dockerun () {"
    addFile "  if ! docker info > /dev/null 2>&1; then"
    addFile "    echo \"dockerun false: Docker isn't running\""
    addFile "  else"
    addFile "    echo \"dockerun true: Docker is running\""
    addFile "  fi"
    addFile "}"


    # Alias command part
    addFile "\n# ALIAS COMMAND"
    addFile "alias da='date'"
    addFile "alias ca='cal'"
    addFile "alias c='clear'"
    addFile "alias f='finger'"
    addFile "alias j='jobs -l'"
    addFile "alias bc='bc -l'"
    
    
    # Disabed alias command part
    addFile "\n# OPTIONAL COMMAND"
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
    addFile "#alias vi='vim'             # replace vi -> vim"
    addFile "#alias top='htop'           # replace top -> htop"
    addFile "#alias wget='wget -c'       # continue download default"
    addFile "#alias curl='curl -w \"\\\n\"'  # ignore output % (=warning) when use zsh"
    if [ "$(uname)" = "Linux" ]; then
        addFile "#alias dnf='sudo dnf'          # for redhat-based family"
        addFile "#alias yum='sudo yum'          # legacy of redhat-based family"
        addFile "#alias apt='sudo apt'          # for debian-based family"
        addFile "#alias apt-get='sudo apt-get'  # legacy of debian-based family"
        addFile "#alias pacman='sudo pacman'    # for arch-based family"
        addFile "#alias zypper='sudo zypper'    # for suse-based family"
        addFile "#alias nft='sudo nft'                # firewall management tool: nftables (netfilter table)"
        addFile "#alias ufw='sudo ufw'                # firewall management tool: ufw (uncomplicated firewall)"
        addFile "#alias firewall='sudo firewall-cmd'  # firewall management tool: firewall"
        addFile "#alias iptables='sudo iptables'      # legacy of nefirewall management tool"
        addFile "#alias reboot='sudo reboot'"
        addFile "#alias shutdown='sudo shutdown'"
    fi
}


# MAIN
funTitle ""
echo -e "- Check your shell type ... \c"
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ] || [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    echo -e "OK \n- Check your OS type ... \c"
    if [ "$(uname)" = "Darwin" ] || [ "$(uname)" = "Linux" ]; then
        echo -e "OK "
        if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
            profileName=".zprofile"
        elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
            profileName=".bash_profile"
        fi
        if ! [ -f "$tacshFilePath" ]; then
            echo -e "- Install Alias4sh... \c"
            funMain
            echo -e "OK \n- Add on $profileName file ... \c"
            echo -e "\n# Alias4sh" >> $HOME/$profileName
            echo -e "source $tacshFilePath\n" >> $HOME/$profileName
            echo -e "OK \n\nFinish \n • Try \"source ~/$profileName\" or restart Terminal to load the aliases.\n"
        elif [ -f "$tacshFilePath" ]; then
            echo -e "- Renstall Alias4sh ... \c"
            rm -f $tacshFilePath
            funMain
            echo -e "OK \n\nFinish"
            echo -e " • Restart your shell or restart Terminal to load the aliases to your shell's profile."
            echo -e " • If not work, check \"source ~/.config/a4s/a4s.sh\" code in your shell resoure file (~/$profileName).\n"
        else
            echo -e "NO \n • Someting wrong. Please check persmission or file path."
        fi
    else
        echo -e "NO \n • Sorry, this OS isn't support OS. Only supoort macOS and Linux.\n"
    fi
else
    echo -e "NO \n • Sorry, this sehll isn't support. Only support Bash and Zsh."
fi