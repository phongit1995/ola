# Cờ Tỷ Phú — danh sách ô trên bàn

Ghi chú nhanh bàn hiện tại (20/10/2026). Nguồn dữ liệu: `logic/board.json`, `logic/cards.json`. Luật chi tiết: [05-gameplay-rules-and-protocol.md](./05-gameplay-rules-and-protocol.md); giá và cân bằng: [09-economy.md](./09-economy.md).

## 1. Tổng quan

Bàn có **32 ô**, mỗi cạnh 8 ô (tính cả 1 góc). Đi **thuận kim đồng hồ** từ góc dưới-trái (Xuất phát): cột trái đi lên → hàng trên sang phải → cột phải đi xuống → hàng dưới sang trái.

| Loại ô | `kind` | Số ô | Vị trí | Mua được | Mua lại được |
|---|---|---|---|---|---|
| Thành phố | `street` | 16 (8 nhóm × 2) | xem §2 | có | có, nếu chưa lên Khách sạn |
| Sân bay | `station` | 4 | 4, 12, 20, 28 (giữa mỗi cạnh) | có | không |
| Cơ hội | `chance` | 4 | 6, 18, 22, 29 | — | — |
| Khí vận | `chest` | 3 | 2, 14, 26 | — | — |
| Thuế | `tax` | 1 | 10 | — | — |
| Góc | `go` · `jail` · `festival` · `travel` | 4 | 0 Xuất phát · 8 Nhà tù · 16 Lễ hội · 24 Du lịch | — | — |

Tổng: 16 + 4 + 4 + 3 + 1 + 4 = 32.

Đổi ngày 20/10/2026 cho gần ZingPlay: Bãi đỗ xe → **Lễ hội**, Vào tù → **Du lịch**, Nhà máy điện → **Thuế**, Nhà máy nước → **Cơ hội**. Không còn ô tiện ích.

## 2. Toàn bộ 32 ô

Tiền thuê thành phố theo cấp: đất trống / Nhà / Biệt thự / Khách sạn (đơn vị tr). Đất trống mà chủ sở hữu trọn nhóm thì thuê ×2; ô đang có Lễ hội thì ×2 thêm.

| # | Cạnh | Ô | Loại | Nhóm | Giá | Thuê | Giá mỗi cấp |
|---|---|---|---|---|---|---|---|
| 0 | góc dưới-trái | Xuất phát | góc | — | — | đi qua hoặc đáp vào nhận 160 | — |
| 1 | cột trái ↑ | Thanh Hóa | thành phố | Bắc Trung Bộ (nâu) | 60 | 6 / 40 / 145 / 320 | 50 |
| 2 | cột trái ↑ | Khí vận | thẻ | — | — | rút thẻ Khí vận | — |
| 3 | cột trái ↑ | Vinh | thành phố | Bắc Trung Bộ (nâu) | 80 | 8 / 45 / 160 / 340 | 50 |
| 4 | cột trái ↑ | Sân bay Nội Bài | sân bay | Sân bay | 200 | theo số sân bay | — |
| 5 | cột trái ↑ | Buôn Ma Thuột | thành phố | Tây Nguyên (xanh trời) | 100 | 10 / 50 / 180 / 380 | 50 |
| 6 | cột trái ↑ | Cơ hội | thẻ | — | — | rút thẻ Cơ hội | — |
| 7 | cột trái ↑ | Đà Lạt | thành phố | Tây Nguyên (xanh trời) | 120 | 12 / 60 / 200 / 400 | 50 |
| 8 | góc trên-trái | Nhà tù | góc | — | — | đáp vào = thăm tù, không sao | — |
| 9 | hàng trên → | Cần Thơ | thành phố | Miền Tây (hồng) | 140 | 14 / 85 / 310 / 660 | 100 |
| 10 | hàng trên → | Thuế thu nhập | thuế | — | — | đóng 10% tổng tài sản | — |
| 11 | hàng trên → | Phú Quốc | thành phố | Miền Tây (hồng) | 160 | 16 / 90 / 320 / 690 | 100 |
| 12 | hàng trên → | Sân bay Tân Sơn Nhất | sân bay | Sân bay | 200 | theo số sân bay | — |
| 13 | hàng trên → | Quy Nhơn | thành phố | Nam Trung Bộ (cam) | 180 | 18 / 100 / 340 / 720 | 100 |
| 14 | hàng trên → | Khí vận | thẻ | — | — | rút thẻ Khí vận | — |
| 15 | hàng trên → | Nha Trang | thành phố | Nam Trung Bộ (cam) | 200 | 20 / 105 / 360 / 750 | 100 |
| 16 | góc trên-phải | Lễ hội | góc | — | — | chọn 1 thành phố của mình, thuê ô đó ×2 | — |
| 17 | cột phải ↓ | Hội An | thành phố | Di sản miền Trung (đỏ) | 220 | 22 / 130 / 470 / 1000 | 150 |
| 18 | cột phải ↓ | Cơ hội | thẻ | — | — | rút thẻ Cơ hội | — |
| 19 | cột phải ↓ | Huế | thành phố | Di sản miền Trung (đỏ) | 240 | 24 / 135 / 490 / 1040 | 150 |
| 20 | cột phải ↓ | Sân bay Cam Ranh | sân bay | Sân bay | 200 | theo số sân bay | — |
| 21 | cột phải ↓ | Hạ Long | thành phố | Duyên hải Bắc Bộ (vàng) | 260 | 26 / 145 / 500 / 1060 | 150 |
| 22 | cột phải ↓ | Cơ hội | thẻ | — | — | rút thẻ Cơ hội | — |
| 23 | cột phải ↓ | Hải Phòng | thành phố | Duyên hải Bắc Bộ (vàng) | 280 | 28 / 150 / 520 / 1100 | 150 |
| 24 | góc dưới-phải | Du lịch | góc | — | — | lượt sau bay tới ô bất kỳ | — |
| 25 | hàng dưới ← | Vũng Tàu | thành phố | Thành phố biển (xanh lá) | 300 | 30 / 175 / 630 / 1350 | 200 |
| 26 | hàng dưới ← | Khí vận | thẻ | — | — | rút thẻ Khí vận | — |
| 27 | hàng dưới ← | Đà Nẵng | thành phố | Thành phố biển (xanh lá) | 320 | 32 / 180 / 650 / 1380 | 200 |
| 28 | hàng dưới ← | Sân bay Long Thành | sân bay | Sân bay | 200 | theo số sân bay | — |
| 29 | hàng dưới ← | Cơ hội | thẻ | — | — | rút thẻ Cơ hội | — |
| 30 | hàng dưới ← | Hà Nội | thành phố | Đô thị đặc biệt (xanh dương) | 350 | 35 / 190 / 680 / 1420 | 200 |
| 31 | hàng dưới ← | TP. Hồ Chí Minh | thành phố | Đô thị đặc biệt (xanh dương) | 400 | 40 / 210 / 720 / 1500 | 200 |

## 2b. Giá phát sinh theo luật (thành phố)

Tính từ bảng §2, đơn vị tr. **Trọn nhóm** = đất trống khi chủ có cả 2 ô (×2). **Mua lại** = 2 × (giá đất + cấp × giá mỗi cấp), trả cho chủ cũ; ô Khách sạn không mua lại được. **Hạ cấp** hoàn nửa giá mỗi cấp. **Lễ hội** = thuê ×2 thêm: cột đầu là đất trống trọn nhóm (×4 thuê gốc), các cột sau theo cấp (cấp 1–3 chỉ có khi đã trọn nhóm).

| # | Thành phố | Trọn nhóm (đất trống) | Mua lại: đất trống / Nhà / Biệt thự | Hạ cấp hoàn / cấp | Có Lễ hội: trống trọn nhóm / Nhà / Biệt thự / Khách sạn |
|---|---|---|---|---|---|
| 1 | Thanh Hóa | 12 | 120 / 220 / 320 | 25 | 24 / 80 / 290 / 640 |
| 3 | Vinh | 16 | 160 / 260 / 360 | 25 | 32 / 90 / 320 / 680 |
| 5 | Buôn Ma Thuột | 20 | 200 / 300 / 400 | 25 | 40 / 100 / 360 / 760 |
| 7 | Đà Lạt | 24 | 240 / 340 / 440 | 25 | 48 / 120 / 400 / 800 |
| 9 | Cần Thơ | 28 | 280 / 480 / 680 | 50 | 56 / 170 / 620 / 1.320 |
| 11 | Phú Quốc | 32 | 320 / 520 / 720 | 50 | 64 / 180 / 640 / 1.380 |
| 13 | Quy Nhơn | 36 | 360 / 560 / 760 | 50 | 72 / 200 / 680 / 1.440 |
| 15 | Nha Trang | 40 | 400 / 600 / 800 | 50 | 80 / 210 / 720 / 1.500 |
| 17 | Hội An | 44 | 440 / 740 / 1.040 | 75 | 88 / 260 / 940 / 2.000 |
| 19 | Huế | 48 | 480 / 780 / 1.080 | 75 | 96 / 270 / 980 / 2.080 |
| 21 | Hạ Long | 52 | 520 / 820 / 1.120 | 75 | 104 / 290 / 1.000 / 2.120 |
| 23 | Hải Phòng | 56 | 560 / 860 / 1.160 | 75 | 112 / 300 / 1.040 / 2.200 |
| 25 | Vũng Tàu | 60 | 600 / 1.000 / 1.400 | 100 | 120 / 350 / 1.260 / 2.700 |
| 27 | Đà Nẵng | 64 | 640 / 1.040 / 1.440 | 100 | 128 / 360 / 1.300 / 2.760 |
| 30 | Hà Nội | 70 | 700 / 1.100 / 1.500 | 100 | 140 / 380 / 1.360 / 2.840 |
| 31 | TP. Hồ Chí Minh | 80 | 800 / 1.200 / 1.600 | 100 | 160 / 420 / 1.440 / 3.000 |

Sân bay: không mua lại, không chịu Lễ hội. Thẻ Cơ hội "Bay đến sân bay gần nhất" bắt trả ×2: 50 / 100 / 200 / 400 theo số sân bay chủ có.

## 2c. Các khoản tiền khác

| Khoản | Số tiền |
|---|---|
| Vốn đầu mỗi người | 1.500 |
| Đi qua / đáp Xuất phát | +160 |
| Thuế (ô 10) | 10% tổng tài sản (tiền mặt + giá đất + tiền nâng cấp), làm tròn |
| Nộp phạt ra tù | 50 |
| Thẻ Cơ hội | cổ tức +50 · xổ số +150 · phạt tốc độ −15 · bảo trì −25 / cấp nhà |
| Thẻ Khí vận | ngân hàng tính nhầm +200 · bảo hiểm +100 · thừa kế +100 · bán hàng +50 · hoàn thuế +20 · viện phí −100 · học phí −50 · sửa đường −40 / cấp nhà · sinh nhật: mỗi người mừng 10 |

## 3. Cách tính từng loại ô

- **Thành phố:** trọn nhóm (2 ô) mới được nâng cấp, tối đa 3 cấp Nhà → Biệt thự → Khách sạn, nâng đều giữa 2 ô; hạ cấp hoàn nửa giá. Trả thuê xong được mua lại với giá ×2 (giá đất + tiền nâng cấp), trừ ô đã lên Khách sạn.
- **Sân bay:** thuê theo số sân bay chủ đang có: 1 → 25, 2 → 50, 3 → 100, 4 → 200. Không nâng cấp, không mua lại. Đủ 4 sân bay là thắng ngay.
- **Lễ hội (16):** đáp vào mà có ít nhất 1 thành phố thì chọn một thành phố của mình để tổ chức Lễ hội: thuê ô đó ×2. Cả bàn chỉ có một Lễ hội — người sau tổ chức thì Lễ hội chuyển đi. Không chọn trong 30 giây thì hệ thống chọn ô có tiền thuê cao nhất.
- **Du lịch (24):** đáp vào là hết lượt; lượt sau được bay thẳng tới ô bất kỳ (chạm ô trên bàn → "Bay tới đây") thay vì gieo. Bay qua Xuất phát vẫn nhận 160. Có thể bỏ quyền bay và gieo bình thường; hết giờ cũng là gieo bình thường. Bị đưa vào tù trước lượt đó thì mất quyền bay.
- **Thuế (10):** đóng 10% tổng tài sản (tiền mặt + giá đất + tiền nâng cấp), làm tròn. Thiếu tiền thì hạ cấp nhà hoặc phá sản như nợ ngân hàng.
- **Cơ hội / Khí vận:** mỗi bộ 12 thẻ. Cơ hội thiên về di chuyển (về Xuất phát, tới TP. HCM / Huế / Cần Thơ, tới sân bay gần nhất trả thuê ×2, đi dự Lễ hội), Khí vận thiên về tiền. Cả hai có thẻ ra tù, vào tù, sửa nhà theo số cấp. Danh sách thẻ: §2 trong [05](./05-gameplay-rules-and-protocol.md).
- **Nhà tù (8):** đáp vào chỉ là thăm tù. Chỉ vào tù khi rút thẻ Vào tù hoặc gieo đôi 3 lần liên tiếp. Ra tù bằng gieo đôi, nộp 50 hoặc dùng thẻ ra tù; đến lượt thứ 3 bắt buộc nộp phạt.

## 4. Thắng ngay theo ô

| Điều kiện | Ô cần có |
|---|---|
| Trọn 3 nhóm màu | 6 thành phố của 3 nhóm bất kỳ |
| Trọn một cạnh bàn | 4 thành phố trên cùng cạnh: (1, 3, 5, 7) · (9, 11, 13, 15) · (17, 19, 21, 23) · (25, 27, 30, 31) |
| Cả 4 sân bay | 4, 12, 20, 28 |

Sân bay không tính vào "trọn một cạnh".
