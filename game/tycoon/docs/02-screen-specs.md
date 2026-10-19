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

> **UI v3 (concept 19/10/2026).** Bố cục lấy theo bộ ảnh mới nhất [`assets/pixel-options-2026-10-19/`](../assets/pixel-options-2026-10-19/README.md): cả 4 thẻ người chơi nằm **một hàng dưới bàn**, cụm lượt (đồng hồ, xúc xắc, nút) nằm **giữa bàn**, footer là thanh tiện ích. Ảnh tham chiếu phong cách đã duyệt [`exec-f7dbd796…png`](../assets/exec-f7dbd796-8a5f-46af-af8a-2b6d1d3780c2.png) chia 2 thẻ trên / 2 thẻ dưới — **không dùng bố cục đó nữa**, chỉ giữ phong cách. Ba bản pixel (8-bit, 16-bit, isometric) chỉ khác tranh trong ô; vị trí mọi nút và ô thông tin giống hệt nhau. Ảnh chỉ để lấy bố cục: tên ô, giá, màu nhóm luôn lấy từ `logic/board.json`.
>
> Thay thế UI v2 (17/10): `TurnPanel` và `GameLog` dưới hàng pod được bỏ; nội dung `TurnPanel` chuyển vào giữa bàn (6.3), `GameLog` thu thành dòng sự kiện ở footer (6.5).

### 6.1 Sơ đồ dọc

```text
┌──────────────────────────────────────────┐
│ [CỜ TỶ PHÚ]   ( Vòng 7/20 )   (♪)  (≡)   │ header
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │  NHÀ TÙ · 7 ô hàng trên · BÃI ĐỖ XE  │ │
│ │  ·   ┌────────────────────────┐  ·   │ │
│ │  ·   │ [CƠ HỘI]    [KHÍ VẬN]  │  ·   │ │
│ │  7   │                        │  7   │ │
│ │  ô   │ (Lượt của bạn) (0:28)  │  ô   │ │  bàn 32 ô
│ │  ·   │       [3]   [5]        │  ·   │ │  + cụm lượt
│ │  ·   │   [  Gieo xúc xắc  ]   │  ·   │ │
│ │  ·   └────────────────────────┘  ·   │ │
│ │  XUẤT PHÁT · 7 ô hàng dưới · VÀO TÙ  │ │
│ └──────────────────────────────────────┘ │
├──────────────────────────────────────────┤
│ [o Bạn  ] [o Linh ] [o Khoa ] [o Mai  ]  │ hàng pod
│ [ 1.240 ] [  980  ] [  760  ] [ 1.100 ]  │
├──────────────────────────────────────────┤
│ [Tài sản] [Diễn biến] │ Linh vừa qua …   │ footer
└──────────────────────────────────────────┘
```

| Vùng | Khung concept 3:4 (% cao) | Tại 390 × 844 (y, px) | Nội dung |
|---|---|---|---|
| Header | 0–5% | 0–52 (+ safe-area trên) | logo trái, chip vòng giữa, âm thanh + menu phải (6.4) |
| Bàn | 5–87% | 56–422 | bàn vuông `min(100vw − 24, 480)` = 366; 32 ô + vùng trong (6.2, 6.3) |
| Hàng pod | 88–95% | 430–494 (compact) | 2–4 pod chia đều 1 hàng (6.5, 03 §5) |
| Footer | 96–100% | đáy − 52 → đáy (+ safe-area dưới) | `Tài sản`, `Diễn biến`, dòng sự kiện mới nhất (6.5) |

Lề ngang 12 cho mọi khối; bàn, hàng pod và footer cùng chiều rộng `var(--ty-board)` để các mép thẳng hàng.

**Co giãn theo chiều cao.** Concept là khung 3:4, gần như không dư chỗ. Điện thoại 390 × 844 dư khoảng 290 px giữa hàng pod và footer. Thứ tự lấp chỗ dư:
1. Dư ≥ 32 px: pod sang biến thể **mở rộng** (03 §5), thêm hàng chip đất/nhà/thẻ tù và thanh tổng tài sản. Pod cao 64 → 96.
2. Còn dư ≥ 72 px: dòng sự kiện của footer mở lên thành **thẻ Diễn biến** đặt ngay trên thanh nút footer. Thẻ hiện 2–6 dòng gần nhất (mới ở trên) và lấp hết phần còn lại, giống `GameLog` v2.
3. Khung không dư (3:4, tablet, màn ngắn < 700): giữ đúng concept — pod compact, footer 1 dòng.

Không kéo giãn bàn theo chiều dọc. Bàn luôn vuông (ảnh concept hơi cao hơn rộng, ≈ 1 : 1.12, nhưng spec giữ vuông).

Width 360: bàn 336, pod 4 × 79. Width ≥ 480: bàn 456–480, pod đủ rộng cho bố cục ngang như concept (03 §5).

### 6.2 Bàn — vị trí ô và thông tin trên ô

- Góc cố định (không xoay bàn, mọi người thấy cùng hướng): **dưới-trái** `XUẤT PHÁT` (mũi tên chỉ lên + `+160` jade), **trên-trái** `NHÀ TÙ` (phòng giam ở góc dưới-phải của ô, dải Thăm tù dọc mép trên + mép trái), **trên-phải** `BÃI ĐỖ XE` (biển P + 2 xe), **dưới-phải** `VÀO TÙ` (song sắt). Đi **thuận kim đồng hồ** từ Xuất phát: cột trái dưới → trên, hàng trên trái → phải, cột phải trên → dưới, hàng dưới phải → trái. Thứ tự 32 ô ở 05 §1.
- Mỗi ô cạnh, mọi phía, chữ luôn đứng thẳng, đọc từ trên xuống:
  1. **tên ô** (ngắn, `shortName`) sát mép trên ô;
  2. **tranh/glyph** ở giữa: phong cảnh địa danh cho ô đất, glyph cho bến/tiện ích/thẻ/thuế;
  3. **giá** sát mép dưới ô (`220 tr`); ô thuế hiện số phải trả màu coral; ô Cơ hội/Khí vận không có dòng giá.
- **Dải màu nhóm** luôn nằm ở mép **phía trong** bàn: hàng trên → dải ở đáy ô; hàng dưới → dải ở đỉnh ô; cột trái → dải ở mép phải ô; cột phải → dải ở mép trái ô. Cấp nhà (1–2 nhà hoặc khách sạn) đặt trên dải. Ô không phải đất không có dải.
- Ô có chủ: nền nhạt màu ghế + vạch 3 px màu ghế ở mép **ngoài**, để không lẫn với dải nhóm ở mép trong. Dòng giá đổi thành viên tiền thuê hiện tại (nền paper sáng, viền màu chủ).
- Quân: ghim bản đồ màu ghế có avatar. Mũi ghim chạm mép **trong** của ô; thân ghim nằm trong vùng trong bàn, không che tên/giá. Ô 10: quân trong tù đứng vùng phòng giam, quân thăm tù đứng dải Thăm tù.
- Tap ô bất kỳ (kể cả ô góc, ô đặc biệt) → S7. Vùng chạm mở rộng 4 px mỗi phía.

### 6.3 Vùng trong bàn — chồng thẻ và cụm lượt

Vùng trong = phần bàn trừ 4 cạnh ô (72.8% cạnh bàn, 266 × 266 tại 390). Nền paper trơn; không logo/watermark và không cảnh lớn phía sau nút. Logo đã chuyển lên header.

| Phần tử | Vị trí trong vùng trong (% theo cạnh vùng trong) | Kích thước tại 390 | Ghi chú |
|---|---|---|---|
| Chồng `CƠ HỘI` | góc **trên-trái**, cách mép trên 4%, mép trái 6% | 58 × 41 (22% rộng) | cam, glyph `?`; chỉ trang trí, không bấm |
| Chồng `KHÍ VẬN` | góc **trên-phải**, đối xứng | 58 × 41 | xanh trời, glyph gió |
| Cụm lượt | căn giữa ngang; tâm dọc ở 53% (thấp hơn tâm một chút để chừa chỗ hai chồng thẻ) | rộng tối đa 246, cao 140–170 | 3 hàng, xem dưới |

Cụm lượt (`TurnCluster`, 03 §6), từ trên xuống:

| Hàng | Trái → phải | Kích thước tại 390 |
|---|---|---|
| 1. Chip lượt + đồng hồ | chip pill gold `(avatar) Lượt của bạn` · khoảng 8 · vòng đồng hồ `0:28` bên phải chip; cả hàng căn giữa | chip cao 34, đồng hồ ⌀ 40 |
| 2. Xúc xắc | hai viên cạnh nhau, khoảng 16 | 40 × 40 mỗi viên |
| 3. Nút theo pha | xem bảng pha | cao 48; CTA đơn rộng 196 (≈ 74% vùng trong) |

Khoảng cách giữa các hàng 10. Concept (khung 3:4) đặt chip ở 31–39%, xúc xắc 43–56%, CTA 60–70% chiều cao vùng trong.

**Nút theo pha** (chỉ khi `myTurn`). Hàng 2 đổi nội dung tùy pha; hàng 1 luôn giữ nguyên:

| phase | Hàng 2 | Hàng 3 (trái → phải) |
|---|---|---|
| `roll` | 2 xúc xắc (mặt lần gieo trước, hoặc 1–1 lúc đầu ván) | `Gieo xúc xắc` CTA vàng 196 (ic-dice); đang có đôi: `Gieo thêm lượt (đôi!)` |
| `jail` | 2 xúc xắc | 3 nút đứng đều 74 × 56: `Gieo đôi` (gold, dòng phụ `lần n/3`) · `Nộp phạt` paper (`50 tr`) · `Dùng thẻ` paper (`còn n`, disabled khi 0) |
| `decide` | thẻ sổ đỏ thu gọn 246 × 52 thay xúc xắc: dải nhóm trái, tên + glyph, `Giá`, `Thuê`, `x/y của bạn`; chạm mở S7 | `Bỏ qua` paper 40% · `Mua {giá} tr` CTA vàng 60% kèm dòng phụ `còn lại …` (không đủ tiền → disabled, `cần …`) |
| `card` | O2 thay **cả** hàng 2 và 3 (xem O2) | `Làm theo thẻ` nằm trong thẻ |
| `manage` | 2 xúc xắc (mặt vừa gieo) | `Nâng cấp` paper 40% (mở S8; ẩn nếu chưa trọn nhóm nào, khi đó CTA rộng 196) · `Kết thúc lượt ›` CTA vàng 60%; vừa gieo đôi → `Gieo tiếp (đôi!)` (vẫn gửi END_TURN) |
| `debt` | dòng cảnh báo coral `Bạn đang nợ {x} tr` | không nút; O3 mở giữa màn |

Hết giờ local (deadline qua): hàng 3 thay bằng dòng `Hết giờ, hệ thống đang đi thay bạn…`, mọi nút disabled cho đến STATE mới. Khi `movePending`: nút vừa bấm hiện spinner, cả hàng 3 disabled.

**Không tới lượt mình:** hàng 1 là chip paper `(avatar) Lượt của @ten` viền màu ghế người đó, đồng hồ thay bằng 3 chấm "đang nghĩ". Dưới chip là dòng phụ 12.5 navy 70% (`đang gieo xúc xắc…`, `đang cân nhắc mua đất…`; lúc replay: `đang di chuyển…`). Hàng 2 chỉ hiện xúc xắc khi người đó gieo (O1). Hàng 3 trống. Cụm co lại nhưng vẫn giữ tâm ở 53%.

Chỉ có **một** nút gold trên màn tại mọi thời điểm, và nó luôn nằm ở hàng 3 của cụm lượt (style/05 §1).

### 6.4 Header

| Vị trí | Phần tử | Kích thước tại 390 | Hành vi |
|---|---|---|---|
| Trái, lề 12 | logo chữ `CỜ TỶ PHÚ` + xúc xắc nhỏ (raster `lobby/logo.webp` hoặc live text) | cao 32, rộng ≤ 120 | không bấm |
| Giữa (căn theo màn, không theo phần còn trống) | `RoundChip` `Vòng 7/20` pill paper viền navy | 108 × 32 | không bấm; đổi màu từ vòng 18 (O7) |
| Phải, cách mép 12 | nút âm thanh tròn | 44 × 44 | bật/tắt âm, `aria-pressed` |
| Phải cùng | nút menu tròn (☰ trong concept) | 44 × 44 | popover paper: `Về sảnh` · `Luật chơi` · `Bỏ cuộc` (coral) |

Width < 370: ẩn chữ logo, chỉ giữ biểu tượng xúc xắc để chip vòng không bị đẩy lệch.

### 6.5 Hàng pod và footer

**Hàng pod.** Ngay dưới bàn, cách 8. 2–4 pod chia đều một hàng; thứ tự trái → phải theo seat (seat 0 gold, 1 xanh, 2 san hô, 3 tím), không đổi theo lượt. Có thể là `Bạn` ở bất kỳ vị trí nào; tên pod của mình ghi `Bạn`. Bố cục bên trong pod ở 03 §5. Tap pod → S8 xem tài sản người đó (của mình thì có nút xây/bán).

**Footer.** Một hàng cao 44, đáy màn + safe-area:

| Vị trí | Phần tử | Hành vi |
|---|---|---|
| Trái | nút pill `Tài sản` (icon danh sách/sổ) | mở S8 của mình |
| Kế bên | nút pill `Diễn biến` (icon cột) | mở sheet diễn biến đầy đủ |
| Vạch ngăn dọc | — | — |
| Phần còn lại | dòng sự kiện mới nhất: icon xúc xắc + câu log, tên tô màu ghế, số tiền jade/coral (`Linh vừa qua Xuất phát +160 tr`), cắt `…` nếu dài | chạm mở sheet diễn biến |
| Phải cùng (bản online) | nút `ic-chat` 44 có chấm đỏ khi có tin mới | mở ChatDrawer; bản chơi với máy không có |

Khi màn dư chỗ (6.1 mục 2), dòng sự kiện thành thẻ Diễn biến nhiều dòng, đặt trên thanh nút. Lúc đó thanh footer chỉ còn hai nút + chat.

### 6.6 Lớp phủ trong S6 — vị trí

| Lớp | Vị trí |
|---|---|
| O1 xúc xắc | đúng ô xúc xắc của hàng 2 cụm lượt — không có khay riêng |
| O2 thẻ bài | giữa vùng trong, thay cụm lượt (che cả 3 hàng), không đè pod |
| Turn announce `ĐẾN LƯỢT BẠN` | giữa vùng trong, đè lên cụm lượt 1.2 s |
| O7 `Vòng cuối!` | giữa vùng trong, 2.5 s |
| O6 toast | mép trên vùng trong, đè lên hai chồng thẻ (z trên), rộng tối đa 240, tự ẩn 2.5 s |
| O4 mất kết nối | dải 100% × 36 dính ngay dưới header, đè lên hàng ô trên; không đẩy layout |
| Tiền bay `+200` / `−120` | bay lên từ dòng tiền của pod tương ứng |
| S7, S8, sheet diễn biến | bottom sheet đè toàn màn |
| O3, O5, S9 | modal giữa màn |

### 6.7 Sự kiện trong S6
- `STATE` → replay steps (01 §8) → cập nhật pod/bàn/cụm lượt.
- `turnAnnounce` khi `turn` đổi sang mình: `ĐẾN LƯỢT BẠN` + `bridge.attention(YourTurn)`.
- `OPPONENT_DISCONNECTED` → O4 với tên người rớt; nếu người rớt đang tới lượt, đồng hồ dừng (engine pause).
- Bỏ cuộc: menu header → `Bỏ cuộc` (ic-flag) → O5 `Bỏ cuộc? Bạn sẽ bị tính phá sản và xếp cuối.` → `FORFEIT`.

---

## S7. Sheet chi tiết ô

Bottom sheet 100% × auto (max 62% chiều cao), paper, radius 28 trên, handle 36×4.

### 7.1 Ô đất (`street`)
- Dải màu nhóm cao 44 trên cùng, tên nhóm 12.5/500 navy trên dải màu sáng hoặc cream trên dải tối.
- Tên ô 20/800, chip chủ sở hữu (avatar 20 + tên) hoặc `Chưa có chủ`.
- Dòng giá `Giá 220 tr` · `Nhà 150 tr`.
- Dòng `Giá nâng mỗi cấp 150 tr`.
- Bảng tiền thuê 4 hàng: `Đất trống` (ghi `×2 khi trọn nhóm`), `Cấp 1 · Nhà`, `Cấp 2 · Biệt thự`, `Cấp 3 · Khách sạn`; hàng đang áp dụng (theo cấp hiện tại và chủ) highlight gold 30%.
- Hàng `Cấp hiện tại`: 1–2 glyph nhà hoặc 1 khách sạn + tên cấp.
- Nút theo ngữ cảnh: `Mua 220 tr` (khi `decide` và là ô đang đứng), `Nâng cấp (150 tr)` / `Hạ cấp (+75 tr)` (khi của mình + pha manage/debt + hợp lệ), disabled kèm lý do 12.5 coral (`Cần sở hữu trọn nhóm — thiếu Huế`, `Nâng đều: Huế mới ở cấp 1`, `Đã đạt cấp tối đa (cấp 3)`).

### 7.2 Bến / tiện ích
- Bảng 4 hàng số bến ↔ tiền thuê, hoặc 2 hàng tiện ích ↔ hệ số; highlight hàng hiện tại.

### 7.3 Ô đặc biệt
- Mô tả 1–2 dòng (`Nhận 160 tr mỗi lần đi qua`, `Vào tù, đi thẳng không qua Xuất phát`), không nút.

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

Hai viên 40 × 40 tại 390 (44 khi bàn ≥ 456) radius 12 paper viền navy 2, dot navy, nằm ở hàng 2 của cụm lượt (6.3). Lăn theo 01 §8. Dừng → chip tổng `= 7` 15/800 ngay bên phải viên thứ hai; double → chip `Đôi!` gold thay chip tổng. Chip tự ẩn khi quân bắt đầu di chuyển 200 ms, xúc xắc ở lại hiện mặt vừa gieo.

## O2. Thẻ bài

Thẻ 236 × 168 tại 390 (tối đa 280 × 180 khi bàn ≥ 456), đặt giữa vùng trong và thay cả cụm lượt (6.6). Mặt sau = dải màu loại + glyph (ic-chance `?` / ic-chest). Lật → mặt trước:
- dải đầu 28 px ghi tên loại `CƠ HỘI`/`KHÍ VẬN`;
- nội dung 15/600, tối đa 3 dòng; số tiền màu jade/coral;
- nút `Làm theo thẻ` CTA vàng 100% × 44 dính đáy thẻ, chỉ người rút thấy.

Người khác thấy thẻ không có nút; thẻ tự ẩn khi có STATE kế tiếp. Thẻ bay ra từ chồng tương ứng ở góc trên vùng trong (08).

## O3. Trả nợ

Modal 340: `Bạn cần trả {amount} tr cho @ten/ngân hàng`, dòng `Tiền mặt {cash} tr`, dòng `Bán nhà có thể thu tối đa {x} tr`. Danh sách ô có nhà với nút `Bán −` (+ giá). Nút `Trả nợ` CTA vàng enabled khi `cash ≥ amount`; `Phá sản` danger (O5 confirm). Đồng hồ 30 s hiện trong modal. Khi tổng khả năng < amount: chỉ hiện `Phá sản` + giải thích.

## O4. Banner mất kết nối

Top banner 100% × 44: ic-wifi-off + `@ten mất kết nối · 23s`; nhiều người rớt → gộp `2 người mất kết nối`. Tắt khi `OPPONENT_RECONNECTED` hoặc người đó bị quit (step `bankrupt`).

## O5. ConfirmModal

Bỏ cuộc, thoát bàn, mời ra, phá sản, hạ cấp (chỉ khi hạ từ Khách sạn xuống Biệt thự).

## O6. Toast + turn announce

Lỗi server (map `errorText`) là toast ở mép trên vùng trong bàn (6.6). `ĐẾN LƯỢT BẠN` đè giữa cụm lượt. `+160 tr qua Xuất phát` không cần toast riêng: nó đã hiện ở dòng sự kiện footer và tiền bay ở pod.

## O7. Banner vòng

Chip vòng ở giữa header; vòng 18–19 coral; vòng 20 hiện banner 1 lần `Vòng cuối! Xếp hạng theo tổng tài sản` 2.5 s ở giữa vùng trong bàn.
