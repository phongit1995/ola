# 05 — Gameplay: luật v1, bàn 40 ô, thẻ bài, state, protocol

Server (`server/internal/game/games/tycoon/`) là nguồn chân lý. Client **không mirror luật diễn tiến** (khác cờ tướng): không tự tính ô đích, tiền thuê, thẻ hay kết quả — mọi số đều từ `STATE`. Client chỉ có hai thứ: (1) bảng dữ liệu tĩnh (giá, tiền thuê, tên ô, nội dung thẻ) sinh từ Go bằng codegen `constants.gen.ts` + `board.gen.json` (pattern `thirteengen`); (2) `rules-hint.ts` — hàm `canBuild/canSell(view, seat, tile)` trả `{ok, reason}` chỉ để **enable/disable nút và hiện lý do** trong S7/S8; server validate lại y hệt, parity test so khớp cả dữ liệu tĩnh lẫn `canBuild/canSell` trên fixture.

---

## 1. Bàn cờ

40 ô, index `0..39` theo chiều kim đồng hồ, ô 0 ở góc dưới-phải. Cạnh dưới đi từ phải sang trái (0→10), cạnh trái đi lên (10→20), cạnh trên sang phải (20→30), cạnh phải đi xuống (30→39).

Loại ô (`kind`): `go`, `street`, `station`, `utility`, `chance`, `chest`, `tax`, `jail`, `parking`, `gotojail`.

Đơn vị tiền: triệu (`tr`). Giá trị dùng thang chuẩn board game cổ điển ×1 để cân bằng đã được kiểm chứng; chỉ đổi tên.

| Idx | Tên | kind | Nhóm | Giá | Tiền thuê 0/1/2/3/4 nhà/KS | Giá nhà |
|---|---|---|---|---|---|---|
| 0 | Xuất phát | go | — | — | nhận 200 khi đi qua/đáp | — |
| 1 | Phố Hiến | street | Nâu | 60 | 2 / 10 / 30 / 90 / 160 / 250 | 50 |
| 2 | Khí vận | chest | — | — | — | — |
| 3 | Phố cổ Hội An | street | Nâu | 60 | 4 / 20 / 60 / 180 / 320 / 450 | 50 |
| 4 | Thuế thu nhập | tax | — | — | trả 200 | — |
| 5 | Ga Hà Nội | station | Bến | 200 | 25 / 50 / 100 / 200 (theo số bến sở hữu) | — |
| 6 | Sa Pa | street | Xanh trời | 100 | 6 / 30 / 90 / 270 / 400 / 550 | 50 |
| 7 | Cơ hội | chance | — | — | — | — |
| 8 | Mộc Châu | street | Xanh trời | 100 | 6 / 30 / 90 / 270 / 400 / 550 | 50 |
| 9 | Ninh Bình | street | Xanh trời | 120 | 8 / 40 / 100 / 300 / 450 / 600 | 50 |
| 10 | Nhà tù / Thăm tù | jail | — | — | — | — |
| 11 | Cần Thơ | street | Hồng | 140 | 10 / 50 / 150 / 450 / 625 / 750 | 100 |
| 12 | Nhà máy điện | utility | Tiện ích | 150 | 4× / 10× tổng xúc xắc | — |
| 13 | Phú Quốc | street | Hồng | 140 | 10 / 50 / 150 / 450 / 625 / 750 | 100 |
| 14 | Hạ Long | street | Hồng | 160 | 12 / 60 / 180 / 500 / 700 / 900 | 100 |
| 15 | Sân bay Tân Sơn Nhất | station | Bến | 200 | 25 / 50 / 100 / 200 | — |
| 16 | Hải Phòng | street | Cam | 180 | 14 / 70 / 200 / 550 / 750 / 950 | 100 |
| 17 | Khí vận | chest | — | — | — | — |
| 18 | Huế | street | Cam | 180 | 14 / 70 / 200 / 550 / 750 / 950 | 100 |
| 19 | Nha Trang | street | Cam | 200 | 16 / 80 / 220 / 600 / 800 / 1000 | 100 |
| 20 | Bãi đỗ xe | parking | — | — | không có gì xảy ra | — |
| 21 | Đà Lạt | street | Đỏ | 220 | 18 / 90 / 250 / 700 / 875 / 1050 | 150 |
| 22 | Cơ hội | chance | — | — | — | — |
| 23 | Đà Nẵng | street | Đỏ | 220 | 18 / 90 / 250 / 700 / 875 / 1050 | 150 |
| 24 | Quy Nhơn | street | Đỏ | 240 | 20 / 100 / 300 / 750 / 925 / 1100 | 150 |
| 25 | Cảng Hải Phòng | station | Bến | 200 | 25 / 50 / 100 / 200 | — |
| 26 | Biên Hòa | street | Vàng | 260 | 22 / 110 / 330 / 800 / 975 / 1150 | 150 |
| 27 | Thủ Dầu Một | street | Vàng | 260 | 22 / 110 / 330 / 800 / 975 / 1150 | 150 |
| 28 | Nhà máy nước | utility | Tiện ích | 150 | 4× / 10× tổng xúc xắc | — |
| 29 | Vũng Tàu | street | Vàng | 280 | 24 / 120 / 360 / 850 / 1025 / 1200 | 150 |
| 30 | Vào tù | gotojail | — | — | đi thẳng ô 10 | — |
| 31 | Đồng Khởi | street | Xanh lá | 300 | 26 / 130 / 390 / 900 / 1100 / 1275 | 200 |
| 32 | Nguyễn Huệ | street | Xanh lá | 300 | 26 / 130 / 390 / 900 / 1100 / 1275 | 200 |
| 33 | Khí vận | chest | — | — | — | — |
| 34 | Thủ Thiêm | street | Xanh lá | 320 | 28 / 150 / 450 / 1000 / 1200 / 1400 | 200 |
| 35 | Bến xe Miền Đông | station | Bến | 200 | 25 / 50 / 100 / 200 | — |
| 36 | Cơ hội | chance | — | — | — | — |
| 37 | Hồ Gươm | street | Xanh đậm | 350 | 35 / 175 / 500 / 1100 / 1300 / 1500 | 200 |
| 38 | Thuế xa xỉ | tax | — | — | trả 100 | — |
| 39 | Hồ Tây | street | Xanh đậm | 400 | 50 / 200 / 600 / 1400 / 1700 / 2000 | 200 |

Hằng số: `START_CASH 1500`, `GO_SALARY 200`, `JAIL_FINE 50`, `MAX_HOUSES 4` (+1 = khách sạn), `HOUSE_SELL_RATIO 0.5`, `MAX_ROUNDS 20`, `TURN_SECONDS 30`, `MAX_DOUBLES 3`, `JAIL_MAX_TURNS 3`.

Tiền thuê đất **chưa xây** khi sở hữu **trọn nhóm** = ×2. Bến: tiền thuê theo số bến người chủ sở hữu (1→25, 2→50, 3→100, 4→200). Tiện ích: 1 tiện ích → 4 × tổng xúc xắc, cả 2 → 10 ×.

## 2. Thẻ bài

Hai bộ, mỗi bộ 12 thẻ (rút gọn từ 16 để ván ngắn và không cần luật "lùi 3 ô"). Thứ tự bộ do rng xáo lúc Init; rút từ đỉnh, trả xuống đáy; thẻ "Ra tù miễn phí" giữ trong tay người rút (ra khỏi bộ) đến khi dùng.

### 2.1 Cơ hội (`chance`, dải gold)

| id | Nội dung (live text) | Hiệu ứng |
|---|---|---|
| ch01 | Tiến đến Xuất phát. Nhận 200 tr. | `moveTo 0`, salary |
| ch02 | Đi đến Hồ Tây. Qua Xuất phát nhận 200 tr. | `moveTo 39` |
| ch03 | Đi đến Đà Lạt. Qua Xuất phát nhận 200 tr. | `moveTo 21` |
| ch04 | Đi đến Cần Thơ. Qua Xuất phát nhận 200 tr. | `moveTo 11` |
| ch05 | Đi đến bến gần nhất. Nếu có chủ, trả gấp đôi tiền thuê. | `moveToNearest station`, rentMul 2 |
| ch06 | Đi đến tiện ích gần nhất. Nếu có chủ, trả 10 × xúc xắc. | `moveToNearest utility`, rent 10× |
| ch07 | Ngân hàng trả cổ tức 50 tr. | `cash +50` |
| ch08 | Thẻ ra tù miễn phí. Giữ đến khi dùng. | `keepJailCard` |
| ch09 | Vào tù. Đi thẳng, không qua Xuất phát. | `goToJail` |
| ch10 | Sửa chữa toàn bộ nhà: 25 tr/nhà, 100 tr/khách sạn. | `repair 25/100` |
| ch11 | Phạt vượt tốc độ 15 tr. | `cash −15` |
| ch12 | Bạn trúng giải xổ số 150 tr. | `cash +150` |

### 2.2 Khí vận (`chest`, dải sky)

| id | Nội dung | Hiệu ứng |
|---|---|---|
| cm01 | Tiến đến Xuất phát. Nhận 200 tr. | `moveTo 0` |
| cm02 | Ngân hàng tính nhầm, bạn nhận 200 tr. | `cash +200` |
| cm03 | Viện phí 100 tr. | `cash −100` |
| cm04 | Hoàn thuế 20 tr. | `cash +20` |
| cm05 | Thẻ ra tù miễn phí. Giữ đến khi dùng. | `keepJailCard` |
| cm06 | Vào tù. Đi thẳng, không qua Xuất phát. | `goToJail` |
| cm07 | Sinh nhật bạn! Mỗi người chơi mừng 10 tr. | `collectEach 10` |
| cm08 | Hoàn tiền bảo hiểm 100 tr. | `cash +100` |
| cm09 | Học phí 50 tr. | `cash −50` |
| cm10 | Nhận thừa kế 100 tr. | `cash +100` |
| cm11 | Bán hàng được 50 tr. | `cash +50` |
| cm12 | Sửa đường: 40 tr/nhà, 115 tr/khách sạn. | `repair 40/115` |

`collectEach`: trừ từng người chơi còn hoạt động; ai thiếu tiền thì vào pha `debt` với chủ nợ là người rút thẻ (xử lý lần lượt theo seat, xem §4.5).

## 3. Diễn tiến một lượt

Lượt là một chuỗi pha; engine giữ lượt (`KeepTurn` = true) cho đến khi state chuyển sang người khác.

```
roll ──(gieo)──► moving ──(server tính ô đích)──► landed
landed:
  street/station/utility chưa chủ  → decide   (BUY | DECLINE)
  có chủ (không phải mình)         → pay tự động → manage   (hoặc debt nếu thiếu)
  của mình / parking / jail-visit  → manage
  go                               → +200 → manage
  tax                              → trả → manage (hoặc debt)
  chance/chest                     → card (hiện thẻ, áp hiệu ứng; nếu moveTo → quay lại landed ở ô mới)
  gotojail                         → vào tù → end (mất quyền gieo lại kể cả đôi)
manage: BUILD / SELL_HOUSE bất kỳ số lần → END_TURN
END_TURN: nếu lượt vừa rồi gieo đôi và chưa vào tù → quay lại roll (lần 2, 3); đôi lần 3 → vào tù, hết lượt.
```

Trong tù (`inJail`): pha `jail` thay cho `roll`: `JAIL_PAY` (trả 50 → roll bình thường), `JAIL_CARD` (dùng thẻ → roll), `JAIL_ROLL` (gieo: đôi → ra tù và đi theo số đó, không gieo lại; không đôi → ở lại, `jailTurns++`, sang manage). Đến lượt thứ 3 trong tù mà vẫn không đôi → bắt buộc trả 50 (tự động, có thể vào `debt`) rồi đi theo số vừa gieo.

Pha `debt` (§4.5) chèn vào bất cứ chỗ nào phải trả tiền mà `cash < amount`.

## 4. Luật chi tiết

### 4.1 Gieo và di chuyển
- Hai xúc xắc 1–6 từ rng server. Đôi → sau END_TURN được gieo lần nữa; đôi lần 3 liên tiếp trong cùng lượt → vào tù ngay (không đi).
- Đi `sum` ô theo chiều tăng index, mod 40. Đi qua hoặc đáp ô 0 → +200 (không cộng khi bị đưa vào tù bằng thẻ/ô 30).

### 4.2 Mua đất
- Đáp ô `street/station/utility` chưa chủ: `BUY` nếu `cash ≥ price`; `DECLINE` thì ô vẫn vô chủ (v1 không đấu giá). Hết giờ = DECLINE.

### 4.3 Tiền thuê
- Đáp ô có chủ khác, chủ không phá sản: trả tự động theo bảng §1. Chủ đang **trong tù vẫn thu tiền**.
- Người đáp vào ô của mình: không trả.

### 4.4 Xây và bán
- `BUILD {tile}`: phải sở hữu **trọn nhóm**, ô là `street`, tiền ≥ giá nhà, và **xây đều**: số nhà ô này sau khi xây ≤ min(nhà các ô cùng nhóm) + 1. Nhà thứ 5 = khách sạn (hiện `houses = 5`). Chỉ xây trong pha `manage` của lượt mình. Không giới hạn số nhà ngân hàng (bỏ luật 32 nhà/12 khách sạn cho đơn giản).
- `SELL_HOUSE {tile}`: bán 1 nhà (khách sạn → 4 nhà) nhận `houseCost × 0.5`, phải **bán đều** (ô này sau khi bán ≥ max(nhóm) − 1). Được bán trong pha `manage` và pha `debt` (kể cả ngoài lượt khi bị đòi nợ bởi `collectEach`).

### 4.5 Nợ và phá sản
- Khi phải trả `amount` mà `cash < amount`: state vào `phase: debt {creditor: seat|-1, amount}`. Người nợ có 30 s để `SELL_HOUSE` nhiều lần rồi `PAY_DEBT`, hoặc `DECLARE_BANKRUPT`.
- Hết giờ: server tự bán nhà theo thứ tự giá trị giảm dần đến khi đủ; vẫn không đủ → phá sản.
- Nếu `cash + 0.5 × tổng nhà < amount` ngay từ đầu → phá sản ngay (không chờ).
- Phá sản: `bankrupt[seat] = true`, `bankruptOrder` nối thêm seat. Tiền mặt còn lại + toàn bộ đất (nhà bị bán hết trước, tiền bán gộp vào) chuyển cho **chủ nợ** nếu là người chơi; nếu chủ nợ là ngân hàng (thuế, thẻ, sửa chữa) thì đất về **vô chủ** (không đấu giá). Quân rời bàn.
- Người phá sản không còn lượt; nếu đang là lượt của họ, chuyển lượt luôn.

### 4.6 Người chơi rời ván / hết giờ liên tiếp
- Engine gọi `OnPlayerQuit` khi FORFEIT, hết grace reconnect 30 s, hoặc 3 lần hết giờ liên tiếp (engine `MaxConsecutiveTimeouts`). Game xử lý y hệt phá sản với chủ nợ = ngân hàng (đất về vô chủ) để tránh người còn lại được lợi bất công từ việc một người thoát.
- Nếu còn ≥ 2 người hoạt động, ván tiếp tục (`QuitHandler`); engine chỉ kết thúc ván khi `Result` báo over.

### 4.7 Kết thúc ván
| Tình huống | Kết quả | `MATCH_OVER.reason` | `rankings` |
|---|---|---|---|
| Chỉ còn 1 người chưa phá sản | người đó thắng | `win` | người thắng, rồi `bankruptOrder` đảo ngược |
| Hết `MAX_ROUNDS` (kiểm tra ở END_TURN của người cuối cùng trong vòng) | xếp theo **tổng tài sản** giảm dần | `win` | tài sản giảm dần, hòa tài sản → ít phá sản hơn, rồi seat thấp hơn; người phá sản xếp cuối theo thứ tự phá sản đảo |
| 2 người, 1 người quit/forfeit | người còn lại thắng | `forfeit`/`timeout`/`disconnect` | engine quyết |

`Tổng tài sản = cash + Σ price(đất sở hữu) + Σ houses × houseCost`. Khách sạn tính 5 × houseCost.

`winnerIdx` trả về trong `Result` = `rankings[0]`. Không có hòa.

### 4.8 Vòng
`round` tăng khi END_TURN của người chơi có seat lớn nhất còn hoạt động (sau khi engine chuyển lượt về seat nhỏ nhất). Vòng bắt đầu từ 1. Client hiện `Vòng r/20`; từ vòng 18 chip đổi coral; vòng 20 hiện banner "Vòng cuối!".

## 5. State server (JSON — snapshot Redis, full state không bao giờ gửi client)

```jsonc
{
  "players": [
    { "cash": 1500, "pos": 0, "inJail": false, "jailTurns": 0, "jailCards": 0,
      "bankrupt": false, "doubles": 0, "quit": false }
  ],                                   // dài = playerCount (2..4)
  "tiles": [ { "owner": -1, "houses": 0 } ],   // 40 phần tử; owner = seat | -1
  "turn": 0,                           // seat tới lượt
  "phase": "roll",                     // roll|jail|decide|manage|debt|card
  "dice": [0, 0],                      // lần gieo gần nhất của lượt
  "debt": null,                        // {creditor, amount, by} khi phase=debt
  "card": null,                        // {deck, id} khi phase=card (chờ ACK)
  "chanceDeck": [3, 7, 0, ...],        // id còn lại theo thứ tự rút — ẨN
  "chestDeck": [...],                  // ẨN
  "rng": "<uint64 splitmix64>",        // ẨN
  "round": 1,
  "bankruptOrder": [],
  "moveCount": 0,
  "steps": []                          // replay lượt vừa apply, không tích lũy
}
```

`StateVersion()` = 1. `DecodeState` phải reject: số người ngoài 2..4, `tiles` ≠ 40, `owner` ngoài −1..n−1, `houses` > 5, `phase` lạ, state đã kết thúc.

### 5.1 View gửi client (`ViewFor`)

Giống state nhưng **bỏ** `rng`, `chanceDeck`, `chestDeck`; thêm `you`, `chanceLeft`, `chestLeft` (số thẻ còn trong bộ, để UI hiện chồng thẻ). `card` chỉ có khi đang hiện thẻ. Mọi người chơi nhận cùng view trừ `you` — game không có thông tin riêng ngoài rng/bộ thẻ.

## 6. Lệnh MOVE

`MOVE {matchId, move: {type, tile?}}`. Engine chỉ chấp nhận từ `turn` (trừ ngoại lệ §6.1).

| type | Pha hợp lệ | tile | Ghi chú |
|---|---|---|---|
| `ROLL` | roll | — | |
| `JAIL_PAY` / `JAIL_CARD` / `JAIL_ROLL` | jail | — | CARD cần `jailCards > 0` |
| `BUY` / `DECLINE` | decide | — | |
| `CARD_ACK` | card | — | đóng thẻ; hết 6 s client tự gửi |
| `BUILD` | manage | idx | luật §4.4 |
| `SELL_HOUSE` | manage, debt | idx | |
| `PAY_DEBT` | debt | — | cần `cash ≥ amount` |
| `DECLARE_BANKRUPT` | debt | — | |
| `END_TURN` | manage | — | |

Sai pha → `INVALID_MOVE` với message mã hóa `tycoon:wrong_phase`; sai luật xây → `tycoon:build_uneven` / `tycoon:not_group_owner` / `tycoon:no_cash`; client map sang tiếng Việt trong `helpers/errorText.ts`.

### 6.1 Nợ ngoài lượt (`collectEach`)

Thẻ "Sinh nhật" có thể khiến người **không tới lượt** thiếu tiền. Vì engine chỉ nhận MOVE từ `turn`, game giải quyết bằng `TurnOrder.NextTurn`: khi thẻ tạo nợ cho seat k, state đặt `phase: debt`, `debt.by = k`, và `NextTurn` trả về k (lượt tạm chuyển sang con nợ, `turn` lưu người gốc trong `debt.returnTo`). Sau `PAY_DEBT`/`DECLARE_BANKRUPT`, `NextTurn` trả lượt về `returnTo` ở pha `manage`. Mỗi lần chuyển lượt engine cấp đồng hồ 30 s mới. Đây là cách duy nhất không phải sửa engine; đấu giá/trao đổi ở v2 dùng cùng cơ chế.

## 7. Mapping interface engine (`internal/game/logic`)

| Interface | Tycoon | Ghi chú |
|---|---|---|
| `GameLogic` | ID `tycoon`, `Init` không dùng (xem PlayerInit), `Result` theo §4.7 | |
| `PlayerCounter` | Min 2, Max 4 | |
| `PlayerInit` | `InitPlayers(seed, n)`: rng từ seed, xáo 2 bộ thẻ, cash 1500, pos 0 | |
| `TurnKeeper` | `KeepTurn` = `turn` chưa đổi sau Apply | giữ lượt cả chuỗi pha; đôi → giữ tiếp |
| `TurnOrder` | `NextTurn` = `state.turn` (game tự tính seat kế tiếp, bỏ qua phá sản/quit; dùng cho §6.1) | như thirteen |
| `TurnTimer` | 30 s | mỗi MOVE hợp lệ cấp lại 30 s vì engine reset deadline sau Apply |
| `TimeoutMover` | `MoveOnTimeout`: roll→`ROLL`, jail→`JAIL_ROLL` (lượt 3: `JAIL_PAY`), decide→`DECLINE`, card→`CARD_ACK`, manage→`END_TURN`, debt→tự bán nhà rồi `PAY_DEBT` hoặc `DECLARE_BANKRUPT` | engine vẫn đếm 3 lần liên tiếp → quit |
| `TimeoutSkipper` | **không implement** (skip lượt làm hỏng chuỗi pha) | |
| `TurnSkipHandler` | không cần | |
| `StateViewer` | `ViewFor` §5.1 | kéo theo chặn spectate (§9) |
| `QuitHandler` | `OnPlayerQuit` = phá sản chủ nợ ngân hàng §4.6 | |
| `Ranker` | `Rankings` §4.7 | `MATCH_OVER.rankings` cho màn kết quả |
| `TurnStartDelayer` | 0 cho pha trong cùng lượt; 600 ms khi đổi người (turn announce) | |

Commission: `TYCOON_COMMISSION_PERCENT` (default 5) khai báo sẵn trong settlement map dù v1 bet = 0, để v2 không đụng config.

## 8. steps[] — animation script

Server nối `steps` cho mỗi Apply (kể cả `MoveOnTimeout`); client replay tuần tự rồi mới cập nhật UI từ state cuối.

| kind | fields | Client render |
|---|---|---|
| `roll` | by, dice[2], double | O1 lăn xúc xắc, badge Đôi |
| `move` | by, from, to, passedGo | quân nhảy từng ô; passedGo → nháy ô 0 + float +200 |
| `teleport` | by, from, to | quân bay cung (thẻ moveTo, vào tù) |
| `land` | by, tile | fill `--ty-landing`, mở sheet nếu decide |
| `pay` | from (seat\|-1), to (seat\|-1), amount, reason: rent\|tax\|card\|fine\|repair\|birthday\|buy\|build\|sell | đếm số pod, chip bay giữa pod; −1 = ngân hàng (bay từ/đến giữa bàn) |
| `buy` | by, tile | chấm chủ sở hữu pop |
| `card` | by, deck, id | O2 lật thẻ (text từ bảng gen) |
| `jail-in` / `jail-out` | by, how: dice3\|card\|tile \| pay\|card\|double\|forced | quân vào/ra ô 10, badge song sắt trên pod |
| `build` / `sell` | by, tile, houses (sau) | chấm nhà pop/fade |
| `debt` | by, creditor, amount | O3 cho con nợ; pod pulse coral cho người khác |
| `bankrupt` | by, creditor, tilesTransferred[] | pod mờ, chấm chủ đổi màu/mất |
| `round` | round | chip vòng đổi số; banner vòng cuối |
| `finish` | rankings[], worth[] | chuyển S9 sau MATCH_OVER |

Resume (`MATCH_FOUND.resumed`): `steps` null, dựng bàn từ view, không animation; nếu `phase = card` hiện thẻ ngay; nếu `phase = debt` và `you = debt.by` mở O3.

## 9. Socket protocol (SDK `game/src/sdk` — dùng nguyên)

Kết nối `joinGame('tycoon')`. Flow phòng/trận giống xiangqi (ROOM_* → MATCH_FOUND → MOVE/STATE → MATCH_OVER → ROOM_WAITING/ROOM_STATE afterMatchId), với `maxPlayers` 2–4 (`ROOM_CREATE {bet: 0, password, maxPlayers}`), `MATCH_FOUND.players` dài 2–4, `you` = seat.

- `STATE.turn` = seat tới lượt; `deadline` cấp lại sau mỗi MOVE hợp lệ (vì KeepTurn vẫn qua `applyTurn`). Client khóa thao tác khi hết giờ local.
- `OPPONENT_DISCONNECTED.userId` xác định ai rớt (nhiều người) → O4 ghi tên; `OPPONENT_RECONNECTED {turn, deadline}` đồng bộ lại đồng hồ.
- `MATCH_OVER.rankings[]` + `expGains[]` dùng cho S9; `kenDelta` = 0 ở v1; `winnerId` = hạng 1.
- **Spectate**: engine trả `SPECTATE_NOT_SUPPORTED` cho game có `StateViewer` (`engine.go:237`). v2 muốn xem trận thì sửa engine: cho `StateViewer` nhận `playerIdx = -1` nghĩa là khán giả, và bỏ guard trong `spectate.go`. Không làm trong v1.

## 10. State machine client (store `useTycoon`)

```
lobby(loading→connecting→ready|error)
  → ranked (room list)
    → pregame (ROOM_WAITING/ROOM_STATE, 2–4 ghế)
      → playing (MATCH_FOUND)
          [replay(steps) → idle(phase, myTurn)]*
          sheet: tile | assets | debt | card
        → result (MATCH_OVER, rankings)
          → pregame (Chơi lại) | ranked (Đóng)
```

Bất biến:
- Không optimistic: bàn/tiền render duy nhất từ view server; `movePending` chặn double-send.
- `handledMatchIds` dedupe MATCH_FOUND/OVER (cap 64 — pattern caro).
- `refs.session` guard mọi handler; `exitingMatch` nuốt MATCH_OVER khi chủ động thoát.
- Dữ liệu tĩnh (tên ô, giá, thuê, thẻ) đọc từ `constants.gen.ts`/`board.gen.json` — không hardcode trong component.
- Text lý do/lỗi từ `helpers/errorText.ts`.

## 11. Kiểm thử

- Go table-driven: gieo đôi ×3 vào tù, qua Xuất phát (kể cả đáp đúng ô 0, teleport không cộng), tiền thuê từng loại (nhóm trọn ×2, bến 1–4, tiện ích 4×/10×), xây/bán đều, nợ → bán tự động → phá sản, chuyển đất cho chủ nợ/ngân hàng, `collectEach` với con nợ ngoài lượt (NextTurn tạm), MAX_ROUNDS xếp hạng tài sản + tie-break, DecodeState reject, `MoveOnTimeout` mọi pha, `OnPlayerQuit` giữa pha debt.
- Codegen: `go generate ./internal/game/games/tycoon` → `game/tycoon/logic/constants.gen.ts` + `board.gen.json` + `cards.gen.json` + `testdata/parity.json` (vitest chỉ kiểm dữ liệu tĩnh khớp Go).
- E2E: `game/scripts/tycoon-e2e-bots.mjs` — 4 bot (mua nếu đủ tiền, xây khi trọn nhóm, END_TURN) chạy trọn 20 vòng, assert MATCH_OVER có 4 rankings, tổng tiền hệ thống hợp lý; cần `JWT_SECRET` + `TL_USERS` như thirteen.
- UI: harness `tycoon/mock-ui.html?screen=<tên>&state=<fixture>` + `scripts/tycoon-shots.mjs` (pattern xiangqi).
