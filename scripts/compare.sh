#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ] || [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
  printf 'Usage: %s <repo-path> <local-path>\n' "$0" >&2
  exit 2
fi

repo_path=$1
local_path=$2
while [[ "$repo_path" != / && "$repo_path" == */ ]]; do
  repo_path=${repo_path%/}
done
while [[ "$local_path" != / && "$local_path" == */ ]]; do
  local_path=${local_path%/}
done

find -H "$repo_path" -type f -print0 | LC_ALL=C sort -z | while IFS= read -r -d '' repo_file; do
  relative_path=${repo_file#"$repo_path"}
  local_file=$local_path
  if [ -n "$relative_path" ]; then
    local_file="${local_path%/}/${relative_path#/}"
  fi
  if [ -f "$local_file" ]; then
    code --diff "$repo_file" "$local_file" </dev/null
  else
    if [ -d "$local_file" ]; then
      printf '! 本地路径是目录：%s\n' "$local_file"
    else
      printf '∅ 本地不存在：%s\n' "$local_file"
    fi
    code "$repo_file" </dev/null
  fi
done
