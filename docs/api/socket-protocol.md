# Ola 2.1.11 — Giao thức Socket TCP (chat realtime)

> Kênh chính cho chat, presence, phòng, VIP, me-feed… Giao thức nhị phân tự định nghĩa (kiểu Yahoo Messenger), dùng **service code** (mã lệnh) + body là các cặp **key-value**.
> Đường dẫn file trỏ vào `jadx_out/sources/chat/ola/vn/`.

## 0. Lõi giao thức nằm ở package `w/`

> ⚠️ Đính chính so với khảo sát ban đầu: builder/parser packet **KHÔNG** nằm ở package `entity/` (đó là model quảng cáo). Lõi thật ở package `w/`.

| Vai trò | Class | File |
|---------|-------|------|
| Cấu hình server + magic | `chat.ola.vn.f.d` | `f/d.java` |
| Engine cấp cao (tạo request) | `ci` | `w/ci.java` (2020 dòng) |
| Object packet nội bộ (service code + field) | `bk` | `w/bk.java` |
| Builder body (ghi key-value) | `cg` | `w/cg.java` |
| Writer ra socket (ghi header) | `dr` | `w/dr.java` |
| Reader từ socket (đọc header + KV) | `ce` | `w/ce.java` |
| Vòng lặp đọc + dispatch theo service code | `dq` | `w/dq.java:24` |
| Packet đã parse (mảng key-value) | `s` | `w/s.java` |
| Bảng đăng ký codec theo service code | `ch` | `w/ch.java` (mảng `bb[256]`) |
| Interface codec (encode + decode) | `bb` | `w/bb.java` |
| ~110 codec con (mỗi loại lệnh) | `a`..`ee` | `w/*.java` |
| Callback xử lý push (giao diện `p.g`) | hiện thực ở | `network/e.java` |

**Luồng gửi:** `OlaNetworkService.<x>()` → `ci.<y>()` tạo `bk(new bk((short)N))` + gán field → `ch.a().a(N)` lấy codec → `codec.a(bk, cg, g)` ghi KV vào `cg` → `dr.a(cg)` ghi header + body ra socket.

**Luồng nhận:** `dq.run()` → `ce.a()` đọc 1 packet thành `s` → `ch.a().a(s.b)` lấy codec → `codec.a(s, g, ci)` parse KV rồi gọi callback ở `network/e.java`.

---

## 1. Cấu trúc packet

### Header GỬI ĐI — `w/dr.java:47-68` (10 byte)
```
byte[0..3] : độ dài (int big-endian) = bodyLen + 6
byte[4]    : 0x06 (6)   ─┐
byte[5]    : 0x05 (5)    │ 5 byte hằng số cố định
byte[6]    : 0x0A (10)   │ (KHÔNG phải "YMSG" lúc runtime)
byte[7]    : 0x13 (19)   │
byte[8]    : 0x04 (4)   ─┘
byte[9]    : (byte) service code      // mã lệnh, 1 byte
byte[10..] : body (các cặp key-value)
```

### Header NHẬN VỀ — `w/ce.java:27-60` (7 byte, không đối xứng)
```
byte[0..1] : số lượng key (short BE)
byte[2..5] : độ dài body (int BE)
byte[6]    : service code (1 byte)    → dispatch tại dq.java:24
```

### Thân (body) — cặp key-value
- **Ghi** (`w/cg.java:57-82`): `key` = 1 byte, rồi `value` = 4 byte độ dài (int BE) + bytes giá trị.
- **Đọc** (`w/ce.java:40-56`): mỗi cặp = 1 byte key + 4 byte độ dài (int BE) + bytes value. Giới hạn value ≤ **1.024.000 byte**.

### Về magic "YMSG"
Hằng `f.d.c = {89,77,83,71}` ("YMSG") và `f.d.d = {0,16,0,0}` chỉ tồn tại trong `f/d.java`, **không dùng ở writer/reader runtime** (writer dùng header `{6,5,10,19,4}`). Có thể là di sản từ codebase Yahoo Messenger gốc.

IP server: `f.d.e_/f_ = {210.211.116.129, .131, .134, .130}`, chọn ngẫu nhiên (`u/d.java:34-35`). Cổng 1239 (chính) → 80 (fallback); host ưu tiên `ocs.ola.vn`.

---

## 2. Bảng ý nghĩa KEY thường gặp

| Key | Ý nghĩa | Key | Ý nghĩa |
|----:|---------|----:|---------|
| 0 | status/auth result | 72 | **transaction/order id** (long) |
| 1 | payload/handshake bytes | 79 | cookie/captcha/cờ |
| 2 | **username** (lowercase) | 86 | display name/nick |
| 4 | recipient/target id | 88 | flag byte |
| 5 | mã/cookie phụ (captcha) | 92/93/95 | bộ ba captcha (id/data/answer) |
| 6 | nhóm/danh mục bạn | 100 | **room id** (long) |
| 7 | buddy id (lặp cho list) | 101/104 | room name/topic |
| 8 | count / message text / số dư | 108 | session/keepalive id (long) |
| 9 | timestamp / cờ online | 109–113 | danh sách tham số (nối `;`) |
| 12 | message-type / class | 114 | **sub-command / action type** |
| 13 | nội dung phụ / alias | 124–126 | id/đếm phụ |
| 14 | message body (me/feed) | 129 | id đối tượng (me/post) |
| 22 | **nội dung tin nhắn / display name** | 130 | timestamp/online-time (long) |
| 23 | dữ liệu nhị phân (avatar/emoticon) | 135 | **working session** |
| 38 | trạng thái (status enum) | 137–140 | tham số mở rộng (chat group) |
| 43 | **mật khẩu đã mã hoá (XOR seed)** | 205–207 | tham số bạn/me (count/role) |
| 45 | flag online/offline | 220/221 | tham số phụ |
| 50/51 | image dimension "WxH" | 255 | **status / error code** (chuẩn YMSG) |
| 58 | message id / timestamp (long) | | |

---

## 3. REQUEST (client → server)

> Service code = `new bk((short)N)` trong `w/ci.java`; key gửi đi lấy từ `codec.a(bk,cg,g)`. Ý nghĩa suy từ caller (Activity/method) + log.

### Đăng nhập / phiên / keepalive
| Svc | Codec | Ý nghĩa | Key gửi | Ref |
|----:|-------|---------|---------|-----|
| **206** | f | **LOGIN** (username + pass mã hoá XOR) | 2,5,43,50,61,79,86,94,111,112,255 | `ci.java:1110` |
| **195** | df | Handshake/khởi tạo (lấy challenge) | 5 | `ci.java:1819` |
| **5** | az | Keepalive/ping | 114 | `ci.java:1307` |
| **92** | ed | Heartbeat / keepalive session | 9,45,67,72,108,114,125,220,221,255 | `ci.java:440` |
| **75** | w | Trả lời captcha/keepalive | 5,92,93,95,255 | `ci.java:761` |
| **8** | ae | Logout / disconnect | 255 | `ci.java:1661` |
| **146** | x | Đặt invisible/visible | 114 | `ci.java:49` |

### Tin nhắn / chat
| Svc | Codec | Ý nghĩa | Key gửi | Ref |
|----:|-------|---------|---------|-----|
| **106** | co | **Gửi tin nhắn 1-1 (IM chính)** | 8,12,24,72,79,113,114,220,255 | `ci.java:570` |
| **2** | dv | Gửi tin (kèm thông tin phiên) | 2,4,5,22,43,58,88,109,142,255 | `ci.java:731,746` |
| **57** | e | **Gửi tin nhắn nhóm/feed** | 9,20,45,109,110,112,114,255 | `ci.java:123` |
| **103** | ee | **Ack / đánh dấu đã đọc** | 7,72,115,255 | `ci.java:469,591` |
| **204** | bp | Báo đang nhập (typing) | 109,130 | `ci.java:605` |
| **190** | t | Gửi báo nhận | 109,114 | `ci.java:74` |
| **85** | bf | **Tin nhắn trong phòng chat** | 38,45,79,88,100,114,115,255 | `ci.java:482` |

### Bạn bè / presence / hồ sơ
| Svc | Codec | Ý nghĩa | Key gửi | Ref |
|----:|-------|---------|---------|-----|
| **67** | ad | **Lấy danh sách bạn (full)** | 2,6,9,62,69,205,206,207,255 | `ci.java:815` |
| **15** | c | Lấy danh sách bạn / presence | 7,12,21,22,38,45 | `ci.java:989` |
| **12** | y | **Cập nhật presence/status bản thân** | 4,22,23,58,88,109 | `ci.java:691` |
| **21** | m | **Yêu cầu kết bạn / auth buddy** | 12,13,38,45,58 | `ci.java:1619` |
| **50** | ai | **Lấy hồ sơ buddy (profile)** | 7,255 | `ci.java:1492` |
| **125** | h | Đăng ký bạn theo số/khoảng | 7,45,205,255 | `ci.java:554` |
| **79** | bl | Block/ignore buddy | 7,109,114 | `ci.java:241` |
| **9** | af | Set buddy group / report | 39 | `ci.java:418` |
| **54** | i | Tìm/đối chiếu contact | 7,22 | `ci.java:1095` |

### Phòng chat / nhóm
| Svc | Codec | Ý nghĩa | Key gửi | Ref |
|----:|-------|---------|---------|-----|
| **81** | at | **Vào phòng chat (join room)** | 100,101,103,255 | `ci.java:1021` |
| **193** | ac | **Tạo/sửa nhóm chat** | 4,7,22,109,114,255 | `ci.java:152` |
| **189** | ec | **Lấy danh sách thành viên nhóm** | 7,9,45,110,114,130,220,255 | `ci.java:280` |
| **163** | dk | Thao tác nhóm chat | 24,109,110,129 | `ci.java:717` |
| **203** | bi | Mời/thêm thành viên nhóm | 24,62,109,110,114,255 | `ci.java:60` |
| **207** | dh | Thao tác chat group mở rộng | 110,137,138,139 | `ci.java:886` |

### VIP / giao dịch / mua bán
| Svc | Codec | Ý nghĩa | Key gửi | Ref |
|----:|-------|---------|---------|-----|
| **91** | bg | **Mua / giao dịch (transaction)** | 72,90,109,114 | `ci.java:84` |
| **166** | de | **Mua VIP (thời hạn ngày)** | 7,59,110,130,255 | `ci.java:668` |
| **147** | ay | **Lấy thông tin VIP** | 7,255 | `ci.java:1772` |
| **111** | u | Lấy số dư/balance | 72 | `ci.java:429` |
| **116** | cj | Lấy gift/sticker shop | 29,30,113,124,125,255 | `ci.java:1762` |

### Me-feed / nội dung / khác
| Svc | Codec | Ý nghĩa | Key gửi | Ref |
|----:|-------|---------|---------|-----|
| **97** | ba | **Đăng me/status có ảnh (WxH)** | 2,12,50,51,61,79,86,94,110,111,255 | `ci.java:630` |
| **96** | cz | Đăng feedback/me có ảnh | 14,50,51,61,86,94 | `ci.java:403` |
| **139** | o | Đăng me-feed (text) | 14,50,51,86,94 | `ci.java:1806` |
| **160** | dg | Like/share theo id | 12,129,255 | `ci.java:251` |
| **201** | k | Comment me theo id | 13,24,129,255 | `ci.java:1221` |
| **66** | p | Lấy quảng cáo/popup | 114,124,255 | `ci.java:167` |
| **65** | q | Lấy emoticon/sticker | 7,30 | `ci.java:1184` |
| **109** | cl | **Game caro: nước đi + lệnh r/s/t/u/v** | 7,209 | `ci.java:914…` |
| **55** | g | Đăng ký vị trí (geo) | 7,62 | `ci.java:1859` |
| **209** | cc | Load setting (bmk/rss/set) | 138,139,140,255 | `ci.java:873…` |

> Còn nhiều svc phụ (16,17,18,19,20,23,25,39,44,53,61,62,68–74,76,80,82,86,87,104,107,110,122,123,124,128,142,143,148,149,150,158,159,161,162,164,165,167,169,170,172,188,194,197,198,200,202,210…) — xem báo cáo đầy đủ bằng cách mở `w/<codec>.java` tương ứng (map ở `w/ch.java:9-121`).

---

## 4. RESPONSE / SERVER-PUSH (server → client)

> Dispatch tại `w/dq.java:24` → `codec.a(s, g, ci)`; callback ở `network/e.java`. Cùng service code dùng chung codec cho cả gửi và nhận.

| Svc | Codec | Ý nghĩa | Key đọc ra | Callback / Ref |
|----:|-------|---------|------------|----------------|
| **206** | f | **Kết quả LOGIN** | 2,5,9,43,50,61,79,86,94,111,112,135,255 | `e.java:703 a(ci,short)` |
| **195** | df | **Handshake response (challenge seed)** | 1,5,8 | `w/df.java` |
| **0** | ab | **Kết quả auth / status push** | 0(status),1,8,12,255 | `e.java:188` |
| **1** | da | **Server ngắt kết nối / logoff** | 1,11,255 | `w/da.java` |
| **2** | dv | **Nhận tin nhắn (incoming IM)** | 2,4,5,22,43,58,88,109,142,255 | `w/dv.java` |
| **106** | co | **Kết quả gửi IM / số dư** | 8,12,24,72,79,113,114,220,255 | `g.b(long,short)` |
| **12** | y | **Presence update của buddy** | 4,22,23,58,88,109 | `w/y.java` |
| **15** | c | **Danh sách bạn + presence** | 7,12,13,21,22,38,45,86 | `g.a(String,List)` |
| **67** | ad | **Danh sách bạn đầy đủ** (→ entity.l) | 2,6,9,24,62,69,109,205,206,207,255 | `w/ad.java` |
| **21** | m | **Yêu cầu kết bạn đến** | 7,12,13,38,45,58 | `w/m.java` |
| **50** | ai | **Hồ sơ buddy trả về** (→ entity.b) | 7,66,109,110,111,124,125,126,130,255 | `g.a(entity.b,short)` |
| **57** | e | **Tin nhắn nhóm/feed đến** | 7,8,9,20,45,109–112,114,116,117,124,130,137,220,255 | `w/e.java` |
| **85** | bf | **Tin nhắn phòng chat đến** | 2,79,100,114,255 | `w/bf.java` |
| **81** | at | **Kết quả vào phòng** | 30,100,101,103,104,109,255 | `w/at.java` |
| **189** | ec | **Danh sách thành viên nhóm** (→ entity.g[]) | 7,8,9,13,24,28,45,109,110,114,130,220,255 | `w/ec.java` |
| **163** | dk | Cập nhật nhóm chat | 7,9,24,45,109,110,129 | `w/dk.java` |
| **204** | bp | **Push typing/presence** | 0,8,23,109,110,130 | `w/bp.java` |
| **92** | ed | **Kết quả keepalive / số dư VIP** | nhiều (8,9,22,24,38,45,67,72,108,113,114,125,220,221,255) | `w/ed.java` |
| **147** | ay | **Thông tin VIP push** (→ List ah) | 7,9,109–112,114,130,255 | `g.a(...,List<ah>,short)` |
| **166** | de | **Kết quả mua VIP** | 7,45,59,110,111,114,130,255 | `w/de.java` |
| **97** | ba | **Kết quả đăng me/status** | 2,4,9,12,13,22,45,50,51,61,79,86,94,110,111,255 | `w/ba.java` |
| **117** | au | Push thông tin VIP/gift | 8,29,72,90,109,113,124,125,207,255 | — |
| **169** | ap | Danh sách online/presence | 7,9,22,23,109–114,124,255 | — |

> Sau login (svc 206 → `e.java:703`): set `h.m`, working-session, VIP status `H = ci.m()`, tự join các phòng "ola"/"#hai", và gửi loạt request khởi tạo (svc 209: `bmk`/`rss`/`set`).

---

## 5. Mã hoá / Encoding

1. **Số nguyên:** mọi short/int/long ghi/đọc **big-endian** (`util/e.java`). Value của key suy kiểu theo độ dài (`w/s.java:18`).
2. **Chuỗi:** charset mặc định nền tảng (UTF-8). Ghi `cg.java:21`; đọc `util/o.java:197-215`. Không Base64 ở tầng KV.
3. **Mật khẩu (key 43):** KHÔNG plaintext. `chat.ola.vn.j.a.a(byte[] seed, String pass)` (`j/a.java:63-74`):
   - `md5 = MD5(pass)` → hex (`j/a.java:10-31`).
   - Trộn pass với `seed` (challenge server, lưu ở `ci.w`) bằng **XOR** với offset `seed[0]` + padding `0x11` (`j/a.java:76-108`).
   - Cơ chế **challenge-response** (seed từ handshake svc 195/206/0).
4. **Value dạng chuỗi ghép / JSON:**
   - Danh sách (key 109–113): chuỗi nối `;`, tách bằng `m.e(str,";")`.
   - Một số field là JSON (vd check-in: `{"checkInId":"..."}` `ci.java:578`) hoặc `"id=...;chatgroupId=..."` (`ci.java:722`).
   - Kích thước ảnh key 51 = `"WxH"` (`w/ba.java:51`).
5. **Cờ session tự động:** `dr.a()` (`dr.java:32-46`) — packet có cờ session sẽ tự chèn key 2 (username) + key 135 (working session) từ `chat.ola.vn.h`; thiếu session → ném IOException (chặn gửi khi chưa login).
6. **Giới hạn:** value đọc tối đa 1.024.000 byte (`ce.java:46`); buffer body khởi tạo 10.260 byte (`cg.java:10`).

---

## Cách kiểm chứng nhanh
- Bảng dispatch service code → codec: `w/ch.java:9-121`.
- Header gửi/nhận: `w/dr.java:47-68` / `w/ce.java:27-60`.
- Body KV ghi/đọc: `w/cg.java:45-82` / `w/ce.java:40-56`.
- Map service code → method ngữ nghĩa: `grep "new bk((short)" w/ci.java`.
- Key từng lệnh: mở `w/<codec>.java`, đọc `a(bk,cg,g)` (request) và `a(s,g,ci)` (response).
- Callback push: `network/e.java` (interface `p/g.java`).

---

## ✅ Kiểm chứng THỰC TẾ (đã chạy với fake server — xem [../../fake-api/](../../fake-api/))

Đã dựng fake socket server (Node, port 1239) tái hiện giao thức và **đăng nhập + chat thật được** trên thiết bị. Các phát hiện đã xác nhận bằng bắt gói trực tiếp:

### Luồng kết nối → ONLINE (đã verify)
| Bước | Client gửi | Server phải trả | Tác dụng |
|------|-----------|-----------------|----------|
| 1 | **svc 96** (hello: locale, device-info, `1080x2266`, device-id) | key 11 (short) | client coi như connected, `gVar.f()` |
| 2 | **svc 206** (login: key2=user, key43=pass XOR) | key2/135/112/9/255 | nhận login, lưu working session |
| 3 | **svc 97** (`ba`: key2/12/50/51/110/111/255 + session) | **key 255=0** + key9/45 | ⭐ `gVar.a(ciVar, status)` → **STATE_AUTHENTICATING → STATE_ONLINE** (vào app) |

> ⚠️ Đính chính so với phân tích tĩnh: callback "login thành công" `a(ci,short)` (`e.java:703`) thực ra được kích hoạt bởi **response svc 97 (`ba`)** chứ không phải 206. Thiếu trả lời svc 97 → app kẹt `STATE_AUTHENTICATING` rồi reconnect liên tục.

### Chat 1-1 (đã verify)
- Gửi tin: app dùng **svc 14 (`Cdo`)** — key7=peer, key8=nội dung, key110=client-msg-id.
- Hiện tin đến: server **push svc 14** với key7=người gửi (≠ session) → `gVar.a(message.d)` (`e.java:664`) → bong bóng tin đến. (svc 2 `dv` chỉ là ACK.)
- Danh sách hội thoại (tab TIN NHẮN): push svc 14 từ nhiều nick → mỗi nick tạo 1 hội thoại.

### Mã hoá password (key 43) — verify thực tế
Fake server **không cần** seed/mật khẩu đúng: chỉ cần trả svc 206/97 success là app vào được (app tự mã hoá pass bằng seed bất kỳ, server bỏ qua). Đăng nhập chấp nhận **nick + mật khẩu bất kỳ**.

### Danh bạ (DANH BẠ) — KHÔNG fake được qua socket
Tab DANH BẠ đọc list `this.k` (`message.g`), chỉ nạp qua codec **`w/ca.java`** — nhưng `ca` là **DEAD CODE** (không trong bảng dispatch `ch.java`, không nơi nào khởi tạo). Đã thử wire `ca` vào svc trống (0xfa) trong smali + push, vẫn không render (còn gate state/refresh). Kết luận: luồng danh bạ đã bị gỡ trong bản 2.1.11. Chi tiết: [../../fake-api/README.md](../../fake-api/README.md).
