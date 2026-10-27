# 04 — Ma trận màu icon

Icon điều khiển (`ic-*`) không có màu riêng: màu đến từ `color` của surface chứa nó (`currentColor`). Glyph ô (`tg-*`) có màu theo loại ô. Bảng này là nguồn khi review: "icon X ở chỗ Y màu gì".

**Riêng menu S2 đã chốt:** dùng 5 minh họa `lobby/ill-*` (PNG gốc cắt từ concept, khi code xuất WebP/SVG) theo [S2 lobby §6](../screens/s2-lobby/README.md#6-nút-và-minh-họa): xúc xắc paper/navy, đồng hồ blue, bục gold/blue/coral, sách paper/navy, cửa coral. Đây là hình trang trí có fill màu, không phải `ic-*` đơn sắc; các dòng `ic-history/leaderboard/dice/exit-door` bên dưới chỉ làm fallback khi chưa có minh họa S2. Nút âm thanh và badge KEN vẫn dùng `ic-*`.

## 1. Icon điều khiển theo surface

| Surface | `color` | Hex | Disabled |
|---|---|---|---|
| topbar / footer trên nền trời (icon nằm trong nút paper) | navy | `#1F2A44` | navy 45% |
| surface navy (ô Lễ hội, toast danger) | cream | `#FFF8EA` | cream 45% |
| cụm lượt giữa bàn (trên paper) | navy | `#1F2A44` | navy 45% |
| paper (sheet, modal, pod, row) | navy | `#1F2A44` | navy 45% |
| CTA gold | navy | `#1F2A44` | navy 45% |
| jade (Sẵn sàng) | cream | | |
| danger | cream | | |
| chip gold / jade / coral | navy / cream / cream | | |
| toast lỗi (nền danger) | cream | | |
| toast thành công (nền jade) | cream | | |

## 2. Từng icon điều khiển — nơi dùng và màu thực tế

| Icon | Nơi | Màu | Ngoại lệ |
|---|---|---|---|
| `ic-arrow-left` | header S3/S10/S11 (nút paper trên nền trời) | navy | — |
| `ic-chevron-left/right` | footer S3 trên paper nút | navy | disabled 45% ở trang đầu/cuối |
| `ic-close` | sheet/modal/chat (paper) | navy | — |
| `ic-refresh` | header S3 | navy | xoay 360° 600 ms khi đang tải |
| `ic-volume-on/off` | lobby, header S6 icon-btn | navy | off: navy 70% để "tắt" nhìn nhạt hơn |
| `ic-lock` | room row (paper) | navy | S5 title: navy |
| `ic-ken` | badge KEN lobby (paper) | fill gold `#F2B807` + stroke navy | duy nhất icon có fill gold; trên CTA gold → one-color navy |
| `ic-chat` | footer S5/S6 | navy | có tin mới: chấm coral 6 px góc trên-phải |
| `ic-reaction` | footer S6 | navy | — |
| `ic-flag` | menu ⋯ (paper popover) | coral `#E4573D` | hành động nguy hiểm, cùng màu chữ "Bỏ cuộc" |
| `ic-exit-door` | menu ⋯, S5 | navy | — |
| `ic-send` | chat composer, nút gold | navy | — |
| `ic-wifi-off` | O4 banner (nền danger) | cream | pod: coral trên paper |
| `ic-warning` | lý do disabled (paper) | coral | toast danger: cream |
| `ic-check` | chip Sẵn sàng (jade) | cream | row "đã mua": jade trên paper |
| `ic-owner` | ghế chủ bàn | gold `#F2B807` fill nhỏ + stroke navy | giống `ic-ken` là 2 icon duy nhất có gold fill |
| `ic-history` / `ic-leaderboard` | lobby nút paper | navy | — |
| `ic-user-minus` | S5 ghế khách (paper) | coral | — |
| `ic-plus` | S8 nút xây (paper 36 px) | jade | disabled navy 45% |
| `ic-minus` | S8/O3 nút bán | coral | disabled navy 45% |
| `ic-dice` | CTA gieo (gold) | navy | S2 nút Vào bàn: navy |
| `ic-deed` | footer S6 | navy | pod chip (paper): navy |
| `ic-house` | S8 chip, log | jade | cấp 3 khách sạn: coral (cùng icon, đổi màu + số "KS") |
| `ic-key` | pod chip (nền gold-soft `#FBE9A6`) | navy | không fill gold — chip nền đã mang nghĩa "thẻ quý" |
| `ic-jail-bars` | pod chip | navy trên chip paper-deep | nút Nộp phạt: navy |
| `ic-coins` | S8/S9 tổng tài sản, nút Trả nợ (gold) | navy | S9 hạng 1: gold-deep trên paper |
| `ic-more` | topbar S6 | navy | — |

## 3. Glyph ô (`tg-*`)

| Glyph | Trên ô (paper-dim) | Trên thẻ O2 (dải gold/sky) | Trong sheet header | Trong chip/log 16 px |
|---|---|---|---|---|
| `tg-go` | jade `#1F8A5B` | — | jade | jade |
| `tg-chest` | chest-deep `#0D95EE` | chest-deep (trên chest) | chest-deep trên dải chest | chest-deep |
| `tg-chance` | chance-deep `#E0560E` | cream viền navy (trên chance) | cream viền navy trên dải chance | chance-deep |
| `tg-tax` | túi gold `#F2B807` + `%` coral | — | như trên | như trên |
| `tg-train/plane/ship/bus` | navy (sân bay trên bàn dùng tranh pixel; `tg-plane` chỉ dùng ở chip/log) | — | navy | navy |
| `tg-festival` | gold trên festival-bg (fallback khi tắt tranh) | cream (huy hiệu trên ô) | gold-deep | gold-deep |
| `tg-travel` | vali cam `#F2994A` + máy bay sky-deep | — | như trên | như trên |
| `tg-jail` | navy | — | navy | navy |
| `tg-house` | jade | — | jade | — |
| `tg-hotel` | coral | — | coral | — |

Quy tắc: `chance`, `chest`, gold, sky bản sáng **không** làm màu glyph đơn trên paper (contrast không đủ) — dùng biến thể `-deep`, hoặc kèm viền navy như túi tiền Thuế.

## 4. Xúc xắc

| Trạng thái | Nền ô | Dot | Viền |
|---|---|---|---|
| đang lăn | trắng nổi khối | navy | navy 2 |
| dừng, bình thường | trắng nổi khối, nghiêng ±8° | navy | navy 2 |
| dừng, đôi | gold-light `#FFD34D` | navy | gold-deep 2 + badge "Đôi!" |
| đôi lần 3 (vào tù) | paper pha coral 15% | coral | coral 2 |

## 5. Quân cờ (con tốt)

| Trạng thái | Thân | Viền | Hiệu ứng |
|---|---|---|---|
| bình thường | seat-n, vùng sáng ở đầu | navy 1.5 | — |
| tới lượt | seat-n | navy 1.5 | + glow gold |
| trong tù | seat-n | navy 1.5 | đứng sau song trong tranh Nhà tù |
| mất kết nối | seat-n 50% | navy 1.5 | opacity 60% |
| phá sản | — | — | unmount |

## 6. Màu tiền

| Ngữ cảnh | Màu |
|---|---|
| số tiền tĩnh (pod, sheet) | navy |
| vừa tăng (500 ms) + float `+x tr` | jade |
| vừa giảm + float `−x tr` | coral |
| không đủ tiền (giá trong nút Mua/Xây) | coral + `ic-warning` |
| tổng tài sản hạng 1 (S9) | gold-deep |
| KEN thật (lobby) | navy + `ic-ken` gold — không bao giờ jade/coral |
