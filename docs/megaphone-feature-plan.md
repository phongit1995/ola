# Plan: Loa (phát loa tới mọi người)

Ngày lập: 04/11/2026 · Trạng thái: server, admin, web xong (04/11/2026, chưa commit); mobile chưa làm

User trả KEN để phát một câu ngắn. Mọi người đang mở app thấy câu đó chạy thành dải chữ ở tab Chat và tab Phòng chat; ai mở app sau thì xem lại được trong màn "Loa" (24 giờ gần nhất).

## 1. Phạm vi bản đầu

| Hạng mục | Chốt |
|---|---|
| Ai gửi | **Mọi user**, trả KEN mỗi lần, **trừ hẳn** (hệ thống thu về). Giá admin chỉnh |
| Nội dung | Chữ thường + emoji unicode, tối đa 80 ký tự (setting). **Không** link, không ảnh/sticker/smiley của app |
| Nơi hiện | Tab **Chat** (danh sách tin nhắn), tab **Phòng chat** (danh sách phòng) và **trong phòng chat**. Không hiện ở chat 1-1, game, Truyện, Me, khoảnh khắc |
| Cách hiện | Dải chữ chạy ngay dưới header: icon loa + avatar + tên + nội dung, mỗi loa hiện 10 giây (setting). Nhiều loa thì xếp hàng theo thứ tự server cấp, mọi máy thấy cùng thứ tự |
| Xem lại | Màn **"Loa"** liệt kê loa 24 giờ gần nhất. **Không push** |
| Kiểm duyệt | **Phát ngay**. Từ cấm và link bị chặn **trước khi trừ KEN**. User báo cáo được; admin xoá thì loa biến mất trên mọi máy, có thể cộng điểm vi phạm, không hoàn KEN |
| Người mình đã chặn | Ẩn loa của họ ở máy mình |

Ngoài phạm vi (để sau): loa trong game, loa có ảnh/sticker, loa "nổi bật" trả thêm, ghim loa, trả lời/thả tim loa, push, người gửi tự huỷ loa đang chờ.

## 2. Cái đã có, dùng lại

- **Phát tới mọi người đang online**: `wsServer.BroadcastToAll` ([server.go](../server/internal/transport/websocket/server.go)) phát vào room `broadcast:online`, chạy qua Redis adapter nên đúng cả khi có nhiều instance. Mẫu đầy đủ là **rương KEN**: [kenchest.service.go](../server/internal/modules/kenchest/kenchest.service.go) publish Kafka → [domain/kenchest/kenchest.handler.go](../server/internal/domain/kenchest/kenchest.handler.go) ở chat service gọi `BroadcastToAll`.
- **Trừ KEN trong transaction + chống trừ 2 lần**: y như `Send` của tặng quà ([gift.service.go](../server/internal/modules/gift/gift.service.go)): `clientRequestId` unique theo người gửi, khoá dòng user, ghi `ken_transactions`, sau commit `wsServer.EmitKenUpdate`.
- **Cài đặt**: `app_settings` KV + Validate + form admin (mẫu `setting.gift.go`, trang `GiftSettingsPage`).
- **Báo cáo + điểm vi phạm**: module `report` + `REPORT_TARGET_TYPE` (shared) + cảnh báo Discord/Telegram sẵn có; admin xử lý thì gọi `moderation.RecordPenalty` / `ApplyPenalty` như [admin/report/report.service.go](../server/internal/modules/admin/report/report.service.go) và [admin/me/me.service.go](../server/internal/modules/admin/me/me.service.go).
- **Realtime phía client**: mẫu [stores/ken/kenRealtime.ts](../packages/shared/src/stores/ken/kenRealtime.ts) (`claimRealtimeRegistration`, `SocketService.on`, đồng bộ lại khi `onReconnect`).
- **Danh sách người mình chặn**: `roomFilterStore.blockedUserIds` ([roomFilterStore.ts](../packages/shared/src/stores/room/roomFilterStore.ts)).
- **Rate limit**: policy trong [rate_limit.policy.go](../server/internal/middleware/rate_limit.policy.go).
- **Chưa có**: bộ lọc từ cấm. Đã làm ở module riêng `internal/modules/content-filter` (dùng chung được cho phòng chat sau này).

## 3. Dữ liệu (PostgreSQL)

Bảng loa nằm chung migration với quà, khoá tài khoản theo điểm vi phạm và ràng buộc KEN game theo ghế: `20261105000001_add_moderation_gifts_megaphones` (gộp 05/11 khi chưa chạy ở prod; dev phải chạy file down của migration gộp + đặt `schema_migrations` về `20261030000002` trước khi deploy). Không sửa migration đã chạy. Migration này mở rộng CHECK cũ `reports.target_type` thêm `megaphone`; bảng `user_violations` tạo trong cùng file nên `source` có sẵn `megaphone_remove`.

```sql
CREATE TABLE megaphones (
  id                uuid PRIMARY KEY,
  sender_id         uuid NOT NULL REFERENCES users(id),
  content           varchar(200) NOT NULL,
  ken_price         int  NOT NULL CHECK (ken_price >= 0),
  show_at           timestamptz NOT NULL,
  display_seconds   int  NOT NULL CHECK (display_seconds > 0),
  status            varchar(20) NOT NULL DEFAULT 'active',
  removed_by        uuid,
  removed_reason    varchar(200) NOT NULL DEFAULT '',
  removed_at        timestamptz,
  client_request_id varchar(64) NOT NULL,
  created_at        timestamptz NOT NULL DEFAULT now(),
  UNIQUE (sender_id, client_request_id)
);
CREATE INDEX idx_megaphones_show_at ON megaphones (show_at DESC);
CREATE INDEX idx_megaphones_sender  ON megaphones (sender_id, created_at DESC);
```

- `status`: `active` | `removed`. Không xoá dòng: admin cần tra lại khi có khiếu nại.
- `ken_price` snapshot giá lúc gửi.
- `show_at` là giờ bắt đầu phát do server cấp (mục 4.3).
- KEN: thêm `KenTxTypeMegaphone = "MEGAPHONE"` ([ken_transaction.model.go](../server/internal/models/ken_transaction.model.go)), cho vào `visibleKenTxTypes`, nhãn 📢 "Phát loa" trong `KEN_TX_META` (shared).
- Setting `megaphone` (app_settings):

| Field | Mặc định | Ý nghĩa |
|---|---|---|
| `enabled` | `true` | Công tắc tổng |
| `kenPrice` | `2000` | Giá một lần phát |
| `maxLength` | `80` | Số ký tự tối đa |
| `displaySeconds` | `10` | Thời gian hiện mỗi loa |
| `cooldownSeconds` | `60` | Mỗi người phải chờ giữa 2 lần phát |
| `dailyLimit` | `20` | Số loa tối đa mỗi người mỗi ngày (giờ VN) |
| `maxQueueSeconds` | `300` | Hàng chờ dài quá thì từ chối, không trừ KEN |

- Setting `content_filter` riêng: `{ bannedWords: string[] }` (tối đa 5.000 từ, mỗi từ 60 ký tự). Tách khỏi `megaphone` để dùng lại cho phòng chat, bài Me sau này. Không cần cache riêng: `app_settings` đã cache cả bảng trong Redis và xoá khi admin lưu.

## 4. Server (Go) — module `internal/modules/megaphone`

Khuôn module: `megaphone.router.go`, `.controller.go`, `.service.go`, `.repository.go`, `.dto.go`, `.constants.go`, `.errors.go`, `.dig.go`; đăng ký ở `cmd/api/container.go`. Handler Kafka đặt ở `internal/domain/megaphone/` và đăng ký trong chat service.

### 4.1 API người dùng (`RequireAuth`)

| Method | Path | Mô tả |
|---|---|---|
| GET | `/megaphones/config` | `{ enabled, kenPrice, maxLength, displaySeconds, cooldownSeconds, dailyLimit, todayCount, cooldownRemaining, queueWaitSeconds }` cho màn soạn |
| GET | `/megaphones/active` | Loa đang chờ + đang phát (`show_at + display_seconds > now`), kèm `serverTime`. Gọi khi mở app và khi socket nối lại |
| GET | `/megaphones?cursor=` | Lịch sử 24 giờ, chỉ loa đã tới giờ phát (`show_at <= now`), mới nhất trước, keyset theo `(show_at, id)`, bỏ loa `removed` |
| POST | `/megaphones` | Phát loa (4.2), trả 201. Rate limit `PolicyMegaphoneSend` 6 lần/phút (đếm cả lượt bị từ chối) |

Request: `{ "content": "...", "clientRequestId": "uuid" }` → Response: `{ megaphone, kenBalance, waitSeconds }`.

`megaphone` (dùng chung cho API và socket): `{ id, sender: { id, username, fullName, avatar, vipUsed, vipEndTime }, content, showAt, displaySeconds, createdAt }`.

### 4.2 Luồng `Send`

1. Setting tắt → `MEGAPHONE_DISABLED`.
2. Chuẩn hoá nội dung: cắt khoảng trắng hai đầu, gộp khoảng trắng và xuống dòng thành một dấu cách; rỗng → `MEGAPHONE_CONTENT_EMPTY`, quá `maxLength` ký tự (đếm rune) → `MEGAPHONE_CONTENT_TOO_LONG`.
3. Có link (`http`, `www.`, dạng `abc.com` / `abc.vn`...) → `MEGAPHONE_LINK_NOT_ALLOWED`. Đuôi dễ trùng chữ thường (`.me`, `.co`, `.ly`, `.gg`, `.tv`...) chỉ bị chặn khi có `/` phía sau (`zalo.me/…`, `bit.ly/…`) để "ok.co", "chao.me" không bị chặn nhầm.
4. Dính từ cấm → `MEGAPHONE_CONTENT_BLOCKED`. So khớp theo từ sau khi chuẩn hoá (chữ thường, bỏ dấu, dấu câu thành khoảng trắng): một từ chỉ khớp khi đứng riêng nên "dit" không chặn nhầm "đi tắm"; chuỗi chữ cái đơn liền nhau được ghép lại để bắt "đ.ị.t", "d i t"; cụm nhiều từ còn khớp khi viết liền thành một từ ("napkengiare"); 2–3 mẩu ngắn (≤3 ký tự) liền nhau được ghép thử để bắt kiểu tách "za lo", "đị.t". Danh sách từ đã chuẩn hoá được nhớ trong process, chỉ tính lại khi admin đổi danh sách.
5. Trùng `clientRequestId` → trả lại kết quả cũ ngay, kể cả khi admin vừa tắt loa hay thêm từ cấm (khác nội dung → `MEGAPHONE_REQUEST_CONFLICT`). Bước này chạy trước cả bước 1.
6. **Một transaction DB**, mọi lượt phát xếp hàng qua cùng một `pg_advisory_xact_lock` nên các bước kiểm dưới đây không bị chạy song song vượt giới hạn:
   - Đã có `(sender_id, client_request_id)` → trả kết quả cũ, không trừ lần nữa (bắt được cả 2 request trùng gửi cùng lúc).
   - Đủ `dailyLimit` trong ngày giờ VN (`utils.VietnamPeriodStart`) → `MEGAPHONE_DAILY_LIMIT`.
   - Loa gần nhất của người này chưa quá `cooldownSeconds` → `MEGAPHONE_COOLDOWN` (tính từ `created_at`, không dùng Redis; số giây còn lại trả ở `/megaphones/config`).
   - Tính `show_at` (4.3); chờ quá `maxQueueSeconds` → `MEGAPHONE_QUEUE_FULL`.
   - `SELECT ... FOR UPDATE` dòng người gửi, thiếu KEN → `MEGAPHONE_INSUFFICIENT_KEN`.
   - Trừ `users.ken`, ghi `ken_transactions` type `MEGAPHONE`, `ref_type = 'megaphone'`, `ref_id`.
   - Insert `megaphones`.
7. Sau commit: `wsServer.EmitKenUpdate`, publish Kafka `CHAT.MEGAPHONE.CREATED`. Publish lỗi thì chỉ log: loa vẫn nằm trong `/megaphones/active` và lịch sử, máy nào nối lại sẽ đồng bộ.

Mọi lỗi đều trả về **trước** khi trừ KEN.

### 4.3 Hàng chờ

- Trong transaction, sau advisory lock: `slot = max(now, MAX(show_at + display_seconds) của loa active còn hiệu lực)`, `wait = slot - now`.
- Dùng DB thay cho Redis để cấp slot và trừ KEN nằm chung một transaction; lượng loa thấp nên khoá ngắn không thành vấn đề.
- Admin xoá một loa đang chờ thì **không** dồn hàng: khe đó trống, client bỏ qua, tránh tính lại giờ cho mọi máy.

### 4.4 Realtime

- `internal/constants/kafka.go`: `KafkaTopicMegaphoneCreated = "CHAT.MEGAPHONE.CREATED"`, `KafkaTopicMegaphoneRemoved = "CHAT.MEGAPHONE.REMOVED"`, thêm vào `AllKafkaTopics()`.
- `internal/constants/websocket.go`: `WebSocketEventMegaphoneNew = "MEGAPHONE_NEW"`, `WebSocketEventMegaphoneRemoved = "MEGAPHONE_REMOVED"`.
- `internal/domain/megaphone/megaphone.handler.go` (chat service): loa đã quá giờ phát thì bỏ qua như rương KEN; còn lại `BroadcastToAll(MEGAPHONE_NEW, { ...megaphone, serverTime })`.
- Xoá: `BroadcastToAll(MEGAPHONE_REMOVED, { id })`.

### 4.5 Báo cáo

- Thêm `ReportTargetMegaphone = "megaphone"` ([internal/constants/report.go](../server/internal/constants/report.go)) và `REPORT_TARGET_TYPE.megaphone` (shared). Dòng báo cáo lưu snapshot nội dung loa như các loại khác.
- Admin xử lý báo cáo loa với lựa chọn "Gỡ nội dung" → gọi xoá loa (4.6) + điểm vi phạm theo luồng sẵn có.

### 4.6 Admin (`internal/modules/admin/megaphone`)

| Method | Path | Mô tả |
|---|---|---|
| GET | `/admin/megaphones?userId=&status=&from=&to=` | Danh sách + tổng số loa, tổng KEN thu |
| POST | `/admin/megaphones/:id/remove` | Body `{ reason, penalty?: { reason, severity, note } }` (giống ẩn bài Me) → `status = removed`, publish `CHAT.MEGAPHONE.REMOVED`, có `penalty` thì ghi vi phạm nguồn `megaphone_remove` (`ContentRemoved = true`). Gỡ lần 2 không làm gì. Không hoàn KEN |
| POST | `/admin/content-filter/check` | `{ text }` → `{ blocked, reason: link\|banned_word, word }` cho ô thử ở trang Từ cấm |
| GET/PUT | `/admin/settings/megaphone`, `/admin/settings/content_filter` | Qua endpoint setting sẵn có, thêm Validate cho 2 key mới |

### 4.7 Test

- Unit: chuẩn hoá nội dung, bắt link, so từ cấm (có dấu/không dấu/xen ký tự), tính slot.
- API (`server/tests/api/tests/33-megaphones.test.js`): gửi thành công trừ đúng KEN; từ cấm/link/quá dài/thiếu KEN đều không trừ KEN; retry cùng `clientRequestId` chỉ trừ 1 lần (gửi song song); cooldown; daily limit; hàng chờ đầy; lịch sử 24 giờ bỏ loa đã xoá; admin xoá + điểm vi phạm; setting tắt.

## 5. Shared (`@ola/shared`)

- Types `types/api/megaphone.type.ts`; `API_PATH.megaphones`; `MegaphoneService` (config, active, history, send).
- Hằng số `constants/megaphone.ts`: socket events, mã lỗi → key i18n, page size.
- `lib/megaphone.ts` (hàm thuần): đếm ký tự như server, `megaphoneErrorText(t, error)`, `currentMegaphone(items, nowServer)` trả loa đang phát + số ms tới lần đổi kế tiếp.
- `stores/megaphone/megaphoneStore.ts`: danh sách loa sắp xếp theo `showAt`, độ lệch giờ `serverTime - Date.now()`, `receive`, `remove`, `syncActive`, bỏ loa đã hết giờ.
- `stores/megaphone/megaphoneRealtime.ts`: nghe `MEGAPHONE_NEW` / `MEGAPHONE_REMOVED`, `onReconnect` → `syncActive`.
- Hook `useMegaphoneComposer` (theo mẫu `useGiftPicker`: nội dung, số ký tự còn lại, giá, số dư, `clientRequestId`, gửi, toast lỗi) và `useMegaphoneHistory` (phân trang).
- Lọc loa của người trong `roomFilterStore.blockedUserIds` ngay trong selector.
- i18n `megaphone.*` (vi + en), nhãn KEN `MEGAPHONE`, `report.target` cho loa.

## 6. Web

- `shared/components/megaphone/MegaphoneBar.tsx`: dải chữ chạy (CSS keyframes `translateX`, chữ ngắn thì đứng yên), bấm vào mở màn Loa. Bật giảm chuyển động thì hiện tĩnh, cắt bớt chữ.
- Mount: đầu danh sách tin nhắn (tab Chat), đầu `RoomPanel` (tab Phòng chat), dưới header `RoomChatView`. Dải chỉ chiếm chỗ khi đang có loa phát.
- `pages/megaphone/MegaphonePage.tsx` (overlay): danh sách 24 giờ (avatar → profile, menu Báo cáo), nút "Phát loa".
- `MegaphoneComposeDialog` (`Dialog` chuẩn): ô nhập + đếm ký tự, giá, số dư, câu "Loa sẽ phát sau khoảng X phút" khi có hàng chờ, nút Phát (luôn hỏi lại vì là trả tiền).
- Điểm vào: nút loa trên header tab Chat và tab Phòng chat, và bấm vào dải chữ; cả hai mở màn Loa (overlay `megaphone` trong `AppOverlay`), nút "Phát loa" nằm trong màn đó. Dải chữ giữ cố định avatar + tên, chỉ phần nội dung chạy.

## 7. Mobile (React Native)

Port bằng skill `port-web-to-mobile`, logic giữ ở shared:

- `MegaphoneBar` chạy chữ bằng `react-native-reanimated`: đo bề ngang chữ rồi `translateX`, định vị bằng số. Hai bẫy đã gặp khi làm hiệu ứng quà: `left: '50%'` trong khung co theo nội dung bị lệch, và padding đặt thẳng lên `LinearGradient` cắt mất nội dung (gradient phải là nền `absoluteFill`).
- Mount ở `ChatListScreen`, `RoomListScreen`, `RoomChatScreen` (header custom → đặt ngay dưới header).
- `MegaphoneScreen` trên root stack (`ScreenHeader`), dialog soạn dùng `Dialog` + `showToasts`, ô nhập trong `KeyboardView`, `TextInput` set màu chữ bằng inline style.
- Icon loa phải là PNG (Metro không nhận `.svg`), đặt trong file asset riêng `megaphoneAssets.ts`.

## 8. Admin web

- Menu "Loa": **Danh sách loa** (lọc người gửi/ngày/trạng thái, tổng KEN thu, nút Xoá kèm lý do + điểm vi phạm), **Cài đặt loa** (form setting `megaphone`).
- Menu "Kiểm duyệt" → **Từ cấm**: ô nhập mỗi dòng một từ, nút Lưu, có ô thử một câu xem có bị chặn không.
- Trang báo cáo: hiện nội dung loa với loại `megaphone`, nút "Gỡ nội dung" gọi xoá loa.

## 9. Tài nguyên cần chuẩn bị

- Icon loa: một bản cho nút header (đơn sắc, dùng được trên nền xanh) và một bản màu cho dải chữ, màn Loa, dòng lịch sử KEN. Web dùng PNG/SVG, mobile cần PNG @2x/@3x.
- Danh sách từ cấm ban đầu (tục tĩu, lừa đảo kiểu "nạp KEN giá rẻ", "liên hệ zalo"...).
- Giá và các con số trong setting (mục 3) theo kinh tế KEN hiện tại.

## 10. Thứ tự làm

1. Docs (file này) → chốt các câu ở mục 12.
2. **Server**: migration, module `megaphone`, bộ lọc nội dung, Kafka + handler chat service, báo cáo, admin API, unit + API test.
3. **Shared**: types, service, store, realtime, hooks, i18n.
4. **Admin**: danh sách, cài đặt, từ cấm, báo cáo.
5. **Web**: dải chữ, màn Loa, dialog soạn; kiểm bằng CDP với 2 tài khoản (một gửi, một xem).
6. **Mobile**: port như mục 7, chạy iOS simulator.
7. **Deploy**: chạy migration → deploy server (**cả API và chat service**, vì handler Kafka nằm ở chat) → admin nhập từ cấm + chỉnh giá → phát hành web/app. Bản app cũ không nghe `MEGAPHONE_NEW` nên chỉ không thấy loa, không lỗi gì.

## 11. Rủi ro và lưu ý

- **Spam, lừa đảo**: giá + cooldown + giới hạn ngày + chặn link + từ cấm + báo cáo + admin xoá + điểm vi phạm. Từ cấm né được bằng cách viết lách, chỉ là lớp đầu; lớp chính vẫn là báo cáo và admin.
- **App Store (guideline 1.2, nội dung do user tạo)**: Apple yêu cầu có lọc nội dung, báo cáo, chặn người dùng. Loa có đủ cả ba (từ cấm, báo cáo, ẩn loa của người đã chặn). Nên nêu trong ghi chú gửi review vì app từng bị reject.
- **Hàng chờ dài**: giới hạn `maxQueueSeconds`, báo trước thời gian chờ trong dialog, hết chỗ thì từ chối và không trừ KEN.
- **Lệch giờ máy**: client không dùng giờ máy để tính lịch phát mà dùng `serverTime` gửi kèm event/API.
- **Chat service nhiều instance**: Kafka consumer group bảo đảm chỉ một instance nhận event, Redis adapter phát ra mọi instance → mỗi máy nhận đúng một lần.
- **Tab ẩn / app ở nền**: khi quay lại chỉ hiện loa đang trong khung giờ của nó, không phát bù loa đã qua (đã có trong màn Loa).

## 12. Đã chốt (04/11/2026)

- Mọi user được phát loa, trả KEN mỗi lần.
- Loa chỉ hiện ở tab Chat, tab Phòng chat và trong phòng chat.
- Phát ngay; chặn từ cấm và link trước khi trừ KEN; báo cáo + admin xoá + điểm vi phạm.
- Có màn xem lại loa 24 giờ; không gửi push.

Chốt khi bắt đầu làm (theo đề xuất của plan, admin chỉnh được):

- Mặc định: 2.000 KEN, 80 ký tự, hiện 10 giây, chờ 60 giây giữa 2 lần, 20 loa/ngày, hàng chờ tối đa 300 giây.
- Bản đầu **không** cho người gửi tự huỷ loa đang chờ.
- Có hiện huy hiệu VIP cạnh tên (dải chữ và màn Loa).

## 13. Đã làm (04/11/2026)

- Server: migration, module `megaphone` + `content-filter`, handler Kafka ở chat service, báo cáo loại `megaphone`, admin API, swagger. Test: unit (`content-filter`, setting) + `server/tests/api/tests/33-megaphones.test.js` (69 case, pass local).
- Shared: types, `MegaphoneService`, `stores/megaphone/` (`megaphoneStore`, `megaphoneRealtime`, `useCurrentMegaphone`, `useMegaphoneComposer`, `useMegaphoneHistory`), i18n vi/en.
- Admin: menu **Loa** (Danh sách loa + gỡ kèm mức xử lý, Từ cấm + ô thử, Cài đặt), trang Báo cáo có nút "Gỡ loa".
- Web: `MegaphoneBar` ở tab Chat, tab Phòng chat, trong phòng chat; màn Loa; dialog soạn + xác nhận; kiểm bằng CDP (gửi, xếp hàng, lỗi link, menu báo cáo).
- Còn lại: mobile (mục 7), deploy (mục 10.7).
