#!/bin/bash

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin
export FZF_BASE=/path/to/fzf/install/dir

export FZF_BASE="/home/.fzf"

ZSH_THEME="agnoster"

plugins=(
  git
  zsh-autosuggestions
  vi-mode
  history-substring-search
  fzf
)

source $ZSH/oh-my-zsh.sh

# Colors:
# eval `dircolors ~/.dir_colors/dircolors`


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# source /home/cudayanh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# personal customization (START)

# add datetime-format for `history`
# HISTTIMEFORMAT="%F %T "
HISTTIMEFORMAT="%Y-%m-%d %T "

# lines number active history
HISTSIZE=200

# lines number of saved history
HISTFILESIZE=200

# colored variables for Prompt
blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset

# allow to use `vim` from command line
set -o vi

#------------ FUNCTION (start)

# global exception 
exception() {
	local man="my_alias"
	echo "EXCEPTION: invalid arguments. type $man for manuals."
}

# initialize maven project 
mk_mvn() {
  local group_id=$1 # com.thegreatapi.demolibrary
  local artifact_id=$2
  if [[ -n "$group_id" && -n "$artifact_id" ]]; then
	  command mvn archetype:generate -DgroupId=$group_id -DartifactId=$artifact_id -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false && cd $artifact_id && command mvn package
  else
	  exception
  fi
}

# initialize React project with template
mk_react() {
  local project=$1
  local template=$2

  if [[ -n "$project" && -n "$template" ]]; then
	  command npx create-react-app $project --template $template  # with TS
  elif [ -n "$project" ]; then
	  command npx create-react-app $project # JS for default
  else
	  exception
  fi
}

# initialize Node project with ExpressJS
mk_node() {
  local dir=$1
  if [ -n "$dir" ]; then
	  mkdir $dir && cd $dir && command npm init -y && touch "index.js" && command npm install "express.js"
  else
	  exception
  fi
}

# grep search `process_name`
hg() {
    history | grep "$1";
}

# git init
git_init() {
    if [ -z "$1" ]; then
		git init && touch README.md .gitignore LICENSE;
    else
        mkdir $1 && cd $1 && pwd && git init;
        touch README.md .gitignore LICENSE;
        echo "# $(basename $PWD)" >> readme.md
    fi
}

# get current git branch
git_br() {
    if [ -d .git ] ; then
        printf "%s" "($(git branch 2> /dev/null | awk '/\*/{print $2}'))";
    fi
}

# basic HTTP request with CURL
curl_do() {
  local method=$1 
  local url=$2 
  local body=$3

  case $method in
    "GET")
      command curl -v "http://$url" | json ;;
    "DELETE")
      command curl -v -X $method "http://$url" | json ;;
    "PUT")
      command curl -v -X $method "http://$url" -H "Content-Type: application/json" -d $body | json ;;
    "POST")
      command curl -v -X $method "http://$url" -H "Content-Type: application/json" -d $body | json ;;
    *)
      echo "Exception: invalid HTTP request: $method"
	  echo "E.g. curl_do <GET | DELETE | PUT | POST> <host>:<port> [OPTIONS]"
	  return 1
      ;; 
  esac
}

# find and remove file/fodler
find_rm() {
  local dir=$1
  local type=$2
  local pattern=$3

  case $type in
    "f") 
        find $dir -type $type -name "*$pattern*" -delete ;; 
    "d")
        find $dir -type $type -name "*$pattern*" -delete ;;
    *)
      echo "ERROR: invalid type (only accept `f` or `d`)" 
      echo "E.g. find_rm <location> <f | d> <pattern>"
      return 1
    ;;
  esac
}

# get tree structure of folder
dir_tree() {
  find $1 -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

# get PID from given port
pid() {
  local port=$1
  local process_id=$(lsof -t -i :${port}) # this also works (get PID alone, only PID)
  echo $process_id
}

# get very detailed about the process running on given port
p_info() {
   local port=$1
   # local process=$(lsof -i :${port} | tail -n +2 | awk '{ print $1" "$2" "$3" "$4" "$5 }') # get three columns
   local process=$(lsof -i :${port} | awk '{ print $1" "$2" "$3" "$4" "$5 }') # get three columns
   if [ -z "$process" ]; then
	   echo "No process running on port $port"
	   return 1
   fi 
   # local process=(lsof -i :${port} | tail -n +2 | awk '{ print $1" "$2" "$3 }') # get three columns
   echo $process
}

# find PID of particular process running on given port and kill it
kill_port() {
  local port=$1
  local process_id=$(lsof -t -i :${port}) #  (get PID alone, only PID)
  # local process_id=(lsof -i :${port} | tail -n +2 | awk '{ print $1}') # get first one column
  # local process_id=(lsof -i :${port} | tail -n +2 | awk '{ print $1" "$2" "$3 }') # get two columns
  # local process_id=(lsof -i :${port} | tail -n +2 | awk '{ print $1" "$2" "$3 }') # get three columns
  
  if [ -n "$process_id" ]; then
    echo "Process running on port $port with ID $process_id. Killing process..."
    kill $process_id
    # verify whether $PID was killed 
    sleep 1
    if kill -0 $process_id >/dev/null 2>&1; then
      echo "Failed to kill process with ID $process_id."
      exit 1
    else
      echo "Process with ID $process_id killed successfully."
    fi
  else
    echo "No process found running on port $port."
    exit 1
  fi
}

# basic file transfer using SCP
scp_do() {
  local file=$1
  local body=$2
  if [[ -n "$file" && -n "$host"  &&  -n "$path" ]]; then 
    command scp -v $file $body
  else 
    exception
	echo "E.g. scp_do <file> <body>"
  fi
}

# archiving file as *.tar and compress it using gzip
targz_c() {
	local name=$1
	local dir=$2
	if [[ -n "$name" && -n "$dir" ]]; then
		command tar -czvf "${name}.tar.gz" $dir
	elif [ -n "$name" ]; then
		command tar -czvf "${name}.tar.gz" 
	else
		exception
		echo "E.g. tar_ <name> <dir>"
	fi
}

# decompress files 
targz_d() {
	local name=$1
	local dir=$2
	if [[ -n "$name" && -n "$dir" ]]; then 
		# extract files to specific dir
		command tar -xzf "${name}" -C $dir
	elif [ -n "$name" ]; then
		command tar -xzf "${name}"
	else
		exception
		echo "E.g. tar_d <name> -C <dir>"
	fi 
}

# install package 
apt_i() {
	local pkg=$1
	if [ -n "$pkg" ]; then 
		command sudo apt update && sudo apt-get install $pkg
	else
		exception
	fi
}

# remove installed package
apt_rm() {
	local pkg=$1
	if [ -n "$pkg" ]; then 
		command sudo apt remove $pkg
	else
		exception
		echo "E.g. apt_rm <package_name>"
	fi
}

# check current avaiable disk space 
disk_c() {
	local dir=$1
	if [ -n "$dir" ]; then
		command df -h 
	else
		command df -h $dir
	fi
}

#------------------ Function (end)


#------------------ Alias (start)

# NETSTAT

# List TCP Listening ports && List all statistic of those ports
alias tcp_active='echo "> Here are TCP Listening ports:\n" && netstat -at && echo "\n> Statistics for all ports:" && netstat -st' 

# List UDP Listening ports && List all statistic of those ports
alias udp_active='echo "> Here are UDP Listening ports:\n" && netstat -au && echo "\n> Statistics for all ports:" && netstat -su' 

# List UNIX Listening ports && List all statistic of those ports
alias unix_active='echo "> Here are UNIX Listening ports:\n" && echo "\n> Statistics for all ports:" && netstat -lx' 

# Find all listening programs
alias active_all='echo "> Here are all listening programs:\n" && netstat -lp' 

alias active_port='sudo lsof -i -P -n'

# get currnet largest file
alias largest_files='du -h -x -s -- * | sort -r -h | head -20'

# get all current system users
alias sys_users='cut -d: -f1 /etc/passwd | sort'

# view Git status
alias gs='git status'

# add a file to Git
alias ga='git add'

# add all files to Git
alias gaa='git add --all'

# commit changes to the code
alias gc='git commit'

# view the Git log
alias gl='git log --oneline'

# git log pretty with format
alias glp='git log --pretty=format:"%h - %an, %ar : %s"'

# create a new Git branch and move to the new branch at the same time 
alias gb='git checkout -b'

# view the difference
alias gd='git diff'

# press c to clear the terminal screen
alias c='clear'

# press h to view the bash history
alias h='history'

# display the directory structure better
alias tree='tree --dirsfirst -F'

# make a directory and all parent directories with verbosity
alias mkdir='mkdir -p -v'

# check all current installed packges
alias apt_l='echo "Here are your installed packages\n:" && apt list --installed'

# view specific calendar 
alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'

alias my_alias='echo " 
  > FUNCTIONS: 
  $ curl_do(): perform Curl HTTP request (E.g. curl_action <GET | POST | PUT | DELETE> <url> <body>)\n
  $ find_rm(): find file/dir and remove by its pattern (E.g. find_rm <location> <f | d> <pattern>)\n
  $ dir_info(): get target directory info tree (E.g. dir_info <dir>)\n
  $ pid(): get PID of process running on port (E.g. pid <port> )\n
  $ p_info(): get PID of process running on port (E.g. pid <port> )\n
  $ kill_port(): kill process running on specific port (E.g. kill_port <port>)\n
  $ scp_do(): send file over network (E.g. scp_action <file> <host>:<pathToReceive>)\n
  $ targz_c(): compress and zip files as *.tar.gz (E.g. targz_c <filename> <dir> )\n
  $ targz_d(): decompress and unzip *.tar.gz files (E.g. targz_d <filename> <dir> ) \n
  $ apt_i(): install specific package (E.g. apt_i <pkg_name>)\n
  $ apt_rm(): remove installed specific package (E.g. apt_rm <pkg_name>)\n
  $ disk_c(): check current available disk space from specific dir (disk_c <dir>)\n

  > ALIASING:
  $ win_info: get windows info (IPv4, IPv6, default gateway)\n 
  $ tcp_active: list all TCP active connections and statistic information\n
  $ udp_active: list all UDP active connections statistic information\n
  $ active_unix: list all UNIX active connections statistic information\n
  $ active_port: list all  active connections\n
  $ largest_files: get top 20 largest files\n 
  $ sys_users: list all currently system users\n 
  $ id: view users detailed information (E.g. id <user> )\n
  $ active_port: list all currently active port\n 
  $ apt_list: list all installed packages\n
  $ gs: git status\n
  $ gc: git commit\n
  $ gl: git log --oneline\n
  $ gb: git checkout -b\
  $ gd: git diff\n
  $ c: clear (screen)\n
  $ h: history\n
  $ mkdir: mkdir -p -v
  $ jan: get january\n
  $ feb: ... \n
  $ mar: ... \n
  $ apr: ... \n
  $ may: ... \n
  $ jun: ... \n
  $ jul: ... \n
  $ aug: ... \n
  $ sep: ... \n
  $ oct: ... \n
  $ nov: ... \n
  $ dec: ... \n
"'
#------------ Alias (END)

