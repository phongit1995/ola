# 01. Tổng quan và khởi đầu

> Nguồn: [economy.json](../../assets/farm/bundles/farm-town/economy.json), [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json), [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts), [FreshFarm.ts](../../assets/farm/scripts/core/FreshFarm.ts). Đối chiếu ngày 25/09/2026.

## Vòng chơi

Gieo hạt trên ruộng → thu hoạch → làm thức ăn ở **Máy thức ăn** → cho vật nuôi ăn → thu trứng, sữa, thịt xông khói, len → chế biến ở các nhà máy → **bán trong kho lấy xu** → dùng xu mua hạt, xây nhà máy, xây chuồng, mở rộng và mua thêm ruộng.

- **Nguồn xu duy nhất do chơi mà có là bán hàng trong kho.** Ngoài ra chỉ có đổi kim cương lấy xu và tiền hoàn khi hủy cây.
- Không có đơn hàng, nhiệm vụ, thành tích, ao cá. Đơn hàng đã chốt không làm (26/09/2026, xem [12](12-diem-can-chot.md#đã-chốt-đợt-26092026)). Kim cương chỉ có thêm khi lên level (+2 mỗi level mới).
- Kho **không giới hạn sức chứa**.

## Ba chỉ số của người chơi

| Chỉ số | Khởi đầu | Tăng khi | Giảm khi |
| --- | ---: | --- | --- |
| Xu | 500 | Bán hàng; đổi kim cương lấy xu; hủy cây đang lớn (hoàn 30% tiền hạt) | Mua hạt, xây nhà máy, xây chuồng, mở ô chuồng (kèm con), mua con, mở ô hàng chờ, mở ruộng |
| Kim cương | 10 | Lên level: +2 cho mỗi level mới | Làm xong ngay (cây, vật nuôi, món trong nhà máy); đổi lấy xu |
| EXP | 0 | Thu hoạch, thu sản phẩm vật nuôi, nhận thành phẩm từ máy, bán hàng; xây nhà máy, chuồng, mở ô chuồng, ô hàng chờ, mua ruộng | Không bao giờ giảm |

Level không lưu riêng mà tính lại từ tổng EXP mỗi lần, xem [02](02-exp-level-mo-khoa.md).

## Trạng thái khởi đầu

- 700 xu, 10 kim cương, 0 EXP (level 1).
- 6 ruộng mở sẵn (Ruộng 1 đến Ruộng 6), chưa gieo gì. 34 ruộng còn lại mua dần theo level, xem [04](04-ruong.md).
- Kho có sẵn **4 Lúa mì + 2 Ngô**, đủ làm 2 mẻ Thức ăn gà ngay khi xây xong Máy thức ăn (`gameplay.json` `startingInventory`). Chưa có nhà máy, chưa có chuồng.
- Bảng chào mừng hiện khi mới vào (`showWelcome: true`).
- Ở level 1 xây được **Máy thức ăn 1** (200) và **Chuồng gà 1 kèm 1 con** (100 + 120 = 220), tổng 420, còn 280 xu đủ gieo cả 6 ruộng. Hai công trình này cho 20 + 15 = 35 EXP, đủ lên level 2 ngay (+2 kim cương).
- Level 3 mở ô chuồng gà thứ 2, level 9 mở ô thứ 3, để các level đầu level nào cũng có thứ mới (trước 26/09/2026 level 3 và 9 không mở gì).

## Giới hạn

| Hạng mục | Tối đa | Ghi chú |
| --- | ---: | --- |
| Ruộng | 40 | 6 mở sẵn + 34 mua theo level |
| Nhà máy | 16 | 8 loại × 2 nhà; nhà 2 chỉ mua sau nhà 1 |
| Chuồng | 8 | 4 loài × 2 chuồng; chuồng 2 chỉ mua sau chuồng 1 |
| Con mỗi chuồng | 5 | tối đa 40 con trên cả trang trại |
| Hàng chờ mỗi nhà máy | 5 | tính cả việc đang làm; khởi đầu 1 |
| Khay nhận mỗi nhà máy | 5 | khay đầy thì máy dừng |
| Level | 99 |  |
| Kho | không giới hạn | không có nâng cấp kho |

Mỗi nhà máy và chuồng chiếm bề ngang bằng **4 ô ruộng** trên bản đồ; muốn xây phải còn chỗ trống, nếu không phải dời công trình khác trước.

## Luật chung

- **Phải có Máy thức ăn** (ít nhất 1 nhà) mới được xây chuồng, mua con hay mở ô chuồng (`requireFeedMill: true`).
- **Xây theo thứ tự:** nhà máy 2 và chuồng 2 chỉ mua được khi đã có nhà/chuồng 1 cùng loại; ruộng mua lần lượt từ Ruộng 7 đến Ruộng 40.
- **Đạt level chỉ mở quyền mua**, vẫn phải trả đủ xu. Thứ chưa mua không mất khi lên level.
- Mọi thao tác thành công được **lưu ngay**. Thời gian chạy theo giờ thực, xem [10](10-thoi-gian-offline-luu.md).

## Các thao tác

| Thao tác | Mã action | Trên giao diện |
| --- | --- | --- |
| Gieo hạt | plant | Có |
| Thu hoạch | harvest | Có |
| Hủy cây đang lớn (hoàn 30% tiền hạt) | cancel | Có |
| Làm chín ngay bằng kim cương | boost | Có |
| Mở ruộng mới | improve | Có |
| Nhận lúa cứu trợ | rescue | Có, chỉ khi hết vốn |
| Đóng bảng chào mừng | dismissGuide | Có |
| Xếp món vào máy | produce | Có |
| Nhận hết khay của một máy | collectAll | Có |
| Nhận từng mẻ | collect | Không (giao diện dùng "nhận hết") |
| Hủy món đang chờ (hoàn đủ nguyên liệu) | cancelQueued | Có |
| Mở thêm ô hàng chờ | expandQueue | Có |
| Làm xong ngay từng món trong máy (đang làm hoặc đang chờ) | boostMachine | Có (nút giá kim cương dưới mỗi ô hàng chờ) |
| Xây nhà máy | buyMachine | Có |
| Bán hàng trong kho | sellItem | Có |
| Xây chuồng (kèm 1 con) | buyPen | Có |
| Mở ô chuồng (kèm 1 con) | expandPen | Có |
| Mua con vào chỗ trống | buyAnimal | Có (chỉ khi chuồng có chỗ trống) |
| Cho vật nuôi ăn | feedAnimals | Có |
| Làm xong ngay sản phẩm vật nuôi | boostAnimal | Có |
| Thu sản phẩm vật nuôi | collectAnimals | Có |
| Đổi kim cương lấy xu | buyCoins | Có |
| Dời công trình | moveBuilding | Có (giữ công trình khoảng 0,45 giây rồi kéo) |
| Bán con vật (hoàn 50% giá con) | sellAnimal | Không có nút |
| Đổi loài trong chuồng | setPenSpecies | Tắt ở bản hiện tại |
