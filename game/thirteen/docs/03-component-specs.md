# 03 — Component specifications

## 1. Quy ước chung

Mọi component tương tác phải có đủ:

- default;
- hover khi có pointer;
- pressed;
- keyboard focus-visible;
- disabled;
- loading nếu có async action;
- semantic error/success nếu phù hợp.

Touch target tối thiểu 44 × 44 px. Phần nhìn thấy có thể nhỏ hơn nhưng hit area không được nhỏ hơn.

Mọi label, số và nội dung thay đổi là live text. Component production ưu tiên CSS/SVG, không raster skin.

## 2. Token kích thước

```css
--control-h-sm: 40px;
--control-h-md: 48px;
--control-h-lg: 56px;
--control-h-xl: 72px;

--space-1: 4px;
--space-2: 8px;
--space-3: 12px;
--space-4: 16px;
--space-5: 20px;
--space-6: 24px;
--space-8: 32px;
```

## 3. Button family

### 3.1 Cấu tạo

Button chỉ gồm:

1. background fill;
2. navy border;
3. optional icon;
4. live label/subtitle;
5. short bottom shadow.

Không có viền trong, bevel, highlight rim, texture hoặc ornament.

### 3.2 Primary Sun

Dùng cho hành động tiến tới: chơi ngay, tạo/xác nhận, sẵn sàng, bắt đầu, đánh, chơi tiếp, gửi.

```css
background: linear-gradient(180deg, #FFD867 0%, #FFC83D 68%, #F7B725 100%);
color: var(--navy-900);
border: 2px solid var(--navy-800);
border-radius: var(--radius-md);
box-shadow: var(--shadow-control);
font-weight: 800;
```

State:

- hover: tăng lightness phần trên 3%, translateY -1 px nếu pointer chính xác;
- pressed: translateY 2 px, shadow none, fill `sun.500`;
- focus: outer ring `0 0 0 3px cream.50, 0 0 0 6px focus.ring`;
- disabled: `cream.200`, border navy 45%, text navy 58%, no shadow;
- loading: spinner navy 16–18 px, giữ label hoặc label trạng thái.

### 3.3 Secondary Cream

Dùng cho hủy, bỏ lượt, rời bàn, tạo bàn riêng, icon control.

- fill `cream.50`;
- border navy 2;
- text navy;
- shadow control;
- hover `cream.100`;
- pressed `cream.200`;
- không gradient.

### 3.4 Soft Aqua

Dùng cho trạng thái “Đang chơi”, filter/chip active hoặc hành động cấp thấp tích cực.

- fill `aqua.100`;
- border `teal.700` 2 px;
- text navy;
- shadow none hoặc 0 2 px 0 teal 15%;
- không dùng cho CTA quan trọng nhất màn.

### 3.5 Danger

Dùng khi hành động gây mất state/rời bàn cần nhấn mạnh.

- mặc định nên là cream với text/icon `coral.500`;
- confirm destructive có thể fill `coral.400`, text `navy.900` hoặc cream tùy contrast;
- luôn có icon/label cụ thể, không dùng đỏ chung chung;
- focus ring vẫn blue, không coral.

### 3.6 Size

| Family | Height | Padding X | Radius | Text |
|---|---:|---:|---:|---|
| compact | 40 | 12 | 12 | 13/16 800 |
| standard | 48 | 16 | 16 | 15/20 800 |
| large | 56 | 20 | 16 | 17/22 800 |
| hero | 72 | 20 | 20 | 20/25 800 + subtitle 12/16 |

Icon gap 8 px. Button chỉ icon dùng width bằng height.

### 3.7 Nội dung dài

- label một dòng;
- truncate chỉ với action động; label cố định phải fit;
- không giảm font dưới 13 px;
- subtitle hero tối đa một dòng;
- locale khác dài hơn 30% phải tăng width hoặc cho layout stack, không ép chữ.

## 4. Icon button

- 44 × 44 mặc định;
- 40 × 40 cho refresh trong list nếu hit area bọc đủ 44;
- cream fill;
- navy border 2;
- radius 12;
- icon 22–24;
- shadow control;
- aria-label bắt buộc;
- tooltip chỉ desktop, không thay aria-label.

Các icon chuẩn:

| Tên | Hình học |
|---|---|
| back | shaft 16 px, chevron 8 px, hướng trái |
| chat | rounded speech box + 3 dot |
| refresh | cung 280° + arrowhead, không vòng tròn kín |
| lock | shackle + body, fill none |
| close | hai nét chéo, optical size 18 |
| send | paper plane đơn nét hoặc arrow right |
| kick | user-minus, tránh boot/violence icon |
| crown | ba đỉnh đơn giản, fill sun optional |

## 5. Balance pill

- height 44;
- width theo số, min 142, max 188;
- cream fill, navy border 2, radius pill;
- avatar 34, margin 3; render ảnh VIP của user theo catalog chung, fallback mặt cười Ola;
- number flex 1, right aligned hoặc center optical;
- `font-variant-numeric: tabular-nums`;
- icon 20–22 × 20–22: tái sử dụng Ken PNG vàng chính thức `web/src/assets/icons/apps/ken.png`; không dựng sun circle/coin thay thế;
- khi số quá dài: format compact chỉ khi product cho phép; nếu không giảm font tối thiểu 14 px.

## 6. Avatar

Size:

| Class | Visible | Hit/slot |
|---|---:|---:|
| `tl-avatar-sm` | 34 | 36 |
| default | 48 | 50 |
| `tl-avatar-md` | 52 | 56 |
| `tl-avatar-lg` | 60 | 64 |

Layers:

1. color gradient circle;
2. white initial;
3. cream ring 3 px;
4. navy outline 2 px;
5. short navy shadow.

Initial:

- một ký tự Unicode đầu đã uppercase;
- center quang học, có thể translateY -1 px;
- size 44–50% avatar diameter;
- font weight 800.

Không dùng ảnh sinh chân dung. Nếu product thêm ảnh người dùng sau này, crop cover trong cùng ring.

## 7. Turn ring

- wrapper lớn hơn avatar 8 px;
- track cream 70%;
- conic progress sun;
- thickness 4 px;
- navy outer outline 1 px;
- progress bắt đầu tại 12 giờ;
- update tối đa 10 FPS để đủ mượt và nhẹ;
- urgent: progress coral, không nhấp nháy nhanh hơn 700 ms;
- finish: ring ẩn hoặc giữ 0, không quay vô hạn.

## 8. Nameplate

- min-height 28;
- min-width 72, max-width 132;
- cream fill;
- navy border 1.5–2;
- radius pill;
- padding 2 10;
- text 13/18 weight 800;
- ellipsis;
- shadow `0 2px 0 rgba(8,46,74,.14)`;
- tên không uppercase tự động.

Local nameplate có thể liền avatar bằng overlap -6 px nhưng border phải sạch, không tạo đường đôi lộn xộn.

## 9. Badge và status chip

### 9.1 Base

- min-height 22;
- padding 2 8;
- radius pill;
- border 1.5 px;
- label 11/15 weight 800;
- không shadow trừ badge nổi trên avatar.

### 9.2 Variants

| Variant | Fill | Border | Text/Icon |
|---|---|---|---|
| neutral | cream.200 | navy.700 45% | navy.800 |
| success | aqua.100 | teal.700 | teal.700/navy |
| owner/gold | sun.300 | navy.800 | navy.900 |
| danger | coral.300 28% | coral.500 | coral.500 |
| playing | coral.400 | navy.800 | cream.50 hoặc navy theo contrast |

Badge không được chỉ là một chấm màu nếu trạng thái quan trọng.

## 10. Seat dots

- dot diameter 9 px lobby, 10 px nếu độc lập;
- gap 4 px;
- filled `aqua.500`;
- empty `aqua.100`;
- empty có border `teal.600` 15% nếu nền cream;
- tối đa 4 dot;
- occupancy số luôn đi kèm để screen reader và người khó phân biệt màu đọc được.

## 11. Room row

### 11.1 Geometry

- min-height 78;
- cream fill;
- navy border 2;
- radius 16;
- shadow control;
- padding 10–12;
- column avatar 48, info flexible, action 84–96.

### 11.2 State rules

- default không tint;
- hover chỉ đổi cream rất nhẹ;
- focus-within outer blue ring;
- playing/full không đặt `opacity` lên row;
- locked giữ nội dung đầy đủ, thêm lock;
- meta luôn gồm occupancy và wager pill; wager `0` vẫn hiển thị;
- wager pill dùng icon Ken 15 px, nền sun alpha nhẹ, số tabular; không viết thêm chữ “Ken” để row không chật;
- nếu `bet > user.ken`, row giữ nguyên độ tương phản nhưng action chuyển coral nhạt, label “Thiếu Ken” và bị disable;
- stale/loading dùng skeleton có cùng geometry, không spinner ở mỗi row.

### 11.3 Skeleton

- avatar circle `cream.300`;
- hai bar 42% và 28% width;
- action block 84 × 40;
- shimmer optional 1.2 s; reduced motion dùng fill tĩnh;
- skeleton không có border navy đậm bên trong từng bar.

## 12. Section header

- height 40–44;
- title 17/22 weight 800 navy;
- count teal;
- action phải là icon button;
- không divider chạy toàn width nếu đã có khoảng trắng.

## 13. Modal

### 13.1 Shell

- cream fill;
- navy border 2;
- radius 20;
- shadow overlay;
- padding 20;
- max-width 350;
- max-height theo viewport;
- content scroll, title/action cố định nếu nội dung dài.

### 13.2 Header

- title 20/26 weight 800;
- close icon 40 × 40 khi modal có close trực tiếp;
- title center nếu không close, left nếu có close;
- coral handle/underline chỉ dùng một, không cả hai.

### 13.3 Backdrop

- navy alpha 38%;
- optional blur 3 px;
- fade 180 ms;
- click ngoài và Escape theo product behavior;
- focus không thoát khỏi modal.

## 14. Input

### 14.1 Text/password

- height 46;
- fill cream.50;
- border navy 2;
- radius 12;
- padding 0 12;
- font 15/20 weight 700;
- caret teal.700;
- placeholder navy 52%;
- focus ring blue;
- error border coral.500 + helper text;
- disabled cream.200, text navy 55%.

### 14.2 Wager/Ken

- shell height 48, border navy 2, radius 12;
- grid icon Ken 26 px / input co giãn / suffix “KEN”;
- giá trị mặc định `0`, chỉ nhận chữ số và format hiển thị theo `vi-VN`;
- helper 12/17 teal; validation error dùng coral nhưng không đổi geometry;
- kiểm tra số nguyên an toàn, không âm, không vượt `user.ken` và `user.maxBet` nếu có;
- state invalid phải có cả màu, nội dung lỗi và `aria-invalid`; submit bị disable.

### 14.3 Chat input

- height 44;
- flex 1;
- border 1.5–2;
- radius 12;
- không shadow;
- IME Vietnamese không bị submit khi đang composition;
- Enter send, Shift+Enter chỉ khi hỗ trợ multiline.

## 15. Capacity segment

- mỗi item height 44;
- min-width 64;
- cream fill/navy border 2;
- active aqua.100 hoặc sun.300;
- active border 3 hoặc check 14 px;
- radius 12;
- group gap 8;
- label bao gồm số và “người” nếu đủ chỗ; nếu chỉ số, group có field label rõ.

## 16. Seat card phòng chờ

### 16.1 Occupied

- cream fill/navy border 2/radius 18;
- min-height 126;
- avatar 60;
- name 15/20;
- badge 22;
- owner accent sun 4 px ở cạnh trên hoặc crown, không cả ornament lớn;
- kick 32 visible, hit target 44 bằng pseudo-element/wrapper.

### 16.2 Empty

- transparent hoặc aqua.100 30%;
- dashed navy border 2;
- plus circle 42;
- label navy 65%;
- hover/focus đổi fill cream 25% nếu seat có thể mời/chọn.

## 17. Chat panel

- cream surface;
- navy border 2;
- radius 16 hoặc top 24 cho bottom sheet;
- log background transparent;
- row separator chỉ khi cần;
- reaction tiles 44;
- scrollbar teal alpha;
- không dùng dark chat panel.

## 18. Table center

Không có raster skin.

- transparent;
- optional dashed cream outline 2;
- radius 18;
- min touch/pointer events none cho vùng hiển thị;
- trick cards là asset hiện tại;
- owner/hint là live chip.

## 19. Card presentation

### 19.1 Existing cards

- không recolor mặt bài;
- không đặt filter làm trắng/ấm;
- giữ aspect ratio;
- `object-fit: contain`;
- border radius theo asset, không clip rank/suit.

### 19.2 Hand card

- shadow navy 20%;
- hover desktop translateY -4;
- selected translateY -14;
- selected thêm outer sun 3 px nhưng không che mặt bài;
- disabled/input locked không chuyển grayscale;
- focus keyboard outline blue 3 px.

### 19.3 Trick card

- animation 250 ms;
- không bounce quá 1.03 scale;
- overlap không che hoàn toàn rank của lá dưới khi combo cần đọc;
- z-order theo thứ tự play.

### 19.4 Card back mini

- ưu tiên `assets/cards/back.webp` hiện có;
- nếu thay, thiết kế flat teal với diamond pattern cream 8%, navy outline;
- không có logo/text;
- không đổi đồng thời với mặt bài nếu chưa QA cả bộ.

## 20. Action bar

- transparent;
- display flex;
- gap 12;
- padding ngang 20;
- button flex 1;
- max button width 180 tại màn rộng;
- sticky bottom, safe area;
- không có frame hoặc gradient panel lớn.

## 21. Toast

- cream fill;
- navy border 2;
- left semantic stripe 5;
- radius 14;
- shadow panel;
- padding 10 12;
- max width 342;
- icon 18 optional;
- text 13–14;
- close icon chỉ nếu toast persistent;
- auto dismiss ≥4 s cho nội dung thường, không tự đóng lỗi cần hành động.

## 22. Result panel và row

Result panel theo modal shell nhưng radius 24. Result row:

- height ≥58;
- radius 14;
- border 1.5;
- place 32 px column;
- avatar 36;
- name flexible;
- badge/result right;
- first dùng sun tint;
- me dùng aqua tint;
- last dùng coral tint nhẹ;
- không huy chương 3D hoặc confetti mặc định.

## 23. Empty, error và offline

### Empty

- icon outline 48–64;
- title/body navy;
- CTA sun/cream;
- không illustration raster bắt buộc.

### Error

- coral icon/left stripe;
- message navy;
- action rõ;
- không nền đỏ toàn panel.

### Offline

- coral pill;
- wifi-off icon;
- countdown;
- aria-live polite/appropriate;
- không khóa màn nếu gameplay vẫn có thể hiển thị.

## 24. Focus và accessibility

Focus chuẩn:

```css
:focus-visible {
  outline: 3px solid #6988F5;
  outline-offset: 3px;
}
```

- không xóa outline nếu chưa có thay thế;
- thứ tự tab theo thứ tự đọc;
- icon-only có accessible name;
- color không phải tín hiệu duy nhất;
- live timer không announce mỗi giây;
- toast/error quan trọng dùng `aria-live` phù hợp;
- modal dùng `role="dialog"`, `aria-modal="true"` và labelled-by.

## 25. Mapping class chính

| Class hiện tại | Component Style 02 |
|---|---|
| `tl-icon-btn` | Icon Button Cream |
| `tl-ken-pill` | Balance Pill |
| `tl-play-now` | Primary Sun Hero |
| `tl-secondary-btn` | Secondary Cream Large |
| `tl-room-row` | Room Row |
| `tl-btn-gold` | Primary Sun |
| `tl-btn-ghost` | Secondary Cream |
| `tl-btn-disabled` | Disabled button state |
| `tl-modal` | Cream Modal |
| `tl-capacity-btn` | Capacity Segment |
| `tl-seat` | Waiting Seat Card |
| `tl-seat-empty` | Empty Dashed Seat |
| `tl-room-chat` | Cream Chat Panel |
| `tl-avatar` | Flat Color Avatar |
| `tl-turn-ring` | Sun/Coral Conic Ring |
| `tl-opponent-name` | Cream Nameplate |
| `tl-pass-chip` | Neutral Status Chip |
| `tl-away-badge` | Danger Status Chip |
| `tl-table-center` | Transparent Trick Zone |
| `tl-action-bar` | Transparent Action Layout |
| `tl-chat-panel` | Cream Bottom Sheet |
| `tl-result-card` | Cream Result Modal |
| `tl-result-row` | Flat Ranking Row |
| `tl-toast` | Cream Semantic Toast |

Mapping đầy đủ từng class nằm trong `06-screen-to-asset-map.md`.

## 26. Component QA

- [ ] cùng family có cùng border 2 px;
- [ ] radius chỉ dùng scale được duyệt;
- [ ] pressed không tạo layout shift ngoài translate;
- [ ] disabled vẫn đọc được;
- [ ] focus-visible rõ trên cream, aqua và sun;
- [ ] label không bake vào ảnh;
- [ ] shadow đúng một trong ba token;
- [ ] không xuất hiện bevel/glow/text shadow;
- [ ] touch target ≥44;
- [ ] text dài và tên 16 ký tự không phá layout;
- [ ] state không phụ thuộc riêng màu;
- [ ] reduced motion hoạt động.
