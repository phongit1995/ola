# Generated board asset batch — Cờ Tỷ Phú

Ngày: 2026-11-02 (Asia/Ho_Chi_Minh). Công cụ: built-in `image_gen`, sau đó ImageMagick để tách sheet, đặt canvas và xuất WebP.

- `assets/screens/board/bg-board-pixel-generated.png`: bản nền pixel 16-bit mới để đối chiếu; runtime tiếp tục dùng `assets/lobby/bg-board-pixel.webp` đã có và đã được duyệt.
- `assets/tiles/art/*.webp`: 19 tranh ô, tách từ `assets/screens/board/tiles-sheet.png`, cùng đường chân trời và palette theo docs S6.
- `assets/chars/{char}-{pose}-{crop}.webp`: 6 nhân vật × 4 pose × 2 crop = 48 sprite alpha thật, tách từ `assets/screens/board/chars-sheet.png`.
- `assets/tokens/tk-*.webp`: 8 quân v2 alpha thật, tách từ `assets/screens/board/tokens-sheet.png`.
- `assets/tokens/tk-pawn.svg`: pawn code-native cho UI v3.

SHA-256, kích thước và danh sách runtime đầy đủ nằm trong `assets/asset-manifest.generated.json`.
