#!/usr/bin/env bash
set -euo pipefail

if (( $# == 0 || $# % 2 == 0 )); then
  printf 'Usage: %s <output.csv> [<tool> <version-command>]...\n' "$0" >&2
  exit 2
fi

output=$1
shift
snapshot=$(mktemp "$output.XXXXXX")
trap 'rm -f "$snapshot"' EXIT

{
  printf 'Tool,Version\n'
  while [ "$#" -gt 0 ]; do
    name=$1
    version_output=$(bash -c "$2" </dev/null 2>/dev/null) || version_output=
    version_value=$(printf '%s\n' "$version_output" | sed -nE '1s/^[^0-9]*([0-9]+(\.[0-9]+)+[[:alnum:].+-]*).*/\1/p')
    version_value=${version_value:-∅}
    printf '"%s","%s"\n' "${name//\"/\"\"}" "${version_value//\"/\"\"}"
    shift 2
  done
} > "$snapshot"

chmod 644 "$snapshot"
mv "$snapshot" "$output"
printf '已更新 %s\n' "$output"
