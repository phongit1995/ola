# 09 — Chế độ tập luyện (chơi với máy)

## 1. Phạm vi

Nút “Tập luyện” ở sảnh mở modal “Chơi với máy”:
- thêm 1–3 máy, mỗi máy chọn mức Dễ / Thường / Khó, thành bàn 2, 3 hoặc 4 người;
- bấm “Bắt đầu” thì vào bàn chơi như ván thật.

Ván tập chạy hoàn toàn trong trình duyệt của người chơi:
- không gửi gì lên server game;
- không cược, không cộng EXP, không lưu lịch sử, không tính vào bảng xếp hạng (xem `10-history-leaderboard.md`);
- server không có code riêng cho chế độ này.

Màn bàn chơi, hoạt cảnh bài bay, thông báo lượt, đồng hồ 30 giây, nút gợi ý, chat, biểu cảm và màn kết quả đều dùng lại nguyên của ván online.

## 2. Kiến trúc

```text
LobbyScreen ── PracticeSetupModal ── startPractice(bots)
                                         │
store/useThirteen.ts ── bindMatch(session) ◄── practice.ts (GameSession giả lập)
        │                                         │
 startMatch / handleState / handleMatchOver   logic/engine.ts  (luật, port từ Go)
        │                                     logic/bot.ts     (não máy 3 mức)
 TableScreen / ResultScreen                   helpers/practiceChat.ts (câu chat máy)
```

- **`practice.ts`:** `createPracticeSession({ user, bots, random? })` trả về một `GameSession<ServerState, ServerMove>` giống socket thật, theo mẫu `game/caro/bot.ts`.
  - Phát `MATCH_FOUND`, `STATE` (có `steps`), `MATCH_OVER`, `CHAT_MESSAGE`, `REACTION`, `ERROR` đúng định dạng server.
  - Nhờ vậy store không cần nhánh xử lý riêng cho bàn chơi.
- **Store:**
  - `bindMatch(source)` gắn các sự kiện ván cho cả session online lẫn session tập. Sự kiện của session không đang hoạt động bị bỏ qua.
  - `matchSession()` trả về session tập nếu đang tập, không thì session online. `playSelected`, `passTurn`, `sendChat`, `sendReaction` đều gọi qua hàm này.
  - State `practice: BotSetupItem[] | null` khác `null` nghĩa là đang ở ván tập.

## 3. Engine local (`logic/engine.ts`)

Port 1:1 từ `server/internal/game/games/thirteen/{state,move,logic}.go`:

| Hàm | Tương đương Go |
|---|---|
| `newDeal(playerCount, random)` / `dealFromDeck` | `newDeal`, chia 13 lá, người có 3♠ đi trước, không có thì người có lá nhỏ nhất |
| `instantWinKind` | `instantWinKind`: tứ quý heo, sảnh rồng, 6 đôi, 4 đôi thông |
| `checkMove` / `applyMove` | `checkMove` / `applyMove`: cờ `chop`, xếp hạng người hết bài, tự xếp người cuối |
| `skipTurn` | `OnTurnSkipped`: hết giờ khi ra bài thì đánh lá nhỏ nhất (hoặc 3♠), khi chặn thì bỏ lượt |
| `rankings` / `winnerSeat` / `isOver` | `Rankings` / `Result` |
| `viewFor(state, seat)` | `ViewFor`: chỉ lộ bài của mình, các ghế khác chỉ có số lá |
| `turnStartDelayMs` | `TurnStartDelay`: lượt đầu chờ 4 s; sau đó 400 ms + 500/lá đánh (+400 nếu chặt) + 500/dọn vòng + 600/hết bài, tối đa 3 s |

`logic/engine.test.ts` kiểm parity với fixture `server/.../thirteen/testdata/parity.json`:
- tới trắng;
- chia bài và người đi trước.

Ngoài ra test port các ca chính của `logic_test.go`, và chạy 180 ván ngẫu nhiên để chắc ván luôn kết thúc với đủ hạng.

Luật bài có đổi ở server thì phải sửa `engine.ts` theo và chạy lại test.

## 4. Não máy (`logic/bot.ts`)

`chooseBotMove(view, level, random)` nhận đúng những gì một người ngồi bàn biết:
- bài trên tay, bài trên bàn, `require3s`;
- số lá từng người;
- các lá đã ra trong ván.

**Điểm chung của mọi mức:**
- Liệt kê nước hợp lệ bằng `legalPlays` (`logic/hints.ts`, dùng chung với nút gợi ý).
- Đánh được hết bài trong một lượt thì đánh luôn.
- `planHand` chia bài thành ít lượt đánh nhất: tách heo và tứ quý, thử 3 cách (đôi thông trước, sảnh trước, bộ cùng số trước) và chọn cách ít bộ nhất, ít lá lẻ thấp nhất.
- Mỗi nước được chấm theo "phá bao nhiêu bộ" (số lượt còn lại sau khi đánh so với hiện tại).

| Mức | Hành vi |
|---|---|
| Dễ | Ra bài: ngẫu nhiên trong 3 gợi ý đầu. Chặn: 25% bỏ lượt dù chặn được, 60% đánh bộ rẻ nhất, còn lại ngẫu nhiên (kể cả heo/chặt). |
| Thường | Ra bộ thấp nhất không phá bài; giữ heo, tứ quý, đôi thông, trừ khi có người còn ≤ 2 lá, mình còn ≤ 2 lượt, hoặc bàn đang là heo (thì chặt). Có người còn 1 lá thì ra đôi/bộ hoặc lá lẻ cao. 30% lượt đi nước tốt nhì/ba, 60% giữ bài khi phải phá bộ. |
| Khó | Như Thường nhưng luôn chọn nước tốt nhất, coi "sắp hết" khi còn ≤ 3 lượt, và nhớ bài: biết bộ nào không ai còn chặn được (`bossChecker`), dùng để giữ quyền ra bài và kết thúc bằng bộ chắc thắng. Chặn lá lẻ cao khi có người còn 1 lá. |

Đo bằng 800 ván tự đánh (tỉ lệ về Nhất của ghế đang xét):

| Bàn | Tỉ lệ |
|---|---|
| 4 Dễ | 26% (mức chuẩn 25%) |
| Thường vs 3 Dễ | ~52% |
| Khó vs 3 Dễ | ~60% |
| Khó vs 3 Thường | ~33% |
| Khó vs Thường (2 người) | ~59% |

`logic/bot.test.ts` khoá các điểm trên:
- luôn đi nước hợp lệ;
- ván luôn kết thúc;
- mức cao thắng mức thấp.

Mỗi nước của máy mất dưới 40 ms.

## 5. Session tập (`practice.ts`)

- **Ghế:** mình luôn ngồi ghế 0, máy ở ghế 1..N.
  - id của máy là `bot-1..3`, tên “Máy 1..3”, avatar VIP 12 / 27 / 5.
  - `atName` không thêm `@` trước tên bắt đầu bằng “Máy ”. Nickname thật không có khoảng trắng nên không bị trùng.
- **Lượt máy:** chờ `turnStartDelayMs` để hoạt cảnh chạy xong, cộng 0,6–1,4 s "suy nghĩ", rồi đánh.
- **Lượt mình:**
  - hạn lượt = bây giờ + delay + 30 s; hết giờ thì `skipTurn` và phát `STATE` với `autoMoved`;
  - ván tập không xử thua khi treo máy.
- **Nước sai:** phát `ERROR` với `INVALID_MOVE` / `NOT_YOUR_TURN`, store hiện toast như ván thật.
- **Hết ván:** phát `MATCH_OVER` gồm `rankings` theo `userId`, không có `expGains`.
  - “Chơi lại” gọi `joinQueue()` để chia ván mới với cùng dàn máy;
  - “Về sảnh” huỷ session.
- **Chat và biểu cảm** (`helpers/practiceChat.ts`):
  - máy tự nói hoặc thả biểu cảm khi vào ván, chặt, bị chặt, bỏ lượt, về Nhất, khi mình về Nhất, khi mình ra heo;
  - mỗi máy tối đa 1 lần mỗi 4 s, có xác suất theo từng sự kiện;
  - mình chat thì một máy trả lời theo từ khoá.

## 6. Store và UI khi ở ván tập

- **Tiêu đề bàn:** “Tập luyện”.
- **Màn kết quả:** dòng nhỏ “VÁN TẬP”, hai nút “Về sảnh” / “Chơi lại”, không có pill EXP.
- **Rời ván:** hộp xác nhận ghi “Rời ván tập? Ván tập không tính điểm. Bạn muốn về sảnh?”. Rời thì huỷ session, không gọi server.
- **Không đụng tới server:** không gọi `bridge.refreshUser()` khi hết ván tập (Ken không đổi). Vẫn gọi `bridge.gameOver` để host hiện chấm báo.
- **Mất kết nối server:** không hiện lớp phủ mất kết nối trong lúc tập.
- **Có ván thật cùng lúc:** nếu server gửi `MATCH_FOUND` (ván thật đang chơi dở) trong lúc tập, store dừng ván tập, chuyển sang ván thật, và toast “Bạn đang có ván thật, đã chuyển về bàn”.

## 7. Kiểm tra

```bash
pnpm -C game exec tsc --noEmit -p .
pnpm -C game exec vitest run thirteen
```

Chạy thật bằng trang mock (vite port 5174):
- `/thirteen/mock-ui.html?screen=practice-setup`: sảnh đang mở modal chọn máy.
- `/thirteen/mock-ui.html?screen=practice&bots=easy,hard`: vào thẳng ván tập. Danh sách `bots` quyết định số máy và mức.
- Trang mock gắn `useThirteen` lên `window` để script CDP điều khiển: bấm gợi ý, `playSelected()`, `passTurn()`.
