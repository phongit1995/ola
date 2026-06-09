# Ola 2.1.11 — HTTP REST API & JS Bridge

> Kênh phụ (ngoài socket): các API HTTP tới `api.ola.vn` cho đăng nhập, hồ sơ, mall, me-feed, thanh toán, check-in… và cầu nối JavaScript (WebView ↔ native).
> Đường dẫn file trỏ vào `jadx_out/sources/chat/ola/vn/`.

## A. Cơ chế chung

### Base URL & định tuyến — `util/http/a.java`
- **Base REST:** `http://api.ola.vn/` (cleartext HTTP) — `a.java:225` (hàm `c()`).
- Định tuyến path (`a.java:177-199`):
  - `rss://...` → `http://api.ola.vn/html/rss/view/<rest>`
  - `http://...` → chỉ chấp nhận nếu host chứa `api.ola.vn`, nếu không trả `null` (`a.java:182-187`).
  - path thường: `z=true` (JSON) → `json/<path>`; `z=false` (HTML) → `html/<path>`.

### Tham số chung (gắn vào MỌI request) — `a.java:106-129`
| Param | Nguồn | Ý nghĩa |
|-------|-------|---------|
| `owsc` | `e.a().j()` | **session code** (token đăng nhập). Rỗng + `z=true` → bỏ request |
| `owsn` | `h.a()` | nick/username |
| `cid` | `"77B9A513"` | client id |
| `apv` | `"24"` | API version |
| `acbh` / `btbh` | px | chiều cao action bar / button bar |
| `ctms` | timestamp tăng dần | client time ms (chống trùng) |
| `olaLocale` | `x.i()` | locale |
| `googlePlay` | `"true"` | |
| `deviceType` | `"4"` | Android |
| `olaVersion` | `"5.10.19"` | phiên bản app |
| `sig` | tính ký | chữ ký request |

### Ký request `sig` — `a.java:138-152`
1. Gom: **path** (bỏ `/` đầu) + tất cả cặp `key=value`.
2. **Sort** alphabet.
3. Nối bằng dấu cách `" "`, rồi `.trim()`.
4. `sig = MD5_hex(chuỗi)` (`j/a.java:10-19`).
5. Thêm `sig` vào params rồi build query.

> ⚠️ `sig` không có secret key trong chuỗi ký → chỉ chống sửa params, **không phải HMAC bí mật**, dễ giả mạo nếu biết thuật toán.

### Lớp transport & parse — `util/http/c.java`
- Dùng `AndroidHttpClient`, **chỉ HTTP GET** (`HttpGet`), header **`user-agent: "JSON Fetcher: 24"`**. Timeout 15s / 3s.
- `e(url)`→String; `g(url)`→JSONObject (lỗi parse → `{code:"0", meta:<raw>}`); `f(url)`→byte[].
- Lỗi: hầu hết bọc `try/catch Throwable` → trả `null`. Response chuẩn nhiều endpoint kiểm tra `code==0` + `payload`.

### Luồng auth & mã hoá mật khẩu — `a.java:39-71`
1. `GET id/pubkey?un=<user>` → mảng byte "public key" (chuỗi `[b1,b2,...]`).
2. Mã hoá pass: `j.a.a(pubKeyBytes, password)` — **KHÔNG phải RSA chuẩn** mà là **XOR custom + offset theo MD5(password)** (`j/a.java:63-74`), rồi `Base64 (NO_WRAP|URL_SAFE)`.
3. `GET id/signin?un=<user>&pw=<base64>` → JSON `{code, loginName, sessionCode, lastLoginTime, meta}`.
   - `code==1` → lưu `authAccount`, `authtoken=sessionCode`, `_time`.
   - khác → đọc `meta` làm thông báo lỗi.
4. **Session** = `sessionCode` → dùng làm `owsc` cho mọi request sau.

---

## B. Bảng endpoint REST

> Tất cả là **GET** (lib chỉ dùng HttpGet); thao tác ghi (like/create/commit) cũng đưa data lên query string. Path tương đối với `http://api.ola.vn/`, tự prefix `json/` hoặc `html/`.

### Tài khoản / đăng nhập
| Path | Request params | Response fields | Ref |
|------|----------------|-----------------|-----|
| `id/pubkey?un=` | `un` | mảng byte public key | a.java:41 |
| `id/signin?un=&pw=` | `un`, `pw` (b64) | `code, loginName, sessionCode, lastLoginTime, meta` | a.java:47-65 |
| `id/signup` (html) | form web | — | OlaOAuthenRegisterHtmlActivity:142 |
| `id/check` | `un` | `nick, result(bool)` | network/a/a/a.java |
| `id/regable` | `un` | `nick, result(bool)` | network/a/a/m.java |
| `id/pubinfo` | `fields=ip,ms,acckit,facebook,...` | info hệ thống | c.java:78 |
| `id/profile` | `un` hoặc `phone`; `fields` | `errorCode, nick, name, gender, birthday, registerMs, lastActiveAgo, socialLinkType, noFans, noFriends, noMedias, statusMessage, cared, isFan, blocked, boxSpouse, vip, phone{number,verified,protect}, like{...}, friends[], fans[], medias[]` | network/a/a/w.java:44-225 |
| `id/authweb` | `did` | `url` | network/a/a/am.java |
| `id/activehit` | (chung) | — (ping active) | network/a/a/ae.java |
| `id/signoutall` | (chung) | — | network/a/a/ak.java |

### Me-feed / like / RSS
| Path | Request params | Response fields | Ref |
|------|----------------|-----------------|-----|
| `me/view/<id>` | id | `id, content, creator, createdDate, deltaTime, likes[], kulId, mediaCode, liked, likeCount, replyCount` | network/a/a/s.java, r.java |
| `me/attachs/<id>` | id | `url, title, intro, media, noLikes, liked, likes[], noComments, type` | network/a/a/t.java |
| `me/visit/more` | `ms`, `n` | `visits[]{nick, dms}, more` | network/a/a/u.java |
| `like/act/<a>/<b>` | `act` | `1, 2, liked, likers[]` | network/a/a/ag.java |
| `like/gets/<c>` | `ids` (JSON array) | per-id `{1,2,liked,likers[]}` | network/a/a/ad.java |
| `rss/get`, `rss/get/<id>` | id | `type, title, content, thumbCode, meId, noLikes, liked, noComments` | network/a/a/x.java |

### Mall / Gallery / Sticker
| Path | Request params | Response fields | Ref |
|------|----------------|-----------------|-----|
| `mall/` (list) | morePath | `code, payload[...]` | network/a/a/q.java |
| `mall/getTow?towId=` | `towId` | `code, payload` | network/a/a/q.java |
| `mall/hittow?id=&owsn=` | `id`, `owsn` | — (đếm view) | network/a/a/af.java |
| `mall/yt?id=` | `id` | `payload{title, duration, hqThumbnailUrl}` | network/a/a/ac.java |
| `mall/like?id=` / `mall/unlike?id=` | `id` | — | network/a/a/ah.java |
| `mall/watch?id=` | `id` | — | m/g.java:119 |
| `mall/search?q=` | `q` | (list) | m/w.java:90 |
| `mall/tags` | — | tags | m/g.java:82 |
| `gallery`, `gallery/...` | path động | `type(cats/folders/files), morePath, cats[]/folders[]/files[]{name,path,coverUrl,count,url}` | network/a/a/ab.java |
| `gallery/cat/sticker` | — | `folders[]{id,name,coverUrl,path,count}` | network/a/a/z.java |
| `gallery/folder/<id>` | path | `files[]{url}` | network/a/a/aa.java |
| `scrape/http/get?url=` | `url` | `site, title, desc, image, redirect` | network/a/a/aj.java |

### Thanh toán / game
| Path | Request params | Response fields | Ref |
|------|----------------|-----------------|-----|
| `pay/ginapp/payload?packageName=&productId=` | `packageName`, `productId` | `errorCode, productId, payload` | network/a/a/v.java |
| `pay/ginapp/request` | `packageName`, `country`, `simAvailable` | `payload` (danh sách sản phẩm) | network/a/a/y.java |
| `pay/ginapp/commit` | `responseCode`, `purchaseData`, `dataSignature` | `errorCode, message, purchaseToken, productId` | network/a/a/n.java |
| `player/token` | `gameCode=ola`, `deviceId`, `socialToken`, `socialType` | `token` | l/e.java |
| `player/member/list` | `gameCode=ola`, `deviceId`, `token`, ... | `nicks[]` | l/d.java |
| `player/member/register` | `gameCode=ola`, `deviceId`, `token`, `nick`, `pass`, `phone` | `owsc` (session mới) | l/i.java |
| `player/member/acckit` | `kitToken`, `gameCode=ola.acckit`, `act`, `nick` | `nicks`/`pass`/`error`, `acc{phoneNumber}` | network/a/a/o.java,p.java,ai.java,al.java |

### Check-in / Venue (Aurora)
| Path | Request params | Response fields | Ref |
|------|----------------|-----------------|-----|
| `aurora/action` | — | `code, payload[]{id,name,icon,placeholder,allowDefined, items[]{...}, icons[]}` | network/a/a/b.java |
| `aurora/item/create?info=` | `info` (JSON) | `payload{id,lastModified,mediaCode,name,lon,lat}` | network/a/a/c.java |
| `aurora/item/find?info=&lmt=` | `info`, `lmt` | `payload{nextPage, items[]{...}}` | network/a/a/g.java |
| `aurora/preparecheckin?info=` | `info` | `payload` (string) | network/a/a/i.java |
| `aurora/venue/create?info=` | `info` | `payload{email,desc,mediaCode,name,venueId,lon,lat,distance,checkinNo}` | network/a/a/d.java |
| `aurora/venue/update?info=` | `info` | giống venue create | network/a/a/j.java |
| `aurora/venue/find?info=&lmt=` | `info`, `lmt` | `payload{nextPage, venues[]{...,distanceMt}}` | network/a/a/k.java |
| `aurora/venue/find/opt?...` | query opt | `payload{venues[]{...}}` | network/a/a/l.java |
| `aurora/venue/watch?id=` | `id` | `payload{...,mediaCodes[],type,wifi,familiar{userName,checkinNo}}` | network/a/a/e.java |
| `aurora/checkin/list?id=&mid=` | `id`, `mid` | `payload{nextMeId, checkins[]{meId,content,username,id,createTime,mediaCode,timeAgo}}` | network/a/a/h.java |
| `aurora/checkin/get/full?chid=` | `chid` | `payload{id,username,createTime, action{...}, venue{...}, items[]{...}}` | network/a/a/f.java |

### Khác
| Path | Request params | Response fields | Ref |
|------|----------------|-----------------|-----|
| `api/apps` | — | `version, apps[]{name,notifyText,isNotification,positionIndex,appAction,url,icon}` | util/http/b.java |
| `adme/create-adme?meid=` (html WebView) | `meid` | form web | util/b.java:33 |
| `adme/createAdRoom?status=&roomId=` (html) | `status`, `roomId` | form web | util/b.java:38 |
| `html/translate/view/` | — | trang dịch (WebView) | m/z.java |
| `html/rss/view/<id>` | — | trang RSS (WebView) | a.java:180 |

---

## C. JS Bridge — `util/http/WebAppInterfaceImp.java`

> Đối tượng JS được inject vào WebView, mọi method gắn `@JavascriptInterface`. Đây cũng là "API" giữa trang web (mall/me/adme) và app native.

| Method | Chức năng |
|--------|-----------|
| `copyToClipboard(s)` | Copy text vào clipboard |
| `fetchHttpUrl(url, hdrs, m1, m2, cb)` | Fetch HTTP qua native, trả JS qua `loadUrl(callback)` |
| `fetchUrl(url[, hdrs], cb)` | Wrapper của fetchHttpUrl |
| `getClientPhone(cb)` | Trả số điện thoại client về JS |
| `getHtmlFromPage(s)` | Parse HTML trang |
| `getTopActionBarHeight(cb)` | Trả chiều cao action bar |
| `openApp(a, b)` | Mở app/route nội bộ |
| `openHttp(url)` / `openHttpTrust(url)` | Mở URL HTTP (untrusted/trusted) |
| `openMeByClan(s)` / `openMeByNick(s)` | Mở trang "Me" theo clan/nick |
| `openMedia(url)` / `openMedias(urls[], idx)` | Mở ảnh/video/audio / gallery |
| `openRss(s)` | Mở `rss://<s>` |
| `playSoundUrl(url)` / `playSoundUrls(json,i,j)` | Phát audio |
| `playVideoUrl(url, i)` / `playYoutubes(ids[],i,j)` | Phát video / YouTube |
| `requestShowPostMeRssForm(a,b,c)` | Mở form đăng "Me" từ RSS |
| `sendSms(num, body)` | Gửi SMS (qua OlaSmsSendingActivity) |
| `showPostMeForm(...)` / `showReplyMeForm(id,txt)` | Form đăng / trả lời "Me" |
| `showToast(s)` | Hiện toast |
| `startChatGroup(s)` / `startChatOla(s)` | Mở chat nhóm / 1-1 |
| `createOlaMallShortcut`, `hi`, `onCloseApp`, `onSignInComplete`, `onSignUpComplete`, `onVisibleActionBar` | (no-op / callback rỗng) |

> ⚠️ **Cảnh báo bảo mật:** bridge gồm `openHttp`/`fetchHttpUrl` (fetch URL tuỳ ý, inject kết quả qua `loadUrl(javascript:...)`), `getClientPhone` (lộ SĐT), `sendSms` (gửi SMS). Trên WebView cũ + HTTP cleartext, kẻ tấn công MITM có thể chèn JS gọi các method này → bề mặt tấn công đáng kể.

---

## D. Subdomain & mục đích

| Host | Vai trò |
|------|---------|
| `api.ola.vn` | REST API chính (mọi endpoint bảng B); chỉ host này được chấp nhận cho HTTP request native |
| `mall.ola.vn` | Cửa hàng/shop (path `mall/*` phục vụ qua api.ola.vn) |
| `mobile.ola.vn` | Cổng web mobile (WebView) |
| `gamestore.ola.vn` | Game store (liên quan `player/*`, `pay/ginapp/*`) |
| `birthday.ola.vn` | Tính năng sinh nhật (web) |
| `adme.ola.vn` | Quảng cáo / đăng "adme" |
| `props.kaspee.com`, `s1.cdn.kaspee.com` | CDN ảnh/sticker/media (resolve từ `mediaCode`, `coverUrl`, `thumbCode`) |

---

## Tóm tắt phát hiện chính
- Toàn bộ traffic **HTTP cleartext**, mọi request **GET** (kể cả thao tác ghi).
- Ký request bằng **MD5** của (path + params sort + nối space) → `sig`; không có secret → chống sửa params chứ không bảo mật mạnh.
- Mật khẩu mã hoá bằng **XOR custom dựa trên MD5(password) + offset**, KHÔNG phải RSA thật (dù lấy "pubkey" từ `id/pubkey`).
- Session = `owsc` (sessionCode), nick = `owsn` — gắn vào mọi request.
- File load-bearing: `util/http/a.java` (build+sign), `util/http/c.java` (transport GET), `j/a.java` (MD5 sig + mã hoá pass), `network/a/a/*.java` (~39 lớp request — mỗi lớp 1 endpoint), `util/http/WebAppInterfaceImp.java` (JS bridge).
