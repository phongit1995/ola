# Ảnh mẫu UI — Cờ Tỷ Phú

![Ảnh mẫu bàn chơi](./concept-board-pixel-16bit.png)

[`concept-board-pixel-16bit.png`](./concept-board-pixel-16bit.png) là **ảnh mẫu duy nhất** cho giao diện bàn chơi, phong cách **pixel 16-bit**, chốt ngày 20/10/2026. Ảnh được tạo bằng AI (built-in imagegen) để tham khảo. Đây không phải asset của game: code không import ảnh này, và không được cắt ảnh này ra để dùng trong game.

## Lấy gì từ ảnh mẫu

- **Phong cách:** cảnh địa danh Việt Nam vẽ pixel 16-bit nhiều lớp, nền trời sáng, nét viền navy, nút chính màu vàng, chữ hiện đại và sắc nét.
- **Bố cục:** bàn vuông nhìn thẳng từ trên xuống, gồm 32 ô (4 góc và 7 ô giữa hai góc trên mỗi cạnh). Cụm lượt (đồng hồ, xúc xắc, nút "Gieo xúc xắc") nằm giữa bàn. Bốn thẻ người chơi xếp một hàng dưới bàn. Footer là thanh tiện ích.
- **Quân cờ:** 4 màu là vàng, xanh, san hô, tím; mỗi người chơi đúng một quân.

## Không lấy từ ảnh mẫu

- Tên ô, thứ tự, giá, tiền thuê, màu nhóm, chủ sở hữu và trạng thái luôn lấy từ [`logic/board.json`](../../logic/board.json) và dữ liệu ván chơi. Chữ dựng bằng DOM, không cắt từ ảnh.
- Tiền trên các thẻ người chơi trong ảnh chỉ là số minh họa giữa ván.

## Chỗ ảnh chưa đúng — khi dựng UI phải sửa

- Bàn trong ảnh hơi cao hơn rộng. Khi dựng phải khóa tỷ lệ **1:1**.
- Một số dải màu nhóm bị lặp ở mép ngoài. Dải màu nhóm **chỉ nằm ở mép trong** và chỉ có trên ô thành phố.
- Dòng sự kiện xuất hiện ở cả vùng log lẫn footer. Chỉ dùng **một vùng log** theo đặc tả.

Ảnh mẫu chỉ có pha gieo xúc xắc. Các pha mua, mua lại, lễ hội, du lịch, quản lý và nợ dùng chung bố cục này; nội dung giữa bàn theo [đặc tả màn hình](../02-screen-specs.md).

## Tài liệu liên quan

- [Đặc tả màn hình](../02-screen-specs.md)
- [Luật chơi](../05-gameplay-rules-and-protocol.md)
- [Danh sách ô](../10-board-tiles.md)
- [Hệ style](../style/README.md)
