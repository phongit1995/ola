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

Phía server:
- phòng chờ lưu `lastWinnerId` (trong JSON phòng ở Redis, không cần migration):
  - gán khi hết ván (`prepareNextRound`);
  - xóa khi ván không có người thắng, hoặc khi người đó rời bàn (`removeRoomGuest`);
- lúc bắt đầu ván, nếu người đó có trong danh sách ghế và game cài `logic.LeaderInit`, engine gọi `InitPlayersLed(seed, n, ghế)` thay cho `InitPlayers`;
- Tiến Lên dùng `newLedDeal`: chia bài y như `newDeal`, rồi đặt người đi trước, `require3s = false`, `ledByWinner = true`;
- view gửi client có thêm `ledByWinner`;
- Caro / War God / Cờ tướng không cài `LeaderInit` nên không đổi.

## 5. Chat và kết quả

Chat dùng bottom sheet cream, backdrop navy 30%, drag handle, close button, reaction row scroll ngang, log live và input/send state rõ ràng.

Result dùng modal cream radius 24, title live với coral underline, row semantic cho hạng nhất/người hiện tại/hạng cuối và action sticky. “Rời bàn” rời room thật phía server và xóa room local; “Chơi tiếp” quay lại waiting room đã reset cho ván mới.

## 6. QA

Đã kiểm tra mock state ở 360 × 800, 390 × 844 và 520 × 932 qua Chrome device metrics. Các state chính:

- room host/guest/2-player;
- table 2/3/4-player, selected, chat, FX và disconnect;
- result normal và instant win.

Lệnh kiểm tra:

```bash
pnpm -C game typecheck
pnpm -C game test
pnpm -C game build
cd server && go test ./internal/game/games/thirteen ./internal/game/engine
```
