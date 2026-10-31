# 06 — Screen/class to Style 02 map

## 1. Mục đích

Tài liệu này nối source hiện tại với design system Style 02. Mỗi class phải được triển khai bằng một trong bốn loại:

- `layout`: chỉ bố cục;
- `CSS component`: fill/border/radius/shadow/state bằng token;
- `SVG`: icon/pattern/FX trong manifest;
- `existing`: asset game hiện có, chủ yếu lá bài/reaction/VIP.

Không class nào trong map này dùng raster frame/button/background kiểu skeuomorphic cũ.

## 2. App/loading/global

| Selector/class | Loại | Style 02 implementation |
|---|---|---|
| `#tl-app` / `tl-app` | layout | viewport cream, max-width 520, overflow clip |
| `tl-screen` | layout | absolute inset, safe-area, screen root |
| `tl-loading` | layout + CSS | cream page, centered stack, optional aqua ellipse |
| `tl-loading-title` | live text | title.lg navy |
| `tl-loading-sub` | live text | body.sm teal/navy |
| `tl-toast` | CSS component | cream semantic toast, navy border, left stripe |
| `tl-topbar` | layout | flex, safe-area, 44 px controls |
| `tl-topbar-spacer` | layout | width equal icon button for optical centering |

## 3. Shared controls/content

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-icon-btn` | CSS + SVG | cream square, navy border; selected icon IC-01/02/03/etc. |
| `tl-btn` | CSS base | shared height, border, typography, state |
| `tl-btn-gold` | CSS variant | Primary Sun; tên class legacy không quyết định màu “gold” |
| `tl-btn-ghost` | CSS variant | Secondary Cream |
| `tl-btn-disabled` | CSS state | cream.200, soft navy border/text, no shadow |
| `tl-btn-sm` | size modifier | compact 40 px |
| `tl-btn-wide` | layout modifier | flex 1, min-width 0 |
| `tl-avatar` | CSS component | flat hash gradient, cream ring, navy outline |
| `tl-avatar-sm` | size modifier | visible 34 px |
| `tl-avatar-md` | size modifier | visible 52 px |
| `tl-avatar-lg` | size modifier | visible 60 px |
| `tl-badge` | CSS component | neutral pill |
| `tl-badge-gold` | CSS variant | owner/rank sun pill |
| `tl-badge-green` | CSS variant | success aqua pill |
| `tl-badge-red` | CSS variant | danger coral pill |
| `tl-input` | CSS component | cream input, navy 2 px, radius 12, focus/error |
| `tl-field-label` | live text | 13/18 navy 800 |
| `tl-lock` | SVG/live wrapper | IC-04, 14–16 px, sun/coral accent |
| `tl-vip-icon` | existing | existing VIP image, max 14 px, no Style 02 redraw required |

## 4. Lobby

DOM outline:

```text
tl-lobby
  tl-topbar
    tl-icon-btn
    tl-ken-pill
  tl-logo
  tl-lobby-actions
    tl-play-now            (TẠO BÀN)
    tl-secondary-btn tl-practice-btn   (Tập luyện)
  tl-room-list-header
  tl-room-list
    tl-room-empty | tl-room-row...
```

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-lobby` | layout + CSS | cream header, aqua mat/pattern, coral-cream-navy curve |
| `tl-ken-pill` | CSS component | balance pill cream/navy |
| `tl-user-avatar` | shared VIP PNG + CSS frame | `user.vipType` → `/vip-icons/vip_XXX.png`; fallback Ola smiley |
| `tl-ken-amount` | live text | body.lg navy, tabular nums |
| `tl-ken-coin` | existing PNG | IC-09 Ken vàng chính thức từ Web, không tạo lại SVG |
| `tl-logo` | layout | centered text stack, no plaque |
| `tl-logo-main` | live text | display.xl navy |
| `tl-logo-sub` | live text + SVG decor | coral spaced text; optional SU-01..04 |
| `tl-lobby-actions` | layout | vertical stack, 14 px gap |
| `tl-play-now` | CSS component | Primary Sun Hero, nút “TẠO BÀN” |
| `tl-play-now-label` | live text | title.lg navy |
| `tl-play-now-sub` | live text | body.sm navy 86% |
| `tl-secondary-btn` | CSS component | Secondary Cream Large |
| `tl-practice-btn` | CSS + icon `ic-bot.svg` | nút “Tập luyện”: icon máy 26 px, chữ, chip aqua “Chơi với máy”; disabled tới khi preload bộ bài |
| `tl-practice-modal` | CSS component | modal “Chơi với máy” trên khung `tl-lobby-modal`, gap 8, không có vạch accent |
| `tl-practice-head` / `tl-practice-emblem` / `tl-practice-sub` | CSS + icon `ic-bot.svg` | huy hiệu tròn 56 px aqua→teal nảy vào, tiêu đề, dòng phụ 13 px |
| `tl-practice-list-head` / `tl-practice-count` | layout + live | “Đối thủ N/3” trái, nút “+ Thêm máy” phải |
| `tl-practice-add` | CSS + icon `ic-plus.svg` | nút viên thuốc cao 28 px viền navy; mờ khi đủ 3 máy |
| `tl-practice-list` / `tl-practice-row` | layout + CSS | hàng máy `34px 1fr 28px`, cream.100, radius 14, vạch 4 px trái và viền avatar theo màu mức (`data-level` easy aqua / normal sun / hard coral), trượt vào khi thêm |
| `tl-practice-who` / `tl-practice-label` / `tl-practice-name` / `tl-practice-hint` | layout + live | tên “Máy N” và mô tả mức (Đánh bừa / Giữ bài / Nhớ bài) trái, bộ chọn mức phải; dưới 360 px xếp dọc, ẩn mô tả |
| `tl-practice-levels` / `tl-practice-level` | CSS component | radiogroup viên thuốc cao 26 px, chữ 11 px; ô `.active` tô màu nhạt của mức, viền màu mức |
| `tl-practice-remove` | CSS + icon `ic-user-minus.svg` | nút xoá tròn 28 px viền coral, xám khi còn 1 máy |
| `tl-practice-rules` | CSS + live | chip luật canh giữa: số người (aqua), 30 giây/lượt, không cược, không cộng EXP |
| `tl-room-list-header` | layout/text | title left, count teal, refresh right |
| `tl-room-list` | layout | scroll column, 10–12 px gap, no outer frame |
| `tl-room-empty` | live + SVG | IC-14 and centered empty copy |
| `tl-room-row` | CSS component | cream flat row, navy outline, radius 16 |
| `tl-room-info` | layout | minmax info column |
| `tl-room-name` | live text | 15–16 px navy 800, ellipsis |
| `tl-room-meta` | layout + live | occupancy + wager pill, luôn hiện cả khi cược 0 |
| `tl-room-occupancy` | layout + live | dots + current/max player teal |
| `tl-room-bet` | existing PNG + live text | icon Ken vàng 15 px + số cược format `vi-VN` |
| `tl-seat-dots` | CSS primitives | 9 px aqua filled/empty circles |
| `tl-playing-badge` | CSS component | coral playing pill + live label |

Room row state `.muted` là state modifier hiện có, không giảm opacity toàn row; style action/badge theo playing/full.

## 5. Lobby modals

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-modal-backdrop` | CSS | navy 38% overlay, optional blur 3 |
| `tl-modal` | CSS component | cream panel, navy border, radius 20 |
| `tl-modal-title` | live text | title.lg navy |
| `tl-modal-text` | live text | body.md navy/teal |
| `tl-capacity-row` | layout | 3 segment flex, 8 px gap |
| `tl-capacity-btn` | CSS component | cream segment; `.active` aqua/sun + check/border |
| `tl-bet-input` | existing PNG + input | icon Ken vàng 26 px, numeric value mặc định 0, suffix KEN |
| `tl-bet-hint` | live text | helper teal hoặc validation coral; `aria-live` |
| `tl-modal-actions` | layout | two equal 48 px buttons |

Dynamic text “Tạo bàn mới”, số cược, owner name, password errors and button labels remain live. Submit truyền đúng `bet`; khi `bet` vượt balance/maxBet thì nút tạo bàn bị disable.

## 6. Waiting room

DOM outline:

```text
tl-room
  tl-topbar / tl-room-title
  tl-seat-grid
    tl-seat | tl-seat tl-seat-empty
  tl-room-chat
  tl-room-actions
```

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-room` | layout + CSS | aqua mat + cream curved topbar |
| `tl-room-title` | live text/layout | centered title/meta, no plaque |
| `tl-seat-grid` | layout | two-column grid, 12 px gap |
| `tl-seat` | CSS component | occupied cream seat card |
| `tl-seat-empty` | CSS state | transparent/aqua tint + dashed navy border |
| `tl-seat-plus` | CSS + SVG optional | 42 px cream circle + IC-12 |
| `tl-seat-name` | live text | 15 px navy, ellipsis |
| `tl-crown` | SVG preferred | replace glyph visually with IC-08; aria semantics preserved |
| `tl-kick-btn` | CSS + SVG | compact cream/coral icon button + IC-07 |
| `tl-room-chat` | CSS component | cream panel, navy border, radius 16 |
| `tl-room-chat-log` | layout | scroll log, transparent background |
| `tl-chat-hint` | live text | navy 52–60%, body.sm |
| `tl-chat-line` | live text/layout | username navy 800 + message navy 600 |
| `tl-chat-input-row` | layout | input + send action, 8 px gap |
| `tl-room-actions` | layout | sticky two-button row, safe bottom |

Owner/ready classes dùng các semantic variant của `tl-badge`, không tạo skin riêng.

## 7. Table root/topbar

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-table-screen` | layout + CSS | aqua mat, cream top/bottom, festival curves |
| `tl-table-title` | live text | 17–20 px navy 800 |
| `tl-felt` | layout | grid `'left top right' / 'left center right'`; `.full` (4 người) đẩy 2 ghế bên sát mép, `.trio` (3 người) đưa 2 ghế bên lên trên |
| `tl-seat-slot` | layout | ô lưới top/left/right của `tl-felt` |
| `tl-opponent` | layout | pod stack without container panel |
| `tl-opponent-name` | CSS + live text | cream nameplate, navy outline |
| `tl-turn-ring` | CSS | conic sun/coral ring around avatar |
| `tl-seat-avatar` | layout | khung avatar + vòng lượt; `data-seat` là điểm xuất phát của bài bay |
| `tl-count-badge` | existing + CSS | viên navy (card back + số lá) bên phải avatar, ghế phải đặt phía trong |
| `tl-pass-chip` | CSS/live | neutral cream status pill |
| `tl-away-badge` | CSS/live | coral danger pill with countdown |
| `tl-seat-reactions` | layout | neo ở góc trên avatar (ghế phải: góc trên trái), đè ~1/4 icon |
| `tl-reaction-balloon` | existing + motion | `tl-reaction-pop` bật ra (0 → 1,3 → 1), lắc nhẹ, vòng sáng vàng toả ra, rồi bay lên mờ dần trong 2,6 s; nhiều biểu cảm lệch trái/phải |

Position modifiers `.top`, `.left`, `.right`, `.active`, `.urgent`, `.quit` remain CSS states/layout; no asset.

## 8. Table center and cards

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-table-center` | layout/CSS | transparent trick zone, optional dashed cream outline |
| `tl-trick` | layout | hàng bài giữa bàn (`trickLayout`), luôn giữ chỗ kể cả khi bàn trống |
| `tl-trick-card` | existing + motion | card face; lượt mới bay từ ghế người đánh (bài của mình bay từ vị trí trên tay), mỗi lá trễ 45 ms |
| `tl-ticker` | CSS/live | thông báo 1 dòng: `.play` "@x vừa đánh" / `.pass` "@x bỏ lượt" giữ 1,1 s rồi `.turn` "Tới lượt @y" (navy, chấm vàng), `.turn.mine` "Tới lượt bạn" vàng phát sáng; bàn trống thêm "ra bài" |
| `tl-turn-timer` | CSS/live | đồng hồ cuối dòng "Tới lượt": vòng SVG rút dần theo hạn lượt (30 s) + số giây nảy mỗi giây; ≤5 s đổi đỏ cam, viên thông báo phát sáng nhấp nháy; lượt mình là đĩa kem vòng navy |
| `tl-table-hint` | CSS/live | "Đang chọn: …" trong vùng bài khi bàn trống |
| `tl-finish-banner` | CSS/live | cream/sun flat banner, navy border |
| `tl-my-row` | layout | local identity anchored above hand |
| `tl-my-info` | layout | name/place/pass stack |
| `tl-my-name` | CSS/live | local cream nameplate “Bạn” |
| `tl-hint-btn` | CSS/live + icon `ic-hint.svg` | nút "Gợi ý" ở góc phải hàng của mình: sáng vàng nhấp nháy khi tới lượt mình và có nước đi (`hintPlays`), mờ khi không; bấm chọn sẵn bộ bài gợi ý, bấm tiếp đổi sang gợi ý kế |
| `tl-hint-step` | CSS/live | chấm xanh navy góc trên nút "Gợi ý" ghi thứ tự gợi ý đang chọn (`2/8`), chỉ hiện khi có từ 2 gợi ý trở lên |
| `tl-hand` | layout | hàng bài cong nhẹ (`handArc`: nghiêng tối đa 4°, hai đầu hạ 6% chiều cao lá), cỡ lá theo bề ngang (`handLayout`), chừa chỗ cho lá nhô lên |
| `tl-hand-card` | existing + CSS | card face + bóng mảnh đổ sang lá bên dưới; lá chọn nhô lên 24% chiều cao, bóng đậm hơn, không viền |
| `tl-action-bar` | layout | transparent sticky button row |
| `tl-disconnect-overlay` | CSS/live | localized coral pill, not full-screen dark overlay |

State `.selected`, `.dealing`, `.chop` are CSS/animation states. Chop uses FX-01 or CSS rays.

## 9. Table chat

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-chat-overlay` | CSS | trong suốt để vẫn thấy bàn và đồng hồ; chỉ tối 45% khi màn thấp hơn 420 px (đang mở bàn phím) |
| `tl-chat-panel` | CSS component | sheet kem gọn (tiêu đề → tin → biểu cảm → câu nhanh → ô nhập), radius top 20; đang gõ thì ẩn hàng biểu cảm và câu nhanh |
| `tl-reaction-row` | layout | lưới 6 ô chia đều, vừa máy 320 px |
| `tl-reaction-btn` | CSS component | ô kem cao 40 px (32 px khi màn thấp), navy border, aqua pressed |
| `tl-quick-row` / `tl-quick-chip` | layout + CSS | hàng câu nhắn nhanh cuộn ngang (`QUICK_CHATS`), bấm là gửi và đóng khung |
| `tl-chat-btn` / `tl-unread-badge` | CSS/live | nút chat trên thanh tiêu đề + chấm đỏ số tin chưa đọc (quá 9 hiện 9+), nảy khi có tin mới |
| `tl-chat-bubble` | CSS/live | bong bóng tin mới cạnh avatar người nhắn trong 3 s (ghế trái/mình: phía trên, ghế phải: phía trên lệch trái, ghế trên: bên trái), tối đa 2 dòng |

`tl-room-chat-log`, `tl-chat-line`, `tl-chat-hint`, `tl-chat-input-row` và `tl-input` tái dùng quy tắc phòng chờ.

## 10. Result

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-result-backdrop` | CSS state | modal backdrop navy radial + blur, z-index result, fade-in |
| `tl-result-confetti` | CSS/live | 22 mảnh giấy màu rơi 2 lượt, chỉ khi mình về Nhất; tắt khi reduced-motion |
| `tl-result-card` | CSS component | cream modal radius 26, pop-in; `.tone-win/.tone-mid/.tone-lose/.tone-neutral` đổi màu dải nền đầu thẻ và huy hiệu |
| `tl-result-emblem` | CSS/live + icon `ic-crown.svg` | huy hiệu tròn 76px đè mép trên thẻ: vương miện khi Nhất (kèm `tl-result-rays` tia sáng xoay), số hạng khi Nhì/Ba/Bét; màu vàng/bạc/đồng/coral theo hạng |
| `tl-result-head` | layout | cột giữa: `tl-result-kicker` (KẾT QUẢ VÁN), `tl-result-title` ("Bạn về Nhất!", Bét màu coral), `tl-result-subtitle` (câu động viên hoặc lý do kết thúc) |
| `tl-result-instant` | CSS/live | sun pill thay câu phụ khi tới trắng |
| `tl-result-rows` | layout | danh sách `ol`, scroll khi thiếu chỗ |
| `tl-result-row` | CSS component | hàng hạng trượt lên lần lượt; `.first` nền vàng viền navy, `.me` nền aqua viền teal |
| `tl-result-medal` | CSS/live | huy chương số hạng 30px: `.gold/.silver/.bronze/.last/.plain` |
| `tl-result-who` | layout | tên (`tl-result-name`, ellipsis) + nhãn hạng (`tl-result-label`) |
| `tl-result-exp` | CSS/live | pill teal "+N EXP" từ `expGains` của MATCH_OVER, ẩn khi 0 |
| `tl-result-empty` | live text | "Ván đấu không có kết quả" |

Badges và action buttons tái dùng shared component.

## 11. Animation/keyframe map

Các token sau là tên animation/keyframe đang có trong CSS, không phải asset:

| Tên | Style 02 behavior |
|---|---|
| `tl-pulse` | opacity pulse nhẹ cho timer/queue, không scale glow |
| `tl-balloon` | reaction bay 2.0–2.6 s, translate + fade |
| `tl-chop` | 500 ms scale/opacity + FX-01 rays |
| `tl-card-in` | 220–250 ms translate/rotate về vị trí |
| `tl-banner` | 180–240 ms scale .96→1 + fade |
| `tl-toast-in` | 160 ms y -8→0 + fade |
| `tl-result-fade` / `tl-result-pop` | backdrop fade 240 ms; thẻ kết quả y +24 → 0, scale .92 → 1, 380 ms nảy nhẹ |
| `tl-result-emblem` | huy hiệu scale .3 → 1, xoay -25° → 0, trễ 120 ms |
| `tl-result-spin` | tia sáng sau huy hiệu Nhất xoay 1 vòng / 9 s |
| `tl-result-row` | hàng hạng y +10 → 0 + fade, trễ 220 ms + 80 ms mỗi hàng |
| `tl-result-confetti` | mảnh giấy rơi hết màn 2.2–3.4 s, lệch ngang ±30 px, chạy 2 lượt |

Mọi animation có reduced-motion fallback.

## 12. Asset dependency theo màn

| Màn | SVG mới | Existing |
|---|---|---|
| loading | PT-01 optional | none |
| lobby | IC-01, IC-03, IC-04, IC-14, SU-01..04, PT-01 | IC-09 Ken PNG vàng, VIP optional |
| modal | IC-05 optional, IC-11 | none |
| room | IC-01, IC-06, IC-07, IC-08, IC-11, IC-12, PT-01 | none |
| table | IC-01, IC-02, IC-10, FX-01, PT-01 | cards, back, reactions |
| chat | IC-05, IC-06 | reactions |
| result | IC-11, optional FX-03 | none |

Không cần preload asset chỉ xuất hiện ở chat/result.

## 13. CSS pseudo-element map

| Vùng | Pseudo-element | Nội dung |
|---|---|---|
| lobby/table/room root | `::before` | woven pattern overlay pointer-events none |
| cream-to-mat boundary | `::after` hoặc child | coral/cream/navy curve |
| primary button | none ưu tiên | gradient trực tiếp, không highlight pseudo |
| toast | `::before` | semantic left stripe |
| result title | `::after` | coral underline |
| disabled button | none | explicit fill/border/text state |
| focus ring | outline/box-shadow | không pseudo nếu không cần |

Pseudo-element trang trí luôn `aria-hidden` theo bản chất CSS và `pointer-events:none`.

## 14. Live text inventory

Không bake:

- loading title/sub;
- game logo;
- balance;
- CTA label/subtitle;
- room list title/count;
- room name/lock/playing/occupancy/action;
- modal title/label/error/action;
- room title/member/status/chat;
- table title/player/card count/pass/away/hint/owner/action;
- toast/finish;
- result title/reason/ranking/action.

Suit marks trang trí và icon là SVG, nhưng suit trên lá bài vẫn thuộc existing card asset.

## 15. Source coverage checklist

Danh sách class/tên `tl-*` cần được coverage khi source thay đổi:

```text
tl-action-bar tl-app tl-avatar tl-avatar-lg tl-avatar-md tl-avatar-sm
tl-away-badge tl-badge tl-badge-gold tl-badge-green tl-badge-red
tl-btn tl-btn-disabled tl-btn-ghost tl-btn-gold tl-btn-sm tl-btn-wide
tl-capacity-btn tl-capacity-row tl-chat-hint tl-chat-input-row tl-count-badge
tl-chat-btn tl-chat-bubble tl-chat-line tl-chat-overlay tl-chat-panel tl-crown tl-disconnect-overlay
tl-felt tl-field-label tl-finish-banner tl-hand tl-hand-card tl-hint-btn tl-hint-step tl-icon-btn tl-input
tl-ken-amount tl-ken-coin tl-ken-pill tl-kick-btn tl-loading tl-loading-sub
tl-loading-title tl-lobby tl-lobby-actions tl-lock tl-logo tl-logo-main
tl-logo-sub tl-modal tl-modal-actions tl-modal-backdrop
tl-modal-text tl-modal-title tl-my-info tl-my-name tl-my-row tl-opponent
tl-opponent-name tl-pass-chip tl-playing-badge tl-play-now tl-play-now-label
tl-play-now-sub tl-practice-add tl-practice-btn tl-practice-count tl-practice-emblem tl-practice-head
tl-practice-hint tl-practice-label tl-practice-level tl-practice-levels tl-practice-list tl-practice-list-head
tl-practice-modal tl-practice-name tl-practice-remove tl-practice-row tl-practice-rules tl-practice-sub
tl-practice-who tl-quick-chip tl-quick-row tl-reaction-balloon tl-reaction-btn tl-reaction-pop tl-reaction-row tl-unread-badge
tl-result-backdrop tl-result-card tl-result-confetti tl-result-emblem tl-result-emblem-disc
tl-result-empty tl-result-exp tl-result-head tl-result-instant tl-result-kicker tl-result-label
tl-result-medal tl-result-name tl-result-rays tl-result-row tl-result-rows tl-result-subtitle
tl-result-title tl-result-who
tl-room tl-room-actions tl-room-chat tl-room-chat-log tl-room-empty
tl-room-info tl-room-list tl-room-list-header tl-room-meta tl-room-name
tl-room-row tl-room-title tl-screen tl-seat tl-seat-dots tl-seat-empty
tl-seat-avatar tl-seat-grid tl-seat-name tl-seat-plus tl-seat-reactions tl-seat-slot
tl-secondary-btn tl-table-center tl-table-hint tl-table-screen tl-table-title
tl-ticker tl-toast tl-topbar tl-topbar-spacer tl-trick tl-trick-card tl-turn-timer
tl-turn-ring tl-vip-icon
```

Animation names coverage:

```text
tl-balloon tl-banner tl-card-in tl-chop tl-pulse tl-toast-in
```

Nếu source thêm class `tl-*`, CI/manual audit phải báo cho đến khi file này được cập nhật.

## 16. Acceptance

- [ ] tất cả class source có trong coverage list;
- [ ] tất cả class có quy tắc hoặc nằm trong nhóm tái sử dụng được nêu rõ;
- [ ] không tham chiếu asset hoặc đường dẫn style cũ;
- [ ] không raster hóa text/control;
- [ ] màn chỉ tải SVG cần thiết;
- [ ] cards/reactions/VIP tiếp tục dùng asset hiện có;
- [ ] state modifiers không tạo component mới sai hệ;
- [ ] animation có reduced-motion;
- [ ] mapping khớp source tại commit triển khai.
