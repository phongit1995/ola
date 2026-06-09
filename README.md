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
✅ Chat 1-1 hai chiều (auto-reply) + danh sách tin nhắn
✅ Phòng chat (PHÒNG CHAT): fake danh sách phòng qua **socket svc 81** + patch 1 dòng `h.O = new ag()` lúc login trong `network/e.smali` → 6 phòng hiển thị đầy đủ
❌ Danh bạ (DANH BẠ): luồng nạp là dead-code trong bản 2.1.11 — không fake được qua socket

## Cách tạo lại các thư mục decompile (nếu cần)
```bash
apktool d -f Ola_2.1.11_APKPure.apk -o apktool_out
jadx -d jadx_out Ola_2.1.11_APKPure.apk
```

> ⚠️ Chỉ dùng cho mục đích học tập / nghiên cứu bảo mật.
