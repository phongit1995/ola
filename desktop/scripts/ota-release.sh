#!/usr/bin/env bash
# Phát hành OTA web bundle cho desktop (chạy từ máy local, không cần CI).
# Token KHÔNG hardcode — truyền qua GH_TOKEN hoặc file gitignore desktop/.ota-token.
#
# Cách dùng:
#   GH_TOKEN=ghp_xxx bash desktop/scripts/ota-release.sh "sua loi abc"
#
# shell_version lấy tự động từ desktop/package.json — shell chỉ nhận bundle
# phát hành cho đúng version nó (xem src/updater.ts). Đổi preload/main xong
# phải bump version package.json + phát hành installer mới trước khi OTA
# bundle dùng API mới.
set -euo pipefail

OTA_REPO="ducphanvanntq/ola"
TAG_PREFIX="desktop-v"
NOTES="${1:?Thiếu notes, vd: \"sua loi abc\"}"

DESKTOP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$DESKTOP_DIR"

if [ -z "${GH_TOKEN:-}" ] && [ -f "$DESKTOP_DIR/.ota-token" ]; then
  GH_TOKEN="$(tr -d ' \t\r\n' < "$DESKTOP_DIR/.ota-token")"
fi
if [ -z "${GH_TOKEN:-}" ]; then
  echo "❌ Không có token. Ghi token vào desktop/.ota-token hoặc set GH_TOKEN." >&2
  exit 1
fi
export GH_TOKEN

SHELL_VERSION="$(node -p "require('./package.json').version")"

echo "== Build web bundle (vite, env production của desktop) =="
pnpm build:web

echo "== Zip bundle =="
rm -f desktop-bundle.zip
( cd dist && zip -r "$DESKTOP_DIR/desktop-bundle.zip" . -x "*.DS_Store" >/dev/null )
SHA256="$(node -e "const c=require('crypto'),f=require('fs');console.log(c.createHash('sha256').update(f.readFileSync('desktop-bundle.zip')).digest('hex'))")"

echo "== Tính tag mới =="
# Không dùng /releases/latest (là của mobile) — liệt kê tag desktop-v* lấy số lớn nhất.
NUM=$(gh release list --repo "$OTA_REPO" --limit 100 --json tagName \
  -q "[.[].tagName | select(startswith(\"$TAG_PREFIX\")) | ltrimstr(\"$TAG_PREFIX\") | tonumber] | max // 0")
TAG="$TAG_PREFIX$((NUM + 1))"
echo "tag = $TAG (shell_version=$SHELL_VERSION)"

echo "== Tạo release =="
BODY=$(SHELL_VERSION="$SHELL_VERSION" SHA256="$SHA256" NOTES="$NOTES" node -e \
  "console.log(JSON.stringify({ shell_version: process.env.SHELL_VERSION, sha256: process.env.SHA256, notes: process.env.NOTES }))")
echo "body = $BODY"
# --prerelease BẮT BUỘC: updater mobile gọi /releases/latest, release desktop
# mà thành latest là mobile không thấy bản mới của nó nữa.
gh release create "$TAG" \
  --repo "$OTA_REPO" \
  --title "$TAG" \
  --prerelease \
  --notes "$BODY" \
  desktop-bundle.zip

rm -f desktop-bundle.zip
echo "✅ Đã tạo OTA release $TAG"
