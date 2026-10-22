# S3/S4 — đối chiếu icon với ảnh đã chốt

**Kết luận: chưa đủ asset đúng hình thức của ảnh đã chốt.** Lần kiểm trước xác nhận 33 file SVG/import có tồn tại và typecheck qua; những bằng chứng đó không chứng minh icon giống mẫu. Đặc biệt, chưa có artwork ổ khóa vàng của hàng bàn; `ic-lock.svg` hiện tại cũng không phải khóa navy đặc trong modal.

[Spec và 6 ảnh đã chốt](./README.md#8-modal-trên-danh-sách-bàn-s4-o5)

Kiểm ngày **22/10/2026**: mở trực tiếp concept S3 và cả 6 WebP; đọc hình học 12 SVG liên quan, wrapper `TyIcon` và CSS mask; xem đồng KEN, nền, VIP 003 và ba asset khóa của Caro/War God. Không sinh ảnh hoặc chỉnh các ảnh đã duyệt, không tạo file crop/raster mới.

## 1. Những phần thiếu hoặc khác mẫu

| Chi tiết | Nguồn đã chốt | File hiện tại | Chênh lệch và việc còn thiếu |
|---|---|---|---|
| Khóa ở hàng bàn | S3, hàng @linh/@tuan | [ic-lock.svg](../../../assets/icons/ic-lock.svg) | **Chưa có bản đúng mẫu:** ảnh là thân vàng/cam, quai sáng, viền đậm, lỗ khóa và cạnh nổi; file chỉ là outline một màu. Cần asset riêng hoặc vector đủ lớp theo hình này. |
| Khóa ở header modal | 03/04 | cùng `ic-lock.svg` | Ảnh là **thân navy đặc, lỗ khóa khoét**, nằm trong badge vàng. SVG có thân rỗng và nét dọc thay lỗ khóa. Phải phân biệt glyph này với khóa vàng ở hàng bàn; badge vẫn là CSS. |
| Reload | header S3 | [ic-refresh.svg](../../../assets/icons/ic-refresh.svg) | Ảnh có hai cung/hai đầu mũi tên xanh, contour và highlight. SVG chỉ có một đầu mũi tên, một cung đơn sắc. Đổi màu CSS không bổ sung hình học còn thiếu. |
| Back | header S3 | [ic-arrow-left.svg](../../../assets/icons/ic-arrow-left.svg) | **Mapping khác hình:** ảnh là chevron đậm không cán ngang; file có cán. `ic-chevron-left` gần cấu trúc hơn, nhưng vẫn cần khớp nét. |
| Phân trang | footer S3 | [trái](../../../assets/icons/ic-chevron-left.svg), [phải](../../../assets/icons/ic-chevron-right.svg) | Đúng hướng/loại; stroke 2 mảnh hơn mẫu. Cần canh độ dày, đầu nét và visible bounds, cả disabled. |
| Dấu cộng | Tạo bàn ở footer S3 | [ic-plus.svg](../../../assets/icons/ic-plus.svg) | Ảnh là dấu cộng cam/vàng có viền nâu/cạnh nổi; file chỉ hai nét đơn sắc stroke 2.6. Chưa có bản theo artwork. |
| Đóng modal | 01/02 và 03/04 | [ic-close.svg](../../../assets/icons/ic-close.svg) | Cấu trúc X đã có. 01/02 dùng nét đậm hơn; 03/04 mảnh hơn. Một cỡ/độ dày cố định chưa đại diện cả hai; không nhất thiết cần PNG. |
| Mắt mật khẩu | 02/03/04 | [ic-eye.svg](../../../assets/icons/ic-eye.svg), [ic-eye-off.svg](../../../assets/icons/ic-eye-off.svg) | Cặp mới thêm **chỉ đủ nghĩa hiện/ẩn**. Ảnh là mắt navy đặc, vòng sáng quanh tròng; SVG là contour/circle rỗng. Bản eye-off chưa có trong ảnh, phải đi cùng nét bản eye được hoàn thiện. |
| Cảnh báo dưới ô | 04 | [ic-warning.svg](../../../assets/icons/ic-warning.svg) | Ảnh là tam giác coral đặc + dấu ! trắng; file là tam giác rỗng + dấu ! cùng màu. Mask một màu không tạo được hai lớp đó. |

Các khác biệt này không được tự động coi là ngoại lệ đã duyệt chỉ vì §7 hoặc bộ icon chung liệt kê tên SVG. Ảnh đã chốt cho thấy hình khác; bảng asset cần ghi rõ trạng thái thiếu/chưa khớp. **Giữ nguyên thiết kế đã chốt**, hoàn thiện asset/biến thể của chi tiết, không thiết kế lại màn hình để dùng vừa glyph cũ.

## 2. Có sẵn và được phép dùng lại

| Phần | File/cơ chế | Kết luận |
|---|---|---|
| Đồng KEN trong bảng, ô cược, thông tin bàn | [ill-ken.webp](../../../assets/lobby/ill-ken.webp), nguồn [icon-ken.png](../../../assets/screens/lobby/icon-ken.png) | Đã có đồng vàng/vương miện và alpha. Crown/rim/highlight khác chi tiết ảnh AI; docs chỉ định dùng lại, không gọi là trùng pixel. Cần kiểm ở cỡ 24 px khi lắp. |
| Avatar VIP | [avatarIconUrl](../../../helpers/player.ts), VIP shared | Có sẵn và là ngoại lệ rõ trong docs. S4b dùng icon VIP thật 32 px; không cắt avatar AI lớn. |
| O5 thiếu KEN | [ic-ken.svg](../../../assets/icons/ic-ken.svg) | **Đủ theo ngoại lệ đã chốt:** navy thay chồng xu vàng ảnh 05; không cần tách chồng xu. |
| O5 mất mạng | [ic-wifi-off.svg](../../../assets/icons/ic-wifi-off.svg) | **Đủ theo ngoại lệ đã chốt:** navy thay wifi/gạch đỏ ảnh 06. |
| Nền trời/phố | [bg-board-pixel.webp](../../../assets/lobby/bg-board-pixel.webp) | Có cảnh cùng chủ đề đã chỉ định dùng lại. Vị trí/tỷ lệ phố trong file khác ảnh S3; chưa được kết luận khớp layout, cần canh khi dựng. |
| Spinner | `.ty-btn[aria-busy='true']::before` trong [style.css](../../../style.css) | Đã có CSS, dùng như `NoticeModal`; không thiếu file spinner. |
| Toast | `App.tsx` + `.ty-toast` | Đã có, dùng theo docs; không cần minh họa toast mới. |

Có file và được chỉ định dùng lại chưa đồng nghĩa đã qua kiểm UI thật. Các ngoại lệ KEN/wifi/avatar ở README §8 vẫn giữ nguyên, không mở rộng sang ổ khóa, reload, mắt hoặc dấu cộng.

## 3. Phần dựng bằng CSS/DOM

- Nền badge vàng/coral và glyph bên trong là hai lớp riêng. Không cắt cả badge + chữ thành ảnh.
- Nút vàng/kem/disabled, highlight/cạnh dưới, khung modal, pill tiêu đề và badge chỗ cần CSS; không tính là thiếu icon.
- Công tắc Bật/Tắt gồm track, núm, chữ; không có icon khóa bên trong công tắc. Tên nhãn và số người/số KEN là DOM.
- Gạch mảnh dưới header 03/04, viền ô lỗi và các chấm mật khẩu do CSS/input.
- Nút `Xem` chỉ có chữ theo docs, **không cần icon mắt cho nút Xem**. Mắt chỉ dùng ở ô mật khẩu.
- CSS khung chung hiện có chưa đủ để xác nhận mọi highlight/độ nổi giống sáu ảnh. S3/S4 online chưa dựng, nên chưa có visual QA runtime.

## 4. Phạm vi kiểm từng ảnh

| Ảnh | Chi tiết đã kiểm |
|---|---|
| S3 | back, reload, hai khóa hàng bàn, đồng KEN, VIP, hai nút phân trang, dấu cộng, các trạng thái Tham gia/Xem/Đang chơi |
| 01 | X đậm, đồng KEN, chip 2/3/4, hai toggle Tắt, nút Hủy/Tạo bàn |
| 02 | X đậm, KEN, mắt và chấm mật khẩu, hai toggle Bật, các nhãn |
| 03 | badge/khóa navy, X mảnh, VIP, KEN, pill chỗ, mắt, Vào bàn disabled |
| 04 | cùng 03 + tam giác/dấu !, viền coral, lỗi Sai mật khẩu và Vào bàn active |
| 05 | chồng xu so với ngoại lệ `ken`, badge vàng, một nút Đã hiểu |
| 06 | wifi/gạch đỏ so với ngoại lệ `wifi-off`, badge coral, hai nút Để sau/Thử lại |

## 5. Đính chính và việc tiếp theo

1. Ưu tiên khóa vàng hàng bàn và khóa navy modal; tiếp đến reload hai mũi tên và dấu cộng có màu.
2. Hoàn thiện chevron/back, X theo ngữ cảnh, mắt đặc và tam giác cảnh báo theo mẫu. Bản chỉ dùng S3/S4 nên có biến thể riêng, tránh tự thay toàn bộ icon dùng chung làm đổi các màn khác.
3. Khi có asset phù hợp, so từng chi tiết trên nền kem ở cỡ thật và phóng lớn; sau đó mới so toàn màn. Không dùng typecheck hay số lượng file để kết luận giống mẫu.

Các khóa có sẵn ở game khác đã được xem: Caro là xanh đậm/viền vàng, War God là khóa vàng hình trụ 3D; đều khác silhouette của S3, không coi là asset dùng ngay. Lần này chỉ audit và sửa mô tả độ sẵn sàng; không tạo icon thay thế hoặc thay sáu ảnh đã chốt.

