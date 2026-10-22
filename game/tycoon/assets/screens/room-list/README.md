# PNG nguồn icon danh sách bàn

Ngày 22/10/2026. Hai PNG RGBA là output được chọn sau ba vòng built-in imagegen: `lock-gold.png`, `plus-gold.png`. Giữ nguyên byte output; không cắt từ concept. Reload trước đây cũng sinh bằng imagegen nhưng đã thay bằng SVG vẽ tay vì viền xanh chói, không theo viền navy của game.

- Bản runtime: [`assets/room-list/`](../../room-list/README.md). Khi xuất chỉ trim lề trong suốt bên ngoài, thu cạnh dài về 92 px, thêm lề 2 px và lưu WebP lossless; không sửa màu, hình hay alpha bên trong.

Trạng thái: đã xuất để review. Prompt và metadata lúc sinh không giữ trong repo. Hai raster còn sai lệch nhỏ so với ảnh mẫu; xem [audit](../../../docs/screens/s3-room-list/icon-export-audit.md).
