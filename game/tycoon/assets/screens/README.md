# Asset theo màn — Cờ Tỷ Phú

Mỗi màn có một thư mục `assets/screens/<tên-screen>/`. Tên thư mục dùng tiếng Anh kebab-case, ví dụ `lobby`, `board`, `result`; mã S2/S6 thuộc tài liệu thiết kế, không cần lặp trong tên asset.

- [lobby/](./lobby/README.md) — 15 PNG nguồn S2 (8 bản v2 + 5 v1 + 2 lớp cửa/mũi tên tách lại từ v1).
- [rules-guide/](./rules-guide/manifest.json) — 18 PNG minh họa trong suốt từ 4 tab Hướng dẫn chơi đã chốt; prompt, hash và khác biệt trong `manifest.json`; runtime `assets/rules/ill-*.webp` ([S2 §12](../../docs/screens/s2-lobby/README.md#asset-hướng-dẫn-chơi)).
- [room-list/](./room-list/README.md) — 2 PNG nguồn imagegen; bộ runtime 2 WebP + 9 SVG riêng cho danh sách bàn và modal. Đã đối chiếu, còn sai lệch nhỏ ghi trong audit; chưa lắp online.
- [leaderboard/](./leaderboard/manifest.json) — 3 PNG huy chương mặt trống từ mẫu S11 Mint tối giản đã chốt; prompt/hash/alpha và thông số xuất trong manifest; [3 WebP và cách ghép số DOM](../leaderboard/README.md).

Quy trình: vẽ chung cả màn thành concept → cắt từng asset → lưu PNG gốc ở đây → khi code màn đó mới xuất WebP/SVG theo tên production ([screens](../../docs/screens/README.md#quy-trình-asset-theo-màn)). PNG ở đây không import vào runtime.

Tên file mô tả vai trò trong màn: `background.png`, `logo.png`, `mascot.png`, `icon-history.png`… Asset dùng chung hiện tại vẫn ở thư mục riêng như `assets/icons/`.
