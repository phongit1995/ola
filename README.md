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
✅ Phòng chat (PHÒNG CHAT): fake danh sách phòng qua **socket svc 81** + patch smali
✅ Vào trong phòng (JOIN): **socket svc 85** → hiện tên phòng + danh sách thành viên
❌ Danh bạ (DANH BẠ): luồng nạp là dead-code trong bản 2.1.11 — không fake được qua socket

### Tại sao Phòng Chat cần patch smali?

**Vấn đề:** Khi login thành công, callback `a(ci ciVar, short s)` trong [`network/e.java:715`](file:///Volumes/D/ola/older-ola/jadx_out/sources/chat/ola/vn/network/e.java#L715) gán:
```java
chat.ola.vn.h.O = null;  // xóa user profile (class entity.ag)
```

Biến `h.O` (kiểu [`entity.ag`](file:///Volumes/D/ola/older-ola/jadx_out/sources/chat/ola/vn/entity/ag.java)) chứa thông tin user profile (VIP status `.u`, gender `.w`, phone verified `.x`, v.v.). Bình thường server thật sẽ push **svc response** chứa profile → `a(ag agVar, short s)` ([`e.java:548`](file:///Volumes/D/ola/older-ola/jadx_out/sources/chat/ola/vn/network/e.java#L548)) sẽ gán `h.O = agVar`. Fake server **không push profile** nên `h.O` vẫn **null** mãi.

**Hậu quả:** Tab Phòng Chat adapter ([`b/y.java:103-115`](file:///Volumes/D/ola/older-ola/jadx_out/sources/chat/ola/vn/b/y.java#L103-L115)) truy cập trực tiếp `h.O.u`, `h.O.q`, `h.O.x` **mà không check null** → **NullPointerException** → crash hoặc tab trống. Tương tự ở [`network/e.java:856`](file:///Volumes/D/ola/older-ola/jadx_out/sources/chat/ola/vn/network/e.java#L856): `h.O.u = h.H`.

**Giải pháp — patch smali:** Thay `h.O = null` bằng `h.O = new ag()` (entity rỗng) trong [`network/e.smali:1086-1090`](file:///Volumes/D/ola/older-ola/apktool_out/smali/chat/ola/vn/network/e.smali#L1086-L1090):
```smali
# GỐC:  const/4 v6, 0x0  →  sput-object v6, Lchat/ola/vn/h;->O  (= null)
# PATCH:
new-instance v7, Lchat/ola/vn/entity/ag;
invoke-direct {v7}, Lchat/ola/vn/entity/ag;-><init>()V
sput-object v7, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;
```

Kết quả: `h.O` không bao giờ null → các adapter đọc được (u=0 → hiện "Mua VIP", w=-1, x=false) → **phòng chat hiển thị đầy đủ** mà không crash.

## Cách tạo lại các thư mục decompile (nếu cần)
```bash
apktool d -f Ola_2.1.11_APKPure.apk -o apktool_out
jadx -d jadx_out Ola_2.1.11_APKPure.apk
```

> ⚠️ Chỉ dùng cho mục đích học tập / nghiên cứu bảo mật.
