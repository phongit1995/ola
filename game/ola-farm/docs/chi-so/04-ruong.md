# 04. Ruộng

> Nguồn: [economy.json](../../assets/farm/bundles/farm-town/economy.json) (`fields`), [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts) (`improve`, `fieldUnlockOffer`). Đối chiếu ngày 25/09/2026.

## Luật

- 6 ruộng mở sẵn ở level 1. 34 ruộng còn lại mua lần lượt, **mỗi lần một ô, đúng thứ tự** từ Ruộng 7 đến Ruộng 40.
- Level 2, 4, 6, …, 68 (các level chẵn) mỗi level mở quyền mua thêm 1 ô. Level lẻ không thêm ô.
- Đạt level chỉ mở quyền mua; ô chưa mua giữ lại để mua sau.
- Bản đồ chỉ hiện ruộng đã có và **một ô xanh kế tiếp**; chạm ô xanh để xem level yêu cầu hoặc giá.
- Đất mua xong giữ vĩnh viễn, không có phí duy trì. Mọi ô ở cấp đất 1.
- ID là mã lưu trong bản lưu: ruộng 1–12 là ID 0–11, ruộng 13–40 là ID 22–49 (ID 12–21 là vị trí chuồng và ao).

## Bảng 40 ruộng

| Ruộng | ID | Level mua được | Giá mở (xu) | Tổng tiền đất đến ô này (xu) |
| --- | ---: | ---: | ---: | ---: |
| Ruộng 1 | 0 | 1 (mở sẵn) | 0 | 0 |
| Ruộng 2 | 1 | 1 (mở sẵn) | 0 | 0 |
| Ruộng 3 | 2 | 1 (mở sẵn) | 0 | 0 |
| Ruộng 4 | 3 | 1 (mở sẵn) | 0 | 0 |
| Ruộng 5 | 4 | 1 (mở sẵn) | 0 | 0 |
| Ruộng 6 | 5 | 1 (mở sẵn) | 0 | 0 |
| Ruộng 7 | 6 | 2 | 500 | 500 |
| Ruộng 8 | 7 | 4 | 1.000 | 1.500 |
| Ruộng 9 | 8 | 6 | 1.500 | 3.000 |
| Ruộng 10 | 9 | 8 | 2.500 | 5.500 |
| Ruộng 11 | 10 | 10 | 4.000 | 9.500 |
| Ruộng 12 | 11 | 12 | 6.000 | 15.500 |
| Ruộng 13 | 22 | 14 | 8.100 | 23.600 |
| Ruộng 14 | 23 | 16 | 22.000 | 45.600 |
| Ruộng 15 | 24 | 18 | 44.000 | 89.600 |
| Ruộng 16 | 25 | 20 | 73.000 | 162.600 |
| Ruộng 17 | 26 | 22 | 110.000 | 272.600 |
| Ruộng 18 | 27 | 24 | 160.000 | 432.600 |
| Ruộng 19 | 28 | 26 | 210.000 | 642.600 |
| Ruộng 20 | 29 | 28 | 270.000 | 912.600 |
| Ruộng 21 | 30 | 30 | 340.000 | 1.252.600 |
| Ruộng 22 | 31 | 32 | 410.000 | 1.662.600 |
| Ruộng 23 | 32 | 34 | 500.000 | 2.162.600 |
| Ruộng 24 | 33 | 36 | 590.000 | 2.752.600 |
| Ruộng 25 | 34 | 38 | 680.000 | 3.432.600 |
| Ruộng 26 | 35 | 40 | 790.000 | 4.222.600 |
| Ruộng 27 | 36 | 42 | 900.000 | 5.122.600 |
| Ruộng 28 | 37 | 44 | 1.030.000 | 6.152.600 |
| Ruộng 29 | 38 | 46 | 1.150.000 | 7.302.600 |
| Ruộng 30 | 39 | 48 | 1.290.000 | 8.592.600 |
| Ruộng 31 | 40 | 50 | 1.440.000 | 10.032.600 |
| Ruộng 32 | 41 | 52 | 1.590.000 | 11.622.600 |
| Ruộng 33 | 42 | 54 | 1.750.000 | 13.372.600 |
| Ruộng 34 | 43 | 56 | 1.910.000 | 15.282.600 |
| Ruộng 35 | 44 | 58 | 2.090.000 | 17.372.600 |
| Ruộng 36 | 45 | 60 | 2.270.000 | 19.642.600 |
| Ruộng 37 | 46 | 62 | 2.460.000 | 22.102.600 |
| Ruộng 38 | 47 | 64 | 2.660.000 | 24.762.600 |
| Ruộng 39 | 48 | 66 | 2.870.000 | 27.632.600 |
| Ruộng 40 | 49 | 68 | 3.080.000 | 30.712.600 |

Tổng tiền mua đủ 34 ô: **30.712.600 xu**.

## Giá đã được đặt ra thế nào

Đợt cân bằng 25/09/2026 đặt lại giá theo đường level mới. Giá ô thứ `k` mua thêm (k = 1…34, ô trên bản đồ là k + 6, level mua là 2k) được tính rồi ghi cố định vào economy.json:

```text
T(L)      = tổng EXP để đạt level L
ΔXP(1)    = T(2) − T(1);   ΔXP(k) = T(2k) − T(2k − 2) với k ≥ 2
Sàn(k)    = 500, 1.000, 1.500, 2.500, 4.000, 6.000 với k = 1…6;   6.000 + 2.000 × (k − 6) với k ≥ 7
Giá thô   = max(Sàn(k), 6 × ΔXP(k))
Giá mở    = làm tròn lên theo bậc 100 xu nếu giá thô < 10.000; bậc 1.000 xu nếu < 100.000; bậc 10.000 xu từ 100.000
```

Nghĩa là: Ruộng 7–Ruộng 12 lấy giá sàn cho dễ mua lúc mới chơi; từ Ruộng 13 giá bám theo **6 xu cho mỗi EXP** cần để đi qua 2 level. Đổi đường level mà không đổi bảng giá thì giá không tự đổi theo.

Trong [mô phỏng nhịp chơi](02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính) ngày 25/09/2026, người chơi nhẹ mua mỗi ô sau khi đủ level trung bình 10,4 ngày với Ruộng 7–Ruộng 20 và 32,7 ngày với Ruộng 21–Ruộng 40: xu vẫn là thứ phải để dành, nhưng không chặn quá lâu. Lúc mua hết còn 19.810 xu.

Bảng cũ (trước 25/09/2026) dùng giá thô = max(2.000 × k, 4 × ΔXP(k)) trên đường level cũ, tổng 102.021.000 xu; mô phỏng cùng cách với cấu hình cũ cho thấy người chơi 3 lần/ngày mất khoảng 22 năm mới mua hết và dư khoảng 69 triệu xu.

## Chỉnh ở đâu

`fields.<ID>` trong economy.json: `initiallyUnlocked` (mở sẵn), `requiredLevel`, `unlockPrice`, `initialLevel` (cấp đất khởi đầu, 1–4). Phải còn ít nhất 1 ruộng mở sẵn.
