#!/usr/bin/env bash

source ./package.sh
tacshDirPath="$HOME/.config/tacsh"

funcWrong() { echo " • Your environment is not supported."; exit 1; }
funcUninstall() {
    if [ -f $2 ]; then
        read -p "Are you sure to remove TacSh? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        echo -e "- funcUninstalling TacSh$4 ... \c"
        if [ $1 == "1" ]; then rm -rf $tacshDirPath
        elif [ $1 == "2" ]; then rm -f $2
        else exit 1; fi
    else echo -e " • TacSh is not installed."; exit 1; fi
    echo -e "OK \n • Finish to funcUninstall TacSh$4! \n • Please remove manually in ~/$3 \n • Thank you for using TacSh!"
}

echo -e "TacSh funcUninstaller"
if [ "$(uname)" = "Darwin" ]; then
    tacshFilePath="$tacshDirPath/tac.sh"
    profileName=".zprofile"
    funcUninstall 1 $tacshFilePath $profileName ""
elif [ "$(uname)" = "Linux" ]; then
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        tacshFileName="tac.zsh"
        tacshFilePath="$tacshDirPath/$tacshFileName"
        profileName=".zshrc"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        tacshFileName="tac.bash"
        tacshFilePath="$tacshDirPath/$tacshFileName"
        profileName=".bashrc"
    else funcWrong; fi
    if [ -f "$tacshDirPath/tac.zsh" ] && [ -f "$tacshDirPath/tac.bash" ] ; then
        read -p "Which shell do you want to funcUninstall? (1: $tacshFileName, 2. all): " choose && [[ $choose == [12as] ]] || exit 1
        if [[ "$choose" == "1" || "$choose" == "s" ]]; then funcUninstall 2 $tacshFilePath $profileName " $tacshFileName"
        elif [[ "$choose" == "2" || "$choose" == "a" ]]; then funcUninstall 1 $tacshFilePath $profileName " all"; fi
    else funcUninstall 1 $tacshFilePath $profileName ""; fi
elif [[ "$(uname)" =~ "MINGW64" ]]; then 
    tacshFilePath="$tacshDirPath/tac.sh"
    profileName=".bashrc"
    funcUninstall 1 $tacshFilePath $profileName ""
else funcWrong; fi