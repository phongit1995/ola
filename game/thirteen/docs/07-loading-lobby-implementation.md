# 07 — Triển khai loading/lobby và cách cắt asset

## 1. Phạm vi đã triển khai

Hai state production đã được chuyển sang Style 02 — Chiếu Bài Ngày Vui:

- `connecting`: nền kem, ellipse chiếu aqua, ba lớp viền coral/cream/navy, brand live text và progress dot;
- `lobby`: topbar kem, curve chuyển nền, CTA vàng, nút phụ kem, room list, empty state, modal tạo bàn, modal mật khẩu và confirm/notice khi đang ở lobby.

Luật game, store, bridge, socket, ghép bàn và preload bộ bài không đổi. React vẫn render toàn bộ tên, số Ken, trạng thái, số ghế và label; không có text nào nằm trong ảnh.

## 2. Quyết định cắt asset

Không cắt concept thành một ảnh nền lớn và không cắt button/panel thành PNG. Mỗi thành phần được phân loại như sau:

| Thành phần nhìn thấy | Production implementation | Lý do |
|---|---|---|
| nền kem | CSS `background-color` | co giãn tuyệt đối, không cần asset |
| mảng chiếu aqua | CSS ellipse/pseudo-element | giữ curve đúng ở 360–520 px |
| viền coral/cream/navy | CSS `border` + `box-shadow` | không bị răng cưa hoặc méo |
| texture chiếu | SVG tile 24 × 24 lặp | nhẹ, seamless, không có noise AI |
| button/panel/room row/modal | CSS fill, border, radius, shadow | state hover/pressed/focus/disabled dùng chung geometry |
| logo “TIẾN LÊN / MIỀN NAM” | live HTML text | tiếng Việt sắc nét, accessibility đúng |
| back/refresh/lock/check | SVG độc lập | icon tái sử dụng, không phụ thuộc font emoji |
| Ken balance/cược | PNG vàng chính thức hiện có | tái sử dụng `web/src/assets/icons/apps/ken.png`, không vẽ coin thay thế |
| bốn chất bài | bốn SVG 16 × 16 | màu và khoảng cách ổn định trong brand |
| empty room illustration | một SVG 64 × 64 | chỉ là icon outline, không phải tranh raster |
| avatar chữ cái | CSS gradient + live initial | không cần sinh chân dung, đổi theo username |
| mặt/lưng bài | WebP hiện có | không tạo lại hoặc recolor |

Kết quả là mockup chỉ đóng vai trò tham chiếu. Production không phụ thuộc độ phân giải của concept và không mang lỗi chữ/hình học do AI sinh.

## 3. Asset đã tạo

### 3.1 Icon chức năng

| File | ViewBox | CSS size đang dùng | Nội dung |
|---|---:|---:|---|
| `assets/icons/ic-back.svg` | 24 × 24 | 24 px | mũi tên quay lại |
| `assets/icons/ic-refresh.svg` | 24 × 24 | 22 px | tải lại room list |
| `assets/icons/ic-lock.svg` | 16 × 16 | 16 px | phòng có mật khẩu |
| `../../../web/src/assets/icons/apps/ken.png` | existing | 15/22/26 px | room bet / balance pill / bet input |
| `assets/icons/ic-check.svg` | 24 × 24 | 19 px trong circle | capacity đang chọn |
| `assets/icons/ic-cards-empty.svg` | 64 × 64 | 58 px | room list rỗng |

### 3.2 Brand suits

| File | ViewBox | CSS size | Màu cố định |
|---|---:|---:|---|
| `assets/icons/suit-club.svg` | 16 × 16 | 14 px | teal `#179E9A` |
| `assets/icons/suit-diamond.svg` | 16 × 16 | 14 px | coral `#FF6F61` |
| `assets/icons/suit-heart.svg` | 16 × 16 | 14 px | coral `#FF6F61` |
| `assets/icons/suit-spade.svg` | 16 × 16 | 14 px | teal `#179E9A` |

### 3.3 Pattern

`assets/patterns/pat-woven-diamond.svg`:

- canvas và viewBox 24 × 24;
- nền transparent;
- chỉ có hai nhóm đường chéo tạo diamond weave;
- cạnh trái/phải và trên/dưới nối seamless;
- không blur, filter, noise, grain hoặc embedded bitmap;
- được lặp bằng `background-image`, không stretch.

Toàn bộ asset trên là SVG code-native viết trực tiếp cho project, không lấy từ nguồn bên ngoài và không cần rasterize trước khi build.

## 4. Cấu trúc source

```text
game/thirteen/
  App.tsx                              # markup loading
  components/
    BrandMark.tsx                      # logo live text + bốn suit SVG
    ConfirmModal.tsx                   # variant Style 02 khi ở lobby
    modalKeyboard.ts                   # Escape và focus loop
  screens/lobby/
    LobbyScreen.tsx                    # lobby, rows, create/password modal
  style.css                            # token và CSS Style 02
  assets/
    cards/                             # giữ nguyên
    icons/                             # asset SVG vừa cắt
    patterns/
      pat-woven-diamond.svg
```

Không thêm tầng `style-01`/`style-02`; Style 02 là implementation chính tại path hiện tại.

## 5. Loading implementation

### 5.1 Layer

Thứ tự từ dưới lên:

1. `.tl-loading`: full-screen `cream.100`;
2. `.tl-loading-mat`: ellipse aqua + pattern;
3. border ellipse navy 3 px;
4. cream gap 7 px bằng shadow;
5. coral outer line 4 px bằng shadow tiếp theo;
6. `.tl-loading-content`: brand, status và dots.

Ellipse dùng `width: max(650px, 145vw)` và `height: clamp(410px, 53dvh, 510px)`. Vì ellipse lớn hơn viewport ngang, hai cạnh bị crop tự nhiên và đường cong không biến thành pill hẹp ở màn 360 px.

### 5.2 Motion

- ba dot chạy chu kỳ 1.2 giây;
- mỗi dot lệch nhau 160 ms;
- active đổi sang sun và nâng 3 px;
- `prefers-reduced-motion: reduce` tắt animation và giữ dot đầu màu sun.

`role="status"` và `aria-live="polite"` nằm trên wrapper; suit/dot trang trí dùng `aria-hidden`.

## 6. Lobby implementation

### 6.1 Background curve

`.tl-lobby` dùng aqua + tile pattern. Pseudo-element `::before` tạo vùng kem phía trên:

- width 124%, lệch trái -12% để curve không lộ góc;
- height responsive `clamp(172px, 21.5dvh, 194px)`;
- coral border 4 px;
- cream shadow offset 7 px;
- navy shadow offset 10 px;
- radius đáy dạng ellipse nông.

Không export curve ra SVG/PNG vì height topbar và safe area có thể thay đổi theo thiết bị.

### 6.2 Kích thước chính

| Component | Size production |
|---|---|
| back | 44 × 44, radius 12, border 2 |
| balance pill | cao 44, rộng 150–188 |
| avatar balance | 34 × 34 |
| logo main | `clamp(38px, 10.8vw, 44px)` |
| CTA chơi ngay | cao 72, radius 20 |
| tạo bàn riêng | cao 52, radius 16 |
| refresh | 40 × 40, icon 22 |
| room row | min-height 78, radius 16 |
| avatar room | 48 × 48 |
| row action | min-width 86, min-height 42 |
| modal | max-width 350, radius 20 |
| input | min-height 46, radius 12 |
| modal action | min-height 48 |

### 6.3 Avatar

Avatar trong balance pill dùng ảnh VIP từ `user.vipType`, cùng mapping `/vip-icons/vip_XXX.png` như Caro/War God; nếu user chưa có VIP thì dùng `ola_smiley_online.png`. Avatar của chủ bàn trong room list vẫn hash username thành một trong bốn tone `coral`, `violet`, `sun`, `blue`, có inner cream ring, navy outline và initial live text.

### 6.4 State room row

- joinable: button sun;
- locked: icon lock SVG cạnh tên;
- playing: badge coral + button soft aqua;
- full: button soft aqua và label “Đầy”;
- không đủ số dư cho `room.bet`: button coral nhạt, label “Thiếu Ken”, disable join;
- meta luôn hiện icon Ken và số cược; `0` là giá trị hợp lệ và vẫn hiển thị;
- không giảm opacity toàn row;
- tên dài ellipsis riêng, badge không bị co/cắt;
- `focus-within` có focus ring xanh.

## 7. Modal và keyboard

Create/password modal dùng cùng shell Style 02:

- backdrop navy 38%, blur tối đa 3 px;
- cream surface, navy border 2, radius 20;
- coral handle 48 × 4;
- capacity là button thật với `aria-pressed`;
- input “Cược mỗi người” dùng icon Ken hiện có, mặc định `0`, format `vi-VN` và numeric keyboard;
- cược vượt số dư/`maxBet` hiện helper coral, gắn `aria-invalid` và disable submit;
- input password là live input;
- submit dùng `<form>` nên Enter hoạt động;
- Escape đóng modal;
- Tab/Shift+Tab lặp trong các control của modal;
- click ngoài đóng theo behavior cũ;
- dialog có `role="dialog"`, `aria-modal` và `aria-labelledby`.

## 8. Responsive

Các breakpoint đã hiện thực:

- `<380 px`: gutter 16, action row 80 px tối thiểu, logo subtitle và capacity text thu nhẹ;
- `430–520 px`: gutter ngoài 24, content/row tối đa 472 px;
- height `≤760 px`: header curve, logo spacing và CTA stack rút gọn nhưng touch target vẫn tối thiểu 44 px;
- safe area dùng `--safe-top`/`--safe-bottom` hiện có;
- room list là vùng scroll độc lập với `min-height: 0`.

Viewport nghiệm thu chính: 360 × 800, 390 × 844 và 520 × 932.

## 9. Quy trình thêm asset mới

1. Xác định asset có thật sự cần file không. Surface, border, button, curve và text phải ưu tiên CSS/HTML.
2. Chọn viewBox 16 cho micro icon, 24 cho control icon, 48–64 cho empty-state/FX.
3. Vẽ path sạch, round cap/join, không metadata editor, filter hoặc embedded bitmap.
4. Lưu đúng `assets/icons/ic-{name}.svg`, `assets/patterns/pat-{name}.svg` hoặc `assets/fx/fx-{name}.svg`.
5. Import URL vào TSX và render bằng `<img alt="">` nếu trang trí; icon có nghĩa phải có `alt` hoặc accessible label ở button.
6. Set kích thước bằng CSS. Không đưa width runtime, label hoặc shadow tương tác vào file SVG.
7. Kiểm tra ở 1× và 2×, trên cream/aqua/sun, ở default/focus/disabled.
8. Chạy typecheck, test và build trước khi merge.

## 10. Lệnh kiểm thử

Từ repository root:

```bash
pnpm -C game typecheck
pnpm -C game test
pnpm -C game build
```

Visual QA dùng Vite game ở port 5174 và chụp đúng viewport 360 × 800, 390 × 844, 520 × 932. Cần kiểm tra tối thiểu:

- loading;
- lobby 0 phòng và 4+ phòng;
- queueing;
- create room;
- password room;
- confirm/notice;
- keyboard focus và reduced motion.

## 11. Acceptance checklist

- [x] không dùng ảnh full-screen;
- [x] button, panel, curve và border là CSS responsive;
- [x] text/data đều live;
- [x] không dùng emoji cho back/refresh/lock; Ken dùng đúng asset PNG vàng chính thức;
- [x] asset SVG đúng folder phẳng của Style 02;
- [x] CTA và row có state disabled/playing/full rõ;
- [x] tạo bàn truyền cược mặc định 0 xuống SDK và room row hiển thị cược Ken;
- [x] modal có Enter, Escape, focus loop và accessible name;
- [x] loading có reduced-motion fallback;
- [x] hỗ trợ 360–520 px và safe area;
- [x] giữ nguyên bộ bài và logic game.
