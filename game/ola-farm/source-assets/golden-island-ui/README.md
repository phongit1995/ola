# Giao diện công trình và Shop Golden Island

Bundle `assets/farm/bundles/golden-island-ui` giữ 26 PNG được dùng trong Cocos: 16 thành phần modal và 10 thành phần Shop, lấy từ các `Image` của Golden Island 1.0.24. Mỗi ảnh được chọn bằng đường dẫn node prefab và PPtr, vì nhiều sprite nguồn trùng tên nhưng khác hình. Manifest ghi hash bundle nguồn, ID 64 bit dạng chuỗi, kích thước, border, node và SHA-256 PNG. Không cần `reference/` để build hoặc kiểm bundle đã nhập.

Tạo lại từ nguồn cục bộ, dùng Python có UnityPy và Pillow:

```sh
reference/venv/bin/python cocos/tools/import-island-ui.py --source reference/golden-island
node cocos/tools/check-island-ui.cjs
```

PNG giữ nguyên ảnh xuất từ sprite nguồn, không nhuộm màu hoặc ghép thành khung mới. Border dùng thứ tự `[left, bottom, right, top]`. Riêng `panelInfo` có border dọc nguồn chồng nhau (`79 + 74 > 136`); importer giữ tỷ lệ hai cạnh và một pixel tâm để Cocos không lấy vùng tâm âm. `sourceBorder` vẫn giữ số gốc.

| Nhóm | Key trong bundle | Thành phần gốc |
| --- | --- | --- |
| Khung chung | `window`, `inset` | `Ui2`, `Ui1` trong InventoryUI/PopupMissingMultiple |
| Khung công trình | `buildingWindow`, `panelInfo`, `card` | `Popup`, `popup1`, `ui1` trong UpgradeHouseUI |
| Điều khiển | `close`, `green` | Nút X đỏ nhô cạnh và nút xanh gốc; hành động phụ dùng nền `card` |
| Sản xuất | `recipe`, `selected`, `slot`, `material`, `info` | Thẻ lục giác, ô hàng đợi và nguyên liệu của CraftingUI |
| Kho | `tab`, `tabInactive`, `progress`, `progressFill` | Tab và thanh trạng thái InventoryUI |
| Tab Shop | `shopTab`, `shopTabOpen`, `shopRim` | `UImain3`, `StateOpen`, `UImain` trong BuildingUI |
| Danh mục Shop | `shopBuilding`, `shopAnimal` | `IconBuilding`, `IconAnimal` trong BuildingUI |
| Thẻ Shop | `card`, `shopCardLocked`, `shopPrice`, `shopLock`, `shopQuantity` | Nền mở khóa `ui1` dùng chung PPtr với `card` cũ; nền khóa `ui2`, dải `lockui1`, ổ khóa và `bg_slot` của HouseBuildingUI/AnimalBuildingUI |
| Mở Shop | `navShop` | `icon_building` tại GameplayMainUI/SafeArea/PanelBot/GroupLeft/Building; ảnh 196 × 224, giữ tỉ lệ 0,875 |

`UpgradeHouseUI` gốc có khung yêu cầu 967,41 × 591,07 tại `(174,87; -24,24)` và bảng thông tin 338,55 × 549,1 tại `(-488,78; -43,13)`, theo canvas 1920 × 1080. Khung `buildingWindow` có mấu tiêu đề sẵn trong ảnh; không ghép thêm thanh tiêu đề Farm Town. Tên công trình dùng nâu gạch RGB `(188,66,47)`; tiêu đề thẻ và mô tả dùng `(161,66,50)`; chữ nút xanh màu trắng.

Header của khung này nằm trong sprite `Popup`, không có ảnh Heading riêng. `TextName` ở `(0; 254,5)`, khung chữ `700 × 63,75`, cỡ tối đa 48 (autosize 18–48), font **Poetsen One Regular**, màu `(188,66,47)`. PPtr font trỏ tới `Poetsen` trong `CAB-63791d93676d2809591e8b1d6988d46d`; `Poetsen Material` có `_OutlineWidth=0` và không bật keyword underlay, nên không thêm viền hoặc bóng chữ. `ButtonClose` ở `(505;125)`, hình `92 × 88`: tâm nằm ngoài cạnh phải panel khoảng 21,295 đơn vị nguồn. Đây là nút gắn bên hông khung, không phải icon nhỏ đặt sát tên công trình.

`CraftingUI` gốc là lớp thao tác quanh công trình trên map: thẻ lục giác hai bên, ba ô hàng đợi phía dưới và bảng nguyên liệu nổi. Nó không dùng khung cam đặc quanh toàn bộ màn hình. Bản Cocos có thể dùng các thành phần này trong modal thích ứng màn hình, giữ luật sản xuất hiện hành; đó là bố cục chuyển sang Cocos, không phải bản phát lại giao diện Unity.

Shop công trình/vật nuôi gốc là **BuildingUI**, khác `ShopPanel` bán gói IAP. Nó trượt lên từ đáy màn hình, có năm tab biểu tượng Building/Animal/Energy/Decor/Storage và hàng thẻ cuộn ngang. Hai tab Vật nuôi/Công trình của Cocos lấy thành phần từ hai danh mục đầu; việc rút còn hai tab, thêm nhãn tiếng Việt và mua bằng xu theo giá/điều kiện Ola Farm là phần chuyển đổi sang Cocos. Kinh tế gem của Golden Island không được chuyển nguyên sang game.

Theo canvas nguồn 1920 × 1080, nền kem RGB `(255,249,211)` cao 426,58; vùng nút tab cao 561,809. Biểu tượng tab được chọn nhô cao hơn vùng nút: Animal tới y=616,532 và Building tới y=608,832 tính từ đáy. Tab rộng 267,735 × 117, cách nhau −6, lề trái 150; biểu tượng không chọn thu còn 0,74. Thẻ rộng 285,75 × 408,8, cách nhau 30, lề hai bên 30. Ô hình 250 × 250; dải giá Animal 239,6 × 64,7 tại y=−138,9. Font nguồn là Poetsen One Regular, tên/giá khoảng 36; chữ tên nâu `(155,65,47)` hoặc `(157,64,49)`, yêu cầu khóa cam `(217,90,35)`. `All/Close` là vùng chạm trong suốt ngoài bảng; BuildingUI không có khung UpgradeHouse hay nút X riêng trong prefab.

APK chứa metadata IL2CPP và thư viện ARM64, không chứa thân hàm C# để chép trực tiếp. Đối chiếu PPtr và mã máy xác nhận nút HUD gọi `UIPlay.OnClickBuildingIcon` → `BuildingUI.Show(0)`; hai nút danh mục gọi `Tab(0)`/`Tab(1)`. `TabBuilding.Awake` sắp xếp theo mức mở khóa rồi bỏ qua công trình đã có trên map; `HouseElement.Init` cũng ẩn thẻ nếu `HasBuildingOnMap` trả về đúng. Nhấn thẻ gọi `HouseElement.OnClick` hoặc `AnimalElement.SpawnAnimal`, đóng bảng và đưa prefab vào bước đặt trên map. Nhánh mua vật nuôi đăng ký callback xác nhận trong `MoveObjectUI` trước khi trừ gem. Các thao tác và kinh tế Cocos phải được kiểm theo luật game Cocos; nhập sprite không đồng nghĩa đã chuyển toàn bộ logic Unity.

Ảnh đối chiếu và cây node đầy đủ nằm ở `artifacts/golden-island-modal/source/` và `artifacts/golden-island-shop/source/` trong workspace khảo sát. Ảnh `reconstructed-*.png` được dựng từ sprite và số đo nguồn, có ghi rõ không phải ảnh chụp Unity đang chạy; hình/tên/giá minh họa trên thẻ không phải một trạng thái save nguồn. `artifacts/` và nguồn APK `reference/` được Git bỏ qua; chúng không phải đầu vào bắt buộc của bản game đã nhập. Nguồn là bộ art Golden Island được đối chiếu cho project này; hồ sơ nguồn không thay thế giấy phép của studio.
