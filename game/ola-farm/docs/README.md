# Tài liệu Cocos Farm

Bản chơi hiện hành là scene **Farm** trong Cocos Creator **3.8.8**: **40 ruộng, 8 cây, tối đa 8 chuồng, 5 con mỗi chuồng, 8 loại máy (tối đa 16 nhà), 23 công thức và 35 vật phẩm**. Mỗi loại có tối đa hai nhà; nhà thứ hai mở ở level 12–54 tùy loại. Mở ô chuồng mới gồm cả một con. Bảng chăm chỉ hiển thị chuồng đang chọn, với năm thẻ trên một hàng kéo ngang.

**Mọi con số (giá, level, EXP, thời gian, nhà máy, chuồng, công thức, ruộng, kim cương) xem [Chỉ số game](chi-so/README.md)** — bộ tài liệu sinh từ file JSON và đã kiểm chứng bằng cách chạy code game. Các tài liệu dưới đây giữ phần giải thích kỹ thuật, Editor và lịch sử thiết kế.

| Cần tra cứu | Tài liệu |
| --- | --- |
| **Toàn bộ chỉ số game và điểm cần chốt** | [Chỉ số game](chi-so/README.md) |
| Cài đặt, build, chạy và kiểm tra | [Cocos README](../README.md) |
| Cách chia logic, hằng số, dữ liệu sinh tự động và prefab | [Cấu trúc code](cocos/code-structure.md) |
| Kế hoạch backend: kiến trúc, database, API, đồng bộ, vận hành và lộ trình | [Backend](backend/README.md) |
| Schema PostgreSQL, khóa/index, migration, đối soát và phục hồi | [Kế hoạch database chi tiết](backend/08-postgresql-database-plan.md) |
| Vòng chơi, mở chuồng/máy và bản lưu | [Chăn nuôi và chế biến](cocos/farm-town-husbandry-runtime.md) |
| Đồng hồ thực, XP và cách chạy mô phỏng | [Tiến trình thời gian thực](cocos/real-time-economy.md) |
| Tất cả cấu hình: sức chứa, mở khóa, khởi đầu, offline, thao tác và âm thanh | [Bảng cấu hình game](cocos/configuration.md) |
| Chỉnh giá nhà/ô, level, ví và ruộng mở sẵn | [Cấu hình kinh tế và ô đất](cocos/economy-config.md) |
| Chỉnh thời gian bằng JSON và áp dụng vào game | [Cấu hình thời gian](cocos/timing-config.md) |
| Giá, thời gian và công suất cám | [Bảng cân bằng](cocos/farm-town-husbandry-balance.md) |
| Giữ, kéo, đặt công trình và migration bố cục | [Di chuyển công trình](cocos/di-chuyen-cong-trinh.md) |
| Gieo, thu hoạch và tăng tốc cây | [Footer và bong bóng ô đất](cocos/footer-o-dat.md) |
| Chỉnh prefab, nguồn ảnh và generator | [Asset pipeline](cocos/asset-pipeline.md) |
| Shop và hai prefab chỉnh trong Editor | [Shop](cocos/golden-island-shop.md) |
| Popup xưởng, kho và chăm đàn | [Giao diện công trình](cocos/farm-town-modals.md) |
| Phân biệt dữ liệu APK Farm Town với game đang chạy | [Kiểm kê nguồn](cocos/farm-town-agriculture-inventory.md) |

[Bộ nguồn 30 loại cây](../source-assets/farm-town/crops/README.md) giữ ảnh và hồ sơ để tra cứu; [gallery](../source-assets/farm-town/crops/index.html) giúp xem các mảnh nguồn. Bộ này không tự đưa 30 loại vào game: runtime hiện có tám giống trong catalog.

[Catalog runtime](../assets/farm/bundles/farm-town/catalog.json) là nguồn của cây, vật nuôi, máy, công thức và vật phẩm; [timing.json](../assets/farm/bundles/farm-town/timing.json) giữ riêng thời gian của tất cả công việc. [economy.json](../assets/farm/bundles/farm-town/economy.json) giữ giá, level, ví/XP và trạng thái khởi đầu của ruộng; [FarmGame.ts](../assets/farm/scripts/core/FarmGame.ts) thực thi điều kiện và giao dịch. Các expected contract dùng cho kiểm thử nằm trong [fixtures](../tests/fixtures/), không phải kế hoạch nội dung mới.

Các mốc dưới đây là cấu hình mặc định; level trên HUD được suy từ XP. Cây mở ở level 1/1/4/7/10/14/18/24. Ô 2–5 của chuồng gà yêu cầu level 3/9/15/20, ô bò dùng level 2/3/4/5; xây nhà thứ hai cần level 12–54 tùy loại, đã có nhà 1, đủ mốc nội dung và tiền. Ô 2–5 của máy thức ăn yêu cầu level 5/10/15/20, các máy khác dùng level 1; có thể đổi giá/level từng ô trong economy.json. Save cũ được giữ và chuyển lên state v7/pack v6/layout v6, không tự cấp nhà mới. Clock v1 tùy chọn tính tiến trình offline cho công việc đã trả tiền; profile hiện hành chỉ chạy 1×. Không có hệ đơn hàng, nhiệm vụ có thưởng hoặc nuôi cá/ao. Các anchor không hoạt động còn lại phục vụ cấu trúc map và bản lưu cũ. Ảnh, log và build cục bộ ở `artifacts/` không phải đầu vào bắt buộc để build game.

Bản HTML đối chiếu đã được gỡ. Chạy game và kiểm thử bằng Cocos theo hướng dẫn ở trên; nguồn Unity đã trích xuất và các công cụ khảo sát được mô tả trong [nguồn asset](asset-sources.md).
