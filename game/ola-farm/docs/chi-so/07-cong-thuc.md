# 07. Công thức chế biến

> Nguồn: [catalog.json](../../assets/farm/bundles/farm-town/catalog.json) (`products`), [economy.json](../../assets/farm/bundles/farm-town/economy.json) (`recipes`, `items`), [timing.json](../../assets/farm/bundles/farm-town/timing.json) (`recipes`), [FarmCatalog.ts](../../assets/farm/scripts/core/FarmCatalog.ts). Đối chiếu ngày 25/09/2026.

## 23 công thức theo nhà máy

### Máy thức ăn

| Công thức | ID | Level | Điều kiện thêm | Nguyên liệu | Thành phẩm | Thời gian | EXP | Giá bán 1 thành phẩm (xu) |
| --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| Thức ăn gà | 24 | 1 | — | 2 Lúa mì + 1 Ngô | 3 Thức ăn gà | 5 phút | 2 | 12 |
| Thức ăn bò | 25 | 10 | — | 2 Ngô + 2 Bắp cải | 3 Thức ăn bò | 15 phút | 4 | 30 |
| Cám heo | 105003 | 15 | mốc Chăn nuôi | 2 Bắp cải + 2 Khoai Tây | 3 Cám heo | 30 phút | 6 | 60 |
| Cám cừu | 105004 | 35 | mốc Thủ công | 2 Khoai Tây + 1 Bí Ngô | 3 Cám cừu | 1 giờ | 8 | 85 |

### Lò bánh

| Công thức | ID | Level | Điều kiện thêm | Nguyên liệu | Thành phẩm | Thời gian | EXP | Giá bán 1 thành phẩm (xu) |
| --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| Bánh mì | 7 | 5 | — | 2 Lúa mì | 1 Bánh mì | 10 phút | 3 | 28 |
| Bánh mì ngô | 26 | 5 | — | 2 Ngô + 2 Trứng gà | 1 Bánh mì ngô | 45 phút | 10 | 135 |
| Bánh dâu | 10 | 14 | — | 2 Lúa mì + 1 Dâu tây | 1 Bánh dâu | 1 giờ 30 phút | 16 | 132 |
| Bánh Quế (Waffle) | 100207 | 20 | — | 3 Lúa mì + 2 Trứng gà + 1 Đường Trắng + 1 Ngô | 1 Bánh Quế (Waffle) | 3 giờ | 26 | 250 |
| Bánh nho | 9 | 24 | — | 2 Lúa mì + 1 Nho | 1 Bánh nho | 2 giờ | 20 | 225 |

### Xưởng sữa

| Công thức | ID | Level | Điều kiện thêm | Nguyên liệu | Thành phẩm | Thời gian | EXP | Giá bán 1 thành phẩm (xu) |
| --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| Bơ | 20 | 10 | — | 2 Sữa bò | 1 Bơ | 30 phút | 9 | 205 |
| Phô mai | 22 | 10 | — | 2 Sữa bò | 1 Phô mai | 1 giờ | 12 | 220 |
| Kem sữa | 101501 | 10 | — | 1 Sữa bò | 1 Kem sữa | 20 phút | 6 | 106 |
| Sữa Chua Dâu Tây | 101503 | 14 | — | 1 Sữa bò + 2 Dâu tây | 1 Sữa Chua Dâu Tây | 2 giờ | 22 | 335 |

### Bếp nướng

| Công thức | ID | Level | Điều kiện thêm | Nguyên liệu | Thành phẩm | Thời gian | EXP | Giá bán 1 thành phẩm (xu) |
| --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| Khoai Tây Chiên | 101602 | 15 | — | 3 Khoai Tây + 1 Bơ | 1 Khoai Tây Chiên | 1 giờ 30 phút | 22 | 525 |
| Bánh Mì Nướng | 101603 | 15 | — | 1 Bánh mì + 1 Bơ | 1 Bánh Mì Nướng | 1 giờ | 14 | 330 |
| Burger | 101604 | 15 | mốc Chăn nuôi | 2 Bánh mì + 1 Thịt xông khói + 1 Phô mai | 1 Burger | 3 giờ | 30 | 660 |

### Máy Chế Biến Đường

| Công thức | ID | Level | Điều kiện thêm | Nguyên liệu | Thành phẩm | Thời gian | EXP | Giá bán 1 thành phẩm (xu) |
| --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| Đường Trắng | 107101 | 20 | — | 1 Củ Cải Đường | 1 Đường Trắng | 30 phút | 8 | 55 |

### Lò Ngô

| Công thức | ID | Level | Điều kiện thêm | Nguyên liệu | Thành phẩm | Thời gian | EXP | Giá bán 1 thành phẩm (xu) |
| --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| Bỏng Ngô | 102000 | 25 | — | 3 Ngô + 1 Bơ | 1 Bỏng Ngô | 2 giờ | 20 | 355 |
| Ngũ Cốc Ngô | 102001 | 25 | — | 2 Ngô + 1 Đường Trắng + 1 Sữa bò | 1 Ngũ Cốc Ngô | 1 giờ 30 phút | 16 | 220 |

### Tiệm Bánh Pie

| Công thức | ID | Level | Điều kiện thêm | Nguyên liệu | Thành phẩm | Thời gian | EXP | Giá bán 1 thành phẩm (xu) |
| --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| Bánh Bắp Cải | 101901 | 30 | — | 2 Lúa mì + 2 Bắp cải + 2 Trứng gà | 1 Bánh Bắp Cải | 2 giờ | 18 | 180 |
| Pie khoai thịt | 101902 | 30 | mốc Chăn nuôi | 2 Lúa mì + 2 Khoai Tây + 2 Thịt xông khói | 1 Pie khoai thịt | 4 giờ | 34 | 690 |
| Bánh Bí Ngô | 101904 | 30 | — | 2 Lúa mì + 2 Bí Ngô + 1 Kem sữa | 1 Bánh Bí Ngô | 3 giờ | 28 | 490 |

### Bàn đan

| Công thức | ID | Level | Điều kiện thêm | Nguyên liệu | Thành phẩm | Thời gian | EXP | Giá bán 1 thành phẩm (xu) |
| --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| Áo len | 102101 | 35 | mốc Thủ công | 2 Len | 1 Áo len | 6 giờ | 42 | 960 |

Các công thức cũ (Bánh mì, Bánh nho, Bánh dâu, Bơ, Phô mai) ghi nguyên liệu bằng số ID trong catalog.json: ID `n` nghĩa là vật phẩm `raw:n`, thành phẩm mặc định là 1 `goods:<ID công thức>`.

## Hiệu quả (số tính ra)

| Công thức | Máy | Giá trị nguyên liệu theo giá bán | Giá trị thành phẩm | Chênh lệch / mẻ | Chênh lệch % | Chênh lệch / giờ máy | EXP / giờ máy | Giá vốn hạt giống / mẻ | Lãi so với giá vốn / mẻ |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Thức ăn gà | Máy thức ăn | 30 | 36 | 6 | 20% | 72 | 24 | 23,33 | 12,67 |
| Thức ăn bò | Máy thức ăn | 74 | 90 | 16 | 21,6% | 64 | 16 | 50 | 40 |
| Cám heo | Máy thức ăn | 150 | 180 | 30 | 20% | 60 | 12 | 90 | 90 |
| Cám cừu | Máy thức ăn | 208 | 255 | 47 | 22,6% | 47 | 8 | 113,33 | 141,67 |
| Bánh mì | Lò bánh | 16 | 28 | 12 | 75% | 72 | 18 | 13,33 | 14,67 |
| Bánh mì ngô | Lò bánh | 92 | 135 | 43 | 46,7% | 57,33 | 13,33 | 35,56 | 99,44 |
| Bánh dâu | Lò bánh | 92 | 132 | 40 | 43,5% | 26,67 | 10,67 | 53,33 | 78,67 |
| Bánh Quế (Waffle) | Lò bánh | 157 | 250 | 93 | 59,2% | 31 | 8,67 | 67,22 | 182,78 |
| Bánh nho | Lò bánh | 166 | 225 | 59 | 35,5% | 29,5 | 10 | 86,67 | 138,33 |
| Bơ | Xưởng sữa | 144 | 205 | 61 | 42,4% | 122 | 18 | 33,33 | 171,67 |
| Phô mai | Xưởng sữa | 144 | 220 | 76 | 52,8% | 76 | 12 | 33,33 | 186,67 |
| Kem sữa | Xưởng sữa | 72 | 106 | 34 | 47,2% | 102 | 18 | 16,67 | 89,33 |
| Sữa Chua Dâu Tây | Xưởng sữa | 224 | 335 | 111 | 49,6% | 55,5 | 11 | 96,67 | 238,33 |
| Khoai Tây Chiên | Bếp nướng | 361 | 525 | 164 | 45,4% | 109,33 | 14,67 | 123,33 | 401,67 |
| Bánh Mì Nướng | Bếp nướng | 233 | 330 | 97 | 41,6% | 97 | 14 | 46,67 | 283,33 |
| Burger | Bếp nướng | 456 | 660 | 204 | 44,7% | 68 | 10 | 90 | 570 |
| Đường Trắng | Máy Chế Biến Đường | 35 | 55 | 20 | 57,1% | 40 | 16 | 21,67 | 33,33 |
| Bỏng Ngô | Lò Ngô | 247 | 355 | 108 | 43,7% | 54 | 10 | 63,33 | 291,67 |
| Ngũ Cốc Ngô | Lò Ngô | 155 | 220 | 65 | 41,9% | 43,33 | 10,67 | 58,33 | 161,67 |
| Bánh Bắp Cải | Tiệm Bánh Pie | 126 | 180 | 54 | 42,9% | 27 | 9 | 58,89 | 121,11 |
| Pie khoai thịt | Tiệm Bánh Pie | 480 | 690 | 210 | 43,8% | 52,5 | 8,5 | 133,33 | 556,67 |
| Bánh Bí Ngô | Tiệm Bánh Pie | 330 | 490 | 160 | 48,5% | 53,33 | 9,33 | 136,67 | 353,33 |
| Áo len | Bàn đan | 640 | 960 | 320 | 50% | 53,33 | 7 | 75,56 | 884,44 |

- Chênh lệch = giá trị thành phẩm − giá trị nguyên liệu nếu đem bán thẳng. Đây là cái lợi của việc chế biến so với bán thô.
- "Mỗi giờ máy" giả định máy chạy liên tục. Giá vốn hạt giống xem [08](08-vat-pham-gia-ban.md).
- Chênh lệch % thấp nhất: Thức ăn gà, Cám heo (20%); cao nhất: Bánh mì (75%).

## Một máy mỗi ngày với người chơi 3 lần/ngày

Người chơi ghé 7h, 12h, 20h (cách nhau 5, 8, 11 giờ) và mỗi lần xếp đủ 5 món (đã mở đủ 5 ô hàng chờ; lúc mới xây máy chỉ có 1 ô). Máy chạy liên tục nên số mẻ trong mỗi khoảng = min(5, khoảng cách / thời gian món). Đây là trần của một máy khi đủ nguyên liệu; thực tế thường thiếu nguyên liệu, nhất là sữa (xem [12](12-diem-can-chot.md)).

| Công thức | Máy | Mẻ / ngày | Chênh lệch / ngày | EXP / ngày |
| --- | --- | ---: | ---: | ---: |
| Thức ăn gà | Máy thức ăn | 15 | 90 | 30 |
| Thức ăn bò | Máy thức ăn | 15 | 240 | 60 |
| Cám heo | Máy thức ăn | 15 | 450 | 90 |
| Cám cừu | Máy thức ăn | 15 | 705 | 120 |
| Bánh mì | Lò bánh | 15 | 180 | 45 |
| Bánh mì ngô | Lò bánh | 15 | 645 | 150 |
| Bánh dâu | Lò bánh | 13,33 | 533,3 | 213,3 |
| Bánh Quế (Waffle) | Lò bánh | 8 | 744 | 208 |
| Bánh nho | Lò bánh | 11,5 | 678,5 | 230 |
| Bơ | Xưởng sữa | 15 | 915 | 135 |
| Phô mai | Xưởng sữa | 15 | 1.140 | 180 |
| Kem sữa | Xưởng sữa | 15 | 510 | 90 |
| Sữa Chua Dâu Tây | Xưởng sữa | 11,5 | 1.276,5 | 253 |
| Khoai Tây Chiên | Bếp nướng | 13,33 | 2.186,7 | 293,3 |
| Bánh Mì Nướng | Bếp nướng | 15 | 1.455 | 210 |
| Burger | Bếp nướng | 8 | 1.632 | 240 |
| Đường Trắng | Máy Chế Biến Đường | 15 | 300 | 120 |
| Bỏng Ngô | Lò Ngô | 11,5 | 1.242 | 230 |
| Ngũ Cốc Ngô | Lò Ngô | 13,33 | 866,7 | 213,3 |
| Bánh Bắp Cải | Tiệm Bánh Pie | 11,5 | 621 | 207 |
| Pie khoai thịt | Tiệm Bánh Pie | 6 | 1.260 | 204 |
| Bánh Bí Ngô | Tiệm Bánh Pie | 8 | 1.280 | 224 |
| Áo len | Bàn đan | 4 | 1.280 | 168 |

## Luật

- Xếp món cần: đủ level, đủ mốc (nếu có), có nhà máy đó còn chỗ trong hàng chờ, đủ nguyên liệu trong kho.
- Nguyên liệu trừ lúc xếp; EXP và thành phẩm nhận lúc lấy từ khay.
- Món đang làm có thể làm xong ngay bằng kim cương, xem [06](06-nha-may.md#luật).
- Mỗi mẻ ra đúng số thành phẩm ghi trong bảng (thức ăn gia súc ra 3, còn lại ra 1).

## Chỉnh ở đâu

| Chỉ số | File | Khóa |
| --- | --- | --- |
| Level, EXP | economy.json | `recipes.<ID>.requiredLevel`, `xp` |
| Giá bán thành phẩm | economy.json | `items.<mã thành phẩm>.sellPrice` |
| Thời gian | timing.json | `recipes.<ID>.durationSeconds` |
| Nguyên liệu, thành phẩm, máy, mốc | catalog.json | `products[].ingredients`, `outputs`, `machine`, `unlock` |
