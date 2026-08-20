# 05 — Production workflow and QA

## 1. Mục tiêu quy trình

Quy trình Style 02 phải bảo đảm:

- concept sáng/phẳng được chuyển thành hệ thống chính xác;
- ảnh sinh chỉ hỗ trợ ý tưởng, không quyết định geometry production;
- component được tái sử dụng thay vì cắt riêng từ từng màn;
- text và dữ liệu luôn live;
- giữ duy nhất DNA sáng, phẳng và code-native đã được duyệt;
- UI đáp ứng accessibility, responsive và performance.

## 2. Gate sản xuất

### Gate A — Functional inventory

Trước khi vẽ:

- chốt danh sách màn/state từ source React;
- chốt class/component map;
- chốt text động và text cố định;
- chốt asset hiện có phải giữ;
- chốt breakpoint và safe area.

Output: checklist màn trong `02-screen-specs.md` và mapping trong `06-screen-to-asset-map.md`.

### Gate B — Token proof

Dựng một trang sandbox có:

- core palette;
- type scale;
- border/radius/shadow scale;
- button family đầy đủ state;
- avatar/nameplate/badge;
- row/modal/input;
- mat pattern/curve.

Không triển khai từng màn trước khi token proof được duyệt.

### Gate C — Golden components

Chốt ba component chuẩn:

1. Primary Sun button;
2. Room row;
3. Avatar + nameplate + turn ring.

Ba component này quyết định stroke, radius, shadow, spacing và màu cho phần còn lại.

### Gate D — Screen assembly

Thứ tự:

1. lobby;
2. modal;
3. room waiting;
4. table;
5. chat overlay;
6. result/loading/toast.

Mỗi màn phải lắp từ component đã duyệt; không tạo phiên bản “gần giống” cục bộ.

### Gate E — QA and freeze

- visual regression;
- interaction state;
- accessibility;
- responsive;
- performance;
- asset audit;
- prompt/source log.

## 3. Workflow từ concept đến production

### Bước 1 — Tách concept thành primitives

Không crop trực tiếp. Ghi lại:

- cream page;
- aqua mat;
- coral/cream/navy curve;
- navy outline;
- sun CTA;
- cream surface;
- short shadow;
- avatar color system;
- woven pattern;
- typography hierarchy.

### Bước 2 — Dựng token

- khai báo CSS custom properties;
- không hard-code hex trong screen-level CSS;
- semantic token map từ core token;
- token name không gắn component cụ thể nếu có thể dùng chung.

### Bước 3 — Dựng SVG

- ưu tiên manual path/code;
- dùng cùng viewBox/stroke;
- optimize và test optical size;
- không nhúng shadow/fill state vào icon.

### Bước 4 — Dựng component

- dùng pseudo-element cho curve/accent;
- dùng CSS state class/data-attribute;
- typography live;
- focus, disabled, loading làm ngay từ đầu.

### Bước 5 — Lắp screen

- so functional screenshot trước;
- so concept Style 02 sau;
- không đổi logic/DOM chỉ để khớp ảnh giả nếu không cần;
- nếu DOM hạn chế, ghi rõ mapping hoặc đề xuất refactor riêng.

### Bước 6 — Chụp và diff

- capture đúng viewport;
- tắt font animation/time random;
- dùng dữ liệu fixture ổn định;
- so geometry, color, text wrap và state;
- không dùng pixel-perfect diff chống alias tuyệt đối; dùng threshold hợp lý.

## 4. Khi nào được dùng image generation

Được dùng cho:

- thăm dò toàn màn;
- gợi ý composition mới;
- thử palette/mood;
- hình minh họa optional không chứa UI/text.

Không dùng output trực tiếp cho:

- button/panel/row production;
- icon 16/24;
- text/logo;
- border curve cần lặp chính xác;
- pattern seamless chưa được redraw;
- card face/back chưa qua game QA.

Nếu dùng output model:

1. ghi prompt và reference vào log;
2. chọn ý tưởng, không chọn lỗi hình học;
3. redraw CSS/SVG;
4. bỏ toàn bộ chữ giả;
5. kiểm tra bản quyền/nguồn nếu có reference ngoài;
6. reviewer duyệt bản production, không chỉ duyệt concept.

## 5. Review ít dấu vết AI

### 5.1 Geometry audit

Đo bằng devtools/Figma:

- border cùng family chênh 0 px;
- radius cùng token chênh 0 px;
- button height chênh 0 px;
- icon center sai tối đa 0.5 px quang học;
- gap thuộc scale;
- room rows dùng cùng DOM/component;
- curve là CSS/SVG thật.

### 5.2 Text audit

- inspect DOM thấy text live;
- Vietnamese dấu đầy đủ;
- font load không gây overflow;
- số dùng tabular nums khi thay đổi;
- không text nào nằm trong background image;
- line break đến từ layout, không `<br>` tùy tiện trừ logo/title thiết kế.

### 5.3 Material audit

Style 02 không có “material realism”. Reject nếu thấy:

- thớ gỗ;
- kim loại;
- giấy cũ;
- nỉ tối;
- bevel;
- specular highlight;
- ambient glow;
- texture hạt ngẫu nhiên.

Pattern chiếu hợp lệ nếu ở 3–5% opacity và không nhìn như nhiễu.

## 6. CSS architecture đề xuất

```text
style.css hoặc styles/
  tokens.css
  base.css
  components/
    button.css
    avatar.css
    row.css
    modal.css
    form.css
    badge.css
  screens/
    lobby.css
    room.css
    table.css
    result.css
  motion.css
```

Nếu giữ một file hiện tại:

- đặt token đầu file;
- tiếp theo base/component;
- screen theo thứ tự route;
- media queries gần component hoặc gom cuối file nhưng nhất quán;
- không duplicate selector để override chồng nhiều vòng.

## 7. Token lint thủ công

Search trước review:

```text
#[0-9a-fA-F]{3,8}
rgba?\(
border-radius:
box-shadow:
font-size:
z-index:
```

Mọi giá trị ngoài token phải có comment lý do hoặc được đưa vào scale.

Các exception hợp lệ:

- màu suit/card asset hiện có;
- avatar gradient từ bảng cố định;
- conic timer tính runtime;
- alpha backdrop/overlay đã ghi trong spec.

## 8. SVG QA

Cho mỗi SVG:

- parse không lỗi;
- viewBox đúng;
- không width/height bất hợp lý;
- không embedded base64;
- không `<text>`;
- không filter nếu icon;
- không hard-code màu ngoài trường hợp suit/FX hai màu;
- path không có hàng nghìn node do auto-trace;
- hiển thị rõ ở target size;
- icon mirror/rotate đúng khi dùng RTL nếu sản phẩm yêu cầu.

## 9. Responsive QA matrix

| Viewport | DPR | Màn bắt buộc |
|---|---:|---|
| 360×800 | 2 | all |
| 390×844 | 2/3 | all, golden |
| 412×915 | 2/3 | lobby/table |
| 430×932 | 3 | lobby/table/result |
| 520×932 | 2 | all |

Kiểm tra thêm:

- safe top 0/24/44;
- safe bottom 0/20/34;
- browser text zoom 200% ở flow không gameplay nếu khả thi;
- OS font scaling phổ biến;
- keyboard ảo mở ở chat/password;
- tên 1, 8 và 16 ký tự;
- Ken 1, 7, 10+ chữ số;
- room list 0, 1, 4, 20 items.

## 10. Accessibility QA

### 10.1 Contrast

- body text ≥4.5:1;
- large/bold ≥3:1;
- UI border/state ≥3:1 với màu kề;
- focus ring ≥3:1;
- disabled text vẫn đọc được, mục tiêu ≥3:1.

Đo trên màu thực sau gradient/alpha, không chỉ token gốc.

### 10.2 Keyboard

- tab order hợp lý;
- focus không bị che bởi sticky action;
- Escape đóng modal/sheet nếu đúng behavior;
- Enter/Space kích hoạt button;
- card selection có keyboard path nếu game hỗ trợ desktop;
- focus trap modal hoạt động và trả focus về trigger.

### 10.3 Screen reader

- icon button có aria-label;
- avatar initial không announce hai lần;
- seat dots có text occupancy;
- timer không announce liên tục;
- toast dùng live region;
- modal/result có heading/label;
- card alt/aria representation theo logic game, không chỉ filename.

### 10.4 Motion

- reduced motion tắt pulse/stagger/bounce;
- không flash >3 lần/giây;
- animation không bắt buộc để hiểu state;
- action phản hồi pressed vẫn có thay đổi màu tức thời.

## 11. Interaction QA

### Buttons

- hit 44 px;
- double click/tap không submit hai lần;
- loading giữ width;
- disabled ngăn handler;
- pressed không kẹt sau pointer cancel.

### Modals

- background không scroll;
- keyboard không che input/action;
- error đặt gần field;
- click backdrop không đóng khi đang submit nếu gây mất dữ liệu.

### Table

- chọn bài không làm card ra ngoài viewport;
- action không che hand;
- card animation không che topbar/chat;
- reconnect không xóa thông tin ván;
- timer urgent rõ không cần âm thanh.

## 12. Visual regression

Golden screenshots:

- lobby default;
- lobby 4 rooms;
- create modal;
- room host 3/4;
- table active with 13 cards;
- table selected;
- chat open;
- result.

Mask/deterministic:

- tên và số random dùng fixture;
- timer freeze;
- animation disabled ở capture;
- font loaded trước screenshot;
- hide cursor/caret;
- card order cố định.

Reject regression nếu:

- border/radius thay đổi;
- content chồng;
- action ra khỏi safe area;
- font fallback;
- pattern quá đậm;
- curve xuất hiện seam;
- semantic state mất phân biệt.

## 13. Performance budget

| Hạng mục | Budget |
|---|---:|
| Style 02 SVG + pattern initial | ≤80 KB raw, mục tiêu ≤30 KB gzip |
| CSS Style 02 bổ sung | ≤35 KB raw |
| optional FX lazy | ≤40 KB gzip |
| one icon SVG | mục tiêu ≤2 KB |
| new full-screen raster | 0 |
| layout shift | CLS gần 0 |

Quy tắc runtime:

- transform/opacity cho animation;
- tránh filter blur động;
- conic timer không update quá 10 FPS;
- không tạo DOM particle không giới hạn;
- lazy load chat reaction/result FX nếu cần.

## 14. Browser/device

Tối thiểu kiểm tra:

- Chromium desktop/mobile;
- Safari iOS hiện được sản phẩm hỗ trợ;
- Android WebView/Chrome;
- thiết bị thấp/mid nếu có;
- forced-colors fallback cho control chính;
- offline/reconnect path.

Fallback:

- không `backdrop-filter`: overlay vẫn đủ contrast;
- không CSS mask: dùng SVG background tile;
- không conic-gradient: dùng SVG circle progress;
- font chưa tải: fallback không phá layout.

## 15. Checklist theo màn

### Loading

- [ ] logo text live;
- [ ] state connecting/error;
- [ ] reduced motion;
- [ ] không có environment art.

### Lobby

- [ ] topbar safe;
- [ ] logo/curve không overlap;
- [ ] CTA 72/52 px;
- [ ] room 0/1/n;
- [ ] queueing;
- [ ] locked/playing/full;
- [ ] refresh focus/loading;
- [ ] scroll bottom safe.

### Modal

- [ ] focus trap/return;
- [ ] input Vietnamese/password;
- [ ] error/loading;
- [ ] keyboard open;
- [ ] destructive close behavior.

### Room

- [ ] 2/3/4 capacity;
- [ ] owner/guest;
- [ ] ready states;
- [ ] empty seat dashed;
- [ ] kick target;
- [ ] chat scroll/send;
- [ ] action safe area.

### Table

- [ ] all seats;
- [ ] 1–13 cards;
- [ ] hand selection;
- [ ] trick 1–4 cards;
- [ ] timer normal/urgent;
- [ ] pass/chop/finish;
- [ ] disconnected/quit;
- [ ] chat/reaction;
- [ ] action disabled/enabled;
- [ ] rank/suit legible.

### Result

- [ ] 2/3/4 rankings;
- [ ] first/me/last combinations;
- [ ] instant/disconnect/forfeit;
- [ ] rows scroll;
- [ ] actions sticky/focus.

## 16. Completion audit

Trước khi tuyên bố Style 02 hoàn tất, thu bằng chứng:

1. danh sách class source và mapping docs có cùng coverage;
2. search toàn bộ docs không còn tên, đường dẫn hoặc tài liệu của style cũ và không còn tầng thư mục `style-*`;
3. root README chỉ Style 02 là active;
4. mọi link Markdown hoạt động;
5. SVG manifest path tồn tại khi triển khai asset;
6. screenshots golden tồn tại và được review;
7. contrast report;
8. responsive test report;
9. asset byte report;
10. git diff không chứa thay đổi gameplay ngoài scope nếu task chỉ là style.

## 17. Prompt sửa lỗi thường gặp

### Quá 3D

```text
Flatten the approved UI without changing layout. Replace bevels and material highlights with one
flat fill, one consistent 2 px navy outline and one short downward shadow. Remove gloss, inner
shadow, metallic trim, embossing and ambient glow. Preserve exact text-free component geometry.
```

### Viền không đều

```text
Normalize every interactive component to the same production geometry: uniform 2 px deep navy
outline on all four sides, exact symmetric corner radii from a 12/16/20 scale, clean vector-like
edges, no hand-painted wobble, no double rim and no black outline. Preserve positions and content.
```

### Pattern quá đậm

```text
Reduce the aqua mat weave to an extremely subtle seamless geometric diamond pattern at 3 to 4
percent contrast. Remove fibers, noise, stains, photoreal texture and center ornaments. Keep the
mat bright, calm and highly readable behind cards and typography.
```

### Generic/thiếu cá tính

```text
Keep the flat production system but restore the approved Chieu Bai Ngay Vui identity through the
large aqua woven mat, one confident coral-cream-navy curved boundary, warm cream surfaces and sunny
yellow primary actions. Do not add illustrations, ornament, 3D materials or extra UI.
```

### Model tự thêm chữ

```text
Remove all environmental text, signs, labels, logos, watermarks and invented copy. Reusable skins
must be completely text-free. Preserve only empty spaces reserved for live HTML text and keep the
approved layout unchanged.
```

## 18. Sign-off

Một release cần tối thiểu:

- design review: geometry + identity;
- frontend review: reuse + states + responsive;
- QA review: functional state matrix;
- accessibility review: contrast/focus/semantics;
- product review: wording/action priority.

Không sign-off chỉ dựa trên một ảnh lobby đẹp. Bàn chơi và toàn bộ state mới là bằng chứng Style 02 hoạt động như một system.
