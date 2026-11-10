# 08 — Triển khai phòng chờ, bàn chơi và kết quả

## 1. Phạm vi

Các state production còn lại đã được chuyển sang Style 02 — Chiếu Bài Ngày Vui:

- phòng chờ 2–4 người, góc nhìn chủ bàn và khách;
- bàn chơi 2–4 người, chọn bài, bỏ lượt, chia bài, finish/reaction/disconnect;
- chat bottom sheet trong ván;
- toast, xác nhận rời ván và notice;
- kết quả thường, tới trắng, disconnect và forfeit.

Markup tiếp tục dùng dữ liệu live từ Zustand/socket. Mặt bài, lưng bài và reaction tái sử dụng asset hiện có; surface, curve, viền, shadow và state đều là CSS responsive.

## 2. Asset hoàn thiện

Các asset code-native bổ sung đúng manifest:

| File | Màn dùng |
|---|---|
| `icons/ic-chat.svg` | mở chat ở bàn chơi |
| `icons/ic-close.svg` | đóng chat sheet |
| `icons/ic-send.svg` | hành động gửi |
| `icons/ic-user-minus.svg` | mời thành viên khỏi bàn |
| `icons/ic-crown.svg` | chủ bàn |
| `icons/ic-wifi-off.svg` | mất kết nối |
| `icons/ic-plus.svg` | ghế trống |
| `icons/ic-warning.svg` | warning dùng chung |
| `fx/fx-chop-rays.svg` | hiệu ứng chặt |

Không có raster UI mới và không có text nằm trong asset.

## 3. Phòng chờ

- cream topbar + curve coral/cream/navy;
- grid hai cột, occupied seat cream, empty seat aqua/dashed;
- avatar tone ổn định theo user ID;
- crown, kick và ready dùng SVG/state semantic;
- chat panel cream tự cuộn xuống tin mới;
- action bar giữ touch target tối thiểu 48 px;
- phòng hai người không render hàng ghế rỗng thứ hai.

## 4. Bàn chơi

- topbar cream, chiếu aqua và curve ở hai đầu;
- opponent pod không có panel lớn;
- turn ring đổi sang coral khi còn tối đa 5 giây;
- trick center chứa được combo dài trong vùng 236 px bằng overlap động;
- card fan dùng góc tối đa ±6°, card width responsive 52–68 px;
- selected card có outline sun và accessible label theo rank/suit;
- local pass giữ badge tới khi trick được clear;
- disconnect là pill cục bộ, không phủ tối toàn bàn;
- reduced motion tắt animation deal/chop/reaction/banner.

**Ai đi trước:**
- Ván đầu tiên của bàn theo luật 3♠: ai giữ 3♠ đi trước và nước đầu phải có 3♠; không ai giữ 3♠ (bàn 2–3 người) thì người có lá nhỏ nhất đi trước, ra tự do.
- Từ ván thứ hai, người về Nhất ván trước đi trước và **ra bài tự do**, không cần 3♠. Có người khác vào hoặc rời bàn cũng vậy, miễn người thắng còn ngồi ở bàn.
- Quay về luật 3♠ khi:
  - người thắng đã rời bàn;
  - ván trước hòa hoặc bị hủy (không có người thắng).
- Thông báo lượt ghi thêm “· thắng ván trước” cho tới khi lá đầu tiên được đánh, ví dụ “Tới lượt bạn ra bài · thắng ván trước”.
  - Store chỉ bật nhãn (`openingLead`) khi `ledByWinner`, `moveCount = 0` và lượt hiện tại đúng là ghế `starter`.
  - Người thắng rời ván trước khi đánh thì lượt chuyển sang người kế, nhưng server vẫn giữ `ledByWinner`. Nhờ điều kiện trên, người kế không bị gắn nhãn.
- Tới trắng vẫn xét theo thứ tự bắt đầu từ người đi trước.

**Chiều đánh và chỗ ngồi:**
- Lượt đi theo ghế `+1`. Client đặt ghế ngược chiều kim đồng hồ quanh bàn (`helpers/seats.ts`): mình ngồi dưới, người đánh sau mình ngồi bên phải, rồi trên, rồi trái.
- Bàn chơi theo phòng giữ nguyên ghế giữa các ván. Thứ tự ghế lưu ở `seatOrder` trong JSON phòng, chỉ dùng cho game cài `logic.SeatKeeper` (hiện chỉ Tiến Lên); Caro / War God / Cờ tướng vẫn xáo ghế mỗi ván.
  - Ván đầu của phòng xáo ghế ngẫu nhiên.
  - Ai rời bàn thì bỏ ghế đó, người mới ngồi sau những người đã có ghế.

**Cóng:**
- Khi người đầu tiên hết bài, ai chưa đánh lá nào (còn đủ 13 lá) bị cóng: khóa, không được đánh tiếp, xếp chót theo thứ tự lượt tính từ người về Nhất. Những người còn lại đánh tiếp để phân hạng.
- State và view có `cong` (danh sách ghế), bước `cong` báo cho client hiện banner “… bị cóng!” và nhãn “Cóng” ở ghế. Bài người bị cóng không lật lúc đó, chỉ lật khi hạ bài lúc hết ván.
- Không phạt thêm cược: cược chỉ trả cho người về Nhất.
- Chế độ tập luyện (`logic/engine.ts`) chạy cùng luật.

**Hết ván:**
- Nước kết thúc ván không có `state` riêng: server chỉ gửi `matchOver` với state đầy đủ (`hands`, `table`, `finishOrder`, `cong`, `steps`). Client khóa thao tác ngay (`turn = -1`, `animating`), phát lại `steps` nếu `moveCount` mới hơn state đã áp (chế độ tập luyện đã gửi `state` trước nên không phát lại), rồi áp snapshot cuối: bài trên tay, bài giữa bàn, số lá, hạng, cóng.
- Sau đó chờ 600 ms rồi hạ bài: lật bài còn lại của từng người ngay tại ghế trong 2,8 s, xong mới mở kết quả. Chế độ tập luyện gửi kèm `hands` trong `matchOver`.
- Dữ liệu lật bài và cóng (`revealHands`, `cong`, `congFx`) được xóa khi bắt đầu ván, vào xem bàn khác, đóng kết quả hoặc rời bàn.
- Màn kết quả ghi thêm “· Cóng” cạnh hạng của người bị cóng.

Phía server:
- phòng chờ lưu `lastWinnerId` (trong JSON phòng ở Redis, không cần migration):
  - gán khi hết ván (`prepareNextRound`);
  - xóa khi ván không có người thắng, hoặc khi người đó rời bàn (`removeRoomGuest`);
- lúc bắt đầu ván, nếu người đó có trong danh sách ghế và game cài `logic.LeaderInit`, engine gọi `InitPlayersLed(seed, n, ghế)` thay cho `InitPlayers`;
- Tiến Lên dùng `newLedDeal`: chia bài y như `newDeal`, rồi đặt người đi trước, `require3s = false`, `ledByWinner = true`;
- view gửi client có thêm `ledByWinner`;
- Caro / War God / Cờ tướng không cài `LeaderInit` nên không đổi.

## 5. Xem bàn đang chơi

Ở sảnh, bàn công khai đang chơi có nút “Xem” (xem 07 § 6.4). Người xem thấy đúng những gì người chơi thấy trên bàn, trừ bài trên tay.

Giao diện người xem:
- topbar ghi “Đang xem” kèm icon mắt; nút back rời xem ngay, không hỏi xác nhận vì người xem không bị xử thua;
- ghế 0 ngồi ở giữa phía dưới bàn (`.tl-seat-slot.bottom`, lưới `.tl-felt.watching` thêm hàng `bottom`), vẽ y như ghế đối diện: avatar, badge số lá, tên, hạng/bỏ lượt/mất kết nối. Không vẽ bài úp;
- thanh dưới thay cho “Bỏ lượt / Đánh”: ghi chú “Bạn đang xem ván này” và nút “Rời xem”;
- chat chỉ đọc: vẫn thấy tin nhắn và cảm xúc của người chơi, không có hàng cảm xúc, câu nhanh và ô nhập;
- hết ván: không mở modal kết quả. Chờ bước đánh cuối phát xong (600 ms) và hạ bài (2,8 s) như người chơi, rồi chuyển sang bàn chờ của chính bàn đó (xem dưới). Nếu bàn đã giải tán thì về sảnh kèm toast “Ván đấu bạn đang xem đã kết thúc.”;
- mất kết nối rồi có lại thì tự gửi lại yêu cầu xem; ván đã xong thì về sảnh kèm thông báo.

Bàn chờ của người xem (giữa hai ván):
- cùng lưới ghế với bàn chờ của người chơi (chủ bàn, đã/chưa sẵn sàng, ghế trống) nhưng không có nút mời ra; tiêu đề “Đang xem bàn chờ” kèm icon mắt;
- thẻ trạng thái: “Đang chờ N người sẵn sàng” hoặc “Chờ chủ bàn bắt đầu ván mới”, dòng phụ “Ván mới bắt đầu bạn sẽ được xem tiếp”;
- chat của bàn chỉ đọc (không có ô nhập);
- nút “Rời xem” về sảnh; còn ghế trống thì có “Vào chơi” (gửi `ROOM_JOIN`, vào được thì thành người chơi của bàn), đủ người thì nút xám “Bàn đã đủ người”;
- chủ bàn bắt đầu ván mới: sảnh nhận `ROOM_UPSERT` bàn `playing` kèm `matchId` mới, client tự gửi `SPECTATE_JOIN` và quay lại màn bàn đang xem;
- bàn giải tán (`ROOM_CLOSED` hoặc `ROOM_REMOVED`) khi đang ở bàn chờ: về sảnh kèm toast “Bàn bạn đang xem đã giải tán.”. Nếu giải tán khi đang xem ván thì xem nốt ván rồi về sảnh.

Danh sách người xem (cả người chơi lẫn người xem đều thấy):
- khi bàn có ít nhất 1 người xem, góc phải trên của bàn có tab `.tl-viewers-tab` dính mép phải: icon mắt + số người xem;
- bấm tab thì cả khối trượt sang trái 180 px, lộ panel “Người đang xem” (avatar nhỏ + tên, chính mình ghi “Bạn”; dài quá thì cuộn). Bấm tab lần nữa thì trượt về;
- panel đóng được ẩn hẳn (`visibility: hidden` sau 260 ms, `inert`) để không lộ bóng ở mép màn và không nhận focus;
- số người xem tính theo tài khoản: một người mở 2 tab chỉ hiện 1 lần.

Phía server:
- game giấu thông tin chỉ được xem khi cài `logic.SpectatorViewer`. Tiến Lên trả `PlayerView` với `you = -1` (`SpectatorSeat`, sinh sang client thành `SPECTATOR_SEAT`) và `yourHand` rỗng;
- mọi thứ gửi cho người xem đều đi qua view này: `SPECTATE_JOINED`, kể cả khi đọc lại snapshot từ Redis, và từng `STATE`;
- bàn có mật khẩu bị từ chối với `SPECTATE_NOT_ALLOWED` và không có trong `SPECTATE_LIST`;
- người xem không gửi được nước đi hay chat. Tối đa 20 chỗ xem mỗi trận (`MaxSpectators`), mỗi socket một chỗ;
- người xem lưu trong hash Redis `GAME:<g>:MATCH:<id>:VIEWERS` (socket → tên, VIP, cấp, lúc vào). Mỗi lần có người vào/ra, server gửi `SPECTATORS { matchId, spectators }` cho từng người chơi và cho phòng xem của trận; người chơi kết nối lại nhận danh sách ngay sau `MATCH_FOUND`. Trận đã xong thì không gửi nữa;
- Cờ Tỷ Phú vẫn giấu thông tin mà chưa có view cho người xem nên vẫn không xem được;
- bàn Tiến Lên đang chơi nằm trong danh sách bàn ở sảnh (`listsPlayingRooms`, giống War God) với `status: playing` và `matchId`; trước đây bàn bị gỡ khỏi sảnh lúc bắt đầu nên nút “Xem” không bao giờ hiện;
- theo dõi bàn: `ROOM_WATCH { roomId }` / `ROOM_UNWATCH`. Socket vào kênh `game:<g>:roomwatch:<roomId>`, nhận `ROOM_STATE` có `watcher: true` và `youId` rỗng mỗi khi bàn chờ đổi (kể cả ngay sau ván, có `afterMatchId`), chat của bàn và `ROOM_CLOSED`. Bàn có mật khẩu, bàn mình là thành viên hoặc bàn không còn thì server trả `ROOM_CLOSED { reason: "unavailable" }` cho riêng socket đó. Client gửi `ROOM_WATCH` cùng lúc với `SPECTATE_JOIN` khi bấm “Xem”, và gửi lại khi kết nối lại.

## 6. Chat và kết quả

Chat dùng bottom sheet cream, backdrop navy 30%, drag handle, close button, reaction row scroll ngang, log live và input/send state rõ ràng.

Result dùng modal cream radius 24, title live với coral underline, row semantic cho hạng nhất/người hiện tại/hạng cuối và action sticky. “Rời bàn” rời room thật phía server và xóa room local; “Chơi tiếp” quay lại waiting room đã reset cho ván mới.

## 7. QA

Đã kiểm tra mock state ở 360 × 800, 390 × 844 và 520 × 932 qua Chrome device metrics. Các state chính:

- room host/guest/2-player;
- table 2/3/4-player, selected, chat, FX và disconnect;
- result normal và instant win;
- chế độ xem: `watch`, `watch-3p`, `watch-2p`, `watch-finished`, `watch-chat`, `watch-viewers-open`, `watch-room` (bàn chờ còn ghế), `watch-room-full`, `watch-ended` (về sảnh kèm toast); sảnh mock có một bàn đang chơi xem được và một bàn có mật khẩu;
- danh sách người xem ở bàn người chơi: `table-viewers`, `table-viewers-open`, `table-viewers-2p`.

Lệnh kiểm tra:

```bash
pnpm -C game typecheck
pnpm -C game test
pnpm -C game build
cd server && go test ./internal/game/games/thirteen ./internal/game/engine
```
