#!/usr/bin/env bash
# Dot Pet installer: local checkout or GitHub owner/repo + optional ref.
set -euo pipefail
repo="${1:-}"
ref="${2:-main}"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
if [[ -n "$repo" ]]; then
  [[ "$repo" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] || { echo 'Expected GitHub OWNER/REPO' >&2; exit 1; }
  [[ "$ref" =~ ^[A-Za-z0-9._-]+$ ]] || { echo 'Ref must be a simple branch, tag, or commit SHA' >&2; exit 1; }
  source_dir="$work/source"
  mkdir -p "$source_dir"
  for file in pet.json spritesheet.webp SHA256SUMS; do
    curl --fail --silent --show-error --location --proto '=https' --tlsv1.2 \
      "https://raw.githubusercontent.com/$repo/$ref/pets/dot-pet/$file" -o "$source_dir/$file"
  done
else
  script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
  source_dir="$script_dir/pets/dot-pet"
fi
for file in pet.json spritesheet.webp SHA256SUMS; do
  [[ -s "$source_dir/$file" ]] || { echo "Missing or empty: $file" >&2; exit 1; }
done
if command -v shasum >/dev/null 2>&1; then
  (cd "$source_dir" && shasum -a 256 -c SHA256SUMS)
elif command -v sha256sum >/dev/null 2>&1; then
  (cd "$source_dir" && sha256sum -c SHA256SUMS)
else
  echo 'SHA-256 verification requires shasum or sha256sum.' >&2; exit 1
fi
pet_root="${CODEX_HOME:-$HOME/.codex}/pets"
destination="$pet_root/dot-pet"
mkdir -p "$pet_root"
stage="$(mktemp -d "$pet_root/.dot-pet-stage.XXXXXX")"
cp "$source_dir/pet.json" "$source_dir/spritesheet.webp" "$stage/"
if [[ -e "$destination" || -L "$destination" ]]; then
  backup="$pet_root/dot-pet.backup.$(date +%Y%m%d%H%M%S).$$"
  mv "$destination" "$backup"
  echo "Previous installation backed up: $backup"
fi
mv "$stage" "$destination"
printf '\nDot Pet installed: %s\nRestart Codex and select Dot Pet in the pet picker.\n' "$destination"
