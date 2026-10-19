# Cờ Tỷ Phú — 3 lựa chọn phong cách

Ngày: 19/10/2026. Công cụ: built-in image_gen.imagegen.

Ảnh tham chiếu: ../exec-f7dbd796-8a5f-46af-af8a-2b6d1d3780c2.png.
Nguồn luật: ../../docs/05-gameplay-rules-and-protocol.md, ../../logic/board.json, ../../logic/constants.ts.

Đây là ảnh concept để chọn phong cách; chữ, số và số ô cần kiểm tra lại khi triển khai bằng code.

Kiểm tra hình ảnh: cả ba giữ bố cục tham chiếu, địa danh minh họa và cụm gieo giữa bàn. Một số dải màu đất và màu quân/portrait chưa thống nhất hoàn toàn với dữ liệu luật; không dùng ảnh làm nguồn dữ liệu gameplay. Khi triển khai lấy thứ tự, giá, nhóm màu và ghế người chơi từ code.

- [Kem cổ điển](./01-kem-co-dien.png)
- [Xanh biển trong trẻo](./02-xanh-bien.png)
- [Phố nắng ấm](./03-pho-nang.png)

## Prompt chung

Use case: ui-mockup.
Input image: the supplied image is the user's approved VISUAL STYLE and LAYOUT REFERENCE for CỜ TỶ PHÚ. Create ONE polished sibling gameplay screen in the same attractive illustrated casual mobile board-game family. Match the reference's portrait 3:4 proportions, complete board, friendly human avatars in colored map-pin tokens, miniature Vietnamese destination paintings within tiles, soft dimensional ivory dice, clean navy typography, and sunny gold primary action. Full-bleed UI image, no device frame, no presentation headings.
Keep two player panels ABOVE and two BELOW the board. Header "Vòng 7/20", sound, menu. Player colors/names/cash: gold "Bạn · 1.240 tr", blue "Linh · 980 tr", coral "Khoa · 760 tr", violet "Mai · 1.100 tr". Tokens must correspond to these player colors. ONLY ONE main action area at exact board center: "Lượt của bạn", circular countdown "0:28", TWO dice, button "Gieo xúc xắc". This depicts the roll phase; don't show Buy/Build/End turn simultaneously. Two small card stacks "CƠ HỘI" (gold/orange) and "KHÍ VẬN" (sky blue) near upper inner corners. Interior mostly airy and open with quiet paving and sparse landscaped edges like reference, small "CỜ TỶ PHÚ" at lower interior, never a giant central illustration. Bottom utility strip: compact assets/deed icon, event log icon, a small event "Linh vừa qua Xuất phát +200 tr". Money only in tr, no dollar or betting.
RULE-ACCURATE BOARD: exactly 40 perimeter spaces = 4 large corners + exactly 9 cells BETWEEN each pair of corners, an 11 by 11 perimeter grid. All labels upright. Bottom-right "XUẤT PHÁT" with LEFT arrow and small "+200 tr"; bottom-left "NHÀ TÙ" with visiting area; top-left "BÃI ĐỖ XE"; top-right "VÀO TÙ". Do not duplicate or omit tiles.
Bottom edge, from RIGHT to LEFT BETWEEN corners: Phố Hiến 60 tr; Khí vận; Hội An 60 tr; Thuế 200 tr; Ga Hà Nội 200 tr; Sa Pa 100 tr; Cơ hội; Mộc Châu 100 tr; Ninh Bình 120 tr.
Left edge from BOTTOM to TOP between corners: Cần Thơ 140 tr; Điện 150 tr; Phú Quốc 140 tr; Hạ Long 160 tr; Tân Sơn Nhất 200 tr; Hải Phòng 180 tr; Khí vận; Huế 180 tr; Nha Trang 200 tr.
Top edge from LEFT to RIGHT between corners: Đà Lạt 220 tr; Cơ hội; Đà Nẵng 220 tr; Quy Nhơn 240 tr; Cảng HP 200 tr; Biên Hòa 260 tr; Thủ Dầu Một 260 tr; Nước 150 tr; Vũng Tàu 280 tr.
Right edge from TOP to BOTTOM between corners: Đồng Khởi 300 tr; Nguyễn Huệ 300 tr; Khí vận; Thủ Thiêm 320 tr; Bến xe 200 tr; Cơ hội; Hồ Gươm 350 tr; Thuế 100 tr; Hồ Tây 400 tr.
Group bands MUST follow rules rather than random reference colors: Phố Hiến/Hội An BROWN; Sa Pa/Mộc Châu/Ninh Bình SKY; Cần Thơ/Phú Quốc/Hạ Long PINK; Hải Phòng/Huế/Nha Trang ORANGE; Đà Lạt/Đà Nẵng/Quy Nhơn RED; Biên Hòa/Thủ Dầu Một/Vũng Tàu YELLOW; Đồng Khởi/Nguyễn Huệ/Thủ Thiêm GREEN; Hồ Gươm/Hồ Tây DEEP BLUE. Specials have no property group band. Distinguish tiny ownership markers from group bands. No houses are needed in this snapshot.
Destination miniatures must be retained, not generic houses: Nha Trang curved turquoise beach + waterfront skyline, Huế imperial gate, Hạ Long limestone karsts, Hội An lantern street, Sa Pa rice terraces, Mộc Châu hills, Cần Thơ river market, Phú Quốc palms/beach, Hồ Gươm lake tower, Hồ Tây sunset pagoda. Match original illustration richness and quality. Transportation icons coherent with destinations. All Vietnamese carefully typeset. No extra game mechanics, auction, mortgage or trade buttons. This is a design concept, render the intended UI as beautifully and precisely as possible.

## Kem cổ điển

Closest to the approved reference. Warm ivory board and off-white outer background, a slim navy double outline with champagne inner trim, rich clean travel-poster miniatures, modest leafy plaza edges. Refine the UI with pill-shaped player panels, matching circular avatar rims, a soft gold active-turn pill, gold circular timer arc, and wide gold roll button with gentle satin dimensionality. Friendly rounded sans, well-spaced amounts. A restrained classic city board game, crisp and airy; avoid ornate embellishments and excessive scenery. Preserve the reference's balance and generous center.

## Xanh biển trong trẻo

A fresh coastal variation clearly in the SAME illustrated family as reference. Pale aqua outer canvas, porcelain ivory tiles, slender teal-navy board border, a faint blue-tinted plaza interior with sparse palms and planters at the inside corners. Destination paintings stay accurate to their own locations, vivid, clean and sunlit. Player cards are softly rounded rectangles with inset colored edge and large circular portraits, two top/two bottom. Center controls use a compact cream turn chip with gold accent and gold timer arc, two soft ivory dice and a GOLD rounded roll button with crisp navy text. Slightly cleaner, less beveled components and very tidy icon outlines. Still charming illustrated casual board game, not a minimal wireframe, not monochrome. Preserve all group and player colors.

## Phố nắng ấm

A warm sunny Vietnamese city variation in the SAME polished illustrated casual-game family as reference. Pale apricot outer canvas, sunlit cream board, fine dark-navy outline with warm terracotta accent line, destination miniatures in coherent bright morning light without sepia. Sparse ochre planters, tiny bougainvillea accents and soft pavement along inner border, no large buildings behind controls. Player panels resemble rounded cream nameplates with strong seat-color header/edge and circular portrait medallions, same 2 above/2 below layout. Center active-turn label is a neat warm-gold rounded tab, ivory/gold countdown dial, two ivory dice and a full sunny golden rounded-rectangle CTA with gentle hard lower shadow. Warm friendly typography, tactile restrained depth, generous blank center, original reference's attractive landmark illustrations and avatar pins. Avoid antique paper, grunge, casino neon or dark background.

