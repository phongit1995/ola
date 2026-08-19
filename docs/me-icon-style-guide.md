# Style guide icon Me

Tài liệu này là chuẩn chung cho icon trong header và menu trái của màn hình Me. Mục tiêu là giữ các icon đồng đều về **khối lượng thị giác**, không chỉ đồng đều về giá trị `width`/`height` trong CSS.

## Bộ đang áp dụng

Các phương án đã chọn và gắn vào app là: `Kết hôn 03 · Yêu thích 06 · Khách ghé 07`.

## Chuẩn file nguồn

- Canvas và `viewBox`: `96 × 96`.
- Nền trong suốt, hình nguồn màu đen.
- Nét chính mục tiêu: `7–8px`; bộ đang áp dụng dùng nét chính `7.5px`, nét chi tiết `6px`, `stroke-linecap="round"`, `stroke-linejoin="round"`.
- Chỉ dùng mảng đặc cho chi tiết cần nhấn như đồng tử, đầu người hoặc trái tim đặc.
- Giữ hình chính cân giữa canvas theo cảm nhận thị giác; không cân máy móc theo bounding box nếu hình có chi tiết nhô lên hoặc chân nặng.
- Tên file: `ic_header_<semantic>.svg` và bản PNG cùng tên.

## Màu và trạng thái

- Asset gốc luôn là glyph đen trên nền trong suốt.
- Trên nền primary, dùng utility `icon-on-primary`; utility tự đổi màu theo theme.
- Trong menu trái, các icon dùng chung `opacity-[0.26]`, tương đương màu inactive của bottom navigation.
- Không nhúng sẵn màu trắng vào asset và không thêm `brightness`, `invert` hoặc `opacity` riêng cho từng icon để chữa chênh lệch hình học.

## Kích thước hiển thị

| Vị trí | Kích thước quang học | Dịch trục Y |
|---|---:|---:|
| Nút menu header | 18px | 0 |
| Thông báo, tìm kiếm | 22px | 0 |
| Tab Cộng đồng, Cá nhân | 28px | theo cấu hình tab |
| Tab Clan trong header | 32px | +1px |
| Icon thường trong menu trái | 24px | 0 |
| Clan trong menu trái | 28px | +1px |

Kích thước quang học là kích thước của hộp `<img>`. Khi một glyph có tỷ lệ ngang/dọc đặc biệt, chỉ điều chỉnh `opticalSize` hoặc `opticalOffsetY` sau khi đã xem ở kích thước thật; không sửa bằng padding ẩn trong ảnh.

## Xuất PNG

SVG là nguồn chuẩn; PNG là asset được app import. Ví dụ:

```bash
rsvg-convert -w 96 -h 96 \
  -o ic_header_favorite.tmp.png \
  ic_header_favorite.svg

magick ic_header_favorite.tmp.png \
  -colorspace Gray \
  -define png:color-type=4 \
  ic_header_favorite.png
```

PNG cuối phải là `96 × 96`, grayscale + alpha. Xóa file `.tmp.png` sau khi đã đối chiếu xong.

## Checklist trước khi dùng

- SVG hợp lệ và có đúng canvas `96 × 96`.
- PNG khớp từng pixel với SVG sau khi render.
- Không có khoảng trống vô tình do dùng lẫn canvas 48, 64 và 96.
- Kiểm tra icon ở đúng các mức 18, 22, 24, 28 và 32px, thêm một lần ở màn hình 2×.
- So khối lượng nét, chiều cao cảm nhận và tâm thị giác với hai icon đứng cạnh.
- Chạy typecheck, lint file liên quan và production build sau khi đổi asset hoặc cách import.

## Ánh xạ menu trái

| Mục | Asset hiện tại |
|---|---|
| Cá nhân | `ic_header_personal.png` |
| Kết hôn | `ic_header_marriage.png` — phương án 03 |
| Yêu thích | `ic_header_favorite.png` — phương án 06 |
| Khách ghé | `ic_header_visitors.png` — phương án 07 |
| Clan | `ic_header_clan.png` |
