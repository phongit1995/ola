# Contract API backend

> Đây là API **đề xuất để triển khai**, chưa phải endpoint có thể gọi. Prefix thống nhất là `/api/v1`. Giao dịch, receipt và đồng hồ tuân theo [03-data-and-transactions.md](03-data-and-transactions.md); cách thay client hiện tại nằm trong [05-client-sync-and-migration.md](05-client-sync-and-migration.md).

## 1. Quy ước chung

REST/JSON qua HTTPS; UTF-8; request gameplay có `Content-Type: application/json`. Server tạo `requestId` phục vụ tra log và trả nó trong mọi response; request ID này khác `commandId` dùng chống áp dụng một ý định hai lần. `accountId` đến từ phiên đã xác thực. `farmId` ở route chỉ là tài nguyên được yêu cầu, không phải bằng chứng quyền sở hữu.

| Trường | Contract |
| --- | --- |
| `protocolVersion` | Số nguyên `1` cho envelope đề xuất hiện tại. |
| `commandId` | UUID v4 do client tạo và giữ nguyên đến khi biết kết quả terminal; mỗi ý định mới dùng ID mới. |
| `farmEpoch` | UUID do server cấp cho lượt farm hiện tại; bắt buộc ở commands và sync. |
| `expectedRevision` / `revision` | Chuỗi thập phân không dấu, không leading zero trừ `"0"`, dài tối đa 19 ký tự và giá trị ≤ `9223372036854775807` theo PostgreSQL bigint; không chuyển qua JavaScript Number. Cocos phải kiểm hỗ trợ BigInt trên target hoặc dùng comparator decimal chính xác. |
| `catalogVersion` | ID release bất biến do server chọn; không phải chuỗi giá trị client tự đề xuất để thay economy. |
| ID domain như `plot`, `machine`, `animal`, `recipe` | Số nguyên an toàn theo `FarmState`/catalog; nhiều ID hiện bắt đầu từ `0`, vì vậy không áp quy tắc tất cả ID phải lớn hơn `0`. |
| `serverTime` | UTC ISO 8601, lấy từ đồng hồ server tại lần trả response. |
| `stateAsOf` | UTC ISO 8601 của watermark `last_settled_at` gắn với chính snapshot được trả. |
| `error.code` | Mã ổn định để client xử lý; `message` có thể địa phương hóa và không được dùng để phân loại lỗi. |

Mọi object request dùng schema tường minh và `additionalProperties:false`, kể cả `action.position`. `enrollmentKey` chỉ là secret enrollment ngoài command, có entropy tối thiểu do backend chốt, không log và không dùng làm `farmId`; `operationId` của `POST /me/farms` là UUID riêng. Không nhận các trường số dư, giá, duration, outputs, XP, farm state, `Date.now`, `speed` hoặc `accountId` trong command. Từ chối duplicate JSON keys, chuỗi giả số, số âm ở lượng tiền/hàng và số ngoài safe integer. Tọa độ là số hữu hạn và còn phải qua geometry/snap/collision của catalog server. Đề xuất trần body command 16 KiB; trần này khác import local 2 MB.

Fastify dùng request schema để chặn đầu vào và response schema để chỉ trả các trường cho phép. Cấu hình validator phải từ chối dữ liệu lạ thay vì âm thầm coerce/bỏ trường; kiểm quyền, balance và invariant domain thực hiện trong service/transaction, không trong validator async truy cập DB. Validation chia hai bước: envelope ổn định và JSON/size được kiểm trước; action schema hiện hành chỉ áp sau khi xác thực, khóa farm và không tìm thấy receipt. Vì vậy action cũ đã có receipt vẫn replay được khi allow-list/catalog mới thay đổi. Không đặt một schema action chỉ hỗ trợ phiên bản mới ở middleware trước đường replay. Schema là tài sản mã nguồn được review, không cho client cung cấp. [Fastify: Validation and Serialization](https://fastify.dev/docs/latest/Reference/Validation-and-Serialization/).

Parser phải phát hiện key trùng trước khi chuyển JSON thành object; `JSON.parse` rồi validate schema không còn thấy key đã bị ghi đè. Cấu hình Ajv tắt `coerceTypes`, `removeAdditional`, `useDefaults` cho request. Envelope giới hạn size/depth và giữ nguyên action để hash/replay; chỉ action mới qua schema chi tiết sau lookup. Không áp schema mới lên receipt cũ. Test bằng raw JSON, kể cả key trùng dùng escape Unicode, thay vì chỉ truyền object trong test route.

Response có auth/account/farm/receipt, kể cả lỗi và redirect cấp phiên, dùng `Cache-Control: no-store`; proxy/CDN/service worker không cache các route đó. Snapshot cache chủ động của app vẫn theo namespace ở [05](05-client-sync-and-migration.md). Chỉ asset/catalog công khai bất biến được cache dài hạn; policy công khai dùng chính sách ngắn hạn riêng.

### Đồng hồ phía client

Snapshot chứa `state.time` ở `stateAsOf`; muốn hiển thị thời gian dự đoán, client dùng một công thức nhất quán:

`displayTime = snapshot.state.time + max(0, serverTime - stateAsOf) / 1000 + elapsedMonotonicSinceResponse`.

Không cộng phần `serverTime - stateAsOf` vào state rồi cộng lại lần nữa trong timer. Network latency làm countdown chỉ là hiển thị gần đúng; đến mốc ready vẫn cần command/sync được server chấp nhận để cộng hàng. Dùng monotonic clock để nội suy, reset baseline khi nhận snapshot mới. `receipt.evaluatedAt` có thể là thời điểm cũ khi replay, không được thay cho `serverTime`. Snapshot cũ không được ghi đè snapshot có revision mới hơn hoặc epoch khác.

## 2. Danh sách endpoint

Các đường dẫn trong bảng đều bắt đầu bằng `/api/v1`.

| Method và route | Quyền/đầu vào | Kết quả và tác dụng |
| --- | --- | --- |
| `GET /client-policy` | Không cần đăng nhập; client build/protocol qua header | Maintenance, min client, protocol hỗ trợ, feature flags công khai, thời điểm server. Không trả gameplay state hoặc secret. |
| `POST /auth/guest` | Body `{enrollmentKey}` bí mật 32 byte ngẫu nhiên, base64url không padding; không nhận farm/save | Tạo guest/farm/ownership/phiên một lần. Trong enrollment pending còn hạn, retry cùng key/fingerprint trả cùng credential còn hợp lệ; không rotate mỗi retry. Xem mục 2.1. |
| `POST /auth/guest/confirm` | Phiên guest vừa cấp + CSRF ở web, body `{}` | Đóng enrollment của phiên atomically, xóa ciphertext phát lại credential; idempotent `204`, không rotate cookie. Client xác nhận trước gameplay và xóa key cục bộ sau thành công. |
| `POST /auth/oidc/start` | Provider allow-list, loại client, redirect alias; PKCE `S256` cho web/native và binding tạm thời với browser/session khởi tạo | Tạo auth transaction và URL đăng nhập; không nhận arbitrary redirect URL. |
| `GET /auth/oidc/{provider}/callback` | Web authorization code + state | Kiểm auth transaction, đổi code ở server, xác minh identity, phát hành phiên web và redirect đến đường dẫn đã cho phép. |
| `POST /auth/oidc/exchange` | Native: transaction ID, code, PKCE verifier | Hoàn tất flow native, xác minh ID token ở server, trả phiên native. Không nhận `accountId`/email như bằng chứng. |
| `POST /auth/refresh` | Web: cookie hợp lệ + CSRF, body `{}`. Native: refresh credential qua adapter riêng | Web gia hạn idle trong absolute expiry, giữ cùng opaque credential. Native rotate token một lần, giữ lịch sử hash để phát hiện reuse. Lost response native yêu cầu reauth theo [06](06-security-and-operations.md); không dùng retry command cho auth. |
| `POST /auth/logout` | Phiên hiện tại và CSRF nếu dùng cookie | Revoke phiên/refresh family tương ứng, xóa cookie; không reset hoặc xóa farm. |
| `POST /auth/logout-all` | Phiên đã xác minh lại khi cần | Revoke mọi phiên của account; không thay state. |
| `GET /me/bootstrap` | Phiên hợp lệ | Account tối thiểu, farm đang chọn, durable snapshot, catalog/policy, serverTime. Không settlement hoặc reward ngầm. |
| `POST /me/farms` | Account đã xác thực chưa có farm active + body `{operationId: UUID}` đã lưu trước request | Tạo một farm từ catalog server và opening ledger trong một transaction; retry cùng operation và cùng fingerprint trả cùng farm, không cấp starter lần hai. Cùng operation với payload khác trả `OPERATION_ID_REUSED`. Nếu account đã có farm active thì ghi/tra operation theo policy và trả farm đó, không tạo farm thứ hai. |
| `GET /farms/{farmId}/state` | Owner | Full durable snapshot + revision/epoch/catalog/time. Không ghi và không khởi tạo `FarmGame` có side effect. |
| `POST /farms/{farmId}/sync` | Owner + envelope không có action | Quyết toán timer bằng đồng hồ server, commit state/revision/receipt, trả snapshot. Đây là lifecycle operation riêng, không thêm `sync` vào union 25 action hiện tại. |
| `POST /farms/{farmId}/commands` | Owner + envelope có đúng một action | Áp dụng ý định gameplay trong một transaction; success hoặc rejection có receipt terminal. |
| `GET /farms/{farmId}/commands/{commandId}` | Owner | Tra receipt trên primary, dùng cho lost response; không chạy action và không settlement. Receipt sync dùng cùng route này. |
| `GET /catalogs/{catalogVersion}` | Có thể public nếu release được phát hành | Gameplay/config manifest đúng version + content hash; immutable caching, ETag. Chỉ trả dữ liệu công khai. |
| `POST /me/identity-links/start` | Phiên guest/registered còn quyền link | Bắt đầu OIDC transaction có purpose `link`, ràng buộc với account hiện tại. |
| `POST /me/identity-links/complete` | `{authTransactionId, operationId}` + phiên nguồn; proof đã xác minh lưu phía server | Consume proof của đúng purpose/session, link cùng account hoặc trả conflict operation. Không nhận issuer/subject/email/verified do client tự khai. |
| `GET /me/identity-links/{linkId}` | Các bên đã được chứng minh trong operation | Tra kết quả link sau lost response, không tiết lộ identity/farm khác. |
| `POST /me/identity-links/{linkId}/resolve` | Challenge ngắn hạn + lựa chọn farm + operation ID | Chốt một farm active, bảo toàn farm còn lại theo policy; atomically cập nhật ownership/receipt/sessions. |

Không expose ở online v1: `PUT/PATCH /state`, upload `FarmPack` vào state, `tick`, `setSpeed`, `setCoins`, `buyGems`, reset farm, admin grant, tự cấp reward hoặc mua hàng bằng `paid:true`. Reset hiện tại chỉ là chức năng local; epoch được dành cho lifecycle/recovery có kiểm soát trong tương lai. Sound/music/camera/menu vẫn là trạng thái client. API health/readiness và các route vận hành không nằm trong API người chơi công khai.

Contract export/delete account thuộc backlog cần chốt OpenAPI ở P0 trước khi triển khai lifecycle P4 trong [07](07-roadmap-and-testing.md): chỉ owner, xác minh lại phiên gần thời điểm thao tác, deletion có operation ID chống xử lý lặp và quy tắc retention rõ. Tài liệu này chưa đặt URL hoặc tuyên bố đã có endpoint cho hai luồng đó.

### 2.1. Vòng đời enrollment guest

`enrollmentKey` là credential phục hồi tạm thời, không chỉ là ID chống trùng. Client tạo bằng CSPRNG, lưu trước request trong kho riêng ngắn hạn; không nhận key từ URL, save import, analytics hoặc người khác. Web phải kiểm Origin chính xác và JSON content type cho guest/start trước khi có phiên; các mutation đã có cookie còn phải kiểm CSRF. Không dùng device ID làm proof.

1. Server cấp account/farm/session và enrollment trong cùng transaction. Đề xuất cửa sổ retry **15 phút kể từ lần tạo**, không kéo dài theo retry. Server lưu hash key và bản credential đã cấp được mã hóa bằng khóa ngoài DB. Retry cùng key/fingerprint trong trạng thái `pending` chỉ phát lại credential đó khi session chưa revoke/expired và account vẫn là guest; response đảo thứ tự không ghi cookie đã bị một retry khác vô hiệu hóa.
2. Sau khi nhận cookie/token và xác nhận đúng account qua bootstrap, client gọi `/auth/guest/confirm`. Server khóa account → session → enrollment, đánh dấu `confirmed`, xóa ciphertext; cùng session confirm lại trả `204`. Gameplay/provision/link bị chặn với `ENROLLMENT_CONFIRMATION_REQUIRED` khi enrollment còn pending. Confirm không đổi credential; mất response có thể gọi confirm lại bằng phiên đã có. GET bootstrap không tự confirm.
3. Logout, logout-all, revoke, account delete/merge/link phải đóng mọi enrollment còn có thể cấp lại phiên liên quan trong cùng transaction. `confirmed/expired/revoked` không bao giờ trở lại pending. Key đóng nhận `409 ENROLLMENT_CLOSED`, không cấp phiên hoặc starter wallet; khác fingerprint nhận `409 ENROLLMENT_KEY_REUSED`. Hết cửa sổ chỉ đóng đường phát lại key, không tự xóa farm hoặc phiên đang hợp lệ; phiên đã nhận vẫn có thể confirm.
4. Sau confirm client xóa key; lỗi xóa không mở lại quyền vì server đã đóng. Giữ tombstone hash ngăn key cũ trở thành enrollment mới; không dọn chỉ vì hết 15 phút. Tối thiểu tách hash chống tái sử dụng khỏi liên kết PII khi áp dụng retention/delete. Nếu sau này muốn dọn tombstone, phải đổi protocol với bằng chứng key hết hiệu lực mà server vẫn kiểm được; random key hiện tại không cung cấp bằng chứng đó.

Mất cả credential lẫn key hoặc key đã đóng thì chỉ recovery qua identity đã liên kết; guest chưa link có thể mất quyền truy cập. Không tự tạo guest mới để che lỗi recovery. `POST /me/farms` dùng `operationId` riêng cho account đã xác thực và khóa account khi provision; không dùng enrollment key hay command ID gameplay.

## 3. Bootstrap, state và policy

Contract snapshot:

| Trường | Nội dung |
| --- | --- |
| `farmId`, `farmEpoch`, `revision`, `catalogVersion`, `stateSchemaVersion` | Metadata của cùng một phiên bản đã commit. |
| `stateAsOf` | Watermark đã lưu cùng state. |
| `state` | `FarmState` đã validate; UI nhận đúng IDs và snapshots job server lưu. Không chứa session, identity, ledger nội bộ hay audit actor. |

Mọi response đọc farm áp dụng transaction đọc nhất quán ở [03, mục 3.1](03-data-and-transactions.md#31-đường-đọc-cũng-phải-giữ-đúng-quyền-và-phiên-bản); không kiểm owner ở một query rồi lấy state/receipt ở query khác không được bảo vệ. Farm `archived/locked` vẫn đọc được nếu policy/quyền cho phép, nhưng command/sync mới nhận receipt rejected `FARM_READ_ONLY`; receipt đã có được tra trước gate trạng thái này.

Bootstrap trả `account:{id,kind}`, danh sách farm có quyền tối thiểu/selected farm, `currentFarm` (có thể `null` nếu account OIDC chưa provision farm), `policy`, `catalog:{version,url,hash}`, `serverTime`, `requestId`. Không coi GET bootstrap là “đã quyết toán đến hiện tại” và không để GET tự tạo farm. Với `currentFarm:null`, client gọi `POST /me/farms` với `operationId` rồi GET bootstrap lại; guest bình thường đã có farm từ `/auth/guest`. Client dùng durable snapshot để khởi tạo, rồi POST sync với revision đó trước khi bật kinh tế online theo quy trình ở [05](05-client-sync-and-migration.md).

`state` mặc định đầy đủ ở commands/sync/receipt lookup để giảm số lượt mạng. Client có thể dùng query `includeState=false` khi chỉ tra outcome; khi đó `currentFarm` giữ metadata, `stateIncluded:false` và `stateUrl`, không có `state`. Cờ biểu diễn response không thuộc fingerprint command. GET `/state` luôn trả đầy đủ. Ví dụ JSON ở mục sau dùng dạng metadata-only để không phải chép lại 40 plot; đây là một response hợp lệ ở chế độ đó, không phải schema FarmState rút gọn.

Policy tối thiểu gồm `mode:normal|read-only|maintenance`, `minimumClientBuild`, `supportedProtocolVersions`, `featureFlags` và thông tin hướng dẫn cập nhật. Catalog version dùng trong command phải trùng release đang pin trên farm. “Latest catalog” trong policy không tự đổi catalog của một farm. Khi release thay đổi luật/state format, server thực hiện migration đã kiểm chứng rồi trả revision/catalog mới.

Trong maintenance/read-only, ưu tiên giữ GET policy, logout và tra receipt để client xác định command trước đó đã commit chưa; command mới bị chặn. Nếu database không sẵn sàng, không tuyên bố một receipt “không tồn tại”: trả lỗi hạ tầng retryable. New command từ client quá cũ nhận `CLIENT_UPDATE_REQUIRED`; receipt cũ vẫn có thể được replay sau auth nếu envelope ổn định còn đọc được.

## 4. Envelope và xử lý command

Ví dụ request đổi gói kim cương lấy xu:

```http
POST /api/v1/farms/1207d71c-cb0a-41e2-952c-9a8db1b108ce/commands?includeState=false
Content-Type: application/json
X-Client-Build: 100
```

```json
{
  "protocolVersion": 1,
  "commandId": "88d50897-01ad-4c74-82c7-20d05e7c6794",
  "farmEpoch": "be781a37-c810-4984-a0fb-c81e1c0b7116",
  "expectedRevision": "41",
  "catalogVersion": "farm-town-2026-09-20.1",
  "action": { "type": "buyCoins", "pack": 0 }
}
```

Ví dụ response HTTP `200` sau commit; số lượng ví trong `result` minh họa release có gói `5 diamonds → 1000 coins` như [economy.json hiện tại](../../assets/farm/bundles/farm-town/economy.json):

```json
{
  "requestId": "req-7f953301",
  "serverTime": "2026-09-20T09:00:00.125Z",
  "replayed": false,
  "receipt": {
    "commandId": "88d50897-01ad-4c74-82c7-20d05e7c6794",
    "farmEpoch": "be781a37-c810-4984-a0fb-c81e1c0b7116",
    "operation": "command",
    "outcome": "committed",
    "code": "COIN_PACK_PURCHASED",
    "catalogVersion": "farm-town-2026-09-20.1",
    "revisionBefore": "41",
    "revisionAfter": "42",
    "evaluatedAt": "2026-09-20T09:00:00.100Z",
    "result": {
      "action": "buyCoins",
      "pack": 0,
      "effects": [
        { "resource": "currency:diamonds", "delta": -5 },
        { "resource": "currency:coins", "delta": 1000 }
      ]
    }
  },
  "currentFarm": {
    "farmId": "1207d71c-cb0a-41e2-952c-9a8db1b108ce",
    "farmEpoch": "be781a37-c810-4984-a0fb-c81e1c0b7116",
    "revision": "42",
    "catalogVersion": "farm-town-2026-09-20.1",
    "stateSchemaVersion": 7,
    "stateAsOf": "2026-09-20T09:00:00.100Z",
    "stateIncluded": false,
    "stateUrl": "/api/v1/farms/1207d71c-cb0a-41e2-952c-9a8db1b108ce/state"
  }
}
```

Server tự suy giá, balance, số lượng nhận và thời gian. `receipt.result.effects` là dữ liệu hiển thị kết quả đã commit; client không tự cộng chúng vào một snapshot rồi lại áp full snapshot. API receipt không expose ID ledger nội bộ nếu UI không cần.

### Thứ tự chống trùng

Auth/quyền sở hữu luôn đứng trước việc trả receipt. Sau đó tìm `(farmId, commandId)` trước kiểm epoch/revision/catalog/min-client của command mới. Duplicate giống fingerprint trả receipt terminal cũ với `replayed:true`; `currentFarm` và `serverTime` phản ánh snapshot hiện tại. Cùng ID khác nội dung trả `COMMAND_ID_REUSED`. Không thay receipt cũ bằng kết quả lần sau.

Tình huống COMMIT đã thành công nhưng response mất: client không tạo command ID mới, gọi GET receipt hoặc POST lại **nguyên envelope/action cũ**, kể cả expectedRevision đã stale. Nếu client tự sửa expectedRevision với ID cũ thì đã đổi fingerprint và phải bị từ chối. GET receipt `404 COMMAND_NOT_FOUND` chỉ nói chưa thấy receipt đã commit tại lúc đọc; request ban đầu có thể còn chạy. Giữ cùng ID để lần retry tham gia cùng giao dịch chống trùng.

Receipt lookup trả HTTP `200` khi tìm thấy receipt, kể cả outcome là rejected. POST replay trả HTTP status nghiệp vụ của receipt gốc (`200`, `409`, `422`...). Những metadata transport mới không thay nghĩa kết quả gốc. Receipt của sync có `operation:"sync"` và cùng quy tắc.

`receipt.farmEpoch/catalogVersion` luôn là giá trị request gốc; `revisionBefore/After` là revision đã quan sát/commit khi đánh giá. Với mismatch epoch/catalog, `receipt.result.observedFarmEpoch/observedCatalogVersion` lưu head đã quan sát lúc reject; chúng không được suy lại từ farm hiện tại khi replay. `currentFarm` mới là head đang trả. DB giữ `business_code` và `http_status` cho cả success/rejection, cùng hash version, metadata và result tối thiểu sau compact; không chỉ lưu `error_code` hoặc tính lại status bằng mapping mới.

### Sync

`POST /farms/{farmId}/sync` nhận đúng envelope trên **không có `action`**. Fingerprint có `operation:"sync"`; dùng lại ID của gameplay command cho sync là xung đột. So expectedRevision trước tick; tính thời gian ở server, lưu settlement và revision nếu state/time thay đổi, trả `code:"FARM_SYNCED"`. Hai sync cùng ID replay; hai sync khác ID cùng expectedRevision có thể một success và một `REVISION_CONFLICT`.

Không cho client gửi `seconds`, `savedAt`, `running`, `delta`, `speed`, `grantOfflineReward` hoặc full save trong sync. Chỉ khi cả durable state, `state.time` và watermark không đổi thì sync được committed/no-op với revision giữ nguyên; sync thường xuyên vẫn có thể tăng revision do thời gian tiến lên. Khi command nghiệp vụ bị reject, candidate settlement bị bỏ; sync tiếp theo lấy delta từ watermark đã commit, không mất thời gian đó.

## 5. Allow-list đầy đủ 25 action hiện tại

Nguồn đối chiếu: [ActionTypes.FarmAction](../../assets/farm/scripts/core/types/ActionTypes.ts) và [applyAction](../../assets/farm/scripts/core/FarmActions.ts). Bảng này mô tả trường nằm **bên trong `action`**; `type` luôn bắt buộc. Dấu `?` giữ nghĩa optional hiện tại. Domain IDs phải tồn tại trong farm/epoch/catalog tương ứng và đúng loại tài nguyên.

| `type` | Trường ngoài `type` | Kiểm tra/hiệu ứng phía server |
| --- | --- | --- |
| `moveBuilding` | `building:string`, `position:{x:number,y:number}` | Công trình phải thuộc farm và đã xây; snap, bounds, footprint, đường vào và collision chạy bằng geometry server. Không nhận scale/footprint client. |
| `plant` | `plot:int`, `crop:int` | Đúng ô trống đã mở, đúng loại cây/level; trừ giá gieo; server chụp duration/output/refund/XP và mốc thời gian. |
| `harvest` | `plot:int` | Cây đủ giờ ở server; nhận theo snapshot, kiểm capacity/overflow, cộng inventory/XP/mốc rồi xóa crop. |
| `cancel` | `plot:int` | Chỉ lứa đang lớn và cho hủy; hoàn theo refund snapshot, không theo giá client hoặc giá release mới. |
| `boost` | `plot:int` | Lứa chưa ready; server tính số gems theo thời gian còn lại và rule, trừ gems rồi đưa mốc ready về hiện tại. |
| `improve` | `plot:int` | Với `simple-1` hiện tại là mua ô đất tiếp theo đúng thứ tự/level bằng xu; không lấy luật cải tạo legacy bằng gems làm mặc định. |
| `rescue` | Không | Chỉ khi luật cứu trợ bật và không còn hàng/cây/job/tray/con đang làm để thu; chọn ô hỗ trợ ở server, không phải phát tiền tùy ý. |
| `dismissGuide` | Không | Chỉ cập nhật hướng dẫn; lần đã dismiss có thể là no-op. Không nhận cờ milestone khác. |
| `produce` | `recipe:int`, `machine?:int` | Máy đã mua, recipe đúng loại và mở khóa, hàng chờ còn chỗ; trừ nguyên liệu lúc enqueue; snapshot input/output/duration/XP trên job. |
| `collect` | `machine:int`, `batch?:int` | Nhận một mẻ thực sự trong tray đã ready; batch ID không phải index tùy ý; cộng theo snapshot, xóa mẻ đúng một lần. |
| `collectAll` | `machine:int` | Thu các mẻ trong tray của máy, atomically kiểm tổng inventory/stat limits. Không thu máy không thuộc farm. |
| `cancelQueued` | `machine:int`, `job:int` | Job còn nằm trong waiting; không hủy job đang chạy; hoàn đủ inputs đã chụp và xóa waiting job. |
| `expandQueue` | `machine:int` | Kiểm cấp/slot/max capacity; tính phí tại server, trừ xu và tăng một slot. |
| `boostMachine` | `machine:int`, `job?:int` | Bỏ `job` (hoặc là job đang chạy): job đang chạy chưa ready theo đồng hồ server, gems theo thời gian còn lại, vào tray, job chờ kế tiếp bắt đầu. `job` là job đang chờ: gems theo toàn bộ duration, job rời hàng chờ vào tray ngay, job đang chạy giữ nguyên; tray phải còn chỗ cho cả job đang chạy. Không cộng output/XP cho tới khi collect. |
| `buyMachine` | `machineType:int`, `building?:string` | Kiểm site còn lại/thứ tự, điều kiện mở, giá, giới hạn loại và chỗ đặt; cấp machine ID, trừ xu và thêm layout atomically. |
| `sellItem` | `item:string`, `quantity:int > 0` | Có item và đủ kho; tính giá bán/XP tích lũy bằng rule server, kiểm overflow, trừ kho và cộng xu; không nhận giá bán. |
| `setPenSpecies` | `plot:int`, `species:string|null` | Có trong union để hỗ trợ legacy nhưng `simple-1` khóa loài theo chuồng: online profile này trả `ACTION_NOT_AVAILABLE`, không âm thầm đổi loài. |
| `buyAnimal` | `plot:int`, `slot?:int` | Chuồng đã xây, đúng slot trống/capacity, có feed mill nếu rule yêu cầu; trừ xu và cấp animal ID ở server. |
| `buyPen` | `plot:int` | Chưa xây, đúng site/loài/level/gate/giới hạn; giá gồm chuồng và số con khởi đầu; mua nhà, con và vị trí trong cùng commit. |
| `expandPen` | `plot:int`, `slot?:int` | Đúng slot kế tiếp, đủ level/xu; phí hiện tại bao gồm mở chỗ và mua thêm con, không được chỉ tăng capacity. |
| `sellAnimal` | `plot:int`, `animal:int` | Con tồn tại và đang chờ ăn, không còn job; hoàn theo rule bán con, xóa con và cộng xu. |
| `feedAnimals` | `plot:int`, `animal?:int` | Một con chỉ định hoặc tất cả con đang chờ ăn; kiểm đủ tổng feed trước khi trừ; tạo job/output/XP/mốc giờ ở server. |
| `boostAnimal` | `plot:int`, `animal:int` | Con có job chưa ready; server tính gems, trừ và kết thúc timer; không nhận reward ngay nếu chưa collect. |
| `collectAnimals` | `plot:int`, `animal?:int` | Một con hoặc tất cả con đủ giờ; cộng snapshot output/XP, xóa job, cập nhật milestone trong cùng commit. |
| `buyCoins` | `pack:int` | Đổi diamonds đã có lấy gói coins của catalog pin. Đây không phải xác nhận thanh toán tiền thật. |

Khi người chơi nhắm một mục cụ thể, UI nên gửi `machine`, `batch`, `building`, `slot` tương ứng. Nếu optional bị bỏ, server dùng lựa chọn xác định của domain trên đúng expectedRevision và lưu target thực tế vào result. Không chọn lại một mục khác sau revision conflict. Việc bỏ `animal` chỉ dùng có chủ đích cho “cho cả đàn ăn/thu cả đàn”.

Các action cộng XP (`plant`, `harvest`, `collect`, `collectAll`, `sellItem`, `collectAnimals`, và XP xây dựng một lần của `improve`, `expandQueue`, `buyMachine`, `buyPen`, `expandPen` theo `experience.buildXP`) còn trả thưởng kim cương khi lên level mới theo `experience.levelUpDiamonds` và ghi `rewardedLevel`, trong cùng commit với XP; mỗi level chỉ trả một lần.

Action schema được sinh/kiểm đồng bộ với 25 nhánh hiện tại, nhưng không tự động cho phép action mới chỉ vì một developer thêm nó vào TypeScript union. API cần review quyền, idempotency, economy effect, code lỗi và test trước khi thêm vào allow-list production.

`buyGems` không có trong `FarmAction` hiện tại; các gói gems ở UI/catalog chỉ là hiển thị/mock. Nếu công cụ simulator hoặc bản dev bổ sung thao tác này, production vẫn từ chối. Tương lai IAP phải nhận transaction/receipt của nhà cung cấp, xác minh server-side, chống trùng transaction và xử lý refund/revocation; không đổi mock button thành endpoint tự cộng gems. Tính năng đó là phase riêng, mặc định `purchasesEnabled:false`.

## 6. Lỗi, admission và retry

Adapter cần bổ sung mã lỗi có kiểu rõ ràng cho domain; `ActionResult.error` hiện mới là thông báo chuỗi. Không parse tiếng Việt như `"Cần ... xu"` để suy mã lỗi.

| HTTP | `error.code` | Receipt | Client xử lý |
| --- | --- | --- | --- |
| 400 | `INVALID_JSON`, `INVALID_ENVELOPE`, `UNSUPPORTED_PROTOCOL_VERSION` | Không nếu chưa đủ envelope ổn định để nhận command | Sửa request/client; không lặp vô hạn. Schema action sai sau admission có thể ghi rejected `INVALID_ACTION`. |
| 400 | `INVALID_ACTION` | Rejected khi envelope/quyền hợp lệ | Sửa lỗi lập trình, ID cũ vẫn rejected. |
| 401 | `UNAUTHENTICATED`, `SESSION_EXPIRED` | Không | Refresh/login, sau đó giải quyết pending command bằng cùng ID. |
| 404 | `FARM_NOT_FOUND` | Không | Dùng cùng response cho không tồn tại/không có quyền, tránh dò tài nguyên account khác. |
| 404 | `COMMAND_NOT_FOUND` | Không có receipt nhìn thấy lúc đọc | Không suy ra request đang bay đã thất bại; retry cùng envelope/ID nếu cần. |
| 409 | `COMMAND_ID_REUSED` | Receipt gốc giữ nguyên | Lỗi client/abuse; không tự đổi ID rồi gửi lại payload đã đổi. |
| 409 | `FARM_EPOCH_MISMATCH` | Rejected | Bỏ ý định gắn epoch cũ sau khi ghi kết quả, bootstrap farm hiện tại. |
| 409 | `REVISION_CONFLICT` | Rejected | Cập nhật state/sync, để người chơi thử lại nếu ý định còn đúng. |
| 409 | `CATALOG_VERSION_MISMATCH` | Rejected | Tải catalog/state phù hợp, không tự thay version trong ID cũ. |
| 409 | `CLIENT_UPDATE_REQUIRED` | Không cho command mới | Cập nhật build; vẫn tra receipt cũ nếu service còn đọc được envelope. |
| 409 | `FARM_READ_ONLY` | Rejected cho command/sync mới | Farm archive/locked chỉ đọc; không đổi ID để vượt gate. Receipt cũ vẫn tra được theo quyền. |
| 409 | `ENROLLMENT_CONFIRMATION_REQUIRED` | Không cho mutation mới trước admission | Xác nhận enrollment bằng phiên đã nhận trước khi chơi/link. |
| 409 | `ENROLLMENT_CLOSED`, `ENROLLMENT_KEY_REUSED`, `OPERATION_ID_REUSED` | Kết quả auth/provision riêng, không phải command receipt | Không đổi key/operation để tự cấp farm khác; phục hồi phiên hoặc sửa lỗi client. |
| 409 | `IDENTITY_ALREADY_LINKED`, `FARM_LINK_CONFLICT` | Receipt lifecycle riêng | Hiển thị flow giải quyết link; không merge tài sản. |
| 422 | `INSUFFICIENT_FUNDS`, `INSUFFICIENT_ITEMS`, `NOT_READY`, `CAPACITY_REACHED`, `TARGET_LOCKED`, `INVALID_TARGET`, `INVALID_PLACEMENT`, `ACTION_NOT_AVAILABLE`, `STATE_LIMIT_REACHED` | Rejected | Hiển thị lý do/chi tiết an toàn; không tự lặp. `FARM_READ_ONLY` dành riêng cho farm archive/locked ở HTTP 409. |
| 429 | `RATE_LIMITED` | Không nếu chưa admission | Dùng `Retry-After`, backoff+jitter, giữ pending ID chưa biết kết quả. |
| 503 | `MAINTENANCE`, `SERVICE_UNAVAILABLE`, `COMMAND_BUSY` | Không mới ở nhánh hạ tầng | Backoff, tra receipt; không khẳng định “chưa trừ tiền” khi COMMIT chưa rõ. |
| 500 | `INTERNAL_ERROR` | Có thể chưa biết ở client | Giữ ID/body, tra status; requestId để hỗ trợ, không expose stack/SQL/state khác. |

Ví dụ revision conflict HTTP `409` ở chế độ `includeState=false`:

```json
{
  "requestId": "req-45ad48fd",
  "serverTime": "2026-09-20T09:00:01.000Z",
  "replayed": false,
  "error": {
    "code": "REVISION_CONFLICT",
    "message": "Nông trại đã thay đổi trên thiết bị khác.",
    "retryable": false,
    "details": { "expectedRevision": "41", "currentRevision": "42" }
  },
  "receipt": {
    "commandId": "65338d85-a5be-4aba-bf6c-02f370bf4f58",
    "farmEpoch": "be781a37-c810-4984-a0fb-c81e1c0b7116",
    "operation": "command",
    "outcome": "rejected",
    "code": "REVISION_CONFLICT",
    "catalogVersion": "farm-town-2026-09-20.1",
    "revisionBefore": "42",
    "revisionAfter": "42",
    "evaluatedAt": "2026-09-20T09:00:01.000Z",
    "result": { "expectedRevision": "41", "observedRevision": "42" }
  },
  "currentFarm": {
    "farmId": "1207d71c-cb0a-41e2-952c-9a8db1b108ce",
    "farmEpoch": "be781a37-c810-4984-a0fb-c81e1c0b7116",
    "revision": "42",
    "catalogVersion": "farm-town-2026-09-20.1",
    "stateSchemaVersion": 7,
    "stateAsOf": "2026-09-20T09:00:00.100Z",
    "stateIncluded": false,
    "stateUrl": "/api/v1/farms/1207d71c-cb0a-41e2-952c-9a8db1b108ce/state"
  }
}
```

`retryable:false` nghĩa không tự gửi lại ý định bằng ID mới; vẫn có thể tra/replay receipt cũ để giải quyết transport. Khi replay rejection ở revision mới hơn nữa, `receipt.result.observedRevision` giữ nguyên giá trị đã đánh giá; `currentFarm.revision` có thể khác. Client đọc trạng thái mới từ `currentFarm`, không lấy error details lịch sử làm head hiện tại.

## 7. Liên kết guest và xung đột farm

Flow login và flow link là hai mục đích riêng. Login vào identity đã tồn tại mở account của identity đó; không được tự chuyển farm guest đang mở vào account này. Muốn giữ tiến độ guest phải bắt đầu link có phiên guest và hoàn tất proof identity.

1. Guest gọi `/me/identity-links/start` với provider được hỗ trợ. Server ràng buộc auth transaction vào account/session hiện tại, nonce/state/PKCE, redirect allow-list và hạn sử dụng.
2. Sau proof thành công, server lấy `issuer` và `subject` đã xác minh để tìm identity. Identity mới: attach vào guest account, giữ farm ID/epoch/revision; ghi lifecycle receipt, rotate/revoke phiên theo policy.
3. Identity đã thuộc account khác: trả `FARM_LINK_CONFLICT`, `linkId`, thời hạn, mô tả tối thiểu hai farm và lựa chọn được phép. Không trả token của account kia hoặc full state trước khi flow đã chứng minh quyền ở cả hai bên.
4. `/resolve` nhận `operationId`, `resolution:keepGuestFarm|keepExistingFarm`, `guestFarmEpoch/revision`, `existingFarmEpoch/revision` và challenge. Server re-auth/recheck các quyền, khóa accounts theo ID, các session bị ảnh hưởng, rồi ownership/farms theo thứ tự thống nhất; thay đổi bên nào trong lúc chọn gây conflict mới thay vì lấy lựa chọn trên state cũ.
5. Một farm được chọn active; farm kia được bảo toàn/archive theo policy. Không cộng balances, inventory, XP hoặc migration timestamp. Cùng operation ID/payload replay kết quả; khác payload trả conflict. `/identity-links/{linkId}` giải quyết lost response mà không làm link lại. Vì link có thể rotate/revoke session cũ, client phải dùng credential mới nếu đã nhận được; nếu response cấp credential bị mất, re-authenticate bằng identity hiện tại rồi mới tra `linkId`. Không khôi phục session cũ chỉ vì biết `linkId`, và không cho người chưa chứng minh quyền đọc kết quả link.

Callback/exchange dùng `purpose` lưu trên auth transaction để phân luồng: `login` cấp phiên account identity; `link` chỉ lưu proof và trả về UI nguồn, chưa đổi cookie sang account khác. `/complete` consume proof đó dưới phiên nguồn còn hợp lệ. `linkId` và operation ID là locator, không phải proof; việc mất phản hồi token exchange khi chưa lưu được proof phải bắt đầu OIDC mới, không gửi lại authorization code đã dùng.

Quyết định sản phẩm còn cần chốt: có cho giữ guest farm thay farm hiện có không, thời gian giữ archive và điều kiện support restore. Default bảo thủ của MVP: không tự hủy farm nào và không merge tài sản; nếu chưa có UI conflict hoàn chỉnh, dừng link ở conflict và cho login vào account đã có, bảo toàn guest credential để quay lại.

## 8. Bảo vệ auth và API

Provider cụ thể phụ thuộc nền tảng phát hành; contract dùng provider allow-list để chưa khóa sản phẩm vào một nhà cung cấp. Server phải xác minh chữ ký ID token, `issuer`, `audience`/authorized party, thời hạn và nonce của đúng auth transaction; identity lưu theo `(issuer, subject)`, không theo email do client gửi. Không nhận tùy ý `jwksUrl`/issuer do request chỉ định rồi tải key từ đó. [OpenID Connect: ID Token Validation](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation).

Web ưu tiên cùng origin với backend/BFF, cookie `Secure`, `HttpOnly`, SameSite phù hợp flow OAuth và CSRF protection cho request thay đổi state. CORS chỉ cho origin đã cấu hình; origin không thay xác thực. Native dùng short-lived bearer credential và refresh token trong secure storage hệ điều hành; không cất secret provider trong client build. Refresh rotation/reuse detection, revoke và hạn phiên theo [06-security-and-operations.md](06-security-and-operations.md).

Gameplay không tin kết quả do client tính: server tra farm, ID target, giá, time, unlock, inventory, quantity cap, snapshots và footprint. Client vẫn có thể dùng core để preview/render, nhưng response đã commit mới là kết quả. Receipt status yêu cầu cùng ownership như gameplay; biết command UUID không trao quyền đọc.

Không log access/refresh token, OAuth code, PKCE verifier, cookie hoặc full save nhập từ người chơi. Error response chỉ trả mã, requestId và details thuộc farm đã được authorize. Audit tiền và audit bảo mật có quyền đọc khác với API người chơi.

## 9. Gate nghiệm thu contract

- OpenAPI/JSON Schema và TypeScript contract cùng một nguồn versioned; kiểm đủ 25 action và từ chối tất cả action/trường ngoài allow-list.
- Snapshot/revision/epoch/catalog/stateAsOf trong một response phải cùng phiên bản; command chỉ được báo committed sau transaction commit.
- Contract test bao stale/duplicate/changed-payload/lost-response, sync revision conflict, old-epoch replay và tombstone sau retention.
- Auth test bao cross-account farmId, commandId của farm khác, ID token sai issuer/audience/nonce, redirect lạ, refresh token reuse, link conflict bị thay farm trong lúc chọn.
- Schema không biến `"5"` thành `5`, không bỏ trường `coins`, không chấp nhận quantity overflow, batch ID của máy khác hoặc position chứa trường footprint.
- Client reconnect/foreground/sync không tự cấp hàng và không cộng elapsed hai lần; local pause/speed/reset/import không thay farm online.
- Maintenance/min-client chặn command mới có thông báo rõ nhưng không biến receipt đã commit thành thất bại chưa xử lý; lỗi hạ tầng vẫn giữ trạng thái “chưa biết kết quả” ở client.

Đây là danh sách kiểm cần xây khi triển khai backend; chưa có API thật hoặc kết quả load/security test để xác nhận các gate này.
