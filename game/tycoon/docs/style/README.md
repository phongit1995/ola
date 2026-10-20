# Phố Thị Rực Rỡ — UI style system

Thư mục này là đặc tả triển khai chi tiết cho hướng mỹ thuật của Cờ Tỷ Phú. `../01-art-direction.md` và `../03-component-specs.md` là tổng quan; nếu khác nhau thuần về UI style, thư mục này được ưu tiên.

- Tên hiển thị: **Phố Thị Rực Rỡ**.
- ID dùng trong ticket/design review: `tycoon-city-v1`.
- Viewport thiết kế gốc: `390 × 844 CSS px`, responsive `360–520 px`, có safe-area.
- **UI v3 (20/10/2026): phong cảnh pixel 16-bit.** Ảnh mẫu chuẩn: [`../screenshots/concept-s6-board-pixel-16bit.png`](../screenshots/concept-s6-board-pixel-16bit.png) (xem [README ảnh mẫu](../screenshots/README.md)).

## Ảnh mẫu và docs — cái nào thắng

- **Ảnh mẫu thắng** về mỹ thuật: nền màn, cách vẽ tranh ô, hình glyph, hình quân, xúc xắc, nút, chồng thẻ, ô góc, bố cục S6.
- **Docs thắng** về dữ liệu và con số: tên/thứ tự/giá ô lấy từ `logic/board.json`; hex màu nhóm đất và màu ghế giữ token `01-foundations.md` (ảnh AI vẽ đậm hơn, không lấy mã màu từ ảnh); kích thước theo px tại 390.
- **Ba chỗ ảnh tự mâu thuẫn, docs giữ:** bàn vuông 1:1 (ảnh hơi cao); dải nhóm hàng trên nằm ở mép **trong** (đáy ô) như 3 cạnh còn lại, không có chữ trên dải; chỉ **một** vùng log (ảnh vẽ cả thẻ log lẫn dòng sự kiện ở footer).

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

1. **Bàn là tiêu điểm, tranh pixel là linh hồn của ô.** Bàn giấy sáng nằm trên nền trời pixel; mỗi thành phố có một tranh phong cảnh pixel 16-bit, dải màu nhóm cho biết đất thuộc nhóm nào.
2. **Hai lớp hình: cảnh pixel, UI mượt.** Pixel 16-bit chỉ dùng cho tranh cảnh (ô thành phố, ô sân bay, Nhà tù, Lễ hội, nền màn). Nút, chip, pod, thẻ, glyph, chữ là vector mượt viền navy — không pixel hoá UI.
3. **Một hệ nét cho UI.** Outline navy `1.5/2 px`; icon điều khiển stroke `2`; glyph ô fill màu với contour navy mảnh; không trộn emoji.
4. **Chữ luôn thật.** Không bake tên ô, số tiền, tên nhân vật hay nhãn nút vào bitmap (logo là ngoại lệ duy nhất).
5. **Mỗi màu có nghĩa.** Gold = hành động chính/lượt; jade = tiền vào/hợp lệ; coral = tiền ra/nguy hiểm; cam = Cơ hội; xanh trời = Khí vận; màu ghế = danh tính người chơi; màu nhóm = đất. Không dùng accent để trang trí.

## Quy tắc chống cảm giác AI-generated

- Chỉ dùng các họ màu trong `01-foundations.md`; nhân vật dùng palette riêng trong `03-characters.md` nhưng contour vẫn navy.
- Tranh pixel: cùng độ phân giải gốc, cùng bảng màu, cùng góc nhìn ngang có trời; phóng bằng nearest-neighbor theo bội số nguyên (`image-rendering: pixelated`), không làm mịn, không trộn tranh vẽ mượt.
- Địa danh vẽ cách điệu bằng pixel, không ảnh chụp, không logo/chữ thương hiệu; không rồng phượng trang trí, không tiền thật.
- Nổi khối nhẹ (gradient 2 tông + mép dưới đậm) chỉ cho logo, nút gold, xúc xắc, chồng thẻ và quân. Không glow, glass, neon.
- Mọi màn chụp visual regression ở cùng viewport, cùng fixture.

## Bản đồ class dự kiến

| Nhóm | Class |
|---|---|
| Button | `.ty-btn`, `.ty-btn-gold`, `.ty-btn-paper`, `.ty-btn-jade`, `.ty-btn-danger`, `.ty-btn-text`, `.ty-btn-big`, `.ty-btn-small` |
| Icon button | `.ty-icon-btn`, `.ty-icon-btn-dark` |
| Chip | `.ty-chip`, `.ty-chip-gold`, `.ty-chip-jade`, `.ty-chip-coral`, `.ty-chip-group[data-group]`, `.ty-chip-seat[data-seat]` |
| Board | `.ty-board`, `.ty-tile[data-kind][data-group]`, `.ty-tile-band`, `.ty-tile-house`, `.ty-tile-hotel`, `.ty-owner-dot`, `.ty-token[data-seat]`, `.ty-tile-art` |
| Surface | `.ty-pod[data-seat]`, `.ty-sheet`, `.ty-modal`, `.ty-card[data-deck]`, `.ty-room-row`, `.ty-list-row` |
| Feedback | `.ty-toast`, `.ty-turn-announce`, `.ty-oppaway`, `.ty-round-chip`, `.ty-money-float` |
| Character | `.ty-char[data-char][data-pose]` |
