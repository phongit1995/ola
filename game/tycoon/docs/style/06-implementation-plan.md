# 06 — Kế hoạch triển khai UI style

Kế hoạch này chỉ cho phần UI/asset; server và protocol theo `../07-screen-to-feature-map.md` mục "Thứ tự triển khai". UI có thể bắt đầu song song với server nhờ harness fixture.

## Giai đoạn 0 — Concept (trước khi code UI)

Mục tiêu: có 5 ảnh concept để duyệt art direction, tránh code rồi mới đổi.

- [ ] Concept bàn chơi S6 ở 390 × 844: đủ 40 ô theo `02-board-tiles.md`, 4 bust ô góc, 4 pod, action bar pha `decide`.
- [ ] Concept lobby S2 với Bác Tỷ + logo.
- [ ] Concept sheet S7 ô đất nhóm Đỏ có 2 nhà.
- [ ] Concept thẻ Cơ hội O2 với Bác Tỷ `happy`.
- [ ] Concept kết quả S9 4 người.
- [ ] Bảng 6 nhân vật × 4 pose dạng sheet (chỉ để duyệt; asset production sinh riêng từng cái).

Lưu tại `../screenshots/concept-*.png` sau khi duyệt (ảnh concept được commit như thirteen; ảnh verify/nháp thì không). Duyệt xong mới sang giai đoạn 1.

## Giai đoạn 1 — Token và khung

- [ ] `game/tycoon/styles/tokens.css` từ `01-foundations.md` (copy nguyên, không đổi giá trị lẻ tẻ).
- [ ] `game/tycoon/styles/base.css`: gradient màn, type scale, class `.ty-btn*`, `.ty-chip*`, `.ty-icon-btn`, surface.
- [ ] `TyIcon` wrapper + union 30 tên; copy 22 svg từ xiangqi/thirteen; vẽ 8 icon mới theo `../06-icon-system.md` §2.3.
- [ ] Harness `tycoon/mock-ui.html?screen=` với fixture 4 người, pattern xiangqi.
- [ ] Màn lobby/ranked/pregame copy từ xiangqi, đổi token, thêm chọn số người.

DoD: screenshot 3 màn ở 360/390/520 không tràn; typecheck + lint xanh.

## Giai đoạn 2 — Bàn cờ tĩnh

- [ ] `BoardSurface` SVG: lưới 40 ô, công thức corner/edge, xoay khung + dải theo cạnh.
- [ ] 13 `tg-*` theo `../06-icon-system.md` §3, màu theo `04-icon-colors.md` §3.
- [ ] Nhà/khách sạn inline, chấm chủ, ô 10 chia chéo.
- [ ] Token DOM với ring 2 lớp; fallback `tk-seat-*` SVG trước, raster sau.
- [ ] Fixture: ván giữa chừng (4 người, 15 ô có chủ, 3 nhóm trọn, 1 khách sạn, 1 người trong tù, 1 phá sản).
- [ ] Visual check mù màu (simulate deuteranopia) — 8 dải vẫn phân biệt nhờ vị trí + tên trong sheet.

DoD: bàn render từ fixture khớp bảng `02-board-tiles.md`; ảnh chụp 390 đối chiếu concept.

## Giai đoạn 3 — Tương tác và replay (tier Lite trước)

- [ ] Sheet S7/S8, cụm lượt giữa bàn theo pha (02 §6.3), TurnClock, RoundChip, FooterBar + dòng sự kiện.
- [ ] `fx/tween.ts` + `fx/anchors.ts`; `replay.ts` gọi `effects/*` theo `../08-fx-and-animation.md` §4.
- [ ] Toàn bộ effect ở cột **Lite** (không hạt): roll, move hop, pay đếm + chip, card flip, build/sell, jail, bankrupt, turn, round, result.
- [ ] Tier `off` (reduced-motion) cho mọi effect.
- [ ] Âm thanh WebAudio theo `../08-fx-and-animation.md` §7.

DoD: fixture 40 step chạy tier lite/off đúng state cuối, không rò replayEpoch; `charsEnabled=false` vẫn đủ UI.

## Giai đoạn 3b — FX layer (tier Full)

- [ ] `fx/FxLayer.ts` Pixi: 1 app, canvas phủ bàn, pool 150, texture sinh bằng Graphics, ticker dừng khi rỗng.
- [ ] 6 kind hạt: coins, dust, confetti, spark, shard, trail.
- [ ] Nâng 22 effect L2 lên bản Full theo §3 của 08; vignette, rung bàn, idle thở, CTA shine.
- [ ] Tự hạ tier theo frame time (08 §5) + cài đặt Hiệu ứng trong lobby.
- [ ] `tycoon-shots.mjs --audit-motion`: p95 frame ≤ 24 ms ở Full trên máy tham chiếu.

DoD: cùng fixture 40 step chạy Full không lỗi JS, canvas rỗng sau 2 s cuối, không sprite rò sau 1000 emit.

## Giai đoạn 4 — Nhân vật và raster

- [ ] Sinh 6 nhân vật × 4 pose × 2 crop theo `03-characters.md` §5, log từng file.
- [ ] Sinh 8 quân, bg-lobby, logo theo `../04-asset-manifest-and-prompts.md`.
- [ ] Gắn nhân vật vào 16 vị trí trong `03-characters.md` §4; preload groups cập nhật.
- [ ] QA grayscale 6 nhân vật ở 30 px; budget ≤ 800 KB toàn bộ assets.
- [ ] App icon SVG + PNG 1024.

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
