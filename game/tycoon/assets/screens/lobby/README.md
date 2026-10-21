# Lobby — asset tách từ concept S2

13 PNG của bộ thử lobby đã được chuyển vào **`game/tycoon/assets/screens/lobby/`**. Đây là vị trí nguồn trong workspace; không phụ thuộc thư mục build `dist`. Bản logo được chọn trước đây tên `logo-clean.png`, nay là **`logo.png`**; pixel và alpha giữ nguyên.

| File | Nội dung |
|---|---|
| [background.png](./background.png) | Nền trời và phố; đã dựng bù vùng bị UI che |
| [logo.png](./logo.png) | Logo CỜ TỶ PHÚ, crown và die; bản đã làm sạch viền |
| [mascot.png](./mascot.png) | Bác Tỷ toàn thân cùng quạt |
| [hero-properties.png](./hero-properties.png) | Cụm ba thẻ đất và hai quân, chung một lớp |
| [icon-dice.png](./icon-dice.png) | Xúc xắc |
| [icon-history.png](./icon-history.png) | Đồng hồ lịch sử |
| [icon-leaderboard.png](./icon-leaderboard.png) | Bục xếp hạng và crown |
| [icon-rules.png](./icon-rules.png) | Sách luật chơi |
| [icon-exit.png](./icon-exit.png) | Cửa và mũi tên thoát |
| [icon-ken.png](./icon-ken.png) | Xu KEN |
| [icon-sound.png](./icon-sound.png) | Loa và sóng âm |
| [button-gold.png](./button-gold.png) | Nền nút vàng không chữ/icon |
| [button-paper.png](./button-paper.png) | Nền nút kem không chữ/icon |

12 PNG có alpha, 1 nền kín. [Manifest](./manifest.json) ghi kích thước, hash, số byte, nguồn sinh và trạng thái từng asset; `file` được tính tương đối từ thư mục này. Tổng PNG khoảng 12,49 MiB, chưa tối ưu runtime và chưa import vào game.

[Concept S2](../../../docs/style/screens/s2-lobby/concept-s2-lobby-pixel-16bit.png) là ảnh nguồn. [Prompt set](./prompts.md) và các file `*-prompt.txt` giữ thông tin xử lý bằng built-in image_gen. Đây là tách/inpaint bằng AI, một số chi tiết đã được dựng lại; icon sách/bục vẫn có viền mềm ở kích thước gốc. Đây là **PNG gốc** theo [quy trình asset theo màn](../../../docs/style/screens/README.md#quy-trình-asset-theo-màn): vẽ chung concept → cắt → giữ PNG; khi code S2 mới xuất sang WebP/SVG theo bảng đối chiếu và ghi chú QA ở [style S2 §10](../../../docs/style/screens/s2-lobby/README.md#10-asset-cắt-từ-concept--file-production).

Trang xem thử local ở `game/dist/tycoon-lobby-assets-v1/index.html` (thư mục build, bị gitignore, có thể mất khi build lại).
