# 08. Vật phẩm và giá bán

> Nguồn: [catalog.json](../../assets/farm/bundles/farm-town/catalog.json) (`items`), [economy.json](../../assets/farm/bundles/farm-town/economy.json) (`items`), [FarmCatalog.ts](../../assets/farm/scripts/core/FarmCatalog.ts) (`stockCatalog`). Đối chiếu ngày 25/09/2026.

## 35 vật phẩm

| Vật phẩm | Mã | Tab kho | Giá bán (xu) | Nguồn | Dùng cho | Giá vốn hạt giống (tính ra) |
| --- | --- | --- | ---: | --- | --- | ---: |
| Lúa mì | `raw:1` | Nguyên liệu | 8 | Cây Lúa mì | Thức ăn gà, Bánh mì, Bánh dâu, Bánh Quế (Waffle), Bánh nho, Bánh Bắp Cải, Pie khoai thịt, Bánh Bí Ngô | 6,67 |
| Ngô | `farm40:corn` | Nguyên liệu | 14 | Cây Ngô | Thức ăn gà, Bánh mì ngô, Thức ăn bò, Bánh Quế (Waffle), Bỏng Ngô, Ngũ Cốc Ngô | 10 |
| Bắp cải | `farm40:cabbage` | Nguyên liệu | 23 | Cây Bắp cải | Thức ăn bò, Cám heo, Bánh Bắp Cải | 15 |
| Củ Cải Đường | `town:beet` | Nguyên liệu | 35 | Cây Củ Cải Đường | Đường Trắng | 21,67 |
| Khoai Tây | `town:potato` | Nguyên liệu | 52 | Cây Khoai Tây | Khoai Tây Chiên, Cám heo, Pie khoai thịt, Cám cừu | 30 |
| Dâu tây | `raw:4` | Nguyên liệu | 76 | Cây Dâu tây | Bánh dâu, Sữa Chua Dâu Tây | 40 |
| Bí Ngô | `town:pumpkin` | Nguyên liệu | 104 | Cây Bí Ngô | Bánh Bí Ngô, Cám cừu | 53,33 |
| Nho | `raw:3` | Nguyên liệu | 150 | Cây Nho | Bánh nho | 73,33 |
| Trứng gà | `farm40:egg` | Nguyên liệu | 32 | Vật nuôi: Gà đẻ trứng | Bánh mì ngô, Bánh Quế (Waffle), Bánh Bắp Cải | 7,78 |
| Sữa bò | `raw:7` | Nguyên liệu | 72 | Vật nuôi: Bò sữa | Bơ, Phô mai, Kem sữa, Sữa Chua Dâu Tây, Ngũ Cốc Ngô | 16,67 |
| Thịt xông khói | `town:beacon` | Nguyên liệu | 180 | Vật nuôi: Heo | Burger, Pie khoai thịt | 30 |
| Len | `town:wool` | Nguyên liệu | 320 | Vật nuôi: Cừu | Áo len | 37,78 |
| Thức ăn gà | `farm40:chicken-feed` | Thành phẩm | 12 | Máy thức ăn: Thức ăn gà | Thức ăn cho gà đẻ trứng | 7,78 |
| Thức ăn bò | `farm40:cow-feed` | Thành phẩm | 30 | Máy thức ăn: Thức ăn bò | Thức ăn cho bò sữa | 16,67 |
| Cám heo | `town:feed_pig` | Thành phẩm | 60 | Máy thức ăn: Cám heo | Thức ăn cho heo | 30 |
| Cám cừu | `town:feed_goat` | Thành phẩm | 85 | Máy thức ăn: Cám cừu | Thức ăn cho cừu | 37,78 |
| Bánh mì | `goods:7` | Thành phẩm | 28 | Lò bánh: Bánh mì | Bánh Mì Nướng, Burger | 13,33 |
| Bánh mì ngô | `farm40:corn-bread` | Thành phẩm | 135 | Lò bánh: Bánh mì ngô | — (chỉ để bán) | 35,56 |
| Bánh dâu | `goods:10` | Thành phẩm | 132 | Lò bánh: Bánh dâu | — (chỉ để bán) | 53,33 |
| Bánh Quế (Waffle) | `town:waffle` | Thành phẩm | 250 | Lò bánh: Bánh Quế (Waffle) | — (chỉ để bán) | 67,22 |
| Bánh nho | `goods:9` | Thành phẩm | 225 | Lò bánh: Bánh nho | — (chỉ để bán) | 86,67 |
| Bơ | `goods:20` | Thành phẩm | 205 | Xưởng sữa: Bơ | Khoai Tây Chiên, Bánh Mì Nướng, Bỏng Ngô | 33,33 |
| Phô mai | `goods:22` | Thành phẩm | 220 | Xưởng sữa: Phô mai | Burger | 33,33 |
| Kem sữa | `town:cream` | Thành phẩm | 106 | Xưởng sữa: Kem sữa | Bánh Bí Ngô | 16,67 |
| Sữa Chua Dâu Tây | `town:yogurt` | Thành phẩm | 335 | Xưởng sữa: Sữa Chua Dâu Tây | — (chỉ để bán) | 96,67 |
| Khoai Tây Chiên | `town:fries` | Thành phẩm | 525 | Bếp nướng: Khoai Tây Chiên | — (chỉ để bán) | 123,33 |
| Bánh Mì Nướng | `town:toast` | Thành phẩm | 330 | Bếp nướng: Bánh Mì Nướng | — (chỉ để bán) | 46,67 |
| Burger | `town:burger` | Thành phẩm | 660 | Bếp nướng: Burger | — (chỉ để bán) | 90 |
| Đường Trắng | `town:sugar` | Thành phẩm | 55 | Máy Chế Biến Đường: Đường Trắng | Bánh Quế (Waffle), Ngũ Cốc Ngô | 21,67 |
| Bỏng Ngô | `town:popcorn` | Thành phẩm | 355 | Lò Ngô: Bỏng Ngô | — (chỉ để bán) | 63,33 |
| Ngũ Cốc Ngô | `town:flakes` | Thành phẩm | 220 | Lò Ngô: Ngũ Cốc Ngô | — (chỉ để bán) | 58,33 |
| Bánh Bắp Cải | `town:pie_cabbage` | Thành phẩm | 180 | Tiệm Bánh Pie: Bánh Bắp Cải | — (chỉ để bán) | 58,89 |
| Pie khoai thịt | `town:pie_potato` | Thành phẩm | 690 | Tiệm Bánh Pie: Pie khoai thịt | — (chỉ để bán) | 133,33 |
| Bánh Bí Ngô | `town:pie_pumpkin` | Thành phẩm | 490 | Tiệm Bánh Pie: Bánh Bí Ngô | — (chỉ để bán) | 136,67 |
| Áo len | `town:woolly` | Thành phẩm | 960 | Bàn đan: Áo len | — (chỉ để bán) | 75,56 |

- **Tab kho:** "Nguyên liệu" và "Thành phẩm" là hai tab trong kho của game.
- **Giá bán** là giá bán trong kho, bán bao nhiêu cũng một giá, không có giá mua vào (không mua được vật phẩm).
- **Giá vốn hạt giống** = tiền hạt để làm ra 1 đơn vị, cộng qua mọi bước: cây = giá hạt / sản lượng; thức ăn và thành phẩm = tổng giá vốn nguyên liệu / số thành phẩm; sản phẩm vật nuôi = giá vốn phần thức ăn / số sản phẩm. Không tính tiền xây nhà, mua con, thời gian.
- Mã vật phẩm là khóa trong bản lưu, không được đổi. Một số mã lệch nghĩa do lịch sử: `town:beacon` là **Thịt xông khói** (bacon), `town:feed_goat` là **Cám cừu**, `town:woolly` là **Áo len**.
- Trường `sourcePrice` trong catalog.json chỉ là giá tham khảo từ nguồn cũ, **game không dùng**.

## Chỉnh ở đâu

`items.<mã>.sellPrice` trong economy.json. Tên hiển thị lấy ở `items[].name` trong catalog.json.
