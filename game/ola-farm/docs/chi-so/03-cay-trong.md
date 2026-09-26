# 03. Cây trồng

> Nguồn: [economy.json](../../assets/farm/bundles/farm-town/economy.json) (`crops`, `items`), [timing.json](../../assets/farm/bundles/farm-town/timing.json) (`crops`), [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts) (`plant`, `harvest`, `cancel`, `boost`), [FarmMigration.ts](../../assets/farm/scripts/core/FarmMigration.ts) (`cropSnapshot`). Đối chiếu ngày 25/09/2026.

## Bảng chính

| Cây | Mã vật phẩm | Level mở | Thời gian lớn | Giá hạt (xu) | Sản lượng / lần thu | Giá bán / đơn vị (xu) | EXP thu hoạch |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Lúa mì | `raw:1` | 1 | 5 phút | 20 | 3 | 8 | 2 |
| Ngô | `farm40:corn` | 1 | 15 phút | 30 | 3 | 14 | 3 |
| Bắp cải | `farm40:cabbage` | 4 | 45 phút | 45 | 3 | 23 | 5 |
| Củ Cải Đường | `town:beet` | 7 | 2 giờ | 65 | 3 | 35 | 8 |
| Khoai Tây | `town:potato` | 10 | 4 giờ | 90 | 3 | 52 | 12 |
| Dâu tây | `raw:4` | 14 | 6 giờ | 120 | 3 | 76 | 16 |
| Bí Ngô | `town:pumpkin` | 18 | 8 giờ | 160 | 3 | 104 | 20 |
| Nho | `raw:3` | 24 | 12 giờ | 220 | 3 | 150 | 26 |

Sản lượng là của **đất cấp 1**, cấp duy nhất hiện có (xem bên dưới).

## Hiệu quả (số tính ra)

| Cây | Doanh thu / lần thu | Lãi / lần thu | Xu lãi / giờ / ô | EXP thu hoạch / giờ / ô | EXP bán / lần thu | Tổng EXP / giờ / ô |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Lúa mì | 24 | 4 | 48 | 24 | 0,24 | 26,88 |
| Ngô | 42 | 12 | 48 | 12 | 0,42 | 13,68 |
| Bắp cải | 69 | 24 | 32 | 6,67 | 0,69 | 7,59 |
| Củ Cải Đường | 105 | 40 | 20 | 4 | 1,05 | 4,53 |
| Khoai Tây | 156 | 66 | 16,5 | 3 | 1,56 | 3,39 |
| Dâu tây | 228 | 108 | 18 | 2,67 | 2,28 | 3,05 |
| Bí Ngô | 312 | 152 | 19 | 2,5 | 3,12 | 2,89 |
| Nho | 450 | 230 | 19,17 | 2,17 | 4,5 | 2,54 |

- Doanh thu = sản lượng × giá bán. Lãi = doanh thu − giá hạt.
- "Mỗi giờ / ô" giả định gieo lại ngay khi chín, liên tục 24 giờ; người chơi ghé thưa thì thấp hơn.
- EXP bán = doanh thu / 100 (trung bình, vì EXP bán cộng dồn phần lẻ). Tổng EXP / giờ = (EXP thu hoạch + EXP bán) × 3.600 / thời gian lớn (giây).

## Mỗi ô mỗi ngày theo lịch chơi

Gieo ở một lần ghé, thu ở lần ghé đầu tiên sau khi chín rồi gieo lại ngay; trung bình trên 28 ngày. Cây chín giữa hai lần ghé phải chờ tới lần ghé sau, nên người ghé thưa lời nhất với cây dài, người ghé dày lời nhất với cây vừa khít khoảng cách giữa hai lần ghé. EXP gồm EXP thu hoạch và EXP bán. Lịch ghé giống [mô phỏng nhịp chơi](02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính).

| Cây | Nhẹ: lần thu / ngày | Nhẹ: lãi / ngày | Nhẹ: EXP / ngày | Đều: lãi / ngày | Đều: EXP / ngày | Cày: lãi / ngày | Cày: EXP / ngày |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Lúa mì | 3 | 12 | 6,7 | 24 | 13,4 | 68 | 38,1 |
| Ngô | 3 | 36 | 10,3 | 72 | 20,5 | 204 | 58,1 |
| Bắp cải | 3 | 72 | 17,1 | 144 | 34,1 | 408 | 96,7 |
| Củ Cải Đường | 3 | 120 | 27,2 | 240 | 54,3 | 360 | 81,5 |
| Khoai Tây | 3 | 198 | 40,7 | 198 | 40,7 | 330 | 67,8 |
| Dâu tây | 2 | 216 | 36,6 | 324 | 54,8 | 324 | 54,8 |
| Bí Ngô | 2 | 304 | 46,2 | 304 | 46,2 | 456 | 69,4 |
| Nho | 1,5 | 345 | 45,8 | 460 | 61 | 460 | 61 |

## Làm chín ngay và hủy

| Cây | Kim cương làm chín ngay khi vừa gieo | Hoàn khi hủy (xu) |
| --- | ---: | ---: |
| Lúa mì | 5 | 6 |
| Ngô | 15 | 9 |
| Bắp cải | 45 | 13 |
| Củ Cải Đường | 120 | 19 |
| Khoai Tây | 240 | 27 |
| Dâu tây | 360 | 36 |
| Bí Ngô | 480 | 48 |
| Nho | 720 | 66 |

- Giá làm chín ngay: cứ 1 phút còn lại tốn 1 kim cương, làm tròn lên (xem [09](09-kim-cuong-xu.md#giá-làm-xong-ngay)). Cột trên là giá khi vừa gieo; cây càng gần chín càng rẻ.
- Hủy cây đang lớn hoàn 30% giá hạt, làm tròn xuống; cây đã chín không hủy được. Hủy không trừ EXP (gieo hạt cho 0 EXP).
- Lúa cứu trợ (xem [09](09-kim-cuong-xu.md#lúa-cứu-trợ)) gieo miễn phí, không EXP, hủy không hoàn tiền.

## Sản lượng theo cấp đất

| Cây | Cấp 1 | Cấp 2 | Cấp 3 | Cấp 4 |
| --- | ---: | ---: | ---: | ---: |
| Lúa mì | 3 | 5 | 7 | 9 |
| Ngô | 3 | 5 | 7 | 9 |
| Bắp cải | 3 | 5 | 7 | 9 |
| Củ Cải Đường | 3 | 4 | 5 | 6 |
| Khoai Tây | 3 | 4 | 5 | 6 |
| Dâu tây | 3 | 5 | 7 | 9 |
| Bí Ngô | 3 | 4 | 5 | 6 |
| Nho | 3 | 5 | 7 | 9 |

**Hiện không có cách nâng cấp đất**: mọi ruộng mở ra ở cấp 1 và không thao tác nào tăng cấp. Các cột cấp 2–4 là cấu hình chờ sẵn, chưa dùng.

## Cây dùng vào đâu

| Cây | Dùng làm nguyên liệu cho | Level sớm nhất có công thức dùng | Số level chỉ bán thô được |
| --- | --- | ---: | ---: |
| Lúa mì | Thức ăn gà (L1), Bánh mì (L5), Bánh dâu (L14), Bánh Quế (Waffle) (L20), Bánh nho (L24), Bánh Bắp Cải (L30), Pie khoai thịt (L30, mốc Chăn nuôi), Bánh Bí Ngô (L30) | L1 | 0 |
| Ngô | Thức ăn gà (L1), Bánh mì ngô (L5), Thức ăn bò (L10), Bánh Quế (Waffle) (L20), Bỏng Ngô (L25), Ngũ Cốc Ngô (L25) | L1 | 0 |
| Bắp cải | Thức ăn bò (L10), Cám heo (L15, mốc Chăn nuôi), Bánh Bắp Cải (L30) | L10 | 6 (L4–L9) |
| Củ Cải Đường | Đường Trắng (L20) | L20 | 13 (L7–L19) |
| Khoai Tây | Khoai Tây Chiên (L15), Cám heo (L15, mốc Chăn nuôi), Pie khoai thịt (L30, mốc Chăn nuôi), Cám cừu (L35, mốc Thủ công) | L15 | 5 (L10–L14) |
| Dâu tây | Bánh dâu (L14), Sữa Chua Dâu Tây (L14) | L14 | 0 |
| Bí Ngô | Bánh Bí Ngô (L30), Cám cừu (L35, mốc Thủ công) | L30 | 12 (L18–L29) |
| Nho | Bánh nho (L24) | L24 | 0 |

## Luật

- Ruộng nào cũng gieo được mọi cây đã mở level; mỗi ô một cây một lúc.
- Gieo trừ tiền hạt ngay. Hết xu thì không gieo được.
- Cây đổi sang hình "đang lớn" khi đi được 50% thời gian (`growthStageFraction`), chỉ là hình ảnh.
- Thu hoạch đưa toàn bộ sản lượng vào kho và cộng EXP thu hoạch; không có rủi ro hỏng hay mất mùa.
- Giá hạt, sản lượng, EXP, tiền hoàn và thời gian được **chốt lúc gieo**; đổi cấu hình không ảnh hưởng cây đang lớn.

## Chỉnh ở đâu

| Chỉ số | File | Khóa |
| --- | --- | --- |
| Giá hạt, level, EXP thu hoạch, sản lượng 4 cấp đất | economy.json | `crops.<cây>.seedPrice`, `requiredLevel`, `harvestXP`, `yields` |
| Giá bán | economy.json | `items.<mã vật phẩm>.sellPrice` |
| Thời gian lớn | timing.json | `crops.<cây>.durationSeconds` |
| Số giây cho mỗi kim cương khi làm chín ngay | timing.json | `boostSecondsPerGem` |
| Tỷ lệ hoàn khi hủy | economy.json | `refunds.cropCancelRate` |

`<cây>` là mã: `wheat` (Lúa mì), `corn` (Ngô), `cabbage` (Bắp cải), `beet` (Củ Cải Đường), `potato` (Khoai Tây), `strawberry` (Dâu tây), `pumpkin` (Bí Ngô), `grapes` (Nho). Lúa mì bắt buộc mở ở level 1 vì dùng cho lúa cứu trợ.
