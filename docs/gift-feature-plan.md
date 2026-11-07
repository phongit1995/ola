# Plan: Tặng quà

Ngày lập: 04/11/2026 · Trạng thái: server + admin + web + mobile xong (04/11/2026), chưa deploy

## 1. Phạm vi bản đầu

| Hạng mục | Chốt |
|---|---|
| Nơi tặng | **Chat 1-1** (panel "Thêm" của khung chat, cạnh Chuyển KEN / Tặng ngày VIP) và **trang cá nhân** người khác (nút "Tặng quà") |
| Người tặng trả | KEN, **trừ hẳn** (hệ thống thu về) |
| Người nhận được | **Sức hút** (cột `charm`) + **tường quà** trên profile. **Không nhận KEN** → không thành kênh chuyển/rửa KEN, không cần mật khẩu như Chuyển KEN |
| Hiệu ứng | Ảnh tĩnh PNG/WebP (admin upload) + animation chung (CSS keyframes ở web, `Animated` ở mobile) |
| Xếp hạng | Có ngay: **Top tặng** (đại gia) + **Top nhận** (được yêu thích) theo tuần / tháng / tất cả |

Ngoài phạm vi (để sau): tặng trong phòng chat, tặng dưới bài Me/khoảnh khắc, Lottie, combo quà, quà giới hạn theo sự kiện, đổi charm ra phần thưởng.

## 2. Cái đã có, dùng lại

- `ken_transactions` đã có type `GIFT_SENT` / `GIFT_RECEIVED` ([ken_transaction.model.go](../server/internal/models/ken_transaction.model.go)) + nhãn lịch sử và icon 🎁 trong [packages/shared/src/constants/ken.ts](../packages/shared/src/constants/ken.ts). Chỉ cần thêm `GIFT_SENT` vào `visibleKenTxTypes` ở [ken.repository.go](../server/internal/modules/ken/ken.repository.go). `GIFT_RECEIVED` không dùng vì người nhận không nhận KEN.
- Mẫu trừ KEN trong transaction (khoá dòng user, ghi `balance_before/after`): `Transfer` ở [ken.repository.go](../server/internal/modules/ken/ken.repository.go). Sau commit gọi `wsServer.EmitKenUpdate`.
- Mẫu tin nhắn do server sinh: `sendCallLogMessage` ở [call.service.go](../server/internal/modules/call/call.service.go) gọi `msgService.SendMessage(..., MessageTypeCall, "", metadataJSON, ...)`. DTO gửi tin của client đang `oneof=text image file video audio` ([message.dto.go](../server/internal/modules/message/message.dto.go)) → client **không** giả được tin `gift`. Giữ nguyên ràng buộc này.
- Kiểm tra chặn: `conversation.BlockIfUsersBlocked` / lỗi `ErrBlockedGift` của VIP gift ([vip.service.go](../server/internal/modules/vip/vip.service.go)).
- Thông báo: `notifSvc.Create(recipient, &actor, type, &refID, preview)` + nội dung push ở [push.content.go](../server/internal/push/push.content.go).
- BXH theo kỳ giờ VN: `periodRange` trong [wordchain.leaderboard.go](../server/internal/modules/room/wordchain/wordchain.leaderboard.go).
- Upload ảnh admin: [admin/upload](../server/internal/modules/admin/upload/upload.controller.go). Trang mẫu CRUD catalog: [admin/src/pages/vip/VipShopPage.tsx](../admin/src/pages/vip/VipShopPage.tsx).
- Cài đặt: `app_settings` KV + form admin (như `username_change`, `topup`).
- UI: panel "Thêm" ở [web AttachmentBar.tsx](../web/src/shared/components/ui/AttachmentBar.tsx) và [mobile AttachmentBar.tsx](../mobile/src/screens/chat/components/AttachmentBar.tsx); nút profile ở `RelationButtons.tsx` (web + mobile); số "hôn" (`kisses`) ở `ProfileCard.tsx` là chỗ đặt charm.

## 3. Dữ liệu (PostgreSQL)

Migration mới, version **lớn hơn mọi môi trường** → nằm chung với loa trong `20261106000001_add_gifts_megaphones`. Không sửa migration đã chạy.

```sql
CREATE TABLE gifts (
  id           uuid PRIMARY KEY,
  name         varchar(60)  NOT NULL,
  name_en      varchar(60)  NOT NULL DEFAULT '',
  image_url    varchar(500) NOT NULL,
  ken_price    int  NOT NULL CHECK (ken_price > 0),
  charm_points int  NOT NULL CHECK (charm_points >= 0),
  is_active    boolean NOT NULL DEFAULT true,
  sort_order   int  NOT NULL DEFAULT 0,
  created_at, updated_at, deleted_at
);

CREATE TABLE gift_transactions (
  id                uuid PRIMARY KEY,
  sender_id         uuid NOT NULL REFERENCES users(id),
  receiver_id       uuid NOT NULL REFERENCES users(id),
  gift_id           uuid NOT NULL REFERENCES gifts(id),
  gift_name         varchar(60)  NOT NULL,
  gift_image_url    varchar(500) NOT NULL,
  quantity          int NOT NULL CHECK (quantity > 0),
  unit_price        int NOT NULL,
  total_ken         int NOT NULL,
  charm_points      int NOT NULL,
  source            varchar(20) NOT NULL,
  conversation_id   uuid,
  message_id        uuid,
  note              varchar(100) NOT NULL DEFAULT '',
  client_request_id varchar(64) NOT NULL,
  created_at        timestamptz NOT NULL DEFAULT now(),
  UNIQUE (sender_id, client_request_id)
);
CREATE INDEX idx_gift_tx_receiver ON gift_transactions (receiver_id, created_at DESC);
CREATE INDEX idx_gift_tx_sender   ON gift_transactions (sender_id, created_at DESC);
CREATE INDEX idx_gift_tx_created  ON gift_transactions (created_at);

CREATE TABLE user_gift_wall (
  receiver_id      uuid NOT NULL REFERENCES users(id),
  gift_id          uuid NOT NULL REFERENCES gifts(id),
  quantity         int  NOT NULL DEFAULT 0,
  last_received_at timestamptz NOT NULL,
  PRIMARY KEY (receiver_id, gift_id)
);

ALTER TABLE users ADD COLUMN charm int NOT NULL DEFAULT 0;
```

Ghi chú:
- `gift_transactions` **snapshot** tên/ảnh/giá/charm lúc tặng → admin đổi giá hoặc tắt quà không làm sai lịch sử, tin nhắn cũ.
- `charm_points` là tổng = `gift.charm_points × quantity`. Mặc định admin đặt charm = giá KEN, nhưng tách cột để sau này cân lại.
- `user_gift_wall` là bảng tổng hợp, upsert trong cùng transaction → tường quà đọc 1 query, không phải `GROUP BY` sổ quà.
- `users.charm` để cạnh `kisses`, profile đọc sẵn, BXH "tất cả" của top nhận = `ORDER BY charm`.
- Model GORM: `gift.model.go`, `gift_transaction.model.go`, `user_gift_wall.model.go`, thêm `Charm` vào `user.model.go`.
- Không cần migration Scylla: cột `type` của message là text.

## 4. Server (Go) — module `internal/modules/gift`

Theo khuôn module: `gift.router.go`, `gift.controller.go`, `gift.service.go`, `gift.repository.go`, `gift.dto.go`, `gift.constants.go`, `gift.dig.go`, đăng ký ở `cmd/api/container.go`.

### 4.1 API người dùng (`RequireAuth`)

| Method | Path | Mô tả |
|---|---|---|
| GET | `/gifts` | Catalog đang bật, sắp theo `sort_order`. Cache Redis `GIFT:CATALOG`, xoá khi admin sửa |
| POST | `/gifts/send` | Tặng quà (chi tiết 4.2) |
| GET | `/gifts/users/:id/wall` | `{ userId, charm, totalGifts, items: [{ gift, quantity }] }` |
| GET | `/gifts/received?cursor=` | Lịch sử mình nhận (ai tặng, quà gì, lời nhắn). Keyset `utils.EncodeTimeCursor` |
| GET | `/gifts/sent?cursor=` | Lịch sử mình tặng |
| GET | `/gifts/leaderboard?type=sender\|receiver&period=week\|month\|all&limit=50` | `{ items: [{ rank, user, value }], me: { rank, value } }` |

Request tặng:

```json
{ "giftId": "uuid", "receiverId": "uuid", "quantity": 5, "note": "chúc mừng sinh nhật",
  "source": "chat", "clientRequestId": "uuid-sinh-ở-client" }
```

Response: `{ transactionId, kenBalance, receiverCharm, messageId? }`.

### 4.2 Luồng `Send` (service)

1. Đọc setting `gift` → `enabled`, `quantityMax`, `noteMaxLength`. Tắt → `GIFT_DISABLED`.
2. Validate: không tự tặng (`CANNOT_GIFT_SELF`), `quantity` trong `[1, quantityMax]`, `note` cắt khoảng trắng + giới hạn độ dài, `source ∈ {chat, profile}`.
3. Quà tồn tại + `is_active` (`GIFT_NOT_FOUND`). Người nhận tồn tại, `is_active`, không bị khoá (`RECEIVER_UNAVAILABLE`). Hai bên không chặn nhau (`GIFT_BLOCKED`).
4. Rate limit 20 lần/phút mỗi user bằng middleware `PolicyGiftSend` (chỉ bật ở release mode như các policy khác).
5. **Một transaction DB**:
   - Nếu đã có `(sender_id, client_request_id)` → trả lại kết quả cũ (idempotent, client retry không trừ 2 lần).
   - `SELECT ... FOR UPDATE` dòng người tặng, đủ KEN không (`INSUFFICIENT_KEN`, dùng lại mã lỗi KEN sẵn có).
   - Trừ `users.ken`, ghi `ken_transactions` type `GIFT_SENT`, `ref_type = 'gift_transaction'`, `ref_id`, `metadata { giftId, receiverId, quantity }`.
   - Insert `gift_transactions`, upsert `user_gift_wall`, `UPDATE users SET charm = charm + ?` cho người nhận.
6. Sau commit:
   - `wsServer.EmitKenUpdate(sender, kenBalance)`; xoá cache profile người nhận (charm đổi).
   - `source = chat` → `msgService.SendDirectMessage(sender, receiver, MessageTypeGift, fallbackText, metadataJSON, clientRequestId)` rồi cập nhật `message_id` vào sổ quà. Lỗi ở bước này chỉ log (KEN đã trừ hợp lệ, quà vẫn vào tường).
   - `source = profile` → `notifSvc.Create(receiver, &sender, AppNotificationGiftReceived, &txID, "🎁 {tên} ×{số}")` → realtime `APP_NOTIFICATION` + push "Đã tặng bạn một món quà: 🎁 …". `source = chat` **không** tạo thông báo vì tin nhắn quà đã có push riêng (tránh báo 2 lần).

### 4.3 Tin nhắn loại `gift`

- `constants.MessageTypeGift = "gift"` ở [internal/constants/message.go](../server/internal/constants/message.go). **Không** thêm vào `oneof` của DTO client.
- `GiftMetadata { transactionId, giftId, giftName, giftNameEn, imageUrl, quantity, charmPoints }`: chỉ thông tin giao dịch.
- `content` = lời nhắn của người tặng (rỗng nếu không nhắn). Client đọc lời nhắn từ `content` (`parseGiftMessageMetadata(metadata, content)`). App bản cũ không biết type `gift` sẽ chỉ hiện lời nhắn, hoặc bong bóng rỗng khi không có lời nhắn.
- `previewForType` thêm nhánh `gift` → `🎁 {tên} ×{số}` từ metadata (dùng cho tin cuối + push); client `previewOf` cũng tạo từ metadata qua `giftMessagePreview`; [admin conversation.service.go](../server/internal/modules/admin/conversation/conversation.service.go) thêm nhánh hiển thị.
- Không cho sửa tin `gift` (như `call`). Cho xoá phía mình như tin thường; xoá tin không hoàn KEN.

### 4.4 Bảng xếp hạng

- `period = week|month`: `SUM(total_ken)` theo `sender_id` (top tặng) hoặc `SUM(charm_points)` theo `receiver_id` (top nhận) trên `gift_transactions` trong `periodRange` giờ VN (tách `periodRange` của word-chain ra `utils` để dùng chung, đừng chép).
- `period = all`: top nhận dùng `users.charm`; top tặng `SUM` toàn bảng (index `sender_id` đủ dùng ở quy mô hiện tại).
- Loại user `is_active = false` hoặc đang bị khoá. Cache Redis `GIFT:LB:{type}:{period}` TTL 60s; `me.rank` tính riêng (không cache chung).

### 4.5 Admin

- `internal/modules/admin/gift`: CRUD `/admin/gifts` (tên vi/en, ảnh qua admin upload, giá, charm, bật/tắt, thứ tự), xoá mềm; `GET /admin/gift-transactions` lọc theo user / khoảng ngày (`utils.ParseTimeRange`), dùng lại `admincommon.UserBriefOf`. Ghi audit log như các trang admin khác.
- Setting `gift` trong `app_settings`: `{ enabled, platforms, quantityOptions: [1, 5, 10, 99], quantityMax: 99, noteMaxLength: 100, confirmOverKen: 1000 }`. `enabled` là công tắc tổng, `platforms` bật/tắt theo web, Android, iOS và từng bản. App nhận qua key `gift` của `GET /settings/app` lúc vừa vào; `GET /gifts` vẫn trả kèm cho app cũ. Server trả `enabled` đã tính theo nền tảng người gọi, không lộ `platforms`.
- Dashboard (tuỳ chọn): KEN thu từ quà hôm nay / tháng.

### 4.6 Test server

- Unit test service: thiếu KEN, tự tặng, bị chặn, quà tắt, quantity ngoài khoảng, **idempotent** (cùng `clientRequestId` gửi 2 lần chỉ trừ 1 lần), **2 request song song** không làm âm KEN.
- API test trong `server/tests/api` (luồng tặng → tường quà → BXH → lịch sử KEN có `GIFT_SENT`).

## 5. Shared (`@ola/shared`)

- `types/api/gift.type.ts`: `Gift`, `GiftSettings`, `SendGiftRequest/Result`, `GiftWall`, `GiftHistoryItem`, `GiftLeaderboard`.
- `MessageType` thêm `'gift'`, `MESSAGE_TYPE.gift`; `GiftMessageMetadata` + hàm parse an toàn (metadata hỏng → trả `null`, UI rơi về text).
- `APP_NOTIFICATION_TYPE.giftReceived = 'gift_received'`.
- Hằng `GIFT_SOURCE`, `GIFT_LEADERBOARD_TYPE`, `GIFT_LEADERBOARD_PERIOD` theo mẫu `as const satisfies`.
- Service `GiftService` (catalog, send, wall, history, leaderboard). Catalog cache trong store nhỏ (zustand) để mở dialog không chờ mạng.
- Helper thuần: `giftTotalKen(gift, qty)`, `canAffordGift(balance, gift, qty)`, `clampGiftQuantity` — test ở mobile jest.
- i18n vi/en: `gift.*` (tiêu đề dialog, nút, lỗi theo mã server, câu thông báo, BXH).

## 6. Web

- **`GiftPickerDialog`** (dùng `Dialog`/`DialogButton` chuẩn): lưới quà (ảnh, tên, giá), chọn số lượng theo `quantityOptions`, ô lời nhắn, dòng "Tổng: X KEN · Số dư: Y", nút Tặng disable khi thiếu KEN + link "Nạp KEN". Bước xác nhận khi tổng ≥ ngưỡng (vd 1.000 KEN). Sinh `clientRequestId` một lần mỗi lần mở dialog.
- **Chat 1-1**: icon Tặng quà trên thanh công cụ, bên phải mic, không nằm trong menu Khác (web `AttachSendPayload.kind = 'gift'`, mobile `onSendGift`) → mở dialog với người nhận = peer. Tin `gift` render `GiftMessageCard` (ảnh quà, "×5", lời nhắn, viền/nền theo token `ola-*`) trong `ChatMessageBubble`/`MessageRow`.
- **Hiệu ứng** `GiftAnimationOverlay`: ảnh quà bay vào giữa, phóng to + lấp lánh ~2s rồi mờ. Chạy cho người tặng sau khi gửi thành công và cho người nhận khi `NEW_MESSAGE` loại `gift` tới (đang mở đúng hội thoại) hoặc khi nhận `APP_NOTIFICATION` `gift_received`. Hàng đợi để nhiều quà liên tiếp không chồng nhau; tôn trọng `prefers-reduced-motion`.
- **Profile**: nút "Tặng quà" trong `RelationButtons` (chỉ profile người khác); charm cạnh số hôn trong `ProfileCard`; section/overlay **Tường quà** (lưới quà + số lượng, tổng charm); link sang BXH.
- **Trang "Quà tặng"** (mục mới trong tab Cá nhân, `pages/gift/GiftHomePage.tsx`): sức hút của mình + tường quà + lối vào Bảng xếp hạng và Lịch sử quà. Cần vì "Trang cá nhân" trong tab Cá nhân là form sửa thông tin, người nhận không có chỗ khác xem quà của mình.
- **BXH**: trang mới (route trong `ROUTES`), 2 tab Top tặng / Top nhận, chọn kỳ tuần / tháng / tất cả, top 3 nổi bật, dòng hạng của mình ghim dưới. Lối vào từ tường quà và danh sách Ứng dụng (`pages/apps`).
- **Thông báo**: `NotificationsPage` render loại `gift_received`, bấm mở profile người tặng (hoặc hội thoại nếu từ chat).
- **Lịch sử KEN**: tự hiện `GIFT_SENT` sau khi server mở `visibleKenTxTypes`.

## 7. Mobile (React Native)

Port từ web bằng skill `port-web-to-mobile`. Logic chung nằm ở `@ola/shared/stores/gift/`, web và mobile chỉ còn phần giao diện:

- `useGiftPicker`: chọn quà/số lượng/lời nhắn, giữ `clientRequestId` (đổi khi đổi lựa chọn, giữ nguyên khi thử lại), bước xác nhận theo `confirmOverKen`, gửi, cập nhật số dư, chạy hiệu ứng, toast lỗi.
- `useGiftHistory` (phân trang, cờ đang tải riêng từng tab), `useGiftLeaderboard` (đệm theo loại + kỳ, lỗi gắn với đúng tab/kỳ và tự xoá khi đổi lựa chọn), `useGiftWall`.
- `useGiftAnimationStore` (hàng đợi hiệu ứng, chống chạy trùng theo id); web `@/store/giftAnimationStore` chỉ re-export.
- Hằng số tab/nhãn kỳ/huy chương (`GIFT_LEADERBOARD_TYPE_TABS`, `GIFT_HISTORY_TABS`...) và `isRecentGift` (quà mới ≤ 15 giây) cũng ở shared.

Phần riêng của mobile:

- `components/gift/GiftPickerDialog.tsx`: `Dialog`/`DialogButton` chuẩn, bước xác nhận đổi nội dung ngay trong cùng dialog, bật `showToasts` để toast lỗi hiện trên dialog (prop mới của `Dialog`, toast ở gốc app nằm dưới cửa sổ Modal). Màu hồng quà ở `components/gift/constants.ts`, ảnh ở `components/gift/giftAssets.ts`.
- `components/gift/GiftAnimationOverlay.tsx`: dựng lại keyframes web bằng `react-native-reanimated` + tia sáng `react-native-svg`, mount ở `App.tsx` cạnh `ToastHost`; tia/đốm sáng đặt trong khung cố định bằng số (dùng `left: '50%'` trong khung co theo nội dung thì bị lệch). Máy bật giảm chuyển động thì hiện tĩnh.
- `LinearGradient` chỉ dùng làm nền phủ kín (`StyleSheet.absoluteFill`), nội dung đặt ở view bên trên: đặt padding thẳng lên gradient thì nội dung bị cắt.
- Chat: mục "Tặng quà" trong panel Thêm của `AttachmentBar`; `ChatBubble` có nhánh `MESSAGE_TYPE.gift` → `GiftMessageBubble`; `useIncomingGiftAnimation` chạy hiệu ứng khi tin quà mới đến từ người kia; tin quà không trả lời/báo cáo được.
- Profile: nút Tặng quà trong `RelationButtons`, dòng ✨ sức hút dưới số hôn trong `ProfileCard`, `GiftWallSection` dưới thẻ profile.
- Màn trên root stack: `GiftHome` (mục "Quà tặng" ở tab Cá nhân), `GiftLeaderboard`, `GiftHistory`. Web mở các trang này dạng overlay.
- Thông báo `gift_received` trong `NotificationsScreen`; push `app_notification` mở màn Thông báo như các loại khác.
- Chặn: đang chặn/bị chặn thì chat thay ô nhập bằng thanh thông báo chặn, profile chỉ còn nút Bỏ chặn hoặc báo không tìm thấy, nên không có nút tặng. Bị chặn trong lúc đang mở chat thì server trả `GIFT_BLOCKED`, không trừ KEN, dialog báo "Không thể tặng quà cho người này".

## 8. Admin web

- `admin/src/pages/gifts/`: `GiftsPage` (bảng + `GiftFormModal` có upload ảnh, giá, charm, bật/tắt, kéo thứ tự), `GiftTransactionsPage` (lọc user/ngày, tổng KEN thu). Query hook theo mẫu `useVipShopQueries.ts`.
- Form setting `gift` trong trang Settings.

## 9. Tài nguyên cần chuẩn bị

- Bộ ảnh quà PNG/WebP nền trong, ~256×256, một phong cách. Gợi ý catalog khởi điểm (giá KEN / charm):

| Quà | Giá | Charm |
|---|---|---|
| Hoa hồng | 10 | 10 |
| Trái tim | 20 | 20 |
| Kẹo mút | 50 | 50 |
| Socola | 100 | 100 |
| Gấu bông | 200 | 200 |
| Bánh kem | 500 | 500 |
| Nhẫn kim cương | 2.000 | 2.000 |
| Siêu xe | 5.000 | 5.000 |
| Du thuyền | 10.000 | 10.000 |
| Lâu đài | 20.000 | 20.000 |

- Admin tạo quà qua UI sau khi deploy (không seed ảnh vào migration).

## 10. Thứ tự làm

1. **Server**: migration + model → module `gift` (send, catalog, wall, history) → tin `gift` + preview + push/notification → BXH → admin module + setting → test.
2. **Shared**: type, hằng, service, helper + test, i18n.
3. **Admin web**: catalog + sổ quà + setting → tạo bộ quà trên dev.
4. **Web**: dialog + chat + hiệu ứng → profile + tường quà → BXH → thông báo. Verify bằng CDP (cổng 3006).
5. **Mobile**: port như mục 7, chạy iOS simulator + Android.
6. **Phát hành**: chạy migration trên dev/prod **trước**, deploy server, tạo quà trên admin prod, rồi mới bật setting `enabled` và phát hành web/app. App bản cũ vẫn đọc được tin quà nhờ `content` dự phòng.

## 11. Rủi ro và lưu ý

- **Apple/Google**: người nhận không nhận được giá trị quy đổi (không KEN, không tiền) → quà là vật phẩm tiêu dùng thuần, ít rủi ro chính sách hơn phương án chia KEN. Nếu sau này muốn chia KEN cho người nhận, phải xem lại cả chính sách store lẫn chống rửa KEN (chuyển KEN hiện bắt mật khẩu).
- **Trừ tiền 2 lần**: chặn bằng `clientRequestId` unique + khoá dòng; client giữ cùng id khi retry.
- **Spam tặng quà tới người lạ từ profile**: đã chặn bằng block + rate limit; nếu cần thêm, cài đặt riêng tư "Chỉ bạn bè được tặng quà" ở `user_settings` (giai đoạn sau).
- **Tin nhắn giả mạo**: client không gửi được type `gift` (DTO `oneof`); không nới ràng buộc này.
- **BXH bị thao túng bằng nick phụ**: top nhận có thể bị bơm bằng tài khoản phụ tự tặng nhau; theo dõi qua trang sổ quà admin, chưa xử lý tự động ở bản đầu.

## 12. Đã chốt (04/11/2026)

- Tên hiển thị của `charm`: **Sức hút**.
- Bước xác nhận khi tổng ≥ **1.000 KEN** (`confirmOverKen` trong setting `gift`, admin chỉnh được); rate limit **20 lần/phút** mỗi người tặng (middleware, cố định trong code).
- Tặng từ profile **không** tạo tin `gift` trong chat 1-1, chỉ thông báo + tường quà.
- Tường quà công khai chỉ hiện **loại quà + số lượng + tổng sức hút**; danh sách ai tặng chỉ chủ profile xem (lịch sử quà nhận).
- Bản đầu chưa có cài đặt ẩn sức hút, chưa hiện ở danh sách thành viên phòng.
