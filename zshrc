
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="Lukerandall"
plugins=(git)
source $ZSH/oh-my-zsh.sh

alias dockerrmvblank='docker rmi $(docker images | grep "^<none>" | awk "{print $3}") --force'

# Git Aliases
alias co='git checkout'
alias cob=gitcob
alias pushall=gitpush
alias pa=gitpush
alias push='git push'
alias pull='git pull'
alias cm='git commit -m'
alias status='git status'
alias pip='pip3'
alias python='python3'

# VS Code
alias code='open -b com.microsoft.VSCode "$@"' # Prevents duplicate VS Codes in Dock

# AWS
export AWS_ACCESS_KEY_ID=todo123
export AWS_SECRET_ACCESS_KEY=todo123
export AWS_DEFAULT_REGION=us-east-1
export projects=~/Documents/Projects
export GITHUB_TOKEN=todo123
export TWILIO_ACCOUNT_SID=abc123
export TWILIO_AUTH_TOKEN=xyz123
export SENDER_NUMBER="+1234567890"
export TF_VAR_twilio_account_sid=$TWILIO_ACCOUNT_SID
export TF_VAR_twilio_auth_token=$TWILIO_AUTH_TOKEN
export TF_VAR_sender_number=$SENDER_NUMBER
export AWS_DEFAULT_REGION=us-east-1

# PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"


export JAVA_HOME=$(/usr/libexec/java_home -v 17)
jdk() {
	version=$1
	export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
	java -version
}
# For the system Java wrappers to find this JDK, symlink it with
#  sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
# echo 'export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"' >> ~/.zshrc
# sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk

# Python Alias
# alias python=python3

export NVM_DIR="$HOME/.nvm"
function load_nvm() {  
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

function gitcob(){
   git pull && git checkout -b $1 && git push -u origin $1
}
function refresh () {
	source  ~/.zshrc
}
function branches() {
	git branch -a
}

function gitstatus() {
	git status
}
gitpush() {
    git add .
    git commit -m "$*"
    git push
}

function git_delete_branch() {
	git branch -D $1
	git push -u origin -d $1
}

function cleanlocalbranches() {
	git fetch -p ; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D
}

function gitfetch() {
	echo "executing: git fetch -p origin"
	git fetch -p origin
}

# source ~/.git-bash-for-mac.sh
# eval "$(/opt/homebrew/bin/brew shellenv)"