# Git checkout
# This function uses fzy to select a branch to ceckout
# If the selected branch is the current, nothing happens
# If the selected branch does not yet exist, it will be created
__git_checkout() {
	local cmd="git branch -vv $1"
	# Get all branches remove `HEAD` and the current `*` branch
	local branches=$(eval "$cmd" | grep -v HEAD | grep -v '*' | sed "s/^[ \t]*//") 2> /dev/null
	# Pipe the all branches to fzy and select
	local branch=$(echo "$branches" | fzy --query="$2" | awk '{print $1}')
	# The name of the current branch `*`
	local current="$(git branch | grep '*' | awk '{print $2}')"
	# If anything was selected ...
	if [[ -n "$branch" ]] then
		# If the selected branch is in the list of all branches,
		# switch to that branch
		if [[ $(echo "$branches" | grep "$branch") ]] then
			git checkout "$branch"
		# The selected branch is alread checked out
		elif [[ "$current" == "$branch" ]] then
			echo "The branch $branch is already selected"
		# Create a new branch from the current
		else
			git checkout -b "$branch"
		fi
	fi
}

# Checkout from local branches
__git_checkout_local() {
	__git_checkout "" $1
}

# Checkout out from local and remote
__git_checkout_global() {
	__git_checkout "--all" $1
}

# Extended Git status
function g() {
	# Get the current branch name
	# Get all branches and print only the name of the current
	# (indicated with leading `*`)
	local branch="$(git branch --color  2>/dev/null | awk '/^\*/ {print $2}')"
	# Print the current branch name and append a short
	# status description, otherwise it's not a git repo
	[[ -n "$branch" ]] \
	       	&& echo "$branch" \
		&& eval "git status -s 2>/dev/null" \
	       	|| echo "Not a git Repository"
}

# Git commit
alias gc="git commit"
alias gca="gc --all"
alias gcam="gca --message"
alias gcamend="gc --amend"

# Git push
alias gp="git push"
alias gpu="gp -u "
alias gpup="gpu origin HEAD"

# Git merge
alias gm="git merge"
alias gmom "gm origin/master"
alias gmum "gm upstream/master"

# Git branch
alias gbd="git branch -D"

# Git status
alias gs="git status"

# Git checkout
alias gco="git checkout"
alias gcof="gco -f"
alias gcob="gco -b"
alias gcom="gco master"

# Git add
alias ga="git add"
alias gaa="ga --all"

# Git diff
alias gd="git diff"

# Git pull
alias gl="git pull"

# Git clone
alias gcl="git clone"
alias gc1="git clone --depth 1"

# Git log
alias glo="git log --oneline --graph --decorate"
alias gll="git log --pretty=full"

# vim:tw=80:ts=2:sw=2:expandtab
