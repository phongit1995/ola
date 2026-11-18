# Plan: Nhiệm vụ

Ngày lập: 18/11/2026 · Trạng thái: **plan, chưa code**

User làm các việc trong app (nhắn tin, đăng Me, chơi game, tặng quà...) để hoàn thành nhiệm vụ. Mỗi nhiệm vụ xong thì bấm **Nhận** để lấy thưởng: **ngày VIP** và/hoặc **điểm hoạt động**. Điểm hoạt động đủ mốc thì mở **rương** (thưởng ngày VIP). Admin tự thêm, sửa, bật, tắt nhiệm vụ và rương, không cần deploy.

## 1. Phạm vi

| Hạng mục | Chốt |
|---|---|
| Loại nhiệm vụ | **Hằng ngày** (reset 0h giờ VN), **Hằng tuần** (reset 0h thứ Hai giờ VN), **Tân thủ** (làm 1 lần trong đời tài khoản) |
| Thưởng | **Ngày VIP** (cộng thẳng vào `vip_end_time`, như vòng quay) và **điểm hoạt động**. Không thưởng KEN |
| Điểm hoạt động | Nhiệm vụ ngày cộng vào thanh điểm **ngày**, nhiệm vụ tuần cộng vào thanh điểm **tuần**. Mỗi thanh có các **rương mốc** (vd 20/40/60/80/100), mỗi rương thưởng ngày VIP. Tân thủ chỉ thưởng ngày VIP, không có điểm |
| Nhận thưởng | Đủ tiến độ thì hiện nút **Nhận**; có nút **Nhận tất cả**. Lối vào có chấm đỏ khi còn thưởng chưa nhận. Hết kỳ chưa nhận thì **mất** |
| Ai quản lý | **Admin**: danh sách nhiệm vụ (chọn hành động có sẵn trong code, số lần, điểm, ngày VIP, thứ tự, bật/tắt) và rương mốc. Code chỉ định nghĩa **các hành động đếm được** |
| Nơi vào | Ô **Nhiệm vụ** đầu lưới tab Cá nhân (web + mobile), có chấm đỏ. Mỗi nhiệm vụ có nút **Đi làm** mở đúng màn |
| Nền tảng | Web + Android + iOS, bật/tắt theo nền tảng bằng `app_settings` như topup |

Ngoài phạm vi (để sau): thưởng KEN/quà/khung avatar, nhiệm vụ sự kiện có ngày bắt đầu/kết thúc, nhiệm vụ clan, bảng xếp hạng điểm hoạt động, push nhắc làm nhiệm vụ.

## 2. Cái đã có, dùng lại

- **Cộng ngày VIP trong transaction**: `vip.GrantDaysTx(tx, userID, days, source, name)` ([vip.repository.go](../server/internal/modules/vip/vip.repository.go)), ghi `vip_purchases` để hiện trong lịch sử VIP. Sau commit gọi `vipService.invalidate`, giống vòng quay ([wheel.repository.go](../server/internal/modules/wheel/wheel.repository.go)). Thêm source `mission` vào `packages/shared/src/lib/vipHistory.ts`.
- **Kỳ theo giờ VN**: `utils.VietnamPeriodStart(now, PeriodDay|PeriodWeek)` ([period.go](../server/internal/utils/period.go)), tuần bắt đầu thứ Hai.
- **Redis**: `services.CacheService` có ở cả 3 binary api, chat, game ([cmd/game/container.go](../server/cmd/game/container.go)) nên bộ đếm chạy được ở mọi nơi.
- **Kafka + WS**: mẫu `CHAT.FRIEND.CONTENT` vừa làm: API/game publish → chat service `EmitToUser`.
- **Cài đặt theo nền tảng**: `app_settings` + `setting.Client` (mẫu topup, social_limit).
- **Admin CRUD có thứ tự**: mẫu gói VIP (`CreatePackageAt`, `ReorderPackages`) và trang `VipPackagesPage`.
- **Lưới app tab Cá nhân**: `PERSONAL_ITEMS` ở [web/src/pages/apps/constants.ts](../web/src/pages/apps/constants.ts) và `mobile/src/screens/apps/constants.ts`.
- **Realtime phía client**: mẫu `stores/ken/kenRealtime.ts` (`claimRealtimeRegistration`, đồng bộ lại khi reconnect).

## 3. Hành động đếm được (registry trong code)

Mỗi hành động có mã cố định, được đếm ở **một chỗ trong service** ngay sau khi việc đó thành công (sau commit). Admin chỉ chọn trong danh sách này.

| Mã | Ý nghĩa | Đếm ở | Kỳ dùng được |
|---|---|---|---|
| `open_app` | Mở app trong ngày | `GET /missions` hoặc `GET /missions/badge` lần đầu trong ngày | ngày |
| `active_days` | Số ngày có mở app trong tuần | cùng chỗ `open_app`, chỉ +1 khi `open_app` ngày đó lần đầu | tuần |
| `send_dm` | Gửi tin nhắn 1-1/nhóm | `message.SendMessage`, `SendImageMessage`, `SendAudioMessage` | ngày, tuần |
| `room_message` | Gửi tin trong phòng chat | `room.SendMessage` + media | ngày, tuần |
| `me_post` | Đăng bài Me (không tính clan) | `me.Create` | ngày, tuần |
| `me_comment` | Bình luận bài Me | `me.AddComment` | ngày, tuần |
| `me_react` | Thả cảm xúc bài Me | `me.React` (chỉ khi thêm mới, bỏ cảm xúc không trừ) | ngày, tuần |
| `moment_post` | Đăng khoảnh khắc | `moment.Create` (video tính khi MarkReady) | ngày, tuần |
| `moment_react` | Thả tim khoảnh khắc người khác | `moment.React` | ngày, tuần |
| `play_game` | Chơi xong 1 ván game online | game service `settleFinish` sau commit, cho từng người chơi thật | ngày, tuần |
| `win_game` | Thắng 1 ván game online | như trên, chỉ người thắng | ngày, tuần |
| `send_gift` | Tặng quà | `gift.Send` | ngày, tuần |
| `read_chapter` | Đọc chương truyện | `story.Chapter` khi `prefetch=false` và chương chưa đọc hôm nay | ngày, tuần |
| `story_comment` | Bình luận truyện | `story.CreateComment` | ngày, tuần |
| `spin_wheel` / `smash_egg` / `pen_shot` | Chơi vòng quay / đập trứng / sút pen | service tương ứng | ngày, tuần |
| `add_friend` | Có thêm bạn | `relationships.AcceptFriendRequest` (cả 2 người) | ngày, tuần |

**Hành động tân thủ** đọc theo **trạng thái** trong DB lúc mở màn, không đếm sự kiện, nên Redis mất cũng không sai và tài khoản cũ cũng tính đúng:

| Mã | Điều kiện |
|---|---|
| `has_avatar` | đã đặt avatar |
| `email_verified` | đã xác minh email |
| `friend_count` | số bạn bè ≥ target |
| `me_post_total` | tổng bài Me ≥ target |
| `moment_total` | tổng khoảnh khắc ≥ target |
| `game_total` | tổng ván game online ≥ target |
| `gift_sent_total` | tổng quà đã tặng ≥ target |

Thêm hành động mới = thêm 1 dòng registry (mã, kỳ dùng được, đơn vị) + 1 dòng `Track` ở service, + i18n tên. Admin thấy ngay trong dropdown.

## 4. Dữ liệu

Migration mới `20261119000001_add_missions` (version phải lớn hơn mọi môi trường, kể cả prod; không sửa migration đã chạy).

```sql
CREATE TABLE missions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  kind varchar(10) NOT NULL,              -- daily | weekly | newbie
  action varchar(40) NOT NULL,            -- mã registry
  target int NOT NULL CHECK (target > 0),
  points int NOT NULL DEFAULT 0,          -- newbie luôn 0
  vip_days int NOT NULL DEFAULT 0,
  title varchar(100),                     -- bỏ trống = client tự dựng từ i18n action + target
  position int NOT NULL DEFAULT 0,
  enabled boolean NOT NULL,
  created_at, updated_at, deleted_at
);

CREATE TABLE mission_chests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  kind varchar(10) NOT NULL,              -- daily | weekly
  points_required int NOT NULL CHECK (points_required > 0),
  vip_days int NOT NULL CHECK (vip_days > 0),
  enabled boolean NOT NULL,
  created_at, updated_at, deleted_at
);

CREATE TABLE user_mission_claims (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  mission_id uuid,                        -- một trong hai
  chest_id uuid,
  period_key varchar(12) NOT NULL,        -- d20261118 | w20261116 | all
  points int NOT NULL DEFAULT 0,          -- chụp lại lúc nhận
  vip_days int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX uq_mission_claim ON user_mission_claims (user_id, mission_id, period_key) WHERE mission_id IS NOT NULL;
CREATE UNIQUE INDEX uq_chest_claim ON user_mission_claims (user_id, chest_id, period_key) WHERE chest_id IS NOT NULL;
CREATE INDEX idx_mission_claims_user_period ON user_mission_claims (user_id, period_key);
```

- Điểm hoạt động của kỳ = `SUM(points)` các claim nhiệm vụ của kỳ đó. Không cần bảng riêng, không bị lệch.
- Bẫy GORM `default:true` (đã gặp ở module quà): cột `enabled` không để default ở model, luôn set tường minh.
- Admin sửa `target/points/vip_days` giữa kỳ: claim đã nhận giữ nguyên số chụp lại; người chưa nhận dùng số mới.

**Tiến độ trong Redis** (chỉ cho ngày/tuần):

```
MISSION:PROGRESS:<userId>:d20261118   hash action → count   TTL 2 ngày
MISSION:PROGRESS:<userId>:w20261116   hash action → count   TTL 9 ngày
```

Mất Redis thì mất tiến độ hôm đó (không mất thưởng đã nhận). Chấp nhận được, ghi rõ trong docs.

## 5. Server

### 5.1 Module `internal/modules/mission`

- `mission.constants.go`: registry hành động, kind, period key, cache key.
- `mission.tracker.go`: `Tracker.Track(ctx, userID, action, n)`.
  - Đọc **tập action đang có nhiệm vụ bật** (cache Redis 60s). Action không ai dùng thì return luôn, không ghi Redis.
  - Pipeline `HINCRBY` key ngày + key tuần, set TTL.
  - Nếu giá trị **vừa vượt** target của một nhiệm vụ đang bật (trước < target ≤ sau) thì publish Kafka `CHAT.MISSION.CLAIMABLE` {userId, missionId}. Chat service `EmitToUser(MISSION_CLAIMABLE)` để client hiện chấm đỏ.
  - Chạy async (`utils.PublishAsync`), lỗi chỉ log, không làm hỏng việc chính.
  - Tracker là struct nhỏ chỉ cần CacheService + producer, inject được vào cả game service.
- `mission.newbie.go`: tính tiến độ tân thủ bằng 1 query gộp (avatar, email, đếm bạn, bài, khoảnh khắc, ván game, quà), cache 60s theo user, xoá cache khi claim.
- `mission.service.go`: `List`, `Badge`, `Claim`, `ClaimAll`, `ClaimChest`.
- `mission.repository.go`, `mission.controller.go`, `mission.router.go`, `mission.dig.go`.

### 5.2 Nhận thưởng

`Claim(userID, missionID)`:

1. Lấy nhiệm vụ (bật, chưa xoá), tính `period_key` theo giờ VN **phía server**.
2. Kiểm tra tiến độ ≥ target (Redis hoặc trạng thái tân thủ). Không đủ → `MISSION_NOT_COMPLETED`.
3. Tân thủ: tài khoản phải trong cửa sổ tân thủ (5.4) → nếu không `MISSION_NOT_AVAILABLE`.
4. Transaction: insert `user_mission_claims` (trùng unique → `MISSION_ALREADY_CLAIMED`, trả 409, client coi như đã nhận); nếu `vip_days > 0` gọi `vip.GrantDaysTx(tx, userID, days, "mission", title)`.
5. Sau commit: invalidate cache VIP + user, trả `{points, vipDays, vipEndTime, dailyPoints, weeklyPoints}`.

`ClaimChest`: như trên nhưng điều kiện là `SUM(points)` của kỳ ≥ `points_required`. `ClaimAll`: nhận mọi nhiệm vụ đủ điều kiện trước rồi đến rương, trong **một** transaction, trả tổng.

### 5.3 API

| Method | Path | Mô tả |
|---|---|---|
| GET | `/missions` | `{daily, weekly, newbie}`. Mỗi nhóm: `periodEndsAt`, `points`, `chests[] {id, pointsRequired, vipDays, status}`, `missions[] {id, action, target, progress, points, vipDays, title, status}`. `status`: `in_progress` / `claimable` / `claimed`. Gọi lần đầu trong ngày thì `Track(open_app)` |
| GET | `/missions/badge` | `{claimable: n}` cho chấm đỏ; app gọi khi mở và khi quay lại foreground |
| POST | `/missions/:id/claim` | nhận 1 nhiệm vụ |
| POST | `/missions/chests/:id/claim` | mở 1 rương |
| POST | `/missions/claim-all` | nhận hết |

Rate limit policy cho các POST (vd 20/phút). Feature tắt hoặc nền tảng không bật → `/missions` trả `enabled:false`, client ẩn ô Nhiệm vụ.

### 5.4 Cài đặt `app_settings` key `mission`

```json
{
  "platforms": { "web": true, "android": true, "ios": true },
  "newbieWindowDays": 30,
  "newbieMinAccountCreatedAt": "2026-11-20T00:00:00+07:00",
  "maxVipDaysPerWeek": 7
}
```

- `newbieWindowDays`: tân thủ chỉ hiện trong N ngày đầu từ lúc tạo tài khoản.
- `newbieMinAccountCreatedAt`: chỉ tài khoản tạo **sau** mốc này mới có tân thủ, để tài khoản cũ không bấm nhận hàng loạt ngày VIP ngay khi ra mắt (cần chốt, xem mục 9).
- `maxVipDaysPerWeek`: trần ngày VIP từ nhiệm vụ + rương mỗi tuần; vượt thì vẫn nhận điểm nhưng không cộng thêm ngày VIP. Chặn admin cấu hình nhầm.

### 5.5 Chống gian lận

- Chỉ đếm việc **đã thành công** (sau commit, đã qua giới hạn nhắn tin, từ cấm...).
- `play_game`: chỉ ván online kết thúc bình thường có ≥ 2 người thật; không tính tập luyện với máy, ván huỷ, ván bỏ cuộc dưới 1 phút (dùng `end_reason` của `game_matches`).
- `send_dm`: không tính tin gửi chatbot và tin gửi chính mình. Có thể đếm **số người khác nhau** thay vì số tin nếu thấy spam (đổi registry, không đổi DB).
- `me_react` / `moment_react`: bỏ rồi thả lại không tính thêm (đếm theo cặp user+post bằng Redis set trong ngày).
- Ngày VIP chuyển được cho người khác (Chuyển NSD), nên nuôi nhiều nick để gom là rủi ro chính. Trần `maxVipDaysPerWeek` + cửa sổ tân thủ giới hạn thiệt hại; xem thống kê admin (6) để phát hiện sớm.

## 6. Admin

Menu mới **Nhiệm vụ** (dưới "Trò chơi"), 1 trang 4 tab:

| Tab | Nội dung |
|---|---|
| Nhiệm vụ | Bảng lọc theo kind; thêm/sửa: kind, hành động (dropdown chỉ hiện action hợp kind), target, điểm, ngày VIP, tiêu đề tuỳ chọn (trống = tự sinh, có xem trước), bật/tắt; kéo thả thứ tự |
| Rương | Theo kind ngày/tuần: điểm mốc, ngày VIP, bật/tắt |
| Cài đặt | form `mission` (5.4) |
| Thống kê | theo ngày: số người nhận, số claim mỗi nhiệm vụ, tổng ngày VIP đã phát; top user nhận nhiều ngày VIP nhất trong tuần |

API admin `/admin/missions`, `/admin/missions/chests`, `/admin/missions/stats`, ghi `admin_audit_logs` như các module khác.

## 7. Client

### 7.1 Shared `packages/shared`

- `types/mission.ts`, `services/mission.service.ts`.
- `constants/mission.ts`: `MISSION_KIND`, `MISSION_STATUS`, `MISSION_ACTION` (map `as const`), `MISSION_SOCKET_EVENT`.
- `stores/mission.ts` (zustand): `data`, `badge`, `load()`, `loadBadge()`, `claim(id)`, `claimChest(id)`, `claimAll()`. Realtime: `MISSION_CLAIMABLE` → `badge++` và đánh dấu nhiệm vụ nếu đang mở màn; reconnect/foreground → `loadBadge()`. Qua nửa đêm khi đang mở màn → tự `load()` lại.
- `lib/missionTitle.ts`: dựng tiêu đề từ i18n `mission.action.<code>` + target, vd "Gửi 10 tin nhắn".
- `lib/missionLink.ts`: action → đích "Đi làm" dạng trừu tượng (`chatTab`, `roomTab`, `meComposer`, `momentCreate`, `gameTab`, `storyTab`, `wheel`, `egg`, `pen`, `profileEdit`, `friendSuggest`...), mỗi nền tảng tự map sang điều hướng của mình.
- i18n vi/en: `mission.*`.
- Thêm `mission` vào `vipHistory.ts` để lịch sử VIP hiện "Nhiệm vụ".

### 7.2 Màn Nhiệm vụ (web overlay `missions`, mobile screen `Missions`)

```
┌ Nhiệm vụ                         [Nhận tất cả] ┐
│ [Hằng ngày] [Hằng tuần] [Tân thủ]             │
│ Còn 05:12:30 làm mới                          │
│ Điểm hoạt động 45                             │
│ ●━━━━━●━━━━━○━━━━━○━━━━━○                     │
│ 20🎁  40🎁  60🎁  80🎁  100🎁 (rương mở được nảy) │
├───────────────────────────────────────────────┤
│ 💬 Gửi 10 tin nhắn          +10 điểm          │
│ ▓▓▓▓▓▓░░░░ 6/10                  [Đi làm]     │
│ 🎮 Chơi 3 ván game     +20 điểm · +1 ngày VIP │
│ ▓▓▓▓▓▓▓▓▓▓ 3/3                   [Nhận]       │
│ 📝 Đăng 1 bài Me            +10 điểm          │
│                                   ✓ Đã nhận   │
└───────────────────────────────────────────────┘
```

- Sắp xếp: `claimable` lên đầu, rồi `in_progress`, `claimed` xuống cuối.
- Nhận xong: hiện hộp "+1 ngày VIP · +20 điểm" và thanh điểm chạy tới giá trị mới.
- Tab Tân thủ: hiện "Còn X ngày" theo cửa sổ tân thủ; hết hoặc làm hết thì ẩn tab.
- Mobile: dùng `ScreenHeader`, `Dialog`, token màu `ola-*`, `useThemeColors`.
- Ô **Nhiệm vụ** đầu `PERSONAL_ITEMS` (web + mobile), chấm đỏ khi `badge > 0`; tab Cá nhân trên bottom bar cũng có chấm đỏ.
- **Cần ảnh**: icon ô Nhiệm vụ, rương (đóng/mở được/đã mở), icon từng nhóm hành động. Phải hỏi user trước khi tạo bằng Codex Astra, ảnh mới để webp.

## 8. Thứ tự làm

| Bước | Việc | Ước lượng |
|---|---|---|
| 1 | Migration + model + registry + Tracker + service/API + test Go (claim trùng, sai kỳ, qua nửa đêm, trần VIP) | 1,5 ngày |
| 2 | Cắm `Track` vào các service API (bảng mục 3) + Kafka/WS `MISSION_CLAIMABLE` ở chat service | 0,5 ngày |
| 3 | Cắm `play_game` / `win_game` ở game service | 0,5 ngày |
| 4 | Admin 4 tab | 1 ngày |
| 5 | Shared store/service/i18n + web màn + ô + chấm đỏ | 1 ngày |
| 6 | Mobile màn + ô + chấm đỏ + test store ở mobile jest | 1 ngày |
| 7 | E2E local (docker dev, 2 tài khoản, giả qua nửa đêm bằng sửa Redis key), ảnh xác nhận web + simulator | 0,5 ngày |

Deploy: migration trước, rồi api + chat + game (đều có Tracker), rồi admin cấu hình nhiệm vụ/rương, cuối cùng bật `platforms`. App cũ không có màn Nhiệm vụ cũng không lỗi gì.

## 9. Cần chốt trước khi code

1. **Tài khoản cũ có được làm tân thủ không?** Đề xuất: chỉ tài khoản tạo sau ngày ra mắt (`newbieMinAccountCreatedAt`), vì phần lớn tài khoản cũ đã đủ điều kiện và sẽ nhận ngay một loạt ngày VIP.
2. **Mức thưởng mặc định** (admin đổi được). Đề xuất khởi đầu: nhiệm vụ ngày chỉ cho điểm; rương ngày 100 điểm = 1 ngày VIP; rương tuần 300 điểm = 2 ngày VIP; tân thủ tổng ~3 ngày VIP; trần 7 ngày VIP/tuần.
3. **Danh sách nhiệm vụ mặc định** để seed (đề xuất):
   - Ngày: mở app (10đ), gửi 10 tin nhắn (10đ), đăng 1 bài Me (20đ), thả cảm xúc 5 bài (10đ), chơi 3 ván game (20đ), đọc 5 chương truyện (10đ), tặng 1 quà (20đ) → tối đa 100đ.
   - Tuần: mở app 5 ngày (50đ), chơi 20 ván (100đ), thắng 10 ván (100đ), đăng 3 khoảnh khắc (50đ), tặng 5 quà (100đ).
   - Tân thủ: đặt avatar, xác minh email, có 3 bạn, đăng bài Me đầu tiên, đăng khoảnh khắc đầu tiên, chơi ván game đầu tiên, tặng quà đầu tiên.
4. Ngày VIP từ nhiệm vụ có được **Chuyển NSD** như ngày VIP mua không? Đề xuất: cho chuyển như bình thường (tách riêng phức tạp), dùng trần tuần để giới hạn.
