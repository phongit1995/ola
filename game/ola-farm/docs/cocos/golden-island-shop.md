# Shop vật nuôi và công trình

Nút **Shop** thay **Nông trại** ở navigation, cạnh Kho và Nhà máy. Mở Shop hiện bảng dưới màn hình, hai tab **Vật nuôi / Công trình** và thẻ cuộn ngang. Chạm bản đồ phía trên để đóng; thao tác cuộn trong Shop không kéo hoặc zoom map. **Menu → Nông trại** giữ lối về góc nhìn gần ruộng và chuồng.

Shop có một thẻ cho mỗi loại: tám loại máy và bốn loài. Bộ đếm **0/2 → 1/2 → 2/2** là số nhà đã xây. Nhà thứ hai cần **level 12–54 tùy loại**, đã có nhà 1, đủ điều kiện nội dung và đủ xu. Thiếu level vẫn hiện giá số + icon xu, ổ khóa và `Cần level N`; thiếu tiền hiện số xu còn thiếu. Đủ hai nhà hiện `Đã đủ 2 nhà` và khóa mua.

Tab Vật nuôi xây chuồng, mỗi chuồng mới có một ô kèm một con. Mua thêm con hoặc mở ô nuôi nằm trong popup của đúng chuồng. Ô gà 2–5 cần level 5/10/15/20; ô bò dùng level 2/3/4/5, độc lập với level xây nhà 2. Mỗi chuồng tối đa năm con.

Giá và level theo từng loại nằm trong [bảng cân bằng hiện hành](farm-town-husbandry-balance.md#máy-và-hàng-đợi). Ví dụ chuồng gà thứ hai cần level 12/4.120 xu gồm một con; máy thức ăn thứ hai cần level 12/5.000 xu.

Heo cần nhận cám, trứng và sữa; cừu/bàn đan cần nhận burger. Level và giá nhà lấy từ [economy.json](../../assets/farm/bundles/farm-town/economy.json); [hướng dẫn cấu hình](economy-config.md). Giao dịch qua `GameSession.dispatch`, lưu thành công rồi mới công bố và đóng Shop/focus đúng nhà vừa xây. Bấm lặp nút cũ không mua sang vị trí khác.

Lượt mới chưa có máy hoặc chuồng; tất cả công trình sản xuất phải mua trong Shop. Các nhà chưa mua không có hình, badge, vùng bấm hoặc khả năng di chuyển; đất của chúng không chặn công trình khác. Khi mua, game ưu tiên vị trí đã lưu/mặc định, nếu bị chiếm thì tìm chỗ trống gần nhất. Không có chỗ thì không trừ tiền. Tất cả vị trí cũ được giữ; 12 anchor mới phục vụ nhà số 2, layout v6. Xem [runtime](farm-town-husbandry-runtime.md).

## Nguồn Golden Island

Nguồn đúng là **`BuildingUI`**, với các thẻ `AnimalBuildingUI` và `HouseBuildingUI`; `ShopPanel` trong APK là cửa hàng IAP khác. Hai tab được giữ từ thanh category gốc. Khung tab `StateOpen`, `UImain3`, dải nối `UImain`, icon category, thẻ, giá, khóa và số lượng dùng đúng sprite PPtr. Nút navigation dùng `GameplayMainUI/SafeArea/PanelBot/GroupLeft/Building` (`icon_building`), giữ tỉ lệ ảnh.

[Manifest](../../assets/farm/bundles/golden-island-ui/manifest.json) và [hồ sơ nhập nguồn](../../source-assets/golden-island-ui/README.md) ghi node, sprite ID, hash và border. Các sprite modal đã có được giữ nguyên. `ShopPanel.ts` nối dữ liệu với prefab Shop; `PanelHost` giữ lớp chặn input, vòng refresh và trạng thái cuộn. Model công trình dùng prefab Farm Town đang có trong game. Bốn thẻ chuồng dùng `yard-coop`, `yard-cowshed`, `yard-pigpen`, `yard-sheepfold`, giữ nguyên các lớp hình và thứ tự hàng rào. Chuồng gà và bò có sẵn hình con vật trang trí trong nguồn; chúng không biểu thị số vật nuôi đã mua.

Bố cục lấy hình dáng từ canvas nguồn 1920×1080, được thu gọn theo yêu cầu hiện tại. Màn hình dọc và điện thoại hẹp điều chỉnh vùng chữ và hình, giữ nút mua ít nhất 44 CSS px. Đây là UI Cocos dựng từ dữ liệu prefab/sprite gốc với hai menu được yêu cầu; ảnh đối chiếu ghép từ nguồn không phải screenshot gameplay Unity. Luật mua và vị trí công trình vẫn là luật Ola Farm.

## Chỉnh trong Cocos Editor

Mở [Shop.prefab](../../assets/farm/prefabs/ui/Shop.prefab) để sửa bố cục bảng, hai tab, nền và vùng cuộn; mở [ShopCard.prefab](../../assets/farm/prefabs/ui/ShopCard.prefab) để sửa thẻ dùng chung. Các node, SpriteFrame, font Poetsen, nút giá và liên kết component được lưu trong prefab. `ShopView` và `ShopCardView` đọc các liên kết Inspector rồi cập nhật dữ liệu, trạng thái khóa và kích thước phù hợp màn hình.

Trong Inspector của `ShopView`, `cardGap`, `cardPadding`, `bottomPadding` và `headerHeight` điều chỉnh khoảng cách và phần đầu tab. Kích thước trên điện thoại nằm ở `portraitCardWidth/Height`, `portraitHeaderHeight`, `compactCardWidth/Height` và `compactHeaderHeight`. Mặc định thẻ dọc là 128×190 CSS px, thẻ ngang thấp là 120×145 CSS px; trên desktop, kích thước lấy từ `UITransform` của prefab thẻ theo chiều cao màn hình. Khung desktop thu còn khoảng 75% kích thước bố cục trước; màn hình nhỏ giữ riêng chiều cao nút mua để thao tác được.

Thẻ gốc có kích thước 215×305 đơn vị Editor. `ShopName`, `QuantityBackground/ShopQuantity`, `ShopModel`, `ShopDescription` và `Price/Title` là các phần chỉnh nội dung, chữ và vị trí; `LockedBackground` và `Price/Lock` dùng cho trạng thái chưa mở. Trong `ShopModel/PreviewFit` có một instance liên kết tới prefab `yard-coop`, nên mở riêng thẻ trong Editor vẫn thấy nguyên mẫu chuồng. Khi chạy, game ẩn mẫu này và lắp prefab phù hợp với thẻ. Phần xem trước được fit từ toàn bộ Sprite con, vì khung 200×160 của prefab chuồng có khoảng trống quanh hình.

`CardBackground` và `Price/PriceBackground` tách hình nine-slice khỏi kích thước thẻ/vùng bấm, giúp góc bo thu đúng tỉ lệ và dải giá không đè lệch lên đáy thẻ. `Price/PriceCoin` liên kết trực tiếp icon xu 54×54 đang dùng trong HUD; không thêm ảnh mới hoặc sửa metadata của các sprite dùng chung. Chữ giá/trạng thái mặc định giảm từ 20 xuống 16 đơn vị Editor, mô tả từ 16 xuống 13; trên điện thoại giữ chữ giá tối thiểu 11 CSS px và vùng bấm tối thiểu 44 CSS px. Ví dụ giá trong prefab là nội dung xem trước; giá khi chơi lấy từ economy.json.

Giữ các liên kết trên component và tên node điều khiển sẵn có khi thay hình hoặc chỉnh bố cục. Chỉnh màu, font và ảnh tại node tương ứng; giá, số lượng, điều kiện và mẫu chuồng lúc chạy lấy từ dữ liệu game. Các ảnh ghép nguồn là tài liệu đối chiếu, không phải file dùng để sửa Shop. Prefab không bị tái tạo tự động mỗi lần chạy kiểm tra.

## Kiểm tra

`two-buildings.test.ts` và `pen-slots.test.ts` kiểm bộ đếm, giá, khóa level, vị trí, giới hạn và reload. Các browser test `two-buildings.browser.cjs` / `pen-slot-levels.browser.cjs` mô tả nghiệm thu bản giá cũ; cần cập nhật kỳ vọng trước khi chạy với `town-real-time-1`. `shop-prefab.test.ts` kiểm liên kết node/meta. Các browser test Shop cũ còn kỳ vọng 1/1 hoặc mua ô nuôi trong Shop cần cập nhật trước khi dùng lại.
