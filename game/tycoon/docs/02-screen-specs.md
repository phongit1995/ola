# 02 — Screen specifications

Mọi số đo tại viewport logic `390 × 844`. Width hỗ trợ 360–520 px: bàn cờ vuông `min(100vw − 24, 480)`, các khối khác dùng % + clamp. Safe area: `env(safe-area-inset-*)`, host WebView đã set `data-ola-native-safe-area` (xem `caro/main.tsx`).

Điều hướng không dùng router: mỗi màn là boolean/enum trên store `useTycoon` (pattern caro `App.tsx`). Sheet (S7, S8, O3) là lớp trượt lên đè S6, không phải màn riêng.

---

## S1. Loading / Connecting

Hiện khi `lobbyPhase = 'loading' | 'connecting' | 'error'`, nằm trong LobbyScreen.

- Nền navy gradient + logo giữa màn (y 38%).
- Dưới logo 24 px: `Đang tải... {n}%` hoặc `Đang kết nối...`.
- Preload chỉ nhóm LOBBY_CRITICAL trước first paint (04 §5).
- `lobbyPhase='error'`: text lỗi map tiếng Việt, nút `Thử lại` (CTA vàng 240×52) gọi lại `init()`.

---

## S2. Lobby

### 2.1 Cấu trúc dọc
| Vùng | y | Nội dung |
|---|---|---|
| Topbar | 0–64 | avatar + tên (trái), badge KEN (phải), nút âm thanh |
| Logo | 96–300 | logo "CỜ TỶ PHÚ" + minh họa 2 quân cờ trên 3 ô bàn |
| CTA stack | 330–580 | 4 nút dọc, cách 16 px |
| Footer | đáy − 32 | nút Thoát game (`bridge.exit()`), version nhỏ |

### 2.2 CTA stack
| Nút | Style | Hành vi |
|---|---|---|
| `Vào bàn` | CTA vàng 320×64, chữ navy 17/700 | `openRanked()` → S3, preload nhóm RANKED |
| `Lịch sử` | nút giấy kem viền navy 320×52 | S10 |
| `Bảng xếp hạng` | nút giấy kem viền navy 320×52 | S11 |
| `Luật chơi` | nút text 320×44, chữ cream 15/600 gạch chân | mở modal luật: 6 mục ngắn (gieo, mua, thuê, xây, tù, kết thúc), scroll, nút Đóng |

CTA online disabled khi `lobbyPhase !== 'ready'`. Luật chơi dùng được offline.

---

## S3. Danh sách bàn (RankedScreen)

Copy hành vi caro/xiangqi `RankedScreen.tsx`.

- Header 56: back, title `Bàn tỷ phú` 20/800, nút Làm mới.
- Cột: `Chủ bàn | Chỗ | Tham gia`. Không có cột cược ở v1 (bet luôn 0); giữ chỗ trong layout để v2 thêm cột `KEN`.
- 9 hàng/trang cố định, hàng cao 8.85% vùng list, absolute theo %.
- Hàng: avatar chủ bàn 32 + VIP, `@username` 15/600, badge chỗ `2/4` (viền jade khi còn chỗ, mờ 50% + Tham gia disabled khi đầy), icon khóa 16 khi `locked`, chip `Đang chơi` khi `status = 'playing'`.
- Footer: `Tạo bàn` (CTA vàng) giữa, phân trang ‹ › hai bên.
- `ROOM_LIST` khi mở + Làm mới; `ROOM_UPSERT/REMOVED` realtime; auto re-sync 90–120 s jitter.

---

## S4. Modal Tạo bàn / Vào bàn khóa

### 4a Tạo bàn (modal 340 × auto, radius 20)
- Title `Tạo bàn` 20/800.
- Nhóm `Số người`: 3 chip-btn `2 · 3 · 4`, mặc định 4, chip active gold.
- Toggle `Khóa bàn` + input mật khẩu 4–8 ký tự (hiện khi bật).
- Nút `Tạo bàn` CTA vàng 100% × 52; `Hủy` text.
- Gửi `ROOM_CREATE {bet: 0, password, maxPlayers}` → `ROOM_WAITING` → S5. Lỗi `ROOM_CREATE_FAILED/INVALID_PASSWORD` → toast.
- v2: thêm ô nhập cược + validate `maxBet`.

### 4b Vào bàn khóa
- Input mật khẩu, nút `Vào bàn`; `WRONG_PASSWORD` → shake input + text lỗi đỏ.

---

## S5. Phòng chờ (pregame)

Render trong BoardScreen với `boardMode = 'pregame'`: bàn cờ hiện mờ 40% phía dưới, panel ghế đè giữa.

### 5.1 Panel ghế (340 × auto, paper, radius 28)
- Title `Bàn của @owner` + badge chỗ `3/4` + icon khóa.
- Lưới ghế 2 × 2 (hoặc 1 × 2, 1 × 3 theo `maxPlayers`): mỗi ghế 150 × 88: avatar 40 viền màu ghế, tên 15/600, chip `Chủ bàn` (ic-owner) hoặc `Sẵn sàng` jade / `Chưa sẵn sàng` mờ; ghế trống hiện dấu `+` nét đứt `Đang chờ...`.
- Màu ghế theo seat index (01 §2.3) — cho người chơi biết trước mình màu gì.

### 5.2 Hành động
| Vai | Nút |
|---|---|
| Chủ bàn | `Bắt đầu` CTA vàng (enabled khi ≥ 2 người và tất cả khách sẵn sàng), `Mời ra` trên từng ghế khách (ic-user-minus, O5 confirm), `Thoát bàn` |
| Khách | `Sẵn sàng` jade ⇄ `Hủy sẵn sàng` paper, `Thoát bàn` |

- `ROOM_START` → `MATCH_FOUND` → `boardMode='playing'`. Lỗi `ROOM_NOT_READY`/`ROOM_NOT_FULL` → toast. Bàn 3–4 chỗ được bắt đầu khi có từ 2 người: engine chỉ kiểm `playerCount ≥ MinPlayers` (`engine.go` `startRoom`), không bắt buộc đầy.
- Chat phòng: nút ic-chat góc dưới phải mở ChatDrawer (`CHAT_SEND {roomId}`).
- `ROOM_CLOSED`/`ROOM_KICKED` → toast + về S3.

---

## S6. Bàn chơi (BoardScreen, `boardMode='playing'`)

### 6.1 Cấu trúc dọc tại 390
| Vùng | y | Nội dung |
|---|---|---|
| Topbar | 0–52 | chip vòng `Vòng 7/20` + thanh tiến độ vòng (trái), nút âm thanh + menu ⋯ (Về sảnh, Bỏ cuộc) (phải) |
| Bàn | 60–426 | bàn 366 × 366 (03 §1) |
| Pod row | 438–534 | 2–4 pod: avatar, tên, tiền mặt, số ô/nhà/thẻ ra tù/đang ở tù, thanh tổng tài sản so với người dẫn đầu, vương miện cho người giàu nhất, nhãn `Lượt bạn`/`Đang đi` |
| Panel lượt | 546– | `TurnPanel`: avatar + `Lượt của …` + mô tả pha + đồng hồ vòng tròn (chỉ lượt mình); nút theo pha (6.3). Lượt máy: panel trong suốt + 3 chấm |
| Log | phần còn lại | `GameLog` lấp hết chiều cao còn lại, 8 dòng mới nhất (mới ở trên, chấm xanh/đỏ theo tiền vào/ra), chạm mở sheet log |

> UI v2 (17/10/2026) thay Action bar + đồng hồ topbar bằng `TurnPanel`; footer chat/reaction chưa có trong bản chơi với máy.

Ở width 360 bàn 336, pod 4 × 78. Ở 480+ bàn 456, giữa bàn rộng hơn cho pod trong bàn — v1 vẫn giữ pod row dưới bàn để một layout.

### 6.2 Bàn
- 40 ô theo 03 §1–2; tap ô bất kỳ mở S7 (sheet chi tiết) — kể cả ô đặc biệt (hiện mô tả).
- Quân là ghim bản đồ ~24 px màu ghế có avatar, mũi ghim đặt ở mép trong của ô (ô góc/ô cạnh), Nhà tù chia vùng trong phòng giam / Thăm tù; quân tới lượt nhún + vòng gold.
- Giữa bàn: logo bảng navy, chồng thẻ Cơ hội/Khí vận, dãy phố nhà ống; khi `roll` → O1 xúc xắc trong khay giấy ở giữa; khi `card` → O2 thẻ ở giữa (đè bàn, không đè pod).
- Ô có chủ: nền màu nhạt của ghế + vạch 3 px mép ngoài + giá đổi thành viên tiền thuê hiện tại; nhà/khách sạn nằm trên dải màu nhóm.

### 6.3 Action bar theo pha (chỉ khi `myTurn`)
| phase | Nút (trái → phải) |
|---|---|
| `roll` | `Gieo xúc xắc` CTA vàng 100% (ic-dice) |
| `jail` | `Gieo` paper · `Nộp 50 tr` paper · `Dùng thẻ` paper (disabled nếu không có) — 3 nút đều |
| `decide` | thẻ sổ đỏ thu gọn ngay trong panel (tên, giá, thuê đất trống, `x/y của bạn` trong nhóm; chạm mở S7) · `Bỏ qua` paper 40% · `Mua {price} tr` CTA vàng 60% kèm dòng `còn lại …` |
| `card` | `Làm theo thẻ` CTA vàng trong panel; chạm vào thẻ O2 cũng được |
| `manage` | `Xây nhà` paper (mở S8, ẩn nếu không sở hữu trọn nhóm nào) · `Kết thúc lượt` CTA vàng; nếu vừa gieo đôi, nhãn `Gieo tiếp` thay `Kết thúc lượt` (vẫn gửi END_TURN) |
| `debt` | O3 chiếm bar: `Bán nhà` · `Trả {amount} tr` · `Phá sản` |

Không tới lượt: bar hiện `Lượt của @ten` + mini-avatar + pha đang làm (`đang gieo…`, `đang nghĩ mua…`), 15/600 cream 70%.

Hết giờ local (deadline qua): disable toàn bar, chữ `Hết giờ, hệ thống đang xử lý…` cho đến STATE mới.

### 6.4 Sự kiện trong S6
- `STATE` → replay steps (01 §8) → cập nhật pod/bàn/bar.
- `turnAnnounce` khi `turn` đổi sang mình: `ĐẾN LƯỢT BẠN` + `bridge.attention(YourTurn)`.
- `OPPONENT_DISCONNECTED` → O4 với tên người rớt; nếu người rớt đang tới lượt, đồng hồ dừng (engine pause).
- Bỏ cuộc: ic-flag → O5 `Bỏ cuộc? Bạn sẽ bị tính phá sản và xếp cuối.` → `FORFEIT`.

---

## S7. Sheet chi tiết ô

Bottom sheet 100% × auto (max 62% chiều cao), paper, radius 28 trên, handle 36×4.

### 7.1 Ô đất (`street`)
- Dải màu nhóm cao 44 trên cùng, tên nhóm 12.5/500 navy trên dải màu sáng hoặc cream trên dải tối.
- Tên ô 20/800, chip chủ sở hữu (avatar 20 + tên) hoặc `Chưa có chủ`.
- Dòng giá `Giá 220 tr` · `Nhà 150 tr`.
- Bảng tiền thuê 6 hàng: `Đất trống` (ghi `×2 khi trọn nhóm`), `1 nhà`…`4 nhà`, `Khách sạn`; hàng đang áp dụng (theo `houses` hiện tại và chủ) highlight gold 30%.
- Hàng nhà hiện tại: 0–4 glyph nhà hoặc 1 khách sạn.
- Nút theo ngữ cảnh: `Mua 220 tr` (khi `decide` và là ô đang đứng), `Xây (150 tr)` / `Bán nhà (+75 tr)` (khi của mình + pha manage/debt + hợp lệ), disabled kèm lý do 12.5 coral (`Cần sở hữu trọn nhóm Đỏ`, `Xây đều: ô Đà Nẵng mới có 1 nhà`).

### 7.2 Bến / tiện ích
- Bảng 4 hàng số bến ↔ tiền thuê, hoặc 2 hàng tiện ích ↔ hệ số; highlight hàng hiện tại.

### 7.3 Ô đặc biệt
- Mô tả 1–2 dòng (`Nhận 200 tr mỗi lần đi qua`, `Trả 200 tr`, `Vào tù, đi thẳng không qua Xuất phát`), không nút.

---

## S8. Sheet quản lý tài sản

Bottom sheet max 70%.
- Header: `Tài sản của bạn` + tổng `2.340 tr` 22/800 (tiền mặt + đất + nhà) + dòng `Tiền mặt 820 tr`.
- Danh sách theo nhóm: header nhóm = chip màu + tên + `3/3` (sở hữu/tổng); hàng ô: tên, nhà hiện có, nút `+` (xây) / `−` (bán) 36×36 với giá bên cạnh; disabled kèm tooltip lý do.
- Nhóm chưa trọn: hiện mờ, chú thích `Thiếu Đà Nẵng`.
- Bến/tiện ích liệt kê cuối, không nút.
- Mọi `BUILD/SELL_HOUSE` gửi ngay, sheet không đóng; số cập nhật khi STATE về (có `movePending` theo ô).

---

## S9. Kết quả

Modal 340 × auto, radius 28, không đóng khi tap backdrop.
- Title theo hạng của mình: `Tỷ phú số 1!` gold / `Hạng 2` / `Hạng 3` / `Phá sản` coral; dòng lý do (`Hết 20 vòng` / `Chỉ còn một người` / `Bạn đã bỏ cuộc`).
- Bảng 2–4 hàng: hạng, avatar + tên, tổng tài sản 15/800, chip XP `+50` (từ `expGains`). Hàng mình viền màu ghế.
- v1 không hiện KEN (bet 0). Layout chừa dòng `±KEN` cho v2.
- Nút `Chơi lại` CTA vàng (→ `ROOM_READY`, về S5 nếu phòng còn) + `Đóng` (→ S3).

---

## S10. Lịch sử

Giống xiangqi S8: 100 trận gần nhất; mỗi hàng: hạng của mình (`#1`…`#4`, màu gold cho #1), số người, thời gian, chip `Bỏ cuộc` nếu `reason` tương ứng. Không có cột KEN v1 (`kenDelta` luôn 0).

## S11. Bảng xếp hạng

Giống xiangqi S9: tab Hôm nay/Tuần này, cột thắng (hạng 1) – trận. Không có cột KEN ở v1.

---

## O1. Xúc xắc

Hai ô 44×44 radius 12 paper viền navy 2, dot navy; lăn theo 01 §8; dừng → text tổng `7` 24/800 dưới; badge `Đôi!` gold nếu double; tự ẩn sau khi quân bắt đầu di chuyển 200 ms.

## O2. Thẻ bài

Thẻ 280 × 180 giữa bàn; mặt sau = dải màu loại + glyph (ic-chance `?` / ic-chest); lật → mặt trước: dải đầu 28 px tên loại `CƠ HỘI`/`KHÍ VẬN`, nội dung 16/600 tối đa 3 dòng, số tiền hiển thị màu jade/coral. Nút `Tiếp tục` (chỉ người rút); người khác thấy thẻ không nút, tự ẩn khi STATE kế tiếp.

## O3. Trả nợ

Modal 340: `Bạn cần trả {amount} tr cho @ten/ngân hàng`, dòng `Tiền mặt {cash} tr`, dòng `Bán nhà có thể thu tối đa {x} tr`. Danh sách ô có nhà với nút `Bán −` (+ giá). Nút `Trả nợ` CTA vàng enabled khi `cash ≥ amount`; `Phá sản` danger (O5 confirm). Đồng hồ 30 s hiện trong modal. Khi tổng khả năng < amount: chỉ hiện `Phá sản` + giải thích.

## O4. Banner mất kết nối

Top banner 100% × 44: ic-wifi-off + `@ten mất kết nối · 23s`; nhiều người rớt → gộp `2 người mất kết nối`. Tắt khi `OPPONENT_RECONNECTED` hoặc người đó bị quit (step `bankrupt`).

## O5. ConfirmModal

Bỏ cuộc, thoát bàn, mời ra, phá sản, bán nhà (chỉ khi bán khách sạn — mất 1 khách sạn thành 4 nhà, nhận 100 tr).

## O6. Toast + turn announce

Lỗi server (map `errorText`), `ĐẾN LƯỢT BẠN`, `+200 tr qua Xuất phát` (toast nhỏ jade).

## O7. Banner vòng

Chip vòng ở topbar; vòng 18–19 coral; vòng 20 hiện banner 1 lần `Vòng cuối! Xếp hạng theo tổng tài sản` 2.5 s.
