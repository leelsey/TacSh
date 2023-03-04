#!/usr/bin/env bash

source ./package.sh
tacshGenDirPath="./src"
tacshDirPath="\$HOME/.config/tacsh"
msgReadme="Read the README.md for build options."
tacshLogo="\" ______         ______ \n/_  __/__ _____/ __/ / \n / / / _ \\\`/ __/\\\\ \\\\/ _ \\\\ \n/_/  \\\\_,_/\\\\__/___/_//_/\""

funcTitle() { echo -e "$1 ______         ______ \n$1/_  __/__ _____/ __/ / \n$1 / / / _ \`/ __/\\ \\/ _ \\ \n$1/_/  \\_,_/\\__/___/_//_/ ver $version \n$1                        by $author \n"; }
funcAddTacSh() { echo -e $1 >> $taschGenFilePath; }
funcAddInst() { echo $1 >> ./installer; }
funcAddUninst() { echo $1 >> ./uninstaller; }
funcWrong() { echo " • Wrong usage. Please try again."; exit 1; }
funcMkFile() { if [ ! -f $1 ]; then touch $1 && chmod $2 $1; fi; }
funcRmFile() { if [ -f $1 ]; then rm -rf $1; fi; }
funcGenInst() {
    funcRmFile "./installer"
    funcMkFile "./installer" 755
    funcAddInst "#!/usr/bin/env bash"
    funcAddInst "tacshDirPath=\"\$HOME/.config/tacsh\""
    funcAddInst "funcWrong() { echo \" • Your environment is not supported.\"; exit 1; }"
    funcAddInst "funcInstall() {"
    funcAddInst " echo -e \"- \$2 TacSh ... \\c\""
    funcAddInst " if [ -f \$tacshFilePath ]; then rm -rf \$tacshFilePath; fi"
    funcAddInst " if [ ! -f \"./\$srcPath\" ]; then curl -o \$tacshFilePath https://raw.githubusercontent.com/leelsey/TacSh/main/\$srcPath"
    funcAddInst " else cp \$srcPath \$tacshFilePath; fi"
    funcAddInst " if [ \$1 = \"install\" ]; then echo -e \"\n# TacSh\nsource \$tacshFilePath\n\" >> \$HOME/\$profileName; fi"
    funcAddInst " echo -e \"OK \n- Finish to \$1 TacSh!\""
    funcAddInst " echo -e \"\$3\""
    funcAddInst "}"
    echo -e "echo -e $tacshLogo" >> ./installer
    funcAddInst "echo -e \"\n$name($version) Installer\""
    funcAddInst "echo -e \"- Check your OS type ... \c\""
    funcAddInst "if [ \"\$(uname)\" = \"Darwin\" ] || [[ \"\$(uname)\" =~ \"MINGW64\" ]]; then"
    funcAddInst " if [ \"\$(uname)\" = \"Darwin\" ]; then osName=\"macOS\"; profileName=\".zprofile\""
    funcAddInst " elif [[ \"\$(uname)\" =~ \"MINGW64\" ]]; then osName=\"Windows\"; profileName=\".bashrc\"; fi"
    funcAddInst " srcPath=\"src/\$osName/tac.sh\""
    funcAddInst " tacshFilePath=\"\$tacshDirPath/tac.sh\""
    funcAddInst "elif [ \"\$(uname)\" = \"Linux\" ]; then"
    funcAddInst " source /etc/os-release"
    funcAddInst " if [ \"\$ID\" = \"ubuntu\" ]; then osName=\"Ubuntu\""
    funcAddInst " elif [ \"\$ID\" = \"debian\" ]; then osName=\"Debian\""
    funcAddInst " elif [ \"\$ID\" = \"fedora\" ]; then osName=\"Fedora\""
    funcAddInst " elif [ \"\$ID\" = \"centos\" ]; then osName=\"CentOS\""
    funcAddInst " elif [ \"\$ID\" = \"rhel\" ]; then osName=\"RHEL\""
    funcAddInst " elif [[ \"\$ID\" =~ \"suse\" ]]; then osName=\"SUSE\""
    funcAddInst " elif [ \"\$ID\" = \"arch\" ]; then osName=\"Arch\""
    funcAddInst " elif [ \"\$ID\" = \"kali\" ]; then osName=\"Kali\""
    funcAddInst " else"
    funcAddInst "  if [[ \"\$ID_LIKE\" =~ \"ubuntu\" ]]; then osName=\"Ubuntu\""
    funcAddInst "  elif [[ \"\$ID_LIKE\" =~ \"debian\" ]]; then osName=\"Debian\""
    funcAddInst "  elif [[ \"\$ID_LIKE\" =~ \"fedora\" ]] || [[ "\$ID_LIKE" =~ \"rhel\" ]]; then osName=\"fedora\""
    funcAddInst "  elif [[ \"\$ID_LIKE\" =~ \"arch\" ]]; then osName=\"Arch\""
    funcAddInst "  else osName=\"Linux\"; fi"
    funcAddInst " fi"
    funcAddInst " if [ -n \"\`\$SHELL -c 'echo \$ZSH_VERSION'\`\" ]; then profileName=\".zshrc\"; tacshFileName=\"tac.zsh\";"
    funcAddInst " elif [ -n \"\`\$SHELL -c 'echo \$BASH_VERSION'\`\" ]; then profileName=\".bashrc\"; tacshFileName=\"tac.bash\"; fi"
    funcAddInst " if [ osName=\"Linux\" ]; then srcPath=\"src/Linux/\$tacshFileName\""
    funcAddInst " else srcPath=\"src/Linux/\$osName/\$tacshFileName\"; fi"
    funcAddInst " tacshFilePath=\"\$tacshDirPath/\$tacshFileName\""
    funcAddInst "else funcWrong; fi"
    funcAddInst "echo -e \"OK \n- Check your Shell type ... \c\""
    funcAddInst "if [ -n \"\`\$SHELL -c 'echo \$ZSH_VERSION'\`\" ] || [ -n \"\`\$SHELL -c 'echo \$BASH_VERSION'\`\" ]; then echo -e \"OK \""
    funcAddInst "else funcWrong; fi;"
    funcAddInst "if [ -f \$tacshFilePath ]; then"
    funcAddInst " if [[ \$TACSH_VERSION = \"$version\" ]]; then instType=\"reinstall\"; msgInst=\"Reinstalling\""
    funcAddInst " elif [[ \$TACSH_VERSION < \"$version\" ]]; then instType=\"update\"; msgInst=\"Updating\""
    funcAddInst " else instType=\"change\"; msgInst=\"Changing stable version\"; fi"
    funcAddInst " msgFinish=\" • Restart your shell use 'shrl' or 'source ~/\$profileName'\n • If not work, check 'source \$tacshFilePath' include in '~/\$profileName'.\""
    funcAddInst "else"
    funcAddInst " instType=\"install\"; msgInst=\"Installing\""
    funcAddInst " msgFinish=\" • Try 'source ~/$profileName' or restart Terminal to load the TacSh.\""
    funcAddInst "fi"
    funcAddInst "mkdir -p \$tacshDirPath"
    funcAddInst "funcInstall \"\$instType\" \"\$msgInst\" \"\$msgFinish\""
}
funcGenUninst() {
    funcRmFile "./uninstaller"
    funcMkFile "./uninstaller" 755
    funcAddUninst "#!/usr/bin/env bash"
    funcAddUninst "tacshDirPath=\"\$HOME/.config/tacsh\""
    funcAddUninst "funcWrong() { echo \" • Your environment is not supported.\"; exit 1; }"
    funcAddUninst "funcUninstall() {"
    funcAddUninst " if [ -f \$2 ]; then"
    funcAddUninst "  read -p \"Are you sure to remove TacSh? (Y/N): \" confirm && [[ \$confirm == [yY] || \$confirm == [yY][eE][sS] ]] || exit 1"
    funcAddUninst "  echo -e \"- funcUninstalling TacSh$4 ... \c\""
    funcAddUninst "  if [ \$1 == \"1\" ]; then rm -rf \$tacshDirPath"
    funcAddUninst "  elif [ \$1 == \"2\" ]; then rm -f \$2"
    funcAddUninst "  else exit 1; fi"
    funcAddUninst " else echo -e \" • TacSh is not installed.\"; exit 1; fi"
    funcAddUninst " echo -e \"OK \n • Finish to funcUninstall TacSh\$4! \n • Please remove manually in ~/\$3 \n • Thank you for using TacSh!\""
    funcAddUninst "}"
    funcAddUninst "echo -e \"echo -e \$tacshLogo\" >> ./installer"
    funcAddUninst "echo -e \"\nTacSh uninstaller\""
    funcAddUninst "if [ \"\$(uname)\" = \"Darwin\" ]; then"
    funcAddUninst " tacshFilePath=\"\$tacshDirPath/tac.sh\""
    funcAddUninst " profileName=\".zprofile\""
    funcAddUninst " funcUninstall 1 \$tacshFilePath \$profileName \"\""
    funcAddUninst "elif [ \"\$(uname)\" = \"Linux\" ]; then"
    funcAddUninst " if [ -n \"\`\$SHELL -c 'echo \$ZSH_VERSION'\`\" ]; then"
    funcAddUninst "  tacshFileName=\"tac.zsh\""
    funcAddUninst "  tacshFilePath=\"\$tacshDirPath/\$tacshFileName\""
    funcAddUninst "  profileName=\".zshrc\""
    funcAddUninst " elif [ -n \"\`\$SHELL -c 'echo \$BASH_VERSION'\`\" ]; then"
    funcAddUninst "  tacshFileName=\"tac.bash\""
    funcAddUninst "  tacshFilePath=\"\$tacshDirPath/\$tacshFileName\""
    funcAddUninst "  profileName=\".bashrc\""
    funcAddUninst " else funcWrong; fi"
    funcAddUninst " if [ -f \"\$tacshDirPath/tac.zsh\" ] && [ -f \"\$tacshDirPath/tac.bash\" ] ; then"
    funcAddUninst "  read -p \"Which shell do you want to funcUninstall? (1: \$tacshFileName, 2. all): \" choose && [[ \$choose == [12as] ]] || exit 1"
    funcAddUninst "  if [[ \"\$choose\" == \"1\" || \"\$choose\" == \"s\" ]]; then funcUninstall 2 \$tacshFilePath \$profileName \" \$tacshFileName\""
    funcAddUninst "  elif [[ \"\$choose\" == \"2\" || \"\$choose\" == \"a\" ]]; then funcUninstall 1 \$tacshFilePath \$profileName \" all\"; fi"
    funcAddUninst " else funcUninstall 1 \$tacshFilePath \$profileName \"\"; fi"
    funcAddUninst "elif [[ \"\$(uname)\" =~ \"MINGW64\" ]]; then "
    funcAddUninst " tacshFilePath=\"\$tacshDirPath/tac.sh\""
    funcAddUninst " profileName=\".bashrc\""
    funcAddUninst " funcUninstall 1 \$tacshFilePath \$profileName \"\""
    funcAddUninst "else funcWrong; fi"
}
funcGenTacSh() {
    mkdir -p $taschGenDirPath
    funcRmFile $taschGenFilePath
    funcMkFile $taschGenFilePath 600
    funcTitle "# " >> $taschGenFilePath

    # Funtional command part
    funcAddTacSh "# $description"

    # About TacSh
    funcAddTacSh "\n# ABOUT TACSH"
    funcAddTacSh "TACSH_VERSION=\"$version\""
    funcAddTacSh "TACSH_PATH=$tacshDirPath"
    funcAddTacSh "tacsh () {"
    funcAddTacSh "\tif [[ \$1 == ver ]] || [[ \$1 == version ]]; then echo \"ver \$TACSH_VERSION\" ;"
    funcAddTacSh "\telif [[ \$1 == ls ]] || [[ \$1 == list ]]; then cat \"\$TACSH_PATH\" ;"
    funcAddTacSh "\telif [[ \$1 == conf ]] || [[ \$1 == config ]] || [[ \$1 == configure ]]; then vi \"\$TACSH_PATH\" ;"
    funcAddTacSh "\telse echo \"try 'tacsh ver' or 'tacsh ls' or 'tacsh conf'\" ; fi"
    funcAddTacSh "}"

    # About Shell and Evironments
    funcAddTacSh "\n# ABOUT ENVIRONMENTS"
    if [ \$EUID != 0 ]; then
        funcAddTacSh "admin () { sudo -i ; } "
    fi
    funcAddTacSh "shrl () { echo \"reloaded shell\" && exec -l \$SHELL ; }"
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "macrl () { killall SystemUIServer ; killall Dock ; killall Finder ; echo \"reloaded macOS GUI\" ; }"
    fi
    funcAddTacSh "rlsh () {"
    funcAddTacSh "\tif [ -f \"\$HOME/.$shPf\" ] || [ -f \"\$HOME/.$shRc\" ]; then"
    funcAddTacSh "\t\tsource \"\$HOME/.$shPf\" && source \"\$HOME/.$shRc\" ;"
    funcAddTacSh "\t\techo \"reloaded .$shPf and .$shRc\" ;"
    funcAddTacSh "\telif [ -f \"\$HOME/.$shRc\" ]; then"
    funcAddTacSh "\t\tcommand source \"\$HOME/.$shRc\" ;"
    funcAddTacSh "\t\techo \"reloaded .$shRc\" ;"
    funcAddTacSh "\telif [ -f \"\$HOME/$shPf\" ]; then"
    funcAddTacSh "\t\tcommand source \"\$HOME/.$shPf\" ;"
    funcAddTacSh "\t\techo \"reloaded .$shPf\" ;"
    funcAddTacSh "\telse"
    funcAddTacSh "\t\techo \"shrl: No environment file found\""
    funcAddTacSh "\tfi"
    funcAddTacSh "}"
    funcAddTacSh "vienv () { vi \"\$HOME/.$shEnv\" ; }"
    funcAddTacSh "viprofile () { vi \"\$HOME/.$shPf\" ; }"
    funcAddTacSh "virc () { vi \"\$HOME/.$shRc\" ; }"
    funcAddTacSh "vilogin () { vi \"\$HOME/.$shLin\" ; }"
    funcAddTacSh "vilogout () { vi \"\$HOME/.$shLout\" ; }"
    funcAddTacSh "whichos () { echo \$(uname) ; }"
    if [ $keName = "Linux" ]; then
        funcAddTacSh "\n# ABOUT FIREWALL MANAGEMENT TOOL"
        if [[ $osName = "Ubuntu" ]]; then
            funcAddTacSh "#alias firewall='sudo firewall-cmd' # firewall (firewalld)"
            funcAddTacSh "alias ufw='sudo ufw'                # ufw (uncomplicated firewall)"
            funcAddTacSh "#alias nft='sudo nft'               # nftables (netfilter table)"
            funcAddTacSh "alias iptables='sudo iptables'      # iptables (old netfilter)"
        elif [[ $osName = "Debian" ]] || [[ $osName = "Kali" ]]; then
            funcAddTacSh "#alias firewall='sudo firewall-cmd' # firewall (firewalld)"
            funcAddTacSh "#alias ufw='sudo ufw'               # ufw (uncomplicated firewall)"
            funcAddTacSh "alias nft='sudo nft'                # nftables (netfilter table)"
            funcAddTacSh "alias iptables='sudo iptables'      # iptables (old netfilter)"
        elif [[ $osName = "Fedora" ]] || [[ $osName = "CentOS" ]] || [[ $osName = "RHEL" ]] || [[ $osName = "SUSE" ]]; then
            funcAddTacSh "alias firewall='sudo firewall-cmd'  # firewall (firewalld)"
            funcAddTacSh "#alias ufw='sudo ufw'               # ufw (uncomplicated firewall)"
            funcAddTacSh "#alias nft='sudo nft'               # nftables (netfilter table)"
            funcAddTacSh "alias iptables='sudo iptables'      # iptables (old netfilter)"
        elif [[ $osName = "Arch" ]]; then
            funcAddTacSh "#alias firewall='sudo firewall-cmd' # firewall (firewalld)"
            funcAddTacSh "#alias ufw='sudo ufw'               # ufw (uncomplicated firewall)"
            funcAddTacSh "#alias nft='sudo nft'               # nftables (netfilter table)"
            funcAddTacSh "alias iptables='sudo iptables'      # iptables (old netfilter)"
        else
            funcAddTacSh "#alias firewall='sudo firewall-cmd' # firewall (firewalld)"
            funcAddTacSh "#alias ufw='sudo ufw'               # ufw (uncomplicated firewall)"
            funcAddTacSh "#alias nft='sudo nft'               # nftables (netfilter table)"
            funcAddTacSh "#alias iptables='sudo iptables'     # iptables (old netfilter)"
        fi
        funcAddTacSh "\n# ABOUT PACKAGE MANAGEMENT TOOL"
        if [[ $osName = "Ubuntu" ]] || [[ $osName = "Debian" ]] || [[ $osName = "Kali" ]]; then
            funcAddTacSh "#alias dpkg='sudo dpkg'             # Debian Package Manager for Debian-based"
            funcAddTacSh "#alias apt='sudo apt'               # Advanced Package Tool for Debian-based"
            funcAddTacSh "#alias apt-get='sudo apt-get'       # Advanced Package Tool (old) for Debian-based"
        elif [[ $osName = "Fedora" ]] || [[ $osName = "CentOS" ]] || [[ $osName = "RHEL" ]]; then
            funcAddTacSh "#alias rpm='sudo rpm'               # Red Hat Package Manager for RHEL-based"
            funcAddTacSh "#alias dnf='sudo dnf'               # Dandified YUM for RHEL-based"
            funcAddTacSh "#alias yum='sudo yum'               # Yellowdog Updater, Modified (old) for RHEL-based"
        elif [[ $osName = "SUSE" ]]; then
            funcAddTacSh "#alias zypper='sudo zypper'         # Zen / YaST Packages Patches Patterns Products for SUSE-based"
        elif [[ $osName = "Arch" ]]; then
            funcAddTacSh "#alias pacman='sudo pacman'         # Pacman for arch-based family"
        else
            funcAddTacSh "#alias dpkg='sudo dpkg'             # Debian Package Manager for Debian-based"
            funcAddTacSh "#alias apt='sudo apt'               # Advanced Package Tool for Debian-based"
            funcAddTacSh "#alias apt-get='sudo apt-get'       # Advanced Package Tool (old) for Debian-based"
            funcAddTacSh "#alias rpm='sudo rpm'               # Red Hat Package Manager for RHEL-based"
            funcAddTacSh "#alias dnf='sudo dnf'               # Dandified YUM for RHEL-based"
            funcAddTacSh "#alias yum='sudo yum'               # Yellowdog Updater, Modified (old) for RHEL-based"
            funcAddTacSh "#alias zypper='sudo zypper'         # Zen / YaST Packages Patches Patterns Products for SUSE-based"
            funcAddTacSh "#alias pacman='sudo pacman'         # Pacman for arch-based family"
            funcAddTacSh "#alias emerge='sudo emerge'         # Portage for gentoo-based"
        fi
    fi

    # About Default Commands Options & Colourising
    funcAddTacSh "\n# ABOUT DEFAULT OPTIONS WITH COLOURISING"
    if [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then 
        funcAddTacSh "rm () { command rm -iv \"\$@\" ; } "
        funcAddTacSh "mv () { command mv -iv \"\$@\" ; } "
        funcAddTacSh "cp () { command cp -iv \"\$@\" ; } "
        funcAddTacSh "ln () { command ln -iv \"\$@\" ; } "
        funcAddTacSh "#chmod () { command chmod --preserve-root \"\$@\" ; }"
        funcAddTacSh "#chown () { command chown --preserve-root \"\$@\" ; }"
        funcAddTacSh "#chgrp () { command chgrp --preserve-root \"\$@\" ; }"
        funcAddTacSh "#mkdir () { command mkdir -v \"\$@\" ; } "
        funcAddTacSh "#rmdir () { command rmdir -v \"\$@\" ; } "
        funcAddTacSh "#vi () { command vim \"\$@\" ; }"
        funcAddTacSh "#emcs () { emacs \"\$@\" ; }"
        funcAddTacSh "#semcs () { sudo emacs \"\$@\" ; }"
        funcAddTacSh "#semacs () { sudo emacs \"\$@\" ; }"
        funcAddTacSh "#dfh () { df -h \"\$@\" ; }"
        funcAddTacSh "#duh () { du -h \"\$@\" ; }"
    fi
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "grep () { command grep --color=auto \"\$@\" ; }"
        funcAddTacSh "egrep () { command egrep --color=auto \"\$@\" ; }"
        funcAddTacSh "fgrep () { command fgrep --color=auto \"\$@\" ; }"
        funcAddTacSh "xzegrep () { command xzegrep --color=auto \"\$@\" ; }"
        funcAddTacSh "xzfgrep () { command xzfgrep --color=auto \"\$@\" ; }"
        funcAddTacSh "xzgrep () { command xzgrep --color=auto \"\$@\" ; }"
        funcAddTacSh "zegrep () { command zegrep --color=auto \"\$@\" ; }"
        funcAddTacSh "zfgrep () { command zfgrep --color=auto \"\$@\" ; }"
        funcAddTacSh "zgrep () { command zgrep --color=auto \"\$@\" ; }"
        funcAddTacSh "ls () { command ls -G \"\$@\" ; }"
        funcAddTacSh "gls () { command gls --color=auto \"\$@\" ; }"
        funcAddTacSh "dir () { gls -Ao --group-directories-first \"\$@\" ; }"
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        if [ $shName = "zsh" ]; then
            funcAddTacSh "grep () { command grep --color=auto \"\$@\" ; }"
            funcAddTacSh "ls () { command ls --color=auto \"\$@\" ; }"
        elif [ $shName = "bash" ]; then
            funcAddTacSh "#grep () { command grep --color=auto \"\$@\" ; }"
            funcAddTacSh "#ls () { command ls --color=auto \"\$@\" ; }"
        fi
        funcAddTacSh "dir () { command dir -Ao --color=auto --group-directories-first \"\$@\" ; }"
        funcAddTacSh "vdir () { command vdir -Ao --color=auto --group-directories-first \"\$@\" ; }"
    fi
    if [ $keName = "Linux" ]; then
        funcAddTacSh "ip () { command ip -c \"\$@\" ; }"
    fi
    funcAddTacSh "tree () { command tree -C \"\$@\" ; }"

    # About Extended Command
    funcAddTacSh "\n# ABOUT EXTENDED COMMAND"
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "l () { ls -C \"\$@\" ; }"
        funcAddTacSh "ll () { ls -l \"\$@\" ; }"
        funcAddTacSh "la () { ls -A \"\$@\" ; }"
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        if [ $shName = "zsh" ]; then
            funcAddTacSh "l () { ls -C \"\$@\" ; }"
            funcAddTacSh "ll () { ls -l \"\$@\" ; }"
            funcAddTacSh "la () { ls -A \"\$@\" ; }"
        elif [ $shName = "bash" ]; then
            if [[ $osName = "Ubuntu" ]]; then
                funcAddTacSh "#l () { ls -C \"\$@\" ; }"
                funcAddTacSh "#ll () { ls -l \"\$@\" ; }"
                funcAddTacSh "#la () { ls -A \"\$@\" ; }"
            elif [[ $osName = "Debian" ]]; then
                funcAddTacSh "l () { ls -C \"\$@\" ; }"
                funcAddTacSh "ll () { ls -l \"\$@\" ; }"
                funcAddTacSh "la () { ls -A \"\$@\" ; }"
            else
                funcAddTacSh "l () { ls -C \"\$@\" ; }"
                funcAddTacSh "#ll () { ls -l \"\$@\" ; }"
                funcAddTacSh "la () { ls -A \"\$@\" ; }"
            fi
        fi
    fi
    funcAddTacSh "ld () { ls -Cd .* \"\$@\" ; }"
    funcAddTacSh "lal () { ls -Al \"\$@\" ; }"
    funcAddTacSh "lla () { ls -al \"\$@\" ; }"
    funcAddTacSh "llo () { ls -alO \"\$@\" ; }"
    funcAddTacSh "lsf () { ls -F \"\$@\" ; }"
    funcAddTacSh "lld () { ls -ld .* \"\$@\" ; }"
    funcAddTacSh "lsv () { ls -alh \$@ | grep -v \"^[d|b|c|l|p|s|-]\" \"\$@\" ; }"
    funcAddTacSh "ltr () { ls -lR \"\$@\" ; }"
    funcAddTacSh "cl () { cd \"\$@\" && ls ; }"
    funcAddTacSh "cla () { cd \"\$@\" && ls -A ; }"
    funcAddTacSh "cll () { cd \"\$@\" && ls -al ; }"
    funcAddTacSh "cdp () { cd \"\$@\" && pwd ; }"
    funcAddTacSh "cdr () { cd /\"\$@\" ; }"
    funcAddTacSh "cdh () { cd ~/\"\$@\" ; }"
    funcAddTacSh "his () { history \"\$@\" ; }"
    funcAddTacSh "cls () { clear ; }"
    if [ $shName = "zsh" ]; then
        funcAddTacSh "clh () { echo -n > ~/.zsh_history && history -p  && exec \$SHELL -l; }"
        funcAddTacSh "clha () { echo -n > ~/.zsh_history && history -p && rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec \$SHELL -l; }"
    elif [ $shName = "bash" ]; then
        funcAddTacSh "clh () { history -c  && exec \$SHELL -l; }"
        funcAddTacSh "clha () { rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec \$SHELL -l; }"
    fi
    if [ $keName = "Darwin" ]; then 
        funcAddTacSh "clmac () { defaults delete com.apple.dock ; defaults write com.apple.dock ResetLaunchPad -bool true ; killall Dock ; echo \"reseted dock and launchpad\" ; }"
        funcAddTacSh "cldock () { defaults delete com.apple.dock ; killall Dock ; echo \"reseted dock\" ; }"
        funcAddTacSh "cllaunchpad () { defaults write com.apple.dock ResetLaunchPad -bool true ; killall Dock ; echo \"reseted launchpad\" ; }"
    fi
    funcAddTacSh "shdn () { sudo shutdown \"\$@\" ; } "
    funcAddTacSh "shdnh () { sudo shutdown -h now ; } "
    funcAddTacSh "shdnr () { sudo shutdown -r now ; } "
    funcAddTacSh "vin () { vi \"+set nu\" \"\$@\" ; }"
    funcAddTacSh "svi () { sudo vi \"\$@\" ; }"
    funcAddTacSh "svim () { sudo vim \"\$@\" ; }"
    funcAddTacSh "nvi () { nvim \"\$@\" ; }"
    funcAddTacSh "snvi () { sudo nvim \"\$@\" ; }"
    funcAddTacSh "snvim () { sudo nvim \"\$@\" ; }"
    funcAddTacSh "pings () { ping -a \"\$@\" ; }"
    funcAddTacSh "pingt () { ping -a -c 10 \"\$@\" ; }"
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "pinga () { ping -a --apple-connect --apple-time \"\$@\" ; }"
        funcAddTacSh "macslp () {"
        funcAddTacSh "\tif [ \"\$#\" -eq 1 ]; then"
        funcAddTacSh "\t\tif [[ \$1 =~ on ]]; then"
        funcAddTacSh "\t\t\tsudo pmset -c disablesleep 0 ;"
        funcAddTacSh "\t\telif [[ \$1 =~ off ]]; then"
        funcAddTacSh "\t\t\tsudo pmset -c disablesleep 1 ;"
        funcAddTacSh "\t\telse"
        funcAddTacSh "\t\t\techo \"usage: macslp on/off \" ;"
        funcAddTacSh "\t\tfi"
        funcAddTacSh "\telse"
        funcAddTacSh "\t\techo \"usage: macslp on/off \" ;"
        funcAddTacSh "\tfi"
        funcAddTacSh "}"
        funcAddTacSh "icloud () { cd $iCloudPath ; ls -A ; }"
        funcAddTacSh "if [ -d $dropboxPath ]; then"
        funcAddTacSh "\tdropbox () { cd $dropboxPath ; ls -A ; }"
        funcAddTacSh "fi"
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        funcAddTacSh "if [ -d $dropboxPath ]; then"
        funcAddTacSh "\tdropbox () { cd $dropboxPath ; ls -A ; }"
        funcAddTacSh "fi"
    fi
    if [ $keName = "Darwin" ] || [ $keName = "MinGW64" ]; then
        funcAddTacSh "ip () { command ipconfig \"\$@\" ;  }" 
    fi
    funcAddTacSh "dif () { diff \$1 \$2 | bat -l diff ; }"
    funcAddTacSh "dfr () { diff -u \$1 \$2 | diffr --line-numbers ; }"
    funcAddTacSh "gsdif () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | bat -l diff ; shift ; done ; }"
    funcAddTacSh "gsdfr () { while [[ \$# -gt 0 ]] ; do git show \"\${1}\" | diffr --line-numbers ; shift ; done ; }"
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "sy () { pbcopy < \"\$1\" ; }"
        funcAddTacSh "sp () { pbpaste > \"\$1\" ; }"
        funcAddTacSh "pwdc () { pwd | pbcopy ; }"
    elif [ $keName = "Linux" ]; then
        funcAddTacSh "sy () { xclip -selection clipboard < \"\$1\" ; }"
        funcAddTacSh "sp () { xclip -selection clipboard > \"\$1\" ; }"
        funcAddTacSh "pwdc () { pwd | xclip -selection clipboard ; }"
    fi
    funcAddTacSh "p () {"
    funcAddTacSh "\tif [ \$# -eq 0 ]; then"
    funcAddTacSh "\t\tcd .. ;"
    funcAddTacSh "\telif [ \$# -eq 1 ]; then"
    funcAddTacSh "\t\tif [[ \$1 =~ '^[0-9]+$' ]]; then"
    funcAddTacSh "\t\t\tif [[ \$1 == 0 ]]; then"
    funcAddTacSh "\t\t\t\tpwd ;"
    funcAddTacSh "\t\t\telse"
    funcAddTacSh "\t\t\t\tprintf -v cdpFull '%*s' \$1 ;"
    funcAddTacSh "\t\t\t\tcd \"\${cdpFull// /\"../\"}\" ;"
    funcAddTacSh "\t\t\tfi"
    funcAddTacSh "\t\telif [[ \$1 =~ '^[y]+$' ]]; then"
    funcAddTacSh "\t\t\tpwd | pbcopy ;"
    funcAddTacSh "\t\telif [[ \$1 =~ '^[p]+$' ]]; then"
    funcAddTacSh "\t\t\tpwd ;"
    funcAddTacSh "\t\telif [[ \$1 =~ '^[b]+$' ]] || [[ \$1 == - ]]; then"
    funcAddTacSh "\t\t\tcd - ;"
    funcAddTacSh "\t\telif [[ \$1 =~ '^[r]+$' ]] || [[ \$1 == / ]]; then"
    funcAddTacSh "\t\t\tcd / ;"
    funcAddTacSh "\t\telif [[ \$1 =~ '^[h]+$' ]] || [[ \$1 == ~ ]]; then"
    funcAddTacSh "\t\t\tcd ~ ;"
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "\t\telif [[ \$1 == ap ]] || [[ \$1 == app ]] || [[ \$1 == App ]]; then"
        funcAddTacSh "\t\t\tcd /Applications ;"
    fi
    funcAddTacSh "\t\telif [[ \$1 == ds ]] || [[ \$1 == des ]] || [[ \$1 == Des ]]; then"
    funcAddTacSh "\t\t\tcd ~/Desktop ;"
    funcAddTacSh "\t\telif [[ \$1 == dc ]] || [[ \$1 == doc ]] || [[ \$1 == Doc ]]; then"
    funcAddTacSh "\t\t\tcd ~/Documents ;"
    funcAddTacSh "\t\telif [[ \$1 == dw ]] || [[ \$1 == dow ]] || [[ \$1 == Dow ]]; then"
    funcAddTacSh "\t\t\tcd ~/Downloads ;"
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "\t\telif [[ \$1 == lb ]] || [[ \$1 == lib ]] || [[ \$1 == Lib ]]; then"
        funcAddTacSh "\t\t\tcd ~/Library ;"
        funcAddTacSh "\t\telif [[ \$1 == mv ]] || [[ \$1 == mov ]] || [[ \$1 == Mov ]]; then"
        funcAddTacSh "\t\t\tcd ~/Movies ;"
    fi
    funcAddTacSh "\t\telif [[ \$1 == ms ]] || [[ \$1 == mus ]] || [[ \$1 == Mus ]]; then"
    funcAddTacSh "\t\t\tcd ~/Music ;"
    funcAddTacSh "\t\telif [[ \$1 == pc ]] || [[ \$1 == pic ]] || [[ \$1 == Pic ]]; then"
    funcAddTacSh "\t\t\tcd ~/Pictures ;"
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "\t elif [[ \$1 == ic ]] || [[ \$1 == icl ]] || [[ \$1 == iCl ]] || [[ \$1 == cl ]] || [[ \$1 == clo ]] || [[ \$1 == Clo ]] ; then"
        funcAddTacSh "\t\t\tcd '$iCloudPath' ;"
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        funcAddTacSh "\t\telif [[ \$1 == vd ]] || [[ \$1 == vid ]] || [[ \$1 == Vid ]]; then"
        funcAddTacSh "\t\t\tcd ~/Videos ;"
    fi
    funcAddTacSh "\t\telif [[ \$1 == dr ]] || [[ \$1 == dro ]] || [[ \$1 == Dro ]] || [[ \$1 == drp ]] || [[ \$1 == Drp ]] ; then"
    funcAddTacSh "\t\t\tif [ -d $dropboxPath ]; then"
    funcAddTacSh "\t\t\t\tcd '$dropboxPath' ;"
    funcAddTacSh "\t\t\telse"
    funcAddTacSh "\t\t\t\techo \"p: wrong usage, try p -h\" ;"
    funcAddTacSh "\t\t\tfi"
    funcAddTacSh "\t\telif [[ \$1 == --help ]] || [[ \$1 == -help ]] || [[ \$1 == -h ]]; then"
    funcAddTacSh "\t\t\techo \"p: change direcotry to parent directory\""
    funcAddTacSh "\t\t\techo \"p [number]: change direcotry to parent [number]th directory\""
    funcAddTacSh "\t\t\techo \"p p: output current directory\""
    funcAddTacSh "\t\t\techo \"p b(-): change direcotry to previous directory\""
    funcAddTacSh "\t\t\techo \"p r(/): change direcotry to root directory\""
    funcAddTacSh "\t\t\techo \"p h(~): change direcotry to home directory\""
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "\t\t\techo \"p ap, app: change direcotry to applications directory\""
    fi
    funcAddTacSh "\t\t\techo \"p ds, des: change direcotry to desktop directory\""
    funcAddTacSh "\t\t\techo \"p dc, doc: change direcotry to documents directory\""
    funcAddTacSh "\t\t\techo \"p dw, dow: change direcotry to downloads directory\""
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "\t\t\techo \"p lb, lib: change direcotry to movies directory\""
        funcAddTacSh "\t\t\techo \"p mv, mov: change direcotry to movies directory\""
    fi
    funcAddTacSh "\t\t\techo \"p ms, mus: change direcotry to music directory\""
    funcAddTacSh "\t\t\techo \"p pc, pic: change direcotry to pictures directory\""
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "\t\t\techo \"p ic, cl, icl, clo: change direcotry to icloud directory\""
    elif [ $keName = "Linux" ] || [ $keName = "MinGW64" ]; then
        funcAddTacSh "\t\t\techo \"p vd, vid: change direcotry to videos directory\""
    fi
    funcAddTacSh "\t\t\techo \"p dr, dro, drp: change direcotry to dropbox directory\""
    funcAddTacSh "\t\t\techo \"p -h: output usage\""
    funcAddTacSh "\t\telse"
    funcAddTacSh "\t\t\techo \"p: wrong usage, try p -h\" ;"
    funcAddTacSh "\t\tfi"
    funcAddTacSh "\telse"
    funcAddTacSh "\t\techo \"p: wrong usage, try p -h\" ;"
    funcAddTacSh "\tfi"
    funcAddTacSh "}"
    funcAddTacSh "jctl () {"
    funcAddTacSh "\tif [ \"\$#\" -eq 0 ]; then"
    funcAddTacSh "\t\t/usr/libexec/java_home -V ;"
    funcAddTacSh "\telif [ \"\$#\" -eq 1 ]; then"
    funcAddTacSh "\t\tunset JAVA_HOME ;"
    funcAddTacSh "\t\texport JAVA_HOME=\$(/usr/libexec/java_home -v \"\$1\") ;"
    funcAddTacSh "\t\tjava -version ;"
    funcAddTacSh "\telse"
    funcAddTacSh "\t\techo \"javahome: wrong usage\""
    funcAddTacSh "\tfi"
    funcAddTacSh "}"
    funcAddTacSh "dockerun () {"
    funcAddTacSh "\tif ! docker info > /dev/null 2>&1; then"
    funcAddTacSh "\t\techo \"dockerun false: Docker isn't running\""
    funcAddTacSh "\telse"
    funcAddTacSh "\t\techo \"dockerun true: Docker is running\""
    funcAddTacSh "\tfi"
    funcAddTacSh "}"
    if [ $keName = "Darwin" ]; then
        funcAddTacSh "chicn () {"
        funcAddTacSh "\tif [ \$# -eq 2 ]; then"
        funcAddTacSh "\t\tif [[ \"\$1\" =~ ^https?:// ]]; then"
        funcAddTacSh "\t\t\tcurl -sLo /tmp/ic \"\$1\" ;"
        funcAddTacSh "\t\t\t1=/tmp/iconchange"
        funcAddTacSh "\t\tfi"
        funcAddTacSh "\t\tif ! [ -f \$1 ]; then"
        funcAddTacSh "\t\t\techo \"chicn: cannot stat '\$1': No such file\""
        funcAddTacSh "\t\telif ! [ -d \$2 ]; then"
        funcAddTacSh "\t\t\techo \"chicn: cannot stat '\$2': No such directory\""
        funcAddTacSh "\t\telse"
        funcAddTacSh "\t\t\tsudo rm -rf \"\$2\"\$'/Icon\\\r'"
        funcAddTacSh "\t\t\tsips -i \"\$1\" > /dev/null"
        funcAddTacSh "\t\t\tDeRez -only icns \"\$1\" > /tmp/icnch.rsrc"
        funcAddTacSh "\t\t\tsudo Rez -append /tmp/icnch.rsrc -o \"\$2\"\$'/Icon\\\r'"
        funcAddTacSh "\t\t\tsudo SetFile -a C \"\$2\""
        funcAddTacSh "\t\t\tsudo SetFile -a V \"\$2\"\$'/Icon\\\r'"
        funcAddTacSh "\t\tfi"
        funcAddTacSh "\t\trm -rf /tmp/icnch /tmp/icnch.rsrc"
        funcAddTacSh "\telse"
        funcAddTacSh "\t\techo \"chicn: wrong usage\""
        funcAddTacSh "\tfi"
        funcAddTacSh "}"
    fi

    # Alias commands for user (custom)
    if [ $keName = "Linux" ]; then
        funcAddTacSh "\n# ABOUT USER COMMANDS"
        funcAddTacSh "#alias top='htop'"
        funcAddTacSh "#alias wget='wget -c'"
        funcAddTacSh "#alias curl='curl -w \"\\\n\"'"
        funcAddTacSh "#alias ca='cal'"
        funcAddTacSh "#alias da='date'"
        funcAddTacSh "#alias c='clear'"
        funcAddTacSh "#alias f='finger'"
        funcAddTacSh "#alias j='jobs -l'"
        funcAddTacSh "#alias bc='bc -l'"
    fi
}

# MAIN
funcTitle ""
if [[ $1 = 0 ]]; then osCode=0
    if [[ $2 = 1 ]]; then inCode=1
    elif [[ $2 = 2 ]]; then inCode=2
    else echo "$msgReadme"; read -p "- Build installer type: " inCode; fi
elif [[ $1 = 1 ]]; then osCode=1
elif [[ $1 = 2 ]]; then osCode=2
    if [[ $2 = 1 ]]; then luCode=1
    elif [[ $2 = 2 ]]; then luCode=2
    elif [[ $2 = 3 ]]; then luCode=3
    elif [[ $2 = 4 ]]; then luCode=4
    elif [[ $2 = 5 ]]; then luCode=5
    elif [[ $2 = 6 ]]; then luCode=6
    elif [[ $2 = 7 ]]; then luCode=7
    elif [[ $2 = 8 ]]; then luCode=8
    elif [[ $2 = 9 ]]; then luCode=9; fi
    if [[ $3 = 1 ]]; then shCode=1
    elif [[ $3 = 2 ]]; then shCode=2; fi
elif [[ $1 = 3 ]]; then osCode=3
else echo "$msgReadme"; read -p "- Build OS type: " osCode; fi

if [ $osCode = 0 ]; then
    if [ $inCode = 1 ]; then funcGenInst; msgInst="installer"
    elif [ $inCode = 2 ]; then funcGenUninst; msgInst="uninstaller"
    else funcWrong; fi
    echo "- Generated $msgInst file: ./$msgInst"; exit 1
elif [ $osCode = 1 ]; then
    keName="Darwin"
    osName="macOS"
    shName="zsh"
    taschGenDirPath="$tacshGenDirPath/$osName"
    taschGenFilePath="$taschGenDirPath/tac.sh"
    tacshFilePath="\"$tacshDirPath/tac.sh\""
    iCloudPath="\"\$HOME/Library/Mobile Documents/com~apple~CloudDocs\""
    dropboxPath="\"\$HOME/Library/CloudStorage/Dropbox\""
elif [ $osCode = 2 ]; then keName="Linux"
    if [ -z $luCode ] || [ -z $shCode ]; then echo "$msgReadme"; fi
    if [ -z $luCode ]; then read -p "- Build Linux type: " luCode; fi
    if [ -z $shCode ]; then read -p "- Build shell type: " shCode; fi
    if [ $luCode = 1 ]; then osName="Ubuntu"
    elif [ $luCode = 2 ]; then osName="Debain"
    elif [ $luCode = 3 ]; then osName="Fedora"
    elif [ $luCode = 4 ]; then osName="CentOS"
    elif [ $luCode = 5 ]; then osName="REHL"
    elif [ $luCode = 6 ]; then osName="SUSE"
    elif [ $luCode = 7 ]; then osName="Arch"
    elif [ $luCode = 8 ]; then osName="Kali"
    elif [ $luCode = 9 ]; then osName="Other Linux"
    else funcWrong; fi
    if [ $luCode = 9 ]; then taschGenDirPath="$tacshGenDirPath/Linux"
    else taschGenDirPath="$tacshGenDirPath/Linux/$osName"; fi
    if [ $shCode = 1 ]; then shName="zsh"
        taschGenFilePath="$taschGenDirPath/tac.zsh"
        tacshFilePath="\"$tacshDirPath/tac.zsh\""
    elif [ $shCode = 2 ]; then shName="bash"
        taschGenFilePath="$taschGenDirPath/tac.bash"
        tacshFilePath="$tacshDirPath/tac.bash"
    else funcWrong; fi
    dropboxPath="\"\$HOME/Dropbox\""
elif [ $osCode = 3 ]; then
    keName="MINGW64"
    osName="Windows"
    shName="bash"
    taschGenDirPath="$tacshGenDirPath/$osName"
    taschGenFilePath="$taschGenDirPath/tac.sh"
    tacshFilePath="\"$tacshDirPath/tac.bash\""
else funcWrong; fi

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
else funcWrong; fi

echo "- Selected Enironment: $osName($keName) & $shName"
funcGenTacSh
echo "- Generated tacsh file: $taschGenFilePath"