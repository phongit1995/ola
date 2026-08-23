# 06 — Screen → store → SDK → component map

Bảng tra nhanh khi implement: mỗi màn cần state gì, bắn/nghe event nào, dùng component nào. Store chính `useXiangqi` (pattern `useCaro`); UI ephemeral per-screen dùng store zustand nhỏ riêng (`useLobby`, `useRanked`, `useBoard`, `useResult`, ...).

| Màn | Store state (useXiangqi) | SDK gửi | SDK nghe | Component (03) |
|---|---|---|---|---|
| S1 Loading | `lobbyPhase`, `lobbyError`, progress local | — (connect) | `USER_INFO` | CTA vàng (Thử lại) |
| S2 Lobby | `lobbyVisible`, `userInfo`, `ken`, `soundOn` | — | `USER_INFO` (bridge `KenUpdated`) | PlayerPod rút gọn, BetBadge KEN, Buttons |
| S3 Danh sách bàn | `rankedVisible`, `rooms`, `roomActionPending` | `ROOM_LIST`, `ROOM_JOIN`, `ROOM_CREATE` | `ROOM_LIST/UPSERT/REMOVED`, `ERROR` | RoomRow, Modal S4, Toast |
| S4 Modal tạo/vào bàn | `roomActionPending('creating'\|'joining')` | `ROOM_CREATE`, `ROOM_JOIN` | `ROOM_WAITING`, `ERROR` | Modal, Input, quick-chip |
| S5 Phòng chờ | `boardMode='pregame'`, `roomWaiting{roomId,ownerId,bet,members}`, `messages` | `ROOM_READY/START/LEAVE/KICK`, `CHAT_SEND(room)` | `ROOM_STATE/CLOSED/KICKED/SYNC`, `CHAT_MESSAGE` | BoardSurface (dimmed), panel ghế, ActionBar pregame, ConfirmModal |
| S6 Bàn chơi | `boardMode='playing'`, `match{id,you,bet}`, `board[90]`, `selected`, `hints[]`, `lastFrom/To`, `myTurn`, `deadline`, `movePending`, `capturedMine/Opp`, `check`, `oppAway`, `messages` | `MOVE{from,to}`, `FORFEIT`, `CHAT_SEND`, `REACTION_SEND` | `STATE`, `MATCH_FOUND(resumed)`, `OPPONENT_DIS/RECONNECTED`, `CHAT_MESSAGE`, `REACTION`, `ERROR` | BoardSurface, Piece, MoveHintDot, LastMoveMarker, CheckBanner, PlayerPod+TurnClock+CapturedTray, BetBadge, ActionBar, ChatDrawer, ReactionPicker, OppAwayBanner |
| S7 Kết quả | `result{outcome,kenDelta,reason,revealDelayMs}`, `matchSeq` | — (`again()` → ROOM_READY flow) | `MATCH_OVER`, `ROOM_WAITING/STATE` (preserveOutcome) | Modal result, fx, Buttons |
| S8 Lịch sử | `historyData/loading/error` | `HISTORY` | `HISTORY` | HistoryRow, skeleton |
| S9 BXH | `leaderboard{day,week}` | `LEADERBOARD{period}` | `LEADERBOARD` | LeaderboardRow, tabs |
| O1 Banner | `oppAway(graceDeadline)` | — | `OPPONENT_*` | OppAwayBanner |
| O2 Confirm | `notice{title,body,onOk}` | tùy hành động | — | ConfirmModal |
| O3 Toast | `toast`, `turnAnnounce` | — | `ERROR` | Toast, TurnAnnounce |
| O4 Chơi với máy | `gameMode='bot'`, `botDifficulty`, `botPlayerSide`, `botThinking` | — | — | BotSetupModal, BoardScreen, ResultScreen |

## Logic thuần client (game/xiangqi/logic/)

| Module | Hàm | Dùng ở |
|---|---|---|
| `board.ts` | `idx/xy`, `flipIndex`, `pieceSide/Kind`, `inPalace`, `crossedRiver`, `positionKey`, `parseBoard` | S6 render + test |
| `moves.ts` | `legalMovesFrom` (sorted), `inCheck`, `generalsFacing`, `hasLegalMove` | S6 hints, SR announce |
| `local-game.ts` | state/apply, chiếu bí, khốn tử, lặp thế, chiếu dai, 120 ply | O4 luật ván local |
| `bot.ts` | sinh nước hợp lệ, lượng giá, alpha-beta theo 3 độ khó | O4 nước đi của máy |
| `pieces.ts` | label VN + glyph Hán theo kind | aria-label, tooltip, CapturedTray, S8 |
| `server-types.ts` | `decodeServerState` (RangeError) | wireSession STATE/MATCH_FOUND |
| `constants.gen.ts` | GAME_ID, TURN_SECONDS, StartBoard, mã quân... | khắp nơi — DO NOT EDIT |

## Bridge host (mọi màn)

`ready()` khi mount App; `turnChanged` mỗi applyTurn; `attention(YourTurn|MatchStarted|OpponentJoined|OpponentReady|OpponentLeft|RoomKicked|OpponentDisconnected|NewChat|GameOver)`; `gameOver` khi MATCH_OVER; `exit()` từ lobby; `refreshUser()` sau MATCH_OVER để host cập nhật KEN.

## Checklist hoàn thành từng màn

Một màn được coi là xong khi: render đúng spec 02 ở width 360/390/520 · mọi state (loading/empty/error/disabled) có UI · keyboard/focus/aria đủ (03 §16) · reduced-motion OK · text 100% tiếng Việt từ helpers · không warning console · screenshot E2E được cập nhật.
