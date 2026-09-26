# 02. EXP, level và mở khóa

> Nguồn: [economy.json](../../assets/farm/bundles/farm-town/economy.json) (`experience`, `requiredLevel`), [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json) (`gates`), [Progression.ts](../../assets/farm/scripts/core/Progression.ts), [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts). Đối chiếu ngày 26/09/2026.

## Nguồn EXP

EXP của trồng trọt, chăn nuôi và nhà máy được cộng khi **nhận kết quả**, không cộng khi bắt đầu việc. Xây dựng thì cộng một lần ngay lúc trả tiền, giống Hay Day và Township.

| Hành động | EXP | Cộng lúc | Cấu hình |
| --- | --- | --- | --- |
| Gieo hạt | 0 | lúc gieo | `experience.plantingXP` |
| Thu hoạch cây | 2–26 tùy cây (xem [03](03-cay-trong.md)) | lúc thu hoạch | `crops.<cây>.harvestXP` |
| Cho vật nuôi ăn | 0 | — | — |
| Thu sản phẩm vật nuôi | gà 3, bò 6, heo 12, cừu 20 mỗi con mỗi lượt (xem [05](05-vat-nuoi-va-chuong.md)) | lúc thu | `animals.<loài>.xp` |
| Xếp món vào máy | 0 | — | — |
| Nhận thành phẩm từ máy | 2–42 tùy công thức (xem [07](07-cong-thuc.md)) | lúc nhận từ khay | `recipes.<id>.xp` |
| Bán hàng trong kho | 1 cho mỗi 100 xu doanh thu | lúc bán | `experience.saleCoinsPerXP` |
| Xây nhà máy | 20 mỗi nhà | lúc xây | `experience.buildXP.machine` |
| Xây chuồng (kèm con đầu tiên) | 15 mỗi chuồng | lúc xây | `experience.buildXP.pen` |
| Mở ô chuồng (kèm một con) | 5 mỗi ô | lúc mở | `experience.buildXP.penSlot` |
| Mở ô hàng chờ nhà máy | 3 mỗi ô | lúc mở | `experience.buildXP.queueSlot` |
| Mua ruộng | 10 mỗi ruộng | lúc mua | `experience.buildXP.field` |
| Mua lại con đã bán | 0 | — | — |
| Làm xong ngay, đổi xu, hủy cây, hủy món | 0 | — | — |
| Lúa cứu trợ | 0 khi gieo và 0 khi thu hoạch | — | — |

- **EXP bán hàng tính trên doanh thu cộng dồn:** EXP nhận = phần nguyên của (tổng doanh thu sau khi bán / 100) − phần nguyên của (tổng doanh thu trước khi bán / 100). Chia nhỏ lần bán không được thêm EXP. Tiền đổi từ kim cương, tiền hoàn và tiền bán con không tính vào doanh thu.
- **EXP xây dựng cả trang trại:** 16 nhà máy × 20 + 8 chuồng × 15 + 32 ô chuồng × 5 + 64 ô hàng chờ × 3 + 34 ruộng × 10 = **1.132 EXP**. Con số này đáng kể ở vài level đầu (lên level 5 cần 132 EXP) nhưng không đáng kể về sau (lên level 68 cần 5.096.737 EXP), đúng như Hay Day: xây dựng giúp người mới lên level nhanh, còn người chơi lâu lên level chủ yếu nhờ sản xuất và bán. Chỉ tính công trình mới; bán con rồi mua lại không có EXP nên không thể nuôi EXP bằng cách mua bán vòng.
- **Nếu thiếu cấu hình** (chỉ xảy ra với bản lưu/profile cũ không có economy.json) code dùng giá trị dự phòng khác: gieo hạt 2 EXP, bán 1 EXP mỗi 10 xu, thu hoạch 3 × sản lượng, công thức 10 EXP, vật nuôi 3 × số sản phẩm mỗi lượt, không thưởng lên level. Bản hiện tại luôn có đủ cấu hình nên các giá trị này không dùng.

## Thưởng khi lên level

- Mỗi level mới được **+2 kim cương** (`experience.levelUpDiamonds`). Tới level 68 là 134 kim cương, tới level 99 là 196.
- Mỗi level chỉ thưởng một lần: bản lưu nhớ level cao nhất đã thưởng (`rewardedLevel`). Bản lưu có từ trước đợt 25/09/2026 không được trả bù cho các level đã qua; nếu sau này đổi đường level làm level tụt xuống thì lên lại các level đó không được thưởng lần nữa.
- Thông báo sau thao tác cho EXP có thêm "Lên level X · +2 kim cương"; một thao tác vượt nhiều level thì cộng đủ cho từng level.
- Đặt `levelUpDiamonds` bằng 0 để tắt thưởng.

## Công thức level

```text
EXP để lên từ level L sang L + 1 = 15 + 12 × (L − 1) + 80 × max(0, L − 10)²
Level tối đa: 99
```

Đến level 10 mỗi level chỉ cần thêm 12 EXP so với level trước; từ level 11 cộng thêm phần bình phương (80 × (L − 10)²) nên càng về sau càng dốc. Cấu hình ở `experience.curve` trong economy.json.

| Mốc | Tổng EXP cần để đạt |
| --- | ---: |
| Level 5 | 132 |
| Level 10 | 567 |
| Level 15 | 3.702 |
| Level 20 | 25.137 |
| Level 25 | 84.872 |
| Level 30 | 202.907 |
| Level 35 | 399.242 |
| Level 40 | 693.877 |
| Level 50 | 1.658.047 |
| Level 54 | 2.212.051 |
| Level 60 | 3.255.417 |
| Level 68 | 5.096.737 |
| Level 80 | 8.989.757 |
| Level 99 | 18.542.026 |

## Nhịp chơi ước tính

Đường level và giá đất được chọn để người chơi đều tay mua hết trang trại trong khoảng 3–4 năm. Số dưới đây lấy từ mô phỏng chạy đúng code game (`FarmGame`) với cấu hình hiện tại: người chơi giả tự trồng, cho ăn, chế biến, bán và mua dần, không dùng kim cương, không nghỉ ngày nào. Mỗi lần vào 10 phút, riêng lần đầu 30 phút. Người chơi giả chơi hợp lý nhưng không tối ưu: người chơi giỏi sẽ nhanh hơn, người hay bỏ ngày sẽ chậm hơn. Đây là kết quả mô phỏng ngày 25/09/2026, trước khi có EXP xây dựng (thêm ngày 26/09 làm level 10 sớm hơn 0,5–1 ngày, các mốc sau gần như không đổi; xem [12](12-diem-can-chot.md#đã-chốt-đợt-26092026)); công cụ mô phỏng chưa nằm trong repo, nên khi đổi đường level, giá đất, EXP hay thời gian thì các số này phải chạy lại mới đúng.

| Mốc | Nhà, chuồng, ruộng mới | Nhẹ: 3 lần/ngày (7h, 12h, 20h) | Đều: 6 lần/ngày (7h–22h) | Cày: mỗi giờ từ 7h đến 23h |
| --- | --- | ---: | ---: | ---: |
| Level cuối ngày đầu |  | L5 | L7 | L12 |
| Level 10 | Xưởng sữa 1, Chuồng bò 1, Ruộng 11 | 3,3 ngày | 1,7 ngày | 0,7 ngày |
| Level 15 | Bếp nướng 1, Chuồng heo 1 (cần mốc Chăn nuôi) | 8,8 ngày | 4,9 ngày | 2,5 ngày |
| Level 20 | Máy Chế Biến Đường 1, Ruộng 16 | 26 ngày | 17 ngày | 8,8 ngày |
| Level 25 | Lò Ngô 1 | 62 ngày | 41 ngày | 22 ngày |
| Level 30 | Bếp nướng 2, Tiệm Bánh Pie 1, Chuồng heo 2 (cần mốc Chăn nuôi), Ruộng 21 | 130 ngày | 81 ngày | 44 ngày |
| Level 35 | Bàn đan 1 (cần mốc Thủ công), Chuồng cừu 1 (cần mốc Thủ công) | 222 ngày | 138 ngày | 77 ngày |
| Level 54 | Bàn đan 2 (cần mốc Thủ công), Chuồng cừu 2 (cần mốc Thủ công), Ruộng 33 | 2,1 năm | 1,4 năm | 318 ngày |
| Level 68 | Ruộng 40 | 4 năm | 2,8 năm | 1,7 năm |
| **Mua hết** | 40 ruộng, 16 nhà máy, 8 chuồng, 40 con | **4,1 năm** | **2,9 năm** | **2 năm** |
| Xu còn lại lúc mua hết |  | 19.810 | 25.284 | 25.835 |

Người chơi nhẹ theo từng năm (khoảng khô = số ngày dài nhất không có level mới hay món mới để mua):

| Năm | Level mới trong năm | Khoảng khô dài nhất (ngày) |
| --- | ---: | ---: |
| Năm 1 | 40 | 24,5 |
| Năm 2 | 11 | 36 |
| Năm 3 | 9 | 45,8 |
| Năm 4 | 7 | 58,5 |

## Bảng đầy đủ 99 level

| Level | EXP để lên level tiếp | Tổng EXP cần để đạt level này |
| --- | ---: | ---: |
| 1 | 15 | 0 |
| 2 | 27 | 15 |
| 3 | 39 | 42 |
| 4 | 51 | 81 |
| 5 | 63 | 132 |
| 6 | 75 | 195 |
| 7 | 87 | 270 |
| 8 | 99 | 357 |
| 9 | 111 | 456 |
| 10 | 123 | 567 |
| 11 | 215 | 690 |
| 12 | 467 | 905 |
| 13 | 879 | 1.372 |
| 14 | 1.451 | 2.251 |
| 15 | 2.183 | 3.702 |
| 16 | 3.075 | 5.885 |
| 17 | 4.127 | 8.960 |
| 18 | 5.339 | 13.087 |
| 19 | 6.711 | 18.426 |
| 20 | 8.243 | 25.137 |
| 21 | 9.935 | 33.380 |
| 22 | 11.787 | 43.315 |
| 23 | 13.799 | 55.102 |
| 24 | 15.971 | 68.901 |
| 25 | 18.303 | 84.872 |
| 26 | 20.795 | 103.175 |
| 27 | 23.447 | 123.970 |
| 28 | 26.259 | 147.417 |
| 29 | 29.231 | 173.676 |
| 30 | 32.363 | 202.907 |
| 31 | 35.655 | 235.270 |
| 32 | 39.107 | 270.925 |
| 33 | 42.719 | 310.032 |
| 34 | 46.491 | 352.751 |
| 35 | 50.423 | 399.242 |
| 36 | 54.515 | 449.665 |
| 37 | 58.767 | 504.180 |
| 38 | 63.179 | 562.947 |
| 39 | 67.751 | 626.126 |
| 40 | 72.483 | 693.877 |
| 41 | 77.375 | 766.360 |
| 42 | 82.427 | 843.735 |
| 43 | 87.639 | 926.162 |
| 44 | 93.011 | 1.013.801 |
| 45 | 98.543 | 1.106.812 |
| 46 | 104.235 | 1.205.355 |
| 47 | 110.087 | 1.309.590 |
| 48 | 116.099 | 1.419.677 |
| 49 | 122.271 | 1.535.776 |
| 50 | 128.603 | 1.658.047 |
| 51 | 135.095 | 1.786.650 |
| 52 | 141.747 | 1.921.745 |
| 53 | 148.559 | 2.063.492 |
| 54 | 155.531 | 2.212.051 |
| 55 | 162.663 | 2.367.582 |
| 56 | 169.955 | 2.530.245 |
| 57 | 177.407 | 2.700.200 |
| 58 | 185.019 | 2.877.607 |
| 59 | 192.791 | 3.062.626 |
| 60 | 200.723 | 3.255.417 |
| 61 | 208.815 | 3.456.140 |
| 62 | 217.067 | 3.664.955 |
| 63 | 225.479 | 3.882.022 |
| 64 | 234.051 | 4.107.501 |
| 65 | 242.783 | 4.341.552 |
| 66 | 251.675 | 4.584.335 |
| 67 | 260.727 | 4.836.010 |
| 68 | 269.939 | 5.096.737 |
| 69 | 279.311 | 5.366.676 |
| 70 | 288.843 | 5.645.987 |
| 71 | 298.535 | 5.934.830 |
| 72 | 308.387 | 6.233.365 |
| 73 | 318.399 | 6.541.752 |
| 74 | 328.571 | 6.860.151 |
| 75 | 338.903 | 7.188.722 |
| 76 | 349.395 | 7.527.625 |
| 77 | 360.047 | 7.877.020 |
| 78 | 370.859 | 8.237.067 |
| 79 | 381.831 | 8.607.926 |
| 80 | 392.963 | 8.989.757 |
| 81 | 404.255 | 9.382.720 |
| 82 | 415.707 | 9.786.975 |
| 83 | 427.319 | 10.202.682 |
| 84 | 439.091 | 10.630.001 |
| 85 | 451.023 | 11.069.092 |
| 86 | 463.115 | 11.520.115 |
| 87 | 475.367 | 11.983.230 |
| 88 | 487.779 | 12.458.597 |
| 89 | 500.351 | 12.946.376 |
| 90 | 513.083 | 13.446.727 |
| 91 | 525.975 | 13.959.810 |
| 92 | 539.027 | 14.485.785 |
| 93 | 552.239 | 15.024.812 |
| 94 | 565.611 | 15.577.051 |
| 95 | 579.143 | 16.142.662 |
| 96 | 592.835 | 16.721.805 |
| 97 | 606.687 | 17.314.640 |
| 98 | 620.699 | 17.921.327 |
| 99 | — (level tối đa) | 18.542.026 |

## Lịch mở khóa theo level

Chỉ liệt kê những level có thứ mới. Level ghi ở đây là level **thực tế** người chơi dùng được: ô chuồng và ô hàng chờ không thể mở trước khi có chuồng/nhà tương ứng, nên lấy level lớn hơn giữa level của ô và level của chuồng/nhà.

| Level | Tổng EXP cần | Mở mới |
| ---: | ---: | --- |
| 1 | 0 | **Cây:** Lúa mì, Ngô · **Công thức:** Thức ăn gà · **Nhà máy:** Máy thức ăn 1 · **Chuồng:** Chuồng gà 1 |
| 2 | 15 | **Ruộng:** Ruộng 7 |
| 3 | 42 | **Ô chuồng:** Chuồng gà 1: ô 2 |
| 4 | 81 | **Cây:** Bắp cải · **Ruộng:** Ruộng 8 |
| 5 | 132 | **Công thức:** Bánh mì, Bánh mì ngô · **Nhà máy:** Lò bánh 1 · **Ô hàng chờ:** Máy thức ăn 1: ô 2, Lò bánh 1: ô 2, 3, 4, 5 |
| 6 | 195 | **Ruộng:** Ruộng 9 |
| 7 | 270 | **Cây:** Củ Cải Đường |
| 8 | 357 | **Ruộng:** Ruộng 10 |
| 9 | 456 | **Ô chuồng:** Chuồng gà 1: ô 3 |
| 10 | 567 | **Cây:** Khoai Tây · **Công thức:** Thức ăn bò, Bơ, Phô mai, Kem sữa · **Nhà máy:** Xưởng sữa 1 · **Chuồng:** Chuồng bò 1 · **Ô chuồng:** Chuồng bò 1: ô 2, 3, 4, 5 · **Ô hàng chờ:** Máy thức ăn 1: ô 3, Xưởng sữa 1: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 11 |
| 12 | 905 | **Nhà máy:** Máy thức ăn 2 · **Chuồng:** Chuồng gà 2 · **Ô chuồng:** Chuồng gà 2: ô 2, 3 · **Ô hàng chờ:** Máy thức ăn 2: ô 2, 3 · **Ruộng:** Ruộng 12 |
| 14 | 2.251 | **Cây:** Dâu tây · **Công thức:** Bánh dâu, Sữa Chua Dâu Tây · **Ruộng:** Ruộng 13 |
| 15 | 3.702 | **Công thức:** Cám heo (cần mốc Chăn nuôi), Khoai Tây Chiên, Bánh Mì Nướng, Burger (cần mốc Chăn nuôi) · **Nhà máy:** Bếp nướng 1 · **Chuồng:** Chuồng heo 1 (cần mốc Chăn nuôi) · **Ô chuồng:** Chuồng gà 1: ô 4, Chuồng gà 2: ô 4, Chuồng heo 1: ô 2, 3, 4, 5 · **Ô hàng chờ:** Máy thức ăn 1: ô 4, Máy thức ăn 2: ô 4, Bếp nướng 1: ô 2, 3, 4, 5 |
| 16 | 5.885 | **Ruộng:** Ruộng 14 |
| 18 | 13.087 | **Cây:** Bí Ngô · **Nhà máy:** Lò bánh 2 · **Ô hàng chờ:** Lò bánh 2: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 15 |
| 20 | 25.137 | **Công thức:** Bánh Quế (Waffle), Đường Trắng · **Nhà máy:** Máy Chế Biến Đường 1 · **Ô chuồng:** Chuồng gà 1: ô 5, Chuồng gà 2: ô 5 · **Ô hàng chờ:** Máy thức ăn 1: ô 5, Máy thức ăn 2: ô 5, Máy Chế Biến Đường 1: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 16 |
| 22 | 43.315 | **Ruộng:** Ruộng 17 |
| 24 | 68.901 | **Cây:** Nho · **Công thức:** Bánh nho · **Nhà máy:** Xưởng sữa 2 · **Chuồng:** Chuồng bò 2 · **Ô chuồng:** Chuồng bò 2: ô 2, 3, 4, 5 · **Ô hàng chờ:** Xưởng sữa 2: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 18 |
| 25 | 84.872 | **Công thức:** Bỏng Ngô, Ngũ Cốc Ngô · **Nhà máy:** Lò Ngô 1 · **Ô hàng chờ:** Lò Ngô 1: ô 2, 3, 4, 5 |
| 26 | 103.175 | **Ruộng:** Ruộng 19 |
| 28 | 147.417 | **Ruộng:** Ruộng 20 |
| 30 | 202.907 | **Công thức:** Bánh Bắp Cải, Pie khoai thịt (cần mốc Chăn nuôi), Bánh Bí Ngô · **Nhà máy:** Bếp nướng 2, Tiệm Bánh Pie 1 · **Chuồng:** Chuồng heo 2 (cần mốc Chăn nuôi) · **Ô chuồng:** Chuồng heo 2: ô 2, 3, 4, 5 · **Ô hàng chờ:** Bếp nướng 2: ô 2, 3, 4, 5, Tiệm Bánh Pie 1: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 21 |
| 32 | 270.925 | **Ruộng:** Ruộng 22 |
| 34 | 352.751 | **Ruộng:** Ruộng 23 |
| 35 | 399.242 | **Công thức:** Cám cừu (cần mốc Thủ công), Áo len (cần mốc Thủ công) · **Nhà máy:** Bàn đan 1 (cần mốc Thủ công) · **Chuồng:** Chuồng cừu 1 (cần mốc Thủ công) · **Ô chuồng:** Chuồng cừu 1: ô 2, 3, 4, 5 · **Ô hàng chờ:** Bàn đan 1: ô 2, 3, 4, 5 |
| 36 | 449.665 | **Nhà máy:** Máy Chế Biến Đường 2 · **Ô hàng chờ:** Máy Chế Biến Đường 2: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 24 |
| 38 | 562.947 | **Ruộng:** Ruộng 25 |
| 40 | 693.877 | **Ruộng:** Ruộng 26 |
| 42 | 843.735 | **Nhà máy:** Lò Ngô 2 · **Ô hàng chờ:** Lò Ngô 2: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 27 |
| 44 | 1.013.801 | **Ruộng:** Ruộng 28 |
| 46 | 1.205.355 | **Ruộng:** Ruộng 29 |
| 48 | 1.419.677 | **Nhà máy:** Tiệm Bánh Pie 2 · **Ô hàng chờ:** Tiệm Bánh Pie 2: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 30 |
| 50 | 1.658.047 | **Ruộng:** Ruộng 31 |
| 52 | 1.921.745 | **Ruộng:** Ruộng 32 |
| 54 | 2.212.051 | **Nhà máy:** Bàn đan 2 (cần mốc Thủ công) · **Chuồng:** Chuồng cừu 2 (cần mốc Thủ công) · **Ô chuồng:** Chuồng cừu 2: ô 2, 3, 4, 5 · **Ô hàng chờ:** Bàn đan 2: ô 2, 3, 4, 5 · **Ruộng:** Ruộng 33 |
| 56 | 2.530.245 | **Ruộng:** Ruộng 34 |
| 58 | 2.877.607 | **Ruộng:** Ruộng 35 |
| 60 | 3.255.417 | **Ruộng:** Ruộng 36 |
| 62 | 3.664.955 | **Ruộng:** Ruộng 37 |
| 64 | 4.107.501 | **Ruộng:** Ruộng 38 |
| 66 | 4.584.335 | **Ruộng:** Ruộng 39 |
| 68 | 5.096.737 | **Ruộng:** Ruộng 40 |

Level cấu hình của ô chuồng bò (2/3/4/5), heo (1/1/1/1), cừu (1/1/1/1) không cao hơn level mở chuồng (bò 10, heo 15, cừu 35), nên thực tế các ô này mở cùng lúc với chuồng. Chỉ ô chuồng gà (3/9/15/20) có mốc level riêng.

## Điều kiện nội dung (mốc Chăn nuôi và mốc Thủ công)

Ngoài level, một số thứ còn cần mốc nội dung. Mốc được tính trên **tổng số đã từng nhận** (thu hoạch, thu từ vật nuôi, nhận từ máy) trong suốt quá trình chơi; không cần còn trong kho, bán đi vẫn tính.

| Mốc | Điều kiện | Mở |
| --- | --- | --- |
| Mốc Chăn nuôi | Thức ăn gà hoặc Thức ăn bò ×1 và Trứng gà ×1 và Sữa bò ×1 | Chuồng heo 1–2, Cám heo, Burger, Pie khoai thịt |
| Mốc Thủ công | Burger ×1 | Chuồng cừu 1–2, Bàn đan 1–2, Cám cừu, Áo len |

Mốc Thủ công cần Burger, mà Burger cần Thịt xông khói từ heo, nên cừu và Bàn đan chỉ mở được sau khi đã nuôi heo và có Bếp nướng.
