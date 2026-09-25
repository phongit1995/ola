# 05. Đồng bộ client, offline và chuyển đổi save

Đây là thiết kế đề xuất cho client Cocos tại baseline `c6c2d26`, chưa phải implementation. Farm online lấy kết quả từ server; farm local hiện có tiếp tục dùng cơ chế lưu cục bộ. Hai nhánh có danh tính, storage và hành vi rõ ràng để đăng nhập, mất mạng hoặc nâng cấp không vô tình ghi đè tiến trình.

Tên trường, HTTP status và mã lỗi lấy [04 · API contract](04-api-contract.md) làm chuẩn. Trình tự transaction, receipt và clock lấy [03](03-data-and-transactions.md) làm chuẩn. Tài liệu này tập trung vào cách UI, session, cache và người chơi xử lý các kết quả đó.

## 1. Những thay đổi người chơi sẽ nhận thấy

| Tình huống | Nhánh local được giữ | Nhánh online đề xuất |
| --- | --- | --- |
| Mở game | Đọc save trên thiết bị | Đăng nhập/khôi phục phiên, tải farm account; cache chỉ giúp hiển thị sớm |
| Xây nhà trong Shop | Đủ điều kiện thì action cục bộ hoàn tất ngay | Đợi server xác nhận mua; nhà xuất hiện sau commit, không thêm thời gian thi công |
| Mua, bán, thu hoạch | Lưu local trước khi UI xác nhận | Server commit trước khi UI xác nhận; có trạng thái đang xử lý |
| Mất mạng | Tiếp tục chơi local | Xem farm và countdown dự kiến; thao tác thay đổi farm chờ kết nối |
| Pause/menu/sắp xếp | Có thể dừng thời gian local theo logic hiện tại | Chỉ thay đổi UI/tương tác; công việc đã trả chi phí tiếp tục theo giờ server |
| Đóng app nhiều giờ | Clock trong pack quyết định chạy bù local | Server settle công việc đã bắt đầu; không tự thu, bán, cho ăn hoặc gieo vòng mới |
| Nhập JSON/chơi lại | Thao tác trên local save | Không có import/reset farm account v1 |
| Đổi thiết bị | Phải chuyển save local | Cùng account tải cùng farm; lệnh cũ được xử lý qua revision/receipt |

Nội dung trong UI dùng ngôn ngữ sản phẩm: “Đang lưu thao tác…”, “Mất kết nối — kết nối lại để thu hoạch”, “Nông trại đã thay đổi trên thiết bị khác”. Không đưa transaction, hash, epoch hoặc ledger vào thông báo thông thường. Mã hỗ trợ/request ID có thể nằm ở màn chẩn đoán.

## 2. Chia adapter theo quyền sở hữu state

### 2.1. Vì sao không chỉ thay `FarmSave` bằng HTTP

[GameSession](../../assets/farm/scripts/core/GameSession.ts) hiện dispatch đồng bộ; nó tự tick từ `Date.now`, clone `FarmGame`, gọi action, ghi storage rồi publish. [GameApp.act](../../assets/farm/scripts/app/bootstrap/GameApp.ts) trả `boolean`, còn [AppFacade](../../assets/farm/scripts/ui/shared/AppFacade.types.ts) và nhiều callback UI dựa vào việc biết kết quả ngay. [SessionTypes](../../assets/farm/scripts/core/types/SessionTypes.ts) cũng mô tả event và `Dispatch` đồng bộ.

Nếu chỉ gửi pack lên HTTP sau khi `GameSession.dispatch` thành công, ví và kho vẫn do client quyết định. Nếu gắn HTTP vào interface `StoragePort.setItem` đồng bộ, lỗi mạng/timeout dễ bị coi nhầm là “chưa commit”. Cần tách session local và session online ở lớp điều phối; server dùng domain trực tiếp trong transaction, không tạo local `GameSession`.

### 2.2. Các thành phần đề xuất

Tên module dưới đây là trách nhiệm để chia việc, không phải file mới đã được tạo. Cách bố trí theo feature/types/constants/schema tuân theo [02](02-architecture.md).

| Thành phần | Trách nhiệm | Không được kiêm nhiệm |
| --- | --- | --- |
| `LocalSessionAdapter` | Bọc `GameSession` hiện tại; giữ import/export/reset/pause và lỗi lưu local | Không gửi state local để cấp tài sản server |
| `OnlineSessionAdapter` | Bootstrap, snapshot đã xác nhận, async command/sync, kết quả receipt, quyền thao tác và event UI | Không tự áp dụng mutation kinh tế rồi coi là đã commit |
| Session port cho UI | Đọc model, capabilities, connection/pending state; gửi intent và nhận kết quả bất đồng bộ | Không expose tùy ý `.state.coins = …`, clock settlement hoặc storage credential |
| API client | Auth headers/cookie, timeout, hủy request, schema response, mã lỗi, request ID | Không tự retry bằng command ID mới hoặc tự chọn farm khác |
| Pending-command store | Lưu chính xác lệnh đã tạo trước khi gửi; khôi phục yêu cầu chưa rõ kết quả | Không xếp hàng hành động mới khi offline; không chứa cả pack để upload |
| Online snapshot cache | Bản cuối server xác nhận, key theo account/farm/epoch, metadata version và checksum kiểm lỗi cục bộ nếu dùng | Không chứng minh tài sản; không phải nguồn overwrite server |
| Display clock/model | Countdown, hình thái cây, dự đoán máy đã xong và vị trí kéo thử | Không cộng ví/kho/XP thật, phát âm thanh nhận thưởng hoặc ghi server snapshot từ dự đoán |
| Account/mode coordinator | Chọn local/online, đổi tài khoản, liên kết, resume và dọn UI theo danh tính | Không merge currency/inventory của hai nhánh hoặc hai account |

Giao diện session có thể thống nhất dạng `submit(action): Promise<outcome>`; adapter local bọc kết quả đồng bộ cũ thành promise. Đây là bước thay đổi contract cần thực hiện có kiểm soát, không bắt mọi logic domain chuyển sang async. Thành phần thuần như query unlock, inventory list và geometry vẫn tái sử dụng được.

### 2.3. Bản đồ thay đổi mã client

| Nguồn hiện có | Công việc khi triển khai | Kiểm tra cần có |
| --- | --- | --- |
| [app/bootstrap/GameApp.ts](../../assets/farm/scripts/app/bootstrap/GameApp.ts) | Boot chọn adapter; `act` chờ kết quả; callback `after`, toast và âm thanh thành công chỉ sau receipt commit; event thay snapshot hủy gesture đang trỏ state cũ | Không đóng panel/hiện nhà hoặc phát thưởng trước commit; callback đến muộn không sửa scene đã hủy |
| [core/GameSession.ts](../../assets/farm/scripts/core/GameSession.ts) | Giữ làm local implementation; bọc qua port thay vì đổi ngầm clock/save của nhánh cũ | Test local cũ tiếp tục qua; không có HTTP bên trong core gameplay |
| [core/types/SessionTypes.ts](../../assets/farm/scripts/core/types/SessionTypes.ts), [UI AppFacade](../../assets/farm/scripts/ui/shared/AppFacade.types.ts) | Bổ sung contract UI async và trạng thái pending/capabilities ở layer thích hợp | Typecheck mọi caller, không dùng promise như boolean |
| [UI menu](../../assets/farm/scripts/ui/menu/MenuPanels.ts) | Local có import/reset; online hiển thị account/kết nối và các khả năng được hỗ trợ; bỏ speed/pause gameplay online, giữ audio | Không gọi nhầm `session.restart/importText` trên account farm |
| [ui/production](../../assets/farm/scripts/ui/production), [ui/livestock](../../assets/farm/scripts/ui/livestock), [ui/inventory](../../assets/farm/scripts/ui/inventory), [ui/shop](../../assets/farm/scripts/ui/shop) | Pending đúng action; ID mục được chọn; refresh theo snapshot mới; xử lý item/slot/mẻ không còn tồn tại | Không dùng reference `Plot/Machine` cũ sau replace; không bật lại nút tạo lệnh mới khi kết quả cũ chưa rõ |
| [map](../../assets/farm/scripts/map), [render](../../assets/farm/scripts/render) | Tách model hiển thị/countdown khỏi state xác nhận; kéo nhà là preview cho tới commit; nhận snapshot mới phải reconcile chọn mục/camera | Pause UI không ngừng timer account; footprint kiểm ở client và server khớp release |
| [render/Art.ts](../../assets/farm/scripts/render/Art.ts) | Xác thực khả năng đọc catalog release mà server trả; tải/cập nhật assets tương ứng trước khi cho action | Không thấy price của bundle cũ nhưng gửi lệnh theo release mới |
| [app/services/SaveFiles.ts](../../assets/farm/scripts/app/services/SaveFiles.ts) | Giữ xuất/nhập local; nếu xuất online thì tách định dạng và nhãn nguồn | File online export không thể nhập vào account để cấp/khôi phục tài sản |
| [app/debug/DebugApi.ts](../../assets/farm/scripts/app/debug/DebugApi.ts) | Chỉ diagnostics không chứa credential; fixture account dùng môi trường test ngoài public API | Production không cài global debug; không có debug grant/tick/import endpoint |

Không đổi tên inspector class/property hoặc di chuyển prefab chỉ để thêm network adapter. Nếu cần thêm UI trạng thái kết nối, giữ dependency UI → session port, không import database/API transport trực tiếp vào từng card.

## 3. Bootstrap và state machine của phiên online

### 3.1. Chuỗi mở game

1. Khởi tạo loading UI và đọc lựa chọn local/online trước đó. Chưa có lựa chọn thì hiển thị lựa chọn rõ nếu phát hiện save cũ; không tự upload JSON.
2. Nhánh local đi theo boot hiện tại. Nhánh online khôi phục phiên xác thực theo [06](06-security-and-operations.md). Web là nền tảng đầu đề xuất; guest/OIDC chưa phải tích hợp hiện có.
3. Đọc cache đúng account/farm nếu có để hiển thị tạm; đánh dấu chưa xác nhận. Không hiện một cache của account trước trong phiên account mới.
4. Gọi `GET /api/v1/me/bootstrap`. API chỉ trả danh tính, lựa chọn/quyền truy cập farm và snapshot durable theo [04](04-api-contract.md); GET không provision và không ghi starter ledger.
5. Nếu account OIDC chưa có `currentFarm`, tạo `operationId` UUID, lưu trước khi gửi `POST /api/v1/me/farms`, rồi nhận farm/opening ledger đã commit. Retry cùng operation trả cùng farm; guest bình thường đã có farm từ `/auth/guest`. Gọi lại bootstrap sau khi tạo, không dựa vào thiếu cache trên máy để quyết định tạo.
6. Kiểm tra account, farm, epoch, schema, catalog release và khả năng client đọc dữ liệu. Nhận snapshot server rồi thay bản xác nhận; không trộn từng field với cache.
7. Nếu có command chưa biết kết quả thuộc đúng account/farm, xử lý receipt/retry chính xác trước khi tạo command mới. Không gửi lại một lệnh chưa rõ bằng ID khác để “làm mới revision”.
8. Gửi `/sync` để xác nhận thời gian trước khi bật kinh tế online, qua cùng hàng điều phối với commands; không chạy sync song song rồi tạo xung đột với lệnh của chính phiên. Nếu gặp conflict, nhận snapshot mới và xử lý như mục 4 trước khi tạo lần sync mới.
9. Khi không còn kết quả mơ hồ, assets/catalog phù hợp và đã có snapshot đầy đủ, bật khả năng gửi action. Thời gian mở menu/loading vẫn là thời gian server tiến bình thường.

Tạo guest mới và provision farm cho account đã xác thực là hai bài toán khác nhau. Client phải lưu `enrollmentKey` trước `POST /auth/guest`; mất response thì retry đúng key/fingerprint để server phát lại credential pending trong cửa sổ cố định, không tạo guest/farm thứ hai. Client gọi `/auth/guest/confirm` sau khi bootstrap xác nhận đúng account; trước confirm, gameplay/link/provision bị khóa. Mất cả key lẫn credential thì không dùng device ID hoặc UUID tự khai để lấy lại quyền. Account OIDC dùng `operationId` đã lưu trước `POST /me/farms`; GET bootstrap không có side effect.

### 3.2. Trạng thái điều phối

| Trạng thái | Có thể hiển thị | Có thể sửa farm online | Lối thoát |
| --- | --- | --- | --- |
| `booting` / `authenticating` | Loading hoặc cache gắn đúng danh tính | Không | Auth/bootstrap thành công hoặc chuyển sang lỗi rõ ràng |
| `enrollment-pending` | Snapshot guest đúng account, thông báo hoàn tất thiết lập | Không | Confirm idempotent thành công; hết phiên thì auth/retry theo enrollment policy |
| `reconciling` | Snapshot gần nhất; thông báo cập nhật | Không tạo lệnh mới | Resolve pending receipt, state/catalog và sync nếu cần |
| `ready` | Snapshot xác nhận cộng dự đoán countdown | Có; tối đa một lệnh/sync đang xử lý mỗi farm trong coordinator | Submit, disconnect, đổi account hoặc version |
| `pending` | Preview/thông báo đang xử lý | Không gửi mutation mới; vẫn cho xem/chuyển panel | Receipt terminal, hoặc timeout sang `uncertain` |
| `uncertain` | Snapshot xác nhận cuối cùng, chưa kết luận thất bại | Không | Retry/tra receipt cùng ID, reconnect hoặc đăng nhập lại |
| `offline` | Cache và countdown dự kiến | Không; không có economic action queue | Khôi phục phiên → reconcile |
| `auth-required` | Thông báo đăng nhập; xử lý cache theo quyền riêng tư | Không | Auth đúng tài khoản hoặc lựa chọn local riêng |
| `upgrade-required` / `catalog-unavailable` | Thông báo cập nhật; dữ liệu raw vẫn được giữ nếu đọc được envelope | Không | Có client/assets phù hợp rồi bootstrap/reconcile |

Đây là trạng thái network của online adapter; không tái sử dụng `GameSession.paused` như một cờ tổng hợp cho tất cả. `paused` hiện ảnh hưởng thời gian gameplay, trong khi `offline/pending` online không được dừng thời gian server.

## 4. Gửi lệnh và chống gửi lặp trên client

### 4.1. Một ý định, một command ID

Đối với mỗi lần người chơi xác nhận hành động khi ready:

1. Đọc `farmId`, `farmEpoch`, `revision`, `catalogVersion` từ snapshot xác nhận gần nhất. `expectedRevision` là decimal string; không ép sang JavaScript `number` hoặc so sánh thứ tự bằng chuỗi thông thường.
2. Tạo UUID `commandId` mới cho **lần ý định này**. Tạo body bằng các trường allowlist; không gửi wallet, XP, inventory, `state.time`, `ready`, giá hoặc kết quả dự tính.
3. Lưu body bất biến và danh tính liên quan vào pending-command store **trước khi truyền**. Nếu không lưu được outbox, không gửi mutation mới; giải thích lỗi lưu yêu cầu và cho thử lại. Không giả định body chắc chắn chưa tới server chỉ vì promise fetch bị reject.
4. Đánh dấu UI pending. Coordinator tuần tự hóa commands và sync cho cùng farm. Client không phải lock bảo mật: nhiều tab/thiết bị vẫn cần revision/transaction server.
5. Gửi `POST /api/v1/farms/{farmId}/commands` hoặc dedicated `/sync`. Body có `protocolVersion: 1`, `commandId`, `farmEpoch`, `expectedRevision`, `catalogVersion`; action chỉ có ở commands theo contract [04](04-api-contract.md). Guest chỉ được gửi sau khi hoàn tất `/auth/guest/confirm`.
6. Receipt terminal được lưu/xử lý theo ID trước khi bỏ pending. Nếu server commit nhưng cache write cục bộ lỗi, giao dịch server vẫn đã thành công: hiển thị kết quả xác nhận và cảnh báo cache; không rollback server hoặc gửi action mới để sửa lỗi cache.
7. Thay snapshot từ `currentFarm` nếu đầy đủ và phù hợp danh tính/version; chỉ sau đó chạy callback UI thành công. Lưu việc đã hiển thị receipt ở phiên hiện tại để retry không phát hiệu ứng nhận thưởng lần nữa.

Outbox chỉ chứa yêu cầu đã tạo khi đang cho phép hành động và cần xác định kết quả; không phải hàng đợi cho người chơi tiếp tục mua/bán/thu hoạch offline. Bản `pendingPack` của local `GameSession` không được đưa vào outbox online.

### 4.2. Hành vi với từng loại kết quả

| Kết quả | Ý nghĩa | Client cần làm |
| --- | --- | --- |
| Receipt `committed` | Server đã ghi tác động của action/sync | Chấp nhận snapshot trả về, hiển thị kết quả một lần, đóng pending; không apply action thêm lên snapshot |
| Receipt `rejected` | Ý định đã có kết quả từ chối bền vững | Hiển thị lý do; cập nhật snapshot hiện tại; bỏ pending. Người chơi muốn thử lại phải có ý định mới, dựa trên state mới |
| Timeout/mất kết nối/response hỏng | Chưa biết commit hay chưa | Giữ nguyên body/ID; trạng thái uncertain; retry cùng yêu cầu, không báo “đã hủy” |
| `REVISION_CONFLICT` | State đã đổi trước khi xét lệnh | Đọc `currentFarm`/GET đầy đủ, sync nếu cần; không tự đổi revision của lệnh cũ rồi gửi như cùng ý định |
| `FARM_EPOCH_MISMATCH` | Lệnh nhắm vòng đời farm khác | Dừng mutation, bootstrap lại; giữ lịch sử receipt. Không chuyển lệnh cũ sang epoch mới |
| `CATALOG_VERSION_MISMATCH` | Nội dung đang dùng đã đổi | Lấy version/asset phù hợp, render lại giá/điều kiện; người chơi xác nhận lại trước ý định mới |
| `COMMAND_ID_REUSED` | Một ID bị dùng với payload khác | Dừng retry mutation đó, ghi diagnostic không chứa token; không tự xoay ID để che lỗi của outbox |
| `NOT_READY`, `INSUFFICIENT_FUNDS`, domain reject khác | Điều kiện server không đủ | Hiện message từ mã lỗi được dịch; refresh; không trừ trước hoặc tự sửa số dư local |
| HTTP 400 với error envelope hợp lệ, xác định được từ server | Request không hợp lệ hoặc không được hỗ trợ theo contract | Nếu có receipt terminal thì xử lý receipt; nếu error xác nhận transport validation chưa dispatch thì dừng lần gửi lỗi và giữ diagnostic. Không retry request sai vô hạn |
| Response sau gửi không parse/validate được | Chưa biết server đã commit hay chưa, kể cả HTTP status trông như lỗi | Giữ pending ở trạng thái uncertain; tra receipt/retry cùng body/ID. Không xóa outbox hoặc coi là chắc chắn chưa commit |
| 401 | Phiên hết hạn/không hợp lệ | Khôi phục auth đúng danh tính; sau đó kiểm tra lại cùng ID chưa rõ kết quả; không chuyển thành guest mới rồi phát lại |
| 403/404 quyền hoặc farm không tồn tại | Không được truy cập farm trong phiên này | Khóa mutation, về bootstrap; không tìm cách thử farm/account khác bằng payload cũ |
| 429/503 | Server yêu cầu chờ hoặc tạm không xử lý lệnh mới | Tôn trọng `Retry-After`/backoff+jitter; cùng ID/body khi retry; không tạo hành động mới khi đang uncertain |
| 409 `CLIENT_UPDATE_REQUIRED` hoặc schema không hỗ trợ | Client cần cập nhật | Khóa mutation mới; giữ pending nguyên vẹn để hỏi kết quả/receipt qua đường còn tương thích hoặc sau cập nhật |

Receipt cũ được tìm sau ownership và trước các kiểm tra epoch/revision/catalog/gate dành cho lệnh mới. Kết quả receipt là bất biến; `currentFarm` trong lần replay có thể mới hơn receipt, thậm chí ở epoch khác. Vì vậy không dựng state bằng cách “replay result” của receipt cũ lên farm hiện tại.

Có thể tra `GET /api/v1/farms/{farmId}/commands/{commandId}` để giải quyết lost response. HTTP 200 của route này chỉ nói tìm thấy receipt, không có nghĩa action đã committed: client phải đọc `receipt.outcome`. Replay POST giữ HTTP business status của kết quả ban đầu. Nếu chưa tìm thấy receipt, đó chưa phải bằng chứng một request đồng thời không còn có thể commit; tiếp tục xử lý cùng ID/body theo [04](04-api-contract.md), không tạo ý định thay thế.

Server giữ ID/hash/kết quả tối thiểu lâu dài theo [03](03-data-and-transactions.md); client không dùng việc đã qua một số giờ/ngày làm bằng chứng lệnh chưa từng commit. Backoff/timeout là cấu hình transport cần đo ở [07](07-roadmap-and-testing.md), không phải TTL cấp quyền tạo ID thay thế.

### 4.3. ID mục được chọn và bulk action

- Nếu UI đang chọn máy cụ thể, gửi `produce.machine`; đang chọn mẻ cụ thể, gửi `collect.batch`; đang mua site cụ thể, gửi `buyMachine.building`; đang chọn chỗ, gửi `buyAnimal.slot`/`expandPen.slot`.
- Contract vẫn cho phép trường optional hiện có. Khi omit, server chọn mục xác định trên state đúng revision và ghi mục thực tế vào result; client không suy ra mục từ array index sau khi state đã thay.
- `collectAll(machine)` là ý định nhận toàn khay. Omit `animal` ở `feedAnimals/collectAnimals` chỉ dùng cho nút tất cả có chủ ý; không bỏ ID vì node UI đã bị hủy.
- Sau khi chạm mua, dù giá preview là số nhỏ, cũng không tự đổi sang site nhà thứ hai hoặc slot kế tiếp khi request đầu đã có tác động. Revision và expected target bảo vệ điều đó.

## 5. Snapshot, countdown và settlement

### 5.1. Ba lớp dữ liệu riêng

1. **Snapshot xác nhận:** envelope chứa `farmId`, `farmEpoch`, `revision`, `catalogVersion`, `stateSchemaVersion`, `stateAsOf`, `state`. Đây là state server đã commit; giữ bất biến đối với logic vẽ frame.
2. **Dự đoán hiển thị:** bản đọc/clone cộng tiến thời gian monotonic để vẽ cây chín, khay dự kiến hoặc countdown. Không ghi trở lại snapshot xác nhận, không dùng để tạo quantity/reward cho request.
3. **Preview thao tác:** vị trí nhà đang kéo, panel đang chọn và trạng thái nút. Có thể bỏ/cập nhật khi snapshot mới đến; không có quyền sở hữu/economy riêng.

`FarmGame` constructor có bước `advanceMachines`; nếu dùng nó để tạo model query cho render, chỉ dùng bản clone dành cho hiển thị. Không lấy clone đã tự chuyển job/tray làm `currentFarm.state` hoặc upload nó. Không gọi session local `tick` để ghi cache online thành bản xác nhận mới.

### 5.2. Công thức thời gian để hiển thị

Response cung cấp `serverTime` và snapshot có `stateAsOf` là mốc settle cuối cùng. Với snapshot nhận tại mốc monotonic `receivedAt` trên thiết bị:

```text
elapsedAtReceive = max(0, serverTime - stateAsOf)
elapsedSinceReceive = max(0, monotonicNow - receivedAt)
displayFarmTime = confirmedState.time + (elapsedAtReceive + elapsedSinceReceive) / 1000
```

ISO timestamp được parse thành milliseconds. Không cộng `serverTime - stateAsOf` vào `state.time` khi nhận rồi cộng lại lần nữa trong mỗi frame. Ước lượng trên không tự bù toàn bộ độ trễ mạng; nó là countdown hiển thị, kết quả sẵn sàng thật vẫn do server xét. Clock hệ thống thiết bị chỉ phục vụ ngày giờ UI; đổi ngày/giờ trên máy không tăng quyền nhận thưởng.

Khi app resume, device sleep hoặc timer monotonic không còn đáng tin, quay về reconcile. Không cố dựng một clock có thẩm quyền từ `Date.now()` hay cache `savedAt`. Có thể hiển thị “Sẵn sàng dự kiến — đang cập nhật” khi hết countdown mà chưa có server xác nhận.

### 5.3. Khi nào đồng bộ

- Bootstrap/resume, sau khi mạng phục hồi, khi tải lại farm trên một thiết bị khác, hoặc lúc cần xác nhận trạng thái timer đang hiển thị.
- GET `/state` chỉ trả durable snapshot; không dùng polling GET như cách âm thầm commit công việc tới hạn.
- POST `/sync` chạy qua cùng coordinator và cơ chế receipt như command. Nếu chưa có command pending, sync bắt kịp thời gian và due transitions; revision có thể tăng dù không có phần thưởng hoặc tiền thay đổi.
- Không gọi sync mỗi frame hoặc theo chu kỳ autosave local 2,5 giây. Chu kỳ refresh online phải có debounce, giới hạn số request, backoff khi ẩn tab/mất mạng và số đo tải; server không cần ghi farm liên tục khi không có nhu cầu.
- Có thể gửi `harvest/collect` trực tiếp từ revision snapshot hiện tại vì accepted command sẽ settle trước action. Nếu state đã đổi trên server, nhận conflict rồi reconcile. Nếu command bị reject, settlement candidate bị bỏ; đừng tự coi countdown/tray dự đoán là durable. Dùng sync riêng khi cần commit thời gian mà không thực hiện action khác.

### 5.4. Giữ đúng mô phỏng công việc đã trả chi phí

Thời gian trôi không tự trừ tiền/cám để chạy vòng mới. Máy chỉ chạy các job đã vào queue và đã trả inputs; đầy tray sẽ dừng. Cây chín không tự cộng inventory; animal job xong không tự cho ăn lại. Catalog mới không sửa snapshot công việc cũ. Các tính chất này phải giống [FarmGame](../../assets/farm/scripts/core/FarmGame.ts) và test domain hiện tại.

V1 đề xuất không giới hạn quãng offline của timer đã trả chi phí, đồng thời số job/con/plot bị giới hạn bởi domain nên xử lý settlement có biên theo số công việc. Nếu sau này cần cap, phải coi đó là thay đổi luật có version, không âm thầm áp vào chuyến đi offline đã xảy ra.

## 6. Nhiều thiết bị, nhiều tab và response đến muộn

Một coordinator trên client giảm xung đột tự gây ra; server vẫn là nơi tuần tự hóa farm. Tab khác có thể gửi lệnh và commit khi tab hiện tại còn hiển thị state cũ.

| Rủi ro | Cách xử lý |
| --- | --- |
| Hai tab cùng revision mua một thứ | Server accept một thứ tự; tab thua nhận conflict. Không merge hai snapshot hoặc tự gửi lại ý định mua |
| Sync chạy cạnh mua hàng ở cùng tab | Coordinator gửi tuần tự; khi sync xong dùng revision mới cho lần bấm mới |
| Response cũ đến sau snapshot mới | Với cùng epoch, không hạ revision. So sánh số nguyên decimal chính xác, không theo thứ tự chuỗi |
| Receipt cũ nhưng `currentFarm` mới | Dùng receipt để kết thúc pending; dùng `currentFarm` để render nếu phù hợp; không giả định `revisionAfter` của receipt là revision hiện tại |
| Epoch khác | Epoch UUID không có thứ tự số lớn/nhỏ; bootstrap xác định farm đang hoạt động, loại bỏ display model cũ. Lệnh cũ chỉ hỏi kết quả, không retarget |
| Metadata-only response | Default yêu cầu snapshot đầy đủ; nếu dùng `includeState=false`, không ghép metadata revision mới với `state` cũ rồi gọi đó là snapshot mới. GET state đầy đủ trước khi bật mutation |
| Đóng panel trong lúc chờ | Kết quả vẫn vào session/account; chỉ callback còn đúng generation/selection mới cập nhật node UI. Node đã hủy không được gọi |
| Đăng xuất/đổi tài khoản trong lúc chờ | Hủy liên kết UI và bỏ request khỏi scene hiện tại; cancellation không chứng minh server hủy commit. Pending được phân vùng theo account, giữ để người đúng quyền reconcile |
| Tab khác thông báo state đổi | Có thể dùng broadcast cùng origin để yêu cầu refresh; thông báo chỉ là hint, không coi payload tab là server snapshot đáng tin |

Outbox/cache phải có schema riêng và gắn `accountId + farmId + farmEpoch`. Khi liên kết guest sang tài khoản khác, dùng mapping và hướng xử lý từ server theo [06](06-security-and-operations.md); không đoán ghép hai farm theo email hoặc tự chọn farm nhiều xu hơn.

## 7. Cache và lỗi lưu trên thiết bị

Cache giúp tải lại nhanh, không phải commit gameplay. Có thể xóa cache online hỏng rồi GET lại mà không mất tài sản server. Ngược lại, xóa local save sẽ làm mất tiến trình local nếu không có backup; UI phải phân biệt hai thao tác này.

| Lỗi | Hành vi yêu cầu |
| --- | --- |
| Không ghi được pending request trước khi gửi | Chưa truyền lệnh; giữ UI và cho thử lại khi storage hoạt động hoặc xử lý theo chính sách rõ ràng đã test |
| Gửi thành công nhưng không ghi được snapshot cache | Chấp nhận receipt server trong bộ nhớ; hiện cảnh báo lưu cache; không trừ/thưởng lại |
| Crash sau server commit, trước xóa outbox | Reload retry cùng body/ID; receipt replay, không có tác động lần hai |
| Cache malformed/schema cũ không đọc được | Giữ thông tin chẩn đoán tối thiểu, bỏ khỏi đường render, tải server; không upload bản lỗi |
| Credential không còn hợp lệ | Auth lại; không dùng accountId trong cache để giả định quyền. Enrollment key pending vẫn chỉ retry đúng key/fingerprint trong cửa sổ của [04](04-api-contract.md#21-vòng-đời-enrollment-guest), không tạo guest mới |
| Xóa dữ liệu trình duyệt của guest | Farm server có thể vẫn tồn tại nhưng credential local mất; quy tắc khôi phục/liên kết phải được giải thích ở thiết kế auth, không hứa có thể tìm lại tự động |

Không đưa refresh token vào JSON export hoặc diagnostics. Với web, cơ chế cookie/token và chống CSRF/XSS theo [06](06-security-and-operations.md); với native cần adapter credential storage phù hợp trước khi coi nền tảng đó được hỗ trợ.

## 8. Chuyển đổi từ bản local hiện tại

### 8.1. Chính sách mặc định

Save local không có chứng cứ chứng minh tiền, XP, vật phẩm hoặc clock. Dù qua validator, nó vẫn là dữ liệu do thiết bị kiểm soát. Đề xuất mặc định: **giữ local nguyên vẹn; account online bắt đầu farm mới do server tạo, hoặc tiếp tục farm server đã có**. Không đồng bộ bằng cách lấy số dư lớn hơn, cộng inventory, chọn save mới hơn theo `savedAt` hay upload toàn bộ JSON.

Đây là lựa chọn sản phẩm được nêu rõ để chốt trước triển khai. Nếu người dùng muốn mang tiến trình cũ sang online, cần thiết kế riêng mức tin cậy, giới hạn quà chuyển đổi, chống nhập lặp, fairness và ledger; không nới validator rồi xem như đã giải quyết gian lận. Một checksum/hash do client tự tính chỉ phát hiện thay đổi bytes, không chứng minh nguồn gốc tài sản.

### 8.2. Luồng lựa chọn trên client

1. Phát hiện khóa save local hiện tại và alias cũ mà không ghi đè. Đọc metadata để giới thiệu có tiến trình cũ; nội dung raw được giữ kể cả parse lỗi.
2. Hiển thị hai đường: **“Tiếp tục nông trại trên máy”** và **“Chơi nông trại tài khoản”**. Nếu account chưa có farm, nói rõ nông trại online mới bắt đầu với dữ liệu server; local vẫn còn để mở/xuất. Không gọi hành động này là “đồng bộ save cũ” khi thực tế tạo farm mới.
3. Nếu chọn local, chạy `GameSession/FarmSave` như hiện tại. Import/restart tiếp tục chỉ thuộc nhánh này.
4. Nếu chọn online, auth/bootstrap; không gửi `FarmPack`. Account đã có farm thì mở farm đó; account OIDC chưa có farm gọi `POST /me/farms` với operationId đã lưu trước, sau đó bootstrap lại. Lặp đăng nhập vào cùng account hoặc thiếu cache không tạo farm mới; guest dùng enrollmentKey như mục 3.1.
5. Lưu lựa chọn chế độ ở key riêng, không dùng key farm để ghi nhãn/account envelope. Có đường quay lại local được bảo toàn.
6. Khi đăng xuất, không xóa local save. Nếu người chơi muốn xóa cache online hoặc dữ liệu thiết bị, UI giải thích đúng phạm vi và tránh xóa nhóm khóa local theo wildcard.

### 8.3. Dữ liệu phải giữ

Theo [SaveKeys](../../assets/farm/scripts/core/constants/SaveKeys.ts) và [FarmSave](../../assets/farm/scripts/core/FarmSave.ts):

- Primary `ola-farm-cocos-simple-v1`, `ola-farm-cocos-40-v1` và alias `happy-farm-cocos-simple-v1`, `happy-farm-cocos-40-v1`.
- `.backup`, `.before-import`, `.import-source`, cùng các bản `.before-*` migration đang có. Không đổi nhãn thành online cache hoặc chạy migration server trên chúng.
- Nội dung raw khi parse lỗi; export nguồn, backup và pending local; byte nguồn full-farm chưa phù hợp profile vẫn phải có đường xuất/khôi phục bằng bản tương ứng.
- Snapshot job/animal/slot/layout sau migration local tiếp tục qua validator lịch sử hiện tại. Thêm online không là lý do sửa snapshot lịch sử đóng băng.

Key online mới phải được namespace riêng, ví dụ theo ứng dụng, phiên bản cache, account và farm; tên cụ thể chốt khi triển khai. Export local tiếp tục là `FarmPack`; export online nếu thêm có envelope nêu nguồn account/farm/revision và nhãn chỉ để xem/sao lưu thông tin, không có đường import tài sản account.

### 8.4. Bảng chuyển đổi và phục hồi

| Dữ liệu trước nâng cấp | Lựa chọn/tình huống | Kết quả bắt buộc |
| --- | --- | --- |
| Không có save local | Chọn online lần đầu | Farm mới do server tạo một lần; không cần import |
| Có simple save mới nhất | Chọn local | Chơi như trước, đồng hồ và backup local giữ nguyên semantics |
| Có simple save cũ state 5/6 | Chọn local | Chạy migration lịch sử có backup như hiện tại; không liên quan epoch/revision account |
| Có full/legacy save | Chọn simple/online | Giữ bytes, chỉ đường bản phù hợp; không cắt mất phần dữ liệu ngoài simple |
| Save local JSON lỗi | Chọn online | Có thể chơi account độc lập; raw lỗi vẫn xuất được, không tự ghi fresh local đè lên |
| Local giàu tài sản + account chưa có farm | Chọn online | Nhận farm server mới theo catalog; local không bị trừ/xóa để đổi sang online |
| Local + account đã có farm | Đăng nhập | Mở farm server; local giữ riêng; không merge |
| Đang chơi online mất mạng | Muốn chơi local | Chỉ chuyển sau lựa chọn rõ; online pending được giữ nguyên theo danh tính, không biến thành local pack |
| Import JSON khi đang online | Mở tính năng local import | Chuyển tới đúng nhánh local có thông báo phạm vi; không endpoint ghi đè account |
| Reset local | Đang có account farm | Chỉ reset local qua cơ chế cũ; online farm/ledger/receipt không thay |
| Client update lỗi | Rollback frontend | Bản cũ không đọc được online schema mới phải chặn mutation; local backup/raw vẫn còn, không ép downgrade dữ liệu |

Migration schema server là một luồng khác trong [03](03-data-and-transactions.md): chạy trên dữ liệu đã được server xác nhận, có transaction/version và kiểm thử. V1 không cung cấp reset online; `farmEpoch` vẫn cần để bảo vệ vòng đời dữ liệu và các trường hợp quản trị/restore tương lai. Không lấy presence của epoch làm lý do thêm nút reset account ngoài phạm vi.

## 9. Trình tự triển khai và bằng chứng kiểm thử

### 9.1. Thứ tự thay client

1. Tách session port và adapter local; giữ toàn bộ test local chạy trước khi nối mạng.
2. Thêm online adapter với fake transport có clock điều khiển để test pending, timeout, reorder và callback sau scene destroy. Chưa thêm optimistic economy.
3. Nối lát cắt account → bootstrap → mua máy thức ăn → retry cùng ID → reload trên thiết bị khác. Xác nhận fresh farm không tự có máy/chuồng và mua nhà không có countdown thi công.
4. Chuyển các nhóm action còn lại; mỗi nhóm có fixture trước/sau, UI loading và mã lỗi; optional target gửi đúng ý định.
5. Tách display clock và kiểm thử offline/resume, khay đầy, catalog update; thêm import/export/mode selection rõ ràng.
6. Chạy môi trường backend/DB thật, nhiều browser context độc lập, mock lỗi mạng có kiểm soát và bộ Cocos hiện có theo [07](07-roadmap-and-testing.md).

### 9.2. Kịch bản nghiệm thu bắt buộc

| # | Kịch bản tái hiện | Kết quả quan sát được |
| --- | --- | --- |
| 1 | Double tap xây cùng máy; response đầu bị mất | Một lệnh logic, một lần trừ tiền/một nhà; retry trả receipt, UI không mọc nhà thứ hai |
| 2 | Server commit collect rồi đóng app trước response | Reload giữ outbox; thu thưởng đúng một lần, state theo server |
| 3 | Hai thiết bị cùng bán số hàng cuối | Một giao dịch thắng, thiết bị còn lại cập nhật; không tồn kho âm và không cộng hai doanh thu |
| 4 | Gửi collect khi countdown local hết nhưng server chưa ready | Domain reject; không tăng kho/XP; UI điều chỉnh theo server |
| 5 | Offline đủ lâu để khay máy đầy | Dự đoán và sync dừng đúng capacity; chưa collect thì kho không tăng |
| 6 | Người chơi tăng/giảm giờ máy vài ngày | Timer account/reward không thay quyền; reconnect lấy mốc server |
| 7 | Mở pause menu hoặc kéo nhà nhiều phút | Công việc account vẫn tiến; drop nhà chỉ commit khi server accept |
| 8 | Lệnh mua cũ nhận conflict hoặc catalog mismatch | Không tự mua site/gói mới; UI cập nhật giá/điều kiện trước khi người chơi bấm lại |
| 9 | Replay receipt cũ sau một command khác đã commit | `currentFarm` mới được hiển thị; snapshot/revision không lùi |
| 10 | Response metadata-only được trả | Client fetch state đầy đủ; không gắn revision mới lên state cũ |
| 11 | Logout/account switch trong lúc mua pending | Không lộ/sửa farm account mới; pending thuộc account cũ vẫn được resolve đúng quyền |
| 12 | Storage quota lỗi trước gửi hoặc sau server commit | Trường hợp trước không truyền mutation; trường hợp sau công nhận commit server, không replay bằng ID mới |
| 13 | Cùng ID nhưng body đã bị sửa trong outbox | Nhận ID reuse error, dừng và chẩn đoán; không tự đổi ID |
| 14 | Import save có tiền/XP rất lớn rồi chọn online | Local giữ nội dung; farm account không nhận tài sản đó |
| 15 | Local lỗi/full legacy/migration qua nhiều version | Dữ liệu raw và backup còn, lựa chọn local/online không ghi đè nguồn |
| 16 | App update và pending command dùng catalog cũ | Có thể hỏi lại kết quả cũ theo contract; chỉ tạo lệnh mới sau khi tương thích catalog/schema |

Nguồn test nên tái sử dụng gồm [game-session.test.ts](../../tests/game-session.test.ts), [real-time-economy.test.ts](../../tests/real-time-economy.test.ts), [construction-reset.test.ts](../../tests/construction-reset.test.ts), [save-branding-migration.test.ts](../../tests/save-branding-migration.test.ts), [simple-save.browser.cjs](../../tests/simple-save.browser.cjs), [building-placement.test.ts](../../tests/building-placement.test.ts) và [two-buildings.test.ts](../../tests/two-buildings.test.ts). Chúng là nền tảng bảo toàn hành vi local, cần bổ sung suite network/transaction riêng; test local không tự chứng minh correctness online.

## 10. Tiêu chí nghiệm thu client và migration

1. **SYNC-01 — Async đúng:** mọi gameplay callback chờ receipt terminal; không có `Promise` được dùng như boolean hoặc node đã destroy còn bị sửa.
2. **SYNC-02 — Một lệnh một kết quả:** outbox ghi trước gửi, retry giữ nguyên body/ID, cùng farm được điều phối tuần tự; timeout không tự báo rollback hay tạo ID mới.
3. **SYNC-03 — State không lùi:** response/replay đến muộn, decimal revision lớn và epoch khác đều được kiểm thử; metadata-only không được ghép với state cũ.
4. **SYNC-04 — Quyền server giữ nguyên:** offline/display tick/preview không cộng ví, kho, XP hoặc tạo job thật; import/debug/local JSON không trở thành dữ liệu ghi account.
5. **SYNC-05 — Clock không cộng hai lần:** countdown dùng server reference + monotonic display delta, resume reconcile, pause/menu không dừng timer account; không tự thu thưởng.
6. **SYNC-06 — Conflict cần ý định mới:** stale revision/catalog/slot không tự phát lại action trên target hoặc giá mới; UI thể hiện đúng thay đổi trước lần bấm tiếp.
7. **SYNC-07 — Account không trộn:** cache/outbox theo danh tính; logout/link/switch và response muộn không lộ hoặc sửa farm của phiên khác.
8. **SYNC-08 — Local được bảo toàn:** checksum/so sánh bytes trước và sau nâng cấp chứng minh primary/backup/raw lịch sử không bị overwrite khi chọn online; local import/reset vẫn đúng phạm vi.
9. **SYNC-09 — Chọn mode rõ:** người có save cũ biết online mở farm server hiện có hoặc tạo farm mới; không có merge kinh tế hay upload local tự động.
10. **SYNC-10 — Lỗi storage không tạo giao dịch lặp:** trước-send failure, after-commit cache failure và crash trước outbox cleanup đều qua kiểm thử.
11. **SYNC-11 — Nội dung tương thích:** client chỉ bật mutation khi catalog/schema được hỗ trợ; job đã trả chi phí giữ snapshot; fresh farm và mua nhà giữ semantics hiện tại.
12. **SYNC-12 — Có bằng chứng liên thiết bị:** bộ 16 kịch bản phía trên chạy trên fake transport có kiểm soát và backend/DB thật; smoke mobile/desktop xác nhận pending, offline, chọn mode và chuyển panel không làm mất thao tác.
