# Nguồn cảnh quan và hình học Farm

`manifest.json` giữ file nguồn, SHA-256, object Unity, rect, pivot, trim offset và pixels-to-units của ảnh đã chọn. Runtime dùng các PNG trong `assets/farm/data/farm-decor/`; không cần chép ảnh thêm lần nữa vào thư mục này. Nguồn là asset của các game đã đối chiếu cho project, không phải tuyên bố giấy phép studio.

| Dữ liệu | Vai trò |
| --- | --- |
| `layout.json` | Cấu hình rừng, bãi cỏ, đường viền và decor |
| `placements.json`, `forest.json` | Kết quả sinh cảnh từ cấu hình/seed |
| `roads.json` | Mạng đường hiện rỗng; không có road trong runtime |
| `pen-footprints.json` | Footprint thật của bốn sân, tỉ lệ 784 đơn vị (=4 ô ruộng), source bounds/hash |
| `machine-footprints.json` | Footprint và full-art bounds của tám máy rộng 784 đơn vị |

Cây/props dùng pivot đã bù trim; culling và thứ tự vẽ xét bounds thật. Nền hoa ở dưới vật đứng. Rừng và viền theo bãi cỏ; không lấy tọa độ road cũ làm chướng ngại đặt công trình.

`tools/farm-decor-assets.cjs` nhập/kiểm art cảnh quan; `tools/plant-forest.cjs` sinh lại các nhóm cảnh nó quản lý với seed cố định. Build thường giữ chỉnh sửa trong prefab vùng; chạy lại generator sẽ đặt lại những node nó quản lý. Chỉnh cấu hình nếu muốn tái sinh bố cục lâu dài. `tools/farm-layout.cjs` đọc anchor trong `assets/farm/prefabs/map/scenes.prefab` và các footprint, sinh layout runtime/core. Generator giữ ID và UUID ổn định; kiểm trước/sau nếu thay art hoặc hình học.

```sh
node cocos/tools/farm-decor-assets.cjs --check
node cocos/tools/farm-layout.cjs --check
npm run verify --prefix cocos
```

`--check` dùng asset đã nhập, không cần bộ khảo sát ngoài repo. Xem [quy tắc chỉnh prefab](../../docs/cocos/asset-pipeline.md) và [đặt công trình/bản lưu](../../docs/cocos/di-chuyen-cong-trinh.md).
