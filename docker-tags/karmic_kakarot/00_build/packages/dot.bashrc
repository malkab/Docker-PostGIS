# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Prompt
export PS1="\u@\h:\w$ "

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some more aliases
alias la='ls -hA'
alias l='ls -CF'
alias ll='ls -lAh -v -w 0 --color=auto --group-directories-first'
alias dfh='df -h'
alias drl='dir -lh'
alias duh='du -h -s'
alias lesss='less -S'
alias fzf='fzf --multi --cycle --layout=reverse --inline-info'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Environment
export PAGER='less -iMSx4 -FX'
export ALTERNATE_EDITOR=''
export PGCLIENTENCODING='UTF-8'
export TERM=screen-256color
export EDITOR=vim

# bat
alias bat="bat --theme=\"ansi\""

# fzf
export FZF_DEFAULT_COMMAND='fdfind --type f --color=never --hidden --no-ignore'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --theme=\"ansi\" --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fdfind --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

fshow() {
	  git log --graph --color=always \
		  --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
	  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
			        --bind "ctrl-m:execute:
	                  (grep -o '[a-f0-9]\{7\}' | head -1 |
				                  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
			                  {}
					  FZF-EOF"
}

# fzf
eval "$(fzf --bash)"
