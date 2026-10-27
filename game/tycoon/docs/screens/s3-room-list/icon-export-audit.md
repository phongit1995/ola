# Kiểm bộ icon đã xuất — 22/10/2026

Bộ icon riêng cho danh sách bàn S3 và các modal S4/O5: **11 file, 2 WebP + 9 SVG**, ở [`assets/room-list/`](../../../assets/room-list/README.md). Bộ này bổ sung phần còn thiếu trong [audit trước khi xuất](./asset-audit.md); không thay concept hay bộ `ic-*` dùng chung. Chưa lắp màn online, chưa được duyệt asset.

## Cách kiểm

Cắt từng chi tiết trong concept S3 và sáu ảnh modal, phóng 3 lần, đặt cạnh icon render bằng Chrome ở cỡ phóng 8 lần và cỡ thật, trên nền gần giống chỗ dùng (kem, vàng, xám). Đây là kiểm artwork, chưa phải ảnh chụp màn đã dựng.

## Kết quả

| Icon | Kết quả |
|---|---|
| Khóa vàng hàng bàn (WebP) | Gần mẫu: thân vàng cam, quai sáng, lỗ khóa, viền đậm. Quai hơi ngả ngà, thân rộng hơn đôi chút. |
| Dấu cộng cam (WebP) | Khớp: mặt cam, viền nâu, cạnh nổi. Highlight sáng hơn, tỷ lệ lệch nhẹ. |
| Reload (SVG) | Hai cung xanh có khoảng hở khoảng 30°, đầu mũi tên nhọn, viền navy. Bản imagegen trước có viền xanh dương chói, đầu mũi tên tù và hai cung gần khép kín nên đã thay. |
| Khóa navy modal | Đúng thân đặc, quai, lỗ khóa khoét lộ nền vàng của badge. |
| Mắt / mắt gạch | Dùng `ic-eye` / `ic-eye-off` của `TyIcon`, đã đổi sang mắt đặc có vòng trong suốt đúng ảnh 03/04. Mắt gạch không có ảnh mẫu riêng. |
| Cảnh báo | Đúng tam giác đặc, dấu ! kem; màu `--ty-coral` cùng màu chữ lỗi bên cạnh. |
| Chevron back, trang trước/sau | Đúng chevron không cán, nét đậm, bo đầu. Disabled là xám đặc không viền như ảnh mẫu; trang sau disabled suy từ trang trước. |
| X đóng modal | `close-bold` cho Tạo bàn, `close-thin` cho Vào bàn khóa; khớp ảnh 01 và 03. |

## Style

- SVG dùng token: navy `#1f2a44`, coral `#e4573d`, kem `#fff8ea`. Ngoài token chỉ có xám disabled `#a3a39e` và xanh reload `#2a9df4`, là màu riêng của artwork.
- Hai WebP là raster imagegen: trim lề trong suốt bên ngoài, thu cạnh dài về 92 px, lưu lossless; không sửa màu, hình hay alpha bên trong.
- `RoomIcon` render bằng `img` để giữ màu nhiều lớp. Mắt đơn sắc nên đi qua `TyIcon` và đổi màu theo `currentColor`.

## Dùng lại

Đồng KEN trong bảng và ô cược dùng `lobby/ill-ken.webp`; ô biểu tượng O5 dùng `ic-ken`, `ic-wifi-off` navy; avatar dùng `avatarIconUrl`. Nền badge, nút, ô nhập, công tắc, khung, spinner và chữ là CSS/DOM.
