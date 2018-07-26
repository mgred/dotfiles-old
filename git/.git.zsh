#
# Select a branch on remote/local
#
__git_select_branch() {
  # Get all branches plus remote information
	local cmd="git branch -vv $2"
	# Remove `HEAD` and the current `*` branch
  # Trim leading whitespaces/tabs
	local branches=$(eval "$cmd" | grep -v HEAD | grep -v '*' | sed "s/^[ \t]*//") 2> /dev/null &&
	echo "$branches" | \
    # Filter information from output
    # Format:
    # <branchname> <commithash> [<remote>] <commitmessage>
    # Example:
    # master 123abcd [origin/master] Initial Commit
    #
    # Save the <branchname> from column $1
    # If a remote branch exists (column $3),
    # save this also to the output string
    # <branchname> [<remote>]
    awk '{a=$1} $3 ~ /\[*.\/*.\]/{a=a" "$3} {print a}' | \
    # Pipe to fzy to search the output
    fzy --query="$1" | \
    # Cut out only the <branchname>
    cut -d ' ' -f 1
}

#
# Checkout/Create branch from local branches
#
__git_checkout_local() {
  # Find a local branch by respecting the current
  # input (LBUFFER)
  local branch="$(__git_select_branch $LBUFFER)"
  # Check if a branch was selected
  [[ -n $branch ]] || return 1
  # If the branch has a revision
  if git rev-parse --verify "$branch" >/dev/null 2>&1
  then
    # Switch to it
    git checkout "$branch"
  else
    # Otherwise create it
    git checkout -b "$branch"
  fi
}

#
# Creat a branch from remote branches
#
__git_checkout_remote() {
  local branch=$(__git_select_branch "$LBUFFER" "-r")
  [[ -n $branch ]] || return 1
  git checkout -b $(echo $branch | cut -d '/' -f 2-) --track $branch
}

#
# Get Remote information for the current repository
#
__git_remotes() {
  local remotes=$(git remote -v | awk '{print $1" "$2}' | uniq)
  if [[ -n $remotes ]] then
    local a
    echo $remotes |
    while read line; do \
      local remote=$(echo $line | cut -d ' ' -f 1)
      local giturl=$(echo $line | cut -d ' ' -f 2)
      a=$a"${fg[yellow]}$remote${reset_color} $giturl\n"
    done
    echo $a
  fi
}

#
# Print information about the current repository
#
__git_info() {
  # Check if this is a Git Repository
  # https://stackoverflow.com/a/2180367/6578354
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 &&
  # Get Remote information
  local remotes="$(__git_remotes)" &&
  # If ther is something to show, do it
  echo ${remotes:-"No Remotes"} &&
  # Append a short status description
  git status -sb
}

__git_merge_remote() {
  local branch=$(git branch | grep '^\*' | sed 's/^\* //')
  git merge "$1/$branch"
}

# Print Repositor information,
# Remotes, Branch, Files
alias g="__git_info"

# Git commit
alias gc="git commit"
alias gca="git commit --all"
alias gcm="gc --message"
alias gcamend="gc --amend"

# Git push
alias gp="git push"
alias gpu="gp -u "
alias gpup="gpu origin HEAD"

# Git merge
alias gm="git merge"
alias gmo="__git_merge_remote 'origin'"
alias gmu="__git_merge_remote 'upstream'"

# Git branch
alias gbd="git branch -D"

# Git status
alias gs="git status"

# Git checkout
alias gco="git checkout"
alias gcf="gco -f"
alias gcb="gco -b"
alias gcm="gco master"

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

# Git rm
alias grm="git rm"
alias grm!="git rm -rf"

# Git remote
alias grt="git remote"
alias grtau="git remote add upstream"

# Git clean
alias gcn="git clean -d"
alias gcn!="gcn -f -x"

# Git mv
alias gmv="git mv"

# Gti fetch
alias gf="git fetch"
# Clean removed remote-tracking references (prune)
# Fetch all remotes
alias gff="git fetch --all --prune"

# vim:tw=80:ts=2:sw=2:expandtab
