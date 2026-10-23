# 06 — Kế hoạch triển khai UI style

Kế hoạch này chỉ cho phần UI/asset; server và protocol theo `../07-screen-to-feature-map.md` mục "Thứ tự triển khai". UI có thể bắt đầu song song với server nhờ harness fixture.

## Giai đoạn 0 — Concept (duyệt theo từng màn)

Mục tiêu: duyệt art direction bằng concept cho các màn có nhiều mỹ thuật riêng, tránh code rồi mới đổi. Không chặn cả dự án chờ đủ mọi concept.

- [x] Concept bàn chơi S6 (20/10/2026, pha `roll`): [`screens/s6-board/concept-s6-board-pixel-16bit.png`](../screens/s6-board/concept-s6-board-pixel-16bit.png) — ảnh mẫu chuẩn UI v3, pixel 16-bit.
- [x] Concept lobby S2 với Bác Tỷ + logo: người dùng chọn [phương án 1 — Nền trời thoáng](../screens/s2-lobby/concept-s2-lobby-pixel-16bit.png); đã có [style lobby](../screens/s2-lobby/README.md). Đây là duyệt concept, chưa phải hoàn tất code UI.
- [ ] Concept sheet S7 ô đất nhóm Đỏ có 2 nhà.
- [ ] Concept thẻ Cơ hội O2 với Bác Tỷ `happy`.
- [ ] Concept kết quả S9 4 người.
- [x] Concept S11 Bảng xếp hạng: [mẫu 02 — Mint tối giản](../screens/s11-leaderboard/README.md), người dùng chốt 23/10/2026; đủ 3 tab và hàng ghim, đã dựng UI với dữ liệu giả.
- [ ] Bảng 6 nhân vật × 4 pose dạng sheet (chỉ để duyệt; asset production sinh riêng từng cái).

Lưu tại `screens/s{n}-{tên}/concept-s{n}-{tên}-{style}.png` (cùng folder với style của màn, xem [screens](../screens/README.md)) sau khi duyệt (ảnh concept được commit như thirteen; ảnh verify/nháp thì không).

**Điều kiện bắt đầu dựng — duyệt theo từng màn:**
- Màn có trong danh sách trên (S2, S6, S7, O2, S9, S11) chỉ dựng UI sau khi concept **của chính màn đó** được duyệt và có folder trong [screens](../screens/README.md).
- Màn không có trong danh sách (S1, S3–S5, S8, S10, O1, O3–O7) dựng theo [02-screen-specs](../02-screen-specs.md) + style chung, duyệt bằng ảnh chụp thật ở bước DoD; nếu sau này quyết định vẽ concept cho màn nào thì thêm vào danh sách trên và màn đó chờ concept.
- Giai đoạn 1 (token, khung) bắt đầu được ngay vì S6 — nền mỹ thuật chung — đã duyệt; không cần chờ đủ mọi concept.

## Giai đoạn 1 — Token và khung

- [ ] `game/tycoon/styles/tokens.css` từ `01-foundations.md` (copy nguyên, không đổi giá trị lẻ tẻ).
- [ ] `game/tycoon/styles/base.css`: gradient màn, type scale, class `.ty-btn*`, `.ty-chip*`, `.ty-icon-btn`, surface.
- [ ] `TyIcon` wrapper + union 30 tên; copy 22 svg từ xiangqi/thirteen; vẽ 8 icon mới theo `../06-icon-system.md` §2.3.
- [ ] Harness `tycoon/mock-ui.html?screen=` với fixture 4 người, pattern xiangqi.
- [ ] Màn lobby/ranked/pregame copy từ xiangqi, đổi token, thêm chọn số người.
- [ ] Dựng riêng S2 theo [style S2 lobby](../screens/s2-lobby/README.md), gồm hero, 5 minh họa của nút (xuất từ PNG gốc sang WebP/SVG) và các ca responsive/loading/offline; giữ các checklist triển khai chưa xong cho đến khi có UI được kiểm chứng.

DoD: screenshot 3 màn ở 360/390/520 không tràn; typecheck + lint xanh.

## Giai đoạn 2 — Bàn cờ tĩnh

- [ ] `BoardSurface` SVG: lưới 32 ô, công thức corner `.136` / edge chia 7 (`01-foundations.md` §3), xoay khung + dải theo cạnh.
- [ ] `tg-*` theo `../06-icon-system.md` §3, màu theo `04-icon-colors.md` §3.
- [ ] 19 tranh pixel `tiles/art/*` (16 thành phố + sân bay + Nhà tù + Lễ hội) và nền `bg-board-pixel` theo `../04-asset-manifest-and-prompts.md` §6.5; tạm dùng ô trống khi chưa có tranh.
- [ ] Cấp nhà inline trên dải (1–2 nhà, khách sạn, viền cream), vạch chủ mép ngoài, ô 8 Nhà tù.
- [ ] Quân `tk-pawn.svg` (con tốt) tô màu ghế, DOM tuyệt đối, đế trên mép trong ô (`../03-component-specs.md` §3).
- [ ] Fixture: ván giữa chừng (4 người, 15 ô có chủ, 3 nhóm trọn, 1 ô cấp 3, 1 người trong tù, 1 phá sản).
- [ ] Visual check mù màu (simulate deuteranopia) — 8 dải vẫn phân biệt nhờ vị trí + tên trong sheet.

DoD: bàn render từ fixture khớp bảng `02-board-tiles.md`; ảnh chụp 390 đối chiếu [ảnh mẫu](../screens/s6-board/concept-s6-board-pixel-16bit.png) (trừ 3 chỗ docs giữ, `README.md`).

## Giai đoạn 3 — Tương tác và replay (tier Lite trước)

- [ ] Sheet S7/S8, cụm lượt giữa bàn đủ 9 pha (02 §6.3, gồm `takeover`/`festival`/`travel`), TurnClock, RoundChip, FooterBar + dòng sự kiện.
- [ ] `fx/tween.ts` + `fx/anchors.ts`; `replay.ts` gọi `effects/*` theo `../08-fx-and-animation.md` §4.
- [ ] Toàn bộ effect ở cột **Lite** (không hạt): roll, move hop, pay đếm + chip, card flip, build/sell, jail, bankrupt, turn, round, result.
- [ ] Tier `off` (reduced-motion) cho mọi effect.
- [ ] Âm thanh WebAudio theo `../08-fx-and-animation.md` §7.

DoD: fixture 40 step chạy tier lite/off đúng state cuối, không rò replayEpoch; `charsEnabled=false` vẫn đủ UI.

## Giai đoạn 3b — FX layer (tier Full)

- [ ] `fx/FxLayer.ts` Pixi: 1 app, canvas phủ bàn, pool 150, texture sinh bằng Graphics, ticker dừng khi rỗng.
- [ ] 6 kind hạt: coins, dust, confetti, spark, shard, trail.
- [ ] Nâng 22 effect L2 lên bản Full theo §3 của 08; vignette, rung bàn, idle thở, CTA shine.
- [ ] Tự hạ tier theo frame time (08 §5) + cài đặt Hiệu ứng trong menu tùy chọn S6; giữ topbar S2 đúng mẫu đã chọn.
- [ ] `tycoon-shots.mjs --audit-motion`: p95 frame ≤ 24 ms ở Full trên máy tham chiếu.

DoD: cùng fixture 40 step chạy Full không lỗi JS, canvas rỗng sau 2 s cuối, không sprite rò sau 1000 emit.

## Giai đoạn 4 — Nhân vật và raster

- [ ] Sinh 6 nhân vật × 4 pose × 2 crop theo `03-characters.md` §5, log từng file.
- [ ] Logo theo `../04-asset-manifest-and-prompts.md` §6.2. Nền sảnh dùng chung `bg-board-pixel` (không có `bg-lobby`). 8 quân raster để v2.
- [ ] Gắn nhân vật vào các vị trí trong `03-characters.md` §4 (UI v3 không có bust trên ô góc); preload groups cập nhật.
- [ ] QA grayscale 6 nhân vật ở 30 px; budget ≤ 800 KB toàn bộ assets.
- [x] App icon PNG 1024 (`app-icon.png` chính, `app-icon-sub.png` phụ).

DoD: mọi vị trí nhân vật có fallback; tắt nhân vật không đổi layout (chừa chỗ cố định).

## Giai đoạn 5 — Kết nối server và QA

- [ ] Wire SDK thật, E2E browser + 3 bot (pattern thirteen-e2e-browser).
- [ ] `scripts/tycoon-shots.mjs` chụp toàn bộ màn/state; baseline visual regression.
- [ ] Checklist icon `../06-icon-system.md` §8 cho 8 icon mới + 13 glyph.
- [ ] Accessibility: focus order S6, aria-live thẻ/announce, contrast AA toàn bộ chữ (kiểm bằng tool, không ước lượng).
- [ ] Review bởi người không làm game: hiểu được pha hiện tại trong 3 giây nhìn cụm lượt giữa bàn.

## Definition of Done toàn bộ UI

1. Mọi màn/overlay trong `../02-screen-specs.md` có screenshot baseline ở 390 và 360.
2. Không giá trị màu/size nào nằm ngoài token (grep hex trong `tycoon/` chỉ được thấy trong `tokens.css` và SVG asset).
3. Không emoji, không `<text>` trong SVG, không chữ trong raster.
4. `charsEnabled` on/off đều qua E2E.
5. Docs trong thư mục này được cập nhật khi code lệch; không có "sẽ sửa docs sau".

## Rủi ro và cách xử lý

| Rủi ro | Xử lý |
|---|---|
| Ô cạnh 30 px quá nhỏ trên máy 360 | đã bỏ chữ khỏi ô; nếu vẫn khó đọc dải → tăng dải lên 18 px và giảm thân ô (quân 16 px) |
| Nhân vật sinh ra không đồng bộ phong cách | sinh theo 1 prompt base chung, duyệt pose `idle` của cả 6 trước rồi mới sinh pose còn lại |
| Gold ghế 0 nhầm với CTA | pod luôn có avatar+tên; CTA không bao giờ nằm trong pod row |
| Budget asset vượt 800 KB | bỏ bust pose `sad` của ty/ngan, bỏ fx-result, giảm quân xuống 4 |
| Máy yếu lag khi 4 quân animate + hạt | hop dùng `transform` + `will-change`, không reflow; tier tự hạ Lite theo frame time, `off` khi reduced-motion (08 §5–6) |
| Hiệu ứng nhiều làm ván chậm | ngân sách thời gian từng đoạn (08 §2), replay không chặn tap bàn/sheet, chỉ chặn nút cụm lượt |
| Nhìn như "casino" khi thêm hạt (rủi ro Apple 4.1) | hạt chỉ gold/màu ghế/paper, không neon/đèn nhấp nháy/ký hiệu tiền; không flash trắng |
