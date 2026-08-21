# Cờ Tướng — screenshot UI

**37 PNG** chụp từ harness mock `xiangqi/mock-ui.html?screen=<tên>` ở viewport logic `390 × 844 CSS px`, DPR 2 → file `780 × 1688 px`. Không cần game server: harness ghi đè `init` của store rồi seed dữ liệu giả (`xiangqi/mock-ui.tsx`).

Chụp lại toàn bộ:

```bash
cd game
node scripts/xiangqi-shots.mjs            # tất cả
node scripts/xiangqi-shots.mjs --only board,board-check
```

Script tự bật vite dev (`:5175`) và Chrome headless. Đổi trình duyệt bằng `CHROME_PATH`.

## S1–S2 Kết nối & Lobby

- [Lobby](./lobby.png)
- [Đang kết nối](./lobby-connecting.png)
- [Lỗi kết nối](./lobby-error.png)

## S3–S4 Danh sách bàn & modal

- [Danh sách bàn](./rooms.png)
- [Chưa có bàn nào](./rooms-empty.png)
- [Modal Tạo bàn](./rooms-create.png)
- [Modal Vào bàn khóa](./rooms-password.png)
- [Toast không đủ Ken](./toast.png)

## S5 Phòng chờ

- [Chủ bàn, chờ khách](./pregame-alone.png)
- [Khách đã sẵn sàng — chủ bàn bấm Bắt đầu được](./pregame-ready.png)
- [Góc nhìn khách](./pregame-guest.png)

## S6 Bàn chơi

- [Lượt của bạn](./board.png)
- [Lượt đối thủ](./board-opp-turn.png)
- [Đã chọn quân + gợi ý nước + gợi ý ăn quân](./board-selected.png)
- [Đang gửi nước (`movePending`)](./board-move-pending.png)
- [Chiếu tướng](./board-check.png)
- [Đồng hồ nguy hiểm (≤10 s)](./board-urgent.png)
- [Hết giờ — bàn bị khóa](./board-expired.png)
- [Đối thủ mất kết nối](./board-oppaway.png)
- [Turn announce](./board-announce.png)
- [Chat trong ván](./board-chat.png)
- [Chat bị server từ chối, draft được trả lại](./board-chat-restore.png)
- [Reaction bay](./board-reactions.png)
- [Toast lỗi nước đi](./board-toast.png)

## O2 Confirm

- [Xác nhận Bỏ cuộc](./confirm-forfeit.png)
- [Xác nhận Thoát bàn](./confirm-exit.png)

## S7 Kết quả

- [Thắng (+950 sau hoa hồng 5%)](./result-win.png)
- [Thua](./result-lose.png)
- [Hòa — hoàn cược](./result-draw.png)
- [Ván giao hữu](./result-friendly.png)

## S8 Lịch sử

- [Danh sách](./history.png)
- [Chưa có ván nào](./history-empty.png)
- [Đang tải](./history-loading.png)

## S9 Bảng xếp hạng

- [Hôm nay](./leaderboard.png)
- [Tuần này](./leaderboard-week.png)
- [Chưa có dữ liệu](./leaderboard-empty.png)
- [Đang tải](./leaderboard-loading.png)
