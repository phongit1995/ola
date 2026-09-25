# Giá, thời gian và mốc mở hiện hành

Áp dụng cho Cocos `simple-1`, catalog `town-real-time-1`. Thời gian được chỉnh riêng trong [timing.json](../../assets/farm/bundles/farm-town/timing.json); xem [cách áp dụng](timing-config.md). Giá, level, ví/XP và ô đất được chỉnh trong [economy.json](../../assets/farm/bundles/farm-town/economy.json); xem [hướng dẫn giá và mở ô](economy-config.md). [Catalog](../../assets/farm/bundles/farm-town/catalog.json) giữ identity/công thức; [FarmGame.ts](../../assets/farm/scripts/core/FarmGame.ts) thực thi giao dịch. Bảng này thay thế các mức giá/tốc độ thử nghiệm trước đây; các mức thử nghiệm cũ có thể tra cứu trong lịch sử Git.

Thời gian dưới đây là thời gian thực ở 1×. Đóng game vẫn hoàn tất cây, lượt nuôi và các mẻ đã trả nguyên liệu; người chơi phải quay lại nhận hàng và bắt đầu lượt tiếp theo. Tạm dừng, menu tạm dừng và chế độ di chuyển công trình dừng đồng hồ. [Cách tính tiến trình, mô phỏng thời gian chơi và giới hạn](real-time-economy.md).

## Cây trồng

Với cấu hình mặc định, mỗi ô cấp 1 thu ba sản phẩm. Giá bán tính cho **một sản phẩm**; lãi mỗi lượt = 3 × giá bán − giá hạt. XP thu hoạch tính cho cả ô, gieo cây không cho XP. Cây mở muộn có thời gian dài hơn và lãi mỗi lượt cao hơn; cây ngắn ngày giữ lợi thế khi chơi liên tục.

| Cây | Level mở | Thời gian | Hạt/ô | Bán/sản phẩm | Lãi/ô | XP thu/ô |
| --- | ---: | --- | ---: | ---: | ---: | ---: |
| Lúa mì | 1 | 5 phút | 20 | 8 | 4 | 2 |
| Ngô | 1 | 15 phút | 30 | 14 | 12 | 3 |
| Bắp cải | 4 | 45 phút | 45 | 23 | 24 | 5 |
| Củ Cải Đường | 7 | 2 giờ | 65 | 35 | 40 | 8 |
| Khoai Tây | 10 | 4 giờ | 90 | 52 | 66 | 12 |
| Dâu tây | 14 | 6 giờ | 120 | 76 | 108 | 16 |
| Bí Ngô | 18 | 8 giờ | 160 | 104 | 152 | 20 |
| Nho | 24 | 12 giờ | 220 | 150 | 230 | 26 |

## Chăn nuôi và chuồng

Mỗi con ăn một cám, cho một sản phẩm/lượt và 3 XP khi nhận. Mọi chuồng phải mua trong Shop. Gà và cám gà mở ở level 1; bò và cám bò ở level 10. Con đói chờ ăn, không chết. Mua mới không tự cho ăn.

| Loài | Thời gian/lượt | Giá con | Bán/sản phẩm | Chuồng 1: level · giá gồm một con | Chuồng 2: level · giá gồm một con |
| --- | --- | ---: | ---: | --- | --- |
| Gà đẻ trứng | 30 phút | 120 | 32 | Lv 1 · 220 xu | Lv 12 · 4.120 xu |
| Bò sữa | 2 giờ | 240 | 72 | Lv 10 · 440 xu | Lv 24 · 8.240 xu |
| Heo | 6 giờ | 360 | 180 | Lv 15 · 4.860 xu | Lv 30 · 14.360 xu |
| Cừu | 12 giờ | 600 | 320 | Lv 35 · 12.600 xu | Lv 54 · 22.600 xu |

Heo còn cần đã **nhận cám, trứng và sữa**; cừu còn cần đã **nhận burger**. Có sẵn nguyên liệu trong kho của lượt chơi mới không tự hoàn tất mốc. Nhà thứ hai còn cần nhà thứ nhất, đủ tiền và chỗ đặt hợp lệ.

Mỗi chuồng tối đa năm ô/năm con. Mở ô 2–5 tuần tự, trả phí chỗ 45/75/120/180 xu cộng giá con trong cùng giao dịch:

| Loài | Ô 2 + con | Ô 3 + con | Ô 4 + con | Ô 5 + con |
| --- | ---: | ---: | ---: | ---: |
| Gà đẻ trứng | 165 | 195 | 240 | 300 |
| Bò sữa | 285 | 315 | 360 | 420 |
| Heo | 405 | 435 | 480 | 540 |
| Cừu | 645 | 675 | 720 | 780 |

Ô gà 2/3/4/5 yêu cầu level **5/10/15/20**; ô bò giữ level 2/3/4/5. Heo/cừu không có khóa level riêng cho từng ô sau khi đã mua chuồng. Mua lại ở ô đã trả phí chỉ tốn giá con. ID, ô trống và tài sản đã mua trong save cũ được giữ. Bảng chăm hiện không có nút bán con, dù core vẫn hỗ trợ bán con đang đói.

## Máy và hàng đợi

| Máy | Nhà 1: level · giá | Nhà 2: level · giá |
| --- | --- | --- |
| Máy thức ăn | Lv 1 · 200 xu | Lv 12 · 5.000 xu |
| Lò bánh | Lv 5 · 100 xu | Lv 18 · 7.000 xu |
| Xưởng sữa | Lv 10 · 400 xu | Lv 24 · 9.000 xu |
| Bếp nướng | Lv 15 · 1.800 xu | Lv 30 · 12.000 xu |
| Máy Chế Biến Đường | Lv 20 · 6.000 xu | Lv 36 · 18.000 xu |
| Lò Ngô | Lv 25 · 9.000 xu | Lv 42 · 24.000 xu |
| Tiệm Bánh Pie | Lv 30 · 14.000 xu | Lv 48 · 32.000 xu |
| Bàn đan | Lv 35 · 22.000 xu | Lv 54 · 44.000 xu |

Bàn đan còn cần đã nhận burger. Mỗi máy có một ô hàng đợi ban đầu; nâng ô 2/3/4/5 tốn 60/120/200/320 xu. Máy thức ăn yêu cầu level **5/10/15/20** cho bốn ô này; các máy khác giữ level 1. Có thể chỉnh riêng mỗi ô trong economy.json. Mua ô tuần tự theo level người chơi, áp dụng cho cả nhà thứ nhất/thứ hai; lên level không tự mở. Ô đã trả tiền vẫn được giữ trong save cũ. Một máy xử lý từng mẻ tuần tự; hàng đợi tính cả mẻ đang chạy. Khay tối đa năm mẻ; đầy khay thì dừng bắt đầu mẻ tiếp theo.

## Công thức

Giữ nguyên nguyên liệu và số lượng đầu ra của 23 công thức. Giá đầu vào là số xu nhận được nếu bán ngay nguyên liệu; chênh lệch chưa trừ công gieo/nuôi, vốn xây nhà và thời gian thao tác. Mọi mẻ có giá bán cao hơn ít nhất 15% giá trị bán nguyên liệu. Công thức cần đủ level, máy và mốc nội dung liên quan.

| Món | Level | Nguyên liệu → đầu ra | Thời gian/mẻ | Bán nguyên liệu | Bán cả mẻ | Chênh lệch | XP nhận/mẻ |
| --- | ---: | --- | --- | ---: | ---: | ---: | ---: |
| Thức ăn gà | 1 | 2 lúa mì + 1 ngô → 3 thức ăn gà | 5 phút | 30 | 36 | 6 | 2 |
| Thức ăn bò | 10 | 2 ngô + 2 bắp cải → 3 thức ăn bò | 15 phút | 74 | 90 | 16 | 4 |
| Bánh mì | 5 | 2 lúa mì → 1 bánh mì | 10 phút | 16 | 28 | 12 | 3 |
| Bánh nho | 24 | 2 lúa mì + 1 nho → 1 bánh nho | 2 giờ | 166 | 225 | 59 | 20 |
| Bánh dâu | 14 | 2 lúa mì + 1 dâu tây → 1 bánh dâu | 90 phút | 92 | 132 | 40 | 16 |
| Bánh mì ngô | 5 | 2 ngô + 2 trứng gà → 1 bánh mì ngô | 45 phút | 92 | 135 | 43 | 10 |
| Bánh Quế (Waffle) | 20 | 3 lúa mì + 2 trứng gà + 1 đường trắng + 1 ngô → 1 bánh quế (waffle) | 3 giờ | 157 | 250 | 93 | 26 |
| Bơ | 10 | 2 sữa bò → 1 bơ | 30 phút | 144 | 205 | 61 | 9 |
| Phô mai | 10 | 2 sữa bò → 1 phô mai | 1 giờ | 144 | 220 | 76 | 12 |
| Kem sữa | 10 | 1 sữa bò → 1 kem sữa | 20 phút | 72 | 106 | 34 | 6 |
| Sữa Chua Dâu Tây | 14 | 1 sữa bò + 2 dâu tây → 1 sữa chua dâu tây | 2 giờ | 224 | 335 | 111 | 22 |
| Khoai Tây Chiên | 15 | 3 khoai tây + 1 bơ → 1 khoai tây chiên | 90 phút | 361 | 525 | 164 | 22 |
| Bánh Mì Nướng | 15 | 1 bánh mì + 1 bơ → 1 bánh mì nướng | 1 giờ | 233 | 330 | 97 | 14 |
| Đường Trắng | 20 | 1 củ cải đường → 1 đường trắng | 30 phút | 35 | 55 | 20 | 8 |
| Bỏng Ngô | 25 | 3 ngô + 1 bơ → 1 bỏng ngô | 2 giờ | 247 | 355 | 108 | 20 |
| Ngũ Cốc Ngô | 25 | 2 ngô + 1 đường trắng + 1 sữa bò → 1 ngũ cốc ngô | 90 phút | 155 | 220 | 65 | 16 |
| Bánh Bắp Cải | 30 | 2 lúa mì + 2 bắp cải + 2 trứng gà → 1 bánh bắp cải | 2 giờ | 126 | 180 | 54 | 18 |
| Bánh Bí Ngô | 30 | 2 lúa mì + 2 bí ngô + 1 kem sữa → 1 bánh bí ngô | 3 giờ | 330 | 490 | 160 | 28 |
| Cám heo | 15 | 2 bắp cải + 2 khoai tây → 3 cám heo | 30 phút | 150 | 180 | 30 | 6 |
| Burger | 15 | 2 bánh mì + 1 thịt xông khói + 1 phô mai → 1 burger | 3 giờ | 456 | 660 | 204 | 30 |
| Pie khoai thịt | 30 | 2 lúa mì + 2 khoai tây + 2 thịt xông khói → 1 pie khoai thịt | 4 giờ | 480 | 690 | 210 | 34 |
| Cám cừu | 35 | 2 khoai tây + 1 bí ngô → 3 cám cừu | 1 giờ | 208 | 255 | 47 | 8 |
| Áo len | 35 | 2 len → 1 áo len | 6 giờ | 640 | 960 | 320 | 42 |

## Công suất và tổng vốn

Nuôi liên tục 40 con (10 con mỗi loài) cần trung bình `Σ(10 × thời gian mẻ cám / (3 × thời gian nuôi)) = 1.5278` máy cám. Hai máy dùng khoảng **76.4%** công suất để cung cấp đủ cám về mặt thời gian máy. Đây chưa gồm nguồn nguyên liệu, thời gian nhận khay và lịch người chơi; không có tự đặt cám hoặc tự cho ăn.

Từ lượt mới, mua đủ 16 máy, tám chuồng, 40 con và nâng mọi hàng đợi lên năm ô tốn **297.060 xu**, gồm 204.500 xây máy + 67.440 xây chuồng kèm con đầu + 13.920 mở ô kèm 32 con + 11.200 mở hàng đợi. Chưa gồm hạt giống, nguyên liệu hoặc mua lại con đã bán. Đủ tiền vẫn phải đạt các level tương ứng.

Ruộng bắt đầu với sáu ô miễn phí; mua thêm 34 ô theo [bảng giá đất](land-purchase.md) tốn riêng **102.021.000 xu**, tại các level chẵn 2–68. Tổng đất cộng công trình/con/hàng đợi nói trên là **102.318.060 xu**. Giá đất này chưa được đo lại bằng mô phỏng tiến trình dài hạn.

Xong ngay cây/vật nuôi: một kim cương cho mỗi 15 phút còn lại, làm tròn lên. Bán hàng nhận một XP mỗi 100 xu doanh thu cộng dồn; bán lẻ nhiều lần không tăng XP so với bán gộp. Hạt hỗ trợ khi hết vốn không cho XP thu hoạch; sản phẩm vẫn bán để có vốn.
