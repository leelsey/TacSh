#!/usr/bin/env bash
tacshDirPath="$HOME/.config/tacsh"
confirmUninstall() {
    read -p "Are you sure to remove TacSh? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
}
if [ -d "$tacshDirPath" ]; then
    if [ "$(uname)" = "Darwin" ]; then
        echo -e '- Uninstalling TacSh ... \c'
        tacshFileName="tac.sh"
        tacshFilePath="$tacshDirPath/$tacshFileName"
        profileName=".zprofile"
        if [ -f "$tacshFilePath" ]; then
            confirmUninstall
            rm -f $tacshFilePath
            rm -rf $tacshDirPath
        else
            echo -e " • TacSh is not installed."
            exit 1
        fi
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
        if [ -f "$tacshFilePath" ]; then
            confirmUninstall
        else
            echo -e " • TacSh is not installed."
            exit 1
        fi
        if [ -f "$tacshDirPath/tac.zsh" ] && [ -f "$tacshDirPath/tac.bash" ] ; then
            read -p "Which one would you like to delete? (1: $tacshFileName, 2. all): " choose && [[ $choose == [12as] ]] || exit 1
            if [[ "$choose" == "1" || "$choose" == "s" ]]; then
                echo -e '- Uninstalling TacSh $tacshFileName ... \c'
                rm -f $tacshFilePath
            elif [[ "$choose" == "2" || "$choose" == "a" ]]; then
                echo -e '- Uninstalling TacSh all ... \c'
                rm -rf $tacshDirPath
            fi
        fi
    else
        echo -e " • Your OS is not supported."
        exit 1
    fi
else
    echo -e "NO \n • TacSh is not installed."
    exit 1
fi
echo -e "OK \n • Finish to remove TacSh! \n • Please remove manually in ~/$profileName"