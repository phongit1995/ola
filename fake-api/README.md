# Ola Fake API — hướng dẫn test

Bộ này gồm 3 phần:
1. **Fake REST server** (`server.js`) — giả lập `api.ola.vn` (HTTP) bằng Express.
2. **Fake SOCKET server** (`socket-server.js`) — giả lập server chat (TCP 1239), giao thức nhị phân kiểu YMSG. **Cho phép ĐĂNG NHẬP vào app.**
3. **APK đã patch + ký** — `../older-ola/Ola_2.1.11_fake_signed.apk` — đã đổi cả base URL REST **và** IP/host socket trỏ về máy bạn.

> ✅ Đã test thành công: app đăng nhập (user bất kỳ, vd "test") và vào được màn hình bên trong (Kho VIP…). Bằng chứng: `screenshots/01-login-success.png`.

## Chạy CẢ HAI server

```bash
cd /Volumes/D/ola/fake-api
npm install            # lần đầu
node server.js &       # REST (cổng 8080)
node socket-server.js  # SOCKET (cổng 1239) — quan trọng cho login
```

Đăng nhập trong app: nhập **nick bất kỳ + mật khẩu bất kỳ** → server chấp nhận hết.

### Luồng login đã giải mã (socket)
1. App gửi **svc 96** (hello: locale, device-info, màn hình, device-id) → server trả **key 11** (short).
2. App gửi **svc 206** (login: key2=user, key43=mật khẩu mã hoá) → server trả **key2/135/112/9/255=0** = thành công.
3. App lưu working session (key 135) → gửi tiếp svc 97/204/116… (đã đăng nhập).

### Đã fake được DATA cho màn chat ✅
- **svc 97 (ba)**: server trả status=0 → app chuyển **STATE_AUTHENTICATING → STATE_ONLINE** (hết churn reconnect). Đây là chìa khoá để ổn định.
- **svc 14 (Cdo)** = tin nhắn 1-1. App gửi key7=peer, key8=nội dung. Server **auto-reply**: push lại svc 14 (key7=peer, key8=text trả lời) → hiện **bong bóng tin đến** trong màn chat. Bằng chứng: `screenshots/03-chat-2-chieu.png` (gửi "Alo robot oi" → nhận trả lời từ fake server).
- **Osimi** = web-bot, load HTML từ REST server (`/html/osimi`) → đã hiện trang.

### Đã fake DATA cho danh sách tin nhắn ✅
- Khi online, server **PUSH svc 14** từ vài nick (linhchi92, tuananh, maiphuong) → mỗi tin tạo 1 hội thoại trong tab **TIN NHẮN** (có preview + badge chưa đọc). Bằng chứng: `screenshots/02-danh-sach-tin-nhan.png`.
- Cấu hình danh sách: sửa mảng `FAKE_CONVOS` trong `socket-server.js`.

### DANH BẠ (friend list) — CHƯA hiện được ⚠️ (đã đào sâu, gặp tường kỹ thuật)
Đã thử **4 svc**, server đều gửi đúng nhưng không svc nào render ra tab DANH BẠ:
- **svc 15 (c)**: callback `a(String,List)` ở `network/e.java:1463` **rỗng (no-op)**.
- **svc 67 (ad)**: callback định tuyến theo status `s` (key255) qua `entry.c.f.b(s)` — push đơn phương s=0 bị bỏ qua.
- **svc 9 (af)**: callback `a(List<message.f>,int)` → `h.t.d(list)` → fill list `this.i` (không phải nguồn DANH BẠ).
- **svc 193 (ac)**: callback `c(list)` → `h.t.i(list)` → fill `this.f` NHƯNG **chỉ giữ bạn đã có trong list master `this.e`** (`message/g.java:1297-1307`).

**Nguyên nhân gốc:** `chat.ola.vn.h.t` (`message.g`, 1567 dòng) là manager có **~8 list nội bộ** (i, f, k, e, g…) phụ thuộc chéo. Bạn chỉ hiện ở DANH BẠ khi đã nằm trong list master `this.e`, mà `this.e` được nạp qua luồng **định tuyến theo status (entry handler)** — push đơn phương từ server không khớp status nên bị loại. Tab DANH BẠ cũng **không gửi socket request** khi mở (đọc từ cache/DB local), nên không có request để "trả lời echo status".

**KẾT LUẬN CUỐI (đã trace trọn chuỗi):** Tab DANH BẠ đọc `h.t.p()/q()` = list `this.k`. `this.k` chỉ được fill bởi `message.g.a(List,String)` [g.java:609] hoặc `e(List)` [g.java:978]. Hai method này chỉ được gọi từ callback `b(List,String,short)` [e.java:2662] → mà callback đó chỉ được codec **`w/ca.java`** gọi. **`ca` là DEAD CODE**: không `new ca(` ở đâu, KHÔNG có trong bảng dispatch `ch.java`, và không có luồng load-DB nào gọi `h.t.a/e(list)`.
> ⇒ Luồng nạp danh sách bạn đã bị **gỡ/vô hiệu hóa trong bản build 2.1.11**. KHÔNG có svc/status nào để bắt → **không thể fake DANH BẠ qua socket**. Tab trống là hành vi đúng của bản này (app chuyển sang mô hình chat người lạ + hội thoại). Cách duy nhất còn lại: chỉnh sửa code app (smali) hoặc seed thẳng SQLite DB.

### Phòng chat — CHƯA (tab rỗng, không gửi socket request khi mở).

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
