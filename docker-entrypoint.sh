#!/usr/bin/env bash
set -eo pipefail

export LC_COLLATE=C
export LANG=C

slugify() {
    echo -en "$@" | tr -c '[:alnum:]_.-' '-'
}

exec "$@"
