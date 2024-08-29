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

# Locale
LANG=es_ES.UTF-8
LANGUAGE=es:en
LC_CTYPE="es_ES.UTF-8"
LC_NUMERIC=es_ES.UTF-8
LC_TIME=es_ES.UTF-8
LC_COLLATE="es_ES.UTF-8"
LC_MONETARY=es_ES.UTF-8
LC_MESSAGES="es_ES.UTF-8"
LC_PAPER=es_ES.UTF-8
LC_NAME=es_ES.UTF-8
LC_ADDRESS=es_ES.UTF-8
LC_TELEPHONE=es_ES.UTF-8
LC_MEASUREMENT=es_ES.UTF-8
LC_IDENTIFICATION=es_ES.UTF-8
LC_ALL=

# Environment
export PAGER='less -iMSx4 -FX'
export ALTERNATE_EDITOR=''
export PGCLIENTENCODING='UTF-8'
export TERM=screen-256color
export EDITOR=vim
