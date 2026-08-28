# 05 — Screen application, responsive và accessibility

File này mô tả cách áp dụng style “Mộc bản thủ công” lên toàn bộ flow. Luật, dữ liệu và network vẫn theo các tài liệu gameplay hiện có.

## 1. Khung màn chuẩn

```text
┌──────────────────────────┐
│ safe-area top            │
│ header / player pod      │
│                          │
│ primary content          │
│                          │
│ footer / action bar      │
│ safe-area bottom         │
└──────────────────────────┘
```

- Nền wood là lớp liên tục.
- Paper surface chỉ xuất hiện nơi cần đọc/thao tác; không bọc toàn màn bằng card trắng.
- Mỗi màn có một điểm nhấn gold chính.
- Modal/bottom sheet dùng cùng surface, border, shadow; không tự tạo skin riêng.
- Texture nằm ở app level để không thay đổi theo route.

## 2. S1 — Loading / Connecting

### Hierarchy

1. Logo/glyph pair ở giữa trên.
2. Tên game.
3. Progress/status live text.
4. CTA `Thử lại` chỉ khi lỗi.

### Style

- Logo pieces giống piece system, không dùng ảnh AI/illustration nền.
- Progress bar nếu có: track cream 18%, fill gold, height 8, radius pill.
- Status `15/22/600`, cream 80%.
- Lỗi dùng warning SVG + text cream; CTA gold.
- Không animate vô hạn nhiều phần. Chỉ spinner/progress; reduced-motion dùng fade tĩnh.

### Accessibility

- Status có `role="status"`, lỗi có thể `role="alert"`.
- Không đọc phần trăm ở mỗi frame; throttle announce theo mốc.
- Retry là button thật và nhận focus khi lỗi được hiển thị, nếu không làm gián đoạn người dùng.

## 3. S2 — Lobby

### Layout 390

```text
[avatar name]       [KEN] [sound]

          [帥] [將]
          CỜ TƯỚNG

       [CHƠI XẾP HẠNG + mô tả]
       [CHƠI VỚI MÁY + mô tả]
       [Lịch sử] [Bảng xếp hạng]

          Thoát game
```

### Style decisions

- Topbar cao tối thiểu 52; tên truncate tại 130 px ở 390.
- KEN badge paper/navy; sound là icon button.
- Logo title gold, không texture/text-shadow.
- CTA Chơi xếp hạng là gold hero; Chơi với máy là jade hero, có icon tile + mô tả một dòng, width tối đa 326 hoặc 90%.
- Hai secondary button paper nằm cùng một hàng, có icon 20 và label một dòng.
- Exit là inline action hạ cấp ở đáy.
- Margin logo dùng responsive clamp, không hardcode một giá trị chỉ đẹp ở 844 px cao.
- Motion vào theo nhịp topbar → logo/glyph → hai CTA → shortcut; chỉ dùng opacity/transform và kết thúc trong khoảng nửa giây.

### Short height

- Giảm margin logo từ `9vh/6vh` xuống khoảng `32/24 px`.
- Giữ CTA 60 px và touch targets.
- Nếu vẫn thiếu chiều cao, cho screen scroll dọc có kiểm soát; không cắt Exit.

## 4. S3 — Danh sách bàn

### Hierarchy

1. Header: Back, title, Refresh.
2. Column header nhẹ nếu đủ không gian.
3. Room list scroll.
4. Footer: pagination + CTA `Tạo bàn`.

### Style

- Room row paper/paper-dim xen kẽ.
- Owner name navy, cược tabular, lock icon 16.
- `Vào bàn` là paper/ink compact và gộp occupancy trong cùng button; full dùng neutral disabled. Gold toàn màn dành cho `Tạo bàn`.
- Footer không đè list; có nền wood hoặc gradient scrim nhẹ nếu sticky.
- Empty state dùng icon line 32 + text, không dùng illustration lớn.

### Responsive

- 390+: grid `1fr 86px 108px`.
- 360–389: `1fr 70px 102px`; rút gọn copy hợp lệ trước khi giảm font.
- Khi tên owner dài, ellipsis; không đẩy cược/action ra ngoài.
- Số hàng visible được quyết định bởi chiều cao, nhưng row không thấp hơn 56.
- Row stagger `24 ms`, tối đa 10 hàng; footer rise sau nhóm đầu. Refresh/page mới chỉ animate các row vừa mount.

## 5. S4 — Tạo bàn / Vào bàn khóa

- Modal paper 330 max, padding 20.
- Field label rõ; input height 48.
- Bet chips wrap tự nhiên, gap 8; active gold.
- Password optional có label, không chỉ placeholder.
- Validation message nằm ngay dưới field, warning icon + danger text/border.
- Footer: `Hủy` paper bên trái, `Tạo bàn/Vào bàn` gold bên phải.
- Keyboard mở không được che field/action: modal có thể chuyển align-start và scroll trong viewport nhỏ.
- `inputmode=numeric` cho cược; password hỗ trợ trình quản lý mật khẩu theo yêu cầu sản phẩm.

## 6. S5 — Pregame

- Board vẫn nhận diện phía sau nhưng dim `.4`; không blur.
- Pregame panel đặt giữa, width max 340.
- Hai seat dùng cùng một component và anatomy.
- Chủ bàn: CTA gold `Bắt đầu` chỉ enabled khi đủ điều kiện; `Mời ra` paper.
- Khách: CTA gold `Sẵn sàng`; khi ready chuyển action thành paper `Hủy sẵn sàng`.
- `Thoát bàn` paper ở bước đầu; confirm danger nếu hành động có hậu quả.
- Trạng thái ready dùng chip jade + text; không chỉ vòng xanh quanh avatar.
- Loading label không làm panel đổi width.
- Backdrop fade, panel scale/rise nhẹ; hai seat vào tuần tự rồi mới tới nhóm action. Không animate lại chỉ vì ready state đổi.

## 7. S6 — Bàn chơi

### Vertical order

```text
[Opponent pod 64]
[Board + bet badge]
[My pod 64]
[Chat] [Reaction] [Forfeit] [Exit]
```

### Priority

- Board dùng diện tích lớn nhất.
- Opponent/my pod có cùng anatomy; active turn dùng gold border.
- Action bar giảm tương phản so với board.
- Overlay không được che thông tin lâu hơn cần thiết.
- Entrance theo thứ tự pod đối thủ → status → board → pod của bạn → action bar; mọi phần vẫn tương tác được và không đổi geometry trong lúc animate.

### State styling

| State | Bắt buộc thấy |
|---|---|
| my turn | pod active + clock/turn text; không chỉ color |
| opponent turn | opponent pod active |
| selected | selected ring + valid hints |
| move pending | controls khóa; state không nhảy |
| last move | from/to markers |
| check | General ring + banner + optional sound |
| urgent | clock danger + pulse hoặc static strong ở reduced-motion |
| opponent away | top banner + countdown |
| expired | banner chờ server; board locked |
| chat unread | badge trên Chat + accessible name |
| reaction picker | popover neo action, trigger expanded state |

### Height adaptation

- Board width quyết định size trước; nếu chiều cao thiếu, giảm gap giữa pod/board/action từ 8 xuống 4.
- Pod có thể compact còn 56 px bằng giảm vertical padding, không giảm avatar dưới 40.
- Action label giữ; không chuyển sang icon-only để tiết kiệm chiều cao.
- Nếu thiết bị rất thấp, cho captured tray ẩn thị giác sau nút mở chi tiết nhưng accessible state vẫn có.

## 8. S7 — Kết quả

- Result modal ở level 4; board closing state vẫn phía sau.
- Glyph pair 52, title 30, reason 14.5, KEN delta 20.
- Win/lose/draw dùng màu semantic nhưng cùng layout.
- Không dùng confetti/particle mặc định; nếu thêm celebration, phải code-native, thời lượng ngắn và reduced-motion tắt.
- Chơi lại gold; Đóng paper.
- Focus chuyển vào modal sau khi kết quả đã được announce; không đọc title/reason lặp.
- Glyph pair vào lệch nhịp nhẹ, sau đó title và summary rise; không dùng particle, và reduced-motion hiển thị trạng thái cuối tức thời.

## 9. S8 — Lịch sử

- Header pattern chuẩn.
- Rows paper/paper-dim, avatar, opponent name, timestamp, outcome chip, KEN delta.
- KEN positive jade, negative danger, zero navy; luôn có sign hoặc label rõ.
- Outcome có text `Thắng/Thua/Hòa`, không chỉ màu.
- Timestamp line tối thiểu `12.5/17`, không opacity dưới `.65` trên paper.
- Empty/loading/error dùng pattern hệ thống.
- Row mount dùng stagger ngắn; loading có spinner CSS kèm live text, empty dùng mark tĩnh sau reduced-motion.

## 10. S9 — Bảng xếp hạng

- Header pattern chuẩn.
- Tab Hôm nay/Tuần này dùng tab semantics.
- Rank column fixed; medal emoji không nên là icon production nếu hình thay đổi theo OS. Có thể dùng số với badge gold/jade hoặc SVG medal đồng hệ.
- Avatar/name flexible; thắng-thua là text; KEN net tabular.
- Top 3 có thể dùng border/accent khác nhưng không đổi anatomy row và không thêm crown/particle ngẫu nhiên.
- Keyboard arrow chuyển tab; list vẫn đọc theo thứ tự DOM.
- Đổi period remount list để row choreography phản ánh đúng tập dữ liệu mới; tab active chỉ scale rất nhẹ, không trượt indicator qua layout.

## 11. Overlay matrix

| Overlay | Anchor | Dismiss | Focus | Live region |
|---|---|---|---|---|
| Confirm modal | center | buttons/Esc theo policy | trap; trả về trigger | dialog title/body |
| Result modal | center | action buttons | trap | assertive/polite một lần |
| Chat drawer | bottom | close/Esc/swipe nếu hỗ trợ | focus input hoặc heading | dialog |
| Reaction picker | action bar | select/outside/Esc | roving focus nếu keyboard | không cần live |
| Toast | bottom above action | auto | không lấy focus | status/alert |
| Turn announce | center overlay | auto | không lấy focus | polite |
| Check banner | board center | auto | không lấy focus | status |
| Opp-away/expired | safe top | state-driven | không lấy focus | status |

Khi modal mở, background inert; toast vẫn có thể render trên modal nhưng không che action hoặc đọc lặp lỗi đã có inline.

## 12. Breakpoints và container

Không tạo desktop layout khác trong v1; chỉ scale/center mobile shell.

```css
.xq-app {
  width: 100%;
  max-width: 520px;
  margin-inline: auto;
}

@media (min-width: 400px) {
  .xq-screen { padding-inline: 20px; }
}
```

### Ma trận kiểm tra

| Viewport | Mục tiêu |
|---|---|
| `360 × 640` | thấp/hẹp; không cắt action, board vẫn thao tác được |
| `390 × 844` | baseline design + screenshot |
| `412 × 915` | Android phổ biến, safe spacing |
| `430 × 932` | iPhone lớn |
| `520 × 900` | max shell; board max 480 |

Landscape không phải layout tối ưu v1 nhưng phải hiện thông báo/scroll an toàn, không làm mất quyền thoát hoặc confirm.

## 13. Safe-area và bàn phím

- Dùng `env(safe-area-inset-top/bottom, 0px)` cho screen, banners và bottom sheet.
- Action bar không nằm dưới home indicator.
- Khi virtual keyboard mở, chat input/modal field phải scroll vào view.
- Không cộng safe-area hai lần ở screen và component con; chỉ lớp sở hữu cạnh viewport cộng inset.
- Toast neo trên action bar + safe-area, không dùng bottom cố định một giá trị ở mọi màn.

## 14. Keyboard navigation

Thứ tự focus bám thứ tự đọc:

1. Header back/action.
2. Nội dung chính theo top-to-bottom.
3. CTA/footer.
4. Overlay mới nhất khi mở.

Yêu cầu:

- Tab/Shift+Tab đi qua mọi control, không đi qua decorative SVG.
- Enter/Space kích hoạt button.
- Arrow keys điều hướng tab; reaction picker có thể dùng arrow theo hàng.
- Esc đóng modal/drawer/popover theo policy.
- Board: tối thiểu mỗi piece/hint là button focusable khi tương tác; tốt hơn là roving tabindex/grid keyboard trong phase accessibility nâng cao.
- Focus không bị mất sau khi list refresh; nếu row biến mất, chuyển focus đến header/list container và announce.

## 15. Screen reader

### Board

- Board có accessible name `Bàn cờ Tướng` và mô tả lượt hiện tại.
- Piece label: `{Tên quân} {phe}, cột {x} hàng {y}`.
- Hint label: `Đi tới cột {x} hàng {y}`.
- Sau move server-confirmed, announce: `{Quân} {phe} từ cột… đến cột…`, thêm `ăn {quân}`/`chiếu tướng` nếu có.
- Không announce animation frames hoặc mỗi giây clock.

### Dynamic UI

- Toast `role=status`; lỗi chặn flow có thể alert.
- Turn/check/result chỉ announce một lần theo sequence ID.
- Chat unread nằm trong accessible name/button description.
- Modal có accessible title/body association, không chỉ `aria-label` chung nếu có heading thật.

## 16. Contrast và non-color cues

- Text thường mục tiêu WCAG AA `4.5:1`.
- Text lớn mục tiêu `3:1` nhưng vẫn ưu tiên `4.5:1` khi palette cho phép.
- UI boundary/focus mục tiêu `3:1` với nền kề.
- Selected: ring + elevation/position.
- Ready/success: chip text + color.
- Error/check: icon/text + border/color.
- Urgent timer: text/rule + color; pulse chỉ là bổ sung.
- Disabled: thuộc tính DOM + opacity; không chỉ đổi màu.

## 17. Text zoom và localization tiếng Việt

- Test browser text zoom `200%` và OS font scaling lớn.
- Không fixed height cho modal body, row có subtitle hoặc error message.
- Button label có thể tăng chiều cao; không dùng `overflow:hidden` cho label hành động.
- Dự phòng dấu và ascender/descender bằng line-height ≥1.25.
- Test các chuỗi: `Bảng xếp hạng`, `Hủy sẵn sàng`, `Đối thủ mất kết nối`, `Bạn đã hết giờ · máy chủ đang đi thay`, `Hết giờ — hệ thống đã đi thay bạn`.
- Dùng ký tự minus `−` hoặc dấu trừ nhất quán; dùng formatter locale cho `1.000`.
- Không viết hoa toàn bộ body text. Uppercase chỉ cho logo/announce ngắn.

## 18. Motion và sensory safety

- Không flash quá 3 lần/giây.
- Check shake biên độ tối đa 2 px; urgent pulse 1 s.
- Reaction float không che board và có giới hạn số lượng.
- Sound/haptic luôn có toggle hoặc theo cài đặt app; không dùng âm thanh làm kênh duy nhất.
- Reduced-motion bỏ shake, pulse, float, stagger và smooth board replay; trạng thái cuối vẫn rõ.

## 19. Accessibility acceptance checklist

- [ ] Toàn flow dùng được bằng keyboard.
- [ ] Focus-visible không bị clip bởi overflow.
- [ ] Modal/drawer trap và restore focus đúng.
- [ ] Mọi icon-only button có accessible name.
- [ ] Tab/toggle/popover có state ARIA.
- [ ] Board move và kết quả có live announcement không lặp.
- [ ] Text zoom 200% không mất action hoặc nội dung.
- [ ] Touch targets tối thiểu 44 px.
- [ ] Thông tin quan trọng không chỉ dựa vào màu/motion/sound.
- [ ] Reduced-motion không còn pulse/shake/float.
- [ ] Kiểm tra ở 360×640 và có virtual keyboard.
