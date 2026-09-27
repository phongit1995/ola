# Bộ ảnh bong bóng ô đất theo Golden Island

Mười PNG cho phần giao diện bám vào ô đất (cộng một icon KEN của Ola, xem cuối bảng), lấy đúng sprite mà prefab ô đất (`b_01`, script `Farm`) và `PlantingUI` của Golden Island tham chiếu. Đọc bundle bằng `reference/golden-island/analysis/plot_ui.py`; kết quả ở `reference/golden-island/analysis/plot_ui.json` và `images/plot-ui/`. `manifest.json` ghi node nguồn, SHA-256, kích thước và viền nine-slice `m_Border` của Unity theo thứ tự `[left, bottom, right, top]`. Đây là ghi nhận nguồn cho bản thử, không phải tuyên bố giấy phép của studio.

Từ gốc repo:

```sh
node cocos/tools/plot-ui-assets.cjs        # chép PNG vào assets/farm/bundles/farm-plot-ui và sinh .meta ổn định
node cocos/tools/plot-ui-assets.cjs --check
```

`--check` chỉ kiểm tra bản Cocos đã chuẩn bị, không cần `reference/`. Khác `farm-hud`, thư mục `assets/farm/bundles/farm-plot-ui/` **là bundle**: `Art.loadSkin` tải bundle; hình và font tĩnh đã liên kết trong `assets/farm/prefabs/ui/PlotBubble.prefab`, `SeedPicker.prefab` và `SeedTile.prefab`. Runtime instantiate prefab, bind dữ liệu và đặt bong bóng trên bản đồ.

| Khoá | Sprite gốc | Dùng ở đâu |
|---|---|---|
| `bubble` | `bg_information_item_1` | khung bong bóng cây đang lớn (200×110, viền 28) |
| `pill` | `BgMaterial` | nền viên thuốc chứa thời gian |
| `clock` | `IconTime` | icon đồng hồ |
| `button` | `bt_2` | nút xanh "xong ngay" (viền 31/49/32/49) |
| `gem` | `ss_001` | icon kim cương trên nút |
| `ready` | `bg_ctn` | bong bóng đã chín, chạm để thu |
| `locked` | `bg_ctn_khoa` | bong bóng ô chưa cải tạo |
| `tile` | `BgToolUI` | ô lục giác chọn giống |
| `select` | `Select` | viền vàng ở giống đang xem |
| `info` | `BgInfo` | thẻ thông tin giống |
| `ken` | Ola `web/src/assets/icons/apps/ken.png` | icon KEN (đồng xu vàng chữ K) trong form chuyển KEN sang kim cương; ảnh của chính Ola, không lấy từ Golden Island. `gem` cũng là icon kim cương dùng chung cho HUD, giá xong ngay trong Nhà máy và form này |

Chữ trong bong bóng dùng Poetsen One mà HUD đã liên kết sẵn trong scene (`assets/farm/fonts/hud/`), được liên kết trực tiếp trong các prefab UI để dùng chung tài nguyên font.
