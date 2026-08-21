# Mộc bản thủ công — UI style system

Thư mục này là đặc tả chi tiết cho hướng mỹ thuật đã chọn của game Cờ Tướng.

- Tên hiển thị: **Mộc bản thủ công**.
- Codename nội bộ: **Kỳ Đàn Son Mộc**.
- ID dùng trong ticket/design review: `xiangqi-woodblock-v1`.
- Ảnh tham chiếu: [board-style-moc-ban.png](../screenshots/style-concepts/board-style-moc-ban.png).
- Viewport thiết kế gốc: `390 × 844 CSS px`.
- Phạm vi responsive: rộng `360–520 px`, có safe-area trên và dưới.

Ảnh concept chỉ xác định art direction. Không cắt nguyên giao diện trong ảnh để đưa vào game. Chữ, icon, nút, panel, lưới bàn cờ và trạng thái tương tác phải được dựng bằng CSS/SVG/live text. Raster chỉ được dùng cho texture nền liền mạch hoặc mặt quân đã được duyệt thủ công.

## Thứ tự đọc

1. [01-foundations.md](./01-foundations.md) — nguyên tắc, màu, chữ, spacing, viền, shadow, texture và motion.
2. [02-buttons-and-controls.md](./02-buttons-and-controls.md) — từng loại button/control và toàn bộ trạng thái.
3. [03-components.md](./03-components.md) — bàn cờ, quân, pod người chơi, panel, input, modal, toast, chat và list.
4. [04-icon-system.md](./04-icon-system.md) — lưới icon, quy tắc vẽ, danh mục icon và quy trình tạo icon mới.
5. [05-screens-responsive-accessibility.md](./05-screens-responsive-accessibility.md) — áp dụng lên từng màn, responsive, accessibility và localization.
6. [06-implementation-qa.md](./06-implementation-qa.md) — trình tự triển khai, visual regression và Definition of Done.

## Quyền quyết định

- React/store/server quyết định hành vi, dữ liệu và luật chơi.
- Thư mục này quyết định visual token, anatomy, kích thước, trạng thái và cách dùng component.
- `01-art-direction.md` và `03-component-specs.md` vẫn là tài liệu tổng quan. Nếu có khác biệt thuần về UI style, đặc tả trong thư mục này được ưu tiên.
- Không tự thêm một biến thể mới chỉ để khớp một màn. Component mới phải ghép từ token và pattern đã có; nếu thật sự thiếu thì cập nhật docs trước khi code.

## Năm nguyên tắc không được phá vỡ

1. **Bàn và quân là tiêu điểm.** Thành phần xung quanh giảm tương phản, không cạnh tranh với thế cờ.
2. **Thủ công có kiểm soát.** Cảm giác mộc đến từ palette, nét in và texture rất nhẹ; hình học, baseline và khoảng cách vẫn chính xác.
3. **Một hệ nét.** UI dùng outline navy `1.5/2 px`; icon dùng stroke `2 px`; không trộn emoji, icon fill và icon outline.
4. **Chữ luôn thật.** Không bake tên, số KEN, đồng hồ, trạng thái hay nhãn nút vào bitmap.
5. **Mỗi trạng thái có lý do.** Gold = hành động chính/lượt; red = nguy hiểm/chiếu/lỗi; jade = hợp lệ/thành công; không dùng accent để trang trí ngẫu nhiên.

## Quy tắc chống cảm giác AI-generated

- Chỉ dùng sáu họ màu: wood, paper, navy/ink, vermilion, gold và jade.
- Chỉ dùng radius trong scale đã chốt; không bo góc tùy hứng theo từng component.
- Texture không được đi qua chữ, icon hoặc đường cờ; không tạo vết xước ngẫu nhiên trên từng nút.
- Không dùng rồng, phượng, chùa, đèn lồng, mây, triện giả, pseudo-calligraphy hoặc ornament “Á Đông” không có chức năng.
- Không dùng glow, glassmorphism, neon, chrome, bevel 3D hoặc gradient nhiều màu.
- Không dùng hình AI nguyên khối làm background màn chơi.
- Icon mới phải qua template và checklist trong `04-icon-system.md`; không lấy emoji hệ điều hành làm icon production.
- Mọi màn phải chụp visual regression ở cùng viewport và cùng dữ liệu fixture để phát hiện lệch spacing, text và glyph.

## Bản đồ class hiện tại

| Nhóm | Class/pattern hiện có |
|---|---|
| Button chuẩn | `.xq-btn`, `.xq-btn-gold`, `.xq-btn-paper`, `.xq-btn-danger` |
| Kích thước button | `.xq-btn-big`, mặc định, `.xq-btn-small` |
| Icon button | `.xq-icon-btn` |
| Action bar | `.xq-action`, `.xq-action-danger`, `.xq-dot` |
| Tab/chọn nhanh | `.xq-tab`, `.xq-tab-active`, `.xq-chip-btn`, `.xq-chip-btn-active` |
| Badge | `.xq-chip`, `.xq-chip-gold`, `.xq-chip-jade`, `.xq-ken-badge`, `.xq-bet-badge` |
| Board control | `.xq-piece`, `.xq-hint-dot`, `.xq-last-marker` |
| Surface | `.xq-modal`, `.xq-pregame-panel`, `.xq-pod`, `.xq-room-row`, `.xq-list-row` |
| Feedback | `.xq-toast`, `.xq-check-banner`, `.xq-turn-announce`, `.xq-oppaway`, `.xq-expired` |

Các class trên là điểm nối với code hiện tại. Tài liệu không yêu cầu đổi tên class chỉ để đổi style.
