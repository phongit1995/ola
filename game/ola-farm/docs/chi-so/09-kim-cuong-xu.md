# 09. Kim cương, xu, tăng tốc, hoàn tiền

> Nguồn: [economy.json](../../assets/farm/bundles/farm-town/economy.json) (`startingWallet`, `experience.levelUpDiamonds`, `coinPacks`, `gemPacks`, `refunds`), [timing.json](../../assets/farm/bundles/farm-town/timing.json) (`boostSecondsPerGem`), [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json) (`rescueEnabled`), [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts), [FarmTiming.ts](../../assets/farm/scripts/core/FarmTiming.ts) (`boostGems`). Đối chiếu ngày 25/09/2026.

## Ví khởi đầu

| Chỉ số | Khởi đầu |
| --- | ---: |
| Xu | 700 |
| Kim cương | 10 |
| EXP | 0 |

## Kim cương

- **Nguồn:** 10 viên lúc bắt đầu và **+2 viên mỗi level mới** (xem [02](02-exp-level-mo-khoa.md#thưởng-khi-lên-level)). Tới level 68 có tổng 144 viên nếu chưa tiêu. Chưa có nhiệm vụ; chưa mua hay đổi KEN được.
- **Dùng vào:** làm xong ngay cây, sản phẩm vật nuôi, món đang làm trong nhà máy; đổi lấy xu.

### Đổi kim cương lấy xu

| Gói | Kim cương | Nhận xu | Xu mỗi kim cương |
| --- | ---: | ---: | ---: |
| 1 | 5 | 250 | 50 |
| 2 | 10 | 550 | 55 |
| 3 | 20 | 1.200 | 60 |

Đổi xu không cho EXP và không tính vào doanh thu bán hàng. Tính theo xu thì đổi kim cương lấy xu luôn lợi hơn boost: 1 kim cương đổi được 50–60 xu, còn boost 1 kim cương chỉ bớt được 1 phút chờ (ví dụ lúa mì vừa gieo tốn 5 kim cương để lấy sớm một lứa lãi 4 xu). Boost là để có hàng ngay, không phải để kiếm xu; xem C5 ở [12](12-diem-can-chot.md).

### Gói kim cương (chỉ hiển thị)

| Gói | Kim cương | Giá hiển thị |
| --- | ---: | ---: |
| 1 | 20 | 0,99 $ |
| 2 | 120 | 4,99 $ |
| 3 | 300 | 9,99 $ |

**Chưa bán được:** bấm vào chỉ hiện thông báo "Cửa hàng kim cương sẽ mở ở bản sau". Không có thanh toán thật.

## Giá làm xong ngay

Làm xong ngay (boost) là trả kim cương để một việc xong ngay lập tức: cây chín, con vật có sản phẩm, hoặc món đang làm trong máy xong và vào khay. Giá tính theo **thời gian còn lại lúc bấm**, không theo tổng thời gian của việc.

### Cách tính

```text
Kim cương = làm tròn lên(thời gian còn lại / 60 giây)
```

Nghĩa là **cứ 1 phút còn lại tốn 1 kim cương**; phần lẻ tính tròn lên (còn 1 giây cũng tốn 1 kim cương, còn 4 phút 30 giây tốn 5). Cùng một cách tính cho cây, vật nuôi (tính từng con) và nhà máy (món đang làm). Boost không cho EXP; thành phẩm và EXP vẫn nhận như thường khi thu hoạch, thu sản phẩm hoặc nhận hàng.

### Ví dụ

| Việc | Lúc bấm | Còn lại | Kim cương |
| --- | --- | ---: | ---: |
| Nho (12 giờ) | vừa gieo | 12 giờ | 720 |
| Nho (12 giờ) | sau 4 giờ | 8 giờ | 480 |
| Nho (12 giờ) | sau 4 giờ 1 phút | 7 giờ 59 phút | 479 |
| Nho (12 giờ) | sau 10 giờ | 2 giờ | 120 |
| Nho (12 giờ) | sau 11 giờ 57 phút | 3 phút | 3 |
| Gà đẻ trứng (30 phút) | vừa cho ăn | 30 phút | 30 |
| Gà đẻ trứng (30 phút) | sau 15 phút | 15 phút | 15 |
| Gà đẻ trứng (30 phút) | sau 20 phút | 10 phút | 10 |
| Gà đẻ trứng (30 phút) | sau 25 phút | 5 phút | 5 |
| Bánh mì (10 phút) | vừa bắt đầu làm | 10 phút | 10 |
| Bánh mì (10 phút) | sau 5 phút | 5 phút | 5 |

Với nhà máy: Lò bánh đang làm bánh mì và còn 1 bánh mì nữa trong hàng chờ. Bấm "Xong ngay" lúc còn 5 phút tốn 5 kim cương; bánh đầu vào khay, bánh sau bắt đầu ngay nên nút lại hiện 10 kim cương.

### Lưu ý cân bằng

- **Việc dài rất đắt:** nho 12 giờ vừa gieo tốn 720 kim cương, cừu vừa ăn cũng 720.
- **Kim cương còn ít:** chỉ có 10 viên lúc đầu và +2 mỗi level mới. Người chơi 3 lần/ngày lên level 20 sau khoảng 26 ngày, lúc đó có 48 kim cương nếu chưa tiêu: đủ làm xong ngay tổng cộng 48 phút, ví dụ 9 lần lúa mì vừa gieo hoặc 3 lần ngô vừa gieo. Boost vì vậy chủ yếu dùng cho mấy phút cuối của một việc, hoặc sau này khi đổi KEN lấy kim cương.
- **Muốn rẻ hơn** thì tăng `boostSecondsPerGem`: 300 (5 phút một kim cương) thì nho còn 144; 900 (15 phút một kim cương, như trước 25/09/2026) thì nho còn 48.

### Ở đâu trong game

- **Cây:** chạm cây đang lớn, bong bóng hiện nút giá kim cương (cạnh nút hủy). Cây chín ngay, vẫn phải bấm thu hoạch.
- **Vật nuôi:** mở chuồng, con đang ăn có nút giá kim cương dưới hình. Sản phẩm sẵn sàng ngay, vẫn phải bấm thu.
- **Nhà máy:** mở máy; khi khay trống mà máy đang làm, nút "Nhận hàng" đổi thành "Xong ngay · N kim cương". Khay còn hàng thì phải nhận hàng trước. Xem [06](06-nha-may.md#luật).
- Mỗi lần bấm chỉ boost một việc; không có boost cả hàng chờ hay cả ruộng một lần.

### Giá nếu làm xong ngay từ đầu

| Việc | Thời gian đủ | Kim cương nếu làm ngay từ đầu |
| --- | ---: | ---: |
| Lúa mì | 5 phút | 5 |
| Ngô | 15 phút | 15 |
| Bắp cải | 45 phút | 45 |
| Củ Cải Đường | 2 giờ | 120 |
| Khoai Tây | 4 giờ | 240 |
| Dâu tây | 6 giờ | 360 |
| Bí Ngô | 8 giờ | 480 |
| Nho | 12 giờ | 720 |
| Gà đẻ trứng (1 con) | 30 phút | 30 |
| Bò sữa (1 con) | 2 giờ | 120 |
| Heo (1 con) | 6 giờ | 360 |
| Cừu (1 con) | 12 giờ | 720 |
| Thức ăn gà (1 mẻ) | 5 phút | 5 |
| Thức ăn bò (1 mẻ) | 15 phút | 15 |
| Cám heo (1 mẻ) | 30 phút | 30 |
| Cám cừu (1 mẻ) | 1 giờ | 60 |
| Bánh mì (1 mẻ) | 10 phút | 10 |
| Bánh mì ngô (1 mẻ) | 45 phút | 45 |
| Bánh dâu (1 mẻ) | 1 giờ 30 phút | 90 |
| Bánh Quế (Waffle) (1 mẻ) | 3 giờ | 180 |
| Bánh nho (1 mẻ) | 2 giờ | 120 |
| Bơ (1 mẻ) | 30 phút | 30 |
| Phô mai (1 mẻ) | 1 giờ | 60 |
| Kem sữa (1 mẻ) | 20 phút | 20 |
| Sữa Chua Dâu Tây (1 mẻ) | 2 giờ | 120 |
| Khoai Tây Chiên (1 mẻ) | 1 giờ 30 phút | 90 |
| Bánh Mì Nướng (1 mẻ) | 1 giờ | 60 |
| Burger (1 mẻ) | 3 giờ | 180 |
| Đường Trắng (1 mẻ) | 30 phút | 30 |
| Bỏng Ngô (1 mẻ) | 2 giờ | 120 |
| Ngũ Cốc Ngô (1 mẻ) | 1 giờ 30 phút | 90 |
| Bánh Bắp Cải (1 mẻ) | 2 giờ | 120 |
| Pie khoai thịt (1 mẻ) | 4 giờ | 240 |
| Bánh Bí Ngô (1 mẻ) | 3 giờ | 180 |
| Áo len (1 mẻ) | 6 giờ | 360 |

### Chỉnh giá

- Sửa `boostSecondsPerGem` trong [timing.json](../../assets/farm/bundles/farm-town/timing.json) (hiện `60`): số giây còn lại ứng với 1 kim cương. 60 là 1 phút một kim cương, 300 là 5 phút, 900 là 15 phút. Phải là số lớn hơn 0.
- Đổi là áp dụng ngay, kể cả việc đang chạy (giá không chốt lúc gieo, cho ăn hay xếp món).
- Code tính giá: hàm `boostGems` trong [FarmTiming.ts](../../assets/farm/scripts/core/FarmTiming.ts); cây, vật nuôi và nhà máy đều gọi hàm này.

## Hoàn tiền

| Trường hợp | Hoàn | Ghi chú |
| --- | --- | --- |
| Hủy cây đang lớn | 30% giá hạt, làm tròn xuống | bảng từng cây ở [03](03-cay-trong.md#làm-chín-ngay-và-hủy) |
| Hủy món đang chờ trong máy | 100% nguyên liệu | chỉ việc chưa bắt đầu |
| Bán con vật | 50% giá con, làm tròn xuống | giao diện chưa có nút |

## Lúa cứu trợ

Bật/tắt bằng `rescueEnabled` (hiện: `true`). Người chơi được gieo **miễn phí 1 ô lúa mì** khi đồng thời:
- số xu nhỏ hơn giá hạt rẻ nhất đang mở;
- kho trống hoàn toàn;
- không có cây đang lớn, không có con đang ăn, không máy nào có việc đang làm, đang chờ hay chờ nhận;
- còn ít nhất 1 ruộng trống.

Lúa cứu trợ không cho EXP khi gieo và khi thu, hủy không hoàn tiền. Thu được 3 lúa mì bán được 24 xu, đủ gieo tiếp. Dùng để không bao giờ kẹt vốn hoàn toàn.

## Chỉnh ở đâu

| Chỉ số | File | Khóa |
| --- | --- | --- |
| Ví khởi đầu | economy.json | `startingWallet` |
| Thưởng kim cương mỗi level mới | economy.json | `experience.levelUpDiamonds` |
| Gói đổi xu | economy.json | `coinPacks` |
| Gói kim cương hiển thị | economy.json | `gemPacks` |
| Số giây cho mỗi kim cương khi làm xong ngay | timing.json | `boostSecondsPerGem` |
| Tỷ lệ hoàn | economy.json | `refunds.cropCancelRate`, `refunds.animalSaleRate` |
| Lúa cứu trợ | gameplay.json | `rescueEnabled` |
