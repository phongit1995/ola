# Dữ liệu và giao dịch backend

> Trạng thái: kế hoạch thiết kế, chưa có schema, migration hoặc endpoint backend được triển khai. Quy ước API nằm trong [04-api-contract.md](04-api-contract.md). Các con số vận hành dưới đây là đề xuất ban đầu cần kiểm bằng tải thực.

Schema vật lý PostgreSQL, DDL mẫu, FK/index, roles, migration và test gate được cụ thể hóa ở [08 · Kế hoạch database](08-postgresql-database-plan.md). Tài liệu này giữ vai trò quy định invariant và kết quả giao dịch.

## 1. Điểm xuất phát trong game hiện tại

`FarmState` đang gom toàn bộ trạng thái gameplay trong một object: ví `coins`/`diamonds`, XP, inventory, thống kê tích lũy, plots, machines, các mốc hướng dẫn và vị trí công trình. Máy giữ công việc đang chạy, hàng chờ và khay thành phẩm; chuồng giữ con vật và công việc của từng con. Trạng thái này phù hợp với một aggregate nông trại có kích thước giới hạn: catalog hiện tại có 40 ô trồng, tối đa 16 máy và các vị trí chuồng theo catalog; sức chứa hàng chờ/con vật cũng có giới hạn. Đây là giới hạn nội dung hiện tại, cần đọc từ catalog được phát hành thay vì viết lại số cố định trong API. Nguồn: [StateTypes](../../assets/farm/scripts/core/types/StateTypes.ts), [ProductionTypes](../../assets/farm/scripts/core/types/ProductionTypes.ts), [LivestockTypes](../../assets/farm/scripts/core/types/LivestockTypes.ts), [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json).

`GameSession.dispatch` đã có trình tự đáng giữ: tạo candidate, áp dụng action, lưu thành công rồi mới công bố cho UI. Backend chuyển điểm lưu này thành transaction PostgreSQL. Không dùng `FarmSave` làm repository server: lớp đó phục vụ localStorage, backup, import JSON và đồng hồ cục bộ. `FarmGame` có thể dùng lại sau khi tách dependency và bổ sung các yêu cầu server; đặc biệt constructor hiện gọi `advanceMachines`, vì vậy đọc snapshot thuần không được ngầm khởi tạo domain rồi trả một trạng thái chưa commit. Nguồn: [GameSession](../../assets/farm/scripts/core/GameSession.ts), [FarmGame](../../assets/farm/scripts/core/FarmGame.ts), [FarmSave](../../assets/farm/scripts/core/FarmSave.ts).

## 2. Mô hình lưu trữ đề xuất

Dùng PostgreSQL với một hàng `farms` chứa `state jsonb` và revision. Tách danh tính, quyền sở hữu, phiên đăng nhập, catalog và lịch sử giao dịch thành bảng quan hệ. Cách này cho phép khóa đúng một nông trại khi thay đổi đồng thời ví, inventory, công trình và mốc mở khóa. Không tách ngay mỗi plot/job/animal thành bảng có quyền sửa độc lập: phần lớn action hiện chạm nhiều phần của cùng một nông trại.

Các bảng thống kê, tìm kiếm hoặc bảng xếp hạng sau này là projection chỉ đọc, có thể dựng lại. Cột số dư trích ra để báo cáo cũng là projection; không trở thành ví có quyền chi tiêu thứ hai.

### 2.1. Danh tính và quyền sở hữu

| Bảng đề xuất | Cột chính | Khóa và bất biến |
| --- | --- | --- |
| `accounts` | `id uuid`, `kind guest/registered`, `status`, `created_at`, `updated_at`, `merged_into_account_id nullable` | ID do server tạo, không tái sử dụng. Tài khoản đã chuyển danh tính không tiếp tục phát hành phiên độc lập. |
| `account_identities` | `id`, `account_id`, `provider`, `issuer`, `subject`, `linked_at`, thông tin xác minh tối thiểu | Unique `(issuer, subject)`. Email hoặc tên hiển thị không phải khóa đăng nhập. Provider chỉ từ allow-list. |
| `auth_sessions` | `id`, `account_id`, `client_kind web/native`, `access_token_hash`, `token_family_id nullable`, `generation`, `expires_at`, `absolute_expires_at`, `revoked_at`, `last_seen_at` | Web dùng opaque cookie, gia hạn idle trong absolute expiry; native có refresh family riêng. Token bí mật không lưu nguyên văn. Revoke/rotation và command dùng cùng thứ tự khóa. |
| `refresh_tokens` (native) | `token_hash`, `session_id`, `family_id`, `generation`, `parent_token_hash nullable`, `issued_at`, `expires_at`, `consumed_at`, `revoked_at` | Unique token hash và `(family_id, generation)`. Giữ hash token đã dùng tới khi cả family không còn hợp lệ để nhận diện reuse; chỉ lưu hash token hiện tại là không đủ. Rotation ghi token cũ đã dùng và token mới trong một transaction. |
| `auth_transactions` | `id`, `purpose login/link`, `provider`, `state_hash`, `nonce_hash`, `browser_binding_hash nullable`, PKCE challenge/verifier tùy loại client, `account_id/session_id/generation nullable`, `expires_at`, `status pending/exchanging/verified/failed/consumed` | Ràng buộc với browser hoặc PKCE của app bắt đầu flow; link còn ràng buộc phiên nguồn. Claim một lần trước token exchange ngoài transaction; lưu proof xác minh phía server. Verifier cần gửi token endpoint được mã hóa khi lưu, không chỉ hash. |
| `farm_ownership` | `farm_id`, `account_id`, `selected boolean`, `granted_at` | `farm_id` là PK: một owner mỗi farm trong MVP. Unique có điều kiện trên `account_id WHERE selected` để có tối đa một farm đang chọn. Không đồng thời đặt `owner_account_id` có quyền sửa riêng trong `farms`. |
| `account_link_operations` | `id`, `source_account_id`, `target_account_id`, `identity_id`, `resolution`, `request_hash`, `outcome`, `created_at`, `completed_at` | Durable receipt cho thao tác liên kết; không cộng hai ví khi chuyển quyền sở hữu. Khóa cả tài khoản liên quan theo thứ tự ID. |
| `farm_provision_operations` | `account_id`, `operation_id uuid`, `farm_id`, `request_hash`, `outcome`, `created_at` | PK `(account_id, operation_id)`; dùng cho `POST /me/farms`. Một account chỉ có farm active theo policy; retry cùng operation không tạo starter wallet hoặc farm thứ hai. |
| `guest_enrollments` | `enrollment_key_hash`, `account_id`, `session_id`, `operation_id`, `request_hash`, `issued_credential_ciphertext`, `encryption_key_id`, `created_at`, `expires_at`, `closed_at`, `status pending/confirmed/expired/revoked` | Unique key hash/tombstone. Trong cửa sổ pending cố định, retry cùng key/fingerprint trả lại đúng credential đã cấp và còn hợp lệ; không rotate mỗi retry. Ciphertext chỉ phục vụ lost response, mã hóa bằng khóa ngoài DB và xóa khi đóng enrollment. Key đã đóng không được cấp phiên lại. |

Một tài khoản có thể giữ thêm farm đã lưu trữ sau khi giải quyết xung đột guest, nhưng chỉ một farm được chọn để chơi trong MVP. Trạng thái `archived` là đọc được theo quyền sở hữu và không nhận gameplay command. Việc khôi phục một farm lưu trữ là thao tác lifecycle có kiểm tra riêng, không phải sửa trực tiếp trường `selected` từ client.

Tạo farm phải khóa account trước khi kiểm tra farm đã có và operation; hai `operationId` khác nhau cũng không được vượt policy một farm active. Guest key chưa có row dùng unique insert để phân xử: transaction thua phải rollback mọi account/farm vừa tạo trước khi đọc kết quả transaction thắng. Với enrollment đã tồn tại, đọc mapping rồi khóa account → session → enrollment và kiểm tra lại; confirm/logout/link dùng cùng thứ tự. Chi tiết vòng đời key nằm ở [04, mục 2.1](04-api-contract.md#21-vòng-đời-enrollment-guest).

### 2.2. Nông trại và catalog

| Bảng đề xuất | Cột chính | Quy tắc |
| --- | --- | --- |
| `catalog_releases` | `id text`, `content_hash`, `domain_version`, `state_schema_version`, `rules_version`, `manifest jsonb`, `status draft/active/retired`, `created_at` | Nội dung của release đã phát hành là bất biến. Manifest bao gồm catalog, economy, timing, gameplay và geometry liên quan đến luật đặt nhà. Giữ release cũ còn được farm hoặc job tham chiếu. |
| `farms` | `id uuid`, `farm_epoch uuid`, `revision bigint`, `catalog_version FK`, `state_schema_version integer`, `state jsonb`, `state_hash`, `last_settled_at timestamptz`, `status active/archived/locked`, `created_at`, `updated_at` | Revision không âm; mọi ghi gameplay đi qua transaction của aggregate. `farm_epoch` đổi khi DR có thể làm lùi lịch sử hoặc reset tương lai, không đổi mỗi lần đăng nhập. |
| `farm_epoch_archives` | `farm_id`, `farm_epoch`, `final_revision`, `catalog_version`, `final_state_hash`, snapshot hoặc archive reference, `reason`, `recovery_id nullable`, `closed_at` | Unique `(farm_id, farm_epoch)`. MVP cần dấu phục hồi DR; reset người chơi vẫn ngoài phạm vi. Với DR, final revision/hash là điểm đã phục hồi, không khẳng định tái tạo được các commit bị mất. |
| `service_policy` | `id`, `policy_version`, `mode normal/read-only/maintenance`, `minimum_client_build`, `supported_protocol_versions`, feature flags, `updated_at` | Chỉ control plane được sửa. Khớp policy API 04; không chứa bí mật trong bản trả cho client. |

Phân biệt các version:

| Trường | Ý nghĩa |
| --- | --- |
| `state.version` | Version format/domain save hiện tại của `FarmState`; không phải số lần ghi. |
| `state.rulesVersion` | Nhãn luật domain đang có trong game. |
| `catalogVersion` | ID release bất biến phía server, chọn toàn bộ bộ dữ liệu dùng để đánh giá action. |
| `revision` | Số phiên bản ghi của farm; truyền dạng chuỗi thập phân trên wire để không mất chính xác `bigint`. |
| `farmEpoch` | UUID nhận diện lịch sử farm đang được chấp nhận. DR có thể lùi lịch sử phải tạo epoch mới trước mở ghi; reset tương lai cũng tạo epoch mới. Lệnh cũ không được tác động một lịch sử khác. |
| `protocolVersion` | Version contract command; tách khỏi format save và version nội dung. |

Đây là invariant **server**: xu, kim cương, XP, doanh thu/thống kê đếm và số lượng inventory là số nguyên không âm, có trần không vượt `Number.MAX_SAFE_INTEGER` và có thể đặt trần vận hành thấp hơn. `state.time` là giây logic nên có thể là số hữu hạn không âm, không nhất thiết là số nguyên. [FarmValidation hiện tại](../../assets/farm/scripts/core/FarmValidation.ts) dùng predicate `nonnegative` cho cả `coins`, `xp`, `earned`, `harvested`, `sold`, vì vậy vẫn cho qua giá trị phân số hoặc lớn hơn safe integer; không được dùng validator save đó làm canonical validator cho backend. Backend phải bổ sung kiểm tra `Number.isSafeInteger` cho các trường đếm/ví, kiểm tra hậu điều kiện và overflow trước khi gọi commit. PostgreSQL lưu được số lớn hơn không có nghĩa JavaScript được phép tính trên chúng. Tổng delta và phép nhân giá × số lượng phải kiểm overflow trước khi commit. Timestamp quản trị dùng UTC. Client không được gửi timestamp để quyết định hoàn tất việc.

### 2.3. Command receipt, ledger và audit

| Bảng đề xuất | Nội dung | Ràng buộc |
| --- | --- | --- |
| `farm_operations` | `farm_id`, `operation_id uuid`, `kind command/sync/provision/catalog_migration/recovery/ownership_change`, `recorded_at` | PK `(farm_id, operation_id)` làm registry chung cho receipt, ledger và audit. Gameplay dùng commandId; lifecycle dùng UUID nội bộ. Ghi cùng transaction terminal, không giữ hàng pending ngoài transaction. |
| `command_receipts` | `farm_id`, `command_id uuid`, `actor_account_id`, `actor_session_id`, `request_farm_epoch`, `request_catalog_version`, `observed_farm_epoch`, `observed_catalog_version`, `protocol_version`, `request_hash`, `hash_version`, `operation`, `outcome committed/rejected`, `business_code`, `http_status`, `revision_before`, `revision_after`, `evaluated_at`, `committed_at`, `result_summary jsonb` | PK `(farm_id, command_id)`, độc lập với epoch. Giữ cả mã success/rejection và HTTP status gốc; không suy lại theo code mapping của release mới. Request và observed metadata khác nhau khi reject epoch/catalog. Receipt terminal không bị sửa. |
| `command_payloads` | `farm_id`, `command_id`, action/envelope đã lọc dữ liệu nhạy cảm, archive reference, `expires_at` | FK receipt. Payload lớn có thể chuyển kho lưu trữ hoặc xóa theo retention; việc đó không xóa khóa chống trùng. |
| `economy_ledger` | `id`, `farm_id`, `farm_epoch`, `command_id`, `revision`, `line_no`, `resource_key`, `delta`, `balance_after`, `reason`, `created_at` | Unique `(farm_id, command_id, line_no)`. Chỉ append. Resource gồm `currency:coins`, `currency:diamonds`, `xp`, `item:<key>`; cùng item/currency được cộng delta rõ ràng. |
| `farm_audit_events` | `id`, `farm_id`, `farm_epoch`, `command_id nullable`, `event_type`, actor, `revision_before/after`, `before_hash`, `after_hash`, catalog/domain version, `created_at` | Append-only; ghi cả thay đổi không phải tiền, sync, migration, reset và sự kiện quản trị. Không lưu access token/OAuth code. |
| `outbox_events` | `id`, `farm_id`, `revision`, `event_type`, `payload`, `created_at`, `published_at nullable`, `attempts` | Chỉ cần khi đã có consumer ngoài transaction. Ghi cùng state; publisher có thể gửi lặp, consumer chống trùng theo event ID. Chưa cần triển khai queue chỉ để lưu farm. |

Ví duy nhất có quyền chi tiêu là `farms.state`. Ledger giải thích thay đổi và dùng để đối soát, không được cập nhật số dư riêng rồi hy vọng đồng bộ sau. Với mỗi lần commit:

`balance_after(resource) = balance_before(resource) + tổng ledger.delta(resource)`.

FK của `economy_ledger(farm_id, command_id)` trỏ vào registry `farm_operations`; không chỉ vào command receipt vì opening ledger/migration không phải lệnh người chơi. Receipt tham chiếu registry cùng kind; audit có `operation_id` bắt buộc bên cạnh `command_id` nullable. Nếu lookup không có receipt nhưng registry đã dùng ID cho lifecycle khác, trả `COMMAND_ID_REUSED`; registry command/sync thiếu receipt là lỗi toàn vẹn, không thực thi lại. Chi tiết DDL và reconciliation ở [08](08-postgresql-database-plan.md).

Áp dụng bất biến này cho mọi resource thực sự đổi. Hàng ledger đối soát được với before/after state của cùng revision; không chỉ suy delta từ `ActionResult.coins` vì result hiện tại không bao phủ inventory, XP, refund và tất cả nhánh giao dịch. Reset có bản ghi đóng số dư epoch cũ và bản ghi mở số dư epoch mới; không biến tổng coins bị reset thành doanh thu bán hàng. Admin grant sau này cũng phải là command có receipt/ledger/audit, không dùng SQL sửa JSONB trực tiếp.

Khi tạo farm lần đầu, server tạo một lifecycle operation ID nội bộ và dùng làm `command_id` cho opening ledger/audit; giữ nguyên ID đó khi retry transaction khởi tạo. `POST /auth/guest` dùng `enrollmentKey` bí mật entropy cao để retry enrollment mất response trong cửa sổ pending; server phát lại credential đã cấp, sau đó client confirm enrollment. `POST /me/farms` dùng `operationId` đã lưu trước request cho account đã xác thực. Cùng transaction phải tạo account (nếu guest), ownership, farm từ catalog đã pin và ledger mở đầu. Baseline kế toán trước khi farm tồn tại là **0 cho mọi resource**: catalog hiện tại mở `+500 currency:coins`, `+10 currency:diamonds`, cùng từng lượng inventory khởi đầu nếu catalog có cấp; `balance_after` bằng số dư state vừa tạo. Không cần dòng delta 0 cho XP hoặc item không được cấp. Unique operation/key và quyền tạo farm một lần bảo vệ khỏi cấp lặp; bootstrap/login chỉ đọc farm đã có, không chạy lại starter wallet. Đây là khởi tạo MVP, độc lập với reset/admin lifecycle tương lai. Nguồn giá trị ban đầu: [economy.json](../../assets/farm/bundles/farm-town/economy.json).

Index khởi đầu: PK và unique constraint ở trên; `farm_ownership(account_id)`; `auth_sessions(account_id, revoked_at)`; `economy_ledger(farm_id, farm_epoch, revision)`; `farm_audit_events(farm_id, created_at)`; index hạn phiên/phần payload để dọn. Chưa tạo GIN index toàn bộ `state` khi chưa có query cần nó. Hàng JSONB phải bị giới hạn kích thước và được validate đầy đủ; giới hạn import local 2 MB hiện tại không phải kích thước mục tiêu cho mỗi request command.

## 3. Biên giao dịch của một command

MVP dùng `READ COMMITTED` và khóa hàng farm bằng `SELECT ... FOR UPDATE`. PostgreSQL sẽ chờ transaction đang giữ khóa và đọc phiên bản hàng vừa commit trước khi xử lý tiếp; điều này phù hợp với invariant nằm trong một aggregate. Quy tắc này chỉ đúng khi **mọi** đường ghi farm, timer, reset, migration và admin đều đi qua cùng khóa. Giao dịch liên quan nhiều farm/account phải khóa theo thứ tự thống nhất hoặc dùng thiết kế riêng; không suy ra rằng `READ COMMITTED` tự bảo vệ tất cả invariant nhiều hàng. [PostgreSQL: isolation](https://www.postgresql.org/docs/current/transaction-iso.html), [row locks](https://www.postgresql.org/docs/current/explicit-locking.html).

Trình tự dưới đây là đặc tả để triển khai và kiểm thử:

1. Giới hạn byte, parse JSON và validate envelope ổn định; không ép string thành number, không bỏ trường lạ. Xác thực phiên, client/protocol cơ bản, giới hạn tốc độ. `farmId` lấy từ route nhưng phải chứng minh quyền sở hữu; `accountId` lấy từ phiên.
2. Bắt đầu transaction. Từ principal đã parse, khóa account theo ID, rồi khóa `auth_sessions` tương ứng bằng `FOR UPDATE` theo thứ tự session ID ổn định; đọc lại `revoked_at`, `expires_at`, generation và status account. Logout, refresh rotation, revoke-all và link cũng phải dùng cùng thứ tự account → session, nên request được tuyến tính hóa: lệnh đã giữ session lock có thể hoàn tất trước một logout đến sau; lệnh thấy session đã revoke/expired bị dừng trước receipt lookup. Sau đó khóa ownership và farm theo ID (nhiều account thì sort account, session, ownership và farm ID), rồi đọc lại ownership/status. Không chỉ kiểm auth ngoài transaction hoặc chờ giữ farm rồi mới kiểm session; lookup xác thực ban đầu một mình không ngăn race với guest-link, chuyển quyền hoặc revoke. Request không có quyền không được biết receipt có tồn tại hay không.
3. Đọc `command_receipts(farm_id, command_id)` **trước** khi so epoch, revision hoặc catalog hiện tại. Tính fingerprint của request bằng `hash_version` lưu trên receipt tìm được, không mặc định thuật toán mới nhất. Cùng fingerprint: trả lại kết quả terminal đã có, không tick, không gọi domain. Khác fingerprint: `COMMAND_ID_REUSED`, không sửa receipt cũ.
4. Với command mới, kiểm tra maintenance/min-client, trạng thái farm, epoch, expectedRevision, catalog, action schema/allow-list và điều kiện phiên cần xác minh lại. Lỗi có envelope/identity hợp lệ được ghi receipt rejected theo bảng ở mục 5; lỗi hạ tầng không thành rejection nghiệp vụ.
5. Chụp một `serverNow` từ DB bằng `clock_timestamp()` **đúng một lần sau khi đã có khóa**, rồi dùng mốc đó xuyên suốt evaluation. Không dùng `now()`/`CURRENT_TIMESTAMP` ở đây vì chúng là thời điểm bắt đầu transaction, có thể đã cũ sau khi chờ khóa. Lấy state đã commit, dựng candidate bằng catalog đang pin, tính phần thời gian chưa quyết toán từ `last_settled_at`, gọi domain settlement rồi action. Không gọi IDP, thanh toán, HTTP khác hoặc chờ queue khi đang giữ khóa farm. [PostgreSQL: current date/time](https://www.postgresql.org/docs/current/functions-datetime.html#FUNCTIONS-DATETIME-CURRENT).
6. Nếu action bị từ chối, bỏ toàn bộ candidate kể cả phần settlement vừa tính; chỉ ghi receipt rejected và audit cần thiết. State, revision, `last_settled_at`, ví và ledger không đổi. Điều này giữ nguyên nghĩa “thao tác thất bại không công bố candidate” của client hiện tại.
7. Nếu thành công, validate full state và layout; tính delta ledger và hash. Ghi state mới, `last_settled_at`, revision tăng một lần, receipt committed, ledger, audit và outbox nếu cần trong **cùng transaction**. Chỉ trả committed/no-op với revision giữ nguyên khi toàn bộ durable state, kể cả `state.time`, và watermark đều không đổi; receipt vẫn tồn tại. Dismiss đã hoàn tất thường vẫn làm thời gian tiến lên khi settle nên vẫn tăng revision.
8. Chỉ trả success sau COMMIT. Nếu kết nối mất ngay sau COMMIT, server/client coi kết quả chưa biết; tìm receipt bằng cùng ID, không chạy một lệnh thay thế với ID mới.

Khóa farm làm hai request đồng thời cùng command ID lần lượt nhìn thấy cùng receipt. Unique constraint vẫn là lớp bảo vệ cuối. Không dùng Redis lock hay cache receipt làm căn cứ duy nhất chống chi tiêu hai lần.

Lỗi deadlock/serialization được retry **toàn bộ transaction**, số lần nhỏ có jitter; lần retry dùng lại command ID/body và tra receipt trước. Lock timeout hoặc hết ngân sách retry trả lỗi retryable. Chỉ retry sau khi biết transaction trước rollback, hoặc dùng receipt để giải quyết tình huống COMMIT chưa rõ. PostgreSQL yêu cầu chuẩn bị retry toàn bộ giao dịch khi dùng các mức isolation có serialization failure. [PostgreSQL: retry và isolation](https://www.postgresql.org/docs/current/transaction-iso.html).

### 3.1. Đường đọc cũng phải giữ đúng quyền và phiên bản

Bootstrap/state/receipt lookup dùng primary DB và transaction ngắn: khóa account → session → ownership → farm bằng `FOR SHARE`, theo cùng thứ tự ID với đường ghi; đọc lại credential generation, expiry, account status và ownership sau khi có khóa. Chỉ đọc receipt/head/state sau bước này; lấy toàn bộ metadata và JSONB từ cùng hàng farm. Bootstrap giữ account lock trong lúc lấy danh sách/selected farm để link/provision không đổi tập farm giữa các query. Reader không nâng khóa sang writer, không tick và không cập nhật `last_seen_at` trong transaction này; gia hạn phiên là POST riêng.

Kết quả là snapshot đã được authorize tại điểm đọc: revoke/chuyển chủ hoàn tất trước khi reader lấy khóa phải chặn reader; reader đã giữ khóa có thể hoàn tất trước revoke đến sau. Không hứa thu hồi bytes đã gửi. Đây là protocol ứng dụng được đề xuất; `READ COMMITTED` tự nó cho mỗi statement một snapshot nên nhiều SELECT rời không bảo đảm cùng quyền/head. [PostgreSQL isolation](https://www.postgresql.org/docs/18/transaction-iso.html), [shared row locks](https://www.postgresql.org/docs/18/explicit-locking.html).

## 4. Đồng hồ và quyết toán timer

`FarmGame.tick(seconds)` tăng `state.time` rồi đưa job máy qua trạng thái phù hợp với hàng chờ và sức chứa khay. Thu hoạch cây/con vật vẫn là hành động riêng; việc đến giờ không tự cộng sản phẩm vào kho. Job đang chạy đã chứa snapshot duration/inputs/outputs/XP; crop giữ paid/refund snapshot. Backend phải giữ các snapshot đó qua catalog release mới. Nguồn: [FarmGame.tick](../../assets/farm/scripts/core/FarmGame.ts), [PlotTypes](../../assets/farm/scripts/core/types/PlotTypes.ts), [ProductionTypes](../../assets/farm/scripts/core/types/ProductionTypes.ts).

Đề xuất giai đoạn đầu:

- `GET bootstrap/state` chỉ đọc snapshot bền vững, có `stateAsOf` và `serverTime`. Không tick rồi trả kết quả chưa lưu.
- `POST .../sync` là thao tác có receipt, khóa farm và lưu settlement. Dùng khi mở game, trở lại foreground hoặc cần xác nhận trạng thái sau thời gian dài. Sync không thưởng thêm ngoài luật domain và không tự harvest/collect.
- Gameplay command kiểm `expectedRevision` trước khi settle candidate; settle và action thành công được ghi trong một revision. Từ chối action thì không lưu settlement, như mục 3. Client muốn cập nhật đồng hồ khi action thất bại gửi sync mới sau khi đã xử lý receipt.
- `settledAtNext = max(lastSettledAt, serverNow)` và `deltaSeconds = (settledAtNext - lastSettledAt) / 1000`; khi commit lưu chính `settledAtNext`. Không ghi đè watermark bằng thời gian server nhỏ hơn rồi tính lại cùng quãng thời gian ở request sau. Clock watermark không lùi; server lệch giờ không được dùng thời gian client để sửa. Khi phát hiện lệch đồng hồ vượt ngưỡng vận hành, chặn/điều tra thay vì trả thưởng từ một mốc giờ sai.
- Runtime hiện bật offline progress và không có trần thời gian offline. Giữ hành vi này trong đề xuất parity ban đầu, nhưng chạy settlement với giới hạn công việc theo queue hữu hạn; không lặp từng giây. Thay trần offline hoặc để pause dừng sản xuất là thay đổi gameplay cần chốt riêng. Nguồn: [runtime.json](../../assets/farm/bundles/farm-town/runtime.json).
- Menu/pause, đóng tab, thay FPS, đổi múi giờ và mất mạng không dừng đồng hồ server. Các nút speed/debug/import không điều khiển thời gian authoritative.

Không cần một cron ghi từng farm mỗi giây. Nếu sau này cần notification, worker dùng cùng settlement service, khóa và revision. Worker chỉ làm materialize trạng thái đến thời điểm server, không chạy phiên bản luật hoặc thuật toán khác. Client vẫn phải xử lý revision conflict do worker hoặc thiết bị khác.

## 5. Replay, rejection và retention

Fingerprint tính từ canonical JSON gồm `protocolVersion`, route `farmId`, `farmEpoch`, `expectedRevision`, `catalogVersion`, loại operation và action nguyên nghĩa. Sort khóa object; giữ thứ tự array; từ chối duplicate JSON keys, số không hợp lệ và trường vượt schema. Không đưa token, requestId của tracing hay clientVersion vào fingerprint. Ghi `hash_version` để canonicalization mới không làm hỏng retry cũ.

Triển khai giữ bộ canonicalizer cho mọi `hash_version` còn có receipt/tombstone. Với receipt cũ, hash lại request bằng version cũ trước khi so sánh; không hash toàn bộ request bằng version hiện hành rồi mới lookup. UUID được chuẩn hóa một kiểu chữ theo envelope, optional bỏ trống khác `null`, array giữ thứ tự. Admission validation không được thêm default hoặc biến đổi action trước hash. Test tương thích phải bao gồm đổi hash version và replay một action không còn trong allow-list mới.

| Tình huống | Receipt bền vững | Thay đổi farm | Hành vi retry |
| --- | --- | --- | --- |
| JSON lỗi, envelope thiếu ID, request quá lớn, chưa xác thực/không có quyền | Không | Không | Sửa transport/auth trước; không thể tuyên bố ID đã được xử lý. |
| Command hợp lệ nhưng stale revision/epoch/catalog, action không hỗ trợ, thiếu tiền/nguyên liệu/level | Rejected | Không | Cùng ID trả cùng rejection. Muốn thực hiện ý định mới trên trạng thái mới phải tạo ID mới sau refresh và xác nhận ý định còn đúng. |
| Maintenance/min-client/rate limit/DB unavailable trước admission | Không | Không | Theo `Retry-After` hoặc cập nhật client, giữ ID/body nếu ý định vẫn còn và chưa có kết quả terminal. |
| Domain success, save/ledger/receipt commit thành công | Committed | Một commit | Cùng ID không có lần chi tiêu/thu hoạch thứ hai. |
| DB rollback đã xác nhận | Không | Không | Retry cùng ID/body. |
| COMMIT chưa biết vì network/process chết | Chưa biết ở client | Có thể đã commit | GET receipt trên primary hoặc POST lại cùng ID/body; 404 receipt không chứng minh request cũ không còn đang chạy. |
| Duplicate đã thành công nhưng farm giờ có revision/epoch/catalog mới | Receipt cũ giữ nguyên | Không | Replay receipt cũ trước current checks; trả thêm current head để client không ghi đè cache bằng state cũ. |

Receipt lưu lâu dài phần tối thiểu: `(farmId, commandId)`, hash/version, operation, epoch gốc, outcome, code, revision trước/sau và result summary. Payload chi tiết có thể dọn sau cửa sổ vận hành, đề xuất 90 ngày trước khi đánh giá dung lượng. **Không đặt TTL khiến ID đã chi tiêu biến thành “chưa từng thấy”.** Nếu cần compact thành tombstone, tombstone giữ đủ fingerprint và kết quả terminal, vẫn nằm trong đường lookup trước revision. Không bao giờ cho thực thi lại vì response body đã được archive.

Receipt replay bảo đảm cùng **kết quả nghiệp vụ**. Response HTTP có thể bổ sung `replayed:true`, `serverTime` mới và current farm head; không hứa byte-identical toàn bộ response. Snapshot trả theo API là snapshot hiện tại đã commit, không phải snapshot lịch sử bị nhầm là mới. Receipt của epoch cũ luôn hiển thị rõ epoch gốc.

## 6. Hai thiết bị, liên kết guest và lifecycle tương lai

Hai thiết bị cùng revision `41`: A thu hoạch commit revision `42`; B bán với expected `41` nhận `REVISION_CONFLICT`, receipt rejected, không tự bán theo số lượng mới. B tải/sync state rồi cho người chơi thử lại bằng command ID mới nếu còn đúng ý định. Không tự rebase lệnh mua/xóa/reset, không auto-replay hàng loạt input offline vào kinh tế online.

**Reset không có API online trong MVP; nút reset hiện tại chỉ thuộc local.** Phần sau là thiết kế dự phòng cho lifecycle/admin recovery tương lai và chưa phải scope triển khai v1. Nếu bổ sung reset có kiểm soát, thao tác giữ `farmId`, tạo `farmEpoch` UUID mới, lưu epoch cũ và tạo state từ catalog server. Đề xuất revision tăng tiếp thay vì quay về 0; epoch vẫn bắt buộc để phân biệt object ID tái dùng. Lifecycle tương lai này cần command ID, expectedRevision, catalogVersion, quyền/challenge xác nhận phù hợp và receipt riêng trong cùng namespace chống trùng. Old command chưa từng commit bị `FARM_EPOCH_MISMATCH`; old command đã commit chỉ replay receipt cũ, không tác động lượt mới. Không xóa receipt khi reset.

Liên kết guest với identity chưa thuộc tài khoản khác: giữ nguyên farm/epoch/revision và ownership, đổi account kind, tạo identity, xoay phiên. Identity đã thuộc tài khoản có farm khác: tạo conflict operation; yêu cầu chọn farm giữ làm active, bảo toàn farm còn lại dưới dạng archive hoặc giữ riêng theo quyết định sản phẩm. Không cộng coins/diamonds/inventory/XP, không chọn theo timestamp lớn nhất. Mọi chuyển ownership và kết quả chọn farm được ghi atomically, có receipt lifecycle; session cũ bị revoke theo chính sách đã chốt. Xem chi tiết contract [04](04-api-contract.md#7-liên-kết-guest-và-xung-đột-farm).

## 7. Migration và kiểm chứng trước triển khai

State đang lưu phải qua migration xác định từ schema/catalog cũ sang mới, có before/after hash, backup và audit. Release mới không được silently thay giá/refund/output của công việc đã trả tiền. Chỉ chuyển `catalog_version` của farm khi migration đã commit cùng state/revision; giữ package domain/catalog cũ để điều tra. JSON local hiện có là dữ liệu không đáng tin, không được import vào ví server chỉ vì `FarmValidation` chấp nhận hình dạng.

Checklist nghiệm thu cho lớp dữ liệu:

1. Chạy song song hàng chục bản sao cùng command: đúng một debit, một receipt terminal, ledger khớp state.
2. Cùng ID khác payload; stale revision; replay sau đổi catalog; replay qua epoch lifecycle giả lập; replay sau compact payload đều không tạo hiệu ứng mới. Kiểm reset/admin lifecycle thật chỉ trở thành gate phát hành khi tính năng tương lai đó được triển khai.
3. Cắt kết nối trước COMMIT, ngay sau COMMIT và trước response; client giải quyết được bằng receipt.
4. Domain rejection sau khi timer đã đủ giờ không làm thay đổi watermark/state; sync tiếp theo quyết toán đúng một lần.
5. Hai thiết bị, sync/command, ownership transfer/command tranh chấp khóa đúng quy tắc; thêm reset/admin lifecycle contention khi đưa tính năng tương lai đó vào scope; không rò state sang tài khoản không có quyền.
6. Tổng delta ledger bằng chênh lệch state cho mọi action, gồm refund, nâng chuồng kèm con, cứu trợ và đổi kim cương lấy xu.
7. Full-state validation bắt overflow, số âm, ID trùng, job snapshot hỏng, vị trí ngoài bản đồ và catalog không hợp lệ trước commit.
8. Restore backup phải khôi phục cùng điểm thời gian cho state, receipt, ledger, ownership và catalog. Restore riêng state về cũ nhưng để receipt mới là mất nhất quán; restore riêng receipt về cũ có thể chi tiêu lặp.

Các mục này là tiêu chí cho phase backend, không phải báo cáo test đã chạy trên một server hiện có.
