# 02 — Bảng màu 32 ô bàn cờ

Mỗi ô là `<g class="ty-tile" data-idx data-kind data-group>`. Màu lấy từ token `01-foundations.md`; cột hex ghi lại để người vẽ concept không phải tra.

## 1. Anatomy chung

| Phần | Ô đất (`street`) | Ô sân bay | Ô thẻ/thuế | Ô góc |
|---|---|---|---|---|
| Kích thước (390) | 38.1 × 49.8 | 38.1 × 49.8 | 38.1 × 49.8 | 49.8 × 49.8 |
| Nền | paper `#FBF3E0` | paper-dim `#F0E4C8` | Cơ hội gold-soft, Khí vận sky-soft, Thuế coral-soft | Xuất phát gradient vàng; Lễ hội gold-soft; Du lịch sky-soft; ô 8 Nhà tù: dải Thăm tù paper ở mép trên + mép trái, phòng giam dim ở góc dưới-phải |
| Dải màu | 7–9 px ở mép phía trong bàn, màu nhóm, viền navy 1 px cạnh giáp thân ô | không | không | không |
| Tên (trên) | tên ngắn 800, `board × 0.0182`, ≤ 2 dòng | như trái | như trái (`Cơ hội`, `Khí vận`, `Thuế`) | chữ góc 2 dòng (`LỄ / HỘI`, `DU / LỊCH`, `NHÀ TÙ`, `XUẤT / PHÁT`) |
| Tranh / glyph (giữa) | tranh phong cảnh địa danh (concept UI v3); bàn < 456 có thể ẩn tranh | glyph 18 px | glyph 18 px | bust nhân vật 30 px (03-characters) — fallback glyph 26 px |
| Giá (dưới) | `220 tr` tabular; có chủ → tiền thuê hiện tại | `200 tr` / `150 tr` | thẻ: không có | Xuất phát: `+160 tr` jade |
| Cấp nhà | trên dải: cấp 1 = 1 nhà jade `#1F8A5B`, cấp 2 = 2 nhà, cấp 3 = 1 khách sạn coral | — | — | — |
| Có chủ | nền seat-soft + vạch 3 px màu ghế ở mép **ngoài** | như trái | — | — |
| Quân | ghim ~24 px, mũi chạm mép trong ô, thân trong vùng trong | như trái | như trái | ô 8: vùng theo trạng thái tù |
| Lưới | line `#8C7B5E` 1 px | | | |

Xoay: cạnh dưới 0°, cạnh trái 90°, cạnh trên 180°, cạnh phải 270° cho **khung + dải**. Tên, tranh/glyph, giá, nhà, quân **không xoay**: luôn đứng thẳng, đọc từ trên xuống (tên → tranh → giá) ở cả 4 cạnh.

## 2. Bảng 32 ô

Xuất phát ở góc dưới-trái, đi thuận kim đồng hồ (05 §1). 16 ô đất là 16 thành phố; giá và tiền thuê ở [09-economy.md](../09-economy.md).

Cột "Glyph màu" là `fill` của `tg-*`. Cột "Nhân vật" chỉ ô góc có bust; nhân vật của ô khác xuất hiện ở sheet/thẻ (03-characters §4).

| Idx | Vị trí | Tên (live text) | kind | Dải (hex) | Nền | Glyph | Glyph màu | Nhân vật trên ô |
|---|---|---|---|---|---|---|---|---|
| 0 | góc dưới-trái | Xuất phát | go | — | dim | `tg-go` (fallback) | navy `#1F2A44` | Bé Lộc (bust) |
| 1 | cột trái ↑ | Thanh Hóa | street | brown `#8D5B3C` | paper | — | — | — |
| 2 | cột trái ↑ | Khí vận | chest | — | sky-soft | `tg-chest` | sky-deep `#3C9BBF` | — |
| 3 | cột trái ↑ | Vinh | street | brown | paper | — | — | — |
| 4 | cột trái ↑ | Cơ hội | chance | — | gold-soft | `tg-chance` | gold-deep `#B98700` | — |
| 5 | cột trái ↑ | Buôn Ma Thuột | street | sky `#7EC8E3` | paper | — | — | — |
| 6 | cột trái ↑ | Sân bay | station | — | dim | `tg-plane` | navy | — |
| 7 | cột trái ↑ | Đà Lạt | street | sky | paper | — | — | — |
| 8 | góc trên-trái | Nhà tù / Thăm tù | jail | — | paper ∕ dim | `tg-jail` (fallback) | navy | Anh Tèo (bust, vùng dim) |
| 9 | hàng trên → | Cần Thơ | street | pink `#E58FB5` | paper | — | — | — |
| 10 | hàng trên → | Sân bay | station | — | dim | `tg-plane` | navy | — |
| 11 | hàng trên → | Phú Quốc | street | pink | paper | — | — | — |
| 12 | hàng trên → | Thuế thu nhập | tax | — | coral-soft | `tg-tax` | coral `#E4573D` | — |
| 13 | hàng trên → | Quy Nhơn | street | orange `#F2994A` | paper | — | — | — |
| 14 | hàng trên → | Khí vận | chest | — | sky-soft | `tg-chest` | sky-deep `#3C9BBF` | — |
| 15 | hàng trên → | Nha Trang | street | orange | paper | — | — | — |
| 16 | góc trên-phải | Lễ hội | festival | — | gold-soft | `tg-festival` | gold-deep `#B98700` | Mèo Đậu (bust) |
| 17 | cột phải ↓ | Hội An | street | red `#D64545` | paper | — | — | — |
| 18 | cột phải ↓ | Cơ hội | chance | — | gold-soft | `tg-chance` | gold-deep `#B98700` | — |
| 19 | cột phải ↓ | Huế | street | red | paper | — | — | — |
| 20 | cột phải ↓ | Cơ hội | chance | — | gold-soft | `tg-chance` | gold-deep `#B98700` | — |
| 21 | cột phải ↓ | Hạ Long | street | yellow `#F2D04E` | paper | — | — | — |
| 22 | cột phải ↓ | Sân bay | station | — | dim | `tg-plane` | navy | — |
| 23 | cột phải ↓ | Hải Phòng | street | yellow | paper | — | — | — |
| 24 | góc dưới-phải | Du lịch | travel | — | sky-soft | `tg-travel` | sky-deep `#3C9BBF` | — |
| 25 | hàng dưới ← | Vũng Tàu | street | green `#3BA776` | paper | — | — | — |
| 26 | hàng dưới ← | Sân bay | station | — | dim | `tg-plane` | navy | — |
| 27 | hàng dưới ← | Đà Nẵng | street | green | paper | — | — | — |
| 28 | hàng dưới ← | Khí vận | chest | — | sky-soft | `tg-chest` | sky-deep `#3C9BBF` | — |
| 29 | hàng dưới ← | Cơ hội | chance | — | gold-soft | `tg-chance` | gold-deep `#B98700` | — |
| 30 | hàng dưới ← | Hà Nội | street | blue `#2F5FD0` | paper | — | — | — |
| 31 | hàng dưới ← | TP. Hồ Chí Minh | street | blue | paper | — | — | — |

Ghi chú màu glyph: Cơ hội dùng `gold-deep` thay vì `gold` vì `gold #F2B807` trên `paper-dim` chỉ đạt ~1.9:1 — không đủ cho hình 18 px. Khí vận dùng `sky-deep` cùng lý do. Trên thẻ bài (nền dải gold/sky đậm hơn) glyph dùng navy.

## 3. Ô góc chi tiết (49.8 × 49.8)

| Ô | Bố cục | Trạng thái động |
|---|---|---|
| 0 Xuất phát (dưới-trái) | bust Bé Lộc 30 px; mũi tên `tg-go` xoay 90° **chỉ lên** (hướng đi lên cột trái) + chip `+160` jade | khi ai qua: nền nháy `--ty-landing` 300 ms, Bé Lộc đổi pose `happy` 600 ms |
| 8 Nhà tù (trên-trái) | phòng giam 68% × 68% ở góc dưới-phải (phía vùng trong, dim/đỏ) có song `tg-jail` + bust Anh Tèo 22 px; dải Thăm tù (paper) chạy dọc mép trên + mép trái, chữ `Thăm tù` ở mép trên, quân thăm đứng ở dải trái | có người trong tù: Anh Tèo pose `sad`; quân trong tù đứng sau song (z thấp hơn song) |
| 16 Lễ hội (trên-phải) | nền gold-soft, `tg-festival` (ngôi sao) 22 px gold-deep + chữ `LỄ / HỘI` gold-deep; bản có nhân vật: bust Mèo Đậu 30 px | quân đáp: Mèo pose `happy` 600 ms. Ô thành phố đang có Lễ hội: viền trong 2 px gold + huy hiệu tròn gold-deep có ngôi sao cream ở góc trên-phải |
| 24 Du lịch (dưới-phải) | nền sky-soft, `tg-travel` (vali) 22 px sky-deep + chữ `DU / LỊCH` sky-deep | lượt sau của người đáp: chạm ô bất kỳ → sheet có nút `Bay tới đây`; quân bay cung (`teleport`) |

Fallback khi tắt nhân vật (`data-chars="off"` cho máy yếu hoặc asset lỗi): glyph 26 px màu theo bảng §2 thay bust.

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
| street | màu nhóm, không chữ; tên ô + chip nhóm ở dưới trên paper | — (hiện cấp: 1–2 `ic-house` jade hoặc khách sạn coral) |
| station | paper-dim | `tg-*` 40 px navy |
| chance | gold | Bác Tỷ pose `idle` 64 px |
| chest | sky | Cô Ngân pose `idle` 64 px |
| tax | paper-dim pha coral 10% | Cô Ngân pose `point` 64 px |
| go | paper-dim | Bé Lộc `happy` |
| jail | paper-dim | Anh Tèo `idle` |
| festival | gold-soft | Mèo Đậu `happy` (fallback `tg-festival` 40 px gold-deep) |
| travel | sky-soft | `tg-travel` 40 px sky-deep |

## 6. Màu nhà/khách sạn và chấm chủ trên nền

| Phần tử | Trên paper | Trên dải màu | Ghi chú |
|---|---|---|---|
| `tg-house` | jade `#1F8A5B` | không đặt | 6 × 6, gap 1 |
| `tg-hotel` | coral `#E4573D` | không đặt | 14 × 8 |
| `.ty-owner-dot` | seat-n, viền paper 1 px | không đặt | 8 px; ở ô cạnh trái/phải vẫn góc ngoài-phải theo hướng nhìn người dùng |
| quân | webp + ring 22 px paper viền navy 1.5 + ring seat-n 2 | — | |

Nhà và chấm chủ cố ý tránh dải màu để không có tình huống jade trên green hay coral trên red.
