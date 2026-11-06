# Plan: Loa (phát loa tới mọi người)

Ngày lập: 04/11/2026 · Cập nhật: 06/11/2026 · Trạng thái: thiết kế mới (server tự phát, viên nổi, loa quà) đã làm ở server, admin, web ngày 06/11/2026, **chưa deploy**. Mobile chỉ có ô thông báo ở hộp chọn quà, chưa có Loa

User trả KEN để phát một câu ngắn, hoặc tặng một món quà có thông báo. Server tự phát thông báo chung cho mọi người trong 30 phút, lặp lại theo lượt. Câu đó chạy trong viên nổi trên đầu màn hình, giống thông báo của admin. Máy nào đã xem thì không hiện lại. Màn "Loa" xem lại được loa thường 24 giờ gần nhất, loa quà không nằm trong lịch sử.

## 1. Phạm vi

| Hạng mục | Chốt |
|---|---|
| Loại tin | **Loa thường** (user tự viết, trả KEN) và **loa quà** (server tự tạo khi tặng quà). Chung một đường phát |
| Ai gửi loa thường | **Mọi user**, trả KEN mỗi lần, **trừ hẳn** (hệ thống thu về). Giá admin chỉnh |
| Nội dung loa thường | Chữ thường + emoji unicode, tối đa 80 ký tự (setting). **Không** link, không ảnh/sticker/smiley của app |
| Nội dung loa quà | Câu tự tạo kiểu "A tặng B Lâu Đài Vàng ×5". Không có chữ tự viết, không có lời nhắn kèm quà. **Miễn phí** |
| Ai điều khiển | **Server quyết định hết**: phát tin nào, lúc nào, lặp bao nhiêu lần. Client không gọi API lấy loa đang phát, chỉ nhận qua websocket |
| Thời gian sống | 30 phút (setting). Hết hạn thì server ngừng phát |
| Nơi hiện | 6 tab (Chat, Phòng chat, Me, Truyện, Game, Cá nhân) và **trong phòng chat** |
| Nơi ẩn | Mọi màn full màn hình: chat 1-1, chat với bot, gợi ý kết bạn, lời mời kết bạn, cuộc gọi, khoảnh khắc, xem và cắt ảnh, game, Nối từ, đọc truyện, chi tiết truyện, mua VIP, mua KEN, Quà tặng, BXH quà, lịch sử quà, Thông báo, Cài đặt, Thông tin cá nhân, trang cá nhân người khác, clan, Kết hôn, màn Loa |
| Cách hiện | Viên nổi giống `AnnouncementBanner`: icon loa đứng yên; icon VIP của người gửi (chưa có VIP thì icon mặc định), `@username`, nội dung chạy từ phải sang trái một lượt trong 12 giây, không hiện avatar. Có nút X |
| Đã xem | Tính **theo thiết bị**. Chạy hết một lượt, bấm vào loa hoặc bấm X đều là đã xem. **Sau đó server có phát lại thì máy đó vẫn không hiện** |
| Xem lại | Màn **"Loa"** liệt kê loa thường 24 giờ gần nhất, **không có loa quà**. **Không push** |
| Kiểm duyệt | Từ cấm và link bị chặn **trước khi trừ KEN**. User báo cáo được loa thường; admin xoá thì server ngừng phát và loa biến mất trên mọi máy, có thể cộng điểm vi phạm, không hoàn KEN |
| Người mình đã chặn | Ẩn loa của họ ở máy mình |

Ngoài phạm vi (để sau): loa trong game, loa có ảnh/sticker, loa "nổi bật" trả thêm, ghim loa, trả lời/thả tim loa, push, người gửi tự huỷ loa đang chờ, tặng quà ẩn danh.

## 2. Cái đã có, dùng lại

- **Phát tới mọi người đang online**: `wsServer.BroadcastToAll` ([server.go](../server/internal/transport/websocket/server.go)) phát vào room `broadcast:online`, chạy qua Redis adapter nên đúng cả khi có nhiều instance. Mẫu đầy đủ là **rương KEN**: [kenchest.service.go](../server/internal/modules/kenchest/kenchest.service.go) publish Kafka → [domain/kenchest/kenchest.handler.go](../server/internal/domain/kenchest/kenchest.handler.go) ở chat service gọi `BroadcastToAll`.
- **Trừ KEN trong transaction + chống trừ 2 lần**: y như `Send` của tặng quà ([gift.service.go](../server/internal/modules/gift/gift.service.go)): `clientRequestId` unique theo người gửi, khoá dòng user, ghi `ken_transactions`, sau commit `wsServer.EmitKenUpdate`.
- **Cài đặt**: `app_settings` KV + Validate + form admin (mẫu `setting.gift.go`, trang `GiftSettingsPage`).
- **Báo cáo + điểm vi phạm**: module `report` + `REPORT_TARGET_TYPE` (shared) + cảnh báo Discord/Telegram sẵn có; admin xử lý thì gọi `moderation.RecordPenalty` / `ApplyPenalty` như [admin/report/report.service.go](../server/internal/modules/admin/report/report.service.go) và [admin/me/me.service.go](../server/internal/modules/admin/me/me.service.go).
- **Realtime phía client**: mẫu [stores/ken/kenRealtime.ts](../packages/shared/src/stores/ken/kenRealtime.ts) (`claimRealtimeRegistration`, `SocketService.on`, đồng bộ lại khi `onReconnect`).
- **Danh sách người mình chặn**: `roomFilterStore.blockedUserIds` ([roomFilterStore.ts](../packages/shared/src/stores/room/roomFilterStore.ts)).
- **Rate limit**: policy trong [rate_limit.policy.go](../server/internal/middleware/rate_limit.policy.go).
- **Bộ lập lịch chạy nền**: mẫu [kenchest.scheduler.go](../server/internal/modules/kenchest/kenchest.scheduler.go), khởi động ở `cmd/api/scheduler.go`, có kênh `wake` để đánh thức sớm.
- **Redis**: sorted set đã dùng ở [room.message.redis.go](../server/internal/modules/room/room.message.redis.go), khoá `SetNX` đã dùng ở nhiều module.
- **Quyền riêng tư tường quà**: `GiftWallPrivacy` trong [gift.repository.go](../server/internal/modules/gift/gift.repository.go), 3 mức `All`, `Friends`, `OnlyMe`.
- **Chưa có**: bộ lọc từ cấm. Đã làm ở module riêng `internal/modules/content-filter` (dùng chung được cho phòng chat sau này).

## 3. Dữ liệu

Postgres là nguồn chuẩn cho tiền, lịch sử và trạng thái gỡ. Redis chỉ giữ lịch phát (4.3) và dựng lại được từ Postgres.

Bảng `megaphones` đã tạo trong `20261105000001_add_moderation_gifts_megaphones`. **Không sửa migration đó.** Thiết kế mới nằm ở `20261106000001_add_megaphone_schedule`:

```sql
ALTER TABLE megaphones
  ADD COLUMN type varchar(20) NOT NULL DEFAULT 'message',
  ADD COLUMN weight smallint NOT NULL DEFAULT 3,
  ADD COLUMN expires_at timestamptz,
  ADD COLUMN first_played_at timestamptz,
  ADD COLUMN gift_transaction_id uuid;

UPDATE megaphones
SET expires_at = show_at + display_seconds * interval '1 second',
    first_played_at = show_at;

ALTER TABLE megaphones ALTER COLUMN expires_at SET NOT NULL;
CREATE UNIQUE INDEX uq_megaphones_gift_transaction
  ON megaphones (gift_transaction_id) WHERE gift_transaction_id IS NOT NULL;
CREATE INDEX idx_megaphones_active ON megaphones (expires_at) WHERE status = 'active';

ALTER TABLE gifts ADD COLUMN announce_enabled boolean NOT NULL DEFAULT false;
```

- `type`: `message` (loa thường) | `gift` (loa quà).
- `status`: `active` | `removed`. Không xoá dòng: admin cần tra lại khi có khiếu nại.
- `weight`: trọng số chốt lúc tạo, admin đổi mốc sau đó không ảnh hưởng tin đang chạy.
- `first_played_at`: lúc server phát lượt đầu. Còn `NULL` nghĩa là tin đang chờ lượt đầu, dùng để tính trần tải (4.4) và lịch sử chỉ hiện loa thường đã phát.
- `show_at`: lúc tạo bằng giờ gửi, khi phát lượt đầu được đổi thành giờ phát thật. Không còn dùng để xếp lịch, chỉ để sắp xếp lịch sử.
- Loa quà: `ken_price = 0`, `client_request_id = 'gift:<transactionId>'`, `content` lưu câu tiếng Việt để admin đọc; app tự ghép câu theo ngôn ngữ từ dữ liệu quà.
- `gifts.announce_enabled` mặc định tắt, admin bật theo từng quà.
- KEN: `KenTxTypeMegaphone = "MEGAPHONE"` ([ken_transaction.model.go](../server/internal/models/ken_transaction.model.go)), chỉ loa thường mới có giao dịch này.
- Setting `megaphone` (app_settings):

| Field | Mặc định | Ý nghĩa |
|---|---|---|
| `enabled` | `true` | Công tắc tổng |
| `kenPrice` | `5000` | Giá một lần phát loa thường, admin sửa được (đổi từ 2.000) |
| `maxLength` | `80` | Số ký tự tối đa |
| `liveMinutes` | `30` | Thời gian sống của mỗi tin (mới) |
| `displaySeconds` | `12` | Thời gian chạy một lượt (đổi từ 10) |
| `gapSeconds` | `3` | Nghỉ giữa 2 lượt phát (mới) |
| `repeatBaseSeconds` | `720` | Nhịp lặp của trọng số 1 (mới) |
| `messageWeight` | `3` | Trọng số loa thường (mới) |
| `giftTiers` | `[{minKen:0,weight:1},{minKen:1000,weight:3},{minKen:20000,weight:6}]` | Mốc trọng số loa quà theo tổng KEN = giá × số lượng (mới) |
| `cooldownSeconds` | `60` | Mỗi người phải chờ giữa 2 lần phát, tính riêng từng loại |
| `dailyLimit` | `20` | Số loa thường tối đa mỗi người mỗi ngày (giờ VN) |

`maxQueueSeconds` bị bỏ, thay bằng trần tải tự tính (4.4). `validateMegaphoneValue` đang từ chối field lạ nên phải sửa cùng form admin, và phải đọc được giá trị cũ đã lưu trong `app_settings`.

- Setting `content_filter` riêng: `{ bannedWords: string[] }` (tối đa 5.000 từ, mỗi từ 60 ký tự). Tách khỏi `megaphone` để dùng lại cho phòng chat, bài Me sau này. Không cần cache riêng: `app_settings` đã cache cả bảng trong Redis và xoá khi admin lưu.

## 4. Server (Go) — module `internal/modules/megaphone`

Khuôn module: `megaphone.router.go`, `.controller.go`, `.service.go`, `.repository.go`, `.dto.go`, `.constants.go`, `.errors.go`, `.dig.go`; đăng ký ở `cmd/api/container.go`. Handler Kafka đặt ở `internal/domain/megaphone/` và đăng ký trong chat service.

### 4.1 API người dùng (`RequireAuth`)

| Method | Path | Mô tả |
|---|---|---|
| GET | `/megaphones/config` | `{ enabled, kenPrice, maxLength, displaySeconds, cooldownSeconds, dailyLimit, todayCount, cooldownRemaining, queueWaitSeconds }` cho màn soạn. `queueWaitSeconds` = thời gian chờ dự kiến (4.4) |
| GET | `/megaphones?cursor=` | Lịch sử 24 giờ cho màn Loa, chỉ `type = 'message'` đã phát (`first_played_at` khác `NULL`), mới nhất trước, keyset theo `(show_at, id)`, bỏ tin `removed`. **Không trả loa quà** |
| POST | `/megaphones` | Phát loa (4.2), trả 201. Rate limit `PolicyMegaphoneSend` 6 lần/phút (đếm cả lượt bị từ chối) |

**Bỏ `GET /megaphones/active`.** Client không lấy loa đang phát qua API: ai mở app sau sẽ nhận ở lượt lặp kế tiếp.

Request: `{ "content": "...", "clientRequestId": "uuid" }` → Response: `{ megaphone, kenBalance, waitSeconds }`.

`megaphone` (dùng chung cho API và socket): `{ id, type, sender: { id, username, fullName, avatar, vipUsed, vipEndTime }, content, showAt, displaySeconds, expiresAt, createdAt, gift?: { id, name, nameEn, imageUrl, quantity }, receiver?: { id, username, fullName, avatar } }`.

### 4.2 Luồng `Send`

1. Setting tắt → `MEGAPHONE_DISABLED`.
2. Chuẩn hoá nội dung: cắt khoảng trắng hai đầu, gộp khoảng trắng và xuống dòng thành một dấu cách; rỗng → `MEGAPHONE_CONTENT_EMPTY`, quá `maxLength` ký tự (đếm rune) → `MEGAPHONE_CONTENT_TOO_LONG`.
3. Có link (`http`, `www.`, dạng `abc.com` / `abc.vn`...) → `MEGAPHONE_LINK_NOT_ALLOWED`. Đuôi dễ trùng chữ thường (`.me`, `.co`, `.ly`, `.gg`, `.tv`...) chỉ bị chặn khi có `/` phía sau (`zalo.me/…`, `bit.ly/…`) để "ok.co", "chao.me" không bị chặn nhầm.
4. Dính từ cấm → `MEGAPHONE_CONTENT_BLOCKED`. So khớp theo từ sau khi chuẩn hoá (chữ thường, bỏ dấu, dấu câu thành khoảng trắng): một từ chỉ khớp khi đứng riêng nên "dit" không chặn nhầm "đi tắm"; chuỗi chữ cái đơn liền nhau được ghép lại để bắt "đ.ị.t", "d i t"; cụm nhiều từ còn khớp khi viết liền thành một từ ("napkengiare"); 2–3 mẩu ngắn (≤3 ký tự) liền nhau được ghép thử để bắt kiểu tách "za lo", "đị.t". Danh sách từ đã chuẩn hoá được nhớ trong process, chỉ tính lại khi admin đổi danh sách.
5. Trùng `clientRequestId` → trả lại kết quả cũ ngay, kể cả khi admin vừa tắt loa hay thêm từ cấm (khác nội dung → `MEGAPHONE_REQUEST_CONFLICT`). Bước này chạy trước cả bước 1.
6. **Một transaction DB**, mọi lượt phát xếp hàng qua cùng một `pg_advisory_xact_lock` nên các bước kiểm dưới đây không bị chạy song song vượt giới hạn:
   - Đã có `(sender_id, client_request_id)` → trả kết quả cũ, không trừ lần nữa (bắt được cả 2 request trùng gửi cùng lúc).
   - Đủ `dailyLimit` trong ngày giờ VN (`utils.VietnamPeriodStart`) → `MEGAPHONE_DAILY_LIMIT`. Chỉ đếm `type = 'message'`, để loa quà không ăn vào lượt của user.
   - Loa thường gần nhất của người này chưa quá `cooldownSeconds` → `MEGAPHONE_COOLDOWN` (tính từ `created_at`, không dùng Redis; số giây còn lại trả ở `/megaphones/config`). Cũng chỉ tính `type = 'message'`.
   - Kiểm trần tải (4.4), đầy → `MEGAPHONE_QUEUE_FULL`.
   - `SELECT ... FOR UPDATE` dòng người gửi, thiếu KEN → `MEGAPHONE_INSUFFICIENT_KEN`.
   - Trừ `users.ken`, ghi `ken_transactions` type `MEGAPHONE`, `ref_type = 'megaphone'`, `ref_id`.
   - Insert `megaphones` với `expires_at = now + liveMinutes`.
7. Sau commit: `wsServer.EmitKenUpdate`, đưa tin vào lịch Redis (4.3) và đánh thức bộ lập lịch. Redis lỗi thì chỉ log: bước đối chiếu Postgres sẽ bù lại.

Mọi lỗi đều trả về **trước** khi trừ KEN.

### 4.3 Bộ lập lịch và thuật toán phát

Server phát xoay vòng như đài phát thanh. Lượt đầu ai đang ở màn ẩn lỡ thì lượt sau vẫn thấy, ai mở app muộn cũng tự nhận được ở lượt kế tiếp.

**Vị trí:** `internal/modules/megaphone/megaphone.scheduler.go`, chạy trong API như `kenchest.Scheduler`, có kênh `wake`. Chạy nhiều instance thì khoá Redis bảo đảm mỗi lượt chỉ một máy phát.

**Redis**

| Key | Dùng để |
|---|---|
| `MEGAPHONE:SCHEDULE` (sorted set) | Id tin, điểm là điểm lượt |
| `MEGAPHONE:ITEM:<id>` | Dữ liệu tin + `weight`, `expiresAt`, `lastPlayedAt`. TTL theo hạn |
| `MEGAPHONE:VIRTUAL_PASS` | Điểm lượt chung hiện tại |
| `MEGAPHONE:NEXT_SLOT` | Thời điểm sớm nhất được phát tin kế |
| `MEGAPHONE:LOCK` | Khoá `SetNX` chống phát trùng |

**Thuật toán: xếp lượt theo trọng số (stride scheduling).** Mỗi lượt cách nhau `displaySeconds + gapSeconds` = 15 giây:

1. Lấy khoá; chưa tới `NEXT_SLOT` thì thôi.
2. Bỏ tin hết hạn khỏi lịch.
3. Từ điểm lượt thấp lên cao, chọn tin đầu tiên đã đủ thời gian lặp: `now - lastPlayedAt >= repeatBaseSeconds / weight`. Tin chưa phát lần nào luôn đủ điều kiện. Không có tin nào thì lượt này trống.
4. Publish Kafka `CHAT.MEGAPHONE.PLAY`. Lần đầu thì ghi `first_played_at`.
5. `VIRTUAL_PASS = max(VIRTUAL_PASS, điểm của tin)`, rồi cộng điểm tin: `điểm = max(điểm, VIRTUAL_PASS) + repeatBaseSeconds / weight`.

Tin mới vào lịch với điểm bằng `VIRTUAL_PASS`, nên chạy trước các lượt lặp. Khi vắng, tin lặp đúng nhịp riêng. Khi đông, số lượt tự giãn theo tỉ lệ trọng số, tin nhẹ vẫn tới lượt.

| Loại | Tổng KEN | Trọng số | Lặp lại sau |
|---|---|---|---|
| Quà nhỏ | Dưới 1.000 | 1 | 12 phút |
| Loa thường, quà vừa | 1.000 đến 19.999 | 3 | 4 phút |
| Quà lớn | Từ 20.000 | 6 | 2 phút |

Số lượt phát trung bình mỗi tin trong 30 phút, theo mô phỏng ngày 06/11 với số giả định (chưa có trần tải):

| Tình huống | Quà nhỏ | Loa | Quà lớn |
|---|---|---|---|
| Vắng: 3 tin | 3 | 8 | 15 |
| Vừa: 27 tin trong 30 phút | 2,8 | 7 | 13,5 |
| Đông: 110 tin trong 30 phút | 1,1 | 2,5 | 3,8 |
| Dồn: 90 tin trong 2 phút | 1 | 1,6 | Không có trong kịch bản |

Không tin nào bị bỏ sót trong cả 4 tình huống.

**Đối chiếu Postgres:** khi khởi động và mỗi phút, bộ lập lịch nạp tin `active` còn hạn mà Redis chưa có, bỏ tin đã gỡ, và ghi bù `first_played_at` nếu lần trước ghi lỗi. Mất Redis thì dựng lại được, tin đang chạy chỉ mất thứ tự lượt. Người gửi bị khoá hoặc xoá tài khoản thì tin của họ bị bỏ khỏi lịch ở lần đối chiếu kế tiếp, tối đa 1 phút.

### 4.4 Trần tải tự tính

Admin không nhập số tin tối đa. Server tính từ thời gian sống:

```
slot         = displaySeconds + gapSeconds                 (15 giây)
capacity     = liveMinutes * 60 / slot                     (120 lượt)
messageWait  = liveMinutes * 60 / 3                        (10 phút)
giftWait     = messageWait / 2                             (5 phút)
expectedWait = số tin active, first_played_at NULL, còn hạn × slot
```

- Loa thường: `expectedWait > messageWait` (40 tin đang chờ) → `MEGAPHONE_QUEUE_FULL`, không trừ KEN.
- Loa quà: `expectedWait > giftWait` (20 tin đang chờ) → không tạo loa, **quà vẫn tặng thành công**, trả `announced: false`.
- Đếm trong transaction, sau `pg_advisory_xact_lock`, để hai người gửi cùng lúc không vượt trần.
- Đổi `liveMinutes` thì các số này tự đổi theo.

### 4.4b Loa quà

**Không đổi:** thông báo cho người nhận vẫn chạy như cũ dù có loa hay không. Quà tặng trong chat vẫn là tin nhắn quà, quà tặng ở trang cá nhân vẫn là `AppNotificationGiftReceived`. Việc người tặng tắt loa không ảnh hưởng người nhận.

**Điều kiện tạo loa quà, phải đủ cả 5:**

1. Quà có `announce_enabled = true`, do admin cài.
2. Người tặng để `announce = true`.
3. Tường quà người nhận ở mức công khai (`SettingGiftWallPrivacyAll`). Mức bạn bè hoặc chỉ mình tôi thì không phát.
4. Loa quà gần nhất của người tặng đã quá `cooldownSeconds`.
5. Chưa chạm trần tải loa quà (4.4).

**Thay đổi API tặng quà**

- Catalog: `GiftItem` thêm `announceEnabled`.
- `SendGiftRequest` thêm `announce` (bool). Không gửi thì coi là `false`, để người dùng bản cũ không bị phát mà không có cách tắt.
- `SendGiftResponse` thêm `announced` (bool). Server tự kiểm tra lại mọi điều kiện, không tin client.

**Luồng:** quà lưu xong mới gọi `megaphone.AnnounceGift`, chạy transaction riêng rồi đưa vào lịch Redis. `gift_transaction_id` unique nên không tạo trùng; gửi lại quà chỉ đọc lại trạng thái loa. **Không gộp vào transaction của quà:** quà khoá dòng user trước, loa khoá hàng phát trước, gộp lại có thể deadlock làm hỏng lần tặng. Máy chết đúng giữa hai bước thì mất loa quà, quà vẫn còn; chấp nhận được vì loa quà miễn phí.

**Nguyên tắc:** không phát được loa thì **quà vẫn phải tặng thành công**. Điều kiện nào không đạt chỉ trả `announced: false`. Khoá hàng đợi chỉ lấy khi quà đủ điều kiện 1 đến 3, để quà thường không phải chờ khoá.

Quà tặng ở chat 1-1 vẫn được phát loa nếu đủ các điều kiện trên.

### 4.4c Realtime

- `internal/constants/kafka.go`: `KafkaTopicMegaphonePlay = "CHAT.MEGAPHONE.PLAY"` thay cho `CHAT.MEGAPHONE.CREATED`; giữ `KafkaTopicMegaphoneRemoved = "CHAT.MEGAPHONE.REMOVED"`.
- `internal/constants/websocket.go`: `WebSocketEventMegaphonePlay = "MEGAPHONE_PLAY"` thay cho `MEGAPHONE_NEW`; giữ `WebSocketEventMegaphoneRemoved = "MEGAPHONE_REMOVED"`.
- `internal/domain/megaphone/megaphone.handler.go` (chat service): tin đã quá `expiresAt`, hoặc lượt phát đã cũ hơn `displaySeconds` (Kafka trễ), thì bỏ qua để máy không nhận dồn cả loạt. Còn lại `BroadcastToAll(MEGAPHONE_PLAY, { megaphone })`.
- Xoá: bỏ khỏi lịch Redis, `BroadcastToAll(MEGAPHONE_REMOVED, { id })`.

### 4.5 Báo cáo

- Thêm `ReportTargetMegaphone = "megaphone"` ([internal/constants/report.go](../server/internal/constants/report.go)) và `REPORT_TARGET_TYPE.megaphone` (shared). Dòng báo cáo lưu snapshot nội dung loa như các loại khác.
- Chỉ loa thường mới có Báo cáo, vì loa quà không có chữ do user viết.
- Admin xử lý báo cáo loa với lựa chọn "Gỡ nội dung" → gọi xoá loa (4.6) + điểm vi phạm theo luồng sẵn có.

### 4.6 Admin (`internal/modules/admin/megaphone`)

| Method | Path | Mô tả |
|---|---|---|
| GET | `/admin/megaphones?userId=&status=&type=&from=&to=` | Danh sách + tổng số loa, tổng KEN thu |
| POST | `/admin/megaphones/:id/remove` | Body `{ reason, penalty?: { reason, severity, note } }` (giống ẩn bài Me) → `status = removed`, bỏ khỏi lịch Redis, publish `CHAT.MEGAPHONE.REMOVED`, có `penalty` thì ghi vi phạm nguồn `megaphone_remove` (`ContentRemoved = true`). Gỡ lần 2 không làm gì. Không hoàn KEN |
| POST | `/admin/content-filter/check` | `{ text }` → `{ blocked, reason: link\|banned_word, word }` cho ô thử ở trang Từ cấm |
| GET/PUT | `/admin/settings/megaphone`, `/admin/settings/content_filter` | Qua endpoint setting sẵn có, thêm Validate cho 2 key mới |

### 4.7 Test

- Unit: chuẩn hoá nội dung, bắt link, so từ cấm (có dấu/không dấu/xen ký tự), chọn tin và cộng điểm lượt, tin nhẹ không bị bỏ đói, tính trần tải.
- API (`server/tests/api/tests/33-megaphones.test.js`): gửi thành công trừ đúng KEN; từ cấm/link/quá dài/thiếu KEN đều không trừ KEN; retry cùng `clientRequestId` chỉ trừ 1 lần (gửi song song); cooldown; daily limit không tính loa quà; hàng đầy; lịch sử 24 giờ bỏ loa đã xoá; admin xoá + điểm vi phạm; setting tắt.
- Loa quà: đủ 5 điều kiện mới có loa; thiếu từng điều kiện thì quà vẫn thành công và `announced: false`; người nhận vẫn nhận thông báo như cũ khi người tặng tắt loa; retry không tạo loa trùng.
- Bộ lập lịch: 2 instance không phát trùng; mất Redis dựng lại từ Postgres; tin hết hạn ngừng phát; admin gỡ thì ngừng ngay.

## 5. Shared (`@ola/shared`)

Client chỉ hiển thị, không xếp lịch. Bỏ `MegaphoneService.active`, `syncActive`, `clockOffset`, `currentMegaphone`, `pendingMegaphones`, `useCurrentMegaphone`.

**Khi nhận `MEGAPHONE_PLAY`, client kiểm tra lần lượt:**

1. Id đã có trong danh sách đã xem hoặc đã bị gỡ → bỏ qua. **Server có phát lại bao nhiêu lần thì máy này cũng không hiện nữa.**
2. Người gửi nằm trong `roomFilterStore.blockedUserIds` → bỏ qua.
3. Đang ở màn ẩn hoặc app ở nền → bỏ qua, **chưa tính đã xem**, chờ lượt lặp sau. Bước này ở từng nền tảng (mục 6, 7).
4. Còn lại thì hiện.

**Tính đã xem** khi chữ chạy hết một lượt, hoặc bấm vào loa, hoặc bấm X. Đang chạy mà bị che thì dừng, chưa tính đã xem. Nhận `MEGAPHONE_REMOVED` trùng tin đang chạy thì tắt ngay.

- `stores/megaphone/megaphoneStore.ts`: tin đang hiện `current`, `seenIds` dạng `{ id: expiresAt }`, `play`, `stop` (dừng, chưa tính đã xem), `markSeen`, `remove`. `seenIds` lưu trên máy qua `sharedPersistStorage` như `announcementStore`, tự xoá id đã hết hạn. **Đăng xuất không xoá**, vì tính theo thiết bị.
- `stores/megaphone/megaphoneRealtime.ts`: nghe `MEGAPHONE_PLAY` / `MEGAPHONE_REMOVED`. Không đồng bộ khi nối lại.
- `MegaphoneService`: config, history, send.
- Hằng số `constants/megaphone.ts`: socket events, mã lỗi → key i18n, page size.
- `lib/megaphone.ts` (hàm thuần): đếm ký tự như server, `megaphoneErrorText(t, error)`, ghép câu loa quà theo ngôn ngữ.
- Hook `useMegaphoneComposer` và `useMegaphoneHistory` giữ nguyên vai trò.
- `useGiftPicker`: thêm trạng thái ô thông báo, bật sẵn với quà `announceEnabled`, gửi `announce`, báo khi `announced = false`.
- i18n `megaphone.*` (vi + en), nhãn KEN `MEGAPHONE`, `report.target` cho loa.

## 6. Web

- `shared/components/megaphone/MegaphoneBar.tsx`: viên nổi theo mẫu `AnnouncementBanner`, chạy chữ bằng Web Animations trong `displaySeconds`, bấm vào mở màn Loa, có nút X. Bật giảm chuyển động thì hiện tĩnh, cắt bớt chữ. Loa thành viên dùng icon xanh `web/src/assets/images/member-megaphone.webp`, cũng là icon ở màn Loa, hộp gửi loa và menu Cá nhân. Loa vàng `announcement-megaphone.png` chỉ dành cho thông báo admin. Loa quà giữ icon loa, chữ chạy dạng `@người tặng tặng @người nhận Tên quà [ảnh quà] ×số lượng`. `@username` dùng màu `ola-megaphone-name` (cam nhạt), không dùng màu xanh của theme.
- Icon, chữ và nút X của viên nổi tách ở `MegaphoneText.tsx`, `useMegaphoneMarquee.ts`, `ui/PillCloseButton.tsx`.
- Mount một lần ở `HomePage`, `z-50`, phủ 6 tab và cả phòng chat. Không chiếm chỗ trong layout. Thông báo admin được ưu tiên: khi `AnnouncementBanner` đang chạy thì viên loa chờ, chưa tính đã xem, admin xong mới chạy từ đầu ở cùng vị trí.
- **Biết đang bị che:** các màn che có thuộc tính `data-megaphone-cover`. `isMegaphoneCovered` ([megaphoneCover.ts](../web/src/shared/components/megaphone/megaphoneCover.ts)) tìm phần tử đó và hỏi `checkVisibility`, kiểm tra lúc nhận tin và mỗi 500ms khi đang chạy; tab trình duyệt ẩn cũng tính là che. `FullScreenOverlay` tự gắn thuộc tính, `RoomChatView` tắt bằng `keepMegaphone`. `Dialog` và các màn tự dựng gắn tay: `EditProfileMePage`, `StoryReaderPage`, `MomentViewer`, `CallContent`, `MediaViewer`, `ArcadeOverlay`. Không dùng bộ đếm số màn đang mở, vì Truyện và Nối từ còn mounted khi đã chuyển tab. **Màn full màn hình mới không dùng `FullScreenOverlay` thì phải tự gắn thuộc tính.**
- `pages/megaphone/MegaphonePage.tsx` (overlay): danh sách 24 giờ chỉ gồm loa thường, không có loa quà (avatar → profile, menu Báo cáo), nút "Phát loa". Bỏ dải chữ trong màn.
- `MegaphoneComposeDialog` (`Dialog` chuẩn): ô nhập + đếm ký tự, giá, số dư, câu "Loa sẽ phát sau khoảng X phút" khi có tin đang chờ, nút Phát (luôn hỏi lại vì là trả tiền). Sửa câu gợi ý `megaphone.hint`, không còn nói chỉ tab Chat và Phòng chat.
- Hộp chọn quà: quà `announceEnabled` hiện ô "Thông báo cho mọi người" ngay ở màn chọn, không để ở bước xác nhận vì bước đó chỉ có với quà đắt.
- Điểm vào: mục Loa trong menu Cá nhân và bấm vào viên loa; cả hai mở màn Loa (overlay `megaphone` trong `AppOverlay`).

## 7. Mobile (React Native)

Port bằng skill `port-web-to-mobile`, logic giữ ở shared:

- Viên nổi theo `components/ui/AnnouncementBanner.tsx`, mount ở cấp root; chạy chữ bằng `react-native-reanimated`, định vị bằng số. Hai bẫy đã gặp khi làm hiệu ứng quà: `left: '50%'` trong khung co theo nội dung bị lệch, và padding đặt thẳng lên `LinearGradient` cắt mất nội dung (gradient phải là nền `absoluteFill`).
- Biết đang bị che: theo route hiện tại của navigator, chỉ cho hiện ở 6 tab và `RoomChatScreen`.
- `MegaphoneScreen` trên root stack (`ScreenHeader`), dialog soạn dùng `Dialog` + `showToasts`, ô nhập trong `KeyboardView`, `TextInput` set màu chữ bằng inline style.
- Icon loa phải là PNG (Metro không nhận `.svg`), đặt trong file asset riêng `megaphoneAssets.ts`.
- Hộp chọn quà mobile thêm ô thông báo ngay từ đợt đầu, kể cả khi chưa port màn Loa, vì mobile đã tặng được quà.

## 8. Admin web

- Menu "Loa": **Danh sách loa** (lọc người gửi/ngày/trạng thái/loại, tổng KEN thu, nút Xoá kèm lý do + điểm vi phạm), **Cài đặt loa** (form setting `megaphone`: thời gian sống, thời gian chạy, nghỉ giữa lượt, nhịp lặp, trọng số, mốc quà; bỏ ô hàng chờ tối đa; hiện các số tự tính để admin xem).
- Form sửa quà (`GiftFormModal`): thêm công tắc **Cho phép thông báo loa**, mặc định tắt.
- Menu "Kiểm duyệt" → **Từ cấm**: ô nhập mỗi dòng một từ, nút Lưu, có ô thử một câu xem có bị chặn không.
- Trang báo cáo: hiện nội dung loa với loại `megaphone`, nút "Gỡ nội dung" gọi xoá loa.

## 9. Tài nguyên cần chuẩn bị

- Icon loa: bản màu cho viên nổi, màn Loa, dòng lịch sử KEN. Web dùng PNG/SVG, mobile cần PNG @2x/@3x.
- Danh sách từ cấm ban đầu (tục tĩu, lừa đảo kiểu "nạp KEN giá rẻ", "liên hệ zalo"...).
- Giá và các con số trong setting (mục 3) theo kinh tế KEN hiện tại.

## 10. Thứ tự làm

1. Docs (file này) → chốt các câu ở mục 12.
2. **Server**: migration mới, cột quà, setting, bộ lập lịch + Redis, trần tải, loa quà, handler chat service, admin API, unit + API test.
3. **Shared**: bỏ logic xếp lịch ở client, store hiển thị, `seenIds`, realtime, `useGiftPicker`, i18n.
4. **Admin**: cài đặt mới, công tắc ở form quà, lọc loại.
5. **Web**: viên nổi, tín hiệu đang bị che, màn Loa, ô thông báo ở hộp chọn quà; kiểm bằng CDP với 2 tài khoản (một gửi, một xem).
6. **Mobile**: ô thông báo ở hộp chọn quà trước, port Loa như mục 7 sau, chạy iOS simulator.
7. **Deploy**: chạy migration → deploy server (**cả API và chat service**, vì handler Kafka nằm ở chat) → admin bật thông báo cho từng quà, chỉnh setting (môi trường đã lưu giá cũ thì phải đặt lại 5.000 KEN ở admin, vì giá đã lưu được ưu tiên hơn mặc định) → phát hành web/app. Client cũ nghe `MEGAPHONE_NEW` nên sẽ không thấy loa cho tới khi cập nhật, không lỗi gì. Có loa đang chờ lúc deploy thì đã hết hạn theo backfill, không phát lại.

## 11. Rủi ro và lưu ý

- **Spam, lừa đảo**: giá + cooldown + giới hạn ngày + chặn link + từ cấm + báo cáo + admin xoá + điểm vi phạm. Từ cấm né được bằng cách viết lách, chỉ là lớp đầu; lớp chính vẫn là báo cáo và admin.
- **App Store (guideline 1.2, nội dung do user tạo)**: Apple yêu cầu có lọc nội dung, báo cáo, chặn người dùng. Loa có đủ cả ba (từ cấm, báo cáo, ẩn loa của người đã chặn). Nên nêu trong ghi chú gửi review vì app từng bị reject.
- **Che nội dung**: viên nổi đè lên dòng đầu danh sách, giống thông báo admin. Nút X chỉ tắt tin đang chạy, tin khác vẫn hiện tiếp.
- **Ra khỏi màn ẩn không hiện ngay**: phải chờ lượt lặp kế tiếp, khoảng vài phút khi vắng, lâu hơn khi đông. Đây là đánh đổi có chủ đích để client không phải giữ hàng chờ.
- **Có thể không kịp thấy**: máy mở app muộn hoặc ở màn ẩn lâu có thể lỡ tin hết hạn. Loa thường còn xem lại được ở màn Loa; loa quà lỡ là mất vì không nằm trong lịch sử, và quà nhỏ ít lượt nên dễ bị lỡ hơn.
- **Lúc đông chờ lâu**: tối đa khoảng 10 phút với loa thường, hộp soạn báo trước khi trừ KEN.
- **Redis mất dữ liệu**: Redis từng bị hỏng AOF. Lịch phát dựng lại được từ Postgres, tiền và lịch sử không nằm ở Redis.
- **Nhiều instance API**: khoá Redis chỉ cho một máy phát mỗi lượt. Khoá phải có TTL ngắn để máy chết không kẹt lịch.
- **Chat service nhiều instance**: Kafka consumer group bảo đảm chỉ một instance nhận event, Redis adapter phát ra mọi instance → mỗi máy nhận đúng một lần.
- **Cùng máy, đổi tài khoản**: đã xem tính theo thiết bị nên tài khoản khác trên máy đó cũng không thấy tin đã xem.
- **Quyền riêng tư người nhận**: chỉ phát khi tường quà công khai, vì người nhận không được hỏi trước khi loa phát.

## 12. Đã chốt

Giữ từ 04/11/2026:

- Mọi user được phát loa thường, trả KEN mỗi lần.
- Chặn từ cấm và link trước khi trừ KEN; báo cáo + admin xoá + điểm vi phạm.
- Có màn xem lại loa 24 giờ; không gửi push.
- Mặc định 80 ký tự, chờ 60 giây giữa 2 lần, 20 loa/ngày.
- Không cho người gửi tự huỷ loa đang chờ.
- Có huy hiệu VIP cạnh tên.

Chốt 06/11/2026:

- Hiển thị như thông báo admin, ở 6 tab và trong phòng chat, ẩn ở mọi màn full màn hình kể cả màn Quà tặng.
- Server điều khiển hết, chung một thông báo cho tất cả, bỏ `GET /megaphones/active`.
- Mỗi tin sống 30 phút, server phát lặp theo trọng số.
- Chạy xong hoặc bấm X thì máy đó không hiện lại, dù server còn phát.
- Trần tải tự tính, không nhập tay.
- Loa quà chung bảng, chung đường phát, miễn phí, chỉ có câu thông báo quà.
- Loa quà không hiện trong lịch sử màn Loa, chỉ admin xem được ở Danh sách loa.
- Admin bật thông báo theo từng quà. Lúc tặng, ô thông báo bật sẵn, người tặng tắt được.
- Thông báo 1-1 cho người nhận giữ nguyên, không phụ thuộc loa quà.
- Tường quà người nhận không công khai thì không phát loa quà.
- Quà tặng trong chat 1-1 vẫn phát loa nếu quà được phép và người tặng bật.
- Giá loa thường mặc định 5.000 KEN, admin sửa được ở Cài đặt loa.
- Mốc trọng số quà: dưới 1.000 KEN là quà nhỏ, 1.000 đến 19.999 KEN là quà vừa, từ 20.000 KEN là quà lớn.

## 13. Đã làm bản đầu (04/11/2026)

- Server: migration, module `megaphone` + `content-filter`, handler Kafka ở chat service, báo cáo loại `megaphone`, admin API, swagger. Test: unit (`content-filter`, setting) + `server/tests/api/tests/33-megaphones.test.js` (69 case, pass local).
- Shared: types, `MegaphoneService`, `stores/megaphone/` (`megaphoneStore`, `megaphoneRealtime`, `useCurrentMegaphone`, `useMegaphoneComposer`, `useMegaphoneHistory`), i18n vi/en.
- Admin: menu **Loa** (Danh sách loa + gỡ kèm mức xử lý, Từ cấm + ô thử, Cài đặt), trang Báo cáo có nút "Gỡ loa".
- Web: `MegaphoneBar` ở tab Chat, tab Phòng chat, trong phòng chat; màn Loa; dialog soạn + xác nhận; kiểm bằng CDP (gửi, xếp hàng, lỗi link, menu báo cáo).
- Lối vào Loa đã chuyển sang menu Cá nhân, dưới Quà tặng (`28bf3ee29`).

## 14. Đã làm thiết kế mới (06/11/2026)

- Server: migration `20261106000001_add_megaphone_schedule`, `megaphone.scheduler.go`, `megaphone.schedule.go`, trần tải, loa quà, event `MEGAPHONE_PLAY`, bỏ `/megaphones/active`, admin lọc loại và cột quà. Test: unit + `33-megaphones.test.js` pass 2 lần liên tiếp với API, chat service, Kafka, Redis thật.
- Shared, web, admin: như các mục trên. Kiểm bằng CDP với 2 tài khoản.
- Còn lại: port Loa sang mobile (mục 7), deploy (mục 10.7).
- `32-gifts.test.js` có 3 lỗi có sẵn, bản trước khi sửa cũng lỗi y hệt: `gift message metadata`, `gift message has text fallback`, và `TypeError` ở dòng 216.

**Sửa sau review (06/11/2026):**

- **Chặn trước khi trừ KEN:** thời gian chờ thực tế gồm lượt đang chạy cộng hàng chờ. Nếu loa sẽ hết hạn trước lượt của nó thì server trả `MEGAPHONE_QUEUE_FULL`. Admin không lưu được cấu hình có thời gian chạy cộng nghỉ dài bằng hoặc hơn thời gian sống.
- **Migration:** loa cũ chưa tới giờ phát được giữ là chưa phát và có hạn 30 phút tính từ lúc nâng cấp. `expires_at` có giá trị mặc định để API cũ vẫn gửi được loa trong lúc chờ API mới lên.
- **Không hoàn KEN:** user đã chốt không hoàn tiền. Loa đã trả tiền mà hết hạn chưa phát, ví dụ do admin tắt Loa lâu hơn thời gian sống, thì mất KEN.
- **Chưa làm:** chạy nhiều bản API cần gia hạn khoá `MEGAPHONE:LOCK`. Hiện prod chạy một bản nên chưa cần.
