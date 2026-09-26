# Ola Farm — Cocos Creator 3.8.8

Project vào từ **`assets/farm/scenes/Loading.scene`**, rồi mở **`assets/farm/scenes/Farm.scene`**: 40 ruộng, 8 giống cây, 4 loài vật nuôi, 8 loại máy, 23 công thức và 35 vật phẩm. Chuồng và máy cần mua xây khi đạt level và điều kiện sản phẩm. Cây mở từ level 1 đến 24; mỗi loại công trình có tối đa hai nhà, nhà thứ hai mở từ level 12 đến 54. Tối đa tám chuồng và 16 máy; mỗi chuồng tối đa 5 ô, mở ô kèm một con. [Luật chơi và giá hiện tại](docs/cocos/farm-town-husbandry-runtime.md) · [Cân bằng sản xuất](docs/cocos/farm-town-husbandry-balance.md) · [Thời gian thực và mô phỏng tiến trình](docs/cocos/real-time-economy.md).

## Trong monorepo Ola

Project nằm ở `game/ola-farm/`, dùng toolchain riêng (npm + Cocos Creator) và không thuộc workspace pnpm; vite, vitest và Docker của `game/` bỏ qua thư mục này. Bản chạy trong app là build release đã commit ở `game/public/ola-farm/`: `vite build` chép sang `dist/ola-farm/`, nên game chạy ở `/ola-farm/` cùng domain với các game khác. CI Linux không có Cocos Creator, vì vậy sau khi sửa code, prefab hay cấu hình phải build lại trên máy có Creator rồi commit `game/public/ola-farm/`:

```sh
pnpm -C game build:farm
```

Lệnh dùng [ola-web-mobile.json](build-configs/ola-web-mobile.json) (release, md5Cache); đặt `COCOS_CREATOR` nếu Creator nằm ở chỗ khác. Toàn bộ chỉ số game (giá, level, EXP, thời gian, nhà máy, chuồng, công thức, ruộng, kim cương) và các điểm cần chốt nằm ở [docs/chi-so](docs/chi-so/README.md). Kế hoạch backend trong `docs/backend/` viết cho repo farm-game cũ, đường dẫn `cocos/` trong đó tương ứng thư mục này.

## Chạy và build

Từ `game/ola-farm/`:

```sh
npm ci
npm run verify
```

Mở `game/ola-farm/` trong Creator 3.8.8 rồi mở scene `Loading`. Trong Build chọn **Web Mobile**, thêm cả **Loading** và **Farm**, đặt **Start Scene: Loading**, orientation **Auto**, output **farm-web-mobile**. File cấu hình build bên dưới đã có các thiết lập này (bản debug dùng cho browser test). Có thể dùng CLI trên macOS; thay đường dẫn Creator theo máy:

```sh
env -u ELECTRON_RUN_AS_NODE /Applications/Cocos/Creator/3.8.8/CocosCreator.app/Contents/MacOS/CocosCreator \
  --project "$PWD" --build "configPath=$PWD/build-configs/farm-web-mobile.json"
npm start
```

Windows PowerShell:

```powershell
$env:ELECTRON_RUN_AS_NODE = $null
& 'D:\cocos\editors\Creator\3.8.8\CocosCreator.exe' --project "$PWD" --build "configPath=$PWD\build-configs\farm-web-mobile.json"
npm start
```

Mở **http://127.0.0.1:4173**. CLI Creator trả exit 36 khi build thành công; cần kiểm tra log `Finished` và output. Build không nằm trong Git và phải tạo lại sau khi sửa code/prefab. Chạy game không cần APK hoặc thư mục khảo sát.

## Chỉnh giá, level, ô đất và thời gian

Bảng đầy đủ mọi con số hiện hành và khóa JSON tương ứng: [docs/chi-so](docs/chi-so/README.md).

Sửa [economy.json](assets/farm/bundles/farm-town/economy.json) để đổi giá xây nhà/chuồng, ô nuôi, hàng đợi, hạt/sản phẩm, ví/XP và ruộng mở sẵn hoặc mua mở theo level. Chạy `npm run config:check`; [bảng mục cấu hình và ví dụ](docs/cocos/economy-config.md).

Sửa [timing.json](assets/farm/bundles/farm-town/timing.json) để đổi thời gian của tám cây, bốn loài và 23 công thức; `durationSeconds` tính bằng giây. Chạy `npm run timing:check` từ `game/ola-farm/`, rồi khởi động lại Preview hoặc build lại Web Mobile. Lượt đã bắt đầu giữ timer trong save. [Cách chỉnh và áp dụng](docs/cocos/timing-config.md).

## Code và Editor

Các lớp xếp theo thứ tự `core → render → map → ui → app`; một file chỉ import lớp của mình hoặc lớp bên trái. `npm run layers:check` kiểm tra hướng import, `npm run format` chạy Prettier (cấu hình trong `.prettierrc.json`); cả hai nằm trong `verify`.

| Thư mục | Trách nhiệm |
| --- | --- |
| `assets/farm/scripts/core/` | Luật chơi, `FarmMigration.loadFarmState`, `FreshFarm`, save và `GameSession`; không import `cc` |
| `assets/farm/scripts/core/constants/` | Giới hạn, giá trị dự phòng và khóa lưu theo từng chức năng; giá/level đang chơi vẫn lấy từ JSON |
| `assets/farm/scripts/core/types/`, `core/enums/` | Kiểu dữ liệu theo domain và các nhóm giá trị chuỗi cố định; tách khỏi xử lý gameplay |
| `assets/farm/scripts/core/legacy/` | Dữ liệu và adapter đọc save cũ; giữ các snapshot hình học lịch sử |
| `assets/farm/scripts/core/generated/` | Hình học va chạm/bố cục được công cụ sinh ra |
| `assets/farm/scripts/map/generated/` | Scale và bounds hiển thị được công cụ sinh ra |
| `assets/farm/scripts/render/` | Bộ dụng cụ trình bày dùng chung: `Art`, `Ui`, `UiPrefabs`, `FarmButton`, kiểu dữ liệu map, icon và số đo |
| `assets/farm/scripts/map/` | `buildings`, `crops`, `camera`, `layout`, `assets`; View/model điều phối ở gốc, types và constants có file riêng |
| `assets/farm/scripts/ui/` | View và panel nằm chung từng chức năng (`shop`, `production`, `livestock`, `inventory`…); kiểu, enum và thông số ở các file riêng |
| `assets/farm/scripts/app/` | `bootstrap` khởi tạo Loading/Farm, `services` xử lý audio/save, `layout` bố trí UI và `debug` chứa API kiểm tra |

[Cách chia code, hằng số và prefab](docs/cocos/code-structure.md) chỉ rõ nơi sửa từng loại dữ liệu và cách tạo lại. Toàn bộ game nằm dưới `assets/farm/` (`scenes`, `scripts`, `prefabs`, `bundles`, `data`, `fonts`); chỉ `assets/resources/` đứng ngoài vì Cocos quy định. UI prefab để phẳng trong `assets/farm/prefabs/ui/`; chuyển thư mục vẫn giữ nguyên UUID và liên kết Inspector.

`GameSession.dispatch` áp action lên bản sao, lưu thành công rồi mới công bố state. UI không tự sửa luật chơi. Mỗi lần commit thay object `game`, nên `PanelHost` chỉ cần so identity và các mốc thời gian (cây chín, việc xong) để biết khi nào vẽ lại. Canvas dùng cạnh ngắn 720, hỗ trợ dọc/ngang; xoay màn hình cập nhật bố cục và camera.

**Canvas → GameRoot → FarmMap → World → Farm** liên kết `assets/farm/prefabs/map/scenes.prefab`. Mở prefab để chỉnh anchor map; rừng và bốn cạnh đá nằm trong 8 prefab ở `assets/farm/prefabs/map/`. **GameRoot → HUD** liên kết `assets/farm/prefabs/ui/HUD.prefab`. Thư mục UI còn có khung popup, nội dung máy/chuồng/kho, các thẻ lặp, thanh chọn hạt, thanh chăm đàn và bubble cây trồng. Component `UiPrefabs` trên Canvas giữ các liên kết; [bảng prefab và cách chỉnh](docs/cocos/asset-pipeline.md#chỉnh-trong-editor). Giữ nguyên UUID trong `.meta` khi di chuyển hoặc đổi tên asset. Liên kết component được kiểm tra bằng `npm run prefabs:check`.

**Màn hình tải:** mở `assets/farm/scenes/Loading.scene` để chỉnh trực tiếp trong Editor. `LoadingCanvas → LoadingScreen` là instance của `assets/farm/prefabs/ui/LoadingScreen.prefab`; nền, hình nông trại, chữ và thanh tiến trình đều được lưu bằng Sprite/Label/Widget, không vẽ hoặc tạo node lúc chạy. `LoadingSceneController` tải tài nguyên rồi preload scene `Farm`, chuyển scene và giữ Canvas loading che game đến khi `GameApp` đọc save, gắn dữ liệu vào map/HUD xong. Hai scene dùng chung bộ tài nguyên đã tải. Nếu tải lỗi, loading giữ nguyên và chặn thao tác. Play trực tiếp từ `Farm` trong Editor sẽ chuyển về `Loading` trước khi khởi tạo game.

Kiểm tra loading trên bản build mới bằng `node tests/loading-screen.browser.cjs` từ `game/ola-farm/`. Để kiểm tra Preview đang mở trong Creator, dùng PowerShell:

```powershell
$env:COCOS_TEST_URL = 'http://localhost:7456'
$env:PLAYWRIGHT_CHANNEL = 'msedge'
node tests/loading-screen.browser.cjs
```

Suite kiểm tra màn hình 393×585 và 1280×720, xoay/resize, tiến độ thật, chuyển scene và lỗi tải asset; Preview còn kiểm tra Play trực tiếp từ Farm. Có thể chọn một viewport bằng `COCOS_UI_VIEWPORT=393x585` hoặc `1280x720`, hoặc chạy riêng `COCOS_LOADING_CASE=error` / `direct-farm` (case cuối cần Preview URL). Bỏ các biến lọc để chạy đủ suite; không dùng hai bộ lọc cùng lúc. Báo cáo và ảnh nằm trong `artifacts/loading-screen/`.

Nguồn art và quy trình sinh lại nằm trong [asset pipeline](docs/cocos/asset-pipeline.md). Các manifest lưu nguồn, hash, pivot và viền cắt ảnh; tránh sửa trực tiếp file sinh tự động mà bỏ qua đầu vào của nó.

## Map và thao tác

Map có bốn cạnh viền đá phân cách khu xây dựng với rừng. Road và các patch `GiPatchMeadow1/2/3`, `GiPatchGrass1/2/3` đã bỏ khỏi map; cấu hình đường và patch rỗng để không sinh lại. Rừng, đá và decor sinh từ `source-assets/farm-beautify/layout.json`. [Hướng dẫn nguồn map](source-assets/farm-beautify/README.md).

Kéo/chụm/cuộn để xem map. **Menu → Nông trại** về góc gần khu ruộng và chuồng; kéo để tới máy xung quanh. Giữ công trình đã xây khoảng 0,45 giây, kéo và thả ở chỗ hợp lệ để lưu vị trí. [Di chuyển công trình](docs/cocos/di-chuyen-cong-trinh.md).

Lượt mới có **6 ô trồng và một ô đất xanh kế tiếp**. Chạm ô xanh để xem khóa/level hoặc giá mua; mỗi hai level mở quyền mua thêm một ô, tối đa 40 ô tại level 68. Xem [bảng giá đất](docs/cocos/land-purchase.md). Save cũ giữ nguyên đất đã mở.

UI mua đất có prefab riêng [LandPurchase.prefab](assets/farm/prefabs/ui/LandPurchase.prefab). Mở trong Editor để chỉnh `LandCard`: hình đất, khung, chữ, giá và nút mua/đóng. `LandPurchaseView` cập nhật dữ liệu và co cả thẻ theo màn hình, giữ vị trí/font/màu đã chỉnh trong prefab.

Chạm ô trống để chọn giống; giống chưa mở hiện level cần đạt. Giữ hạt giống để xem thông tin. Chạm ô đang trồng mở đồng hồ, xong ngay hoặc đào bỏ; chạm cây chín để thu. [Footer và bong bóng ruộng](docs/cocos/footer-o-dat.md).

Shop xây công trình với bộ đếm 0/2–2/2, giá + icon xu và điều kiện level. Mua con/mở ô trong bảng chuồng đang chọn. [Chỉnh Shop](docs/cocos/golden-island-shop.md).

Chạm chuồng mở thẳng popup; bảng quản lý chỉ hiện chuồng đang chọn với **5 ô trên một hàng kéo ngang**. Muốn đổi loài, đóng bảng rồi chọn chuồng khác trên map. Máy mở bảng công thức, hàng đợi và nhận thành phẩm. [Panel và thao tác](docs/cocos/farm-town-modals.md).

## Save và kiểm tra

Save hiện dùng state v7/pack v6/layout v6, profile `simple-1`, khóa `ola-farm-cocos-simple-v1`. Các phiên bản cũ được kiểm tra và chuyển đổi trước khi ghi. Khóa full `ola-farm-cocos-40-v1`, snapshot bố cục cũ, IDs và mã `farm40:*` còn cần cho tương thích. Không xóa chúng theo tên “legacy”. Lỗi ghi sẽ giữ giao dịch chờ để thử lại hoặc xuất dữ liệu. Profile hiện hành chạy 1×, dùng clock v1 tùy chọn để tính công việc đã trả tiền khi offline; job trong save cũ giữ snapshot, không tự nhận hàng hay cho ăn.

Khi chưa có khóa Ola, game đọc bản lưu từ khóa `happy-farm-cocos-*` tương ứng và ghi sang khóa Ola ở lần lưu thành công tiếp theo. Nội dung và các bản dự phòng trong khóa cũ được giữ nguyên. Nếu khóa Ola đã tồn tại nhưng lỗi, game mở chế độ phục hồi để tránh thay tiến trình mới bằng bản cũ. Các tên cũ còn trong code tương thích và fixture lịch sử phục vụ việc đọc bản lưu trước khi đổi tên.

```sh
npm run verify
npm run typecheck
node tests/economy-config.browser.cjs
node tests/timing-config.browser.cjs
node tests/construction-reset.browser.cjs
node tests/starter-slot-levels.browser.cjs
node tests/land-purchase.browser.cjs
npm run simulate:balance
```

`verify` kiểm asset/hash/UUID, prefab, TypeScript core và unit test. Full typecheck cần Creator tạo `temp/tsconfig.cocos.json`. Browser test cần build hiện tại và Playwright browser đã cài (`npx playwright install chromium`); trên Windows có thể đặt `$env:PLAYWRIGHT_CHANNEL = 'msedge'`. Các unit test khác trong `tests/` bao phủ save, map, vật nuôi và chế biến. Browser test lịch sử, gồm `real-time-economy.browser.cjs`, còn hard-code giá/level/6×/12× cần cập nhật trước khi dùng nghiệm thu bộ cân bằng mới. Các suite `construction-reset.browser.cjs`, `starter-slot-levels.browser.cjs` và `land-purchase.browser.cjs` kiểm luồng xây nhà, mở ô và mua đất hiện hành trên bản build mới. Mô phỏng xuất vào `artifacts/real-time-economy/`, giả lập luật và thao tác, không dự báo giữ chân người chơi.

`simple-farm.performance.cjs` mặc định chạy riêng 30 phút, không chạy build hoặc browser khác cùng lúc. Thời lượng rút ngắn chỉ kiểm tra fixture/luồng, không thay thế nghiệm thu hiệu năng. Báo cáo cục bộ trong `artifacts/` chỉ có giá trị cho phiên bản và phạm vi đã kiểm. Android/iOS cần nghiệm thu riêng trên thiết bị thật.

Giữ source, `.meta`, test fixture và manifest trong Git; không commit `library`, `temp`, `build`, `node_modules` hay `artifacts`.

## Cấu hình luật chơi và vận hành

[Bảng cấu hình đầy đủ](docs/cocos/configuration.md) chỉ rõ năm file runtime: `catalog.json`, `economy.json`, `timing.json`, `gameplay.json`, `runtime.json` trong `assets/farm/bundles/farm-town/`. Hai file mới giữ sức chứa, kho/con/ô khởi đầu, yêu cầu thu sản phẩm, lượng cám, autosave/offline, âm thanh, thông báo, thao tác và camera. Mặc định giữ nguyên cân bằng hiện tại. Chạy `npm run config:check`, lưu JSON và khởi động lại Preview hoặc build Web Mobile lại để áp dụng.
