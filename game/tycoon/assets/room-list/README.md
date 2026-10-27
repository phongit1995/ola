# Icon danh sách bàn và modal

Bộ icon riêng cho danh sách bàn S3 và các modal S4/O5 mở trên màn đó, theo [concept và sáu ảnh modal](../../docs/screens/s3-room-list/README.md). Xuất ngày **22/10/2026**; chưa lắp màn online, chưa được duyệt asset. [Audit đối chiếu](../../docs/screens/s3-room-list/icon-export-audit.md).

**11 file: 2 WebP có alpha + 9 SVG.** Màu SVG theo token: navy `#1f2a44` (`--ty-navy`), coral `#e4573d` (`--ty-coral`), kem `#fff8ea` (`--ty-cream`); xám disabled `#a3a39e` và xanh reload `#2a9df4` là màu riêng của artwork.

| Tên dùng trong code | File | Hộp mặc định (CSS px) | Đối chiếu ảnh mẫu |
|---|---|---|---|
| `lock-gold` | [lock-gold.webp](./lock-gold.webp) | 18 × 24 | Gần mẫu; quai hơi ngả ngà, thân rộng hơn đôi chút. |
| `plus-gold` | [plus-gold.webp](./plus-gold.webp) | 28 × 28 | Mặt cam, viền nâu, cạnh nổi; highlight và tỷ lệ lệch nhẹ. |
| `refresh-blue` | [refresh-blue.svg](./refresh-blue.svg) | 28 × 28 | Hai cung xanh có khoảng hở, đầu mũi tên nhọn, viền navy. |
| `lock-solid` | [lock-solid.svg](./lock-solid.svg) | 24 × 30 | Thân navy đặc, lỗ khóa trong suốt; badge vàng do CSS. |
| `warning-coral` | [warning-coral.svg](./warning-coral.svg) | 16 × 16 | Tam giác coral đặc, dấu ! kem. |
| `chevron-left` | [chevron-left.svg](./chevron-left.svg) | 16 × 24 | Nút back và trang trước. |
| `chevron-right` | [chevron-right.svg](./chevron-right.svg) | 16 × 24 | Trang sau. |
| `chevron-left-disabled` | [chevron-left-disabled.svg](./chevron-left-disabled.svg) | 16 × 24 | Trang đầu; xám, không viền. |
| `chevron-right-disabled` | [chevron-right-disabled.svg](./chevron-right-disabled.svg) | 16 × 24 | Trang cuối; ảnh mẫu không có, suy từ chevron trái. |
| `close-bold` | [close-bold.svg](./close-bold.svg) | 22 × 22 | X đậm cho modal Tạo bàn. |
| `close-thin` | [close-thin.svg](./close-thin.svg) | 22 × 22 | X mảnh cho modal Vào bàn khóa. |

## Dùng trong code

[RoomIcon](../../components/RoomIcon.tsx) xuất `ROOM_ICONS`, `RoomIconName` và component:

```tsx
<button type="button" aria-label="Làm mới danh sách bàn">
  <RoomIcon name="refresh-blue" />
</button>
```

- Render bằng `img` để giữ màu nhiều lớp, không qua mask một màu của `TyIcon`.
- Icon có `alt=""` và `aria-hidden`; tên truy cập, `disabled`, vùng bấm tối thiểu 44 px thuộc nút chứa icon. Đổi sang chevron disabled không thay cho thuộc tính `disabled`.
- Kích thước trong bảng là điểm bắt đầu; canh lại khi dựng cả màn.

## Dùng lại, không nằm trong bộ này

- Mắt hiện/ẩn mật khẩu: `ic-eye` / `ic-eye-off` qua `TyIcon` (mắt đặc, đổi màu theo `currentColor`).
- KEN trong bảng và ô cược: `../lobby/ken.png` (đồng chữ K chung của app). Ô biểu tượng O5: `ic-ken`, `ic-wifi-off` navy qua `TyIcon`. Avatar: `avatarIconUrl`.
- Nền nút, badge, khung, ô nhập, công tắc, chip và spinner là CSS; chữ và số là DOM.

## Nguồn

[PNG gốc](../screens/room-list/README.md). Khóa vàng và dấu cộng sinh bằng built-in imagegen; các SVG vẽ bằng hình học theo ảnh mẫu.
