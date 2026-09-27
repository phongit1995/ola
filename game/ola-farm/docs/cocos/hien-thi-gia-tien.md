# Hiển thị giá tiền và số

Trang này ghi cách game viết xu, kim cương, KEN và số lượng lên màn hình: hàm nào viết số, dùng ở đâu, và chỗ nào đang lỗi. Con số giá thì xem [Chỉ số game](../chi-so/README.md). Cách viết số trong bộ tài liệu đó (`1.250`) là quy ước của tài liệu, không phải cách game hiển thị.

Kiểm tra ngày 27/09/2026 trên code nhánh `feat/ola-farm` và bản build `game/public/ola-farm/`.

## Ba cách viết số đang có

| Cách viết | Ở đâu | 1000 | 12500 | 3080000 |
| --- | --- | --- | --- | --- |
| `format(n)` | [Format.ts](../../assets/farm/scripts/core/Format.ts) | `1.000` (tiếng Việt), `1,000` (tiếng Anh) | `12.500` / `12,500` | `3.080.000` / `3,080,000` |
| `formatWallet(n)` | [Format.ts](../../assets/farm/scripts/core/Format.ts) | `1,000` | `12,500` | `3,080,000` |
| Số thô: `String(n)`, hoặc số truyền thẳng vào câu `t(...)` | từng file UI | `1000` | `12500` | `3080000` |

- `format` đổi dấu phân cách theo ngôn ngữ đang chạy (`?lang=`, xem [README](../../README.md#ngôn-ngữ-vien)).
- `formatWallet` luôn dùng dấu phẩy, kể cả khi chơi tiếng Việt. Cách này chép theo `DString.ConvertToMoneyString` của bản Unity gốc.
- Game **chưa có cách rút gọn** kiểu `1K`, `12,5K` hay `1,2M`.

## Chỗ nào dùng cách nào

Cột "Giá lớn nhất" lấy từ [economy.json](../../assets/farm/bundles/farm-town/economy.json) hiện tại. Nó cho biết chỗ đó thực tế phải chứa số dài bao nhiêu.

| Nơi hiển thị | Cách viết | Giá lớn nhất | Code |
| --- | --- | --- | --- |
| HUD: số xu, số kim cương | `formatWallet` | — | [HudView.ts](../../assets/farm/scripts/ui/hud/HudView.ts) |
| HUD: nút Kho (tổng số món) | `format` | — | [HudView.ts](../../assets/farm/scripts/ui/hud/HudView.ts) |
| Hộp mua đất: giá, số dư, còn thiếu | `formatWallet` | 3.080.000 (ruộng cuối) | [LandPurchaseView.ts](../../assets/farm/scripts/ui/land/LandPurchaseView.ts) |
| Bảng Danh sách ô: "Mua đất · … xu" | `formatWallet` | 3.080.000 | [MenuPanels.ts](../../assets/farm/scripts/ui/menu/MenuPanels.ts) |
| Bảng Thêm xu: số xu mỗi gói | `formatWallet` | — | [MenuPanels.ts](../../assets/farm/scripts/ui/menu/MenuPanels.ts) |
| Kho: giá bán, số lượng, tiền nhận, thống kê, số trên thẻ | `format` | giá bán 960 | [InventoryPanel.ts](../../assets/farm/scripts/ui/inventory/InventoryPanel.ts), [StockCardView.ts](../../assets/farm/scripts/ui/inventory/StockCardView.ts), [InventoryBodyView.ts](../../assets/farm/scripts/ui/inventory/InventoryBodyView.ts) |
| Form đổi KEN sang kim cương | `format` | — | [GemExchangePanel.ts](../../assets/farm/scripts/ui/menu/GemExchangePanel.ts) |
| Ô hàng chờ nhà máy: giá mở ô | số thô | 320 | [FactoryQueueSlotView.ts](../../assets/farm/scripts/ui/production/FactoryQueueSlotView.ts) |
| Nhà máy: giá xong ngay (kim cương) dưới từng món | số thô | — | [FactoryPanel.ts](../../assets/farm/scripts/ui/production/FactoryPanel.ts) |
| Bong bóng ô đất: giá xong ngay (kim cương) | số thô | — | [PlotBubbles.ts](../../assets/farm/scripts/map/crops/PlotBubbles.ts) |
| Thẻ Shop: giá xây máy, xây chuồng; "Cần thêm … xu" | số thô | 44.000 (máy), 22.000 (chuồng) | [ShopPanel.ts](../../assets/farm/scripts/ui/shop/ShopPanel.ts), [ShopCardView.ts](../../assets/farm/scripts/ui/shop/ShopCardView.ts) |
| Bảng chuồng: giá mở ô, giá mua con, giá xong ngay, nút "Xây chuồng + … · … xu" | số thô | 180 (ô), 600 (con) | [LivestockPanel.ts](../../assets/farm/scripts/ui/livestock/LivestockPanel.ts) |
| Ô chọn giống: giá hạt | số thô | 220 | [SeedTileView.ts](../../assets/farm/scripts/ui/crops/SeedTileView.ts) |
| Danh sách máy, nguồn nguyên liệu: "Xây · … xu", "Chưa mua · … xu" | số thô | 44.000 | [ProductionBrowser.ts](../../assets/farm/scripts/ui/production/ProductionBrowser.ts) |
| Thông báo (toast) khi mua, mở ô, xây: "Cần 1000 xu để mở ô.", "Đã mở ô thứ 3 · −200 xu" | số thô | 3.080.000 | [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts) |
| Thông báo khi bán: "Đã bán … · +… xu" | `format` | — | [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts) |
| Thông báo khi đổi gói xu: "+… xu · −… kim cương" | dấu phẩy, như `formatWallet` | — | [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts) |

## Ô hàng chờ nhà máy

Mỗi ô chưa mở luôn hiện giá mở ô (kèm icon xu) ở nửa dưới. Nửa trên có 3 kiểu:

| Kiểu | Khi nào | Nửa trên |
| --- | --- | --- |
| Mua được ngay | Ô kế tiếp và đã đủ level | Dấu `+` màu xanh; bấm để mua |
| Chưa tới lượt | Đủ level nhưng còn ô trước chưa mua | Icon ổ khóa |
| Chưa đủ level | Level người chơi thấp hơn level của ô | Chữ `Lv 25`, không có ổ khóa |

Hiện chỉ Máy thức ăn có mốc level cho ô chờ (5/10/15/20); các máy khác đều level 1 ([06](../chi-so/06-nha-may.md)).

Đã thử giá 1.000 / 12.500 / 150.000 / 1.250.000 ở 3 cỡ màn (điện thoại dọc, ngang, máy tính). Giá chỉ đổi trong bộ nhớ trang, không đổi config:

- Từ 1 đến 5 chữ số (`1000`, `12500`) vừa ô.
- Từ 6 chữ số (`150000`, `1250000`), chữ bị thu nhỏ (Label để chế độ SHRINK) và **đè lên icon xu**.
- Giá ô chờ hiện cao nhất 320, nên khi chơi thật chưa gặp lỗi này.

## Vấn đề hiện tại

1. **Ba cách viết lẫn nhau trên cùng màn hình.** HUD viết `47,500`, Kho viết `7.800`, thẻ Shop viết `4860`.
2. **`formatWallet` luôn dùng dấu phẩy.** Chơi tiếng Việt vẫn thấy `47,500` ở HUD nhưng `7.800` trong Kho.
3. **Ô nhỏ không rút gọn.** Số dài chỉ còn cách thu nhỏ chữ. Ô hàng chờ đè icon từ 6 chữ số. Thẻ Shop phải chứa tới `44000`.
4. **Toast viết số thô.** Ví dụ `Cần 1290000 xu` khó đọc hơn `Cần 1.290.000 xu`.

## Đề xuất (chưa làm, chờ chốt)

1. **Thêm hàm rút gọn cho ô nhỏ** (ô hàng chờ, ô chuồng, thẻ Shop, ô chọn giống, giá xong ngay):

   | Số | Tiếng Việt | Tiếng Anh |
   | --- | --- | --- |
   | 999 | `999` | `999` |
   | 1000 | `1.000` | `1,000` |
   | 4860 | `4.860` | `4,860` |
   | 12500 | `12,5K` | `12.5K` |
   | 150000 | `150K` | `150K` |
   | 1250000 | `1,25M` | `1.25M` |

   Dưới 10.000 viết đủ, có dấu phân cách. Từ 10.000 trở lên rút gọn, giữ tối đa 3 chữ số có nghĩa.
2. **Chỗ rộng viết đủ số, có dấu phân cách theo ngôn ngữ.** Gồm HUD, hộp mua đất, Kho, danh sách máy và toast.
3. **Ô chưa đủ level:** hiện ổ khóa kèm `Lv 25` và ẩn giá. Tới level mới hiện giá.

Cần chốt:

- Rút gọn từ 1.000 (`1K`) hay từ 10.000 như bảng trên?
- HUD giữ dấu phẩy kiểu Unity (`47,500`) hay theo ngôn ngữ (`47.500` khi chơi tiếng Việt)?

Đã ghi thành mục D9 ở [Điểm cần chốt](../chi-so/12-diem-can-chot.md#d-nội-dung-và-luật). Làm xong thì cập nhật bảng "Chỗ nào dùng cách nào" ở trên.
