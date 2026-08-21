# Cờ Tướng — screenshot UI

Thư mục này chứa hướng dẫn tạo **37 screenshot** từ harness mock `xiangqi/mock-ui.html?screen=<tên>`. Các PNG được sinh ở ngay thư mục này chỉ là output cục bộ, không phải runtime asset và không được lưu trong Git.

Viewport logic là `390 × 844 CSS px`, DPR 2, nên mỗi file có kích thước `780 × 1688 px`. Harness ghi đè `init` của store rồi seed dữ liệu giả từ `xiangqi/mock-ui.tsx`; không cần game server.

Chụp lại toàn bộ hoặc một nhóm state:

```bash
cd game
node scripts/xiangqi-shots.mjs
node scripts/xiangqi-shots.mjs --only board,board-check
```

Script tự bật Vite dev ở cổng `5175` và Chrome headless. Có thể đổi trình duyệt bằng biến môi trường `CHROME_PATH`.

## Coverage

- Kết nối và lobby: `lobby`, `lobby-connecting`, `lobby-error`.
- Danh sách bàn và modal: `rooms`, `rooms-empty`, `rooms-create`, `rooms-password`, `toast`.
- Phòng chờ: `pregame-alone`, `pregame-ready`, `pregame-guest`.
- Bàn chơi: `board`, `board-opp-turn`, `board-selected`, `board-move-pending`, `board-check`, `board-urgent`, `board-expired`, `board-oppaway`, `board-announce`, `board-chat`, `board-chat-restore`, `board-reactions`, `board-toast`.
- Xác nhận: `confirm-forfeit`, `confirm-exit`.
- Kết quả: `result-win`, `result-lose`, `result-draw`, `result-friendly`.
- Lịch sử: `history`, `history-empty`, `history-loading`.
- Bảng xếp hạng: `leaderboard`, `leaderboard-week`, `leaderboard-empty`, `leaderboard-loading`.

Ba mockup định hướng mỹ thuật trong [`style-concepts/`](./style-concepts/README.md) là tài liệu được theo dõi riêng và không bị script ghi đè.
