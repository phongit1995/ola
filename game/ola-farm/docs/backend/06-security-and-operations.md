# 06 — Bảo mật và vận hành

Trạng thái: **kế hoạch đề xuất, chưa triển khai và chưa đo tải/SLO**. Nguồn chính thức được kiểm tra ngày 20-09-2026. Các con số dưới đây là điểm bắt đầu để thiết kế và diễn tập, cần người phụ trách sản phẩm/vận hành phê duyệt trước phát hành.

Thiết kế nền: TypeScript, Node.js 24 LTS, Fastify 5 và PostgreSQL 18 managed; PostgreSQL 17 là phương án dự phòng nếu nhà cung cấp chưa hỗ trợ 18 phù hợp. API dùng `/api/v1`; backend quyết định tiền, vật phẩm, công trình và thời gian. Chi tiết giao dịch và hợp đồng nằm trong [03](03-data-and-transactions.md), [04](04-api-contract.md); chuyển client/local save nằm trong [05](05-client-sync-and-migration.md).

## 1. Ranh giới tin cậy và những gì đang có

Hiện tại [GameSession](../../assets/farm/scripts/core/GameSession.ts) tạo bản ứng viên, áp dụng action, lưu rồi mới công bố trạng thái. Đồng hồ lấy từ thiết bị; import/reset/pause tồn tại trong phiên local. [FarmAction](../../assets/farm/scripts/core/types/ActionTypes.ts) là danh sách ý định UI, chưa phải hợp đồng API đã xác thực. JSON vượt qua [FarmSave](../../assets/farm/scripts/core/FarmSave.ts) chỉ chứng minh cấu trúc hợp lệ, không chứng minh tiền hoặc tiến trình do server cấp.

V1 cần bảo vệ bốn tài sản: quyền sở hữu farm, tính toàn vẹn kinh tế, thông tin đăng nhập và khả năng khôi phục dữ liệu đã chấp nhận. Giả định kẻ tấn công có thể sửa toàn bộ JavaScript, đồng hồ, localStorage, request, thứ tự request và gửi đồng thời từ nhiều thiết bị.

| Bề mặt | Quy tắc thiết kế | Bằng chứng phải có trước beta |
| --- | --- | --- |
| Client gửi coin/XP/state hoặc thời gian hoàn thành | Chỉ nhận command allowlist; chi phí, điều kiện mở khóa và settlement do server tính | Request tự tăng coin, thay giá/catalog, gửi save tùy ý đều không thay đổi farm |
| Đoán ID farm/job hoặc đọc receipt người khác | Xác thực chủ thể và quyền trên đối tượng trước đọc, ghi và replay | Ma trận kiểm thử hai tài khoản và hai farm |
| Gửi lại action vì mạng lỗi | Một receipt bền vững cùng giao dịch với kết quả; khóa idempotency `(farmId, commandId)` độc lập chủ sở hữu/epoch | Mất response sau commit vẫn chỉ trừ/cộng một lần |
| Đổi giờ, offline lâu, mở menu | Thời gian server; chỉ hoàn tất công việc đã trả phí; giới hạn công việc settlement | Không phát sinh thưởng hoặc xây công trình chỉ vì lên cấp/reconnect |
| Chiếm cookie/token, liên kết nhầm tài khoản | Phiên có thể thu hồi, reauth khi thao tác nhạy cảm, liên kết có kiểm chứng | Thử replay phiên đã thu hồi và xung đột liên kết |
| Nhân viên hoặc automation cấp thưởng sai | Quyền tối thiểu, ledger và audit cho mọi điều chỉnh | Cấp bù lặp không nhân đôi, xác định được ai/why/when |

Không tiếp nhận các thao tác local reset/import tùy ý/pause/speed làm API kinh tế v1. Đóng tab, mở menu hay di chuyển công trình không được đóng băng thời gian chung của server. Đây là thay đổi hành vi cần giải thích trong UI và kiểm thử chuyển đổi.

## 2. Khách, tài khoản và phiên đăng nhập

### Lựa chọn đề xuất

Cho phép chơi khách có danh tính server, rồi liên kết với nhà cung cấp OIDC được chọn. Không tự xây mật khẩu/quên mật khẩu trong MVP. OIDC cung cấp lớp xác thực; nhận diện liên kết bằng cặp `issuer + subject`, không ghép tài khoản chỉ vì email giống nhau. Kiểm tra chữ ký, issuer, audience, thời hạn và nonce theo profile đã chốt. [OpenID Connect Core](https://openid.net/specs/openid-connect-core-1_0.html)

| Phương án | Khi phù hợp | Việc đội dự án phải sở hữu |
| --- | --- | --- |
| Khách + OIDC managed, đề xuất | Vào chơi nhanh, có khôi phục và dùng nhiều thiết bị | Liên kết farm, phiên game, xung đột danh tính, chi phí MAU và phụ thuộc IdP |
| Chỉ khách | Prototype hoặc beta giới hạn không cần khôi phục | Thông báo mất credential có thể mất quyền truy cập; thiếu đường khôi phục và chống tạo hàng loạt |
| Tự quản mật khẩu hoặc tự vận hành IdP | Có yêu cầu sản phẩm/hạ tầng cụ thể và người vận hành | Băm mật khẩu, MFA, xác minh email, chống dò, recovery, vá lỗi và trực sự cố; ước lượng lại phạm vi |

Luồng đăng nhập dùng Authorization Code + PKCE `S256`, `state`, redirect URI allowlist chính xác; bỏ implicit flow và password grant. Mỗi auth transaction phải bind với browser session tạm thời hoặc PKCE verifier của đúng app; kiểm tra `iss`/provider để chống mix-up, không chỉ nonce chung. Không lấy URL discovery/JWKS tùy ý từ client. Cache khóa IdP có thời hạn và diễn tập rotation; kiểm tra token qua thư viện được duy trì, không tự viết bộ xác minh. [OAuth 2.0 Security BCP — RFC 9700](https://www.rfc-editor.org/rfc/rfc9700.html)

### Browser cùng origin

Backend xử lý callback OIDC và phát cookie phiên opaque; token IdP giữ phía server. Cookie đề xuất `__Host-farm_session`, ngẫu nhiên tối thiểu 32 byte, `Secure; HttpOnly; SameSite=Lax; Path=/`, không `Domain`; DB lưu hash credential. Rotate khi đăng nhập/liên kết/nâng quyền; logout thu hồi ở server. Có idle expiry và absolute expiry cấu hình riêng cho khách/tài khoản, chốt theo UX trước beta. Refresh web không đổi giá trị cookie nên retry sau mất response là an toàn trong cùng expiry; native refresh phải rotate một lần và lưu token cũ đã consume để phát hiện reuse, vì retry token cũ sau mất response có thể bị coi là reuse và buộc reauth. Các thuộc tính cookie và vòng đời này theo hướng dẫn [OWASP Session Management](https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html).

API `/api` được reverse proxy về cùng origin với game để giảm cấu hình cross-origin. Command, sync và các mutation quản lý tài khoản dùng CSRF token cùng kiểm tra Origin; GET gameplay/bootstrap/state không mutate. OAuth callback có thể dùng GET để hoàn tất phiên sau kiểm tra state/nonce/PKCE, không áp dụng luật “GET chỉ đọc” của farm một cách máy móc cho callback xác thực. `SameSite` chỉ là một lớp bảo vệ; HttpOnly cũng không ngăn XSS gửi action bằng phiên đang mở. CORS, nếu thực sự cần, chỉ cho origin đã đăng ký và không dùng wildcard với credentials. [OWASP CSRF Prevention](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html)

Client không ghi bearer token vào localStorage, URL, log hay analytics. Thiết lập CSP tương thích bản build Cocos qua chế độ report-only trên staging rồi thu hẹp, tránh thêm script bên thứ ba không có nhu cầu. Không đoán CSP nghiêm ngặt nào hoạt động trước khi kiểm tra loader/WebAssembly của bản build thực tế.

### Native nếu được đưa vào phạm vi

Native mở trình duyệt hệ thống cho OAuth + PKCE, dùng redirect/deep link đã xác minh và allowlist; không nhúng trang đăng nhập IdP trong WebView, không coi secret đóng gói trong app là bí mật. [OAuth for Native Apps — RFC 8252](https://www.rfc-editor.org/rfc/rfc8252.html)

Credential dài hạn đặt trong [Apple Keychain](https://developer.apple.com/documentation/security/keychain-services); trên Android dùng blob mã hóa với khóa được bảo vệ bởi [Android Keystore](https://developer.android.com/privacy-and-security/keystore). Keystore bảo vệ khóa mã hóa, không phải nơi lưu trực tiếp chuỗi token tùy ý. Access credential ngắn hạn giữ trong bộ nhớ; refresh có rotation/revocation và phát hiện reuse. Browser và native là hai adapter xác thực, cùng ánh xạ vào principal server; không áp dụng máy móc cookie/CSRF của browser cho bearer-native.

### Khách và liên kết

1. Server tạo guest principal, farm và credential ngẫu nhiên; `farmId`/device ID không phải credential. Browser dùng cookie phiên; native dùng kho credential của hệ điều hành. Enrollment pending phải confirm theo [04](04-api-contract.md#21-vòng-đời-enrollment-guest) trước khi nhận command; retry lost response không rotate credential mỗi lần.
2. Khách được hiển thị lợi ích liên kết trước khi đổi thiết bị hoặc thực hiện giao dịch tiền thật trong tương lai. Guest chưa liên kết bị mất credential không được hứa khôi phục bằng tên farm, ảnh chụp hoặc local JSON.
3. Liên kết yêu cầu phiên khách hiện tại và chứng cứ OIDC mới. Với tài khoản đã có liên kết, thao tác thêm/bỏ danh tính cần recent reauthentication.
4. Trong transaction, kiểm tra unique `(issuer, subject)` và khóa các bản ghi liên quan. Liên kết mới nâng tài khoản khách, giữ nguyên farm. Một danh tính đã thuộc tài khoản khác trả conflict challenge rõ ràng; chỉ chọn farm active và archive farm còn lại qua luồng xác nhận có chứng cứ, không tự cộng hai ví, nhân đôi tồn kho hoặc ghi đè farm cloud. Chi tiết chuyển quyền nằm trong [05](05-client-sync-and-migration.md).
5. Link thành công rotate phiên; log audit sự kiện nhưng không ghi token. Không cho bỏ phương thức đăng nhập cuối cùng nếu chưa có phương thức khôi phục được xác minh. Quyết định giữ những phiên khác hay thu hồi tất cả phải có UX nhất quán.

Tình huống nhiều thiết bị cùng link, logout khi request đang chạy và hai danh tính cùng email là các test bắt buộc. Không dùng IdP email vừa đổi làm lý do tự chuyển quyền farm.

### Khôi phục, xuất và xóa dữ liệu

- Khôi phục qua IdP đã liên kết hoặc thủ tục hỗ trợ có bằng chứng sở hữu được phê duyệt; support không cấp quyền vì người yêu cầu biết số coin. Thu hồi phiên rò rỉ, tạo audit và thông báo qua kênh đã xác minh nếu có.
- Export chỉ cho chủ sở hữu sau recent reauth: trạng thái farm, metadata tài khoản và lịch sử thuộc phạm vi sản phẩm. Không xuất credential, secret, thông tin người khác hoặc tín hiệu chống gian lận nội bộ. Có hạn mức, phân trang/kích thước tối đa và expiry tải xuống nếu dùng file.
- Delete là workflow idempotent: xác minh, thu hồi phiên, ngừng nhận command, đánh dấu xóa, xóa/ẩn danh dữ liệu theo chính sách đã duyệt và hoàn tất có audit. Không chỉ xóa hàng `users` để lại bản sao gắn danh tính trong log/export.
- Trước beta chốt trường dữ liệu, vùng lưu, thời hạn giữ, cơ sở giữ ledger/audit và thời gian xử lý yêu cầu theo thị trường phát hành. Đây là quyết định sản phẩm/pháp lý còn mở, tài liệu này không đặt ra kết luận tuân thủ.
- Backup hết hạn theo lịch; runbook restore phải áp dụng lại danh sách xóa/thu hồi có thẩm quyền trước mở traffic, tránh phục hồi tài khoản đã xóa. Tách danh sách tối thiểu này khỏi snapshot đang khôi phục và bảo vệ quyền đọc.

## 3. Phân quyền API, replay và giới hạn tài nguyên

### Quyền trên từng đối tượng

Mọi route có dữ liệu farm phải truy principal từ session/token hợp lệ và kiểm tra ownership. Bao gồm bootstrap, state, command, sync, receipt, export, pending job và công cụ support. UUID khó đoán không thay thế authorization. Không tin `playerId` trong payload; query DB cần gắn farm với principal được xác thực. Đây là kiểm soát trực tiếp cho [OWASP API1: Broken Object Level Authorization](https://api-security.owasp.org/editions/2023/en/0xa1-broken-object-level-authorization/).

Thứ tự chuẩn cho command: xác thực → mở transaction → khóa account rồi session bằng cùng thứ tự mà logout/refresh/revoke dùng → đọc lại `revoked_at`, expiry, generation và account status → khóa ownership/farm → tìm receipt và so request hash → replay nếu phù hợp → kiểm tra policy hiện tại, enrollment confirmed, `farmEpoch`, `catalogVersion`, `expectedRevision` → settlement/action trên candidate trong transaction → commit state/ledger/receipt nguyên tử. `expectedRevision` là chuỗi thập phân, `commandId` và `farmEpoch` là UUID theo [04](04-api-contract.md). Actor được ghi audit, không tạo namespace idempotency mới. Logout cạnh command được tuyến tính hóa ở session lock: request lấy lock trước có thể hoàn tất, request thấy revoked/expired bị dừng. Ownership vẫn được kiểm tra trước trả receipt cũ; sau chuyển quyền hợp lệ, chủ sở hữu hiện tại có thể tra/replay commit cũ của farm nhưng chủ sở hữu trước không còn quyền.

Receipt terminal rejection được ghi bền vững nhưng candidate settlement của command bị từ chối phải rollback. `/sync` có transaction riêng để ghi chuyển trạng thái timer; GET state chỉ đọc trạng thái đã lưu. Đừng dùng middleware trả response cache trước authentication hoặc middleware ghi settlement ngoài transaction.

### Idempotency không thay thế chống lạm dụng

Receipt có khóa `(farm_id, command_id)` độc lập với epoch; ownership được kiểm tra riêng. Fingerprint bao gồm envelope/payload canonical theo hợp đồng, kể cả epoch, để ID cũ không trở thành command mới khi epoch đổi. Không dùng ID toàn cục do client tự chọn như khóa duy nhất thiếu ownership. Cùng ID khác nội dung phải bị từ chối. Retry lỗi mạng dùng nguyên ID và nội dung; sau conflict/review người chơi quyết định intent mới với ID mới.

Hạn mức áp dụng cả request trùng và ID mới để chặn spam receipt/DB. Phân biệt replay hợp lệ với ID mismatch trong metrics. Sau khi rút gọn full receipt vẫn giữ tombstone trong vòng đời farm, không ngầm chạy lại command chi tiêu cũ; quy tắc retention và kết quả tra receipt rút gọn nằm trong [03](03-data-and-transactions.md)/[04](04-api-contract.md). Cần test trước khi triển khai cleanup. HTTP timeout hoặc mất kết nối không chứng minh giao dịch chưa commit, vì vậy client không tự cấp ID mới cho cùng lần bấm.

### Baseline giới hạn cần đo và điều chỉnh

| Lớp | Đề xuất ban đầu | Điều kiện/kiểm chứng |
| --- | --- | --- |
| JSON command | 16 KiB/request; schema allowlist, số hữu hạn và giới hạn trường/mảng | So với payload lớn nhất được duyệt; chặn trước domain/DB |
| Hành động theo principal | 10 request/giây, burst 40; sync gộp khi resume/timer đến hạn | Đo thao tác thu hoạch nhanh, mạng retry và công cụ hỗ trợ tiếp cận; trả retry delay rõ ràng |
| IP/edge | Trần tổng request và guest creation riêng, siết khi có tín hiệu lạm dụng | Không khóa hàng loạt người chơi chung NAT chỉ vì dùng cùng IP; không tin header IP nếu proxy chưa được cấu hình |
| DB | Pool có trần; connection acquisition 1 s, lock wait 500 ms, statement 2 s là điểm thử | Tổng pool của tất cả replica/chạy migration phải dưới ngân sách DB; tune bằng load test |
| Request | Budget ứng dụng 5 s, reverse proxy lớn hơn một khoảng hữu hạn | Timeout phải kết hợp cancellation/rollback rõ ràng; kết quả commit chưa biết được tra bằng receipt |
| Payload đầu ra và export | State có size cap theo schema; danh sách có pagination; export giới hạn đồng thời | Không trả lịch sử receipt/ledger vô hạn trong bootstrap |
| Settlement | Duyệt số plot/slot/job có giới hạn theo farm, không lặp từng giây offline | Farm đầy + offline 30 ngày vẫn có chi phí hữu hạn; không tự lặp sinh sản xuất mới |

Các giới hạn phải ở proxy, ứng dụng và DB đúng chức năng; limiter in-memory của mỗi replica không phải quota toàn hệ thống. V1 ưu tiên edge quota và hạn mức ứng dụng phù hợp, chưa đưa Redis vào chỉ để có limiter. Quyết định thêm kho quota chung dựa trên số replica và bằng chứng lạm dụng. OWASP khuyến nghị kiểm soát kích thước, tần suất, thời gian và chi phí, không chỉ một giới hạn request/giây. [OWASP API4: Unrestricted Resource Consumption](https://api-security.owasp.org/editions/2023/en/0xa4-unrestricted-resource-consumption/)

Cấu hình Fastify timeout/body limit rõ ràng, không dựa vào mặc định: timeout nhận request và deadline xử lý nghiệp vụ là hai việc khác nhau. Chỉ compile schema được version-control, không nhận schema từ người dùng. Structural validation trước transaction chỉ kiểm JSON/size/envelope ổn định; sau ownership và tra receipt mới áp action schema/allowlist hiện hành cho command mới, để action cũ vẫn replay được. [Fastify Server](https://fastify.dev/docs/latest/Reference/Server/), [Fastify Validation and Serialization](https://fastify.dev/docs/latest/Reference/Validation-and-Serialization/)

## 4. Quản trị, kinh tế và tiền thật tương lai

MVP chưa mở API grant/debit quản trị. V1 cần phân quyền vận hành/support tối thiểu và cấm sửa kinh tế tùy tiện; các yêu cầu grant/debit dưới đây là ràng buộc cho pha bổ sung công cụ đó, không phải endpoint hiện có hay phạm vi ngầm của MVP.

Admin là audience/ứng dụng riêng với MFA, phiên ngắn hơn và RBAC; không có cờ `isAdmin` client có thể gửi để mở quyền. Tách ít nhất: support chỉ đọc, người đề nghị điều chỉnh, người duyệt điều chỉnh lớn, người phát hành config và vận hành hạ tầng. Ngưỡng cần hai người duyệt phải chốt trước khi bật công cụ grant/debit, không hardcode con số tùy ý trong domain.

Mỗi grant/debit cần lý do, ticket, actor, approver nếu cần, thời điểm, command ID và ledger entry gắn farm. Cập nhật ví/state và ledger cùng transaction; audit không phụ thuộc log debug dễ bị xoay vòng. Điều chỉnh sai được bù bằng giao dịch mới tham chiếu giao dịch cũ. Không cho console sửa thẳng balance hoặc xóa ledger. Break-glass phải có thời hạn, cảnh báo và review sau sử dụng; DB production không phải công cụ support thường ngày.

Theo dõi coin/diamond/inventory reconciliation, tốc độ tích lũy bất thường và tỷ lệ command bị từ chối. Tín hiệu bất thường dẫn tới điều tra hoặc hạn chế tạm thời có audit; không tự kết luận gian lận vì offline lâu hoặc ping cao. Mọi nguồn/sink được đặt mã ổn định để giải thích biến động; đây không phải yêu cầu biến toàn game thành event sourcing.

`buyCoins` hiện có là đổi diamond lấy coin trong game, không chứng minh đã tích hợp thanh toán. IAP ở pha sau phải xác minh phía server, bind đúng app/environment/product/account, chống trùng transaction/purchase token và chỉ cấp quyền khi trạng thái hợp lệ. Cần xử lý pending, hủy/hoàn tiền, notification đến lặp/khác thứ tự và đối soát; thời điểm acknowledgement theo yêu cầu cửa hàng. [Google Play Billing Security](https://developer.android.com/google/play/billing/security), [Apple App Store Server API](https://developer.apple.com/documentation/appstoreserverapi)

Receipt gửi từ client chỉ là đầu vào xác minh; không tin cờ `paid=true` hoặc số diamond client yêu cầu. Chính sách bù/trừ khi vật phẩm đã tiêu sau refund cần được duyệt riêng. Bật tiền thật là release gate mới, không thuộc điều kiện hoàn thành backend farm MVP.

## 5. Môi trường, CI/CD và secrets

Repo có [script root](../../package.json), [verify Cocos](../../package.json) và browser harness local; tại thời điểm khảo sát chưa có workflow `.github/` hay dịch vụ backend. Pipeline và deployment trong phần này là công việc cần xây.

| Môi trường | Dữ liệu và dịch vụ | Yêu cầu |
| --- | --- | --- |
| Local/test | PostgreSQL cô lập, catalog fixture, IdP giả lập hoặc tenant dev | Khởi tạo lại được; không cần secret production; đồng hồ domain được inject |
| CI | DB thật tạm thời, OIDC test keys, build đã khóa dependency | Test transaction/concurrency/migration; không phát secret cho PR không tin cậy |
| Staging | Cùng major runtime/DB, proxy/TLS/cookie giống production, IdP riêng | Farm tổng hợp; rehearsal migration, rollback, failover và restore; không chép PII production tùy tiện |
| Production | PostgreSQL managed có backup/HA theo ngân sách, API immutable, CDN | Quyền tối thiểu, giám sát, người trực và runbook; số replica dựa trên tải và mục tiêu khả dụng |

Pin Node 24 LTS/Fastify 5 và lockfile trong triển khai, kiểm tra tương thích plugin qua CI. Theo lịch hiện được công bố, Node 24 là LTS; Node khuyến nghị production dùng Active/Maintenance LTS. Fastify có chính sách LTS riêng nên phải theo dõi cả framework/plugin, không chỉ Node. [Node.js Releases](https://nodejs.org/en/about/previous-releases), [Fastify LTS](https://fastify.dev/docs/latest/Reference/LTS/)

PostgreSQL 18 là mặc định, 17 dự phòng; cập nhật minor đã được xác minh, lên kế hoạch major upgrade riêng với rehearsal. PostgreSQL hỗ trợ một major trong 5 năm; 18 hiện có hạn hỗ trợ đến 14-11-2030 và 17 đến 08-11-2029. [PostgreSQL Versioning Policy](https://www.postgresql.org/support/versioning/)

Secrets lấy từ secret manager khi chạy, tách theo môi trường; không ghi trong Cocos assets, JSON catalog, Docker layer, URL hoặc log. App DB role chỉ có quyền DML cần thiết, migration role riêng. CI/CD ưu tiên workload identity và credential ngắn hạn; nếu dùng GitHub Actions, khóa trust OIDC theo repo/ref/environment thay vì cho toàn tổ chức. [GitHub Actions OIDC](https://docs.github.com/en/actions/concepts/security/openid-connect)

Gate build gồm lockfile install, lint/typecheck, domain/transaction/auth tests, kiểm tra migration, dependency/license/security scan phù hợp và artifact gắn commit SHA. Promotion dùng cùng artifact qua staging → production, không build lại từ dependency trôi. Có môi trường duyệt deployment và kế hoạch rotation/revoke secret; việc duyệt deployment là chính sách CI tương lai, không phải yêu cầu xin phép thêm cho việc viết tài liệu hiện tại.

## 6. Mục tiêu dịch vụ, quan sát và giới hạn chi phí

### SLO/RPO/RTO đề xuất, chưa đo

| Chỉ số | Mục tiêu thử nghiệm | Cách xác nhận |
| --- | --- | --- |
| Khả dụng API | Beta 99,5%; GA 99,9% theo tháng | Định nghĩa eligible request và cửa sổ theo dõi trước beta; tách reject hợp lệ khỏi lỗi hạ tầng, vẫn đo auth/sync/read |
| Độ trễ command | p95 < 300 ms, p99 < 1 s tại tải chuẩn [07](07-roadmap-and-testing.md) | Từ API ingress đến response, gồm DB/settlement; đo riêng end-to-end từ thiết bị và IdP login |
| Toàn vẹn kinh tế | Không có cấp/trừ lặp cho một command; không balance âm trái luật | Invariant trong DB/test/reconciliation; đây là điều kiện đúng sai, không đổi thành SLO cho phép sai một tỷ lệ |
| Crash tiến trình API | Không mất giao dịch DB đã commit bền vững | Kill sau commit/trước response; retry tìm đúng receipt |
| Khôi phục thảm họa | RPO ≤ 5 phút, RTO ≤ 60 phút đề xuất | Đo khoảng WAL đã bảo vệ và thời gian restore/kiểm tra/mở traffic trong drill thực tế |

Tuyên bố RPO=0 chỉ hợp lệ cho phạm vi lỗi mà storage/replication bảo đảm. Không tắt durability để đạt benchmark; cấu hình `fsync`, `synchronous_commit` và chế độ failover phải được kiểm tra với nhà cung cấp. Replication/backup bất đồng bộ có thể không giữ những commit gần nhất khi xảy ra thảm họa. Nếu sản phẩm yêu cầu không mất bất kỳ accepted action nào ở cả mất vùng, phải chốt kiến trúc đồng bộ và chi phí trước GA. Sau PITR có thể tồn tại command ID đã commit trên vùng cũ nhưng mất khỏi bản phục hồi: không mở ghi với cùng epoch; tạo `recovery_id` và `farmEpoch` mới, lưu epoch cũ vào archive, chặn command cũ bằng epoch mismatch, rồi mới cho client bootstrap/reconcile. [PostgreSQL WAL Settings](https://www.postgresql.org/docs/current/runtime-config-wal.html)

Metrics cần có: request/latency theo route và outcome; accepted/rejected/replayed command; revision/epoch/catalog conflict; mismatch ID; DB pool/lock wait/deadlock; settlement time; state size; queue depth; error và reconnect của client; backlog audit/export; backup age/WAL lag/dung lượng; reconciliation lệch. Cảnh báo ưu tiên lỗi toàn vẹn, backup hỏng, auth lỗi hàng loạt và SLO burn; mỗi cảnh báo có owner/runbook và thử phát cảnh báo trên staging.

Trace nối request ID → transaction → receipt, không đưa token, cookie, code OAuth, full save, email hoặc body request thô vào log. Player ID nếu cần điều tra là trường pseudonymous được hạn quyền, không là label metrics gây cardinality lớn. Sampling không được làm mất audit cần giữ. OpenTelemetry cung cấp hướng dẫn loại bỏ/redact dữ liệu nhạy cảm; hash dữ liệu không tự biến nó thành vô danh. [OpenTelemetry: Handling Sensitive Data](https://opentelemetry.io/docs/security/handling-sensitive-data/)

Readiness kiểm tra khả năng phục vụ với schema/config đã hỗ trợ và DB trong budget; liveness kiểm tra tiến trình, tránh DB chập chờn gây vòng restart. Khi SIGTERM: bỏ readiness → ngừng nhận request mới → drain request/giao dịch với deadline được đo → đóng pool và process. Response thất lạc khi drain vẫn hồi phục qua receipt.

### Mô hình chi phí, không dùng giá giả định

`Chi phí/tháng = giờ API × đơn giá instance + giờ PostgreSQL × đơn giá tier/HA + GB dữ liệu/index × đơn giá storage + I/O tính phí + GB backup/WAL/copy × đơn giá giữ + GB egress × đơn giá vùng + MAU auth × đơn giá IdP + ingest/retention telemetry + CI/build + tên miền/phí cố định + thời gian vận hành.`

Input phải đo: DAU, phiên/ngày, command và sync/phiên, kích thước state/receipt/ledger/index, tốc độ WAL, số bản backup, retention, cache hit assets và network vùng. Tách fixed cost và cost/1.000 active player-days để dự báo. Lấy báo giá hiện hành của nhà cung cấp sau khi chốt vùng/HA; đặt budget alert và trần telemetry/export. Không giảm độ bền transaction hoặc xóa receipt sớm chỉ để giảm hóa đơn.

## 7. Backup, restore, migration và rollback

### Backup và diễn tập phục hồi

Đề xuất managed base backup hằng ngày, WAL liên tục và PITR 14 ngày, mã hóa, credential restore riêng, bản sao cách ly theo khả năng nhà cung cấp. Chu kỳ/retention này cần kiểm tra chi phí và yêu cầu giữ dữ liệu. PITR cần base backup cùng chuỗi WAL liên tục; `pg_dump` đơn lẻ không thay thế PITR. [PostgreSQL Continuous Archiving and PITR](https://www.postgresql.org/docs/current/continuous-archiving.html)

Restore drill tối thiểu hằng tháng và trước thay đổi schema có rủi ro dữ liệu:

1. Ghi thời điểm bắt đầu, snapshot/WAL checkpoint và commit kiểm chứng đã biết; restore vào môi trường cô lập không gửi notification hay gọi payment.
2. Xác nhận schema, catalog/config lịch sử, farm revision/epoch, receipt và ledger thuộc cùng điểm khôi phục; kiểm tra constraint và các invariant kinh tế trên fixture lẫn mẫu farm.
3. Replay command kiểm chứng đã nhận: không được trừ/cấp lại; command chưa có receipt phải xử lý theo trạng thái khôi phục và chính sách DR, không đoán thành công.
4. Áp dụng lại tombstone xóa/thu hồi, vô hiệu phiên khi cần và kiểm tra secret/config hạ tầng. Backup DB không mặc nhiên chứa cấu hình IdP, DNS, artifact ứng dụng hoặc catalog ngoài DB.
5. Đo RPO thực tế, RTO gồm validation/cutover, khoảng thiếu WAL và chi phí. Lưu biên bản cùng owner và hạng mục sửa; kiểm tra backup thành công không thay thế biên bản restore.

DR có thể mất accepted actions trong cửa sổ RPO. Khi đó dừng ghi, xác định phạm vi, đối soát chứng cứ bền vững độc lập nếu có và đưa ra quy trình khôi phục/bồi hoàn có audit. Không hứa ledger trong chính DB đã mất có thể tái tạo dữ liệu bị mất. Công bố kỳ vọng này và quyết định tăng durability trước khi có tiền thật.

### Migration và phiên bản config

Schema dùng chuỗi expand → backfill có thể chạy lại → chuyển code → contract sau cửa sổ tương thích. Một runner có khóa điều phối thực thi migration; không để mọi API replica tự DDL khi khởi động. Đo lock trên dữ liệu lớn, chia batch có progress, đặt timeout và kiểm thử chạy tiếp sau ngắt giữa chừng. Không gộp drop column và phát hành code còn dùng column trong cùng lần rollout.

Tách schema version, domain state version, immutable `catalogVersion`, revision và `farmEpoch` như [03](03-data-and-transactions.md). Job đã trả phí giữ điều khoản chi phí/thời lượng/output hoặc tham chiếu config bất biến đủ tái hiện. Deploy config mới không âm thầm định giá lại job cũ. Catalog và migration cần review, validation và fixture tương thích N/N−1. Farm có domain version mới hơn code đang chạy phải bị từ chối an toàn, không bị reset hoặc tự hạ phiên bản.

### Rollback phát hành phải giữ accepted actions

| Sự cố | Hành động | Dữ liệu được giữ |
| --- | --- | --- |
| API release lỗi, schema vẫn tương thích | Dừng rollout, route về artifact N−1 đã kiểm chứng hoặc forward fix | Giữ nguyên state, ledger, receipt và revision đã commit |
| Catalog mới sai | Chặn command bị ảnh hưởng; phát catalog sửa; dùng policy chấp nhận phiên bản có kiểm soát | Job cũ dùng điều khoản đã chốt; replay receipt vẫn trả đúng kết quả |
| Migration chưa xong | Dừng backfill/contract, tiếp tục schema mở rộng an toàn; sửa và chạy tiếp | Không down-migrate mù làm mất cột/giá trị mới |
| Economy bug đã cấp/trừ sai | Khoanh phạm vi theo ledger, sửa code và compensating transaction có duyệt | Giữ lịch sử, không ghi đè balance hàng loạt bằng snapshot cũ |
| DB hỏng/mất vùng | Runbook DR/PITR và cutover có kiểm chứng | Theo RPO đo được; đây là phục hồi thảm họa, không phải rollback release |

Trong maintenance, có thể tạm ngừng command mới nhưng vẫn giữ khả năng xác định kết quả command đã nhận theo quyền truy cập. Release gate phải chứng minh deploy N → tạo accepted actions → rollback code N−1 → đọc/replay/tiếp tục chơi không mất các actions đó. Nếu schema/domain mới không tương thích N−1, lựa chọn là forward fix hoặc maintenance; không dùng restore trước deploy để giả lập rollback an toàn.

## 8. Quyết định còn mở và chủ trì

| Quyết định trước mốc | Chủ trì đề xuất | Đầu ra cần duyệt |
| --- | --- | --- |
| Trước auth implementation | Product + backend | IdP, nền tảng browser/native, guest expiry/recovery và link conflict policy |
| Trước staging công khai | Backend + vận hành | Vùng/provider/HA, quota thực tế, pool và timeout, budget alert, secrets/rotation |
| Trước beta | Product + QA + vận hành | SLO/RPO/RTO, retention/delete/export, admin grant limits, lịch trực và restore drill đạt |
| Trước rollout migration local | Product + backend + client | Quyền nhập/chọn farm, chống lặp migration, xử lý giá trị local không có bằng chứng |
| Trước tiền thật | Product + payment/security owner | Server receipt verification, refund/chargeback, đối soát và tiêu chuẩn durability cao hơn nếu cần |

Chuyển các quyết định này thành issue có owner, dependency và acceptance theo [07 — Lộ trình và kiểm thử](07-roadmap-and-testing.md); một mục chưa chốt phải chặn pha phụ thuộc thay vì biến thành mặc định ngầm.
