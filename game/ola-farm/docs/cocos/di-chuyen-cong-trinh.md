# Di chuyển công trình

## Cách dùng

Nhấn giữ công trình khoảng 0,45 giây, kéo bằng cùng ngón tay hoặc chuột, rồi **thả để đặt**. Vị trí hợp lệ được lưu ngay và game tiếp tục chạy, không cần mở Tạm dừng, bấm xác nhận hay bấm Xong. Giữ yên rồi thả không đổi vị trí và không mở bảng.

Vùng xanh cho biết đặt được. Vùng đỏ báo sát/đè ruộng, công trình khác, ao/giếng/cối xay/nhà chó hoặc ra ngoài bãi cỏ. Phần chân công trình cần cách ruộng ít nhất 24 đơn vị bản đồ. Road đã được gỡ khỏi map và không còn footprint chặn đặt công trình. Thả ở vị trí không hợp lệ trả công trình về chỗ cũ. Chạm nhanh vào chuồng mở popup chăm đàn: từ toàn cảnh sẽ phóng vừa chuồng, còn camera đã chỉnh thủ công được giữ nguyên. Chạm ruộng không đổi zoom; kéo nhanh trước khi đủ thời gian giữ vẫn di chuyển camera.

Ngón thứ hai hủy vị trí đang kéo và chuyển sang zoom. Escape, hủy cảm ứng, cuộn chuột, xoay màn hình, ẩn tab, mở bảng và thay phiên chơi cũng bỏ thao tác chưa thả. Các vị trí đã thả và lưu trước đó vẫn được giữ.

Menu Tạm dừng → **Sắp xếp** là lối vào phụ để chọn công trình bằng mũi tên. Trong menu này, thả vẫn lưu ngay; **Bỏ chọn** bỏ lựa chọn hiện tại, **Xong** thoát chế độ. Không có nút xác nhận vị trí.

## Phạm vi

| Công trình | ID bố cục |
| --- | --- |
| Nhà | `farm-house` |
| Kho | `barn` |
| Lò bánh | `bakery-1` |
| Xưởng sữa | `dairy-1` |
| Máy thức ăn | `feed-1` |
| Bếp nướng | `grill-1` |
| Máy đường | `industry-sugar_processor` |
| Lò ngô | `industry-popcorn_factory` |
| Lò pie | `industry-pie_bakery` |
| Bàn đan | `industry-loom` |
| Chuồng gà | `pen:12` |
| Chuồng bò | `pen:13` |
| Chuồng heo | `pen:14` |
| Chuồng cừu | `pen:15` |
| Máy nhà 2 | `bakery-2`, `dairy-2`, `feed-2`, `grill-2`, `industry-sugar_processor-2`, `industry-popcorn_factory-2`, `industry-pie_bakery-2`, `industry-loom-2` |
| Chuồng nhà 2 | `pen:50` (gà), `pen:51` (bò), `pen:52` (heo), `pen:53` (cừu) |

**Menu → Nông trại** đưa camera về khu giữa gần hơn: 40 ruộng, các chuồng đã xây, nhà và kho. Đây cũng là mức zoom-out tối đa; kéo map để tới các xưởng đã xây ngoài rìa hoặc chọn máy để focus. Khi quay về Home sau khi chuyển chuồng/nhà/kho, camera tính lại vùng vừa đủ theo vị trí đã lưu.

Chỉ công trình đã xây mới hiện trên map và kéo được, không mất tiền. Vị trí chưa mua nằm trong Shop; khi mua, công trình ưu tiên tọa độ đã lưu/mặc định; nếu bị chiếm thì tìm ô trống gần nhất. Bản lưu cũ đã dời vị trí chưa mua vẫn giữ tọa độ đó làm vị trí ưu tiên. 40 ô ruộng, cây đang trồng và những ô chăn nuôi/ao không hoạt động giữ nguyên.

Nhóm `Livestock` trong `scenes.prefab` vẫn có chức năng: `FarmMapLayout.livestock` giữ 10 anchor `Cell12–21` cho bốn sân thật và hình học của sáu ô legacy. Đã xóa 10 preview children `Pen1`/`PondSlot1` cùng records của instance; không chỉ tắt hình khi chạy. `tools/link-prefab-components.cjs` giữ các anchor và loại preview cũ khi liên kết lại. Bốn sân Farm Town và đàn bên trong do `FarmTownViews` dựng riêng, nên vẫn kéo, chăm đàn và lưu vị trí bình thường.

Cây, hoa, bụi, xe, rơm và các đoạn rào trang trí đứng riêng trên bản đồ; không đi theo nhà hoặc máy. Hình chuồng và đàn vật nuôi bên trong vẫn đi cùng nhau. Các chi tiết trang trí nhỏ không mở rộng diện tích va chạm của công trình. Thân và cánh cối xay gió cố định có chung node cha; đổi vị trí cụm này giữ cả hai phần thẳng nhau.

Map hiện không có đường: `roads.json.paths = []`, danh sách tile, liên kết và footprint đều rỗng. Đất đường cũ dùng được để đặt công trình nếu thỏa các ràng buộc còn lại. Kéo, thả, mua máy, tải lại hoặc nhập bố cục không tạo lại node đường. Hai đoạn `DecorFenceSE` cũng đã được gỡ cùng footprint; hai đoạn `DecorFenceNE` vẫn giữ.

## Mã nguồn và dữ liệu

`tools/farm-layout.cjs` đọc anchor trong `scenes.prefab`, sinh `assets/farm/data/farm-layout/layout.json`, `assets/farm/scripts/core/generated/FarmLayoutManifest.ts` và `assets/farm/scripts/map/generated/BuildingPresentationData.ts`. `core/FarmLayoutData.ts` là điểm import cho phần va chạm/save. Chỉ chỉnh nguồn hình học/anchor rồi chạy generator; không sửa tay các file trong `generated/`. Manifest tách công trình, chướng ngại cố định và đồ trang trí; không có quan hệ đồ trang trí đi theo công trình.

`BuildingGeometry.ts` kiểm tra đa giác lồi theo phần tiếp đất, khoảng cách giữa các cạnh và bãi cỏ hình thoi bốn cạnh. `BuildingPlacement.ts` chỉ cho kéo công trình đã xây, kiểm tra ID, tọa độ, chướng ngại và khoảng cách với ruộng; va chạm công trình chỉ xét những công trình đã xây. Không yêu cầu lối nối tới cửa. Lưới snap 36×18; tọa độ mặc định không bị ép snap khi chỉ giữ yên. Cache tối đa 64 kết quả, phân biệt theo bố cục và tập công trình đã sở hữu.

Bốn sân rộng **784 đơn vị = 4 × 196 đơn vị của một ô đất** trong cùng hệ tọa độ bản đồ. Scale sân/rào lấy từ `784 / 190 ≈ 4,1263`; đàn có scale riêng **3,0**, vị trí đứng giãn theo sân. Vùng chiếm chỗ lấy từ pixel nền/rào sau đầy đủ transform prefab, bao cả chiều cao rào để các sân không xuyên nhau. `tools/pen-ground-footprints.py` tạo `source-assets/farm-beautify/pen-footprints.json` với bề ngang ô đất, số ô mục tiêu, scale và hash nguồn; `farm-layout.cjs` xuất cùng scale cho hình học và runtime. Khi đổi hình hoặc số ô mục tiêu, tạo lại dữ liệu này rồi chạy generator.

Mười sáu vị trí xưởng có hình hiển thị rộng 784 đơn vị; chỉ xưởng đã mua mới có mô hình trên map. `tools/machine-ground-footprints.py` sinh `source-assets/farm-beautify/machine-footprints.json` từ transform prefab và alpha của ảnh nguồn; `MACHINE_PRESENTATION` trong `map/generated/BuildingPresentationData.ts` cung cấp scale và bounds hiển thị cho map. Khung đặt và va chạm dùng phần nền tiếp đất, không lấy mái, chiều cao tường hoặc máy móc phía trên. Bảy loại xưởng lấy đa giác từ pixel nền; xưởng sữa có nền liền trong ảnh thân nhà nên dùng đa giác chân nhà được ghi theo tọa độ ảnh nguồn trong `source-assets/farm-beautify/machine-ground-overrides.json`. Khi đổi ảnh hoặc prefab, chạy lại công cụ đo rồi sinh bố cục; xưởng không có lớp nền phải khai báo phần chân nhà, không tự lấy toàn bộ bóng hình làm đất.

Kích thước hình xưởng, vùng chạm bao mái và vị trí neo được giữ riêng với phần nền. Khung mới nằm trong vùng dành chỗ cũ, nên vị trí đã lưu vẫn hợp lệ và không cần dời nhà hay tăng phiên bản save. Mua xưởng tạo mô hình đủ kích thước tại vị trí đã lưu/mặc định nếu còn trống, hoặc ô trống phù hợp gần nhất. Vị trí chưa mua không chặn thao tác đặt công trình; khi mua không tìm được chỗ thì không trừ tiền.

Viền chọn dùng đa giác footprint thật. Vùng chạm/nhấn giữ bao sân và mái; việc ẩn hình ngoài màn hình kiểm cả bounds sân/nhãn thay vì chỉ điểm chân. Focus tính cả mái, badge và khoảng trống trên thanh chăm đàn. Home fit 40 ruộng, các chuồng đã xây, nhà và kho trong vùng còn lại giữa HUD/footer. Các xưởng ngoài rìa không tham gia phép fit Home; pan vẫn tới được chúng. `MapCamera` chặn cuộn/chụm thu nhỏ quá mức Home, kể cả khi khôi phục camera sau resize. Tỷ lệ bốn ô là kích thước art trong hệ tọa độ map, độc lập với camera.

`BuildingMoveController.ts` giữ vị trí thử ngoài state. Kiểm tra ngay khi kéo, không chờ timer tìm đường. `FarmMapView` phân biệt nhấn giữ, kéo camera, thả và hủy pointer; cùng một hàm vị trí phục vụ hiển thị, vùng bấm, focus và thứ tự che khuất. Nhà/kho, máy, chuồng và vật đứng cố định dùng chung thứ tự vẽ theo phần chân. Cây và đường không được cập nhật vị trí khi kéo.

`GameApp` nhận sự kiện thả, gọi action di chuyển, bỏ lựa chọn và thoát ngay nếu thao tác bắt đầu bằng nhấn giữ. Thanh hướng dẫn trực tiếp chỉ hiện chữ, không chặn ngón tay đang kéo. Chế độ vào từ menu có thể tiếp tục sắp xếp nhiều công trình.

## Bản lưu

Profile `simple-1`, khóa `ola-farm-cocos-simple-v1` (đọc alias `happy-farm-cocos-simple-v1` khi chưa có khóa Ola), state v7 và pack v6:

```ts
buildingLayout: { version: 6, positions: { barn: { x: -1400, y: 0 } } }
```

Chỉ lưu vị trí khác mặc định; dữ liệu vị trí máy chưa mua từ bản cũ vẫn được đọc và giữ nguyên. ID công trình/máy/chuồng/vật nuôi không thay đổi. Di chuyển không đổi ví, kho, cây trồng, hàng chờ, khay sản phẩm hoặc thời hạn công việc.

Đợt Farm Town bốn loài thêm heo/cừu/bàn đan; đợt sân 2,2 lần dùng layout v3; sân rộng bốn ô dùng v4. Đợt xưởng rộng bốn ô chuyển sang **layout v5**, bố trí lại tám vị trí xưởng để chứa đủ mô hình trước và sau mua. Vị trí và kích thước của 40 ruộng giữ nguyên. Vị trí người chơi tự đặt còn hợp lệ được ưu tiên trước mặc định mới; các xưởng bị va chạm sau khi phóng lớn được tìm chỗ hợp lệ gần nhất theo thứ tự xác định. Xem [quy tắc bản lưu hiện hành](farm-town-husbandry-runtime.md).

State v5/pack v4 được xác thực trước khi chuyển qua layout v5 rồi lên layout v6; nguồn cũ giữ một lần ở `.before-layout-v6` trước khi ghi đè. `parse()` chỉ đọc.

Các snapshot hình học nằm trong `assets/farm/scripts/core/legacy/`. Layout v1 được xác thực bằng `PreviousFarmLayout.ts`, v2 bằng `PreviousPenLayout.ts`, v3 bằng `PreviousLargePenLayout.ts`, và v4 bằng `PreviousFourFieldLayout.ts`. Không đổi ví, kho, cây trồng, công việc, hàng chờ hoặc vật nuôi. Raw source v1/v2/v3/v4 giữ nguyên byte một lần ở `.before-large-machines-v5` trước khi ghi. Các khóa dự phòng lịch sử vẫn giữ theo phiên bản nguồn. Layout v5 nhập từ bên ngoài được xác thực bằng `PreviousSingleBuildingLayout` rồi chuyển lên v6; v6 hiện hành được kiểm trực tiếp. Vị trí trên đường đã xóa không bị từ chối chỉ vì vị trí đường cũ.

Đợt hai nhà mỗi loại giữ nguyên các vị trí cũ và thêm 12 anchor mới: tám máy và bốn chuồng plot 50–53. Save v6/state cũ được giữ byte nguồn ở `.before-two-buildings-v7` trước khi chuyển state v7/layout v6. Chuồng/máy chưa xây không được cấp tự động. Các vị trí nhà mới mặc định chừa vùng bấm và nhãn của nhà bên cạnh.

Action `{ type: 'moveBuilding', building, position }` xác thực trên bản sao state, ghi thành công rồi mới công bố vị trí. Nếu ghi lỗi lúc thả, hình về chỗ cũ và vị trí đang chờ nằm trong `pendingPack`; thử lưu lại thành công mới áp dụng. Autosave không thấy vị trí đang giữ.

Trong lúc giữ/kéo, `layoutEditing` tạm ngừng thời gian sản xuất và các action khác. Khi thả hoặc hủy, game khôi phục trạng thái tạm dừng trước đó. Lỗi lưu dùng luồng phục hồi sẵn có.

## Kiểm tra

```sh
node cocos/tools/farm-layout.cjs --check
npm run verify --prefix cocos
npm run typecheck --prefix cocos
```

Sau build, chạy `node cocos/tests/machine-placement-outline.browser.cjs` từ gốc repo để kiểm cả 16 nhà sản xuất: kích thước hình, khung nền khi giữ/kéo, thả và tải lại vị trí trên máy tính, điện thoại dọc và ngang. Ảnh và báo cáo nằm trong `artifacts/machine-move-audit/verified/`.

Các bài `building-long-press.browser.cjs`, `building-move.browser.cjs`, `building-move-gestures.browser.cjs`, `fixed-roads-save.browser.cjs`, `herd-size-focus.browser.cjs` và `camera-limits.browser.cjs` trong `cocos/tests/` kiểm thêm vị trí hợp lệ/sai, hủy cử chỉ, mua trên đất chưa đặt trước, nguồn save cũ, retry khi ghi lỗi và focus không che UI. Một số fixture lịch sử còn giả định công trình mở sẵn hoặc giá cũ; cần cập nhật theo cấu hình hiện hành trước khi dùng để nghiệm thu. Tên bài kiểm road được giữ vì nó kiểm bản lưu trước/sau gỡ đường; map hiện không có đường.

Không dùng kết quả của bố cục sân/máy nhỏ hơn trong lịch sử để chứng nhận hình học hiện tại.
