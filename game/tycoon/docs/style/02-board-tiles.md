# 02 — Bảng màu 32 ô bàn cờ

Mỗi ô là `<g class="ty-tile" data-idx data-kind data-group>`. Màu lấy từ token `01-foundations.md`; cột hex ghi lại để người vẽ concept không phải tra.

## 1. Anatomy chung

| Phần | Ô đất (`street`) | Ô sân bay | Ô thẻ/thuế | Ô góc |
|---|---|---|---|---|
| Kích thước (390) | 38.1 × 49.8 | 38.1 × 49.8 | 38.1 × 49.8 | 49.8 × 49.8 |
| Nền | paper `#FCFDF0` | paper | paper | Xuất phát, Du lịch, Nhà tù: paper; Lễ hội: festival-bg `#0B1F66` |
| Dải màu | 7–9 px ở mép phía trong bàn, màu nhóm, viền navy 1 px cạnh giáp thân ô | không | không | không |
| Tên (trên) | tên ngắn 800, `board × 0.0182`, ≤ 2 dòng | `Sân bay` | `Cơ hội`, `Khí vận`, `Thuế` | chữ góc in hoa 1 dòng 800 (`XUẤT PHÁT`, `NHÀ TÙ`, `LỄ HỘI`, `DU LỊCH`) |
| Tranh / glyph (giữa) | tranh pixel 16-bit địa danh, phủ hết chiều rộng thân ô, có trời | tranh pixel máy bay + tháp chỉ huy (chung 4 ô) | glyph vector 18 px: Cơ hội `?` cam, Khí vận gió xanh, Thuế túi tiền vàng có `%` | Xuất phát: mũi tên jade chỉ lên; Nhà tù: tranh pixel phòng giam có Anh Tèo; Lễ hội: tranh pixel đèn lồng + ngôi sao vàng; Du lịch: vali cam + máy bay nhỏ |
| Giá (dưới) | `220 tr` tabular; có chủ → tiền thuê hiện tại | `200 tr` | Thuế: `−10%` coral; thẻ: không có | Xuất phát `+160 tr` jade; Nhà tù `Thăm tù`; Lễ hội `Thuê x2` cream; Du lịch `Bay lượt sau` |
| Cấp nhà | **trên dải**: cấp 1 = 1 nhà jade `#1F8A5B`, cấp 2 = 2 nhà, cấp 3 = 1 khách sạn coral; viền cream 1 px (§6) | — | — | — |
| Có chủ | nền seat-soft + vạch 3 px màu ghế ở mép **ngoài** | như trái | — | — |
| Quân | con tốt 16 × 24, đế đứng trên mép trong ô, thân nhô vào vùng trong | như trái | như trái | ô 8: vùng theo trạng thái tù |
| Lưới | line `#8C7B5E` 1 px | | | |

Xoay: cạnh dưới 0°, cạnh trái 90°, cạnh trên 180°, cạnh phải 270° cho **khung + dải**. Tên, tranh/glyph, giá, nhà, quân **không xoay**: luôn đứng thẳng, đọc từ trên xuống (tên → tranh → giá) ở cả 4 cạnh.

Tranh pixel (`assets/tiles/art/{slug}.webp`): vẽ gốc 64 × 40 px, export ×3 nearest-neighbor, hiển thị `image-rendering: pixelated`. Ở bàn < 456 tranh thu nhỏ nhưng không ẩn; nếu tranh lỗi thì ô vẫn đọc được bằng tên + giá + dải. Ảnh mẫu vẽ dải hàng trên ở mép ngoài và tên đè lên dải — **không làm theo**, hàng trên cũng đặt dải ở đáy ô.

## 2. Bảng 32 ô

Xuất phát ở góc dưới-trái, đi thuận kim đồng hồ (05 §1). 16 ô đất là 16 thành phố; giá và tiền thuê ở [09-economy.md](../09-economy.md).

Cột "Glyph màu" là `fill` của `tg-*`. `art/{slug}` là tranh pixel 16-bit (§1), slug không dấu theo tên thành phố (`thanh-hoa`, `da-lat`, `tp-hcm`…). Trong UI v3 chỉ Nhà tù có nhân vật (Anh Tèo vẽ sẵn trong tranh); nhân vật khác xuất hiện ở sheet/thẻ (03-characters §4).

| Idx | Vị trí | Tên (live text) | kind | Dải (hex) | Nền | Tranh / glyph | Glyph màu | Nhân vật trên ô |
|---|---|---|---|---|---|---|---|---|
| 0 | góc dưới-trái | Xuất phát | go | — | paper | `tg-go` | jade `#1F8A5B` | — |
| 1 | cột trái ↑ | Thanh Hóa | street | brown `#8D5B3C` | paper | tranh `art/{slug}` | — | — |
| 2 | cột trái ↑ | Khí vận | chest | — | paper | `tg-chest` | chest-deep `#0D95EE` | — |
| 3 | cột trái ↑ | Vinh | street | brown | paper | tranh `art/{slug}` | — | — |
| 4 | cột trái ↑ | Cơ hội | chance | — | paper | `tg-chance` | chance-deep `#E0560E` | — |
| 5 | cột trái ↑ | Buôn Ma Thuột | street | sky `#7EC8E3` | paper | tranh `art/{slug}` | — | — |
| 6 | cột trái ↑ | Sân bay | station | — | paper | tranh `art/san-bay` | — | — |
| 7 | cột trái ↑ | Đà Lạt | street | sky | paper | tranh `art/{slug}` | — | — |
| 8 | góc trên-trái | Nhà tù / Thăm tù | jail | — | paper | tranh `art/nha-tu` (fallback `tg-jail`) | navy | Anh Tèo (trong tranh) |
| 9 | hàng trên → | Cần Thơ | street | pink `#E58FB5` | paper | tranh `art/{slug}` | — | — |
| 10 | hàng trên → | Sân bay | station | — | paper | tranh `art/san-bay` | — | — |
| 11 | hàng trên → | Phú Quốc | street | pink | paper | tranh `art/{slug}` | — | — |
| 12 | hàng trên → | Thuế thu nhập | tax | — | paper | `tg-tax` | gold `#F2B807`, `%` coral | — |
| 13 | hàng trên → | Quy Nhơn | street | orange `#F2994A` | paper | tranh `art/{slug}` | — | — |
| 14 | hàng trên → | Khí vận | chest | — | paper | `tg-chest` | chest-deep `#0D95EE` | — |
| 15 | hàng trên → | Nha Trang | street | orange | paper | tranh `art/{slug}` | — | — |
| 16 | góc trên-phải | Lễ hội | festival | — | festival-bg | tranh `art/le-hoi` (fallback `tg-festival`) | gold | — |
| 17 | cột phải ↓ | Hội An | street | red `#D64545` | paper | tranh `art/{slug}` | — | — |
| 18 | cột phải ↓ | Cơ hội | chance | — | paper | `tg-chance` | chance-deep `#E0560E` | — |
| 19 | cột phải ↓ | Huế | street | red | paper | tranh `art/{slug}` | — | — |
| 20 | cột phải ↓ | Cơ hội | chance | — | paper | `tg-chance` | chance-deep `#E0560E` | — |
| 21 | cột phải ↓ | Hạ Long | street | yellow `#F2D04E` | paper | tranh `art/{slug}` | — | — |
| 22 | cột phải ↓ | Sân bay | station | — | paper | tranh `art/san-bay` | — | — |
| 23 | cột phải ↓ | Hải Phòng | street | yellow | paper | tranh `art/{slug}` | — | — |
| 24 | góc dưới-phải | Du lịch | travel | — | paper | `tg-travel` | cam `#F2994A` + máy bay sky-deep | — |
| 25 | hàng dưới ← | Vũng Tàu | street | green `#3BA776` | paper | tranh `art/{slug}` | — | — |
| 26 | hàng dưới ← | Sân bay | station | — | paper | tranh `art/san-bay` | — | — |
| 27 | hàng dưới ← | Đà Nẵng | street | green | paper | tranh `art/{slug}` | — | — |
| 28 | hàng dưới ← | Khí vận | chest | — | paper | `tg-chest` | chest-deep `#0D95EE` | — |
| 29 | hàng dưới ← | Cơ hội | chance | — | paper | `tg-chance` | chance-deep `#E0560E` | — |
| 30 | hàng dưới ← | Hà Nội | street | blue `#2F5FD0` | paper | tranh `art/{slug}` | — | — |
| 31 | hàng dưới ← | TP. Hồ Chí Minh | street | blue | paper | tranh `art/{slug}` | — | — |

Ghi chú màu glyph: Cơ hội dùng `chance-deep` và Khí vận dùng `chest-deep` trên ô paper để hình 18 px đủ tương phản; bản sáng (`chance`, `chest`) chỉ dùng làm nền chồng thẻ và dải thẻ, khi đó glyph cream/navy.

## 3. Ô góc chi tiết (49.8 × 49.8)

Bốn ô góc theo ảnh mẫu: chữ in hoa 1 dòng ở trên, hình ở giữa, dòng phụ ở dưới. Không có bust nhân vật trên ô góc (trừ Anh Tèo vẽ sẵn trong tranh Nhà tù).

| Ô | Bố cục | Trạng thái động |
|---|---|---|
| 0 Xuất phát (dưới-trái) | nền paper; `XUẤT PHÁT` navy; mũi tên `tg-go` jade **chỉ lên** (hướng đi lên cột trái); `+160 tr` jade 800 | khi ai qua: nền nháy `--ty-landing` 300 ms, mũi tên nảy 1 lần |
| 8 Nhà tù (trên-trái) | nền paper; `NHÀ TÙ` navy; giữa là tranh pixel phòng giam có song sắt và Anh Tèo; dải `Thăm tù` ở đáy ô | quân trong tù đứng trong tranh, sau song (z thấp hơn song); quân thăm tù đứng ở dải `Thăm tù` |
| 16 Lễ hội (trên-phải) | nền `festival-bg`; `LỄ HỘI` cream; tranh pixel đèn lồng đỏ + ngôi sao vàng; `Thuê x2` cream | Ô thành phố đang có Lễ hội: viền trong 2 px gold + huy hiệu tròn gold-deep có ngôi sao cream ở góc trên-phải |
| 24 Du lịch (dưới-phải) | nền paper; `DU LỊCH` navy; `tg-travel` vali cam có máy bay nhỏ; `Bay lượt sau` navy 12.5 | lượt sau của người đáp: chạm ô bất kỳ → sheet có nút `Bay tới đây`; quân bay cung (`teleport`) |

Fallback khi tranh lỗi hoặc máy yếu (`data-art="off"`): Nhà tù dùng `tg-jail`, Lễ hội dùng `tg-festival` gold 26 px; Xuất phát và Du lịch vốn là glyph nên không đổi.

## 4. Chip nhóm (trong sheet S7/S8)

`.ty-chip-group[data-group=red]`: ô vuông 12 × 12 màu nhóm, viền navy 1 px, radius 2, + tên nhóm navy 12.5/500. Tên nhóm:

| data-group | Tên hiển thị |
|---|---|
| brown | Bắc Trung Bộ |
| sky | Tây Nguyên |
| pink | Miền Tây |
| orange | Nam Trung Bộ |
| red | Di sản miền Trung |
| yellow | Duyên hải Bắc Bộ |
| green | Thành phố biển |
| blue | Đô thị đặc biệt |
| station | Sân bay |

## 5. Header sheet S7 theo loại ô

| kind | Dải header 44 px | Icon/nhân vật trong header (64 px, bên phải) |
|---|---|---|
| street | màu nhóm, không chữ; tên ô + chip nhóm ở dưới trên paper | tranh `art/{slug}` 64 px; cấp nhà hiện bằng 1–2 `ic-house` jade hoặc khách sạn coral |
| station | paper-dim | tranh `art/san-bay` 64 px |
| chance | chance | Bác Tỷ pose `idle` 64 px |
| chest | chest | Cô Ngân pose `idle` 64 px |
| tax | paper-dim pha coral 10% | Cô Ngân pose `point` 64 px |
| go | paper-dim | Bé Lộc `happy` |
| jail | paper-dim | tranh `art/nha-tu` 64 px |
| festival | festival-bg | tranh `art/le-hoi` 64 px (fallback `tg-festival` 40 px gold) |
| travel | paper-dim | `tg-travel` 40 px |

## 6. Màu nhà/khách sạn, vạch chủ và quân trên nền

| Phần tử | Trên paper | Trên dải màu | Ghi chú |
|---|---|---|---|
| `tg-house` | — | jade `#1F8A5B`, viền cream 1 px | 6 × 6, gap 1 |
| `tg-hotel` | — | coral `#E4573D`, viền cream 1 px | 14 × 8 |
| vạch chủ | seat-n 3 px ở mép **ngoài** ô + nền seat-soft | không đặt | thay chấm chủ 8 px cũ; nằm đối diện dải nên không lẫn |
| quân | con tốt `tk-pawn` 16 × 24 fill seat-n, viền navy 1.5 | không đặt (đế đứng trên mép trong, thân nhô vào vùng trong) | 03 §3 |

Nhà nằm **trên dải** (khớp code `Board.tsx` và 03 §2.3). Viền cream 1 px quanh nhà/khách sạn giữ chúng nổi trên mọi dải, kể cả jade trên dải xanh lá và coral trên dải đỏ. Vạch chủ và quân không đặt trên dải.
