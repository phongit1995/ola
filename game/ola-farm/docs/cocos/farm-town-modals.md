# Popup công trình và chăm đàn

Giao diện hiện tại dùng **popup Golden Island ở giữa màn hình**, được chia thành các prefab Cocos để phục vụ [chăn nuôi và chế biến hiện hành](farm-town-husbandry-runtime.md): **8 cây, 4 loài, 8 loại máy (tối đa 16 nhà), 23 công thức, 35 vật phẩm**, giữ 40 ruộng.

Cả tám xưởng dùng chung `FactoryPanel`/`FactoryBody`/`FactoryQueueSlot`; `RecipeChoice` và `IngredientItem` có View riêng, số thẻ tạo theo dữ liệu công thức/nguyên liệu. Chuồng dùng `LivestockPanel`/`LivestockBody`/`HerdSlot`, cùng hệ khung `DialogShell` nhưng khác phần chăm đàn. Hai nhà mỗi loại dùng chung các prefab này; tiêu đề và nguồn nguyên liệu phân biệt nhà 1/2, mọi thao tác dùng ID instance đang chọn.

## Bấm trên bản đồ

**Menu → Nông trại** về góc nhìn gần của khu giữa: 40 ruộng, các chuồng đã xây, nhà và kho. Đây cũng là giới hạn thu nhỏ; kéo map hoặc chọn công trình để tới các máy ngoài rìa. Home không ép tất cả máy vào một khung hình. Chạm ô đất giữ nguyên zoom; giữ rồi kéo công trình vẫn là thao tác [di chuyển và lưu vị trí](di-chuyen-cong-trinh.md).

| Công trình | Thao tác |
| --- | --- |
| Lò bánh, xưởng sữa, máy thức ăn | Phải mua trong Shop; máy thức ăn/lò bánh/xưởng sữa lần đầu mở ở level 1/5/10, rồi chạm máy đã xây để sản xuất |
| Bếp nướng, máy đường, lò ngô, lò pie, bàn đan | Shop hiện 0/2, 1/2 hoặc 2/2; nhà thứ hai cần level 12–54 tùy loại. Mua xong xuất hiện trên map, chạm để sản xuất đúng nhà |
| Nhà kho | Mở tab nguyên liệu/thành phẩm; chọn món và số lượng bán |
| Nhà ở | Menu/cài đặt; lúc mở chặn thao tác trên map nhưng không dừng đồng hồ; đóng trả lại trạng thái trước đó |
| Chuồng gà/bò/heo/cừu | Chạm chuồng đã xây mở thẳng popup của chuồng đó, có mua ô/con, cho ăn, tăng tốc và nhận sản phẩm |

Tám anchor máy đầu tiên là `bakery-1`, `dairy-1`, `feed-1`, `grill-1`, `industry-sugar_processor`, `industry-popcorn_factory`, `industry-pie_bakery`, `industry-loom`. Thêm tám anchor máy nhà 2 có hậu tố `-2`; giữ ID của 50 ô cũ và thêm chuồng plot 50–53 (`Cell50–53`, `cell: null`). Các ruộng đã sở hữu, một ô đất xanh kế tiếp và các chuồng đã xây có tương tác (7 vị trí lúc khởi đầu: 6 ruộng và 1 ô xanh; 48 khi mua đủ 40 ruộng và tám chuồng). Nhóm `Livestock` vẫn giữ 10 anchor `Cell12–21` để định vị bốn chuồng và tương thích hình học save cũ. Đã xóa 10 preview chuồng/ao legacy cùng liên kết instance; hình sân và vật nuôi thật do `FarmTownViews` dựng riêng.

Khung chung nằm trong `assets/farm/prefabs/ui/DialogShell.prefab`; `FactoryBody`/`FactoryQueueSlot`, `LivestockBody`/`HerdSlot`, `InventoryBody`/`StockCard` giữ nội dung và các thẻ lặp. `HerdQuickBar.prefab` vẫn còn trong repo nhưng luồng chạm chuồng hiện mở modal trực tiếp. Mở từng prefab để chỉnh hình, chữ và bố cục; các component View bind trạng thái hiện tại, còn luật giao dịch giữ trong core. [Bảng module và cách chỉnh trong Editor](asset-pipeline.md#chỉnh-trong-editor).

## Luồng popup hiện tại

[Shop](golden-island-shop.md) thay nút Nông trại ở navigation. Đây là bảng dưới màn hình theo `BuildingUI`, được thu gọn và lưu trong `Shop.prefab` / `ShopCard.prefab`, gồm hai tab và hàng thẻ cuộn ngang; các popup công trình bên dưới vẫn dùng khung giữa màn hình.

- Nhà máy: trạng thái mẻ đang chạy, nút **Nhận hàng**, hàng chờ tối đa năm ô, vùng chọn công thức/nguyên liệu và nút làm món. Chạm **Chọn món** đổi danh sách công thức; chạm nguyên liệu xem nơi cung cấp. Ghim món và đường quay về giữ đúng máy/công thức. Khay nhận tối đa năm mẻ; mẻ đang chờ có thể hủy/hoàn nguyên liệu theo luật hiện hành.
- Kho: tab cố định ghi tổng số món trong tab, tab đang chọn chữ đậm màu hơn; lưới cuộn, icon giữ tỉ lệ. Món đang có xếp trước; món hết hàng vẫn hiện để người chơi biết có món đó nhưng mờ và không có số. Vòng số lượng tự rộng theo số chữ số. Nút Bán nhanh màu xanh. Chọn món để xem tồn kho và giá mỗi cái, giảm/tăng/tối đa số lượng, xem tiền nhận rồi bán; nút xanh duy nhất là Bán, Về kho là nút trắng; quay về giữ tab. Bán nhanh chỉ liệt kê món đang có, tab đang chọn màu xanh.
- Chuồng: mở thẳng chế độ chăm của **chuồng đang chọn**, với **năm thẻ ô trên một hàng cuộn ngang**. Không có tab chọn loài khác trong bảng; đóng rồi chạm chuồng khác trên map để đổi đàn. Ban đầu mở một ô có một con. Mua ô khóa mở ô kèm một con; mỗi chuồng tối đa năm con cùng loài. Con đang nuôi hiện đồng hồ + thời gian và nút số giá + kim cương để tăng tốc; tăng tốc xong cần nhận sản phẩm riêng. Gà có nút **Cho ăn / Nhận trứng**, các loài khác dùng sản phẩm tương ứng. Lượng cám có icon lớn bên dưới hàng thẻ, không có liên kết tìm cám hoặc nút bán con. Cho cả đàn ăn cần đủ phần cho các con đói; nhận cả đàn chỉ lấy sản phẩm đã xong.
- Popup có khung giữa màn hình, nút đóng và nền chặn thao tác map phía sau. Nội dung dài cuộn trong vùng riêng; resize giữ panel, máy, chuồng và tab. Các action vẫn đi qua `GameSession`, bao gồm khóa giao dịch khi mở Menu hoặc lỗi lưu.

## Art Golden Island đang dùng

[Manifest Golden Island](../../assets/farm/bundles/golden-island-ui/manifest.json) ghi từng sprite, node nguồn, asset/bundle nguồn, SHA-256, rect, trim offset, kích thước và border. [Importer](../../tools/import-island-ui.py) truy sprite qua component Image của prefab, tránh nhầm các sprite trùng tên. PNG nguồn không được vẽ lại; border nine-slice được hiệu chỉnh theo phần atlas đã cắt và giới hạn kích thước để giữ góc khung.

| Phần trong Cocos | Node nguồn Golden Island |
| --- | --- |
| Khung popup công trình | `UpgradeHouseUI/Popup/PanelRequirement` |
| Nút đóng, nền thẻ, nút xanh | Các node `ButtonClose`, `UpgradeHouseElement`, `ButtonUpgradeAll` trong `UpgradeHouseUI` |
| Ô hàng chờ | `Crafting/Popup/SlotCrafting/Slot1` |
| Ô chọn công thức, đánh dấu chọn | `Crafting/Popup/ListTool/ToolUI` và `Select` |
| Thẻ nguyên liệu, nền thông tin | `Crafting/Popup/ToolDetails/Material1` và `ToolDetails` |
| Khung popup chung, tab và thanh tiến độ | Các sprite từ `InventoryUI/Popup` |

`PanelHost.ts` đặt khung ở giữa màn hình; `FactoryPanel.ts` ghép các ô, thẻ và nút vào bố cục phù hợp tiếng Việt và màn hình dọc/ngang. **Đây là bố cục Cocos dùng sprite và thành phần nguồn, không phải ảnh chụp màn hình Unity hoặc port nguyên màn hình `Crafting`/`UpgradeHouseUI`.** Luật nâng cấp nhà của Golden Island không được suy ra từ tên asset; các nút vẫn thực hiện mua máy, xếp mẻ, nhận hàng và chăm đàn của Ola Farm. Art công trình/vật nuôi Farm Town và animation trạng thái Cocos vẫn giữ riêng với skin popup.

Popup sản xuất (`factory`) dùng bố cục riêng theo CSS px, font Poetsen đồng bộ với HUD/Shop. Khung thường rộng tối đa **560 px**, cao **450 px**; hàng đợi và các nút nằm cố định trong khung, vùng công thức cuộn riêng. Trên màn hình ngang thấp dưới 500 px và rộng từ 560 px, trạng thái/hàng đợi nằm bên trái, công thức/nguyên liệu bên phải; khung rộng tối đa **620 px**, cao tối đa **340 px** và luôn chừa lề màn hình. Một nguyên liệu dùng trọn hàng, nhiều nguyên liệu chia hai cột. Ô hàng đợi trống không lặp chữ; ô mở thêm ghi giá số và icon xu. Nút nhận hàng có nền nhẹ khi khay rỗng, chuyển xanh khi có thành phẩm; nút **Chế biến** và **Chọn món** cách đáy khung 30 px, vùng chạm tối thiểu 44 px.

`factoryLayout` trong `ui/production/FactoryLayout.ts` dùng chung với `PanelHost.ts` để kích thước khung khớp nội dung. `FactoryFrame` và nền nút được scale riêng để giữ góc bo theo kích thước hiển thị, không sửa PNG/border dùng chung. Popup xem/mua công trình (`industry`) vẫn giữ mức thu 80% trên màn hình có cạnh ngắn từ 600 CSS px.

Header popup sản xuất đối chiếu trực tiếp `UpgradeHouseUI/Popup/PanelRequirement`: tên nằm trên tai cam, màu `(188,66,47)`, font Poetsen không viền; tai cam là phần sẵn có của sprite khung. Hệ số ảnh 0,42 cho chữ khoảng 20 CSS px và nút X đúng tỷ lệ 38,64 × 36,96 CSS px, với vùng bấm 44 × 44. Khi màn hình đủ rộng, X nhô bên phải như prefab gốc. Màn hình hẹp đưa X lên vùng header và giữ toàn bộ vùng bấm cách mép cửa sổ ít nhất 4 px, tránh đè nút nhận hàng. Kích thước khung, vị trí/chữ của hàng đợi, công thức, nguyên liệu và các nút bên dưới được giữ nguyên. `Crafting` gốc không có header/X này; nó cung cấp các thành phần sản xuất nằm trên bản đồ.

Chuồng dùng cùng khung/header này, tiêu đề ghi đúng **Chuồng gà 1/2**, **Chuồng bò 1/2**, **Chuồng heo 1/2** hoặc **Chuồng cừu 1/2** đang mở. `livestockLayout` đặt cả năm thẻ trên **một hàng duy nhất**, không xuống hàng trên điện thoại. Vùng thẻ có mask; chiều rộng thẻ chia đều theo số cột vừa khung để không cắt chữ ở vị trí đầu/cuối danh sách. Điện thoại hiện hai thẻ rồi kéo ngang xem các ô còn lại; màn hình rộng có thể hiện cả năm. Chữ và nút không bị thu nhỏ theo số cột. Lượng cám nằm trên một hàng cố định, bỏ dòng đếm `N/5 con`. Thẻ chừa lề ngang 26 px; nút chăm đàn chừa đáy 28 px để tránh phần bo góc của khung; mỗi ô có ảnh con vật, trạng thái và nút riêng với vùng bấm tối thiểu 44 px. Kéo trên thẻ không kích hoạt nút mua/cho ăn/nhận và không kéo map phía sau.

Giá ghi trên ô khóa đã gồm phí mở ô và một con vật; chỉ ô kế tiếp được mở. Bấm lặp cùng ô không mua sang ô khác. Con vật có `slot` cố định trong bản lưu; bán một con để lại ô trống, mua lại vào ô đó không trả phí mở lần nữa. Bản lưu cũ giữ nguyên các ô đã mua, con vật và timer, gán slot theo thứ tự cũ và giữ bản gốc dự phòng. Chuồng chưa mở hiển thị prefab sân, điều kiện và tổng giá xây kèm con đầu tiên.

Ô khóa của chuồng chưa đủ cấp hiện **Level N ngay trên nút mở ô**, nút bị khóa và ẩn icon xu. Đạt cấp mới hiện **số giá + icon xu**; vẫn phải mở ô theo thứ tự và đủ xu. Ổ khóa 48×54 CSS px ở bố cục thường hoặc 36×40,5 khi thấp. Mặc định ô 2–5 của gà cần level 5/10/15/20, bò dùng level 2/3/4/5; chưa đủ thì hiện `Level N` và khóa mua. Lợn/cừu chưa khóa level theo ô. Trong xưởng, giá hàng đợi cũng dùng số + xu nhưng ổ khóa nhỏ hơn. Giá/level mọi ô chuồng và máy lấy từ [economy.json](../../assets/farm/bundles/farm-town/economy.json); ô máy thiếu level hiện `Lv N` và không mua được. Các mốc ô này độc lập với level 12–54 tùy loại để xây nhà thứ hai.

## Mã nguồn và kiểm tra

`PanelHost.ts` quản lý modal và giữ offset cuộn cùng chuồng. `FactoryPanel.ts` dựng sản xuất; `LivestockPanel.ts` dựng năm ô; `InventoryPanel.ts` dựng kho. `GameSession.dispatch` giữ giao dịch và lỗi ghi. Thao tác, điều kiện và bộ đếm lấy từ domain, không suy ra từ hình khóa hoặc tên sprite.

Sau khi build, `factory-cards.browser.cjs` và `gameplay-runtime-config.browser.cjs` trong `game/ola-farm/tests/` kiểm các thẻ Factory và UI chuồng. Các test lịch sử như `livestock-layout.browser.cjs` còn kỳ vọng thanh chăm nhanh/bán con/tìm cám; `animal-boost.browser.cjs` còn đọc node `HerdCount` đã bỏ; `pen-slot-levels.browser.cjs` dùng mốc ô gà cũ. Cần cập nhật chúng trước khi nghiệm thu lại. Kiểm luồng khởi đầu và level ô hiện tại bằng `construction-reset.browser.cjs` và `starter-slot-levels.browser.cjs` sau khi build lại. Báo cáo cục bộ chỉ áp dụng cho phiên bản đã chạy.
