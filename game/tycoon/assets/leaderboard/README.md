# Asset S11 — Mint tối giản

Bộ huy chương theo [mẫu 02 đã chốt](../../docs/screens/s11-leaderboard/README.md). **3 WebP có alpha, tổng 11.880 byte (~11,6 KiB)**, sẵn để ghép vào màn. Mỗi mặt huy chương để trống; số hạng là text DOM. Đã dùng trong `screens/LeaderboardScreen.tsx` (rộng 36, số 20/800).

| Hạng | File dùng trong game | Kích thước ảnh | Dung lượng | Màu số gợi ý |
|---|---|---|---|---|
| 1 | [medal-gold.webp](./medal-gold.webp) | 81 × 96 | 4.074 B | `#744700` |
| 2 | [medal-silver.webp](./medal-silver.webp) | 80 × 96 | 3.664 B | `#143451` |
| 3 | [medal-bronze.webp](./medal-bronze.webp) | 79 × 96 | 4.142 B | `#74320b` |

PNG nguồn 1254 × 1254 giữ nguyên output imagegen: [vàng](../screens/leaderboard/medal-gold.png), [bạc](../screens/leaderboard/medal-silver.png), [đồng](../screens/leaderboard/medal-bronze.png). [Manifest](../screens/leaderboard/manifest.json) chứa prompt đầy đủ, nguồn concept/generation ID, hash, alpha, crop và thông số export. Không import PNG nguồn vào bundle.

## Ghép số hạng

Giữ tỷ lệ ảnh, rộng 36 px (cao thực tế khoảng 43–44). Đặt số ở tâm mặt tròn, `left: 50%`, `top: 41.5%`; tâm này nằm phía trên tâm của cả huy chương vì có đuôi ruy băng bên dưới. Font Nunito 22/800, line-height 1. Cùng cách ghép cho cả ba màu.

```tsx
import medalGold from '../assets/leaderboard/medal-gold.webp';

<span className="ty-leaderboard-medal" data-rank="1" role="img" aria-label="Hạng 1">
  <img src={medalGold} alt="" draggable={false} />
  <b aria-hidden="true">1</b>
</span>
```

```css
.ty-leaderboard-medal {
  position: relative;
  display: inline-block;
  width: 36px;
  flex: 0 0 36px;
  vertical-align: middle;
}
.ty-leaderboard-medal img { display: block; width: 100%; height: auto; }
.ty-leaderboard-medal b {
  position: absolute;
  left: 50%; top: 41.5%;
  transform: translate(-50%, -50%);
  font: 800 22px/1 'Nunito', sans-serif;
  color: #744700;
}
.ty-leaderboard-medal[data-rank='2'] b { color: #143451; }
.ty-leaderboard-medal[data-rank='3'] b { color: #74320b; }
```

Hạng từ 4 trở đi dùng số navy trực tiếp. Huy chương là thông tin hạng, không phải nút. Khi đổi màu phải đổi cả file và `data-rank`; không tô bằng CSS mask hoặc `filter` vì artwork nhiều màu.

## Dùng lại và surface

- Header: [ill-leaderboard.webp](../lobby/ill-leaderboard.webp), khoảng 36–40 px rộng.
- Quay lại: [chevron-left.svg](../room-list/chevron-left.svg), trong nút paper CSS có vùng chạm 44.
- Nền: [bg-board-pixel.webp](../lobby/bg-board-pixel.webp). Avatar: `avatarIconUrl(vipType)` và fallback Ola.
- Khung panel, header pill, tab gold/paper, chip mint, nền hàng mình/vạch jade, divider, scrollbar, skeleton và chữ là CSS/DOM. [Bảng phân lớp đầy đủ](../../docs/screens/s11-leaderboard/README.md#phân-lớp-asset).

## Đối chiếu và quy cách xuất

Đã xem cả ba cạnh crop concept, cả mặt trống và bản ghép số Nunito; kiểm ở rộng 36 px trên kem, mint và navy. Giữ đúng mặt tròn, hai đuôi ruy băng, màu ba hạng và phần tâm trống. Có alpha thật, không dính nền giấy hay chữ/số cũ.

Imagegen có tái dựng nét: highlight vàng dài hơn một chút; vòng bạc đậm và đều hơn; gradient đồng mượt hơn ảnh nhỏ trong concept. Số DOM dùng font thật nên nét không trùng tuyệt đối chữ AI. Những khác biệt này vẫn nhận thấy khi phóng lớn; không gọi là crop trùng pixel. Chưa xác nhận visual QA của cả màn S11.

Nguồn: built-in `image_gen`, `transparent_background=true`, một lần tách cho từng huy chương và bỏ số trên mặt. PNG không chỉnh sửa. Xuất WebP bằng `cwebp`: crop theo alpha > 8, thêm khoảng 4 px nguồn và căn tọa độ crop chẵn; scale cao 96 giữ tỷ lệ; `-q 90 -alpha_q 100 -m 6 -metadata none`. Tọa độ crop riêng từng ảnh trong manifest. Alpha nguồn bằng 0 chiếm 54,85–59,20%; mép ngoài có vài pixel alpha 1/255, đã nằm ngoài crop runtime. Không thêm shadow/filter ngoài khi render.

Chỉ cần tải bộ này khi mở BXH; tổng 11,6 KiB là riêng ba huy chương, không phải budget toàn màn. PNG nguồn và concept chỉ dùng thiết kế.
