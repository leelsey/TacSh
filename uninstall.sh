#!/usr/bin/env zsh
tacshDirPath="$HOME/.config/tacsh"
echo '- Remove Alias4sh ... \c'
if [ "$(uname)" = "Darwin" ]; then
    profileName=".zprofile"
elif [ "$(uname)" = "Linux" ]; then
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        profileName=".zshrc"
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        profileName=".bashrc"
    fi
else
    echo "NO\n • Your OS is not supported!"
    exit 1
fi
if [ -d "$tacshDirPath" ]; then
    rm -rf $tacshDirPath
else
    echo -e "NO \n • Someting wrong. Please check persmission or file path."
    exit 1
fi
echo "OK \n • Finish to remove TacSh! \n • Please remove manually in ~/$profileName"