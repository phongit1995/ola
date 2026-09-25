# Cách chia code, hằng số và prefab

Project game hiện tại nằm trong `cocos/`. Cấu trúc này chia theo trách nhiệm: luật chơi, hiển thị bản đồ, giao diện và nguồn dữ liệu. Một chức năng có thể có code ở nhiều lớp; prefab giữ hình và liên kết component, còn giao dịch đi qua `GameSession`.

## Thư mục assets

Toàn bộ game nằm dưới một thư mục gốc `assets/farm/`; chỉ `assets/resources/` đứng ngoài vì Cocos quy định vị trí của nó.

| Thư mục | Vai trò |
| --- | --- |
| `assets/farm/scenes/` | Hai điểm vào Loading và Farm. |
| `assets/farm/scripts/` | TypeScript của game, chia lớp rồi chia chức năng. |
| `assets/farm/prefabs/ui/` | 19 prefab giao diện để phẳng; `tools/ui-prefab-paths.cjs` giữ tên và UUID. |
| `assets/farm/prefabs/map/` | `scenes.prefab`, `CropPlot.prefab` và tám vùng `Border0–3`, `ForestNE/NW/SE/SW`. |
| `assets/farm/prefabs/items/` | Thư viện đối tượng map: `animals`, `buildings`, `crops`, `plots`, `scenery` và `catalog.json`. |
| `assets/farm/bundles/` | Bốn bundle Cocos (`farm-town`, `farm-town-ui`, `farm-plot-ui`, `golden-island-ui`): ảnh, manifest, JSON cấu hình và prefab thuộc bundle. Tên thư mục là tên bundle được `loadBundle` gọi. |
| `assets/farm/data/` | Nội dung không phải bundle: `farm-decor`, `farm-hud`, `farm-layout`. |
| `assets/farm/fonts/` | Font được các prefab tham chiếu. |
| `assets/resources/ported/` | Dữ liệu được `resources.load` tải theo đường dẫn; thư mục này phải nằm ngay dưới `assets/`. |

Code không để chung một tầng thư mục. Các nhóm chính trong `assets/farm/scripts/`:

```text
core/       luật chơi; types/, constants/, enums/, utils/, legacy/, generated/
render/     bộ dụng cụ Cocos; types/, constants/, enums/
map/        assets/, buildings/, camera/, crops/, layout/, types/, constants/, generated/
ui/         shop/, production/, livestock/, inventory/, crops/, land/, hud/, loading/, menu/, shared/
app/        bootstrap/, services/, debug/, layout/
```

`ui/panels/index.ts` là registry nối tên panel với implementation trong từng chức năng. Các module điều phối như `FarmGame`, `FarmMapView` vẫn có tên riêng; chúng import types/constants từ nơi sở hữu.

## Luồng logic

```text
app → ui → map → render → core
```

File được dùng lớp cùng cấp hoặc các lớp bên phải trong sơ đồ. `core` không import Cocos (`cc`). `tools/check-layers.cjs` kiểm hướng import.

| Nơi quản lý | Trách nhiệm |
| --- | --- |
| `assets/farm/scripts/core/FarmGame.ts` | Thực thi thao tác và điều kiện của game trên state. |
| `assets/farm/scripts/core/GameSession.ts` | Điều phối thao tác, ghi save rồi công bố state. |
| `assets/farm/scripts/core/FarmCatalog.ts` | Tra cứu cây, công thức, vật phẩm và vị trí công trình trong catalog. |
| `assets/farm/scripts/core/constants/` | Hằng số, giới hạn và giá trị dự phòng theo sản xuất, vật nuôi, ví, tiến trình, session và khóa lưu. |
| `assets/farm/scripts/core/types/` | Kiểu catalog, state, action, save, hình học và schema cấu hình; chỉ có khai báo kiểu. |
| `assets/farm/scripts/core/enums/` | Nhóm giá trị định danh cố định, giữ nguyên chuỗi dùng trong JSON/save. |
| `assets/farm/scripts/core/legacy/` | Dữ liệu mặc định và adapter cho bản game/save trước đây. Snapshot hình học cũ phục vụ xác thực, không sửa theo layout mới. |
| `assets/farm/scripts/map/` | Camera, vị trí hiển thị, vùng chạm, kéo thả và render công trình. |
| `assets/farm/scripts/ui/` | View và panel: bind dữ liệu vào prefab, nhận thao tác người chơi và gọi action. |
| `assets/farm/scripts/app/` | Loading, khởi tạo game và kết nối session/map/UI. |

## Hằng số và cấu hình

Trong từng chức năng, file logic chứa hàm/class; `*.types.ts` chứa interface/type; `*.constants.ts` chứa thông số và bảng dữ liệu cố định; `*.enum.ts` chứa nhóm giá trị có tên. Ví dụ thanh gieo trồng có `ui/crops/PlotFooter.ts`, `PlotFooter.types.ts` và `PlotFooter.constants.ts`. Kiểu dùng chung của core nằm trong `core/types/`, hằng số tương ứng ở `core/constants/`.

Các nhóm như loại ô đất, chế độ camera và tên panel dùng object `as const` trong file enum, rồi suy ra union type ở file type. Cách này giữ nguyên các chuỗi hiện có trong save và vẫn kiểm tra được giá trị hợp lệ. Các import chỉ phục vụ kiểu dùng `import type`; đọc hằng số từ module sở hữu nó. `FarmTypes.ts` là điểm xuất lại kiểu cho các consumer cũ; `isRecord` nằm riêng trong `core/utils/TypeGuards.ts`.

Hàm hỗ trợ thuật toán và cache ở lại file logic. Giá trị mặc định của `@property` ở lại component để Inspector tiếp tục chỉnh được. Không cần tách từng số trung gian trong một phép tính thành một hằng số công khai.

| Muốn thay đổi | Sửa ở đâu |
| --- | --- |
| Nội dung, ID vật phẩm/công trình, công thức, liên kết art | `assets/farm/bundles/farm-town/catalog.json` |
| Giá, level, XP, ví và đất mở sẵn | `assets/farm/bundles/farm-town/economy.json` |
| Thời gian trồng/nuôi/sản xuất | `assets/farm/bundles/farm-town/timing.json` |
| Sức chứa, lượng cám, nội dung khởi đầu và điều kiện thu sản phẩm | `assets/farm/bundles/farm-town/gameplay.json` |
| Autosave/offline, âm thanh, camera và thao tác | `assets/farm/bundles/farm-town/runtime.json` |
| Giới hạn code hỗ trợ hoặc giá trị dự phòng khi đọc dữ liệu thiếu cấu hình | Module tương ứng trong `assets/farm/scripts/core/constants/` |
| Vị trí mặc định trên map | Anchor trong `assets/farm/prefabs/map/scenes.prefab`, rồi chạy `tools/farm-layout.cjs` |
| Chân nhà và kích thước nguồn | `source-assets/farm-beautify/`, qua công cụ đo footprint và generator layout |

Các giá trị dự phòng trong TypeScript không thay thế JSON của game hiện tại. Không tạo thêm một bản giá/level trong View hoặc một file `Constants.ts` gom mọi chức năng. Đọc trực tiếp module sở hữu giá trị đó. Xem [bảng cấu hình](configuration.md) để biết schema và cách áp dụng.

`FarmLayoutData.ts` chỉ xuất hình học dùng cho va chạm/save. Phần dữ liệu lớn được tạo tự động nằm ở hai nơi riêng:

- `core/generated/FarmLayoutManifest.ts`: vị trí, footprint, chướng ngại và biên map.
- `map/generated/BuildingPresentationData.ts`: scale và bounds của hình hiển thị.

Hai phần cùng lấy dữ liệu nguồn từ `tools/farm-layout.cjs`, nên không cần chép số đo giữa code logic và code render. Không chỉnh trực tiếp file trong `generated/`.

## Prefab

`assets/farm/prefabs/ui/` để phẳng 19 prefab giao diện; tên prefab đã nói rõ chức năng:

| Prefab | Nội dung |
| --- | --- |
| `DialogShell` | Khung popup dùng chung. |
| `HUD`, `LoadingScreen` | HUD và màn hình tải. |
| `Shop`, `ShopCard` | Cửa hàng và thẻ mua công trình. |
| `FactoryDialogFrame`, `FactoryBody`, `FactoryQueueSlot`, `RecipeChoice`, `IngredientItem` | Khung xưởng, nội dung sản xuất, hàng đợi, công thức và nguyên liệu. |
| `LivestockBody`, `HerdSlot`, `HerdQuickBar` | Quản lý chuồng, ô vật nuôi và thanh chăm đàn. |
| `InventoryBody`, `StockCard` | Kho và thẻ vật phẩm. |
| `SeedPicker`, `SeedTile`, `PlotBubble` | Chọn giống, thẻ hạt và bong bóng ô đất. |
| `LandPurchase` | Bảng mua đất. |

`assets/farm/prefabs/map/` giữ bản đồ và tám vùng cảnh quan; `assets/farm/prefabs/items/` giữ thư viện đối tượng. Các mô hình Farm Town trong `assets/farm/bundles/farm-town/prefabs/` tiếp tục nằm cùng bundle ảnh và manifest của chúng. Không chuyển chúng vào UI hoặc tách khỏi bundle chỉ để gom mọi prefab về một thư mục.

Một prefab giữ một đối tượng giao diện/công trình hoặc một phần được lặp lại độc lập. Ví dụ `FactoryBody` dùng các thẻ công thức/nguyên liệu; không tách từng Sprite của mái hoặc chân máy thành prefab riêng. Component `UiPrefabs` và các View giữ liên kết Inspector theo UUID.

`tools/ui-prefab-paths.cjs` quản lý đường dẫn phục vụ generator và kiểm thử. UUID của tài nguyên độc lập với đường dẫn hiện tại. Khi chuyển prefab, mang theo `.meta`; khi sinh lại, giữ định danh đã dùng trong scene. Xem [asset pipeline](asset-pipeline.md) để biết prefab nào cần mở trong Editor.

Script component cũng mang theo `.ts.meta` khi chuyển thư mục. Công cụ authoring dùng `componentScript`/`componentTypeByName` trong `tools/cocos-ids.cjs` để tìm đúng `@ccclass` và đọc UUID từ meta; tên trùng hoặc thiếu sẽ báo lỗi. Đây là tra cứu của công cụ, còn runtime giữ liên kết Inspector đã lưu trong scene/prefab.

## Kiểm tra sau khi sửa

Từ gốc repo:

```sh
node cocos/tools/farm-layout.cjs --check
npm run verify --prefix cocos
npm run typecheck --prefix cocos
```

`verify` kiểm asset/UUID, đồ thị prefab, hướng phụ thuộc, cách tách logic/type/constants/enum, format, TypeScript core và unit test. `npm run structure:check --prefix cocos` kiểm riêng quy tắc tổ chức code để tránh trộn trở lại. Sau khi đổi đường dẫn prefab hoặc module runtime, build lại bằng Creator và kiểm tra luồng mở UI trên bản build mới; build cũ không phản ánh thay đổi nguồn.
