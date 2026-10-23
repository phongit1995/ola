# 07 — Screen → store → SDK → component map

Bảng tra nhanh khi implement. Store chính `useTycoon` (pattern `useThirteen` cho N người + `useXiangqi` cho room/pregame); UI ephemeral per-screen dùng store zustand nhỏ riêng (`useLobby`, `useRanked`, `useBoard`, `useSheet`, `useResult`).

| Màn | Store state (useTycoon) | SDK gửi | SDK nghe | Component (03) |
|---|---|---|---|---|
| S1 Loading | `lobbyPhase`, `lobbyError`, progress local | — (connect) | `USER_INFO` | CTA vàng (Thử lại) |
| S2 Lobby | `lobbyVisible`, `userInfo`, `ken`, `soundOn`, `rulesOpen` | — | `USER_INFO` (bridge `KenUpdated`) | PlayerPod rút gọn, badge KEN, Buttons, RulesModal |
| S3 Danh sách bàn | `rankedVisible`, `rooms`, `roomActionPending` | `ROOM_LIST`, `ROOM_JOIN`, `ROOM_CREATE`, `SPECTATE_JOIN{matchId}` | `ROOM_LIST/UPSERT/REMOVED`, `SPECTATE_JOINED`, `ERROR` | RoomRow, Modal S4, Toast |
| S4 Modal tạo/vào | `roomActionPending('creating'\|'joining')` | `ROOM_CREATE{bet,password,maxPlayers,allowSpectators}` (11), `ROOM_JOIN` | `ROOM_WAITING`, `ERROR` | Modal, chip 2/3/4, Input |
| S5 Phòng chờ | `boardMode='pregame'`, `roomWaiting{roomId,ownerId,maxPlayers,members[]}`, `messages` | `ROOM_READY/START/LEAVE/KICK`, `CHAT_SEND(room)` | `ROOM_STATE/CLOSED/KICKED/SYNC`, `CHAT_MESSAGE` | BoardSurface (dim), SeatGrid, ActionBar pregame, NoticeModal |
| S6 Bàn chơi | `boardMode='playing'`, `match{id,you,players[]}`, `view` (05 §5.1), `phase`, `myTurn`, `deadline`, `movePending`, `landingTile`, `pathTiles`, `log[]`, `oppAway{userId→graceDeadline}`, `messages` | `MOVE{type,tile?}`, `FORFEIT`, `CHAT_SEND`, `REACTION_SEND` | `STATE`, `MATCH_FOUND(resumed)`, `OPPONENT_DIS/RECONNECTED`, `CHAT_MESSAGE`, `REACTION`, `ERROR` | Header (logo, RoundChip, âm thanh, menu), BoardSurface, Tile, Token, TurnCluster (chip lượt, TurnClock, DiceRoll, nút theo pha), PlayerPod×n, FooterBar (Tài sản, Diễn biến, dòng sự kiện), ChatDrawer, ReactionPicker, OppAwayBanner |
| S7 Sheet ô | `sheet={kind:'tile', idx}` | `MOVE BUY/DECLINE/BUILD/SELL_HOUSE` | `STATE` | BottomSheet, DeedCard, GroupChip, RentTable, OwnerChip |
| S8 Sheet tài sản | `sheet={kind:'assets', seat}` | `MOVE BUILD/SELL_HOUSE` | `STATE` | BottomSheet, group list, +/− buttons |
| S9 Kết quả | `result{rankings[],worth[],reason,expGains}`, `matchSeq` | — (`again()` → ROOM_READY) | `MATCH_OVER`, `ROOM_WAITING/STATE` (afterMatchId) | Modal result, RankRow |
| S10 Lịch sử | `history{online, bot, status}` (ván máy đọc `localStorage`) | `HISTORY` (05 §9.2) | `HISTORY{items[place, playerCount, endReason, players]}` | HistoryRow mở rộng, dải tóm tắt, skeleton |
| S11 BXH | `leaderboard{day,week,level}` (cache 60 giây mỗi tab) | `LEADERBOARD{period, board}` (05 §9.1) | `LEADERBOARD{board, items, me}` | LeaderboardRow, tabs |
| O1 Xúc xắc | `dice{values,rolling}` (từ step `roll`) | — | — | DiceRoll |
| O2 Thẻ | `card{deck,id}` (từ step `card` / view.card) | `MOVE CARD_ACK` | `STATE` | Card |
| O3 Trả nợ | `debt{creditor,amount}` khi `view.phase='debt' && view.debt.by===you` | `MOVE SELL_HOUSE/PAY_DEBT/DECLARE_BANKRUPT` | `STATE` | Modal debt |
| O4 Banner | `oppAway` | — | `OPPONENT_*` | OppAwayBanner |
| O5 Xác nhận / thông báo | `notice`, `noticeQueue` (`showNotice`/`closeNotice`) | tùy hành động | — | NoticeModal |
| O6 Toast | `toast`, `turnAnnounce` | — | `ERROR` | Toast, TurnAnnounce |
| O7 Vòng | `view.round` (step `round`) | — | — | RoundChip, banner |

## Dữ liệu tĩnh client (game/tycoon/logic/)

| Module | Nội dung | Dùng ở |
|---|---|---|
| `constants.gen.ts` | GAME_ID, START_CASH, GO_SALARY, JAIL_FINE, MAX_ROUNDS, TURN_SECONDS, enum phase/move/step — DO NOT EDIT | khắp nơi |
| `board.gen.json` | 32 ô: name, kind, group, price, rent[4] (đất trống + 3 cấp), houseCost (giá mỗi cấp) | Tile aria-label, S7, S8 |
| `cards.gen.json` | 24 thẻ: deck, id, text | O2 |
| `server-types.ts` | `decodeView` (RangeError nếu sai shape) | wireSession |
| `money.ts` | `formatMoney`, `worthOf(view, seat)` (chỉ để hiện tổng tài sản live trong S8; S9 dùng số server) | pod, sheet |
| `replay.ts` | tuần tự steps → hành động UI theo 01 §8, `replayEpoch` | S6 |
| `rules-hint.ts` | `canBuild/canSell(view, seat, tile)` → `{ok, reason}` — chỉ để enable/disable nút + lý do; không authoritative | S7, S8, O3 |
| `errorText.ts` | map mã lỗi `tycoon:*` + GAME_ERROR_CODE → tiếng Việt | toast, lý do disabled |

Không có `moves.ts`/`bot.ts`: client không mirror luật diễn tiến (gieo/đi/thuê/thẻ), không có chế độ chơi với máy ở v1.

## Bridge host (mọi màn)

`ready()` khi mount App; `turnChanged` mỗi khi `turn` đổi; `attention(YourTurn|MatchStarted|OpponentJoined|OpponentReady|OpponentLeft|RoomKicked|OpponentDisconnected|NewChat|GameOver)`; `gameOver` khi MATCH_OVER; `exit()` từ lobby; `refreshUser()` sau MATCH_OVER.

## Checklist hoàn thành từng màn

Một màn được coi là xong khi: render đúng spec 02 ở width 360/390/520 · mọi state (loading/empty/error/disabled) có UI · keyboard/focus/aria đủ (03 §17) · reduced-motion OK · text 100% tiếng Việt từ helpers/gen · không warning console · screenshot harness được cập nhật.

## Thứ tự triển khai đề xuất

1. Server: state + bảng dữ liệu + codegen → luật roll/move/buy/rent/end-turn → tù, thẻ → xây/bán → nợ/phá sản → MAX_ROUNDS/Rankings → MoveOnTimeout/OnPlayerQuit → test Go.
2. Bot E2E 4 người chạy trọn ván (chốt protocol trước khi làm UI).
3. Client: lobby/ranked/pregame (copy xiangqi, đổi token) → BoardSurface + Tile + Token tĩnh với fixture → replay steps → TurnCluster theo pha (giữa bàn) → sheet S7/S8 → O1–O3 → result/history/leaderboard.
4. Harness screenshot + QA icon theo 06 §8.
5. Phát hành: migration (không cần bảng mới — `game_match_players` đã có), row `mini_games` slug `tycoon` → `https://<GAME_DOMAIN>/tycoon/`, env `TYCOON_COMMISSION_PERCENT`, rebuild `ola-game-web`.
