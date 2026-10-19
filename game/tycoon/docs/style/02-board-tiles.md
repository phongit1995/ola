# 02 — Bảng màu 40 ô bàn cờ

Mỗi ô là `<g class="ty-tile" data-idx data-kind data-group>`. Màu lấy từ token `01-foundations.md`; cột hex ghi lại để người vẽ concept không phải tra.

## 1. Anatomy chung

| Phần | Ô đất (`street`) | Ô bến/tiện ích | Ô thẻ/thuế | Ô góc |
|---|---|---|---|---|
| Kích thước (390) | 30.4 × 46 | 30.4 × 46 | 30.4 × 46 | 46 × 46 |
| Nền | paper `#FBF3E0` | paper-dim `#F0E4C8` | paper-dim | paper-dim (ô 10 chia chéo: nửa paper + nửa dim) |
| Dải màu | 7–9 px ở mép phía trong bàn, màu nhóm, viền navy 1 px cạnh giáp thân ô | không | không | không |
| Tên (trên) | tên ngắn 800, `board × 0.0182`, ≤ 2 dòng | như trái | như trái (`Cơ hội`, `Khí vận`, `Thuế`) | chữ góc 2 dòng (`BÃI / ĐỖ XE`, `VÀO / TÙ`, `NHÀ TÙ`, `XUẤT / PHÁT`) |
| Tranh / glyph (giữa) | tranh phong cảnh địa danh (concept UI v3); bàn < 456 có thể ẩn tranh | glyph 18 px | glyph 18 px | bust nhân vật 30 px (03-characters) — fallback glyph 26 px |
| Giá (dưới) | `220 tr` tabular; có chủ → tiền thuê hiện tại | `200 tr` / `150 tr` | thuế: số phải trả coral; thẻ: không có | Xuất phát: `+200 tr` jade |
| Nhà | hàng ngang trên dải, jade `#1F8A5B` | — | — | — |
| Có chủ | nền seat-soft + vạch 3 px màu ghế ở mép **ngoài** | như trái | — | — |
| Quân | ghim ~24 px, mũi chạm mép trong ô, thân trong vùng trong | như trái | như trái | ô 10: vùng theo trạng thái tù |
| Lưới | line `#8C7B5E` 1 px | | | |

Xoay: cạnh dưới 0°, cạnh trái 90°, cạnh trên 180°, cạnh phải 270° cho **khung + dải**. Tên, tranh/glyph, giá, nhà, quân **không xoay**: luôn đứng thẳng, đọc từ trên xuống (tên → tranh → giá) ở cả 4 cạnh.

## 2. Bảng 40 ô

Cột "Glyph màu" là `fill` của `tg-*`. Cột "Nhân vật" chỉ ô góc có bust; nhân vật của ô khác xuất hiện ở sheet/thẻ (03-characters §4).

| Idx | Tên (live text) | kind | Dải (hex) | Nền | Glyph | Glyph màu | Nhân vật trên ô |
|---|---|---|---|---|---|---|---|
| 0 | Xuất phát | go | — | dim | `tg-go` (fallback) | navy `#1F2A44` | Bé Lộc (bust) |
| 1 | Phố Hiến | street | brown `#8D5B3C` | paper | — | — | — |
| 2 | Khí vận | chest | — | dim | `tg-chest` | sky-deep `#3C9BBF` | — |
| 3 | Phố cổ Hội An | street | brown | paper | — | — | — |
| 4 | Thuế thu nhập | tax | — | dim | `tg-tax` | coral `#E4573D` | — |
| 5 | Ga Hà Nội | station | — | dim | `tg-train` | navy | — |
| 6 | Sa Pa | street | sky `#7EC8E3` | paper | — | — | — |
| 7 | Cơ hội | chance | — | dim | `tg-chance` | gold-deep `#B98700` | — |
| 8 | Mộc Châu | street | sky | paper | — | — | — |
| 9 | Ninh Bình | street | sky | paper | — | — | — |
| 10 | Nhà tù / Thăm tù | jail | — | paper ∕ dim | `tg-jail` (fallback) | navy | Anh Tèo (bust, vùng dim) |
| 11 | Cần Thơ | street | pink `#E58FB5` | paper | — | — | — |
| 12 | Nhà máy điện | utility | — | dim | `tg-electric` | jade `#1F8A5B` | — |
| 13 | Phú Quốc | street | pink | paper | — | — | — |
| 14 | Hạ Long | street | pink | paper | — | — | — |
| 15 | Sân bay Tân Sơn Nhất | station | — | dim | `tg-plane` | navy | — |
| 16 | Hải Phòng | street | orange `#F2994A` | paper | — | — | — |
| 17 | Khí vận | chest | — | dim | `tg-chest` | sky-deep | — |
| 18 | Huế | street | orange | paper | — | — | — |
| 19 | Nha Trang | street | orange | paper | — | — | — |
| 20 | Bãi đỗ xe | parking | — | dim | `tg-parking` (fallback) | navy | Mèo Đậu (bust) |
| 21 | Đà Lạt | street | red `#D64545` | paper | — | — | — |
| 22 | Cơ hội | chance | — | dim | `tg-chance` | gold-deep | — |
| 23 | Đà Nẵng | street | red | paper | — | — | — |
| 24 | Quy Nhơn | street | red | paper | — | — | — |
| 25 | Cảng Hải Phòng | station | — | dim | `tg-ship` | navy | — |
| 26 | Biên Hòa | street | yellow `#F2D04E` | paper | — | — | — |
| 27 | Thủ Dầu Một | street | yellow | paper | — | — | — |
| 28 | Nhà máy nước | utility | — | dim | `tg-water` | jade | — |
| 29 | Vũng Tàu | street | yellow | paper | — | — | — |
| 30 | Vào tù | gotojail | — | dim | `tg-gotojail` (fallback) | coral | Chú Cảnh (bust) |
| 31 | Đồng Khởi | street | green `#3BA776` | paper | — | — | — |
| 32 | Nguyễn Huệ | street | green | paper | — | — | — |
| 33 | Khí vận | chest | — | dim | `tg-chest` | sky-deep | — |
| 34 | Thủ Thiêm | street | green | paper | — | — | — |
| 35 | Bến xe Miền Đông | station | — | dim | `tg-bus` | navy | — |
| 36 | Cơ hội | chance | — | dim | `tg-chance` | gold-deep | — |
| 37 | Hồ Gươm | street | blue `#2F5FD0` | paper | — | — | — |
| 38 | Thuế xa xỉ | tax | — | dim | `tg-tax` | coral | — |
| 39 | Hồ Tây | street | blue | paper | — | — | — |

Ghi chú màu glyph: Cơ hội dùng `gold-deep` thay vì `gold` vì `gold #F2B807` trên `paper-dim` chỉ đạt ~1.9:1 — không đủ cho hình 18 px. Khí vận dùng `sky-deep` cùng lý do. Trên thẻ bài (nền dải gold/sky đậm hơn) glyph dùng navy.

## 3. Ô góc chi tiết (46 × 46)

| Ô | Bố cục | Trạng thái động |
|---|---|---|
| 0 Xuất phát | bust Bé Lộc 30 px lệch trái-trên; mũi tên `tg-go` 12 px navy góc dưới-phải chỉ hướng đi | khi ai qua: nền nháy `--ty-landing` 300 ms, Bé Lộc đổi pose `happy` 600 ms |
| 10 Nhà tù | chia chéo từ góc trên-trái → dưới-phải: tam giác trong (dim) = Nhà tù có 3 song `tg-jail` 10 px + bust Anh Tèo 22 px; tam giác ngoài (paper) = Thăm tù, quân thăm đứng đây | có người trong tù: Anh Tèo pose `sad`; quân trong tù đứng sau song (z thấp hơn song) |
| 20 Bãi đỗ xe | bust Mèo Đậu 30 px giữa, `tg-parking` 12 px navy góc | quân đáp: Mèo pose `happy` (vẫy đuôi) 600 ms |
| 30 Vào tù | bust Chú Cảnh 30 px, nền dim pha coral 10% (`color-mix(in srgb, var(--ty-paper-dim), var(--ty-coral) 10%)`), `tg-gotojail` 12 px coral góc | quân đáp: Chú Cảnh pose `point`, còi nháy coral 2 lần |

Fallback khi tắt nhân vật (`data-chars="off"` cho máy yếu hoặc asset lỗi): glyph 26 px màu theo bảng §2 thay bust.

## 4. Chip nhóm (trong sheet S7/S8)

`.ty-chip-group[data-group=red]`: ô vuông 12 × 12 màu nhóm, viền navy 1 px, radius 2, + tên nhóm navy 12.5/500. Tên nhóm:

| data-group | Tên hiển thị |
|---|---|
| brown | Phố cổ |
| sky | Cao nguyên |
| pink | Biển đảo Nam |
| orange | Duyên hải |
| red | Miền Trung |
| yellow | Đông Nam Bộ |
| green | Sài Gòn |
| blue | Hà Nội |
| station | Bến |
| utility | Tiện ích |

## 5. Header sheet S7 theo loại ô

| kind | Dải header 44 px | Icon/nhân vật trong header (64 px, bên phải) |
|---|---|---|
| street | màu nhóm, không chữ; tên ô + chip nhóm ở dưới trên paper | — (hiện 0–4 `ic-house` / khách sạn, màu jade/coral) |
| station | paper-dim | `tg-*` 40 px navy |
| utility | paper-dim | `tg-*` 40 px jade |
| chance | gold | Bác Tỷ pose `idle` 64 px |
| chest | sky | Cô Ngân pose `idle` 64 px |
| tax | paper-dim pha coral 10% | Cô Ngân pose `point` 64 px |
| go | paper-dim | Bé Lộc `happy` |
| jail | paper-dim | Anh Tèo `idle` |
| parking | paper-dim | Mèo Đậu `idle` |
| gotojail | paper-dim pha coral 10% | Chú Cảnh `point` |

## 6. Màu nhà/khách sạn và chấm chủ trên nền

| Phần tử | Trên paper | Trên dải màu | Ghi chú |
|---|---|---|---|
| `tg-house` | jade `#1F8A5B` | không đặt | 6 × 6, gap 1 |
| `tg-hotel` | coral `#E4573D` | không đặt | 14 × 8 |
| `.ty-owner-dot` | seat-n, viền paper 1 px | không đặt | 8 px; ở ô cạnh trái/phải vẫn góc ngoài-phải theo hướng nhìn người dùng |
| quân | webp + ring 22 px paper viền navy 1.5 + ring seat-n 2 | — | |

Nhà và chấm chủ cố ý tránh dải màu để không có tình huống jade trên green hay coral trên red.
