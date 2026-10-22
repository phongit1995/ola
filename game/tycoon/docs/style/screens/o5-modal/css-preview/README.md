# O5 — Bản dựng CSS để so với ảnh mẫu

[Mở trang so sánh](./index.html) · [CSS modal](./modal.css) · [CSS trang](./style.css) · [Đối chiếu viền/chữ](./fidelity-audit.md) · [Hành vi preview](./preview.mjs) · [Đặc tả O5](../README.md)

Tạo ngày **22/10/2026**, theo yêu cầu dựng trực tiếp bằng CSS để xem có giống bốn ảnh example hay không. Đây là preview mỹ thuật trong docs; chưa import vào game.

## Cách xem

1. Chọn Xác nhận / Bỏ cuộc / Thông báo / Kết nối.
2. Dùng **Cạnh nhau** để xem ảnh gốc và bản dựng trên cùng tỷ lệ.
3. Dùng **Chồng ảnh**, kéo độ rõ 0–100% để đối chiếu đường viền, vị trí và khoảng cách. Trên điện thoại mặc định chỉ hiện CSS, có thể chuyển sang ảnh mẫu hoặc chồng ảnh.
4. Bấm thử nút hoặc dùng Tab. Nút chính mô phỏng pending 1,2 giây; không gửi hành động vào game. Nút phụ giữ hộp để tiếp tục so sánh.

## Phần nào là CSS

- Khung paper, viền, bóng đổ, nền tối, badge, highlight, thân nút, icon check/warning/info/wifi-off và spinner đều dựng bằng CSS/HTML.
- Chữ là DOM với Nunito local; không bake chữ vào bitmap. Không có `<svg>` hoặc `<img>` bên trong modal.
- Nền lobby dùng [concept S2](../../s2-lobby/concept-s2-lobby-pixel-16bit.png) làm phông tham chiếu để so đúng cùng bố cục. Ảnh cột trái và lớp chồng dùng bốn WebP example. Đây là ảnh tham khảo trong docs, không phải asset cần thêm vào runtime.
- [button.css](../svg/button.css) cung cấp state chung, `:focus-visible`, pending và reduced motion. [modal.css](./modal.css) tinh chỉnh tỷ lệ, viền, cạnh nổi, chữ và độ bóng theo ảnh mẫu. Spinner trong trang này dùng border CSS, không dùng SVG mask.

## Độ giống và phạm vi

Bốn ảnh AI có kích thước/card/font khác nhau, nên preview này canh silhouette riêng theo từng mẫu trên artboard 390px. Chiều rộng modal lần lượt 322/316/302/320px; không tự thay mốc 340px trong đặc tả O5. Badge và chữ cũng được canh theo ảnh để người dùng duyệt hình thức. Khung có cùng tâm gần ảnh mẫu; màu paper, outline navy, nút vàng/kem/đỏ và bố cục một/hai nút đã được đối chiếu trực tiếp.

**Cập nhật sau phản hồi về độ giống:** bản trước sai rõ ở viền/cạnh nổi, độ rộng chữ và sắc đỏ; đã sửa và ghi [số đo trước/sau, cách đo, phần còn lệch](./fidelity-audit.md). Nút đỏ trong preview nay theo ảnh mẫu; không đổi token nút đỏ production. Khớp kích thước không đồng nghĩa khớp kiểu chữ: Nunito vẫn khác dáng glyph AI, icon và chuyển bóng còn khác khi phóng lớn. Lớp tối dùng `rgba(4,16,36,.7)`, không thay token overlay production. Chưa đánh dấu đạt duyệt mỹ thuật.

`ResizeObserver` chỉ scale **toàn bộ artboard tham chiếu** để nằm vừa cột so sánh. Nút không dùng SVG hoặc JS để dựng lại hình theo kích thước. Màn hẹp thu nhỏ artboard; đây không phải chứng nhận responsive/vùng chạm của modal production.

## Đã kiểm

- Mở và đối chiếu cả bốn ảnh chụp desktop; canh lại chiều cao, padding, khoảng cách, badge và lớp tối.
- Kiểm 4 case tại 360/390/520px: không tràn ngang/cắt nhãn; chế độ ảnh/CSS/chồng ảnh hoạt động.
- Kiểm nút chính pending, khóa nút phụ rồi phục hồi; focus và hover dùng CSS chung.
- Kiểm modal không có SVG/image và không có JavaScript exception trong lượt kiểm.
- Ảnh chụp và số đo chỉ chạy local, không lưu trong repo. Chưa tích hợp vào game.
