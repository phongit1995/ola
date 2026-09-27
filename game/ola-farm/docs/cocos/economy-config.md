# Chỉnh giá, level và ô đất bằng JSON

> **Số liệu hiện hành đã kiểm chứng nằm ở [Chỉ số game](../chi-so/README.md).** Tài liệu này giữ phần giải thích và lịch sử thiết kế; nếu con số ở đây lệch với `docs/chi-so/` hoặc file JSON thì lấy `docs/chi-so/` và JSON làm chuẩn.

[economy.json](../../assets/farm/bundles/farm-town/economy.json) là nơi chỉnh các con số cân bằng của bản Cocos. Game tải file này cùng [timing.json](../../assets/farm/bundles/farm-town/timing.json) và [catalog.json](../../assets/farm/bundles/farm-town/catalog.json) khi khởi động. Giá và điều kiện trên Shop, bảng chuồng, máy, ruộng và giao dịch trong core cùng dùng dữ liệu đã tải.

Lượt mới có 700 xu/10 kim cương, 4 lúa mì + 2 ngô trong kho, **6 ruộng mở sẵn**, chưa xây máy hoặc chuồng nào. Mỗi level chẵn từ 2 đến 68 cho phép mua thêm một ruộng, tối đa 40 ruộng; giá từ 500 đến 3.080.000 xu theo [bảng giá đất](land-purchase.md). File có tên tiếng Việt ở từng mục để dễ tìm. `name` trong economy chỉ là nhãn tra cứu; tên hiển thị và ID vẫn lấy từ catalog.

## Tìm đúng mục

| Muốn chỉnh | Mục trong economy.json | Ý nghĩa |
| --- | --- | --- |
| Xu, kim cương, XP khi bắt đầu | `startingWallet` | Chỉ áp dụng khi tạo lượt chơi mới |
| Giá hạt, level mở cây, XP thu hoạch | `crops.<key>` | `seedPrice`, `requiredLevel`, `harvestXP` |
| Sản lượng cây theo cấp đất | `crops.<key>.yields` | Bốn số tương ứng cấp đất 1–4 |
| Giá bán mọi nguyên liệu/sản phẩm | `items.<itemKey>.sellPrice` | Xu cho một đơn vị; gồm nông sản, trứng/sữa/thịt/len, cám và thành phẩm |
| Level và XP của công thức | `recipes.<id>` | `requiredLevel`, `xp`; XP nhận khi lấy mẻ đã xong |
| Giá con, sản lượng và XP mỗi lượt | `animals.<key>` | `purchasePrice`, `quantity`, `xp` (XP mỗi con mỗi lượt) |
| Giá mở ô chuồng, level mỗi ô | `animals.<key>.slots` | Bốn mục lần lượt là ô 2, 3, 4, 5 |
| Giá xây máy/nhà, level xây | `machines.<key>.sites` | Hai mục lần lượt là nhà 1 và nhà 2 |
| Giá và level mở hàng đợi máy | `machines.<key>.queueSlots` | Bốn mục lần lượt là ô 2, 3, 4, 5 |
| Giá xây chuồng, level xây | `pens.<buildingId>` | `sitePrice`, `requiredLevel` |
| Ruộng nào mở sẵn, giá/level mở thêm | `fields.<plotId>` | `initiallyUnlocked`, `unlockPrice`, `requiredLevel` |
| Cấp đất ban đầu của từng ruộng | `fields.<plotId>.initialLevel` | 1–4; chỉ áp dụng lượt mới |
| Công thức XP lên level | `experience.curve` | `baseXP`, `linearXP`, `quadraticAfterLevel`, `quadraticXP`, `maxLevel` |
| XP gieo/bán, thưởng kim cương khi lên level | `experience` | `plantingXP`, `saleCoinsPerXP`, `levelUpDiamonds` |
| XP xây dựng (một lần lúc trả tiền) | `experience.buildXP` | `machine`, `pen`, `penSlot`, `queueSlot`, `field`; số nguyên 0–10.000, 0 để tắt |
| Tỷ lệ hoàn hạt/bán lại con | `refunds` | `cropCancelRate`, `animalSaleRate`, từ 0 đến 1 |
| Gói đổi kim cương thành xu | `coinPacks` | `coins`, `diamonds` của từng gói |
| Đổi KEN lấy kim cương | `kenExchange` | `kenPerDiamond` (hiện 1.000 KEN mỗi kim cương), `packs` (1–6 số kim cương chọn nhanh, hiện 10/50/100); form đã có, server trừ KEN chưa làm |

Thời gian trồng/nuôi/chế biến và số giây mỗi kim cương khi làm xong ngay (`boostSecondsPerGem`) nằm trong `timing.json`; xem [hướng dẫn thời gian](timing-config.md). Công thức nguyên liệu/đầu ra, nơi gắn mốc `husbandry`/`crafts` và định danh hình ảnh nằm trong `catalog.json`. Kho, số con/ô khi tạo chuồng/máy, sức chứa và yêu cầu từng mốc nằm trong `gameplay.json`; xem [bảng cấu hình đầy đủ](configuration.md). `sourcePrice` trong catalog là dữ liệu nguồn để đối chiếu, không phải giá bán đang dùng.

## Ví dụ giá nhà và ô

**Bếp nướng nhà 1:** sửa `machines.grill.sites[0]`, mặc định:

```json
{ "price": 1800, "requiredLevel": 15 }
```

`sites[1]` là nhà thứ hai. Mọi máy và chuồng đều phải xây bằng giao dịch trong Shop. Đủ level vẫn phải có nhà trước và đáp ứng mốc sản phẩm nếu loại máy/chuồng đó có mốc; lên level hoặc tải save không tự cấp nhà.

Mốc xây nhà đầu tiên và nhà thứ hai được giãn theo tiến trình:

| Công trình | Level nhà 1 | Level nhà 2 | Giá nhà 1 |
| --- | ---: | ---: | ---: |
| Máy thức ăn | 1 | 12 | 200 xu |
| Chuồng gà | 1 | 12 | 220 xu, gồm một gà |
| Lò bánh | 5 | 18 | 100 xu |
| Xưởng sữa | 10 | 24 | 400 xu |
| Chuồng bò | 10 | 24 | 440 xu, gồm một bò |
| Bếp nướng | 15 | 30 | 1.800 xu |
| Chuồng heo | 15 | 30 | 4.860 xu, gồm một heo |
| Máy đường | 20 | 36 | 6.000 xu |
| Lò ngô | 25 | 42 | 9.000 xu |
| Lò pie | 30 | 48 | 14.000 xu |
| Bàn đan | 35 | 54 | 22.000 xu |
| Chuồng cừu | 35 | 54 | 12.600 xu, gồm một cừu |

Level 1–4 chỉ xây được máy thức ăn và chuồng gà đầu tiên. Ngô và cám gà mở ở level 1 để làm được cám ngay; 700 xu khởi đầu đủ mua máy + chuồng (420 xu) và giữ 280 xu gieo cả 6 ruộng; 4 lúa mì + 2 ngô có sẵn làm được 2 mẻ cám gà ngay. Công thức được đặt theo máy và nguồn nguyên liệu: cám bò level 10, cám heo 15, đường/bánh quế 20, cám cừu 35. Giá và nguyên liệu giữ nguyên. Chuồng còn yêu cầu đã xây máy thức ăn; heo/cừu vẫn cần mốc thu sản phẩm. `catalog.initialMachines` đang rỗng, mọi site có `initial: false`.

**Ô gà thứ hai:** sửa `animals.layer.slots[0]`, mặc định:

```json
{ "price": 45, "requiredLevel": 3 }
```

`price` ở ô chuồng là **phí chỗ**, giá người chơi trả = phí chỗ + `animals.layer.purchasePrice`. Mặc định `45 + 120 = 165 xu`, có ngay một con. Giá mua lại con ở ô trống đã trả phí chỉ là `purchasePrice`.

**Chuồng gà thứ hai:** sửa `pens["pen:50"]`. Mặc định `sitePrice: 4000`, `requiredLevel: 12`. Giá xây trên Shop là `4000 + 120 = 4120 xu`, gồm con đầu tiên theo mặc định. Khi đổi `startingAnimals` trong gameplay, giá xây cộng giá của số con được cấp đó.

**Ô hàng đợi thứ hai của lò bánh:** sửa `machines.bakery.queueSlots[0]`. Giá này là toàn bộ phí mở ô, không cộng thêm nguyên liệu. Khi thiếu level, UI hiện `Lv N` và khóa nút; core cũng kiểm lại trước khi trừ tiền.

**Ô chuồng gà và máy thức ăn:** `animals.layer.slots` và `machines.feedmill.queueSlots` dùng chung các mốc giãn cách sau, áp dụng cho cả nhà 1 và nhà 2:

| Ô | Level mở | Chuồng gà, gồm con mới | Hàng đợi máy thức ăn |
| --- | ---: | ---: | ---: |
| 1 | Khi xây nhà | Đã gồm trong giá xây | Đã gồm trong giá xây |
| 2 | 5 | 165 xu | 60 xu |
| 3 | 10 | 195 xu | 120 xu |
| 4 | 15 | 240 xu | 200 xu |
| 5 | 20 | 300 xu | 320 xu |

Các ô phải mua tuần tự, đạt level không tự mở ô. Đây là level người chơi, không phải số level kể từ khi xây nhà. Ô đã mua trong save cũ tiếp tục dùng được kể cả dưới mốc mới. Ô bò và hàng đợi các máy khác giữ cấu hình riêng hiện có.

## Cấu hình ruộng mở sẵn hoặc mua mở

Có 40 ruộng với ID **0–11 và 22–49**; dùng `name: "Ruộng N"` trong JSON để tra thứ tự 1–40. ID 12–21 thuộc chuồng/anchor cũ, không đưa vào danh sách ruộng.

Ví dụ đặt ruộng thứ hai thành ô phải mua ở level 2, giá 123 xu:

```json
"1": {
  "name": "Ruộng 2",
  "initiallyUnlocked": false,
  "initialLevel": 1,
  "unlockPrice": 123,
  "requiredLevel": 2
}
```

Đây là một mục trong `fields`, không thay toàn bộ file bằng đoạn ví dụ. Map hiển thị những ruộng đã sở hữu và **một ô đất xanh kế tiếp** (asset `Soil0`/`dat0`). Chạm ô xanh: chưa đủ level sẽ hiện khóa và level cần đạt; đủ level sẽ hiện giá xu để mua. Thiếu xu thì nút mua bị khóa. Mua thành công sẽ trừ đúng giá, đổi ô xanh thành đất trồng và hiện ô xanh tiếp theo. Core cũng chặn mua vượt thứ tự hoặc trừ thêm tiền vào ô đã mở. Sau đó gieo/thu hoạch như ruộng bình thường.

`initiallyUnlocked: true` nghĩa là được cấp sẵn trong lượt mới, không thu `unlockPrice`. `false` với giá 0 nghĩa là mở miễn phí khi đạt level. Cần giữ ít nhất một ruộng mở sẵn để có thể bắt đầu trồng hoặc nhận hạt hỗ trợ khi hết vốn.

`initialLevel` chọn cấp đất ban đầu và phần tử sản lượng tương ứng trong `yields`; hiện không có nút mua nâng cấp đất giữa phiên. Cấu hình này áp dụng các vị trí hiện có: 40 ruộng, tối đa hai nhà mỗi loại và năm ô mỗi chuồng/máy. Thêm vị trí hoặc tăng giới hạn vượt bố cục hiện tại cần thay đổi map/UI/save, không chỉ thêm giá vào JSON.

## Lưu, kiểm tra và áp dụng

Từ gốc repo:

```sh
npm run config:check --prefix game/ola-farm
```

Lệnh kiểm cả năm file và báo đúng đường dẫn mục bị lỗi. Giá/XP/level/số lượng dùng số nguyên; level từ 1 đến `maxLevel` (tối đa 99). Giá âm, thiếu mục, sai khóa, số lượng ô không đúng hoặc giá trị trùng trong catalog bị từ chối. `timing:check` cũ vẫn dùng cùng bộ kiểm tra.

Lưu JSON, chờ Creator import asset rồi **khởi động lại Preview**; với Web Mobile thì **build lại** theo [README](../../README.md) và tải lại trang. Game không tự thay luật giữa phiên đang mở. Không cần sửa TypeScript hoặc xóa save để đổi giá các giao dịch tiếp theo.

Nhà/ô/con đã mua, ví, kho, XP và cấp đất trong save được giữ. Các mục `startingWallet`, `initiallyUnlocked`, `initialLevel` chỉ tác động lượt mới; đổi chúng không cấp thêm hoặc thu hồi tài sản trong lượt cũ. Có thể kiểm tra bố cục khởi đầu bằng một lượt mới trong profile trình duyệt riêng.

Để reset lượt đang chơi, dùng **Menu → Chơi lại → Đồng ý**. Luồng này đặt lại ví, XP, kho, công việc và bố cục; mọi máy/chuồng trở về chưa xây. Tải lại trang sau đó vẫn giữ trạng thái chưa xây. Chỉ tải lại Preview không tự xóa công trình trong save cũ.

Cây, lượt nuôi và mẻ đã trả nguyên liệu giữ snapshot đầu ra/XP/thời gian; hạt đã gieo giữ giá hoàn tiền lúc gieo. Giao dịch mới và giá bán hàng trong kho dùng config mới. Thay đường cong XP có thể làm level hiển thị thay đổi, nhưng không mất XP hoặc ô/nhà đã mua. Lỗi lưu giao dịch mở ruộng giữ trạng thái đang thấy; thử lại chỉ trừ tiền và mở ô một lần.

## Luồng dữ liệu và kiểm chứng

[withFarmEconomy](../../assets/farm/scripts/core/FarmEconomy.ts) ghép identity từ catalog với economy; [withFarmTiming](../../assets/farm/scripts/core/FarmTiming.ts) thêm thời gian. [Art.ts](../../assets/farm/scripts/render/Art.ts) và [loadFarmCatalog](../../tools/load-farm-catalog.ts) dùng cùng luồng này. Các giá trị dự phòng trong `core/constants/` được `FarmCatalog.ts` và `Progression.ts` sử dụng chỉ hỗ trợ các catalog cũ không dùng economy; bản hiện hành phải tải/kiểm đủ JSON trước khi tạo game.

`economy-config.test.ts` kiểm giá/level, ví/XP, sản lượng, hoàn tiền, mở ruộng, dữ liệu sai, giữ tài sản cũ và lỗi lưu/thử lại. `economy-config.browser.cjs` thay JSON asset trong context thử nghiệm để kiểm giá thực trên UI và số xu trừ khi mua ruộng, nhà, chuồng, ô máy và ô nuôi, rồi tải lại ở ba viewport. File nguồn mặc định không bị thay bằng số liệu thử nghiệm.

Chạy `npm run verify --prefix game/ola-farm`, `npm run typecheck --prefix game/ola-farm` và các browser test trên bản build mới khi sửa luật. Để đo lại tiến trình theo config, chạy `npm run simulate:balance --prefix game/ola-farm`. Mô phỏng cũng đọc giá/level/ruộng từ JSON; nó mua các ruộng đang khóa khi đủ điều kiện. Kiểm tra cấu hình hợp lệ không chứng minh mọi cách chỉnh giá đều cân bằng hoặc mọi chiến thuật đều hoàn thành trong cùng thời gian.
