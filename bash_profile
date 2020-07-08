# Docker Aliases
alias dockerrmvblank='docker rmi $(docker images | grep "^<none>" | awk "{print $3}") --force'

# Git Aliases
alias co='git checkout'
alias cob=gitcob
alias pushall=gitpush
alias push='git push'
alias pull='git pull'
alias cm='git commit -m'
alias status='git status'

function gitcob(){
   git checkout -b $1 && git push -u origin $1
}
function refresh () {
	source  ~/.bash_profile
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
function cleanlocalbranches() {
	typeset var quiet
	typeset var force
	force="-d"

	for arg in $*
	do
		if [ "$DEBUG" == "true" ]
		then
			echo "processing argument: $arg"
		fi
		case $arg in
			-quiet|-q) 
				echo "quiet processing enabled, automatic deletion of local branches that do not exist in the remote is enabled. No prompts will occur."
				quiet=true
				;;
			-force|-f) 
				echo "forcing deletion of all local branches that do not exist in the remote repo, including unmerged branches using: git branch -D"
				force="-D"
				;;
		esac
	done	

	gitfetch
	localbranches=`git branch --format "%(refname:short)"`
	for branch in $localbranches
	do
		echo ""
		echo "Checking if local branch ${branch} exists in remote repo"
		if [[ "${branch}" == "master" ]] || [[ "${branch}" == "develop" ]];
		then
			echo "skipping protected ${branch} branch"
			continue
		fi
		remotebranch=$(git branch -r | grep ${branch})
		if [[ -z "${remotebranch}" ]]; 
		then
			if [[ -z "$quiet" ]];
			then
				while true; do
						read -p "Branch ${branch} does not exist in the remote repo, would you like to delete the local branch? (n*/y)" yn
						case $yn in
								[Yy]* )
									git branch ${force} ${branch}
									echo "deleted local ${branch} branch"; 
									break
									;;
								* )
									echo "not deleting local ${branch} branch"; 
									break
									;;
						esac
				done
			else 
				git branch ${force} ${branch}
				echo "deleted local ${branch} branch"; 
			fi
		else
			echo "Branch ${branch} exists in remote repo, skipping"
		fi
	done

}
function gitfetch() {
	echo "executing: git fetch -p origin"
	git fetch -p origin
}
