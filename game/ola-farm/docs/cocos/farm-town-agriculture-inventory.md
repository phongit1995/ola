# Kiểm kê nguồn Farm Town

Đây là dữ liệu đã đối chiếu từ **APK mod Farm Town 5.16 được cung cấp**, SHA-256 `4233a96b74efe5ec1b73b91e5846f5c0309b7b96c402851abf23ddad438ece5b`. Bảng nguồn có **14 cây ruộng, 10 cây/bụi quả, 6 bụi hoa, 7 loài cho sản phẩm và 29 cơ sở chế biến** với 137 công thức. Chưa chạy APK trên thiết bị để xác nhận toàn bộ hành vi.

Game Cocos hiện chỉ dùng **8 cây, 4 loài, 8 máy, 23 công thức** trong [catalog](../../assets/farm/bundles/farm-town/catalog.json). Gà/bò/heo/cừu đã có prefab đầy đủ; ong/đà điểu/chim công chỉ có trong nguồn khảo sát. Số liệu giá, thời gian, level và sức chứa dưới đây thuộc APK, không được áp thay [luật Cocos](farm-town-husbandry-runtime.md).

Nguồn/hierarchy/ảnh đã nhập được ghi trong [manifest runtime](../../assets/farm/bundles/farm-town/manifest.json). Khảo sát đầy đủ cục bộ ở `artifacts/farm-town/agriculture-audit.json` và `agriculture-source-checks.json`; build chỉ cần asset đã nhập trong Git. Đây là kiểm kê nguồn, không phải kế hoạch nhập tất cả nội dung.

**Cây trồng trên ruộng**

Tất cả 14 ItemID đã nối tới `EntityFarmViewAnim.Animators`, controller/override đúng giống, clip lớn lên/chín/thu hoạch và PNG có thật. Một clip có thể dùng nhiều mảnh ảnh; đây chưa phải 14 prefab Cocos chuyển xong. Giá và thời gian bảng này thuộc nguồn APK, không phải bảng cân bằng mới.

| Cây | Key nguồn | Chi phí gieo | Thời gian nguồn | Cấp công thức nguồn |
| --- | --- | ---: | ---: | ---: |
| Lúa Mì | `wheat` | 0 xu | 30 giây | 1 |
| Ngô | `corn` | 1 xu | 1.5 phút | 2 |
| Bắp Cải | `cabbage` | 2 xu | 5 phút | 5 |
| Củ Cải Đường | `beet` | 2 xu | 10 phút | 7 |
| Cà Rốt | `carrot` | 3 xu | 30 phút | 8 |
| Gạo | `rice` | 6 xu | 30 phút | 9 |
| Khoai Tây | `potato` | 4 xu | 40 phút | 10 |
| Bí Ngô | `pumpkin` | 4 xu | 50 phút | 11 |
| Bông | `cotton` | 5 xu | 60 phút | 13 |
| Cây Lanh | `flax` | 6 xu | 75 phút | 14 |
| Mía | `cane` | 5 xu | 60 phút | 17 |
| Ớt | `pepper` | 5 xu | 50 phút | 24 |
| Đậu | `beans` | 4 xu | 70 phút | 27 |
| Cà Chua | `tomato` | 6 xu | 85 phút | 31 |

Mỗi công thức ruộng nguồn trả 1 sản phẩm. Cấp công thức không tự chứng minh cấp mở thực tế: còn phụ thuộc cấp công trình, điều kiện và shop. Farm hiện có sản lượng/thời gian khác.

**Cây/bụi lâu năm và hoa**

| Loại | Sản phẩm/lượt | Thời gian nguồn | `livesMax` | Dọn cây bằng |
| --- | --- | --- | ---: | --- |
| Cây Táo (`apple_tree`) | 5 Táo | 90 phút | 3 | 1 Cưa |
| Cây Ca Cao (`cacao_tree`) | 5 Hạt Ca Cao | 100 phút | 3 | 1 Cưa |
| Cây Anh Đào (`cherry_tree`) | 5 Anh Đào | 90 phút | 3 | 1 Cưa |
| Cây Cà Phê (`coffee_tree`) | 4 Hạt Cà Phê | 120 phút | 3 | 1 Xẻng |
| Cây Chanh (`lemon_tree`) | 5 Chanh | 90 phút | 3 | 1 Cưa |
| Bụi Mâm Xôi (`raspberry_bush`) | 3 Mâm Xôi | 60 phút | 4 | 1 Xẻng |
| Bụi Dâu Tây (`strawberry_bush`) | 5 Dâu Tây | 40 phút | 4 | 1 Xẻng |
| Tử Đinh Hương (`bush_lilac`) | 1 Tử Đinh Hương | 25 phút | 5 | 1 Dao Cắt |
| Hoa Tulip (`bush_tulip`) | 1 Hoa Tulip | 2 phút | 5 | 1 Dao Cắt |
| Hoa Hồng (`bush_roses`) | 1 Hoa Hồng | 30 phút | 5 | 1 Dao Cắt |
| Cúc Vàng (`bush_hriz`) | 1 Cúc Vàng | 20 phút | 5 | 1 Dao Cắt |
| Hoa Ly (`bush_lily`) | 1 Hoa Ly | 60 phút | 5 | 1 Dao Cắt |
| Hoa Diên Vĩ (`bush_iris`) | 1 Hoa Diên Vĩ | 45 phút | 5 | 1 Dao Cắt |
| Việt Quất (`blueberry`) | 5 Việt Quất | 75 phút | 4 | 1 Xẻng |
| Cây Cam (`orange_tree`) | 5 Cam | 150 phút | 3 | 1 Cưa |
| Quả Lê (`pear_tree`) | 5 Quả Lê | 150 phút | 1 | 1 Cưa |

Các cây trên đều có `unlimitedLives = 0`. Mã máy `EntityPlant.StartGrow` trừ lượt khi bắt đầu đợt mọc; `OnHarvest` gọi lại `StartGrow`; cây chỉ chết khi hết lượt, không còn job và không còn sản phẩm chờ nhận. Vì vậy vẫn nhận được đợt cuối. Dụng cụ phục vụ dọn cây chết, không phải trả cưa cho mỗi lần hái quả. Bản disassembly cục bộ được ghi ở `artifacts/farm-town/native/EntityPlant.asm` trong workspace khảo sát, không nằm trong Git.

Táo/ca cao/anh đào/chanh/cam có 3 lượt, trả 1 ván khi dọn; cà phê 3 lượt, các bụi dâu/mâm xôi/việt quất 4 lượt và hoa 5 lượt, trả 1 dây thừng khi dọn. Riêng lê ghi 1 lượt và không có drop bảo đảm. Đây là cấu hình nguồn cần chú ý khi thiết kế, không sửa thành “mọi cây đều 3 lượt”.

**Vật nuôi cho sản phẩm**

| Vật nuôi | Cho ăn mỗi chu kỳ | Nhận mỗi chu kỳ | Thời gian nguồn |
| --- | --- | --- | --- |
| Gà (`chicken`) | 1 Thức Ăn Chim | 1 Trứng | 10 phút |
| Bò (`cow`) | 1 Thức Ăn Bò | 1 Sữa | 20 phút |
| Heo (`pig`) | 1 Thức Ăn Heo | 1 Thịt Xông Khói | 90 phút |
| Cừu (`sheep`) | 1 Thức Ăn Cừu | 1 Len | 120 phút |
| Ong (`bee`) | 1 Thức Ăn Cho Ong | 1 Mật Ong | 10 phút |
| Đà Điểu (`ostrich`) | 1 Thức Ăn Chim | 1 Lông Đà Điểu | 150 phút |
| Chim Công (`peacock`) | 1 Thức Ăn Chim | 1 Lông Công | 150 phút |

Có prefab và controller cho cả bảy loại, với các clip/role cho ăn, chờ nhận và thu sản phẩm. `EntityAnimal` xử lý job/drop; `EntityYard` quản lý các con vật trong chuồng. Thu sản phẩm giữ con vật; Cocos hiện hành cũng dùng đàn thường trú. Các bản disassembly `artifacts/farm-town/native/EntityAnimal.asm` và `EntityYard.asm` chỉ có trong workspace khảo sát, không nằm trong Git. Key `feed_goat` được công thức **cừu** dùng; chưa có bằng chứng về một loại dê sản xuất riêng.

| Chuồng nguồn | Behavior | Số con tối thiểu / tối đa trong cấu hình |
| --- | --- | --- |
| Chuồng Gà (`coop`) | `EntityYard` | 0 / 6 |
| Chuồng Bò (`cowshed`) | `EntityYard` | 0 / 5 |
| Chuồng Heo (`pigpen`) | `EntityYard` | 0 / 5 |
| Chuồng Cừu (`sheepfold`) | `EntityYard` | 0 / 5 |
| Tổ Ong (`beehive`) | `EntityYard` | 0 / 5 |
| Nhà Đà Điểu (`ostrich_house`) | `EntityYard` | 0 / 5 |
| Nhà Chim Công (`peacock_house`) | `EntityYard` | 0 / 5 |

**29 cơ sở chế biến có prefab và công thức**

Mỗi cơ sở dưới đây được xác minh qua `EntityBusiness`, prefab GameObject, SpriteRenderer và Animator. Danh sách có cả máy nhỏ và cửa hàng sản xuất, không chỉ nhà máy lớn. Cột sản phẩm chỉ lấy ba ví dụ đầu; báo cáo khảo sát cục bộ có toàn bộ công thức.

| Cơ sở | Key nguồn | Số công thức | Ví dụ đầu ra |
| --- | --- | ---: | --- |
| Tiệm Bánh | `bakery` | 8 | Bánh Mì, Bánh Ngô, Bánh Quy Táo |
| Tiệm Bánh Kem | `cake_bakery` | 4 | Bánh Kem, Bánh Cà Rốt, Bánh Phô Mai |
| Nhà Máy Kẹo | `candy_factory` | 4 | Kẹo Bông, Kẹo Dẻo Marshmallow, Sôcôla |
| Máy Chế Biến Thực Phẩm | `food_processor` | 5 | Thức Ăn Chim, Thức Ăn Bò, Thức Ăn Cho Ong |
| Máy Làm Kem | `ice_cream` | 5 | Đá Táo, Đá Chanh, Cappuccino Đá |
| Nhà Máy Mứt | `jam_factory` | 3 | Mứt Táo, Mứt Dâu Tây, Mứt Anh Đào |
| Thợ Kim Hoàn | `jewel` | 6 | Nhẫn Bạc, Vòng Tay Vàng, Vòng Cổ Bạch Kim |
| Bàn Đan Len | `loom` | 2 | Mũ Len, Áo Len |
| Đồ Ăn Mexico | `mexico` | 6 | Bánh Taco, Bánh Burrito, Bánh Enchiladas |
| Nhà Sản Xuất Sữa | `milk_factory` | 7 | Cocktail Hình Con Mắt, Kem, Bơ |
| Lò Nướng | `oven` | 7 | Táo Caramen, Bánh Burger, Khoai Tây Chiên |
| Nhà Máy Sơn | `paint_factory` | 3 | Sơn Đỏ, Sơn Trắng, Sơn Hồng |
| Nhà Máy Giấy | `paper_factory` | 4 | Giấy Vàng, Giấy Trắng, Giấy Đỏ |
| Tiệm Bánh Pie | `pie_bakery` | 7 | Bánh Táo, Bánh Bắp Cải, Bánh Thịt Nghiền (Shepherd's Pie) |
| Lò Ngô | `popcorn_factory` | 5 | Bỏng Ngô, Ngũ Cốc Ngô, Khoai Mandrake Chiên |
| Bàn May | `sewing` | 3 | Áo Thun, Áo Sơ Mi, Quần |
| Lò Luyện Kim | `smelter` | 3 | Thỏi Bạc, Thỏi Vàng, Thỏi Bạch Kim |
| Máy Xay Sinh Tố | `blender` | 4 | Cocktail Mâm Xôi, Sữa Lắc Sôcôla, Sinh Tố Anh Đào |
| Máy Pha Cà Phê | `coffee_machine` | 4 | Cà Phê Đen, Latte, Cappuccino |
| Máy Ép Nước | `drinks` | 4 | Nước Táo, Nước Cam, Nước Cà Chua |
| Nhà Máy Hoa | `flower_factory` | 7 | Bó Hoa Đồng Cỏ, Bó Hoa Tử Đinh Hương, Hoa Cưới |
| Máy Chế Biến Đường | `sugar_processor` | 3 | Kẹo Dẻo Hình Giun, Đường Trắng, Đường Nâu |
| Phụ Kiện | `accessories` | 7 | Quạt Công, Đèn Bí Ngô Jack O’Lantern, Quạt Lông Đà Điểu |
| Mũ | `hats_prod` | 9 | Mũ Hoa Dại, Điện Capitolium, Mũ Biển |
| Cửa hàng Sushi | `sushi_bar` | 5 | Mì Sợi, Sushi, Cuộn Sushi |
| Chảo Wok | `noodle_factory` | 3 | Mì Cá, Mì Heo, Mì Chay |
| Lò Pizza | `pizza_bakery` | 4 | Pizza Pepperoni, Pizza Margherita, Pizza Hải Sản |
| Xưởng Mộc | `carpentry` | 3 | Ghế, Bàn, Tủ Ngăn Kéo |
| Sản Xuất Súp | `soup_manufacture` | 2 | Súp Cà Chua, Súp Bí Ngô |

27 cơ sở ghi queue ban đầu 2, tối đa 7. Xưởng mộc và xưởng súp ghi 0/0 nhưng vẫn có prefab, behavior và công thức; không suy ra hai cơ sở này không tồn tại, cũng không tự áp queue 0 vào Farm.

**Chuỗi thức ăn đã đối chiếu**

| Công thức máy thức ăn | Đầu vào nguồn | Đầu ra/mẻ | Thời gian nguồn |
| --- | --- | --- | --- |
| `feed_chicken` | 2 Lúa Mì + 1 Ngô | 3 Thức Ăn Chim | 6 phút |
| `feed_cow` | 2 Ngô + 2 Bắp Cải | 3 Thức Ăn Bò | 15 phút |
| `bee_eat` | 1 Cúc La Mã + 1 Hoa Anh Túc | 3 Thức Ăn Cho Ong | 4 phút |
| `feed_pig` | 2 Bắp Cải + 2 Cà Rốt | 3 Thức Ăn Heo | 30 phút |
| `feed_goat` | 2 Khoai Tây + 1 Bí Ngô | 3 Thức Ăn Cừu | 45 phút |

**Phạm vi chưa thể coi là nội dung chơi được**

16 nguyên liệu xuất hiện ở đầu vào nhưng không là đầu ra trực tiếp của 177 công thức: `coin`, `emerald`, `diamond`, `fish_raw`, `poppy`, `camomile`, `landysh`, `amela`, `icon_pick`, `dynamite`, `silver_ore`, `gold_ore`, `platinum_ore`, `tnt`, `plank`, `rope`. Một số là tiền/công cụ; ván và dây thừng đã tìm thấy trong drop dọn cây. Hoa dại, cá nguyên liệu, quặng và đá quý cần nối thêm nguồn khai thác/đánh bắt/drop/cửa hàng trước khi dùng các công thức phụ thuộc. Không vì thấy icon cá mà kết luận đã có cả hệ nuôi cá/tôm giống Farm.

Danh mục gồm cả công thức có `bundleParameter`/điều kiện sự kiện. Số lượng đếm được không có nghĩa tất cả mở đồng thời trong game nguồn. Bản thiết kế không chép nguyên thứ tự cấp, giá hoặc thời gian của APK mod.

Các mảnh ảnh, Sprite PPtr và clip chứng minh tài nguyên nguồn tồn tại; không chứng minh Unity Animator đã được port nguyên sang Cocos. Hai gói remote vắng trong APK nằm ngoài phạm vi. Khi cần tái nhập, theo [quy tắc asset](asset-pipeline.md), giữ provenance và kiểm render/action thực tế.
