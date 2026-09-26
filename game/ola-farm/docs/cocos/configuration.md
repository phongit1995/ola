# Các cấu hình của game Cocos

> **Số liệu hiện hành đã kiểm chứng nằm ở [Chỉ số game](../chi-so/README.md).** Tài liệu này giữ phần giải thích và lịch sử thiết kế; nếu con số ở đây lệch với `docs/chi-so/` hoặc file JSON thì lấy `docs/chi-so/` và JSON làm chuẩn.

Bản hiện hành tải năm JSON trong `game/ola-farm/assets/farm/bundles/farm-town/`. Các file này đã nối vào luật chơi, giao diện và bộ kiểm tra; sửa số rồi khởi động lại game/build để áp dụng. Bộ giá trị mặc định giữ nguyên nhịp chơi trước khi tách cấu hình.

| Muốn chỉnh | File / mục |
| --- | --- |
| Giá hạt, giá bán, giá chuồng/máy/ô, level, XP, sản lượng, hoàn tiền, ví ban đầu, ruộng khóa/mở | [economy.json](../../assets/farm/bundles/farm-town/economy.json), xem [hướng dẫn kinh tế](economy-config.md) |
| Thời gian cây/vật nuôi/mẻ chế biến, số giây tăng tốc mỗi kim cương | [timing.json](../../assets/farm/bundles/farm-town/timing.json), xem [hướng dẫn thời gian](timing-config.md) |
| Số nhà tối đa, số ô, khay nhận, số con, lượng cám, kho khởi đầu, điều kiện mở heo/cừu | [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json) |
| Autosave, offline, âm thanh, chuyển động, thông báo, giữ/chạm/kéo, zoom, số luồng tải ảnh | [runtime.json](../../assets/farm/bundles/farm-town/runtime.json) |
| Tên/ID, hình ảnh/prefab, công thức nguyên liệu/đầu ra, loại máy làm món, cám và sản phẩm mỗi loài, nơi gắn mốc mở khóa | [catalog.json](../../assets/farm/bundles/farm-town/catalog.json) |

`name` trong các bảng timing/economy/gameplay là nhãn tiếng Việt để tra cứu. Tên hiển thị lấy từ catalog. `sourcePrice` trong catalog là thông tin nguồn, không phải giá đang dùng.

## gameplay.json

| Mục | Tác động |
| --- | --- |
| `startingInventory` | Kho cấp khi tạo lượt mới, ví dụ `{ "raw:1": 10, "farm40:chicken-feed": 5 }`. Không cộng vào thống kê thu hoạch hoặc mốc mở khóa |
| `showWelcome` | Có mở hướng dẫn khi tạo lượt mới hay không |
| `rescueEnabled` | Bật/tắt hạt lúa hỗ trợ khi không còn vốn, hàng hay công việc đang chờ; mặc định bật |
| `growthStageFraction` | Tỷ lệ thời gian chuyển từ cây non sang giai đoạn giữa; mặc định `0.5`, cho phép `0.01–0.99` |
| `requireFeedMill` | Có bắt buộc sở hữu máy thức ăn trước khi mua chuồng, con hoặc mở ô hay không |
| `animals.<key>.maxPens` | Giới hạn mua chuồng của loài, `1–2` |
| `animals.<key>.maxCapacity` | Sức chứa tối đa được nâng, `1–5` |
| `animals.<key>.startingCapacity` | Số ô khi chuồng được tạo: cả chuồng cấp sẵn lẫn chuồng mua mới |
| `animals.<key>.startingAnimals` | Số con kèm chuồng được tạo, từ `0` đến `startingCapacity` |
| `animals.<key>.feedPerAnimal` | Lượng cám cho một con mỗi lượt, số nguyên ít nhất `1` |
| `machines.<key>.maxBuildings` | Giới hạn mua nhà của loại máy, `1–2` |
| `machines.<key>.maxQueueCapacity` | Giới hạn nâng hàng đợi, `1–5` |
| `machines.<key>.startingCapacity` | Số ô khi máy được tạo, cả máy cấp sẵn và máy mua mới |
| `machines.<key>.trayCapacity` | Số mẻ chứa trong khay, `1–5`; đầy thì dừng lấy việc tiếp theo |
| `gates.husbandry`, `gates.crafts` | Điều kiện thu sản phẩm; đối tượng sử dụng từng mốc được gắn `unlock` trong catalog |

Ví dụ chỉnh gà có hai con khi tạo chuồng, tối đa ba con và cần hai cám mỗi con:

```json
"layer": {
  "name": "Gà đẻ trứng",
  "maxPens": 2,
  "maxCapacity": 3,
  "startingCapacity": 2,
  "startingAnimals": 2,
  "feedPerAnimal": 2
}
```

Đây là mục bên trong `animals`, không thay cả file bằng đoạn này. Giá xây chuồng mới = `economy.pens.<site>.sitePrice + startingAnimals × economy.animals.<key>.purchasePrice`. Giá mở thêm một ô vẫn gồm phí ô và **một con**. Mua con vào ô trống chỉ tính giá con. `startingCapacity` lớn hơn 1 nghĩa là số ô đó nằm trong gói chuồng/máy được tạo, không thu thêm từng giá nâng ô.

Giao diện chỉ hiện số ô được phép nâng hoặc số ô đã sở hữu nếu nhiều hơn. Hạ giới hạn không xóa con, ô, nhà hoặc mẻ đã trả nguyên liệu. Nếu khay cũ có ba mẻ và giới hạn mới là một, người chơi vẫn lấy đủ ba mẻ; máy chờ khay còn chỗ rồi mới tiếp tục. Số con/ô khởi tạo không ghi đè lên chuồng/máy đã có trong save.

### Điều kiện mở nội dung

Ví dụ yêu cầu nhận tổng cộng năm trứng và hai sữa để mở nhóm `husbandry`:

```json
"husbandry": {
  "mode": "all",
  "requirements": [
    { "items": ["farm40:egg"], "quantity": 5, "label": "thu trứng" },
    { "items": ["raw:7"], "quantity": 2, "label": "thu sữa" }
  ]
}
```

`all` yêu cầu đủ mọi dòng, `any` chỉ cần một dòng. Mỗi dòng cộng lượng đã nhận của các mã trong `items`; ví dụ cám gà và cám bò có thể gộp chung. `requirements: []` bỏ khóa mốc đó. Level trong economy vẫn được kiểm riêng.

Thống kê tính lúc **thu hoạch/nhận hàng**, giữ được sau khi bán hoặc chế biến; có sẵn hàng trong kho chưa được tính là đã thu. Từ lần cập nhật này, nông sản thu từ ruộng cũng ghi vào `produced`, nên có thể đặt mốc theo lúa/ngô… Lượt thu ruộng trước đây chưa có thống kê chi tiết sẽ không được suy đoán thêm. Các cờ mốc một lần của save cũ vẫn được công nhận với đúng yêu cầu mặc định tương ứng. Đổi yêu cầu sang lượng lớn hơn sẽ dùng lượng thu thực đã ghi.

Tăng yêu cầu có thể khóa lại công thức chưa đáp ứng; công trình đã sở hữu vẫn giữ nguyên. Khi chỉnh mốc, tránh yêu cầu một món chỉ sản xuất được sau chính mốc đó. Bộ kiểm tra xác nhận cấu trúc và mã vật phẩm, không chứng minh mọi tổ hợp luật đều có đường hoàn thành.

## runtime.json

| Mục | Ý nghĩa / mặc định |
| --- | --- |
| `session.autosaveSeconds` | Chu kỳ lưu tự động: `2.5` giây. Giao dịch và chuyển trạng thái vẫn lưu ngay |
| `session.offlineProgressEnabled` | Tiếp tục công việc đã trả nguyên liệu khi đóng/ẩn game: `true` |
| `session.maxOfflineSeconds` | Giới hạn tiến độ mỗi lần vắng mặt; `null` không giới hạn, `0` không cộng thời gian |
| `session.defaultSound`, `defaultMusic` | Tùy chọn âm thanh cho lượt mới: `false`. Tùy chọn đã lưu của người chơi được ưu tiên |
| `audio.musicVolume`, `effectVolume` | Âm lượng `0–1`, mặc định `0.15` và `0.3` |
| `ui.refreshSeconds` | Chu kỳ cập nhật nhãn/nút: `0.25` giây |
| `ui.toastSeconds` | Thời gian hiện thông báo: `4` giây |
| `ui.motionEnabled` | Bật chuyển động: `true`; vẫn tôn trọng tùy chọn giảm chuyển động của hệ điều hành |
| `input.longPressSeconds` | Giữ hạt để xem thông tin hoặc giữ công trình để di chuyển: `0.45` giây |
| `input.mapDragSlop`, `seedDragSlop`, `buttonDragSlop` | Độ lệch để phân biệt chạm/kéo theo đơn vị thiết kế: `8`, `12`, `10` |
| `input.wheelZoomStep` | Hệ số zoom mỗi nấc cuộn: `1.12` |
| `input.resizeSettleSeconds` | Chờ kích thước cửa sổ ổn định trước khi sắp xếp lại: `0.25` giây |
| `camera.homePadding`, `cullMargin` | Khoảng chừa khi nhìn toàn trại và lề ngoài màn hình để giữ cảnh: `90`, `250` |
| `camera.maxZoom`, `maxDisplayScale` | Trần camera được tính bằng `max(maxZoom, maxDisplayScale / scaleNền)`; mặc định `8`, `2` |
| `camera.buildingFocusScale`, `facilityFocusScale` | Tỷ lệ mong muốn khi tập trung vào chuồng/máy và công trình chức năng: `1.35`, `1.1`; vẫn thu nhỏ để vừa màn hình |
| `assets.loadConcurrency` | Số luồng tải tài nguyên ported: `8`, cho phép `1–32`; config được đọc trước đợt tải này |

Ví dụ giới hạn offline tám giờ: `maxOfflineSeconds: 28800`. Chỉ phần thời gian được phép được cộng; phần dư bị bỏ, không phát lại khi tải lại trang. Cây, vật nuôi và máy chỉ hoàn thành công việc đã bắt đầu, không tự thu, cho ăn hoặc xếp thêm món. Khi đang chơi, đồng hồ tiếp tục chạy bình thường và không bị trần offline. Menu và chế độ sắp xếp không dừng đồng hồ, chỉ chặn thao tác; chỉ lỗi lưu mới dừng tiến độ.

Giá trị runtime áp dụng lúc khởi động; không đổi giới hạn hoặc volume giữa một phiên đang chạy. `autosaveSeconds` lớn không trì hoãn việc lưu giao dịch. Khoảng thời gian autosave khi đang mở ứng dụng dùng thời gian frame, còn tiến độ công việc dùng đồng hồ thực.

## Phần đã có chỗ cấu hình riêng

Không cần tạo JSON thứ hai cho các dữ liệu đã do Editor hoặc bộ tạo asset quản lý:

- Bố cục, đường, trang trí và nền công trình: các JSON trong [source-assets/farm-beautify](../../source-assets/farm-beautify/), được công cụ tạo thành [layout.json](../../assets/farm/data/farm-layout/layout.json), geometry TypeScript và prefab. Sửa nguồn rồi chạy công cụ tương ứng theo tài liệu bố cục; không sửa riêng file sinh ra.
- Kích thước, màu, font, nút, khoảng cách và liên kết UI đã công khai qua `@property`: chỉnh Inspector của các prefab/view như `ShopView`, `SeedPickerView`, `InventoryBodyView`, `DialogShell` và scene `Farm`. Công thức responsive còn ở code.
- Tên, ảnh, nguyên liệu, sản phẩm và gắn mốc: catalog JSON hiện có. `initialMachines` và `residentPens.initial` mô tả các công trình cấp sẵn của profile; thay tập công trình này cần xét cả giá `null`, layout và việc chuyển save cũ. Đây là cấu trúc nội dung, không phải thông số cân bằng tùy ý áp dụng lên mọi save.

Các bất biến vẫn ở code: version/khóa save, ID vị trí/vật phẩm, chuyển save cũ, bảo toàn giao dịch, giới hạn an toàn của số, thứ tự render và mô tả chuyển động của từng phần model. Bố cục hiện có **40 ruộng, hai vị trí mỗi loại nhà, năm ô chuồng/hàng đợi và bốn cấp đất**. JSON có thể hạ giới hạn trong phạm vi này; vượt chúng cần thêm map, prefab/UI và chuyển dữ liệu tương ứng.

## Cách kiểm và áp dụng

Từ gốc repo:

```sh
npm run config:check --prefix game/ola-farm
npm run verify --prefix game/ola-farm
npm run typecheck --prefix game/ola-farm
```

`config:check` đọc cả năm file theo cùng luồng với [Art.ts](../../assets/farm/scripts/render/Art.ts): economy → timing → gameplay → runtime. Thiếu mục, gõ sai khóa, sai kiểu, ngoài giới hạn hoặc vật phẩm không tồn tại sẽ báo tên file và đường dẫn mục lỗi trước khi tạo game. File hiện hành không được âm thầm thay bằng mặc định nếu tải thất bại.

Sau khi lưu JSON và Creator import xong, khởi động lại Preview; với Web Mobile, build lại rồi tải lại trang. Kho/ví/tài sản cũ và snapshot công việc đang chạy được giữ. Muốn kiểm tra kho, ví, ruộng và vật nuôi khởi đầu thì dùng lượt mới trong profile trình duyệt riêng.

`gameplay-runtime-config.test.ts` kiểm luật, dữ liệu sai, tiến độ offline, autosave và giữ save. `gameplay-runtime-config.browser.cjs` thay nội dung hai JsonAsset ngay trong response của bản build thử: kiểm số ô hiển thị, lượng cám thực bị trừ, giới hạn Shop, khay đầy, mở mốc sau khi nhận bánh, trần offline, âm lượng, thời gian thông báo và tải lại trên ba kích thước màn hình. File nguồn mặc định không bị sửa để chạy kịch bản thử.

Mô phỏng `simulate:balance` đọc config hiện tại nhưng chiến thuật cám/burger và lịch đăng nhập vẫn là kịch bản thử cố định, không phải bộ tự tìm đường chơi cho mọi bộ mốc/công thức mới. Chỉ dùng kết quả gắn với đúng cấu hình và giả định đã chạy; xem [cách đọc báo cáo mô phỏng](real-time-economy.md#chạy-mô-phỏng-cấu-hình-hiện-hành).
