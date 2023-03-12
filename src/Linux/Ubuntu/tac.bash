#  ______         ______ 
# /_  __/__ _____/ __/ / 
#  / / / _ `/ __/\ \/ _ \ 
# /_/  \_,_/\__/___/_//_/ ver 0.1 
#                         by leelsey 

# Tactical Command for Shell

# ABOUT TACSH
TACSH_VERSION="0.1"
TACSH_HOME="$HOME/.config/tacsh"
DROPBOX_HOME="$HOME/Dropbox"
tacsh () {
	if [[ $1 == ver ]] || [[ $1 == version ]]; then echo "ver $TACSH_VERSION"
	elif [[ $1 == ls ]] || [[ $1 == list ]]; then cat "$TACSH_HOME/tac.bash"
	elif [[ $1 == conf ]] || [[ $1 == config ]] || [[ $1 == configure ]]; then vi "$TACSH_HOME/tac.bash"
	else echo "try 'tacsh ver' or 'tacsh ls' or 'tacsh conf'"; fi
}

# ABOUT ENVIRONMENTS
admin () { sudo -i; }
shrl () { echo "reloaded shell" && exec -l $SHELL; }
rlsh () {
	if [ -f "$HOME/.bash_profile" ] || [ -f "$HOME/.bashrc" ]; then source "$HOME/.bash_profile" && source "$HOME/.bashrc"; echo "reloaded .bash_profile and .bashrc"
	elif [ -f "$HOME/.bashrc" ]; then source "$HOME/.bashrc"; echo "reloaded .bashrc"
	elif [ -f "$HOME/.bash_profile" ]; then source "$HOME/.bash_profile"; echo "reloaded .bash_profile"
	else echo "shrl: No environment file found"; fi
}
vienv () { vi "$HOME/.bash_env"; }
viprofile () { vi "$HOME/.bash_profile"; }
virc () { vi "$HOME/.bashrc"; }
vilogin () { vi "$HOME/.bash_login"; }
vilogout () { vi "$HOME/.bash_logout"; }
whichos () { echo $(uname); }

# ABOUT FIREWALL MANAGEMENT TOOL
#alias firewall='sudo firewall-cmd' # firewall (firewalld)
alias ufw='sudo ufw' # ufw (uncomplicated firewall)
#alias nft='sudo nft' # nftables (netfilter table)
alias iptables='sudo iptables' # iptables (old netfilter)

# ABOUT PACKAGE MANAGEMENT TOOL
#alias dpkg='sudo dpkg' # Debian Package Manager for Debian-based
#alias apt='sudo apt' # Advanced Package Tool for Debian-based
#alias apt-get='sudo apt-get' # Advanced Package Tool (old) for Debian-based

# ABOUT DEFAULT OPTIONS WITH COLOURISING
rm () { command rm -iv "$@"; }
mv () { command mv -iv "$@"; }
cp () { command cp -iv "$@"; }
ln () { command ln -iv "$@"; }
#chmod () { command chmod --preserve-root "$@"; }
#chown () { command chown --preserve-root "$@"; }
#chgrp () { command chgrp --preserve-root "$@"; }
#mkdir () { command mkdir -v "$@"; }
#rmdir () { command rmdir -v "$@"; }
#vi () { command vim "$@"; }
#emcs () { emacs "$@"; }
#semcs () { sudo emacs "$@"; }
#semacs () { sudo emacs "$@"; }
#dfh () { df -h "$@"; }
#duh () { du -h "$@"; }
#grep () { command grep --color=auto "$@"; }
#ls () { command ls --color=auto "$@"; }
dir () { command dir -Ao --color=auto --group-directories-first "$@"; }
vdir () { command vdir -Ao --color=auto --group-directories-first "$@"; }
ip () { command ip -c "$@"; }
tree () { command tree -C "$@"; }

# ABOUT EXTENDED COMMAND
#l () { ls -C "$@"; }
#ll () { ls -l "$@"; }
#la () { ls -A "$@"; }
ld () { ls -Cd .DS_Store .git .gitignore "$@"; }
lal () { ls -Al "$@"; }
lla () { ls -al "$@"; }
llo () { ls -alO "$@"; }
lsf () { ls -F "$@"; }
lld () { ls -ld .DS_Store .git .gitignore "$@"; }
lsv () { ls -alh $@ | grep -v "^[d|b|c|l|p|s|-]" "$@"; }
ltr () { ls -lR "$@"; }
cl () { cd "$@" && ls; }
cla () { cd "$@" && ls -A; }
cll () { cd "$@" && ls -al; }
cdp () { cd "$@" && pwd; }
cdr () { cd /"$@"; }
cdh () { cd ~/"$@"; }
his () { history "$@"; }
cls () { clear; }
clr () { reset; }
clh () { history -c && exec $SHELL -l; }
clha () { rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }
shdn () { sudo shutdown "$@"; }
shdnh () { sudo shutdown -h now; }
shdnr () { sudo shutdown -r now; }
vin () { vi "+set nu" "$@"; }
svi () { sudo vi "$@"; }
svim () { sudo vim "$@"; }
nvi () { nvim "$@"; }
snvi () { sudo nvim "$@"; }
snvim () { sudo nvim "$@"; }
pings () { ping -a "$@"; }
pingt () { ping -a -c 10 "$@"; }
if [ -d $DROPBOX_HOME ]; then dropbox () { cd $DROPBOX_HOME; ls -A; }; fi
dif () { diff $1 $2 | bat -l diff; }
dfr () { diff -u $1 $2 | diffr --line-numbers; }
gsdif () { while [[ $# -gt 0 ]]; do git show "${1}" | bat -l diff; shift; done; }
gsdfr () { while [[ $# -gt 0 ]]; do git show "${1}" | diffr --line-numbers; shift; done; }
sy () { xclip -selection clipboard < "$1"; }
sp () { xclip -selection clipboard > "$1"; }
pwdc () { pwd | xclip -selection clipboard; }
shspeed () { if [ -z $1 ]; then 1=1; fi; for i in {1..$1}; do /usr/bin/time $SHELL -i -c exit; done; }
p () {
	if [ $# -eq 0 ]; then cd ..
	elif [ $# -eq 1 ]; then
		if [[ $1 =~ '^[0-9]+$' ]]; then
			if [[ $1 == 0 ]]; then pwd
			else printf -v cdpFull '%*s' $1; cd "${cdpFull// /"../"}"; fi
		elif [[ $1 =~ '^[p]+$' ]]; then pwd
		elif [[ $1 =~ '^[b]+$' ]] || [[ $1 == - ]]; then cd -
		elif [[ $1 =~ '^[r]+$' ]] || [[ $1 == / ]]; then cd /
		elif [[ $1 =~ '^[h]+$' ]] || [[ $1 == ~ ]]; then cd ~
		elif [[ $1 == ds ]] || [[ $1 == des ]] || [[ $1 == Des ]]; then cd ~/Desktop
		elif [[ $1 == dc ]] || [[ $1 == doc ]] || [[ $1 == Doc ]]; then cd ~/Documents
		elif [[ $1 == dw ]] || [[ $1 == dow ]] || [[ $1 == Dow ]]; then cd ~/Downloads
		elif [[ $1 == ms ]] || [[ $1 == mus ]] || [[ $1 == Mus ]]; then cd ~/Music
		elif [[ $1 == pc ]] || [[ $1 == pic ]] || [[ $1 == Pic ]]; then cd ~/Pictures
		elif [[ $1 == vd ]] || [[ $1 == vid ]] || [[ $1 == Vid ]]; then cd ~/Videos
		elif [[ $1 == db ]] || [[ $1 == drb ]] || [[ $1 == Drb ]]; then
			if [ -d "$HOME/Dropbox" ]; then cd "$HOME/Dropbox"; else echo "p: wrong usage, try p -h"; fi
		elif [[ $1 == --help ]] || [[ $1 == -help ]] || [[ $1 == -h ]]; then
			echo "p: change direcotry to parent directory"
			echo "p [number]: change direcotry to parent [number]th directory"
			echo "p p: output current directory"
			echo "p b, -: change direcotry to previous directory"
			echo "p r, /: change direcotry to root directory"
			echo "p h, ~: change direcotry to home directory"
			echo "p ds, des: change direcotry to desktop directory"
			echo "p dc, doc: change direcotry to documents directory"
			echo "p dw, dow: change direcotry to downloads directory"
			echo "p ms, mus: change direcotry to music directory"
			echo "p pc, pic: change direcotry to pictures directory"
			echo "p vd, vid: change direcotry to videos directory"
			echo "p db, drb: change direcotry to dropbox directory"
			echo "p -h: output usage"
		else echo "p: wrong usage, try p -h"; fi
	else echo "p: wrong usage, try p -h"; fi
}
jctl () {
	if [ "$#" -eq 0 ]; then /usr/libexec/java_home -V
	elif [ "$#" -eq 1 ]; then unset JAVA_HOME; export JAVA_HOME=$(/usr/libexec/java_home -v "$1"); java -version
	else echo "javahome: wrong usage"; fi
}
dockerun () {
	if ! docker info > /dev/null 2>&1; then echo "dockerun false: Docker isn't running"
	else echo "dockerun true: Docker is running"; fi
}

# ABOUT USER COMMANDS
#alias top='htop'
#alias wget='wget -c'
#alias curl='curl -w "\n"'
#alias ca='cal'
#alias da='date'
#alias c='clear'
#alias f='finger'
#alias j='jobs -l'
#alias bc='bc -l'
