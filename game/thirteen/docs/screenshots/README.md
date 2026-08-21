# Tiến Lên UI screenshots

Thư mục này chứa toàn bộ ảnh tham chiếu đi kèm bộ docs. Tổng cộng **29 PNG**:

- 7 concept đã duyệt cho Style 02 — “Chiếu Bài Ngày Vui”;
- 22 screenshot chức năng đã được render lại từ source React Style 02 để đối chiếu state và hành vi hiện tại.

Concept quyết định ngôn ngữ hình ảnh. Screenshot chức năng quyết định dữ liệu, control và state bắt buộc. Không dùng bất kỳ ảnh toàn màn nào làm production background.

Các screenshot chức năng được chụp từ `mock-ui.html?screen=<tên>` tại viewport logic `390 × 844 CSS px`, DPR 2, nên file xuất có kích thước `780 × 1688 px`. Hai state modal `create-room` và `password-room` cũng có URL mock độc lập, không cần thao tác tay trước khi chụp.

## Concept Style 02

1. [Lobby](./concept-lobby-style-02-ngay-vui.png)
2. [Bàn chơi](./concept-table-style-02-ngay-vui.png)
3. [Phòng chờ](./concept-room-style-02-ngay-vui.png)
4. [Kết quả](./concept-result-style-02-ngay-vui.png)
5. [Tạo bàn](./concept-create-room-style-02-ngay-vui.png)
6. [Chat trong ván](./concept-table-chat-style-02-ngay-vui.png)
7. [Đang kết nối](./concept-loading-style-02-ngay-vui.png)

## Screenshot chức năng — kết nối, lobby và modal

- [Đang kết nối](./connecting.png)
- [Lobby mặc định](./lobby.png)
- [Lobby không có bàn](./lobby-empty.png)
- [Lobby đang ghép bàn](./lobby-queueing.png)
- [Tạo bàn](./create-room.png)
- [Nhập mật khẩu phòng](./password-room.png)
- [Xác nhận rời ván](./confirm-exit.png)
- [Thông báo](./notice.png)

## Screenshot chức năng — phòng chờ

- [Chủ bàn](./room-host.png)
- [Khách trong phòng](./room-guest.png)
- [Phòng hai người](./room-2p.png)

## Screenshot chức năng — bàn chơi

- [Bàn bốn người](./table.png)
- [Bàn ba người](./table-3p.png)
- [Bàn hai người](./table-2p.png)
- [Đang chia bài](./table-dealing.png)
- [Đã chọn bài](./table-selected.png)
- [Chat trong ván](./table-chat.png)
- [Hiệu ứng gameplay](./table-fx.png)
- [Mất kết nối](./table-disconnected.png)
- [Toast](./toast.png)

## Screenshot chức năng — kết quả

- [Kết quả thường](./result.png)
- [Tới trắng](./result-instant.png)
