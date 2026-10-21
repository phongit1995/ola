# Tách lại nút thoát từ bản v1 — 2026-10-21

Dùng built-in `image_gen`, `transparent_background: true`, mỗi lượt một asset. Đầu vào là [icon-exit.png](./icon-exit.png) đã được chọn; giữ cửa cam, mũi tên **kem viền đỏ nâu, hướng phải**. Không phục hồi cặp v2 đỏ ruột/viền kem đã bị loại.

PNG nguồn được chép nguyên từ output của imagegen, không dùng script mask/tẩy viền/recolor. WebP runtime là bản xuất riêng: lấy bounds alpha > 8, thu LANCZOS, thêm padding 4 px mỗi cạnh, q80/alpha q90.

## Cửa — bản dùng

Output: `exec-75807626-0a0a-44df-b1b9-8f2a2c995db4.png` → [icon-exit-door.png](./icon-exit-door.png).

```text
Use case: precise-object-edit / background-extraction. Edit target: attached icon-exit.png. Extract ONLY the orange door component from this exact approved combined exit icon; remove the entire cream arrow and its maroon outline, reconstruct the occluded door surface. Keep the tall rounded orange door, deep red/maroon contour, creamy top gloss, orange/yellow bevels, inset dark red rectangular recess on the left-middle, same front-on geometry and smooth cartoon painted style. No handle, no knob, no lettering, no arrow, no new ornaments, no glow, no cast shadow outside the door. Preserve the source silhouette and palette; do not redesign. Isolated door centered, entire object visible with modest transparent padding. Output PNG with genuine transparent background, smooth antialiased edges, high resolution.
```

## Mũi tên — lượt đầu, không dùng

Output: `exec-18f33acd-6fe0-4590-a7df-0f7ecb063fba.png`. Visible khoảng 1,72:1, thân dài hơn bản v1; chỉ dùng làm đầu vào chỉnh tỷ lệ.

```text
Use case: precise-object-edit / background-extraction. Edit target: attached icon-exit.png. Extract ONLY the right-pointing arrow from this exact approved combined exit icon. Keep its warm CREAM / ivory interior, thick dark maroon / red-brown outline, rounded corners, white top-left gloss and subtle pale gold/orange lower bevel. Preserve the source arrow silhouette, proportions and exact right-facing orientation. Remove the entire door. Do not reverse fill and outline colors. No red-filled arrow, no cream outline. No background, no detached flecks, no glow, no cast shadow outside the contour, no text, no other objects. Smooth antialiased cartoon UI artwork, not pixel art. Center the isolated horizontal arrow with modest transparent padding; genuine transparent PNG.
```

## Mũi tên — sửa tỷ lệ, bản dùng

Input 1: output mũi tên lượt đầu. Input 2: `icon-exit.png` v1.

Output: `exec-c71fb112-c6a1-4071-a72c-f0949c3b58d4.png` → [icon-exit-arrow.png](./icon-exit-arrow.png). Visible 931 × 663, khoảng 1,40:1; gần tỷ lệ khoảng 1,45:1 của v1 hơn lượt đầu. AI không giữ nguyên pixel.

```text
Use case: precise-object-edit. Image 1 is the edit target: isolated cream arrow. Image 2 is the original combined exit icon and is the exact silhouette reference. Change only the isolated arrow's proportions: shorten its horizontal shaft so its complete visible silhouette (including dark maroon contour) has width:height about 1.45:1, matching the arrow in image 2. Keep the same warm cream/ivory fill, thick maroon outline, rounded corners, subtle pale gold lower bevel and white upper gloss. Right-pointing orientation. Remove any glow or faint exterior paint: outside the solid contour must be completely transparent except a very narrow antialiased edge. Do not change fill to red, do not use a cream outline. No door, no other objects, no text. Output one centered standalone arrow on genuine transparent background, about 10% empty transparent padding, smooth high resolution artwork.
```

## Export và ghép

- Cửa: visible 720 × 940 → thumbnail tối đa 40 × 48 → 37 × 48 + padding → WebP 45 × 56, 1.024 byte.
- Mũi tên: visible 931 × 663 → thumbnail tối đa 36 × 26 → 36 × 26 + padding → WebP 44 × 34, 850 byte.
- Slot DOM 24 × 24: cửa CSS 22,5 × 28, top −2/right −2; mũi tên CSS 22 × 16,5, top 3,75/left −2. `object-fit: contain` giữ tỷ lệ khi hai khung khác nhau.
- Hai lớp trang trí nằm trong một button có nhãn Thoát game, vẫn gửi một sự kiện `bridge.exit()`.
- Bản ghép v1 giữ làm reference; runtime bỏ `ill-exit.webp`, dùng `ill-exit-door.webp` + `ill-exit-arrow.webp`.
