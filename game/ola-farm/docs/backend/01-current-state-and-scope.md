# 01. Hiện trạng và phạm vi backend

Baseline gameplay là commit `c6c2d26`, ngày 20/09/2026; đường dẫn nguồn và static server đã được rà lại sau refactor `58a13f5` và đợt gỡ HTML cũ ngày 23/09/2026. Đây là kế hoạch triển khai, chưa có backend gameplay được viết hoặc triển khai. Các lựa chọn sản phẩm chưa được người dùng xác nhận được ghi là **đề xuất**; không coi chúng là hành vi hiện tại.

Đề xuất cơ sở là chuyển nông trại tài khoản sang server quyết định kết quả gameplay, kinh tế và thời gian; giữ nông trại đang lưu trên máy thành một nhánh riêng có thể tiếp tục chơi và xuất dữ liệu. Kiến trúc chi tiết nằm ở [02](02-architecture.md), giao dịch ở [03](03-data-and-transactions.md), API ở [04](04-api-contract.md), thay đổi client ở [05](05-client-sync-and-migration.md).

## 1. Những gì đã có

### 1.1. Hai lớp cần phân biệt

| Thành phần hiện tại | Vai trò thực tế | Ý nghĩa đối với backend |
| --- | --- | --- |
| [serve.cjs](../../tools/serve.cjs) | HTTP server Node phục vụ bản build `cocos/build/farm-web-mobile`; mặc định cổng 4173, bind `127.0.0.1`; chạy bằng `npm start` hoặc `npm run start:cocos` | Không có API gameplay, đăng nhập, database, thanh toán hay xử lý đồng bộ; không thể coi việc chạy file này là đã có game server |
| [Cocos project](../../package.json) | Game đang phát triển bằng Creator 3.8.8; TypeScript, scene, prefab và bundle nội dung | Là client mục tiêu của kế hoạch; không chuyển scene/prefab/renderer lên server |
| [FarmGame](../../assets/farm/scripts/core/FarmGame.ts) | Luật trồng trọt, sản xuất, vật nuôi, mua bán, tiến độ và vị trí công trình | Phần engine-free có thể chia sẻ cho client và server sau khi đóng gói; chia sẻ mã không khiến client có quyền xác nhận kết quả |
| [GameSession](../../assets/farm/scripts/core/GameSession.ts) | Clock cục bộ, dispatch đồng bộ, pause, lưu, import/export, reset và sự kiện UI | Hiện là nơi quyết định state sống; cần adapter online riêng, không chỉ thay `localStorage` bằng HTTP |
| [FarmSave](../../assets/farm/scripts/core/FarmSave.ts) | JSON pack, khóa lưu cục bộ, kiểm tra và bản dự phòng | Giữ phục vụ nông trại local; online cache không trở thành nguồn state server |

Bản HTML/JavaScript và static server cũ ở gốc đã được gỡ. `cocos/tools/serve.cjs` chỉ phục vụ tệp build Cocos; kế hoạch backend bổ sung service riêng cho xác thực, kinh tế và đồng bộ.

### 1.2. Cấu hình thực tế của nông trại mới

Nguồn là [catalog.json](../../assets/farm/bundles/farm-town/catalog.json), [economy.json](../../assets/farm/bundles/farm-town/economy.json), [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json), [timing.json](../../assets/farm/bundles/farm-town/timing.json) và [FreshFarm.ts](../../assets/farm/scripts/core/FreshFarm.ts).

| Mục | Giá trị hiện tại |
| --- | --- |
| Profile, rules, thời gian | `simple-1`, `town-real-time-1`, `timeMode: "real"` |
| State và layout mới | `FarmState.version = 7`, `buildingLayout.version = 6`; `FarmPack.version = 6` |
| Ví khởi đầu | 700 xu, 10 kim cương, 0 XP; kho 4 lúa mì + 2 ngô |
| Kho, cây, vật nuôi khởi đầu | Kho rỗng; không có cây đang trồng; không có con vật |
| Ruộng | 40 plot loại `crop` trong mô hình; 6 ruộng mở sẵn |
| Plot tổng | 54: 50 vị trí lịch sử và 4 plot chuồng bổ sung; không đồng nghĩa mọi plot đều hoạt động trong profile hiện tại |
| Nội dung | 8 cây, 23 công thức, 35 loại vật phẩm trong catalog, 8 loại máy, 4 loài vật nuôi |
| Công trình | 16 vị trí máy, 8 vị trí chuồng; tất cả `initial: false`, `initialMachines: []` |
| Giới hạn | Mỗi loại máy tối đa 2 nhà; mỗi loài tối đa 2 chuồng; hàng chờ máy, khay và sức chứa chuồng tối đa 5 theo cấu hình hiện tại |
| Chuồng khi mua | Khởi đầu 1 chỗ và 1 con; giá xây bao gồm phần công trình cùng giá con khởi đầu |
| Điều kiện nuôi | Phải có máy thức ăn; gà/bò không bị gate sản phẩm nâng cao. Heo cần đã nhận cám, trứng, sữa; cừu và bàn đan cần đã nhận burger; từng site vẫn có điều kiện level |
| Đổi xu | 5 kim cương → 250 xu; 10 → 550; 20 → 1.200 |
| Hoàn thành ngay | Cây, vật nuôi và món đang làm trong máy: 1 kim cương cho mỗi 60 giây còn lại, làm tròn lên (`boostSecondsPerGem`) |
| Thưởng lên level | +2 kim cương cho mỗi level mới (`experience.levelUpDiamonds`), mỗi level trả một lần; state lưu `rewardedLevel` |

Vì vậy, với lượt chơi mới hiện tại, người chơi vào Shop và chủ động xây máy/chuồng sau khi đủ xu, level và điều kiện. Lên level chỉ mở quyền mua. Server tạo farm mới phải dùng cùng quy tắc này; không tự xây nhà để thuận tiện cho fixture hoặc onboarding. Save cũ đã có nhà được giữ nguyên quyền sở hữu theo migration hiện có.

`buyMachine` và `buyPen` hoàn tất công trình ngay khi action mua được chấp nhận. Game hiện không có đồng hồ thi công nhà; kế hoạch backend giữ hành vi này, chỉ bổ sung thời gian chờ phản hồi mạng trên UI.

### 1.3. Quyền sở hữu cấu hình

[Art.loadTown](../../assets/farm/scripts/render/Art.ts) đang tải các JSON rồi ghép qua `withFarmEconomy → withFarmTiming → withFarmGameplay → withFarmRuntime`. [load-farm-catalog.cjs](../../tools/load-farm-catalog.cjs) thực hiện kiểm tra nội dung bằng Node.

| Nguồn | Nội dung có thẩm quyền hiện tại | Khi lên server |
| --- | --- | --- |
| `catalog.json` | ID/key, quan hệ recipe–máy–vật phẩm, species, vị trí xây, profile | Đóng gói thành release nội dung bất biến; client gửi ID, không gửi định nghĩa |
| `economy.json` + [FarmEconomy](../../assets/farm/scripts/core/FarmEconomy.ts) | Giá, XP, refund, ví mới, level, gói xu và thông tin xem trước gói kim cương | Server tính tất cả giá và phần thưởng từ release đang áp dụng |
| `timing.json` + [FarmTiming](../../assets/farm/scripts/core/FarmTiming.ts) | Thời lượng cây, vật nuôi, recipe; giây/kim cương | Server tạo snapshot công việc đã trả chi phí; không nhận `ready` hoặc thời lượng do client định giá |
| `gameplay.json` + [FarmGameplay](../../assets/farm/scripts/core/FarmGameplay.ts) | Giới hạn nhà/slot, starting inventory, welcome, rescue, thức ăn và gate | Phần gameplay chạy trên server; cấu hình khởi đầu không phát lại khi đăng nhập/retry |
| `runtime.json` + [FarmRuntime](../../assets/farm/scripts/core/FarmRuntime.ts) | Autosave, offline local, audio, UI, input, camera, tải assets | Audio/input/camera ở client; offline/clock của server có chính sách riêng, không nhận cấu hình này từ client |
| [core/constants](../../assets/farm/scripts/core/constants) | Giá trị mặc định tương thích khi catalog cũ thiếu trường, giới hạn domain, save key | Không tạo bộ giá server độc lập dễ lệch JSON; giữ fallback có phạm vi lịch sử rõ ràng |
| [core/generated/FarmLayoutManifest](../../assets/farm/scripts/core/generated/FarmLayoutManifest.ts) | Geometry logic, vị trí và footprint | Được release và kiểm tra cùng luật placement trên server; dữ liệu hình ảnh trong map/render không cần đưa lên server |

`rulesVersion` hiện là chuỗi có trong state và catalog, không phải danh tính một release nội dung được ký hoặc hash. Không dùng riêng chuỗi `town-real-time-1` để chứng minh hai bản economy/timing giống nhau. Đề xuất `catalogVersion` của API là release ID bất biến bao trùm các cấu hình gameplay và geometry liên quan; xem [02](02-architecture.md) và [04](04-api-contract.md).

## 2. Danh mục đầy đủ các ý định gameplay

[ActionTypes.ts](../../assets/farm/scripts/core/types/ActionTypes.ts) có **24** biến thể `FarmAction`. [FarmActions.ts](../../assets/farm/scripts/core/FarmActions.ts) chuyển từng biến thể đến `FarmGame`. Tất cả action online đều phải kiểm tra quyền sở hữu farm, schema, epoch, revision và catalog theo [04](04-api-contract.md), rồi kiểm tra luật riêng bên dưới trên state server.

Các cột sau mô tả hành vi hiện có, không tự thêm action hoặc đổi giá. Trường tùy chọn giữ tương thích contract; UI nên gửi mục cụ thể nếu người chơi đã chọn một máy, mẻ, chỗ hoặc vị trí xây.

| # | Action và dữ liệu người chơi chọn | Tác động hiện tại | Kiểm tra/điểm cần bảo toàn trên server |
| --- | --- | --- | --- |
| 1 | `moveBuilding(building, position)` | Đổi layout của công trình đã xây | Xác nhận quyền sở hữu công trình, tọa độ hữu hạn, footprint, biên đất, vùng cấm/đường và va chạm theo [BuildingPlacement](../../assets/farm/scripts/core/BuildingPlacement.ts); không tin khung xanh ở client |
| 2 | `plant(plot, crop)` | Trừ xu hạt, tạo snapshot output/refund/thời lượng, cộng planting XP và thống kê | Plot mở, trống, đúng nhóm; cây tồn tại và đủ level; giá và snapshot do server tạo |
| 3 | `harvest(plot)` | Thu output, XP, cập nhật thống kê/gate, làm trống plot | Đã tới `ready` theo server; cùng một lứa chỉ thu một lần; không lấy quantity/XP từ request |
| 4 | `cancel(plot)` | Hủy lứa chưa chín, hoàn `snapshot.refundCoins` | Không hủy lứa đã chín; hoàn theo snapshot đã trả, không định giá lại theo catalog mới |
| 5 | `boost(plot)` | Trừ kim cương, đặt cây sẵn sàng ngay | Còn thời gian, đủ số dư; giá tính tại lúc server xét lệnh; chưa tự thu sản phẩm |
| 6 | `improve(plot)` | Với simple: trừ xu, mở ruộng kế tiếp và cộng XP xây dựng | Thứ tự ruộng, level, giá; nhánh legacy trừ 1 kim cương không được vô tình áp dụng cho online simple |
| 7 | `rescue` | Gieo lúa hỗ trợ miễn phí, không planting/harvest XP, không refund | Đúng điều kiện cạn vốn/kho/công việc và có plot trống; không biến thành endpoint nhận tiền tùy ý |
| 8 | `dismissGuide` | Ghi cờ đã bỏ hướng dẫn | Vẫn ghi state/receipt nhất quán; không cấp ví khởi đầu lần nữa |
| 9 | `produce(recipe, machine?)` | Trừ đủ nguyên liệu ngay lúc xếp hàng, tạo job snapshot, có thể chạy ngay | Máy đúng loại/đã mua, công thức mở, queue còn chỗ; server tạo ID, inputs, outputs, XP, duration |
| 10 | `collect(machine, batch?)` | Nhận một mẻ trong khay, cộng kho/XP/gate, có thể cho máy chạy tiếp | Mẻ thực sự có trong khay; chỉ collect mới cộng kho; receipt nêu mẻ thực tế |
| 11 | `collectAll(machine)` | Nhận toàn bộ khay hiện có bằng một action | Không nhận việc đang chạy/chờ; kiểm tra tổng output trước khi sửa; all-or-nothing |
| 12 | `cancelQueued(machine, job)` | Hủy việc còn chờ và hoàn đủ nguyên liệu snapshot | Không hủy việc đang chạy hoặc đã xong; cùng job không hoàn hai lần |
| 13 | `expandQueue(machine)` | Trừ xu, tăng capacity một chỗ, cộng XP xây dựng | Chỗ tiếp theo, giá, level và giới hạn; capacity hiện có không bị hạ vì config mới |
| 14 | `buyMachine(machineType, building?)` | Trừ xu, mua máy mới, đặt layout hợp lệ, cộng XP xây dựng | Gate/level, số nhà, site tiếp theo, có chỗ đặt; site kỳ vọng chống thao tác trên offer cũ |
| 15 | `sellItem(item, quantity)` | Trừ kho, cộng xu/doanh thu/XP/thống kê | Quantity nguyên dương, đủ hàng; giá server; XP theo chênh lệch tổng doanh thu tránh lợi dụng chia nhỏ giao dịch |
| 16 | `setPenSpecies(plot, species)` | Chỉ nhánh legacy cho đổi loài chuồng trống | Online `simple-1` trả `ACTION_NOT_AVAILABLE`; không mở tính năng mới chỉ vì union có action này |
| 17 | `buyAnimal(plot, slot?)` | Trừ xu, thêm con vào slot trống đã mở | Chuồng đúng loài, slot chưa đổi, còn capacity, có máy thức ăn; ID do server cấp |
| 18 | `buyPen(plot)` | Trừ giá xây kèm con, mở chuồng, cấp số con khởi đầu và layout, cộng XP xây dựng | Loài/site cố định, gate, level, thứ tự nhà, max pens, máy thức ăn và diện tích; một giao dịch cho mọi phần |
| 19 | `expandPen(plot, slot?)` | Trừ giá chỗ cộng giá con, tăng capacity, thêm một con, cộng XP xây dựng | Chỉ mở chỗ kế tiếp, đủ level/xu, đúng slot kỳ vọng và giới hạn |
| 20 | `sellAnimal(plot, animal)` | Bỏ con và hoàn xu theo tỷ lệ bán con hiện hành | Chỉ bán con không có job; slot vẫn tồn tại, capacity không giảm; không nhân đôi hoàn tiền |
| 21 | `feedAnimals(plot, animal?)` | Trừ thức ăn, tạo job cho một hoặc mọi con đang đói | Omit `animal` là chủ ý cho ăn tất cả con đủ điều kiện; đủ tổng cám, dùng snapshot output/XP hiện tại |
| 22 | `boostAnimal(plot, animal)` | Trừ kim cương, job của con sẵn sàng nhận | Job chưa xong, giá theo thời gian server; không tự cộng sản phẩm |
| 23 | `collectAnimals(plot, animal?)` | Nhận một hoặc mọi con có job đã xong; cộng kho/XP/gate và bỏ job | Lọc theo thời gian server, tổng lượng an toàn, không tự cho ăn vòng mới |
| 24 | `buyCoins(pack)` | Trừ kim cương, cộng gói xu cố định; không cộng XP hoặc doanh thu bán hàng | Pack nằm trong catalog release; không nhận giá/số xu/số kim cương do client gửi |
| 25 | `boostMachine(machine)` | Trừ kim cương, món đang làm của máy vào khay ngay, món chờ kế tiếp bắt đầu | Máy có job đang chạy chưa xong; giá theo thời gian server; không tự cộng thành phẩm/XP, chỉ cộng khi collect |

Các action cộng XP (`plant`, `harvest`, `collect`, `collectAll`, `sellItem`, `collectAnimals`, cùng năm action xây dựng `improve`, `expandQueue`, `buyMachine`, `buyPen`, `expandPen` theo `experience.buildXP`) còn trả thưởng kim cương khi vượt level mới và cập nhật `rewardedLevel` trong cùng commit. Server tự tính thưởng, không nhận số kim cương hay level từ client.

### 2.1. Kim cương và trường hợp `buyGems`

Ở baseline được audit **không có** `buyGems` trong `FarmAction`, `FarmGame`, hoặc handler giao diện. [gemsPanel](../../assets/farm/scripts/ui/menu/MenuPanels.ts) hiển thị gói và giá tham khảo; chạm nút chỉ hiện thông báo cửa hàng mở ở bản sau, không cộng kim cương. Không có tích hợp xác thực giao dịch thanh toán.

Điều này không làm kim cương local trở thành tài sản đáng tin: người dùng vẫn có thể sửa số dư JSON/localStorage rồi import một state hợp lệ về hình dạng. Nếu một prototype hoặc bản lịch sử có hàm cấp gems từ client, không đưa hàm đó vào allowlist online. Backend v1 không có public command `buyGems`, `setBalance`, `grantCurrency`, hay tham số `paymentSuccess: true` để cộng tiền. `buyCoins` chỉ tiêu kim cương đã tồn tại hợp lệ trong ledger server. Thanh toán thật là phạm vi bổ sung, chỉ cấp kim cương sau xác thực nhà cung cấp và chống cấp trùng theo [06](06-security-and-operations.md).

## 3. Cách state, thời gian và lưu dữ liệu đang hoạt động

### 3.1. Ranh giới giao dịch cục bộ

Luồng hiện tại là `GameApp.act → GameSession.dispatch → applyAction → FarmGame`.

1. Với profile real-time, session gọi `tick(0)` để bắt kịp `Date.now()` trước khi xét input.
2. Kiểm tra trạng thái UI/session: pause, đang sắp xếp, hidden, lỗi lưu. Riêng `moveBuilding` được dispatch trong chế độ sắp xếp.
3. Tạo `FarmGame` candidate từ bản clone của state đang sống; áp dụng action. Domain error trả message và không publish candidate.
4. Lưu pack candidate bằng `FarmSave.save`; nếu thành công mới thay `game/pack` và phát `committed`.
5. Nếu lưu lỗi, giữ candidate trong `pendingPack`, đánh dấu `storageFailed`, pause để tránh tiếp tục hành động trên dữ liệu chưa lưu.

Đây là cơ chế chống mất thao tác trên máy, chưa phải transaction database. `tick(0)` trước action đã có thể thay thời gian/state sống; các lần `localStorage.setItem` cho backup, bản migration và primary độc lập. Không có lock đa tab, revision, receipt, ledger hoặc commit atomically giữa thiết bị. Không mô tả cơ chế này là đảm bảo chống double-spend của account.

### 3.2. Timer và phần thưởng

[FarmGame.tick](../../assets/farm/scripts/core/FarmGame.ts) nhận số giây từ bên gọi, cộng `state.time` rồi xử lý máy. Core không tự đọc đồng hồ hệ điều hành; server có thể truyền delta do server xác định.

- Cây và vật nuôi có `started/ready`; chỉ khi gọi `harvest`/`collectAnimals` mới nhận kho và XP.
- Job máy đã trừ nguyên liệu ngay khi vào queue. Khi tick qua hạn, máy đưa mẻ vào tray; nếu còn chỗ, job kế tiếp bắt đầu theo mốc hoàn thành trước đó.
- Khay đầy làm máy dừng tiến hàng chờ. Thu khay mở chỗ và có thể bắt đầu job tiếp theo tại thời gian thu hiện tại; không giả lập đã có chỗ trống trong quá khứ.
- `FarmGame` constructor cũng gọi `advanceMachines(state.time)` sau load/validate. Vì vậy GET snapshot server phải trả dữ liệu đã commit, không dựng domain rồi âm thầm trả một state đã được normalize/settle mà DB chưa ghi.
- Crop/production/animal job chứa snapshot phần thưởng đã trả chi phí. Cập nhật catalog không được tính lại những inputs/outputs/XP/refund/duration đã ghi để làm mất quyền lợi hoặc tăng thưởng hồi tố. ID và luật dùng để đọc snapshot cũng phải có chiến lược tương thích.

### 3.3. Pause, offline và tốc độ hiện tại

[runtime.json](../../assets/farm/bundles/farm-town/runtime.json) đặt autosave 2,5 giây, `offlineProgressEnabled: true`, `maxOfflineSeconds: null`.

| Tình huống local hiện tại | Hành vi |
| --- | --- |
| Chơi real-time | Lấy chênh lệch `Date.now`; tốc độ cố định 1 |
| Đồng hồ lùi | Session dùng `max(lastWallTime, now)`; không phát lại đoạn thời gian đã đi qua trong cùng chuỗi clock |
| Đồng hồ tiến xa | Có thể tăng thời gian tương ứng; không có nguồn thời gian độc lập để xác thực |
| Ẩn tab/đóng rồi mở | Nếu pack ghi `clock.running = true`, candidate tiến thời gian offline, lưu rồi publish |
| Chủ động pause/menu/sắp xếp | Từ 26/09/2026 thời gian local vẫn tăng như Hay Day; chỉ chặn action khác; `clock.running` luôn ghi `true` (save cũ có `false` thì lần mở đầu không cộng offline) |
| Lỗi lưu | Pause; retry không chạy bù quãng chờ lỗi lưu |
| Profile legacy | Có tốc độ 1/6/12; mỗi delta frame clamp tối đa 2 giây trước khi nhân speed |

Offline hiện chỉ tự hoàn thành công việc đã trả chi phí, không tự gieo, cho ăn, bán hoặc nhận kho. Tuy nhiên thao tác offline vẫn được client local cho phép sau khi mở game, nên việc kiểm tra đúng thời lượng không chứng minh nguồn gốc tài sản. Online đề xuất đổi hành vi pause: đóng menu, sắp xếp, thoát app hoặc mất mạng đều không dừng timer server; xem [05](05-client-sync-and-migration.md).

### 3.4. JSON save và migration hiện có

| Cấu trúc | Nội dung |
| --- | --- |
| [FarmState](../../assets/farm/scripts/core/types/StateTypes.ts) | Ví, XP, thời gian, inventory theo item key, thống kê, plot, máy/queue/tray, ID, guide/husbandry và layout |
| [FarmPack](../../assets/farm/scripts/core/types/SaveTypes.ts) | `version`, profile, `current: "free"`, `free`, settings và optional `clock` |
| Settings | Speed, sound, music; chưa có account preference service |
| Clock | `{ version: 1, savedAt, running }` hoàn toàn do client ghi |

Khóa hiện dùng là `ola-farm-cocos-simple-v1` và `ola-farm-cocos-40-v1`. Khi mở trong app Ola, game xin accessToken qua bridge và thêm `@<mã tài khoản>` vào mọi khóa ([AccountStorage](../../assets/farm/scripts/core/AccountStorage.ts)); `ola-farm.device-owner` ghi tài khoản đã nhận nông trại cũ của máy; alias cũ tương ứng bắt đầu `happy-farm-…`, theo [SaveKeys](../../assets/farm/scripts/core/constants/SaveKeys.ts). `FarmSave` giữ `.backup`, `.before-import`, `.import-source`, và các snapshot migration đặt tên cho layout, đường, kích thước chuồng/máy, animal slots, town husbandry và two-buildings. Tên key và bytes cũ có giá trị khôi phục; không đổi chung thành khóa account.

Import kiểm tra JSON/schema/domain và chuyển phiên bản qua [FarmMigration](../../assets/farm/scripts/core/FarmMigration.ts), [FarmValidation](../../assets/farm/scripts/core/FarmValidation.ts) và validator/layout lịch sử đóng băng trong [legacy](../../assets/farm/scripts/core/legacy). Simple nhận pack 4/5/6 tương ứng state 5/6/7; pack full farm được báo dùng bản game phù hợp, không âm thầm chuyển sang simple. File picker giới hạn 2.000.000 byte; `FarmSave.parse` giới hạn 2.000.000 ký tự, hai kiểm tra không tương đương với chuỗi Unicode.

Validation hiện kiểm tra ID, loài, số lượng, queue, layout, snapshot và một số ngưỡng số học. Nó **không chứng minh** số dư, XP, output hoặc đồng hồ được tạo bởi một lịch sử chơi hợp lệ. Một số giá trị ví/thống kê chỉ yêu cầu số hữu hạn không âm, trong khi inventory/diamond/ID dùng safe integer. API cần schema và giới hạn rõ ràng, kiểm tra hậu điều kiện sau mutation; không mặc định `FarmAction` TypeScript hoặc validator save là validation request đầy đủ.

## 4. Các thao tác ngoài FarmAction phải xử lý riêng

| Bề mặt hiện tại | Nguồn | Quyết định đề xuất cho online v1 |
| --- | --- | --- |
| `tick`, `advanceOffline` | `FarmGame`/`GameSession` | Server tính settlement; không public endpoint nhận `seconds`, `savedAt` hoặc `ready` tùy ý |
| `restart` | `GameSession`, menu và `GameApp` | Chỉ dùng ở nhánh local; không có reset farm online v1; tạo lại farm không được cấp starting wallet lặp |
| Import JSON | `FarmSave`, [SaveFiles](../../assets/farm/scripts/app/services/SaveFiles.ts), `GameApp.importText` | Giữ ở nhánh local; không POST `FarmState`/`FarmPack` để ghi đè farm account |
| Export nguồn/backup/pending/full legacy | `GameSession.exportSource` | Giữ khả năng cứu dữ liệu local; online export chỉ là bản dữ liệu xem được, không phải vé khôi phục tài sản |
| `retrySave`, `pendingPack` | `GameSession` | Giữ local; online dùng outbox lệnh và receipt, không upload pending pack |
| `setSpeed`, pause/menu, layout editing | `GameSession` | UI presentation/preferences; không tác động server clock; online bỏ tùy chọn tốc độ gameplay |
| Audio, camera, zoom, chọn ô/panel | app/map/UI | Client quản lý; không tạo farm revision/ledger chỉ vì di chuyển camera |
| `farmCocos` global debug | [DebugApi](../../assets/farm/scripts/app/debug/DebugApi.ts), chỉ cài khi `DEBUG` | Hiện read-only: snapshot/pack clone, controls, targets, diagnostics; production phải không cài debug surface và không log token. Debug không phải quyền admin |
| Browser fixtures | [tests](../../tests), setup qua runtime/storage trong môi trường test | Có thể tạo dữ liệu gian lận để test local; không mang đường cấp tiền/XP, import fixture hoặc tick nhanh vào public API |
| Chỉnh JSON nội dung | Các `withFarm…` loader | Chỉ pipeline nội dung được kiểm tra/phát hành; client không chọn số tiền hoặc bật/tắt gate server |

## 5. Phạm vi đề xuất và những gì chưa chốt

### 5.1. Backend đầu tiên cần hoàn thành

1. Tài khoản/phiên đăng nhập và quyền sở hữu farm; bootstrap phân biệt người mới với farm đã tồn tại. Nhà cung cấp đăng nhập, guest account và cách liên kết account còn cần quyết định.
2. Nông trại online `simple-1` với behavior gameplay hiện tại, các action được phép trong bảng 25 action, server clock và catalog release bất biến.
3. REST dưới `/api/v1`, command có `commandId`, `farmEpoch`, `expectedRevision`, `catalogVersion`; ghi state, receipt và economy ledger bằng một transaction theo [03](03-data-and-transactions.md).
4. GET state chỉ đọc snapshot durable; `/sync` dùng cơ chế receipt chung để commit thời gian/công việc tới hạn. Rejected command lưu kết quả từ chối, không commit settlement của candidate.
5. Hỗ trợ mất phản hồi, retry, xung đột nhiều thiết bị/tab, cache cũ, hết phiên và upgrade client bằng hành vi UX xác định ở [05](05-client-sync-and-migration.md).
6. Giữ và cho xuất local save; người chơi chủ động chọn tiếp tục local hoặc vào farm online, không chuyển số dư local thành tài sản trusted.
7. Quan sát vận hành, backup/restore, kiểm thử transaction, phân quyền và rollout có điểm dừng theo [06](06-security-and-operations.md) và [07](07-roadmap-and-testing.md).

Đề xuất triển khai là TypeScript modular monolith, PostgreSQL và phần core engine-free dùng chung. Quy mô tải, nhà cung cấp hosting, khu vực dữ liệu, domain/TLS, auth và nền tảng phát hành chưa được người dùng xác nhận. Các version runtime cụ thể, phương án deployment và giả định tải nằm trong [02](02-architecture.md); chưa coi đó là yêu cầu vận hành đã duyệt.

### 5.2. Không thuộc implementation v1 đã đề xuất

Chưa triển khai ở đợt này: mua kim cương bằng tiền thật; giao dịch giữa người chơi; marketplace, guild, chat hoặc PvP; leaderboard cần chống gian lận riêng; scheduler push notification; reset/import farm account tự phục vụ; nhận phần thưởng từ chuỗi action offline. Nếu bổ sung một mục, phải cập nhật contract, ledger, quyền và nghiệm thu trước khi xây.

Việc giữ game local không có nghĩa bảo đảm các tài sản local dùng được cho tính năng online tương lai. Tính năng chỉ đọc/thăm farm hoặc quà chuyển đổi có thể thiết kế sau, nhưng không phải cách mặc nhiên thừa nhận tiền/XP cũ.

## 6. Ranh giới tin cậy và khoảng trống cần lấp

| Dữ liệu/bên tham gia | Được tin ở mức nào | Khoảng trống hiện tại → yêu cầu backend |
| --- | --- | --- |
| Client request | Chỉ là ý định chưa kiểm chứng | Không nhận toàn bộ state, kết quả, giá, phần thưởng, delta clock hoặc userId tự khai làm quyền sở hữu |
| Local save/cache/export | Dữ liệu do thiết bị kiểm soát | Giữ để phục hồi local/hiển thị; không xác thực tài sản account |
| UI đã khóa nút | Gợi ý tương tác | Server phải tự kiểm tra mọi điều kiện, kể cả nút bị gọi trực tiếp |
| TypeScript types | Kiểm tra lúc biên dịch | HTTP cần runtime validation chặt, giới hạn kích thước và trường cho phép |
| Shared domain | Luật có thể tái sử dụng | Chạy trên candidate thuộc transaction; kiểm tra hậu điều kiện, không expose state mutation tùy ý |
| Server snapshot + ledger | Nguồn đúng cho farm account sau commit | Cần row lock/revision, receipt chống lặp, sao lưu và kiểm tra nhất quán |
| `serverTime` | Clock tham chiếu từ response server | Client dùng để vẽ countdown; settlement chỉ bởi server/DB clock, không từ đồng hồ gửi lên |
| Content release | Được phát hành qua pipeline có kiểm tra | Không ghi đè release ID đang dùng; không đổi job đã trả chi phí hồi tố |
| Admin/support/payment provider | Quyền riêng, không ngang player | Audit, phân quyền, xác thực nguồn và command chuyên dụng khi có nhu cầu; không thêm đường tắt vào API farm |

## 7. Kịch bản xác nhận phạm vi

| Kịch bản | Hiện tại | Kết quả yêu cầu trong kế hoạch online |
| --- | --- | --- |
| Tạo farm mới | Local fresh state | Server tạo một lần: 700 xu/10 kim cương, 4 lúa mì + 2 ngô, 6 ruộng, 0 máy/chuồng/con; retry/bootstrap không cấp thêm |
| Nhấn xây máy hai lần/đứt mạng sau commit | Local UI/save xử lý trong một phiên | Cùng command ID cho cùng lần mua có một receipt, một máy, một lần trừ tiền |
| Hai thiết bị cùng tiêu 10 kim cương | Không có account/revision | Một state thứ tự hóa; lệnh từ revision cũ bị từ chối và client cập nhật |
| Cây chín trong lúc đóng app | Local `Date.now` và pack clock | Timer server tiếp tục; sync xác nhận sẵn sàng; thu hoạch là command riêng |
| Khay đầy khi offline rất lâu | Máy dừng khi khay đầy | Cùng semantics; không tự bán/nhận/giải phóng khay để sản xuất vô hạn |
| Sửa JSON thành nhiều tiền/XP | Có thể qua shape validation nếu dữ liệu phù hợp | Chỉ ảnh hưởng nhánh local; không có route ghi state account từ JSON |
| Bấm gói kim cương | Thông báo bản xem trước | Giữ đóng cửa bán cho đến khi có backend payment riêng; không mint từ client |
| Pause/menu/sắp xếp | Dừng thời gian local | Chỉ dừng tương tác/animation cần thiết; timer account tiếp tục |
| GET state sau nhiều giờ | Chưa có API | Chỉ trả durable snapshot, kèm mốc thời gian; sync/command mới commit settlement |
| Load save nhiều phiên bản | Validator/migration lịch sử | Nhánh local giữ tương thích; migration server là đường độc lập, versioned và test riêng |

## 8. Tiêu chí nghiệm thu phạm vi

1. **SCOPE-01 — Baseline rõ:** tài liệu và task triển khai đối chiếu đúng 25 action; `setPenSpecies` được nêu là không khả dụng ở online simple; không còn hàm/route cấp gems client trong allowlist.
2. **SCOPE-02 — Khởi đầu đúng:** integration test tạo account/farm mới và retry chứng minh đúng tài sản, ruộng và 0 công trình đã xây theo release hiện hành.
3. **SCOPE-03 — Không nhầm static server:** hệ thống online có service/API/DB riêng theo kiến trúc, không đánh dấu hoàn thành chỉ vì `npm start` phục vụ được build Cocos.
4. **SCOPE-04 — Economy đúng nguồn:** giá, gate, XP, duration và footprint server lấy từ release đã validate; client không gửi giá trị làm quyền quyết định.
5. **SCOPE-05 — Dữ liệu đã trả được giữ:** crop/job/animal snapshots và quyền sở hữu/slot cũ không bị định giá hoặc giảm quyền hồi tố khi đổi catalog.
6. **SCOPE-06 — Giao dịch đủ:** mọi action online được accept có state+receipt+ledger cần thiết cùng commit; reject không lưu candidate settlement; retry không tạo tác động lần hai.
7. **SCOPE-07 — Timer phân biệt thưởng:** hoàn thành timer không tự cộng kho/XP từ collect, không tự tạo vòng mới chưa trả nguyên liệu; khay đầy chặn đúng.
8. **SCOPE-08 — Không thăng cấp save tùy ý:** import/reset local không tác động tài khoản; chọn nhánh rõ, byte nguồn và backup local được giữ.
9. **SCOPE-09 — Giới hạn nền tảng minh bạch:** auth, hosting, payment, mức tải và nền tảng chưa chốt được ghi thành quyết định mở hoặc đề xuất, không triển khai dựa vào giả định ẩn.
10. **SCOPE-10 — Có bằng chứng:** tái sử dụng test domain hiện tại và thêm test backend/client ở [07](07-roadmap-and-testing.md), bao gồm concurrency, lost response, clock và migration; chưa coi test local hiện tại là bằng chứng server an toàn.
