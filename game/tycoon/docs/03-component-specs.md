# 03 — Component specifications

Mọi số đo tại viewport 390; bàn 366. Class prefix `ty-`.

## 1. BoardSurface (SVG code-native)

- `<svg viewBox="0 0 366 366">` (số thực theo width), nền `--ty-paper`, viền ngoài navy 3 px, radius 8.
- Lưới 32 ô vẽ bằng `<rect>` + `<line>` `--ty-line` 1 px; ô góc 49.8, ô cạnh 38.1 × 49.8. Vị trí ô theo `tileRect(idx)`: góc ở `idx % 8 == 0`, Xuất phát dưới-trái, thuận kim đồng hồ.
- Vùng trong (72.8% cạnh bàn): nền paper trơn, không watermark/logo. Chứa 2 chồng thẻ ở 2 góc trên và `TurnCluster` (§6) ở giữa — vị trí chi tiết ở 02 §6.3. Cụm lượt, thẻ O2, turn announce là DOM tuyệt đối đè lên bàn.
- Thứ tự layer: nền → tranh pixel ô (`<image>` webp, `image-rendering: pixelated`) → dải màu → nhà → chấm chủ sở hữu → glyph ô → highlight landing/path → quân (DOM, không SVG, để animate dễ) → overlay.
- Màn S6 nằm trên nền trời pixel (01 §7); bàn có viền ngoài navy 3 px để tách khỏi nền.
- Mỗi ô là `<g data-tile={idx}>` có `role="button"` + `aria-label="Đà Lạt, nhóm Đỏ, của @an, 2 nhà"`; hit rect mở rộng 4 px.

## 2. Tile

### 2.1 Anatomy ô đất (cạnh dưới, 38.1 × 49.8)
- Dải màu nhóm: rect 38.1 × 7–9 ở mép phía **trong** bàn (mép giáp vùng trong), viền navy 1 px ở cạnh giáp thân ô; nhà/khách sạn nằm trên dải.
- Thân ô, chữ luôn đứng thẳng, ba tầng từ trên xuống:
  1. **tên ngắn** (`shortName`) 800, cỡ `board × 0.0182` (6.7 px tại 366), tối đa 2 dòng, sát mép trên thân;
  2. **tranh pixel 16-bit** địa danh (ô đất, ô sân bay) hoặc glyph (Cơ hội, Khí vận, Thuế) ở giữa, phủ hết chiều rộng thân ô — tại 390 chỉ còn ≈ 36 × 22 px, tranh rõ từ bàn ≥ 456;
  3. **giá** `220 tr` tabular sát mép dưới thân; ô có chủ đổi thành viên tiền thuê.
- Ô có chủ: nền `SEAT_SOFT_COLORS` + vạch 3 px màu ghế ở mép **ngoài** ô (đối diện dải nhóm), thay chấm chủ.
- Cột trái/phải: khung và dải xoay theo cạnh (dải ở mép trong theo trục ngang); ba tầng chữ/tranh/giá **không xoay**, vẫn đọc từ trên xuống. Hàng trên: dải ở đáy ô, tên vẫn ở đỉnh.

### 2.2 Ô đặc biệt
- Nền `--ty-paper`, không dải. Sân bay: tranh pixel `art/san-bay`. Cơ hội, Khí vận, Thuế: glyph 18 px (grid 32 scale 0.56) màu theo `style/02-board-tiles.md` §2.
- Ô góc 49.8 × 49.8 (class `ty-tile-corner-bl|tl|tr|br` theo vị trí): chữ in hoa 1 dòng trên, hình giữa, dòng phụ dưới (`style/02-board-tiles.md` §3). Không bust nhân vật. Ô 8 (Nhà tù, góc trên-trái): tranh pixel phòng giam có Anh Tèo ở giữa, dải `Thăm tù` ở đáy ô. Quân trong tù đứng trong tranh sau song, quân thăm đứng ở dải `Thăm tù`.

### 2.3 Cấp nhà (3 cấp)
- Cấp 1 · Nhà: 1 `tg-house` fill jade 6 × 6 (nóc tam giác + thân) trên dải màu.
- Cấp 2 · Biệt thự: 2 `tg-house` xếp ngang, gap 1 px.
- Cấp 3 · Khách sạn: 1 `tg-hotel` fill coral 14 × 8 với nóc, thay 2 nhà.
- Tên cấp lấy từ `LEVEL_NAMES` (`constants.ts`), nhãn đầy đủ `Cấp n · Tên` từ `levelLabel()` (`helpers/tiles.ts`).
- Ở size này không có outline navy (quá nhỏ); fill + viền cream 1 px để nổi trên mọi dải màu (kể cả jade trên dải xanh lá, coral trên dải đỏ).

### 2.4 State
| State | Hiển thị |
|---|---|
| landing | fill `--ty-landing` toàn ô |
| path | fill `--ty-path` 600 ms fade |
| selected (sheet mở) | viền navy 2 px bên trong |
| owner bankrupt | chấm chủ mất, nhà mất |

## 3. Token (quân cờ)

- Con tốt board game 16 × 24 tại 390 (đầu tròn, cổ thắt, đế loe), fill màu ghế, viền navy 1.5, vùng sáng ở đầu và mép tối ở đế (như ảnh mẫu). SVG inline đổi màu theo `--ty-seat-n`; không có avatar trên quân — danh tính đọc bằng màu ghế khớp pod.
- Vị trí: đế quân đứng trên mép **trong** của ô (hàng dưới: mép trên ô; hàng trên: mép dưới; cột trái/phải: mép trong, ở 80% chiều dài ô). Quân luôn đứng thẳng, thân nhô vào vùng trong để không che tên/giá. Nhiều quân cùng ô: dàn ngang theo thứ tự seat, mỗi quân lệch 2.6% cạnh bàn.
- Quân tới lượt: vòng gold blur 6 pulse 1.2 s.
- Quân phá sản: unmount sau step `bankrupt`.
- Người chơi chọn quân ở S5? **Không** — v1 gán quân theo seat (tokens/tk-{seat}) để không cần protocol chọn quân; 8 quân trong manifest dùng cho v2 chọn quân.

## 4. Dice

- Hai viên 40 × 40 tại 390 (44 khi bàn ≥ 456), radius 12, mặt trắng, viền navy 2, nổi khối (mép dưới `--ty-sh-raise` + bóng mềm dưới viên), hai viên nghiêng nhẹ ngược chiều nhau (±8°) như ảnh mẫu; dot r 4 navy; 6 mặt SVG `dice/d1..d6.svg` (06 §6). Luôn nằm ở hàng 2 của `TurnCluster` (§6), khoảng giữa hai viên 16.
- Component `DiceRoll {dice:[a,b], rolling}`: khi rolling đổi mặt ngẫu nhiên mỗi 80 ms (client-only, không ảnh hưởng kết quả), kết thúc đúng mặt server.
- Reduced-motion: hiện mặt cuối ngay.

## 5. PlayerPod (1 hàng dưới bàn)

Hàng pod nằm ngay dưới bàn (02 §6.5): 2–4 pod chia đều `var(--ty-board)`, gap 6, theo thứ tự seat. Nền `--seat-soft`, viền 2 px `--seat`, radius 16. Có 3 bố cục theo chiều rộng pod và chỗ dư:

**Ngang (như concept; pod ≥ 128 px — 2 người ở mọi width, 3 người khi bàn ≥ 400; cao 64):**
```
┌──────────────────────────┐
│ ╭────╮  Bạn / @username  │  avatar VIP ⌀ 34 viền seat 2.5 px, sát trái, căn giữa dọc (§18)
│ │ ◕‿◕│  🪙 1.240 tr       │  tên 13.5/800 trên; xu 12 + tiền 14/800 tabular dưới
│ ╰────╯                   │
└──────────────────────────┘
```

**Compact (pod < 128 px — 4 người ở mọi width, 3 người ở 390; cao 64):**
```
┌───────────────┐
│ ◯ @username   │  hàng 1: avatar VIP ⌀ 24 + `Bạn`/`@username` 12.5/800 (ellipsis, §18)
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
- 3 hàng chính + 1 dòng gợi ý, cách nhau 10:
  1. chip lượt (pill cao 34: avatar VIP 24 + `Lượt của bạn` / `Lượt của @username` 15/800; lượt mình nền gold, lượt người khác nền paper viền màu ghế) + `TurnClock` ⌀ 40 bên phải chip;
  2. xúc xắc (§4), hoặc thẻ sổ đỏ thu gọn 246 × 52 ở pha `decide`;
  3. nút theo pha, cao 48 (jail: 3 nút đứng 74 × 56). CTA đơn rộng 196; hai nút chia 40/60, nút gold bên phải;
  4. dòng gợi ý `Thắng ngay: 3 nhóm · 1 cạnh · 4 sân bay` — pill paper-dim, chữ 12.5/600 navy 70%, chỉ hiện ở pha `roll` của mình; pha khác ẩn để không chật.
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
- OwnerChip: avatar VIP 20 + `@username` (của mình: `Bạn`) + chấm màu ghế (§18).

## 10. Card (O2)

- 236 × 168 tại 390 (280 × 180 khi bàn ≥ 456), giữa vùng trong bàn, thay TurnCluster. Radius 16, viền navy 2, dải đầu 28 màu loại; nút `Làm theo thẻ` dính đáy thẻ (chỉ người rút); `aria-live="polite"` đọc nội dung.
- Mặt sau: nền `--ty-chance` (Cơ hội) hoặc `--ty-chest` (Khí vận), chữ `CƠ HỘI` / `KHÍ VẬN` navy 800 ở trên, glyph 48 giữa (`?` cream viền navy / gió `--ty-chest-deep`) — giống chồng thẻ giữa bàn.
- Chồng thẻ giữa bàn (trang trí): 3 lớp lệch nhau 3 px, radius 12, viền navy 2, mép dưới `--ty-sh-raise`, mặt trên như mặt sau thẻ.
- Flip bằng `rotateY` 2 mặt `backface-visibility: hidden`.

## 11. BottomSheet (S7, S8)

- Trượt từ dưới, radius 28 trên, handle 36 × 4 navy 30%, backdrop `--ty-overlay`.
- Max height theo màn; nội dung scroll; nút hành động dính đáy sheet (sticky) cao 52 + safe-area.
- Đóng: kéo xuống, tap backdrop, nút ic-close; khi `decide` đóng sheet **không** gửi DECLINE (bar vẫn còn nút).

## 12. Modal (S4, S9, O3, O5)

- 340 × auto, radius 22, paper, viền navy 2, bóng `0 6px 0 ink` + shadow lg; title 21/800; nút hàng ngang 2 (CTA phải, nút phụ trái).
- Modal xác nhận/thông báo O5: [style O5](./screens/o5-modal/README.md).
- Focus trap, `Escape` đóng (trừ S9, O3).

## 13. Buttons

| Class | Nền | Chữ | Viền | Dùng |
|---|---|---|---|---|
| `.ty-btn-gold` | gradient gold + mép dưới 4 px gold-deep | navy 17/800 | gold-deep 2 | hành động chính của pha |
| `.ty-btn-paper` | paper | navy 15/600 | navy 2 | phụ |
| `.ty-btn-jade` | jade | cream 16/700 | navy 2 | Sẵn sàng, Mua (biến thể khi muốn nhấn "được tiền") — v1 chỉ dùng cho Sẵn sàng |
| `.ty-btn-danger` | danger | cream 15/700 | navy 2 | Phá sản, Bỏ cuộc trong confirm |
| `.ty-btn-text` | — | cream 15/600 | — | Hủy, Luật chơi |
| `.ty-icon-btn` | paper | navy | navy 1.5 | 44 × 44 tròn (header S6 trên nền trời) |

Mọi `.ty-btn` radius pill (ảnh mẫu); riêng nút đứng pha jail radius 16.

State: hover viền 2 + translateY(−1); active translateY(0) shadow sm; disabled opacity 45% không shadow; focus-visible ring navy 2 px offset 3 (01-foundations §9); loading spinner thay icon.

## 14. Chip / Badge

- `.ty-chip` paper viền navy 1.5 radius 8, 12.5/600; `.ty-chip-gold`, `.ty-chip-jade`, `.ty-chip-coral` đổi nền.
- `.ty-money` số tabular + hậu tố ` tr` 80% opacity; `.ty-money-up/down` màu + float.
- `.ty-seat-badge` chấm 10 px màu ghế dùng trong chat và log.

## 15. ChatDrawer, ReactionPicker, Toast, OppAwayBanner, ConfirmModal

Dùng lại cấu trúc xiangqi (`03-component-specs` §chat/reaction/toast), đổi token `--xq-*` → `--ty-*`. Chat trong ván: mỗi tin bắt đầu bằng chấm màu ghế + icon VIP 14 + `@username` (§18). Reaction bay từ pod người gửi.

## 16. FooterBar và dòng sự kiện

- Thanh cao 44 ở đáy màn (+ safe-area), rộng `var(--ty-board)`. Trái → phải:
  - pill `Tài sản` (icon sổ/danh sách) — mở S8 của mình;
  - pill `Diễn biến` (icon cột) — mở sheet diễn biến;
  - vạch ngăn dọc;
  - dòng sự kiện;
  - (bản online) `ic-chat` 44 ở phải cùng.
- Dòng sự kiện: icon xúc xắc 16 + câu log mới nhất 13/600, người chơi hiện bằng `PlayerName` (icon VIP + `@username` màu ghế, §18), số tiền jade/coral, 1 dòng cắt `…`. Sinh từ steps (`pay`, `buy`, `build`, `jail-in`, `bankrupt`, `card`, qua Xuất phát). Tap → sheet diễn biến đầy đủ (50 dòng; bản online là tab thứ 2 của ChatDrawer).
- Khi màn dư chỗ (02 §6.1): dòng sự kiện thành thẻ Diễn biến 2–6 dòng (mới ở trên, mỗi dòng giờ `18:20` + chấm màu ghế + câu) ngay trên thanh nút, lấp phần cao còn lại. Lúc đó footer **bỏ** dòng sự kiện, chỉ còn các nút — chỉ một vùng log tại một thời điểm (ảnh mẫu vẽ cả hai, không làm theo).
- Footer nằm trên nền trời: pill nền paper viền navy 1.5, chữ/icon navy.

## 17. Accessibility

- Mọi ô, pod, nút có accessible name tiếng Việt; thẻ bài và turn announce `aria-live`.
- Màu ghế luôn kèm tên/avatar; màu nhóm đất luôn kèm tên nhóm trong sheet.
- Touch ≥ 44 trừ ô bàn cờ (đã nêu lý do ở 01 §4) và chấm nhà (không tương tác).
- Reduced-motion theo 01 §8; không âm thanh tự phát khi tắt loa.

## 18. Tên người chơi và icon VIP (`PlayerName`, `PlayerAvatar`)

Áp dụng cho **mọi** chỗ hiện người chơi: S2 topbar, S3 hàng bàn, S5 ghế, S6 pod/chip lượt/dòng chờ/footer log, S7 chủ sở hữu, S8, S9, S11, O3, O4, chat, toast.

- **Tên:** luôn là `@username` (`PlayerInfo.name` / `UserInfoData.username` / `LeaderboardEntry.username`), live text, không dịch, không viết hoa. Ellipsis đếm phần sau `@`: 12 ký tự trong pod/chip, 16 trong list; `aria-label` đọc đủ tên.
- **Chính mình:** ở pod, chip lượt và câu log có chủ ngữ là mình thì ghi `Bạn` (`Lượt của bạn`, `Bạn vừa qua Xuất phát`). Ở danh sách có nhiều người (ghế S5, bảng S9, BXH S11, chủ sở hữu S7 khi xem của người khác) vẫn ghi `@username` của mình.
- **Avatar = icon VIP:** game không có ảnh đại diện; vòng avatar hiện ảnh VIP `avatarIconUrl(vipType)` (`game/src/sdk/avatar.ts`, catalog `@ola/shared/lib/vip`), chưa có VIP thì `ola_smiley_online.png`. Chỗ đã có avatar thì **không** chồng thêm badge VIP thứ hai (như thirteen).
- **Chỗ chỉ có chữ** (footer log, thẻ Diễn biến, dòng chờ dưới chip lượt, banner O4, popup O3, chat, toast): `PlayerName` = icon VIP 14 px (`vipIconUrl`) + khoảng 4 + `@username` tô màu ghế (navy nếu không có ghế). User không có VIP thì bỏ icon, không chèn mặt cười.
- **Bot** (bản chơi với máy): tên hiển thị `Bot 1`, `Bot 2`, `Bot 3` theo danh sách thiết lập, dùng nhất quán ở modal/S6/S9/log, không có `@` vì không phải tài khoản; avatar theo VIP gán cho bot như xiangqi (`BOT_VIP_ID`), chỗ chỉ có chữ không có icon VIP. Pod S6 và bảng S9 có thêm nhãn mức độ `Dễ`/`Thường`/`Khó` cạnh tên ([02 §2.3](./02-screen-specs.md#23-modal-chơi-với-máy-botsetupmodal)).
- Thứ tự trong `PlayerName`: [chấm màu ghế nếu là chat] → icon VIP → `@username`. Không đặt icon VIP sau tên.
