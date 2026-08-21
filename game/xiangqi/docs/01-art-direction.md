# 01 — Art direction: Mộc bản thủ công (Kỳ Đàn Son Mộc)

> Đây là art direction tổng quan. Đặc tả triển khai chi tiết nằm trong [`style/`](./style/README.md).

## 1. DNA hình ảnh

- Không khí: bàn cờ gỗ ngoài hiên nhà, ấm, tĩnh, sang nhưng gần gũi — không "casino", không neon.
- Ba chất liệu chủ đạo: **gỗ trầm** (nền màn), **giấy kem** (mặt bàn cờ), **son – mực** (hai phe quân).
- Kế thừa DNA mini-game Ola: outline navy đồng nhất, hình học phẳng, CTA vàng nắng, text live.
- Quân cờ là ngôi sao: đĩa tròn nổi nhẹ, chữ Hán khắc rõ, mọi thứ khác nhường độ tương phản cho bàn + quân.

## 2. Palette chuẩn

### 2.1 Core tokens

| Token | Hex | Dùng cho |
|---|---|---|
| `--xq-wood-900` | `#3E2A1E` | nền màn (đáy gradient) |
| `--xq-wood-700` | `#5C3E2A` | nền màn (đỉnh gradient), khung bàn |
| `--xq-wood-500` | `#8B5E3C` | viền khung bàn, phân cách |
| `--xq-paper` | `#F3E4C3` | mặt bàn cờ |
| `--xq-paper-dim` | `#E8D5AE` | hàng chẵn list, panel phụ |
| `--xq-navy` | `#1F2A44` | outline thống nhất, chữ chính trên nền sáng |
| `--xq-line` | `#6B4A2F` | nét lưới bàn cờ (mực nâu) |
| `--xq-red` | `#C0392B` | phe Đỏ, accent nguy hiểm |
| `--xq-red-deep` | `#8F1D12` | chữ khắc quân Đỏ, viền quân Đỏ |
| `--xq-ink` | `#1B1B1F` | phe Đen, chữ khắc quân Đen |
| `--xq-gold` | `#F2B807` | CTA chính, badge cược |
| `--xq-gold-deep` | `#B98700` | viền/shadow CTA vàng |
| `--xq-cream` | `#FFF6E3` | chữ trên nền gỗ, mặt quân |
| `--xq-jade` | `#2E7D5B` | trạng thái thắng/sẵn sàng |

### 2.2 Semantic tokens

| Token | Giá trị | Dùng cho |
|---|---|---|
| `--xq-turn-mine` | `--xq-gold` | vòng lượt của mình, turn announce |
| `--xq-turn-opp` | `--xq-cream` 60% | vòng lượt đối thủ |
| `--xq-check` | `--xq-red` | banner Chiếu, viền Tướng đang bị chiếu |
| `--xq-hint` | `#2E7D5B` 85% | chấm gợi ý nước đi |
| `--xq-hint-capture` | `--xq-red` 85% | vòng gợi ý đè lên quân ăn được |
| `--xq-last-move` | `#F2B807` 45% | ô from/to nước vừa đi |
| `--xq-danger` | `#D64545` | Bỏ cuộc, lỗi, timer ≤10s |
| `--xq-overlay` | `#1F1A14` 62% | backdrop modal |

### 2.3 Quy tắc tương phản

- Chữ trên `--xq-paper`: dùng `--xq-navy` hoặc `--xq-ink` (AA ≥ 4.5).
- Chữ trên gỗ: `--xq-cream`; không đặt chữ đỏ trực tiếp lên gỗ (fail AA) — đỏ chỉ đứng trên kem/giấy.
- `--xq-gold` chỉ làm nền nút/badge với chữ navy, không làm màu chữ trên nền sáng.
- Highlight `--xq-last-move` và `--xq-hint` phải đọc được trên `--xq-paper` lẫn trên texture; giữ alpha ≥ 45%.

## 3. Hình học

### 3.1 Border

- Outline navy 1.5 px cho component nhỏ (badge, input), 2 px cho panel/nút lớn — thống nhất toàn game.
- Quân cờ: viền kép — vòng ngoài navy 1.5 px, vòng khắc trong màu phe 2 px.
- Lưới bàn cờ: nét `--xq-line` 1.5 px, biên ngoài bàn 3 px.

### 3.2 Radius

Chỉ dùng scale `8 / 12 / 16 / 20 / 28 / 999`:

- 999: quân cờ, chấm gợi ý, avatar, badge tròn;
- 20–28: modal, panel kết quả;
- 16: nút CTA, hàng room list;
- 12: input, badge cược;
- 8: chip nhỏ, tooltip.

### 3.3 Icon

Stroke 2 px, cap tròn, vẽ trên grid 24; bộ nhỏ 16 cho inline. Không icon fill đặc trừ trạng thái active.

## 4. Bàn cờ và quân — tỷ lệ thị giác

- Bàn 9 cột × 10 hàng giao điểm; tỷ lệ mặt bàn `8:9` (8 khoảng ngang × 9 khoảng dọc) + lề 1/2 khoảng mỗi phía.
- Tại viewport 390: khoảng lưới `cell = 40 px` → mặt bàn `360 × 400 px`, chiếm trọn bề ngang trừ lề 15 px.
- Quân đường kính `0.92 × cell` (≈ 37 px tại 390) — chạm nhau gần như sít khi đứng cạnh, đúng cảm giác bàn thật.
- Vùng chạm mỗi giao điểm tối thiểu 44 × 44 px (cell 40 + spill 4) — chấp nhận overlap chạm, ưu tiên giao điểm gần tâm chạm nhất.
- Chữ khắc trên quân chiếm 62% đường kính, font serif CJK đậm.

## 5. Typography

### 5.1 Font

- UI: giữ hệ font của game Ola hiện có (sans đậm cho số/nút, xem caro) — không thêm font UI mới.
- Chữ Hán trên quân: **không phải live text** — nằm trong asset webp mặt quân (xem 04). Duy nhất ngoại lệ nguyên tắc live-text, vì là hình khắc của quân.
- Nhãn Việt kèm quân khi cần (tooltip, lịch sử nước): live text `Tướng/Sĩ/Tượng/Xe/Pháo/Mã/Tốt`.

### 5.2 Type scale tại viewport 390

| Vai trò | Size/weight |
|---|---|
| Title màn | 24/800 |
| Turn announce | 20/800, letter-spacing 0.04em |
| Nút CTA | 17/700 |
| Body/label | 15/600 |
| Số KEN | 16/800 tabular |
| Phụ chú, timestamp | 12.5/500 |
| Đồng hồ lượt | 22/800 tabular |

## 6. Shadow và độ sâu

- 3 mức: `sm` 0 1 2 / 25% navy (chip), `md` 0 3 8 / 30% (nút, quân), `lg` 0 10 28 / 38% (modal, result).
- Quân đang được chọn: nâng shadow md → lg + translateY(-2 px).
- Không dùng glow ngoài trừ 2 chỗ: vòng lượt của mình (gold, blur 6) và Tướng bị chiếu (red, blur 6, pulse).

## 7. Gradient

- Nền màn: linear 180° `--xq-wood-700 → --xq-wood-900`.
- CTA vàng: linear 180° `#FFD34D → #F2B807`, viền `--xq-gold-deep`.
- Mặt quân: radial nhẹ `#FFFBEF → #F3E4C3` (nằm trong asset).
- Không gradient nhiều màu, không gradient trên chữ.

## 8. Motion

| Chuyển động | Thông số |
|---|---|
| Quân trượt (steps replay) | 220 ms, cubic-bezier(.2,.8,.3,1) |
| Quân bị ăn | scale .8 + fade 180 ms, sau khi quân ăn đáp xuống |
| Chấm gợi ý xuất hiện | fade+scale 120 ms stagger 12 ms |
| Banner Chiếu | slide-down + shake 2 px, 450 ms, tự ẩn sau 1.2 s |
| Turn announce | fade-scale 300 ms, giữ 900 ms |
| Timer ≤10 s | pulse màu `--xq-danger` mỗi 1 s |
| KEN float ±  | bay lên 24 px + fade 900 ms (giống caro) |
| Modal | fade backdrop 150 ms + pop 180 ms |

`prefers-reduced-motion`: tắt shake/pulse, quân nhảy thẳng vị trí, giữ fade ≤ 150 ms.

## 9. Âm thanh (WebAudio tổng hợp, không file)

Theo pattern `war-god/audio.ts`: `click` (gõ nhẹ), `place` (gõ quân trầm ~180 Hz, 60 ms), `capture` (2 nốt gõ nhanh), `check` (cảnh báo 660→880 Hz), `win`/`lose` (arpeggio 3 nốt lên/xuống). Có toggle âm ở lobby, lưu localStorage.

## 10. Anti-style

- Không neon, không glassmorphism, không 3D render quân.
- Không rồng phượng/hoa văn dày đặc — texture chỉ ở nền, không bao giờ sau chữ.
- Không đổ bóng chữ, không outline chữ.
- Không dùng ảnh AI nguyên khối làm màn; asset sinh ra phải qua QA từng cái (xem 04).
