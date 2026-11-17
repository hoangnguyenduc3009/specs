#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'HELP'
Usage: bash install.sh [--dest WORKSPACE] [--client codex|cursor|all] [--ref BRANCH_OR_TAG] [--dry-run]

Local checkout: use its install.py and skill sources.
Remote bootstrap: clone into WORKSPACE/mmd-sdd and keep it for skill symlinks.
Default destination: current directory. Requires Python 3; remote mode also needs Git.
--ref selects a remote branch/tag (default: repository default branch).
Existing remote destination is never overwritten or automatically updated.
HELP
}

die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

DEST="$PWD"
CLIENT=all
REF=""
DRY_RUN=0
REPO_URL="${MMD_SDD_REPO_URL:-https://github.com/hoangnguyenduc3009/specs.git}"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dest|--client|--ref)
      [ "$#" -ge 2 ] && [ -n "$2" ] || die "$1 requires a value"
      case "$1" in
        --dest) DEST="$2" ;;
        --client) CLIENT="$2" ;;
        --ref) REF="$2" ;;
      esac
      shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "Unknown option: $1" ;;
  esac
done

case "$CLIENT" in codex|cursor|all) ;; *) die "Invalid client: $CLIENT" ;; esac
command -v python3 >/dev/null 2>&1 || die 'Python 3 is required'
[ -d "$DEST" ] || die "Workspace does not exist: $DEST"
DEST="$(cd "$DEST" && pwd -P)"

SOURCE=""
SCRIPT_PATH="${BASH_SOURCE[0]:-}"
if [ -n "$SCRIPT_PATH" ] && [ -f "$SCRIPT_PATH" ]; then
  CANDIDATE="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd -P)"
  if [ -f "$CANDIDATE/scripts/install.py" ] && [ -d "$CANDIDATE/.cursor/skills/mmd-ba-clarify" ]; then
    SOURCE="$CANDIDATE"
  fi
fi

if [ -n "$SOURCE" ]; then
  [ -z "$REF" ] || die '--ref only applies to remote mode; select the local checkout version yourself'
else
  command -v git >/dev/null 2>&1 || die 'Git is required for remote installation'
  SOURCE="$DEST/mmd-sdd"
  if [ -e "$SOURCE" ] || [ -L "$SOURCE" ]; then
    die "$SOURCE already exists. Use its local scripts/install.sh after checking the source; nothing overwritten."
  fi
  if [ "$DRY_RUN" -eq 1 ]; then
    printf 'WOULD CLONE: %s (ref: %s) -> %s\n' "$REPO_URL" "${REF:-default branch}" "$SOURCE"
    printf 'WOULD INSTALL: client=%s in %s. Remote contents/conflicts not yet validated.\n' "$CLIENT" "$DEST"
    exit 0
  fi
  CLONE_ARGS=(--depth 1)
  if [ -n "$REF" ]; then CLONE_ARGS+=(--branch "$REF"); fi
  git clone "${CLONE_ARGS[@]}" -- "$REPO_URL" "$SOURCE"
  [ -f "$SOURCE/scripts/install.py" ] || die 'Clone lacks scripts/install.py; checkout retained for inspection'
fi

ARGS=(--dest "$DEST" --client "$CLIENT")
if [ "$DRY_RUN" -eq 1 ]; then ARGS+=(--dry-run); fi
exec python3 "$SOURCE/scripts/install.py" "${ARGS[@]}"
