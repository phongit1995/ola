# 04 — Asset manifest and generation

## 1. Chiến lược asset

Thứ tự ưu tiên (kế thừa policy thirteen/xiangqi):

1. **CSS token / component thuần CSS** — nút, panel, chip, input, toast, sheet, pod, nhà/khách sạn trên bàn.
2. **SVG code-native trong repo** — bàn cờ (BoardSurface), 33 `ic-*` (gồm cặp mắt mật khẩu S4), 13 `tg-*`, 6 mặt xúc xắc. S2 đã có 2 nhóm tia `lobby/decor-*` theo [style S2 lobby](./screens/s2-lobby/README.md); các minh họa `lobby/ill-*` hiện có bản WebP từ PNG concept, có thể vẽ lại vector khi sửa QA.
3. **Raster tái dùng** — reaction (`../caro/assets/reactions/*.webp`), VIP icons (shared), `ola_smiley_online.png`.
4. **Raster sinh mới** — CHỈ: 19 tranh pixel ô (16 thành phố + sân bay + Nhà tù + Lễ hội) và nền trời pixel `bg-board-pixel` theo ảnh mẫu UI v3, 8 quân cờ (v2), 48 file nhân vật (6 × 4 pose × 2 crop, [style/03-characters.md](./style/03-characters.md)), logo, minh họa result (tùy chọn). Lobby dùng chung nền trời, không sinh nền riêng. Mỗi asset sinh có dòng log theo [asset-generation-log.template.md](./asset-generation-log.template.md).

Ngoại lệ riêng S2 theo concept đã duyệt: hiện có raster `hero-properties` (3 thẻ + 2 quân), 5 minh họa action và xu KEN tách từ concept. Không tự thay bằng hình có dáng khác để khớp danh sách loại asset chung. Review chi tiết tại [S2 asset audit](./screens/s2-lobby/asset-audit.md); WebP hiện có vẫn chưa đạt visual QA.

Ngoại lệ S3/S4 theo yêu cầu xuất icon ngày 22/10: [bộ `room-list/`](../assets/room-list/README.md) gồm 2 WebP (khóa vàng, dấu cộng cam) và 9 SVG riêng (reload, khóa đặc, cảnh báo, chevron active/disabled, hai nét X). PNG nguồn ở [screens/room-list](../assets/screens/room-list/README.md). Render bằng `RoomIcon`/`img` để giữ màu nhiều lớp; mắt mật khẩu dùng `ic-eye` / `ic-eye-off` qua TyIcon. Đã xuất để review, còn sai lệch nhỏ so với ảnh mẫu và chưa lắp online; xem [audit](./screens/s3-room-list/icon-export-audit.md).

Ngoại lệ Hướng dẫn chơi S2 đã chốt ngày 23/10: 18 minh họa `rules/ill-*.webp` (khoảng 72 KB) xuất từ 18 PNG nguồn trong suốt tách từ [4 tab](./screens/s2-lobby/README.md#12-hướng-dẫn-chơi--đã-chốt-4-tab); prompt, hash, thông số xuất và khác biệt tái dựng trong [manifest](../assets/screens/rules-guide/manifest.json). Tái dùng sách/X; khung, tab, card và nền pastel dựng CSS.

Ngoại lệ S11 đã chốt mẫu 02 Mint tối giản ngày 23/10: [3 huy chương WebP mặt trống](../assets/leaderboard/README.md), tổng 11.880 byte; số 1/2/3 ghép DOM. [PNG nguồn và manifest](../assets/screens/leaderboard/manifest.json) giữ prompt, hash và thông số xuất. Tái dùng icon header/quay lại/nền/avatar; các surface là CSS theo [docs màn](./screens/s11-leaderboard/README.md). Đã đối chiếu asset ở cỡ thật, có sai lệch tái dựng được ghi rõ; chưa dựng S11 runtime.

Ngoại lệ S1: xúc xắc bo góc là mesh/shader WebGL theo [style đã duyệt](./screens/s1-loading/README.md), không sinh sprite mới. `lobby/loading-ring-enamel.svg` là **Cung men nổi đã chốt**, xuất trực tiếp từ mẫu được chọn; quay luân phiên với mỗi lần lật 90° của xúc xắc, không có đĩa kem phía sau. Nền/logo/Bác Tỷ và fallback `lobby/ill-dice.webp` dùng lại asset hiện có. Các mẫu viền khác và trang so sánh đã được dọn khỏi source.

Budget: initial load (lobby critical, gồm `ty-idle-full`) ≤ 180 KB gzip; toàn bộ assets tycoon ≤ 800 KB (nhân vật ≈ 260 KB; cắt giảm theo `style/06-implementation-plan.md` nếu vượt). Thêm `/game/tycoon/assets/` vào `assetsInlineLimit` của `game/vite.config.ts` cùng dòng với thirteen/xiangqi, và entry `tycoon: resolve(__dirname, 'tycoon/index.html')`.

## 2. Quy tắc đặt tên

- `ic-{tên}.svg` icon điều khiển; `tg-{tên}.svg` glyph ô; `tk-{tên}.webp` quân; `d{1..6}.svg` xúc xắc; `bg-{màn}.webp` nền; `fx-{tên}.webp` hiệu ứng.
- Kebab-case tiếng Anh cho ic/tg, tiếng Việt không dấu cho quân (`tk-non-la`) vì quân là nội dung văn hóa, tên hiển thị live text `Nón lá`.
- Không viết hoa, không space; webp cho raster runtime, svg cho vector.
- **PNG gốc theo màn:** asset cắt từ concept lưu tạm dạng PNG tại `assets/screens/<màn>/` (tên theo vai trò: `logo.png`, `icon-history.png`…) + `manifest.json`. Khi code màn đó mới xuất sang tên runtime ở trên (bảng đối chiếu trong README của màn, ví dụ [S2 §10](./screens/s2-lobby/README.md#10-asset-cắt-từ-concept--file-production)). Quy trình: [screens](./screens/README.md#quy-trình-asset-theo-màn).
- `lobby/ill-{dice|bot|history|leaderboard|rules|exit}.webp` (hoặc `.svg` nếu vẽ lại vector): 6 minh họa trang trí nút S2, không chữ; tách khỏi `ic-*` điều khiển chung. Nguồn là PNG `icon-*.png` trong `assets/screens/lobby/`; đã có file runtime, còn lỗi visual QA. Đồng KEN (pill số dư S2, cột KEN và ô cược S3/S4) dùng `lobby/ken.png`, chép nguyên đồng chữ K của app (`web/src/assets/icons/apps/ken.png`, cùng file game sút pen, đập trứng và Tiến Lên) từ 22/10/2026; `lobby/ill-ken.webp` (đồng vương miện cắt từ concept) không còn dùng ở runtime.
- `lobby/decor-cta-rays.svg`, `lobby/decor-hero-rays.svg`: 2 nhóm decor SVG code-native **đã tạo** (chưa qua visual QA). Tia vàng nằm ngoài CTA và tia trắng nằm cạnh quân trong hero; SVG code-native theo concept, không phải PNG đã có sẵn.

## 3. Quân cờ — sinh và hậu kỳ

8 quân theo 06 §4. Sinh bằng công cụ ảnh với prompt §6.3, mỗi quân 1 lần sinh riêng, nền trong suốt thật (không xóa nền bằng màu).

Hậu kỳ (script `game/scripts/optimize_tycoon_tokens.sh`, pattern `optimize_caro_assets.py`):
- trim alpha, pad về vuông, scale `96 × 96`, `cwebp -q 85 -alpha_q 100`.
- Kiểm tra silhouette ở 18 px: xếp 8 quân cạnh nhau trên `--ty-paper`, không màu ghế, phải phân biệt được.
- Mục tiêu ≤ 6 KB/quân.

UI v3 dùng `tk-pawn.svg` (con tốt tô màu ghế) cho mọi người chơi, nên không cần fallback hình học `tk-seat-*`. Pipeline trên chỉ áp dụng khi làm 8 quân raster cho v2.

## 4. Manifest tổng

**Asset tách S2 hiện có:** [13 PNG trong `assets/screens/lobby/`](../assets/screens/lobby/README.md) (8 bản v2 đã chọn sau khi so với concept + 5 giữ v1), metadata/hash tại [manifest.json](../assets/screens/lobby/manifest.json). PNG không import trực tiếp; 10 WebP đã xuất và dùng trong Lobby mock, tổng 182.326 byte (~178 KiB). Con số này chỉ là WebP, chưa chứng minh budget toàn bộ initial load. Bộ ảnh vẫn `trial-not-production`; xem [audit 13 ảnh và các lớp thiếu](./screens/s2-lobby/asset-audit.md).

| ID | Loại | Số lượng | Nguồn | Dùng ở |
|---|---|---|---|---|
| `board-surface` | SVG code-native | 1 | component | S5, S6 |
| `tg-*` | SVG code-native 32 | 13 | vẽ tay theo 06 §3 | bàn, O2, S7 |
| `tg-house`/`tg-hotel` | inline SVG | 2 | BoardSurface | bàn |
| `ic-*` | SVG code-native 24 | 30 (22 copy từ xiangqi/thirteen + 8 mới) | 06 §2 | toàn app |
| `lobby/ill-*` | WebP đã có, SVG nếu vẽ lại | 7 | screens/s2-lobby §6, §10 | 6 minh họa action + xu KEN S2; chưa đạt visual QA |
| `lobby/hero-properties.webp` | WebP đã có | 1 | PNG tách từ concept S2 | 3 thẻ + 2 quân, chung một lớp trang trí |
| `lobby/decor-*` | SVG code-native, **đã tạo** | 2 | concept S2, asset-audit §2 | 4 tia vàng quanh CTA; 2 cụm tia trắng quanh hero (3 + 3 tia) |
| `lobby/loading-ring-enamel.svg` | SVG code-native trong suốt | 1 | Cung men nổi đã chọn; screens/s1-loading | bốn cung xanh–vàng, quay luân phiên với mỗi lần xúc xắc lật một mặt |
| `rules/ill-*.webp` | WebP alpha, 96 px (3 hình điều kiện thắng 128 px) | 18 | PNG `screens/rules-guide/icon-*`, 4 concept Hướng dẫn chơi đã chốt | minh họa card RulesModal, ô 54 / hàng thắng 64 × 40 |
| `room-list/*` | 2 WebP lossless + 9 SVG riêng | 11 | 2 PNG imagegen và hình học theo S3/S4 | danh sách bàn/modal; đã xuất để review, chưa lắp online |
| `leaderboard/medal-*` | WebP alpha, mặt trống | 3 | PNG tách từ S11 mẫu 02 đã chốt | hạng 1–3, số DOM; 11.880 byte, dùng trong LeaderboardScreen |
| `roundedDieRenderer` | WebGL mesh/shader, không có texture mới | 1 | components/loading, screens/s1-loading | xúc xắc bo góc 1–6 của S1; fallback tái dùng `lobby/ill-dice.webp` |
| `d1..d6` | SVG 44 | 6 | 06 §5 | O1 |
| `tiles/art/{slug}.webp` | raster pixel 16-bit, gốc 64 × 40, export ×3 nearest-neighbor | 19 | §6.5 | ô bàn, header sheet S7; S2 hiện dùng tranh trong hero từ concept |
| `bg-board-pixel.webp` | raster pixel 16-bit | 1 | §6.5 | nền màn S1–S6 |
| `tk-pawn.svg` | SVG code-native | 1 | 06 §4 | quân trên bàn (UI v3); hero S2 hiện dùng artwork chung với thẻ |
| `tk-*` | raster webp 96 | 8 (v2) | §3 | chọn quân v2 |
| `chars/{char}-{pose}-{crop}.webp` | raster sinh 256/128 | 48 | style/03 §5 | ô góc, sheet, thẻ, modal, lobby, S9 |
| `logo.webp` | raster sinh | 1 | §6.2 | S1, S2, header S6 |
| `fx-result-1/2/3/4.webp` | raster sinh (tùy chọn — thử CSS trước) | 4 | §6.4 | S9 |
| `reactions/*` | reuse caro | 6 | — | S6 |
| vip-icons | shared static copy | — | vite | mọi avatar người chơi + icon 14 px trước `@username` (03 §18) |
| `app-icons/app-icon{,-sub}.png` | raster sinh, PNG 1024 bo góc, **đã tạo** | 2 | 06 §6 | admin upload `mini_games`; `app-icon.png` là icon chính |
| dữ liệu bàn/thẻ | `board.gen.json`, `cards.gen.json` | 2 | codegen Go (05) | S7, O2, S8 |

Âm thanh: KHÔNG có file — WebAudio tổng hợp (01 §9).

## 5. Preload groups (assets.ts)

| Group | Nội dung | Khi nào |
|---|---|---|
| `LOBBY_CRITICAL` | bg-board-pixel, logo, `ty-idle-full`, `hero-properties`, 7 `lobby/ill-*`, cặp icon âm thanh, 2 SVG `lobby/decor-*` và `lobby/loading-ring-enamel.svg` | kế hoạch preload trước first paint; vẫn giữ tổng ≤ 180 KB gzip, chưa xác nhận đạt |
| `RANKED` | icon list | `openRanked()` |
| `BOARD` | 13 tg, 6 dice, `tk-pawn`, 19 tranh `tiles/art`, `bg-board-pixel`, board.gen.json, cards.gen.json | khi vào phòng chờ (bắt buộc xong trước MATCH_FOUND) |
| `CHARS` | 44 file nhân vật còn lại | sau MATCH_FOUND, idle batches; thiếu thì fallback glyph |
| `RESULT` | fx-result nếu có, `ty-happy-full`, `loc-sad-full` | khi match bắt đầu (idle) |
| còn lại | history/leaderboard | idle batches (pattern caro `preloadUrlsInIdleBatches`) |

## 6. Prompt sinh raster

Base: "flat vector illustration, warm cream paper and bright city palette (#FBF3E0, #1F2A44, #F2B807, #1F8A5B, #E4573D, #7EC8E3), unified 2px navy outline, simple geometry, no text, no gradient noise, mobile board game UI, clean edges, transparent background". Negative chuẩn: "no photorealism, no 3d render, no neon, no watermark, no letters, no currency symbols, no real landmarks, no dragons".

### 6.1 bg-lobby
UI v3: bỏ nền lobby riêng, S1/S2 dùng chung `bg-board-pixel` (§6.5) để cả game một nền trời pixel.

### 6.2 logo
Theo ảnh mẫu: chữ `CỜ TỶ PHÚ` vàng nổi khối viền navy dày, vương miện nhỏ trên chữ "C", một viên xúc xắc ở cuối. Logo là ngoại lệ duy nhất có chữ trong ảnh; kèm `aria-label`. Không dùng làm watermark giữa bàn.

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

### 6.5 Tranh pixel 16-bit (UI v3)

Nguồn phong cách: [ảnh mẫu](./screens/s6-board/concept-s6-board-pixel-16bit.png). Không dùng base flat-vector ở trên; prompt riêng:

Base: "16-bit pixel art, SNES era, limited palette, crisp hard pixel edges, no anti-aliasing, no dithering noise, bright daytime sky, side view landscape, no text, no letters, no logos". Negative: "no smooth vector, no photorealism, no 3d render, no blur, no watermark".

- `tiles/art/{slug}`: một cảnh tiêu biểu mỗi thành phố, khung 64 × 40, trời ở 1/3 trên, đường chân trời cùng độ cao ở cả 16 tranh. Sân bay: máy bay + tháp chỉ huy. Nhà tù: phòng giam song sắt có Anh Tèo (03-characters). Lễ hội: đèn lồng đỏ + ngôi sao vàng trên nền đêm `#0B1F66`.
- `bg-board-pixel`: trời `#35C1FC → #7FE3F7`, mây pixel trắng ở trên, cây và mái nhà pixel ở dải dưới và hai bên, giữa để trống cho bàn; 390 × 844 ×2.
- Hậu kỳ: vẽ lại/dọn từng pixel trên lưới gốc (ảnh AI chỉ làm phác), giảm về bảng màu chung, export ×3 nearest-neighbor, webp lossless; mục tiêu ≤ 5 KB/tranh, nền ≤ 90 KB.

## 7. Export & QA

Các budget/runtime export dưới đây áp dụng cho asset production. [PNG concept S2 đã chọn](./screens/s2-lobby/concept-s2-lobby-pixel-16bit.png) giữ nguyên trong docs để đối chiếu, không tải trong game; [log nguồn](./asset-generation-log.md) ghi kích thước/hash. Concept được duyệt là tài liệu, không phải ảnh nháp hoặc screenshot verify.

- SVG: `svgo` preset default, giữ viewBox; kiểm render 1×/2×/3×.
- Raster runtime: webp q 80–85, kiểm size budget bằng `ls -l` trước commit; ảnh > 100 KB phải qua optimize. PNG gốc trong `assets/screens/<màn>/` chưa import nên chưa áp budget; tối ưu khi xuất lúc code.
- QA từng asset: đúng palette 01, không dấu vết AI (chữ giả, chi tiết thừa), đọc được ở kích thước thật trên viewport 360, 8 quân phân biệt được khi xếp cạnh nhau ở 18 px.
- Không commit ảnh nháp hay screenshot verify (quy ước repo).
