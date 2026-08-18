# Ola Chat Desktop

Electron wrapper cho web app (`web/`) — build được Windows / macOS / Linux. Không duplicate code: vite (dev lẫn build) chạy từ `desktop/` trên source của `web/` qua `vite.config.mts` (import thẳng `web/vite.config.ts`), production serve qua protocol `app://ola` (secure context, SPA fallback nên giữ nguyên `BrowserRouter`).

Env đọc riêng tại `desktop/` theo chuẩn vite (`envDir`): `.env` (chung), `.env.development` (dev), `.env.production` (đóng gói) — không đụng `web/.env` hay `env.production` ở root.

## Chạy dev

```bash
pnpm desktop:dev    # 1 lệnh: vite (port 3005, env desktop/.env.development) → mở Electron + devtools, tắt là chết cả cặp
```

Đổi URL dev server cho Electron: `OLA_DESKTOP_DEV_URL=http://localhost:3006 pnpm -C desktop dev:electron-only`. Chỉ muốn mở Electron không kèm Vite: `pnpm -C desktop dev:electron-only`.

## Build phân phối

```bash
pnpm desktop:dist          # OS hiện tại
pnpm -C desktop dist:mac   # dmg + zip
pnpm -C desktop dist:win   # nsis installer
pnpm -C desktop dist:linux # AppImage + deb
```

`dist` chạy `build:web`: typecheck web rồi `vite build` — env lấy từ `desktop/.env.production` + `desktop/.env`, output ra `desktop/dist/` (không có bước copy) → `electron-builder` xuất installer ra `desktop/release/`.

Lưu ý cross-build: máy mac build được cả 3 OS (win cần wine cho một số bước icon; linux ok). Ký app:
- macOS: cần Apple Developer cert để notarize, không có vẫn chạy được local (mở bằng right-click → Open).
- Windows: không có code-signing cert thì SmartScreen cảnh báo, vẫn cài được.

## Smoke test

```bash
pnpm -C desktop smoke   # mở app 5s rồi tự quit, in OLA_DESKTOP_SMOKE_OK
# kèm screenshot: OLA_DESKTOP_SMOKE_SHOT=/tmp/shot.png pnpm -C desktop smoke
```

## Kiến trúc main process (`src/main.js`)

- `app://` protocol: serve file tĩnh từ `dist/`, path lạ → `index.html` (SPA fallback).
- CORS: server chỉ allow `https://olachat.net` → main process ghi đè `Origin` ở request và nới `Access-Control-Allow-Origin` ở response cho `api.olachat.net` (và `localhost:8080` khi dev). Nếu đổi API domain, sửa `API_URL_FILTERS` + `SERVER_ALLOWED_ORIGIN`.
- Mic/camera: `setPermissionRequestHandler` allow `media` (LiveKit call, voice recorder); macOS đã khai entitlements + usage descriptions trong `electron-builder.yml`.
- Link ngoài (`window.open`, navigate ra domain khác) → mở browser hệ thống.
- Renderer sandbox + contextIsolation; preload chỉ expose `window.olaDesktop.platform`.

## Chuyển dần (chưa làm)

- [ ] Notification khi có tin nhắn (renderer đã được cấp quyền `notifications`, cần web gọi `new Notification(...)` hoặc bridge qua preload)
- [ ] Badge số tin chưa đọc trên dock/taskbar
- [ ] Tray icon + chạy nền
- [ ] Auto-update (electron-updater + publish provider)
- [ ] Deep link `olachat://`
- [ ] CI build 3 OS (GitHub Actions matrix)
