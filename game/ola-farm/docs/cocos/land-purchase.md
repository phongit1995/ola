# Mua đất theo level

Game bắt đầu với **6 ô được cấp sẵn**, mua thêm tuần tự để đạt 40 ô. Tài liệu này mô tả cấu hình và luồng đã triển khai; chưa đo thời gian hoàn thành toàn bộ tiến trình với bảng giá hiện tại.

## Luật hiện hành

- Level 1 được cấp sẵn ô 1–6, đất cấp 1, chưa trồng cây.
- Các level **2, 4, 6, …, 68** lần lượt cho phép mua ô 7–40. Level lẻ không thêm ô được phép mua.
- Đạt level chỉ mở quyền mua; vẫn phải trả đủ xu. Ô chưa mua được giữ lại để mua sau, không mất khi lên level.
- Mỗi giao dịch chỉ mở một ô. Đất đã mua được giữ vĩnh viễn, không thu phí duy trì.
- Map chỉ hiện những ô đã sở hữu và một ô xanh kế tiếp, dùng prefab `Soil0` hiện có. Chạm ô xanh mở `LandPurchase.prefab`: icon khóa và level yêu cầu khi chưa đủ cấp; icon xu, giá mua và nút mua khi đủ cấp. Thiếu xu thì nút mua bị vô hiệu hóa; mua thành công ô đổi thành đất trồng `Soil1` và hiện ô xanh tiếp theo.
- Giới hạn vẫn là 40 ô. Giữ ví khởi đầu 500 xu và đường cong XP hiện tại cho phương án này.

## Cơ sở tính giá

Nguồn số liệu: [economy.json](../../assets/farm/bundles/farm-town/economy.json), [timing.json](../../assets/farm/bundles/farm-town/timing.json) và [Progression.ts](../../assets/farm/scripts/core/Progression.ts).

Ở đất cấp 1, mỗi lượt lúa mì có lãi `3 × 8 − 20 = 4` xu trong 5 phút; ngô lãi `3 × 14 − 30 = 12` xu trong 15 phút; nho lãi `3 × 150 − 220 = 230` xu trong 12 giờ. Các số này đã trừ hạt giống, chưa tính chế biến.

Bán hàng còn cho 1 XP mỗi 100 xu doanh thu. Nếu trồng và bán hết sản phẩm, lãi/XP xấp xỉ 1,79 với lúa mì, 3,51 với ngô và 7,54 với nho; XP bán hàng thực tế cộng dồn phần lẻ. Vì vậy chọn **4 xu cho mỗi XP của khoảng giữa hai mốc mua đất** làm cơ sở giá: tương đương khoảng 114% lãi trồng ngô hoặc 53% lãi trồng nho của cùng lượng XP. Đây là tỷ lệ thiết kế, không phải kết quả mô phỏng toàn bộ kinh tế. Chế biến, chăn nuôi và cách dùng sản phẩm làm thay đổi tỷ lệ.

Gọi `k` là thứ tự ô mua thêm, từ 1 đến 34; ô trên bản đồ là `k + 6`, level yêu cầu là `2k`.

```text
XP cần để lên từ level L sang L+1:
  80 + 50 × (L − 1) + 400 × max(0, L − 10)²

T(L) = tổng XP để đạt level L từ level 1.
ΔXP(1) = T(2) − T(1).
ΔXP(k) = T(2k) − T(2k − 2), với k ≥ 2.

Giá thô(k) = max(2.000 × k, 4 × ΔXP(k)).
Giá mua = làm tròn lên theo bậc 1.000 xu nếu giá thô < 100.000;
          từ 100.000 trở lên làm tròn lên theo bậc 10.000 xu.
```

Mức sàn giữ đất đầu game đắt so với ví khởi đầu. Phần giá theo XP tăng mạnh từ sau level 10, khi đường cong XP hiện tại bắt đầu tăng nhanh. Giá cố định trong bảng đã được ghi vào cấu hình; không tự thay giá theo XP cá nhân của người chơi.

## Bảng giá đầy đủ

Đơn vị giá là xu. Ô 1–6 được cấp miễn phí tại level 1.

| Ô đất | Level được mua | Giá riêng ô này | Tổng xu mua đất đến ô này |
| ---: | ---: | ---: | ---: |
| 7 | 2 | 2.000 | 2.000 |
| 8 | 4 | 4.000 | 6.000 |
| 9 | 6 | 6.000 | 12.000 |
| 10 | 8 | 8.000 | 20.000 |
| 11 | 10 | 10.000 | 30.000 |
| 12 | 12 | 12.000 | 42.000 |
| 13 | 14 | 27.000 | 69.000 |
| 14 | 16 | 72.000 | 141.000 |
| 15 | 18 | 150.000 | 291.000 |
| 16 | 20 | 240.000 | 531.000 |
| 17 | 22 | 370.000 | 901.000 |
| 18 | 24 | 520.000 | 1.421.000 |
| 19 | 26 | 690.000 | 2.111.000 |
| 20 | 28 | 890.000 | 3.001.000 |
| 21 | 30 | 1.110.000 | 4.111.000 |
| 22 | 32 | 1.360.000 | 5.471.000 |
| 23 | 34 | 1.640.000 | 7.111.000 |
| 24 | 36 | 1.940.000 | 9.051.000 |
| 25 | 38 | 2.270.000 | 11.321.000 |
| 26 | 40 | 2.620.000 | 13.941.000 |
| 27 | 42 | 3.000.000 | 16.941.000 |
| 28 | 44 | 3.400.000 | 20.341.000 |
| 29 | 46 | 3.830.000 | 24.171.000 |
| 30 | 48 | 4.290.000 | 28.461.000 |
| 31 | 50 | 4.770.000 | 33.231.000 |
| 32 | 52 | 5.280.000 | 38.511.000 |
| 33 | 54 | 5.810.000 | 44.321.000 |
| 34 | 56 | 6.360.000 | 50.681.000 |
| 35 | 58 | 6.950.000 | 57.631.000 |
| 36 | 60 | 7.560.000 | 65.191.000 |
| 37 | 62 | 8.190.000 | 73.381.000 |
| 38 | 64 | 8.850.000 | 82.231.000 |
| 39 | 66 | 9.540.000 | 91.771.000 |
| 40 | 68 | 10.250.000 | 102.021.000 |

Tổng mua thêm 34 ô: **102.021.000 xu**. Ô cuối mở quyền mua tại level **68**, cần tổng **25.461.910 XP** theo đường cong hiện tại. Đạt level 68 không đảm bảo đã kiếm đủ tiền mua toàn bộ đất.

## Mức độ đắt và giới hạn của phương án

- Ô đầu 2.000 xu bằng bốn lần ví khởi đầu. Với sáu ô lúa mì hoặc ngô, lãi lý thuyết khi trồng liên tục là 288 xu/giờ; riêng khoản giá đất tương đương khoảng **6,9 giờ sản xuất liên tục**. Chưa tính tiền có sẵn, thu nhập máy/con vật, đổi kim cương, thời gian thao tác hoặc thời gian bỏ trống.
- Ví 500 xu đủ gieo sáu ô lúa mì với 120 xu tiền hạt. Nếu mua ngay máy thức ăn 200 xu và chuồng gà kèm con 220 xu thì còn 80 xu, đủ gieo bốn ô trước và tích vốn để gieo thêm hai ô còn lại.
- Đất cuối game là mục tiêu mở rộng lâu dài. Riêng ô 40 trồng nho hai lượt/ngày lãi 460 xu/ngày: hoàn lại giá 10.250.000 xu bằng lợi nhuận của riêng ô mới mất khoảng **22.283 ngày, tức 61 năm** theo phép tính lý thuyết này. Giá này ưu tiên tiêu số xu tích lũy trong quá trình lên level; nó không phù hợp nếu mục tiêu là từng ô đất tự hoàn vốn trong vài tuần hoặc vài tháng.
- XP cũng là rào cản rất lớn. Chưa có mô phỏng lịch chơi cho cấu hình sáu ô và bảng giá này; không dùng kết quả mô phỏng cũ với 40 ô mở sẵn để dự báo thời gian hoàn thành. Cần đo trước khi coi đây là bảng cân bằng phát hành.

## Cấu hình, save và kiểm tra

**Chỉnh UI trong Cocos:** mở `assets/farm/prefabs/ui/LandPurchase.prefab`, bung `LandCard`. Các node `Frame`, `Paper`, `NewGreenLand`, `LandLock`, `LandCoin`, `LandOffer`, `LandRequirement`, `LandWallet`, `confirm`, `cancel-confirm`, `close-panel` chứa artwork, chữ và nút thực. Có thể đổi vị trí, kích thước, font, màu và sprite trực tiếp. Component `LandPurchaseView` trên root giữ liên kết Inspector và các tùy chọn `maxScreenWidth`/`screenMargin`. Runtime chỉ đổi nội dung dữ liệu, bật/tắt trạng thái và scale cả thẻ để vừa màn hình; không dựng lại hoặc ghi đè vị trí từng node.

Prefab được liên kết tại Canvas → `UiPrefabs.landPurchase` trong `Farm.scene`. Tool `node cocos/tools/build-land-purchase.cjs` giữ nguyên prefab đã có; thêm `--reset` mới tạo lại bố cục mặc định và ghi đè chỉnh sửa Editor. Không chạy reset trong quy trình build thường.

Trong `economy.json`, ô 1–6 mở sẵn; ô 7–40 khóa và dùng `requiredLevel`/`unlockPrice` đúng bảng. ID cấu hình của ô 1–12 là 0–11, ô 13–40 là 22–49. UI hiển thị thứ tự ô 1–40, bỏ qua khoảng ID chuồng 12–21.

Save hiện có giữ toàn bộ đất đã sở hữu, cây, tiền và XP; `initiallyUnlocked` chỉ áp dụng khi chơi mới. Nếu save có các ô sở hữu không liền nhau, game tiếp tục đề nghị ô khóa đầu tiên theo thứ tự. Save đã mở đủ 40 ô không hiện thêm ô xanh.

- [land-purchase.test.ts](../../tests/land-purchase.test.ts): bảng giá đầy đủ, các biên level, thiếu xu, mua vượt thứ tự, mua lặp, save cũ và lưu lỗi/thử lại không trừ hai lần.
- [land-map.test.ts](../../tests/land-map.test.ts): một ô xanh kế tiếp, trạng thái trước/sau mua, ô đã sở hữu không liền nhau và hết ô để mua.
- [land-purchase.browser.cjs](../../tests/land-purchase.browser.cjs): click map và nút mua thật, icon/level/giá, cập nhật UI đang mở, đất xanh chuyển sang ô tiếp theo, gieo hạt và tải lại. Chạy trên bản build mới; báo cáo/ảnh trong `artifacts/land-purchase/`.

```sh
npm run verify --prefix cocos
npm run typecheck --prefix cocos
node cocos/tests/land-purchase.browser.cjs
```

Mô phỏng thời gian chơi dài hạn là bước đánh giá cân bằng riêng; các kiểm thử mua đất không chứng minh thời gian hoàn thành hoặc mức giá phù hợp để phát hành.
