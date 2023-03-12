#  ______         ______ 
# /_  __/__ _____/ __/ / 
#  / / / _ `/ __/\ \/ _ \ 
# /_/  \_,_/\__/___/_//_/ ver 0.1 
#                         by leelsey 

# Tactical Command for Shell

# ABOUT TACSH
TACSH_VERSION="0.1"
TACSH_HOME="$HOME/.config/tacsh"
ICLOUD_HOME="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
DROPBOX_HOME="$HOME/Library/CloudStorage/Dropbox"
tacsh () {
	if [[ $1 == ver ]] || [[ $1 == version ]]; then echo "ver $TACSH_VERSION"
	elif [[ $1 == ls ]] || [[ $1 == list ]]; then cat "$TACSH_HOME/tac.sh"
	elif [[ $1 == conf ]] || [[ $1 == config ]] || [[ $1 == configure ]]; then vi "$TACSH_HOME/tac.sh"
	else echo "try 'tacsh ver' or 'tacsh ls' or 'tacsh conf'" ; fi
}

# ABOUT ENVIRONMENTS
admin () { sudo -i ; }
shrl () { echo "reloaded shell" && exec -l $SHELL ; }
macrl () { killall SystemUIServer ; killall Dock ; killall Finder ; echo "reloaded macOS GUI" ; }
rlsh () {
	if [ -f "$HOME/.zprofile" ] || [ -f "$HOME/.zshrc" ]; then source "$HOME/.zprofile" && source "$HOME/.zshrc" ; echo "reloaded .zprofile and .zshrc"
	elif [ -f "$HOME/.zshrc" ]; then source "$HOME/.zshrc" ; echo "reloaded .zshrc"
	elif [ -f "$HOME/.zprofile" ]; then source "$HOME/.zprofile" ; echo "reloaded .zprofile"
	else echo "shrl: No environment file found" ; fi
}
vienv () { vi "$HOME/.zshenv" ; }
viprofile () { vi "$HOME/.zprofile" ; }
virc () { vi "$HOME/.zshrc" ; }
vilogin () { vi "$HOME/.zlogin" ; }
vilogout () { vi "$HOME/.zlogout" ; }
whichos () { echo $(uname) ; }

# ABOUT DEFAULT OPTIONS WITH COLOURISING
grep () { command grep --color=auto "$@" ; }
egrep () { command egrep --color=auto "$@" ; }
fgrep () { command fgrep --color=auto "$@" ; }
xzegrep () { command xzegrep --color=auto "$@" ; }
xzfgrep () { command xzfgrep --color=auto "$@" ; }
xzgrep () { command xzgrep --color=auto "$@" ; }
zegrep () { command zegrep --color=auto "$@" ; }
zfgrep () { command zfgrep --color=auto "$@" ; }
zgrep () { command zgrep --color=auto "$@" ; }
ls () { command ls -G "$@" ; }
gls () { command gls --color=auto "$@" ; }
dir () { gls -Ao --group-directories-first "$@" ; }
tree () { command tree -C "$@" ; }

# ABOUT EXTENDED COMMAND
l () { ls -C "$@" ; }
ll () { ls -l "$@" ; }
la () { ls -A "$@" ; }
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
clh () { echo -n > ~/.zsh_history && history -p && exec $SHELL -l; }
clha () { echo -n > ~/.zsh_history && history -p && rm -f ~/.bash_history; rm -f ~/.node_repl_history; rm -f ~/.python_history; exec $SHELL -l; }
clmac () { defaults delete com.apple.dock ; defaults write com.apple.dock ResetLaunchPad -bool true ; killall Dock ; echo "reseted dock and launchpad" ; }
cldock () { defaults delete com.apple.dock ; killall Dock ; echo "reseted dock" ; }
cllaunchpad () { defaults write com.apple.dock ResetLaunchPad -bool true ; killall Dock ; echo "reseted launchpad" ; }
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
pinga () { ping -a --apple-connect --apple-time "$@" ; }
macslp () {
	if [ "$#" -eq 1 ] ; then
		if [[ $1 =~ on ]] ; then sudo pmset -c disablesleep 0
		elif [[ $1 =~ off ]]; then sudo pmset -c disablesleep 1
		else echo "usage: macslp on/off " ; fi
	else echo "usage: macslp on/off " ; fi
}
if [ -d $ICLOUD_HOME ] ; then icloud () { cd $ICLOUD_HOME ; ls -A ; } ; fi
if [ -d $DROPBOX_HOME ] ; then dropbox () { cd $DROPBOX_HOME ; ls -A ; } ; fi
ip () { command ipconfig "$@" ; }
dif () { diff $1 $2 | bat -l diff ; }
dfr () { diff -u $1 $2 | diffr --line-numbers ; }
gsdif () { while [[ $# -gt 0 ]] ; do git show "${1}" | bat -l diff ; shift ; done ; }
gsdfr () { while [[ $# -gt 0 ]] ; do git show "${1}" | diffr --line-numbers ; shift ; done ; }
sy () { pbcopy < "$1" ; }
sp () { pbpaste > "$1" ; }
pwdc () { pwd | pbcopy ; }
shspeed () { if [ -z $1 ] ; then 1=1 ; fi ; for i in {1..$1} ; do /usr/bin/time $SHELL -i -c exit ; done ; }
p () {
	if [ $# -eq 0 ]; then cd ..
	elif [ $# -eq 1 ]; then
		if [[ $1 =~ '^[0-9]+$' ]]; then
			if [[ $1 == 0 ]]; then pwd
			else printf -v cdpFull '%*s' $1 ; cd "${cdpFull// /"../"}" ; fi
		elif [[ $1 =~ '^[y]+$' ]]; then pwd ; pwd | pbcopy
		elif [[ $1 =~ '^[p]+$' ]]; then pwd
		elif [[ $1 =~ '^[b]+$' ]] || [[ $1 == - ]]; then cd -
		elif [[ $1 =~ '^[r]+$' ]] || [[ $1 == / ]]; then cd /
		elif [[ $1 =~ '^[h]+$' ]] || [[ $1 == ~ ]]; then cd ~
		elif [[ $1 == ap ]] || [[ $1 == app ]] || [[ $1 == App ]]; then cd /Applications
		elif [[ $1 == ds ]] || [[ $1 == des ]] || [[ $1 == Des ]]; then cd ~/Desktop
		elif [[ $1 == dc ]] || [[ $1 == doc ]] || [[ $1 == Doc ]]; then cd ~/Documents
		elif [[ $1 == dw ]] || [[ $1 == dow ]] || [[ $1 == Dow ]]; then cd ~/Downloads
		elif [[ $1 == lb ]] || [[ $1 == lib ]] || [[ $1 == Lib ]]; then cd ~/Library
		elif [[ $1 == mv ]] || [[ $1 == mov ]] || [[ $1 == Mov ]]; then cd ~/Movies
		elif [[ $1 == ms ]] || [[ $1 == mus ]] || [[ $1 == Mus ]]; then cd ~/Music
		elif [[ $1 == pc ]] || [[ $1 == pic ]] || [[ $1 == Pic ]]; then cd ~/Pictures
		elif [[ $1 == pb ]] || [[ $1 == pub ]] || [[ $1 == Pub ]]; then cd ~/Public
		elif [[ $1 == cl ]] || [[ $1 == cld ]] || [[ $1 == Cld ]]; then
			if [ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ]; then cd "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ; else echo "p: wrong usage, try p -h" ; fi
		elif [[ $1 == db ]] || [[ $1 == drb ]] || [[ $1 == Drb ]]; then
			if [ -d "$HOME/Library/CloudStorage/Dropbox" ]; then cd "$HOME/Library/CloudStorage/Dropbox" ; else echo "p: wrong usage, try p -h" ; fi
		elif [[ $1 == --help ]] || [[ $1 == -help ]] || [[ $1 == -h ]]; then
			echo "p: change direcotry to parent directory"
			echo "p [number]: change direcotry to parent [number]th directory"
			echo "p p: output current directory"
			echo "p y: output current directory with copy"
			echo "p b, -: change direcotry to previous directory"
			echo "p r, /: change direcotry to root directory"
			echo "p h, ~: change direcotry to home directory"
			echo "p ap, app: change direcotry to applications directory"
			echo "p ds, des: change direcotry to desktop directory"
			echo "p dc, doc: change direcotry to documents directory"
			echo "p dw, dow: change direcotry to downloads directory"
			echo "p lb, lib: change direcotry to library directory"
			echo "p mv, mov: change direcotry to movies directory"
			echo "p ms, mus: change direcotry to music directory"
			echo "p pc, pic: change direcotry to pictures directory"
			echo "p pb, pub: change direcotry to public directory"
			echo "p cl, cld: change direcotry to icloud directory"
			echo "p db, drb: change direcotry to dropbox directory"
			echo "p -h: output usage"
		else echo "p: wrong usage, try p -h" ; fi
	else echo "p: wrong usage, try p -h" ; fi
}
jctl () {
	if [ "$#" -eq 0 ]; then /usr/libexec/java_home -V
	elif [ "$#" -eq 1 ]; then unset JAVA_HOME ; export JAVA_HOME=$(/usr/libexec/java_home -v "$1") ; java -version
	else echo "javahome: wrong usage" ; fi
}
dockerun () {
	if ! docker info > /dev/null 2>&1 ; then echo "dockerun false: Docker isn't running"
	else echo "dockerun true: Docker is running" ; fi
}
chicn () {
	if [ $# -eq 2 ]; then
		if [[ "$1" =~ ^https?:// ]] ; then curl -sLo /tmp/ic "$1" ; 1=/tmp/iconchange ; fi
		if ! [ -f $1 ]; then echo "chicn: cannot stat '$1': No such file"
		elif ! [ -d $2 ]; then echo "chicn: cannot stat '$2': No such directory"
		else
			sudo rm -rf "$2"$'/Icon\r'
			sips -i "$1" > /dev/null
			DeRez -only icns "$1" > /tmp/icnch.rsrc
			sudo Rez -append /tmp/icnch.rsrc -o "$2"$'/Icon\r'
			sudo SetFile -a C "$2"
			sudo SetFile -a V "$2"$'/Icon\r'
		fi
		rm -rf /tmp/icnch /tmp/icnch.rsrc
	else echo "chicn: wrong usage" ; fi
}
