# 01 — Art direction: Phố Thị Rực Rỡ

> Đây là art direction tổng quan. Token đầy đủ, bảng màu 40 ô, nhân vật và ma trận màu icon nằm trong [`style/`](./style/README.md).

## 1. DNA hình ảnh

- Không khí: thành phố Việt buổi sáng, phẳng, tươi, sạch — board game bày trên bàn gỗ sáng, không "casino", không neon, không 3D.
- Ba chất liệu chủ đạo: **giấy kem** (mặt bàn cờ, thẻ bài), **dải màu nhóm đất** (8 màu bão hòa vừa), **navy** (outline, chữ).
- Kế thừa DNA mini-game Ola: outline navy đồng nhất, hình học phẳng, CTA vàng nắng, text live. Người chơi đã quen Tiến Lên và Cờ Tướng phải thấy đây là "cùng một nhà".
- Bàn cờ là ngôi sao, nhưng ở 390 px mỗi ô chỉ ~30 px: bàn đọc bằng **màu và glyph** trước, kèm **tên ngắn + giá** cỡ ~6.7 px (`helpers/tiles.ts` → `TILE_SHORT_NAME`), ô có chủ đổi giá thành **viên tiền thuê** viền màu ghế. Bảng tiền thuê đầy đủ vẫn dồn vào sheet.
- UI v2 (17/10/2026, bản chơi với máy): font Nunito (dùng chung file với caro); ô có chủ tô nền `SEAT_SOFT_COLORS` + vạch 3 px màu ghế ở mép ngoài thay cho chấm 8 px; nhà nằm trên dải màu nhóm; giữa bàn có logo bảng navy, 2 chồng thẻ Cơ hội/Khí vận và dãy phố nhà ống (`components/Skyline.tsx`, dùng lại bản đêm ở sảnh); quân là ghim bản đồ có avatar, đứng ở mép trong của ô để không che chữ; nút/thẻ có bóng đặc 4 px `--ty-ink` kiểu board game.
- Tiền là cảm xúc chính của game: số tiền đổi màu, bay lên/xuống, pod người chơi luôn hiện tiền mặt.

## 2. Palette chuẩn

### 2.1 Core tokens

| Token | Hex | Dùng cho |
|---|---|---|
| `--ty-bg-900` | `#1E2A3A` | nền màn (đáy gradient), backdrop |
| `--ty-bg-700` | `#2C3E55` | nền màn (đỉnh gradient), khung bàn |
| `--ty-paper` | `#FBF3E0` | mặt bàn cờ, thẻ bài, sheet |
| `--ty-paper-dim` | `#F0E4C8` | hàng chẵn list, ô góc, panel phụ |
| `--ty-navy` | `#1F2A44` | outline thống nhất, chữ chính trên nền sáng |
| `--ty-line` | `#8C7B5E` | nét lưới ô bàn cờ |
| `--ty-cream` | `#FFF8EA` | chữ trên nền navy |
| `--ty-gold` | `#F2B807` | CTA chính, lượt của mình |
| `--ty-gold-deep` | `#B98700` | viền/shadow CTA vàng |
| `--ty-jade` | `#1F8A5B` | tiền tăng, mua thành công, sẵn sàng |
| `--ty-coral` | `#E4573D` | tiền giảm, trả tiền thuê, nguy hiểm |
| `--ty-danger` | `#B3261E` | phá sản, lỗi, timer ≤10 s; đủ AA cho chữ nhỏ trên paper |
| `--ty-overlay` | `#141B26` 62% | backdrop modal/sheet |

### 2.2 Màu 8 nhóm đất

Dải màu trên ô (`tile-band`) và chip nhóm trong sheet. Chọn để 8 màu phân biệt được khi mù màu đỏ-lục bằng độ sáng + có glyph nhóm kèm theo (06 §4.3).

| Token | Hex | Nhóm | Ô |
|---|---|---|---|
| `--ty-g-brown` | `#8D5B3C` | Nâu — Phố cổ | 1, 3 |
| `--ty-g-sky` | `#7EC8E3` | Xanh trời — Cao nguyên | 6, 8, 9 |
| `--ty-g-pink` | `#E58FB5` | Hồng — Biển đảo Nam | 11, 13, 14 |
| `--ty-g-orange` | `#F2994A` | Cam — Duyên hải | 16, 18, 19 |
| `--ty-g-red` | `#D64545` | Đỏ — Miền Trung | 21, 23, 24 |
| `--ty-g-yellow` | `#F2D04E` | Vàng — Đông Nam Bộ | 26, 27, 29 |
| `--ty-g-green` | `#3BA776` | Xanh lá — Sài Gòn | 31, 32, 34 |
| `--ty-g-blue` | `#2F5FD0` | Xanh đậm — Hà Nội | 37, 39 |

Ô đặc biệt không có dải màu nhóm; dùng `--ty-paper-dim` làm nền và glyph màu navy (bến/ga: `--ty-navy`; tiện ích: `--ty-jade`; Cơ hội: `--ty-gold`; Khí vận: `--ty-sky`; thuế: `--ty-coral`).

### 2.3 Màu quân cờ (4 ghế)

Màu ghế cố định theo seat index, dùng cho viền pod, vòng quân, dấu chủ sở hữu trên ô, dòng chat:

| Seat | Token | Hex |
|---|---|---|
| 0 | `--ty-seat-0` | `#F2B807` (gold) |
| 1 | `--ty-seat-1` | `#2F9BD6` (blue) |
| 2 | `--ty-seat-2` | `#E4573D` (coral) |
| 3 | `--ty-seat-3` | `#8E5BD9` (violet) |

Màu ghế không trùng với 8 màu nhóm đất ở cùng độ sáng để dấu chủ sở hữu (chấm 8 px ở góc ô) không bị lẫn với dải màu.

### 2.4 Semantic tokens

| Token | Giá trị | Dùng cho |
|---|---|---|
| `--ty-turn-mine` | `--ty-gold` | vòng lượt của mình, turn announce, viền pod |
| `--ty-turn-other` | `--ty-cream` 60% | vòng lượt người khác |
| `--ty-money-up` | `--ty-jade` | số tiền tăng, float "+" |
| `--ty-money-down` | `--ty-coral` | số tiền giảm, float "−" |
| `--ty-owned-mine` | `--ty-seat-{you}` | viền ô của mình trong sheet S8 |
| `--ty-landing` | `--ty-gold` 45% | ô vừa đáp xuống |
| `--ty-path` | `--ty-gold` 25% | các ô quân vừa đi qua (fade 600 ms) |
| `--ty-bankrupt` | `--ty-navy` 35% | pod + quân người phá sản |

### 2.5 Quy tắc tương phản

- Chữ trên `--ty-paper`: `--ty-navy` (AA ≥ 4.5). Chữ trên nền navy: `--ty-cream`.
- Không đặt chữ coral/jade trực tiếp lên navy ở cỡ < 15 px — dùng chip nền paper.
- `--ty-gold` chỉ làm nền nút/badge với chữ navy, không làm màu chữ trên nền sáng.
- Dải màu nhóm đất không bao giờ có chữ đè lên; nếu cần số nhà, dùng chấm/glyph navy trên nền paper phía dưới dải.
- Nhóm vàng (`--ty-g-yellow`) và gold CTA gần nhau: dải nhóm vàng luôn kèm viền navy 1 px, CTA gold luôn kèm viền `--ty-gold-deep` 2 px.

## 3. Hình học

### 3.1 Border

- Outline navy 1.5 px cho component nhỏ (badge, chip, input), 2 px cho panel/nút lớn/sheet.
- Ô bàn cờ: nét `--ty-line` 1 px; viền ngoài bàn 3 px navy.
- Quân cờ: vòng tròn nền paper 1.5 px navy + vòng màu ghế 2 px bên trong.
- Thẻ bài: viền navy 2 px, góc 16, dải đầu thẻ màu loại thẻ (gold Cơ hội / sky Khí vận) cao 28 px.

### 3.2 Radius

Chỉ dùng scale `8 / 12 / 16 / 20 / 28 / 999`:

- 999: quân cờ, avatar, badge tròn, chấm chủ sở hữu, xúc xắc dot;
- 28: sheet (góc trên), panel kết quả;
- 20: modal;
- 16: thẻ bài, nút CTA, hàng room list;
- 12: input, badge cược, xúc xắc (cạnh 44);
- 8: chip nhóm đất, nhà/khách sạn, tooltip;
- 0: ô bàn cờ (lưới liền), ô góc.

### 3.3 Icon

Stroke 2 px, cap tròn, grid 24 cho icon điều khiển; glyph ô bàn cờ là họ riêng dạng fill trên grid 32. Chi tiết toàn bộ ở [06-icon-system.md](./06-icon-system.md).

## 4. Bàn cờ — tỷ lệ thị giác

- Bàn vuông 11 × 11 ô lưới: 4 ô góc + 36 ô cạnh (9 mỗi cạnh) = 40 ô, đi theo chiều kim đồng hồ từ Xuất phát ở góc **dưới-phải** (giống cảm giác board thật).
- Tại viewport 390: bàn `366 × 366` (lề 12). Ô góc `46 × 46`; ô cạnh `30.4 × 46` (dọc cạnh dưới/trên) hoặc `46 × 30.4` (cạnh trái/phải). Công thức: `corner = round(board × 0.126)`, `edge = (board − 2 × corner) / 9`.
- Ở width 480 (max): bàn 456, góc 57, cạnh 38 — glyph vẫn cùng tỷ lệ, không thêm chữ.
- Vùng giữa bàn `274 × 274` tại 390: chứa logo mờ (watermark 12% opacity), xúc xắc khi lăn, thẻ bài khi lật, 4 pod người chơi gọn ở 4 góc trong (03 §6).
- Ô đất: dải màu nhóm chiếm 1/3 chiều sâu ô (phía trong bàn), phần còn lại nền paper hiện nhà (chấm 6 px xếp hàng) hoặc khách sạn (hình chữ nhật 14 × 8) và quân.
- Quân cờ 18 px trên ô; nhiều quân cùng ô xếp 2 × 2 so le 4 px, tối đa 4.
- Vùng chạm ô: ô cạnh chỉ 30 px — chấp nhận, vì tap ô chỉ để mở sheet (không phải thao tác tốc độ); mở rộng hit 4 px mỗi phía, ưu tiên ô gần tâm chạm.
- Người chơi không xoay bàn; mọi người thấy cùng hướng. Xuất phát luôn ở góc dưới-phải.

## 5. Typography

### 5.1 Font

- UI: giữ hệ font của game Ola hiện có (sans đậm cho số/nút, xem caro) — không thêm font mới.
- Số tiền dùng `font-variant-numeric: tabular-nums` ở mọi nơi để pod không nhảy chiều rộng.
- Không có chữ trong ảnh. Tên ô trên thẻ sở hữu và tên thẻ bài đều live text.

### 5.2 Type scale tại viewport 390

| Vai trò | Size/weight |
|---|---|
| Title màn | 24/800 |
| Turn announce | 20/800, letter-spacing 0.04em |
| Nút CTA | 17/700 |
| Body/label | 15/600 |
| Số tiền trong pod | 15/800 tabular |
| Số tiền lớn (sheet, modal trả nợ) | 22/800 tabular |
| Tên ô trong sheet | 20/800 |
| Bảng tiền thuê | 13.5/600, cột số 13.5/800 tabular |
| Phụ chú, timestamp, tên nhóm | 12.5/500 |
| Đồng hồ hành động | 22/800 tabular |
| Số vòng | 13/700 |
| Nội dung thẻ bài | 16/600, tối đa 3 dòng |

### 5.3 Định dạng tiền

- Đơn vị ván: **triệu**, viết tắt `tr`. Hiển thị `1.500 tr`, `60 tr`; dấu chấm ngăn hàng nghìn (`formatMoney` trong `helpers/money.ts`).
- Thay đổi tiền: `+200 tr` jade, `−150 tr` coral. Không bao giờ hiện "$" hay "KEN" cho tiền trong ván để không lẫn với KEN thật.
- Tổng tài sản trong kết quả: `2.340 tr`, kèm phụ chú "tiền mặt + giá đất + nhà".

## 6. Shadow và độ sâu

- 3 mức: `sm` 0 1 2 / 25% navy (chip, quân), `md` 0 3 8 / 30% (nút, thẻ, xúc xắc), `lg` 0 10 28 / 38% (modal, sheet, result).
- Quân đang di chuyển: shadow md + scale 1.15 khi nhảy giữa các ô.
- Không glow ngoài trừ 3 chỗ: vòng lượt của mình (gold, blur 6), ô vừa đáp (gold 45% fill), pod người sắp phá sản (coral, blur 6, pulse 1 s).

## 7. Gradient

- Nền màn: linear 180° `--ty-bg-700 → --ty-bg-900`.
- CTA vàng: linear 180° `#FFD34D → #F2B807`, viền `--ty-gold-deep`.
- Mặt bàn: phẳng `--ty-paper`, không gradient; watermark logo giữa bàn 12% opacity.
- Không gradient nhiều màu, không gradient trên chữ, không gradient trên dải màu nhóm.

## 8. Motion

> Bảng dưới là nhịp cơ bản. Danh mục đầy đủ ≈ 60 hiệu ứng (kể cả hạt trên lớp canvas Pixi), bậc Full/Lite/Off và ngân sách hiệu năng nằm ở [08-fx-and-animation.md](./08-fx-and-animation.md) — khi khác nhau, 08 được ưu tiên.

| Chuyển động | Thông số |
|---|---|
| Xúc xắc lăn (O1) | 2 viên xoay 3D giả bằng đổi mặt mỗi 80 ms trong 720 ms, dừng lệch nhau 120 ms, tổng hiện 200 ms sau |
| Quân nhảy từng ô | 140 ms/ô, cubic-bezier(.3,.9,.4,1), scale 1.15 ở đỉnh; 12 ô ≈ 1.7 s; quân của mình cùng tốc độ (không skip) |
| Qua Xuất phát | ô 0 nháy gold 300 ms + float `+200 tr` lên 24 px 900 ms |
| Đáp ô | ô fill `--ty-landing` 240 ms rồi giữ đến hết lượt |
| Trả tiền (step `pay`) | số tiền pod người trả giảm đếm 500 ms coral; pod người nhận tăng đếm jade; chip "tiền thuê" bay từ pod này sang pod kia 400 ms |
| Lật thẻ (O2) | flip 3D 360 ms, giữ tới khi bấm Tiếp tục hoặc 6 s |
| Xây nhà | chấm nhà pop scale 0→1 160 ms; khách sạn thay 4 chấm bằng 1 khối 220 ms |
| Bán nhà | chấm fade 160 ms + float `+x tr` |
| Vào tù | quân bay cung 420 ms sang ô 10, song sắt (glyph) nháy 2 lần |
| Phá sản | pod chuyển `--ty-bankrupt` 400 ms, quân fade, các ô thuộc người đó mất chấm chủ sở hữu stagger 30 ms |
| Turn announce | fade-scale 300 ms, giữ 900 ms |
| Timer ≤10 s | pulse màu `--ty-danger` mỗi 1 s |
| Sheet | slide-up 240 ms, backdrop fade 150 ms |
| Modal | fade backdrop 150 ms + pop 180 ms |
| Screen entrance | fade + dịch 8–12 px, 240 ms |
| Result | hạng 1 settle 360 ms → hàng 2–4 rise stagger 80 ms, không particle |

`prefers-reduced-motion`: xúc xắc hiện kết quả ngay, quân nhảy thẳng đến ô đích 1 bước 120 ms, tắt pulse/float/stagger; mọi `pay` vẫn cập nhật số tức thời.

Replay `steps[]` serialized theo `replayEpoch` (pattern thirteen/xiangqi); người chơi khác thao tác trong lúc replay thì STATE mới hủy replay cũ và nhảy về trạng thái cuối.

## 9. Âm thanh (WebAudio tổng hợp, không file)

Theo pattern `war-god/audio.ts`: `click`, `dice` (tiếng lắc 3 nốt noise ngắn + gõ), `step` (gõ nhẹ 120 Hz 40 ms mỗi ô, giảm dần), `cash-in` (2 nốt lên), `cash-out` (2 nốt xuống), `card` (quẹt giấy), `build` (gõ búa), `jail` (2 nốt trầm), `bankrupt` (arpeggio xuống 4 nốt), `win`/`lose` (3 nốt lên/xuống), `tick` (≤10 s). Toggle ở lobby, lưu localStorage `ola:tycoon:sound`.

## 10. Anti-style

- Không neon, không glassmorphism, không 3D render quân/nhà.
- Không ảnh chụp địa danh; địa danh chỉ xuất hiện bằng **tên** (live text) và màu nhóm. Không vẽ Chùa Một Cột/Bitexco trên ô — bàn phải trung tính để không thiên vị vùng miền và tránh tranh cãi hình ảnh.
- Không ký hiệu tiền tệ thật ($, ₫) trong ván.
- Không đổ bóng chữ, không outline chữ.
- Không dùng ảnh AI nguyên khối làm màn; raster chỉ 8 quân + 6 nhân vật + nền lobby + logo, mỗi cái qua QA (04 §7).
- Nhân vật là mascot sáng tác riêng với contour navy cùng hệ; không chibi kiểu anime, không người thật, không nhân vật thương mại.
