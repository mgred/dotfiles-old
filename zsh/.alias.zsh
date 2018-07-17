find_dir() {
	find . -type d
}

__change_dir() {
	local dir="$(find_dir | fzy --query=$1)"
	cd "$dir"
}
alias c="cd -"
alias cc="__change_dir"

# ls
# Colorised output
alias ls="ls --color='always'"
# Sort with dirs first, show only the name
alias l="ls -1h --group-directories-first"
alias la="l --all"

# Tree
# Print with colors and print dirs first
alias lt="tree -C --dirsfirst"
# Only one level deep
alias lt1="lt -L 1 --dirsfirst"
# Print all files, also hidden
alias ltaa="lt -a"
# Ignore `.git` dir
alias lta="ltaa -I '\.git|node_modules'"

# less pager
# set -r to properly color output
alias less="less -r"
# set lesspipe to color output
#LESSOPEN="|~/./zsh/lesspipe.sh/lesspipe.sh %s"; export LESSOPEN
#LESSOPEN="| lesspipe %s"; export LESSOPEN

# vim:tw=80:ts=2:sw=2:expandtab
