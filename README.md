# 卓著音樂 Bible - OTA 靜態下載發布包

本資料夾為採用 **「方案 1：自建 OTA 靜態下載頁（永久固定網址）」** 所生成的完整發布資產。

---

## 📦 發布資產清單

| 檔案名稱 | 說明 |
| :--- | :--- |
| **`musicbible2.ipa`** (或 `Musicbible.ipa`) | 本次使用續約完成之 Apple Developer 帳號 (`benny chen`) 重新編譯簽名之 Ad-Hoc 安裝包（檔案大小約 10.5 MB，效期至 **2027/07/09**，包含 73 台已註冊 iPad UDID）。 |
| **`manifest.plist`** | iOS `itms-services://` OTA 協定安裝設定檔。 |
| **`index.html`** | 專屬現代化深色玻璃擬態（Glassmorphism）下載網頁。支援 iPad 裝置辨識、LINE 內嵌瀏覽器防呆穿透、安裝 Toast 提示與電腦端 QR Code 展示。 |
| **`app-icon.png`** / **`app-icon-512.png`** | 卓著音樂 Bible 應用程式圖示。 |
| **`configure_url.sh`** | 一鍵設定部署網址腳本（自動更新 `manifest.plist` 中的 HTTPS 網址）。 |

---

## 🚀 靜態空間部署與網址設定步驟

iOS OTA 安裝規範要求：**所有檔案必須託管於支援 HTTPS (SSL) 的伺服器或靜態空間**。

### 推薦免費靜態空間（三選一）：
1. **GitHub Pages**（推薦：完全免費、穩定、自帶 SSL）
   - 建立一個 GitHub 倉庫（例如 `musicbible-ota`）。
   - 將 `OTA_Distribution/` 目錄下的所有檔案上傳或 push 至該倉庫的 `main` 分支。
   - 至 Settings > Pages 開啟 GitHub Pages。
   - 取得永久網址，例如：`https://<你的帳號>.github.io/musicbible-ota/`
2. **Cloudflare Pages**（推薦：速度快、自帶 SSL）
   - 直接將本資料夾拖拉上傳至 Cloudflare Pages，立即取得永久 `.pages.dev` 網址。
3. **卓著現有網站伺服器（Apache / Nginx）**
   - 上傳至 `https://www.musicbook.com.tw/ota/`。

---

## ⚙️ 如何更新網址

若您確定了要發布的網址（例如 `https://ota.musicbook.com.tw/`）：

### 方式 A：執行一鍵腳本
在終端機執行：
```bash
cd OTA_Distribution
./configure_url.sh https://ota.musicbook.com.tw/
```

### 方式 B：手動修改 `manifest.plist`
打開 `manifest.plist`，將裡面的網址改為您的伺服器路徑即可：
```xml
<key>url</key>
<string>https://ota.musicbook.com.tw/musicbible2.ipa</string>
```

---

## 📲 iPad 安裝指引與疑難排解

1. **必須使用 Safari 開啟**：
   - 請將網址（例如 `https://ota.musicbook.com.tw/`）傳給老師/樂手。
   - 若使用者在 LINE 中點開，網頁頂部會自動提示並導引至 Safari 開啟。
2. **點擊「立即下載安裝」**：
   - Safari 會跳出系統提示：`要安裝「卓著音樂 Bible」嗎？`
   - 點擊 **「安裝」**，返回 iPad 主畫面即可看到圖示正在下載安裝。
3. **首次開啟信任憑證（如需要）**：
   - 前往 iPad **「設定」 > 「一般」 > 「VPN 與裝置管理」**。
   - 點選開發者 **「benny chen」**。
   - 點擊 **「信任 benny chen」** 即可開始正常閱譜！
