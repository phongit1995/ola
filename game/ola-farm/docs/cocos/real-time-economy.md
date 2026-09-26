# Tiến trình theo thời gian thực

> **Số liệu hiện hành đã kiểm chứng nằm ở [Chỉ số game](../chi-so/README.md).** Tài liệu này giữ phần giải thích và lịch sử thiết kế; nếu con số ở đây lệch với `docs/chi-so/` hoặc file JSON thì lấy `docs/chi-so/` và JSON làm chuẩn.

Bộ cân bằng `town-real-time-1` áp dụng cho bản Cocos `simple-1`. [Bảng cây, vật nuôi, công thức và giá nhà](farm-town-husbandry-balance.md) là nơi tra cứu giá hiện hành. Tài liệu này mô tả đồng hồ và cách đo tiến trình theo cấu hình hiện hành. Số ngày/năm hoàn thành ước tính bằng mô phỏng ngày 25/09/2026 nằm ở [chi-so/02](../chi-so/02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính).

Thời gian hiện được tách vào [timing.json](../../assets/farm/bundles/farm-town/timing.json), được game và mô phỏng cùng đọc. Giá/level/ví/XP và trạng thái ruộng nằm trong [economy.json](../../assets/farm/bundles/farm-town/economy.json); xem [cách chỉnh](economy-config.md). [Hướng dẫn chỉnh, tải lại và giữ timer cũ](timing-config.md). Cần chạy lại mô phỏng khi đổi thời gian hoặc mốc xây.

## Thay đổi và mục tiêu

Cây mất 5 phút–12 giờ, lượt nuôi 30 phút–12 giờ, mẻ máy 5 phút–6 giờ. Lúa mì/ngô cùng mở ở level 1; các cây còn lại ở 4/7/10/14/18/24. Nhà đầu tiên mở theo các nhóm level 1/5/10/15/20/25/30/35; nhà thứ hai từ level 12 đến 54. Lượt mới có 500 xu, 10 kim cương, 6 ruộng mở sẵn và chưa có máy/chuồng. 34 ruộng còn lại mua dần tại các level chẵn 2–68 theo [bảng giá đất](land-purchase.md). Level 1 chỉ cho mua máy thức ăn và chuồng gà; nguyên liệu và công thức cám gà dùng được ngay. Xem [toàn bộ mốc xây](economy-config.md). Lên level không tự cấp công trình hoặc ruộng; các lần mua vẫn kiểm tiền và mốc sản phẩm.

Mục tiêu là cho phép gieo/đặt mẻ rồi quay lại sau, kéo dài việc hoàn thiện trang trại theo yêu cầu chơi lâu hơn. Cây dài giờ cho lãi mỗi lần thu cao hơn, cây ngắn giờ cho lãi theo giờ cao hơn nếu chăm liên tục. Việc kéo dài mốc tối đa chưa chứng minh game có đủ nội dung hấp dẫn trong nhiều năm.

## XP và các mốc

Tổng XP được giữ trong save, level được tính lại. XP lên cấp L → L+1:

```text
15 + 12 × (L − 1) + 80 × max(0, L − 10)²
```

Đường này thay đường cũ `80 + 50 × (L − 1) + 400 × max(0, L − 10)²` từ ngày 25/09/2026, để người chơi đều tay mua hết trong khoảng 3–4 năm. Không nhận XP khi gieo hoặc gieo rồi đào bỏ. XP thu hoạch và XP mỗi mẻ máy nằm trong `economy.json` (`crops.<cây>.harvestXP`, `recipes.<ID>.xp`); sản phẩm vật nuôi cho XP theo loài (`animals.<loài>.xp`); xây nhà máy, chuồng, mở ô chuồng, ô hàng chờ và mua ruộng cho XP một lần lúc trả tiền (`experience.buildXP`); mỗi level mới thưởng kim cương (`experience.levelUpDiamonds`). Bán hàng nhận một XP mỗi 100 xu doanh thu cộng dồn, giữ phần lẻ qua các giao dịch và tải lại.

| Level | Tổng XP cần đạt | Mốc đáng chú ý |
| ---: | ---: | --- |
| 1 | 0 | Máy thức ăn, chuồng gà, lúa mì/ngô và cám gà |
| 5 | 132 | Lò bánh |
| 10 | 567 | Chuồng bò, xưởng sữa và cám bò |
| 15 | 3.702 | Chuồng heo, bếp nướng và cám heo |
| 20 | 25.137 | Máy đường và bánh quế |
| 25 | 84.872 | Lò ngô |
| 30 | 202.907 | Lò pie |
| 35 | 399.242 | Chuồng cừu, bàn đan và cám cừu: đủ loại công trình |
| 54 | 2.212.051 | Chuồng cừu/bàn đan thứ hai: level cao nhất cần để mua mọi nhà |
| 68 | 5.096.737 | Mở quyền mua ruộng cuối cùng |

Mốc trên là điều kiện level; mua nhà vẫn cần tiền, nhà trước, vị trí và sản phẩm đã nhận tương ứng. Level HUD tối đa là 99; mua đủ nhà cần level 54, mua đủ đất cần level 68. “Mở tối đa” trong mô phỏng nghĩa là **40 ruộng đã mua, 16 máy × 5 ô hàng đợi và tám chuồng × 5 con**, không phải đạt level 99 hoặc đã làm đủ 23 món.

## Đồng hồ, offline và bản lưu

- Bản hiện hành chỉ chạy 1×; menu bỏ lựa chọn 6×/12×. Đồng hồ dùng thời gian thực của thiết bị, bao gồm khoảng ứng dụng đóng/ẩn. Thao tác mới được gắn với thời điểm thực của thao tác.
- Offline chỉ xử lý cây đã gieo, con đã cho ăn và mẻ đã trả nguyên liệu. Cây/con chờ nhận; máy dừng khi khay đầy. Không tự gieo, cho ăn, đặt mẻ, bán hay nhận thưởng.
- Từ 26/09/2026, giống Hay Day: menu và chế độ di chuyển công trình **không dừng đồng hồ**. Chúng chỉ chặn các action khác (`canAct` = false, toast "Đang mở Menu." hoặc "Đang sắp xếp công trình."); cây, vật nuôi và máy vẫn chạy, bản lưu luôn ghi `clock.running = true` nên thoát game lúc đang mở menu vẫn được cộng offline. Chế độ thời gian thực bỏ phím Space tạm dừng. Chỉ lỗi lưu mới dừng đồng hồ. Save cũ ghi `running = false` lúc còn luật tạm dừng: lần mở đầu không cộng khoảng offline đó.
- Pack v6/state v7/layout v6 được giữ, thêm trường tùy chọn `clock: { version: 1, savedAt, running }`. Save cũ chưa có clock bắt đầu tính từ lúc mở bằng bản mới; không đoán thời gian đã đóng trước đó.
- Job đã trả tiền giữ thời gian, đầu ra và XP trong snapshot cũ. Ví, kho, ID, ô và công trình đã mua được giữ; các lượt trồng/nuôi/chế biến hoặc mua tiếp dùng luật mới. Giá bán kho chuyển sang catalog mới. XP cũ không bị xóa, nhưng level tính từ đường cong mới có thể thấp hơn; cây trồng lần tiếp theo theo khóa level mới.
- Offline được tính trên bản sao, lưu thành công rồi mới công bố. Lỗi ghi giữ trạng thái đang thấy và `pendingPack`; thử lại áp dụng một lần, bỏ khoảng chờ do lỗi lưu. Import giữ nguồn nguyên bản và xác thực clock trước khi ghi.
- Đồng hồ lùi không nhận thời gian âm hoặc tính trùng. Đây là game lưu cục bộ, không có đồng hồ máy chủ/chống sửa save; số năm không phải rào cản lịch chống gian lận.

## Chạy mô phỏng cấu hình hiện hành

Từ gốc repo:

```sh
npm run simulate:balance --prefix game/ola-farm
```

[Công cụ mô phỏng](../../tools/simulate-real-time-economy.ts) dùng trực tiếp `FarmGame` và năm JSON cấu hình qua `loadFarmCatalog`. Nó bắt đầu từ save mới, không cấp thêm xu/XP/hàng và không dùng kim cương. Báo cáo mặc định ở `artifacts/real-time-economy/simulation.json` (không commit); `REAL_TIME_SIM_OUTPUT` đổi đường dẫn. Alias `simulate-town-husbandry.ts` và biến `TOWN_HUSBANDRY_SIM_OUTPUT` vẫn được hỗ trợ.

Người chơi giả lập giữ vốn hạt, chọn cây có lãi mỗi lần thu cao nhất vừa khoảng vắng mặt, làm sáu công thức cám/burger cố định để mở loài, rồi mua đất, nhà và ô. Đàn mua thêm không chạy sản xuất liên tục sau khi mở mốc. Giả định gieo 2 giây/ô, thu 1 giây/ô, thao tác khác 2–5 giây và tính cả thời gian chờ trong mỗi phiên.

Công cụ thử ba lịch: 7h/15h/23h × 10 phút, 7h/19h × 15 phút và 7h/11h/15h/19h/23h × 12 phút. Mỗi lịch có hai cách chọn cây: chín trước khi quay lại, hoặc chín trong phiên kế tiếp. Hai phép thử thêm dùng lúa mì liên tục trong phiên 8 giờ/ngày và giả lập 24/24. Mỗi lượt giới hạn 3.000 ngày mô phỏng.

Báo cáo gồm `completed`, `events`, `finalLevel`, `finalCoins`, `spending`, `seedCosts`, `recipesMade` và `activeHours`. Chỉ khi `completed: true` và có `events.maxed` mới có mốc hoàn tất cho chiến thuật đó; thiếu mốc không được diễn giải là đã hoàn thành tại ngày cuối. `spending` gồm cả giá mua đất. Tool kiểm state và đối chiếu ví cuối với doanh thu, tiền hạt và chi mua; không cộng tài nguyên để vượt khóa.

Mô hình giả định offline không giới hạn, không mô phỏng `maxOfflineSeconds` hay tắt offline. Chiến thuật cám/burger cố định không tự tìm đường khi thay recipe/gate/feed. Thời gian thao tác là giả định; các lịch chưa tối ưu mọi chuỗi sản xuất và không dự báo khả năng giữ người chơi. Cần lưu ngày chạy và bộ cấu hình cùng báo cáo nếu dùng để quyết định cân bằng.

Các bảng ngày/năm và kết luận kinh tế từ bản cấp sẵn 40 ruộng/năm công trình đã được bỏ khỏi hướng dẫn hiện hành; có thể tra trong lịch sử Git. Chúng không đại diện cho giá mua 34 ô đất và mốc công trình hiện tại. Kiểm tra luật/UI không chứng minh giá đất phù hợp hoặc người chơi sẽ hoàn thành trong một khoảng năm cụ thể.

## Kiểm chứng bản thay đổi

- `npm run verify --prefix game/ola-farm`: asset/prefab, core typecheck và toàn bộ unit test. `real-time-economy.test.ts` kiểm khóa level, biên thời gian, giá, chống tách sale lấy XP, offline/khay đầy, pause/reload, import, snapshot cũ, đồng hồ lùi và lỗi lưu.
- `npm run typecheck --prefix game/ola-farm`: cả lớp Cocos/UI, cần Creator tạo `temp/tsconfig.cocos.json`.
- Build Web Mobile theo [README](../../README.md), rồi chạy `node game/ola-farm/tests/construction-reset.browser.cjs` và `node game/ola-farm/tests/starter-slot-levels.browser.cjs`: kiểm mua công trình, chơi lại, khóa level và mua ô gà/máy thức ăn tại 393×585 và 1280×720. Các ngưỡng XP được đặt trong context kiểm thử; thao tác mua và chơi lại đi qua UI thật. Đây là kiểm luật/UI, không phải chờ thời gian thật nhiều năm.

Các browser test lịch sử, gồm `real-time-economy.browser.cjs`, còn hard-code giá, level hoặc 6×/12× cần cập nhật trước khi dùng làm nghiệm thu cân bằng mới. Android/iOS trên thiết bị thật chưa được nghiệm thu trong đợt này.
