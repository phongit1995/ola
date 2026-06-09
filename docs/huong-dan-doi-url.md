# Hướng dẫn đổi URL/IP trong smali để chạy với Fake API

Tài liệu này liệt kê **chính xác các file smali + dòng cần sửa** để chuyển hướng app Ola từ server thật (`api.ola.vn` / `ocs.ola.vn`) sang **fake server trên máy bạn**, rồi build + ký lại APK.

> Giá trị hiện tại trong repo: REST → `192.168.2.7:8080`, Socket → `192.168.2.7:1239`.
> Đổi `192.168.2.7` thành IP máy bạn (LAN), hoặc `10.0.2.2` nếu chạy emulator AVD.

---

## 1. Các file & dòng cần sửa

### a) REST API → `api.ola.vn`
**File:** `apktool_out/smali/chat/ola/vn/util/http/a.smali`

| Dòng | Gốc | Đổi thành | Vai trò |
|-----:|-----|-----------|---------|
| ~351 | `const-string p4, "http://api.ola.vn/html/adme"` | `"http://192.168.2.7:8080/html/adme"` | URL trang adme |
| ~1000 | `const-string v1, "api.ola.vn"` | `"192.168.2.7"` | **Host-check** (app chỉ chấp nhận host này) |
| ~1100 | `const-string v0, "api.ola.vn"` | `"192.168.2.7"` | **Host-check** |
| ~1160 | `const-string v1, "http://api.ola.vn:/"` | `"http://192.168.2.7:8080/"` | Base URL (biến thể có cổng) |
| ~1178 | `const-string v1, "http://api.ola.vn/"` | `"http://192.168.2.7:8080/"` | **Base URL chính** |

> ⚠️ **Quan trọng:** host-check (dòng 1000/1100) phải là **host KHÔNG kèm cổng** (vì code dùng `new URL(...).getHost()` trả về host không cổng). Base URL (1160/1178/351) thì **có cổng**. Nếu host-check không khớp host trong URL → app bỏ request.

### b) Socket chat → IP server cứng
**File:** `apktool_out/smali/chat/ola/vn/f/d.smali`
- **8 dòng** `const-string v2, "210.211.116.xxx"` → đổi tất cả thành `"192.168.2.7"`
  (4 IP × 2 mảng `e_`/`f_`: `.129`, `.131`, `.134`, `.130`)

### c) Socket chat → hostname `ocs.ola.vn`
**File:** `apktool_out/smali/chat/ola/vn/network/h.smali`
- Dòng ~101: `const-string v2, "ocs.ola.vn"` → `"192.168.2.7"`

> **Cổng socket:** app tự thử cổng **1239** (chính) rồi **80** (fallback) — không cần sửa smali, chỉ cần fake socket server lắng nghe cổng 1239.

---

## 2. Lệnh sed đổi nhanh sang IP/cổng khác

Ví dụ đổi sang `10.0.2.2:8080` (emulator) — chạy trong `apktool_out/smali/chat/ola/vn`:

```bash
cd apktool_out/smali/chat/ola/vn

# REST: base URL (có cổng) + host-check (không cổng)
sed -i '' \
  -e 's#http://192.168.2.7:8080/#http://10.0.2.2:8080/#g' \
  -e 's#"192.168.2.7"#"10.0.2.2"#g' \
  util/http/a.smali

# Socket IP + host
sed -i '' 's#"192.168.2.7"#"10.0.2.2"#g' f/d.smali
sed -i '' 's#"192.168.2.7"#"10.0.2.2"#g' network/h.smali
```

Đổi cổng REST: thay `:8080` trong các base-URL string của `a.smali`, và chạy fake REST server đúng cổng đó.

---

## 3. Build + ký lại APK

```bash
cd /Volumes/D/ola/older-ola
BT=~/Library/Android/sdk/build-tools/35.0.0

apktool b apktool_out -o f.apk
"$BT"/zipalign -p -f 4 f.apk f_a.apk
"$BT"/apksigner sign --ks fake-ola.keystore \
  --ks-pass pass:android --key-pass pass:android \
  --out Ola_2.1.11_fake_signed.apk f_a.apk
rm -f f.apk f_a.apk

# Cài (gỡ bản cũ nếu khác chữ ký)
adb uninstall chat.ola.vn
adb install -r Ola_2.1.11_fake_signed.apk
```

---

## 4. Checklist chạy

1. Lấy IP máy: `ipconfig getifaddr en0` → cập nhật smali nếu khác `192.168.2.7`.
2. Build + ký + cài APK (mục 3).
3. Chạy fake server: `cd fake-api && node server.js & node socket-server.js`.
4. Thiết bị **cùng WiFi** với máy (hoặc emulator dùng `10.0.2.2`).
5. Mở app → đăng nhập nick/mật khẩu bất kỳ → vào app + chat.

> Điều kiện cleartext HTTP: app targetSdk=27 nên HTTP thường được phép mặc định (không cần network-security-config).

---

## 5. Bảng tóm tắt nhanh

| Kênh | File smali | Chuỗi cần đổi |
|------|-----------|---------------|
| REST base URL | `util/http/a.smali` | `http://api.ola.vn/` → `http://<IP>:<PORT>/` (2 chỗ) + `/html/adme` |
| REST host-check | `util/http/a.smali` | `api.ola.vn` → `<IP>` (2 chỗ, KHÔNG cổng) |
| Socket IP | `f/d.smali` | `210.211.116.x` → `<IP>` (8 chỗ) |
| Socket host | `network/h.smali` | `ocs.ola.vn` → `<IP>` |

Xem thêm: [fake-api/README.md](../fake-api/README.md) (cách chạy server), [api/socket-protocol.md](api/socket-protocol.md) (giao thức + luồng login).
