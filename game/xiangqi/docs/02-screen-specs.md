# 02 — Screen specifications

Mọi số đo tại viewport logic `390 × 844`. Width hỗ trợ 360–520 px: bàn cờ scale theo `min(100vw - 30, 480)`, các khối khác dùng % + clamp. Safe area: `env(safe-area-inset-*)`, host WebView đã set `data-ola-native-safe-area` (xem `caro/main.tsx`).

Điều hướng không dùng router: mỗi màn là boolean trên store `useXiangqi` (pattern caro `App.tsx`).

---

## S1. Loading / Connecting

Hiện khi `lobbyPhase = 'loading' | 'connecting' | 'error'`, nằm trong LobbyScreen (không phải màn riêng).

### 1.1 Bố cục
- Nền gỗ gradient + logo game giữa màn (y 38%).
- Dưới logo 24 px: text `Đang tải... {n}%` (preload asset) hoặc `Đang kết nối...`.
- Progress đến từ `preloadAssets(onProgress)` — chỉ preload nhóm LOBBY_CRITICAL trước first paint.

### 1.2 Error/reconnect
- `lobbyPhase='error'`: text lỗi từ `connectToServer` (map `GameAuthenticationRequired/Expired` → tiếng Việt), nút `Thử lại` (CTA vàng 240×52) gọi lại `init()`.
- Mất mạng giữa chừng ngoài trận: toast `Mất kết nối, đang thử lại...` — socket.io tự retry.

---

## S2. Lobby

### 2.1 Cấu trúc dọc
| Vùng | y | Nội dung |
|---|---|---|
| Topbar | 0–64 | avatar + tên (trái), badge KEN (phải), nút âm thanh |
| Logo | 96–300 | logo "CỜ TƯỚNG" + minh họa 2 quân 帥/將 đối mặt |
| CTA stack | 330–560 | 3 nút dọc, cách 18 px |
| Footer | đáy − 32 | nút Thoát game (`bridge.exit()`), version nhỏ |

### 2.2 Topbar
- Avatar 40 px viền navy 1.5, tên 15/600 kem, VIP icon nếu có (`helpers/player.ts` dùng `@ola/shared/lib/vip` như caro).
- Badge KEN: nền `--xq-paper` viền navy, icon ken + số 16/800; số animate rAF 700 ms khi đổi (pattern `animateKen` caro), nhận `KenUpdated` từ host bridge.
- Nút loa 44×44 toggle âm (localStorage `ola:xiangqi:sound`).

### 2.3 CTA stack
| Nút | Style | Hành vi |
|---|---|---|
| `Chơi xếp hạng` | CTA vàng 320×64, chữ navy 17/700 | `playRanked()` → mở S3, preload nhóm ranked |
| `Lịch sử` | nút giấy kem viền navy 320×52 | mở S8 |
| `Bảng xếp hạng` | nút giấy kem viền navy 320×52 | mở S9 |

- v2 (chưa làm): `Chơi với máy` — chừa chỗ trong stack, không render.
- Hover/focus: viền dày 2 px + translateY(-1); disabled khi `lobbyPhase !== 'ready'`.

---

## S3. Danh sách bàn (RankedScreen)

Full-screen đè lobby. Copy hành vi caro `RankedScreen.tsx`.

### 3.1 Bố cục
- Header 56 px: nút back (trái), title `Bàn cờ tướng` 20/800, nút `Làm mới` (phải).
- Bảng cột: `Chủ bàn | Ken cược | Tham gia` — header 10.5% từ đỉnh vùng list.
- **9 hàng/trang cố định**, hàng cao 8.85% vùng list, absolute theo % (pattern caro, tránh reflow).
- Footer: nút `Tạo bàn` (CTA vàng) giữa, phân trang ‹ › hai bên nếu > 9 bàn.

### 3.2 Hàng bàn
- Avatar chủ bàn 32 + VIP icon, `@username` 15/600 navy, cắt ellipsis 12 ký tự.
- Cược: `formatKen(bet)` 16/800 + icon ken; bet 0 hiện `Giao hữu`.
- Icon khóa 16 khi `room.locked`.
- Badge chỗ: `1/2` (slot mở, viền jade) hoặc `2/2` (đầy, mờ 50%, nút Tham gia disabled).
- Nút `Tham gia` 88×40 CTA vàng → nếu `locked` mở modal mật khẩu (S4b), không thì `joinRoom(roomId,'')`.

### 3.3 Data & sync
- `ROOM_LIST` khi mở màn + nút Làm mới; `ROOM_UPSERT`/`ROOM_REMOVED` cập nhật realtime; auto re-sync 90–120 s jitter (pattern caro).
- Empty state: minh họa quân mờ + `Chưa có bàn nào — tạo bàn mới nhé!`.
- Lỗi join (`ROOM_BUSY`, `ROOM_NOT_FOUND`, `WRONG_PASSWORD`, `INSUFFICIENT_KEN`) → toast từ `helpers/errorText.ts`.

---

## S4. Modal Tạo bàn / Vào bàn khóa

### 4a. Tạo bàn
- Modal 330 px, radius 20, nền giấy kem, backdrop `--xq-overlay`.
- Field `Ken cược`: input số, quick-chip `0 / 100 / 500 / 1K / 5K`; validate client (`roomCreationError`): `Số Ken cược không hợp lệ`, `Bạn không đủ Ken để tạo bàn` (so với `userInfo.ken`, trần `maxBet` từ USER_INFO).
- Field `Mật khẩu (tùy chọn)`: ≤ 64 ký tự.
- Nút `Tạo bàn` (CTA vàng, loading spinner khi `roomActionPending='creating'`) + `Hủy`.
- Thành công: `ROOM_WAITING` → vào S5.

### 4b. Vào bàn khóa
- Modal nhỏ 300 px: input mật khẩu + `Vào bàn`/`Hủy`. Sai → toast `Sai mật khẩu`, giữ modal.

Focus trap + Esc đóng (dùng `helpers/dialog.ts` của caro).

---

## S5. Phòng chờ (pregame — render bên trong BoardScreen)

`boardMode='pregame'`: bàn cờ đã hiện (thế khởi đầu, mờ 40%) + panel phòng chờ nổi giữa.

### 5.1 Panel
- 340×min 300, radius 20, giấy kem viền navy 2.
- Title: `Bàn của @{owner}` + badge cược + icon khóa.
- 2 ghế ngang: mỗi ghế avatar 64 + tên + phe (`Đỏ — đi trước` cho chủ bàn/seat 0, `Đen` cho khách); ghế trống: nét đứt + `Đang chờ...` pulse.
- Trạng thái ghế: chip `Sẵn sàng` jade khi ready; chủ bàn chip `Chủ bàn` vàng.

### 5.2 Hành động (bottom bar của BoardScreen)
| Vai | Nút |
|---|---|
| Chủ bàn | `Bắt đầu` (CTA vàng, enable khi khách ready → `startRoom`), `Mời ra` (→ ConfirmModal → `kickRoomMember`), `Thoát bàn` (→ Confirm `Thoát bàn sẽ đóng phòng. Thoát chứ?`) |
| Khách | `Sẵn sàng`/`Hủy sẵn sàng` (`setRoomReady`), `Thoát bàn` (→ Confirm `Bạn sẽ rời bàn; chủ bàn vẫn ở lại...`) |

- Chat phòng: bong bóng cạnh avatar (`sendRoomChat`, `CHAT_MESSAGE`), input 1 dòng đáy panel.
- `ROOM_KICKED` → toast + về S3; `ROOM_CLOSED` → toast lý do + về S3.
- Disconnect khi pregame → reconnect bounce về S3 với toast `Kết nối bị gián đoạn, bạn đã rời bàn` (pattern caro `roomConnectionLost`).

---

## S6. Bàn chơi (`boardMode='playing'`)

### 6.1 Cấu trúc dọc
| Vùng | y | Nội dung |
|---|---|---|
| Opponent pod | 8–76 | avatar, tên, phe, đồng hồ khi tới lượt họ, quân họ đã ăn (mini) |
| Board | 90–610 | bàn 9×10, 360×400 + khung gỗ 12 px |
| My pod | 620–688 | như opponent, thêm vòng lượt gold |
| Action bar | 700–764 | Chat, Reaction, Bỏ cuộc, Thoát |
| Bet badge | góc phải trên board | `⛁ {bet}` |

### 6.2 Bàn cờ (chi tiết component xem 03 §1–§4)
- SVG code-native: lưới 9×10, cung 2 gạch chéo mỗi bên, sông trống hàng giữa với chữ `楚河` `漢界` (nét mực nâu 40%), chấm mốc vị trí Pháo/Tốt.
- Quân = absolutely-positioned button trên giao điểm; mình luôn ở dưới (Đen: render `flipIndex(i)=89-i`).
- **Tương tác**: tap quân mình → chọn (nâng + shadow lg) + chấm gợi ý từ `legalMovesFrom` (TS mirror); tap chấm/quân địch được ăn → gửi `MOVE {from,to}` + `movePending=true` (khóa input, KHÔNG optimistic — bàn chỉ đổi khi `STATE` về); tap chỗ khác/quân khác của mình → đổi chọn; tap lại quân đang chọn → bỏ chọn.
- Highlight `--xq-last-move` tại from + to nước vừa đi (từ `state.lastFrom/lastTo`).
- Replay `steps[]`: quân trượt 220 ms, quân bị ăn scale-fade; step `check` → banner `Chiếu tướng!` + viền đỏ pulse quanh Tướng bị chiếu; serialized theo `replayEpoch` (hủy khi state mới về — pattern thirteen).

### 6.3 Lượt & đồng hồ
- Vòng lượt gold quanh pod đang đi; turn announce `ĐẾN LƯỢT BẠN` khi về mình.
- Đồng hồ 30 s trong pod: `deadline` từ STATE/MATCH_FOUND, interval 250 ms, ≤10 s chuyển `--xq-danger` + pulse + tick âm.
- Hết giờ: server xử thua — client chỉ chờ `MATCH_OVER reason:'timeout'`.

### 6.4 Chat & reaction
- Nút Chat mở drawer đáy (input + 20 tin gần nhất, `sendChat`); tin mới khi đóng → chấm đỏ.
- Reaction picker 6 cảm xúc → balloon bay cạnh pod (tái dùng component + asset caro).

### 6.5 Bỏ cuộc / Thoát
- `Bỏ cuộc` → Confirm `Bạn sẽ bị xử thua ván này. Cả hai vẫn ở lại bàn. Tiếp tục?` → `forfeit(matchId)`.
- `Thoát` → Confirm `Thoát sẽ bị xử thua và rời bàn.` → `forfeit(matchId, true)` + flag `exitingMatch` (nuốt MATCH_OVER, về S3).

### 6.6 Mất kết nối
- Đối thủ rớt: O1 banner `Đối thủ mất kết nối, chờ {s}s...` từ `OPPONENT_DISCONNECTED.graceDeadline`; hồi phục → banner tắt.
- Mình rớt & quay lại: engine tự gửi `MATCH_FOUND resumed:true` → dựng lại bàn từ state (không replay steps), toast `Đã vào lại trận đấu`.

---

## S7. Kết quả (ResultScreen)

Modal lg 340 px trên backdrop, mở từ `MATCH_OVER` (giữ nguyên bàn phía sau).

### 7.1 Nội dung
- Banner kết quả: `THẮNG` (gold), `THUA` (mực), `HÒA` (kem) + minh họa quân 帥/將.
- Dòng lý do: `Chiếu bí!` / `Đối thủ hết nước đi` / `Đối thủ đầu hàng` / `Hết giờ` / `Đối thủ mất kết nối` / `Thua do chiếu dai (luật lặp thế)` / `Ván hòa (lặp thế 3 lần)` / `Ván hòa (60 nước không ăn quân)` — map từ `reason` + step cuối (`mate.reason`, `draw.reason`).
- KEN: `+{kenDelta}` jade / `−{bet}` đỏ / `Hòa — hoàn cược`; reveal delay ≈1.7 s cho animation KEN float chạy trước khi enable nút (pattern caro `revealDelayMs`).
- Nút: `Chơi lại` (về phòng chờ cùng bàn — `showWaitingRoom`, chỉ khi phòng còn) + `Đóng` (về S3).
- `preserveOutcome`: ROOM_STATE về trước khi user đóng result thì vẫn giữ màn kết quả.

---

## S8. Lịch sử (HistoryScreen)

- Full-screen, header back + title `Lịch sử đấu`.
- `getHistory()` → list: mỗi hàng avatar đối thủ, tên, kết quả chip (Thắng jade/Thua đỏ/Hòa kem), ±KEN, lý do ngắn, `formatHistoryTime`.
- 20 hàng, empty state + skeleton loading. (Không có bot-history localStorage vì v1 không có bot.)

---

## S9. Bảng xếp hạng (LeaderboardScreen)

- Tab `Tuần | Tháng | Tất cả` (`getLeaderboard(period)`, cache 3 period riêng như caro).
- Hàng: hạng (1–3 huy chương), avatar + VIP, tên, `{wins} thắng — {losses} thua`, KEN thắng ròng.
- Điều kiện: server đã thêm `xiangqi` vào whitelist leaderboard W/L (`game.repository.go:108`).

---

## O1–O3. Overlay chung

- **O1 OppAwayBanner**: thanh nổi đỉnh màn, đếm ngược grace; z trên board dưới modal.
- **O2 ConfirmModal**: 300 px, title 17/700 + 2 nút (danger đỏ khi hành vi xử thua); focus trap, Esc = hủy.
- **O3 Toast**: đáy màn trên action bar, 2.4 s, tối đa 1 toast (thay thế); Turn announce giữa màn.

## Bridge với host (web/mobile overlay)

- `bridge.ready()` khi mount; `bridge.turnChanged({yourTurn,deadline})` mỗi lượt; `bridge.gameOver(...)` khi MATCH_OVER; `bridge.attention(reason)` cho YourTurn/MatchStarted/OpponentJoined/NewChat...; nút Thoát game ở lobby → `bridge.exit()`; KEN sync 2 chiều (`KenUpdated`, `refreshUser`).
