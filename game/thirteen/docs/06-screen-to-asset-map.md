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
    tl-play-now
    tl-secondary-btn
  tl-room-list-header
  tl-room-list
    tl-room-empty | tl-room-row...
```

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-lobby` | layout + CSS | cream header, aqua mat/pattern, coral-cream-navy curve |
| `tl-ken-pill` | CSS component | balance pill cream/navy |
| `tl-ken-amount` | live text | body.lg navy, tabular nums |
| `tl-ken-coin` | SVG | IC-09 coin, sun fill/navy outline |
| `tl-logo` | layout | centered text stack, no plaque |
| `tl-logo-main` | live text | display.xl navy |
| `tl-logo-sub` | live text + SVG decor | coral spaced text; optional SU-01..04 |
| `tl-lobby-actions` | layout | vertical stack, 14 px gap |
| `tl-play-now` | CSS component | Primary Sun Hero |
| `tl-play-now-label` | live text | title.lg navy |
| `tl-play-now-sub` | live text | body.sm navy 86% |
| `tl-secondary-btn` | CSS component | Secondary Cream Large |
| `tl-room-list-header` | layout/text | title left, count teal, refresh right |
| `tl-room-list` | layout | scroll column, 10–12 px gap, no outer frame |
| `tl-room-empty` | live + SVG | IC-14 and centered empty copy |
| `tl-room-row` | CSS component | cream flat row, navy outline, radius 16 |
| `tl-room-info` | layout | minmax info column |
| `tl-room-name` | live text | 15–16 px navy 800, ellipsis |
| `tl-room-meta` | layout + live | dots + occupancy teal |
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
| `tl-modal-actions` | layout | two equal 48 px buttons |

Dynamic text “Tạo bàn mới”, owner name, password errors and button labels remain live.

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
| `tl-seat-slot` | layout | absolute top/left/right anchors |
| `tl-opponent` | layout | pod stack without container panel |
| `tl-opponent-name` | CSS + live text | cream nameplate, navy outline |
| `tl-turn-ring` | CSS | conic sun/coral ring around avatar |
| `tl-card-count` | live/layout | body.md navy + mini stack |
| `tl-mini-stack` | existing + CSS | three existing card backs, small rotations |
| `tl-pass-chip` | CSS/live | neutral cream status pill |
| `tl-away-badge` | CSS/live | coral danger pill with countdown |
| `tl-seat-reactions` | layout | absolute reaction anchor |
| `tl-reaction-balloon` | existing + motion | existing reaction asset, bounded animation |

Position modifiers `.top`, `.left`, `.right`, `.active`, `.urgent`, `.quit` remain CSS states/layout; no asset.

## 8. Table center and cards

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-table-center` | layout/CSS | transparent trick zone, optional dashed cream outline |
| `tl-trick` | layout | center card overlap/fan |
| `tl-trick-card` | existing | existing card face + short card-in motion |
| `tl-trick-owner` | CSS/live | cream owner name chip |
| `tl-table-hint` | CSS/live | cream/transparent hint chip, navy text |
| `tl-finish-banner` | CSS/live | cream/sun flat banner, navy border |
| `tl-my-row` | layout | local identity anchored above hand |
| `tl-my-info` | layout | name/place/pass stack |
| `tl-my-name` | CSS/live | local cream nameplate “Bạn” |
| `tl-hand` | layout | responsive fan, transform anchors |
| `tl-hand-card` | existing + CSS | card face, selected/focus/animation states |
| `tl-action-bar` | layout | transparent sticky button row |
| `tl-disconnect-overlay` | CSS/live | localized coral pill, not full-screen dark overlay |

State `.selected`, `.dealing`, `.chop` are CSS/animation states. Chop uses FX-01 or CSS rays.

## 9. Table chat

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-chat-overlay` | CSS | navy 30% backdrop |
| `tl-chat-panel` | CSS component | cream bottom sheet, navy outline, radius top 24 |
| `tl-reaction-row` | layout | horizontal scroll, 8 px gap |
| `tl-reaction-btn` | CSS component | 44 px cream tile, navy border, aqua pressed |

`tl-room-chat-log`, `tl-chat-line`, `tl-chat-hint`, `tl-chat-input-row` và `tl-input` tái dùng quy tắc phòng chờ.

## 10. Result

| Class | Loại | Style 02 implementation |
|---|---|---|
| `tl-result-backdrop` | CSS state | modal backdrop, z-index result |
| `tl-result-card` | CSS component | cream result modal, radius 24 |
| `tl-result-banner` | live text/CSS | display title + coral underline, no raster ribbon |
| `tl-result-instant` | CSS/live | sun/coral pill |
| `tl-result-note` | live text | body.sm teal/navy, center |
| `tl-result-rows` | layout | vertical stack/scroll |
| `tl-result-row` | CSS component | flat ranking row; `.first`/`.me` semantic tint |
| `tl-result-place` | live text | place column, tabular nums |
| `tl-result-name` | live text | navy 800, ellipsis |

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

Mọi animation có reduced-motion fallback.

## 12. Asset dependency theo màn

| Màn | SVG mới | Existing |
|---|---|---|
| loading | PT-01 optional | none |
| lobby | IC-01, IC-03, IC-04, IC-09, IC-14, SU-01..04, PT-01 | VIP optional |
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
tl-capacity-btn tl-capacity-row tl-card-count tl-chat-hint tl-chat-input-row
tl-chat-line tl-chat-overlay tl-chat-panel tl-crown tl-disconnect-overlay
tl-field-label tl-finish-banner tl-hand tl-hand-card tl-icon-btn tl-input
tl-ken-amount tl-ken-coin tl-ken-pill tl-kick-btn tl-loading tl-loading-sub
tl-loading-title tl-lobby tl-lobby-actions tl-lock tl-logo tl-logo-main
tl-logo-sub tl-mini-stack tl-modal tl-modal-actions tl-modal-backdrop
tl-modal-text tl-modal-title tl-my-info tl-my-name tl-my-row tl-opponent
tl-opponent-name tl-pass-chip tl-playing-badge tl-play-now tl-play-now-label
tl-play-now-sub tl-reaction-balloon tl-reaction-btn tl-reaction-row
tl-result-backdrop tl-result-banner tl-result-card tl-result-instant
tl-result-name tl-result-note tl-result-place tl-result-row tl-result-rows
tl-room tl-room-actions tl-room-chat tl-room-chat-log tl-room-empty
tl-room-info tl-room-list tl-room-list-header tl-room-meta tl-room-name
tl-room-row tl-room-title tl-screen tl-seat tl-seat-dots tl-seat-empty
tl-seat-grid tl-seat-name tl-seat-plus tl-seat-reactions tl-seat-slot
tl-secondary-btn tl-table-center tl-table-hint tl-table-screen tl-table-title
tl-toast tl-topbar tl-topbar-spacer tl-trick tl-trick-card tl-trick-owner
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
