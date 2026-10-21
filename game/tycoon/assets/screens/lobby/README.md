# Lobby — asset tách từ concept S2

15 PNG nguồn của lobby S2, tách từ [concept S2](../../../docs/style/screens/s2-lobby/concept-s2-lobby-pixel-16bit.png) bằng built-in image_gen. Ngày 2026-10-21 đã so từng file v1/v2 cạnh concept; **8 file dùng bản v2** (gần mẫu hơn), 5 file giữ v1; icon thoát giữ thiết kế v1 và được tách thành 2 lớp cửa + mũi tên bằng imagegen ([exit-split-prompts.md](./exit-split-prompts.md)). Lý do chọn từng file ở [audit S2 §5](../../../docs/style/screens/s2-lobby/asset-audit.md#5-tách-lại-v2-và-lựa-chọn-cuối).

| File | Bản | Nội dung |
|---|---|---|
| [background.png](./background.png) | v1 | Nền trời và phố; đã dựng bù vùng bị UI che |
| [logo.png](./logo.png) | v1 | Logo CỜ TỶ PHÚ, crown và die; bản đã làm sạch viền |
| [mascot.png](./mascot.png) | v2 | Bác Tỷ toàn thân cùng quạt, áo họa tiết đồng xu |
| [hero-properties.png](./hero-properties.png) | v2 | Cụm ba thẻ đất và hai quân, chung một lớp |
| [icon-dice.png](./icon-dice.png) | v2 | Xúc xắc CTA, mặt 3–2–1 |
| [icon-history.png](./icon-history.png) | v2 | Đồng hồ lịch sử, không chấm tâm |
| [icon-leaderboard.png](./icon-leaderboard.png) | v2 | Bục xếp hạng và crown viền nâu |
| [icon-rules.png](./icon-rules.png) | v2 | Sách luật chơi |
| [icon-exit.png](./icon-exit.png) | v1, reference | Ảnh ghép cửa + mũi tên, chỉ dùng đối chiếu, không xuất runtime |
| [icon-exit-door.png](./icon-exit-door.png) | v1-split | Cửa cam, lớp dưới |
| [icon-exit-arrow.png](./icon-exit-arrow.png) | v1-split | Mũi tên kem viền đỏ nâu hướng phải, lớp trên |
| [icon-ken.png](./icon-ken.png) | v1 | Xu KEN |
| [icon-sound.png](./icon-sound.png) | v1 | Loa và sóng âm (chỉ trạng thái bật) |
| [button-gold.png](./button-gold.png) | v2 | Nền nút vàng không chữ/icon, visible 3,50:1 |
| [button-paper.png](./button-paper.png) | v2 | Nền nút kem một contour, visible 4,87:1 |

14 PNG có alpha, 1 nền kín. [Manifest](./manifest.json) ghi kích thước, hash, số byte, nguồn sinh, bản v1/v2 và giới hạn đã biết; `file` tính tương đối từ thư mục này. PNG không import trực tiếp vào game.

## Xuất runtime

Đã xuất 11 WebP vào `assets/lobby/` và `assets/chars/`: cắt theo alpha (> 8) + đệm trong suốt 4 px, thu LANCZOS về ~2× cỡ hiển thị, WebP q80/alpha q90; nền kín 780 px rộng, q68. Script xuất không lưu trong repo (bảng đối chiếu ở [style S2 §10](../../../docs/style/screens/s2-lobby/README.md#10-asset-cắt-từ-concept--file-production)). Hai skin nút và loa không xuất: nút dựng bằng CSS, loa dùng cặp `ic-volume-on/off`. Thoát dùng `ill-exit-door.webp` + `ill-exit-arrow.webp` chồng trong một ô 24 px; thông số ở [exit-split-prompts.md](./exit-split-prompts.md#export-và-ghép). Sửa PNG nào thì xuất lại file WebP tương ứng theo thông số trên; nếu khung `hero-properties.webp` đổi, chỉnh tọa độ trong `lobby/decor-hero-rays.svg`.

Tia vàng CTA (2 + 2) và tia trắng hero (3 + 3) không nằm trong PNG; chúng là SVG riêng `lobby/decor-cta-rays.svg`, `lobby/decor-hero-rays.svg`.

## Prompt

[prompts.md](./prompts.md) giữ prompt v1 và tóm tắt lượt v2 (yêu cầu chính, vùng crop đầu vào); prompt đầy đủ của v2 không lưu. [exit-split-prompts.md](./exit-split-prompts.md) giữ đủ prompt tách cửa và mũi tên. `logo-clean-prompt.txt`, `sound-retry-prompt.txt` là prompt đầy đủ của hai file v1 còn dùng.

Đây là ảnh AI tái dựng, không phải cắt trùng pixel. Bộ ảnh vẫn `trial-not-production` cho tới khi qua visual QA runtime theo [audit S2](../../../docs/style/screens/s2-lobby/asset-audit.md).
