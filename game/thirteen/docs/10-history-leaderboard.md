# 10 — Lịch sử chơi và Bảng xếp hạng

## 1. Phạm vi

Ở sảnh, ngay dưới nút "Tập luyện", có 2 nút:
- **"Lịch sử":** mở màn Lịch sử chơi, gồm tối đa 100 ván online gần nhất của mình.
- **"Xếp hạng":** mở màn Bảng xếp hạng, theo 3 kỳ Hôm nay / Tuần này / Tháng này, tối đa top 100.

Cả hai lấy dữ liệu từ server game (bảng `game_matches` và `game_match_players`). Ván tập với máy chạy trong trình duyệt nên **không** có trong lịch sử và **không** được tính vào bảng xếp hạng.

Giao diện xem `02-screen-specs.md` mục 3.8 và 3.9; class và asset xem `06-screen-to-asset-map.md` mục 4.1.

## 2. Giao thức

Dùng lại 2 lệnh socket có sẵn cho mọi game (`server/internal/game/server.go`):

| Client gửi | Server trả | Ghi chú |
|---|---|---|
| `HISTORY` | `HISTORY` `{ items, error? }` | ván của người gửi, mới nhất trước |
| `LEADERBOARD` `{ period }` | `LEADERBOARD` `{ period, from, to, items, error? }` | `period` là `day` / `week` / `month`; giá trị lạ được coi là `day` |

Mỗi `MatchHistoryEntry` có thêm 3 field so với bản 2 người cũ. Chỉ thêm, nên Caro / Cờ tướng / War God không bị ảnh hưởng.
- `playerCount`: số người trong ván.
- `place`: hạng của mình. Bằng 0 nếu ván không có xếp hạng (hòa, hoặc hệ thống không ghi được hạng).
- `players`: `{ userId, username, vipType?, place? }[]` của cả bàn, xếp theo hạng rồi tới ghế.

`opponentId` / `opponentName` vẫn được điền bằng người đầu tiên trong `players` khác mình.

## 3. Lịch sử: cách server tính

`Repository.MatchHistory` (`server/internal/game/game.repository.go`):

1. **Tìm ván**, gồm cả bàn 2 người lẫn bàn nhiều người:
   ```sql
   player0_id = me OR player1_id = me
   OR (player_count > 2 AND EXISTS (SELECT 1 FROM game_match_players WHERE game_match_id = id AND user_id = me))
   ```
   Chỉ lấy ván đã xong (`status = finished`), không phải `void`, chưa xoá. Sắp `finished_at` giảm dần, `LIMIT 100`.
2. **Lấy ghế:** với các ván hơn 2 người, chạy thêm **một** truy vấn `game_match_players JOIN users WHERE game_match_id IN (...)` để lấy tên, VIP còn hạn và `place` của từng ghế.
3. **Ván 2 người** lấy luôn `player0` / `player1`: người thắng hạng 1, người kia hạng 2, hòa thì không có hạng.
4. **Ken của mình:**
   - người về Nhất: `ken_delta` của ván, tức tiền ròng sau hoa hồng (`winnerAmountsFor`: thắng cả `bet × số người` trừ hoa hồng, rồi trừ cược của mình);
   - người khác: `-bet`;
   - hòa: 0.

Trước đây truy vấn chỉ tìm theo `player0_id` / `player1_id`, nên ở bàn 3–4 người, người ngồi ghế 3 và 4 không thấy ván của mình.

## 4. Bảng xếp hạng: luật

Xếp theo **số ván về Nhất** trong kỳ, giống Caro và Cờ tướng.

| Thứ tự | Tiêu chí |
|---|---|
| 1 | nhiều ván Nhất hơn đứng trên |
| 2 | bằng nhau thì ít ván thua hơn (ván không về Nhất) đứng trên |
| 3 | rồi tới Ken thắng nhiều hơn |
| 4 | rồi tới tên, id |

- **Chỉ người có ít nhất 1 ván Nhất trong kỳ mới có tên trên bảng.**
- **Kỳ** theo giờ Việt Nam (GMT+7), tính từ đầu kỳ tới hiện tại:
  - Hôm nay: từ 0h hôm nay;
  - Tuần này: từ 0h thứ Hai;
  - Tháng này: từ 0h ngày 1.

Tiến Lên có nhánh truy vấn riêng (`gameID == thirteen.GameID`): mỗi ván được tách thành danh sách ghế.
```sql
CROSS JOIN LATERAL (
  SELECT user_id FROM game_match_players WHERE game_match_id = game_matches.id AND game_matches.player_count > 2
  UNION ALL
  SELECT v.user_id FROM (VALUES (player0_id), (player1_id)) v(user_id) WHERE game_matches.player_count <= 2
) AS seats
```

Từ danh sách ghế:
- `wins` = số ghế là `winner_id` (người về Nhất);
- `losses` = số ghế còn lại;
- `ken` = tổng `ken_delta` của ván thắng.

Ván hòa hoặc không có người thắng không được tính. Caro / War God / Cờ tướng vẫn dùng truy vấn cũ theo `winner_id` / `loser_id`. Với bàn hơn 2 người, `loser_id` luôn `NULL`, nên trước đây Nhì / Ba / Bét không bị tính ván thua.

Kỳ `month` thêm ở `normalizeLeaderboardPeriod` / `leaderboardRangeAt`. Server cũ không biết `month` và trả về `period: "day"`; client bỏ qua câu trả lời đó và báo lỗi sau 8 s. Vì vậy **phải deploy server game trước** rồi mới deploy client.

## 5. Client

- **Store** (`store/useThirteen.ts`):
  - state `overlay: 'history' | 'leaderboard' | null`, `history`, `leaderboard` (gồm `period`, `from`);
  - hàm `openHistory`, `retryHistory`, `openLeaderboard`, `setLeaderboardPeriod`, `closeOverlay`.
  - Mỗi lần mở hoặc đổi kỳ đều gửi lại lệnh (không cache).
  - Không có trả lời sau `RECORD_REQUEST_TIMEOUT_MS` (8 s) thì báo lỗi kèm "Thử lại".
  - Câu trả lời của kỳ khác kỳ đang xem bị bỏ qua.
  - Chỉ mở được khi đang ở sảnh. Tự đóng khi vào bàn chờ (`ROOM_STATE`) hoặc vào ván (`MATCH_FOUND`).
  - Session tập luyện để trống `getHistory` / `getLeaderboard`.
- **Helper thuần** (`helpers/history.ts`, có test):
  - `historyPlace`: hạng, nhãn, tông huy chương; không có `place` thì suy từ `outcome`;
  - `historyTablemates`: người cùng bàn; server cũ thì lấy `opponent*`;
  - `historyKenDelta`, `formatSignedKen` (dấu trừ thật `−`);
  - `formatPlayedAt`: Hôm nay / Hôm qua / dd/MM, khác năm thì thêm năm;
  - `leaderboardGames`, `periodCaption`.
- **Màn** (`screens/records/`): `RecordScreen` (khung, header, trạng thái tải / lỗi / trống), `HistoryScreen`, `LeaderboardScreen`. Render ở `App.tsx`, trên sảnh và dưới toast / modal / màn kết quả.

## 6. Admin

Admin > Trò chơi > Mini game có 3 tab: Danh sách game, Lịch sử trận PvP, Level người chơi; trang Thống kê ở `/games/matches/stats`. API ở `server/internal/modules/admin/game-match/`. Đoạn SQL "mọi ghế của ván" (`constants.GameMatchSeatsSubquery`) và điều kiện "ván có người này" (`constants.GameMatchHasUserCondition`) nằm ở `server/internal/constants/game.go`, dùng chung với server game.

- **Lịch sử trận:**
  - mỗi trận trả thêm `playerCount` và `players` (`user`, `seat`, `place`);
  - cột "Người chơi" hiện cả bàn, mỗi người một dòng; bàn 3–4 người có nhãn Nhất / Nhì / Ba / Bét, người thắng có cúp;
  - cột Game ghi thêm "Bàn N người";
  - lọc theo User ID tìm được cả người ngồi ghế 3–4.
- **Tiền** (bàn N người, cược `bet`):
  - Ken qua kèo = `bet × N`;
  - hoa hồng = `bet × (N − 1) − ken_delta` (bàn 2 người vẫn ra `bet − ken_delta` như cũ);
  - trả về người chơi = qua kèo − hoa hồng.
- **Người chơi duy nhất, top người chơi:** đếm mọi ghế. Người không về Nhất ở ván có người thắng tính 1 ván thua và `−bet`.
- **Cặp nghi vấn:** ghép mọi cặp trong cùng bàn (bàn 4 người ra 6 cặp). "Độ một chiều" chỉ tính trên các ván mà một trong hai người thắng.

## 7. Kiểm tra

```bash
cd server && go test ./internal/game/... ./internal/modules/admin/game-match/
pnpm -C game exec tsc --noEmit -p .
pnpm -C game exec vitest run thirteen
```

**Trang mock** (vite port 5174), không cần server:
- `/thirteen/mock-ui.html?screen=history`: ván 2 / 3 / 4 người, thắng / thua, có / không cược, tên dài;
- `history-empty`, `history-error`, `history-loading`;
- `leaderboard`: bấm tab để đổi kỳ; kỳ tháng có 30 người, hàng của mình ở hạng 17;
- `leaderboard-empty`, `leaderboard-error`.

**Với server local:**
1. Chạy `node scripts/thirteen-e2e-bots.mjs` (4 bot trọn ván) để có ván thật.
2. Mở Tiến Lên bằng JWT của người ngồi ghế 3 hoặc 4: Lịch sử phải có ván đó với đủ 4 người đúng hạng.
3. Xếp hạng phải tính 1 ván Nhất cho người thắng và 1 ván thua cho 3 người còn lại.

Bot kết nối lại ngay sau ván trước có thể nhận `MATCH_OVER` phát lại của ván cũ (cơ chế khôi phục kết quả). Đừng nhầm đó là một ván mới.
