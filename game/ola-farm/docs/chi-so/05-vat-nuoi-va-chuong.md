# 05. Vật nuôi và chuồng

> Nguồn: [economy.json](../../assets/farm/bundles/farm-town/economy.json) (`animals`, `pens`, `items`), [timing.json](../../assets/farm/bundles/farm-town/timing.json) (`animals`), [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json) (`animals`, `gates`), [catalog.json](../../assets/farm/bundles/farm-town/catalog.json) (`livestock`, `residentPens`), [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts). Đối chiếu ngày 25/09/2026.

## Bốn loài

| Loài | Mã | Thức ăn | Sản phẩm | Thời gian / lượt | Giá 1 con (xu) | Thức ăn / con / lượt | Sản phẩm / con / lượt | EXP / con / lượt |
| --- | --- | --- | --- | ---: | ---: | ---: | ---: | ---: |
| Gà đẻ trứng | `layer` | Thức ăn gà | Trứng gà | 30 phút | 120 | 1 | 1 | 3 |
| Bò sữa | `dairy-cow` | Thức ăn bò | Sữa bò | 2 giờ | 240 | 1 | 1 | 6 |
| Heo | `pig` | Cám heo | Thịt xông khói | 6 giờ | 360 | 1 | 1 | 12 |
| Cừu | `sheep` | Cám cừu | Len | 12 giờ | 600 | 1 | 1 | 20 |

## Tám chuồng

| Chuồng | Mã | Level | Giá nền (xu) | Giá xây gồm con đầu (xu) | Điều kiện thêm |
| --- | --- | ---: | ---: | ---: | --- |
| Chuồng gà 1 | `pen:12` | 1 | 100 | 100 + 1 × 120 = **220** | — |
| Chuồng gà 2 | `pen:50` | 12 | 4.000 | 4.000 + 1 × 120 = **4.120** | có Chuồng gà 1 |
| Chuồng bò 1 | `pen:13` | 10 | 200 | 200 + 1 × 240 = **440** | — |
| Chuồng bò 2 | `pen:51` | 24 | 8.000 | 8.000 + 1 × 240 = **8.240** | có Chuồng bò 1 |
| Chuồng heo 1 | `pen:14` | 15 | 4.500 | 4.500 + 1 × 360 = **4.860** | mốc Chăn nuôi |
| Chuồng heo 2 | `pen:52` | 30 | 14.000 | 14.000 + 1 × 360 = **14.360** | có Chuồng heo 1; mốc Chăn nuôi |
| Chuồng cừu 1 | `pen:15` | 35 | 12.000 | 12.000 + 1 × 600 = **12.600** | mốc Thủ công |
| Chuồng cừu 2 | `pen:53` | 54 | 22.000 | 22.000 + 1 × 600 = **22.600** | có Chuồng cừu 1; mốc Thủ công |

Mọi chuồng đều cần đã có Máy thức ăn. Mỗi loài tối đa 2 chuồng; chuồng khởi đầu với 1 ô và 1 con.

## Ô chuồng 2–5

Mở một ô = trả **phí ô + giá 1 con**, được thêm 1 ô và 1 con cùng lúc. Level ghi là level cấu hình của ô; thực tế còn phải có chuồng (xem [02](02-exp-level-mo-khoa.md#lịch-mở-khóa-theo-level)). Chuồng 2 dùng cùng bảng giá và level ô như chuồng 1.

| Loài | Ô 2 | Ô 3 | Ô 4 | Ô 5 | Tổng mở đủ 5 ô / chuồng |
| --- | ---: | ---: | ---: | ---: | ---: |
| Gà đẻ trứng | 45 + 120 = **165** · L5 | 75 + 120 = **195** · L10 | 120 + 120 = **240** · L15 | 180 + 120 = **300** · L20 | 900 |
| Bò sữa | 45 + 240 = **285** · L2 | 75 + 240 = **315** · L3 | 120 + 240 = **360** · L4 | 180 + 240 = **420** · L5 | 1.380 |
| Heo | 45 + 360 = **405** · L1 | 75 + 360 = **435** · L1 | 120 + 360 = **480** · L1 | 180 + 360 = **540** · L1 | 1.860 |
| Cừu | 45 + 600 = **645** · L1 | 75 + 600 = **675** · L1 | 120 + 600 = **720** · L1 | 180 + 600 = **780** · L1 | 2.820 |

## Hiệu quả (số tính ra)

| Loài | Giá bán thức ăn / lượt | Giá bán sản phẩm / lượt | Chênh lệch / lượt | Chênh lệch / giờ / con | EXP / giờ / con | Giá vốn hạt giống / sản phẩm |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Gà đẻ trứng | 12 | 32 | 20 | 40 | 6 | 7,78 |
| Bò sữa | 30 | 72 | 42 | 21 | 3 | 16,67 |
| Heo | 60 | 180 | 120 | 20 | 2 | 30 |
| Cừu | 85 | 320 | 235 | 19,58 | 1,67 | 37,78 |

- Chênh lệch = giá bán sản phẩm − giá bán thức ăn đã dùng (thức ăn nếu không cho ăn thì có thể bán).
- "Mỗi giờ" giả định cho ăn lại ngay khi thu, liên tục 24 giờ.
- Giá vốn hạt giống = tiền hạt để làm ra phần thức ăn của 1 sản phẩm (xem [08](08-vat-pham-gia-ban.md)); chưa tính tiền mua con.

## Mỗi con mỗi ngày theo lịch chơi

Cho ăn ở một lần ghé, thu ở lần ghé đầu tiên sau khi xong rồi cho ăn lại ngay; trung bình trên 28 ngày. Lịch ghé giống [mô phỏng nhịp chơi](02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính).

| Loài | Nhẹ: lượt / ngày | Nhẹ: chênh lệch / ngày | Nhẹ: EXP / ngày | Đều: lượt / ngày | Đều: chênh lệch / ngày | Đều: EXP / ngày |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Gà đẻ trứng | 3 | 60 | 9 | 6 | 120 | 18 |
| Bò sữa | 3 | 126 | 18 | 6 | 252 | 36 |
| Heo | 2 | 240 | 24 | 3 | 360 | 36 |
| Cừu | 1,5 | 352,5 | 30 | 2 | 470 | 40 |

## Làm xong ngay, bán con

| Loài | Kim cương làm xong ngay khi vừa cho ăn | Bán lại 1 con (xu, không có nút trên giao diện) |
| --- | ---: | ---: |
| Gà đẻ trứng | 30 | 60 |
| Bò sữa | 120 | 120 |
| Heo | 360 | 180 |
| Cừu | 720 | 300 |

- Giá làm xong ngay: cứ 1 phút còn lại tốn 1 kim cương, làm tròn lên, tính từng con (xem [09](09-kim-cuong-xu.md#giá-làm-xong-ngay)); làm từng con một.
- Bán con hoàn 50% giá con, làm tròn xuống, chỉ bán được con đang chờ ăn; code có nhưng giao diện chưa có nút.

## Tổng chi phí nuôi đủ

| Loài | Xây 2 chuồng (gồm 2 con) | Mở ô 2–5 cả 2 chuồng (gồm 8 con) | Tổng cho 10 con |
| --- | ---: | ---: | ---: |
| Gà đẻ trứng | 4.340 | 1.800 | 6.140 |
| Bò sữa | 8.680 | 2.760 | 11.440 |
| Heo | 19.220 | 3.720 | 22.940 |
| Cừu | 35.200 | 5.640 | 40.840 |

Cả 4 loài: xây 8 chuồng 67.440 xu + mở ô 13.920 xu = **81.360 xu** cho 40 con.

## Luật

- **Cho ăn:** chạm nút của từng con (mỗi con 1 phần thức ăn), hoặc nút "Cho ăn tất cả" cho mọi con đang chờ; nút này cần đủ thức ăn cho tất cả. Con đã ăn bắt đầu đếm giờ.
- **Thu:** hết giờ thì thu từng con hoặc bấm "Thu hoạch tất cả"; mỗi con ra 1 sản phẩm và EXP theo loài (gà 3, bò 6, heo 12, cừu 20). Thu xong con quay lại trạng thái chờ ăn.
- Con đang đếm giờ thì nút của con đó hiện giá kim cương để làm xong ngay.
- Sản phẩm, EXP và thời gian **chốt lúc cho ăn**.
- Không có con chết, bệnh hay cần chăm sóc thêm.

## Chỉnh ở đâu

| Chỉ số | File | Khóa |
| --- | --- | --- |
| Giá con, số sản phẩm mỗi lượt, giá và level ô 2–5 | economy.json | `animals.<loài>.purchasePrice`, `quantity`, `slots` |
| Giá nền và level chuồng | economy.json | `pens.<mã chuồng>.sitePrice`, `requiredLevel` |
| EXP mỗi con mỗi lượt (theo loài) | economy.json | `animals.<loài>.xp` |
| Giá bán thức ăn, sản phẩm | economy.json | `items.<mã>.sellPrice` |
| Thời gian mỗi lượt | timing.json | `animals.<loài>.durationSeconds` |
| Số chuồng, số ô tối đa, ô và con khởi đầu, thức ăn mỗi con | gameplay.json | `animals.<loài>.maxPens`, `maxCapacity`, `startingCapacity`, `startingAnimals`, `feedPerAnimal` |
| Điều kiện mốc | gameplay.json | `gates.husbandry`, `gates.crafts` |
| Thức ăn và sản phẩm của loài | catalog.json | `livestock[].feed`, `output` |
| Tỷ lệ hoàn khi bán con | economy.json | `refunds.animalSaleRate` |
