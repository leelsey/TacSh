#!/usr/bin/env bash

tacshVer="ver 0.1"
tacshDirPath="$HOME/.config/tacsh"
tacshFilePath="$tacDirPath/tac.sh"

funTitle() {
    echo -e "$1    ______         ______ \n$1   /_  __/__ _____/ __/ / \n$1    / / / _ \`/ __/\\ \\/ _ \\ \n$1   /_/  \\_,_/\\__/___/_//_/ $tacshVer \n$1\t\t\t by leelsey \n$1"
}

addFile() {
    echo -e $1 >> $tacshFilePath
}

funMain() {
    mkdir -p $tacshDirPath
    touch $tacshFilePath && chmod 600 $tacshFilePath
    funTitle "#" >> $tacshFilePath

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
    echo "\n# TACTICAL COMMAND" >> $tacshFilePath

    # About Shell and Evironments
    echo "\n# For Enviroments" >> $tacshFilePath
    if [ \$EUID != 0 ]; then
        echo "  admin () { sudo -i ; } " >> $tacshFilePath
    fi
    echo "shrl () { echo \"reloaded shell\" && exec -l $SHELL ; }" >> $tacshFilePath
    if [ "$(uname)" = "Darwin" ]; then
        echo "macrl () { killall SystemUIServer ; killall Dock ; killall Finder ; echo \"reloaded macOS GUI\"}" >> $tacshFilePath
    fi
    echo "zshrl () {" >> $tacshFilePath
    echo "  if [ -f $HOME/.zprofile ] || [ -f $HOME/.zshrc ]; then" >> $tacshFilePath
    echo "    source $HOME/.zprofile && source $HOME/.zshrc ;" >> $tacshFilePath
    echo "    echo \"reloaded zprofile and zshrc\" ;" >> $tacshFilePath
    echo "  elif [ -f $HOME/.zshrc ]; then" >> $tacshFilePath
    echo "    command source $HOME/.zshrc ;" >> $tacshFilePath
    echo "    echo \"reloaded zshrc\" ;" >> $tacshFilePath
    echo "  elif [ -f $HOME/.zprofile ]; then" >> $tacshFilePath
    echo "    command source $HOME/.zprofile ;" >> $tacshFilePath
    echo "    echo \"reloaded zprofile\" ;" >> $tacshFilePath
    echo "  else" >> $tacshFilePath
    echo "    echo \"shrl: No environment file found\"" >> $tacshFilePath
    echo "  fi" >> $tacshFilePath
    echo "}" >> $tacshFilePath
    echo "vi$shEnv () { vi $HOME/.$shEnv ; }" >> $tacshFilePath
    echo "vi$shPf () { vi $HOME/.$shPf ; }" >> $tacshFilePath
    echo "vi$shRc () { vi $HOME/.$shRc ; }" >> $tacshFilePath
    echo "vi$shLin () { vi $HOME/.$shLin ; }" >> $tacshFilePath
    echo "vi$shLout () { vi $HOME/.$shLout ; }" >> $tacshFilePath
    echo "vitacsh () { vi $tacshFilePath ; }" >> $tacshFilePath
    echo "whichos () { echo $(uname) ; }" >> $tacshFilePath
    
    # About Default Commands Options & Colourising
    echo "\n# For Default Options" >> $tacshFilePath
    echo "rm () { command rm -I \"\$@\" ; } " >> $tacshFilePath
    echo "mv () { command mv -i \"\$@\" ; } " >> $tacshFilePath
    echo "cp () { command cp -i \"\$@\" ; } " >> $tacshFilePath
    echo "ln () { command ln -i \"\$@\" ; } " >> $tacshFilePath
    echo "\n# For Colourising" >> $tacshFilePath
    echo "ls () { command ls --color=auto \"\$@\" ; }" >> $tacshFilePath
    if [ "$(uname)" = "Linux" ]; then
        echo "dir () { command dir --color=auto \"\$@\" ; }" >> $tacshFilePath
        echo "vdir () { command vdir --color=auto \"\$@\" ; }" >> $tacshFilePath
        echo "ip () { command ip -c \"\$@\" ; }" >> $tacshFilePath
    fi
    echo "tree () { command tree -C \"\$@\" ; }" >> $tacshFilePath
    echo "grep () { command grep --color=auto \"\$@\" ; }" >> $tacshFilePath
    echo "egrep () { command egrep --color=auto \"\$@\" ; }" >> $tacshFilePath
    echo "fgrep () { command fgrep --color=auto \"\$@\" ; }" >> $tacshFilePath
    echo "xzegrep () { command xzegrep --color=auto \"\$@\" ; }" >> $tacshFilePath
    echo "xzfgrep () { command xzfgrep --color=auto \"\$@\" ; }" >> $tacshFilePath
    echo "xzgrep () { command xzgrep --color=auto \"\$@\" ; }" >> $tacshFilePath
    echo "zegrep () { command zegrep --color=auto \"\$@\" ; }" >> $tacshFilePath
    echo "zfgrep () { command zfgrep --color=auto \"\$@\" ; }" >> $tacshFilePath
    echo "zgrep () { command zgrep --color=auto \"\$@\" ; }" >> $tacshFilePath

    # About Extended Command
    echo "\n# For Extended Command" >> $tacshFilePath
    echo "l () { ls -C \"\$@\" ; }" >> $tacshFilePath
    echo "l. () { ls -Cd .* \"\$@\" ; }" >> $tacshFilePath
    echo "ll () { ls -l \"\$@\" ; }" >> $tacshFilePath
    echo "ll. () { ls -ld .* \"\$@\" ; }" >> $tacshFilePath
    echo "la () { ls -A \"\$@\" ; }" >> $tacshFilePath
    echo "lal () { ls -Al \"\$@\" ; }" >> $tacshFilePath
    echo "lla () { ls -al \"\$@\" ; }" >> $tacshFilePath
    echo "lsf () { ls -F \"\$@\" ; }" >> $tacshFilePath
    echo "lst () { ls -alh \$@ | grep -v \"^[d|b|c|l|p|s|-]\" \"\$@\" ; }" >> $tacshFilePath
    echo "ltr () { ls -lR \"\$@\" ; }" >> $tacshFilePath
    echo "cdr () { cd /\"\$@\" ; }" >> $tacshFilePath
    echo "cdh () { cd ~/\"\$@\" ; }" >> $tacshFilePath
    echo "cdl () { cd \"\$@\" | ls -A ; }" >> $tacshFilePath
    echo "cdla () { cd \"\$@\" | ls -al ; }" >> $tacshFilePath
    echo "his () { history \"\$@\" ; }" >> $tacshFilePath
    echo "cls () { clear ; }" >> $tacshFilePath
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        echo "clh () { echo -n > ~/.zsh_history && history -p  && exec $SHELL -l; }" >> $tacshFilePath
        echo "clha () { echo -n > ~/.zsh_history && history -p && rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }" >> $tacshFilePath
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        echo "clh () { history -c  && exec $SHELL -l; }" >> $tacshFilePath
    fi
    if [ "$(uname)" = "Darwin" ]; then 
        echo "clmac () {" >> $tacshFilePath
        echo "  defaults delete com.apple.dock ;" >> $tacshFilePath
        echo "  defaults write com.apple.dock ResetLaunchPad -bool true ;" >> $tacshFilePath
        echo "  killall Dock ; echo \"reseted dock and launchpad\" ;" >> $tacshFilePath
        echo "}" >> $tacshFilePath
        echo "cldock () {" >> $tacshFilePath
        echo "  defaults delete com.apple.dock ;" >> $tacshFilePath
        echo "  killall Dock ; echo \"reseted dock\" ;" >> $tacshFilePath
        echo "}" >> $tacshFilePath
        echo "cllaunchpad () {" >> $tacshFilePath
        echo "  defaults write com.apple.dock ResetLaunchPad -bool true ;" >> $tacshFilePath
        echo "  killall Dock ; echo \"reseted launchpad\" ;" >> $tacshFilePath
        echo "}" >> $tacshFilePath
    fi
    echo "shdn () { sudo shutdown \"\$@\" ; } " >> $tacshFilePath
    echo "shdnh () { sudo shutdown -h now ; } " >> $tacshFilePath
    echo "shdnr () { sudo shutdown -r now ; } " >> $tacshFilePath
    echo "vin () { vi \"+set nu\" \"\$@\" ; }" >> $tacshFilePath
    echo "svi () { sudo vi \"\$@\" ; }" >> $tacshFilePath
    echo "svim () { sudo vim \"\$@\" ; }" >> $tacshFilePath
    echo "nvi () { nvim \"\$@\" ; }" >> $tacshFilePath
    echo "snvi () { sudo nvim \"\$@\" ; }" >> $tacshFilePath
    echo "snvim () { sudo nvim \"\$@\" ; }" >> $tacshFilePath
    echo "pings () { ping -a \"\$@\" ; }" >> $tacshFilePath
    echo "pingt () { ping -a -c 10 \"\$@\" ; }" >> $tacshFilePath
    if [ "$(uname)" = "Darwin" ]; then
        echo "pinga () { ping -a --apple-connect --apple-time \"\$@\" ; }" >> $tacshFilePath
        echo "ip () { command ipconfig \"\$@\" ;  }" >> $tacshFilePath
        echo "macslp () {" >> $tacshFilePath
        echo "  if [ \"\$#\" -eq 1 ]; then" >> $tacshFilePath
        echo "    if [[ \$1 =~ on ]]; then" >> $tacshFilePath
        echo "      sudo pmset -c disablesleep 0 ;" >> $tacshFilePath
        echo "    elif [[ \$1 =~ off ]]; then" >> $tacshFilePath
        echo "      sudo pmset -c disablesleep 1 ;" >> $tacshFilePath
        echo "    else" >> $tacshFilePath
        echo "      echo \"usage: macslp on/off \" ;" >> $tacshFilePath        
        echo "    fi" >> $tacshFilePath
        echo "  else" >> $tacshFilePath
        echo "    echo \"usage: macslp on/off \" ;" >> $tacshFilePath
        echo "  fi" >> $tacshFilePath
        echo "}" >> $tacshFilePath
        echo "iCloud () { cd '$iCloudPath' ;}" >> $tacshFilePath
        echo "icloud () { cd '$iCloudPath' ;}" >> $tacshFilePath
        echo "if [ -d $macDropboxPath ]; then" >> $tacshFilePath
        echo "  Dropbox () { cd '$macDropboxPath' ;}" >> $tacshFilePath
        echo "  dropbox () { cd '$macDropboxPath' ;}" >> $tacshFilePath 
        echo "fi" >> $tacshFilePath
    elif [ "$(uname)" = "Linux" ]; then
        echo "if [ -d $linuxDropboxPath ]; then" >> $tacshFilePath
        echo "  Dropbox () { cd '$linuxDropboxPath' ;}" >> $tacshFilePath
        echo "  dropbox () { cd '$linuxDropboxPath' ;}" >> $tacshFilePath 
        echo "fi" >> $tacshFilePath
    fi
    echo "dif () { diff \$1 \$2 | bat -l diff ; }" >> $tacshFilePath
    echo "dfr () { diff -u \$1 \$2 | diffr --line-numbers ; }" >> $tacshFilePath
    echo "gsdif () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | bat -l diff ; shift ; done ; }" >> $tacshFilePath
    echo "gsdfr () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | diffr --line-numbers ; shift ; done ; }" >> $tacshFilePath
    echo "p () {" >> $tacshFilePath
    echo "  if [ \$# -eq 0 ]; then" >> $tacshFilePath
    echo "    cd ..;" >> $tacshFilePath
    echo "  elif [ \$# -eq 1 ]; then" >> $tacshFilePath
    echo "    if [[ \$1 =~ '^[0-9]+$' ]]; then" >> $tacshFilePath
    echo "      if [[ \$1 == 0 ]]; then" >> $tacshFilePath
    echo "        pwd ;" >> $tacshFilePath
    echo "      else" >> $tacshFilePath
    echo "        printf -v cdpFull '%*s' \$1 ;" >> $tacshFilePath
    echo "        cd \"\${cdpFull// /\"../\"}\" ;" >> $tacshFilePath
    echo "      fi" >> $tacshFilePath
    echo "    elif [[ \$1 =~ '^[p]+$' ]]; then" >> $tacshFilePath
    echo "      pwd ;" >> $tacshFilePath
    echo "    elif [[ \$1 =~ '^[b]+$' ]] || [[ \$1 == - ]]; then" >> $tacshFilePath
    echo "      cd - ;" >> $tacshFilePath
    echo "    elif [[ \$1 =~ '^[r]+$' ]] || [[ \$1 == / ]]; then" >> $tacshFilePath
    echo "      cd / ;" >> $tacshFilePath
    echo "    elif [[ \$1 =~ '^[h]+$' ]] || [[ \$1 == ~ ]]; then" >> $tacshFilePath
    echo "      cd ~ ;" >> $tacshFilePath
    echo "    elif [[ \$1 == des ]] || [[ \$1 == Des ]]; then" >> $tacshFilePath
    echo "      cd ~/Desktop ;" >> $tacshFilePath
    echo "    elif [[ \$1 == doc ]] || [[ \$1 == Doc ]]; then" >> $tacshFilePath
    echo "      cd ~/Documents ;" >> $tacshFilePath
    echo "    elif [[ \$1 == dow ]] || [[ \$1 == Dow ]]; then" >> $tacshFilePath
    echo "      cd ~/Downloads ;" >> $tacshFilePath
    echo "    elif [[ \$1 == mov ]] || [[ \$1 == Mov ]]; then" >> $tacshFilePath
    echo "      cd ~/Movies ;" >> $tacshFilePath
    echo "    elif [[ \$1 == mus ]] || [[ \$1 == Mus ]]; then" >> $tacshFilePath
    echo "      cd ~/Music ;" >> $tacshFilePath
    echo "    elif [[ \$1 == pic ]] || [[ \$1 == Pic ]]; then" >> $tacshFilePath
    echo "      cd ~/Pictures ;" >> $tacshFilePath
    echo "    elif [[ \$1 == vid ]] || [[ \$1 == Vid ]]; then" >> $tacshFilePath
    echo "      cd ~/Videos ;" >> $tacshFilePath
    echo "    elif [[ \$1 == --help ]] || [[ \$1 == -help ]] || [[ \$1 == -h ]]; then" >> $tacshFilePath
    echo "      echo \"p: move to parent directory\"" >> $tacshFilePath
    echo "      echo \"p [number]: move to parent [number]th directory\"" >> $tacshFilePath
    echo "      echo \"p p: output current directory\"" >> $tacshFilePath
    echo "      echo \"p b(-): move to previous directory\"" >> $tacshFilePath
    echo "      echo \"p r(/): move to root directory\"" >> $tacshFilePath    
    echo "      echo \"p h(~): move to home directory\"" >> $tacshFilePath
    echo "      echo \"p des: move to desktop directory\"" >> $tacshFilePath
    echo "      echo \"p doc: move to documents directory\"" >> $tacshFilePath
    echo "      echo \"p dow: move to downloads directory\"" >> $tacshFilePath
    echo "      echo \"p mov: move to movies directory\"" >> $tacshFilePath
    echo "      echo \"p mus: move to music directory\"" >> $tacshFilePath
    echo "      echo \"p pic: move to pictures directory\"" >> $tacshFilePath
    echo "      echo \"p vid: move to videos directory\"" >> $tacshFilePath
    echo "      echo \"p -h: output usage\"" >> $tacshFilePath
    echo "    else" >> $tacshFilePath
    echo "      echo \"p: wrong usage\" ;" >> $tacshFilePath
    echo "    fi" >> $tacshFilePath
    echo "  else" >> $tacshFilePath
    echo "    echo \"p: wrong usage\" ;" >> $tacshFilePath
    echo "  fi" >> $tacshFilePath
    echo "}" >> $tacshFilePath
    echo "jctl () {" >> $tacshFilePath
    echo "  if [ \"\$#\" -eq 0 ]; then" >> $tacshFilePath
    echo "    /usr/libexec/java_home -V ;" >> $tacshFilePath
    echo "  elif [ \"\$#\" -eq 1 ]; then" >> $tacshFilePath
    echo "    unset JAVA_HOME ;" >> $tacshFilePath
    echo "    export JAVA_HOME=\$(/usr/libexec/java_home -v \"\$1\") ;" >> $tacshFilePath
    echo "    java -version ;" >> $tacshFilePath
    echo "  else" >> $tacshFilePath
    echo "    echo \"javahome: wrong usage\"" >> $tacshFilePath
    echo "  fi" >> $tacshFilePath
    echo "}" >> $tacshFilePath
    if [ "$(uname)" = "Darwin" ]; then 
        echo "chicn () {" >> $tacshFilePath
        echo "  if [ \$# -eq 2 ]; then" >> $tacshFilePath
        echo "    if [[ \"\$1\" =~ ^https?:// ]]; then" >> $tacshFilePath
        echo "      curl -sLo /tmp/ic \"\$1\" ;" >> $tacshFilePath
        echo "      1=/tmp/iconchange" >> $tacshFilePath
        echo "    fi" >> $tacshFilePath
        echo "    if ! [ -f \$1 ]; then" >> $tacshFilePath
        echo "      echo \"chicn: cannot stat '\$1': No such file\"" >> $tacshFilePath
        echo "    elif ! [ -d \$2 ]; then" >> $tacshFilePath
        echo "      echo \"chicn: cannot stat '\$2': No such directory\"" >> $tacshFilePath
        echo "    else" >> $tacshFilePath
        echo "      sudo rm -rf \"\$2\"\$'/Icon\\\r'" >> $tacshFilePath
        echo "      sips -i \"\$1\" > /dev/null" >> $tacshFilePath
        echo "      DeRez -only icns \"\$1\" > /tmp/icnch.rsrc" >> $tacshFilePath
        echo "      sudo Rez -append /tmp/icnch.rsrc -o \"\$2\"\$'/Icon\\\r'" >> $tacshFilePath
        echo "      sudo SetFile -a C \"\$2\"" >> $tacshFilePath
        echo "      sudo SetFile -a V \"\$2\"\$'/Icon\\\r'" >> $tacshFilePath
        echo "    fi" >> $tacshFilePath
        echo "    rm -rf /tmp/icnch /tmp/icnch.rsrc" >> $tacshFilePath
        echo " else" >> $tacshFilePath
        echo "   echo \"chicn: wrong usage\"" >> $tacshFilePath
        echo " fi" >> $tacshFilePath
        echo "}" >> $tacshFilePath
    fi
    echo "dockerun () {" >> $tacshFilePath
    echo "  if ! docker info > /dev/null 2>&1; then" >> $tacshFilePath
    echo "    echo \"dockerun false: Docker isn't running\"" >> $tacshFilePath
    echo "  else" >> $tacshFilePath
    echo "    echo \"dockerun true: Docker is running\"" >> $tacshFilePath
    echo "  fi" >> $tacshFilePath
    echo "}" >> $tacshFilePath


    # Alias command part
    echo "\n\n# ALIAS COMMAND" >> $tacshFilePath
    echo "alias da='date'" >> $tacshFilePath
    echo "alias ca='cal'" >> $tacshFilePath
    echo "alias c='clear'" >> $tacshFilePath
    echo "alias f='finger'" >> $tacshFilePath
    echo "alias j='jobs -l'" >> $tacshFilePath
    echo "alias bc='bc -l'" >> $tacshFilePath
    
    
    # Disabed alias command part
    echo "\n\n# OPTIONAL COMMAND" >> $tacshFilePath
    echo "#rmdir () { command rmdir -v \"\$@\" ; } " >> $tacshFilePath
    echo "#mkdir () { command mkdir -v \"\$@\" ; } " >> $tacshFilePath
    echo "#chmod () { command chmod --preserve-root \"\$@\" ; }" >> $tacshFilePath
    echo "#chown () { command chown --preserve-root \"\$@\" ; }" >> $tacshFilePath
    echo "#chgrp () { command chgrp --preserve-root \"\$@\" ; }" >> $tacshFilePath
    echo "#vi () { command vim \"\$@\" ; }" >> $tacshFilePath
    echo "#emcs () { emacs \"\$@\" ; }" >> $tacshFilePath
    echo "#semcs () { sudo emacs \"\$@\" ; }" >> $tacshFilePath
    echo "#semacs () { sudo emacs \"\$@\" ; }" >> $tacshFilePath
    echo "#dfh () { df -h \"\$@\" ; }" >> $tacshFilePath
    echo "#duh () { du -h \"\$@\" ; }" >> $tacshFilePath
    echo "#alias vi='vim'             # replace vi -> vim" >> $tacshFilePath
    echo "#alias top='htop'           # replace top -> htop" >> $tacshFilePath
    echo "#alias wget='wget -c'       # continue download default" >> $tacshFilePath
    echo "#alias curl='curl -w \"\\\n\"'  # ignore output % (=warning) when use zsh" >> $tacshFilePath
    if [ "$(uname)" = "Linux" ]; then
        echo "#alias dnf='sudo dnf'          # for redhat-based family" >> $tacshFilePath
        echo "#alias yum='sudo yum'          # legacy of redhat-based family" >> $tacshFilePath
        echo "#alias apt='sudo apt'          # for debian-based family" >> $tacshFilePath
        echo "#alias apt-get='sudo apt-get'  # legacy of debian-based family" >> $tacshFilePath
        echo "#alias pacman='sudo pacman'    # for arch-based family" >> $tacshFilePath
        echo "#alias zypper='sudo zypper'    # for suse-based family" >> $tacshFilePath
        echo "#alias nft='sudo nft'                # firewall management tool: nftables (netfilter table)" >> $tacshFilePath
        echo "#alias ufw='sudo ufw'                # firewall management tool: ufw (uncomplicated firewall)" >> $tacshFilePath
        echo "#alias firewall='sudo firewall-cmd'  # firewall management tool: firewall" >> $tacshFilePath
        echo "#alias iptables='sudo iptables'      # legacy of nefirewall management tool" >> $tacshFilePath
        echo "#alias reboot='sudo reboot'" >> $tacshFilePath
        echo "#alias shutdown='sudo shutdown'" >> $tacshFilePath
    fi
}


# MAIN
funTitle " "
funMain
