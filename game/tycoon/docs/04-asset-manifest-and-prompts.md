# 04 — Asset manifest and generation

## 1. Chiến lược asset

Thứ tự ưu tiên (kế thừa policy thirteen/xiangqi):

1. **CSS token / component thuần CSS** — nút, panel, chip, input, toast, sheet, pod, nhà/khách sạn trên bàn.
2. **SVG code-native trong repo** — bàn cờ (BoardSurface), 30 `ic-*`, 13 `tg-*`, 6 mặt xúc xắc, app icon nguồn.
3. **Raster tái dùng** — reaction (`../caro/assets/reactions/*.webp`), VIP icons (shared), `ola_smiley_online.png`.
4. **Raster sinh mới** — CHỈ: 8 quân cờ, 48 file nhân vật (6 × 4 pose × 2 crop, [style/03-characters.md](./style/03-characters.md)), nền lobby, logo, minh họa result (tùy chọn). Mỗi asset sinh có dòng log theo [asset-generation-log.template.md](./asset-generation-log.template.md).

Budget: initial load (lobby critical, gồm `ty-idle-full`) ≤ 180 KB gzip; toàn bộ assets tycoon ≤ 800 KB (nhân vật ≈ 260 KB; cắt giảm theo `style/06-implementation-plan.md` nếu vượt). Thêm `/game/tycoon/assets/` vào `assetsInlineLimit` của `game/vite.config.ts` cùng dòng với thirteen/xiangqi, và entry `tycoon: resolve(__dirname, 'tycoon/index.html')`.

## 2. Quy tắc đặt tên

- `ic-{tên}.svg` icon điều khiển; `tg-{tên}.svg` glyph ô; `tk-{tên}.webp` quân; `d{1..6}.svg` xúc xắc; `bg-{màn}.webp` nền; `fx-{tên}.webp` hiệu ứng.
- Kebab-case tiếng Anh cho ic/tg, tiếng Việt không dấu cho quân (`tk-non-la`) vì quân là nội dung văn hóa, tên hiển thị live text `Nón lá`.
- Không viết hoa, không space; webp cho raster, svg cho vector.

## 3. Quân cờ — sinh và hậu kỳ

8 quân theo 06 §4. Sinh bằng công cụ ảnh với prompt §6.3, mỗi quân 1 lần sinh riêng, nền trong suốt thật (không xóa nền bằng màu).

Hậu kỳ (script `game/scripts/optimize_tycoon_tokens.sh`, pattern `optimize_caro_assets.py`):
- trim alpha, pad về vuông, scale `96 × 96`, `cwebp -q 85 -alpha_q 100`.
- Kiểm tra silhouette ở 18 px: xếp 8 quân cạnh nhau trên `--ty-paper`, không màu ghế, phải phân biệt được.
- Mục tiêu ≤ 6 KB/quân.

Fallback v1 nếu raster chưa đạt: `tokens/fallback/tk-seat-{0..3}.svg` hình học (circle, triangle, square, diamond) fill màu ghế — commit sẵn để không chặn phát hành.

## 4. Manifest tổng

| ID | Loại | Số lượng | Nguồn | Dùng ở |
|---|---|---|---|---|
| `board-surface` | SVG code-native | 1 | component | S5, S6 |
| `tg-*` | SVG code-native 32 | 13 | vẽ tay theo 06 §3 | bàn, O2, S7 |
| `tg-house`/`tg-hotel` | inline SVG | 2 | BoardSurface | bàn |
| `ic-*` | SVG code-native 24 | 30 (22 copy từ xiangqi/thirteen + 8 mới) | 06 §2 | toàn app |
| `d1..d6` | SVG 44 | 6 | 06 §5 | O1 |
| `tk-*` | raster webp 96 | 8 (v1 dùng 4) | §3 | bàn, pod, S9 |
| `tk-seat-*` fallback | SVG | 4 | §3 | dự phòng |
| `chars/{char}-{pose}-{crop}.webp` | raster sinh 256/128 | 48 | style/03 §5 | ô góc, sheet, thẻ, modal, lobby, S9 |
| `bg-lobby.webp` | raster sinh | 1 | §6.1 | S1, S2 |
| `logo.webp` | raster sinh | 1 | §6.2 | S1, S2, watermark bàn |
| `fx-result-1/2/3/4.webp` | raster sinh (tùy chọn — thử CSS trước) | 4 | §6.4 | S9 |
| `reactions/*` | reuse caro | 6 | — | S6 |
| vip-icons | shared static copy | — | vite | pod, row |
| `app-icons/` | SVG nguồn + PNG 1024 | 1 | 06 §6 | admin upload `mini_games` |
| dữ liệu bàn/thẻ | `board.gen.json`, `cards.gen.json` | 2 | codegen Go (05) | S7, O2, S8 |

Âm thanh: KHÔNG có file — WebAudio tổng hợp (01 §9).

## 5. Preload groups (assets.ts)

| Group | Nội dung | Khi nào |
|---|---|---|
| `LOBBY_CRITICAL` | bg-lobby, logo, ic-ken, `ty-idle-full` | trước first paint (progress %) |
| `RANKED` | icon list | `openRanked()` |
| `BOARD` | 13 tg, 6 dice, 4 (hoặc 8) tk, 4 bust idle ô góc, board.gen.json, cards.gen.json | khi vào phòng chờ (bắt buộc xong trước MATCH_FOUND) |
| `CHARS` | 44 file nhân vật còn lại | sau MATCH_FOUND, idle batches; thiếu thì fallback glyph |
| `RESULT` | fx-result nếu có, `ty-happy-full`, `loc-sad-full` | khi match bắt đầu (idle) |
| còn lại | history/leaderboard | idle batches (pattern caro `preloadUrlsInIdleBatches`) |

## 6. Prompt sinh raster

Base: "flat vector illustration, warm cream paper and bright city palette (#FBF3E0, #1F2A44, #F2B807, #1F8A5B, #E4573D, #7EC8E3), unified 2px navy outline, simple geometry, no text, no gradient noise, mobile board game UI, clean edges, transparent background". Negative chuẩn: "no photorealism, no 3d render, no neon, no watermark, no letters, no currency symbols, no real landmarks, no dragons".

### 6.1 bg-lobby
"Stylized Vietnamese city skyline at morning, flat shapes, rooftops and a few trees along the bottom third, soft vignette, empty center for UI, muted navy-blue sky" — 390 × 844 × 2, q 80, ≤ 90 KB. Không có địa danh nhận diện được.

### 6.2 logo
"Three board-game tiles in a corner arrangement with one red and one green color band, a tilted white die showing five, a small conical hat token, flat style" — chữ "CỜ TỶ PHÚ" là **live text** đặt đè, không nằm trong ảnh. Cũng dùng làm watermark 12% giữa bàn.

### 6.3 Quân cờ (mỗi quân 1 prompt, 1024 × 1024)
Base + "ONE standalone game token, centered, filling 85–90% of canvas, side view, 2–3 flat colors with a single soft highlight, thick navy contour, genuinely transparent alpha outside the shape, no base/stand, no shadow" + mô tả:
- `tk-xe-may`: "a small scooter seen from the side, coral body, cream seat"
- `tk-non-la`: "a Vietnamese conical palm-leaf hat seen from a slight angle, golden straw with thin ring lines"
- `tk-xich-lo`: "a cyclo pedicab seen from the side, sky-blue hood, two large wheels"
- `tk-thuyen`: "a small wooden sailboat with one jade sail"
- `tk-banh-mi`: "a baguette sandwich with a few herbs peeking out, golden crust"
- `tk-ca-phe`: "a drip coffee filter on top of a glass, navy filter, cream glass"
- `tk-den-long`: "a round silk lantern with a small tassel, coral"
- `tk-trau`: "a water buffalo head facing forward with wide curved horns, warm brown"

### 6.4 fx-result (tùy chọn)
Hạng 1: pháo giấy + xu gold; hạng 2–3: huy hiệu; phá sản: ví rỗng lật ngược — mỗi ảnh 280 × 160 × 2. Thử CSS/SVG trước; chỉ sinh nếu thiếu cảm xúc.

## 7. Export & QA

- SVG: `svgo` preset default, giữ viewBox; kiểm render 1×/2×/3×.
- Raster: webp q 80–85, kiểm size budget bằng `ls -l` trước commit; ảnh > 100 KB phải qua optimize.
- QA từng asset: đúng palette 01, không dấu vết AI (chữ giả, chi tiết thừa), đọc được ở kích thước thật trên viewport 360, 8 quân phân biệt được khi xếp cạnh nhau ở 18 px.
- Không commit ảnh nháp hay screenshot verify (quy ước repo).
