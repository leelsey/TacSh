#!/usr/bin/env bash

tacshDirPath="$HOME/.config/tacsh"

uninstall() {
    if [ -f $2 ]; then
        read -p "Are you sure to remove TacSh? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        echo -e "- Uninstalling TacSh$4 ... \c"
        if [ $1 == "1" ]; then
            rm -rf $tacshDirPath
        elif [ $1 == "2" ]; then
            rm -f $2
        else
            exit 1
        fi
    else
        echo -e " • TacSh is not installed."
        exit 1
    fi
    echo -e "OK \n • Finish to uninstall TacSh$4! \n • Please remove manually in ~/$3 \n • Thank you for using TacSh!"
}

echo -e "TacSh uninstaller"

if [ "$(uname)" = "Darwin" ]; then
    tacshFileName="tac.sh"
    tacshFilePath="$tacshDirPath/$tacshFileName"
    profileName=".zprofile"
    uninstall 1 $tacshFilePath $profileName ""
elif [ "$(uname)" = "Linux" ]; then
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        tacshFileName="tac.zsh"
        tacshFilePath="$tacshDirPath/$tacshFileName"
        profileName=".zshrc"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        tacshFileName="tac.bash"
        tacshFilePath="$tacshDirPath/$tacshFileName"
        profileName=".bashrc"
    else
        echo -e " • Your shell is not supported."
        exit 1
    fi
    if [ -f "$tacshDirPath/tac.zsh" ] && [ -f "$tacshDirPath/tac.bash" ] ; then
        read -p "Which shell do you want to uninstall? (1: $tacshFileName, 2. all): " choose && [[ $choose == [12as] ]] || exit 1
        if [[ "$choose" == "1" || "$choose" == "s" ]]; then
            uninstall 2 $tacshFilePath $profileName " $tacshFileName"
        elif [[ "$choose" == "2" || "$choose" == "a" ]]; then
            uninstall 1 $tacshFilePath $profileName " all"
        fi
    else
        uninstall 1 $tacshFilePath $profileName ""
    fi
else
    echo -e " • Your OS is not supported."
    exit 1
fi
