# Tiến Lên UI — Style 02: Chiếu Bài Ngày Vui

## Hướng duy nhất

**Style 02 — Chiếu Bài Ngày Vui** là design system duy nhất cho UI Tiến Lên Miền Nam. Toàn bộ tài liệu được đặt trực tiếp trong thư mục `game/thirteen/docs/`; không còn tầng thư mục phân loại theo style.

Ngôn ngữ hình ảnh: nền kem ấm, chiếu aqua sáng, outline navy đồng nhất, CTA vàng nắng, điểm nhấn coral, hình học phẳng và text live. Production ưu tiên CSS/SVG để giao diện sắc, nhất quán và ít dấu vết sinh ảnh.

## Concept được duyệt

- [Lobby](./screenshots/concept-lobby-style-02-ngay-vui.png)
- [Bàn chơi](./screenshots/concept-table-style-02-ngay-vui.png)
- [Phòng chờ](./screenshots/concept-room-style-02-ngay-vui.png)
- [Kết quả](./screenshots/concept-result-style-02-ngay-vui.png)
- [Tạo bàn](./screenshots/concept-create-room-style-02-ngay-vui.png)
- [Chat trong ván](./screenshots/concept-table-chat-style-02-ngay-vui.png)
- [Đang kết nối](./screenshots/concept-loading-style-02-ngay-vui.png)

Toàn bộ 7 concept cùng 22 screenshot chức năng được lưu tại [screenshots/README.md](./screenshots/README.md). Docs không phụ thuộc vào đường dẫn tạm bên ngoài repository.

Source React hiện tại quyết định chức năng, dữ liệu và state. Concept quyết định ngôn ngữ hình ảnh. Không dùng concept nguyên khối làm production background và không sao chép lỗi chữ/dữ liệu giả từ ảnh concept.

## Cấu trúc tài liệu phẳng

Đọc theo thứ tự:

1. [01-art-direction.md](./01-art-direction.md) — palette, typography, hình học, texture, shadow và motion.
2. [02-screen-specs.md](./02-screen-specs.md) — loading, lobby, modal, phòng chờ, bàn chơi, chat và kết quả.
3. [03-component-specs.md](./03-component-specs.md) — từng nút, viền, panel, avatar, input, badge, card state và FX.
4. [04-asset-manifest-and-prompts.md](./04-asset-manifest-and-prompts.md) — manifest CSS/SVG/raster và prompt tạo mockup/asset.
5. [05-generation-workflow-and-qa.md](./05-generation-workflow-and-qa.md) — production, export, accessibility, performance và QA.
6. [06-screen-to-asset-map.md](./06-screen-to-asset-map.md) — mapping DOM class hiện tại sang token/component/asset.
7. [07-loading-lobby-implementation.md](./07-loading-lobby-implementation.md) — implementation loading/lobby, asset đã cắt, responsive và cách QA.
8. [08-room-table-result-implementation.md](./08-room-table-result-implementation.md) — implementation phòng chờ, bàn chơi, chat, feedback và kết quả.
9. [asset-generation-log.template.md](./asset-generation-log.template.md) — log cho mỗi asset hoặc lần sinh hình.

## Nguyên tắc bắt buộc

- viewport logic `390 × 844 CSS px`, hỗ trợ width 360–520 px;
- CSS token và SVG code-native trước, raster chỉ khi thật sự cần;
- border navy thống nhất 1.5–2 px;
- radius chỉ dùng scale 8/12/16/20/28/999;
- label, tên, số và trạng thái luôn là live text;
- giữ nguyên bộ bài trong `game/thirteen/assets/cards/`;
- không bake toàn màn hoặc component tương tác thành ảnh;
- mọi state phải có focus, disabled, loading và reduced-motion khi phù hợp;
- chữ đạt WCAG AA và touch target tối thiểu 44 × 44 px.

## Vị trí asset

```text
game/thirteen/assets/
  app-icons/        # app icon đã chốt, SVG nguồn + PNG bo góc 1024 px
  cards/
  icons/
  patterns/
  fx/
```

Không tạo thêm tầng `style-*`. Bộ docs chỉ mô tả UI và pipeline asset; không thay đổi luật, network/store hoặc chức năng màn React hiện tại.
