#!/usr/bin/env python3
"""Link local mmd-sdd skills into a workspace without overwriting existing files."""

import argparse
import os
from pathlib import Path
import sys


def install():
    hub = Path(__file__).resolve().parent.parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dest", type=Path, default=hub.parent,
                        help="Existing workspace root (default: parent of mmd-sdd)")
    parser.add_argument("--client", choices=("codex", "cursor", "all"), default="all")
    parser.add_argument("--dry-run", action="store_true", help="Check and preview without writes")
    args = parser.parse_args()
    workspace = args.dest.expanduser().resolve()
    if not workspace.is_dir():
        parser.error(f"Workspace does not exist: {workspace}")

    clients = {"codex": ".agents", "cursor": ".cursor"}
    selected = clients if args.client == "all" else {args.client: clients[args.client]}
    sources = [hub / ".cursor" / "skills" / name
               for name in ("mmd-ba-clarify", "mmd-challenge-change")]
    pending = []
    existing = []
    conflicts = []
    for source in sources:
        if not (source / "SKILL.md").is_file():
            parser.error(f"Missing skill source: {source}")
        for folder in selected.values():
            destination = workspace / folder / "skills" / source.name
            for parent in (workspace / folder, destination.parent):
                if parent.is_symlink():
                    conflicts.append(f"Parent is a symlink: {parent}")
                elif parent.exists() and not parent.is_dir():
                    conflicts.append(f"Parent is not a directory: {parent}")
            if destination.is_symlink() or destination.exists():
                try:
                    same = destination.resolve(strict=True) == source.resolve(strict=True)
                except (OSError, RuntimeError):
                    same = False
                if same:
                    existing.append(destination)
                else:
                    conflicts.append(f"Destination already exists: {destination}")
            else:
                pending.append((source, destination))

    if conflicts:
        for conflict in dict.fromkeys(conflicts):
            print(f"CONFLICT: {conflict}", file=sys.stderr)
        print("Nothing changed. Resolve conflicts manually; no force overwrite is supported.",
              file=sys.stderr)
        return 1

    for destination in existing:
        print(f"OK: {destination}")
    for source, destination in pending:
        target = os.path.relpath(source, destination.parent)
        if args.dry_run:
            print(f"WOULD LINK: {destination} -> {target}")
        else:
            destination.parent.mkdir(parents=True, exist_ok=True)
            destination.symlink_to(target, target_is_directory=True)
            print(f"LINKED: {destination} -> {target}")
    print(f"{'Preview' if args.dry_run else 'Done'}: {len(pending)} new, {len(existing)} existing.")
    print(f"Keep this source hub available: {hub}")
    if workspace != hub and workspace / hub.name != hub:
        print("For this workspace, provide the source hub path when invoking the skills.")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(install())
    except OSError as error:
        print(f"Install failed: {error}. Some links may already exist; safe to rerun.",
              file=sys.stderr)
        sys.exit(1)
