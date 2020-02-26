#!/bin/bash

alias ls='ls --color=auto'

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

# --- git related stuff --- #

s='';
branchName='';

git rev-parse --is-inside-work-tree &>/dev/null || return;
branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null)"; 

# Check for uncommitted changes in the index.
if ! $(git diff --quiet --ignore-submodules --cached); then
	s+='+';
fi;
# Check for unstaged changes.
if ! $(git diff-files --quiet --ignore-submodules --); then
	s+='!';
fi;
# Check for untracked files.
if [ -n "$(git ls-files --others --exclude-standard)" ]; then
	s+='?';
fi;
# Check for stashed files.
if $(git rev-parse --verify refs/stash &>/dev/null); then
	s+='$';
fi;

[ -n "${s}" ] && s=" [${s}]";

# ------------------------- #

tput sgr0; # reset colors
bold=$(tput bold);
reset=$(tput sgr0);
black=$(tput setaf 0);
blue=$(tput setaf 33);
cyan=$(tput setaf 37);
green=$(tput setaf 64);
orange=$(tput setaf 166);
purple=$(tput setaf 125);
red=$(tput setaf 124);
violet=$(tput setaf 61);
white=$(tput setaf 15);
yellow=$(tput setaf 136);

userStyle="${bold}${yellow}";
hostStyle="${bold}${red}";

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]"; # working directory base name
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\] at ";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\W"; # working directory full path
PS1+="\[${white}\] on \[${violet}\]${branchName}\[${blue}\]${s}"; # git repository details
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
export PS1;
