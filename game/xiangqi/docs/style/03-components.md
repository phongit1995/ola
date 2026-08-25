# 03 — Component specifications

Tất cả số đo trong tài liệu này dùng viewport cơ sở `390 × 844 CSS px`. Responsive chi tiết nằm trong `05-screens-responsive-accessibility.md`.

## 1. Surface hierarchy

| Level | Component | Nền | Border/shadow | Z-index gợi ý |
|---|---|---|---|---:|
| 0 | app/screen | wood gradient | không border | 0 |
| 1 | board, list row, pod | paper hoặc wood translucent | 1–3 px, shadow tối đa md | 1–10 |
| 2 | popover, reaction picker, banner | paper/navy/red | border 1.5–2, shadow md/lg | 20–29 |
| 3 | chat drawer | paper | border 2, shadow lg | 30–39 |
| 4 | modal/backdrop | paper + overlay | border 2, shadow lg | 40–59 |
| 5 | toast/global notice | navy | shadow md | 60 |

Không giải quyết lỗi chồng lớp bằng z-index tùy ý `9999`. Nếu cần level mới, cập nhật bảng này.

## 2. App shell và screen

Class: `.xq-app`, `.xq-screen`.

- App cao `100%`, max-width `520 px`, đặt giữa ở desktop.
- Screen dùng wood gradient `wood-700 → wood-900`, thớ gỗ và mối ghép ván đủ tương phản để nhận ra ở viewport mobile.
- Padding: top `safe-area + 12`, ngang `15/20`, bottom `safe-area + 12`.
- Nội dung không kéo ngang; danh sách và chat tự scroll trong vùng riêng.
- Không render background minh họa khác nhau cho mỗi màn. Tính nhất quán đến từ một trường nền gỗ liên tục.
- Nếu dùng texture, đặt một pseudo-element ở app level; mọi screen dùng cùng tile/scale để không bị “texture nhảy”.
- Screen có thể thêm khung khắc chìm/inlay ở mép và một lớp sáng tối theo chức năng; lớp này không đổi hướng texture hay tạo scene riêng.

## 3. Screen header

Pattern: `.xq-screen-header`.

```text
[44 Back]        Title        [44 Action/Spacer]
```

- Height tối thiểu `52 px`.
- Grid ba cột `44px 1fr 44px` để title luôn ở chính giữa quang học.
- Title `24/30/800`, cream; ở title dài cho phép `20/26` trước khi truncate.
- Không căn title giữa bằng margin ngẫu nhiên theo từng icon.
- Back/action icon theo `.xq-icon-btn`.
- Nếu không có action phải giữ spacer `44 px` không tương tác.

## 4. Bàn cờ — BoardSurface

Class: `.xq-board-wrap`, `.xq-board-svg`, `.xq-board-layer`.

### Geometry bắt buộc

- 9 cột × 10 hàng **giao điểm**, tương ứng 8 khoảng ngang × 9 khoảng dọc.
- Tỷ lệ vùng lưới `8:9`; có lề quanh giao điểm biên.
- Board max-width `480 px`; tại viewport 390 dùng toàn bộ bề ngang khả dụng.
- Đường dọc bên trong ngắt ở sông; hai đường biên chạy xuyên suốt.
- Cung vẽ hai đường chéo đúng hai phía.
- Marker Pháo/Tốt đúng vị trí, marker sát biên chỉ có nửa hướng vào trong.
- Hướng nhìn: quân của người dùng luôn phía dưới; Đen dùng phép biến đổi tọa độ, không rotate text/glyph ngược.

### Visual layers từ dưới lên

1. Paper surface.
2. Viền gỗ `wood-500/700`.
3. Lưới và sông bằng `--xq-line`.
4. Last-move markers.
5. Hint dots.
6. Pieces.
7. Check/capture/selected rings.
8. Check banner/reaction overlay.

### Chất liệu

- Board paper sáng hơn nền tối rõ ràng nhưng không trắng tinh.
- Texture giấy tối đa `3%`; lưới luôn render SVG sắc, không nằm trong bitmap.
- Khung có một outline chính; không thêm nhiều lớp bevel hoặc góc chạm khắc ngẫu nhiên.
- Chữ sông là yếu tố phụ, opacity khoảng `.4`; không tranh với glyph quân.

### State

| State | Biểu hiện |
|---|---|
| idle | board và pieces ở contrast chuẩn |
| selected | một piece nâng/ring gold; hints xuất hiện |
| movePending | khóa input; giữ thế cờ; có feedback đang xử lý nếu >300 ms |
| check | General ring red + banner ngắn |
| pregame | board dim opacity `.4`, panel pregame ở trên |
| expired | khóa input, banner trạng thái server ở trên |
| opponent away | vẫn đọc được bàn, banner kết nối ở safe top |
| result | giữ closing move hiển thị trước khi result modal xuất hiện |

## 5. Piece

Class: `.xq-piece`, `.xq-piece-red`, `.xq-piece-black`.

### Anatomy

- Hình tròn; visual diameter khoảng `0.92 × cell`.
- Nền `paper-bright → paper` radial rất nhẹ.
- Vòng ngoài navy `2 px`.
- Vòng khắc trong màu phe `2–2.5 px`, opacity `50–60%`.
- Glyph serif CJK, weight `700`, chiếm khoảng `58–62%` đường kính.
- Shadow md; không có bóng dài theo một hướng.

### Glyph chuẩn

| Phe Đỏ | Glyph | Phe Đen | Glyph |
|---|---:|---|---:|
| Tướng | 帥 | Tướng | 將 |
| Sĩ | 仕 | Sĩ | 士 |
| Tượng | 相 | Tượng | 象 |
| Xe | 俥 | Xe | 車 |
| Pháo | 炮 | Pháo | 砲 |
| Mã | 傌 | Mã | 馬 |
| Tốt | 兵 | Tốt | 卒 |

Không để công cụ sinh ảnh tự viết glyph. Nếu dùng raster piece face, từng glyph phải so sánh với bảng trên và asset nguồn phải ở độ phân giải đồng nhất. CSS/live glyph là fallback bắt buộc.

### State modifiers

| Modifier | Visual | Motion |
|---|---|---|
| `.xq-piece-selected` | nâng `3 px`, ring gold `3 px`, shadow lg | 120–150 ms |
| `.xq-piece-capture-hint` | ring red `3 px` | fade 120 ms |
| `.xq-piece-checked` | ring red/glow tối đa 6 px | pulse 1 s; reduced = static |
| disabled | không tương tác | không pulse hover |

Piece không được đổi kích thước giữa các loại quân. Không dùng illustration riêng làm Xe/Mã/Tượng.

## 6. LastMoveMarker và MoveHint

### Last move

- From: outline gold `2 px`, alpha `.65`.
- To: fill gold, alpha `.35–.45`.
- Radius `8 px`; nằm dưới piece.
- Cả hai luôn xuất hiện theo cặp nếu server có đủ from/to.
- Không animate liên tục.

### Move hint

- Hit box `44 × 44`; chấm jade `13 px`.
- Hint trên target trống dùng dot; target có quân địch dùng capture ring trên piece.
- Xuất hiện `fade + scale` 120 ms; stagger tối đa `12 ms/hint` nhưng tổng không quá 200 ms.
- Hint phải biến mất ngay khi move pending hoặc selection đổi.

## 7. PlayerPod

Class: `.xq-pod` và các phần tử con.

```text
┌────────────────────────────────────────────┐
│ [Avatar 44]  username [Đỏ]      00:22      │
│              [captured pieces…]            │
└────────────────────────────────────────────┘
```

| Thuộc tính | Giá trị |
|---|---|
| Min-height | `64 px` |
| Padding | `8 × 12 px` |
| Gap | `10 px` |
| Radius | `16 px` |
| Nền | black 18% trên wood |
| Border idle | cream 25%, `1.5 px` |
| Active | border gold + glow tối đa 6 px |

### Avatar

- `44 × 44`, circle, border navy `2 px`.
- Red avatar dùng red; Black avatar dùng ink.
- Initial là live text uppercase; không tạo portrait AI mặc định.
- Empty seat dùng cream 20% + dashed border; ký hiệu `?` hoặc icon user-add.

### Name và side chip

- Name `15/600`, ellipsis một dòng; accessible name giữ đầy đủ.
- Side chip `11/800`, pill, red/ink background + cream text.
- Không dùng cùng một red chip cho thông báo lỗi; vị trí/context phải tách rõ.

### Captured tray

- Mini piece `18 px`; tối đa 8, sau đó `+n`.
- Hiển thị quân bị người này ăn hoặc quân đã mất phải nhất quán theo quyết định sản phẩm; label `aria-label` giải thích.
- Không để mini-piece chen lên tên/clock tại width 360; giảm số hiển thị xuống 6 trước khi giảm kích thước.

### Clock

- `22/26/800`, tabular, min-width `44`.
- Bình thường gold; ≤10 s chuyển danger và pulse 1 s.
- Không đổi layout khi từ `10` sang `9`; format có thể `00:09` nếu backend dùng phút.
- `aria-live="polite"` chỉ announce mốc quan trọng, không đọc mỗi giây.

## 8. Badge và status chips

### Static chip

Class: `.xq-chip` và modifiers.

| Variant | Màu | Dùng cho |
|---|---|---|
| neutral | cream/navy | chưa sẵn sàng, hòa, metadata |
| gold | gold/navy | chủ bàn, cược nổi bật |
| jade | jade/cream | sẵn sàng, thắng |
| danger | danger/cream | thua/lỗi ngắn |

- Height phụ thuộc content, padding `3 × 10`, radius pill.
- Chip không click; nếu click phải dùng chip button anatomy ở tài liệu button.
- Label tối đa `20` ký tự; dài hơn chuyển sang text phụ.

### KEN badge

- Nền paper, text navy, border navy `1.5`, radius 12.
- Icon KEN `16 px`, gap `6`, số `15/800` tabular.
- Không dùng emoji `⛁` trong production; thay `ic-ken` đã duyệt.

### Bet badge trên board

- Nền gold, border gold-deep `1.5`, radius 12.
- Padding `4 × 10`, text `13/800` tabular.
- Neo top-right board nhưng không che giao điểm hoặc quân.
- Bet `0` hiển thị `Giao hữu` với paper/neutral nếu product cần; không hiển thị số 0 như cược.

## 9. List rows

Class: `.xq-room-row`, `.xq-list-row`.

- Min-height `56 px`, padding `8 × 12`, radius 12.
- Nền xen kẽ paper/paper-dim; border navy 40% `1 px`.
- Gap cột `8 px`; text chính `14–15/600`; số KEN `14/800` tabular.
- Hover trên desktop: paper-bright, border navy 65%; pressed nếu row click: translateY tối đa `1 px`.
- Nếu có button `Vào bàn`, row không đồng thời click toàn bộ trừ khi semantics rõ.
- Tên dài ellipsis; KEN và action không co.
- Empty/loading là row/panel riêng, không dựng một room giả mờ.
- Riêng room list được đặt trên một lớp “kệ bàn” gỗ chìm, dùng cùng texture nền và shadow nội; row giấy vẫn là surface đọc dữ liệu chính.
- `Vào bàn` gộp occupancy `1/2` trong cùng button compact. Dùng paper/ink để không tạo một dải CTA vàng lặp; CTA vàng toàn màn dành cho `Tạo bàn`.

### Room row tại width cơ sở

```text
owner: flexible | bet: 86 px | join/status: 108 px
```

Ở width 360, bet/join co xuống `70/102 px`; nếu vẫn thiếu, chuyển owner+bet thành hai dòng thay vì giảm font dưới 12 px.

## 10. Inputs và form fields

Class: `.xq-field` và input con.

| Thuộc tính | Giá trị |
|---|---|
| Height | `48 px` |
| Background | paper-bright |
| Text | navy `15/600` |
| Border idle | navy `1.5 px` |
| Border focus | gold-deep `2 px` |
| Radius | `12 px` |
| Padding X | `12 px` |
| Label | `13.5/18/600` |

### States

- Placeholder: navy 55%; không dùng placeholder thay label.
- Focus: border gold-deep; outline ngoài nếu cần contrast.
- Filled: không đổi background.
- Error: border danger `2 px`, message `13/18` + warning icon; giữ label.
- Disabled: paper-dim, opacity `.65`, cursor default; value vẫn đọc được.
- Read-only: paper-dim nhưng opacity 1, có label giải thích.

Input KEN dùng `inputmode="numeric"`, giá trị được format khi blur hoặc hiển thị preview rõ; password cho phép show/hide bằng icon button `44 px` nếu được thêm.

## 11. Modal và ConfirmModal

Class: `.xq-backdrop`, `.xq-modal`, `.xq-modal-actions`.

| Thuộc tính | Giá trị |
|---|---|
| Width | `min(330px, calc(100% - 40px))` |
| Background | paper |
| Text | navy |
| Border | navy `2 px` |
| Radius | `20 px` |
| Padding | `20 px` |
| Shadow | lg |
| Backdrop | overlay 62% |

### Nội dung

- Title `18/24/800`, margin-bottom 8.
- Body `14.5/21/500`, margin-bottom 16.
- Field gap 10–12.
- Footer margin-top 14, gap 12, primary ở bên phải.
- Không trang trí góc modal bằng hoa văn ngẫu nhiên.

### Behavior

- Focus trap trong modal.
- `Esc` đóng nếu không có action bất khả đảo ngược đang pending.
- Click backdrop đóng modal form có thể khôi phục; Confirm destructive không nên đóng khi click nhầm backdrop nếu sản phẩm yêu cầu thận trọng.
- Khi mở: focus title hoặc control đầu tiên; destructive confirm ưu tiên `Hủy`.
- Khi đóng: trả focus về trigger.
- Loading disable cả hai action nếu gửi lặp gây lỗi; vẫn cho cancel nếu request có thể hủy an toàn.

## 12. Pregame panel

Class: `.xq-pregame`, `.xq-pregame-panel`, `.xq-seat`.

- Board phía sau opacity `.4`, không blur.
- Panel width `min(340px, 100%)`, paper, border navy 2, radius 20, shadow lg.
- Title `18/24/800`; bet row dùng badge gold/neutral.
- Hai seat đồng dạng; avatar 44, name 14/700, side 12/normal, status chip.
- Empty seat dùng dashed border và animation pulse nhẹ; reduced-motion tắt pulse.
- Actions wrap theo hàng, gap 10; CTA vàng chỉ cho hành động chính theo vai.
- Hint dưới cùng `12/17`, navy 70%; không đặt luật quan trọng chỉ ở hint màu mờ.

## 13. Chat drawer

Class: `.xq-chat`.

- Bottom sheet cao `clamp(360px, 54%, 500px)`, paper, border navy 3, radius top `26`, không border dưới; scrim tối nhẹ đóng khi bấm.
- Header gỗ height tối thiểu 72; icon chat gold, title 17/800, chip `Trong bàn`, subtitle số tin và close icon button tương phản cao.
- Message list scroll độc lập, padding ngang 14, gap 9; có notice phạm vi, tên người gửi và giờ gửi.
- Bubble đối thủ: paper-bright + border navy 35%.
- Bubble mình: gold + border gold-deep.
- Bubble radius bất đối xứng 14/5, padding `8 × 12`, max-width `82%`, text `14/19`.
- Không dùng texture trong bubble; không dùng avatar AI nhỏ cạnh từng tin.
- Input row tôn trọng safe-area bottom; input 44 visual có bộ đếm 120 ký tự, send button 76×44.
- Text dài break-word; URL không được làm overflow.
- Khi lỗi gửi, draft được khôi phục và toast giải thích; không biến bubble thành trạng thái lỗi mơ hồ.

## 14. Reaction picker và float

- Picker là pill paper, border navy 2, padding `8 × 12`, gap 6, shadow md.
- Neo trên action bar, không che quân cuối bàn.
- Trigger có `aria-expanded`; picker có accessible label.
- Reaction float xuất phát gần pod người gửi, duration 2.0–2.4 s; tối đa số lượng đồng thời có giới hạn.
- Reduced-motion: hiển thị tĩnh 600–900 ms rồi fade.
- Asset reaction được duyệt thủ công; không trộn ảnh 3D, emoji native và sticker minh họa trong cùng picker.

## 15. Feedback components

### Toast

- Nền navy 92%, text cream `14/20/600`, radius pill.
- Padding `10 × 20`, max-width `calc(100% - 40px)`.
- Neo bottom `96 px` hoặc trên safe-area/action bar.
- Enter fade+rise 200 ms, giữ khoảng 2.4 s.
- `role="status"`; lỗi nghiêm trọng có thể `role="alert"` nhưng không lạm dụng.
- Một thời điểm tối đa một toast; message mới thay/queue theo logic đã định.

### Turn announce

- Text gold `20/26/800`, tracking `.04em`, ở khoảng 34% màn.
- Không dùng text-shadow nặng; nếu cần chỉ shadow tối để đọc trên board.
- Hiện 900 ms; `aria-live="polite"`.

### Check banner

- Nền red, text cream, border red-deep 2, pill.
- `20/26/800`, padding `10 × 26`, shadow lg.
- Hiện khoảng 1.2 s; shake 2 px tối đa; reduced-motion bỏ shake.
- Không thêm ⚠ emoji; nếu cần icon dùng `ic-warning` SVG.

### Opponent away

- Nền navy 92%, text cream `14/20/600`, radius 12.
- Icon `wifi-off` 18, countdown tabular.
- Vị trí top safe-area; không che modal hoặc header.

### Expired

- Nền red-deep/danger 94%, text cream, border cream/gold 30–45%.
- Copy nói rõ đang chờ server xử; không tự công bố thắng/thua từ client.

## 16. Result modal

- Kế thừa modal surface; content center.
- Hai glyph Tướng `52 px` là visual brand, kiểm tra đúng 帥/將.
- Title `30/36/800`, tracking `.10em`.
- Win có gold-deep/jade tùy context; lose dùng ink/red-deep; draw navy.
- KEN delta `20/26/800` tabular, luôn có dấu `+`, `−` hoặc `0`.
- Lý do là live text, không bake vào artwork.
- Footer dùng Chơi lại = gold, Đóng = paper. Khi pending, không để click lặp.
- Modal chỉ xuất hiện sau khi closing move đã render.

## 17. Empty, loading và error states

### Empty

- Text cream 70% trên wood hoặc navy 70% trên paper.
- Padding `40 × 20`; body `15/22`.
- Có thể dùng một icon line `32 px`, không dùng illustration AI lớn.
- Nếu có hành động hợp lý, một secondary/primary button phía dưới cách 16.

### Loading

- Dưới 300 ms: không flash spinner.
- Trên 300 ms: spinner line hoặc skeleton đơn giản theo hình học component.
- Skeleton dùng paper/cream alpha, không shimmer mạnh; reduced-motion tắt shimmer.
- Không render dữ liệu giả trông như room thật.

### Error

- Message ngắn, nói được bước tiếp theo.
- Error screen có CTA `Thử lại` gold; error inline dùng message + icon warning.
- Không chỉ đổi border đỏ mà thiếu text.

## 18. Component anti-AI checklist

- [ ] Mọi instance cùng loại dùng đúng một anatomy và token.
- [ ] Không có ornament/texture riêng cho một instance ngẫu nhiên.
- [ ] Icon thuộc cùng stroke family; không còn emoji placeholder.
- [ ] Text, số và glyph không méo/bake trong ảnh.
- [ ] Board geometry và vị trí marker đúng luật.
- [ ] State được thể hiện bằng ít nhất hai kênh khi quan trọng.
- [ ] Không có nhiều hơn ba mức shadow hoặc gradient ngoài danh sách.
- [ ] Empty/loading dùng shape hệ thống, không dùng illustration không kiểm soát.
