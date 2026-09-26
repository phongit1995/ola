# Mua đất theo level

> **Số liệu hiện hành đã kiểm chứng nằm ở [Chỉ số game](../chi-so/README.md).** Tài liệu này giữ phần giải thích và lịch sử thiết kế; nếu con số ở đây lệch với `docs/chi-so/` hoặc file JSON thì lấy `docs/chi-so/` và JSON làm chuẩn.

Game bắt đầu với **6 ô được cấp sẵn**, mua thêm tuần tự để đạt 40 ô. Tài liệu này mô tả cấu hình và luồng đã triển khai. Bảng giá được đặt lại và đo bằng mô phỏng ngày 25/09/2026.

## Luật hiện hành

- Level 1 được cấp sẵn ô 1–6, đất cấp 1, chưa trồng cây.
- Các level **2, 4, 6, …, 68** lần lượt cho phép mua ô 7–40. Level lẻ không thêm ô được phép mua.
- Đạt level chỉ mở quyền mua; vẫn phải trả đủ xu. Ô chưa mua được giữ lại để mua sau, không mất khi lên level.
- Mỗi giao dịch chỉ mở một ô. Đất đã mua được giữ vĩnh viễn, không thu phí duy trì.
- Map chỉ hiện những ô đã sở hữu và một ô xanh kế tiếp, dùng prefab `Soil0` hiện có. Chạm ô xanh mở `LandPurchase.prefab`: icon khóa và level yêu cầu khi chưa đủ cấp; icon xu, giá mua và nút mua khi đủ cấp. Thiếu xu thì nút mua bị vô hiệu hóa; mua thành công ô đổi thành đất trồng `Soil1` và hiện ô xanh tiếp theo.
- Giới hạn vẫn là 40 ô. Ví khởi đầu (700 xu từ 26/09/2026) và đường cong XP lấy từ economy.json.

## Cơ sở tính giá

Nguồn số liệu: [economy.json](../../assets/farm/bundles/farm-town/economy.json), [timing.json](../../assets/farm/bundles/farm-town/timing.json) và [Progression.ts](../../assets/farm/scripts/core/Progression.ts).

Đợt cân bằng 25/09/2026 hạ đường level (xem [chi-so/02](../chi-so/02-exp-level-mo-khoa.md#công-thức-level)) rồi đặt lại giá đất theo đường mới. Gọi `k` là thứ tự ô mua thêm, từ 1 đến 34; ô trên bản đồ là `k + 6`, level yêu cầu là `2k`.

```text
T(L) = tổng XP để đạt level L từ level 1.
ΔXP(1) = T(2) − T(1).
ΔXP(k) = T(2k) − T(2k − 2), với k ≥ 2.

Sàn(k) = 500, 1.000, 1.500, 2.500, 4.000, 6.000 với k = 1…6;
         6.000 + 2.000 × (k − 6) với k ≥ 7.
Giá thô(k) = max(Sàn(k), 6 × ΔXP(k)).
Giá mua = làm tròn lên theo bậc 100 xu nếu giá thô < 10.000;
          bậc 1.000 xu nếu < 100.000; bậc 10.000 xu từ 100.000 trở lên.
```

- Sáu ô đầu (ô 7–12) lấy giá sàn, rẻ hơn bảng cũ (2.000–12.000 xu) để người mới mua được trong vài ngày đầu.
- Từ ô 13 giá bám **6 xu cho mỗi XP** cần để đi qua hai level (bảng cũ dùng 4 xu trên đường level cũ, dốc hơn nhiều).
- Tổng mua thêm 34 ô: **30.712.600 xu** (bảng cũ 102.021.000 xu). Giá từng ô và công thức đã kiểm chứng: [chi-so/04](../chi-so/04-ruong.md#bảng-40-ruộng). Giá cố định trong cấu hình; đổi đường level mà không tính lại bảng thì giá không tự đổi theo.

## Kết quả mô phỏng và giới hạn

- Mô phỏng chạy đúng `FarmGame` (xem [chi-so/02](../chi-so/02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính)): người chơi 3 lần/ngày mua hết 40 ô sau khoảng 4 năm, người chơi 6 lần/ngày khoảng 3 năm; mỗi ô thường được mua sau khi đủ level từ vài ngày (đầu game) tới vài tuần (cuối game), nên xu vẫn là thứ phải để dành. Với bảng cũ, cùng cách mô phỏng cho thấy khoảng 22 năm và người chơi ôm hàng chục triệu xu không có gì để mua.
- Đất cuối game là mục tiêu mở rộng lâu dài, không phải khoản đầu tư tự hoàn vốn: ô 40 giá 3.080.000 xu, trồng nho với người chơi 3 lần/ngày lãi khoảng 345 xu/ngày, tự hoàn vốn mất khoảng 24 năm. Giá đất chủ yếu là chỗ tiêu xu tích lũy trong quá trình lên level.

## Cấu hình, save và kiểm tra

**Chỉnh UI trong Cocos:** mở `assets/farm/prefabs/ui/LandPurchase.prefab`, bung `LandCard`. Các node `Frame`, `Paper`, `NewGreenLand`, `LandLock`, `LandCoin`, `LandOffer`, `LandRequirement`, `LandWallet`, `confirm`, `cancel-confirm`, `close-panel` chứa artwork, chữ và nút thực. Có thể đổi vị trí, kích thước, font, màu và sprite trực tiếp. Component `LandPurchaseView` trên root giữ liên kết Inspector và các tùy chọn `maxScreenWidth`/`screenMargin`. Runtime chỉ đổi nội dung dữ liệu, bật/tắt trạng thái và scale cả thẻ để vừa màn hình; không dựng lại hoặc ghi đè vị trí từng node.

Prefab được liên kết tại Canvas → `UiPrefabs.landPurchase` trong `Farm.scene`. Tool `node game/ola-farm/tools/build-land-purchase.cjs` giữ nguyên prefab đã có; thêm `--reset` mới tạo lại bố cục mặc định và ghi đè chỉnh sửa Editor. Không chạy reset trong quy trình build thường.

Trong `economy.json`, ô 1–6 mở sẵn; ô 7–40 khóa và dùng `requiredLevel`/`unlockPrice` đúng bảng. ID cấu hình của ô 1–12 là 0–11, ô 13–40 là 22–49. UI hiển thị thứ tự ô 1–40, bỏ qua khoảng ID chuồng 12–21.

Save hiện có giữ toàn bộ đất đã sở hữu, cây, tiền và XP; `initiallyUnlocked` chỉ áp dụng khi chơi mới. Nếu save có các ô sở hữu không liền nhau, game tiếp tục đề nghị ô khóa đầu tiên theo thứ tự. Save đã mở đủ 40 ô không hiện thêm ô xanh.

- [land-purchase.test.ts](../../tests/land-purchase.test.ts): bảng giá đầy đủ, các biên level, thiếu xu, mua vượt thứ tự, mua lặp, save cũ và lưu lỗi/thử lại không trừ hai lần.
- [land-map.test.ts](../../tests/land-map.test.ts): một ô xanh kế tiếp, trạng thái trước/sau mua, ô đã sở hữu không liền nhau và hết ô để mua.
- [land-purchase.browser.cjs](../../tests/land-purchase.browser.cjs): click map và nút mua thật, icon/level/giá, cập nhật UI đang mở, đất xanh chuyển sang ô tiếp theo, gieo hạt và tải lại. Chạy trên bản build mới; báo cáo/ảnh trong `artifacts/land-purchase/`.

```sh
npm run verify --prefix game/ola-farm
npm run typecheck --prefix game/ola-farm
node game/ola-farm/tests/land-purchase.browser.cjs
```

Mô phỏng thời gian chơi dài hạn là bước đánh giá cân bằng riêng; các kiểm thử mua đất không chứng minh thời gian hoàn thành hoặc mức giá phù hợp để phát hành.
