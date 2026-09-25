# Bộ ảnh HUD theo Golden Island

Chín PNG cho phần đầu màn hình, lấy đúng các sprite mà prefab `GameplayMainUI/SafeArea/PanelTop` của Golden Island tham chiếu (đọc bundle bằng `reference/golden-island/analysis/ui_tree.py`, xuất bằng `export_hud.py`; kết quả ở `reference/golden-island/images/hud-exact/` và `analysis/hud_exact.json`). `manifest.json` ghi node nguồn, SHA-256, kích thước và viền nine-slice `m_Border` của Unity theo thứ tự `[left, bottom, right, top]`. Đây là ghi nhận nguồn cho bản thử, không phải tuyên bố giấy phép của studio.

Từ gốc repo:

```sh
node cocos/tools/hud-assets.cjs        # chép PNG vào assets/farm/data/farm-hud/images và sinh .meta ổn định
node cocos/tools/hud-assets.cjs --check
```

`--check` chỉ kiểm tra bản Cocos đã chuẩn bị, không cần `reference/`. UUID sprite frame là `stableId('farm-hud/<id>/image')` nên scene tham chiếu được trước khi Creator import. Thư mục `assets/farm/data/farm-hud/` không phải bundle: scene chính tham chiếu trực tiếp các sprite frame này.

Bố cục trong `assets/farm/scenes/Farm.scene` (`Canvas → GameRoot → HUD → Header`) lấy tọa độ prefab gốc (canvas 1920×1080) nhân 0,6:

- `Level` (neo trái): `AvatarBacking` + `Avatar` + `AvatarFrame`; `XpTrack` gồm `Background` (bg_cani) và `XpFill` là node Mask có scale 0,6 chứa `FillWhole` (exp, vẽ trọn chiều dài) — `HudView.refresh` chỉ đổi chiều rộng node Mask theo `core/Progression.ts`; `XpText` "hiện tại / cần"; `Star` + `LevelNumber` chồng đầu thanh.
- Không còn dòng ngày. Chữ số dùng Poetsen One (`assets/farm/fonts/hud/`, OFL) với cỡ/viền theo TMP gốc: XP và level 42 → 25, viền nâu (117,8,0); ví 39 → 23, viền đen 43 %.
- Bên phải: `CoinWallet` (Box bg_cani, icon xu cũ, số căn giữa giữa icon và nút, `coins-plus` = bt_+ mở bảng "Thêm xu"), `DiamondWallet` (Box, diammond, `gems-plus` mở bảng "Thêm kim cương" dạng xem trước), `pause-menu` (bt_setting).

Sprite nine-slice (`bg_cani`, `exp`) được đặt ở kích thước gốc trên node con có scale 0,6 để viền 24 px không bị ép. Có thể chỉnh vị trí, kích thước và Widget trong Inspector.
