# Asset generation log — Cờ Tỷ Phú

## screens/s2-lobby/concept-s2-lobby-pixel-16bit.png

- Loại: concept màn S2 để tham chiếu mỹ thuật, không phải asset runtime.
- Ngày sinh: 2026-10-20 (Asia/Bangkok), theo prompt set gốc.
- Công cụ sinh: built-in image_gen; không dùng CLI/API fallback.
- Ảnh tham chiếu: [concept S6 đã duyệt](./screens/s6-board/concept-s6-board-pixel-16bit.png), chỉ làm tham chiếu phong cách.
- Lựa chọn: người dùng đã chọn **phương án 1 — Nền trời thoáng** trong ba phương án lobby (Nền trời thoáng / Bảng giấy / Bàn cờ). Chỉ đưa phương án 1 vào docs.
- File nguồn tại workspace: `game/dist/tycoon-lobby-concepts/concept-s2-lobby-pixel-16bit-01-sky.png`; prompt set gốc: `game/dist/tycoon-lobby-concepts/prompts.md`. Các đường dẫn dist là nguồn nháp local, không phải dependency của docs.
- Hậu kỳ khi đưa vào docs: copy nguyên byte và đổi tên theo quy ước màn; không crop, resize, nén lại hoặc chỉnh ảnh.
- Kích thước cuối: **853 × 1844 px**, **2.136.952 byte** (khoảng 2,04 MiB).
- SHA-256: `75dfca89db6812190fb228b0041703b6f687610917a3cbdcc3d5d3e07517cd78`.
- **Ngày 22/10/2026 đã thay file cùng tên bằng bản có nút Chơi với máy** (2.041.789 byte, SHA-256 `18067e0d21367405c1f094db50a99e77b7e87fff8da6d3b89843a9e452049d31`), xem [mục S2 chơi máy](#s2--chốt-nút-chơi-với-máy-và-tách-asset). Các dòng trên và prompt dưới là của bản 20/10, bản đó còn trong commit `9be6d970b`.
- Người duyệt: người dùng, chọn ảnh thứ nhất trong cuộc hội thoại.
- Kiểm tra docs: ảnh đích có cùng hash với nguồn; đủ topbar/logo/mascot/3 thẻ/2 quân/4 action/footer, đã xem ảnh trực tiếp.
- Ngoại lệ production: tên, avatar, số dư, version là mẫu; chữ bằng DOM với Nunito, avatar VIP + `@username`; palette, kích thước và trạng thái theo [style lobby](./screens/s2-lobby/README.md). Concept không yêu cầu alpha và không được tính vào budget asset tải game.
- Trạng thái: **đã chọn concept, đã viết đặc tả**; chưa dựng UI hoặc sinh asset production riêng.

### Prompt đầy đủ của phương án 1

Giữ nguyên prompt gốc để truy vết. Kích thước/nhân vật trong kết quả sinh không khớp hoàn toàn con số của prompt; người dùng chọn ảnh kết quả. Số đo triển khai được cập nhật ở [style S2 lobby](./screens/s2-lobby/README.md), không dùng số cũ trong prompt này làm đặc tả.

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
- Ảnh nền tham chiếu: [concept lobby S2](./screens/s2-lobby/concept-s2-lobby-pixel-16bit.png). Thêm modal và lớp nền tối lên ảnh lobby để so sánh cùng khung.
- Người dùng yêu cầu copy cả bốn example vào docs; trạng thái **tham khảo**, chưa xác nhận concept chuẩn hoặc UI đã hoàn tất.
- File nguồn local: `game/dist/o5-modal-preview/01-confirm.png`, `02-danger.png`, `03-notice.png`, `04-error.png`. Các file trong docs độc lập với dist.
- File đích: [xác nhận thường](./screens/o5-modal/examples/01-confirm.webp), [xác nhận nguy hiểm](./screens/o5-modal/examples/02-danger.webp), [thông báo một nút](./screens/o5-modal/examples/03-notice.webp), [lỗi kết nối](./screens/o5-modal/examples/04-error.webp).
- Ảnh hiển thị trong [đặc tả O5](./screens/o5-modal/README.md#ảnh-ví-dụ).
- Mỗi ảnh **853 × 1844 px**. Hậu kỳ: chuyển PNG gốc sang WebP chất lượng 85 (mỗi ảnh ~140 KB thay ~1,75 MB), giữ nguyên kích thước, không crop/chỉnh nội dung.
- Đã kiểm trực quan chữ tiếng Việt, icon, số nút và màu theo vai trò. Giới hạn: kích thước khung/badge, sắc độ chưa khớp tuyệt đối token; nền lobby chỉ để so sánh hình thức, không đại diện luồng Bỏ cuộc trong ván.
- Không dùng ảnh làm asset runtime, không đánh dấu đạt QA runtime. Khi dựng dùng chữ DOM, hệ icon và số đo/token trong docs.

## O5 modal — CSS nút, icon SVG và preview đối chiếu

- Ngày **21–22/10/2026**. Không gọi imagegen, không trace bitmap hoặc nhúng raster.
- Thân nút, focus và khung modal dùng CSS; SVG chỉ dành cho icon. [button.css](./screens/o5-modal/svg/button.css): state chung, focus một vòng navy 2px cách 3px, pending, reduced motion, forced colors. Bản nút SVG trước đó bị chồng nhiều viền khi focus nên đã bỏ.
- [9 icon SVG](./screens/o5-modal/svg/icons/): check/warning/wifi-off/lock/ken/coins/flag giữ nguyên path từ `assets/icons`; bổ sung info và spinner. Không thay icon runtime.
- Trang đối chiếu CSS bốn mẫu chỉ dùng local, không lưu trong repo. Chưa giống hoàn toàn và chưa đạt duyệt mỹ thuật.
- Cập nhật [danh sách màn còn thiếu mẫu](./screens/README.md): tám nhóm S3–S5/S7–S11, lớp phủ và trạng thái trong ván. Chưa import vào game.

## App icon

- Ngày **22/10/2026**. Công cụ: **built-in imagegen**, tham chiếu [concept S2](./screens/s2-lobby/concept-s2-lobby-pixel-16bit.png) và mascot hiện tại; palette xanh trời/vàng/kem, contour navy. Sinh 10 hướng, chọn 2, các phương án còn lại đã bỏ.
- `assets/app-icons/app-icon.png` (icon chính): bàn cờ kem góc nghiêng với vài ô đỏ/xanh/lục, một quân vàng và một xúc xắc lớn; nền cyan, không chữ. Đã bỏ mascot AI tự thêm và sửa chấm xúc xắc bằng imagegen.
- `assets/app-icons/app-icon-sub.png` (icon phụ): một quân cờ vàng bóng lớn, viên xúc xắc kem tựa chân đế, đứng trên ô đất xanh ngọc nhỏ; nền cyan, không chữ.
- Hậu kỳ: output gốc 1254 × 1254 RGB, resize Lanczos về 1024, cắt bo góc inset 16 / radius 208 có alpha; không chỉnh nội dung artwork. Chưa xuất bộ kích thước store.

## S3 danh sách bàn — Bảng giấy kem

- File: [`screens/s3-room-list/concept-s3-room-list-pixel-16bit.png`](./screens/s3-room-list/concept-s3-room-list-pixel-16bit.png). Concept màn S3, không phải asset runtime.
- Ngày sinh: **2026-10-22**. Công cụ: **built-in imagegen**; không dùng CLI/API fallback.
- Cách sinh: vòng 1 sinh ba hướng (Bảng giấy kem / Thẻ bàn nổi / Khung bàn cờ) theo 02 §S3 cũ. Vòng 2 sửa trực tiếp trên output vòng 1 để thêm cột `KEN` và nút `Xem` theo 11 §1.3, §2.4; đổi nút vào bàn sang vàng `Tham gia`. Vòng 3 sửa riêng header của mẫu 01: `Làm mới` thành nút tròn chỉ có icon, tách khỏi thanh tiêu đề, đối xứng với nút `‹`; phần còn lại giữ nguyên.
- Tham chiếu: lobby S2, bàn chơi S6, icon VIP `vip_003.png`.
- Lựa chọn: người dùng chọn **mẫu 01 — Bảng giấy kem**; docs dùng bản sau vòng 3.
- File nguồn local: vòng 3 ở `C:/Users/phong.nguyen2/.codex/generated_images/01a157a1-ee0d-75d0-ba29-2121c932e7a4/exec-3318e641-da41-485a-83e1-20851736ae47.png`; vòng 2 ở `game/dist/s3-room-list-preview-v2/01-paper-table.png` (prompt đầy đủ của cả ba mẫu ở `prompts.json` cùng thư mục). Các đường dẫn này là nguồn nháp local, không phải dependency của docs.
- Hậu kỳ: copy nguyên byte, đổi tên theo quy ước màn; không crop, resize hay nén lại.
- Kích thước: **853 × 1844 px**, **2.009.419 byte**. SHA-256: `6fafe59a0ccb70279bd27dda3e09254764d0aa42cec6f11565f9e9e0bbc82c82`, trùng output vòng 3.
- Ngoại lệ production: avatar mặt cười, tên, số KEN và số chỗ là mẫu; dùng icon VIP, dữ liệu `ROOM_LIST` và chữ DOM theo [style S3](./screens/s3-room-list/README.md).
- Trạng thái: **đã chọn concept, đã viết đặc tả**; chưa dựng UI.

### Prompt vòng 2 của mẫu 01

Prompt vòng 3 chỉ sửa header như mô tả ở trên.

```text
Use case: precise-object-edit. Asset: high fidelity Vietnamese Cờ Tỷ Phú mobile room-list concept.
Input image is the edit target. Preserve its portrait aspect ratio, sky and pixel city, header/title/back/refresh, footer/create/pagination, decorative framing, nine-row layout, four-column layout, all owners, VIP smiley avatars and all KEN values. Update only the action column and the state styling of the affected rows according to the newly edited spec.
COLUMN HEADINGS verbatim: "Chủ bàn" | "KEN" | "Chỗ" | "Tham gia / Xem". The last heading may use two lines ("Tham gia" above "/ Xem") to fit its existing width, and the header band may grow minimally if needed; do not make illegible tiny type.
ACTION RULES:
- Waiting room with free seats: active gold enamel button labeled exactly "Tham gia". Replace all previous "Vào bàn" labels with "Tham gia".
- Waiting full room: same sized disabled gray button labeled exactly "Tham gia", NOT "Đã đầy".
- Playing room that allows spectators: ACTIVE cream-paper button labeled exactly "Xem", navy outline and text, same size as Tham gia. It must NOT look disabled even though player seats are full.
- Playing room that forbids spectators: a smaller flat pale-blue state chip labeled exactly "Đang chơi" in the LAST COLUMN, no action button, no raised button border.
Render exactly these nine rows:
1 @minhanh | Giao lưu | 2/4 jade | active gold Tham gia
2 @linh with lock | gold crown coin 500 | 1/2 jade | active gold Tham gia
3 @khoa | coin 1.000 | 3/4 jade | active gold Tham gia
4 @trang | coin 2.000 | 4/4 gray | disabled gray Tham gia [waiting full]
5 @nam | coin 5.000 | 4/4 neutral | ACTIVE CREAM Xem [playing, spectators allowed]
6 @ha | Giao lưu | 2/3 jade | active gold Tham gia
7 @tuan with lock | coin 10.000 | 1/4 jade | active gold Tham gia
8 @vy | coin 500 | 3/3 neutral | flat pale-blue Đang chơi CHIP [playing, spectators forbidden]
9 @long | Giao lưu | 2/4 jade | active gold Tham gia
Remove the old blue Đang chơi chip from below @nam; the new Xem action conveys that state. @nam row is normal cream with normal navy name and colored avatar, not dimmed. @vy also has normal navy name and colored avatar, with the noninteractive Đang chơi chip at far right. Only @trang is the full waiting disabled row. Keep all KEN amounts and exact dot separators. Three Giao lưu rows have no coin. Keep avatar style exactly: green Ola smiley wearing crown and red round glasses.
Keep bottom "Tạo bàn" gold with plus, pagination "1 / 3", LEFT pagination arrow disabled light gray and RIGHT arrow active navy. Do not introduce a spectator tab, extra column, eye icon, toggle, new rows, player balances, human avatars, explanatory captions, watermark or phone frame. No old "Vào bàn" or "Đã đầy" labels should remain. Preserve the hybrid art direction: smooth navy-outlined cream/gold UI and pixel Vietnamese background. Exact Vietnamese spelling, clean alignment and spacing, readable rounded bold type.
Variant-specific invariants: Keep single cream paper table with subtle dividers, compact cream title bar and pixel city strip above bottom footer. CHANGE its previous cream join buttons to GOLD Tham gia as required by the new spec; Xem alone remains cream.
```

## S4 và O5 — modal trên nền danh sách bàn

- Ngày **22/10/2026**, công cụ **built-in imagegen**. Theo yêu cầu vẽ modal liên quan sau khi chọn style S3 và sửa reload thành nút icon riêng.
- Đọc code `tycoon/App.tsx`, `NoticeModal`, `ModalHeading`; hai form tạo/vào bàn trong Caro và Xiangqi. Cờ Tỷ Phú chưa có S3/S4 online, nên nội dung bắt buộc theo **02 §S4** và **11**, khung theo O5.
- Sáu output: Tạo bàn mặc định; Tạo bàn có cược + khóa + cho xem; Vào bàn khóa mật khẩu trống; Sai mật khẩu; Chưa đủ KEN; Mất kết nối. [Xem trong style S3](./screens/s3-room-list/README.md#8-modal-trên-danh-sách-bàn-s4-o5).
- Tham chiếu: S3 mẫu 01 sau sửa header làm nền; example xác nhận O5 chỉ làm tham chiếu chất liệu và nút. Hai trạng thái có mật khẩu/lỗi được sửa trực tiếp từ bản form tương ứng để giữ style.
- Lưu cùng folder S3 dưới tên `screens/s3-room-list/modal-0{1..6}-*.webp`. Hậu kỳ: PNG gốc 853 × 1844 chuyển sang WebP chất lượng 85 (tổng 10,1 MB → 764 KB), giữ kích thước, không crop hay chỉnh nội dung.
- Đã xem trực tiếp đủ trường/nút, trạng thái toggle, lỗi, nhãn tiếng Việt và nền S3. Icon/font/avatar là minh họa AI; khi dựng dùng asset gốc, DOM và số đo spec. Không coi ảnh tĩnh là kiểm thử focus, responsive hoặc protocol.
- Trạng thái **đã được người dùng chốt UI cả sáu case ngày 22/10/2026**, theo các điểm docs thắng ảnh ở README S3 §8; chưa tích hợp S4 online. Giữ nguyên sáu ảnh, không sinh thêm concept cho trạng thái cùng kiểu.

## S3/S4 — chuẩn bị icon sau khi chốt UI

- Ngày **22/10/2026**. Không gọi imagegen, không thay đổi sáu ảnh đã duyệt.
- Kiểm file dùng lại: nền `lobby/bg-board-pixel.webp`, đồng KEN `lobby/ill-ken.webp`, icon điều khiển và VIP shared. Bảng đối chiếu ở [S3 §7](./screens/s3-room-list/README.md#7-asset).
- Bổ sung SVG code-native `ic-eye.svg` và `ic-eye-off.svg`, đăng ký trong `TyIcon`. Hình học tham chiếu `web/src/assets/icons/story/visibility.svg`, chuẩn hóa cùng grid 24/stroke 2 của game; bản ẩn dùng thêm nét chéo. Không copy raster mắt từ ảnh AI hoặc Caro.
- Spinner dùng CSS của `NoticeModal`; công tắc, nút, khung và nền biểu tượng dựng bằng CSS, không cần asset raster mới.

### Đính chính sau kiểm trực quan S3/S4

- Ngày **22/10/2026**, theo yêu cầu kiểm kỹ icon với ảnh đã chốt. Mở concept S3 và đủ sáu modal, đối chiếu SVG/path/CSS mask, KEN/VIP và các khóa có sẵn ở Caro/War God. Không gọi imagegen, không sửa ảnh.
- **Chưa đủ artwork đúng mẫu:** khóa vàng hàng bàn chưa có; khóa modal là thân navy đặc khác `ic-lock` outline; reload, back/phân trang, dấu cộng, X theo ngữ cảnh, mắt và cảnh báo có chênh lệch hình/nét/fill. Cặp mắt mới ở trên chưa phải bản giống ảnh.
- Ngoại lệ KEN/wifi O5 và VIP theo docs được giữ nguyên. Lần kiểm file/typecheck trước chỉ chứng minh khả dụng kỹ thuật, không phải duyệt mỹ thuật.
- [Audit đầy đủ](./screens/s3-room-list/asset-audit.md). Không tạo file crop hoặc thay asset production.

## S3/S4 — xuất bộ icon riêng sau audit

- Ngày **22/10/2026**, ảnh tham chiếu là danh sách bàn S3 và modal S4/O5.
- Built-in imagegen, mỗi icon ba vòng: khóa vàng, dấu cộng cam (giữ) và reload (bỏ). [PNG nguồn](../assets/screens/room-list/README.md). Bản chọn giữ nguyên byte; chỉ trim lề trong suốt, resize và xuất WebP lossless.
- Reload imagegen có viền xanh dương chói, đầu mũi tên tù và hai cung gần khép kín, nên vẽ lại bằng SVG: hai cung có khoảng hở, đầu nhọn, viền navy.
- SVG riêng: reload, khóa đặc, cảnh báo, hai chevron × hai trạng thái, X đậm/mảnh; màu theo token navy `#1f2a44`, coral `#e4573d`, kem `#fff8ea`. Mắt mật khẩu không tách bộ riêng: `ic-eye` / `ic-eye-off` đổi sang mắt đặc. Tổng [11 file runtime](../assets/room-list/README.md), dùng `RoomIcon`.
- Đã so từng icon với chi tiết ảnh mẫu phóng lớn và cỡ thật; [audit](./screens/s3-room-list/icon-export-audit.md). Khóa vàng và dấu cộng còn lệch nhỏ; mắt gạch và trang sau disabled không có ảnh mẫu riêng.
- Trạng thái: đã xuất để review, chưa duyệt asset và chưa lắp màn online.

## S2 — chốt nút Chơi với máy và tách asset

- Ngày **22/10/2026**, người dùng chốt bản xanh ngọc v4, giữ topbar đúng docs: VIP + @username; số dư rồi đồng K bên phải, bỏ chữ KEN. Ảnh này **thay** [concept S2](./screens/s2-lobby/concept-s2-lobby-pixel-16bit.png) cùng tên.
- Built-in imagegen sinh v4: đầu vào là bản v3 sửa topbar (theo screenshot runtime: VIP 3, @minhanh, 12.500 rồi đồng K) và bản v2 chỉ làm tham chiếu màu mint/robot. Output `exec-307eb17f-982d-4cdd-839d-c0b0695c0935.png`, giữ nguyên byte 853 × 1844. Các bản thử đã dọn, không dùng làm chuẩn.
- Tách hai PNG alpha `icon-bot.png` và `button-mint.png`; người dùng xác nhận cần nền nút không chữ, không phải ô nhập liệu. [Prompt, kiểm alpha, giới hạn và cách dùng](../assets/screens/lobby/prompts.md#chơi-với-máy-2026-10-22); metadata/hash trong manifest.
- Đã xuất `lobby/ill-bot.webp` (104 × 90, 3.642 byte, cùng thông số các `ill-*`) và gắn nút vào sảnh. Nền nút dựng bằng CSS theo `button-mint.png`, chữ là DOM. Các phần khác dùng lại asset đang có.

### Prompt concept v4

```text
Use case: precise-object-edit.
Two inputs:
IMAGE 1 is the EDIT TARGET and authoritative entire screen: current-style Cờ Tỷ Phú lobby with correct VIP/@username/K balance topbar and a lavender robot button.
IMAGE 2 is ONLY a COLOR AND ROBOT REFERENCE for its mint-green "Chơi với máy" button. Absolutely do not use image 2's outdated topbar, font, hero or other layout.

Edit IMAGE 1: replace its lavender "Chơi với máy" button with the mint jade-green button style from IMAGE 2. Match that appealing mint face: pale mint #A4F4CF at top to jade #51D9A3 lower face, deeper jade #299B79 bottom bevel, single navy outline #1F2A44, one small upper-left highlight. Remove lavender completely from this button. Replace the white/gold robot with the blue/white friendly robot head from IMAGE 2: blue antenna and earpieces, rounded blue outer case, white face, two navy eyes and smile, small highlights. Keep robot inside button with sufficient padding. Restore the prior mint-button look, not a new design.
Button is directly below Vào bàn, above Lịch sử. Keep image 1's current rounded Nunito typography, navy exact text "Chơi với máy". Center icon and label as one group. Match width of other buttons and match secondary button height (Lịch sử), about 56 CSS pixels; robot ~40 CSS pixels, no protruding antenna. Keep the same upper edge position and comfortable gap below it, don't move other actions. Avoid two bright blobs at either end or large white highlight strips; use the quieter highlight from image 2.

CRITICAL KEEP FROM IMAGE 1: topbar left green Ola VIP face with crown and red glasses, exact lowercase "@minhanh"; balance exact "12.500" THEN gold coin with white letter K on the RIGHT, no "KEN" suffix, no coin before amount, no crown coin, no human portrait, no "Minh Anh". Preserve image 1 font, cream pills, navy outlines, sound icon and all topbar alignment. Keep ALL other pixels/content as closely unchanged as possible: logo, character, property cards and pawns, golden Vào bàn, cream Lịch sử and Bảng xếp hạng, underlined Luật chơi, footer Thoát game, sky and city. Gold Vào bàn remains the large primary action. Output one full portrait screen matching image 1 dimensions/aspect. No annotations, extra buttons, badges, version or frame.
```

## S2 — modal Chơi với máy

- Ngày **23/10/2026**, công cụ **built-in imagegen**, người dùng làm theo [02 §2.3](./02-screen-specs.md#23-modal-chơi-với-máy-botsetupmodal). Bản trước (mỗi bot hai dòng, nút thùng rác) đã bỏ; bản dùng là mỗi bot một hàng với nút `−`.
- Ba bot: `exec-a2d70def-f6eb-4350-9ccd-bdcaff07e43c.png`, sửa từ bản hai dòng. Một bot: `exec-0191154b-ed25-4737-a188-e836788eb790.png`, sửa từ bản ba bot mới. Tham chiếu: concept S2, `icon-bot.png`, VIP 001/002/003.
- File đích: [`modal-bot-01-one-bot.webp`](./screens/s2-lobby/modal-bot-01-one-bot.webp), [`modal-bot-02-three-bots.webp`](./screens/s2-lobby/modal-bot-02-three-bots.webp), hiện ở [S2 §11](./screens/s2-lobby/README.md#11-modal-chơi-với-máy). Hậu kỳ: PNG gốc 935 × 1683 (SHA-256 `af37ab07…` / `453a4f61…`) chuyển WebP chất lượng 85, giữ kích thước, không crop hay chỉnh nội dung (3,15 MB → 220 KB).
- Đã kiểm: hàng ngang không có thùng rác, nút `−` xám khi còn 1 bot và coral khi có 3, robot ở header, `1/3 bot` / `3/3 bot`, tổng người, 30 vòng / 25 phút / 30 giây, Hủy/Bắt đầu. Chỗ docs khác ảnh ở S2 §11.
- Trạng thái: ảnh mẫu; đã dựng UI ngày 23/10/2026 (`components/BotSetupModal.tsx`).

### Asset bổ sung lần đầu — v1 (23/10/2026)

- Thiếu hình hai người và các bản artwork cộng/trừ tròn có trạng thái xám. Đã vẽ **5 SVG hình học** ở [`assets/bot-setup/`](./screens/s2-lobby/README.md#asset-của-modal): `users-blue.svg`, `plus-circle.svg`, `plus-circle-disabled.svg`, `minus-circle.svg`, `minus-circle-disabled.svg`. Nguồn hình là hai concept ở trên, màu dấu cộng/trừ theo token game; không gọi imagegen cho lượt này, không tải thư viện ngoài.
- Giữ nguyên robot `ill-bot.webp`, VIP 001–003 và `room-list/close-bold.svg`. Khung paper, divider mint/beige, pill mức độ, nền nút, nền tròn X, khối tóm tắt và backdrop dựng CSS; chữ là DOM. [Inventory](./screens/s2-lobby/README.md#asset-của-modal) ghi đủ từng phần và cách dùng.
- SVG mới là asset riêng nhiều màu, không phải mask `TyIcon`; có khoảng trong suốt ngoài hình. Chưa tích hợp UI modal, không coi việc xuất asset là duyệt bố cục runtime.

### Sửa asset theo audit — v2 (23/10/2026)

- Người dùng yêu cầu sửa các sai lệch sau lượt đối chiếu. Đã sửa 5 SVG v1: cộng xanh ngọc, trừ coral đỏ hồng, hai sắc xám disabled riêng, vai/thân và cặp xanh của hai người. Bổ sung `close-navy.svg` theo màu X của modal; không thay icon X của S4.
- Vẽ thêm 4 nền nút **SVG không chữ/icon**: `button-mint.svg`, `button-mint-disabled.svg`, `button-paper.svg`, `button-gold.svg`. Mặt mint nhẹ/viền jade, paper viền beige không dải xanh, gold phản sáng góc trái. Không sửa PNG lobby; gói v2 dùng nền modal mới.
- Cả 10 SVG là hình học code-native, không gọi imagegen, không chỉnh bitmap. Màu đo trực tiếp từ hai concept; palette là ngoại lệ riêng modal, 02 §2.3 đã đồng bộ viền jade của Thêm bot. Robot và VIP giữ nguyên nguồn gốc.
- [Inventory v2](./screens/s2-lobby/README.md#asset-của-modal) / [audit sau sửa](./screens/s2-lobby/asset-audit.md#6-modal-chơi-với-máy--asset-v2): đối chiếu đủ 14 cặp ảnh, màu 6 vùng icon lệch tối đa 1 đơn vị mỗi kênh RGB tại các vùng mẫu đã đo. Vector không tái tạo nhiễu/texture AI. Chưa tích hợp modal runtime.

### Prompt ba bot

```text
Use case: precise-object-edit. Edit this supplied Vietnamese Cờ Tỷ Phú THREE-BOT setup screenshot. Requested changes: EACH BOT AND ITS DIFFICULTY SELECTOR MUST BE ON ONE SINGLE HORIZONTAL ROW; REPLACE ALL TRASH BUTTONS WITH ROUND MINUS BUTTONS.
Preserve established cream paper/gold/mint visual style, exact blue robot in title "Chơi với máy", close X upper right, informational "Danh sách bot" and "3/3 bot", dimmed lobby background and correct topbar. Preserve portrait853x1844 proportions.
Redesign the bot-list portion into EXACTLY THREE compact rows, about60 CSS pixels high each, separated by thin beige dividers. Each row's sequence left-to-right, all centered vertically:
[small24px green VIP avatar] [Bot 1] [Dễ | Thường | Khó segmented pill] [coral circular button with white MINUS "−"].
Rows2 and3 same geometry, names Bot 2 and Bot 3, same respective VIP avatar from the source. Shrink the previously huge avatars to fit this single line. Do NOT place level choices below name. Do NOT add separate "Mức độ" lines. Each row fits the existing panel width, not clipped, use clear rounded Nunito text; don't abbreviate "Thường". Make middle segment slightly wider if needed.
Selections: Bot1 "Thường" gold; Bot2 "Dễ" gold; Bot3 "Khó" gold. Unselected segments cream/navy. The three minus buttons are ACTIVE CORAL circles, white horizontal dash, NOT trash, NOT X, NOT plus. The top-right modal CLOSE remains X.
Because rows are shorter, shorten/recenter the whole dialog naturally to around500 CSS px tall, eliminate the unused vertical spaces; keep all content well spaced.
Below the three rows keep disabled gray "+ Thêm bot", then "Đã đủ 3 bot". Preserve pale-blue summary "Ván 4 người: bạn và 3 bot" and exact hint "Tối đa 30 vòng hoặc 25 phút, mỗi hành động 30 giây. Máy đi tự động." Footer cream "Hủy" LEFT, gold "Bắt đầu" RIGHT.
No bot-count picker, no dropdown levels, no second line per bot, no trash icons anywhere, no new features/text, no English, no watermark or frame. This is a precise compact-layout revision of the existing selected design.
```

### Prompt một bot

```text
Use case: precise-object-edit. Edit the provided UPDATED inline-row bot setup screenshot into its initial ONE-BOT state. Preserve exactly this cream/gold/mint UI design and single-line row geometry.
Keep header BLUE ROBOT icon + Vietnamese title "Chơi với máy" + close X, all same style. Keep dimmed lobby background and topbar.
Change count "3/3 bot" to "1/3 bot". Keep ONLY Bot 1, REMOVE rows Bot2 and Bot3 completely. Bot1 stays ONE SINGLE ROW: [small green VIP avatar] [Bot 1] [Dễ | Thường | Khó segmented pill, Thường gold] [CIRCULAR MINUS BUTTON]. The minus is now DISABLED GRAY with a white horizontal dash. Never trash-can, never X in this row. Do not put difficulty on a second line, no extra "Mức độ" label.
Change the add control to ACTIVE mint-green full-width "+ Thêm bot" immediately below Bot1. Remove "Đã đủ 3 bot" helper entirely because there is room to add.
Change summary to exactly "Ván 2 người: bạn và 1 bot". Keep hint exactly "Tối đa 30 vòng hoặc 25 phút, mỗi hành động 30 giây. Máy đi tự động."
Footer retains cream "Hủy" left and GOLD "Bắt đầu" right, equal width. Shorten and vertically center modal to content naturally, do not leave empty space where deleted bots were. Keep all controls inside and comfortably spaced. Preserve same portrait canvas/aspect, visual finish, font and icon details. No quantity picker, no extra features, no English.
```

## S2 — thiết kế lại Hướng dẫn chơi (23/10/2026)

- Theo yêu cầu làm lại UI, dùng skill imagegen và công cụ built-in `image_gen`. Nguồn tham chiếu: concept lobby S2, modal chơi máy 1 bot và `lobby/ill-rules.webp`. Đọc RulesModal, constants và 05 để giữ đúng luật.
- Output Cơ bản đầu `exec-c803b2d4-0acc-4c5c-90ff-7e4d4ac2a53d.png` (không dùng làm chuẩn); Tài sản `exec-71e8e0c6-0876-4dca-80d0-d3c0517e7a10.png` sửa từ Cơ bản đầu; Cơ bản sửa gieo đôi thành 3–3 `exec-f4f89f9e-6386-45cc-89b3-20221f554d67.png`; Ô đặc biệt `exec-8e20ead8-81d3-4496-9cbe-e784a310ad88.png` sửa từ Tài sản; Kết thúc `exec-b6eb3989-26bb-4aca-b980-0da1e93345d1.png` sửa từ Cơ bản bản cuối.
- Prompt đầy đủ của 4 ảnh chuẩn (`concepts[].prompt`) và bản Cơ bản đầu (`conceptHistory`) lưu trong [manifest](../assets/screens/rules-guide/manifest.json).
- Đã kiểm chữ/số chính, nhãn và trạng thái tab, topbar VIP/@username/số rồi đồng K, X/Đã hiểu và minh họa gieo đôi. Ảnh chỉ minh họa copy rút gọn; nội dung đầy đủ ở [S2 §12](./screens/s2-lobby/README.md#nội-dung).

### Chốt concept và tách 18 minh họa (23/10/2026)

- Người dùng chốt cả bốn ảnh và yêu cầu lấy từng asset. Bốn ảnh chuẩn lưu tại `screens/s2-lobby/rules-0{1..4}-*.webp`, WebP q85 đổi từ PNG output nguyên byte (hash PNG gốc ở `concepts[].sourcePng`).
- Dùng skill imagegen, **built-in `image_gen`**, một lần cho từng minh họa, tham chiếu đúng ảnh tab và `transparent_background=true`. 18 PNG nguồn ở `assets/screens/rules-guide/`; [manifest](../assets/screens/rules-guide/manifest.json) ghi prompt đầy đủ, output ID, kích thước, SHA-256, alpha, nguồn concept, crop đối chiếu và khác biệt từng ảnh.
- 17 ảnh 1254 × 1254, một ảnh cạnh bàn 1536 × 1024. Chép nguyên byte output, không chỉnh bitmap; 18/18 có alpha thật. Đã kiểm đủ chủ thể/ký hiệu và xem ở 136/48 px trên kem, navy, ô caro. Một số nét, góc nhìn và highlight khác concept; không phải crop trùng pixel.
- Sách header dùng lại `lobby/ill-rules.webp`; X dùng `bot-setup/close-navy.svg`. Nền modal/tab/card/pastel, divider và nút thuộc CSS; chữ/số thuộc DOM.

### Xuất runtime và dựng RulesModal (23/10/2026)

- Xuất 18 `assets/rules/ill-*.webp`: cắt theo alpha > 8, Lanczos, đệm trong suốt 4 px, 96 px cạnh dài (ba hình điều kiện thắng 128 px), `cwebp -q 80 -alpha_q 90 -m 6`; tổng khoảng 72 KB. Thông số ghi ở `runtimeExport` và `assets[].runtime` trong manifest.
- Dựng `RulesModal` 4 tab theo [S2 §12](./screens/s2-lobby/README.md#12-hướng-dẫn-chơi--đã-chốt-4-tab); chụp đối chiếu cả 4 tab ở 390 × 844 và 360 × 640, kiểm phím tab, Escape/Đã hiểu trả focus về nút Luật chơi.

## S11 — Mint tối giản đã chốt (23/10/2026)

- Người dùng chọn **mẫu 02**; ảnh chuẩn ở [S11](./screens/s11-leaderboard/README.md). Concept built-in `image_gen`, output `exec-c81e15cd-9aba-4df8-91a9-7882f397730a.png`, 853 × 1844, giữ nguyên byte PNG. Prompt và hash lưu trong [manifest nguồn](../assets/screens/leaderboard/manifest.json).
- Đã dọn hai style không chọn, bản hai tab cũ, trang so sánh và các script/brief nháp trong output. Giữ docs hành vi mới gồm 3 tab, thắng/trận, EXP tích lũy, chip Lv và hàng me ghim; chưa dựng runtime hoặc sửa server.
- Huy chương được tách riêng bằng built-in `image_gen` với alpha thật; mặt trống để ghép số DOM. Icon header/quay lại/nền/avatar dùng lại, các surface co giãn bằng CSS. Chi tiết file, nguồn và kiểm tra ở [bộ asset](../assets/leaderboard/README.md).

- Đã xuất 3 WebP cao 96 px, q90/alpha100, tổng **11.880 byte**. Kiểm PNG nguyên byte, alpha thật, crop/export và ghép số DOM ở rộng 36 px trên kem/mint/navy; highlight/viền có khác biệt tái dựng nhỏ ghi trong README asset. PNG nguồn 1254 × 1254; metadata và output ID của ba lượt tách trong manifest.
