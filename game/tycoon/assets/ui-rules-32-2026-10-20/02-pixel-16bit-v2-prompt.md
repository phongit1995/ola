# Pixel 16-bit — cập nhật vị trí ô theo docs

## Prompt tinh chỉnh tỷ lệ và dải màu (lần 2)

```text
Use case: precise-object-edit, UI layout geometry correction.
The supplied image is the updated approved 16-bit pixel Vietnamese board game. ALL 32 TILE CONTENTS, names, values, order, corner identities, exactly four pawns, all four avatars, current board mechanics are CORRECT and MUST REMAIN IDENTICAL. Preserve the exact pixel scenery, modern smooth typography and gold button style.
Make ONLY these two precise geometry/layout corrections:
1. The perimeter board is too tall. Its outer rectangle currently about x20..1065 y80..1250 must become a TRUE SQUARE x20..1065 y80..1125 in the same 1086x1448 portrait canvas. Board width 1045 px and board height 1045 px, visibly equal. Keep top row where it is; move bottom row UP by 125 px. Compress all SEVEN side tiles on left and right to fit equally between top and bottom corners. Keep all thirty-two cells, no deletion, no extra cells. Fit the center elements within the shortened interior: shrink vertical whitespace between decks, turn chip, dice, gold Gieo xúc xắc button and helper. Keep the button centered horizontally. Move the four-player row up to immediately under square board y1140..1250. Use remaining lower space for a neatly spaced two-row event log and bottom utility buttons. The full board must be square, NOT near-square or tall, NO perspective tilt.
2. City group stripes must appear ONLY on INNER edges, not duplicated outside: TOP cities thin color stripe along BOTTOM edge of cell; BOTTOM cities stripe along TOP edge; LEFT cities stripe along RIGHT edge; RIGHT cities stripe along LEFT edge. Remove colored strips from OUTER edges of those city cells. Other borders thin navy, neutral cream background. No colored group borders on any chance, chest, airport, tax or corner cells.
Exact group colors: Thanh Hóa+Vinh brown; Đà Lạt+Buôn Ma Thuột sky; Cần Thơ+Phú Quốc pink; Quy Nhơn+Nha Trang orange; Hội An+Huế red; Hạ Long+Hải Phòng yellow; Đà Nẵng+Vũng Tàu green; TP.HCM+Hà Nội deep blue.
Preserve updated board order exactly, read from reference. Top: Nhà tù, Cần Thơ, Sân bay, Phú Quốc, Thuế, Quy Nhơn, Khí vận, Nha Trang, Lễ hội. Left between corners top-down: Đà Lạt, Sân bay, Buôn Ma Thuột, Cơ hội, Vinh, Khí vận, Thanh Hóa. Right top-down: Hội An, Cơ hội, Huế, Cơ hội, Hạ Long, Sân bay, Hải Phòng. Bottom left-right: Xuất phát, TP.HCM, Hà Nội, Cơ hội, Khí vận, Đà Nẵng, Sân bay, Vũng Tàu, Du lịch.
All four airports exact title Sân bay and 200 tr. Preserve ALL original city prices. All Vietnamese text sharp, upright and unchanged. No new mechanics, no recoloring of scenery, no new art style. Return ONE complete full portrait game UI image.
```

Công cụ: built-in imagegen. Ảnh tham chiếu: [02-pixel-16bit.png](./02-pixel-16bit.png).

Nguồn: `docs/05-gameplay-rules-and-protocol.md`, `docs/10-board-tiles.md`, `docs/style/02-board-tiles.md`, `logic/board.json` tại thời điểm tạo. Sân bay ở 6, 10, 22, 26; Cơ hội ở 4, 18, 20, 29; Khí vận ở 2, 14, 28; Thuế ở 12.

## Prompt

```text
Use case: ui-mockup / precise-object-edit.
EDIT the supplied approved Vietnamese CỜ TỶ PHÚ mobile game UI. The user has APPROVED THIS EXACT 16-BIT PIXEL STYLE. Produce ONE updated polished full game screen, same portrait 3:4 image format, no phone mockup, no annotations or collage. Preserve vivid 16-bit scenic pixel landscapes, stepped pixel edges, blue sky backdrop, warm ivory board, navy rounded typography, gold CTA, friendly smooth avatar portraits, both card stacks, central turn/dice cluster, bottom player row. Do not replace pixel landscapes with paintings or isometric miniatures.
The latest docs RELOCATE 8 special tiles and rename ALL FOUR airports "Sân bay". This precise update is the main purpose. City positions/prices and four corners stay unchanged.
REBUILD EXACT BOARD ORDER, 32 spaces, four corners plus SEVEN cells between each pair of corners. Text always upright:
TOP row left to right INCLUDING corners (9 cells):
NHÀ TÙ | Cần Thơ 140 tr | Sân bay 200 tr | Phú Quốc 160 tr | Thuế −10% | Quy Nhơn 180 tr | Khí vận | Nha Trang 200 tr | LỄ HỘI.
LEFT edge top to bottom BETWEEN corners (7 cells):
Đà Lạt 120 tr | Sân bay 200 tr | Buôn Ma Thuột 100 tr | Cơ hội | Vinh 80 tr | Khí vận | Thanh Hóa 60 tr.
RIGHT edge top to bottom BETWEEN corners (7 cells):
Hội An 220 tr | Cơ hội | Huế 240 tr | Cơ hội | Hạ Long 260 tr | Sân bay 200 tr | Hải Phòng 280 tr.
BOTTOM row left to right INCLUDING corners (9 cells):
XUẤT PHÁT +160 tr | TP. HCM 400 tr | Hà Nội 350 tr | Cơ hội | Khí vận | Đà Nẵng 320 tr | Sân bay 200 tr | Vũng Tàu 300 tr | DU LỊCH.
IMPORTANT: NO names Nội Bài, Tân Sơn Nhất, Cam Ranh, Long Thành anywhere. ALL four airport tiles use exact label "Sân bay", matching pixel airplane/terminal art and 200 tr. The tax is now the MIDDLE tile of top row. Middle tile of left edge = Cơ hội, of right edge = Cơ hội, of bottom row = Khí vận.
GOLDEN SOURCE GROUP BANDS: ONLY the sixteen city tiles have narrow saturated GROUP stripes, on the INNER edge only:
Thanh Hóa and Vinh BROWN #8D5B3C;
Buôn Ma Thuột and Đà Lạt SKY #7EC8E3;
Cần Thơ and Phú Quốc PINK #E58FB5;
Quy Nhơn and Nha Trang ORANGE #F2994A;
Hội An and Huế RED #D64545;
Hạ Long and Hải Phòng YELLOW #F2D04E;
Vũng Tàu and Đà Nẵng GREEN #3BA776;
Hà Nội and TP. HCM BLUE #2F5FD0.
Thus top city stripes BOTTOM edge, left city stripes RIGHT edge, right city stripes LEFT edge, bottom city stripes TOP edge. Airport/chance/chest/tax/corner cells have NO group stripes and thin navy/neutral borders. Airport backgrounds pale cream #F0E4C8; Chance very light gold with bold orange pixel question mark; Chest pale sky with recognizable blue wind glyph as approved reference; Tax pale coral with pixel tax bag and −10% in coral.
Keep 16 scenic compositions location specific and distinctly pixel art from the reference. All city names and prices remain readable. Four corners stay: NHÀ TÙ upper left with pixel prisoner behind bars plus small separate "Thăm tù" strip; LỄ HỘI upper right pixel lantern/star art and "Thuê ×2"; XUẤT PHÁT lower left with UP arrow and "+160 tr"; DU LỊCH lower right pixel suitcase/plane and "Bay lượt sau".
Layout: board should be a true SQUARE rather than reference's vertically stretched rectangle. At output width W, board width and height both approximately 0.96W; located immediately below header. Equal board width and height are deliberate docs requirement. Keep all 32 tiles and whole screen uncropped. Let square-board correction free space BELOW board for the four equal player cards and a compact 2-line recent-events area above the footer. Do not stretch tiles vertically.
Header retain CỜ TỶ PHÚ logo, "Vòng 7/30 · 18:20", sound/menu. Inside board retain two small stacks "CƠ HỘI" upper left and "KHÍ VẬN" upper right, generous plain cream negative space. Centered main cluster: "Lượt của bạn", countdown "0:28", two ivory dice showing 3 and 5, ONLY ONE primary button "Gieo xúc xắc". Small subdued helper "Thắng ngay: 3 nhóm · 1 cạnh · 4 sân bay". No buy/build/travel actions in this roll-phase screen.
Exactly FOUR small pawn tokens total: gold at Vinh, blue at Đà Lạt, coral at Hội An, violet at Hải Phòng; each sits just inside board boundary adjacent to its cell and does not obscure names or price. Remove extra orange fifth token from reference.
ALL FOUR PLAYER CARDS below board, one row: Bạn 1.240 tr GOLD, Linh 980 tr BLUE, Khoa 760 tr CORAL, Mai 1.100 tr VIOLET. No player panels above or inside board.
Footer utility "Tài sản" and "Diễn biến"; recent events "Linh qua Xuất phát +160 tr" and "Khoa đang ở Hội An". Money gain green. No chat. Perfect Vietnamese accents, sharp readable text. Keep the approved overall visual identity; make the board-data update unmistakably accurate.
```

