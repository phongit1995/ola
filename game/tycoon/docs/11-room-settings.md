# 11 — Thiết lập bàn: cược KEN và người xem

Hai tùy chọn chủ bàn chọn khi tạo bàn online. Áp dụng cho mọi phiên bản UI; số đo và style của từng màn vẫn theo [02](./02-screen-specs.md) và [style](./style/README.md).

| Tùy chọn | Giá trị | Mặc định | Ai chọn | Đổi được sau khi tạo |
|---|---|---|---|---|
| Cược KEN | số nguyên ≥ 0 | **0** (bàn giao lưu) | chủ bàn, ở S4 | không |
| Cho người khác xem | bật / tắt | **tắt** | chủ bàn, ở S4 | không |

Chơi với máy (`BotSetupModal`) không có hai tùy chọn này: không cược, không ai xem. Modal đó mở với 1 bot, thêm/xóa tối đa 3 bot và chọn mức độ từng bot; không dùng bộ chọn số lượng ([02 §2.3](./02-screen-specs.md#23-modal-chơi-với-máy-botsetupmodal)).

## 1. Cược KEN

### 1.1 Chọn ở S4 Tạo bàn

- Nhóm `Số KEN cược` đặt ngay dưới `Số người`: ô nhập số, bàn phím số (`inputMode="numeric"`), tự thêm dấu chấm hàng nghìn bằng `formatKen`, giá trị ban đầu `0`. Xoá hết thì coi là `0`.
- Dòng phụ dưới ô: `0 = bàn giao lưu, không mất KEN` khi bằng 0; `Bạn có {ken} KEN` khi lớn hơn 0.
- Kiểm tra trước khi gửi, cùng thứ tự và câu chữ với caro (`helpers/room.ts`):

| Điều kiện | Câu lỗi |
|---|---|
| không phải số nguyên, < 0, hoặc > `maxBet` của user (`USER_INFO.maxBet`) | `Số KEN cược không hợp lệ` |
| > số KEN đang có | `Bạn không đủ KEN để tạo bàn` |

- Gửi `ROOM_CREATE {bet, password, maxPlayers, allowSpectators}`. Lỗi từ server: `INVALID_BET`, `INSUFFICIENT_KEN`, `BET_NOT_ALLOWED` (tài khoản khách, tạm khoá cược) hiện dưới ô cược, modal giữ nguyên.

### 1.2 Vào bàn có cược

- Người vào phải có ít nhất `bet` KEN. Thiếu → O5 thông báo, tông cảnh báo, icon `ken`: `Chưa đủ KEN` · `Bàn này cược {bet} KEN. Bạn đang có {ken} KEN.` · nút `Đã hiểu` ([O5 §9](./screens/o5-modal/README.md#9-tình-huống-dùng)).
- Client chặn sớm theo số dư đang biết; server vẫn kiểm lại lúc vào bàn và lúc bắt đầu ván.

### 1.3 Hiển thị

| Màn | Hiển thị |
|---|---|
| S3 Danh sách bàn | cột `KEN`: `{bet}` rồi đồng KEN bên phải, căn phải; bàn 0 ghi `0` + đồng KEN (không ghi `Giao lưu`, đổi 22/10/2026) |
| S5 Phòng chờ | chip dưới tiêu đề panel: `Cược {bet} KEN` hoặc `Giao lưu` |
| S6 Bàn chơi | dòng thông tin đầu menu ☰: `Cược {bet} KEN` hoặc `Giao lưu`; lúc bắt đầu ván, pod mỗi người hiện `−{bet} KEN` 1,2 s như caro |
| S9 Kết quả | mỗi hàng thêm `±KEN`: hạng 1 `+{nhận} KEN` jade, các hạng khác `−{bet} KEN` coral; bàn 0 không hiện |
| S10 Lịch sử | cột `KEN` theo `kenDelta` của mình |

### 1.4 Thanh toán

- Bắt đầu ván: server giữ `bet` của **mỗi** người (escrow). Pot = `bet × số người`.
- Kết thúc: **hạng 1 nhận cả pot trừ phí** `TYCOON_COMMISSION_PERCENT` (mặc định 5%). Các hạng khác mất `bet`. Hạng lấy từ `Rankings` (05 §4.7), nên bỏ cuộc, phá sản, thoát hoặc hết giờ 3 lần đều tính như người thua.
- Ván không bắt đầu được (thiếu người, lỗi escrow) → hoàn `bet` cho mọi người.
- `MATCH_OVER.kenDelta` của mỗi người = số thực nhận trừ `bet`.

## 2. Cho người khác xem

### 2.1 Chọn ở S4 Tạo bàn

- Công tắc `Cho người khác xem`, dòng phụ `Người ngoài bàn xem được ván, không thao tác được`. Mặc định **Tắt**.
- Đặt dưới `Khóa bàn`. Hai tùy chọn độc lập: bàn khóa vẫn có thể cho xem.

### 2.2 Khi tắt (mặc định)

- Ván không có trong `SPECTATE_LIST`.
- `SPECTATE_JOIN` vào ván này trả lỗi `SPECTATE_NOT_ALLOWED`; client báo toast `Bàn này không cho người ngoài xem`.

### 2.3 Khi bật

- Ván xuất hiện trong `SPECTATE_LIST` khi đang chơi; tối đa `MaxSpectators` (20) người xem, đầy thì `SPECTATE_FULL` → toast `Bàn đã đủ người xem`.
- Bàn khóa có bật cho xem thì vào xem không cần mật khẩu; mật khẩu chỉ để vào chơi.

### 2.4 Nút vào xem ở S3

Vào xem từ chính hàng bàn trong danh sách, không có màn danh sách xem riêng. Cột cuối của hàng đổi theo trạng thái bàn:

| Trạng thái bàn | `allowSpectators` | Cột cuối | Bấm |
|---|---|---|---|
| đang chờ, còn chỗ | bất kỳ | `Tham gia` gold | `ROOM_JOIN` (bàn khóa hỏi mật khẩu, S4b) |
| đang chờ, đủ người | bất kỳ | `Tham gia` disabled | — |
| đang chơi | bật | `Xem` paper | `SPECTATE_JOIN {matchId}` (lấy `matchId` của hàng) → S6 chế độ chỉ xem |
| đang chơi | tắt | chip `Đang chơi`, không nút | — |

- Nút `Xem` cùng kích thước nút `Tham gia`; nhãn chữ, không cần icon mới. Đang gửi thì nút hiện spinner, khóa bấm lại.
- Người đang chơi một ván khác bấm `Xem` → server trả `SPECTATE_OWN_MATCH`, client báo toast `Bạn đang trong một ván khác`.
- Ván kết thúc trong lúc gửi → `MATCH_NOT_FOUND`, toast `Ván đã kết thúc` và làm mới danh sách.
- Người xem nhận cùng view như người chơi nhưng `you = -1`; game không có thông tin riêng ngoài bộ thẻ nên không lộ gì thêm (05 §5.1).
- Màn của người xem dùng S6 ở chế độ chỉ xem: không có nút ở cụm lượt, chỉ chip `Lượt của @username`; không mở O3; sheet S7/S8 chỉ xem; menu ☰ chỉ còn `Rời xem` và `Luật chơi`; không gửi chat và cảm xúc.
- S5 và S6 hiện số người xem ở dòng thông tin menu ☰: `{n} người đang xem`.
- Hết ván → `SPECTATE_LEFT {reason: match_over}`, người xem về danh sách.

## 3. Protocol

| Message | Thay đổi |
|---|---|
| `ROOM_CREATE` | `{bet, password, maxPlayers, allowSpectators}`; `allowSpectators` không bắt buộc. Client tycoon luôn gửi (mặc định `false`). Thiếu trường (game khác, client cũ) thì giữ luật cũ: bàn không khóa xem được, bàn khóa không xem được |
| `ROOM_LIST`, `ROOM_UPSERT`, `ROOM_WAITING`, `ROOM_STATE` | thêm `allowSpectators` (đã có `bet`, `status`, `matchId`), chỉ có khi chủ bàn đã chọn; S3 dùng để hiện nút `Xem` (§2.4); thiếu cờ thì client theo cùng luật server (bàn không khóa xem được) |
| `SPECTATE_LIST` | chỉ trả ván có `allowSpectators = true` (hoặc thiếu cờ và bàn không khóa) |
| `SPECTATE_JOIN` | `SPECTATE_NOT_ALLOWED` khi bàn tắt cho xem (hoặc thiếu cờ và bàn khóa); `ROOM_WATCH` theo cùng luật |

## 4. Việc phía server

Hạ tầng hiện có đã kiểm `bet` (`INVALID_BET`, `INSUFFICIENT_KEN`, `BET_NOT_ALLOWED`, `MaxBet`) và có luồng xem trận. Cần thêm:

1. **Settlement nhiều người (sửa 01/11/2026):**
   - Escrow mọi ghế qua `game_match_players`, hạng từ `Rankings` — có từ khi làm Tiến Lên.
   - `Settlement.WinnerAmounts(gameID, bet, playerCount)`: payout = `bet × số người − phí`, phí = `bet × %` (một phần cược, giữ như Tiến Lên). Engine dùng cùng hàm này cho `MATCH_OVER.payout/kenDelta` (trước đó engine báo theo pot 2 người).
   - Migration `20261101000002_game_ken_delta_per_seat`: ràng buộc `game_matches_ken_delta_check` thành `ken_delta <= bet × max(player_count − 1, 1)` (tính bằng `bigint`). Trước đó `ken_delta <= bet` làm settle bàn 3–4 người có cược lỗi và job thử lại mãi. **Phải chạy migration trước khi deploy server.**
   - `MaxBetFor(số người) = MaxInt32 / số người` để pot không tràn integer: kiểm ở `ROOM_CREATE` (theo `maxPlayers` của bàn), lúc bắt đầu ván và lúc settle; `USER_INFO.maxBet` trả theo số người tối đa của game (Tycoon, Tiến Lên: 536.870.911; game 2 người giữ 1.073.741.823).
2. ~~**Cờ phòng `allowSpectators`.**~~ Đã làm 12/11/2026:
   - `ROOM_CREATE.allowSpectators` là con trỏ `*bool` lưu trong `Room` (Redis, JSON `allowSpectators`, bỏ khi thiếu), nên đi theo `match snapshot.room` và còn sau khi server khởi động lại. Không cần migration SQL.
   - Một hàm `spectatorsAllowed(room)` dùng cho `SPECTATE_LIST`, `SPECTATE_JOIN` (cả ván trong bộ nhớ lẫn snapshot), `ROOM_WATCH` và tin gửi người xem phòng chờ: có cờ thì theo cờ (bật thì bàn khóa vẫn xem được, mật khẩu chỉ để vào chơi); thiếu cờ thì giữ luật cũ — bàn không khóa xem được, bàn khóa trả `SPECTATE_NOT_ALLOWED`. Caro, Tiến Lên, cờ tướng… và client cũ không gửi cờ nên không đổi hành vi.
   - `ROOM_LIST`, `ROOM_UPSERT`, `ROOM_WAITING`, `ROOM_STATE` trả `allowSpectators` khi bàn có cờ. Test: `TestSpectateHonoursRoomSpectatorFlag`, `TestCreateRoomCarriesSpectatorFlag`, `TestRoomWatchRefusesPrivateAndMissingRooms` trong `spectate_test.go`.
3. ~~**Xem trận cho game có `StateViewer`.**~~ Đã làm 11/11/2026: tycoon cài `SpectatorView` (`you = -1`, không lộ bộ thẻ) và nằm trong `playingRoomGames`, nên `ROOM_LIST` có bàn đang chơi kèm `matchId`. 12/11/2026 thêm cờ ở mục 2, chỉ bàn bật cho xem mới hiện nút `Xem`.
4. ~~Config `TYCOON_COMMISSION_PERCENT` (mặc định 5) cạnh các game khác.~~ Đã thêm 01/11/2026.

## 5. Checklist

- [x] S4: ô cược mặc định 0 + kiểm tra; công tắc cho xem mặc định tắt (UI trên dữ liệu giả, [S3 §10](./screens/s3-room-list/README.md#10-bản-dựng-dữ-liệu-giả)).
- [x] S3, S5, S6, S9, S10 hiển thị cược theo §1.3 (12/11/2026): S6 menu ☰ có dòng `Cược {bet} KEN` / `Giao lưu` + `{n} người đang xem` và mục `Luật chơi`; pod hiện `−{bet} KEN` lúc vào ván; S9 mỗi hàng `±KEN` (hạng 1 = `kenDelta` của `MATCH_OVER`, còn lại `−bet`).
- [x] O5 `Chưa đủ KEN` khi vào bàn thiếu tiền (kiểm phía client trên dữ liệu giả).
- [x] Server: settlement 2–4 người, payout `MATCH_OVER` theo số ghế, ràng buộc `ken_delta` + `MaxBet` theo số ghế (migration chưa chạy trên dev/prod), config phí `TYCOON_COMMISSION_PERCENT`.
- [x] Server: `allowSpectators` (thiếu cờ giữ luật cũ cho game khác), xem trận cho `StateViewer`.
- [x] Nút `Xem` ở hàng bàn S3 theo §2.4: chỉ hiện khi bàn đang chơi có `matchId` và `allowSpectators = true`, còn lại chip `Đang chơi`.
- [x] S4: công tắc `Cho người khác xem` hiện lại (mặc định tắt), `createRoom` gửi `allowSpectators`.
- [x] Chế độ chỉ xem ở S6 theo §2.3 (11/11/2026, xem [12 Giai đoạn 6](./12-online-plan.md)).
- [x] Test: bàn 0 không trừ KEN; bàn có cược 2/3/4 người, hạng 1 nhận đúng pot trừ phí; bỏ cuộc vẫn mất cược; bàn tắt xem không vào được (`engine/tycoon_settlement_test.go`, `settlement.tycoon_test.go`, `engine/spectate_test.go`).
