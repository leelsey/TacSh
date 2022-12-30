#!/usr/bin/env zsh

tacshDirPath="$HOME/.config/tacsh"

echo '- Remove Alias4sh ... \c'
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    profileName=".zprofile"
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    profileName=".bash_profile"
else 
    echo "NO\n • Your shell is not supported!"
    exit 1
fi
rm -rf $tacshDirPath
echo "OK \n • Finish to remove TacSh! \n • Please remove manually in ~/$profileName"