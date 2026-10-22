# Asset generation log — Cờ Tỷ Phú

## style/screens/s2-lobby/concept-s2-lobby-pixel-16bit.png

- Loại: concept màn S2 để tham chiếu mỹ thuật, không phải asset runtime.
- Ngày sinh: 2026-10-20 (Asia/Bangkok), theo prompt set gốc.
- Công cụ sinh: built-in image_gen; không dùng CLI/API fallback.
- Ảnh tham chiếu: [concept S6 đã duyệt](./style/screens/s6-board/concept-s6-board-pixel-16bit.png), chỉ làm tham chiếu phong cách.
- Lựa chọn: người dùng đã chọn **phương án 1 — Nền trời thoáng** trong ba phương án lobby (Nền trời thoáng / Bảng giấy / Bàn cờ). Chỉ đưa phương án 1 vào docs.
- File nguồn tại workspace: `game/dist/tycoon-lobby-concepts/concept-s2-lobby-pixel-16bit-01-sky.png`; prompt set gốc: `game/dist/tycoon-lobby-concepts/prompts.md`. Các đường dẫn dist là nguồn nháp local, không phải dependency của docs.
- Hậu kỳ khi đưa vào docs: copy nguyên byte và đổi tên theo quy ước màn; không crop, resize, nén lại hoặc chỉnh ảnh.
- Kích thước cuối: **853 × 1844 px**, **2.136.952 byte** (khoảng 2,04 MiB).
- SHA-256: `75dfca89db6812190fb228b0041703b6f687610917a3cbdcc3d5d3e07517cd78`.
- Người duyệt: người dùng, chọn ảnh thứ nhất trong cuộc hội thoại.
- Kiểm tra docs: ảnh đích có cùng hash với nguồn; đủ topbar/logo/mascot/3 thẻ/2 quân/4 action/footer, đã xem ảnh trực tiếp.
- Ngoại lệ production: tên, avatar, số dư, version là mẫu; chữ bằng DOM với Nunito, avatar VIP + `@username`; palette, kích thước và trạng thái theo [style lobby](./style/screens/s2-lobby/README.md). Concept không yêu cầu alpha và không được tính vào budget asset tải game.
- Trạng thái: **đã chọn concept, đã viết đặc tả**; chưa dựng UI hoặc sinh asset production riêng.

### Prompt đầy đủ của phương án 1

Giữ nguyên prompt gốc để truy vết. Kích thước/nhân vật trong kết quả sinh không khớp hoàn toàn con số của prompt; người dùng chọn ảnh kết quả. Số đo triển khai được cập nhật ở [style S2 lobby](./style/screens/s2-lobby/README.md), không dùng số cũ trong prompt này làm đặc tả.

```text
Use case: ui-mockup.
Create one polished portrait mobile game LOBBY screen for the original Vietnamese board game "CỜ TỶ PHÚ". Logical canvas 390 x 844, portrait aspect ratio about 0.462 (render high resolution). Edge-to-edge interface, NO phone hardware, NO presentation board, NO multiple panels.
Input image 1 is a STYLE REFERENCE ONLY: the approved S6 game board. This deliverable is the S2 LOBBY, not an in-progress game board. Match the reference's cheerful sunny 16-bit pixel scenery plus smooth rounded navy-outlined UI, gold logo and prominent gold pill button.
Use crisp pixel art only for scenery: cyan sky #35C1FC fading to #7FE3F7, blocky white clouds, leafy green trees and small Vietnamese city rooftops along edges/bottom. UI text, buttons, icons, avatar and mascot are SMOOTH vector-like graphics, never pixel fonts. Paper #FCFDF0, navy text/outlines #1F2A44, gold #FFD34D to #F2B807 with darker #B98700 bottom lip, jade #1F8A5B for wallet accent. Limited intentional palette, clean negative space, subtle depth only, no neon/glass/no photo/no realistic 3D/no casino.
MANDATORY CONTENT, exactly one each:
- Compact top bar: cream profile pill with circular avatar and name "Minh Anh" on the left; cream wallet badge with coin icon and "12.500 KEN" on right; separate 44px circular cream navy speaker button.
- Hero/logo area y96–300: exact logo text "CỜ TỶ PHÚ", chunky gold letters with navy contour, small crown over first letter and a single small white die at the end. Include a small illustration of TWO smooth pawn tokens (gold and blue) on THREE paper property tiles with colored strips and pixel landscapes.
- Beside the hero include Bác Tỷ, ONE original Vietnamese uncle mascot: 2.5-head tall rounded proportions, round belly, short dark hair, round cream glasses, two dot eyes, gentle one-line smile, golden ba-ba shirt, navy trousers, tan skin #F3C9A0, holding a folded paper fan. Smooth flat-vector character with uniform navy outline, approximate displayed height100–120px. No top hat, no business suit, no moustached Monopoly mascot. Keep mascot separate from text.
- One centered vertical stack in this order around y330–610: "Vào bàn" gold pill 320x64, "Lịch sử" cream pill320x52, "Bảng xếp hạng" cream pill320x52, "Luật chơi" navy underlined text action. Neat consistent icons: doorway/dice, history clock, bar-chart podium, rules booklet. Navy bold rounded sans-serif similar Nunito, exact Vietnamese accents, large legible type. Single gold primary action.
- Footer near bottom safe area: cream pill with exit icon and exact text "Thoát game"; small "v1.0" nearby.
Do not add online counts, ads, promotions, tournaments, bets, timers, extra currencies, shops, bottom tab navigation or extra buttons. Do not put rules or gameplay controls on this lobby. All texts are part of a design mockup, not a production raster asset. No watermark or captions outside the interface.

COMPOSITION VARIANT 1 — OPEN SKY.
Closest to the written S2 spec. UI elements float individually on an airy uninterrupted bright pixel sky. Compact topbar at top, large horizontally centered gold logo at y100, mascot on left below logo and three tile vignette with two pawns on right at y200–295. Four navigation actions vertically aligned directly on the sky starting y340. The top two thirds are mostly clean blue with small clouds at edges. A low detailed pixel Vietnamese town skyline, trees and a little street occupy only the bottom 20 percent behind footer. No enclosing menu panel. Spacious, clear, welcoming, the gold Vào bàn button is the focus.
```

Negative constraints nằm trong prompt trên; không có negative prompt riêng.

## O5 modal — bốn ảnh ví dụ

- Ngày sinh và lưu vào docs: **2026-10-21** (Asia/Bangkok).
- Công cụ: **built-in imagegen**, một lần sinh cho mỗi loại modal; không dùng CLI/API fallback.
- Ảnh nền tham chiếu: [concept lobby S2](./style/screens/s2-lobby/concept-s2-lobby-pixel-16bit.png). Thêm modal và lớp nền tối lên ảnh lobby để so sánh cùng khung.
- Người dùng yêu cầu copy cả bốn example vào docs; trạng thái **tham khảo**, chưa xác nhận concept chuẩn hoặc UI đã hoàn tất.
- File nguồn local: `game/dist/o5-modal-preview/01-confirm.png`, `02-danger.png`, `03-notice.png`, `04-error.png`. Các file trong docs độc lập với dist.
- File đích: [xác nhận thường](./style/screens/o5-modal/examples/01-confirm.webp), [xác nhận nguy hiểm](./style/screens/o5-modal/examples/02-danger.webp), [thông báo một nút](./style/screens/o5-modal/examples/03-notice.webp), [lỗi kết nối](./style/screens/o5-modal/examples/04-error.webp).
- [Prompt đầy đủ](./style/screens/o5-modal/examples/prompts.json) giữ nguyên nội dung đã chạy; ảnh hiển thị trong [đặc tả O5](./style/screens/o5-modal/README.md#ảnh-ví-dụ).
- Mỗi ảnh **853 × 1844 px**. Hậu kỳ: chuyển PNG gốc sang WebP chất lượng 85 (mỗi ảnh ~140 KB thay ~1,75 MB), giữ nguyên kích thước, không crop/chỉnh nội dung.
- Đã kiểm trực quan chữ tiếng Việt, icon, số nút và màu theo vai trò. Giới hạn: kích thước khung/badge, sắc độ chưa khớp tuyệt đối token; nền lobby chỉ để so sánh hình thức, không đại diện luồng Bỏ cuộc trong ván.
- Không dùng ảnh làm asset runtime, không đánh dấu đạt QA runtime. Khi dựng dùng chữ DOM, hệ icon và số đo/token trong docs.

## O5 modal — CSS nút, icon SVG và preview đối chiếu

- Ngày **21–22/10/2026**. Không gọi imagegen, không trace bitmap hoặc nhúng raster.
- Thân nút, focus và khung modal dùng CSS; SVG chỉ dành cho icon. [button.css](./style/screens/o5-modal/svg/button.css): state chung, focus một vòng navy 2px cách 3px, pending, reduced motion, forced colors. Bản nút SVG trước đó bị chồng nhiều viền khi focus nên đã bỏ.
- [9 icon SVG](./style/screens/o5-modal/svg/icons/): check/warning/wifi-off/lock/ken/coins/flag giữ nguyên path từ `assets/icons`; bổ sung info và spinner. Không thay icon runtime.
- [Trang đối chiếu bốn mẫu](./style/screens/o5-modal/css-preview/index.html): khung, badge, icon và nút dựng bằng CSS/HTML; concept S2 chỉ làm phông tham chiếu. [modal.css](./style/screens/o5-modal/css-preview/modal.css) canh riêng theo từng ảnh mẫu, không phải token production.
- [Audit](./style/screens/o5-modal/css-preview/fidelity-audit.md) lưu số đo trước/sau và các phần còn khác. Đã xác nhận Nunito local được sử dụng; không biết metadata font của chữ AI. Chưa giống hoàn toàn và chưa đạt duyệt mỹ thuật.
- Kiểm bốn mẫu ở ba chiều rộng, overlay, pending, focus, reduced motion và forced colors; không JavaScript exception. Ảnh chụp và số đo chỉ chạy local.
- Cập nhật [danh sách màn còn thiếu mẫu](./style/screens/README.md): tám nhóm S3–S5/S7–S11, lớp phủ và trạng thái trong ván. Chưa import vào game.

## App icon

- Ngày **22/10/2026**. Công cụ: **built-in imagegen**, tham chiếu [concept S2](./style/screens/s2-lobby/concept-s2-lobby-pixel-16bit.png) và mascot hiện tại; palette xanh trời/vàng/kem, contour navy. Sinh 10 hướng, chọn 2, các phương án còn lại đã bỏ.
- `assets/app-icons/app-icon.png` (icon chính): bàn cờ kem góc nghiêng với vài ô đỏ/xanh/lục, một quân vàng và một xúc xắc lớn; nền cyan, không chữ. Đã bỏ mascot AI tự thêm và sửa chấm xúc xắc bằng imagegen.
- `assets/app-icons/app-icon-sub.png` (icon phụ): một quân cờ vàng bóng lớn, viên xúc xắc kem tựa chân đế, đứng trên ô đất xanh ngọc nhỏ; nền cyan, không chữ.
- Hậu kỳ: output gốc 1254 × 1254 RGB, resize Lanczos về 1024, cắt bo góc inset 16 / radius 208 có alpha; không chỉnh nội dung artwork. Chưa xuất bộ kích thước store.
