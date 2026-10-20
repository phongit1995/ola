# 05 — Gameplay: luật v1, bàn 32 ô, thẻ bài, state, protocol

> **Hiện trạng (20/10/2026):** bản đang chạy là **chơi với máy, toàn bộ luật chạy ở client** (`game/tycoon/logic/engine.ts`, bot ở `logic/bot.ts`); chưa có package server. Các mục server / protocol / MOVE / steps bên dưới là thiết kế cho bản online — engine client đã viết theo đúng các pha, nước đi và step đó để port sang Go 1-1.

Server (`server/internal/game/games/tycoon/`) là nguồn chân lý. Client **không mirror luật diễn tiến** (khác cờ tướng): không tự tính ô đích, tiền thuê, thẻ hay kết quả — mọi số đều từ `STATE`. Client chỉ có hai thứ: (1) bảng dữ liệu tĩnh (giá, tiền thuê, tên ô, nội dung thẻ) sinh từ Go bằng codegen `constants.gen.ts` + `board.gen.json` (pattern `thirteengen`); (2) `rules-hint.ts` — hàm `canBuild/canSell(view, seat, tile)` trả `{ok, reason}` chỉ để **enable/disable nút và hiện lý do** trong S7/S8; server validate lại y hệt, parity test so khớp cả dữ liệu tĩnh lẫn `canBuild/canSell` trên fixture.

---

## 1. Bàn cờ

32 ô (lưới 9 × 9: 4 góc + 7 ô mỗi cạnh), index `0..31` **thuận chiều kim đồng hồ**, ô 0 (Xuất phát) ở **góc dưới-trái**. Từ Xuất phát đi **lên cột trái** (1→7), góc trên-trái là Nhà tù (8), sang phải theo hàng trên (9→15), góc trên-phải Lễ hội (16), xuống cột phải (17→23), góc dưới-phải Du lịch (24), rồi đi từ phải sang trái theo hàng dưới (25→31) về Xuất phát. Góc luôn ở `idx % 8 == 0`.

Loại ô (`kind`): `go`, `street`, `station`, `chance`, `chest`, `tax`, `jail`, `festival`, `travel`. Bàn 32 ô không còn tiện ích, Bãi đỗ xe và ô Vào tù (thay bằng Thuế, Lễ hội, Du lịch, thêm 1 Cơ hội — 20/10/2026). Ghi chú nhanh từng ô: [10-board-tiles.md](./10-board-tiles.md).

Đơn vị tiền: triệu (`tr`). 16 ô đất là **16 thành phố Việt Nam**, chia 8 nhóm × 2 thành phố, giá tăng dần theo chiều đi. Mỗi ô đất có **3 cấp nâng**: Cấp 1 Nhà → Cấp 2 Biệt thự → Cấp 3 Khách sạn. Cách tính giá và kết quả mô phỏng ở [09-economy.md](./09-economy.md).

| Idx | Vị trí | Tên | kind | Nhóm | Giá | Thuê đất trống / C1 / C2 / C3 | Giá mỗi cấp |
|---|---|---|---|---|---|---|---|
| 0 | góc dưới-trái | Xuất phát | go | — | — | nhận 160 khi đi qua/đáp | — |
| 1 | cột trái ↑ | Thanh Hóa | street | Nâu | 60 | 6 / 40 / 145 / 320 | 50 |
| 2 | cột trái ↑ | Khí vận | chest | — | — | — | — |
| 3 | cột trái ↑ | Vinh | street | Nâu | 80 | 8 / 45 / 160 / 340 | 50 |
| 4 | cột trái ↑ | Sân bay Nội Bài | station | Sân bay | 200 | 25 / 50 / 100 / 200 (theo số sân bay sở hữu) | — |
| 5 | cột trái ↑ | Buôn Ma Thuột | street | Xanh trời | 100 | 10 / 50 / 180 / 380 | 50 |
| 6 | cột trái ↑ | Cơ hội | chance | — | — | — | — |
| 7 | cột trái ↑ | Đà Lạt | street | Xanh trời | 120 | 12 / 60 / 200 / 400 | 50 |
| 8 | góc trên-trái | Nhà tù / Thăm tù | jail | — | — | — | — |
| 9 | hàng trên → | Cần Thơ | street | Hồng | 140 | 14 / 85 / 310 / 660 | 100 |
| 10 | hàng trên → | Thuế thu nhập | tax | — | — | đóng 10% tổng tài sản | — |
| 11 | hàng trên → | Phú Quốc | street | Hồng | 160 | 16 / 90 / 320 / 690 | 100 |
| 12 | hàng trên → | Sân bay Tân Sơn Nhất | station | Sân bay | 200 | 25 / 50 / 100 / 200 (theo số sân bay sở hữu) | — |
| 13 | hàng trên → | Quy Nhơn | street | Cam | 180 | 18 / 100 / 340 / 720 | 100 |
| 14 | hàng trên → | Khí vận | chest | — | — | — | — |
| 15 | hàng trên → | Nha Trang | street | Cam | 200 | 20 / 105 / 360 / 750 | 100 |
| 16 | góc trên-phải | Lễ hội | festival | — | — | chọn 1 thành phố của mình, thuê ô đó ×2 | — |
| 17 | cột phải ↓ | Hội An | street | Đỏ | 220 | 22 / 130 / 470 / 1.000 | 150 |
| 18 | cột phải ↓ | Cơ hội | chance | — | — | — | — |
| 19 | cột phải ↓ | Huế | street | Đỏ | 240 | 24 / 135 / 490 / 1.040 | 150 |
| 20 | cột phải ↓ | Sân bay Cam Ranh | station | Sân bay | 200 | 25 / 50 / 100 / 200 (theo số sân bay sở hữu) | — |
| 21 | cột phải ↓ | Hạ Long | street | Vàng | 260 | 26 / 145 / 500 / 1.060 | 150 |
| 22 | cột phải ↓ | Cơ hội | chance | — | — | — | — |
| 23 | cột phải ↓ | Hải Phòng | street | Vàng | 280 | 28 / 150 / 520 / 1.100 | 150 |
| 24 | góc dưới-phải | Du lịch | travel | — | — | lượt sau bay tới ô bất kỳ | — |
| 25 | hàng dưới ← | Vũng Tàu | street | Xanh lá | 300 | 30 / 175 / 630 / 1.350 | 200 |
| 26 | hàng dưới ← | Khí vận | chest | — | — | — | — |
| 27 | hàng dưới ← | Đà Nẵng | street | Xanh lá | 320 | 32 / 180 / 650 / 1.380 | 200 |
| 28 | hàng dưới ← | Sân bay Long Thành | station | Sân bay | 200 | 25 / 50 / 100 / 200 (theo số sân bay sở hữu) | — |
| 29 | hàng dưới ← | Cơ hội | chance | — | — | — | — |
| 30 | hàng dưới ← | Hà Nội | street | Xanh đậm | 350 | 35 / 190 / 680 / 1.420 | 200 |
| 31 | hàng dưới ← | TP. Hồ Chí Minh | street | Xanh đậm | 400 | 40 / 210 / 720 / 1.500 | 200 |

Hằng số: `BOARD_SIZE 32`, `START_CASH 1500`, `GO_SALARY 160`, `JAIL_FINE 50`, `JAIL_TILE 8`, `MAX_HOUSES 3` (cấp tối đa), `HOUSE_SELL_RATIO 0.5`, `MAX_ROUNDS 30`, `TIME_LIMIT_MS 25 phút`, `TAKEOVER_MULTIPLIER 2`, `WIN_GROUPS 3`, `FESTIVAL_MULTIPLIER 2`, `TAX_RATE 0.1`, `TURN_SECONDS 30`, `MAX_DOUBLES 3`, `JAIL_MAX_TURNS 3`.

Tiền thuê đất **chưa nâng cấp** khi sở hữu **trọn nhóm** (cả 2 thành phố) = ×2. Sân bay: tiền thuê theo số sân bay người chủ sở hữu (1→25, 2→50, 3→100, 4→200). Thành phố đang có Lễ hội: thuê (sau khi đã tính ×2 trọn nhóm hoặc theo cấp) ×2 nữa.

## 2. Thẻ bài

Hai bộ, mỗi bộ 12 thẻ (rút gọn từ 16 để ván ngắn và không cần luật "lùi 3 ô"). Thứ tự bộ do rng xáo lúc Init; rút từ đỉnh, trả xuống đáy; thẻ "Ra tù miễn phí" giữ trong tay người rút (ra khỏi bộ) đến khi dùng.

### 2.1 Cơ hội (`chance`, dải gold)

| id | Nội dung (live text) | Hiệu ứng |
|---|---|---|
| ch01 | Tiến đến Xuất phát. Nhận 160 tr. | `moveTo 0`, salary |
| ch02 | Đi đến TP. Hồ Chí Minh. Qua Xuất phát nhận 160 tr. | `moveTo 31` |
| ch03 | Đi đến Huế. Qua Xuất phát nhận 160 tr. | `moveTo 19` |
| ch04 | Đi đến Cần Thơ. Qua Xuất phát nhận 160 tr. | `moveTo 9` |
| ch05 | Bay đến sân bay gần nhất. Nếu có chủ, trả gấp đôi tiền thuê. | `moveToNearest station`, rentMul 2 |
| ch06 | Đi dự Lễ hội. Qua Xuất phát nhận 160 tr. | `moveTo 16` (đáp Lễ hội như bình thường) |
| ch07 | Ngân hàng trả cổ tức 50 tr. | `cash +50` |
| ch08 | Thẻ ra tù miễn phí. Giữ đến khi dùng. | `keepJailCard` |
| ch09 | Vào tù. Đi thẳng, không qua Xuất phát. | `goToJail` |
| ch10 | Bảo trì nhà cửa: 25 tr cho mỗi cấp nhà bạn đang có. | `repair 25` × tổng cấp |
| ch11 | Phạt vượt tốc độ 15 tr. | `cash −15` |
| ch12 | Bạn trúng giải xổ số 150 tr. | `cash +150` |

### 2.2 Khí vận (`chest`, dải sky)

| id | Nội dung | Hiệu ứng |
|---|---|---|
| cm01 | Tiến đến Xuất phát. Nhận 160 tr. | `moveTo 0` |
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
| cm12 | Sửa đường: 40 tr cho mỗi cấp nhà bạn đang có. | `repair 40` × tổng cấp |

`collectEach`: trừ từng người chơi còn hoạt động; ai thiếu tiền thì vào pha `debt` với chủ nợ là người rút thẻ (xử lý lần lượt theo seat, xem §4.5).

## 3. Diễn tiến một lượt

Lượt là một chuỗi pha; engine giữ lượt (`KeepTurn` = true) cho đến khi state chuyển sang người khác.

```
roll ──(gieo)──► moving ──(server tính ô đích)──► landed
landed:
  street/station chưa chủ          → decide   (BUY | DECLINE)
  có chủ (không phải mình)         → pay tự động → takeover nếu là thành phố mua lại được (TAKEOVER | DECLINE), không thì manage (hoặc debt nếu thiếu)
  của mình / jail-visit            → manage
  festival                         → festival (FESTIVAL {tile} | DECLINE) nếu có ít nhất 1 thành phố, không thì manage
  travel                           → travel = true, xoá đôi → manage; lượt sau bắt đầu ở pha travel (TRAVEL {tile} | ROLL)
  go                               → +160 → manage
  tax                              → trả 10% tổng tài sản → manage (hoặc debt)
  chance/chest                     → card (hiện thẻ, áp hiệu ứng; nếu moveTo → quay lại landed ở ô mới)
manage: BUILD / SELL_HOUSE bất kỳ số lần → END_TURN
END_TURN: nếu lượt vừa rồi gieo đôi và chưa vào tù → quay lại roll (lần 2, 3); đôi lần 3 → vào tù, hết lượt.
```

Trong tù (`inJail`): pha `jail` thay cho `roll`: `JAIL_PAY` (trả 50 → roll bình thường), `JAIL_CARD` (dùng thẻ → roll), `JAIL_ROLL` (gieo: đôi → ra tù và đi theo số đó, không gieo lại; không đôi → ở lại, `jailTurns++`, sang manage). Đến lượt thứ 3 trong tù mà vẫn không đôi → bắt buộc trả 50 (tự động, có thể vào `debt`) rồi đi theo số vừa gieo.

Pha `debt` (§4.5) chèn vào bất cứ chỗ nào phải trả tiền mà `cash < amount`.

## 4. Luật chi tiết

### 4.1 Gieo và di chuyển
- Hai xúc xắc 1–6 từ rng server. Đôi → sau END_TURN được gieo lần nữa; đôi lần 3 liên tiếp trong cùng lượt → vào tù ngay (không đi).
- Đi `sum` ô theo chiều tăng index (thuận kim đồng hồ), mod 32. Đi qua hoặc đáp ô 0 → +160 (không cộng khi bị đưa vào tù bằng thẻ). Vào tù chỉ còn qua thẻ Vào tù (ch09, cm06) và gieo đôi 3 lần.

### 4.2 Mua đất
- Đáp ô `street/station` chưa chủ: `BUY` nếu `cash ≥ price`; `DECLINE` thì ô vẫn vô chủ (v1 không đấu giá). Hết giờ = DECLINE.

### 4.3 Tiền thuê
- Đáp ô có chủ khác, chủ không phá sản: trả tự động theo bảng §1. Chủ đang **trong tù vẫn thu tiền**.
- Người đáp vào ô của mình: không trả.

### 4.3b Mua lại đất
- Trả thuê xong (không rơi vào nợ) ở ô **thành phố** (`street`) của người chơi khác còn hoạt động, ô **chưa lên Khách sạn** (cấp < 3) và `cash ≥ giá mua lại` → pha `takeover`.
- Giá mua lại = `TAKEOVER_MULTIPLIER × (giá đất + cấp × houseCost)` = ×2. Tiền trả **cho chủ cũ**; ô đổi chủ, giữ nguyên cấp nhà.
- `TAKEOVER` mua lại, `DECLINE` bỏ qua; hết giờ = `DECLINE`. Sân bay và ô Khách sạn không mua lại được. Sau đó sang `manage`.
- Bot mua lại khi việc đó giúp nó gom trọn nhóm (còn ≥ 120 tr sau khi trả), hoặc phá nhóm trọn của chủ cũ (còn ≥ 360 tr).

### 4.3c Thắng ngay
- Sau mỗi lần đổi chủ đất (`BUY`, `TAKEOVER`, nhận đất từ người phá sản) engine kiểm người vừa nhận đất: sở hữu **trọn 3 nhóm màu** (`endReason = groups`) hoặc **toàn bộ thành phố trên một cạnh bàn** (`line`; mỗi cạnh có 4 thành phố = 2 nhóm) hoặc **cả 4 sân bay** (`airports`) → thắng ngay, ván kết thúc. Bot mua ô để chặn (không cần giữ tiền dự phòng) nếu đối thủ có ô đó là thắng ngay, và mua lại ô nếu việc đó giúp chính nó thắng ngay.

### 4.3d Ô đặc biệt: Lễ hội, Du lịch, Thuế
- **Lễ hội (ô 16):** đáp vào mà có ít nhất 1 thành phố → pha `festival`. `FESTIVAL {tile}` chọn một thành phố của mình (`not_street` / `not_owner` nếu sai) → `state.festival = tile`, step `festival`. Cả bàn chỉ có **một** Lễ hội: người sau tổ chức thì Lễ hội chuyển sang ô mới. Thuê ô đang có Lễ hội ×`FESTIVAL_MULTIPLIER` (×2). Lễ hội đi theo ô khi ô đổi chủ (mua lại, nhận từ người phá sản); ô về ngân hàng thì Lễ hội mất. `DECLINE` bỏ qua; hết giờ = tự chọn thành phố có tiền thuê cao nhất (`festivalPick`). Bot chọn như hết giờ, bỏ qua nếu Lễ hội đã ở đúng ô đó.
- **Du lịch (ô 24):** đáp vào → `player.travel = true`, xoá đôi (hết lượt), step `travel`. Lượt sau bắt đầu ở pha `travel` thay cho `roll`: `TRAVEL {tile}` bay tới ô bất kỳ trừ ô đang đứng (`invalid_tile`), đi qua Xuất phát vẫn nhận 160, rồi xử lý ô đáp như thường (mua, trả thuê, mua lại, thẻ, Lễ hội…). `ROLL` = không bay, gieo bình thường. Hết giờ = `ROLL`. Bị đưa vào tù trước lượt đó thì mất quyền Du lịch. Bot chấm điểm từng ô: ô giúp nó thắng ngay > ô chặn đối thủ thắng ngay > ô gom trọn nhóm > ô trống mua được > Lễ hội > ô an toàn; tránh ô có chủ (điểm = −tiền thuê) và ô Thuế.
- **Thuế (ô 10):** trả ngân hàng `round(10% × tổng tài sản)` (tiền mặt + giá đất + tiền nâng cấp, §4.7). Thiếu tiền → `debt` với chủ nợ ngân hàng.

### 4.4 Nâng cấp và hạ cấp
- Mỗi ô đất có cấp `houses` 0–3: 0 = đất trống, 1 = Nhà, 2 = Biệt thự, 3 = Khách sạn. Tên cấp: `LEVEL_NAMES` trong `constants.ts`.
- `BUILD {tile}` = nâng 1 cấp: phải sở hữu **trọn nhóm** (cả 2 thành phố), ô là `street`, tiền ≥ giá mỗi cấp (`houseCost`), chưa ở cấp 3, và **nâng đều**: cấp ô này sau khi nâng ≤ min(cấp các ô cùng nhóm) + 1. Chỉ nâng trong pha `manage` của lượt mình. Không giới hạn số nhà của ngân hàng.
- `SELL_HOUSE {tile}` = hạ 1 cấp, nhận `houseCost × 0.5`, phải **hạ đều** (ô này sau khi hạ ≥ max(nhóm) − 1). Được hạ trong pha `manage` và pha `debt` (kể cả ngoài lượt khi bị đòi nợ bởi `collectEach`).

### 4.5 Nợ và phá sản
- Khi phải trả `amount` mà `cash < amount`: state vào `phase: debt {creditor: seat|-1, amount}`. Người nợ có 30 s để `SELL_HOUSE` nhiều lần rồi `PAY_DEBT`, hoặc `DECLARE_BANKRUPT`.
- Hết giờ: server tự bán nhà theo thứ tự giá trị giảm dần đến khi đủ; vẫn không đủ → phá sản.
- Nếu `cash + 0.5 × tổng nhà < amount` ngay từ đầu → phá sản ngay (không chờ).
- Phá sản: `bankrupt[seat] = true`, `bankruptOrder` nối thêm seat. Tiền mặt còn lại + toàn bộ đất (nhà bị bán hết trước, tiền bán gộp vào) chuyển cho **chủ nợ** nếu là người chơi; nếu chủ nợ là ngân hàng (Thuế, thẻ, sửa chữa) thì đất về **vô chủ** (không đấu giá). Quân rời bàn.
- Người phá sản không còn lượt; nếu đang là lượt của họ, chuyển lượt luôn.

### 4.6 Người chơi rời ván / hết giờ liên tiếp
- Engine gọi `OnPlayerQuit` khi FORFEIT, hết grace reconnect 30 s, hoặc 3 lần hết giờ liên tiếp (engine `MaxConsecutiveTimeouts`). Game xử lý y hệt phá sản với chủ nợ = ngân hàng (đất về vô chủ) để tránh người còn lại được lợi bất công từ việc một người thoát.
- Nếu còn ≥ 2 người hoạt động, ván tiếp tục (`QuitHandler`); engine chỉ kết thúc ván khi `Result` báo over.

### 4.7 Kết thúc ván
| Tình huống | Kết quả | `MATCH_OVER.reason` | `rankings` |
|---|---|---|---|
| Thắng ngay (§4.3c) | người đó thắng (`winner`, `endReason = groups \| line \| airports`) | `win` | người thắng, rồi người còn lại theo tài sản, rồi `bankruptOrder` đảo ngược |
| Chỉ còn 1 người chưa phá sản (`last`) | người đó thắng | `win` | người thắng, rồi `bankruptOrder` đảo ngược |
| Hết `MAX_ROUNDS` = 30 vòng (`rounds`, kiểm tra ở END_TURN của người cuối cùng trong vòng) | xếp theo **tổng tài sản** giảm dần | `win` | tài sản giảm dần, hòa tài sản → ít phá sản hơn, rồi seat thấp hơn; người phá sản xếp cuối theo thứ tự phá sản đảo |
| Hết 25 phút tính từ đầu ván (`time`) | như hết vòng | `win` | như hết vòng. Kết thúc ở **đầu lượt kế tiếp** sau khi hết giờ (không cắt giữa lượt). Bản chơi với máy đếm giờ ở client (`endByTime`); bản online server đếm |
| 2 người, 1 người quit/forfeit | người còn lại thắng | `forfeit`/`timeout`/`disconnect` | engine quyết |

`Tổng tài sản = cash + Σ price(đất sở hữu) + Σ cấp × houseCost`. Khách sạn (cấp 3) tính 3 × houseCost.

`winnerIdx` trả về trong `Result` = `rankings[0]`. Không có hòa.

### 4.8 Vòng
`round` tăng khi END_TURN của người chơi có seat lớn nhất còn hoạt động (sau khi engine chuyển lượt về seat nhỏ nhất). Vòng bắt đầu từ 1. Client hiện `Vòng r/30 · mm:ss` (giờ còn lại của 25 phút, đổi đỏ khi còn ≤ 3 phút); từ vòng 28 chip đổi coral; vòng 30 hiện banner "Vòng cuối!".

## 5. State server (JSON — snapshot Redis, full state không bao giờ gửi client)

```jsonc
{
  "players": [
    { "cash": 1500, "pos": 0, "inJail": false, "jailTurns": 0, "jailCards": 0,
      "bankrupt": false, "doubles": 0, "quit": false, "travel": false }
  ],                                   // dài = playerCount (2..4)
  "tiles": [ { "owner": -1, "houses": 0 } ],   // 32 phần tử; owner = seat | -1; houses = cấp 0–3
  "turn": 0,                           // seat tới lượt
  "phase": "roll",                     // roll|jail|decide|takeover|festival|travel|manage|debt|card
  "dice": [0, 0],                      // lần gieo gần nhất của lượt
  "debt": null,                        // {creditor, amount, by} khi phase=debt
  "card": null,                        // {deck, id} khi phase=card (chờ ACK)
  "festival": -1,                      // idx thành phố đang có Lễ hội, -1 = chưa có
  "chanceDeck": [3, 7, 0, ...],        // id còn lại theo thứ tự rút — ẨN
  "chestDeck": [...],                  // ẨN
  "rng": "<uint64 splitmix64>",        // ẨN
  "round": 1,
  "bankruptOrder": [],
  "moveCount": 0,
  "steps": []                          // replay lượt vừa apply, không tích lũy
}
```

`StateVersion()` = 1. `DecodeState` phải reject: số người ngoài 2..4, `tiles` ≠ 32, `owner` ngoài −1..n−1, `houses` > 3, `phase` lạ, state đã kết thúc.

### 5.1 View gửi client (`ViewFor`)

Giống state nhưng **bỏ** `rng`, `chanceDeck`, `chestDeck`; thêm `you`, `chanceLeft`, `chestLeft` (số thẻ còn trong bộ, để UI hiện chồng thẻ). `card` chỉ có khi đang hiện thẻ. Mọi người chơi nhận cùng view trừ `you` — game không có thông tin riêng ngoài rng/bộ thẻ.

## 6. Lệnh MOVE

`MOVE {matchId, move: {type, tile?}}`. Engine chỉ chấp nhận từ `turn` (trừ ngoại lệ §6.1).

| type | Pha hợp lệ | tile | Ghi chú |
|---|---|---|---|
| `ROLL` | roll, travel | — | ở pha travel = bỏ quyền bay, gieo bình thường |
| `JAIL_PAY` / `JAIL_CARD` / `JAIL_ROLL` | jail | — | CARD cần `jailCards > 0` |
| `BUY` / `DECLINE` | decide | — | |
| `TAKEOVER` / `DECLINE` | takeover | — | luật §4.3b; lỗi `tycoon:takeover_hotel` / `tycoon:not_takeover` / `tycoon:no_cash` |
| `FESTIVAL` / `DECLINE` | festival | idx (FESTIVAL) | luật §4.3d; lỗi `tycoon:not_street` / `tycoon:not_owner` |
| `TRAVEL` | travel | idx | luật §4.3d; lỗi `tycoon:invalid_tile` nếu là ô đang đứng |
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
| `TimeoutMover` | `MoveOnTimeout`: roll→`ROLL`, jail→`JAIL_ROLL` (lượt 3: `JAIL_PAY`), decide→`DECLINE`, takeover→`DECLINE`, festival→`FESTIVAL` ô thuê cao nhất, travel→`ROLL`, card→`CARD_ACK`, manage→`END_TURN`, debt→tự hạ cấp nhà rồi `PAY_DEBT` hoặc `DECLARE_BANKRUPT` | engine vẫn đếm 3 lần liên tiếp → quit |
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
| `move` | by, from, to, passedGo | quân nhảy từng ô; passedGo → nháy ô 0 + float +160 |
| `teleport` | by, from, to | quân bay cung (thẻ moveTo, vào tù) |
| `land` | by, tile | fill `--ty-landing`, mở sheet nếu decide |
| `pay` | from (seat\|-1), to (seat\|-1), amount, reason: rent\|tax\|card\|fine\|repair\|birthday\|buy\|build\|sell\|salary\|takeover | đếm số pod, chip bay giữa pod; −1 = ngân hàng (bay từ/đến giữa bàn) |
| `buy` | by, tile | chấm chủ sở hữu pop |
| `takeover` | by, tile, target (chủ cũ), houses | chấm chủ đổi màu, log "X mua lại ô của Y" |
| `festival` | by, tile | viền vàng + huy hiệu ngôi sao trên ô, log "X tổ chức Lễ hội ở …" |
| `travel` | by, tile (24) | log "X được đi Du lịch" |
| `card` | by, deck, id | O2 lật thẻ (text từ bảng gen) |
| `jail-in` / `jail-out` | by, how: dice3\|card \| pay\|card\|double\|forced | quân vào/ra ô 8, badge song sắt trên pod |
| `build` / `sell` | by, tile, houses (cấp sau khi nâng/hạ) | chấm nhà pop/fade |
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

- Go table-driven: gieo đôi ×3 vào tù, qua Xuất phát (kể cả đáp đúng ô 0; thẻ di chuyển và Du lịch bay qua ô 0 cũng cộng, bị đưa vào tù thì không), tiền thuê từng loại (nhóm trọn ×2, sân bay 1–4, Lễ hội ×2), Thuế 10% tài sản, Du lịch (bay qua Xuất phát nhận lương, ROLL bỏ quyền bay, vào tù mất quyền), xây/bán đều, nợ → bán tự động → phá sản, chuyển đất cho chủ nợ/ngân hàng, `collectEach` với con nợ ngoài lượt (NextTurn tạm), MAX_ROUNDS xếp hạng tài sản + tie-break, DecodeState reject, `MoveOnTimeout` mọi pha, `OnPlayerQuit` giữa pha debt.
- Codegen: `go generate ./internal/game/games/tycoon` → `game/tycoon/logic/constants.gen.ts` + `board.gen.json` + `cards.gen.json` + `testdata/parity.json` (vitest chỉ kiểm dữ liệu tĩnh khớp Go).
- E2E: `game/scripts/tycoon-e2e-bots.mjs` — 4 bot (mua nếu đủ tiền, xây khi trọn nhóm, END_TURN) chạy tới khi ván kết thúc (thắng ngay / phá sản / 30 vòng), assert MATCH_OVER có 4 rankings, tổng tiền hệ thống hợp lý; cần `JWT_SECRET` + `TL_USERS` như thirteen.
- UI: harness `tycoon/mock-ui.html?screen=<tên>&state=<fixture>` + `scripts/tycoon-shots.mjs` (pattern xiangqi).
