# Avatar frames

Danh mục 731 khung avatar nằm ở `packages/shared/src/lib/avatarFrames.json`, dùng chung cho admin, web và mobile. `assets/avatar_frames/frames.json` là bản sao giống hệt; sửa danh mục thì sửa cả hai file. Ảnh webp 160×160 (giữ animation) nằm trên S3 ở `ola/avatar_frames/`.

```json
{
  "id": "001",
  "name": "Carrot",
  "file": "001.webp",
  "url": "https://s3.vn-hcm-1.vietnix.cloud/ola/avatar_frames/001.webp"
}
```

```ts
import { AVATAR_FRAMES, avatarFrameById } from '@ola/shared/lib/avatarFrame';
```

- Import qua `@ola/shared/lib/avatarFrame`, không qua barrel `@ola/shared/lib`, để màn không dùng frame khỏi phải kéo theo file JSON.
- `id` là chuỗi, trùng tên file, không được đổi hay đánh lại. Server chỉ lưu `frameId`.
- Đã bỏ 28 mẫu sticker che kín avatar và 7 dòng trùng file.
- 6 frame chưa có tên: `100`, `256`, `555`, `657`, `658`, `707`.
- Hiển thị: khung rộng bằng 1,2 lần chỗ avatar, avatar bằng 66% khung, khung đè lên trên avatar.
- Chỉ gắn frame cho avatar của user (`user.avatar`) trong Me, không gắn cho `VipAvatar` hay icon.

Bộ gốc 264px (759 ảnh, gồm cả sticker): https://drive.google.com/open?id=1nXDcAOplfoXxIkIsV1aYswPrvp4tcpYE

## Kế hoạch triển khai: bán khung như icon VIP

Mục tiêu: user mua khung bằng KEN trong Cửa hàng, tặng hoặc chuyển khung cho người khác, có kho khung để chọn đeo, khung hiện quanh avatar trong Me. Danh mục khung cố định trong JSON, admin không thêm khung; admin chỉ chọn khung nào trong JSON được bán với giá bao nhiêu (cửa hàng như icon VIP), xem lịch sử mua và chuyển. Server không giữ JSON, chỉ lưu và trả `frameId`, client tra JSON ra tên và ảnh. Làm theo khuôn icon VIP (module `server/internal/modules/vip`, admin `admin/src/pages/vip`, web `web/src/pages/vip`, mobile `mobile/src/screens/vip`).

### Đã chốt

| Câu hỏi | Chốt |
|---|---|
| Thời hạn | Vĩnh viễn. |
| Số bản mỗi user | Một bản mỗi khung, khoá `UNIQUE (user_id, frame_id)`. Mua lặp, tặng hoặc chuyển cho người đã có khung đó đều bị từ chối. |
| Điều kiện đeo | Phải còn VIP. Hết VIP vẫn mua và nhận khung được, khung vẫn nằm trong kho; khung đang đeo không hiện nữa và hiện lại khi gia hạn VIP. Đổi khung không bị trừ ngày VIP. |
| Bản đầu tiên | Mua, kho, đeo, tặng, chuyển nhượng, phần quản lý admin. Chưa làm khung từ trứng hoặc vòng quay. |
| Quyền xem Kho khung | Giống Kho VIP: user chọn ai được xem kho khung của mình (mọi người, bạn bè, chỉ mình tôi). Khung đang đeo vẫn hiện với mọi người. |

### Lưu ở đâu

- Khung **đang đeo** lưu ở `users.avatar_frame_id`, giống `users.vip_used`. Avatar hiện ở đâu cũng cần khung đang đeo, và `users` vốn đã được nạp sẵn (tác giả bài Me qua `Preload("Author")`, cache `USER:%s:PROFILE` có sẵn `vip_end_time`), nên không tốn thêm truy vấn.
- Danh sách khung **sở hữu** lưu ở bảng riêng `user_avatar_frames`, giống `user_vip_icons`, không nhét mảng vào `users`:
  - Chuyển nhượng cần khoá đúng một dòng khung để chặn hai lệnh chuyển cùng lúc; mảng trong `users` phải khoá cả user và dễ bị ghi đè khi vừa nhận khung vừa chuyển khung khác.
  - Mỗi khung có nguồn (mua, tặng, chuyển) và ngày nhận để tra lịch sử.
  - `UNIQUE (user_id, frame_id)` để DB tự chặn sở hữu trùng.
  - Admin cần truy vấn ngược (khung nào bán bao nhiêu, ai đang có).
  - `users` được nạp ở rất nhiều nơi; kéo theo cả danh sách khung là thừa vì chỉ màn Kho khung cần.

### 1. Database (1 migration, version lớn hơn mọi môi trường, ví dụ `20261108000001_add_avatar_frames`)

- `avatar_frame_shop_items`: `id`, `frame_id varchar(8)`, `ken_price int`, `is_active bool`, `sort_order int`, timestamps, `deleted_at`. Unique `frame_id WHERE deleted_at IS NULL`. Server không có danh mục JSON nên dùng bảng này để kiểm tra `frame_id`: user chỉ mua và tặng được khung `is_active`. Admin chọn khung từ danh mục JSON ở giao diện, server chỉ kiểm tra định dạng id (3 chữ số).
- `user_avatar_frames`: `id`, `user_id`, `frame_id varchar(8)`, `source varchar(20)` (purchase/gift/transfer), `acquired_at`, `deleted_at`. Unique `(user_id, frame_id) WHERE deleted_at IS NULL`.
- `avatar_frame_purchases`: `user_id` (người trả KEN), `recipient_user_id` (người nhận khi tặng, null khi tự mua), `shop_item_id`, `frame_id`, `ken_price`, `ken_balance_after`, `source` (purchase/gift), `created_at`. Không dùng chung `vip_purchases` vì bảng đó gắn với ngày VIP.
- `avatar_frame_transfers`: `from_user_id`, `to_user_id`, `frame_id`, `created_at`, index theo từng user.
- `users.avatar_frame_id varchar(8) NULL`: khung đang đeo. Hết VIP vẫn giữ giá trị để gia hạn là hiện lại.
- `user_settings.avatar_frame_store_privacy smallint NOT NULL DEFAULT 0`: quyền xem Kho khung, cùng quy ước với `vip_store_privacy` (0 mọi người, 1 bạn bè, 2 chỉ mình tôi).
- `ken_transactions` dùng loại mới `AVATAR_FRAME`. Cột `type` là `varchar(40)` không có check constraint nên không phải sửa schema.
- Không sửa migration đã chạy ở môi trường nào. Chạy migration trước khi deploy server mới.

### 2. Server (module mới `internal/modules/avatar-frame`, package `avatarframe`)

API cho user, tất cả qua `RequireAuth()`:

| Route | Việc |
|---|---|
| `GET /avatar-frames/shop` | Khung đang bán (`is_active`), kèm cờ `owned` của user |
| `POST /avatar-frames/buy {shopItemId, expectedKenPrice}` | Một transaction: `SELECT … FOR UPDATE` user, đọc lại món hàng trong transaction (ngừng bán thì báo lỗi, giá khác `expectedKenPrice` thì trả `AVATAR_FRAME_PRICE_CHANGED` và không trừ KEN), kiểm tra KEN, trừ KEN, thêm `user_avatar_frames` (`purchase`), `avatar_frame_purchases`, `ken_transactions` loại `AVATAR_FRAME` (`ref_type='avatar_frame_purchase'`). Đã sở hữu thì trả lỗi riêng; hai request mua cùng lúc thì lệnh sau vướng unique index, lỗi Postgres `23505` phải đổi thành lỗi "đã sở hữu" và rollback cả phần trừ KEN. Sau commit xoá cache `USER:%s:PROFILE`, gọi `EmitKenUpdate` |
| `POST /avatar-frames/gift {shopItemId, expectedKenPrice, toUsername, password}` | Kiểm tra giá như lệnh mua. Như `POST /vip/gift`: không tự tặng mình, kiểm tra mật khẩu bcrypt và chặn nhau, khoá hai user theo thứ tự uuid, người nhận đã có khung thì từ chối. Người tặng bị trừ KEN, người nhận có khung (`gift`), gửi thông báo |
| `GET /avatar-frames/mine` | Kho khung, khung đang đeo xếp đầu. Trả `equippedFrameId` thật (kể cả khi hết VIP) và `vipActive`, vì `/auth/me` trả null khi hết VIP nên màn Kho khung cần biết khung nào đang đeo nhưng tạm ẩn |
| `PUT /avatar-frames/equip {frameId}` | Phải sở hữu và còn VIP (`HasActiveVip`, nếu không trả `ErrVipExpired`); `frameId` rỗng là tháo, tháo không cần VIP. Xoá cache user |
| `POST /avatar-frames/mine/:frameId/transfer {toUserId, password}` | Không tự chuyển cho mình, kiểm tra mật khẩu và chặn nhau (`IsBlockedEither` như `vip.service.go` Transfer), khung đang đeo thì không chuyển. Trong một transaction có khoá dòng `user_avatar_frames` (`FOR UPDATE`), người nhận đã có khung thì từ chối, chuyển dòng sang người nhận (`transfer`), ghi `avatar_frame_transfers`, gửi thông báo. VIP đang kiểm tra ngoài transaction nên có thể đua, khung không lặp lỗi đó |
| `GET /avatar-frames/history` | Lịch sử mua và được tặng của chính user |
| `GET /avatar-frames/transfers` | Lịch sử chuyển nhận khung của chính user |
| `GET /avatar-frames/users/:userId/store` | Xem Kho khung của người khác, kiểm tra quyền xem như `GET /vip/users/:userId/store`; không đủ quyền thì trả lỗi riêng |
| `PUT /avatar-frames/store/privacy {privacy}` | Đổi quyền xem Kho khung, chỉ nhận 0, 1, 2; xoá cache `USER:%s:SETTINGS` |

- Hiển thị theo VIP tính ở server: hàm `User.ActiveAvatarFrameID()` trả `avatar_frame_id` khi `HasActiveVip()`, ngược lại trả null. Mọi DTO trả `avatarFrameId` qua hàm này nên client không phải tự xét hạn VIP.
- Thêm `AvatarFrameID` vào model `User` và struct cache user (`user/user.cache.go`, cache đã có `VipEndTime`).
- Các response trả `avatarFrameId`:

  | Response | Chỗ trong code |
  |---|---|
  | Đăng nhập, `GET /auth/me` | `auth.service.go`, `auth.dto.go` |
  | Hồ sơ của chính mình | `user.service.go` (hàm trả profile của mình) |
  | Hồ sơ người khác `GET /users/:id`, kèm cờ `canViewAvatarFrameStore` | `user.service.go`, cạnh `canSeeVipStore` và `CanViewVipStore` |
  | Tác giả bài Me, người bình luận, người thích | `me/me.dto.go`, `me/me.repository.go` |
  | Khách ghé thăm, thông báo Me | `user.service.go` (visitors), module thông báo Me |
  | Khoảnh khắc | `moment.dto.go` |

  Các truy vấn `Select` cột lẻ (như danh sách người thích `me.repository.go`) phải thêm `avatar_frame_id` và `vip_end_time`.
- Quyền xem Kho khung: tách logic của `canSeeVipStore` (`user.service.go:449`) thành hàm chung nhận mức quyền, dùng cho cả Kho VIP và Kho khung. Đọc và ghi mức quyền theo `GetVipStorePrivacy`, `SetVipStorePrivacy` trong `vip.repository.go`. `GET /user-settings` trả thêm `avatarFrameStorePrivacy`.
- Tác giả bài Me, người bình luận, actor thông báo Me (`Preload("Actor")`) và tác giả khoảnh khắc (`FindUsers`, `FindWithAuthors`) đều nạp trực tiếp từ `users`, không lưu ảnh chụp, nên đổi khung là hiện ngay ở lần tải sau. Chỉ cache top người thích (`ME:POST:%s:TOP_LIKERS`) là avatar 18px, không gắn khung.
- Thông báo: loại mới cho nhận khung được tặng và được chuyển, theo `AppNotificationVipReceived` và `AppNotificationTransfer` trong `models/app_notification.model.go`. Thêm câu chữ push vào map trong `push/push.content.go` (cạnh `AppNotificationVipReceived`), xem hàm phân loại ở `app_notification.model.go:65` có cần thêm loại mới không. API trả cả `preview` chữ vì app cũ in thẳng `preview`.
- Hằng số (cache key, mã lỗi) trong `avatar-frame.constants.go`; loại KEN thêm vào `models/ken_transaction.model.go` cạnh `KenTxTypeVipIcon`.
- Không có socket báo khi đổi khung, giống VIP: client tự thấy ở lần tải sau.

### 3. Admin

Server `/admin/avatar-frames` qua `RequireAdmin()`:
- Cửa hàng: `GET/POST /shop` (nhận nhiều `frameId` cùng giá), `PATCH/DELETE /shop/:id`.
- Báo cáo: `GET /purchases`, `GET /purchases/stats`, `GET /transfers`.

UI `admin/src`:
- Thêm mục "Khung avatar" vào Cửa hàng (`pages/shop/sections.tsx`, cạnh VIP, Quà tặng, Loa), có thanh chuyển "Khung đang bán", "Lịch sử mua" và "Lịch sử chuyển".
- Form thêm khung: lưới chọn khung từ `AVATAR_FRAMES` có ảnh xem trước, ô tìm theo id/tên, nhập giá KEN, bật tắt, thứ tự. Chọn nhiều khung để thêm cùng một giá.
- Bật `resolveJsonModule` trong `admin/tsconfig.app.json` để import danh mục.

### 4. Shared (`packages/shared`)

- Đường dẫn API trong `config/api.ts`, service `services/avatarFrame.service.ts`, kiểu trong `types/api/avatarFrame.type.ts`.
- Thêm `avatarFrameId?: string | null` vào các kiểu user liên quan (`types/api/user.type.ts`, kiểu bài/bình luận Me, moment), `canViewAvatarFrameStore: boolean` cạnh `canViewVipStore`, `avatarFrameStorePrivacy` vào kiểu user setting.
- Service có `getPeerStore(userId)` và `setPrivacy(privacy)` như `VipService.setPrivacy`.
- Helper `avatarFrameLayout(slot)` trả kích thước khung và avatar theo tỉ lệ 1,2 và 0,66 để web và mobile dùng chung.
- Hàm map lỗi (giống `lib/vipPurchase.ts`): thiếu KEN, đã sở hữu, người nhận đã có, hết VIP, khung đang đeo, sai mật khẩu.
- i18n khối `avatarFrame` trong `i18n/locales/{vi,en}.json`, nhãn `ken.historyScreen.types.AVATAR_FRAME` cùng mục trong `constants/ken.ts`, chữ cho hai loại thông báo mới.

### 5. Web và mobile

- Component `AvatarWithFrame` riêng cho mỗi nền tảng (web `shared/components/ui`, mobile `components/ui`): nhận `src`, `name`, `size`, `frameId`; giữ nguyên chỗ cũ, thu avatar vào trong, khung đè lên. `frameId` null, hoặc id không có trong `AVATAR_FRAMES` (khung đã bỏ khỏi danh mục), thì hiển thị y như `Avatar` cũ.
- Thay `Avatar` bằng `AvatarWithFrame` ở các chỗ trong Me: tác giả bài, bình luận, ô nhập bình luận, menu trái/phải, người thích, khách ghé thăm, thông báo, khay khoảnh khắc. Bỏ qua chỗ avatar 18px.
- Màn "Mua và tặng khung", mở từ màn "Khung avatar": lưới khung kèm giá, nút mua và nút tặng (nhập username và mật khẩu như `BuyVipPage` chế độ tặng), xác nhận trừ KEN, cập nhật số dư (đặt số dư từ response rồi `refreshUser`). Hết VIP vẫn mua được nhưng hiện ghi chú cần VIP để đeo.
- Màn "Khung avatar", là dòng duy nhất của tính năng trong menu Cá nhân (giống Kho VIP): có dòng "Mua và tặng khung", lưới khung đã có, chạm để đeo hoặc tháo, xem trước trên avatar của mình, nút chuyển (chọn người nhận và nhập mật khẩu), chọn quyền xem kho (mọi người, bạn bè, chỉ mình tôi) như `VipStorePage`. Hết VIP thì nút đeo dẫn sang mua VIP.
- Trang hồ sơ người khác: nút "Kho khung" cạnh nút Kho VIP (`web/src/pages/profile/components/ProfileCard.tsx`), chỉ hiện khi `canViewAvatarFrameStore`; mở hộp thoại xem kho theo `PeerVipStoreDialog` (web và mobile).
- Thông báo nhận khung: hiển thị trong danh sách thông báo, chạm mở Kho khung.
- Ảnh động: chỉ chạy khi khung nằm trong màn hình; danh sách dài thì cân nhắc tắt animation để đỡ giật.

### 6. Thứ tự làm và kiểm thử

1. Migration và model, chạy local (`go run ./cmd/migrations up all`).
2. Module server và API admin. Test bằng `server/tests/api`: mua thiếu KEN, mua lặp, hai request mua cùng lúc (chỉ trừ KEN một lần), tặng hoặc chuyển cho chính mình, tặng cho người đã có khung, tặng hoặc chuyển cho người đang chặn mình, sai mật khẩu, chuyển khung đang đeo, hai lệnh chuyển cùng một khung cùng lúc, đeo khi hết VIP, khung biến mất khi VIP hết hạn và hiện lại khi gia hạn, xem Kho khung của người khác ở từng mức quyền (người lạ, bạn bè, chính chủ), `avatarFrameId` có trong `/auth/me` và hồ sơ người khác.
3. Shared và admin: thêm vài khung vào cửa hàng, mua bằng `test1`.
4. Web: mua, tặng, chuyển, đeo, xem khung trong Me, chụp màn để so.
5. Mobile: port theo web, chạy trên iOS simulator và Android.
6. Phát hành: migration, server, admin, web, rồi mobile. App cũ bỏ qua trường mới nên không vỡ.

### Rủi ro

- Ảnh khung nặng nhất gần 3 MB; một feed nhiều khung khác nhau sẽ tải chậm lần đầu.
- S3 Vietnix từng chặn IP khi upload song song; upload thêm khung thì đẩy 1 luồng.
- Danh mục có hai bản (`packages/shared` và `assets/avatar_frames`), thêm khung mới phải sửa cả hai và upload ảnh trước.
- Gỡ một khung khỏi cửa hàng không thu hồi khung user đã có; khung đó vẫn đeo được.
