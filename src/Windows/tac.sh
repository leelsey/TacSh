#  ______         ______ 
# /_  __/__ _____/ __/ / 
#  / / / _ `/ __/\ \/ _ \ 
# /_/  \_,_/\__/___/_//_/ ver 0.1 
#                         by leelsey 

# Tactical Command for Shell

# ABOUT TACSH
TACSH_VERSION="0.1"
TACSH_PATH=$HOME/.config/tacsh
tacsh () {
	if [[ $1 == ver ]] || [[ $1 == version ]]; then echo "ver $TACSH_VERSION" ;
	elif [[ $1 == ls ]] || [[ $1 == list ]]; then cat "$TACSH_PATH" ;
	elif [[ $1 == conf ]] || [[ $1 == config ]] || [[ $1 == configure ]]; then vi "$TACSH_PATH" ;
	else echo "try 'tacsh ver' or 'tacsh ls' or 'tacsh conf'" ; fi
}

# ABOUT ENVIRONMENTS
admin () { sudo -i ; }
shrl () { echo "reloaded shell" && exec -l $SHELL ; }
rlsh () {
	if [ -f "$HOME/.bash_profile" ] || [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bash_profile" && source "$HOME/.bashrc" ;
		echo "reloaded .bash_profile and .bashrc" ;
	elif [ -f "$HOME/.bashrc" ]; then
		command source "$HOME/.bashrc" ;
		echo "reloaded .bashrc" ;
	elif [ -f "$HOME/bash_profile" ]; then
		command source "$HOME/.bash_profile" ;
		echo "reloaded .bash_profile" ;
	else
		echo "shrl: No environment file found"
	fi
}
vienv () { vi "$HOME/.bash_env" ; }
viprofile () { vi "$HOME/.bash_profile" ; }
virc () { vi "$HOME/.bashrc" ; }
vilogin () { vi "$HOME/.bash_login" ; }
vilogout () { vi "$HOME/.bash_logout" ; }
whichos () { echo $(uname) ; }

# ABOUT DEFAULT OPTIONS WITH COLOURISING
tree () { command tree -C "$@" ; }

# ABOUT EXTENDED COMMAND
ld () { ls -Cd .DS_Store .git .gitignore "$@" ; }
lal () { ls -Al "$@" ; }
lla () { ls -al "$@" ; }
llo () { ls -alO "$@" ; }
lsf () { ls -F "$@" ; }
lld () { ls -ld .DS_Store .git .gitignore "$@" ; }
lsv () { ls -alh $@ | grep -v "^[d|b|c|l|p|s|-]" "$@" ; }
ltr () { ls -lR "$@" ; }
cl () { cd "$@" && ls ; }
cla () { cd "$@" && ls -A ; }
cll () { cd "$@" && ls -al ; }
cdp () { cd "$@" && pwd ; }
cdr () { cd /"$@" ; }
cdh () { cd ~/"$@" ; }
his () { history "$@" ; }
cls () { clear ; }
clh () { history -c && exec $SHELL -l; }
clha () { rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }
shdn () { sudo shutdown "$@" ; }
shdnh () { sudo shutdown -h now ; }
shdnr () { sudo shutdown -r now ; }
vin () { vi "+set nu" "$@" ; }
svi () { sudo vi "$@" ; }
svim () { sudo vim "$@" ; }
nvi () { nvim "$@" ; }
snvi () { sudo nvim "$@" ; }
snvim () { sudo nvim "$@" ; }
pings () { ping -a "$@" ; }
pingt () { ping -a -c 10 "$@" ; }
dif () { diff $1 $2 | bat -l diff ; }
dfr () { diff -u $1 $2 | diffr --line-numbers ; }
gsdif () { while [[ $# -gt 0 ]] ; do git show "${1}" | bat -l diff ; shift ; done ; }
gsdfr () { while [[ $# -gt 0 ]] ; do git show "${1}" | diffr --line-numbers ; shift ; done ; }
p () {
	if [ $# -eq 0 ]; then
		cd .. ;
	elif [ $# -eq 1 ]; then
		if [[ $1 =~ '^[0-9]+$' ]]; then
			if [[ $1 == 0 ]]; then
				pwd ;
			else
				printf -v cdpFull '%*s' $1 ;
				cd "${cdpFull// /"../"}" ;
			fi
		elif [[ $1 =~ '^[y]+$' ]]; then
			pwd | pbcopy ;
		elif [[ $1 =~ '^[p]+$' ]]; then
			pwd ;
		elif [[ $1 =~ '^[b]+$' ]] || [[ $1 == - ]]; then
			cd - ;
		elif [[ $1 =~ '^[r]+$' ]] || [[ $1 == / ]]; then
			cd / ;
		elif [[ $1 =~ '^[h]+$' ]] || [[ $1 == ~ ]]; then
			cd ~ ;
		elif [[ $1 == ds ]] || [[ $1 == des ]] || [[ $1 == Des ]]; then
			cd ~/Desktop ;
		elif [[ $1 == dc ]] || [[ $1 == doc ]] || [[ $1 == Doc ]]; then
			cd ~/Documents ;
		elif [[ $1 == dw ]] || [[ $1 == dow ]] || [[ $1 == Dow ]]; then
			cd ~/Downloads ;
		elif [[ $1 == ms ]] || [[ $1 == mus ]] || [[ $1 == Mus ]]; then
			cd ~/Music ;
		elif [[ $1 == pc ]] || [[ $1 == pic ]] || [[ $1 == Pic ]]; then
			cd ~/Pictures ;
		elif [[ $1 == dr ]] || [[ $1 == dro ]] || [[ $1 == Dro ]] || [[ $1 == drp ]] || [[ $1 == Drp ]] ; then
			if [ -d ]; then
				cd '' ;
			else
				echo "p: wrong usage, try p -h" ;
			fi
		elif [[ $1 == --help ]] || [[ $1 == -help ]] || [[ $1 == -h ]]; then
			echo "p: change direcotry to parent directory"
			echo "p [number]: change direcotry to parent [number]th directory"
			echo "p p: output current directory"
			echo "p b(-): change direcotry to previous directory"
			echo "p r(/): change direcotry to root directory"
			echo "p h(~): change direcotry to home directory"
			echo "p ds, des: change direcotry to desktop directory"
			echo "p dc, doc: change direcotry to documents directory"
			echo "p dw, dow: change direcotry to downloads directory"
			echo "p ms, mus: change direcotry to music directory"
			echo "p pc, pic: change direcotry to pictures directory"
			echo "p dr, dro, drp: change direcotry to dropbox directory"
			echo "p -h: output usage"
		else
			echo "p: wrong usage, try p -h" ;
		fi
	else
		echo "p: wrong usage, try p -h" ;
	fi
}
jctl () {
	if [ "$#" -eq 0 ]; then
		/usr/libexec/java_home -V ;
	elif [ "$#" -eq 1 ]; then
		unset JAVA_HOME ;
		export JAVA_HOME=$(/usr/libexec/java_home -v "$1") ;
		java -version ;
	else
		echo "javahome: wrong usage"
	fi
}
dockerun () {
	if ! docker info > /dev/null 2>&1; then
		echo "dockerun false: Docker isn't running"
	else
		echo "dockerun true: Docker is running"
	fi
}
