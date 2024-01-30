#!/usr/bin/env bash

checkdeps() {
  set -eo pipefail; shopt -s inherit_errexit
  local pkgroot; pkgroot=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
  source "$pkgroot/.upkg/orbit-online/records.sh/records.sh"

  local deps=("$@") dep out ret=0
  for dep in "${deps[@]}"; do
    if ! out=$(type "$dep" 2>&1); then
      error "Dependency %s not found: %s" "$dep" "$out"
      ret=1
    fi
  done
  return $ret
}

checkdeps "$@"
