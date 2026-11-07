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

## Tự cập nhật app

Có hai lớp cập nhật:

| Lớp | Cập nhật gì | Nguồn | Tag |
|---|---|---|---|
| App (`src/appUpdater.ts`, `electron-updater`) | Toàn bộ app, gồm cả Electron | Repo `dactiennguyen/ola-release` | `v0.2.0` |
| OTA web (`src/updater.ts`) | Riêng bundle web | Repo `ducphanvanntq/ola` | `desktop-v1` |

App kiểm tra khi mở và mỗi 6 giờ:

- Windows và Linux AppImage: `electron-updater` tải ngầm, xong thì hỏi khởi động lại. Chọn Để sau thì bản mới được cài khi thoát app.
- macOS: tự tải và thay `.app` (`src/macUpdater.ts`), hỏi khởi động lại giống Windows. Không dùng Squirrel.Mac vì nó bắt buộc chữ ký Apple, app chỉ ký ad-hoc. Bản cập nhật phải có `updateSignature` khớp khoá công khai trong code. Thiếu chữ ký, tải lỗi hoặc không ghi được thư mục app (chạy từ DMG, tài khoản không phải admin) thì quay về báo có bản mới và mở trang release.
- Linux `.deb`: chỉ báo có bản mới một lần cho mỗi version, vì cài cần quyền root.

Do chỉ ký ad-hoc, lần cài đầu trên macOS người dùng phải vào System Settings > Privacy & Security bấm Open Anyway, và macOS có thể hỏi lại quyền mic, camera sau mỗi bản cập nhật.

Bản build `dev` bị bỏ mục `publish` nên không nhận cập nhật từ kênh production. Tên repo nằm ở mục `publish` trong `electron-builder.yml`, CI và app đều đọc từ đó.

### Chuẩn bị một lần

1. Tạo repo public `ola-release`, có sẵn một commit (ví dụ README). Repo phải public vì app tải không kèm token.
2. Tạo fine-grained token chỉ cho repo đó, quyền Contents: Read and write.
3. Lưu token vào secret `DESKTOP_RELEASE_TOKEN` của repo code.
4. Lưu khoá riêng ed25519 vào secret `DESKTOP_UPDATE_SIGNING_KEY` của repo code. Khoá này chỉ dùng để ký bản cập nhật macOS; mất khoá thì các bản đã cài không tự cập nhật được nữa, phải phát hành bản có khoá công khai mới và người dùng cài lại, nên cần sao lưu.

### Phát hành

1. Chạy workflow Desktop với `environment = production`, nhập `version` mới (ví dụ `0.2.0`) và tick `publish`. Version phải cao hơn bản đã phát hành, trùng tag thì job `publish` báo lỗi. Để trống thì lấy từ `desktop/package.json`.
2. Ô `release_now` tick sẵn thì release lên thẳng và app người dùng nhận ngay. Muốn kiểm tra trước thì bỏ tick, rồi vào release nháp ở repo trên, kiểm tra đủ file (`latest.yml`, `latest-mac.yml`, `latest-linux.yml`, bộ cài, `.blockmap`) rồi bấm Publish. App chỉ thấy bản đã Publish.

Version nhập ở workflow không được ghi lại vào `desktop/package.json`, trong khi `scripts/ota-release.sh` lấy `shell_version` từ file đó. Trước khi phát hành OTA phải sửa file đó khớp với version đang phát hành.

OTA chỉ áp dụng cho đúng `shell_version`. Sau khi lên version mới, app quay về web đóng gói sẵn và bỏ qua bundle của version cũ cho tới khi có OTA phát hành cho version đó.

## Kiến trúc main process (`src/main.ts`)

- `app://` protocol: serve file tĩnh từ `dist/`, path lạ → `index.html` (SPA fallback).
- CORS: server chỉ allow `https://olachat.net` → main process ghi đè `Origin` ở request và nới `Access-Control-Allow-Origin` ở response cho `api.olachat.net` (và `localhost:8080` khi dev). Nếu đổi API domain, sửa `API_URL_FILTERS` + `ORIGIN_BY_API_HOST`.
- Mic/camera: `setPermissionRequestHandler` allow `media` (LiveKit call, voice recorder); macOS đã khai entitlements + usage descriptions trong `electron-builder.yml`.
- Link ngoài (`window.open`, navigate ra domain khác) → mở browser hệ thống.
- Renderer sandbox + contextIsolation; preload chỉ expose `window.olaDesktop.platform` và `getInfo()`.
- Chỉ chạy một bản app: mở lần hai thì đưa cửa sổ đang chạy lên trước.

## Chuyển dần (chưa làm)

- [ ] Notification khi có tin nhắn (renderer đã được cấp quyền `notifications`, cần web gọi `new Notification(...)` hoặc bridge qua preload)
- [ ] Badge số tin chưa đọc trên dock/taskbar
- [ ] Tray icon + chạy nền
- [ ] Deep link `olachat://`
