# Prompt set — lobby asset extraction trial

Tool: built-in `image_gen`, edit mode. Input image 1 for the initial extraction calls: [the selected S2 concept](../../../docs/style/screens/s2-lobby/concept-s2-lobby-pixel-16bit.png); the original preview/ZIP includes a copy as `reference.png`. `transparent_background=true` for every cutout/button, `false` for background. These are extraction/reconstruction trials, not exact pixel-preserving crops. Selected files now live in `game/tycoon/assets/screens/lobby/`; the selected `logo-clean.png` was renamed to `logo.png` without changing its pixels.

## Logo — initial

```text
Use case: background-extraction. Input image 1 is the EDIT TARGET, a flattened mobile game lobby. Extract ONLY the large gold/navy title logo "CỜ TỶ PHÚ" near the top, including its small crown and its white die at the right. Preserve the exact Vietnamese lettering, accent marks, navy contour, cream-to-gold letter faces, orange bottom edge, proportions, and character spacing from the source. Remove all cyan sky, clouds, interface, mascot, profile bar, and other objects. Output this ONE isolated logo on a genuinely transparent alpha background, tightly framed with small even transparent padding, wide horizontal composition approximately 3.3:1, high resolution. No redesign, no replacement lettering, no extra text, no watermark, no floor or checkerboard painted into the image. This is a cutout for reassembly, not a new logo concept.
```

Selected logo: second edit of this result using `logo-clean-prompt.txt`, source `exec-1c83e361-fa63-4da0-a89e-52573cd53c6a.png`, selected output `exec-0fe9a8ab-75cc-4246-85a0-d2608c4415e4.png`.

## Mascot

```text
Use case: background-extraction. Input image 1 is the EDIT TARGET. Extract ONLY the full-body round Vietnamese uncle mascot below the logo on the LEFT. Preserve his exact face, black wavy hair, round black-rimmed spectacles, expression, body proportions, gold shirt, dark navy trousers, sandals, hands and opened cream paper fan. Preserve original pose and illustration shading. Include every visible part from the top of his hair to the soles of his sandals and fan tips. Remove ALL sky, clouds, blue elliptical ground shadow, cards, pawns, logo, buttons and interface. Do not include any nearby gold/blue pawn. Output ONE full-body mascot on genuinely transparent alpha, tightly framed with a little padding, portrait composition. Do not redesign or add props. No ground, shadow, captions, text or watermark.
```

## Property / pawn vignette

```text
Use case: background-extraction. Input image 1 is the EDIT TARGET. Extract ONLY the decorative vignette to the RIGHT of the uncle: the THREE overlapping cream property cards with pixel scenery and RED / BLUE / GREEN strips, together with the TWO glossy pawn pieces (gold on left card and blue over middle card). Treat these five objects together as ONE composed illustration asset. Preserve the exact original relative positions, card perspective, scene artwork, outlines, colors, highlights, pawn shapes, overlapping layers and proportions. Remove all cyan sky, white sparkle rays, clouds, mascot, title and buttons. Keep the cards complete, restore only tiny edges if necessary, never add a fourth card or third pawn. Output this ONE vignette on genuinely transparent alpha with tight even padding, landscape composition. No captions, no UI text, no ground or cast shadow outside the shapes, no watermark.
```

## Icon calls — common prefix plus one subject each

Each call concatenated the following prefix with one subject below:

```text
Use case: background-extraction. Input image 1 is the EDIT TARGET, a flattened Vietnamese game lobby. Primary request: extract ONLY the described icon as ONE standalone reusable UI asset. Preserve its source shape, orientation, colors, outlines, highlights, shading and internal details as closely as possible. Remove the surrounding button, all letters, sky, scenery and every other element. Output on a genuinely transparent alpha background, centered, tightly framed with small even transparent padding. No restyling, no new objects, no caption, no watermark, no painted checkerboard, no exterior drop shadow. Subject:
```

### icon-dice

```text
The large white tilted three-face die on the LEFT side of the gold Vào bàn button (near x250 y900 on the 853x1844 source). Keep its navy outline, navy pips and subtle lavender shaded side. Do not extract the smaller die attached to the title logo.
```

### icon-history

```text
The blue circular history-clock arrow icon immediately to the LEFT of Lịch sử on the first cream button. Keep the light clock face, two navy hands, thick blue counterclockwise curved arrow, navy edge and small white highlights.
```

### icon-leaderboard

```text
The small three-bar podium with a gold crown above its middle tallest gold bar, immediately LEFT of Bảng xếp hạng. Keep blue/silver left bar, gold tall middle bar, orange/coral right bar, gold crown and navy outlines together as one icon.
```

### icon-rules

```text
The open paper book immediately LEFT of the underlined Luật chơi text, below the buttons. Keep the two pale white pages, subtle pale blue lines, navy outline and blue cover, including the central book fold. Do not include the words or their underline.
```

### icon-exit

```text
The small orange/coral door and arrow icon immediately LEFT of Thoát game in the bottom footer pill. Keep the exact door silhouette, cream right-pointing arrow through it, and deep coral outline. Do not include the cream pill or letters.
```

### icon-ken

```text
The gold coin with the embossed crown INSIDE the top KEN balance pill, immediately before 12.500 KEN. Keep the circular gold rim, warm orange outline, inner gold face, crown and highlights. Do not include any number, letters, or the cream pill behind the coin.
```

### icon-sound — initial attempt

```text
ONLY the navy loudspeaker with its two curved sound waves INSIDE the round top-right sound button. Remove the cream circular button background and its outer ring. Preserve the exact speaker and two waves, deep navy fill with the original subtle highlight; no added mute symbol.
```

The first execution handle was no longer available and no sound output was found among the completed files. Retried with the exact prompt in `sound-retry-prompt.txt`; selected output `exec-6c6bb4df-62d5-4739-bf8b-78c479f80414.png`.

## Empty gold button

```text
Use case: precise-object-edit. Input image 1 is the EDIT TARGET. Extract ONLY the wide rounded gold pill button in the middle of the lobby, the one originally labeled Vào bàn. Remove its die icon, remove ALL lettering, and seamlessly fill those areas with the original smooth yellow-gold button face. Preserve the exact capsule proportions (about 3.5 times as wide as tall), cream upper rim highlights, bright yellow/gold gradient, orange/navy edge and thick amber bottom lip. Remove sky, external floating yellow rays and every other object. Deliver ONE empty gold button skin on genuinely transparent alpha, front-facing, wide horizontal, tightly framed with small even transparent padding. No text, no icon, no new decorations, no watermark. This is a reusable blank button skin derived from the source, not a new design.
```

## Empty paper button

```text
Use case: precise-object-edit. Input image 1 is the EDIT TARGET. Extract ONLY the cream rounded pill button originally labeled Lịch sử. Remove the history-clock icon and ALL lettering; fill those areas cleanly with the same warm cream button face. Preserve its exact proportions (about 4.7 times as wide as tall), thin navy contour, pale cream highlight and shallow beige/blue bottom edge from the source. Remove sky and all other elements. Output ONE empty cream paper button skin on genuinely transparent alpha, wide horizontal, tightly framed with small padding. No text, no icons, no extra outline shapes, no watermark. This is the reusable secondary button skin, not a new design.
```

## Background

```text
Use case: precise-object-edit. Input image 1 is the EDIT TARGET. Produce a clean BACKGROUND PLATE of this exact portrait lobby. REMOVE every foreground UI/decor object: profile/avatar bar, coin and KEN text, speaker button, title logo/crown/die, uncle mascot/fan/ground shadow, all three property cards and both pawns and sparkles, all menu buttons and their icons/text, the rules book/text/underline, exit button/icon/text, and version. Inpaint the removed upper/middle areas with the same cyan sunny sky and sparse pixel clouds near the edges; keep the center mostly empty for UI. Preserve the existing detailed Vietnamese pixel town, river, yellow bridge, waterfront, roofs, trees, mountains, flowers and street along the BOTTOM as closely as possible, reconstruct only the small area hidden by the footer. Keep the original bright daytime palette, crisp 16-bit pixel scenery, composition, lower-city horizon and portrait framing approximately 853:1844. Output ONE opaque full-bleed portrait background, no interface, no people mascot, no board/cards/pawns, no text anywhere, no watermark. This is an inpainted background plate, not a redesigned scene.
```

## Cleanup attempts

Full prompt: `logo-clean-prompt.txt`, using the already-extracted logo as edit target, transparent_background=true; selected. The rules/leaderboard cleanup outputs were rejected at the time; both icons are now replaced by v2 below.

For the original extraction trial, no script recolored, rematted, cropped or recompressed the source PNG files. Runtime WebP files are separate crop/resize/compress copies; the source PNGs remain unchanged.

## Lượt v2 (2026-10-21) — đã chọn

Sau [audit](../../../docs/style/screens/s2-lobby/asset-audit.md), 10 asset được gen lại bằng built-in `image_gen`, mỗi lần một asset, `transparent_background: true`, không script cắt/mask/recolor. So cạnh concept trên nền trời, chọn v2 cho 8 asset và **thay v1**: `mascot`, `hero-properties`, `icon-dice`, `icon-history`, `icon-leaderboard`, `icon-rules`, `button-gold`, `button-paper`. Cặp cửa/mũi tên thoát v2 bị loại theo quyết định người dùng; `icon-exit.png` giữ v1 cùng `background`, `logo`, `icon-ken`, `icon-sound`.

Prompt đầy đủ của lượt v2 không lưu trong repo. Input của icon là crop phóng lớn nearest-neighbor từ chính concept (`x,y,w,h`): xúc xắc `190,840,125,130`, đồng hồ `238,1025,105,105`, BXH `210,1158,120,108`, sách `284,1312,102,80`, nút vàng `120,817,614,181`; mascot, hero và nút kem dùng cả concept. Bốn icon còn qua thêm một lượt sửa nét (v1 mượt làm edit target, v2 làm hướng dẫn chi tiết).

Điểm đã xác nhận từ crop nguồn và các lần bị loại:

- Xúc xắc CTA là **3–2–1** (mặt lớn trên / trái / phải); không dùng viên trong logo.
- Đồng hồ không có chấm tâm, kim gấp khúc.
- Sách/BXH lấy crop trực tiếp làm input để giữ dáng gọn; crown BXH viền nâu, không navy.
- Skin vàng visible 3,50:1 (lần đầu 3,96:1); không kéo dãn PNG để sửa tỷ lệ.
- Màu RGB dưới alpha = 0 không phải glow nhìn thấy; kiểm viền trên ảnh đã ghép nền.

Tia vàng CTA và tia trắng hero không nằm trong PNG; chúng là hai SVG riêng theo README S2.

## Tách lại cửa và mũi tên từ v1 (2026-10-21)

Theo yêu cầu tiếp tục dùng imagegen, đã tách lại đúng thiết kế thoát v1 thành `icon-exit-door.png` và `icon-exit-arrow.png`. Giữ cửa cam, mũi tên kem viền đỏ nâu hướng phải. Hai output này khác cặp v2 bị loại ở trên. [Toàn bộ prompt, output ID, lượt sửa tỷ lệ và thông số export](./exit-split-prompts.md). PNG nguồn giữ nguyên output imagegen, không script mask/recolor.
