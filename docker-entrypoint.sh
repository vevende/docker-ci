#!/usr/bin/env bash
set -eo pipefail

eval $(ssh-agent -s)

if [ ! -z "$SSH_PRIVATE_KEY" ]; then
    ssh-add <(echo "$SSH_PRIVATE_KEY");
fi

exec "$@"
