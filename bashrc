# If not running interactively, don't do anything

[ -z "$PS1" ] && return

shopt -s nullglob
shopt -s globstar

PS1="\u@\h:\w $ "

export LC_COLLATE=C
export LANG=C
