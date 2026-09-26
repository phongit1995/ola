# Chăn nuôi và chế biến hiện hành

> **Số liệu hiện hành đã kiểm chứng nằm ở [Chỉ số game](../chi-so/README.md).** Tài liệu này giữ phần giải thích và lịch sử thiết kế; nếu con số ở đây lệch với `docs/chi-so/` hoặc file JSON thì lấy `docs/chi-so/` và JSON làm chuẩn.

Farm có **40 ruộng, 8 cây, 4 loài gà/bò/heo/cừu, 8 loại máy, 23 công thức và 35 vật phẩm**. [Catalog](../../assets/farm/bundles/farm-town/catalog.json) giữ nội dung/identity; [economy.json](../../assets/farm/bundles/farm-town/economy.json) giữ giá/level/ví/XP/ô đất; [timing.json](../../assets/farm/bundles/farm-town/timing.json) giữ thời gian trồng/nuôi/chế biến. Game ghép thêm `gameplay.json` và `runtime.json` khi tải, tổng cộng [năm file cấu hình](configuration.md); profile là `simple-1`. [Cách chỉnh thời gian](timing-config.md). [Farm Town nguồn có bảy loài](farm-town-agriculture-inventory.md); ong, đà điểu và chim công không nằm trong runtime này.

Mỗi loại máy và mỗi loài có tối đa **hai nhà**: 16 máy và tám chuồng. Nhà thứ hai yêu cầu **level 12–54 tùy loại**, đã có nhà thứ nhất, đủ mốc nội dung và đủ xu. Đạt level không tự cấp nhà. Xem [giá và level hiện hành](farm-town-husbandry-balance.md).

## Lượt chơi và mở nội dung

Cấu hình mặc định bắt đầu với **700 xu, 10 kim cương, 4 lúa mì + 2 ngô trong kho, 6 ruộng trống mở sẵn, chưa có máy hoặc chuồng**. Ruộng còn lại mua tuần tự tại level 2, 4, …, 68 theo [bảng giá đất](land-purchase.md); map chỉ hiện một ô đất xanh kế tiếp để mua. Level 1 chỉ xây được máy thức ăn và chuồng gà; lò bánh mở ở level 5, bò/xưởng sữa ở level 10, các nhóm sau cách nhau khoảng năm level trong [bảng mốc xây](economy-config.md). Đạt level chỉ cho phép mua, không tự cấp nhà hoặc ruộng. Lúa mì, ngô và cám gà mở ngay ở level 1 để nuôi gà được từ đầu. Tám cây là lúa mì, ngô, bắp cải, dâu tây, nho, khoai tây, bí ngô và củ cải đường.

- Đạt **level 15** và nhận cám, trứng, sữa lần đầu để mở chuồng heo. Giá **4.860 xu**, gồm chuồng 4.500 và một heo 360.
- Đạt **level 35** và nhận burger đầu tiên để mở chuồng cừu và bàn đan. Chuồng **12.600 xu**, gồm chuồng 12.000 và một cừu 600; bàn đan **22.000 xu**.
- Nhà thứ nhất: bếp nướng level 15/1.800 xu, máy đường level 20/6.000 xu, lò ngô level 25/9.000 xu, lò pie level 30/14.000 xu.
- Mốc mở nội dung theo giao dịch nhận hàng; chỉ có đồ trong kho của lượt chơi mới không tự hoàn thành mốc. Cây mở ở level 1/1/4/7/10/14/18/24, công thức theo level nguyên liệu/máy. Ô 2/3/4/5 của gà theo level 3/9/15/20, hàng đợi máy thức ăn theo level 5/10/15/20; ô bò giữ level 2/3/4/5. [Bảng tiến trình và thời gian chơi](real-time-economy.md).

Có thể đặt từng ruộng thành ô phải mua theo giá/level trong JSON; chạm ô khóa để mua mở. Các ô đã có trong save không bị thu hồi khi đổi cấu hình. [Cách chỉnh giá và ô đất](economy-config.md).

[Shop](golden-island-shop.md) giữ cả máy đã xây và chưa xây. Công trình chưa mua không có hình mờ/vùng bấm trên map và không chặn đất đặt công trình khác. Mua kiểm tra chỗ đặt trước khi trừ tiền.

## Chăm đàn

Chạm chuồng đã xây mở thẳng bảng **chuồng đang chọn**. Cho ăn trừ một phần cám mỗi con; con đói chờ ăn, không chết. Nhận xong giữ nguyên con và ID. Cho cả đàn ăn cần đủ cám cho mọi con đang đói; nhận cả đàn chỉ lấy sản phẩm đã sẵn sàng.

Năm thẻ nằm trên **một hàng kéo ngang**, không có tab loài. Mỗi ô có số, hình con, trạng thái và nút riêng; lượng cám với icon lớn nằm dưới hàng thẻ, nút chăm cả đàn nằm cố định ở đáy. Vuốt tới ô ngoài khung, đóng bảng rồi chạm chuồng khác để đổi đàn. Bảng hiện không có dòng đếm đàn riêng, nút bán con hoặc liên kết tìm cám.

Con đang nuôi hiện đồng hồ + thời gian còn lại; nút tăng tốc chỉ có số giá + icon kim cương. Giá là một kim cương cho mỗi phút còn lại của con đó, làm tròn lên (`boostSecondsPerGem` trong `timing.json`, dùng chung với cây và nhà máy): gà vừa ăn 30 kim cương, cừu 720; xem [chi-so/09](../chi-so/09-kim-cuong-xu.md#giá-làm-xong-ngay). Lượt gà/bò/heo/cừu lần lượt là 30 phút/2 giờ/6 giờ/12 giờ thực. Tăng tốc chỉ làm sản phẩm sẵn sàng; người chơi vẫn bấm nhận để đưa vào kho. Gà cho trứng `farm40:egg`, bò cho sữa `raw:7`, heo cho thịt xông khói `town:beacon`, cừu cho len `town:wool`.

Mỗi chuồng bắt đầu một ô/một con, tối đa **năm ô/năm con**. Mở ô 2–5 tuần tự, trả phí chỗ **45/75/120/180 xu cộng giá một con** trong cùng giao dịch. Giá con gà/bò/heo/cừu là **120/240/360/600 xu**. Ví dụ ô gà thứ hai giá 165 và có ngay một gà chờ ăn. Con mới không tự ăn cám.

Nút mở ô chỉ hiện **số giá + icon xu**, có ổ khóa lớn trên thẻ. Ô gà 2/3/4/5 yêu cầu level **3/9/15/20**, ô bò giữ **2/3/4/5**; thiếu level hiện `Level N` và không mua được. Lợn/cừu chưa có khóa level theo ô. Điều kiện ô nuôi được kiểm trong core và bảng chuồng; ô đã mở trong save cũ vẫn được giữ.

Logic bán con vẫn tồn tại trong core, chỉ cho bán con đói và để lại ô trống đã trả phí; bảng chăm hiện không hiển thị thao tác bán. Mua lại chỉ trả giá con và lấp đúng ô được bấm; Mua lại con và mở ô thực hiện trong bảng của đúng chuồng; Shop chỉ xây nhà. Những con còn lại giữ vị trí. Bấm lặp cùng ô không mua sang ô kế tiếp. Xem [đầy đủ giá và công suất](farm-town-husbandry-balance.md).

## Sản xuất, kho và bản đồ

Tiêu đề phân biệt nhà 1/2. Mỗi máy có ID, hàng đợi và khay riêng; mỗi chuồng có đàn, ô nuôi và timer riêng. Kho và ví dùng chung. Danh sách công trình và nguồn nguyên liệu cho chọn cả hai nhà; đường quay lại giữ đúng ID máy gốc.

Máy làm từng mẻ tuần tự. **Chọn món** chỉ chọn công thức; **Chế biến** mới trả nguyên liệu và xếp mẻ. Sức chứa từ một đến năm ô, tính cả mẻ đang chạy; chỉ mẻ chờ được hủy và hoàn nguyên liệu. Khay giữ tối đa năm mẻ đã xong. **Nhận tất cả** lấy các mẻ sẵn sàng của máy đang chọn trong một lần lưu, không thay mẻ đang chạy/chờ.

**Ghim món** giữ đúng máy/công thức khi đi tìm nguyên liệu. Chạm nguyên liệu tới nơi cung cấp; **Về tên món** quay lại mục tiêu. Đây là lựa chọn UI trong phiên, không phải đơn hàng có thưởng. Kho có các tab nguyên liệu/sản phẩm và thao tác chọn số lượng để bán.

Menu **Nông trại** đưa về khu giữa gồm 40 ruộng, chuồng đã xây, nhà và kho; đây cũng là giới hạn thu nhỏ. Kéo map để tới xưởng ngoài rìa. Nhấn giữ khoảng 0,45 giây rồi kéo/thả để [đặt công trình](di-chuyen-cong-trinh.md). Các sân và máy rộng bốn ô ruộng trong cùng hệ tọa độ; 40 ruộng giữ nguyên hình học. [Popup](farm-town-modals.md) dùng art Golden Island, đàn/máy dùng prefab Farm Town.

## Bản lưu và tính nguyên tử

Khóa **`ola-farm-cocos-simple-v1`**, pack **v6**, state **v7**, `buildingLayout.version = 6`; dấu mốc `husbandry.version = 1`. Catalog `town-real-time-1` chạy **1× theo thời gian thực**, bỏ 6×/12×. Pack thêm clock v1 tùy chọn để hoàn tất công việc đã trả tiền khi đóng/ẩn game. Không tự cho ăn, đặt mẻ hoặc nhận hàng; khay đầy dừng hàng đợi. Pause/menu/di chuyển công trình dừng thời gian và lưu ngay trạng thái clock. Save cũ không có clock bắt đầu tính từ lúc mở bằng bản mới; các job cũ giữ snapshot đã trả tiền. Xem [đồng hồ và tương thích save](real-time-economy.md#đồng-hồ-offline-và-bản-lưu).

Khi chưa có khóa Ola, game đọc alias cũ `happy-farm-cocos-simple-v1` và ghi sang Ola ở lần lưu thành công, giữ nguyên nguồn cũ. Khóa Ola đã tồn tại nhưng lỗi sẽ mở luồng phục hồi, không lấy save cũ đè lên.

`GameSession.dispatch` thực hiện giao dịch trên bản sao, lưu thành công rồi mới công bố. Lỗi ghi giữ đàn, tiền và công việc đang hiển thị; dữ liệu đang chờ nằm trong `pendingPack`, thử lại chỉ áp dụng giao dịch đó một lần và bỏ thời gian chờ trong trạng thái lỗi. Không cấp lại tài sản khi load. Import/parse xác thực trước khi ghi; không tự reset save lỗi hoặc nhận phiên bản tương lai.

Mỗi con có `slot` 0–4 duy nhất trong chuồng và nhỏ hơn `capacity`. Save cũ toàn bộ con chưa có slot được gán theo thứ tự đàn; giữ sức chứa, ô trống, ID, job, ví và kho. Bản trộn con có/thiếu slot, slot trùng/ngoài sức chứa hoặc sức chứa sáu bị từ chối. Raw source được giữ một lần ở `.before-animal-slots-v1` trước khi ghi chuyển đổi.

Save state v6 được xác thực bằng catalog/hình học một nhà trước khi chuyển lên v7. Giữ nguyên 50 plot cũ và thêm plot 50–53 có `cell: null`, chưa xây; không cấp thêm tiền, con hay máy. Nguồn nguyên bản được giữ một lần ở `.before-two-buildings-v7`. `PreviousFarmValidation` và `PreviousSingleBuildingLayout` giữ hợp đồng phiên bản cũ.

`FarmSave` giữ `.backup`, `.before-import`, `.import-source` và các bản trước migration. Bản hai loài giữ nguồn ở `.before-town-husbandry`; layout v1–v4 giữ nguồn ở `.before-large-machines-v5` và các khóa lịch sử tương ứng. Hình học lịch sử trong `core/legacy/` (`PreviousFarmLayout`, `PreviousPenLayout`, `PreviousLargePenLayout`, `PreviousFourFieldLayout`) vẫn cần để đọc save cũ. Xem [quy tắc migration vị trí](di-chuyen-cong-trinh.md).

Bản cũ/đầy đủ dùng khóa khác; runtime `simple-1` không nhập pack1–3 và không ghi đè nguồn đó. Menu bản lưu cho phép xuất/nhập JSON và phục hồi khi lưu lỗi. Camera, bảng đang mở và món ghim không phải tài sản lưu lâu dài.

## Kiểm chứng

[Lệnh chạy/build/test](../../README.md) là nơi tra cứu. `two-buildings.test.ts` kiểm giới hạn hai nhà, giao dịch, độc lập công việc, vị trí và migration; `pen-slots.test.ts` kiểm giá gộp, giới hạn, slot và giao dịch lỗi; `animal-boost.test.ts` kiểm tăng tốc; `real-time-economy.test.ts` kiểm bộ giá, khóa cây và đồng hồ thực/offline.

Sau khi build, `construction-reset.browser.cjs`, `starter-slot-levels.browser.cjs` và `land-purchase.browser.cjs` kiểm UI khởi đầu, mua nhà/ô/đất hiện hành. Các browser test lịch sử như `two-buildings.browser.cjs`, `pen-slot-levels.browser.cjs`, `animal-boost.browser.cjs` và `real-time-economy.browser.cjs` còn kỳ vọng giá/level hoặc node cũ, cần cập nhật trước khi dùng nghiệm thu phiên bản này. Browser dùng kho lưu riêng; chưa thay thế nghiệm thu Android/iOS trên thiết bị thật.
