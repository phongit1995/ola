# 09 — Kinh tế bàn 32 ô: giá thành phố, 3 cấp nhà, dòng tiền

Chốt ngày 19/10/2026. Dữ liệu nằm ở `logic/board.json`, `logic/cards.json`, `logic/constants.ts`. Luật chi tiết ở [05 §1, §4.4](./05-gameplay-rules-and-protocol.md).

## 1. Quyết định

| Hạng mục | Giá trị |
|---|---|
| Số ô | **32** (lưới 9 × 9: 4 góc + 7 ô mỗi cạnh) |
| Chiều đi | Xuất phát ở **góc dưới-trái**, đi **thuận kim đồng hồ**: lên cột trái → hàng trên → xuống cột phải → hàng dưới |
| Góc | 0 Xuất phát (dưới-trái) · 8 Nhà tù (trên-trái) · 16 Bãi đỗ xe (trên-phải) · 24 Vào tù (dưới-phải) |
| Ô đất | 16 thành phố Việt Nam, 8 nhóm × 2 thành phố |
| Ô khác | 4 bến · 2 tiện ích · 3 Cơ hội · 3 Khí vận · không có ô thuế |
| Cấp nhà | 3 cấp: Cấp 1 Nhà → Cấp 2 Biệt thự → Cấp 3 Khách sạn |
| Vốn đầu | 1.500 tr |
| Qua Xuất phát | **+160 tr** (200 × 32/40 vì bàn ngắn hơn, qua Xuất phát thường hơn) |
| Giới hạn ván | 20 vòng (giữ nguyên) |

Ô cạnh tại màn 390 rộng 38 px (bàn 40 ô chỉ 29,6 px), đủ chỗ cho tên thành phố, tranh nhỏ và giá.

## 2. Vì sao bỏ bàn 40 ô

Mô phỏng 2.000 ván bot/cấu hình, 4 người, 20 vòng:

| Cấu hình | Ván có người gom đủ nhóm | Cấp nhà cả bàn cuối ván | Thuê trung bình/lần | Ván có người phá sản | Hạng 1 hơn hạng 2 |
|---|---|---|---|---|---|
| 40 ô cũ (nhóm 3 ô, 4 nhà + KS) | 36% | 2,7 | 27 tr | 5,5% | 10% |
| 32 ô nhưng nhóm vẫn 3 ô | 39% | 4,1 | 26 tr | 6% | 9% |
| **32 ô, nhóm 2 ô, 3 cấp (bản chốt)** | **77%** | **9,7** | **62 tr** | **40%** | **29%** |

Nguyên nhân gốc: v1 không có trao đổi đất và đấu giá, nên nhóm 3 ô gần như không ai gom đủ → không ai xây → tiền thuê bằng tiền lẻ, thắng thua do may mắn mua trúng đất đắt. Bỏ giới hạn vòng thì hơn nửa số ván 40 ô 4 người không kết thúc sau 200 vòng. Rút xuống nhóm 2 ô mới là thứ làm game có tương tác; giảm số ô chủ yếu để ô to hơn và bàn gọn hơn.

## 3. Bảng giá 16 thành phố

Giá tăng dần theo chiều đi. Thuê đất trống ×2 khi sở hữu trọn nhóm.

| Ô | Nhóm (màu) | Thành phố | Giá | Giá mỗi cấp | Đất trống | Cấp 1 · Nhà | Cấp 2 · Biệt thự | Cấp 3 · Khách sạn | Vốn tới cấp 3 |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Bắc Trung Bộ (nâu) | Thanh Hóa | 60 | 50 | 6 | 40 | 145 | 320 | 210 |
| 3 | Bắc Trung Bộ (nâu) | Vinh | 80 | 50 | 8 | 45 | 160 | 340 | 230 |
| 5 | Tây Nguyên (xanh trời) | Buôn Ma Thuột | 100 | 50 | 10 | 50 | 180 | 380 | 250 |
| 7 | Tây Nguyên (xanh trời) | Đà Lạt | 120 | 50 | 12 | 60 | 200 | 400 | 270 |
| 9 | Miền Tây (hồng) | Cần Thơ | 140 | 100 | 14 | 85 | 310 | 660 | 440 |
| 11 | Miền Tây (hồng) | Phú Quốc | 160 | 100 | 16 | 90 | 320 | 690 | 460 |
| 13 | Nam Trung Bộ (cam) | Quy Nhơn | 180 | 100 | 18 | 100 | 340 | 720 | 480 |
| 15 | Nam Trung Bộ (cam) | Nha Trang | 200 | 100 | 20 | 105 | 360 | 750 | 500 |
| 17 | Di sản miền Trung (đỏ) | Hội An | 220 | 150 | 22 | 130 | 470 | 1.000 | 670 |
| 19 | Di sản miền Trung (đỏ) | Huế | 240 | 150 | 24 | 135 | 490 | 1.040 | 690 |
| 21 | Duyên hải Bắc Bộ (vàng) | Hạ Long | 260 | 150 | 26 | 145 | 500 | 1.060 | 710 |
| 23 | Duyên hải Bắc Bộ (vàng) | Hải Phòng | 280 | 150 | 28 | 150 | 520 | 1.100 | 730 |
| 25 | Thành phố biển (xanh lá) | Vũng Tàu | 300 | 200 | 30 | 175 | 630 | 1.350 | 900 |
| 27 | Thành phố biển (xanh lá) | Đà Nẵng | 320 | 200 | 32 | 180 | 650 | 1.380 | 920 |
| 30 | Đô thị đặc biệt (xanh đậm) | Hà Nội | 350 | 200 | 35 | 190 | 680 | 1.420 | 950 |
| 31 | Đô thị đặc biệt (xanh đậm) | TP. Hồ Chí Minh | 400 | 200 | 40 | 210 | 720 | 1.500 | 1.000 |

Tổng giá 16 thành phố 3.410 tr; cả bàn (thêm 4 bến × 200, 2 tiện ích × 150) 4.510 tr — gấp 3 vốn một người.

Ô còn lại (không đổi cách tính): bến 4, 12, 20, 28 (Ga Hà Nội, Sân bay Tân Sơn Nhất, Cảng Hải Phòng, Bến xe Miền Đông) giá 200, thuê 25 / 50 / 100 / 200 theo số bến sở hữu; tiện ích 10, 22 (Nhà máy điện, Nhà máy nước) giá 150, thuê 4× hoặc 10× tổng xúc xắc.

## 4. Công thức

Giá trị trong bảng §3 sinh từ công thức, sau đó làm tròn (dưới 200 → bội 5, từ 200 → bội 10):

- **Giá đất**: 2 thành phố mỗi nhóm, bước 20 tr (nhóm cuối 350/400).
- **Giá mỗi cấp** theo cạnh bàn: cột trái 50 · hàng trên 100 · cột phải 150 · hàng dưới 200.
- **Đất trống** = 10% giá.
- **Cấp n** = kₙ × (giá đất + n × giá mỗi cấp), với k₁ = 0,35 · k₂ = 0,90 · k₃ = 1,50.

Vì tính trên tổng vốn đã bỏ ra, mọi nhóm có cùng "tỷ suất": một lần khách đáp vào ô Khách sạn trả khoảng 1,5 lần số vốn chủ đã đổ vào ô đó; ô Nhà trả ~35%, Biệt thự ~90%. Nhóm đắt chỉ khác ở số tuyệt đối — thuê lớn hơn nhưng cũng tốn nhiều vốn hơn và khó gom đủ hơn vì nằm cuối bàn.

Hạ cấp hoàn 50% giá mỗi cấp. Thẻ sửa nhà tính theo **tổng số cấp** người rút đang có: ch10 25 tr/cấp, cm12 40 tr/cấp.

Hiển thị cấp trên ô: cấp 1 = 1 nhà xanh ngọc, cấp 2 = 2 nhà, cấp 3 = 1 khách sạn san hô (`MAX_HOUSES = 3`).

## 5. Kết quả mô phỏng (3.000 ván bot mỗi cấu hình, 20 vòng)

| | 2 người | 3 người | 4 người |
|---|---|---|---|
| Thời gian · 1 người + máy | 5,4 phút | 7,1 phút | 8,7 phút |
| Thời gian · online, chơi nhanh | 7,2 phút | 10,4 phút | 13,4 phút |
| Thời gian · online, chơi chậm (×1,8) | 10,5 phút | 15,1 phút | 19,2 phút |
| Ván có người gom đủ nhóm | 90% | 84% | 77% |
| Ván có người phá sản | 24% | 39% | 40% |
| Ván kết thúc sớm (còn 1 người) | 24% | 14% | 10% |
| Người phá sản đầu tiên (trung vị) | vòng 15 | vòng 15 | vòng 15 |
| Cấp nhà cả bàn cuối ván | 5,4 | 8,1 | 9,7 |
| Thuê trung bình / lần | 58 tr | 62 tr | 62 tr |
| Lần thuê lớn nhất (trung vị) | 100 tr | 340 tr | 400 tr |
| Tiền mặt / người · vòng 5 → 10 → 20 | 876 → 554 → 405 | 942 → 720 → 704 | 1.005 → 881 → 1.032 |
| Đất đã có chủ · vòng 5 → 10 → 20 | 33 → 53 → 73% | 46 → 69 → 88% | 56 → 80 → 95% |
| Tài sản hạng 1 / hạng 2 / hạng cuối | 2.570 / 1.947 | 3.002 / 2.162 / 1.592 | 3.450 / 2.295 / 1.365 |
| Hạng 1 hơn hạng 2 | 21% | 26% | 29% |

Dòng tiền mỗi ván 4 người (trung bình): vốn 6.000 · lương Xuất phát +2.786 · mua đất −4.251 · nâng cấp −1.265 · thẻ phạt −334 · tiền thuê chuyển giữa người chơi 1.853.

Nếu đổi `MAX_ROUNDS` xuống 15: online nhanh 5,6 / 8,1 / 10,4 phút (2 / 3 / 4 người), nhưng chỉ 13–25% số ván có người phá sản và hạng 1 hơn hạng 2 ~15–17% — ván kết thúc trước khi khách sạn kịp phát huy. Không giới hạn vòng: trung vị 30 / 36 / 41 vòng thì còn một người (74–98% số ván tự kết thúc), nên 20 vòng là điểm cắt hợp lý.

Giả định thời gian: bấm gieo 1,5 s, quyết định mua 4 s, bỏ qua 3,5 s, xác nhận thẻ 2,5 s, mỗi lần nâng cấp 2,5 s, kết thúc lượt 1,5 s, mạng 0,15 s/nước, animation lấy đúng `STEP_MS` trong `store/useTycoon.ts`, bot nghĩ 0,65 s.

## 6. Các phương án đã thử

Cùng bàn 32 ô, 4 người, 20 vòng; chỉ đổi hệ số tiền thuê (k₁ / k₂ / k₃, đất trống):

| Bảng | Hệ số | Ván có phá sản | Kết thúc sớm | Thuê lớn nhất | Hạng 1 hơn hạng 2 |
|---|---|---|---|---|---|
| D | 0,20 / 0,50 / 0,85 · 8% | 19% | 1% | 290 | 19% |
| B | 0,25 / 0,60 / 1,00 · 8% | 26% | 3% | 350 | 21% |
| A | 0,30 / 0,75 / 1,25 · 8% | 34% | 8% | 420 | 26% |
| **C (chốt)** | **0,35 / 0,90 / 1,50 · 10%** | **41%** | **11%** | **470** | **30%** |

Đòn bẩy khi cần chỉnh:

- **k₃** (Khách sạn) quyết định độ "căng": tăng → nhiều phá sản, ván kết thúc sớm hơn.
- **Lương Xuất phát**: 200 làm tiền mặt cuối ván 4 người phình lên ~1.100; 160 giữ quanh mức đầu ván.
- **Số vòng**: chỉ đổi thời gian; dưới 15 vòng thì nâng cấp chưa kịp có tác dụng.

## 7. Kiểm tra tự động

`logic/economy.test.ts` chạy 300 ván bot với seed cố định cho 2 và 4 người, kiểm:

| | 2 người | 4 người |
|---|---|---|
| Ván gom được nhóm | > 80% | > 65% |
| Ván có người phá sản | 12–40% | 28–55% |
| Ván kết thúc sớm | — | < 20% |
| Lần thuê lớn nhất (trung vị) | — | ≥ 200 tr |
| Hạng 1 hơn hạng 2 (trung vị) | — | > 15% |

Sửa giá trong `board.json` mà test đỏ nghĩa là cân bằng đã lệch khỏi bảng §5 — chạy lại mô phỏng trước khi nới dải.

## 8. Giới hạn

- Bot mua đất khi mua xong vẫn còn ≥ 120 tr và nâng cấp khi còn ≥ 240 tr; người thật có thể giữ tiền hoặc mạo hiểm hơn.
- v1 không có trao đổi đất, đấu giá, thế chấp — nếu thêm ở v2 phải mô phỏng lại (trao đổi làm gom nhóm dễ hơn nhiều).
- Thời gian online là ước lượng theo giả định §5, chưa đo người thật.
