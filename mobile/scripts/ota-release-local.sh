#!/usr/bin/env bash
# Chạy OTA release từ máy local (không cần GitHub Actions).
# Token KHÔNG hardcode — truyền qua biến môi trường GH_TOKEN.
#
# Cách dùng (PowerShell):
#   $env:GH_TOKEN="ghp_xxx"; bash mobile/scripts/ota-release-local.sh 1.0 "sua loi abc"
# Cách dùng (Git Bash):
#   GH_TOKEN=ghp_xxx bash mobile/scripts/ota-release-local.sh 1.0 "sua loi abc"
set -euo pipefail

OTA_REPO="ducphanvanntq/ola"
APP_VERSION="${1:?Thiếu app_version, vd: 1.0}"
NOTES="${2:?Thiếu notes, vd: \"sua loi\"}"

MOBILE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$MOBILE_DIR"

# Ưu tiên GH_TOKEN từ env; nếu không có thì đọc file gitignore mobile/.ota-token
if [ -z "${GH_TOKEN:-}" ] && [ -f "$MOBILE_DIR/.ota-token" ]; then
  GH_TOKEN="$(tr -d ' \t\r\n' < "$MOBILE_DIR/.ota-token")"
fi
if [ -z "${GH_TOKEN:-}" ]; then
  echo "❌ Không có token. Ghi token vào mobile/.ota-token hoặc set GH_TOKEN." >&2
  exit 1
fi
export GH_TOKEN

echo "== Build JS bundle (android) =="
rm -rf android/output android-bundle.zip
mkdir -p android/output
pnpm exec react-native bundle \
  --platform android \
  --dev false \
  --minify true \
  --entry-file index.js \
  --bundle-output android/output/index.android.bundle \
  --assets-dest android/output

echo "== Zip bundle =="
if command -v cygpath >/dev/null 2>&1; then
  WIN_OUT="$(cygpath -w "$MOBILE_DIR/android/output")"
  WIN_ZIP="$(cygpath -w "$MOBILE_DIR/android-bundle.zip")"
else
  WIN_OUT="$MOBILE_DIR/android/output"
  WIN_ZIP="$MOBILE_DIR/android-bundle.zip"
fi
if command -v zip >/dev/null 2>&1; then
  ( cd android/output && zip -r "$MOBILE_DIR/android-bundle.zip" . -x "*.DS_Store" >/dev/null )
else
  powershell -NoProfile -Command "Compress-Archive -Path (Join-Path '$WIN_OUT' '*') -DestinationPath '$WIN_ZIP' -Force"
fi

echo "== Tính tag mới =="
LATEST=$(gh release view --repo "$OTA_REPO" --json tagName -q .tagName 2>/dev/null || echo "v0")
NUM="${LATEST#v}"; [ -z "$NUM" ] && NUM=0
TAG="v$((NUM + 1))"
echo "tag = $TAG (app_version=$APP_VERSION)"

echo "== Tạo release =="
BODY=$(APP_VERSION="$APP_VERSION" NOTES="$NOTES" node -e "console.log(JSON.stringify({ app_version: process.env.APP_VERSION, notes: process.env.NOTES }))")
echo "body = $BODY"
gh release create "$TAG" \
  --repo "$OTA_REPO" \
  --title "$TAG" \
  --notes "$BODY" \
  android-bundle.zip

echo "✅ Đã tạo OTA release $TAG"
