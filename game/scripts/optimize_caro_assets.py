"""Resize Caro WebP assets to roughly 2x their maximum rendered size.

Requires Pillow with WebP support. Decorative UI assets remain lossless after
resizing; full-screen/background images use high-quality lossy WebP.
"""

from __future__ import annotations

import argparse
import os
from pathlib import Path

from PIL import Image


ASSET_ROOT = Path(__file__).resolve().parents[1] / "caro" / "assets"

# Widths are approximately twice the largest CSS-rendered width in a 520px
# game viewport. Keeping this explicit makes future oversized exports obvious.
TARGET_WIDTHS: dict[str, int] = {
    # Lobby
    "lobby/bg.webp": 941,
    "lobby/avatar-frame.webp": 320,
    "lobby/name-frame.webp": 520,
    "lobby/ken-frame.webp": 640,
    "lobby/ic-ken.webp": 96,
    "lobby/btn-plus.webp": 128,
    "lobby/ic-plus.webp": 64,
    "lobby/mode-frame.webp": 640,
    "lobby/ic-bot.webp": 128,
    "lobby/ic-ranked.webp": 128,
    "lobby/bottom-frame.webp": 900,
    "lobby/ic-history.webp": 96,
    "lobby/ic-leaderboard.webp": 96,
    "lobby/ic-exit.webp": 96,
    "lobby/pick-bg.webp": 760,
    "lobby/pick-title.webp": 760,
    "lobby/pick-level.webp": 480,
    "lobby/pick-close.webp": 96,
    "lobby/pick-x.webp": 64,
    "lobby/confirm-bg.webp": 860,
    "lobby/confirm-title.webp": 450,
    "lobby/confirm-door.webp": 200,
    "lobby/btn-red.webp": 400,
    "lobby/btn-navy.webp": 400,
    # Ranked room list
    "ranked/bg.webp": 941,
    "ranked/title-frame.webp": 860,
    "ranked/ic-cup.webp": 160,
    "ranked/table.webp": 936,
    "ranked/slot-open.webp": 560,
    "ranked/slot-full.webp": 560,
    "ranked/ic-lock.webp": 64,
    "ranked/page-btn.webp": 112,
    "ranked/menu-btn.webp": 220,
    # Board
    "board/bg.webp": 941,
    "board/board-frame.webp": 960,
    "board/x.webp": 64,
    "board/o.webp": 64,
    "board/timer-frame.webp": 300,
    "board/timer-frame-mine.webp": 300,
    "board/turn-left.webp": 200,
    "board/turn-right.webp": 200,
    "board/avatar-frame.webp": 200,
    "board/menu-btn.webp": 320,
    "board/ic-forfeit.webp": 64,
    "board/chat-frame.webp": 960,
    "board/chat-frame-clean.webp": 960,
    "board/btn-send.webp": 64,
    "board/send-icon.webp": 64,
    "board/reaction-icon.webp": 128,
    # Create/join room modal
    "create/panel.webp": 760,
    "create/title-frame.webp": 760,
    "create/label-frame.webp": 500,
    "create/input-frame.webp": 600,
    "create/btn-ok.webp": 260,
    "create/btn-close.webp": 104,
    "create/ic-x.webp": 64,
    "create/ic-password-lock.webp": 72,
    "create/ic-password-eye.webp": 96,
    # Match result
    "result/bg.webp": 660,
    "result/title-frame.webp": 480,
    "result/cup-win.webp": 320,
    "result/cup-lose.webp": 320,
    "result/brush-win.webp": 580,
    "result/brush-lose.webp": 580,
    "result/ken-frame.webp": 450,
    "result/ic-ken.webp": 64,
    "result/btn-close.webp": 360,
    "result/btn-replay-win.webp": 400,
    "result/btn-close-win.webp": 320,
    "result/btn-replay-lose.webp": 400,
    "result/btn-close-lose.webp": 320,
    # Leaderboard
    "leaderboard/panel.webp": 880,
    "leaderboard/title-frame.webp": 580,
    "leaderboard/cup.webp": 96,
    "leaderboard/close-frame.webp": 96,
    "leaderboard/close-x.webp": 48,
    "leaderboard/tab-active.webp": 320,
    "leaderboard/tab-inactive.webp": 320,
    "leaderboard/rank-1.webp": 128,
    "leaderboard/rank-2.webp": 128,
    "leaderboard/rank-3.webp": 128,
    "leaderboard/rank-4.webp": 128,
    "leaderboard/rank-5-violet.webp": 128,
    "leaderboard/rank-6-emerald.webp": 128,
    "leaderboard/rank-7-crimson.webp": 128,
    "leaderboard/rank-8-cyan.webp": 128,
    "leaderboard/rank-9-magenta.webp": 128,
    "leaderboard/rank-10-graphite.webp": 128,
    "leaderboard/page-arrow.webp": 96,
    "leaderboard/page-number.webp": 96,
    "leaderboard/divider.webp": 760,
    "leaderboard/ken.webp": 64,
    # History
    "history/panel.webp": 860,
    "history/title-frame.webp": 500,
    "history/icon.webp": 80,
    "history/close-frame.webp": 96,
    "history/close-x.webp": 48,
    "history/table.webp": 760,
    "history/page-btn.webp": 96,
    "history/ken.webp": 64,
    # Reactions are already exported at 64px and need no resize.
    "reactions/like.webp": 64,
    "reactions/love.webp": 64,
    "reactions/haha.webp": 64,
    "reactions/wow.webp": 64,
    "reactions/sad.webp": 64,
    "reactions/angry.webp": 64,
}

LOSSY_BACKGROUNDS = {
    "lobby/bg.webp",
    "lobby/pick-bg.webp",
    "lobby/confirm-bg.webp",
    "ranked/bg.webp",
    "ranked/table.webp",
    "board/bg.webp",
    "board/board-frame.webp",
    "board/chat-frame.webp",
    "board/chat-frame-clean.webp",
    "create/panel.webp",
    "result/bg.webp",
    *(f"leaderboard/{name}" for name in (
        "panel.webp", "title-frame.webp", "cup.webp", "close-frame.webp", "close-x.webp",
        "tab-active.webp", "tab-inactive.webp", "rank-1.webp", "rank-2.webp", "rank-3.webp",
        "rank-4.webp", "rank-5-violet.webp", "rank-6-emerald.webp", "rank-7-crimson.webp",
        "rank-8-cyan.webp", "rank-9-magenta.webp", "rank-10-graphite.webp", "page-arrow.webp",
        "page-number.webp", "divider.webp", "ken.webp",
    )),
    *(f"history/{name}" for name in (
        "panel.webp", "title-frame.webp", "icon.webp", "close-frame.webp", "close-x.webp",
        "table.webp", "page-btn.webp", "ken.webp",
    )),
}


def optimize(path: Path, target_width: int, dry_run: bool) -> tuple[int, int, tuple[int, int], tuple[int, int]]:
    relative = path.relative_to(ASSET_ROOT).as_posix()
    before = path.stat().st_size
    source_chunk = path.read_bytes()[12:16]
    with Image.open(path) as source:
        source.load()
        old_size = source.size
        width = min(source.width, target_width)
        height = round(source.height * width / source.width)
        image = source if (width, height) == source.size else source.resize((width, height), Image.Resampling.LANCZOS)

        if dry_run:
            return before, before, old_size, image.size

        # Avoid generation loss when rerunning the utility on an asset that is
        # already at its target size and already uses lossy/extended WebP.
        if relative in LOSSY_BACKGROUNDS and source_chunk != b"VP8L" and image.size == old_size:
            return before, before, old_size, image.size

        temporary = path.with_name(f".{path.stem}.optimized.webp")
        try:
            if relative in LOSSY_BACKGROUNDS:
                quality = 84 if relative.endswith("/bg.webp") else 89
                image.save(temporary, "WEBP", lossless=False, quality=quality, method=6)
            else:
                image.save(temporary, "WEBP", lossless=True, method=6, exact=True)
            after = temporary.stat().st_size
            os.replace(temporary, path)
        finally:
            temporary.unlink(missing_ok=True)
        return before, after, old_size, image.size


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    actual = {path.relative_to(ASSET_ROOT).as_posix() for path in ASSET_ROOT.rglob("*.webp")}
    configured = set(TARGET_WIDTHS)
    if actual != configured:
        missing = sorted(actual - configured)
        stale = sorted(configured - actual)
        raise SystemExit(f"Asset map mismatch. Missing={missing}; stale={stale}")

    total_before = 0
    total_after = 0
    for relative, target_width in TARGET_WIDTHS.items():
        before, after, old_size, new_size = optimize(ASSET_ROOT / relative, target_width, args.dry_run)
        total_before += before
        total_after += after
        if old_size != new_size or before != after:
            print(f"{relative:42} {old_size!s:14} -> {new_size!s:14} {before / 1024:8.1f} -> {after / 1024:8.1f} KB")

    print(f"Total: {total_before / 1024 / 1024:.2f} -> {total_after / 1024 / 1024:.2f} MB")


if __name__ == "__main__":
    main()
