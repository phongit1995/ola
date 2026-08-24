# 01 — Foundations và design tokens

## 1. Ý đồ thị giác

“Mộc bản thủ công” mô phỏng cảm giác một bộ cờ được in và đóng thủ công: nền gỗ trầm, giấy ngà, son đỏ, mực đen và một lượng nhỏ vàng mù tạt. Đây là UI game hiện đại lấy cảm hứng từ kỹ thuật in mộc bản, không phải giao diện giả cổ.

Ba lớp thị giác:

1. **Lớp nền:** wood tối, độ chi tiết thấp, giữ vai trò sân khấu.
2. **Lớp thao tác:** paper/cream, outline navy, hình học đều và dễ đọc.
3. **Lớp nhấn:** gold cho hành động/lượt, red cho phe Đỏ hoặc nguy hiểm, jade cho thành công/hợp lệ.

Khi có xung đột, thứ tự ưu tiên là: khả năng đọc → trạng thái game → thao tác → chất liệu trang trí.

## 2. Token màu cơ sở

| Token | Giá trị | Vai trò duy nhất |
|---|---:|---|
| `--xq-wood-900` | `#3E2A1E` | nền sâu, đáy màn, vùng sau modal |
| `--xq-wood-700` | `#5C3E2A` | nền trên, surface gỗ, khung lớn |
| `--xq-wood-500` | `#8B5E3C` | cạnh gỗ, separator, khung bàn |
| `--xq-paper` | `#F3E4C3` | panel, mặt bàn, secondary button |
| `--xq-paper-dim` | `#E8D5AE` | hàng xen kẽ, surface hạ cấp |
| `--xq-paper-bright` | `#FFFBEF` | input, chat bubble, mặt quân |
| `--xq-cream` | `#FFF6E3` | text trên wood/navy/red |
| `--xq-navy` | `#1F2A44` | outline và text chính trên paper |
| `--xq-line` | `#6B4A2F` | đường bàn cờ và chi tiết mực nâu |
| `--xq-ink` | `#1B1B1F` | phe Đen, text có độ tương phản cao |
| `--xq-red` | `#C0392B` | phe Đỏ, check, accent nguy hiểm có kiểm soát |
| `--xq-red-deep` | `#8F1D12` | viền/chữ quân Đỏ, cạnh danger |
| `--xq-gold` | `#F2B807` | CTA chính, lượt của mình, selected |
| `--xq-gold-light` | `#FFD34D` | đầu gradient CTA, không dùng làm text |
| `--xq-gold-deep` | `#B98700` | viền CTA, active edge |
| `--xq-jade` | `#216647` | thành công, sẵn sàng, nước đi hợp lệ |
| `--xq-danger` | `#AD2934` | lỗi, timer gấp, destructive action |
| `--xq-danger-soft` | `#FFB1A6` | icon/label cảnh báo trên nền wood tối |
| `--xq-overlay` | `rgba(31,26,20,.62)` | backdrop modal |

Không thêm màu hex trực tiếp trong component nếu màu đó có vai trò lặp lại. Tạo token semantic trước, ghi lý do vào changelog/ticket, rồi mới dùng.

## 3. Token semantic

```css
:root {
  --xq-surface-app: var(--xq-wood-900);
  --xq-surface-app-raised: var(--xq-wood-700);
  --xq-surface-panel: var(--xq-paper);
  --xq-surface-panel-muted: var(--xq-paper-dim);
  --xq-surface-input: var(--xq-paper-bright);

  --xq-text-on-dark: var(--xq-cream);
  --xq-text-primary: var(--xq-navy);
  --xq-text-strong: var(--xq-ink);
  --xq-text-muted-dark: rgba(255, 246, 227, .70);
  --xq-text-muted-light: rgba(31, 42, 68, .70);

  --xq-border-strong: var(--xq-navy);
  --xq-border-on-dark: rgba(255, 246, 227, .30);
  --xq-border-subtle: rgba(31, 42, 68, .35);

  --xq-action-primary: var(--xq-gold);
  --xq-action-primary-edge: var(--xq-gold-deep);
  --xq-action-danger: var(--xq-danger);
  --xq-action-danger-soft: var(--xq-danger-soft);
  --xq-action-success: var(--xq-jade);

  --xq-state-turn: var(--xq-gold);
  --xq-state-check: var(--xq-red);
  --xq-state-valid: var(--xq-jade);
  --xq-state-last-move: rgba(242, 184, 7, .45);
  --xq-state-scrim: var(--xq-overlay);
}
```

### Ghép màu bắt buộc

| Nền | Text/icon | Border | Không được dùng |
|---|---|---|---|
| wood 700/900 | cream | cream 30% hoặc navy khi có surface sáng | red làm body text |
| paper/paper-dim | navy hoặc ink | navy | gold làm body text |
| gold | navy | gold-deep | cream/white làm text nhỏ |
| red/danger | cream | red-deep | gold làm text |
| jade | cream | jade hoặc navy | red đi cùng trong cùng chip |
| navy | cream | cream 30% | ink/wood text |

Màu không phải kênh thông tin duy nhất. Selected cần thêm border/position; lỗi cần icon hoặc text; lượt cần label/clock ngoài màu.

## 4. Typography

### Font stack

```css
--xq-font-ui: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
  "Helvetica Neue", Arial, sans-serif;
--xq-font-glyph: "Songti SC", "Noto Serif TC", "Noto Serif SC",
  SimSun, serif;
```

- UI tiếng Việt chỉ dùng `--xq-font-ui`; không thêm font viết tay cho heading.
- Chữ Hán trên quân dùng `--xq-font-glyph`, weight `700`.
- Số KEN và đồng hồ dùng `font-variant-numeric: tabular-nums`.
- Không dùng text-shadow, text outline hoặc texture bên trong glyph.
- Tất cả dấu tiếng Việt phải được kiểm tra ở `100%` và `200%` zoom.

### Type scale tại viewport 390 px

| Token gợi ý | Size / line-height / weight | Dùng cho |
|---|---|---|
| `display` | `30 / 36 / 800`, tracking `.10em` | kết quả, logo game |
| `title` | `24 / 30 / 800` | tiêu đề màn |
| `announce` | `20 / 26 / 800`, tracking `.04em` | lượt, chiếu |
| `clock` | `22 / 26 / 800`, tabular | đồng hồ lượt |
| `button-lg` | `17 / 22 / 700` | CTA lớn |
| `button` | `16 / 20 / 700` | button mặc định |
| `body` | `15 / 22 / 500–600` | nội dung chính |
| `label` | `13.5 / 18 / 600` | field label, metadata |
| `caption` | `12 / 16 / 500–700` | chip, action label, timestamp |
| `micro` | `11 / 14 / 600` | badge nhỏ; không dùng cho body |

Text được phép tăng theo cài đặt hệ thống đến 200%. Không khóa chiều cao cho vùng chứa body text; button một dòng được phép tăng chiều cao thay vì cắt chữ.

## 5. Spacing và layout grid

Base unit là `4 px`; bố cục chính theo nhịp `8 px`.

| Token | px | Dùng cho |
|---|---:|---|
| `space-0` | 0 | reset |
| `space-0-5` | 2 | icon/label rất gần |
| `space-1` | 4 | nội bộ badge, action bar |
| `space-2` | 8 | gap component nhỏ |
| `space-3` | 12 | padding field, gap button/modal |
| `space-4` | 16 | padding card, gap section |
| `space-5` | 20 | padding modal |
| `space-6` | 24 | section lớn |
| `space-8` | 32 | khoảng tách khối |
| `space-10` | 40 | empty state |
| `space-12` | 48 | nhịp màn lớn |
| `space-16` | 64 | chiều cao pod/CTA lớn |

Quy tắc:

- Lề ngang màn tại `360–399`: `15 px`; tại `400–520`: `20 px`.
- Không tạo gap `5/7/9/11/13 px` trừ căn quang học icon tối đa `1 px` và phải có comment.
- Một component dùng cùng padding ở các instance; không sửa riêng bằng selector theo màn nếu không có variant rõ tên.
- Baseline label và icon được căn quang học, nhưng box vẫn nằm trên lưới pixel nguyên.

## 6. Kích thước tương tác

| Token | Giá trị | Áp dụng |
|---|---:|---|
| `control-sm` | `40 px` visual, hit area ≥44 | nút gửi, reaction |
| `control-md` | `48 px` | input, button chuẩn |
| `control-lg` | `60 px` | CTA lobby |
| `icon-hit` | `44 × 44 px` | mọi icon-only button |
| `action-tile` | `min 64 × 56 px` | action bar bàn chơi |
| `board-hit` | `44 × 44 px` | quân và giao điểm |

Touch target tối thiểu là `44 × 44 px`, kể cả khi hình nhìn thấy nhỏ hơn. Hai hit area không được chồng tới mức thao tác mơ hồ; riêng giao điểm bàn cờ chọn target có tâm gần nhất.

## 7. Radius, border và separator

### Radius cố định

| Token | px | Dùng cho |
|---|---:|---|
| `radius-sm` | 8 | chip chọn, marker, tooltip |
| `radius-md` | 12 | input, icon button, row, banner |
| `radius-lg` | 16 | CTA, pod, card |
| `radius-xl` | 20 | modal, bottom sheet |
| `radius-2xl` | 28 | hero/result panel nếu cần |
| `radius-round` | 999 | quân, avatar, pill |

Không tạo radius mới. Component nested phải có radius trong nhỏ hơn radius ngoài tối thiểu `4 px`.

### Border

- `1 px`: separator hoặc row rất nhẹ; không dùng làm outline interactive trên nền phức tạp.
- `1.5 px`: input, chip, icon button, pod.
- `2 px`: CTA, modal, panel chính, focus/selected ring.
- `3 px`: biên bàn cờ và capture/check ring.
- Border interactive dùng navy/gold-deep/red-deep; không dùng nhiều màu trên cùng component.

## 8. Shadow và độ sâu

```css
--xq-shadow-sm: 0 1px 2px rgba(31, 42, 68, .25);
--xq-shadow-md: 0 3px 8px rgba(31, 42, 68, .30);
--xq-shadow-lg: 0 10px 28px rgba(0, 0, 0, .38);
```

- `sm`: badge nổi hoặc mini-piece.
- `md`: CTA, quân cờ, active surface.
- `lg`: modal/result và quân selected.
- Không stack quá hai shadow.
- Không dùng shadow màu ngẫu nhiên. Gold/red glow chỉ dùng cho `turn` và `check`, blur tối đa `6 px`.
- Pressed state dùng dịch `1 px`, không tạo bevel mới.

## 9. Chất liệu và texture

### Nền gỗ

- Base là gradient `180deg` từ wood-700 đến wood-900.
- Thớ mịn giữ alpha `3–5%`; mối ghép ván dùng nhịp rộng `80–96 px` và tương phản cao hơn để còn đọc được sau khi render trên mobile.
- Vân chạy cùng một hướng trên toàn màn; không đổi hướng giữa các panel.
- Không có mắt gỗ lớn ngay sau chữ hoặc icon.
- Có thể dùng viền khắc chìm và inlay vàng rất nhẹ ở mép screen; không biến thành khung trang trí dày hoặc cạnh tranh với nội dung.

### Giấy

- Base là `--xq-paper`; input dùng `--xq-paper-bright`.
- Fiber/noise tối đa `2–3%`, kích thước nhỏ và đều.
- Bàn cờ có thể rõ texture hơn panel một mức nhưng đường lưới luôn sắc.

### Dấu in mộc bản

- Chỉ được phép trên mảng trang trí lớn, logo hoặc illustration không chứa dữ liệu.
- Không random distress riêng cho mỗi nút/icon; điều đó tạo cảm giác asset rời rạc và AI-generated.
- Không làm mất đoạn stroke quan trọng hoặc dấu tiếng Việt.

## 10. Motion tokens

| Token | Duration/easing | Dùng cho |
|---|---|---|
| `motion-instant` | `120 ms ease` | pressed, hint dot |
| `motion-fast` | `150 ms ease` | focus/hover, backdrop |
| `motion-base` | `220–260 ms cubic-bezier(.2,.8,.3,1)` | screen content, modal, drawer, quân đi |
| `motion-emphasis` | `300–450 ms ease` | turn announce, check banner |
| `motion-float` | `900 ms ease-out` | KEN delta |

- Hover/pressed chỉ animate `transform`, `opacity`, `background-color`, `border-color`, `box-shadow`.
- Không animate layout bằng width/height khi có thể dùng transform.
- Screen route vào bằng fade + dịch tối đa `12 px`; không slide toàn viewport hoặc giữ người dùng chờ transition out.
- Lobby theo nhịp topbar → logo → CTA. List row stagger `24–45 ms`, tối đa 10 row đầu; các row sau xuất hiện cùng nhịp cuối để tổng thời gian không kéo dài.
- Board theo nhịp opponent pod → status → board → my pod → action bar. Choreography chỉ chạy khi screen mount, không chạy lại theo từng tick đồng hồ.
- Modal giữ pop của surface và stagger content ngắn; result được phép nhấn thêm glyph/title nhưng không dùng particle/confetti mặc định.
- Timer urgent pulse chu kỳ `1 s`, không nhanh hơn.
- `prefers-reduced-motion: reduce`: mọi delay về `0`, animation/transition về gần tức thời, quân chuyển ngay vị trí; spinner vẫn có accessible text tĩnh.

## 11. Responsive foundation

| Width | Quy tắc |
|---|---|
| `<360` | ngoài phạm vi v1; vẫn không overflow ngang, có thể giảm gap trước khi giảm text |
| `360–399` | layout compact, lề 15, board chiếm bề ngang khả dụng |
| `400–439` | lề 20, giữ type scale, tăng khoảng thở quanh board |
| `440–520` | app max-width 520; board max 480; không phóng button quá mức |
| `>520` | app nằm giữa; nền ngoài app dùng wood-900 |

Chiều cao thấp:

- Ưu tiên giảm vertical gap và margin hero.
- Không giảm touch target, font body hoặc quân cờ dưới mức đọc được.
- Chat dùng tối đa 46% chiều cao và phải tôn trọng safe-area bottom.

## 12. Checklist foundation

- [ ] Chỉ dùng palette/token đã duyệt.
- [ ] Component nằm trên grid 4/8 px, không có spacing ngẫu nhiên.
- [ ] Radius thuộc đúng scale.
- [ ] Text và icon rõ trên cả nền paper lẫn wood.
- [ ] Không có texture dưới text/data quan trọng.
- [ ] Touch target ≥44 px.
- [ ] Có focus-visible và reduced-motion.
- [ ] Không có emoji/icon hệ điều hành trong UI production.
- [ ] Tại 360, 390, 520 px không overflow hoặc cắt dấu tiếng Việt.
