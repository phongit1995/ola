# 06. Nhà máy

> Nguồn: [economy.json](../../assets/farm/bundles/farm-town/economy.json) (`machines`), [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json) (`machines`), [catalog.json](../../assets/farm/bundles/farm-town/catalog.json) (`machineTypes`, `products`), [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts). Đối chiếu ngày 25/09/2026.

## Tám loại nhà máy

| Nhà máy | Mã | Nhà 1: level · giá (xu) | Nhà 2: level · giá (xu) | Điều kiện thêm | Công thức |
| --- | --- | ---: | ---: | --- | --- |
| Máy thức ăn | `feedmill` (5) | L1 · 200 | L12 · 5.000 | — | Thức ăn gà, Thức ăn bò, Cám heo, Cám cừu |
| Lò bánh | `bakery` (1) | L5 · 100 | L18 · 7.000 | — | Bánh mì, Bánh nho, Bánh dâu, Bánh mì ngô, Bánh Quế (Waffle) |
| Xưởng sữa | `milk_factory` (4) | L10 · 400 | L24 · 9.000 | — | Bơ, Phô mai, Kem sữa, Sữa Chua Dâu Tây |
| Bếp nướng | `grill` (2) | L15 · 1.800 | L30 · 12.000 | — | Khoai Tây Chiên, Bánh Mì Nướng, Burger |
| Máy Chế Biến Đường | `sugar_processor` (1071) | L20 · 6.000 | L36 · 18.000 | — | Đường Trắng |
| Lò Ngô | `popcorn_factory` (1020) | L25 · 9.000 | L42 · 24.000 | — | Bỏng Ngô, Ngũ Cốc Ngô |
| Tiệm Bánh Pie | `pie_bakery` (1019) | L30 · 14.000 | L48 · 32.000 | — | Bánh Bắp Cải, Bánh Bí Ngô, Pie khoai thịt |
| Bàn đan | `loom` (1021) | L35 · 22.000 | L54 · 44.000 | mốc Thủ công | Áo len |

Tổng xây đủ 16 nhà: **204.500 xu**. Nhà 2 chỉ mua được sau nhà 1 cùng loại; cả hai nhà làm cùng các công thức.

## Hàng chờ và khay nhận

| Thông số | Giá trị (mọi loại máy) |
| --- | --- |
| Hàng chờ khởi đầu | 1 việc |
| Hàng chờ tối đa | 5 việc (tính cả việc đang làm) |
| Khay nhận | 5 mẻ |
| Số nhà mỗi loại | 2 |

**Giá và level mở ô hàng chờ** (mỗi nhà mở riêng; nhà 2 dùng cùng bảng):

| Nhà máy | Ô 2 | Ô 3 | Ô 4 | Ô 5 | Tổng 1 nhà |
| --- | ---: | ---: | ---: | ---: | ---: |
| Máy thức ăn | 60 · L5 | 120 · L10 | 200 · L15 | 320 · L20 | 700 |
| Lò bánh | 60 · L1 | 120 · L1 | 200 · L1 | 320 · L1 | 700 |
| Xưởng sữa | 60 · L1 | 120 · L1 | 200 · L1 | 320 · L1 | 700 |
| Bếp nướng | 60 · L1 | 120 · L1 | 200 · L1 | 320 · L1 | 700 |
| Máy Chế Biến Đường | 60 · L1 | 120 · L1 | 200 · L1 | 320 · L1 | 700 |
| Lò Ngô | 60 · L1 | 120 · L1 | 200 · L1 | 320 · L1 | 700 |
| Tiệm Bánh Pie | 60 · L1 | 120 · L1 | 200 · L1 | 320 · L1 | 700 |
| Bàn đan | 60 · L1 | 120 · L1 | 200 · L1 | 320 · L1 | 700 |

Mở đủ hàng chờ cho cả 16 nhà: **11.200 xu**. Ô hàng chờ không thể mở trước khi có nhà, nên level thực tế của ô là level lớn hơn giữa level ô và level nhà.

## Luật

- **Xếp món:** trừ nguyên liệu ngay, việc vào hàng chờ. Máy làm lần lượt từng việc.
- "Hàng chờ 1" nghĩa là chỉ làm được 1 việc tại một thời điểm, không có chỗ chờ; mở ô 2–5 để xếp sẵn thêm việc.
- **Khay nhận:** việc xong nằm trong khay. Khay đầy (5 mẻ) thì máy **dừng**, việc đang chờ không chạy tiếp cho tới khi nhận hàng.
- **Nhận hàng:** giao diện nhận hết khay một lần, cộng thành phẩm vào kho và EXP của từng mẻ.
- **Hủy:** chỉ hủy được việc đang chờ (chưa bắt đầu), hoàn đủ nguyên liệu. Việc đang làm không hủy được.
- **Làm xong ngay:** khi khay trống mà máy đang làm, nút "Nhận hàng" đổi thành "Xong ngay" kèm giá kim cương. Bấm là món đang làm xong ngay và vào khay, món chờ kế tiếp bắt đầu luôn; thành phẩm và EXP vẫn nhận khi lấy từ khay. Giá: cứ 1 phút còn lại của món đang làm tốn 1 kim cương, làm tròn lên (xem [09](09-kim-cuong-xu.md#giá-làm-xong-ngay)). Khay còn hàng thì phải nhận hàng trước.
- Nguyên liệu, thành phẩm, EXP và thời gian **chốt lúc xếp**.

## Chỉnh ở đâu

| Chỉ số | File | Khóa |
| --- | --- | --- |
| Giá và level nhà 1, nhà 2 | economy.json | `machines.<máy>.sites[0]`, `sites[1]` |
| Giá và level ô hàng chờ 2–5 | economy.json | `machines.<máy>.queueSlots` |
| Số nhà tối đa, hàng chờ khởi đầu/tối đa, khay | gameplay.json | `machines.<máy>.maxBuildings`, `startingCapacity`, `maxQueueCapacity`, `trayCapacity` |
| Máy cần mốc nào | catalog.json | `machineTypes[].unlock` |

Giới hạn cứng trong code: tối đa 2 nhà mỗi loại, hàng chờ tối đa 5, khay tối đa 5; JSON chỉ hạ được, không tăng được.
