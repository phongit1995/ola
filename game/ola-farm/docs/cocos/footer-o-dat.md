# Dải chọn giống và bong bóng trên ô đất

Giao diện 40 ruộng dùng dải giống và bong bóng Golden Island:

- **Ô trống** → dải chọn giống ở đáy màn hình, không nền và không bám camera, kéo ngang để xem hết. Ruộng có tám giống; giống chưa đủ level hoặc xu bị làm mờ và không nhận thao tác gieo; thứ tự xếp theo level mở. Mỗi giống là một ô lục giác (`BgToolUI`) kèm icon và giá xu. **Nhấn giữ** một ô thì hiện viền vàng (`Select`) và thẻ `DetailSeeds` (`BgInfo`) ghi tên cùng thời gian trồng, nổi ngay sát trên ô đó — game gốc đặt thẻ bên phải, bản này đặt phía trên cho vừa màn dọc. Thả tay thẻ vẫn ở lại để đọc; nó tắt khi giữ ô khác, khi chạm vào chính nó, hoặc khi đóng dải. Cú thả kết thúc lần giữ thì không gieo. Giống chưa đủ level hiện `Lv N` thay giá xu; khi đã mở, thiếu xu thì giá hiện đỏ. Điều kiện được kiểm lại ở core trước khi trừ hạt; giữ giống bị khóa vẫn xem được thông tin và level cần đạt. Đóng dải bằng cách chạm nền trống hoặc Escape.
- **Ô đang lớn** → không còn footer. Ô giữ nguyên lựa chọn và treo **bong bóng** ngay trên nó: tên cây, icon đồng hồ và thời gian còn lại, và một hàng nổi phía trên gồm nút xanh "xong ngay" kèm giá kim cương cùng cái xẻng bên phải nó — xẻng đào bỏ cây và hoàn một phần tiền giống. Cả hàng nằm hẳn ngoài bong bóng. Thanh điều hướng vẫn hiện.
- **Ô đã chín** → bong bóng tròn với icon nông sản và số lượng, chạm phát thu luôn. Chạm thẳng vào ô cũng thu như cũ.
Bốn loài, tối đa tám chuồng, dùng [bảng chăm đàn riêng](farm-town-modals.md); các ô ao/chuồng legacy không dùng dải gieo giống này. Lượt mới có **6 ruộng mở sẵn và một ô đất xanh kế tiếp**. Chạm ô xanh mở UI mua đất: khóa kèm level khi chưa đủ cấp; giá xu và nút mua khi đủ cấp. Mua xong ô đó dùng được dải gieo giống và ô xanh chuyển sang vị trí tiếp theo. Các level 2, 4, …, 68 lần lượt cho phép mua thêm một ô, theo [bảng giá đất](land-purchase.md). Cấu hình từng ô nằm trong [economy.json](../../assets/farm/bundles/farm-town/economy.json); xem [cách cấu hình ruộng](economy-config.md#cấu-hình-ruộng-mở-sẵn-hoặc-mua-mở).

Bong bóng nằm trong `World` của bản đồ nên trôi theo khi kéo map, nhưng tự chia lại tỉ lệ `1 / displayScale` để giữ nguyên cỡ trên màn hình — đúng cách `ZoomByCamera` của Unity. Chỉ hai nút trên bong bóng nuốt cú chạm; phần thân để lọt xuống bản đồ nên ô đứng sau vẫn chạm được.

## Cách tính thời gian và giá "xong ngay"

`core/Countdown.ts` theo đúng chuỗi định dạng có trong `global-metadata.dat` của Golden Island: hai đơn vị lớn nhất, cắt dần — `01:42` → `2:05:09` → `1d02h`. Profile hiện hành chạy 1× theo thời gian thực và hỗ trợ offline cho công việc đã trả tiền. Lúa mì 300 giây hiện `05:00`; nho 12 giờ. Mở Menu không dừng đồng hồ. [Luật đồng hồ](real-time-economy.md#đồng-hồ-offline-và-bản-lưu).

`FarmGame.boostPrice` tính **một kim cương cho mỗi phút còn lại**, làm tròn lên (`boostSecondsPerGem` = 60 trong `timing.json`, xem [chi-so/09](../chi-so/09-kim-cuong-xu.md#giá-làm-xong-ngay)). Lúa mì vừa gieo là 5 kim cương; nho vừa gieo là 720. `boost` cho chín ngay (`ready = time`) thay vì rút còn nửa đơn vị như trước.

## Đối chiếu Golden Island

Đọc trực tiếp bundle bằng `reference/golden-island/analysis/plot_ui.py` (UnityPy), kết quả ở `analysis/plot_ui.json`:

- Prefab ô đất là `b_01` mang script `Farm`, có `Canvas` world-space (1920×1080, scale 0,01) chứa `DetailPlant` 200×110 (`bg_information_item_1`, viền 28): `Name` 36px màu `#9B412F` ở y +31,4; viên `BgMaterial` 177,3×43,3 ở y −21,4 với `IconTime` 44×37 lệch trái 54 và chữ thời gian 32px màu `#D05712`; `ButtonComplete` 176×56 (`bt_2`) nổi trên mép bong bóng 34px, bên trong là giá và icon kim cương `ss_001` 50×50.
- `HarvestUI/PanelUnlock` (`bg_ctn`) là bong bóng đã chín, `PanelLock` (`bg_ctn_khoa`) là ô bị khoá.
- `PlantingUI` xếp sáu ô `BgToolUI` 195×184 hai bên màn hình, `Select` là viền chọn, `DetailSeeds` (`BgInfo`) hiện tên và thời gian. Bản Cocos giữ bộ ảnh và tỉ lệ đó nhưng xếp thành một dải kéo ngang ở đáy để gieo chỉ một chạm, và đưa thẻ lên phía trên thay vì sang phải.
- Ảnh và viền nine-slice nằm ở bundle `assets/farm/bundles/farm-plot-ui/`; xem `game/ola-farm/source-assets/farm-plot-ui/README.md`. Chữ dùng Poetsen One mà HUD đã liên kết sẵn.

Nguồn art được ghi trong manifest; các sprite đã chọn nằm trong bundle runtime. Hồ sơ nguồn không thay thế giấy phép của studio.

## Chỉnh và kiểm tra

- `game/ola-farm/assets/farm/prefabs/ui/SeedPicker.prefab` và `SeedTile.prefab`: cấu trúc dải giống, thẻ thông tin và từng ô hạt; mở trong Editor để chỉnh art, font và offset. `scripts/ui/crops/PlotFooter.ts` nối dữ liệu giống, nhấn giữ và hành động gieo. `PLOT_FOOTER_TOP` là mép trên tính từ đáy màn hình, hiện 184 đơn vị thiết kế.
- `game/ola-farm/assets/farm/prefabs/ui/PlotBubble.prefab`: ba nhánh `Growing`, `Ready`, `Locked` có sẵn hình, chữ và vùng bấm. `map/crops/PlotBubbleView.ts` bind dữ liệu/nút; `map/crops/PlotBubbles.ts` giữ cache, vị trí và tỉ lệ ngược camera.
- `game/ola-farm/assets/farm/scripts/core/Countdown.ts`: định dạng đếm ngược. `FarmGame.boostPrice`: giá xong ngay.
- `GameApp.ts`: định tuyến chạm ô, dựng footer cho ô trống, nối hành động của bong bóng.
- `UiPrefabs` trên Canvas giữ liên kết tới các module. `Art.ts` nạp icon theo dữ liệu; khung và font tĩnh được liên kết ngay trong prefab.

Build bằng `game/ola-farm/build-configs/farm-web-mobile.json`, rồi chạy từ thư mục repo:

```sh
node game/ola-farm/tests/plot-footer.browser.cjs
```

Suite dùng browser context riêng và tiền/nguyên liệu giả lập, không sửa bản lưu của người chơi. Kiểm tra desktop 1280×720, dọc 390×844, ngang 844×390 và màn nhỏ 320×568: vị trí dải giống khi kéo map và xoay màn hình, đủ tám giống không cần nút trang, gieo và số tiền bay lên, bong bóng đếm ngược, nút xong ngay trừ đúng kim cương, thu hoạch từ bong bóng, hoàn tiền khi đào bỏ, khoá thao tác khi thiếu tiền và khôi phục điều hướng. Ảnh `*-seeds.png`, `*-growing.png`, `*-ready.png` cùng kết quả ở `artifacts/cocos-footer/`.
