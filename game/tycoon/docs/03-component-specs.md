# 03 — Component specifications

Mọi số đo tại viewport 390; bàn 366. Class prefix `ty-`.

## 1. BoardSurface (SVG code-native)

- `<svg viewBox="0 0 366 366">` (số thực theo width), nền `--ty-paper`, viền ngoài navy 3 px, radius 8.
- Lưới 32 ô vẽ bằng `<rect>` + `<line>` `--ty-line` 1 px; ô góc 49.8, ô cạnh 38.1 × 49.8. Vị trí ô theo `tileRect(idx)`: góc ở `idx % 8 == 0`, Xuất phát dưới-trái, thuận kim đồng hồ.
- Vùng trong (72.8% cạnh bàn): nền paper trơn, không watermark/logo. Chứa 2 chồng thẻ ở 2 góc trên và `TurnCluster` (§6) ở giữa — vị trí chi tiết ở 02 §6.3. Cụm lượt, thẻ O2, turn announce là DOM tuyệt đối đè lên bàn.
- Thứ tự layer: nền → dải màu → nhà → chấm chủ sở hữu → glyph ô → highlight landing/path → quân (DOM, không SVG, để animate dễ) → overlay.
- Mỗi ô là `<g data-tile={idx}>` có `role="button"` + `aria-label="Đà Lạt, nhóm Đỏ, của @an, 2 nhà"`; hit rect mở rộng 4 px.

## 2. Tile

### 2.1 Anatomy ô đất (cạnh dưới, 38.1 × 49.8)
- Dải màu nhóm: rect 38.1 × 7–9 ở mép phía **trong** bàn (mép giáp vùng trong), viền navy 1 px ở cạnh giáp thân ô; nhà/khách sạn nằm trên dải.
- Thân ô, chữ luôn đứng thẳng, ba tầng từ trên xuống:
  1. **tên ngắn** (`shortName`) 800, cỡ `board × 0.0182` (6.7 px tại 366), tối đa 2 dòng, sát mép trên thân;
  2. **tranh** địa danh (ô đất) hoặc glyph (ô đặc biệt) ở giữa — tại 390 chỉ còn ≈ 26 × 16 px, tranh rõ từ bàn ≥ 456;
  3. **giá** `220 tr` tabular sát mép dưới thân; ô có chủ đổi thành viên tiền thuê.
- Ô có chủ: nền `SEAT_SOFT_COLORS` + vạch 3 px màu ghế ở mép **ngoài** ô (đối diện dải nhóm), thay chấm chủ.
- Cột trái/phải: khung và dải xoay theo cạnh (dải ở mép trong theo trục ngang); ba tầng chữ/tranh/giá **không xoay**, vẫn đọc từ trên xuống. Hàng trên: dải ở đáy ô, tên vẫn ở đỉnh.

### 2.2 Ô đặc biệt
- Nền `--ty-paper-dim`, glyph 18 px (grid 32 scale 0.56) màu theo 01 §2.2, không dải.
- Ô góc 49.8 × 49.8 (class `ty-tile-corner-bl|tl|tr|br` theo vị trí): bust nhân vật 30 px (`style/02-board-tiles.md` §3) + glyph nhỏ 12 px ở góc; khi `charsEnabled=false` thay bằng glyph 26 px. Ô 8 (Nhà tù, góc trên-trái): phòng giam 68% × 68% ở góc dưới-phải của ô (phía vùng trong) có song sắt; dải "Thăm tù" paper dọc mép trên + mép trái. Quân trong tù đứng trong phòng giam, quân thăm đứng ở dải trái.

### 2.3 Cấp nhà (3 cấp)
- Cấp 1 · Nhà: 1 `tg-house` fill jade 6 × 6 (nóc tam giác + thân) trên dải màu.
- Cấp 2 · Biệt thự: 2 `tg-house` xếp ngang, gap 1 px.
- Cấp 3 · Khách sạn: 1 `tg-hotel` fill coral 14 × 8 với nóc, thay 2 nhà.
- Tên cấp lấy từ `LEVEL_NAMES` (`constants.ts`), nhãn đầy đủ `Cấp n · Tên` từ `levelLabel()` (`helpers/tiles.ts`).
- Ở size này không có outline navy (quá nhỏ); chỉ fill.

### 2.4 State
| State | Hiển thị |
|---|---|
| landing | fill `--ty-landing` toàn ô |
| path | fill `--ty-path` 600 ms fade |
| selected (sheet mở) | viền navy 2 px bên trong |
| owner bankrupt | chấm chủ mất, nhà mất |

## 3. Token (quân cờ)

- Ghim bản đồ ~24 px màu ghế, đầu ghim tròn chứa avatar (hoặc `<img>` quân webp), viền navy 1.5 (DOM div).
- Vị trí: mũi ghim chạm mép **trong** của ô (hàng dưới: mép trên ô; hàng trên: mép dưới, ghim lộn ngược; cột trái/phải: mép trong, ở 80% chiều dài ô). Thân ghim nằm trong vùng trong để không che tên/giá. Nhiều quân cùng ô: dàn ngang theo thứ tự seat, mỗi quân lệch 2.6% cạnh bàn.
- Quân tới lượt: vòng gold blur 6 pulse 1.2 s.
- Quân phá sản: unmount sau step `bankrupt`.
- Người chơi chọn quân ở S5? **Không** — v1 gán quân theo seat (tokens/tk-{seat}) để không cần protocol chọn quân; 8 quân trong manifest dùng cho v2 chọn quân.

## 4. Dice

- Hai viên 40 × 40 tại 390 (44 khi bàn ≥ 456), radius 12 paper viền navy 2 shadow md, dot r 4 navy; 6 mặt SVG `dice/d1..d6.svg` (06 §6). Luôn nằm ở hàng 2 của `TurnCluster` (§6), khoảng giữa hai viên 16.
- Component `DiceRoll {dice:[a,b], rolling}`: khi rolling đổi mặt ngẫu nhiên mỗi 80 ms (client-only, không ảnh hưởng kết quả), kết thúc đúng mặt server.
- Reduced-motion: hiện mặt cuối ngay.

## 5. PlayerPod (1 hàng dưới bàn)

Hàng pod nằm ngay dưới bàn (02 §6.5): 2–4 pod chia đều `var(--ty-board)`, gap 6, theo thứ tự seat. Nền `--seat-soft`, viền 2 px `--seat`, radius 16. Có 3 bố cục theo chiều rộng pod và chỗ dư:

**Ngang (như concept; pod ≥ 128 px — 2 người ở mọi width, 3 người khi bàn ≥ 400; cao 64):**
```
┌──────────────────────────┐
│ ╭────╮  Bạn              │  avatar ⌀ 34 viền seat 2.5 px, sát trái, căn giữa dọc
│ │ ◕‿◕│  🪙 1.240 tr       │  tên 13.5/800 trên; xu 12 + tiền 14/800 tabular dưới
│ ╰────╯                   │
└──────────────────────────┘
```

**Compact (pod < 128 px — 4 người ở mọi width, 3 người ở 390; cao 64):**
```
┌───────────────┐
│ ◯ Bạn         │  hàng 1: avatar ⌀ 24 + tên 12.5/800 (ellipsis)
│ 🪙 1.240 tr   │  hàng 2: xu 12 + tiền 13.5/800 tabular, căn trái
└───────────────┘
```

**Mở rộng (khi màn dư chỗ, 02 §6.1; cao 96):** compact + hàng chip 11 px (số đất `ic-deed`, tổng cấp nhà `ic-house` jade, thẻ ra tù `ic-key` gold, đang ở tù `ic-jail-bars`) + thanh tổng tài sản 4 px (so với người dẫn đầu) sát đáy pod.

Ở compact/ngang (không có hàng chip), trạng thái thu thành badge 12 px trên avatar: vương miện (giàu nhất) góc trên-trái, song sắt (đang ở tù) góc dưới-phải, chìa khóa (có thẻ ra tù) góc dưới-trái.

- Tiền mặt luôn hiện, đổi màu 500 ms khi tăng/giảm; tiền bay `+/−` xuất phát từ dòng tiền.
- Tới lượt: nền `--seat-soft` đậm (≈ 60%) + viền 3 px + glow màu ghế; nhãn nhỏ `Lượt bạn` / `Đang nghĩ` / `Đang đi` dạng tab trên mép trên pod.
- Mất kết nối: ic-wifi-off đè góc avatar, pod 70% opacity.
- Phá sản: pod `--ty-bankrupt`, text `Phá sản`, giữ vị trí để pod row không nhảy.
- Sắp phá sản (pha debt của người đó): viền coral pulse.
- Tap pod → S8 ở chế độ xem (read-only) tài sản người đó.

## 6. TurnCluster (thay ActionBar, nằm giữa bàn)

- Vị trí: giữa vùng trong bàn, căn giữa ngang, tâm dọc ở 53%; rộng tối đa 246 tại 390 (vùng trong 266 trừ lề 10). Bảng vị trí và nội dung từng pha ở 02 §6.3.
- 3 hàng, cách nhau 10:
  1. chip lượt (pill cao 34: avatar 24 + `Lượt của bạn` 15/800; lượt mình nền gold, lượt người khác nền paper viền màu ghế) + `TurnClock` ⌀ 40 bên phải chip;
  2. xúc xắc (§4), hoặc thẻ sổ đỏ thu gọn 246 × 52 ở pha `decide`;
  3. nút theo pha, cao 48 (jail: 3 nút đứng 74 × 56). CTA đơn rộng 196; hai nút chia 40/60, nút gold bên phải.
- Không đổi vị trí giữa các pha: hàng 1 luôn ở chỗ cũ, chỉ hàng 2–3 thay nội dung, để mắt người chơi không phải dò lại.
- Khi `movePending`: nút vừa bấm hiện spinner 16, cả hàng 3 disabled. Thẻ O2 che cả cụm khi `card`.
- Nền cụm trong suốt, đặt trên paper vùng trong: chữ và icon navy, không dùng cream.

## 7. TurnClock

- Vòng tròn ⌀ 40 nằm bên phải chip lượt (hàng 1 TurnCluster). Cung gold chạy ngược theo thời gian còn, số `0:28` 15/800 tabular ở giữa; ≤ 10 s cung + số đổi `--ty-danger` + pulse + âm tick.
- Chỉ hiện khi tới lượt mình; lượt người khác thay bằng 3 chấm "đang nghĩ".
- Nguồn: `deadline` từ STATE/MATCH_FOUND, tick rAF; dừng khi `oppAway` của người tới lượt.

## 8. RoundChip

- Giữa header S6 (căn theo màn), pill paper viền navy 1.5, 108 × 32, `Vòng 7/30 · 18:20` 15/800 (giờ còn lại của 25 phút, đỏ khi ≤ 3 phút); 28–29 coral, 30 danger + chữ `Vòng cuối`. Có thể kèm thanh tiến độ 3 px dưới chữ.

## 9. DeedCard (trong S7) và GroupChip

- GroupChip: rect 12 × 12 màu nhóm viền navy 1 + tên nhóm 12.5/500.
- RentTable: 4 hàng `label | số` (Đất trống, Cấp 1–3), hàng áp dụng nền gold 30%; số tabular 13.5/800.
- OwnerChip: avatar 20 + `@ten` + chấm màu ghế.

## 10. Card (O2)

- 236 × 168 tại 390 (280 × 180 khi bàn ≥ 456), giữa vùng trong bàn, thay TurnCluster. Radius 16, viền navy 2, dải đầu 28 màu loại; nút `Làm theo thẻ` dính đáy thẻ (chỉ người rút); `aria-live="polite"` đọc nội dung.
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

## 16. FooterBar và dòng sự kiện

- Thanh cao 44 ở đáy màn (+ safe-area), rộng `var(--ty-board)`. Trái → phải:
  - pill `Tài sản` (icon sổ/danh sách) — mở S8 của mình;
  - pill `Diễn biến` (icon cột) — mở sheet diễn biến;
  - vạch ngăn dọc;
  - dòng sự kiện;
  - (bản online) `ic-chat` 44 ở phải cùng.
- Dòng sự kiện: icon xúc xắc 16 + câu log mới nhất 13/600, tên có màu ghế, số tiền jade/coral, 1 dòng cắt `…`. Sinh từ steps (`pay`, `buy`, `build`, `jail-in`, `bankrupt`, `card`, qua Xuất phát). Tap → sheet diễn biến đầy đủ (50 dòng; bản online là tab thứ 2 của ChatDrawer).
- Khi màn dư chỗ (02 §6.1): dòng sự kiện thành thẻ Diễn biến 2–6 dòng (mới ở trên) ngay trên thanh nút, lấp phần cao còn lại.

## 17. Accessibility

- Mọi ô, pod, nút có accessible name tiếng Việt; thẻ bài và turn announce `aria-live`.
- Màu ghế luôn kèm tên/avatar; màu nhóm đất luôn kèm tên nhóm trong sheet.
- Touch ≥ 44 trừ ô bàn cờ (đã nêu lý do ở 01 §4) và chấm nhà (không tương tác).
- Reduced-motion theo 01 §8; không âm thanh tự phát khi tắt loa.
