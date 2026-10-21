# 06 — Icon system: 4 họ icon, số lượng, công thức hình học

## 1. Tổng quan và số lượng

Cờ Tỷ Phú có **4 họ icon** khác nhau về vai trò, grid và cách tô. Không trộn họ: icon điều khiển không bao giờ fill đặc, glyph ô bàn không bao giờ là stroke mảnh.

| Họ | Prefix | Grid | Kiểu | Số lượng v1 | Thư mục |
|---|---|---|---|---|---|
| A. Icon điều khiển | `ic-` | 24 | stroke 2, `currentColor` | **30** | `assets/icons/` |
| B. Glyph ô bàn cờ | `tg-` | 32 | fill phẳng 1 màu (+ 1 màu phụ tối đa) | **11** | `assets/tiles/` |
| C. Quân cờ | `tk-` | UI v3: `tk-pawn.svg` 16 × 24 tô màu ghế; v2: 8 raster 96 | con tốt fill màu ghế + vùng sáng, outline navy | **1** SVG (+ 8 raster cho v2 chọn quân) | `assets/tokens/` |
| D. Mặt xúc xắc | `d1`–`d6` | 44 | fill dot navy | **6** | `assets/dice/` |

Tổng **55 asset icon**, trong đó 47 là SVG code-native, 8 raster. Ngoài ra: 6 reaction tái dùng từ caro, VIP icon shared, `ic-ken` tái dùng từ xiangqi (cùng grid 24).

Họ A dùng lại 22 icon đã có (20 của xiangqi + `ic-user-minus`, `ic-plus` của thirteen, cùng spec) — chỉ copy file sang `tycoon/assets/icons/` để mỗi game tự chứa asset (quy ước repo hiện tại; nếu sau này gom icon shared thì các game chuyển cùng lúc). 8 icon mới là riêng cho tỷ phú.

## 2. Họ A — Icon điều khiển (30)

### 2.1 Spec chung (giống xiangqi `style/04-icon-system.md`)
- viewBox `0 0 24 24`, safe area 2–22, stroke 2, `round` cap/join, `fill="none"`, `stroke="currentColor"`, `aria-hidden="true" focusable="false"`.
- Render 16 / 20 / 24; không dưới 16. Toggle pair cùng bounding box.
- Tối đa 6 path, ~1.5 KB. Không gradient/filter/bitmap/`<text>`.
- Màu: trên navy → cream; trên paper → navy; trên gold → navy; danger → cream.
- Fill nhỏ ≤ 20% diện tích chỉ cho trạng thái active/notification.

### 2.2 Inventory

| # | File | Nguồn | Size | Nơi dùng | Accessible name |
|---|---|---|---|---|---|
| 1 | `ic-arrow-left` | xiangqi | 20/24 | header S3/S10/S11 | Quay lại |
| 2 | `ic-chevron-left` | xiangqi | 20 | phân trang | Trang trước |
| 3 | `ic-chevron-right` | xiangqi | 20 | phân trang | Trang sau |
| 4 | `ic-close` | xiangqi | 20 | sheet/modal/chat | Đóng |
| 5 | `ic-refresh` | xiangqi | 20 | S3 | Làm mới danh sách |
| 6 | `ic-volume-on` | xiangqi | 24 | lobby | Tắt âm |
| 7 | `ic-volume-off` | xiangqi | 24 | lobby | Bật âm |
| 8 | `ic-lock` | xiangqi | 16 | room row, S5 | Có mật khẩu |
| 9 | `ic-ken` | xiangqi | 24 | badge KEN lobby | — (số trong text) |
| 10 | `ic-chat` | xiangqi | 24 | footer S5/S6 | Mở trò chuyện |
| 11 | `ic-reaction` | xiangqi | 24 | footer S6 | Mở bảng cảm xúc |
| 12 | `ic-flag` | xiangqi | 24 | menu S6 | Bỏ cuộc |
| 13 | `ic-exit-door` | xiangqi | 24 | menu S6, S5 | Thoát bàn |
| 14 | `ic-send` | xiangqi | 20 | chat | Gửi |
| 15 | `ic-wifi-off` | xiangqi | 18/20 | O4, pod | Mất kết nối |
| 16 | `ic-warning` | xiangqi | 16/20 | lỗi, lý do disabled | — |
| 17 | `ic-check` | xiangqi | 16/20 | sẵn sàng, mua xong | — |
| 18 | `ic-owner` | xiangqi | 16 | ghế chủ bàn | Chủ bàn |
| 19 | `ic-history` | xiangqi | 20 | lobby fallback cho minh họa | Xem lịch sử |
| 20 | `ic-leaderboard` | xiangqi | 20 | lobby fallback cho minh họa | Xem bảng xếp hạng |
| 21 | `ic-user-minus` | thirteen | 20 | S5 mời ra | Mời ra khỏi bàn |
| 22 | `ic-plus` | thirteen | 20 | S4 ghế trống, S8 nâng cấp | Thêm / Nâng cấp |
| 23 | `ic-minus` | **mới** | 20 | S8 bán, O3 bán | Bán nhà |
| 24 | `ic-dice` | **mới** | 20/24 | CTA gieo, S2 Vào bàn fallback cho minh họa | lấy nhãn của nút: Gieo xúc xắc / Vào bàn |
| 25 | `ic-deed` | **mới** | 20/24 | footer S6 (mở S8), chip số đất trong pod (16) | Xem tài sản |
| 26 | `ic-house` | **mới** | 16/20 | chip nhà trong S8, log | — |
| 27 | `ic-key` | **mới** | 16 | pod: có thẻ ra tù | Có thẻ ra tù |
| 28 | `ic-jail-bars` | **mới** | 16/20 | pod: đang trong tù; nút Nộp phạt | Đang trong tù |
| 29 | `ic-coins` | **mới** | 16/20 | tổng tài sản S8/S9, nút Trả nợ | — |
| 30 | `ic-more` | **mới** | 24 | menu ⋯ topbar S6 | Thêm tùy chọn |

Không có `ic-rules` trong họ A. Lobby S2 đã chốt có sách `ill-rules.svg` bên cạnh chữ Luật chơi; đây là một trong **5 minh họa trang trí riêng S2** (`lobby/ill-{dice,history,leaderboard,rules,exit}`, PNG gốc cắt từ concept, khi code xuất WebP hoặc SVG), không nằm trong inventory 30 `ic-*`. Hình, màu, kích thước và fallback theo [S2 lobby §6](./style/screens/s2-lobby/README.md#6-nút-và-minh-họa). Chúng có contour navy + fill màu, `aria-hidden`; accessible name lấy từ nhãn action, không áp quy tắc icon stroke đơn sắc cho các minh họa này.

### 2.3 Công thức hình học 8 icon mới

Constraint để nhiều người vẽ cho cùng một họ; tọa độ trên grid 24.

#### `ic-minus`
- Một line từ `(6,12)` đến `(18,12)`. Cùng chiều dài với nét ngang của `ic-plus` (thirteen) để cặp +/− cân nhau.

#### `ic-dice`
- Rounded rect `(4,4)`–`(20,20)` radius 4, stroke 2.
- 3 dot fill (ngoại lệ fill nhỏ): `(8.5,8.5)`, `(12,12)`, `(15.5,15.5)` r 1.4 — mặt "3" chéo, đọc được ở 16.
- Không vẽ 2 viên; 1 viên là đủ nghĩa, giữ silhouette vuông.

#### `ic-deed`
- Thẻ đất: rounded rect `(5,3)`–`(19,21)` radius 2.
- Dải đầu: line `(5,8)`–`(19,8)` (ngụ ý dải màu nhóm).
- Hai line ngắn `(8,13)`–`(16,13)`, `(8,17)`–`(13,17)`.
- Phân biệt với `ic-chat` (có tail) và `ic-history` (có kim đồng hồ).

#### `ic-house`
- Nóc: polyline `(4,11)` → `(12,4)` → `(20,11)`.
- Thân: path `(6,10)` → `(6,20)` → `(18,20)` → `(18,10)` (hở phía trên, nối nóc bằng cap tròn).
- Không cửa/ống khói ở 16; ở 20/24 có thể thêm cửa rect `(10.5,15)`–`(13.5,20)`.
- Khác `tg-house` (fill): đây là bản outline cho UI, không đặt lên bàn cờ.

#### `ic-key`
- Đầu khóa: circle tâm `(8,9)` r 4.
- Thân: line `(11,12)` → `(20,21)`; răng: line `(17,18)` → `(19,16)`, `(15,16)` → `(17,14)`.
- Nghiêng 45° theo family (không nằm ngang).

#### `ic-jail-bars`
- Khung: rounded rect `(4,4)`–`(20,20)` radius 2.
- 3 song dọc: line x = 9, 12, 15 từ y 4 đến 20.
- Ở 16 px bỏ khung, giữ 3 song + 2 nét ngang `(5,7)`–`(19,7)`, `(5,17)`–`(19,17)`.

#### `ic-coins`
- 2 đồng xu chồng: ellipse tâm `(12,8)` rx 7 ry 3; hai arc nửa dưới ở y 12 và y 16 nối bởi line hai bên `(5,8)`–`(5,16)`, `(19,8)`–`(19,16)`.
- Khác `ic-ken` (1 đồng tròn có lỗ): coins là chồng xu, nghĩa "tổng tài sản/tiền ván", không phải KEN.

#### `ic-more`
- 3 dot fill r 1.6 tại `(5,12)`, `(12,12)`, `(19,12)` (ngoại lệ fill). Ngang, không dọc.

### 2.4 Wrapper

```tsx
type TyIconName =
  | 'arrow-left' | 'chevron-left' | 'chevron-right' | 'close' | 'refresh'
  | 'volume-on' | 'volume-off' | 'lock' | 'ken' | 'chat' | 'reaction'
  | 'flag' | 'exit-door' | 'send' | 'wifi-off' | 'warning' | 'check'
  | 'owner' | 'history' | 'leaderboard' | 'user-minus' | 'plus' | 'minus'
  | 'dice' | 'deed' | 'house' | 'key' | 'jail-bars' | 'coins' | 'more';

<TyIcon name="dice" size={24} aria-hidden="true" />
```

Union là nguồn duy nhất; không nhận tên icon từ server.

## 3. Họ B — Glyph ô bàn cờ (11)

### 3.1 Spec
- viewBox `0 0 32 32`, safe area 3–29. **Fill phẳng**, không stroke (ở 18 px stroke 2 trên grid 32 sẽ nhòe). Mỗi glyph 1 màu `currentColor`; tối đa 1 màu phụ bằng `fill-opacity` 0.45 cùng màu (ví dụ đất dưới nhà), không hex thứ hai.
- Render: 18 px ở ô cạnh, 26 px ở ô góc, 48 px ở mặt sau thẻ (O2), 20 px trong sheet S7 header.
- Silhouette phải nhận ra ở 18 px trên nền `--ty-paper`; test mù màu: glyph + vị trí ô là đủ, màu chỉ bổ trợ.
- Ngoại lệ 2 màu (theo ảnh mẫu): `tg-tax` (túi gold + `%` coral, viền navy), `tg-travel` (vali cam + máy bay sky-deep). Các glyph này không dùng `currentColor`.
- Không chữ/số trong glyph (kể cả "?" — dùng path vẽ tay dấu hỏi như một hình, không `<text>`).

### 3.2 Inventory

| # | File | Ô | Màu (01 §2.2) | Mô tả hình |
|---|---|---|---|---|
| 1 | `tg-go` | 0 | jade | mũi tên thẳng chỉ lên, thân to đầu nhọn (ô Xuất phát) |
| 2 | `tg-chest` | 2, 14, 28 | chest-deep | gió: 3 nét cong xoắn đầu (Khí vận) |
| 3 | `tg-tax` | 12 | gold + coral | túi tiền thắt miệng, mặt túi có dấu `%` (vẽ bằng path) |
| 4 | `tg-train` | — (không dùng) | navy | đầu tàu nhìn trước: hộp + 2 bánh + đèn tròn |
| 5 | `tg-plane` | chip/log sân bay (trên bàn dùng tranh pixel) | navy | máy bay nhìn trên, cánh thẳng |
| 6 | `tg-ship` | — (không dùng) | navy | thân tàu + 1 ống khói + 2 sóng |
| 7 | `tg-bus` | — (không dùng) | navy | xe buýt nhìn trước: hộp bo + 2 đèn + kính |
| 8 | `tg-chance` | 4, 18, 20, 29 | chance-deep | dấu hỏi đậm vẽ bằng path (không text) |
| 9 | `tg-festival` | 16 (fallback khi tắt tranh) | gold | ngôi sao 5 cánh đặc (Lễ hội); cũng dùng làm huy hiệu trên ô đang có Lễ hội |
| 10 | `tg-travel` | 24 | cam + sky-deep | vali cam (thân chữ nhật + quai chữ U) có máy bay nhỏ bay chéo phía trước |
| 11 | `tg-jail` | 8 (fallback khi tắt tranh), chip pod | navy | 3 song dọc + 2 thanh ngang (bản fill) |

4 sân bay trên bàn cùng dùng một tranh pixel máy bay + tháp chỉ huy để đọc là cùng nhóm — đủ 4 là thắng ngay; `tg-plane` dùng ở chip và log. `tg-train`, `tg-ship`, `tg-bus` hiện không dùng trên bàn.

### 3.3 Cấp nhà trên bàn (cấp 1–2 nhà, cấp 3 khách sạn) (thuộc họ B, không đếm vào 11)
- `tg-house` 6 × 6: tam giác nóc trên rect thân, fill jade. 
- `tg-hotel` 14 × 8: rect thân + nóc thấp, fill coral.
- Hai hình này inline trong BoardSurface (không file riêng), kích thước cố định theo ô.

## 4. Họ C — Quân cờ

**UI v3 (ảnh mẫu):** mọi người dùng chung `tk-pawn.svg` — con tốt board game (đầu tròn, cổ thắt, đế loe) 16 × 24, fill `--ty-seat-n`, outline navy 1.5, một vùng sáng ở đầu. Danh tính đọc bằng màu ghế khớp pod. 8 quân raster dưới đây để dành cho v2 (chọn quân trong S5).

- Raster webp 96 × 96 (hiển thị 18 px trong vòng 22 px — cần 96 để sắc ở 3×), nền trong suốt, fill phẳng 2–3 màu + outline navy 3 px (ở 96) để khớp hệ.
- Silhouette phải khác nhau ở 18 px và không phụ thuộc màu (đặt trong vòng màu ghế). Không chữ.
- v2: chọn quân trong S5; quân raster đặt trong vòng màu ghế.

| # | File | Hình | Gợi ý màu chính |
|---|---|---|---|
| 1 | `tk-xe-may` | xe máy nhìn ngang | coral |
| 2 | `tk-non-la` | nón lá nhìn nghiêng | gold |
| 3 | `tk-xich-lo` | xích lô nhìn ngang | sky |
| 4 | `tk-thuyen` | thuyền thúng/thuyền buồm nhỏ | jade |
| 5 | `tk-banh-mi` | ổ bánh mì | gold nhạt |
| 6 | `tk-ca-phe` | phin cà phê trên ly | navy + cream |
| 7 | `tk-den-long` | đèn lồng tròn | coral |
| 8 | `tk-trau` | đầu trâu nhìn trước | nâu |

Pipeline sinh ở 04 §3. Nếu sinh raster chưa đạt, fallback v1 là 4 SVG hình học (circle/triangle/square/diamond fill màu ghế) — vẫn chơi được, không chặn phát hành.

## 5. Họ D — Mặt xúc xắc (6)

- `d1`–`d6.svg` viewBox `0 0 44 44`, không nền (nền là DOM rounded rect), dot r 4 fill `currentColor` navy.
- Vị trí dot trên lưới 3 × 3 tâm `(11,11) (22,11) (33,11) / (11,22) (22,22) (33,22) / (11,33) (22,33) (33,33)` — chuẩn mặt xúc xắc.
- Dùng cả trong O1 và icon `ic-dice`? **Không** — `ic-dice` là stroke outline riêng (họ A).

## 6. App icon

`assets/app-icons/app-icon-01-city-dice.svg` + PNG 1024: bàn cờ góc Xuất phát (3 ô, 1 dải màu đỏ, 1 dải xanh lá) + 1 viên xúc xắc nghiêng mặt 5 + 1 quân nón lá; palette 01, fill phẳng, outline navy; cắt bo góc inset 16 / radius 208 theo convention thirteen; đọc được ở 48 px (xúc xắc là hình chủ đạo).

## 7. Quy trình tạo icon mới

Theo 8 bước của xiangqi `style/04-icon-system.md` §11 (semantic → metaphor → phác 16 px → chuẩn nét → export sạch → typed manifest → QA ma trận size × surface → screenshot thật). Bổ sung cho tỷ phú:

- Bước 1 ghi rõ icon thuộc **họ nào** (A/B/C/D); họ quyết định grid và fill/stroke, không chọn theo sở thích.
- Họ B phải test trên `--ty-paper` ở 18 px cạnh 3 ô láng giềng (có tranh pixel) trên bàn thật.
- Icon liên quan tiền phải phân biệt được với `ic-ken` ở 16 px (KEN thật ≠ tiền ván).

## 8. Checklist duyệt

- [ ] Đúng họ, đúng prefix, đúng grid.
- [ ] Họ A: stroke 2, currentColor, không fill trừ ngoại lệ ghi rõ (`dice`, `more`).
- [ ] Họ B: fill 1 màu + tối đa 1 `fill-opacity`, không stroke, không text.
- [ ] Rõ ở size nhỏ nhất của nơi dùng (16 cho A, 18 cho B).
- [ ] Không emoji, không ảnh chụp địa danh, không ký hiệu tiền tệ.
- [ ] Toggle pair / cặp +− cùng bounding box.
- [ ] Có accessible name trong bảng inventory.
- [ ] Đã chụp màn thật 390 × 844 và so với icon lân cận.
