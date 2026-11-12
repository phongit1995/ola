#!/usr/bin/env bash
# Tạo OTA release: build bundle Android + iOS, gộp manifest.json, đăng GitHub Release.
# Dùng chung cho workflow mobile-ota.yml và chạy tay ở máy local.
# Token KHÔNG hardcode — truyền qua biến môi trường GH_TOKEN (hoặc file gitignore mobile/.ota-token).
#
# Cách dùng (PowerShell):
#   $env:GH_TOKEN="ghp_xxx"; bash mobile/scripts/ota-release.sh 1.0.0 "sua loi abc"
# Cách dùng (Git Bash / macOS):
#   GH_TOKEN=ghp_xxx bash mobile/scripts/ota-release.sh 1.0.0 "sua loi abc"
#
# manifest.json gộp dồn: lấy manifest của release mới nhất, ghi đè mục của app_version này,
# nên mọi bản store đang dùng đều thấy bundle của mình qua releases/latest/download/manifest.json.
set -euo pipefail

OTA_REPO="${OTA_REPO:-ducphanvanntq/ola-release}"
BUNDLE_ID="com.ola.me.net.org.vn"
APP_VERSION="${1:?Thiếu app_version, vd: 1.0.0}"
NOTES="${2:?Thiếu notes, vd: \"sua loi\"}"

MOBILE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$MOBILE_DIR"

if [ -z "${GH_TOKEN:-}" ] && [ -f "$MOBILE_DIR/.ota-token" ]; then
  GH_TOKEN="$(tr -d ' \t\r\n' < "$MOBILE_DIR/.ota-token")"
fi
if [ -z "${GH_TOKEN:-}" ]; then
  echo "❌ Không có token. Ghi token vào mobile/.ota-token hoặc set GH_TOKEN." >&2
  exit 1
fi
export GH_TOKEN

bash "$MOBILE_DIR/scripts/ota-build-bundle.sh" android
bash "$MOBILE_DIR/scripts/ota-build-bundle.sh" ios

OTA_DIR="$MOBILE_DIR/build/ota"

echo "== Tính tag mới =="
LATEST=$(gh release view --repo "$OTA_REPO" --json tagName -q .tagName 2>/dev/null || echo "v0")
NUM="${LATEST#v}"; [ -z "$NUM" ] && NUM=0
TAG="v$((NUM + 1))"
echo "tag = $TAG (app_version=$APP_VERSION)"

echo "== Gộp manifest.json =="
PREV_MANIFEST="$OTA_DIR/manifest.prev.json"
rm -f "$PREV_MANIFEST"
# Có manifest mà tải hỏng thì dừng hẳn, không thì manifest mới mất mục của các bản store khác.
HAS_MANIFEST=$(gh release view --repo "$OTA_REPO" --json assets -q '[.assets[].name] | index("manifest.json") != null' 2>/dev/null || echo false)
if [ "$HAS_MANIFEST" = "true" ]; then
  gh release download --repo "$OTA_REPO" --pattern manifest.json --output "$PREV_MANIFEST"
  node -e 'JSON.parse(require("fs").readFileSync(process.argv[1], "utf8")).versions' "$PREV_MANIFEST" >/dev/null
else
  echo "(release mới nhất chưa có manifest.json, tạo mới)"
fi
OTA_REPO="$OTA_REPO" TAG="$TAG" APP_VERSION="$APP_VERSION" BUNDLE_ID="$BUNDLE_ID" NOTES="$NOTES" \
PREV_MANIFEST="$PREV_MANIFEST" OUT_MANIFEST="$OTA_DIR/manifest.json" node -e '
  const fs = require("fs");
  const env = process.env;
  const versions = fs.existsSync(env.PREV_MANIFEST)
    ? JSON.parse(fs.readFileSync(env.PREV_MANIFEST, "utf8")).versions || {}
    : {};
  versions[env.APP_VERSION] = {
    version: Number(env.TAG.slice(1)),
    tag: env.TAG,
    notes: env.NOTES,
    published_at: new Date().toISOString(),
  };
  // Dựng lại link từ tag theo tên repo hiện tại (repo từng đổi tên ola -> ola-release).
  for (const entry of Object.values(versions)) {
    const base = `https://github.com/${env.OTA_REPO}/releases/download/${entry.tag}`;
    entry.android = `${base}/android-bundle.zip`;
    entry.ios = `${base}/ios-bundle.zip`;
  }
  const manifest = { schema: 1, bundle_id: env.BUNDLE_ID, versions };
  fs.writeFileSync(env.OUT_MANIFEST, JSON.stringify(manifest, null, 2) + "\n");
  console.log(Object.entries(versions).map(([v, e]) => `  ${v} -> ${e.tag}`).join("\n"));
'

echo "== Tạo release =="
BODY=$(APP_VERSION="$APP_VERSION" BUNDLE_ID="$BUNDLE_ID" NOTES="$NOTES" node -e "console.log(JSON.stringify({ app_version: process.env.APP_VERSION, bundle_id: process.env.BUNDLE_ID, notes: process.env.NOTES }))")
gh release create "$TAG" \
  --repo "$OTA_REPO" \
  --title "$TAG ($APP_VERSION)" \
  --notes "$BODY" \
  --latest \
  "$OTA_DIR/android-bundle.zip" \
  "$OTA_DIR/ios-bundle.zip" \
  "$OTA_DIR/manifest.json"

echo "✅ Đã tạo OTA release $TAG cho app_version $APP_VERSION"
