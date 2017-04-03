#!/usr/bin/env bash
set -eo pipefail

slugify() {
    echo -en "$@" | tr -c '[:alnum:]_.-' '-'
}

exec "$@"
