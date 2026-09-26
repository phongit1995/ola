# Chỉnh thời gian trồng, nuôi và chế biến

> **Số liệu hiện hành đã kiểm chứng nằm ở [Chỉ số game](../chi-so/README.md).** Tài liệu này giữ phần giải thích và lịch sử thiết kế; nếu con số ở đây lệch với `docs/chi-so/` hoặc file JSON thì lấy `docs/chi-so/` và JSON làm chuẩn.

Chỉnh trực tiếp [timing.json](../../assets/farm/bundles/farm-town/timing.json). Đây là nguồn thời gian duy nhất cho bản Cocos hiện hành; game, kiểm tra asset và mô phỏng cùng đọc file này. Các giá trị mặc định giữ nguyên bộ cân bằng `town-real-time-1`.

## Nội dung file

| Mục | Khóa nhận diện | Giá trị cần sửa |
| --- | --- | --- |
| `crops` | Tên kỹ thuật của cây, ví dụ `wheat`, `corn`, `grapes` | `durationSeconds`: thời gian từ gieo đến chín |
| `animals` | `layer`, `dairy-cow`, `pig`, `sheep` | `durationSeconds`: thời gian từ cho ăn đến có sản phẩm |
| `recipes` | ID công thức, ví dụ `7` là bánh mì | `durationSeconds`: thời gian máy làm một mẻ |
| `boostSecondsPerGem` | Giá trị ở đầu file | Số giây còn lại ứng với 1 kim cương khi làm xong ngay, làm tròn lên; hiện `60` = 1 phút một kim cương. Dùng chung cho cây, vật nuôi và món đang làm trong máy |

Mỗi mục có `name` tiếng Việt để dễ tìm. Tên này chỉ giúp đọc cấu hình; tên hiển thị lấy từ [catalog.json](../../assets/farm/bundles/farm-town/catalog.json); level, giá, XP và ô đất nằm trong [economy.json](../../assets/farm/bundles/farm-town/economy.json). [Hướng dẫn chỉnh giá/ô](economy-config.md). Giữ nguyên khóa nhận diện và `version: 1`.

**Đơn vị là giây**: 5 phút = `300`, 30 phút = `1800`, 2 giờ = `7200`, 12 giờ = `43200`. Giá trị phải là số hữu hạn lớn hơn 0, không viết dạng chuỗi như `"5 phút"`.

Ví dụ muốn lúa mì lớn trong 10 phút, tìm mục `crops.wheat` và đổi duy nhất `durationSeconds` từ `300` thành `600`:

```json
"wheat": {
  "name": "Lúa mì",
  "durationSeconds": 600
}
```

Đây là đoạn nằm trong file, không thay toàn bộ JSON bằng đoạn ví dụ. Tương tự, đổi `animals.layer.durationSeconds` thành `3600` để gà cần một giờ, hoặc `recipes["7"].durationSeconds` thành `1200` để bánh mì cần 20 phút.

## Áp dụng trong game

1. Lưu `timing.json`, chạy từ gốc repo:

   ```sh
   npm run timing:check --prefix game/ola-farm
   ```

2. Trong Creator, chờ import asset xong rồi khởi động lại Preview. Với bản Web Mobile, **build lại** theo [README](../../README.md), chạy `npm start --prefix game/ola-farm` và tải lại trang. Chỉ tải lại bản build cũ sẽ chưa nhận thay đổi ở file nguồn.
3. Gieo cây, cho ăn hoặc xếp mẻ mới để thấy thời gian mới. Không cần xóa save hoặc sửa JavaScript/TypeScript. File được đọc khi khởi động game, không tự tải lại giữa phiên đang mở.

Cây đã gieo, con đã cho ăn và mẻ đã trả nguyên liệu (kể cả mẻ đang chờ) giữ thời gian trong save. Lượt bắt đầu sau khi game tải cấu hình mới dùng thời gian mới. `boostSecondsPerGem` áp dụng ngay cho giá xong ngay, kể cả việc đang chạy (cây, vật nuôi và món đang làm trong máy). Đồng hồ 1× và cách tính offline giữ nguyên.

Game báo rõ tên file và mục nếu thiếu cây/con/công thức, sai khóa hoặc có thời gian không hợp lệ. Không có thời gian dự phòng ẩn trong `catalog.json`; không thêm lại `duration` vào catalog.

## Code và kiểm tra

[Art.ts](../../assets/farm/scripts/render/Art.ts) tải `catalog`, `economy`, `timing`, `gameplay` và `runtime` từ bundle `farm-town`, ghép giá/level bằng `withFarmEconomy` rồi gọi [withFarmTiming](../../assets/farm/scripts/core/FarmTiming.ts) rồi ghép gameplay/runtime để tạo catalog đầy đủ cho luật chơi và UI. Xem [bảng cấu hình đầy đủ](configuration.md). Các công cụ Node dùng [loadFarmCatalog](../../tools/load-farm-catalog.ts), gọi cùng hàm ghép/kiểm tra.

`farm-timing.test.ts` kiểm việc đổi JSON tác động đến công việc mới, giữ timer đã lưu và từ chối cấu hình sai. `timing-config.browser.cjs` kiểm bản build đọc asset JSON thực, rồi thay nội dung asset trong context kiểm thử để xác nhận UI và job dùng thời gian khác mà không sửa luật game. Bộ mặc định được kiểm bằng toàn bộ unit test. `real-time-economy.browser.cjs` là suite lịch sử, cần cập nhật kỳ vọng giá/level trước khi dùng nghiệm thu cấu hình hiện hành.

Sau khi thay đổi thời gian để cân bằng lại, chạy `npm run simulate:balance --prefix game/ola-farm` để đo lại tiến trình. Kết quả các lần mô phỏng cũ không còn đại diện cho cấu hình mới. `timing:check` kiểm tính hợp lệ của cấu hình; các test cân bằng có mốc mặc định riêng để phát hiện thay đổi về nhịp chơi.
