# Phố Thị Rực Rỡ — UI style system

Thư mục này là đặc tả triển khai chi tiết cho hướng mỹ thuật của Cờ Tỷ Phú. `../01-art-direction.md` và `../03-component-specs.md` là tổng quan; nếu khác nhau thuần về UI style, thư mục này được ưu tiên.

- Tên hiển thị: **Phố Thị Rực Rỡ**.
- ID dùng trong ticket/design review: `tycoon-city-v1`.
- Viewport thiết kế gốc: `390 × 844 CSS px`, responsive `360–520 px`, có safe-area.
- Không có ảnh concept lúc viết; mục `06-implementation-plan.md` quy định bước tạo concept trước khi code UI.

## Thứ tự đọc

1. [01-foundations.md](./01-foundations.md) — toàn bộ CSS token (màu, chữ, spacing, radius, shadow, z-index, motion) dạng copy được vào `tokens.css`.
2. [02-board-tiles.md](./02-board-tiles.md) — bảng 32 ô: màu dải, nền, glyph, màu glyph, nhân vật, cách xoay, text trong sheet.
3. [03-characters.md](./03-characters.md) — dàn 6 nhân vật: vai trò, palette riêng, pose, nơi xuất hiện, kích thước, prompt sinh.
4. [04-icon-colors.md](./04-icon-colors.md) — ma trận màu của 30 `ic-`, 13 `tg-`, xúc xắc, quân theo từng nền và trạng thái.
5. [05-buttons-and-controls.md](./05-buttons-and-controls.md) — từng loại button/control và toàn bộ trạng thái.
6. [06-implementation-plan.md](./06-implementation-plan.md) — kế hoạch triển khai UI theo giai đoạn, checklist và Definition of Done.

## Quyền quyết định

- React/store/server quyết định hành vi, dữ liệu và luật chơi (`../05-gameplay-rules-and-protocol.md`).
- Thư mục này quyết định visual token, anatomy, màu từng phần tử, trạng thái và cách dùng component.
- Không tự thêm biến thể mới chỉ để khớp một màn. Thiếu thì cập nhật docs trước khi code.

## Năm nguyên tắc không được phá vỡ

1. **Bàn là tiêu điểm, màu nhóm đất là ngôn ngữ chính.** Mọi thứ quanh bàn giảm bão hòa; 8 màu nhóm là nơi duy nhất bão hòa cao.
2. **Nhân vật là gia vị, không phải nền.** Nhân vật không bao giờ đứng sau chữ hoặc đè lên ô cạnh; chỉ ở 4 ô góc, sheet, thẻ, modal, lobby, kết quả.
3. **Một hệ nét.** UI outline navy `1.5/2 px`; icon điều khiển stroke `2`; glyph ô và nhân vật fill phẳng với contour navy; không trộn emoji.
4. **Chữ luôn thật.** Không bake tên ô, số tiền, tên nhân vật hay nhãn nút vào bitmap.
5. **Mỗi màu có nghĩa.** Gold = hành động chính/lượt; jade = tiền vào/hợp lệ; coral = tiền ra/nguy hiểm; sky = Khí vận; màu ghế = danh tính người chơi; màu nhóm = đất. Không dùng accent để trang trí.

## Quy tắc chống cảm giác AI-generated

- Chỉ dùng các họ màu trong `01-foundations.md`; nhân vật dùng palette riêng trong `03-characters.md` nhưng contour vẫn navy.
- Nhân vật cùng tỷ lệ đầu/thân (2.5 đầu), cùng độ dày contour, cùng cách tô highlight một vùng; không nhân vật nào "render" hơn nhân vật khác.
- Không rồng phượng, không hoa văn, không ảnh địa danh thật, không tiền thật.
- Không glow/glass/neon/bevel 3D.
- Mọi màn chụp visual regression ở cùng viewport, cùng fixture.

## Bản đồ class dự kiến

| Nhóm | Class |
|---|---|
| Button | `.ty-btn`, `.ty-btn-gold`, `.ty-btn-paper`, `.ty-btn-jade`, `.ty-btn-danger`, `.ty-btn-text`, `.ty-btn-big`, `.ty-btn-small` |
| Icon button | `.ty-icon-btn`, `.ty-icon-btn-dark` |
| Chip | `.ty-chip`, `.ty-chip-gold`, `.ty-chip-jade`, `.ty-chip-coral`, `.ty-chip-group[data-group]`, `.ty-chip-seat[data-seat]` |
| Board | `.ty-board`, `.ty-tile[data-kind][data-group]`, `.ty-tile-band`, `.ty-tile-house`, `.ty-tile-hotel`, `.ty-owner-dot`, `.ty-token[data-seat]`, `.ty-corner-bust` |
| Surface | `.ty-pod[data-seat]`, `.ty-sheet`, `.ty-modal`, `.ty-card[data-deck]`, `.ty-room-row`, `.ty-list-row` |
| Feedback | `.ty-toast`, `.ty-turn-announce`, `.ty-oppaway`, `.ty-round-chip`, `.ty-money-float` |
| Character | `.ty-char[data-char][data-pose]` |
