#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -al'
alias v='nvim'

# opencode
export PATH=/home/sampaio/.opencode/bin:$PATH

eval "$(starship init bash)"
