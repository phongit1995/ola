#!/usr/bin/env bash
# Sinh bộ bài Tiến Lên: tải SVG public-domain (CC0, Byron Knoll / notpeter/Vector-Playing-Cards)
# rồi render ra webp 2x cho game/thirteen/assets/cards/.
# Yêu cầu: curl, rsvg-convert, cwebp.
set -euo pipefail

BASE_URL="https://raw.githubusercontent.com/notpeter/Vector-Playing-Cards/master/cards-svg"
OUT_DIR="$(cd "$(dirname "$0")/.." && pwd)/thirteen/assets/cards"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

HEIGHT=184

mkdir -p "$OUT_DIR"

ranks=(3 4 5 6 7 8 9 10 j q k a 2)
repo_ranks=(3 4 5 6 7 8 9 10 J Q K A 2)
suits=(s c d h)
repo_suits=(S C D H)

for i in "${!ranks[@]}"; do
  for j in "${!suits[@]}"; do
    name="${ranks[$i]}${suits[$j]}"
    repo_name="${repo_ranks[$i]}${repo_suits[$j]}"
    svg="$TMP_DIR/$name.svg"
    png="$TMP_DIR/$name.png"
    curl -fsSL --retry 3 "$BASE_URL/$repo_name.svg" -o "$svg"
    rsvg-convert -h "$HEIGHT" "$svg" -o "$png"
    cwebp -quiet -q 80 "$png" -o "$OUT_DIR/$name.webp"
  done
done

cat > "$TMP_DIR/back.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="127" height="184" viewBox="0 0 127 184">
  <defs>
    <pattern id="weave" width="14" height="14" patternUnits="userSpaceOnUse" patternTransform="rotate(45)">
      <rect width="14" height="14" fill="#1c6b41"/>
      <rect width="7" height="14" fill="#175c37"/>
      <circle cx="7" cy="7" r="1.6" fill="#f6c95c" opacity="0.55"/>
    </pattern>
  </defs>
  <rect x="0.5" y="0.5" width="126" height="183" rx="9" fill="#fdfcf5" stroke="#b9ae94"/>
  <rect x="6" y="6" width="115" height="172" rx="6" fill="url(#weave)" stroke="#0f4d2e" stroke-width="2"/>
  <circle cx="63.5" cy="92" r="24" fill="#0f4d2e" stroke="#f6c95c" stroke-width="2"/>
  <text x="63.5" y="101" font-family="Georgia, serif" font-size="26" font-weight="bold" fill="#f6c95c" text-anchor="middle">O</text>
</svg>
SVG
rsvg-convert -h "$HEIGHT" "$TMP_DIR/back.svg" -o "$TMP_DIR/back.png"
cwebp -quiet -q 80 "$TMP_DIR/back.png" -o "$OUT_DIR/back.webp"

echo "Đã sinh $(ls "$OUT_DIR" | wc -l | tr -d ' ') file vào $OUT_DIR"
