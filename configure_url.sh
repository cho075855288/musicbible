#!/usr/bin/env bash
# ==============================================================================
# 卓著音樂 Bible - OTA 靜態下載網址快速配置腳本
# 用法範例：
#   ./configure_url.sh https://ota.musicbook.com.tw/
#   ./configure_url.sh https://bennychen.github.io/musicbible/
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_PLIST="$SCRIPT_DIR/manifest.plist"

if [ -z "$1" ]; then
  echo "❌ 請提供您預計部署的 HTTPS Base URL！"
  echo "用法：./configure_url.sh <HTTPS_URL>"
  echo "範例：./configure_url.sh https://ota.musicbook.com.tw/"
  exit 1
fi

BASE_URL="$1"
# 確保末尾帶斜線
[[ "$BASE_URL" != */ ]] && BASE_URL="${BASE_URL}/"

# 檢查是否為 HTTPS
if [[ "$BASE_URL" != https://* ]]; then
  echo "⚠️ 警告：iOS itms-services OTA 協議強制要求使用 HTTPS (SSL) 網址！"
  echo "您輸入的網址並非以 https:// 開頭，請確認是否正確。"
fi

echo "正在更新 manifest.plist 網址為：$BASE_URL ..."

# 使用 python 或 sed 替換 plist 中的網址
python3 - <<EOF
import re

plist_path = "$TARGET_PLIST"
base_url = "$BASE_URL"

with open(plist_path, "r", encoding="utf-8") as f:
    content = f.read()

# 替換 ipa 與 icon 網址
content = re.sub(r'<string>https?://[^<]+/musicbible2\.ipa</string>', f'<string>{base_url}musicbible2.ipa</string>', content)
content = re.sub(r'<string>https?://[^<]+/app-icon\.png</string>', f'<string>{base_url}app-icon.png</string>', content)
content = re.sub(r'<string>https?://[^<]+/app-icon-512\.png</string>', f'<string>{base_url}app-icon-512.png</string>', content)

with open(plist_path, "w", encoding="utf-8") as f:
    f.write(content)

print("✅ manifest.plist 已成功更新！")
EOF

echo ""
echo "🎉 設定完成！"
echo "您現在可以直接將 OTA_Distribution 資料夾內的所有檔案上傳到該空間："
echo " - $TARGET_PLIST"
echo " - $SCRIPT_DIR/index.html"
echo " - $SCRIPT_DIR/musicbible2.ipa"
echo " - $SCRIPT_DIR/app-icon.png"
echo " - $SCRIPT_DIR/app-icon-512.png"
