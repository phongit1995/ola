# Ola 2.1.11 — Reverse Engineering & Fake Server

Phân tích ngược APK **Ola 2.1.11** (`chat.ola.vn`) + dựng fake server (REST + Socket) để test redirect, đăng nhập và chat.

## Cấu trúc thư mục

| Thư mục / file | Nội dung |
|----------------|----------|
| [docs/](docs/) | Tài liệu phân tích (màn hình, API, UI style) |
| [fake-api/](fake-api/) | Fake server (Node/Express + socket) + ảnh demo |
| `apktool_out/` | Decode bằng apktool (manifest, res, **smali đã patch**) |
| `jadx_out/` | Decompile Java (jadx) — tham khảo code |
| `extracted/`, `extracted_full/` | Giải nén thô APK |
| `Ola_2.1.11_APKPure.apk` | APK gốc *(gitignore)* |
| `Ola_2.1.11_fake_signed.apk` | APK đã patch redirect + ký lại *(gitignore)* |
| `fake-ola.keystore` | Keystore test (pass: `android`) *(gitignore)* |

## Tài liệu ([docs/](docs/))
- [man-hinh-screens.md](docs/man-hinh-screens.md) — 77 màn hình (Activity) của app
- [screens/](docs/screens/) — **tài liệu chi tiết từng màn hình** (bố cục, màu, style, CSS) + ảnh chụp + asset: [đăng nhập](docs/screens/dang-nhap/README.md), [đăng ký](docs/screens/dang-ky/README.md), [trang chủ](docs/screens/trang-chu/README.md)
- [ui-style-design.md](docs/ui-style-design.md) — UI style: màu, font, theme (+ [ola-color-palette.html](docs/ola-color-palette.html) xem màu trực quan)
- [api/socket-protocol.md](docs/api/socket-protocol.md) — giao thức socket chat (kiểu YMSG) + **luồng login đã kiểm chứng thực tế**
- [api/http-rest-api.md](docs/api/http-rest-api.md) — REST API (`api.ola.vn`) + JS bridge
- [api/cau-hinh-api-server.md](docs/api/cau-hinh-api-server.md) — tổng quan kiến trúc mạng
- [huong-dan-doi-url.md](docs/huong-dan-doi-url.md) — **đổi URL/IP trong smali để chạy với fake API** (file + dòng cụ thể + build lại)

## Fake server ([fake-api/](fake-api/))
Đã chạy thực tế trên thiết bị: **đăng nhập + chat 1-1 + danh sách tin nhắn**.
- `server.js` — fake REST (`api.ola.vn` → máy local, cổng 8080)
- `socket-server.js` — fake socket chat (cổng 1239): handshake → login → online → chat
- Xem [fake-api/README.md](fake-api/README.md) để chạy & test.

## Đã làm được
✅ Decode + phân tích toàn bộ API (REST + socket)
✅ Patch redirect (REST + socket IP) → build → ký lại APK
✅ Đăng nhập vào app qua fake server (nick/mật khẩu bất kỳ)
✅ Chat 1-1 hai chiều (auto-reply) + danh sách tin nhắn + ACK (svc 106)
✅ Phòng chat (PHÒNG CHAT): fake danh sách phòng qua **socket svc 81**
✅ Vào trong phòng (JOIN): **socket svc 85** → hiện tên phòng + danh sách thành viên
✅ **Hồ sơ bản thân `h.O` set qua SOCKET (svc 204 proxy) — KHÔNG còn cần patch smali** (xem dưới)
❌ Danh bạ (DANH BẠ): luồng nạp là dead-code trong bản 2.1.11 — không fake được qua socket

### Phòng Chat & hồ sơ `h.O` — KHÔNG cần patch smali

Tab Phòng Chat dựng list bằng cách đọc `h.O` (hồ sơ bản thân, `entity.ag`) **không null-check** → `h.O==null` thì **NPE → tab trống**. `h.O` chỉ set qua `id/profile` (task `w` → `a(ag,short)` `e.java:548`).

**Mấu chốt:** khi socket nối, request `id/profile` **đi qua SOCKET (svc 204 proxy), không phải HTTP** — `key109=URL`, `key130=task id`; server trả body về qua svc 204 → client parse → set `h.O`. Fake server cũ coi svc 204 là "typing" rồi vứt đi nên `h.O` mãi null (mới tưởng phải patch).

→ **Giải pháp (server-only):** fake socket xử lý **svc 204**: `key109` là URL `id/profile` → trả `key130`=ECHO id + `key23`=profile JSON. Xem `case 204` + `proxyFetch()` trong [`fake-api/socket-server.js`](fake-api/socket-server.js); chi tiết cơ chế ở [socket-protocol.md](docs/api/socket-protocol.md).

> ✅ Verify: APK **gốc (KHÔNG patch)** + handler svc 204 → 6 phòng hiện đủ + JOIN OK (`fake-api/screenshots/emu_np_rooms.png`, `emu_np_inroom.png`).

## Cách tạo lại các thư mục decompile (nếu cần)
```bash
apktool d -f Ola_2.1.11_APKPure.apk -o apktool_out
jadx -d jadx_out Ola_2.1.11_APKPure.apk
```

> ⚠️ Chỉ dùng cho mục đích học tập / nghiên cứu bảo mật.
