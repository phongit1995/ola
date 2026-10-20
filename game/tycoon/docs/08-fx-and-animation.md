# 08 — Hiệu ứng và animation

Bản này **thay thế** bảng motion rút gọn ở `01-art-direction.md` §8: game đi theo hướng nhiều hiệu ứng ("juicy") nhưng vẫn trên nền DOM/SVG, với một lớp canvas riêng cho hạt. Mọi hiệu ứng là **phản hồi cho sự kiện đã xảy ra** (server đã quyết), không bao giờ là điều kiện để chơi tiếp — người tắt animation vẫn chơi đủ.

## 1. Kiến trúc 4 lớp

| Lớp | Công nghệ | Nội dung | Ai điều khiển |
|---|---|---|---|
| L0 Bàn | SVG tĩnh | lưới, dải màu, glyph, nhà, chấm chủ | React render từ `view` |
| L1 Quân + chip | DOM, CSS transform + Web Animations API (WAAPI) | 4 quân, chip tiền bay, highlight ô | `replay.ts` |
| L2 FX canvas | **Pixi.js** (đã có trong `game/package.json`), 1 `<canvas>` trong suốt phủ đúng vùng bàn, `pointer-events: none` | hạt: xu, bụi, pháo giấy, tia, mảnh vỡ, vệt sáng | `fx/FxLayer.ts` qua API `emit(kind, opts)` |
| L3 Overlay | DOM + WAAPI | xúc xắc, thẻ bài, turn announce, banner, modal, kết quả | `replay.ts` + store |

Nguyên tắc:
- L2 **chỉ hạt**, không chữ, không nút, không state. Xoá canvas đi game vẫn chạy đúng.
- Một `Pixi.Application` duy nhất, tạo khi vào S6, huỷ khi rời; `resolution = min(devicePixelRatio, 2)`; ticker dừng khi không có hạt sống và khi tab ẩn.
- Texture hạt sinh bằng `Pixi.Graphics` → `generateTexture` lúc khởi tạo (xu = tròn gold viền navy, bụi = tròn mờ, confetti = chữ nhật 3 màu, tia = thoi) — **không file ảnh**.
- Pool sprite, tối đa `FX_MAX_PARTICLES = 150` sống cùng lúc; emit vượt cap thì bỏ bớt hạt cũ nhất.
- Tween DOM: helper riêng `fx/tween.ts` bọc WAAPI (`animate(el, keyframes, {duration, easing})` trả Promise) + `sequence/parallel`; **không thêm thư viện tween** để giữ bundle; nếu sau này cần spring thật mới cân nhắc `motion`.
- Mọi hiệu ứng nhận `tier` (§6) và tự rút gọn.

Tọa độ: `boardRef` cung cấp `tileCenter(idx)`, `podAnchor(seat)`, `bankAnchor()` (tâm bàn) tính theo CSS px; FxLayer dùng cùng hệ toạ độ (canvas đặt trùng bàn, scale theo `--ty-board`).

## 2. Nhịp một lượt (ngân sách thời gian)

Replay không được làm người chơi chờ: tổng replay một lượt thường ≤ 4 s, tệ nhất (đi 12 ô + thẻ chuyển ô + trả tiền) ≤ 7 s. Lượt của chính mình replay cùng tốc độ (không skip) để cảm nhận nhất quán; nhưng người chơi bấm vào bàn/sheet trong lúc replay thì **không bị chặn** — chỉ nút của cụm lượt giữa bàn chờ replay xong.

| Đoạn | Ngân sách |
|---|---|
| Gieo | 900 ms (lăn 720 + dừng 180) |
| Đi mỗi ô | 140 ms, tối đa 12 ô ≈ 1.7 s; từ ô thứ 8 tăng tốc 20% |
| Đáp ô | 300 ms |
| Trả tiền | 700 ms (xu bay 450 + đếm 500 chồng lấn) |
| Thẻ | 360 lật + giữ đến ACK (tối đa 6 s) |
| Xây/bán mỗi nhà | 260 ms |
| Vào tù | 900 ms |
| Phá sản | 1.6 s |

## 3. Danh mục hiệu ứng theo sự kiện

Cột **Lite** = bậc rút gọn cho máy yếu; **Off** = `prefers-reduced-motion` hoặc người dùng tắt: mọi thứ nhảy thẳng về trạng thái cuối, chỉ giữ fade 120 ms và cập nhật số tức thời. Âm theo `01` §9 mở rộng ở §7.

### 3.1 Gieo xúc xắc (`roll`)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| R1 | Lắc trước khi lăn | L3 | 2 viên rung ±6 px, xoay ±12°, 240 ms (cảm giác lắc tay) | giữ |
| R2 | Lăn | L3 | đổi mặt mỗi 80 ms, mỗi viên tự xoay 2 vòng (rotate 720°), viên 2 dừng muộn 120 ms | đổi mặt không xoay |
| R3 | Đáp | L3 | squash 1.15×0.85 → 1 trong 180 ms, bóng dưới co lại | giữ |
| R4 | Đôi! | L3 + L2 | badge gold pop + 16 tia gold bắn từ 2 viên; viền xúc xắc gold-deep | badge không hạt |
| R5 | Đôi lần 3 | L3 + L2 | mặt đổi coral, 10 tia coral, bàn rung 3 px 2 lần | đổi màu |
| R6 | Tổng | L3 | số tổng bay lên 12 px + scale 1.2 → 1 | fade |

### 3.2 Di chuyển (`move`, `teleport`)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| M1 | Nhảy ô | L1 | mỗi ô: translate theo cung cao 10 px, scale 1.15 ở đỉnh, squash 0.9 khi chạm | translate thẳng |
| M2 | Bụi khi chạm | L2 | 4 hạt bụi paper-deep toả 8 px, 200 ms, mỗi ô | bỏ |
| M3 | Vệt đường | L0 | ô vừa qua fill `--ty-path` fade 600 ms, nối tiếp thành vệt | giữ |
| M4 | Ô góc phản ứng | L1 | quân đi qua ô góc: hình giữa ô nảy 1 lần 400 ms (mũi tên Xuất phát, đèn lồng Lễ hội, vali Du lịch); UI v3 không còn bust trên ô góc | giữ |
| M5 | Teleport (thẻ/vào tù) | L1 + L2 | quân bay cung parabol cao 60 px 420 ms + xoay 360°, vệt 6 hạt gold (thẻ) / coral (tù) | cung không hạt |
| M6 | Qua Xuất phát | L2 + L3 | 10 xu phun từ ô 0 lên 40 px rồi bay về pod, ô 0 nháy gold, float `+160 tr`, Bé Lộc nhảy | float + nháy |
| M7 | Đáp ô | L0 + L1 | vòng sóng (ring) từ tâm ô mở 1.6× fade 300 ms; ô fill `--ty-landing` | fill |
| M8 | Đáp ô chưa chủ | L0 | dải màu ô nhấp nháy 2 lần + badge "Mua?" wobble trên ô | badge |
| M9 | Đáp ô có chủ khác | L1 | chấm chủ ô scale 1.6 pulse, pod chủ bật sáng viền | pulse |

### 3.3 Tiền (`pay`)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| P1 | Xu bay giữa pod | L2 | 5–12 xu (tỷ lệ theo số tiền: 5 + amount/100, cap 12) bay cung từ `podAnchor(from)` tới `podAnchor(to)`, stagger 30 ms, 450 ms, xoay nhẹ | 1 chip DOM bay |
| P2 | Xu về ngân hàng | L2 | bay về `bankAnchor()` và tan (scale 0 + fade) | chip bay rồi fade |
| P3 | Đếm số | L1 | pod người trả đếm xuống coral 500 ms, nhận đếm lên jade; số scale 1.1 ở cuối | đếm |
| P4 | Pod rung/nhún | L1 | người trả: shake ±3 px 240 ms; người nhận: bounce lên 4 px | bỏ |
| P5 | Float | L1 | `−90 tr` / `+90 tr` bay lên 24 px fade 900 ms | giữ |
| P6 | Cô Ngân | L1 | reason tax/fine/repair: bust Cô Ngân point pop cạnh pod 800 ms | giữ |
| P7 | Thuê lớn (≥ 500) | L2 + L3 | thêm 6 tia coral quanh pod người trả, chữ số to hơn 1 bậc | bỏ |

### 3.4 Mua đất (`buy`)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| B1 | Thẻ bay về ô | L3 → L1 | thẻ mini (dải màu + tên) bay từ sheet/pod tới ô 400 ms, co lại thành chấm chủ | chấm pop |
| B2 | Đóng dấu chủ | L0 | chấm chủ scale 0 → 1.4 → 1 (overshoot) 260 ms | giữ |
| B3 | Confetti nhỏ | L2 | 12 mảnh màu ghế + gold toả từ ô 500 ms | bỏ |
| B4 | Trọn nhóm! | L0 + L2 + L3 | 2–3 ô cùng nhóm nháy đồng loạt 3 lần, 20 confetti, toast `Trọn nhóm Miền Trung — thuê ×2` | toast + nháy |

### 3.5 Xây và bán (`build`, `sell`)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| H1 | Nhà mọc | L0 | scaleY 0 → 1.2 → 1 từ đáy, 260 ms | pop |
| H2 | Bụi xây | L2 | 6 hạt bụi + 2 tia jade | bỏ |
| H3 | Khách sạn (cấp 3) | L0 + L2 | 2 nhà gộp vào tâm 200 ms → khách sạn pop 1.3 → 1, 8 tia coral | pop |
| H4 | Bán nhà | L0 + L2 | nhà vỡ thành 5 mảnh jade rơi 300 ms → 3 xu bay về pod | fade + chip |
| H5 | Trong S8 | L3 | hàng vừa thao tác nháy nền gold 30% 400 ms; số tổng tài sản đếm | nháy |

### 3.6 Thẻ bài (`card`)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| C1 | Chồng thẻ rung | L0 | chồng thẻ ở ô (3 rect lệch) rung 200 ms | bỏ |
| C2 | Thẻ bay ra | L3 | từ ô → tâm bàn, scale 0.3 → 1, 320 ms | fade-in tại chỗ |
| C3 | Lật | L3 | rotateY 180° 360 ms, perspective 800 | crossfade |
| C4 | Nội dung | L3 | 3 dòng text fade-in stagger 60 ms; số tiền pop màu jade/coral | hiện ngay |
| C5 | Nhân vật | L1 | Bác Tỷ/Cô Ngân pose theo nội dung, trượt vào từ trái 240 ms | hiện |
| C6 | Đóng | L3 | thẻ bay về đáy chồng, scale 0.3, 280 ms | fade |

### 3.7 Nhà tù (`jail-in`, `jail-out`)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| J1 | Còi | L1 + L3 | bust Chú Cảnh point pop cạnh pod người vào tù (vào tù chỉ qua thẻ hoặc 3 lần đôi; ô 24 giờ là Du lịch), còi nháy coral 2 lần, vignette coral 8% 300 ms (không flash trắng) | bust |
| J2 | Bay vào tù | L1 + L2 | quân cung parabol xoay, 6 hạt coral | cung |
| J3 | Sập song | L0 | 3 song `tg-jail` scaleY 0 → 1 từ trên 220 ms, bàn rung 2 px | song hiện |
| J4 | Tèo buồn | L1 | bust Anh Tèo sad + giọt mồ hôi rơi (1 hạt) | pose |
| J5 | Badge pod | L1 | chip tù trượt vào pod | hiện |
| J6 | Ra tù | L0 + L1 | song nhấc lên, quân nhảy ra, Tèo happy 400 ms | quân đi |

### 3.8 Nợ và phá sản (`debt`, `bankrupt`)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| D1 | Báo nợ | L1 | pod coral pulse 1 s, số tiền shake, Cô Ngân point trong O3 | pulse |
| D2 | Phá sản — pod | L1 | desaturate 400 ms + overlay nứt (SVG 3 nét) fade-in | desaturate |
| D3 | Quân rơi | L1 + L2 | quân rơi khỏi bàn 40 px + xoay 90° fade 500 ms, 4 hạt bụi | fade |
| D4 | Mất đất | L0 + L2 | chấm chủ từng ô bật ra như bong bóng (scale 1.4 → 0) stagger 40 ms, 2 hạt/ô; nếu chuyển cho chủ nợ thì chấm đổi màu bằng crossfade | chấm mất |
| D5 | Vignette | L3 | tối 10% 600 ms toàn màn | bỏ |
| D6 | Bé Lộc | L1 | pose sad ở góc 0 trong 1 s | bỏ |

### 3.9 Lượt, vòng, chờ
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| T1 | Đến lượt bạn | L3 + L1 | announce scale-in 300 ms giữ 900, viền pod sweep gold 360°, quân mình bounce 2 lần, bust Bác Tỷ point | announce |
| T2 | Lượt người khác | L1 | pod họ viền sáng 300 ms, chip lượt giữa bàn đổi tên + màu ghế | giữ |
| T3 | Đổi vòng | L3 | chip vòng flip dọc 240 ms số mới | đổi số |
| T4 | Vòng 28–29 | L3 | chip chuyển coral + nhịp 1 lần | đổi màu |
| T5 | Vòng cuối | L3 + L0 | banner slide, viền bàn pulse gold 3 lần | banner |
| T6 | Chờ | L1 | Mèo Đậu bust vẫy đuôi loop (2 frame crossfade 1.2 s) | tĩnh |
| T7 | Timer ≤ 10 s | L3 | số pulse danger mỗi giây + tick; ≤ 3 s scale 1.2 | đổi màu |
| T8 | Idle quân | L1 | quân "thở" scale 1 → 1.03 loop 2.4 s, lệch pha theo seat | bỏ |

### 3.10 Kết quả (`finish` → S9)
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| F1 | Bàn mờ | L0 | bàn dim 40% 400 ms, quân người thua fade | dim |
| F2 | Bục | L3 | hàng hạng 1 rise 360 ms, hàng 2–4 stagger 80 ms | fade |
| F3 | Pháo giấy | L2 | 60 confetti gold/màu ghế người thắng rơi 2 s (chỉ khi mình hạng 1: thêm 40) | bỏ |
| F4 | Cột tài sản | L3 | bar chart ngang từng người grow 600 ms stagger, số đếm | hiện |
| F5 | Dấu hạng | L3 | badge `#1..#4` stamp scale 1.5 → 1 | hiện |
| F6 | Nhân vật | L1 | Bác Tỷ happy / Bé Lộc sad slide-in | hiện |
| F7 | XP | L3 | chip `+50 XP` pop sau 600 ms | hiện |

### 3.11 Lobby và UI chung
| # | Hiệu ứng | Lớp | Chi tiết | Lite |
|---|---|---|---|---|
| U1 | Logo | L3 | float lên xuống 6 px loop 3 s | tĩnh |
| U2 | Bác Tỷ lobby | L1 | bob 4 px loop 2.8 s, quạt phe phẩy = 2 frame crossfade | tĩnh |
| U3 | CTA shine | L3 | vệt sáng quét qua nút gold mỗi 6 s (gradient mask 600 ms) | bỏ |
| U4 | Nút bấm | L3 | squash 0.96 80 ms rồi về | giữ |
| U5 | Sheet | L3 | slide-up với overshoot nhẹ (cubic-bezier(.2,.9,.3,1.1)) 280 ms | slide |
| U6 | Chip/badge xuất hiện | L3 | pop 0.8 → 1 160 ms | hiện |
| U7 | Toast | L3 | slide từ trên 200 ms, icon pop | slide |
| U8 | Tab/row | L3 | row rise 10 px stagger 24 ms (tối đa 10) | hiện |
| U9 | Số KEN lobby | L3 | đếm rAF 700 ms (như caro) | đếm |

Tổng: **≈ 60 hiệu ứng**, trong đó 22 dùng L2 (hạt). Mọi hiệu ứng L2 có bản Lite không hạt.

## 4. API và tổ chức code

```text
game/tycoon/fx/
  FxLayer.ts        # Pixi app, pool, emit(kind, opts), tier, pause/resume
  particles.ts      # định nghĩa từng kind: coin, dust, confetti, spark, shard, trail
  tween.ts          # animate(el, kf, opts): Promise; sequence(); parallel(); easings
  effects/          # mỗi file 1 nhóm §3: roll.ts, move.ts, pay.ts, buy.ts, build.ts, card.ts, jail.ts, bankrupt.ts, turn.ts, result.ts
  anchors.ts        # tileCenter, podAnchor, bankAnchor từ refs
```

`replay.ts` chỉ gọi `effects.move(step, ctx)`… và `await` Promise; không chứa số liệu animation. Mỗi effect nhận `ctx = {tier, anchors, fx, sound}`; `tier='off'` → effect áp state cuối ngay và resolve.

`emit` kinds:

| kind | opts | Mô tả |
|---|---|---|
| `coins` | from, to, count, color | bay cung, xoay, tan khi đến |
| `dust` | at, count | toả tròn, fade |
| `confetti` | at, count, colors[] | rơi có trọng lực + xoay |
| `spark` | at, count, color | tia ngắn bắn thẳng |
| `shard` | at, count, color | mảnh vỡ rơi |
| `trail` | path[], color | vệt sáng theo đường |

## 5. Hiệu năng

- Mục tiêu 60 fps trên máy tầm trung (Android 2020, iPhone 11). Ngưỡng: frame > 32 ms liên tiếp 20 lần trong 3 s đầu S6 → tự hạ xuống Lite, lưu localStorage `ola:tycoon:fxTier`.
- Canvas Pixi: `antialias: false`, `backgroundAlpha: 0`, `autoDensity: true`, ticker dừng khi không có hạt.
- DOM: chỉ animate `transform` và `opacity`; không animate `width/height/top/left`; `will-change: transform` cho quân khi di chuyển, bỏ sau.
- Không quá 3 effect L1 chạy song song ngoài replay (idle thở + chờ + float).
- Bundle: Pixi đã có trong deps (war-god); tycoon import tối thiểu (`Application, Container, Sprite, Graphics, Ticker`) để tree-shake.
- Đo bằng `scripts/tycoon-shots.mjs --audit-motion` (pattern xiangqi): log frame time trung bình/p95 từng effect, fail nếu p95 > 24 ms ở tier Full.

## 6. Bậc hiệu ứng (tier)

| Tier | Khi nào | Nội dung |
|---|---|---|
| `full` | mặc định | tất cả §3 |
| `lite` | `deviceMemory < 3`, hoặc tự hạ theo §5, hoặc người dùng chọn | cột Lite: không hạt, không rung, giữ nhảy/đếm/lật |
| `off` | `prefers-reduced-motion` hoặc người dùng chọn | mọi thứ nhảy về cuối, fade 120 ms, số tức thời |

Cài đặt trong lobby cạnh nút âm thanh: `Hiệu ứng: Đầy đủ / Nhẹ / Tắt`. Store `fxTier`, lưu localStorage.

## 7. Âm thanh (WebAudio, không file) — mở rộng

Thêm vào `01` §9: `shake` (noise ngắn 3 lần), `double` (2 nốt gold nhanh), `coin` (ting 1800 Hz 40 ms, pitch ngẫu nhiên ±5%, tối đa 6 lần/giây), `stamp` (gõ trầm 80 ms), `whistle` (còi 2 nốt), `bars` (va kim loại), `crack` (nứt — noise + nốt trầm), `fanfare` (4 nốt lên), `pop` (chip/badge). Mỗi effect gọi `sound.play(name)`; tắt loa thì no-op. Âm không phụ thuộc tier (tắt riêng).

## 8. Kiểm thử

- Unit: `tween.ts` (Promise resolve đúng, cancel khi epoch đổi), `particles.ts` (cap 150, pool tái dùng, không rò sprite sau 1000 emit).
- Harness: `mock-ui.html?screen=board&fx=<id>` chạy 1 effect lặp để chỉnh số; `&tier=lite|off` kiểm fallback.
- Replay dài: fixture 40 step chạy tier full/lite/off đều kết thúc đúng state, không hạt sót, canvas rỗng sau 2 s.
- E2E bot chạy với `fxTier=off` (ổn định); 1 run `full` để bắt lỗi JS trong effect.
