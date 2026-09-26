# 10. Thời gian, offline và lưu game

> Nguồn: [runtime.json](../../assets/farm/bundles/farm-town/runtime.json), [catalog.json](../../assets/farm/bundles/farm-town/catalog.json) (`timeMode`), [GameSession.ts](../../assets/farm/scripts/core/GameSession.ts), [FarmSave.ts](../../assets/farm/scripts/core/FarmSave.ts). Đối chiếu ngày 26/09/2026.

## Thời gian thực

- Game chạy theo **giờ thực, tốc độ 1×** (`timeMode: "real"`). Không có nút tua nhanh.
- Đồng hồ lấy từ giờ của thiết bị. Mọi thời gian trong tài liệu là thời gian thực.

## Menu và dời công trình không dừng đồng hồ

Từ 26/09/2026, luật này giống Hay Day: đồng hồ **không dừng** khi mở Menu hay dời công trình.

- Trong lúc mở **Menu** hoặc đang **dời công trình**, cây, vật nuôi và máy **vẫn chạy**.
- Lúc đó chỉ các thao tác khác (gieo, thu, bán…) bị chặn. Bấm vào sẽ thấy "Đang mở Menu." hoặc "Đang sắp xếp công trình.".
- Thoát game lúc đang mở Menu vẫn được cộng thời gian offline như thường.
- Chế độ thời gian thực không còn phím **Space** để tạm dừng.
- Chỉ **lỗi lưu** làm trang trại đứng: game dừng cả thao tác lẫn thời gian cho tới khi lưu lại được, và không bù khoảng chờ đó.
- Bản lưu cũ ghi lúc đang tạm dừng (trước 26/09/2026): lần mở đầu tiên không được cộng khoảng offline đó; các lần sau tính bình thường.

## Offline

| Thông số | Giá trị | Ý nghĩa |
| --- | ---: | --- |
| `session.offlineProgressEnabled` | true | đóng game hoặc ẩn tab thì việc vẫn chạy tiếp |
| `session.maxOfflineSeconds` | null | **không giới hạn** thời gian offline |

- Lúc vào lại, game cộng toàn bộ thời gian đã đi vắng: cây chín, con có sản phẩm, máy làm tiếp các việc trong hàng chờ cho tới khi khay đầy.
- Offline **chỉ hoàn thành việc đã trả tiền**; không tự gieo, tự cho ăn, tự xếp món hay tự nhận hàng.
- Chỉnh giờ thiết bị **về sau** (tương lai): game cộng hết khoảng chênh ngay. Chỉnh **về trước**: trang trại đứng yên cho tới khi giờ thực vượt lại mốc đã lưu.

## Lưu game

| Thông số | Giá trị |
| --- | --- |
| Nơi lưu | localStorage của trình duyệt/WebView. Mở trong app Ola: khóa `ola-farm-cocos-simple-v1@<mã tài khoản>`, mỗi tài khoản một nông trại. Chạy riêng không có token: khóa `ola-farm-cocos-simple-v1` chung của máy |
| Lưu tự động | mỗi 2,5 giây (`session.autosaveSeconds`) |
| Lưu theo thao tác | mỗi thao tác thành công lưu ngay; lưu lỗi thì game tạm dừng và giữ bản chờ để thử lại |
| Âm thanh/nhạc mặc định | âm thanh tắt, nhạc tắt |

Từ 26/09/2026 game xin accessToken từ app Ola như các game khác (`?token=` trên URL, nếu không có thì hỏi host qua bridge `get_token`). Mã tài khoản trong token chỉ dùng để chọn bản lưu: mỗi tài khoản trên cùng một máy có nông trại riêng. Tài khoản đầu tiên mở game sau bản cập nhật này nhận lại nông trại cũ của máy; tài khoản khác bắt đầu mới. Bản lưu vẫn nằm trên máy, chưa lên server: xóa app hoặc dữ liệu trình duyệt là mất, và không chống sửa số.

## Việc được chốt lúc bắt đầu

| Việc | Chốt lúc | Những gì được chốt |
| --- | --- | --- |
| Cây | gieo | giá hạt, sản lượng, EXP thu hoạch, tiền hoàn khi hủy, thời gian |
| Món trong máy | xếp vào máy | nguyên liệu, thành phẩm, EXP, thời gian |
| Vật nuôi | cho ăn | sản phẩm, EXP, thời gian |

Không chốt: giá bán (bán theo giá hiện hành), giá làm xong ngay (tính theo số giây mỗi kim cương hiện hành trên thời gian còn lại lúc bấm).

## Các thông số runtime khác

| Khóa | Giá trị | Ý nghĩa |
| --- | ---: | --- |
| `audio.musicVolume` | 0,15 | âm lượng nhạc (0–1) |
| `audio.effectVolume` | 0,3 | âm lượng hiệu ứng (0–1) |
| `ui.refreshSeconds` | 0,25 | chu kỳ cập nhật bảng (giây) |
| `ui.toastSeconds` | 4 | thời gian hiện thông báo (giây) |
| `ui.motionEnabled` | true | bật hiệu ứng chuyển động |
| `input.longPressSeconds` | 0,45 | giữ bao lâu để dời công trình / xem thông tin hạt (giây) |
| `input.mapDragSlop` | 8 | ngưỡng kéo bản đồ (px) |
| `input.seedDragSlop` | 12 | ngưỡng kéo hạt (px) |
| `input.buttonDragSlop` | 10 | ngưỡng kéo trên nút (px) |
| `input.wheelZoomStep` | 1,12 | bước zoom bằng con lăn chuột |
| `input.resizeSettleSeconds` | 0,25 | chờ ổn định khi xoay/đổi cỡ màn hình (giây) |
| `camera.homePadding` | 90 | lề khi về góc nông trại |
| `camera.cullMargin` | 250 | lề vẽ ngoài màn hình |
| `camera.maxZoom` | 8 | zoom tối đa |
| `camera.maxDisplayScale` | 2 | tỷ lệ hiển thị tối đa |
| `camera.buildingFocusScale` | 1,35 | tỷ lệ khi zoom vào công trình |
| `camera.facilityFocusScale` | 1,1 | tỷ lệ khi zoom vào khu sản xuất |
| `assets.loadConcurrency` | 8 | số tài nguyên tải song song |
