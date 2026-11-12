# 12 — Kế hoạch nối online (chơi với máy vẫn chạy ở client)

Lập 11/11/2026. Mục tiêu: "Vào bàn" chơi thật với người qua server Go, còn "Chơi với máy" giữ nguyên chạy trên máy người chơi, không cần mạng.

## 0. Hiện trạng

| Phần | Trạng thái |
|---|---|
| Server `server/internal/game/games/tycoon/` | Xong: luật port 1:1 từ `logic/engine.ts`, đăng ký engine game, test luật + tích hợp 4 người, parity 0 lệch (`node game/scripts/tycoon-parity.mjs`) |
| Thanh toán bàn cược 2–4 người | Xong ở server; migration `20261101000002_game_ken_delta_per_seat` **chưa chạy** trên dev/prod |
| Client | **Đã nối (11/11, chưa commit lúc ghi):** store chỉ nói chuyện với `GameSession`; online qua `joinGame('tycoon')`, chơi với máy qua session giả `practice.ts`. Danh sách bàn, phòng chờ, lịch sử, BXH gọi server thật; đã xoá `roomMock` / `historyMock` / `leaderboardMock` |
| Màn phòng chờ S5 | Có: `screens/RoomScreen.tsx` (ghế, sẵn sàng, bắt đầu, mời ra, chat phòng) |
| Người xem | Server chặn (`SPECTATE_NOT_SUPPORTED`), cờ `allowSpectators` chưa có |
| Lịch sử / BXH riêng tycoon | Một phần (05 §9.1, §9.2): bảng thắng dùng chung Tiến Lên đã chạy; thiếu `end_reason`, bảng cấp độ, `me` |

Protocol đầy đủ ở [05 §5–§9](./05-gameplay-rules-and-protocol.md#5-state-server-json--snapshot-redis-full-state-không-bao-giờ-gửi-client), thiết lập bàn ở [11](./11-room-settings.md). Kế hoạch này chỉ chia việc và chốt cách làm phía client.

## 1. Quyết định

1. **Một luồng cho cả online và chơi với máy.** Làm như Tiến Lên (`game/thirteen/practice.ts`): chơi với máy là một `GameSession` giả (`tycoon/practice.ts`) chạy engine + bot ngay trên máy, phát `MATCH_FOUND` / `STATE` / `MATCH_OVER` giống server. Store chỉ nói chuyện với `GameSession`, không biết đang online hay offline. Lợi ích: mọi màn (bàn, sheet, kết quả) dùng chung, ván với máy thử luôn luồng online.
2. **Chơi với máy không cần mạng.** Không kết nối socket được thì sảnh vẫn mở, "Chơi với máy" vẫn chạy; chỉ "Vào bàn", Lịch sử online, BXH báo lỗi kèm nút thử lại.
3. **Online: server là nguồn chân lý.** Không đi trước kết quả: bàn và tiền chỉ đổi theo `view` server gửi về; `movePending` chặn bấm hai lần; `steps` trong view là kịch bản animation (đang dùng sẵn trong `replaySteps`).
4. **Nước đi nhiều bước** (nâng / hạ nhiều cấp bằng `buildPlan` / `sellPlan`): online gửi lần lượt — gửi nước đầu, nhận `STATE` của chính mình thì gửi nước tiếp, gặp lỗi hoặc đổi pha thì dừng. Chơi với máy giữ cách ghép như hiện tại (`sendMoves`).
5. **Dữ liệu tĩnh sinh từ Go.** Tên ô, giá, thuê, thẻ, hằng số đọc từ file sinh ra (`constants.gen.ts`, `board.gen.json`, `cards.gen.json`) thay cho `board.json` / `cards.json` / `constants.ts` viết tay, để client và server không lệch.
6. **Lịch sử chơi với máy vẫn lưu ở máy** (`helpers/history.ts`); màn Lịch sử gộp online + máy, sắp theo thời gian.

## 2. Các giai đoạn

### Giai đoạn 1 — Chuẩn bị (chưa đổi hành vi)

- [x] Mở rộng `server/cmd/tycoongen -constants` sinh `game/tycoon/logic/constants.gen.ts` (hằng số + `BOARD_DATA` + `CARD_DATA` trong cùng một file, không tách json); `go generate` ở `parity_fixture.go` sinh cả hằng số lẫn fixture. Đã xoá `board.json`, `cards.json`; `constants.ts` chỉ còn `LEVEL_NAMES` (chữ hiển thị).
- [x] `logic/parity.test.ts`: chạy lại `testdata/parity.json` bằng `engine.ts` trong vitest (hiện chỉ có script node).
- [x] Kiểu `TycoonView` (= `GameState` bỏ `rng`, `chanceDeck`, `chestDeck`; thêm `you`, `chanceLeft`, `chestLeft`) + `viewFor(state, seat)` phía client, khớp `view.go`.
- [x] `helpers/errorText.ts`: map mã lỗi server `tycoon:*` và mã chung (`INVALID_MOVE`, `NOT_YOUR_TURN`, `INSUFFICIENT_KEN`, …) sang tiếng Việt; thay `RULE_TEXT` trong store.
- [x] Đối chiếu bảng thời lượng animation ở `TurnStartDelayer` (server) với nhịp mới của client (`fx/runtime.ts`, lượt máy nhanh hơn, tốc độ ×2): server chỉ cần đủ thời gian cho tốc độ ×1. Đo trên trình duyệt với 3 bot socket đi sau 80 ms: client bị dồn hàng `STATE`, có lượt của mình chỉ còn 10 s. Đã thêm đuổi kịp ở store: còn `STATE` chờ phía sau thì phát nhanh ×4 và bỏ banner đổi lượt → lượt của mình còn 25–30 s. Người thật không dồn hàng vì chỉ bấm sau khi xem xong animation.

### Giai đoạn 2 — Store chạy qua `GameSession`

- [x] `tycoon/practice.ts`: `createPracticeSession(bots)` cài `GameSession<TycoonView, Move>`: `sendMove` → `applyMove` + bot (`logic/bot.ts`) với độ trễ hiện tại (`BOT_DELAY_MS`, tốc độ ×1/×2), hết giờ dùng `moveOnTimeout`, giới hạn 25 phút như server.
- [x] Tách `store/useTycoon.ts`: phần luật (applyLocal, bot, timer, finishGame) chuyển vào `practice.ts`; store chỉ còn nhận `MATCH_FOUND` / `STATE` / `MATCH_OVER` → `replaySteps` → cập nhật view.
- [x] `sendMoves` online gửi lần lượt theo §1.4; chơi với máy giữ ghép một lần.
- [x] Kết quả lấy từ `MATCH_OVER.rankings` (+ `kenDelta`, `expGains` khi online); lý do kết thúc từ `view.endReason`.
- [x] Giữ nguyên các hiệu ứng chỉ đọc view: cảnh báo sắp thắng (`winThreats`), ô thắng, nhãn nổi, modal phá sản.
- [x] Test store với SDK giả: `store/useTycoon.test.ts` (vào ván + deadline server, bàn chỉ đổi theo `STATE`, nước nhiều bước gửi tuần tự và dừng khi lỗi, chat/cảm xúc, kết quả theo `rankings`, người xem) + `practice.test.ts` (session giả).
- [x] Kiểm tay: ván với máy trước/sau tách giống hệt (thời gian, hiệu ứng, kết quả).

### Giai đoạn 3 — Kết nối, danh sách bàn, phòng chờ

- [x] Kết nối `joinGame('tycoon')` khi vào sảnh (S1 loading → connecting → ready / error), giữ một session cho cả phiên; `USER_INFO` cập nhật KEN, `maxBet`.
- [x] S3 Danh sách bàn: thay `roomMock` bằng `listRooms` + `ROOM_UPSERT` / `ROOM_REMOVED`; S4 tạo bàn gửi `createRoom(bet, password, maxPlayers)`; vào bàn khoá gửi mật khẩu; lỗi `INSUFFICIENT_KEN`, sai mật khẩu, bàn đầy.
- [x] **S5 Phòng chờ (màn mới):** 2–4 ghế, Sẵn sàng / Huỷ, Bắt đầu (chủ bàn, đủ người sẵn sàng), Mời ra, Thoát bàn, chat phòng; dựa logic `thirteen/screens/room/RoomScreen.tsx`, giao diện theo kiểu UI mượt của tycoon (`ui.css`).
- [x] Sau ván: `ROOM_WAITING` / `ROOM_STATE` (`afterMatchId`) → "Chơi lại" về S5, "Đóng" về S3.

### Giai đoạn 4 — Trong ván online

- [x] Đồng hồ theo `deadline` server; hết giờ local khoá thao tác, chờ nước tự động của server (`autoMoved`).
- [x] O4 mất kết nối: `OPPONENT_DISCONNECTED` (tên người rớt, đếm ngược 30 s), `OPPONENT_RECONNECTED` đồng bộ lại đồng hồ; bản thân rớt mạng thì tự nối lại.
- [x] Vào lại giữa ván (`MATCH_FOUND.resumed`): dựng bàn từ view, không animation; pha `card` hiện thẻ ngay, pha `debt` của mình mở hộp thiếu tiền.
- [x] Nợ ngoài lượt (thẻ Sinh nhật, 05 §6.1): server đặt `turn = debt.by` nên con nợ mở được hộp thiếu tiền như lượt thường.
- [x] Bỏ cuộc / Về sảnh online: `forfeit(matchId)`, nuốt `MATCH_OVER` khi chủ động thoát.
- [x] Chống trùng `MATCH_FOUND` / `MATCH_OVER` (`handledMatchIds`, giới hạn 64 như caro).

### Giai đoạn 5 — Lịch sử, bảng xếp hạng

- [x] Client: `getHistory` / `getLeaderboard(period)` thay dữ liệu giả; lịch sử gộp với ván máy (§1.6). Tab BXH cấp độ báo lỗi cho tới khi server có bảng cấp độ.
- [x] Server (05 §9.1–§9.2): migration `20261113000001_game_match_end_reason` (`end_reason`, `exit_reason`, index `user_game_levels(game_id, exp DESC)`), interface `logic.ResultDescriber` (tycoon trả `endReason` + `forfeit`/`bankrupt` từng ghế), ván tycoon 2 người cũng ghi `game_match_players`; `LEADERBOARD {board: 'level'}` + `me` có hạng thật (ROW_NUMBER, chỉ chạy khi mình ngoài top 100); lịch sử trả `endReason`, `exitReason`, `kenDelta` từng người. `protocol.go` và `protocol.ts` sửa cùng lúc, field mới đều optional.

### Giai đoạn 6 — Người xem (sau, tuỳ chọn)

- [x] Server: tycoon cài `SpectatorView` (view `you = -1`, không lộ bộ thẻ) và vào `playingRoomGames` nên `ROOM_LIST` có bàn đang chơi kèm `matchId`.
- [x] Server (12/11): cờ `allowSpectators` theo bàn — `ROOM_CREATE` nhận, lưu trong room + match snapshot, trả trong `ROOM_LIST`/`ROOM_UPSERT`/`ROOM_WAITING`/`ROOM_STATE`; tắt thì không có trong `SPECTATE_LIST` và `SPECTATE_JOIN` trả `SPECTATE_NOT_ALLOWED`; bật thì bàn khóa vẫn xem được. Thiếu cờ (game khác, client cũ) giữ luật cũ: bàn không khóa xem được. Chi tiết [11 §4](./11-room-settings.md#4-việc-phía-server).
- [x] Client: nút Xem ở S3, chế độ chỉ xem ở S6 (`you = -1`, pill "Đang xem · N người xem", menu chỉ còn "Thôi xem", không có Bỏ cuộc/chat), kết quả "@x thắng" + "Về danh sách bàn".
- [x] Client (12/11): công tắc "Cho người khác xem" ở S4 hiện lại (mặc định Tắt), `createRoom` gửi `allowSpectators`; S3 chỉ hiện Xem khi bàn có `matchId` và `allowSpectators = true`, thiếu cờ coi như tắt → chip "Đang chơi".

## 3. Kiểm thử

| Loại | Cách |
|---|---|
| Luật | `go test ./internal/game/games/tycoon/...` + vitest `logic/*` + `parity.test.ts` |
| Store | vitest với SDK giả, cả session máy lẫn online |
| E2E qua socket | `game/scripts/tycoon-e2e-bots.mjs` — env: `JWT_SECRET`, `TY_USERS` (JSON `[{id,name}]`), `TY_PLAYERS`, `GAME_SERVER`, `TY_JOIN_OWNER=<username>` (bot vào bàn của người đang thử trên trình duyệt), `TY_MOVE_DELAY_MS` (mặc định 80, tăng lên để kịp vào xem), `TY_FORFEIT_AFTER=<số STATE>` (bot cuối bỏ cuộc giữa ván), `TY_CHAT=1` (bot đầu gửi một tin chat + một cảm xúc). Kiểm `MATCH_OVER` đủ `rankings`, không lộ `rng`/bộ thẻ |
| Giao diện | Chạy local cổng 5174 (`GAME_SERVER=http://localhost:8083 vite …` để proxy sang server game khác; chạy server thứ hai thì phải tách Redis: `GAME_PORT=8083 REDIS_DB=7 WEBSOCKET_REDIS_DB=8 GAME_WEBSOCKET_REDIS_PREFIX=ola-game-test`, dùng chung Redis với :8082 thì kết nối socket bị treo), nhiều tab guest token (`?token=guest:a`, `guest:b`…), chụp CDP các màn S3/S5/S6/S9 ở 360 và 390 |
| Thời gian ván | Script tự chơi (như lần đo 11/11: 4 ván máy hết sau 2–6 phút, vòng 8–21) chạy lại cho bàn online 2 và 4 người |

## 4. Phát hành

1. Chạy migration `20261101000002` và `20261113000001` trên dev rồi prod **trước** khi deploy server. Các game khác không đụng cột mới (INSERT bỏ `end_reason`/`exit_reason`, chỉ ghi `end_reason` khi có), nhưng ván tycoon kết thúc sẽ lỗi settle nếu thiếu cột.
2. Deploy server, kiểm `tycoon` có trong engine.
3. Bật game trong admin (`mini_games`), build lại game web.
4. Thử trên dev với 2–4 tài khoản thật: bàn 0 KEN và bàn có cược, bỏ cuộc, rớt mạng, vào lại giữa ván.

## 5. Đã chốt khi làm (11/11, mặc định — đổi được)

- Kết nối socket ngay khi mở sảnh, không chặn: lỗi mạng thì sảnh vẫn mở, "Chơi với máy" vẫn chạy, "Vào bàn" thử nối lại.
- Chat + thả cảm xúc trong ván: nút chat ở footer (chấm đỏ khi có tin mới) mở sheet Trò chuyện; cảm xúc bay lên từ pod người gửi; ảnh cảm xúc dùng chung `caro/assets/reactions`. Chơi với máy và người xem không có.
- Step `bankrupt` có thêm `amount` (số nợ, bỏ khi bỏ cuộc) ở cả Go và `engine.ts`, fixture parity sinh lại; modal phá sản dùng số này.
- Người xem: ~~mọi bàn đang chơi xem được (như Tiến Lên), ẩn công tắc "Cho người khác xem" ở S4.~~ Từ 12/11 theo cờ `allowSpectators` của từng bàn, chủ bàn bật ở S4 (mặc định tắt).
- Trường `owner` trong `ROOM_LIST` là username, script E2E dùng `TY_JOIN_OWNER=<username>` để bot vào bàn của người đang thử trên trình duyệt.
