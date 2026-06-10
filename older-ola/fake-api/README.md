# Ola Fake API — hướng dẫn test

Bộ này gồm 3 phần:
1. **Fake REST server** (`server.js`) — giả lập `api.ola.vn` (HTTP) bằng Express.
2. **Fake SOCKET server** (`socket-server.js`) — giả lập server chat (TCP 1239), giao thức nhị phân kiểu YMSG. **Cho phép ĐĂNG NHẬP + CHAT + PHÒNG CHAT.**
3. **APK đã patch + ký** — `../older-ola/Ola_2.1.11_fake_signed.apk` — đã đổi cả base URL REST **và** IP/host socket trỏ về máy bạn.

> ✅ Đã test thành công trên thiết bị thật: đăng nhập → danh sách tin nhắn → chat 2 chiều (auto-reply) → phòng chat.

## Chạy CẢ HAI server

```bash
cd /Volumes/D/ola/fake-api
npm install            # lần đầu
node server.js &       # REST (cổng 8080)
node socket-server.js  # SOCKET (cổng 1239) — quan trọng cho login + chat
```

Đăng nhập trong app: nhập **nick bất kỳ + mật khẩu bất kỳ** → server chấp nhận hết.

---

## Socket Server — Chi tiết (`socket-server.js`)

### Giao thức wire format
- **Client GỬI** (dr.java): `[len(4 BE) = body+6][magic: 06 05 0A 13 04][svc(1)][body]`
- **Client NHẬN** (ce.java): `[numKeys(2 BE)][bodyLen(4 BE)][svc(1)][body]`
- Body = lặp `{ key(1), vlen(4 BE), value(vlen) }`

### Luồng login
1. App gửi **svc 96** (hello) → server trả **key11** (short).
2. App gửi **svc 206** (login) → server trả **key2/135/112/9/255=0** = thành công.
3. App gửi **svc 97** → server trả status=0 → **STATE_ONLINE**.
4. Server **PUSH svc 14** từ các nick fake → tạo danh sách hội thoại.

### Bảng SVC đã handler

| SVC | Codec | Chức năng | Trạng thái |
|:---:|:-----:|-----------|:----------:|
| 96 | ba | Hello/Handshake | ✅ |
| 206 | ct | Login (nick + pass) | ✅ |
| 97 | ba | Auth confirm → STATE_ONLINE | ✅ |
| 14 | Cdo | Chat 1-1 (gửi/nhận tin) + auto-reply | ✅ |
| 106 | co | ACK gửi tin (xác nhận đã gửi) | ✅ |
| 103 | ee | ACK đã đọc / Sync engine | ✅ |
| 204 | bp | Typing **+ HTTP-over-socket proxy** (id/profile → set h.O, bỏ patch smali) | ✅ |
| 209 | cc | Sync hội thoại (load-more + sub-actions) | ✅ |
| 140 | av | Sync danh sách hội thoại | ✅ |
| 81 | at | Danh sách phòng chat | ✅ |
| 85 | bf | JOIN phòng (thành viên) | ✅ |
| 9 | af | Danh bạ (buddy list) | ✅ |
| 193 | ac | Upload danh bạ điện thoại | ✅ |
| 42 | z | Nickname query | ✅ |
| 138 | aq | Notification sync | ✅ |
| 8 | ae | Settings/config | ✅ |
| 164 | ax | RSS/feed config | ✅ |
| 168 | az | Extension config | ✅ |
| 5/92 | — | Keepalive/heartbeat | ✅ |
| *khác* | — | Fallback → trả OK rỗng | ✅ |

### Chat 1-1 (svc 14)
- App gửi `key7=peer`, `key8=nội dung`, `key110=msgId`.
- Server **ngay lập tức** push `svc 106` ACK (key8=text echo, status=0).
- Sau 600ms, server push `svc 14` auto-reply: `🤖 Fake server nhận: "…" — Xin chào từ máy 192.168.2.7!`
- Bằng chứng: `screenshots/07-chat-auto-reply.png`

### Danh sách hội thoại
- Khi online, server PUSH `svc 14` từ 5 nick fake (`linhchi92`, `tuananh`, `maiphuong`, `quanghuy`, `thuhuong`) → mỗi tin tạo 1 hội thoại trong tab **TIN NHẮN**.
- `svc 209` (au=1): trả danh sách hội thoại KHÔNG kèm cursor → hết phân trang.
- `svc 140`: trả OK rỗng → ẩn spinner sync.
- Bằng chứng: `screenshots/08-danh-sach-hoi-thoai-v2.png`

### Phòng chat (svc 81 + 85)
- `svc 81`: trả 6 phòng fake (Việt Nam Chat, Nhạc Trẻ, Game Online…).
- `svc 85`: JOIN phòng → trả tên phòng + danh sách thành viên.
- Bằng chứng: `screenshots/05-phong-chat.png`, `screenshots/06-trong-phong.png`

### DANH BẠ — dead code ⚠️
Tab DANH BẠ đọc list `this.k` (trong `message.g`) chỉ fill bởi codec `w/ca.java` — là **dead code** trong bản 2.1.11 (không có trong bảng dispatch `ch.java`). **Không thể fake qua socket.** Server vẫn trả `svc 9` (buddy list) và `svc 193` (contact sync) nhưng chúng không render ra tab DANH BẠ.

### Tuỳ chỉnh
- **Đổi danh sách bạn**: sửa mảng `FAKE_FRIENDS` trong `socket-server.js`.
- **Đổi phòng chat**: sửa mảng `FAKE_ROOMS`.
- **Đổi cổng socket**: `SPORT=1240 node socket-server.js`.

### Screenshots

| File | Nội dung |
|------|----------|
| `01-login-success.png` | Đăng nhập thành công |
| `02-danh-sach-tin-nhan.png` | Danh sách tin nhắn (5 hội thoại) |
| `03-chat-2-chieu.png` | Chat 2 chiều (gửi + nhận) |
| `04-man-chinh.png` | Màn hình chính sau login |
| `05-phong-chat.png` | Tab Phòng Chat (6 phòng) |
| `06-trong-phong.png` | Trong phòng (thành viên) |
| `07-chat-auto-reply.png` | Chat auto-reply mới (có svc 106 ACK) |
| `08-danh-sach-hoi-thoai-v2.png` | Danh sách hội thoại v2 (5 bạn + status) |

---
## (Cũ) Phần REST

---

## 1. Chạy fake server

```bash
cd /Volumes/D/ola/fake-api
npm install          # lần đầu
npm start            # chạy ở cổng 8080
```

Mở trình duyệt `http://192.168.2.7:8080/` để kiểm tra server sống.
Mọi request từ app sẽ được **log ngay tại terminal** (đường dẫn + query).

> Đổi cổng: `PORT=9090 npm start` (nhớ build lại APK với cổng tương ứng — xem mục 4).

---

## 2. Cài APK lên thiết bị / emulator

APK: `/Volumes/D/ola/older-ola/Ola_2.1.11_fake_signed.apk`

```bash
adb install -r /Volumes/D/ola/older-ola/Ola_2.1.11_fake_signed.apk
```

> Đây là APK ký bằng key test khác key gốc → nếu máy đã cài Ola thật phải **gỡ bản cũ trước** (`adb uninstall chat.ola.vn`).

**Mạng — chọn đúng IP đã build vào APK (mặc định `192.168.2.7:8080`):**
- **Điện thoại thật**: phải cùng WiFi với máy Mac, và Mac có IP `192.168.2.7`. Kiểm tra: `ipconfig getifaddr en0`.
- **Emulator (AVD)**: IP `192.168.2.7` có thể không tới được; emulator thấy máy host qua `10.0.2.2`. → cần build lại APK với host `10.0.2.2` (mục 4).

---

## 3. Test cái gì & kỳ vọng

✅ **Hoạt động (REST):**
- Khi mở app, nó gọi vài endpoint REST lúc khởi động → bạn sẽ **thấy log request đổ về terminal** từ IP thiết bị. Đây là bằng chứng redirect + cài đặt + ký APK chạy thông.
- Luồng web-login (`OlaWebLoginActivity`), mall, hồ sơ… sẽ nhận dữ liệu giả từ server.

❌ **Chưa hoạt động (đã thống nhất — cần socket):**
- **Đăng nhập ở màn hình chính** chạy qua **socket TCP** (service 206), không qua REST → màn login chính sẽ không vào được app.
- Chat realtime, presence, phòng… đều qua socket.
- Muốn login + chat thật phải dựng thêm **fake socket server** (phần để lại sau).

---

## 4. Build lại APK với IP/cổng khác

Nếu cần đổi host (vd `10.0.2.2` cho emulator) hoặc cổng:

```bash
# 1) Sửa 5 chuỗi trong smali:
#    /Volumes/D/ola/older-ola/apktool_out/smali/chat/ola/vn/util/http/a.smali
#    - 2 dòng host-check:  "192.168.2.7"        -> "<HOST_MOI>"
#    - 3 dòng base URL:    "http://192.168.2.7:8080/..."  -> "http://<HOST_MOI>:<PORT>/..."
#    (Lưu ý: host-check phải KHỚP phần host trong URL, KHÔNG kèm cổng)

# 2) Build + ký lại:
cd /Volumes/D/ola/older-ola
BT=~/Library/Android/sdk/build-tools/35.0.0
apktool b apktool_out -o fake.apk
"$BT"/zipalign -p -f 4 fake.apk fake_aligned.apk
"$BT"/apksigner sign --ks fake-ola.keystore --ks-pass pass:android --key-pass pass:android \
  --out Ola_2.1.11_fake_signed.apk fake_aligned.apk
rm fake.apk fake_aligned.apk
```

---

## Ghi chú kỹ thuật
- App targetSdk = 27 → **HTTP cleartext được phép** mặc định (không cần network-security-config).
- Đã đổi cả base URL **và** host-check (code chỉ chấp nhận host chứa `api.ola.vn`, nay là `192.168.2.7` — xem `a.smali` dòng 1000/1100).
- Keystore test: `older-ola/fake-ola.keystore` (alias `fakeola`, mật khẩu `android`).
- Chi tiết API: xem `../older-ola/docs/api/`.
