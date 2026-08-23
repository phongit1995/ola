# 05 — Gameplay: luật cờ tướng VN, state machine, protocol

Server (`server/internal/game/games/xiangqi/`) là nguồn chân lý. Client mirror luật CHỈ để gợi ý nước đi + hiển thị; parity test Go↔TS bắt buộc xanh.

---

## 1. Bàn cờ và ký hiệu

- 90 giao điểm: `idx = y*9 + x`, x ∈ [0,9), y ∈ [0,10). **y=0 là hàng cuối của Đỏ** (player 0, đi trước); sông giữa y=4/y=5; cung x ∈ [3,5], Đỏ y ∈ [0,2], Đen y ∈ [7,9].
- Mã quân: `0` trống; `1..7` Đỏ = Tướng, Sĩ, Tượng, Mã, Xe, Pháo, Tốt; `8..14` Đen cùng thứ tự. `pieceSide(p)=(p-1)/7`, `pieceKind(p)=(p-1)%7+1`.
- Alphabet debug: `.KAEHRCPkaehrcp` (hoa = Đỏ).
- Thế khởi đầu (hàng y=0 → y=9): `RHEAKAEHR / ......... / .C.....C. / P.P.P.P.P / ......... / ......... / p.p.p.p.p / .c.....c. / ......... / rheakaehr`.
- Client phía Đen chỉ lật hiển thị `flipIndex(i) = 89 - i`; mọi index gửi server là canonical.

## 2. Luật đi quân (theo Luật Cờ Tướng — Liên đoàn Cờ VN)

| Quân | Nước đi | Ràng buộc |
|---|---|---|
| Tướng (帥/將) | 1 bước ngang/dọc | không rời cung; không được để 2 Tướng nhìn nhau trên cùng cột không có quân cản (**lộ mặt tướng**) |
| Sĩ (仕/士) | 1 bước chéo | không rời cung (5 điểm) |
| Tượng (相/象) | chéo đúng 2 điểm | không qua sông; bị cản khi có quân đứng **mắt tượng** (điểm chéo giữa) |
| Mã (傌/馬) | ngang/dọc 1 rồi chéo 1 | bị cản khi có quân đứng **chân mã** (điểm ngang/dọc kề theo hướng đi) |
| Xe (俥/車) | ngang/dọc tự do | dừng trước quân cản; ăn quân địch đầu tiên trên đường |
| Pháo (炮/砲) | đi như Xe khi không ăn | **ăn phải nhảy qua đúng 1 quân** (ngòi, màu nào cũng được); không ăn kề không ngòi, không nhảy 2 ngòi, không đáp lên ngòi |
| Tốt (兵/卒) | 1 bước tiến | chưa qua sông: chỉ tiến; qua sông: tiến hoặc ngang; **không bao giờ lùi**; đến hàng cuối chỉ còn đi ngang |

**Tính hợp lệ đầy đủ**: một nước hợp lệ khi (1) đúng kiểu đi của quân, (2) không ăn quân mình, (3) sau nước đi Tướng mình **không bị chiếu**, (4) sau nước đi **không lộ mặt tướng** (kể cả khi quân di chuyển chính là ngòi đang che giữa 2 Tướng). Client dùng `legalMovesFrom` (đã lọc 3–4) để hiện gợi ý; server validate lại y hệt.

## 3. Kết thúc ván

| Tình huống | Kết quả | `MATCH_OVER.reason` | Chi tiết bước cuối |
|---|---|---|---|
| Chiếu bí (không nước nào thoát chiếu) | bên tới lượt **thua** | `win` | step `mate` reason `checkmate` |
| Hết nước đi không bị chiếu (khốn tử/stalemate) | bên tới lượt **thua** (luật cờ tướng, khác cờ vua) | `win` | step `mate` reason `stalemate` |
| **Chiếu dai**: thế lặp lần 3, trong chu kỳ lặp một bên chiếu ở MỌI nước của mình còn bên kia không | bên chiếu dai **thua** (luật VN — chặn ép hòa) | `win` | step `mate` reason `perpetual` |
| Lặp thế 3 lần, không rơi vào chiếu dai một chiều (cả hai cùng chiếu hoặc không bên nào) | **hòa** | `draw` | step `draw` reason `repetition` |
| 60 nước đôi (120 ply) không quân nào bị ăn | **hòa** | `draw` | step `draw` reason `halfmove` |
| Hết 30 s không đi | thua ngay | `timeout` | engine xử, không qua Apply |
| Bỏ cuộc | thua ngay | `forfeit` | engine (`FORFEIT`) |
| Rớt mạng quá 30 s grace | thua | `disconnect` | engine |

Ưu tiên cùng ply: mate/stalemate > phân xử lặp thế > 60-nước. Lặp thế = cùng bàn cờ + cùng bên tới lượt; thế xuất hiện lần đầu tính là lần 1 (thế khởi đầu cũng được đếm); bộ đếm lặp và đồng hồ 60-nước **reset khi có quân bị ăn**.

V2 (chưa làm): đuổi dai quân không được bảo vệ (xử như chiếu dai), nút cầu hòa, xin đi lại.

## 4. Cược & thanh toán

- Bet do chủ bàn đặt khi tạo bàn (0 = giao hữu); escrow khi vào trận.
- Thắng: `payout = 2*bet − commission` (`XIANGQI_COMMISSION_PERCENT`, default 5%), `kenDelta = payout − bet`; thua `−bet`; **hòa: hoàn cược cả hai, kenDelta 0**.
- Client tính hiển thị: `draw → 'Hòa — hoàn cược'`, `won → +kenDelta`, `lost → −bet` (công thức caro `useCaro.ts:669`).
- `HISTORY` cũng trả `kenDelta` **có dấu theo người xem** (thắng `bet − commission`, thua `−bet`, hòa `0`); màn Lịch sử phải dùng field này, không được hiển thị `±bet`.

## 5. State server (JSON — snapshot Redis mỗi nước, client nhận qua STATE)

```jsonc
{
  "board": [90 int],          // mã quân §1
  "moveCount": 12,             // bên tới lượt = moveCount % 2 (0 Đỏ)
  "halfmoveClock": 7,          // ply từ lần ăn quân cuối (>=120 → hòa)
  "history": ["<key91>", ...],// positionKey các thế từ lần ăn cuối (kể cả hiện tại)
  "historyChecks": [false, ...], // song song history: nước dẫn tới thế này có chiếu
  "lastFrom": 81, "lastTo": 72,  // -1 trước nước đầu
  "check": false,              // bên tới lượt đang bị chiếu (UI banner khi resume)
  "steps": [ ... ]             // CHỈ nước vừa đi (không tích lũy); null khi resume
}
```

`positionKey` = 90 ký tự alphabet + 1 ký tự bên đi (`r`/`b`). Client `server-types.ts` decode phòng thủ (throw RangeError nếu sai shape — pattern thirteen).

### steps[] — animation script

| kind | fields | Client render |
|---|---|---|
| `move` | from, to, piece | trượt quân 220 ms + âm `place` |
| `capture` | from, to, piece, captured | trượt + quân bị ăn scale-fade + âm `capture` + cập nhật CapturedTray |
| `check` | — | CheckBanner + viền đỏ Tướng + âm `check` |
| `mate` | reason: checkmate\|stalemate\|perpetual | (MATCH_OVER theo sau) — dòng lý do màn kết quả |
| `draw` | reason: repetition\|halfmove | như trên |

Replay serialized theo `replayEpoch` (hủy khi có STATE/match mới — pattern `useThirteen.ts`); nước của chính mình replay nhanh (skip delay).

## 6. Socket protocol (SDK `game/src/sdk` — dùng nguyên, không sửa)

Kết nối: `joinGame('xiangqi')` — token qua bridge/`?token=`, `auth:{token, gameId:'xiangqi', name?}`.

### Flow phòng & trận

```
ROOM_LIST ⇄ ROOM_UPSERT/ROOM_REMOVED            (S3 realtime)
ROOM_CREATE {bet,password} → ROOM_WAITING + ROOM_STATE   (S5)
ROOM_JOIN {roomId,password} → ROOM_STATE (cả phòng)
ROOM_READY {ready} → ROOM_STATE
ROOM_START (chủ bàn) → MATCH_FOUND {you, state, turn, deadline, bet}
MOVE {matchId, move:{from,to}} → STATE {state, turn, deadline, lastMove, lastBy}
                               ↘ ERROR {INVALID_MOVE|NOT_YOUR_TURN} → toast
FORFEIT {matchId, leaveAfter?}
MATCH_OVER {winnerId, reason, state, bet, payout, kenDelta}
→ ROOM_WAITING/ROOM_STATE (rematch cùng bàn — preserveOutcome giữ màn kết quả)
```

### Sự cố & resume

- Đối thủ rớt: `OPPONENT_DISCONNECTED {graceDeadline, turnRemainingMs}` → O1; `OPPONENT_RECONNECTED` → tắt.
- Mình rớt, reconnect: engine TỰ gửi `MATCH_FOUND {resumed:true}` (bàn dựng từ state, steps null, không animation) hoặc `MATCH_OVER` buffer (TTL 2 phút) nếu ván đã kết thúc; ngoài trận thì `ROOM_SYNC` khôi phục/clear phòng. Vì steps rỗng, resume phải đọc `state.check` để tăng `checkSeq` → banner `Chiếu tướng!` + viền Tướng, nếu không người chơi vào lại mà không biết đang bị chiếu.
- Server restart: engine tự khôi phục từ Redis — client không làm gì thêm.
- `MOVE` sau deadline bị drop im lặng — client phải khóa input khi hết giờ local để tránh cảm giác "nuốt nước".

### Phụ trợ

`CHAT_SEND`/`CHAT_MESSAGE`, `REACTION_SEND`/`REACTION` (6 loại), `LEADERBOARD {period}`, `HISTORY`, `USER_INFO {ken, maxBet, vip...}` khi connect.

## 7. State machine client (store `useXiangqi`)

```
lobby(loading→connecting→ready|error)
  → ranked (room list)
    → pregame (ROOM_WAITING/ROOM_STATE, boardMode='pregame')
      → playing (MATCH_FOUND, boardMode='playing')
          [selecting → moveSent(movePending) → replay(steps) → idle]*
        → result (MATCH_OVER; preserveOutcome)
          → pregame (Chơi lại, phòng còn) | ranked (Đóng/phòng đóng)
```

Bất biến:
- Không optimistic: board render duy nhất từ `state` server; `movePending` chặn double-send.
- `handledMatchIds` dedupe MATCH_FOUND/OVER (Set cap 64 — pattern caro).
- `refs.session` guard mọi handler sau khi đổi session; `exitingMatch` nuốt MATCH_OVER khi chủ động thoát.
- Mọi text lý do/lỗi lấy từ map `helpers/errorText.ts` — không hardcode rải rác.

## 8. Kiểm thử luật (tham chiếu plan chính)

- Go: table-driven từng quân (chân mã 4 hướng, mắt tượng, ngòi pháo 0/1/2, tốt biên/cuối bàn, lộ mặt tướng, ngòi bị ghim), chiếu/chiếu bí/khốn tử, chiếu dai 1 chiều = thua / 2 chiều = hòa, 120 ply, DecodeState reject state hỏng/terminal.
- Parity: `go generate ./internal/game/games/xiangqi` sinh `constants.gen.ts` + `testdata/parity.json`; vitest `logic/parity.test.ts` chạy lại bằng TS mirror.
- E2E server-vs-server: `xiangqi-e2e-bots.mjs` (2 bot legal-random ưu tiên ăn quân, cap 200 ply) — CHƯA làm. Đây là harness giao thức, khác bot luyện tập local đã có trong client.
- UI: harness `xiangqi/mock-ui.html?screen=<tên>` (store thật + dữ liệu giả, không cần server) và `node scripts/xiangqi-shots.mjs` tạo cục bộ toàn bộ state theo [hướng dẫn screenshot](./screenshots/README.md).
