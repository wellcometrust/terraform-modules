#!/usr/bin/env bash

set -o errexit
set -o nounset

if which terraform >/dev/null 2>&1
then
  terraform "$@"
else
  docker run --rm --tty hashicorp/terraform "$@"
fi
