# Plan: Điểm danh hằng ngày

Ngày lập: 19/11/2026 · Trạng thái: **plan, chưa code**

Mỗi ngày user vào bấm **Điểm danh** một lần để đi tiếp 1 ô trên lịch **28 ô** và nhận quà của ô đó. Một ô có thể có nhiều quà, có ô cần VIP, có ô phải làm nhiệm vụ trong ngày (vd đăng 1 bài Me), có ô không có quà. Admin chọn ô nào là **quà to**, và ô nào chỉ nhận được khi chưa lỡ ngày nào (chuyên cần). Admin tự cấu hình hết, không cần deploy.

Quà vé loa dựa trên tính năng **Vé loa** làm trước, plan ở [megaphone-feature-plan.md mục 15](megaphone-feature-plan.md#15-vé-loa-plan-19112026-chưa-code) (xem mục 7).

Dùng lại nền thẻ VIP và khung avatar **khoá + có hạn** ([vip-frame-lock-expiry-plan.md](vip-frame-lock-expiry-plan.md)) để phát đồ đẹp mà không bị nuôi nick gom về nick chính.

## 1. Luật đã chốt

| Hạng mục | Chốt |
|---|---|
| Chu kỳ | **28 ô cố định** (4 tuần, lưới 7 cột × 4 hàng), **riêng cho từng user**, không theo tháng dương lịch nên tháng 28 hay 31 ngày không ảnh hưởng. Ô 1 bắt đầu từ lần điểm danh đầu tiên, xong ô 28 thì sang chu kỳ mới từ ô 1 |
| Mỗi ngày | Điểm danh **1 lần** theo ngày giờ VN (0h), mỗi lần đi tiếp 1 ô |
| Lỡ ngày | Không vào thì **đứng yên ở ô cũ**, hôm sau điểm danh tiếp bình thường. Các ô thường vẫn nhận quà; chỉ mất quà các ô **chuyên cần** còn lại của chu kỳ đó |
| Quà chỉ nhận trong ngày | Quà của ô nào chỉ nhận được **trong đúng ngày điểm danh ô đó**. Qua 0h chưa nhận là mất, ngày vẫn được tính. Không có quà treo, không nhận lại ngày cũ |
| Nhiều quà một ô | Mỗi ô là **danh sách quà**, vd "khung 15 ngày + 2 ngày VIP + 3 vé loa". Nhận là nhận cả danh sách |
| Quà to | Admin bật **quà to** cho ô bất kỳ (mặc định 7, 14, 21, 28): ô vẽ to và nổi bật trên lịch để user biết ngày nào có quà lớn |
| Chuyên cần | Admin bật **chuyên cần** cho ô bất kỳ (mặc định ô 28): chỉ nhận được khi từ đầu chu kỳ tới ô đó chưa lỡ ngày nào. Đã lỡ thì các ô chuyên cần phía sau xám luôn, tới nơi vẫn điểm danh để đi tiếp |
| Ô cần VIP | VIP xét **lúc bấm điểm danh** (`vip_end_time > now`). Không có VIP thì vẫn điểm danh, vẫn tiến ô, vẫn giữ chuyên cần, nhưng **mất quà ô đó**. Không có nút mua VIP để nhận, hôm sau có VIP cũng không nhận lại |
| Ô có nhiệm vụ | Phải làm nhiệm vụ **trong ngày hôm đó** (làm trước hay sau khi điểm danh đều được) rồi bấm **Nhận** trước 0h. Quá giờ thì mất quà, ngày vẫn tính |
| Ô không có quà | Được. Vẫn phải điểm danh để tiến ô và giữ chuyên cần |
| Chu kỳ sau | Giữ nguyên bộ quà 28 ô (admin sửa thì áp dụng từ hôm sau cho mọi người) |
| Loại quà | Ngày VIP · thẻ VIP · khung avatar · vé loa · điểm hoạt động (chỉ khi đã có Nhiệm vụ). Thẻ VIP và khung **luôn khoá**, có hạn hoặc vĩnh viễn (hạn để trống) |
| Nơi vào | **Popup** khi mở app lần đầu trong ngày mà chưa điểm danh + ô **Điểm danh** trong lưới tab Cá nhân (chấm đỏ khi chưa điểm danh hoặc còn quà nhiệm vụ chưa nhận) |
| Nền tảng | Web + Android + iOS, bật/tắt theo nền tảng bằng `app_settings` như topup |

Ngoài phạm vi (để sau): điểm danh bù, push nhắc chưa điểm danh, thưởng ×2 cho VIP, nhiều bộ quà xoay vòng theo chu kỳ, nhiệm vụ gửi tin nhắn 1-1 / phòng (tin nhắn nằm ở ScyllaDB, phải chờ bộ đếm `Tracker` của [plan Nhiệm vụ](mission-feature-plan.md)), vé loa từ vòng quay / đập trứng.

## 2. Ví dụ lịch

```
┌ Điểm danh                          Còn 05:12:30 ┐
│ Chu kỳ 2 · Ngày 9/28 · Chưa lỡ ngày nào          │
│                                                  │
│  ✓1    ✓2    ✓3🎁  ✓4    ✓5📢  ✓6   ✗[ 7 👑 ]     │
│  ✓8    (9)   10🎁  11    12📢  13    [ 14 📝 ]    │
│  15    16    17🎁  18    19📢  20    [ 21 👑 ]    │
│  22    23    24🎁  25    26📢  27    [ 28 🏆 ]    │
│                                                  │
│               [ Điểm danh ngày 9 ]               │
└──────────────────────────────────────────────────┘
✓ đã nhận · ✗ bỏ lỡ quà · [ ] quà to
👑 cần VIP · 📝 có nhiệm vụ · 🏆 chuyên cần · 📢 vé loa
```

## 3. Trạng thái một ô

Khi bấm **Điểm danh** (một transaction):

1. Đã có dòng của hôm nay → trả trạng thái hiện tại, không làm gì (bấm 2 lần / 2 máy không cộng 2 ô).
2. Tính ô tiếp theo và lỡ ngày, chụp lại cấu hình ô đó vào dòng điểm danh.
3. Ô không có quà → `none`.
4. Ô chuyên cần mà chu kỳ đã lỡ ngày → quà **mất** (`missed`).
5. Ô cần VIP mà không có VIP → quà **mất** (`missed`).
6. Ô có nhiệm vụ: nhiệm vụ đã làm hôm nay thì phát quà luôn (`claimed`), chưa thì `pending`.
7. Còn lại → phát quà luôn (`claimed`).

Khi bấm **Nhận** (chỉ cho dòng `pending` của **hôm nay**): kiểm tra nhiệm vụ đã làm hôm nay, đúng thì phát quà → `claimed`. Dòng `pending` của ngày cũ hiển thị là `missed`, không cần job dọn.

Trạng thái client vẽ cho 28 ô của chu kỳ hiện tại:

| Status | Nghĩa |
|---|---|
| `claimed` | đã nhận quà |
| `none` | đã điểm danh, ô không có quà |
| `missed` | đã điểm danh nhưng mất quà (thiếu VIP, quá ngày chưa làm nhiệm vụ, ô chuyên cần đã lỡ ngày) |
| `pending` | hôm nay, chờ làm nhiệm vụ rồi bấm Nhận |
| `today` | hôm nay chưa điểm danh, đây là ô sẽ điểm danh |
| `upcoming` | chưa tới |
| `lost` | ô chuyên cần chưa tới nhưng chu kỳ đã lỡ ngày, chắc chắn không nhận được |

## 4. Dữ liệu

Migration mới `<version>_add_daily_checkin` (sau migration vé loa). Version phải lớn hơn mọi môi trường lúc code (mới nhất hiện là `20261119000001_vip_frame_lock_expiry`), không sửa migration đã chạy.

```sql
CREATE TABLE checkin_slots (
  slot smallint PRIMARY KEY CHECK (slot BETWEEN 1 AND 28),
  rewards jsonb NOT NULL DEFAULT '[]',       -- danh sách quà, xem bảng dưới
  featured boolean NOT NULL,                 -- quà to
  require_streak boolean NOT NULL,           -- chuyên cần
  require_vip boolean NOT NULL,
  task varchar(32),                          -- NULL = không có nhiệm vụ
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE user_checkins (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  day date NOT NULL,                         -- ngày theo giờ VN
  cycle int NOT NULL,                        -- chu kỳ thứ mấy, từ 1
  slot smallint NOT NULL,
  streak_broken boolean NOT NULL,            -- chu kỳ này đã lỡ ngày tính tới ô này
  reward_status varchar(12) NOT NULL,        -- claimed | pending | missed | none
  reward_snapshot jsonb NOT NULL,            -- cấu hình ô lúc điểm danh
  claimed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX uq_user_checkins_day ON user_checkins (user_id, day);
CREATE UNIQUE INDEX uq_user_checkins_slot ON user_checkins (user_id, cycle, slot);
```

Một phần tử trong `rewards`:

| `type` | Trường | Ví dụ |
|---|---|---|
| `vip_days` | `amount` = số ngày VIP | `{"type":"vip_days","amount":2}` |
| `vip_icon` | `ref` = mã loại thẻ, `durationDays` (0 = vĩnh viễn, vẫn khoá) | `{"type":"vip_icon","ref":"12","durationDays":7}` |
| `avatar_frame` | `ref` = mã khung, `durationDays` (0 = vĩnh viễn, vẫn khoá) | `{"type":"avatar_frame","ref":"004","durationDays":15}` |
| `megaphone_ticket` | `amount` = số vé, `durationDays` = hạn vé (0 = không hạn) | `{"type":"megaphone_ticket","amount":3,"durationDays":7}` |
| `activity_points` | `amount` = số điểm (chỉ khi đã có Nhiệm vụ) | `{"type":"activity_points","amount":10}` |

- Migration seed sẵn 28 dòng `checkin_slots` với `rewards = '[]'`; ô 7/14/21/28 `featured = true`, ô 28 `require_streak = true`; admin cấu hình quà sau.
- **Ô tiếp theo** lấy từ dòng mới nhất của user: `slot < 28` → `(cycle, slot + 1)`; `slot = 28` → `(cycle + 1, 1)`; chưa có dòng → `(1, 1)`.
- **Lỡ ngày**: `streak_broken = prev.streak_broken OR day - prev.day > 1`, chỉ xét trong cùng chu kỳ. Ô 1 của chu kỳ mới luôn `false` (nghỉ giữa 2 chu kỳ không tính là lỡ).
- `reward_snapshot` giữ quà đúng như lúc điểm danh: admin sửa ô giữa ngày không ảnh hưởng người đã điểm danh hôm đó, và bấm Nhận nhiệm vụ vẫn phát đúng quà cũ.
- `user_checkins` cũng là lịch sử để admin tra và làm thống kê.
- Bẫy GORM `default:true` (đã gặp ở module quà): cột boolean không để default ở model, luôn set tường minh.

## 5. Nhiệm vụ trong ngày

Không cần bộ đếm. Lúc điểm danh / bấm Nhận, server chạy 1 câu `EXISTS` "hôm nay (từ 0h VN) user đã làm chưa" trên bảng có sẵn ở Postgres:

| Mã | Ý nghĩa | Kiểm tra |
|---|---|---|
| `me_post` | Đăng 1 bài Me | `me`: `author_id`, `clan_id IS NULL`, chưa xoá, `created_at >= 0h` |
| `me_comment` | Bình luận bài Me | `me_comments.author_id` |
| `me_react` | Thả cảm xúc bài Me | `me_reactions.user_id` |
| `moment_post` | Đăng 1 khoảnh khắc | `moments.author_id`, chưa xoá |
| `moment_comment` | Bình luận khoảnh khắc | `moment_comments.author_id` |
| `story_comment` | Bình luận truyện | `story_comments.author_id` |
| `send_gift` | Tặng 1 quà | `gift_transactions.sender_id` |
| `send_megaphone` | Phát 1 loa (cả loa dùng vé) | `megaphones.sender_id`, `type = 'message'` |
| `play_game` | Chơi xong 1 ván game online | `game_match_players` join `game_matches` đã kết thúc trong ngày (ván tập với máy chạy ở client nên tự không tính) |

- Thêm nhiệm vụ mới = thêm 1 dòng registry trong code (mã + câu query) + i18n tên. Admin thấy ngay trong dropdown.
- Kiểm tra index `(author_id/user_id/sender_id, created_at)` của từng bảng, thiếu thì thêm trong cùng migration. Query chỉ chạy lúc user bấm, 1 dòng `LIMIT 1`, rất nhẹ.
- Lách được bằng cách đăng rồi xoá sau khi nhận. Chấp nhận, vì quà có hạn và khoá.
- Gửi tin nhắn 1-1 / phòng chưa làm được (ScyllaDB không đếm theo ngày được), chờ `Tracker` của plan Nhiệm vụ.

## 6. Server điểm danh

### 6.1 Module `internal/modules/checkin`

- `checkin.constants.go`: loại quà, status, registry nhiệm vụ, mã lỗi, key setting.
- `checkin.repository.go`: đọc/sửa `checkin_slots`, đọc dòng mới nhất, insert, cập nhật claim, query nhiệm vụ.
- `checkin.service.go`: `Status`, `CheckIn`, `Claim`, phát quà.
- `checkin.controller.go`, `checkin.router.go`, `checkin.dig.go`, `checkin.dto.go`.

### 6.2 Phát quà (trong transaction điểm danh / nhận)

Transaction mở bằng `ledger.LockUser` để 2 request cùng lúc của một user chạy lần lượt. Unique `(user_id, day)` là chốt chặn cuối. Mọi quà trong danh sách phát trong **cùng** transaction: một món lỗi thì cả ô không phát, user bấm lại được.

| Loại | Gọi |
|---|---|
| `vip_days` | `vip.GrantDaysTx(tx, userID, n, "checkin", "Điểm danh ngày X")` |
| `vip_icon` | `vip.GrantIconTx(tx, userID, typeID, IconSourceCheckin, "checkin", grant)` với `grant = models.LockedGrantForDays(d)`, hoặc `models.PermanentLockedGrant` khi `durationDays = 0` |
| `avatar_frame` | `avatarframe.GrantFrameTx(tx, userID, frameID, AvatarFrameSourceCheckin, now, grant)`, `grant` như trên. Đã có bản có hạn thì cộng dồn hạn; đã có bản vĩnh viễn thì không thêm gì, các quà khác vẫn phát và client báo "đã có khung vĩnh viễn" |
| `megaphone_ticket` | `megaphone.GrantTicketsTx(tx, userID, n, "checkin", nil, durationDays)` (vé loa đã có từ trước, mục 7) |
| `activity_points` | cộng điểm hoạt động ngày của Nhiệm vụ, chỉ bật khi Nhiệm vụ đã có |

- Sau commit: invalidate cache VIP + user + kho khung, giống vòng quay.
- Thêm source `checkin`: `IconSourceCheckin` ([vip.repository.go](../server/internal/modules/vip/vip.repository.go)), `AvatarFrameSourceCheckin` ([avatar_frame.model.go](../server/internal/models/avatar_frame.model.go)), `packages/shared/src/lib/vipHistory.ts` để lịch sử VIP hiện "Điểm danh".
- Khi đã có Nhiệm vụ: điểm danh cũng `Track(open_app)`.

### 6.3 API

| Method | Path | Mô tả |
|---|---|---|
| GET | `/checkin` | `{enabled, today, checkedInToday, cycle, slot, streakBroken, endsAt, slots[28] {slot, rewards[], featured, requireStreak, requireVip, task, status}}`. `endsAt` = 0h VN kế tiếp để client đếm ngược |
| POST | `/checkin` | điểm danh hôm nay, trả trạng thái mới + `rewards` vừa nhận (hoặc lý do mất: `vip_required`, `streak_broken`, hoặc `task_pending`) |
| POST | `/checkin/claim` | nhận quà nhiệm vụ của hôm nay |

- Mã lỗi: `CHECKIN_DISABLED`, `CHECKIN_TASK_NOT_DONE`, `CHECKIN_NOTHING_TO_CLAIM`.
- Rate limit policy cho 2 POST (vd 20/phút).
- Ngày luôn tính **phía server** theo giờ VN (`utils.VietnamPeriodStart(now, PeriodDay)`), không tin giờ máy client.

### 6.4 Cài đặt `app_settings` key `checkin`

```json
{
  "platforms": { "web": true, "android": true, "ios": true },
  "popup": true
}
```

Nền tảng không bật → `GET /checkin` trả `enabled:false`, client ẩn ô và popup. App cũ không gọi API này nên không ảnh hưởng.

## 7. Vé loa

Vé loa **làm trước** điểm danh, plan riêng ở [megaphone-feature-plan.md mục 15](megaphone-feature-plan.md#15-vé-loa-plan-19112026-chưa-code). Điểm danh chỉ dùng lại `megaphone.GrantTicketsTx(tx, userID, n, "checkin", nil, durationDays)` để phát vé (source `checkin`), mọi luật hạn vé, thứ tự dùng, ô tick, giới hạn đã chốt ở đó.

## 8. Admin điểm danh

Menu mới **Điểm danh**, 1 trang 3 tab:

| Tab | Nội dung |
|---|---|
| Lịch 28 ô | Lưới 7 × 4 giống app. Sửa từng ô bằng modal: **danh sách quà** (thêm/xoá dòng: loại, chọn thẻ VIP / khung bằng bộ chọn của `GrantVipModal` / `GrantAvatarFrameModal`, số ngày, hạn, số vé), công tắc **Quà to**, **Chuyên cần**, **Cần VIP**, chọn **nhiệm vụ** |
| Cài đặt | form `checkin` (6.4) |
| Thống kê | theo ngày: số người điểm danh, phân bố theo ô, số quà đã phát theo loại, **số quà mất vì thiếu VIP** (đo hiệu quả kéo VIP), số quà mất vì không làm nhiệm vụ, số người đạt chuyên cần, số vé loa phát ra / đã dùng / hết hạn |

API admin `/admin/checkin/slots`, `/admin/checkin/stats`, ghi `admin_audit_logs` như các module khác. Chi tiết user trong admin có thêm lịch sử điểm danh. Lưu ô thì validate: mã thẻ VIP / khung tồn tại, số ngày > 0 với `vip_days`, số vé > 0, hạn vé ≥ 0 (0 = không hạn).

## 9. Client điểm danh

### 9.1 Shared `packages/shared`

- `types/checkin.ts`, `services/checkin.service.ts`.
- `constants/checkin.ts`: `CHECKIN_REWARD_TYPE`, `CHECKIN_SLOT_STATUS`, `CHECKIN_TASK`, `CHECKIN_SLOT_COUNT = 28` (map `as const`).
- `stores/checkin` (zustand): `data`, `load()`, `checkIn()`, `claim()`, `shouldShowPopup()` (chưa điểm danh + chưa hiện popup hôm nay, nhớ theo ngày VN ở storage máy). Qua 0h VN khi đang mở màn → tự `load()` lại. Nhận vé loa xong → `load()` lại config loa.
- `lib/checkinTask.ts`: nhiệm vụ → tiêu đề i18n + đích nút **Đi làm** dạng trừu tượng (`meComposer`, `momentCreate`, `gameTab`, `storyTab`, `megaphone`...), mỗi nền tảng tự map sang điều hướng.
- i18n vi/en: `checkin.*`.

### 9.2 Màn hình (web + mobile)

- **Popup**: mở app / quay lại foreground, nếu `shouldShowPopup()` thì hiện lưới 28 ô (7 × 4) + nút **Điểm danh ngày X**. Bấm xong hiện kết quả ngay trong popup: danh sách quà vừa nhận, hoặc "Bỏ lỡ quà · cần VIP", hoặc "Làm nhiệm vụ: Đăng 1 bài Me" + nút **Đi làm**.
- **Màn Điểm danh** (web overlay `checkin`, mobile screen `Checkin`): cùng lưới, đếm ngược tới 0h, dòng "Chu kỳ 2 · Ngày 9/28 · Chưa lỡ ngày nào / Đã lỡ ngày, mất quà chuyên cần", nút Nhận khi có `pending`. Bấm vào ô xem đủ danh sách quà của ô đó.
- Ô **quà to** vẽ to hơn, viền nổi, hiện ảnh món đẹp nhất trong danh sách.
- Ô **Điểm danh** trong `PERSONAL_ITEMS` ([web](../web/src/pages/apps/constants.ts), [mobile](../mobile/src/screens/apps/constants.ts)), chấm đỏ khi chưa điểm danh hoặc có `pending`.
- Thẻ VIP / khung hiện ảnh món + "3 ngày" và dấu khoá, dùng lại `ItemGrantMarks` vừa làm.
- Mobile: `Dialog` chuẩn, `ScreenHeader`, token màu `ola-*`, `useThemeColors`.
- **Icon**: user tự vẽ (ô Điểm danh, vương miện ô VIP, cúp chuyên cần, quà, dấu nhiệm vụ, vé loa). Code chừa slot trong map icon trung tâm như `itemGrantIcons`, chưa có file thì dùng emoji tạm; ảnh mới để webp.

## 10. Thứ tự làm

| Bước | Việc | Ước lượng |
|---|---|---|
| 0 | Điều kiện: **Vé loa** đã xong ([megaphone-feature-plan.md mục 15](megaphone-feature-plan.md#15-vé-loa-plan-19112026-chưa-code)) | — |
| 1 | Migration + model | 0,25 ngày |
| 2 | Điểm danh server: registry nhiệm vụ + service/API + test Go (điểm danh 2 lần, qua 0h, lỡ ngày, sang chu kỳ, ô VIP không VIP, chuyên cần ở ô giữa, nhiệm vụ làm trước/sau, quá ngày, nhiều quà một ô, khung đã có vĩnh viễn) | 1,5 ngày |
| 3 | Admin: trang Điểm danh 3 tab | 1 ngày |
| 4 | Shared + web: popup, màn, ô, chấm đỏ | 1 ngày |
| 5 | Mobile: như web + test store ở mobile jest | 1 ngày |
| 6 | E2E local (docker dev, giả qua ngày bằng sửa `day` các dòng `user_checkins`), ảnh xác nhận web + simulator | 0,5 ngày |

Deploy: migration trước, rồi api, rồi admin cấu hình 28 ô, rồi web và app, cuối cùng bật `platforms`. Không cần deploy chat/game. App cũ không có điểm danh, không lỗi gì.

## 11. Cần chốt trước khi code

1. **Bộ quà mặc định 28 ô** (admin đổi được). Đề xuất:

   | Ô | Quà | Điều kiện |
   |---|---|---|
   | 3, 10, 17, 24 | 1 ngày VIP | |
   | 5, 12, 19, 26 | 1 vé loa (hạn 7 ngày) | |
   | 7 · quà to | thẻ VIP loại thấp 3 ngày + 1 vé loa | cần VIP |
   | 14 · quà to | khung avatar 7 ngày | đăng 1 bài Me |
   | 21 · quà to | thẻ VIP loại giữa 7 ngày + 2 vé loa | cần VIP |
   | 28 · quà to | khung hiếm 15 ngày + 2 ngày VIP + 3 vé loa | chuyên cần |
   | còn lại | không có quà (khi có Nhiệm vụ thì cho điểm hoạt động) | |

2. **Popup tự hiện mỗi ngày** hay chỉ chấm đỏ ở ô Điểm danh? Đề xuất: tự hiện, admin tắt được bằng `popup`.
3. **Chặn nick mới?** Ngày VIP chuyển được (Chuyển NSD) nên nuôi nhiều nick để gom ngày VIP là rủi ro chính. Đề xuất giữ ngày VIP ở mức nhỏ như bảng trên, quà lớn để ở thẻ VIP / khung / vé loa (khoá, có hạn). Nếu vẫn lo thì thêm setting "tài khoản phải tạo đủ N ngày mới điểm danh được".
4. **Quan hệ với Nhiệm vụ**: khi làm Nhiệm vụ, điểm danh vẫn là ô riêng (đề xuất) hay gộp thành thẻ đầu màn Nhiệm vụ?