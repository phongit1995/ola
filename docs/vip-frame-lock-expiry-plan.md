# Plan: Thẻ VIP và khung avatar khoá + có hạn

Ngày lập: 18/11/2026 · Trạng thái: **plan, chưa code**

Thêm 2 thuộc tính cho **thẻ VIP** (icon trong Kho VIP) và **khung avatar**:

- **Khoá** (`transferable = false`): không chuyển, không tặng lại, không giao dịch được.
- **Có hạn** (`expires_at`): tới hạn thì món đó coi như không còn. Đang đeo thì tự tháo.

Đây là nền cho các tính năng phát quà sau này (điểm danh, nhiệm vụ, sự kiện): phát đồ đẹp mà không bị nuôi nick gom về nick chính, và không làm mất giá đồ mua bằng KEN.

## 1. Chốt thiết kế

| Hạng mục | Chốt |
|---|---|
| Áp dụng cho | Thẻ VIP (`user_vip_icons`) và khung avatar (`user_avatar_frames`). **Không** đụng ngày VIP (`users.vip_end_time`) |
| Khoá | Cột `transferable`. Thay cho cách kiểm tra cứng `source == gift_code` hiện nay. Đồ từ mã quà tặng giữ nguyên là không chuyển được |
| Có hạn | Cột `expires_at`, NULL = vĩnh viễn. Đồ có hạn **luôn khoá** (server ép `transferable = false`). Hạn **tính từ lúc nhận** và vẫn chạy dù không đeo hay đã hết VIP |
| Giao diện | Món **không khoá, không hạn** hiển thị **y như bản hiện tại**. Chỉ món khoá/có hạn mới thêm nhãn |
| Hết hạn khi đang đeo | Không cần job. Lúc đeo, chép hạn vào `users.vip_used_expires_at` / `users.avatar_frame_expires_at`. Mọi chỗ đọc thẻ/khung đang đeo đi qua helper kiểm tra hạn, hết hạn thì trả `null`. Gặp món đã hết hạn thì server ghi null luôn (dọn lười) |
| Gỡ / đổi / hết hạn | Cột đang đeo và cột hạn đều về **null**. Không tự đeo lại món cũ |
| Món đã hết hạn | **Ẩn** khỏi kho của user và kho người khác xem. Dòng vẫn giữ trong DB để admin xem lịch sử. Admin thấy có nhãn "Đã hết hạn" |
| Dữ liệu trả về client | Danh sách bạn bè, phòng chat, bình luận, loa, game... **giữ nguyên trường**, chỉ là `vipUsed` / khung thành `null` khi hết hạn. Riêng **kho của chính mình** có thêm `transferable` và `expiresAt` cho mỗi món |
| App cũ | Không cần cập nhật. Server tự lọc nên hiển thị vẫn đúng. Bấm chuyển đồ khoá thì server trả `VIP_NOT_TRANSFERABLE` / `AVATAR_FRAME_NOT_TRANSFERABLE`, app cũ đã hiểu 2 mã lỗi này |
| Nơi phát đồ khoá/có hạn (đợt này) | **Admin tặng tay** cho user và **mã quà tặng**. Điểm danh / nhiệm vụ dùng lại sau. Vòng quay, đập trứng để sau |

Ngoài phạm vi: ngày VIP khoá (không Chuyển NSD được), user tự gia hạn bằng KEN, thông báo "sắp hết hạn" (để sau, mục 8), đồ có hạn tính theo giờ trong vòng quay/đập trứng, xoá đồ hết hạn khỏi DB (không xoá, giữ cho admin tra).

## 2. Hiện trạng trong code

- Thẻ VIP mỗi lần nhận là **một dòng riêng** `user_vip_icons` (`vip_icon_id`, `is_locked`, `source`). Đang đeo: `users.vip_used` (mã loại, chuỗi) + `users.vip_used_instance_id`. Đeo thẻ khác loại **trừ 1 ngày VIP** ([vip.service.go `Use`](../server/internal/modules/vip/vip.service.go)).
- `is_locked` là **khoá do user tự bật** để khỏi xoá/chuyển nhầm, tự mở lại được. Cột mới `transferable` là chuyện khác, UI phải đặt tên khác ("Không thể chuyển").
- Chặn chuyển thẻ từ mã quà: `item.Source == IconSourceGiftCode` trong `vip.Service.Transfer`. Chặn chuyển khung: `row.Source == models.AvatarFrameSourceGiftCode` trong `avatar-frame.Repository.Transfer`.
- Khung: mỗi user **chỉ 1 dòng cho mỗi khung** (unique `user_id, frame_id` khi chưa xoá). Đang đeo: `users.avatar_frame_id`. Hiển thị đi qua `User.ActiveAvatarFrameID(now)` ([user.model.go](../server/internal/models/user.model.go)), đòi còn VIP.
- Chỗ cấp thẻ: `vip.CreateIconTx` (mua shop, tặng, đập trứng, vòng quay) và `vip.GrantIconTx` (mã quà, admin). Chỗ cấp khung: `avatarframe.GrantFrameTx` (mã quà, admin) và `Repository.purchase` (mua, tặng).
- `users.vip_used` được đọc thẳng ở **27 file** (DTO user, cache user, bạn bè, phòng chat, nối từ, game, sút pen, loa, quà, bình luận truyện, admin user, auth). Danh sách ở mục 4.4.
- Client tự suy "chuyển được" từ `source` trong `packages/shared/src/lib/giftCode.ts` (`isVipIconTransferable`, khung tương tự).
- Cache user (`user.CacheService`, TTL 1 giờ) giữ `VipUsed`, `AvatarFrameID`.

## 3. Dữ liệu

Migration `20261119000001_vip_frame_lock_expiry`. Version phải lớn hơn mọi môi trường, kể cả prod. Không sửa migration đã chạy.

```sql
ALTER TABLE user_vip_icons
  ADD COLUMN transferable boolean NOT NULL DEFAULT true,
  ADD COLUMN expires_at timestamptz;
UPDATE user_vip_icons SET transferable = false WHERE source = 'gift_code';

ALTER TABLE user_avatar_frames
  ADD COLUMN transferable boolean NOT NULL DEFAULT true,
  ADD COLUMN expires_at timestamptz;
UPDATE user_avatar_frames SET transferable = false WHERE source = 'gift_code';

ALTER TABLE users
  ADD COLUMN vip_used_expires_at timestamptz,
  ADD COLUMN avatar_frame_expires_at timestamptz;
```

Down: drop 6 cột.

- `DEFAULT true` chỉ để điền dữ liệu cũ. Model Go **không** để tag `default:true` (bẫy GORM bỏ qua giá trị `false`, đã gặp ở module quà): khai `Transferable bool gorm:"not null"` và luôn set tường minh khi tạo.
- Không thêm index: các truy vấn kho đã lọc theo `user_id` có index sẵn, điều kiện hạn lọc trên vài chục dòng mỗi user.

## 4. Server

### 4.1 Model

`models.UserVipIcon` và `models.UserAvatarFrame` thêm:

```go
Transferable bool       `gorm:"not null"`
ExpiresAt    *time.Time
func (i *UserVipIcon) Expired(now time.Time) bool
```

`models.User` thêm `VipUsedExpiresAt`, `AvatarFrameExpiresAt *time.Time` và helper:

```go
func (u *User) ActiveVipUsed(now time.Time) *string
func (u *User) ActiveAvatarFrameID(now time.Time) *string
```

- `ActiveVipUsed`: trả `nil` khi `VipUsed` rỗng, hết VIP, hoặc `VipUsedExpiresAt` đã qua.
- `ActiveAvatarFrameID` (sửa hàm có sẵn): thêm điều kiện `AvatarFrameExpiresAt` chưa qua.

Hằng dùng chung (scope SQL) đặt ở `models`, ví dụ `NotExpiredScope(now)` = `expires_at IS NULL OR expires_at > ?`.

### 4.2 Tuỳ chọn khi cấp đồ

```go
type GrantOptions struct {
    Transferable bool
    ExpiresAt    *time.Time
}
var PermanentTransferable = GrantOptions{Transferable: true}
```

Đặt ở `internal/models` (hoặc `internal/constants`) để cả `vip` và `avatar-frame` dùng mà không import vòng. Hàm chuẩn hoá: có `ExpiresAt` thì ép `Transferable = false`.

### 4.3 Thẻ VIP (`internal/modules/vip`)

| Chỗ | Sửa |
|---|---|
| `CreateIconTx(tx, userID, typeID, source)` | thêm `opts GrantOptions`. Các chỗ gọi hiện có (mua shop, tặng, đập trứng, vòng quay) truyền `PermanentTransferable` để hành vi không đổi |
| `GrantIconTx` | thêm `opts`. Mã quà truyền `{Transferable:false, ExpiresAt: theo cấu hình}`; admin truyền theo form |
| `ListByUserPaged`, `CountByUser`, `FindInstance` cho user/peer | lọc `NotExpiredScope`. Bản admin có tham số `includeExpired` |
| `Use` | món hết hạn → `ErrVipIconExpired` (mã `VIP_ICON_EXPIRED`). Khi đeo, set `vip_used_expires_at = item.ExpiresAt`, kể cả nhánh cùng loại chỉ đổi `vip_used_instance_id`. Giữ nguyên quy tắc trừ 1 ngày VIP khi đổi sang thẻ khác loại, **áp dụng cho mọi thẻ kể cả thẻ có hạn và thẻ khoá** (mục 9) |
| `clearActive`, `clearActiveIfGone`, `Delete`, `BatchDelete`, `AdminDelete` | khi gỡ thì null cả `vip_used`, `vip_used_instance_id`, `vip_used_expires_at` |
| `Transfer` (thẻ) | thay `item.Source == IconSourceGiftCode` bằng `!item.Transferable`. Món hết hạn → `ErrVipIconExpired` |
| Giao dịch thẻ trong chat (`useTradingVip`) và tặng thẻ | dùng cùng kiểm tra `Transferable` |
| `toVipItem` / `VipItem` DTO | thêm `transferable bool`, `expiresAt *string` (RFC3339, `omitempty`) |
| `GetStore` của chính mình | nếu `VipUsedExpiresAt` đã qua thì ghi null 3 cột và `invalidate` (dọn lười). Lỗi chỉ log |

### 4.4 Thay mọi chỗ đọc `VipUsed`

Đổi `u.VipUsed` → `u.ActiveVipUsed(now)` khi trả ra ngoài. Câu SQL tự select cột `vip_used` thì đổi thành:

```sql
CASE WHEN u.vip_used_expires_at IS NULL OR u.vip_used_expires_at > now() THEN u.vip_used END AS vip_used
```

| File | Số chỗ |
|---|---|
| `modules/user/user.dto.go`, `user.service.go`, `user.public.go`, `user.repository.go` | 4 + 2 + 2 + 1 |
| `modules/user/user.cache.go` | 3 (thêm 2 trường hạn vào `cachedUser` + `toCachedUser` + `toModel`) |
| `modules/admin/user/user.service.go`, `user.dto.go` | 4 + 1 (admin xem cả giá trị gốc lẫn hạn) |
| `modules/relationships/relationship.service.go`, `relationship.dto.go` | 3 + 2 |
| `modules/room/room.message.go` (`senderFields`), `room.service.go`, `room.dto.go`, `room/wordchain/wordchain.messages.go` | 1 + 1 + 1 + 1 |
| `game/game.repository.go`, `game/settlement.repository.go` | 2 + 2 |
| `modules/pen/pen.service.go`, `pen.repository.go`, `pen.dto.go` | 2 + 1 + 1 |
| `modules/megaphone/megaphone.service.go`, `domain/megaphone/megaphone.dto.go` | 1 + 1 |
| `modules/gift/gift.service.go`, `gift.dto.go` | 1 + 1 |
| `modules/story/story.comment.go`, `story.dto.go` | 1 + 1 |
| `modules/auth/auth.service.go`, `auth.dto.go` | 1 + 1 |
| `modules/vip/vip.service.go` | 2 |

Chỗ là khai báo trường DTO thì giữ nguyên, chỉ đổi chỗ gán. Sau khi làm, chạy `grep -rn '\.VipUsed\b'` để chắc chỉ còn helper, `Use` và cache đọc trực tiếp.

Tin đã chụp lại (tin phòng chat, loa) gửi **trước** lúc hết hạn vẫn giữ thẻ cũ. Tin phòng chat chỉ giữ ngắn trong Redis nên chấp nhận được.

### 4.5 Khung avatar (`internal/modules/avatar-frame`)

**Cấp khung `GrantFrameTx(tx, userID, frameID, source, now, opts)`**: đổi từ `ON CONFLICT DO NOTHING` sang khoá dòng rồi gộp theo bảng:

| Đang có | Nhận thêm | Kết quả |
|---|---|---|
| Không có | bất kỳ | tạo dòng theo `opts` |
| Dòng **đã hết hạn** | bất kỳ | ghi đè dòng đó theo `opts` (hạn mới tính từ bây giờ), `source` mới |
| Vĩnh viễn | có hạn | không đổi gì, trả `granted=false` (người nhận đã có bản tốt hơn) |
| Vĩnh viễn, khoá | vĩnh viễn, chuyển được | thành chuyển được |
| Có hạn, còn hạn | có hạn | **cộng dồn**: `expires_at = expires_at + thời lượng mới` |
| Có hạn, còn hạn | vĩnh viễn | thành vĩnh viễn, `transferable` theo bản mới |

Mã quà và admin truyền **thời lượng** (số ngày), không truyền mốc cố định, để cộng dồn được. Nếu đang đeo khung đó thì cập nhật luôn `users.avatar_frame_expires_at`.

| Chỗ | Sửa |
|---|---|
| `OwnsFrameTx`, `OwnedFrameIDs` (cờ "đã có" ở shop), `ListOwned`, `CountOwned`, `GetStore` | lọc `NotExpiredScope` |
| Mua / tặng từ shop (`purchase`) | người nhận đang có bản **có hạn** thì **nâng thành vĩnh viễn** thay vì báo đã có; chỉ báo `alreadyOwned` khi đã có bản vĩnh viễn |
| `Equip` | món hết hạn → `ErrFrameExpired` (mã `AVATAR_FRAME_EXPIRED`); set `avatar_frame_expires_at = row.ExpiresAt` |
| `ClearEquipped`, `AdminRevoke` (khi đang đeo) | null cả `avatar_frame_id` và `avatar_frame_expires_at` |
| `Transfer` | thay kiểm tra `source == gift_code` bằng `!row.Transferable`; món hết hạn → `ErrFrameExpired`. Người nhận có dòng **đã hết hạn** của khung đó thì xoá mềm dòng đó trước khi chuyển, tránh đụng unique |
| `OwnedFrame` DTO | thêm `transferable`, `expiresAt` |
| `GetStore` của chính mình | dọn lười như thẻ VIP |

### 4.6 Mã quà tặng

`models.GiftCodeReward` thêm `ExpiresInDays int json:"expiresInDays,omitempty"` cho loại `vip_icon` và `avatar_frame` (0 = vĩnh viễn). Đồ từ mã quà **luôn khoá** như hiện nay.

- `gift-code.service.go` tính `ExpiresAt = now + ExpiresInDays` **lúc nhập mã**, không phải lúc tạo chiến dịch.
- Validate ở admin: `0 ≤ expiresInDays ≤ 3650`.
- `GiftCodeRedemption.Rewards` lưu nguyên phần thưởng (đã có), nên lịch sử thấy được hạn.
- Câu thông báo / màn kết quả: "Thẻ VIP Rồng Vàng (7 ngày)".

### 4.7 Lỗi mới

| Mã | HTTP | Khi nào |
|---|---|---|
| `VIP_ICON_EXPIRED` | 410 | đeo, chuyển, giao dịch thẻ đã hết hạn |
| `AVATAR_FRAME_EXPIRED` | 410 | đeo, chuyển khung đã hết hạn |

Mã cũ `VIP_NOT_TRANSFERABLE`, `AVATAR_FRAME_NOT_TRANSFERABLE` dùng chung cho mọi đồ khoá. Đổi message server thành chung chung ("item cannot be transferred").

### 4.8 Test Go

- `models`: `ActiveVipUsed`, `ActiveAvatarFrameID` với các tổ hợp còn/hết VIP × còn/hết hạn × NULL.
- `vip`: đeo món hết hạn bị chặn; đeo set đúng cột hạn; gỡ/xoá null đủ 3 cột; chuyển đồ khoá và đồ hết hạn bị chặn; danh sách ẩn đồ hết hạn; dọn lười.
- `avatar-frame`: đủ 6 dòng bảng gộp ở 4.5; mua bản vĩnh viễn khi đang có bản có hạn; chuyển khi người nhận có dòng hết hạn.
- `gift-code`: nhập mã ra đúng hạn và khoá.
- admin sửa: đặt hạn quá khứ bị chặn; có hạn thì ép khoá; sửa món đang đeo cập nhật cột hạn ở `users`; gia hạn món đã hết hạn làm món hiện lại.
- Test cũ có sẵn (`vip.repository_test.go`, `gift-code_utils_test.go`) vẫn xanh.

## 5. Admin

### 5.1 API

| Method | Path | Sửa |
|---|---|---|
| POST | `/admin/users/:id/vips` | body thêm `expiresInDays` (0–3650, 0 = vĩnh viễn) và `transferable` (bỏ qua khi có hạn) |
| GET | `/admin/users/:id/vips` | thêm query `includeExpired=true` (mặc định true ở admin), mỗi món thêm `transferable`, `expiresAt`, `expired` |
| POST | `/admin/users/:id/avatar-frames` | như thẻ VIP |
| GET | `/admin/users/:id/avatar-frames` | như thẻ VIP |
| POST/PATCH | `/admin/gift-codes` | reward thêm `expiresInDays` |
| PATCH | `/admin/users/:id/vips/:instanceId` | **sửa món đã tặng**: body `{ "expiresAt": "RFC3339" \| null, "transferable": bool }`. `expiresAt = null` là vĩnh viễn |
| PATCH | `/admin/users/:id/avatar-frames/:frameId` | như trên cho khung |
| GET | `/admin/users/:id` | thêm `vipUsedExpiresAt`, `avatarFrameExpiresAt` |

Quy tắc sửa:

- `expiresAt` phải ở **tương lai** (muốn thu hồi thì dùng nút Thu hồi có sẵn). Có `expiresAt` thì server ép `transferable = false`; chỉ bật `transferable` được khi vĩnh viễn.
- Sửa được cả món **đã hết hạn** (gia hạn lại, đền bù). Món hiện lại trong kho user.
- Món đang đeo thì cập nhật luôn `users.vip_used_expires_at` / `users.avatar_frame_expires_at` trong cùng transaction, rồi xoá cache user.
- Khung: sửa thẳng dòng đó, không qua bảng gộp ở 4.5.
- Service: `vip.Service.AdminUpdateIcon`, `avatarframe.Service.AdminUpdateFrame`; ghi `admin_audit_logs` cả giá trị cũ lẫn mới.

Audit log ghi đủ `expiresInDays`, `transferable` khi admin tặng.

### 5.2 Màn hình

- **Người dùng → chi tiết → Thẻ VIP** ([UserVipIconsModal.tsx](../admin/src/pages/users/UserVipIconsModal.tsx)):
  - Form tặng thêm ô số "Hạn (ngày)", trống = vĩnh viễn, và checkbox "Cho phép chuyển". Checkbox tự tắt khi có hạn.
  - Bảng thêm cột **Hạn** ("Vĩnh viễn" / "25/11/2026 20:00" / tag đỏ "Đã hết hạn") và cột **Chuyển được** (✓ / "Khoá").
  - Lọc "Ẩn món đã hết hạn".
- **Người dùng → chi tiết → Khung avatar** ([UserAvatarFramesModal.tsx](../admin/src/pages/users/UserAvatarFramesModal.tsx)): giống hệt. Khi tặng khung user đã có, hiện kết quả theo bảng gộp ("Đã cộng thêm 7 ngày", "User đã có bản vĩnh viễn").
- **Sửa món đã tặng** (cả 2 modal): mỗi dòng có nút **Sửa** mở form nhỏ: chọn "Vĩnh viễn" hoặc chọn ngày giờ hết hạn (có nút nhanh +1 / +7 / +30 ngày tính từ hạn hiện tại), ô "Cho phép chuyển" (tự tắt và mờ khi có hạn). Món đã hết hạn cũng có nút Sửa để gia hạn lại.
- **Chi tiết user**: dòng "Thẻ đang dùng" / "Khung đang đeo" hiện thêm "hết hạn 25/11 20:00" nếu có.
- **Mã quà tặng** ([GiftCodeRewardsField.tsx](../admin/src/pages/gift-codes/GiftCodeRewardsField.tsx)):
  - Phần thưởng loại thẻ VIP / khung có thêm ô "Hạn (ngày)".
  - `GiftCodeBadges` và `GiftCodeSuccessPreview` hiện "(7 ngày)".
- Types: `admin/src/types/user.ts`, `admin/src/types/avatarFrame.ts`, `admin/src/pages/gift-codes/types.ts`.

## 6. Client (web + mobile)

### 6.1 Shared `packages/shared`

- `types/api/vip.type.ts` (`VipIconInstance`) và `types/api/avatarFrame.type.ts` (`OwnedAvatarFrame`) thêm `transferable?: boolean`, `expiresAt?: string | null`.
- `lib/giftCode.ts`: `isVipIconTransferable` / hàm khung đổi thành `item.transferable ?? item.source !== GIFT_CODE`. Cân nhắc chuyển sang `lib/vip.ts` / `lib/avatarFrame.ts` vì không còn riêng mã quà.
- `lib/itemExpiry.ts` (mới):
  - `isItemExpired(expiresAt, now)`.
  - `itemExpiryLabel(t, expiresAt, now)` → "Còn 3 ngày" / "Còn 5 giờ" / "Còn 20 phút".
  - `isExpiringSoon(expiresAt, now)` (< 24 giờ) để tô đỏ.
- `stores/vip/useVipStore.ts`, `stores/avatar-frame/useAvatarFrameCollection.ts`:
  - Lọc món đã hết hạn theo giờ máy, để kho đang mở mà tới hạn thì món tự biến mất.
  - Bắt lỗi `*_EXPIRED` thì tải lại kho.
- `stores/vip/useTradingVip.ts`: dùng helper mới, bỏ qua món khoá/có hạn.
- i18n vi/en:
  - `itemExpiry.days/hours/minutes`;
  - `item.notTransferable` = "Không thể chuyển", thay 2 câu đang nhắc "mã quà tặng";
  - `vip.errors.iconExpired`, `avatarFrame.errors.expired`;
  - `giftCode.rewardWithDays`.

### 6.2 Hiển thị trong Kho VIP / Kho khung (user chốt 18/11/2026)

Mỗi món hiện rõ **có khoá không** và **còn bao lâu**. Món **đã hết hạn thì không hiện** (server lọc, client lọc thêm theo giờ máy để kho đang mở mà tới hạn thì món tự biến mất).

```
┌──────────────────────────────────────────────┐
│ [icon] Rồng Vàng            ĐANG DÙNG        │
│        Mua shop · 12/10/2026                 │
├──────────────────────────────────────────────┤
│ [icon] Phượng Hoàng                          │
│        🔒 Không thể chuyển · ⏱ Còn 3 ngày    │
├──────────────────────────────────────────────┤
│ [icon] Kỳ Lân                                │
│        🔒 Không thể chuyển · ⏱ Còn 5 giờ     │  ← chữ hạn màu đỏ khi < 24 giờ
├──────────────────────────────────────────────┤
│ [icon] Hổ Trắng                              │
│        🔒 Không thể chuyển                    │  ← vĩnh viễn nhưng khoá (mã quà, admin)
└──────────────────────────────────────────────┘
```

**Kho khung** đang là lưới 3 cột ([AvatarFrameStorePage.tsx](../web/src/pages/avatar-frame/AvatarFrameStorePage.tsx)), nên nhãn gắn lên ô:

```
┌─────────┐ ┌─────────┐ ┌─────────┐
│🔒       │ │         │ │🔒       │
│ [khung] │ │ [khung] │ │ [khung] │
│ĐANG ĐEO │ │         │ │         │
│ ⏱ 3 ngày│ │         │ │ ⏱ 5 giờ │  ← đỏ khi < 24 giờ
└─────────┘ └─────────┘ └─────────┘
 Hoa Anh Đào  Ngọc Bích   Lửa Thiêng
```

- Ổ khoá nhỏ ở góc trên trái = không thể chuyển; chip "⏱ 3 ngày" ở đáy ô = có hạn.
- Bấm vào ô (mở chi tiết khung như hiện nay) thì hiện đủ "🔒 Không thể chuyển · Hết hạn 20:00 25/11/2026"; nút Chuyển mờ.
- Khung đang đeo mà có hạn: dòng "Đang đeo" phía dưới lưới cũng hiện "· còn 3 ngày".

Chung cho cả Kho VIP và Kho khung:

- **Nhãn khoá** "🔒 Không thể chuyển": hiện khi `transferable = false`.
- **Nhãn hạn** "⏱ Còn X ngày / X giờ / X phút": hiện khi có `expiresAt`. Bấm hoặc giữ vào nhãn thì hiện giờ chính xác "Hết hạn 20:00 25/11/2026". Còn dưới 24 giờ thì tô đỏ.
- Đồ **vĩnh viễn và chuyển được**: **giữ nguyên giao diện bản hiện tại**, không thêm nhãn, không đổi bố cục, không đổi thứ tự hiển thị so với trước.
- Nút **Chuyển / Tặng / Giao dịch** ẩn hoặc mờ với món khoá. Bấm vào thì hiện toast "Vật phẩm này không thể chuyển".
- Thứ tự: món đang dùng/đang đeo lên đầu (như hiện nay), rồi món **sắp hết hạn trước**, rồi phần còn lại theo ngày nhận.
- Kho người khác xem (Peer dialog): hiện cùng 2 nhãn để người xem biết món đó là đồ có hạn.

### 6.3 Web

| Màn | Sửa |
|---|---|
| [VipStorePage.tsx](../web/src/pages/vip/VipStorePage.tsx) | nhãn khoá + nhãn hạn như 6.2 (nhãn khoá đã có, đổi sang helper mới); nút Chuyển/Tặng mờ khi khoá; sắp xếp sắp hết hạn trước |
| [AvatarFrameStorePage.tsx](../web/src/pages/avatar-frame/AvatarFrameStorePage.tsx) | như trên cho khung; tab cửa hàng: khung đang có bản có hạn hiện "Đang có · còn 3 ngày" và vẫn cho **Mua vĩnh viễn** |
| [PeerVipStoreDialog.tsx](../web/src/pages/profile/components/PeerVipStoreDialog.tsx), [PeerAvatarFrameStoreDialog.tsx](../web/src/pages/profile/components/PeerAvatarFrameStoreDialog.tsx) | hiện nhãn hạn (người khác cũng thấy món đó có hạn) |
| [TradingVipDialog.tsx](../web/src/pages/chat/components/TradingVipDialog.tsx) | không liệt kê món khoá/có hạn |
| Kết quả nhập mã quà | hiện "(7 ngày)" theo `giftCodeRewardText` |

### 6.4 Mobile

Cùng nội dung 6.2 và 6.3 ở `mobile/src/screens/vip/VipStoreScreen.tsx` + `components/VipRow.tsx`, `mobile/src/screens/avatar-frame/AvatarFrameStoreScreen.tsx` + `useAvatarFrameStoreScreen.ts`, `mobile/src/screens/profile/components/PeerVipStoreDialog.tsx`, `PeerAvatarFrameStoreDialog.tsx`, `mobile/src/screens/chat/components/TradingVipDialog.tsx`. Màu theo token `ola-*` / `useThemeColors`, không hardcode hex.

## 7. Thứ tự làm

| Bước | Việc | Ước lượng |
|---|---|---|
| 1 | Migration + model + helper + `GrantOptions` + test model | 0,25 ngày |
| 2 | Thẻ VIP: cấp, đeo, gỡ, chuyển, danh sách, dọn lười + test | 0,5 ngày |
| 3 | Đổi 27 file đọc `VipUsed` sang helper / SQL `CASE` + cache user | 0,5 ngày |
| 4 | Khung: bảng gộp, đeo, chuyển, mua nâng cấp, danh sách + test | 0,5 ngày |
| 5 | Mã quà `expiresInDays` + admin API | 0,25 ngày |
| 6 | Admin UI: 2 modal + chi tiết user + form mã quà | 0,5 ngày |
| 6b | Admin sửa món đã tặng: 2 API PATCH + form Sửa + test | 0,5 ngày |
| 7 | Shared + web + mobile | 0,5 ngày |
| 8 | E2E local: tặng thẻ/khung 1 ngày, sửa `expires_at` trong DB về quá khứ, kiểm tra hồ sơ/bạn bè/phòng chat/game ẩn ngay, đeo/chuyển bị chặn, app cũ (bản đang có trên máy) không lỗi | 0,5 ngày |

Tổng khoảng **4 ngày**.

**Deploy**: migration → api + chat + game (game đọc `vip_used`) → admin → web → app. Server lên trước app vẫn đúng vì chỉ thêm trường.

## 8. Để sau: thông báo hết hạn (user chốt 18/11/2026 chưa làm đợt này)

Job nền trong API theo mẫu [gift-code.cleanup.go](../server/internal/modules/gift-code/gift-code.cleanup.go): khoá Redis `SetNX`, chạy mỗi giờ.

- Món còn **dưới 24 giờ** và chưa báo: tạo `AppNotification` hệ thống "Khung *Hoa Anh Đào* sẽ hết hạn lúc 20:00 ngày 25/11". Đánh dấu đã báo bằng Redis set có TTL, hoặc cột `expiry_notified_at`.
- Món **vừa hết hạn** mà đang đeo: thông báo "đã hết hạn, đã tháo khỏi avatar", bấm vào mở kho.

Job này fail chỉ mất thông báo; hiển thị vẫn đúng nhờ helper. Ước lượng 0,5 ngày.

## 9. Đã chốt (18/11/2026)

Áp dụng giống nhau cho **cả thẻ VIP lẫn khung avatar**:

- Đồ **có hạn ngày** mặc định **khoá** (không chuyển, không tặng lại, không giao dịch). Đồ admin tặng tay cũng mặc định khoá; ô "Cho phép chuyển" mặc định tắt, chỉ bật được khi không đặt hạn. Đồ từ mã quà luôn khoá như hiện nay.
- Kho VIP và Kho khung hiện nhãn khoá + thời gian còn lại cho từng món (mục 6.2).
- Món **hết hạn không hiện** trong Kho VIP, Kho khung của user và khi người khác xem kho. Đang đeo/đang dùng thì tự tháo. Chỉ admin thấy, kèm nhãn "Đã hết hạn".
- **Đeo thẻ VIP có hạn vẫn trừ 1 ngày VIP** như thẻ thường: đổi sang thẻ khác loại với thẻ đang dùng thì trừ 1 ngày, cùng loại thì không trừ (giữ nguyên logic `Use` hiện tại, không thêm ngoại lệ cho thẻ có hạn hay thẻ khoá). Thẻ có hạn tự tháo khi hết hạn **không hoàn** ngày đã trừ. Khung không đổi gì: đeo khung vẫn không trừ ngày, chỉ cần còn VIP.
  - Màn Kho VIP: hộp xác nhận có sẵn `vip.confirmUse` ("Tốn 1 ngày VIP để kích hoạt VIP {{name}}...") hiện cả với thẻ có hạn; thẻ có hạn thêm dòng "Thẻ này hết hạn sau 3 ngày" (key mới `vip.confirmUseExpiry`).

- Hạn **tính từ lúc nhận**, không phải lúc đeo lần đầu; vẫn chạy khi đang không đeo hoặc đã hết VIP.
- Món không khoá, không hạn: **giữ nguyên giao diện** bản hiện tại.
- Admin **sửa được** món đã tặng: đổi hạn, đặt vĩnh viễn, bật/tắt cho chuyển, gia hạn món đã hết hạn (mục 5.1, 5.2).
- Thông báo sắp hết hạn / đã hết hạn: **để sau** (mục 8).
- **Không xoá** món hết hạn khỏi DB.
- App cũ: món khoá vẫn hiện nút Chuyển, bấm thì server báo lỗi "không thể chuyển". Chấp nhận, không bắt cập nhật app.
