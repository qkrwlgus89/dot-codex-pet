#!/usr/bin/env bash
set -euo pipefail
repo="${1:-}"
[[ "$repo" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] || { echo 'Usage: bash scripts/configure-repository.sh OWNER/REPO' >&2; exit 1; }
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
sed "s|OWNER/REPO|$repo|g" "$root/docs/README.template.md" > "$root/README.md"
echo "README configured for https://github.com/$repo"
