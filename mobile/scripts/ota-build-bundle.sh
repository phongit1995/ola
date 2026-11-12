#!/usr/bin/env bash
# Build bundle OTA cho 1 nền tảng, ra mobile/build/ota/<platform>-bundle.zip.
#
# Phải build GIỐNG bản lên store (Xcode/Gradle khi bật Hermes):
#   - Metro --minify false: minify=true kích metro-obfuscator-minifier, obfuscator nối
#     hàm vào cuối module nên Metro chèn id/deps sai chỗ -> "Compiling JS failed".
#   - hermesc -emit-binary -O: app chạy Hermes bytecode như bundle gốc.
#
# Cách dùng: bash mobile/scripts/ota-build-bundle.sh android|ios
set -euo pipefail

PLATFORM="${1:?Thiếu platform: android | ios}"
case "$PLATFORM" in
  android) BUNDLE_NAME="index.android.bundle" ;;
  ios) BUNDLE_NAME="main.jsbundle" ;;
  *) echo "❌ platform phải là android hoặc ios" >&2; exit 1 ;;
esac

case "$(uname -s)" in
  Darwin) HERMES_BIN="osx-bin/hermesc" ;;
  Linux) HERMES_BIN="linux64-bin/hermesc" ;;
  MINGW*|MSYS*|CYGWIN*) HERMES_BIN="win64-bin/hermesc.exe" ;;
  *) echo "❌ Không hỗ trợ hệ điều hành $(uname -s)" >&2; exit 1 ;;
esac

MOBILE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$MOBILE_DIR"

# hermesc đi kèm react-native (package hermes-compiler), cùng bản bytecode với Hermes trong app.
HERMESC="$(node -p "
  const path = require('path');
  const rnDir = path.dirname(require.resolve('react-native/package.json'));
  path.join(path.dirname(require.resolve('hermes-compiler/package.json', { paths: [rnDir] })), 'hermesc', '$HERMES_BIN');
")"
if [ ! -f "$HERMESC" ]; then
  echo "❌ Không thấy hermesc ở $HERMESC" >&2
  exit 1
fi

OTA_DIR="$MOBILE_DIR/build/ota"
OUT_DIR="$OTA_DIR/$PLATFORM"
JS_FILE="$OTA_DIR/$PLATFORM.js"
ZIP_FILE="$OTA_DIR/$PLATFORM-bundle.zip"
rm -rf "$OUT_DIR" "$JS_FILE" "$ZIP_FILE"
mkdir -p "$OUT_DIR"

echo "== Metro bundle ($PLATFORM) =="
pnpm exec react-native bundle \
  --platform "$PLATFORM" \
  --dev false \
  --minify false \
  --entry-file index.js \
  --bundle-output "$JS_FILE" \
  --assets-dest "$OUT_DIR"

echo "== hermesc ($PLATFORM) =="
"$HERMESC" -emit-binary -max-diagnostic-width=80 -O -w -out "$OUT_DIR/$BUNDLE_NAME" "$JS_FILE"
rm -f "$JS_FILE"

echo "== Zip ($PLATFORM) =="
if command -v zip >/dev/null 2>&1; then
  ( cd "$OUT_DIR" && zip -qr "$ZIP_FILE" . -x "*.DS_Store" )
else
  WIN_OUT="$(cygpath -w "$OUT_DIR")"
  WIN_ZIP="$(cygpath -w "$ZIP_FILE")"
  powershell -NoProfile -Command "Compress-Archive -Path (Join-Path '$WIN_OUT' '*') -DestinationPath '$WIN_ZIP' -Force"
fi

echo "✅ $ZIP_FILE"
