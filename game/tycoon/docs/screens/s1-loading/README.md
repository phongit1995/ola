# S1 — Cung men nổi và xúc xắc 3D

**Đã chốt Cung men nổi ngày 2026-10-21.** Runtime dùng một viền SVG và xúc xắc WebGL bo góc đã duyệt. Nền sau xúc xắc trong suốt; viền chuyển động trước, xúc xắc chỉ lật một mặt rồi giữ mặt mới qua lượt tiếp theo.

## Code và asset

- [`DiceLoader.tsx`](../../../components/loading/DiceLoader.tsx): lắp viền, canvas, trạng thái truy cập và fallback.
- [`DiceLoader.css`](../../../components/loading/DiceLoader.css): kích thước, xoay viền và reduced motion.
- [`roundedDieRenderer.ts`](../../../components/loading/roundedDieRenderer.ts): mesh/shader, đồng hồ render và cleanup; API chỉ tạo renderer + `dispose()`.
- [`loadingMotion.ts`](../../../components/loading/loadingMotion.ts): cùng một đồng hồ cho viền và góc xúc xắc.
- [`loading-ring-enamel.svg`](../../../assets/lobby/loading-ring-enamel.svg): xuất trực tiếp từ mẫu Cung men nổi được chọn. Bốn cung bán kính 41, dài 66°; contour navy `#102b58` rộng 10,2; lớp màu 7,5; highlight 1,1. Giữ nguyên tọa độ và gradient của mẫu.

Đã bỏ các phương án không chọn, viền original, trang gallery/iframe, script kiểm gallery, renderer tham chiếu trùng lặp, đường xoay sáu mặt cũ và API debug `seek/play/getState`. Không còn listener điều khiển bằng `postMessage` trong loader. Giữ một lệnh QA dùng chính component thật.

## Bố cục và trạng thái

`LobbyScreen` hiện S1 khi `profile === null`: ẩn tên/avatar, KEN, menu và cụm thẻ/quân; giữ nền trời, logo, Bác Tỷ đứng yên, âm thanh và Thoát game. Có hồ sơ thì gỡ loader, khôi phục S2 và phép đo topbar.

Tâm loader x 50%, y 67% vùng sau safe-area; khung `min(33cqw, 15cqh, 144px)`. Canvas inset 19% / rộng 62%. Xúc xắc giữ bo góc 0,13, contour 0,052, scale 1,12, màu trắng–tím nhạt và chấm navy. Các cặp mặt đối diện có tổng 7. Không có đĩa trắng/kem, chữ loading hiển thị hoặc phần trăm giả; `role=status` đọc “Đang tải hồ sơ”.

## Chuyển động

| Thời gian trong một lượt 2,8 giây | Viền | Xúc xắc |
|---|---|---|
| 0–1.400 ms | quay 360°, tăng/giảm tốc mềm | giữ mặt của lượt trước |
| 1.400–1.600 ms | đứng yên | đứng yên |
| 1.600–2.300 ms | đứng yên | lật 90° quanh Y, giữ X = 40° |
| 2.300–2.800 ms | đứng yên | giữ mặt mới |

Bốn lượt riêng mới về hướng ban đầu. Reduced motion giữ tư thế đầu; tab ẩn dừng đồng hồ và tiếp tục từ cùng nhịp khi hiện lại. Unmount hủy RAF, observer/listener và tài nguyên WebGL. Thiếu WebGL hoặc mất context thì dùng `lobby/ill-dice.webp` tĩnh; viền vẫn quay/nghỉ bằng CSS theo lượt 2,8 giây.

## Xem và kiểm tra

Chạy `pnpm -C game dev`, mở `/tycoon/?preview=loading` trên dev server. Query chỉ hoạt động trong dev; đây là điểm xem duy nhất còn giữ sau khi dọn preview. Store hiện khởi tạo `MOCK_PROFILE`, nên bỏ query sẽ vào sảnh chơi máy bình thường. API hồ sơ, timeout/error/retry/auth vẫn theo kế hoạch [02 S1](../../02-screen-specs.md#s1-loading--connecting).

Kiểm khi đổi loader: viền đúng asset, alpha trong suốt, viền/xúc xắc thay phiên, lật đúng 90° và giữ mặt mới, reduced motion, ẩn/hiện trang, gỡ/dựng component, fallback WebGL, âm thanh/thoát/chơi máy ở 390×844, 360×640, 360×568, 520×900 và safe-area 44/34. Script kiểm tự động không lưu trong repo.

Kết quả lần chốt mẫu (kiểm bằng script Chrome headless + SwiftShader): build qua; viền giống pixel với mẫu đã chọn và 12/12 tư thế xúc xắc giống ảnh trước cleanup; tám lượt lật, năm cấu hình viewport, lifecycle/fallback và các action đều qua; không có exception JavaScript. Build còn cảnh báo chunk lớn ở entry `wargod`, ngoài phạm vi S1. API online, budget tải toàn bộ và kiểm thiết bị thật chưa nằm trong lần chốt UI này.
