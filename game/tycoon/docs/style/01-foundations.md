# 01 — Foundations: token đầy đủ

File này là nguồn để tạo `game/tycoon/styles/tokens.css`. Mọi giá trị dưới đây là CSS custom property trên `:root[data-game="tycoon"]`.

## 1. Màu

### 1.1 Nền và bề mặt

```css
--ty-sky-top: #35C1FC;     /* nền màn UI v3: đỉnh gradient trời */
--ty-sky-bottom: #7FE3F7;  /* nền màn UI v3: chân trời, sau đó là cảnh pixel */
--ty-bg-900: #1E2A3A;      /* backdrop tối, toast danger */
--ty-bg-700: #2C3E55;      /* khung bàn */
--ty-bg-500: #3C5070;      /* hover trên nền navy */
--ty-paper: #FCFDF0;       /* bàn, ô, sheet, thẻ, modal, pod (lấy từ ảnh mẫu) */
--ty-paper-dim: #F0E4C8;   /* ô đặc biệt, hàng chẵn, panel phụ */
--ty-paper-deep: #E3D3AF;  /* pressed trên paper, divider đậm */
--ty-cream: #FFF8EA;       /* chữ trên navy */
--ty-navy: #1F2A44;        /* outline, chữ chính */
--ty-navy-60: rgba(31,42,68,.6);
--ty-navy-30: rgba(31,42,68,.3);
--ty-line: #8C7B5E;        /* lưới ô */
--ty-overlay: rgba(20,27,38,.62);
```

### 1.2 Accent

```css
--ty-gold: #F2B807;  --ty-gold-light: #FFD34D;  --ty-gold-deep: #B98700;
--ty-jade: #1F8A5B;  --ty-jade-light: #3BA776;  --ty-jade-deep: #156842;
--ty-coral: #E4573D; --ty-coral-light: #F07A63; --ty-coral-deep: #B8382A;
--ty-sky: #7EC8E3;   --ty-sky-deep: #3C9BBF;
--ty-danger: #B3261E;
--ty-chance: #F9863B; --ty-chance-deep: #E0560E;   /* Cơ hội: chồng thẻ, dấu ? */
--ty-chest: #6DD9FD;  --ty-chest-deep: #0D95EE;    /* Khí vận: chồng thẻ, glyph gió */
--ty-festival-bg: #0B1F66;                         /* nền ô Lễ hội */
```

Mã màu Cơ hội, Khí vận, Lễ hội đo từ ảnh mẫu. Cơ hội đổi từ gold sang cam để không lẫn với CTA gold.

### 1.3 Nhóm đất (8)

```css
--ty-g-brown: #8D5B3C;   --ty-g-brown-on: var(--ty-cream);
--ty-g-sky: #7EC8E3;     --ty-g-sky-on: var(--ty-navy);
--ty-g-pink: #E58FB5;    --ty-g-pink-on: var(--ty-navy);
--ty-g-orange: #F2994A;  --ty-g-orange-on: var(--ty-navy);
--ty-g-red: #D64545;     --ty-g-red-on: var(--ty-cream);
--ty-g-yellow: #F2D04E;  --ty-g-yellow-on: var(--ty-navy);
--ty-g-green: #3BA776;   --ty-g-green-on: var(--ty-navy);
--ty-g-blue: #2F5FD0;    --ty-g-blue-on: var(--ty-cream);
```

`*-on` chỉ dùng cho **glyph/dot cỡ ≥ 12 px** đặt trên dải (ví dụ chấm nhà trong chip nhóm). **Chữ không bao giờ đặt trên dải màu** — tên nhóm/tên ô luôn navy trên paper ngay dưới dải. Lý do: đỏ `#D64545` không đạt AA với cả navy lẫn cream ở chữ 12.5 px.

### 1.4 Ghế (4)

```css
--ty-seat-0: #F2B807;  --ty-seat-0-soft: #FBE9A6;
--ty-seat-1: #2F9BD6;  --ty-seat-1-soft: #BFE2F5;
--ty-seat-2: #E4573D;  --ty-seat-2-soft: #F8C9BF;
--ty-seat-3: #8E5BD9;  --ty-seat-3-soft: #DCCBF4;
```

`-soft` dùng làm nền chip tên trong chat/log (chữ navy), nền pod khi tới lượt (10% blend). Ghế 0 trùng gold CTA là cố ý: người tạo bàn luôn seat 0, "chủ bàn = vàng" dễ nhớ; để không nhầm với CTA, pod seat 0 luôn kèm avatar + tên, CTA không bao giờ nằm cạnh pod.

### 1.5 Semantic

```css
--ty-turn-mine: var(--ty-gold);
--ty-turn-other: rgba(255,248,234,.6);
--ty-money-up: var(--ty-jade);
--ty-money-down: var(--ty-coral);
--ty-landing: rgba(242,184,7,.45);
--ty-path: rgba(242,184,7,.25);
--ty-bankrupt: rgba(31,42,68,.35);
--ty-focus: var(--ty-navy);   /* ring navy để thấy được cả trên nút gold */
--ty-disabled-opacity: .45;
--ty-deck-chance: var(--ty-chance);
--ty-deck-chest: var(--ty-chest);
```

## 2. Chữ

```css
--ty-font: 'Nunito', ui-sans-serif, system-ui, sans-serif; /* dùng font local hiện có của Caro */
--ty-fs-title: 24px;  --ty-fw-title: 800;
--ty-fs-announce: 20px; --ty-ls-announce: .04em;
--ty-fs-cta: 17px;    --ty-fw-cta: 700;
--ty-fs-body: 15px;   --ty-fw-body: 600;
--ty-fs-money: 15px;  --ty-fw-money: 800;
--ty-fs-money-lg: 22px;
--ty-fs-tile-name: 20px;
--ty-fs-rent: 13.5px;
--ty-fs-caption: 12.5px; --ty-fw-caption: 500;
--ty-fs-round: 13px;
--ty-fs-card: 16px;
--ty-lh-tight: 1.15; --ty-lh-body: 1.35;
```

Số tiền: `font-variant-numeric: tabular-nums`. Tên người: luôn `@username` kèm icon VIP (`../03-component-specs.md` §18); cắt ellipsis 12 ký tự trong pod, 16 trong list (không tính `@`).

Nunito có weight 400–800 và đủ glyph tiếng Việt, đã khai báo tại `game/tycoon/style.css`. Kích thước chữ riêng lobby S2 theo [S2 lobby §3](./screens/s2-lobby/README.md#3-chữ-và-màu), không thay scale control S6 ở trên.

## 3. Spacing và kích thước

```css
--ty-sp-1: 4px; --ty-sp-2: 8px; --ty-sp-3: 12px; --ty-sp-4: 16px;
--ty-sp-5: 20px; --ty-sp-6: 24px; --ty-sp-8: 32px;
--ty-gutter: 12px;             /* lề màn */
--ty-touch: 44px;
--ty-btn-h: 52px; --ty-btn-h-big: 64px; --ty-btn-h-small: 40px;
--ty-pod-w: 86px; --ty-pod-h: 88px;
--ty-pawn-w: 16px; --ty-pawn-h: 24px;   /* quân hình con tốt */
--ty-house: 6px; --ty-hotel-w: 14px; --ty-hotel-h: 8px;
--ty-owner-dot: 8px;
--ty-dice: 44px;
--ty-card-w: 236px; --ty-card-h: 168px;       /* thẻ O2 tại 390 (vùng trong 266) */
--ty-card-w-lg: 280px; --ty-card-h-lg: 180px; /* khi bàn ≥ 456 */
--ty-sheet-handle-w: 36px;
```

Bàn: `--ty-board: min(100vw - 2 * var(--ty-gutter), 480px)`; `--ty-corner: calc(var(--ty-board) * .136)`; `--ty-edge: calc((var(--ty-board) - 2 * var(--ty-corner)) / 7)` (bàn 32 ô: mỗi cạnh 2 góc + 7 ô; khớp `CORNER = 13.6` trong `components/Board.tsx`). Tại 390: bàn 366, góc 49.8, cạnh 38.1.

## 4. Radius

```css
--ty-r-8: 8px; --ty-r-12: 12px; --ty-r-16: 16px; --ty-r-20: 20px; --ty-r-28: 28px; --ty-r-pill: 999px;
```

Ánh xạ: ô bàn 0 · chip nhóm/nhà/tooltip 8 · input/xúc xắc/badge/chồng thẻ 12 · thẻ/row/nút đứng pha jail 16 · modal 20 · sheet/result 28 · nút `.ty-btn`/chip lượt/chip vòng/pill footer/avatar/dot pill.

## 5. Viền và shadow

```css
--ty-bw-thin: 1.5px; --ty-bw: 2px; --ty-bw-board: 3px;
--ty-sh-sm: 0 1px 2px rgba(31,42,68,.25);
--ty-sh-md: 0 3px 8px rgba(31,42,68,.30);
--ty-sh-lg: 0 10px 28px rgba(31,42,68,.38);
--ty-sh-raise-gold: 0 4px 0 var(--ty-gold-deep);   /* mép dưới nổi khối của nút gold */
--ty-sh-raise: 0 3px 0 rgba(31,42,68,.35);         /* mép dưới chồng thẻ, xúc xắc */
--ty-glow-turn: 0 0 6px 2px rgba(242,184,7,.7);
--ty-glow-debt: 0 0 6px 2px rgba(228,87,61,.7);
```

## 6. Z-index

```css
--ty-z-board: 1; --ty-z-token: 5; --ty-z-board-overlay: 10;   /* xúc xắc, thẻ giữa bàn */
--ty-z-bar: 20; --ty-z-banner: 30; --ty-z-sheet: 40; --ty-z-modal: 50;
--ty-z-toast: 60; --ty-z-announce: 70;
```

## 7. Motion

```css
--ty-ease: cubic-bezier(.2,.8,.3,1);
--ty-ease-hop: cubic-bezier(.3,.9,.4,1);
--ty-t-fast: 120ms; --ty-t-base: 180ms; --ty-t-slow: 240ms;
--ty-t-hop: 140ms;          /* mỗi ô quân nhảy */
--ty-t-dice: 720ms; --ty-t-flip: 360ms; --ty-t-count: 500ms;
--ty-t-announce-hold: 900ms;
```

`@media (prefers-reduced-motion: reduce)`: `--ty-t-hop: 0ms`, `--ty-t-dice: 0ms`, `--ty-t-flip: 0ms`, tắt keyframes pulse/float.

## 8. Surface matrix

| Surface | Nền | Chữ | Viền | Icon |
|---|---|---|---|---|
| màn (UI v3) | gradient sky-top→sky-bottom + `bg-board-pixel.webp` (mây, cây, mái nhà pixel ở viền) | navy, chỉ đặt trên surface paper | — | navy trên nút paper |
| cụm lượt (giữa bàn, UI v3) | trong suốt trên paper vùng trong | navy | — | navy |
| paper (sheet/modal/pod/bàn) | paper | navy | navy 2 | navy |
| paper-dim (ô đặc biệt, row chẵn) | paper-dim | navy | line 1 | theo 02 |
| gold (CTA) | gradient gold-light→gold + `--ty-sh-raise-gold` | navy | gold-deep 2 | navy |
| jade (Sẵn sàng) | jade | cream | navy 2 | cream |
| danger | danger | cream | navy 2 | cream |
| seat-soft (chip tên) | seat-n-soft | navy | seat-n 1.5 | navy |
| deck chance (chồng thẻ, dải thẻ) | chance | navy | navy 2 | cream `?` viền navy |
| deck chest (chồng thẻ, dải thẻ) | chest | navy | navy 2 | chest-deep |
| ô Lễ hội | festival-bg + tranh pixel đèn lồng | cream | line 1 | gold |

## 9. Trạng thái chung

| State | Quy tắc |
|---|---|
| hover (pointer) | viền 2 px + `translateY(-1px)`; không đổi màu nền |
| active/pressed | `translateY(0)`, shadow sm, nền paper → paper-deep |
| focus-visible | ring `--ty-focus` 2 px, offset 3 px (khe offset là nền paper để tách khỏi nút), không bỏ outline; dùng chung mọi màn, kể cả S2 |
| disabled | opacity `--ty-disabled-opacity`, không shadow, `cursor: not-allowed`, kèm lý do text nếu là hành động trong ván |
| loading | spinner 16 px thay icon, chữ giữ nguyên, bar disabled |
| selected (ô) | viền navy 2 px bên trong ô |
