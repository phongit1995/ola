# Cờ Tỷ Phú UI — Style: Phố Thị Rực Rỡ

## Trạng thái

Tài liệu thiết kế cho mini-game **Cờ Tỷ Phú** (gameId `tycoon`).

**Đang có (15/10/2026): bản client-only chơi với máy** ở `game/tycoon/` — luật v1 đầy đủ chạy trong `logic/engine.ts` (port 1:1 từ thiết kế server ở 05), bot ở `logic/bot.ts`, store local `store/useTycoon.ts`, hiệu ứng bậc Lite (chưa có lớp hạt Pixi, chưa có nhân vật/raster, quân cờ là hình học). Chạy `pnpm --filter @ola/game dev` rồi mở `http://localhost:5174/tycoon/`.

**Chưa làm:** server Go + protocol (05 §5–§9), danh sách bàn/phòng chờ/chat/lịch sử/BXH online. Khi làm server, `logic/engine.ts` là bản tham chiếu để port sang Go; lúc đó server là nguồn chân lý và client chỉ render view + gửi lệnh như docs mô tả. Bảng dữ liệu tĩnh hiện nằm ở `logic/board.json`, `logic/cards.json`, `logic/constants.ts` (sau này sinh từ Go bằng codegen).

Tên game, tên ô, hình quân và thẻ bài đều là sáng tác riêng. Không dùng tên "Monopoly", tên phố/nhân vật/hình ảnh của Hasbro — cơ chế chơi không được bảo hộ, nhưng tên và mỹ thuật thì có.

## Hướng duy nhất

**Phố Thị Rực Rỡ** là design system duy nhất cho UI Cờ Tỷ Phú. **UI v3 (20/10/2026) theo ảnh mẫu pixel 16-bit** [`screens/s6-board/concept-s6-board-pixel-16bit.png`](./screens/s6-board/concept-s6-board-pixel-16bit.png): nền trời pixel, mỗi thành phố một tranh phong cảnh pixel trong ô, 8 dải màu nhóm đất, UI mượt viền navy, CTA vàng nổi khối, quân con tốt màu ghế, tiền xanh ngọc, nguy hiểm san hô. Production: bàn, ô, nhà, xúc xắc, thẻ, quân là SVG/DOM; raster cho tranh pixel ô, nền trời, logo và nhân vật.

**Lobby S2 đã chốt phương án 1 — Nền trời thoáng:** [ảnh tham chiếu](./screens/s2-lobby/concept-s2-lobby-pixel-16bit.png) (bản 22/10/2026 có nút chơi máy xanh ngọc), [đặc tả style lobby](./screens/s2-lobby/README.md). Nền trời mở, Bác Tỷ bên trái, ba thẻ đất + hai quân bên phải, menu vàng/kem với font Nunito. Lobby mock đã dựng; nút Chơi với máy mở modal [02 §2.3](./02-screen-specs.md#23-modal-chơi-với-máy-botsetupmodal): Bot 1 mặc định, thêm/xóa tối đa 3 bot và chọn mức độ riêng (máy chưa chơi khác nhau theo mức, 05 §12). Topbar dùng avatar VIP, @username và số dư rồi đồng K bên phải.

**Hướng dẫn chơi đã chốt và dựng 23/10/2026:** [bốn tab, nội dung và asset](./screens/s2-lobby/README.md#12-hướng-dẫn-chơi--đã-chốt-4-tab); `RulesModal` dùng 18 minh họa `assets/rules/`.

## Phạm vi v1 (đề xuất chốt)

- PvP **2–4 người**, chơi theo bàn (room) như Tiến Lên; không có hàng đợi ghép nhanh.
- **Cược KEN do chủ bàn chọn, mặc định 0** (bàn giao lưu); hạng 1 nhận pot trừ phí. **Cho người khác xem: mặc định tắt**, chủ bàn bật khi tạo bàn. Chi tiết và việc server còn thiếu: [11-room-settings.md](./11-room-settings.md). Thắng/thua vẫn ghi lịch sử, bảng xếp hạng và cộng XP.
- Bàn **32 ô** (16 thành phố Việt Nam, 8 nhóm × 2), Xuất phát ở góc dưới-trái, đi thuận kim đồng hồ; tiền trong ván tính bằng **triệu** (`tr`), vốn khởi đầu `1.500 tr`.
- **Giới hạn ván**: `MAX_ROUNDS = 30` vòng hoặc 25 phút (mỗi vòng = mọi người còn chơi đã kết thúc lượt một lần). Hết vòng → xếp hạng theo **tổng tài sản**. Chỉ còn 1 người chưa phá sản → kết thúc sớm.
- Có: gieo xúc xắc (đôi được gieo lại, 3 đôi liên tiếp vào tù), mua đất, thu tiền thuê tự động, nâng 3 cấp nhà (Nhà → Biệt thự → Khách sạn) đều tay, hạ cấp hoàn nửa giá, nhà tù (nộp phạt / thẻ ra tù / gieo đôi), thẻ Cơ hội và Khí vận, phá sản. Giá và cân bằng: [09-economy.md](./09-economy.md).
- Không có (v2): đấu giá khi bỏ mua, trao đổi đất, thế chấp.
- **30 giây** cho mỗi hành động; hết giờ server tự làm thay (gieo, bỏ mua, kết thúc lượt, tự bán nhà để trả nợ). 3 lần hết giờ liên tiếp hoặc thoát giữa ván = phá sản kỹ thuật, ván tiếp tục với người còn lại.
- Bỏ cuộc (FORFEIT), reconnect/resume, chat phòng + trong ván, reaction, lịch sử, bảng xếp hạng — dùng hạ tầng engine + SDK sẵn có.

## Công nghệ (đã chốt)

Game 2D, góc nhìn từ trên xuống, không camera, không vật lý. Ba lựa chọn có sẵn trong repo:

| Stack | Game đang dùng | Hợp với tỷ phú? |
|---|---|---|
| **React 19 + zustand + SVG/DOM** (Vite entry trong `game/`) | caro, thirteen, xiangqi | **Chọn làm nền.** Bàn 32 ô tĩnh, UI chủ yếu là sheet/modal/bảng số/live text — đúng thế mạnh DOM; quân nhảy, đếm tiền, lật thẻ, nhân vật bằng CSS transform + WAAPI. Tái dùng nguyên lobby/room/pregame/chat/history của xiangqi. |
| **Pixi.js — chỉ 1 lớp canvas hạt** phủ bàn | war-god (toàn bộ) | **Chọn kèm (hybrid).** Xu bay, bụi, pháo giấy, tia, mảnh vỡ vẽ trên canvas trong suốt `pointer-events: none`; không chữ, không nút, không state. Xoá canvas game vẫn chạy đúng. Xem [08-fx-and-animation.md](./08-fx-and-animation.md). |
| Pixi.js toàn bộ | war-god | Không. Nhiều chữ sống/sheet/accessibility trong canvas tốn gấp đôi công, mất tái dùng UI xiangqi. |
| Cocos Creator | ola-farm | Không. Build tay, không CI, asset pipeline nặng. |

Server: Go, `server/internal/game/games/tycoon/` cắm vào engine hiện có (05 §7), không thêm service. Codegen dữ liệu tĩnh Go → TS như thirteen/xiangqi.

## Danh sách màn hình và tính năng

11 màn/khối UI + 7 lớp overlay, chi tiết trong [02-screen-specs.md](./02-screen-specs.md):

| # | Màn | Tính năng chính |
|---|---|---|
| S1 | Loading / Connecting | đã có [UI chờ hồ sơ + xúc xắc 3D](./screens/s1-loading/README.md), Cung men nổi quay rồi xúc xắc lật một mặt; preload/API/lỗi + thử lại còn trong kế hoạch |
| S2 | Lobby | logo, KEN + avatar VIP + `@username`, CTA Vào bàn, Chơi với máy, Lịch sử, Bảng xếp hạng, Luật chơi, bật/tắt âm, thoát game |
| S3 | Danh sách bàn | list bàn 2–4 chỗ, khóa, KEN, Tham gia/Xem, Tạo bàn, reload chỉ icon tách khỏi tiêu đề, phân trang 9 hàng |
| S4 | Modal Tạo bàn / Vào bàn khóa | số người 2/3/4, cược KEN, mật khẩu, cho xem; [6 ảnh S4/O5 đã chốt UI](./screens/s3-room-list/README.md#8-modal-trên-danh-sách-bàn-s4-o5), chưa dựng online |
| S5 | Phòng chờ | 4 ghế, Sẵn sàng/Hủy, Bắt đầu (chủ bàn), Mời ra, Thoát bàn, chat phòng |
| S6 | Bàn chơi | header (logo, vòng, âm thanh, menu); bàn 9×9 (32 ô) có tên + giá trên ô; cụm lượt **giữa bàn** (chip lượt, đồng hồ 30 s, xúc xắc, nút theo pha); hàng pod 2–4 người **dưới bàn**; footer Tài sản / Diễn biến / sự kiện mới nhất |
| S7 | Sheet chi tiết ô | giá, bảng tiền thuê, chủ sở hữu, nhà đang có; từ đây Mua / Xây / Bán |
| S8 | Sheet quản lý tài sản | danh sách đất của mình theo nhóm, nút xây/bán từng ô, tổng tài sản |
| S9 | Kết quả | hạng 1–4, tổng tài sản từng người, lý do kết thúc, XP, Chơi lại, Đóng |
| S10 | Lịch sử | 100 ván gần nhất (online + chơi với máy): hạng, lý do kết thúc, KEN, thời gian; bấm xem xếp hạng ván; [mẫu 02 Mint đã chốt](./screens/s10-history/README.md), dùng lại asset, chưa dựng UI |
| S11 | Bảng xếp hạng | hôm nay / tuần này (số ván về hạng 1) / cấp độ (EXP tích lũy) |
| O1 | Xúc xắc | hai viên lăn, hiện tổng, badge "Đôi!" |
| O2 | Thẻ bài | lật thẻ Cơ hội / Khí vận, nội dung live text, nút Tiếp tục |
| O3 | Trả nợ | khi tiền < số phải trả: chọn nhà để bán, hoặc tuyên bố phá sản |
| O4 | Banner mất kết nối | icon VIP + `@username` mất kết nối, đếm ngược grace 30 s |
| O5 | NoticeModal | xác nhận (bỏ cuộc, thoát bàn, phá sản, hạ cấp) và thông báo (mời ra, lỗi, thiếu KEN) |
| O6 | Toast + turn announce | lỗi server, ĐẾN LƯỢT BẠN, "+200 qua Xuất phát" |
| O7 | Banner vòng cuối | "Vòng 28/30" đổi màu từ vòng 28, "Vòng cuối!" ở vòng 30 |

## Cấu trúc tài liệu

Đọc theo thứ tự:

1. [01-art-direction.md](./01-art-direction.md) — palette (kể cả 8 màu nhóm đất), typography, hình học, shadow, motion, âm thanh.
2. [02-screen-specs.md](./02-screen-specs.md) — spec từng màn: bố cục, kích thước, state.
3. [03-component-specs.md](./03-component-specs.md) — bàn cờ SVG, ô, quân, nhà, xúc xắc, pod người chơi, thẻ bài, sheet, nút, modal.
4. [04-asset-manifest-and-prompts.md](./04-asset-manifest-and-prompts.md) — manifest CSS/SVG/raster, số lượng từng loại asset, naming, prompt sinh raster.
5. [05-gameplay-rules-and-protocol.md](./05-gameplay-rules-and-protocol.md) — luật v1 đầy đủ, bảng 32 ô + giá + tiền thuê 3 cấp, 24 thẻ bài, state JSON, lệnh MOVE, steps replay, mapping interface engine, timeout, kết thúc ván.
6. [06-icon-system.md](./06-icon-system.md) — hệ icon: 4 họ icon, số lượng, grid, công thức hình học từng icon, quy trình tạo icon mới.
7. [07-screen-to-feature-map.md](./07-screen-to-feature-map.md) — mapping màn → store state → SDK event → component.
8. [08-fx-and-animation.md](./08-fx-and-animation.md) — kiến trúc 4 lớp (SVG / DOM / canvas Pixi hạt / overlay), ≈ 60 hiệu ứng theo sự kiện với bản Lite, API `FxLayer`, ngân sách hiệu năng, tier Full/Lite/Off.
9. [09-economy.md](./09-economy.md) — kinh tế bàn 32 ô: bảng giá 16 thành phố, 3 cấp nhà, công thức, dòng tiền, thời gian một ván, thời gian chờ khi chơi với người thật, kết quả mô phỏng và dải kiểm tra tự động.
10. [10-board-tiles.md](./10-board-tiles.md) — ghi chú nhanh 32 ô: loại ô, vị trí, giá, tiền thuê, ô nào mua / mua lại được, điều kiện thắng ngay theo ô.
11. [11-room-settings.md](./11-room-settings.md) — thiết lập bàn: cược KEN (mặc định 0) và cho người khác xem (mặc định tắt); hiển thị ở từng màn, thanh toán, protocol, việc server.
12. [style/](./style/README.md) — design system chi tiết: token CSS đầy đủ, bảng màu 32 ô, dàn 6 nhân vật, ma trận màu icon, button/control, kế hoạch triển khai UI theo giai đoạn. Khi khác tổng quan về UI thuần, `style/` được ưu tiên.
13. [screens/](./screens/README.md) — mỗi màn một folder gồm ảnh mẫu và style riêng: [S1 loading](./screens/s1-loading/README.md), [S2 lobby](./screens/s2-lobby/README.md), [S3 danh sách bàn](./screens/s3-room-list/README.md), [S6 bàn chơi](./screens/s6-board/README.md), [O5 modal](./screens/o5-modal/README.md).
14. [asset-generation-log.template.md](./asset-generation-log.template.md) — log cho mỗi asset raster sinh ra.
15. [asset-generation-log.md](./asset-generation-log.md) — nguồn, prompt và lựa chọn concept lobby S2.

## Nguyên tắc bắt buộc

- viewport logic `390 × 844 CSS px`, hỗ trợ width 360–520 px; bàn cờ vuông `min(100vw − 24, 480)`;
- CSS token và SVG code-native trước, raster chỉ cho quân cờ, nhân vật, nền lobby, logo;
- nhân vật (6 mascot, [style/03-characters.md](./style/03-characters.md)) chỉ ở 4 ô góc, sheet, thẻ, modal, lobby, kết quả — không bao giờ sau chữ, và luôn có fallback glyph khi tắt;
- border navy thống nhất 1.5–2 px, radius chỉ dùng scale 8/12/16/20/28/999;
- tên ô, số tiền, tiền thuê, tên người chơi, đồng hồ, số vòng luôn là live text — không bake chữ vào ảnh;
- ô bàn cờ hiện tên ngắn (trên) + tranh/glyph (giữa) + giá hoặc tiền thuê (dưới), dải màu nhóm ở mép trong (03 §2.1); bảng thuê, chủ sở hữu và nút mua/xây ở sheet S7;
- bố cục S6 theo concept UI v3 (02 §6): mọi nút hành động nằm ở cụm lượt giữa bàn, thông tin người chơi ở hàng pod dưới bàn, không có panel hay nút nào phía trên bàn ngoài header;
- mọi state có focus, disabled, loading, reduced-motion khi phù hợp;
- chữ đạt WCAG AA, touch target tối thiểu 44 × 44 px (ô bàn cờ 32 px dùng vùng chạm mở rộng);
- client không tự tính tiền, không tự quyết kết quả — mọi số đến từ `STATE`, mọi kết thúc ván đến từ `MATCH_OVER`;
- client không bao giờ thấy seed ngẫu nhiên hay thứ tự bộ thẻ (05 §7).

## Vị trí asset

```text
game/tycoon/assets/
  screens/lobby/    # 13 PNG tách từ concept S2 + manifest/prompt; script xuất WebP runtime
  app-icons/        # app icon: PNG bo góc 1024 px (convention thirteen); app-icon chính, app-icon-sub phụ
  tokens/           # tk-pawn.svg (UI v3); 8 quân webp 96 px cho v2 — xem 04 §3
  chars/            # 6 nhân vật × 4 pose × 2 crop webp — xem style/03-characters.md
  icons/            # ic-* SVG điều khiển (grid 24) — xem 06
  tiles/            # tg-* SVG glyph ô bàn cờ (grid 32) — xem 06 §3
  tiles/art/        # 19 tranh pixel 16-bit trong ô — xem 04 §6.5
  dice/             # 6 mặt xúc xắc SVG — xem 06 §6
  lobby/            # bg-board-pixel.webp, logo.webp; ill-*.webp/svg trang trí nút S2 (xuất khi code)
  fx/               # fx-result-*.webp nếu CSS không đủ
```

Reaction dùng lại `game/caro/assets/reactions/*.webp` qua import tương đối (như thirteen và xiangqi). Docs không thay đổi engine/SDK ngoài phần đã ghi rõ ở 05 §9.
