# Cờ Tỷ Phú — V2: phong cảnh mới, toàn bộ người chơi ở dưới

Tạo bằng built-in imagegen ngày 19/10/2026.

Yêu cầu: vẽ lại phong cảnh trong các ô bằng 3 cách khác nhau; cả 4 thẻ người chơi nằm dưới bàn, cùng một hàng. Giữ cụm gieo xúc xắc giữa bàn.

Tham chiếu: ../style-options-2026-10-19/01-kem-co-dien.png.
Luật: ../../docs/05-gameplay-rules-and-protocol.md và ../../logic/board.json.

## Kiểm tra kết quả

- Đã xem cả 3 ảnh: bốn thẻ Bạn, Linh, Khoa, Mai đều nằm cùng một hàng hoàn toàn dưới mép bàn. Phía trên không còn thẻ người chơi.
- Phong cảnh trong các ô đã được vẽ lại: nét hoạt hình, mô hình nhỏ 3D, và minh họa mảng màu/lớp cảnh đơn giản theo hướng giấy cắt.
- Cụm lượt chơi, đồng hồ, hai xúc xắc và nút gieo vẫn ở giữa bàn.
- Đã kiểm tra 3 PNG lưu trong folder này trùng với đầu ra được xem.
- Đây là concept chọn mỹ thuật. Một số màu nhóm đất và chi tiết số tiền vẫn chưa khớp dữ liệu game; khi dựng UI phải lấy các dữ liệu này từ code.

- [Phong cảnh hoạt hình](./01-phong-canh-hoat-hinh.png)
- [Tiểu cảnh 3D](./02-tieu-canh-3d.png)
- [Phong cảnh giấy cắt](./03-phong-canh-giay-cat.png)

## Prompt chung

Use case: ui-mockup. EDIT/REDESIGN the provided Vietnamese CỜ TỶ PHÚ game screen reference.
THE USER REJECTED THE PREVIOUS OUTPUTS. TWO REQUIRED CHANGES:
(1) COMPLETELY REPAINT the scenery illustrations INSIDE EVERY PROPERTY TILE in the new specified visual medium. Do not keep the same travel-poster scenery. This is a real change of illustration style, not changing just the outer background.
(2) MOVE ALL FOUR PLAYER/MEMBER PANELS TO A SINGLE ROW ENTIRELY BELOW THE BOARD. There must be ZERO player cards, portraits, names, money balances above the board or inside its central area. At top only a slim round/status bar and sound/menu. Player tokens are small colored game markers on board perimeter, no extra member information panels there.
Output ONE full-screen high-fidelity mobile game UI image, portrait 3:4, full uncropped layout, no phone frame, no collage, no annotations outside UI. Preserve recognizable cream/navy/gold design family, circular friendly human avatar portraits in bottom player cards, gold central roll button, top-down board and full Vietnamese content. Layout from top to bottom:
- 5% height slim header with small CỜ TỶ PHÚ wordmark, centered "Vòng 7/20", sound/menu at right. NO PLAYER HUD in this area.
- Complete large SQUARE board spanning 96% screen width, directly below the slim header. Exactly 40 perimeter tiles: four larger square corners, NINE regular spaces between each pair of corners. All city illustrations and labels upright.
- BELOW THE ENTIRE BOTTOM EDGE of board: four equal-width compact member cards SIDE BY SIDE in ONE HORIZONTAL ROW. Left to right: gold Bạn, blue Linh, coral Khoa, violet Mai. Each card has a centered circular portrait ABOVE name ABOVE cash. Exact cash: Bạn "1.240 tr", Linh "980 tr", Khoa "760 tr", Mai "1.100 tr". Yellow highlight for Bạn. Fit all four comfortably within screen, no second row, no player panels anywhere else.
- Beneath players a very slim utility strip "Tài sản", "Diễn biến" and small recent event "+200 tr qua Xuất phát".
Interior of board: very quiet light ivory, NO large trees, no mural, no scenery border. Two small card decks "CƠ HỘI" / "KHÍ VẬN" in upper inner corners. At exact board CENTER a modest "Lượt của bạn" label and circular "0:28" countdown, TWO ivory dice, a sunny gold "Gieo xúc xắc" button. All roll controls are INSIDE board. Most open interior calm and spacious, focus visual detail on newly repainted tile landscapes.
Rules and exact board order: bottom-right XUẤT PHÁT, left arrow +200 tr; bottom-left NHÀ TÙ; top-left BÃI ĐỖ XE; top-right VÀO TÙ.
Bottom BETWEEN corners right to left: Phố Hiến 60, Khí vận, Hội An 60, Thuế 200, Ga Hà Nội 200, Sa Pa 100, Cơ hội, Mộc Châu 100, Ninh Bình 120.
Left BETWEEN corners bottom to top: Cần Thơ 140, Điện 150, Phú Quốc 140, Hạ Long 160, Tân Sơn Nhất 200, Hải Phòng 180, Khí vận, Huế 180, Nha Trang 200.
Top BETWEEN corners left to right: Đà Lạt 220, Cơ hội, Đà Nẵng 220, Quy Nhơn 240, Cảng HP 200, Biên Hòa 260, Thủ Dầu Một 260, Nước 150, Vũng Tàu 280.
Right BETWEEN corners top to bottom: Đồng Khởi 300, Nguyễn Huệ 300, Khí vận, Thủ Thiêm 320, Bến xe 200, Cơ hội, Hồ Gươm 350, Thuế 100, Hồ Tây 400.
Add tr to money labels. Correct groups: Phố Hiến/Hội An brown; Sa Pa/Mộc Châu/Ninh Bình sky blue; Cần Thơ/Phú Quốc/Hạ Long pink; Hải Phòng/Huế/Nha Trang orange; Đà Lạt/Đà Nẵng/Quy Nhơn red; Biên Hòa/Thủ Dầu Một/Vũng Tàu yellow; Đồng Khởi/Nguyễn Huệ/Thủ Thiêm green; Hồ Gươm/Hồ Tây deep blue. Specials neutral.
All NEW scenery should remain destination-specific: beach and waterfront Nha Trang, imperial gate Huế, limestone islands Hạ Long, lantern street Hội An, rice terraces Sa Pa, tea hills Mộc Châu, boat market Cần Thơ, tropical island Phú Quốc, tower on lake Hồ Gươm, sunset pagoda Hồ Tây, pine hill houses Đà Lạt, dragon bridge Đà Nẵng. Tiny colored owner markers/game pieces must not cover names/prices. No new mechanics or giant branding. Main priorities are visibly NEW TILE LANDSCAPE ART and ALL FOUR MEMBERS BELOW BOARD.

## Phong cảnh hoạt hình

REDRAW EVERY property scene as a charming hand-drawn 2D STORYBOOK CARTOON landscape: bold clean navy contour lines, broad flat color areas with just one simple shadow tone, rounded clouds, simplified expressive trees, slightly exaggerated landmark silhouettes, cheerful turquoise water and lush greenery. Visibly drawn with confident illustrated shapes, almost like a high-quality animation background in miniature. No photographic detailing, dense travel-poster texture, fine realistic rendering or old reference scene pixels. Each tile shows one memorable place composition with foreground, landscape and sky, not merely a floating generic icon. Apply matching chunky 2D illustrated pictograms to stations, tax, utilities and corner cells. The whole screen still has the reference's cream, navy and gold casual game UI.

## Tiểu cảnh 3D

REDRAW EVERY property scene as a tiny STYLIZED 3D DIORAMA viewed in gentle isometric perspective, a handcrafted toy landscape: soft matte clay-like materials, rounded edges, miniature land platforms, simplified architectural landmarks, little sculpted hills, turquoise molded water, tiny rounded trees and warm soft shadows. Each diorama fits fully INSIDE its property tile and leaves name/price clear. Nha Trang a tiny curved beach with 2 palm trees and toy waterfront towers; Ha Long a miniature jade-karst archipelago; Hue a toy imperial gate, etc. Rich coherent premium casual-game art, not realistic photography and not the flat original travel paintings. Rounded modeled utility and station pictograms. Board overall stays top-down, never tilt the whole board. Preserve readable cream/gold/navy game UI.

## Phong cảnh giấy cắt

REDRAW EVERY property scene as a contemporary LAYERED PAPER-CUT LANDSCAPE with 4–6 clean colored silhouette layers, tiny subtle shadows separating layers, matte colors, elegant reduced detail. Curved hills and waves, cut-out temple roofs and bridges, flat cloud layers. Use cheerful saturated pastel jade, coral, ochre, sky and ivory, not faded antique sepia. Every miniature should have a designed foreground, middle ground and distant landscape like a tiny cut-paper theatre. Hoi An angular ochre shopfronts and lantern circles; Sa Pa overlapping curved terraced layers; Ha Long three stepped karst silhouettes against aqua; Hue layered palace gate. No photographic/travel poster detail, no outlines around every texture, no reused old scene. Matching layered paper pictograms for special tiles. Keep UI friendly and polished with reference's cream/navy/gold visual family, not a scrapbook or torn-page interface.

