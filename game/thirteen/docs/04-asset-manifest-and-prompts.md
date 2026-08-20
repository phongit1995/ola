# 04 — Asset manifest and generation prompts

## 1. Chiến lược asset

Style 02 không dùng asset raster cho button, panel, border hoặc background toàn màn. Phân loại:

- **CSS**: fill, border, radius, shadow, layout, curve đơn giản, pattern nếu đủ chính xác;
- **SVG code-native**: icon chức năng, suit mini, FX tia, pattern tile;
- **existing raster**: 52 mặt bài + `back.webp`, reaction/VIP assets đang có;
- **generated raster**: chỉ dùng cho concept hoặc asset minh họa thật sự cần bitmap; mặc định là không có.

Mục tiêu production:

- asset Style 02 mới tải ban đầu ≤160 KB gzip/brotli ngoài font;
- không có một ảnh background full-screen;
- không có text trong asset;
- icon SVG cùng viewBox/stroke;
- mọi màu SVG dùng `currentColor` hoặc token CSS khi hợp lý.

## 2. Quy tắc đặt tên

```text
game/thirteen/assets/
  icons/ic-{name}.svg
  patterns/pat-{name}.svg
  fx/fx-{name}.svg
```

- kebab-case;
- prefix `ic-`, `pat-`, `fx-`;
- không thêm hậu tố `final`, `new`, `v2` vào production;
- version nằm trong git/log, không nằm trong filename;
- SVG không chứa metadata editor thừa hoặc embedded raster.

## 3. Manifest tổng

| ID | File/implementation | Type | ViewBox/size | Mục đích | Load |
|---|---|---|---|---|---|
| IC-01 | `icons/ic-back.svg` | SVG | 24 | quay lại/rời màn | initial |
| IC-02 | `icons/ic-chat.svg` | SVG | 24 | mở chat | table |
| IC-03 | `icons/ic-refresh.svg` | SVG | 24 | refresh room list | lobby |
| IC-04 | `icons/ic-lock.svg` | SVG | 16/24 | phòng khóa/input | lobby |
| IC-05 | `icons/ic-close.svg` | SVG | 24 | đóng sheet/modal | conditional |
| IC-06 | `icons/ic-send.svg` | SVG | 24 | gửi chat | conditional |
| IC-07 | `icons/ic-user-minus.svg` | SVG | 24 | kick member | room |
| IC-08 | `icons/ic-crown.svg` | SVG | 24 | chủ bàn | room |
| IC-09 | `../../../web/src/assets/icons/apps/ken.png` | existing PNG | 15/22/26 | Ken balance, room bet, bet input | existing |
| IC-10 | `icons/ic-wifi-off.svg` | SVG | 24 | disconnect | table |
| IC-11 | `icons/ic-check.svg` | SVG | 24 | ready/selected | shared |
| IC-12 | `icons/ic-plus.svg` | SVG | 24 | tạo bàn/seat trống | shared |
| IC-13 | `icons/ic-warning.svg` | SVG | 24 | error/warning | conditional |
| IC-14 | `icons/ic-cards-empty.svg` | SVG | 64 | empty room list | lobby |
| SU-01 | `icons/suit-club.svg` | SVG | 16 | logo decor | lobby |
| SU-02 | `icons/suit-diamond.svg` | SVG | 16 | logo decor | lobby |
| SU-03 | `icons/suit-heart.svg` | SVG | 16 | logo decor | lobby |
| SU-04 | `icons/suit-spade.svg` | SVG | 16 | logo decor | lobby |
| PT-01 | `patterns/pat-woven-diamond.svg` | SVG tile | 24×24 | texture chiếu | initial |
| FX-01 | `fx/fx-chop-rays.svg` | SVG | 160 | chặt bài | table |
| FX-02 | CSS keyframes | CSS | — | deal/play/select | table |
| FX-03 | CSS confetti optional | CSS/SVG | — | thắng | result lazy |
| CD-01 | existing `assets/cards/*.webp` | WebP | existing | mặt bài | existing |
| CD-02 | existing `assets/cards/back.webp` | WebP | existing | lưng bài | existing |

Tổng asset Style 02 mới bắt buộc: 19 SVG (13 icon chức năng, 4 suit, 1 pattern và 1 chop FX) + 1 Ken PNG vàng chính thức tái sử dụng từ Web. FX confetti là optional. Không tạo skin button/panel raster và không tạo lại coin Ken.

## 4. Specification SVG

### 4.1 Icon 24

- `viewBox="0 0 24 24"`;
- `fill="none"` trừ hình cần fill rõ;
- `stroke="currentColor"`;
- `stroke-width="2"`;
- `stroke-linecap="round"`;
- `stroke-linejoin="round"`;
- safe inset 2 px;
- optical center, không chỉ mathematical center;
- path precision tối đa 2 decimal;
- không filter/drop-shadow trong SVG.

### 4.2 Icon 16

- viewBox 16;
- stroke 1.5;
- detail tối thiểu;
- lock/suit không có nét nhỏ dưới 1.25 source unit.

### 4.3 Pattern

`pat-woven-diamond.svg`:

- viewBox 0 0 24 24;
- transparent background;
- path `currentColor` hoặc teal token;
- stroke 1;
- opacity đặt ở CSS 0.035–0.05, không bake opacity nhiều cấp;
- seamless ở cả bốn cạnh;
- không có hạt/noise.

### 4.4 Chop rays

- viewBox 160 × 160;
- 8 tia bất quy tắc có kiểm soát quanh tâm rỗng 72 px;
- stroke coral/sun qua CSS class hoặc `currentColor`;
- stroke 4–6, rounded cap;
- không chữ, không starburst dày, không glow;
- SVG có thể chứa hai group để đổi hai màu.

### 4.5 App icon đã chốt

`assets/app-icons/app-icon-01-card-fan` là icon duy nhất: quạt ba lá với quân 2 cơ ở trung tâm. Thư mục chứa SVG nguồn và PNG master 1024 × 1024 cùng tên. PNG được cắt đúng theo mép ngoài viền navy: inset 16 px, outer radius 208 px; toàn bộ vùng ngoài viền có alpha trong suốt thật. Nội dung chính nằm trong safe area 96 px, vẫn đọc được ở 48 px. Chỉ dùng fill phẳng, outline navy và palette Style 02; không dùng ảnh sinh AI, texture raster, 3D, glow hoặc chi tiết ngẫu nhiên.

## 5. CSS component manifest

Các phần sau là code, không phải asset file:

| ID | Component | CSS bắt buộc |
|---|---|---|
| CS-01 | page background | cream fill |
| CS-02 | mat background | aqua fill + pattern mask/tile |
| CS-03 | mat curve | pseudo-elements coral/cream/navy |
| CS-04 | icon button | cream, navy border, radius 12, shadow |
| CS-05 | primary button | sun gradient, navy border, radius |
| CS-06 | secondary button | cream, navy border |
| CS-07 | soft/disabled button | aqua/cream semantic fills |
| CS-08 | balance pill | pill layout |
| CS-09 | room row | cream card, outline, grid |
| CS-10 | modal/backdrop | cream panel + navy overlay |
| CS-11 | capacity segment | selected state |
| CS-12 | seat card | occupied/empty/owner |
| CS-13 | chat panel | cream panel/bottom sheet |
| CS-14 | avatar | hash gradient + rings |
| CS-15 | turn ring | conic-gradient |
| CS-16 | nameplate | cream pill |
| CS-17 | status badge | semantic variants |
| CS-18 | table trick zone | transparent/dashed outline |
| CS-19 | toast | cream + semantic stripe |
| CS-20 | result panel/row | modal + ranking variants |

## 6. Base prompt cho mockup toàn màn

Prompt chỉ dùng để tạo **ảnh tham khảo**, không dùng output nguyên khối trong production.

```text
Create a polished portrait mobile game UI mockup for Vietnamese Tien Len Mien Nam.
Visual direction: “Chieu Bai Ngay Vui”, a bright contemporary Vietnamese card-mat design.
Use a warm cream page background, a large fresh aqua woven playing mat, deep navy typography
and consistent 2 px navy outlines, sunny yellow primary actions, and restrained coral festival
accent curves. The visual language is flat, clean, friendly and systematic, with rounded geometry,
very subtle woven diamond texture and short downward shadows only. Use exact, repeated component
geometry and crisp spacing as if built from a production design system. Keep the cards as the
clearest content. No environmental illustration. No text baked into reusable assets.

Avoid dark themes, night streets, architecture, wood, felt, brass, ivory parchment, casino gold,
3D bevels, glossy plastic, photoreal materials, glassmorphism, neon, glow, vignette, fantasy,
ornamental frames, random badges, uneven outlines, distorted letters, invented controls,
extra labels, decorative signs, logos, watermarks and AI-like texture noise.
```

## 7. Prompt lobby concept

```text
Use case: mobile game lobby UI mockup, portrait 390 by 844 logical layout.

Design the lobby for Vietnamese Tien Len Mien Nam in the approved “Chieu Bai Ngay Vui” style.
Top 20 percent is warm cream. The lower area is a fresh aqua woven mat separated by one broad
festive curve made from a coral line, a cream gap and a thin navy-teal line. At the top, place a
simple cream square back button with a consistent navy outline, and a cream balance pill with
a colorful circular initial avatar, live currency number and the existing official Ken icon.

Center the typographic game title directly on the cream background, with large deep navy
“TIEN LEN” and a smaller coral “MIEN NAM”, plus only four tiny suit marks. Below the curve,
place one wide sunny yellow primary CTA and one wide cream secondary CTA. Then a flat room-list
header with a refresh icon and a vertical list of reusable cream room rows. Every row has the
same exact radius, outline and shadow, containing a colored initial avatar, room information,
seat dots, an official Ken icon with the wager amount, and a compact action button. The wager
must remain visible even when its value is zero.

Flat systematic UI, 2 px navy outlines, radius scale 12/16/20, short downward shadows,
crisp Vietnamese text placeholders, generous spacing, no scene illustration and no decorative frame.

Do not add wood, metal, lanterns, buildings, night lighting, casino motifs, 3D bevels, glow,
random ornament, extra UI, misspelled labels, background signs or text inside reusable skins.
```

## 8. Prompt table concept

```text
Use case: mobile card-table gameplay UI mockup, portrait 390 by 844 logical layout.

Design a Vietnamese Tien Len Mien Nam gameplay screen in the approved bright flat
“Chieu Bai Ngay Vui” system. Use a warm cream top bar with a cream back button, centered title
and cream chat button, all with consistent deep navy 2 px outlines. Below it, use a large fresh
aqua woven playing mat bounded by a coral, cream and navy curved stripe at the top and bottom.

Arrange three opponent pods around the top, left and right. Each pod is only a colored circular
initial avatar, a cream pill nameplate and a tiny fanned card-back stack with a live card count.
No large pod panel. Place played cards in a clear central zone with an optional subtle cream dashed
rounded outline and a small cream owner chip. Put the local avatar above a readable fanned hand
of real playing cards. At the bottom place two equal action buttons: cream secondary and sunny
yellow primary. Use navy text, short shadows, precise repeated geometry and no excessive decoration.

The card faces must be the visual focus. Keep rank and suits crisp. Do not invent cards, names,
counts, buttons, panels or environmental objects. No oval 3D casino table, wood rim, dark felt,
gold trim, glow, bevel, vignette, fantasy, architecture or background text.
```

## 9. Prompt các màn chưa có concept

### 9.1 Phòng chờ

```text
Create a portrait mobile waiting-room UI using the exact approved Chieu Bai Ngay Vui design system:
warm cream top bar, fresh aqua woven mat, navy 2 px outlines, sunny yellow primary action and coral
micro-accents. Show a two-column grid of four reusable cream seat cards. Occupied cards contain a
flat color initial avatar, live name and a small status badge. Empty cards use a navy dashed outline
with a centered plus. Add one cream chat panel and two bottom actions. Maintain exact repeated
geometry, generous spacing and code-native flat surfaces. No text baked into assets, no illustration,
no wood, metal, 3D, glow, fantasy or extra controls.
```

### 9.2 Modal tạo bàn

```text
Create one centered mobile dialog in the Chieu Bai Ngay Vui design system on a translucent navy
backdrop. The dialog is a warm cream rounded rectangle with one consistent navy 2 px outline,
a short soft shadow, a live title, three flat capacity segments, one password input and two actions.
The confirm action is sunny yellow and the cancel action is cream. Use strict radius and spacing
tokens, readable navy typography, flat SVG icons only. No decorative plaque, frame, bevel, texture,
ornament, generated text or extra fields.
```

### 9.3 Kết quả

```text
Create a bright flat mobile result dialog for Tien Len Mien Nam in the Chieu Bai Ngay Vui system.
Warm cream panel, navy 2 px outline, radius 24, a small coral underline below the live result title,
and four consistent flat ranking rows. First place uses a restrained sunny tint, the local player
uses an aqua tint, and last place uses a very light coral tint. Add cream and sunny actions at the
bottom. Use live text placeholders, exact repeated geometry, no ribbon, medal, trophy, 3D gold,
confetti overload, glow or ornate frame.
```

## 10. Prompt icon SVG

Nên vẽ icon bằng vector/editor hoặc code. Nếu dùng công cụ sinh hình để lấy ý tưởng:

```text
Create a coherent set of minimal monoline mobile UI icons on a transparent background:
back arrow, chat bubble with three dots, refresh arrow, lock, close, send, user minus, crown,
wifi off, check, plus and warning. Friendly rounded geometry, exact 24 by 24 viewBox
logic, deep navy single-color strokes, 2 unit stroke, round caps and joins, no fill except where
structurally necessary. Consistent optical weight and center. No labels, shadows, gradients,
3D, texture, decorative frame or multiple colors. Do not generate a coin icon; reuse the official
yellow Ken PNG supplied by the product.
```

Lưu ý: output bitmap/vector từ model phải được redraw thành path sạch; không dùng auto-trace thô làm production.

## 11. Prompt pattern

```text
Create a perfectly seamless 24 by 24 vector tile suggesting a simplified Vietnamese woven mat.
Use only thin geometric diagonal lines forming a calm diamond weave, uniform 1 unit stroke,
transparent background and one flat teal color. Extremely subtle, low density, no noise, no fiber,
no photoreal texture, no gradients, no ornament, no center motif and no visible seam.
```

Production pattern nên được dựng lại bằng SVG code theo spec mục 4.3.

## 12. Negative prompt chuẩn

```text
dark UI, night, street, house, architecture, lantern, timber, wood grain, lacquer, antique brass,
aged paper, dark felt, casino, poker chips, betting, roulette, gold frame, carved ornament,
photoreal material, skeuomorphism, 3D bevel, embossed text, glossy plastic, glassmorphism,
neon, cyberpunk, glow, bloom, vignette, fantasy, palace, dragon, phoenix, generic gradient app,
random decoration, inconsistent radius, uneven stroke, thick black outline, extra buttons,
invented icons, misspelled Vietnamese, text baked into assets, logo, watermark, signature,
AI artifacts, noisy texture, malformed cards, duplicated cards, incorrect suits
```

## 13. Hướng dẫn dùng ảnh tham chiếu

Khi edit/generate:

- Style 02 lobby/table concept là **style and layout reference**;
- screenshot chức năng là **state and content reference**;
- nói rõ ảnh nào giữ bố cục, ảnh nào giữ màu;
- không để model tự quyết định text;
- nếu cần mockup chính xác, xóa text output và dựng text thật sau;
- không dùng output screen để cắt button/panel production vì hình học sẽ không nhất quán.

## 14. Export SVG

Trước commit:

- remove width/height cứng nếu component cần CSS size;
- giữ viewBox;
- convert color sang `currentColor` khi chỉ một màu;
- remove XML comments, generator metadata, hidden layers;
- SVGO nhưng không làm biến dạng path;
- kiểm tra ở 16/20/24/32 px;
- kiểm tra high contrast và dark browser forced colors nếu cần;
- tổng file icon thường <2 KB sau optimize.

## 15. Export optional raster

Nếu sau này có raster:

- master PNG lossless có alpha;
- runtime WebP lossless hoặc AVIF nếu pipeline hỗ trợ;
- không JPEG;
- cung cấp 1x/2x nếu kích thước CSS cố định;
- không white fringe;
- không bake shadow nếu shadow phải đổi theo state;
- ghi rõ crop, alpha, color profile sRGB và intended CSS size trong log.

## 16. Acceptance từng asset

- [ ] ID và path đúng manifest;
- [ ] không chữ;
- [ ] không embedded raster trong SVG;
- [ ] viewBox và stroke đúng;
- [ ] màu dùng currentColor/token;
- [ ] optical center đúng;
- [ ] icon cùng family không lệch weight;
- [ ] pattern seamless ở 4 cạnh;
- [ ] asset đọc được ở target size;
- [ ] không dấu vết AI/auto-trace răng cưa;
- [ ] license/source/prompt được ghi log;
- [ ] không trùng chức năng asset đã có.
