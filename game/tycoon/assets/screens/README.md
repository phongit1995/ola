# Asset theo màn — Cờ Tỷ Phú

Mỗi màn có một thư mục `assets/screens/<tên-screen>/`. Tên thư mục dùng tiếng Anh kebab-case, ví dụ `lobby`, `board`, `result`; mã S2/S6 thuộc tài liệu thiết kế, không cần lặp trong tên asset.

- [lobby/](./lobby/README.md) — 13 PNG gốc tách từ concept S2 (8 bản v2 đã chọn + 5 v1).

Quy trình: vẽ chung cả màn thành concept → cắt từng asset → lưu PNG gốc ở đây → khi code màn đó mới xuất WebP/SVG theo tên production ([style/screens](../../docs/style/screens/README.md#quy-trình-asset-theo-màn)). PNG ở đây không import vào runtime.

Tên file mô tả vai trò trong màn: `background.png`, `logo.png`, `mascot.png`, `icon-history.png`… Asset dùng chung hiện tại vẫn ở thư mục riêng như `assets/icons/`.
