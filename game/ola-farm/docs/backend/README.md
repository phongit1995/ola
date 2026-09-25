# Kế hoạch backend cho Cocos Farm

Ngày lập: **20/09/2026**; rà soát lần gần nhất: **23/09/2026**. Baseline gameplay tại commit **`c6c2d26`**; đường dẫn nguồn được cập nhật theo refactor **`58a13f5`** và đợt gỡ HTML cũ ngày 23/09/2026. Trạng thái: **kế hoạch đề xuất, chưa triển khai backend**. Các đường dẫn API, bảng dữ liệu, thư mục server và tiêu chí bên dưới mô tả công việc sẽ làm; chưa phải tính năng có sẵn.

Đề xuất xây một backend TypeScript quản lý tài khoản, trạng thái nông trại và toàn bộ giao dịch gameplay. Client Cocos gửi thao tác; server kiểm tra luật, tính thời gian và lưu kết quả. Mục tiêu đầu tiên là chơi cùng một farm trên nhiều thiết bị, tránh mất tiến trình hoặc nhận thưởng hai lần khi mạng chập chờn, đồng thời tái sử dụng domain hiện tại.

## Đọc theo nhu cầu

| Tài liệu | Nội dung và kết quả cần đạt |
| --- | --- |
| [01 · Hiện trạng và phạm vi](01-current-state-and-scope.md) | Những gì repo thực sự có; gameplay, save, ranh giới tin cậy; phạm vi backend đầu tiên. |
| [02 · Kiến trúc và cách chia code](02-architecture.md) | Stack, module, thư mục, logic dùng chung với Cocos; tách types, constants, enums, schema và config. |
| [03 · Dữ liệu và giao dịch](03-data-and-transactions.md) | Database, khóa đồng thời, revision, lưu kết quả lệnh, sổ giao dịch, thời gian và nâng phiên bản dữ liệu. |
| [04 · Hợp đồng API](04-api-contract.md) | Xác thực, bootstrap, snapshot, commands, sync, mã lỗi, retry và danh mục thao tác. |
| [05 · Client, offline và chuyển save](05-client-sync-and-migration.md) | Thay cơ chế session, UI bất đồng bộ, nhiều thiết bị, mất mạng, giữ save local và chuyển sang online. |
| [06 · Bảo mật và vận hành](06-security-and-operations.md) | Phiên đăng nhập, phân quyền, chống lạm dụng, môi trường, backup/restore, log, theo dõi và chi phí. |
| [07 · Lộ trình và kiểm thử](07-roadmap-and-testing.md) | Các giai đoạn, phụ thuộc, đầu việc, ước lượng có điều kiện và tiêu chí nghiệm thu. |
| [08 · Kế hoạch database PostgreSQL](08-postgresql-database-plan.md) | ERD, kiểu cột/FK/index, DDL mẫu, quyền DB, migration DB-00–DB-05, sizing, reconciliation và test gate. |

Đọc `01 → 02 → 03 → 04` để chốt nền tảng; dùng `05 → 06 → 07` để chia việc và chuẩn bị phát hành. Chi tiết tên trường và mã lỗi lấy **04** làm chuẩn; quy tắc commit và thời gian lấy **03** làm chuẩn. Khi thay quyết định, cập nhật đồng thời các tài liệu chịu ảnh hưởng.

PostgreSQL là lựa chọn cho kế hoạch database chi tiết theo yêu cầu hiện tại; đọc **08** sau **03** để triển khai schema và migration. Provider/region/HA/budget vẫn cần chốt. DDL trong 08 là bản thiết kế, chưa phải database hay migration đã triển khai.

## Những quyết định đề xuất

| Chủ đề | Mặc định trong kế hoạch | Lý do / giới hạn |
| --- | --- | --- |
| Mức quyền của server | Server quyết định ví, kho, XP, xây nhà, vị trí và timer. | Cloud save đơn thuần không xác minh được số dư do client gửi. |
| Cách triển khai | Một ứng dụng backend chia module; HTTP API và PostgreSQL. | Gameplay theo thao tác, chưa cần mô phỏng realtime hay nhiều dịch vụ. |
| Công nghệ | Node.js 24 LTS, TypeScript, Fastify 5; PostgreSQL 18 managed, 17 là phương án tương thích nhà cung cấp. | Phiên bản cần kiểm tra lại khi triển khai; xem [nguồn và tradeoff](02-architecture.md#2-stack-đề-xuất). |
| Lưu gameplay | Một snapshot có revision cho mỗi farm; receipt và ledger ghi cùng transaction. | Các thao tác đụng ví, kho, timer và tiến trình cùng lúc; cần nhất quán nguyên tử. |
| Dùng chung luật | Đóng gói phần domain thuần từ `cocos/assets/farm/scripts/core`, không viết lại giá/luật ở server. | Build package riêng, giữ nguồn chuẩn và kiểm thử tương đương. |
| Đồng hồ | Giờ server; công việc đã bắt đầu tiếp tục khi đóng game. | Pause, sửa giờ máy và tốc độ client không điều khiển kinh tế online. |
| Mất mạng | Hiển thị snapshot đã xác nhận; đợi kết nối để chi tiêu/nhận thưởng. | Vẫn có thể chơi chế độ local độc lập; không tự cộng dồn hai nhánh save. |
| Tài khoản | Guest được server tạo, có đường liên kết nhà cung cấp OIDC. | Chọn provider và phạm vi native ở giai đoạn chốt sản phẩm. |
| Save cũ | Giữ nguyên, cho xuất backup; mặc định tạo farm online mới. | Save local không có bằng chứng xác thực kinh tế; nếu cần nhập tiến trình phải có chính sách riêng. |
| Thanh toán | Chưa nằm trong bản backend đầu tiên. | `buyCoins` chỉ đổi kim cương có sẵn lấy xu; không chứng minh giao dịch tiền thật. |

## Những điểm cần chốt trước khi triển khai

Chưa có thông tin về backend có sẵn, ngân sách, lượng người chơi hoặc nhà cung cấp bắt buộc. Kế hoạch sử dụng các mặc định trên để vẫn chia được công việc cụ thể. Đây là danh sách quyết định sản phẩm cho giai đoạn đầu, không phải điều kiện để đọc hay hoàn thiện tài liệu.

| Quyết định | Mặc định để ước lượng | Nếu chọn khác |
| --- | --- | --- |
| Online có phải chế độ chính? | Server authoritative cho farm online; giữ local riêng. | Chỉ cloud save sẽ giảm việc gameplay nhưng đổi mục tiêu chống gian lận và chính sách xung đột. |
| Nền tảng phát hành đầu | Web Cocos; native thêm sau khi kiểm chứng secure storage và callback đăng nhập. | Android/iOS đồng thời cần thêm tích hợp, kiểm thử thiết bị và quy trình phát hành. |
| Đăng nhập | Guest rồi liên kết một provider OIDC. | Email/password tự quản lý cần thêm xác minh, khôi phục, chống dò mật khẩu và hỗ trợ người dùng. |
| Người đang có save local | Tiếp tục local hoặc chủ động tạo online mới; không ghi đè save. | Nhập save có giá trị kinh tế cần định mức, chống nhập lặp và phân hạng dữ liệu tin cậy. |
| Pause và offline | Timer đã trả chi phí tiếp tục theo server, không có giới hạn offline mặc định. | Giới hạn thời gian hoặc dừng timer khi pause là thay đổi luật cần version và kiểm thử. |
| Hạ tầng, thị trường | Một vùng gần nhóm người chơi chính, DB managed có PITR. | Nhiều vùng ghi dữ liệu hoặc yêu cầu lưu trú dữ liệu làm tăng độ phức tạp. |
| Quy mô và mức dịch vụ | Chọn workload và SLO ban đầu trong tài liệu 06, đo trước beta. | Không dùng con số ước lượng làm cam kết năng lực hoặc giá nhà cung cấp. |
| Vận hành kinh tế | Bản đầu chỉ có gameplay; công cụ hỗ trợ tối thiểu và audit. | Tiền thật, giao dịch người chơi, bảng xếp hạng cần giai đoạn riêng. |

## Điều kiện hoàn thành backend đầu tiên

- Người chơi mở farm, xây máy/chuồng qua shop và chơi đủ vòng trồng → thu hoạch → chế biến → chăm vật nuôi → bán theo catalog server.
- Hai thiết bị dùng chung farm không ghi đè dữ liệu; retry hoặc timeout sau commit không trừ tiền, hoàn nguyên liệu hay nhận thưởng thêm lần nữa.
- Timer đúng khi đóng game, mất mạng, server restart và đổi giờ trên thiết bị; hàng chờ/khay đầy giữ đúng luật hiện tại.
- Snapshot, revision, kết quả lệnh và ledger nhất quán sau crash; backup đã được phục hồi thử trong môi trường độc lập.
- Client phân biệt local/online, không nhận số dư local làm số dư server và không làm mất bản lưu cũ khi liên kết tài khoản.
- CI, kiểm thử phân quyền, kiểm thử lỗi mạng, kiểm thử tải và bộ kiểm tra Cocos đạt tiêu chí trong tài liệu 07.

## Việc bắt đầu khi chuyển từ kế hoạch sang code

1. Chốt các lựa chọn sản phẩm ở bảng trên và ghi ADR cho điểm thay đổi.
2. Làm thử package domain: load catalog và chạy cùng chuỗi thao tác trên Node/Cocos, so sánh state; đo một vòng settlement dài và kiểm tra geometry.
3. Dựng một lát cắt hoàn chỉnh: guest → tạo farm → bootstrap → mua máy thức ăn → thử lại đúng command → đọc trên thiết bị thứ hai.
4. Chỉ mở rộng nhóm lệnh và UI sau khi transaction, receipt, auth và persistence của lát cắt này đã qua kiểm thử lỗi.

Không có thay đổi runtime hoặc dịch vụ bên ngoài trong đợt viết kế hoạch này. Cách tổ chức client sau refactor được mô tả ở [cấu trúc code Cocos](../cocos/code-structure.md).
