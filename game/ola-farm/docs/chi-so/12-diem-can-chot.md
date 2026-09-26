# 12. Điểm cần chốt

Theo dõi các quyết định về số liệu và luật. Phần đầu là những gì **đã chốt và đã áp vào game** (đợt 25/09 và 26/09/2026), tiếp theo là bảng so với Hay Day và Township, cuối cùng là những điểm **còn mở** kèm câu hỏi cần quyết định. Số liệu hiện hành lấy từ các tài liệu 01–11.

## Đã chốt đợt 25/09/2026

| # | Nội dung | Trước | Sau |
| ---: | --- | --- | --- |
| A1 | EXP vật nuôi | 3 EXP mỗi sản phẩm cho mọi loài (người chơi 3 lần/ngày: gà 9 EXP/ngày/con, cừu 4,5) | Theo loài, mỗi con mỗi lượt: gà 3, bò 6, heo 12, cừu 20 (người chơi 3 lần/ngày: gà 9, bò 18, heo 24, cừu 30 EXP/ngày/con) |
| A3 | Đường level | 80 + 50 × (L − 1) + 400 × max(0, L − 10)²; level 68 cần 25.461.910 EXP | 15 + 12 × (L − 1) + 80 × max(0, L − 10)²; level 68 cần 5.096.737 EXP |
| A4 | Nhịp chơi (mô phỏng) | Người chơi 3 lần/ngày mất khoảng 22 năm mới mua hết | Mua hết sau 4,1 năm (3 lần/ngày), 2,9 năm (6 lần/ngày), 2 năm (mỗi giờ); xem [02](02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính) |
| B1 | Giá ruộng | Tổng 102.021.000 xu (sàn 2.000 × k, 4 xu mỗi EXP); cuối game dư hàng chục triệu xu | Tổng 30.712.600 xu (sàn 500…6.000, 6 xu mỗi EXP); xem [04](04-ruong.md#giá-đã-được-đặt-ra-thế-nào) |
| C1 | Nguồn kim cương | Chỉ 10 viên lúc bắt đầu | +2 viên mỗi level mới (tới level 68: 134 viên); đổi KEN còn mở (C4) |
| C2 | Giá làm xong ngay, đổi xu | 1 kim cương mỗi 15 phút còn lại (nho 48); đổi xu 200–250 xu mỗi kim cương, 10 kim cương đầu đổi được 2.200 xu | 1 kim cương cho mỗi phút còn lại, làm tròn lên (nho 720); đổi xu 50–60 xu mỗi kim cương; xem [09](09-kim-cuong-xu.md#giá-làm-xong-ngay) |
| C3 | Làm xong ngay cho nhà máy | Không có | Có: nút "Xong ngay" khi khay trống, cùng cách tính giá; xem [06](06-nha-may.md#luật) |

## Đã chốt đợt 26/09/2026

Hai luật nhỏ cho giống Hay Day và Township.

| # | Nội dung | Trước | Sau |
| ---: | --- | --- | --- |
| A6 | EXP khi xây dựng | Xây nhà máy, chuồng, mở ô, mua ruộng không có EXP | Cộng một lần lúc trả tiền: nhà máy 20, chuồng 15, ô chuồng 5, ô hàng chờ 3, ruộng 10 (`experience.buildXP`); cả trang trại 1.132 EXP. Mua lại con đã bán không có EXP; xem [02](02-exp-level-mo-khoa.md#nguồn-exp) |
| D2 | Menu và dời công trình | Mở menu tạm dừng hoặc dời công trình thì cây, vật nuôi, máy đứng yên; thời gian đó mất, thoát game lúc đang tạm dừng không được cộng offline | Đồng hồ luôn chạy như Hay Day; Menu và dời công trình chỉ chặn thao tác khác; bỏ phím Space tạm dừng; chỉ lỗi lưu mới dừng trang trại; xem [10](10-thoi-gian-offline-luu.md#menu-và-dời-công-trình-không-dừng-đồng-hồ) |

Các số nhịp chơi ở [02](02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính) chạy trước hai thay đổi này. Chạy bộ mô phỏng có sẵn trong repo (`tools/simulate-real-time-economy.ts`, 6 lịch chơi) có và không có EXP xây dựng: level 10 đến sớm hơn 0,5–1 ngày, mốc mua hết công trình sớm hơn khoảng 1–1,5 ngày trên hơn 3 năm. Luật menu không đổi kết quả mô phỏng vì người chơi giả không mở menu.

## So với Hay Day và Township

| Luật | Hay Day | Township | Ola Farm (26/09/2026) |
| --- | --- | --- | --- |
| EXP khi thu hoạch cây | Có; cây lâu cho nhiều EXP hơn | Có | Có, 2–26 tùy cây |
| EXP khi nhận hàng nhà máy | Có, khác nhau theo món | Có | Có, 2–42 tùy công thức |
| EXP từ vật nuôi | Có (thu sản phẩm) | Có | Có, theo loài: 3/6/12/20 |
| EXP khi xây dựng | Có khi khánh thành nhà sản xuất hoặc nhà dịch vụ mới, khi đặt trang trí vừa mua | Có khi xây nhà ở, công trình công cộng, nhà máy, chuồng thú | **Có** (A6): nhà máy, chuồng, ô chuồng, ô hàng chờ |
| EXP khi mở rộng đất | Có khi dọn đá, dọn đầm lầy, chặt cây bụi | Có khi mở rộng đất | **Có** (A6): 10 EXP mỗi ruộng mua |
| Bán hàng | Sạp bên đường chỉ ra xu, không EXP; đơn xe tải và tàu ra xu và EXP | Đơn trực thăng, tàu hỏa, máy bay ra xu và EXP | Bán trong kho ra xu và 1 EXP mỗi 100 xu, thay cho đơn hàng (A5) |
| Đơn hàng, nhiệm vụ | Nguồn EXP và xu chính | Nguồn EXP và xu chính (trực thăng cho nhiều EXP nhất) | Chưa có (D1) |
| Đồng hồ khi mở menu | Không dừng | Không dừng | **Không dừng** (D2) |

Hàng "Đồng hồ khi mở menu" là cách hai game này vận hành, không nằm trong các trang nguồn dưới đây. Khác biệt lớn nhất còn lại là đơn hàng (D1): hai game kia dùng đơn hàng để vừa cho EXP, xu, vừa chỉ cho người chơi nên làm gì tiếp.

## Còn mở

### A. EXP và level

| # | Hiện trạng | Cần chốt |
| ---: | --- | --- |
| A2 | **Cây ngắn cho EXP/giờ gấp nhiều lần cây dài:** Lúa mì 24 EXP/giờ/ô, Nho 2,17 (gấp 11,1 lần) nếu gieo lại liên tục. Với người chơi 3 lần/ngày thì ngược lại: mỗi ô lúa mì chỉ 6,7 EXP/ngày, nho 45,8 (xem [03](03-cay-trong.md#mỗi-ô-mỗi-ngày-theo-lịch-chơi)). | Giữ để người cày lợi hơn khi canh cây ngắn, hay thu hẹp khoảng cách? |
| A5 | **Bán hàng cho EXP** (1 EXP mỗi 100 xu). Hay Day không cho EXP khi bán ở sạp mà cho EXP qua đơn hàng. | Giữ EXP bán hàng, hay chuyển sang đơn hàng/nhiệm vụ (xem D1)? |
| A7 | **Sau level 68 không còn gì để mở** (thứ cuối cùng là Ruộng 40), trong khi level tối đa là 99. | Hạ level tối đa, hay thêm nội dung cho level 69–99? |
| A8 | **Cuối game thưa:** kéo dài 3–4 năm với 68 level có nội dung nghĩa là năm thứ 4 người chơi 3 lần/ngày chỉ có 7 level mới, có lúc 59 ngày không có gì mới (xem [02](02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính)). | Thêm việc cho giai đoạn cuối: đơn hàng (D1), nâng cấp đất (B7), sự kiện? |

### B. Giá và kinh tế

| # | Hiện trạng | Cần chốt |
| ---: | --- | --- |
| B2 | **Giá ô hàng chờ giống nhau cho mọi máy** (60/120/200/320), dù nhà máy rẻ nhất 100 xu còn đắt nhất 44.000 xu. | Có cho giá ô hàng chờ tăng theo giá trị máy không? |
| B3 | **Level ô chuồng không có tác dụng với bò, heo, cừu:** ô chuồng bò cấu hình level 2/3/4/5 nhưng chuồng mở ở level 10; ô chuồng heo cấu hình level 1/1/1/1 nhưng chuồng mở ở level 15; ô chuồng cừu cấu hình level 1/1/1/1 nhưng chuồng mở ở level 35. Chỉ ô chuồng gà (level 5/10/15/20) và hàng chờ Máy thức ăn (level 5/10/15/20) là có mốc level thật; hàng chờ các máy khác đều level 1. | Có đặt mốc level cho ô chuồng và ô hàng chờ các máy khác không? |
| B4 | **Bơ và Phô mai cùng dùng 2 Sữa bò, cùng máy:** Bơ (30 phút) lãi 122 xu/giờ máy, Phô mai (1 giờ) 76. Với người chơi 3 lần/ngày thì Phô mai lại hơn: 1.140 so với 915 xu/ngày/máy. | Giữ như vậy (mỗi món hợp một kiểu chơi), hay chỉnh giá/thời gian? |
| B5 | **Cây không có chỗ dùng trong nhiều level:** Bắp cải mở ở L4 nhưng công thức đầu tiên dùng tới ở L10; Củ Cải Đường mở ở L7 nhưng công thức đầu tiên dùng tới ở L20; Khoai Tây mở ở L10 nhưng công thức đầu tiên dùng tới ở L15; Bí Ngô mở ở L18 nhưng công thức đầu tiên dùng tới ở L30. Trong khoảng đó chỉ bán thô được. | Có thêm công dụng sớm hơn (công thức, đơn hàng) hoặc dời level mở cây không? |
| B6 | **Kho không giới hạn** nên không có nâng cấp kho như Hay Day (một chỗ tiêu xu và giữ nhịp chơi). | Có cần giới hạn kho và nâng cấp kho không? |
| B7 | **Nâng cấp đất (cấp 2–4) có trong cấu hình nhưng không có cách nâng.** Sản lượng 5/7/9 (và 4/5/6) chưa dùng. | Bỏ hẳn, hay làm tính năng nâng cấp đất (một chỗ tiêu xu, giải nút thắt nguyên liệu)? |
| B8 | **Sữa là nút thắt cuối game:** tối đa 10 bò, người chơi 3 lần/ngày thu khoảng 30 sữa/ngày, trong khi Bơ, Phô mai, Kem sữa, Sữa Chua Dâu Tây, Ngũ Cốc Ngô cần sữa và Khoai Tây Chiên, Bánh Mì Nướng, Bỏng Ngô cần bơ. Trong mô phỏng (năm 3–4, người chơi 3 lần/ngày) Lò Ngô bỏ trống 100% ô hàng chờ, Bếp nướng 67%, Xưởng sữa 33%. | Cho bò ra 2 sữa mỗi lượt (`animals.dairy-cow.quantity`), thêm bò, hay bớt công thức dùng sữa/bơ? |
| B9 | **Máy Chế Biến Đường lời ít nhất:** một máy với người chơi 3 lần/ngày chỉ tạo khoảng 300 xu chênh lệch/ngày; nhà 2 giá 18.000 xu. | Tăng giá bán/rút thời gian món, hay bỏ nhà 2? |
| B10 | **Máy mở sau không lời hơn máy mở trước:** một máy/ngày với người chơi 3 lần/ngày (xem [07](07-cong-thuc.md#một-máy-mỗi-ngày-với-người-chơi-3-lầnngày)): Bếp nướng (L15) tới 2.187 xu, Tiệm Bánh Pie (L30) 1.280, Bàn đan (L35) 1.280. | Có tăng giá bán hoặc rút thời gian các món cuối game (pie, áo len)? |

### C. Kim cương

| # | Hiện trạng | Cần chốt |
| ---: | --- | --- |
| C4 | **Đổi KEN lấy kim cương chưa làm:** cần ví KEN phía server (backend) và tỷ giá; gói kim cương trong game vẫn chỉ hiển thị. | Tỷ giá KEN → kim cương, giới hạn mua theo ngày, và làm backend trước khi mở? |
| C5 | **Boost việc dài rất đắt so với nguồn kim cương:** 1 kim cương cho mỗi phút còn lại nên nho vừa gieo tốn 720 kim cương, trong khi thưởng lên level chỉ +2 mỗi level (tới level 68 có 134 viên). Tính theo xu, 1 kim cương đổi được 50–60 xu nhưng boost chỉ bớt 1 phút chờ, nên người chơi tính toán sẽ đổi kim cương lấy xu thay vì boost. | Giữ 1 phút một kim cương (chờ đổi KEN), hay tăng `boostSecondsPerGem`: 300 thì nho 144, 900 thì 48? Có hạ tiếp tỷ giá đổi xu không? |

### D. Nội dung và luật

| # | Hiện trạng | Cần chốt |
| ---: | --- | --- |
| D1 | **Không có đơn hàng, nhiệm vụ, thành tích.** Ở Hay Day/Township đơn hàng là nguồn EXP và xu lớn nhất, và cho người chơi biết nên làm gì tiếp. | Có làm bảng đơn hàng không? (tính năng mới) |
| D3 | **Offline không giới hạn** (`maxOfflineSeconds: null`). | Giữ không giới hạn hay đặt trần (ví dụ 24–72 giờ)? |
| D4 | **Bán con vật** có trong code (hoàn 50%) nhưng không có nút. | Làm nút bán con hay bỏ hẳn? |
| D5 | **Hướng dẫn tân thủ gần như không có:** chỉ một bảng chào mừng; các cờ theo dõi tiến trình tân thủ trong code được ghi nhưng không dùng, 3 cờ còn phụ thuộc món Tortilla không còn trong game. | Có làm luồng hướng dẫn 30 phút đầu không? |
| D6 | **Tên hiển thị viết hoa không thống nhất:** "Củ Cải Đường", "Khoai Tây", "Bí Ngô", "Máy Chế Biến Đường" viết hoa từng chữ; "Lúa mì", "Bắp cải", "Máy thức ăn" thì không. | Chốt một kiểu viết tên. |
| D7 | **Bản lưu chưa gắn tài khoản** (localStorage): nhiều tài khoản trên cùng máy dùng chung một nông trại; không chống sửa số. | Làm backend lưu theo tài khoản (Mức 1 hay Mức 2) trước khi phát hành? |
| D8 | **Level farm tách biệt hệ level game của Ola.** Các game PvP của Ola lưu level theo từng game trên server (bảng `user_game_levels`, lên từ level L cần 100 × L EXP, tối đa 99); farm có đường level riêng như trên và không báo EXP về Ola. | Giữ level riêng, hay quy đổi/đồng bộ với level game của Ola? |

Nguồn so sánh (tra ngày 25/09/2026): [Hay Day Wiki – Experience](https://hayday.fandom.com/wiki/Experience), [Hay Day Wiki – Trade](https://hayday.fandom.com/wiki/Trade) (bán ở sạp chỉ ra xu; đơn xe tải/tàu ra xu và EXP), [Township Wiki – Xp](https://township.fandom.com/wiki/Xp).
