#!/bin/bash
# 在 Mac 上執行：需要 Xcode 15+（App Store 安裝後先開一次同意授權）
set -e
cd "$(dirname "$0")"
xcodebuild -project boringNotch.xcodeproj -scheme boringNotch -configuration Release \
  -derivedDataPath build CODE_SIGN_IDENTITY="-" CODE_SIGNING_ALLOWED=YES \
  -destination 'platform=macOS' build | tail -5
APP=$(find build/Build/Products/Release -maxdepth 1 -name "*.app" | head -1)
rm -rf "/Applications/$(basename "$APP")"
cp -R "$APP" /Applications/
xattr -dr com.apple.quarantine "/Applications/$(basename "$APP")" 2>/dev/null || true
echo "完成：/Applications/$(basename "$APP")  （系統語言為繁中即顯示繁中）"
