# 04 — Asset manifest and generation

## 1. Chiến lược asset

Thứ tự ưu tiên (kế thừa policy thirteen):

1. **CSS token / component thuần CSS** — nút, panel, badge, input, toast.
2. **SVG code-native trong repo** — bàn cờ (BoardSurface), icon `ic-*`, app icon nguồn.
3. **Raster tái dùng** — reaction (`../caro/assets/reactions/*.webp`), VIP icons (shared), `ola_smiley_online.png`.
4. **Raster sinh mới** — CHỈ: 14 mặt quân, nền lobby, logo, minh họa result. Mỗi asset sinh phải có dòng log theo [asset-generation-log.template.md](./asset-generation-log.template.md).

Budget: initial load (lobby critical) ≤ 160 KB gzip; toàn bộ assets xiangqi ≤ 700 KB. Thêm `/game/xiangqi/assets/` vào `assetsInlineLimit` của `game/vite.config.ts` (chặn inline data-URI để preload runtime kiểm soát priority).

## 2. Quy tắc đặt tên

- `pieces/{side}{kind}.webp` — side `r|b`; kind `k,a,e,h,r,c,p` (General/Advisor/Elephant/Horse/chaRiot/Cannon/Pawn — khớp mã quân server 1..7). VD `rk.webp` = 帥, `bc.webp` = 砲.
- `ic-{tên}.svg` icon UI; `pat-{tên}` pattern; `fx-{tên}` hiệu ứng; `bg-{màn}` nền.
- Không viết hoa, không space; webp cho raster, svg cho vector.

## 3. Mặt quân — script sinh tự động

`game/scripts/generate_xiangqi_pieces.sh` (pattern `generate_thirteen_cards.sh`: heredoc SVG → `rsvg-convert` → `cwebp`, KHÔNG download ngoài):

- SVG nguồn 256×256/quân: đĩa radial `#FFFBEF→#F3E4C3`, vòng ngoài navy 1.5 (scale 3), vòng khắc trong 2 px màu phe (`--xq-red-deep` / `--xq-ink`), chữ Hán 62% đường kính cùng màu phe.
- Chữ: 帥仕相俥炮傌兵 (đỏ) / 將士象車砲馬卒 (đen). Render bằng font serif CJK hệ thống qua fontconfig; nếu máy build render lệch → fallback nhúng path glyph convert từ Noto Serif TC (OFL) bằng `text2path`, commit SVG đã outline.
- Output: `rsvg-convert -w 148` → `cwebp -q 82` → `game/xiangqi/assets/pieces/*.webp` (14 file, ~3–5 KB/file). Commit output như thirteen commit cards.

Acceptance: chữ sắc nét ở 37 px hiển thị, 2 phe phân biệt được khi mù màu đỏ-lục (khác nhau cả bằng chữ + độ đậm viền), nền trong suốt ngoài đĩa.

## 4. Manifest tổng

| ID | Loại | Nguồn | Dùng ở |
|---|---|---|---|
| `board-surface` | SVG code-native | component | S5, S6 |
| `pieces/*.webp` ×14 | raster script | §3 | S5, S6, S7, minh họa |
| `bg-lobby.webp` | raster sinh | prompt §6.1 | S1, S2 |
| `logo.webp` | raster sinh | prompt §6.2 | S1, S2 |
| `fx-result-win/lose/draw.webp` | raster sinh (tùy chọn — thử CSS trước) | prompt §6.3 | S7 |
| `ic-ken` | reuse caro | — | mọi badge KEN |
| `ic-lock, ic-refresh, ic-back, ic-sound-on/off, ic-chat, ic-reaction, ic-flag, ic-exit, ic-wifi-off, ic-crown` | SVG code-native 24 | vẽ tay theo 01 §3.3 | toàn app |
| `reactions/*` ×6 | reuse `../caro/assets/reactions/` | — | S6 |
| vip-icons | shared static copy | vite | pod, row |
| `app-icons/` | SVG nguồn + PNG 1024 | convention thirteen app-icons/README | admin upload icon `mini_games` |

Âm thanh: KHÔNG có file — WebAudio tổng hợp (01 §9).

## 5. Preload groups (assets.ts)

| Group | Nội dung | Khi nào |
|---|---|---|
| `LOBBY_CRITICAL` | bg-lobby, logo, ic-ken | trước first paint (progress %) |
| `RANKED` | icon list, khung row | `playRanked()` + hover CTA |
| `BOARD` | 14 pieces, fx | khi vào phòng chờ (bắt buộc xong trước MATCH_FOUND) |
| `RESULT` | fx-result | khi match bắt đầu (idle) |
| còn lại | history/leaderboard | idle batches 3 (pattern caro `preloadUrlsInIdleBatches`) |

## 6. Prompt sinh raster (khi cần)

Base: "flat illustration, warm wood and cream paper palette (#5C3E2A, #F3E4C3, #C0392B, #1F2A44, #F2B807), unified 2px navy outline, simple geometry, no text, no gradient noise, mobile game UI, clean edges". Negative chuẩn: "no photorealism, no 3d render, no neon, no watermark, no letters, no dragons".

### 6.1 bg-lobby
"Vietnamese xiangqi night porch scene, subtle wooden table texture bottom third, soft vignette, empty center for UI, muted warm brown" — 390×844 ×2, nén q 80, mục tiêu ≤ 90 KB.

### 6.2 logo
"Two round xiangqi pieces facing each other red and black, gold banner ribbon below, flat style" — chữ "CỜ TƯỚNG" là **live text** đặt đè, không nằm trong ảnh.

### 6.3 fx-result
Win: pháo giấy + ánh gold; Lose: quân đổ nghiêng tông mực; Draw: 2 quân cân trên bập bênh — mỗi ảnh 280×160 ×2.

## 7. Export & QA

- SVG: `svgo` preset default, giữ viewBox; kiểm render 1×/2×/3×.
- Raster: webp q 80–85, kiểm size budget bằng `ls -l` trước commit; ảnh > 100 KB phải qua optimize (tham chiếu `optimize_caro_assets.py`).
- QA từng asset: đúng palette 01, không dấu vết AI (chữ giả, chi tiết thừa), đọc được ở kích thước thật trên viewport 360.
