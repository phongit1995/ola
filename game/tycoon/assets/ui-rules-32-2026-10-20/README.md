# Cờ Tỷ Phú — 3 hướng UI theo luật 32 ô

## Bản cập nhật sau khi chốt style 02

Người dùng đã chọn **pixel 16-bit**. Bản vẽ cập nhật theo docs và dữ liệu bàn mới:

- [02-pixel-16bit-v2.png](./02-pixel-16bit-v2.png) — ảnh cuối, tạo bằng built-in imagegen.
- [Prompt gốc và lần tinh chỉnh](./02-pixel-16bit-v2-prompt.md).
- [Dữ liệu bàn dùng đối chiếu](./02-pixel-16bit-v2-board.json).

Đã xem ảnh và kiểm tra toàn bộ thứ tự 32 ô, tên và giá: 4 sân bay mang tên chung **Sân bay**, giá 200 tr, tại **6, 10, 22, 26**; Cơ hội tại **4, 18, 20, 29**; Khí vận tại **2, 14, 28**; Thuế −10% tại **12**. Thành phố và bốn góc giữ nguyên. Ảnh có đúng 4 quân vàng/xanh/san hô/tím, 4 thẻ người chơi cùng một hàng dưới bàn, cụm gieo ở giữa, phong cảnh pixel 16-bit theo mẫu đã chọn. File lưu đã được đối chiếu SHA-256 với đầu ra đã xem.

Giới hạn của concept: bàn trong ảnh vẫn hơi cao hơn rộng dù đã yêu cầu chỉnh vuông; một số dải nhóm còn lặp ở mép ngoài; dòng sự kiện còn xuất hiện ở cả log và footer. Khi dựng UI cần khóa bàn 1:1, giữ dải nhóm ở mép trong và chỉ dùng một vùng log theo đặc tả. Phần cập nhật vị trí ô đã đúng dữ liệu mới. Bản `02-pixel-16bit-v2-draft.png` lưu lần dựng trước khi tinh chỉnh.

---

Ngày: 20/10/2026. Concept tạo bằng **built-in imagegen**, tham chiếu trực tiếp ảnh trong `assets`. Prompt đầy đủ cho từng ảnh: [PROMPTS.md](./PROMPTS.md).

## Ba phương án

| Phương án | Hướng mỹ thuật | Điểm khác biệt |
|---|---|---|
| [01 — Minh họa 2D](./01-minh-hoa-2d.png) | Nền kem, nét navy, điểm nhấn vàng | Phong cảnh Việt Nam dạng hoạt hình, dễ đọc và gần hệ style hiện tại |
| [02 — Pixel 16-bit](./02-pixel-16bit.png) | Phong cảnh pixel nhiều lớp, nền trời sáng | Địa danh có bầu trời, cảnh gần và xa, cảm giác game retro |
| [03 — Pixel isometric](./03-pixel-isometric.png) | Tiểu cảnh pixel trên đế đất hình thoi | Mỗi địa danh là một mô hình nhỏ, nhiều khoảng trống quanh hình |

Bố cục yêu cầu chung: bàn vuông nhìn từ trên xuống; 4 thẻ người chơi cùng một hàng dưới bàn; cụm lượt, đồng hồ, xúc xắc và nút chính ở giữa bàn. Cả ba minh họa pha gieo để so sánh phong cách trên cùng trạng thái.

## Nguồn luật đã đối chiếu

- [Luật chơi cập nhật](../../docs/05-gameplay-rules-and-protocol.md).
- [Danh sách ô](../../docs/10-board-tiles.md).
- [Dữ liệu bàn](../../logic/board.json) và [hằng số](../../logic/constants.ts).
- [Đặc tả màn hình](../../docs/02-screen-specs.md) và [hệ style](../../docs/style/README.md).

Ưu tiên dữ liệu bàn và luật ngày 20/10/2026 khi ảnh cũ hoặc đoạn tài liệu cũ khác nhau. Ví dụ sơ đồ ASCII trong screen specs còn nhãn góc cũ; bảng vị trí ở mục 6.2 và dữ liệu bàn đã có Lễ hội, Du lịch.

## Những thay đổi đưa vào thiết kế

- **32 ô:** lưới chu vi 9 × 9, 4 góc và 7 ô giữa hai góc mỗi cạnh.
- **Hướng đi:** từ Xuất phát ở dưới-trái đi lên; Nhà tù trên-trái; Lễ hội trên-phải; Du lịch dưới-phải.
- **16 thành phố:** 8 nhóm, mỗi nhóm 2 thành phố; 4 sân bay; 4 Cơ hội; 3 Khí vận; 1 Thuế.
- **Xuất phát +160 tr**, vốn ban đầu 1.500 tr; giới hạn 30 vòng hoặc 25 phút; 30 giây mỗi lượt. Tiền trên thẻ người chơi trong concept là số dư minh họa giữa ván.
- **Lễ hội:** chọn một thành phố của mình để tiền thuê ×2; toàn bàn chỉ có một ô đang tổ chức.
- **Du lịch:** lượt kế tiếp được chọn ô để bay tới, hoặc bỏ quyền bay và gieo bình thường.
- **Thuế:** 10% tổng tài sản, không phải phí cố định.
- **Thắng ngay:** trọn 3 nhóm màu, toàn bộ 4 thành phố trên một cạnh, hoặc cả 4 sân bay.

## Cách các pha khác dùng chung UI

Các trạng thái dưới đây là hướng triển khai từ luật, không phải màn hình đã được vẽ thêm:

| Pha | Nội dung ở giữa bàn | Hành động |
|---|---|---|
| Mua | Tên thành phố, giá, tiền thuê, tiền còn lại | Bỏ qua / Mua |
| Mua lại | Giá bằng 2 × (giá đất + chi phí các cấp đã xây), trả cho chủ cũ | Bỏ qua / Mua lại; sân bay và Khách sạn không có hành động này |
| Lễ hội | Hướng dẫn chọn thành phố đang sở hữu; xem trước thuê ×2 | Bỏ qua / Tổ chức |
| Du lịch | Hướng dẫn chọn ô khác ô đang đứng; xem trước điểm đến | Gieo bình thường / Bay tới đây |
| Quản lý | Tài sản và cấp nhà hiện tại | Nâng cấp / Kết thúc lượt |
| Nợ | Số tiền thiếu và các nhà có thể hạ cấp | Hạ cấp / Trả nợ / Phá sản |

Nhà → Biệt thự → Khách sạn, tối đa 3 cấp; chỉ nâng khi trọn nhóm và phải nâng đều. Không hiển thị tất cả nút của các pha cùng lúc.

## Phạm vi

Đây là ảnh tham khảo mỹ thuật, không phải màn hình game đã triển khai. Khi dựng UI, tên ô, thứ tự, giá, màu nhóm, tiền thuê, chủ sở hữu và trạng thái phải lấy từ dữ liệu game; chữ dùng DOM/canvas text thay vì cắt từ ảnh concept.

## Kiểm tra hình ảnh

- Cả 3 bản đã được xem trực tiếp: đủ 4 góc + 7 ô giữa mỗi cặp góc, đúng thứ tự thành phố và sân bay; có Lễ hội, Du lịch, Thuế −10%, Xuất phát +160 tr, vòng 7/30 và 4 thẻ người chơi dưới bàn.
- Bản 01 dùng minh họa 2D nhiều chi tiết; bản 02 dùng cảnh pixel với đường biên bậc thang và cụm màu vuông rõ hơn.
- Bản 03 thể hiện địa danh bằng tiểu cảnh pixel trên đế hình thoi, có khoảng trống quanh từng hình; hợp hướng asset mô-đun nhỏ, dễ tách thành các ô riêng.
- Tỷ lệ bàn trong ảnh vẫn cao hơn vuông một chút theo ảnh tham chiếu. Khi triển khai phải khóa tỷ lệ 1:1 theo đặc tả.
- Dải màu nhóm chưa hoàn toàn chuẩn; có màu trang trí trên một số ô sân bay/thẻ. Bản 02 còn dư một quân màu gần vàng/cam. Khi triển khai chỉ đặt dải nhóm trên thành phố và sinh đúng một quân cho mỗi người chơi.
