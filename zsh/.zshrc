export KEYTIMEOUT=1

# Local directory for executables
export PATH=$PATH:$HOME/.bin

# Enable vi mode
bindkey -v
bindkey '^x' clear-screen

# Load colors to customise the prompt
autoload colors && colors

# Load aliases
source ~/.go.zsh
source ~/.alias.zsh
source ~/.git.zsh

# Append a new line to every prompt
PROMPT=""$'\n'

# Change cursor depending on vi mode of zsh
# https://unix.stackexchange.com/questions/433273/changing-cursor-style-based-on-mode-in-both-zsh-and-vim
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
      echo -ne '\e[5 q'
  fi
}

# Activate the widget
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec()
{
  echo -ne '\e[5 q'
}

function find_file {
  find . -type f 2>/dev/null
}

function __select_file {
  local file=$(find_file | fzy)
  LBUFFER="${LBUFFER} $file"
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $?
}
zle -N __select_file
bindkey '^f' __select_file

function __open_in_vim {
  local file=$(find_file | fzy)
  # if a file was selected, pass it to vim
  # Tell vim to read from /dev/tty, since this is default of fzy
  [[ -n $file ]] && vim $file < /dev/tty
}
zle -N __open_in_vim
bindkey '^n' __open_in_vim

function __select_history {
  # 1. Get all entries from the history (from position 0)
  # 2. Strip of the entry number and replace leading whitespace/tabs
  # 3. Sort the list and filter out duplicates (-u)
  local cmd=$(history 0 | awk '{$1="";gsub(/^[ \t]+/,"",$0); print $0;}' | sort -u | fzy)
  # Put the command on the prompt line
  LBUFFER="$cmd"
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $?
}
zle -N __select_history
bindkey '^r' __select_history

zle -N __git_checkout_local
bindkey '^g' __git_checkout_local

zle -N __git_checkout_global
bindkey "^g^g" __git_checkout_global

# Set default executable
ENHANCD_FILTER="fzy"
# Make `cd` change to $HOME
ENHANCD_HOME_ARG=1
export ENHANCD_FILTER
source ~/github/enhancd/init.sh

# History options
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.history

# Share the history across sessions and terminals
setopt share_history

# vim:tw=80:ts=2:sw=2:expandtab
