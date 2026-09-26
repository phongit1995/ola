# Asset và prefab Cocos Farm

[Mở project và chạy](../../README.md) · [Nguồn Farm Town](farm-town-agriculture-inventory.md) · [Di chuyển công trình](di-chuyen-cong-trinh.md)

Runtime vào từ `game/ola-farm/assets/farm/scenes/Loading.scene`, tải tài nguyên rồi chuyển sang `Farm.scene` cùng thư mục. Asset đã nhập, prefab và `.meta` được giữ trong Git; build không cần APK hoặc thư mục khảo sát `reference/` và `artifacts/`.

Bộ nguồn [30 loại cây, 430 PNG](../../source-assets/farm-town/crops/README.md) và [gallery](../../source-assets/farm-town/crops/index.html) vẫn được giữ trong `source-assets/farm-town/crops/`. Đây là ảnh, role và hồ sơ nguồn nằm ngoài bundle runtime. Tám giống đang chơi lấy từ catalog và prefab đã nhập trong `assets/`; không suy số giống runtime từ số thư mục của gallery. Chạy `python3 game/ola-farm/tools/prepare-crop-sources.py --check` để kiểm bộ nguồn mà không cần APK; các nhãn đợt nhập trong hồ sơ là phân nhóm khảo sát cũ.

## Nguồn và kiểm tra

| Nội dung | Nơi quản lý |
| --- | --- |
| Cây, bốn sân/loài nuôi, tám máy Farm Town | `game/ola-farm/assets/farm/bundles/farm-town/manifest.json`, `prefabs/`, `images/` |
| Catalog gameplay | `game/ola-farm/assets/farm/bundles/farm-town/catalog.json` |
| Popup và Shop Golden Island | [Hướng dẫn nguồn](../../source-assets/golden-island-ui/README.md), manifest trong `assets/farm/bundles/golden-island-ui/` |
| HUD | [Nguồn HUD](../../source-assets/farm-hud/README.md) |
| Footer và bong bóng cây | [Nguồn ô đất](../../source-assets/farm-plot-ui/README.md) |
| Rừng, viền bãi cỏ, đá và decor | [Nguồn cảnh quan](../../source-assets/farm-beautify/README.md) |
| Asset gốc được port còn dùng | `game/ola-farm/asset-manifest.json`, `assets/resources/ported/` |

Manifest ghi nguồn, hash, rect, pivot/trim hoặc hierarchy tùy nhóm asset. Ảnh nguồn giữ nguyên pixel; dùng transform của node để sửa bố cục. Sprite cùng tên ở hai bundle không nhất thiết là cùng ảnh: đối chiếu file nguồn và object/PPtr. Giữ `.meta` để UUID trong scene/prefab không đổi.

## Chỉnh trong Editor

`assets/farm/prefabs/ui/` để phẳng 19 prefab giao diện, tên prefab nói rõ chức năng. `assets/farm/prefabs/map/` giữ bố cục bản đồ và tám vùng cảnh quan, `assets/farm/prefabs/items/` giữ thư viện item; `assets/farm/bundles/*/prefabs/` giữ prefab thuộc từng bundle nội dung. Đường dẫn bên trong bundle còn được catalog/manifest sử dụng, nên không gộp chúng vào thư mục UI.

| Prefab/node | Phạm vi chỉnh |
| --- | --- |
| `assets/farm/prefabs/map/scenes.prefab` | Anchor nhà/kho/máy/chuồng, 40 ruộng `Fields/R001–R040`, props sân và liên kết các vùng cảnh quan |
| `assets/farm/prefabs/map/ForestNE/NW/SE/SW.prefab` | Bốn vùng rừng; mỗi placement tiếp tục liên kết prefab cây/đá nguồn |
| `assets/farm/prefabs/map/Border0–3.prefab` | Bốn cạnh đá phân cách khu xây dựng và rừng |
| `assets/farm/prefabs/map/CropPlot.prefab` | Vỏ ô ruộng, wrapper đất/cây |
| `assets/farm/prefabs/items/crops/` và `items/plots/` | Art cây Farm và đất đang được thư viện tham chiếu |
| `assets/farm/bundles/farm-town/prefabs/` | Cây, sân, các lớp cơ thể vật nuôi và máy đã nhập |
| `assets/farm/prefabs/ui/LoadingScreen.prefab` | Nền, minh họa, chữ và tiến trình của scene Loading |
| `assets/farm/prefabs/ui/HUD.prefab` | Header, ví, cấp/XP, điều hướng; scene giữ liên kết `GameApp.hud` tới `HudView` bên trong |
| `assets/farm/prefabs/ui/DialogShell.prefab` | Khung popup, title, nút đóng, mount nội dung và các kiểu frame |
| `assets/farm/prefabs/ui/LandPurchase.prefab` | Popup mua đất riêng: khung gọn, hình ô đất, trạng thái khóa/giá, nút mua và đóng; chỉnh trực tiếp trong Editor |
| `assets/farm/prefabs/ui/FactoryDialogFrame.prefab` | Khung ngoài riêng của modal máy, giữ hình nền/viền, phần tiêu đề nhô lên và nút X của UI gốc; liên kết qua DialogShellView.factoryDialogPrefab |
| `assets/farm/prefabs/ui/FactoryBody.prefab`, `FactoryQueueSlot.prefab` | Nội dung máy và ô hàng đợi |
| `assets/farm/prefabs/ui/RecipeChoice.prefab`, `IngredientItem.prefab` | Thẻ chọn công thức và thẻ nguyên liệu; mỗi loại có View và baseline layout riêng |
| `assets/farm/prefabs/ui/LivestockBody.prefab`, `HerdSlot.prefab` | Nội dung chuồng và thẻ con vật/ô mở thêm |
| `assets/farm/prefabs/ui/InventoryBody.prefab`, `StockCard.prefab` | Tab kho, vùng cuộn và thẻ vật phẩm |
| `assets/farm/prefabs/ui/SeedPicker.prefab`, `SeedTile.prefab` | Thanh chọn hạt, thẻ giữ để xem chi tiết và từng ô hạt giống |
| `assets/farm/prefabs/ui/HerdQuickBar.prefab` | Thanh chăm đàn và trạng thái chuồng chưa xây |
| `assets/farm/prefabs/ui/PlotBubble.prefab` | Ba nhánh Growing, Ready, Locked của bubble cây trồng |
| `assets/farm/prefabs/ui/Shop.prefab` | Khung, tab, vùng cuộn và tham chiếu ShopCard |
| `assets/farm/prefabs/ui/ShopCard.prefab` | Nền thẻ, chữ, giá, icon xu và hình xem trước |

Mở prefab, chỉnh node hình bên trong rồi Preview scene. Tám module UI được gán qua component `UiPrefabs` trên Canvas; các thẻ con liên kết trong chính module cha; không tra theo tên file lúc chạy. Chỉnh font, màu và offset của node trong prefab; tên sản phẩm, giá, thời gian và trạng thái nút được cập nhật từ dữ liệu game. Các khung co giãn và vùng cuộn vẫn thích nghi theo màn hình. Chỉnh node anchor để dời cả công trình; chỉnh child hình để thay offset hoặc tỉ lệ art. Kéo thêm một prefab vào cảnh chỉ tạo hình, không tự thêm ID/động vật/quyền sở hữu vào gameplay. Chuồng và máy được dựng từ catalog khi đã mua.

`FactoryBodyView.recipeChoicePrefab` và `ingredientItemPrefab` liên kết hai nguồn thẻ. Chỉnh hình/font/màu trong `RecipeChoice` hoặc `IngredientItem` để áp dụng cho mọi thẻ khi chơi. Các instance trong `choicePreviews`/`ingredientPreviews` chỉ minh họa bố cục trong Editor và được ẩn khi chạy; override riêng trên thẻ mẫu không áp dụng cho danh sách runtime. Danh sách tạo thêm thẻ theo dữ liệu, tái sử dụng khi refresh/đổi món/resize và ẩn thẻ dư; số thẻ mẫu không giới hạn số công thức hay nguyên liệu. `FactoryPanel` giữ việc chọn món, tìm nguồn và giao dịch; View con giữ phần hình, chữ và trạng thái thẻ.

Mở riêng `FactoryDialogFrame.prefab` để chỉnh khung ngoài của máy. `Background` dùng Sprite `buildingWindow` gốc với nine-slice và scale 0.42, giữ viền dày, phần tiêu đề nhô lên và bóng; `Title` dùng font/màu gốc; `close-panel/CloseFace` dùng hình nút X gốc. Đổi hình/màu ở Sprite, font ở Label, vị trí X bằng `Top`/`Right` của Widget trên `close-panel`. Editor hiển thị trực tiếp các Sprite/Label này. Runtime chỉ đổi kích thước gốc, scale toàn khung theo màn hình và tên máy; không vẽ lại kiểu khung khác. Khi so với game điện thoại, đặt UITransform của root bằng kích thước khung đang chạy; mặc định prefab là 560×450, điện thoại 393px dùng khung 369×450. `DialogShellView.factoryDialogPrefab` giữ tham chiếu nguồn và tạo một instance để tái sử dụng khi đổi món/refresh. Chạy `node game/ola-farm/tools/build-factory-dialog-frame.cjs` giữ nguyên chỉnh sửa Inspector; chỉ thêm `--reset` khi chủ động muốn khôi phục mẫu UI gốc.

`LivestockBody` chỉ giữ vùng thức ăn, hàng `HerdSlot`, hai nút chăm đàn và nhánh xem chuồng chưa xây. Các node cũ cho số con lặp, bán/quản lý đàn và đường dẫn nguồn đã được xóa khỏi prefab cùng các binding không còn dùng.

Giữ tên, thứ tự và liên kết bắt buộc của `FarmMapLayout`/`FarmItemLibrary`. `Livestock/Cell12–Cell21` giữ mười anchor; bốn chuồng nhà 1 dùng plot 12–15; bốn chuồng nhà 2 dùng plot 50–53 (`cell: null`) và anchor riêng. Các preview chuồng/ao cũ đã bỏ. Cây dùng các stage trong prefab; vật nuôi dùng các lớp gốc và chuyển động Cocos theo trạng thái, không phải phát lại nguyên Unity Animator. Thứ tự sân sau → đàn → hàng rào trước phải được giữ.

Các prefab nguồn đã nhỏ theo đối tượng nên được giữ nguyên: 21 prefab Farm Town gồm 8 máy, 4 loài, 4 sân và 5 cây; thư viện `assets/farm/prefabs/items/` có 100 prefab cảnh quan/công trình/cây/con vật/ô đất. Không tách riêng từng lớp thân, mái hay hàng rào vì chúng cùng tạo một đối tượng có thứ tự vẽ và chuyển động chung. Menu văn bản ngắn, toast và các primitive Label/Button vẫn được dựng bằng code khi cần; không cần thêm prefab cho từng phần tử đơn lẻ.

`HUD.prefab` liên kết ngay trong scene, nên xem được trước khi gameplay chạy. Các module popup và thanh thao tác có cấu trúc và art thật để mở riêng trong Editor, được instantiate khi dùng. Khi refresh, code chỉ bind nội dung/trạng thái và cập nhật layout đáp ứng theo baseline đã chỉnh. Đừng xóa component View hoặc làm rỗng các property đã gán trong Inspector. Các tên node đang dùng trong adapter cũng là liên kết cần giữ. `DialogShellView.title.font` dùng cho popup thường, `buildingTitleFont` dùng cho header máy/chuồng; đổi font tại property tương ứng.

## Dữ liệu sinh tự động

`source-assets/farm-beautify/layout.json` cấu hình cảnh; `placements.json`/`forest.json` và các nhóm decor/rừng được generator sinh lại. `tools/plant-forest.cjs` có seed ổn định nhưng thay các node nó quản lý: build thường không chạy generator và giữ các chỉnh sửa trong prefab vùng. Chạy lại generator sẽ đặt lại các placement nó quản lý theo cấu hình/seed; nếu muốn tái sinh lâu dài, chỉnh cấu hình thay vì chỉ kéo tay từng cây. Runtime đưa các placement ra cùng lớp depth để cây/đá vẫn che khuất đúng, giữ world transform và trạng thái ẩn đã đặt trong Editor.

`tools/farm-layout.cjs` đọc anchor và dữ liệu footprint, sinh `assets/farm/data/farm-layout/layout.json`, `assets/farm/scripts/core/generated/FarmLayoutManifest.ts` và `assets/farm/scripts/map/generated/BuildingPresentationData.ts`. Không sửa tay các đầu ra này. `core/FarmLayoutData.ts` giữ điểm truy cập nhỏ, ổn định cho hình học va chạm; dữ liệu hiển thị nằm ở tầng map. Footprint sân/máy ghi hình học và hash nguồn trong `pen-footprints.json`/`machine-footprints.json`; khi thay art phải tạo lại và kiểm hình học trước khi dùng bố cục mới. Bản đồ hiện không có road; ruộng và sân giữ nguyên các ID phục vụ bản lưu.

```sh
npm run verify --prefix game/ola-farm
npm run typecheck --prefix game/ola-farm
node game/ola-farm/tools/farm-layout.cjs --check
```

`verify` kiểm manifest/asset, liên kết prefab/meta, toàn bộ graph scene/prefab (ownership, local reference, UUID/type ngoài asset) và domain tests. Sau khi build bằng Creator, dùng các browser test phù hợp trong `game/ola-farm/tests/`; hình học, ảnh thực và thao tác cần được kiểm trên bản build đã thay đổi. Importer là công cụ tái tạo từ nguồn, không phải bước bắt buộc khi mở project. Trước khi chạy một importer, đọc phạm vi đầu ra của nó để tránh ghi đè asset đã chỉnh trong Editor.

`tools/extract-hud.cjs` là migration một lần; chạy lại chỉ kiểm prefab đã liên kết, không ghi đè HUD. Các `build-*-*.cjs` tạo mặc định UI là công cụ reset có chủ đích, không nằm trong build/verify; không chạy chúng sau khi chỉnh Inspector nếu muốn giữ art đã chỉnh. Helper `ui-prefab-builder.cjs` giữ fileId ổn định và `.meta` hiện có. `tools/ui-prefab-paths.cjs` là bảng đường dẫn dùng chung của công cụ UI; UUID gốc độc lập với thư mục để tái tạo cũng không đổi liên kết. Khi chuyển nhóm, di chuyển cả `.prefab` và `.meta`, cập nhật bảng đường dẫn và chạy các kiểm tra graph/prefab.

`tools/extract-factory-cards.cjs` là migration một lần từ các thẻ gốc trong FactoryBody, giữ ảnh/font/màu và baseline offset khi trích. Chạy lại chỉ kiểm các liên kết hiện có. `factory-cards-prefab.test.ts` kiểm graph/binding và phần chuồng đã dọn; sau khi build, `factory-cards.browser.cjs` kiểm giao diện mặc định, chỉnh Inspector, 7 công thức/6 nguyên liệu bằng fixture riêng, tìm nguồn, resize, trừ nguyên liệu một lần và chăm đàn trên ba kích thước màn hình.

Nhánh nhập vật nuôi hiện hành là [import-town-husbandry.py](../../tools/import-town-husbandry.py), dùng helper [farm-town-prefab.py](../../tools/farm-town-prefab.py). Helper giữ cách serialize prefab/UUID; không có bước chạy lại importer đầy đủ cũ để thay toàn bộ catalog.

`node game/ola-farm/tools/prepare-item-edit-check.cjs` tạo project thử riêng trong `artifacts/`, dịch Visual của loài rừng đầu tiên 17 đơn vị và Stage3 của Wheat 11 đơn vị; đồng thời dịch root/placement của `ForestNE` và tắt `ForestNW` để kiểm việc giữ transform và visibility sau khi đổi parent. Build project được in ra, rồi chạy `item-prefabs.browser.cjs` với `COCOS_ITEM_BUILD`, `COCOS_ITEM_SOURCE` (thư mục `assets/farm/prefabs/items` của bản sao) và `COCOS_ITEM_EDIT_TEST=1`. Test yêu cầu có instance thật và đối chiếu vị trí với prefab đã chỉnh; project chính không bị sửa.
