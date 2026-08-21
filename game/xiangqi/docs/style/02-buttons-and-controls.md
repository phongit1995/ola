# 02 — Buttons và interactive controls

## 1. Nguyên tắc chung

Mỗi button phải trả lời được ba câu hỏi mà không cần đoán:

1. Đây có phải hành động chính của vùng hiện tại không?
2. Hành động có phá hủy hoặc làm mất trạng thái không?
3. Button đang ở trạng thái nào: idle, hover, pressed, focused, loading, disabled hay selected?

Một vùng chỉ có tối đa **một CTA vàng**. Modal có một CTA chính ở bên phải. Không dùng màu vàng cho hai hành động ngang cấp trong cùng một nhóm.

## 2. Anatomy chuẩn

```text
┌──────────────────────────────────┐
│  [leading icon]  Label  [badge]  │
└──────────────────────────────────┘
   border 2 px       height ≥48
   radius 16         padding X 22
```

- Label luôn là live text, một dòng ở button chuẩn.
- Khoảng icon → label: `8 px`; icon không có badge thì không để khoảng trống giả.
- Leading icon `20 px` trong button chuẩn, `22 px` trong CTA lớn.
- Spinner thay vị trí icon hoặc nằm trước label; không làm button đổi chiều rộng.
- Button có icon + label không đặt icon bên phải trừ `Tiếp tục`/navigation forward.
- Không đặt cả leading và trailing icon nếu không có lý do điều hướng rõ ràng.

Base class hiện tại:

```css
.xq-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  min-height: 48px;
  padding-inline: 22px;
  border: 2px solid var(--xq-navy);
  border-radius: 16px;
  font: 700 16px/20px var(--xq-font-ui);
  transition: transform 120ms ease, background-color 150ms ease,
    border-color 150ms ease, box-shadow 150ms ease;
}
```

## 3. State model dùng chung

| State | Visual | Hành vi | ARIA/DOM |
|---|---|---|---|
| Idle | màu variant chuẩn | có thể click/tap | `<button type="button">` |
| Hover | surface sáng hơn nhẹ hoặc shadow tăng một mức | chỉ pointer device | `@media (hover:hover)` |
| Pressed | `translateY(1px)`, shadow giảm | action chỉ fire khi release hợp lệ | CSS `:active` |
| Focus-visible | ring gold `2 px`, offset `2 px` | giữ nguyên màu variant | CSS `:focus-visible` |
| Loading | label giữ chỗ, spinner 18–20, không nhận click lặp | không đổi width | `aria-busy="true"`, `disabled` |
| Disabled | opacity `.45`, không shadow nổi, cursor default | không nhận tương tác | thuộc tính `disabled` thật |
| Selected | border/surface thay đổi theo control | click có thể toggle nếu logic cho phép | `aria-pressed` hoặc `aria-selected` |
| Error | không đổi button thành đỏ trừ destructive; lỗi hiển thị cạnh field/toast | cho phép retry | message liên kết bằng `aria-describedby` |

### Focus ring

```css
button:focus-visible,
[role="button"]:focus-visible {
  outline: 2px solid var(--xq-gold);
  outline-offset: 2px;
}
```

Trên button gold, ring vẫn dùng gold nhưng phải có thêm khoảng offset để tách khỏi border gold-deep. Nếu nền xung quanh cũng gold, dùng ring navy `2 px` và outer cream `1 px`.

### Loading

- Không thay label `Bắt đầu` bằng chuỗi dài làm thay width. Có thể hiển thị `Đang bắt đầu…` nếu container đủ rộng và đã reserve width.
- Spinner là SVG `18 × 18`, stroke `2`, dùng `currentColor`.
- Giữ label cho screen reader bằng text thật; nếu label bị ẩn thị giác, dùng utility `sr-only`.
- Sau lỗi, button trở lại idle; lỗi xuất hiện ở toast hoặc field, không giữ spinner.

## 4. CTA vàng — Primary button

Class: `.xq-btn.xq-btn-gold`.

### Khi dùng

- Chơi xếp hạng.
- Tạo bàn / Vào bàn.
- Bắt đầu trận.
- Sẵn sàng.
- Thử lại kết nối.
- Chơi lại.
- Gửi chat nếu đây là action chính duy nhất trong form.
- Xác nhận không destructive.

### Không dùng

- `Hủy`, `Đóng`, `Quay lại`, `Thoát`.
- Hành động phá hủy hoặc bỏ cuộc.
- Tab đang chọn; tab có style active riêng.
- Badge KEN chỉ giống palette, không được nhận anatomy button nếu không click.

### Spec

| Thuộc tính | Giá trị |
|---|---|
| Nền | `linear-gradient(180deg, #FFD34D, #F2B807)` |
| Text/icon | navy |
| Border | gold-deep `2 px` |
| Radius | `16 px` |
| Shadow | `md` |
| Hover | tăng sáng đầu gradient, shadow nhích lên; không glow |
| Pressed | translateY `1 px`, shadow `sm` |
| Focus | ring gold offset `2 px` |
| Disabled | opacity `.45`, bỏ shadow, không đổi sang xám mới |

### Ví dụ

```tsx
<button type="button" className="xq-btn xq-btn-gold" onClick={createRoom}>
  Tạo bàn
</button>
```

## 5. Nút giấy — Secondary button

Class: `.xq-btn.xq-btn-paper`.

### Khi dùng

- Lịch sử, Bảng xếp hạng ở lobby.
- Hủy, Đóng, Thoát khỏi flow không nguy hiểm.
- Mời ra trước bước confirm.
- Hủy sẵn sàng.
- Hành động thứ hai trong modal.

### Spec

| Thuộc tính | Giá trị |
|---|---|
| Nền | paper |
| Text/icon | navy |
| Border | navy `2 px` |
| Radius | `16 px` |
| Shadow | none; hover có `sm` |
| Hover | paper-bright |
| Pressed | paper-dim + translateY `1 px` |
| Focus | gold ring |
| Disabled | opacity `.45` |

Không dùng secondary button trên mặt board nếu làm che nước cờ. Đặt vào panel/action bar.

## 6. Nút danger — Destructive confirmation

Class: `.xq-btn.xq-btn-danger`.

### Chỉ dùng cho bước xác nhận

- Xác nhận `Bỏ cuộc`.
- Xác nhận `Thoát bàn` khi hành động đóng phòng hoặc mất trạng thái.
- Xác nhận `Mời ra` nếu sản phẩm quyết định coi là destructive.

Action bar `Bỏ cuộc` dùng variant cảnh báo nhẹ `.xq-action-danger`; button nền đỏ chỉ xuất hiện trong confirm modal. Điều này tránh người chơi chạm nhầm vào một nút đỏ quá nổi.

### Spec

| Thuộc tính | Giá trị |
|---|---|
| Nền | danger |
| Text/icon | cream |
| Border | red-deep `2 px` |
| Radius | `16 px` |
| Shadow | `sm`; hover `md` |
| Pressed | red-deep nhẹ + translateY `1 px` |
| Focus | gold ring |
| Copy | động từ rõ: `Bỏ cuộc`, `Thoát bàn`; không dùng `OK` |

Modal phải để secondary `Hủy` bên trái, danger bên phải. Focus ban đầu vào danger chỉ khi hành động an toàn và được người dùng chủ động gọi; với bỏ cuộc/thoát, ưu tiên focus `Hủy` để giảm xác nhận nhầm.

## 7. Kích thước button

| Variant | Class | Min-height | Padding X | Font | Icon | Dùng cho |
|---|---|---:|---:|---|---:|---|
| Large | `.xq-btn-big` | 60 | 24 | 17/700 | 22 | CTA lobby/hero |
| Default | `.xq-btn` | 48 | 22 | 16/700 | 20 | form/modal/pregame |
| Small | `.xq-btn-small` | 40 visual, hit ≥44 | 14 | 14/700 | 18 | Gửi chat, action hẹp |

- Không tạo `medium`, `tiny`, `compact-2`.
- Button full-width ở mobile dùng `width:100%` từ layout wrapper, không tạo class màu mới.
- Hai button cạnh nhau phải cùng height; label dài được phép wrap tối đa hai dòng chỉ trong footer đặc biệt, không trong modal chuẩn.

## 8. Icon-only button

Class: `.xq-icon-btn`.

### Dùng cho

- Quay lại.
- Đóng drawer/modal có nút X.
- Bật/tắt âm.
- Làm mới.
- Trang trước/sau.

### Anatomy

| Thuộc tính | Giá trị |
|---|---|
| Hit box | `44 × 44 px` |
| Icon | `20–24 px`, stroke `2 px` |
| Radius | `12 px` |
| Border trên wood | cream 30–40%, `1.5 px` |
| Border trên paper | navy, `1.5 px` |
| Text/icon trên wood | cream |
| Text/icon trên paper | navy |

### State đặc biệt

- Toggle âm thanh dùng `aria-pressed={soundOn}` và icon `volume-on/volume-off`; không đổi chỉ bằng màu.
- Pagination disabled dùng thuộc tính `disabled`; không ẩn icon để layout không nhảy.
- Mọi icon-only button bắt buộc có `aria-label` mô tả hành động, không mô tả hình: `Quay lại`, không phải `Mũi tên trái`.
- Tooltip desktop có thể hiện sau `500 ms`; mobile không phụ thuộc tooltip để hiểu.

```tsx
<button type="button" className="xq-icon-btn" aria-label="Quay lại">
  <Icon name="arrow-left" aria-hidden="true" />
</button>
```

## 9. Action tile ở bàn chơi

Class: `.xq-action`; destructive hint: `.xq-action-danger`.

Action tile luôn có icon và label. Đây là navigation/action phụ, không phải CTA.

| Thuộc tính | Giá trị |
|---|---|
| Min box | `64 × 56 px` |
| Layout | cột, center |
| Icon | `24 px` |
| Label | `11/14/600` |
| Gap | `2–4 px` |
| Radius | `12 px` |
| Border | cream 25%, `1.5 px` |
| Idle text | cream |
| Hover/active | background cream 8–12%, border cream 45% |

### Bốn action chuẩn

| Action | Icon | Màu | Badge/state |
|---|---|---|---|
| Chat | `ic-chat` | cream | chấm danger `8 px` khi unread; `aria-label` thêm số chưa đọc nếu có |
| Cảm xúc | `ic-reaction` | cream | `aria-expanded` và `aria-controls` khi picker mở |
| Bỏ cuộc | `ic-flag` | danger-soft/cream | chỉ cảnh báo nhẹ; click mở confirm danger |
| Thoát | `ic-exit-door` | cream | click mở confirm khi đang chơi |

Không dùng các emoji `💬 😊 🏳️ 🚪` trong production. Chúng chỉ được coi là placeholder cần thay bằng SVG theo `04-icon-system.md`.

### Unread badge

- Chấm `8 × 8`, danger, ở góc trên phải nhưng không đè lên icon.
- Nếu cần số, dùng pill min-width `18`, font `11/700`, tối đa hiển thị `9+`.
- Badge có `aria-hidden`; thông tin được đưa vào accessible name của button.

## 10. Tabs

Class: `.xq-tab`; active: `.xq-tab-active`.

| State | Nền | Text | Border |
|---|---|---|---|
| Idle | transparent | cream | cream 35% `1.5 px` |
| Hover | cream 8% | cream | cream 55% |
| Active | gold | navy | gold-deep |
| Focus | giữ state + gold/navy focus ring theo nền | — | — |
| Disabled | opacity `.45` | — | — |

- Container có `role="tablist"`.
- Mỗi tab có `role="tab"`, `aria-selected`, `aria-controls`.
- Active không chỉ dựa vào màu: dùng nền đặc và weight `700`.
- Phím trái/phải đổi focus giữa tab; Enter/Space kích hoạt nếu không auto-activate.
- Chiều cao `40 px` visual, hit area tối thiểu `44 px` bằng padding/container.

## 11. Quick-select chips

Class: `.xq-chip-btn`; active: `.xq-chip-btn-active`.

Dùng cho mức cược `Giao hữu`, `100`, `500`, `1.000`… và các lựa chọn ngắn trong form. Không dùng chip thay CTA.

| Thuộc tính | Idle | Active |
|---|---|---|
| Nền | cream | gold |
| Text | navy | navy |
| Border | navy `1.5 px` | gold-deep `1.5 px` |
| Radius | `8 px` | `8 px` |
| Padding | `6 × 12 px`, hit wrapper ≥44 | như idle |
| Font | `13/700`, số tabular | như idle |

- Dùng `aria-pressed` cho lựa chọn đơn giản hoặc radio semantics cho một tập độc quyền.
- Label số phải dùng cùng formatter với input và kết quả.
- Chip active vẫn phải có focus ring riêng khi keyboard focus.

## 12. Inline/text action

Class hiện tại: `.xq-exit-link`.

Chỉ dùng cho hành động hạ cấp như `Thoát game` ở cuối lobby. Không dùng text link để xác nhận destructive trong modal.

- Min hit height `44 px` dù text nhìn nhỏ.
- Text cream 75%, font `13–14/600`.
- Hover: cream 100%, underline `1 px` với offset `3 px`.
- Focus: gold ring hoặc underline gold đủ rõ.
- Không dùng opacity dưới `.65` cho text tương tác.

## 13. Reaction buttons

Reaction picker chứa nút `40 × 40 px` nhưng hit target phải được nâng lên tối thiểu `44 × 44 px`.

- Production dùng asset reaction đã duyệt; icon action mở picker vẫn dùng `ic-reaction.svg`.
- Mỗi reaction có `aria-label` tiếng Việt rõ (`Cười`, `Bất ngờ`, `Vỗ tay`…), không dùng enum kỹ thuật làm label.
- Hover/keyboard focus: background wood 8%, scale tối đa `1.05`; reduced-motion bỏ scale.
- Selected/tapped: pressed `scale(.96)` 80–120 ms, sau đó picker đóng.
- Không tạo một vòng glow/màu riêng cho từng emoji.

## 14. Board controls

### Piece button

Class: `.xq-piece` cùng modifier `red/black/selected/capture-hint/checked`.

- Visual diameter khoảng `0.92 × cell`; hit area ít nhất `44 × 44 px`.
- Selected: nâng `3 px`, ring gold `3 px`, z-index tăng; không đổi glyph.
- Capture target: ring red `3 px`; không render thêm chấm jade trên quân.
- Checked general: pulse red; reduced-motion giữ ring red tĩnh.
- Locked/pending: `disabled`; không làm mờ riêng từng quân nếu toàn board có scrim/status.
- Accessible label phải có tên quân, phe và vị trí hiển thị: `Xe đỏ, cột 1 hàng 10`.

### Move hint

Class: `.xq-hint-dot`.

- Hit box `44 × 44`; visual dot `13 × 13` jade 85%.
- Focus ring phải bao hit box hoặc vẽ vòng `24 px`, không chỉ focus chấm 13 px.
- `aria-label`: `Đi tới cột {x} hàng {y}`.
- Không dùng animation lấp lánh hoặc particle.

## 15. Quy tắc chọn variant

```text
Hành động có phá hủy/mất trạng thái?
├─ Có → action nhẹ mở ConfirmModal → Danger chỉ ở bước xác nhận
└─ Không
   ├─ Là hành động chính duy nhất của vùng? → CTA vàng
   ├─ Là hành động hỗ trợ có label? → Nút giấy
   ├─ Chỉ có icon quen thuộc và đủ aria-label? → Icon button
   ├─ Nằm trong action bar bàn chơi? → Action tile
   ├─ Chọn một view ngang cấp? → Tab
   └─ Chọn giá trị ngắn trong form? → Quick-select chip
```

## 16. Copywriting cho button

- Dùng động từ trực tiếp: `Tạo bàn`, `Vào bàn`, `Bắt đầu`, `Thử lại`, `Bỏ cuộc`.
- Không dùng `OK`, `Yes`, `Submit`, `Continue` lẫn tiếng Anh.
- Label 1–3 từ; chỉ dài hơn khi tránh mơ hồ (`Hủy sẵn sàng`).
- Loading dùng động từ đang diễn ra: `Đang tạo…`, `Đang vào…`, `Đang gửi…`.
- Destructive label trong confirm phải khớp hành động mở modal.
- Dấu ba chấm dùng ký tự `…`, chỉ khi có bước tiếp theo hoặc đang chờ; không thêm vào CTA thực thi ngay.

## 17. Checklist button/control

- [ ] Đúng variant theo decision tree.
- [ ] Chỉ một CTA vàng trong vùng.
- [ ] Hit target ≥44 × 44 px.
- [ ] Có idle, hover, pressed, focus-visible, disabled và loading nếu có async.
- [ ] Toggle có `aria-pressed`; tab có `aria-selected`; popover trigger có `aria-expanded`.
- [ ] Icon-only có `aria-label` là hành động.
- [ ] Không dùng emoji hệ điều hành.
- [ ] Loading không làm thay đổi chiều rộng/layout.
- [ ] Label tiếng Việt không bị cắt tại 360 px hoặc text zoom 200%.
- [ ] Destructive luôn qua confirm nếu có thể mất trận/phòng/trạng thái.
