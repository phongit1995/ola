# 03 — Component specifications

Mọi số đo tại viewport 390; bàn 366. Class prefix `ty-`.

## 1. BoardSurface (SVG code-native)

- `<svg viewBox="0 0 366 366">` (số thực theo width), nền `--ty-paper`, viền ngoài navy 3 px, radius 8.
- Lưới 40 ô vẽ bằng `<rect>` + `<line>` `--ty-line` 1 px; ô góc 46, ô cạnh 30.4 × 46.
- Vùng giữa: `<image>` watermark logo 12% opacity, hoặc `<g>` trống để React portal xúc xắc/thẻ đè lên bằng DOM tuyệt đối.
- Thứ tự layer: nền → dải màu → nhà → chấm chủ sở hữu → glyph ô → highlight landing/path → quân (DOM, không SVG, để animate dễ) → overlay.
- Mỗi ô là `<g data-tile={idx}>` có `role="button"` + `aria-label="Đà Lạt, nhóm Đỏ, của @an, 2 nhà"`; hit rect mở rộng 4 px.

## 2. Tile

### 2.1 Anatomy ô đất (cạnh dưới, 30.4 × 46)
- Dải màu nhóm: rect 30.4 × 15 phía **trong** bàn (phía vùng giữa), viền navy 1 px bên dưới dải.
- Thân ô: 30.4 × 31 paper; chứa nhà (2.3) và quân.
- Chấm chủ sở hữu: circle r 4 màu ghế, góc ngoài-phải ô, viền paper 1 px.
- Ô cạnh trái/phải xoay 90°: dải màu nằm phía trong theo trục ngang; glyph không xoay (luôn đứng thẳng).

### 2.2 Ô đặc biệt
- Nền `--ty-paper-dim`, glyph 18 px (grid 32 scale 0.56) màu theo 01 §2.2, không dải.
- Ô góc 46 × 46: bust nhân vật 30 px (`style/02-board-tiles.md` §3) + glyph nhỏ 12 px ở góc; khi `charsEnabled=false` thay bằng glyph 26 px. Ô 10 chia chéo: vùng "Thăm tù" paper + vùng "Nhà tù" dim có song sắt; quân trong tù đứng vùng dim, quân thăm đứng vùng paper.

### 2.3 Nhà và khách sạn
- Nhà: `tg-house` fill jade 6 × 6 (nóc tam giác + thân), xếp hàng ngang sát dải màu, gap 1 px, tối đa 4.
- Khách sạn: `tg-hotel` fill coral 14 × 8 với nóc, thay thế 4 nhà.
- Ở size này không có outline navy (quá nhỏ); chỉ fill.

### 2.4 State
| State | Hiển thị |
|---|---|
| landing | fill `--ty-landing` toàn ô |
| path | fill `--ty-path` 600 ms fade |
| selected (sheet mở) | viền navy 2 px bên trong |
| owner bankrupt | chấm chủ mất, nhà mất |

## 3. Token (quân cờ)

- `<img>` webp 96 px hiển thị 18 px trong vòng tròn paper 22 px viền navy 1.5 + vòng màu ghế 2 px bên trong (DOM div, `border` 2 lớp bằng `box-shadow`).
- Vị trí absolute theo tâm ô, nhiều quân cùng ô: offset `(±5, ±5)` theo thứ tự seat.
- Quân tới lượt: vòng gold blur 6 pulse 1.2 s.
- Quân phá sản: unmount sau step `bankrupt`.
- Người chơi chọn quân ở S5? **Không** — v1 gán quân theo seat (tokens/tk-{seat}) để không cần protocol chọn quân; 8 quân trong manifest dùng cho v2 chọn quân.

## 4. Dice

- Hai ô 44 × 44 radius 12 paper viền navy 2 shadow md, dot r 4 navy; 6 mặt SVG `dice/d1..d6.svg` (06 §6).
- Component `DiceRoll {dice:[a,b], rolling}`: khi rolling đổi mặt ngẫu nhiên mỗi 80 ms (client-only, không ảnh hưởng kết quả), kết thúc đúng mặt server.
- Reduced-motion: hiện mặt cuối ngay.

## 5. PlayerPod (86 × 88)

```
┌────────────────┐
│ ◯ avatar 32    │  viền pod màu ghế 2 px; nền paper; radius 16
│ @ten 12.5/600  │
│ 1.260 tr 15/800│  tabular, đổi màu 500 ms khi tăng/giảm
│ ▪▪▪ 🔒 ⛓       │  hàng chip 12 px: số đất (ic-deed + n), thẻ tù (ic-key), đang trong tù (ic-jail-bars)
└────────────────┘
```

- Tới lượt: viền gold + glow; pod của mình có nhãn `Bạn` góc trên.
- Mất kết nối: ic-wifi-off đè góc avatar, pod 70% opacity.
- Phá sản: pod `--ty-bankrupt`, text `Phá sản`, giữ vị trí để pod row không nhảy.
- Sắp phá sản (pha debt của người đó): viền coral pulse.
- Tap pod → S8 ở chế độ xem (read-only) tài sản người đó.

## 6. ActionBar

- Chiều cao 72, nền navy 20% trên nền màn, nút cao 52.
- Layout theo pha (02 §6.3); mọi nút `≥ 44` cao, khoảng cách 8.
- Khi `movePending`: nút vừa bấm hiện spinner 16, cả bar disabled.
- Đồng hồ không nằm trong bar — ở topbar, để bar không đổi chiều cao.

## 7. TurnClock

- 22/800 tabular, `0:28`; ≤ 10 s đổi `--ty-danger` + pulse + âm tick.
- Nguồn: `deadline` từ STATE/MATCH_FOUND, tick rAF; dừng khi `oppAway` của người tới lượt.

## 8. RoundChip

- Chip paper viền navy 1.5, radius 8, `Vòng 7/20` 13/700; 18–19 coral, 20 danger.

## 9. DeedCard (trong S7) và GroupChip

- GroupChip: rect 12 × 12 màu nhóm viền navy 1 + tên nhóm 12.5/500.
- RentTable: 6 hàng `label | số`, hàng áp dụng nền gold 30%; số tabular 13.5/800.
- OwnerChip: avatar 20 + `@ten` + chấm màu ghế.

## 10. Card (O2)

- 280 × 180, radius 16, viền navy 2, dải đầu 28 màu loại; `aria-live="polite"` đọc nội dung.
- Mặt sau: dải + glyph 48 (tg-chance / tg-chest) giữa.
- Flip bằng `rotateY` 2 mặt `backface-visibility: hidden`.

## 11. BottomSheet (S7, S8)

- Trượt từ dưới, radius 28 trên, handle 36 × 4 navy 30%, backdrop `--ty-overlay`.
- Max height theo màn; nội dung scroll; nút hành động dính đáy sheet (sticky) cao 52 + safe-area.
- Đóng: kéo xuống, tap backdrop, nút ic-close; khi `decide` đóng sheet **không** gửi DECLINE (bar vẫn còn nút).

## 12. Modal (S4, S9, O3, O5)

- 340 × auto, radius 20, paper, viền navy 2, shadow lg; title 20/800; nút hàng ngang 2 (CTA phải, text trái).
- Focus trap, `Escape` đóng (trừ S9, O3).

## 13. Buttons

| Class | Nền | Chữ | Viền | Dùng |
|---|---|---|---|---|
| `.ty-btn-gold` | gradient gold | navy 17/700 | gold-deep 2 | hành động chính của pha |
| `.ty-btn-paper` | paper | navy 15/600 | navy 2 | phụ |
| `.ty-btn-jade` | jade | cream 16/700 | navy 2 | Sẵn sàng, Mua (biến thể khi muốn nhấn "được tiền") — v1 chỉ dùng cho Sẵn sàng |
| `.ty-btn-danger` | danger | cream 15/700 | navy 2 | Phá sản, Bỏ cuộc trong confirm |
| `.ty-btn-text` | — | cream 15/600 | — | Hủy, Luật chơi |
| `.ty-icon-btn` | paper 0/100% | navy/cream | navy 1.5 | 44 × 44 |

State: hover viền 2 + translateY(−1); active translateY(0) shadow sm; disabled opacity 45% không shadow; focus-visible ring gold 3 px offset 2; loading spinner thay icon.

## 14. Chip / Badge

- `.ty-chip` paper viền navy 1.5 radius 8, 12.5/600; `.ty-chip-gold`, `.ty-chip-jade`, `.ty-chip-coral` đổi nền.
- `.ty-money` số tabular + hậu tố ` tr` 80% opacity; `.ty-money-up/down` màu + float.
- `.ty-seat-badge` chấm 10 px màu ghế dùng trong chat và log.

## 15. ChatDrawer, ReactionPicker, Toast, OppAwayBanner, ConfirmModal

Dùng lại cấu trúc xiangqi (`03-component-specs` §chat/reaction/toast), đổi token `--xq-*` → `--ty-*`. Chat trong ván: tin nhắn kèm chấm màu ghế trước tên. Reaction bay từ pod người gửi.

## 16. Log line

- 2 dòng gần nhất dưới action bar, mỗi dòng 12.5/500 cream 80%, tên có màu ghế, số tiền jade/coral; sinh từ steps (`pay`, `buy`, `build`, `jail-in`, `bankrupt`, `card`). Tap → mở drawer log đầy đủ (50 dòng, cùng ChatDrawer tab thứ 2).

## 17. Accessibility

- Mọi ô, pod, nút có accessible name tiếng Việt; thẻ bài và turn announce `aria-live`.
- Màu ghế luôn kèm tên/avatar; màu nhóm đất luôn kèm tên nhóm trong sheet.
- Touch ≥ 44 trừ ô bàn cờ (đã nêu lý do ở 01 §4) và chấm nhà (không tương tác).
- Reduced-motion theo 01 §8; không âm thanh tự phát khi tắt loa.
