# Ola 2.1.11 — Cấu hình API & Server (Tổng quan)

> Nguồn: phân tích ngược từ `Ola_2.1.11_APKPure.apk` (package `chat.ola.vn`).
> Các đường dẫn file dưới đây trỏ vào thư mục `jadx_out/sources/`.
>
> 📄 **Tài liệu chi tiết (đầy đủ request/response):**
> - [socket-protocol.md](socket-protocol.md) — toàn bộ command socket (service code, key fields, request & response)
> - [http-rest-api.md](http-rest-api.md) — toàn bộ endpoint REST + JS Bridge
>
> ⚠️ **Đính chính sau khi phân tích sâu:** (a) packet socket lúc runtime dùng header cố định `{6,5,10,19,4}`, **không** dùng magic "YMSG" (chỉ là hằng số di sản); (b) mật khẩu được mã hoá bằng **XOR custom + MD5**, **KHÔNG phải RSA** dù endpoint tên là `id/pubkey`. Phần mô tả bên dưới giữ nguyên để tham khảo nhanh; chi tiết chính xác xem 2 file trên.

## 1. Tổng quan kiến trúc mạng

Ola dùng **2 kênh kết nối song song**:

| Kênh | Mục đích | Giao thức |
|------|----------|-----------|
| **Socket TCP** | Realtime chat, presence, tin nhắn | Giao thức nhị phân kiểu **YMSG (Yahoo Messenger)** |
| **HTTP REST** | Đăng nhập, hồ sơ, ảnh, mall, quảng cáo… | HTTP (cleartext) tới `api.ola.vn` và các subdomain |

---

## 2. Chat server (Socket TCP) — kênh chính

**File cấu hình:** `chat/ola/vn/f/d.java`

```java
public interface d {
    // Danh sách IP server chat (dùng khi DNS ocs.ola.vn không có)
    public static final String[] e_ = {"210.211.116.129", "210.211.116.131",
                                        "210.211.116.134", "210.211.116.130"};
    public static final String[] f_ = { /* trùng e_ */ };

    public static final byte[] c = {89, 77, 83, 71};   // = "YMSG"  → magic header giao thức
    public static final byte[] d = {0, 16, 0, 0};      // version/flags của packet
}
```

> `{89,77,83,71}` = ký tự ASCII **`YMSG`** → Ola kế thừa giao thức packet của Yahoo Messenger.

**Logic kết nối:** `chat/ola/vn/network/h.java` + `OlaNetworkService.java`

- Hostname ưu tiên: **`ocs.ola.vn`** (được thêm vào đầu danh sách).
- Nếu không có, fallback sang 4 IP tĩnh `210.211.116.129–134` (xáo trộn ngẫu nhiên rồi thử lần lượt).
- Danh sách IP có thể được server cập nhật động qua `chat.ola.vn.h.j` (nếu rỗng mới dùng list tĩnh `e_`).

**Cổng (port) — luân phiên thử:**

| Port | Khi nào dùng |
|-----:|--------------|
| **1239** | Cổng mặc định/chính |
| **80** | Fallback (giả HTTP để qua firewall) khi 1239 lỗi |

```java
// network/h.java
OlaNetworkService.c = 1239;            // mặc định
... else { OlaNetworkService.c = 80; } // fallback
Socket socket = new Socket();
socket.connect(new InetSocketAddress(str, OlaNetworkService.c), 10000); // timeout 10s
socket.setKeepAlive(true);
```

**Một socket phụ khác** (`chat/ola/vn/u/d.java`) kết nối **cổng 1240** (timeout 30s) — dùng cho một dịch vụ con (vd. truyền dữ liệu/voice).

---

## 3. HTTP REST API

**File chính:** `chat/ola/vn/util/http/a.java`

- **Base URL:** `http://api.ola.vn/`  *(HTTP thường, không phải HTTPS)*
- Mọi request gắn chữ ký `sig` (HMAC/hash, hàm `chat.ola.vn.j.a.a(...)`) + tham số `un` (username), `sessionCode`.

### Luồng đăng nhập (signin)
```
GET http://api.ola.vn/id/pubkey?un=<username>
    → trả public key (RSA) để mã hoá mật khẩu

GET http://api.ola.vn/id/signin?un=<username>&pw=<Base64(RSA(password))>
    → trả JSON: { loginName, sessionCode, meta, ... }
```
Mật khẩu được mã hoá bằng public key lấy ở bước `pubkey` (`chat.ola.vn.j.a.a(bytes, user)`), rồi Base64 — **không gửi mật khẩu thô**.

### Các endpoint/đường dẫn khác thấy trong code
- `id/pubkey`, `id/signin` — xác thực
- `html/`, `html/rss/view/` — nội dung HTML nhúng
- `http://api.ola.vn/html/adme...` — quảng cáo "Me"

---

## 4. Các subdomain `*.ola.vn` & CDN

| Host | Vai trò |
|------|---------|
| `api.ola.vn` | **API REST chính** (đăng nhập, dữ liệu) |
| `ocs.ola.vn` | Hostname **chat socket** (cổng 1239/80) |
| `mall.ola.vn` | Cửa hàng / xem nội dung (`/watch?id=`) |
| `mobile.ola.vn` | Trang web mobile |
| `gamestore.ola.vn` | Cửa hàng game |
| `birthday.ola.vn` | Tính năng sinh nhật |
| `adme.ola.vn` | Quảng cáo trang "Me" |
| `props.kaspee.com` | CDN ảnh vật phẩm / clan (`/photo/`, `/clan/photo/`) |
| `s1.cdn.kaspee.com` | CDN ảnh (vd. `ola/preview.jpg`) |
| `web.kaspee.com` | Trang web `/view` |

> **Kaspee.com** là domain hạ tầng/CDN dùng chung — Ola là sản phẩm liên quan đến Kaspee.

---

## 5. Ghi chú bảo mật (chỉ mang tính quan sát)

- REST API dùng **HTTP cleartext** (`http://`), không TLS → traffic có thể bị nghe lén; bù lại mật khẩu được RSA-encrypt ở tầng ứng dụng.
- Chat socket là **giao thức nhị phân tự định nghĩa** (YMSG-style), không mã hoá TLS rõ ràng trong code thấy được.
- IP server hardcode (`210.211.116.129–134`) → đây là khối IP của hạ tầng Ola/Kaspee thời điểm bản 2.1.11.

---

## Phụ lục — file tham chiếu nhanh

| Nội dung | File trong `jadx_out/sources/` |
|----------|--------------------------------|
| IP + magic YMSG | `chat/ola/vn/f/d.java` |
| Logic connect socket + port | `chat/ola/vn/network/h.java`, `chat/ola/vn/network/OlaNetworkService.java` |
| Socket phụ (port 1240) | `chat/ola/vn/u/d.java` |
| HTTP REST + signin + ký request | `chat/ola/vn/util/http/a.java` |
| Mã hoá/ký (RSA, hash) | `chat/ola/vn/j/a.java` |
