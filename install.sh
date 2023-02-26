#!/usr/bin/env bash

source ./package.sh
tacshDirPath="$HOME/.config/tacsh"

# funcAddRC() { echo -e "\n# TacSh\nsource $tacshFilePath\n" >> $HOME/$profileName; }
funcWrong() { echo " • Your environment is not supported."; exit 1; }
funcInstall() {
    echo -e "- $2 TacSh ... \c"
    if [ -f $tacshFilePath ]; then rm -rf $tacshFilePath; fi
    if [ ! -f "./$srcPath" ]; then curl -o $tacshFilePath https://raw.githubusercontent.com/leelsey/TacSh/main/$srcPath
    else cp $srcPath $tacshFilePath; fi
    if [ $1 = "install" ]; then echo -e "\n# TacSh\nsource $tacshFilePath\n" >> $HOME/$profileName; fi
    echo -e "OK \n- Finish to $1 TacSh!"
    echo -e "$3"
}

echo -e " ______         ______ \n/_  __/__ _____/ __/ / \n / / / _ \`/ __/\\ \\/ _ \\ \n/_/  \\_,_/\\__/___/_//_/ ver $version \n                        by $author"
echo -e "\n- Check your OS type ... \c"
if [ "$(uname)" = "Darwin" ] || [[ "$(uname)" =~ "MINGW64" ]]; then
    if [ "$(uname)" = "Darwin" ]; then osName="macOS"; profileName=".zprofile"
    elif [[ "$(uname)" =~ "MINGW64" ]]; then osName="Windows"; profileName=".bashrc"; fi
    srcPath="src/$osName/tac.sh"
    tacshFilePath="$tacshDirPath/tac.sh"
elif [ "$(uname)" = "Linux" ]; then
    source /etc/os-release
    if [ "$ID" = "ubuntu" ]; then osName="Ubuntu"
    elif [ "$ID" = "debian" ]; then osName="Debian"
    elif [ "$ID" = "fedora" ]; then osName="Fedora"
    elif [ "$ID" = "centos" ]; then osName="CentOS"
    elif [ "$ID" = "rhel" ]; then osName="RHEL"
    elif [[ "$ID" =~ "suse" ]]; then osName="SUSE"
    elif [ "$ID" = "arch" ]; then osName="Arch"
    elif [ "$ID" = "kali" ]; then osName="Kali"
    else
        if [[ "$ID_LIKE" =~ "debian" ]]; then osName="Debian"
        elif [[ "$ID_LIKE" =~ "fedora" ]] || [[ "$ID_LIKE" =~ "rhel" ]] ; then osName="fedora"
        elif [[ "$ID_LIKE" =~ "arch" ]]; then osName="Arch"
        else osName="Linux"; fi
    fi
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then profileName=".zshrc"; tacshFileName="tac.zsh";
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then profileName=".bashrc"; tacshFileName="tac.bash"; fi
    if [ osName="Linux" ]; then srcPath="src/Linux/$tacshFileName"
    else srcPath="src/Linux/$osName/$tacshFileName"; fi
    tacshFilePath="$tacshDirPath/$tacshFileName"
else funcWrong; fi

echo -e "OK \n- Check your Shell type ... \c"
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ] || [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then echo -e "OK "
else funcWrong; fi;

if [ -f $tacshFilePath ]; then
    if [[ $TACSH_VERSION = "$version" ]]; then instType="reinstall"; msgInst="Reinstalling"
    elif [[ $TACSH_VERSION < "$version" ]]; then instType="update"; msgInst="Updating"
    else instType="change"; msgInst="Changing stable version"; fi
    msgFinish=" • Restart your shell use 'shrl' or 'source ~/$profileName'\n • If not work, check 'source $tacshFilePath' include in '~/$profileName'."
else
    instType="install"; msgInst="Installing"
    msgFinish="• Try \"source ~/$profileName\" or restart Terminal to load the TacSh."
fi
funcInstall "$instType" "$msgInst" "$msgFinish"