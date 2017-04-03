shopt -s nullglob
shopt -s globstar

slugify() {
    echo -en "$@" | tr -c '[:alnum:]_.-' '-'
}

[ -z "$PS1" ] && return

# If not running interactively, don't do anything
PS1="\u@\h:\w $ "
