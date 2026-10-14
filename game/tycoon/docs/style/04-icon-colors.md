# 04 — Ma trận màu icon

Icon điều khiển (`ic-*`) không có màu riêng: màu đến từ `color` của surface chứa nó (`currentColor`). Glyph ô (`tg-*`) có màu theo loại ô. Bảng này là nguồn khi review: "icon X ở chỗ Y màu gì".

## 1. Icon điều khiển theo surface

| Surface | `color` | Hex | Disabled |
|---|---|---|---|
| màn navy / topbar / footer | cream | `#FFF8EA` | cream 45% |
| action bar | cream | `#FFF8EA` | cream 45% |
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
| `ic-arrow-left` | header S3/S10/S11 (navy) | cream | — |
| `ic-chevron-left/right` | footer S3 trên paper nút | navy | disabled 45% ở trang đầu/cuối |
| `ic-close` | sheet/modal/chat (paper) | navy | — |
| `ic-refresh` | header S3 | cream | xoay 360° 600 ms khi đang tải |
| `ic-volume-on/off` | lobby icon-btn | cream | off: cream 70% để "tắt" nhìn nhạt hơn |
| `ic-lock` | room row (paper) | navy | S5 title: navy |
| `ic-ken` | badge KEN lobby (paper) | fill gold `#F2B807` + stroke navy | duy nhất icon có fill gold; trên CTA gold → one-color navy |
| `ic-chat` | footer S5/S6 | cream | có tin mới: chấm coral 6 px góc trên-phải |
| `ic-reaction` | footer S6 | cream | — |
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
| `ic-deed` | footer S6 | cream | pod chip (paper): navy |
| `ic-house` | S8 chip, log | jade | khách sạn: coral (cùng icon, đổi màu + số "KS") |
| `ic-key` | pod chip (nền gold-soft `#FBE9A6`) | navy | không fill gold — chip nền đã mang nghĩa "thẻ quý" |
| `ic-jail-bars` | pod chip | navy trên chip paper-deep | nút Nộp phạt: navy |
| `ic-coins` | S8/S9 tổng tài sản, nút Trả nợ (gold) | navy | S9 hạng 1: gold-deep trên paper |
| `ic-more` | topbar S6 | cream | — |

## 3. Glyph ô (`tg-*`)

| Glyph | Trên ô (paper-dim) | Trên thẻ O2 (dải gold/sky) | Trong sheet header | Trong chip/log 16 px |
|---|---|---|---|---|
| `tg-go` | navy | — | navy | navy |
| `tg-chest` | sky-deep `#3C9BBF` | navy (trên sky) | navy trên dải sky | sky-deep |
| `tg-chance` | gold-deep `#B98700` | navy (trên gold) | navy trên dải gold | gold-deep |
| `tg-tax` | coral `#E4573D` | — | coral | coral |
| `tg-train/plane/ship/bus` | navy | — | navy | navy |
| `tg-electric/water` | jade `#1F8A5B` | — | jade | jade |
| `tg-jail` | navy | — | navy | navy |
| `tg-parking` | navy | — | navy | navy |
| `tg-gotojail` | coral | — | coral | coral |
| `tg-house` | jade | — | jade | — |
| `tg-hotel` | coral | — | coral | — |

Quy tắc: gold và sky **không bao giờ** là màu glyph trên paper-dim (contrast không đủ) — luôn dùng biến thể `-deep`.

## 4. Xúc xắc

| Trạng thái | Nền ô | Dot | Viền |
|---|---|---|---|
| đang lăn | paper | navy | navy 2 |
| dừng, bình thường | paper | navy | navy 2 |
| dừng, đôi | gold-light `#FFD34D` | navy | gold-deep 2 + badge "Đôi!" |
| đôi lần 3 (vào tù) | paper pha coral 15% | coral | coral 2 |

## 5. Quân cờ và ring

| Trạng thái | Ring ngoài | Ring trong | Ảnh |
|---|---|---|---|
| bình thường | paper, viền navy 1.5 | seat-n 2 px | 100% |
| tới lượt | + glow gold | seat-n | 100% |
| trong tù | paper-deep | seat-n | 100%, đứng sau song |
| mất kết nối | paper | seat-n 50% | 60% |
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
