# 03 — Component specifications

Mọi component viết CSS/SVG code-native trừ khi ghi rõ raster. Số đo tại viewport 390; scale theo `--xq-cell` (khoảng lưới, default 40 px).

---

## 1. BoardSurface (SVG code-native)

Một `<svg viewBox="0 0 720 800">` (đơn vị = cell/2 = 20) render tĩnh, không re-render theo state:

- **Khung**: nền `--xq-paper`, viền ngoài `--xq-line` 3 px, khung gỗ bọc ngoài (CSS border-image hoặc box-shadow lồng `--xq-wood-500/700`) dày 12 px, radius 12.
- **Lưới**: 9 đường dọc × 10 đường ngang, nét 1.5; đường dọc **đứt quãng ở sông** (hàng 4→5) trừ 2 biên.
- **Cung**: 2 gạch chéo nối 4 góc cung (x 3–5, y 0–2 và 7–9).
- **Chấm mốc**: cross-mark 4 góc nhỏ tại vị trí khởi đầu Pháo (2 điểm/bên) và Tốt (5 điểm/bên); điểm sát biên chỉ vẽ nửa trong.
- **Sông**: chữ `楚河`(trái) `漢界`(phải) 28 px, fill `--xq-line` 40%, font serif CJK hệ thống, `aria-hidden`.
- Tọa độ giao điểm: `cx = margin + x*cell`, `cy = margin + y*cell`, margin = cell/2.

## 2. Piece (button)

- `<button class="xq-piece">` absolute tại giao điểm, đường kính `0.92 × cell`, radius 999.
- Nền: asset webp mặt quân (`pieces/{side}{kind}.webp`) — đĩa kem gradient + viền kép + chữ Hán khắc (raster, xem 04 §3).
- `aria-label` live: `"Xe đỏ, cột 1 hàng 10"` (label VN từ `pieces.ts` + tọa độ hiển thị theo phía người xem).
- States:
  - `selected`: translateY(-2), shadow lg, vòng gold 2 px;
  - `selectable` (quân mình, tới lượt): cursor pointer; quân địch/khác lượt: không tương tác (trừ khi là đích ăn được);
  - `capture-target`: vòng `--xq-hint-capture` 3 px đè lên;
  - `in-check` (Tướng): vòng `--xq-check` pulse 1 s;
  - `dimmed` (pregame): opacity .4, disable.
- Di chuyển bằng `transform: translate()` + transition 220 ms (steps replay); bị ăn: class `captured` → scale .8 fade 180 ms rồi unmount.

## 3. MoveHintDot

- Chấm `0.3 × cell` radius 999, `--xq-hint`, tâm tại giao điểm đích trống; xuất hiện fade+scale 120 ms stagger.
- Là button với `aria-label` `"Đi tới cột x hàng y"`; vùng chạm 44×44 (pseudo-element).
- Đích là quân địch → không render dot, render vòng `capture-target` trên quân (xem §2).

## 4. LastMoveMarker

- 2 ô vuông bo 8, `--xq-last-move`, tại giao điểm from (rỗng, viền 2 px) và to (đặc, dưới quân); z dưới quân trên lưới.

## 5. CheckBanner

- Pill giữa màn trên board: nền `--xq-red`, chữ kem `Chiếu tướng!` 20/800, icon ⚠ 20.
- Slide-down + shake, tự ẩn 1.2 s; kèm âm `check`. Trigger từ step `check` trong replay hoặc `state.check` khi resume.

## 6. PlayerPod (opponent / mine)

- Khối ngang 372×64: avatar 48 (viền phe: đỏ `--xq-red-deep` / đen `--xq-ink` 2 px) + VIP icon, tên 15/600 + chip phe `Đỏ`/`Đen` 12/700.
- **TurnClock**: vòng tròn 44 quanh avatar — conic-gradient gold cạn dần theo thời gian còn lại + số giây 22/800 cạnh tên khi ≤ 10 s (đổi `--xq-danger` + pulse).
- **CapturedTray**: hàng mini quân đã ăn được của đối phương (đường kính 18, tối đa 8 hiện + `+n`), giúp đọc thế trận nhanh.
- KEN float `−{bet}` / `+{payout}` bay từ pod (keyed `matchSeq` restart animation — pattern caro BoardHeader).

## 7. BetBadge

- Chip nền `--xq-gold` viền `--xq-gold-deep`, icon ken 16 + `formatKen(bet)` 14/800 navy; bet 0 → chip kem `Giao hữu`.

## 8. ActionBar (đáy màn chơi)

- 4 nút 64×56 (icon 24 + label 11): Chat (badge chấm đỏ khi tin mới), Cảm xúc, `Bỏ cuộc` (đỏ), `Thoát`.
- Pregame đổi bộ nút theo vai (xem 02 §5.2). Disabled khi `movePending` với hành động gửi lệnh.

## 9. Buttons

| Loại | Style |
|---|---|
| CTA vàng | nền gradient gold, viền `--xq-gold-deep` 2, chữ navy 17/700, radius 16, h 52–64; pressed translateY(1); loading: spinner navy 18 thay chữ |
| Nút giấy | nền `--xq-paper` viền navy 2, chữ navy 15/700, radius 16 |
| Nút danger | nền `--xq-danger` chữ kem — chỉ trong ConfirmModal |
| Icon button | 44×44 radius 12, viền navy 1.5 |

Focus ring: outline gold 2 px offset 2. Disabled: opacity .45 + pointer-events none.

## 10. Modal & ConfirmModal

- Backdrop `--xq-overlay` fade 150 ms; modal giấy kem radius 20, viền navy 2, shadow lg, pop 180 ms.
- ConfirmModal: title 17/700, body 14/500, 2 nút cách 12 px (primary phải). Focus trap + Esc (tái dùng `helpers/dialog.ts` caro).

## 11. Input

- H 48, radius 12, nền `#FFFBEF`, viền navy 1.5 (focus: gold 2), chữ 15/600; input số dùng `inputmode="numeric"`; quick-chip cược: chip 8, viền navy 1.5, active nền gold.

## 12. RoomRow / HistoryRow / LeaderboardRow

- H 56, nền xen kẽ `--xq-paper`/`--xq-paper-dim`, radius 12, viền navy 1 px 40%.
- Cấu trúc cột theo 02 §3.2/§8/§9; số KEN tabular; chip kết quả radius 999.

## 13. Toast & TurnAnnounce

- Toast: pill navy 92% chữ kem 14/600, đáy 96 px, fade+rise 200 ms, giữ 2.4 s.
- TurnAnnounce: text 20/800 gold giữa màn, fade-scale, `aria-live="polite"`.

## 14. OppAwayBanner

- Thanh đỉnh 372×44 nền navy 92%, icon wifi-off 18, chữ kem 14/600 `Đối thủ mất kết nối, chờ {s}s...`, countdown tabular.

## 15. ChatDrawer & ReactionPicker

- Drawer đáy responsive `360–500 px` (khoảng 54% baseline), có scrim bấm để đóng và `Esc`; header gỗ hiển thị phạm vi trong bàn, list có tên + giờ, bubble mình phải/vàng và đối thủ trái/giấy; input có bộ đếm 120 ký tự, giữ 20 tin.
- ReactionPicker: popover 6 icon 40 (asset caro), balloon bay theo `useXiangqi.subscribe` ngoài render (pattern caro ReactionBalloons).

## 16. Accessibility checklist (mọi component)

- Live text cho mọi label/số; `aria-live` cho turn announce, check banner, toast.
- Board có mô tả text ẩn: `"{Quân} {phe} từ {ô} đến {ô}"` sau mỗi nước (SR announce).
- Touch ≥ 44; focus ring rõ trên mọi nền; contrast AA; reduced-motion tôn trọng toàn bộ §8 của 01.
