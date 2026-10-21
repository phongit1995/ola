# Style theo từng màn

Mỗi màn có ảnh mẫu đã duyệt thì có **một folder riêng** ở đây, gồm style riêng của màn và ảnh mẫu. Phần dùng chung (token, nút, icon, nhân vật, bảng 32 ô) vẫn ở [`style/`](../README.md); hành vi và dữ liệu của màn ở [02-screen-specs.md](../../02-screen-specs.md).

| Màn | Folder | Ảnh mẫu | Trạng thái |
|---|---|---|---|
| S1. Loading | [s1-loading](./s1-loading/README.md) | Cung men nổi và xúc xắc 3D đã chốt | đã tích hợp UI `profile === null`; viền quay luân phiên với xúc xắc lật một mặt mỗi lượt; đã dọn các mẫu thử; chưa nối API hồ sơ |
| S2. Lobby | [s2-lobby](./s2-lobby/README.md) | `concept-s2-lobby-pixel-16bit.png` | concept đã chốt; UI mock và 11 WebP đã có (nguồn PNG: 8 bản v2 đã chọn + 5 v1 + 2 lớp thoát tách từ v1); **chưa đạt visual QA runtime** — [audit](./s2-lobby/asset-audit.md) |
| S6. Bàn chơi | [s6-board](./s6-board/README.md) | `concept-s6-board-pixel-16bit.png` | ảnh chuẩn pixel 16-bit, nền mỹ thuật chung; chưa dựng UI |

Các màn khác chưa có ảnh mẫu. Điều kiện bắt đầu dựng theo [kế hoạch triển khai, giai đoạn 0](../06-implementation-plan.md) — **duyệt theo từng màn**:
- S7, O2, S9 đã lên kế hoạch vẽ concept: chờ concept của chính màn đó được duyệt rồi mới dựng.
- S3–S5, S8, S10, S11, O1, O3–O7: dựng theo [02-screen-specs.md](../../02-screen-specs.md) + style chung, duyệt bằng ảnh chụp thật.

## Quy ước

- Folder: `s{số màn}-{tên màn}` theo mã màn trong 02 (ví dụ `s7-tile-sheet`, `s9-result`). Lớp phủ dùng `o{số}-{tên}` (ví dụ `o2-card`).
- Trong folder: `README.md` (style riêng của màn, ảnh mẫu nhúng ở đầu) và ảnh `concept-s{số màn}-{tên màn}-{style}.png`.
- Chỉ đưa ảnh đã duyệt vào; ảnh nháp, ảnh verify không commit. Nguồn và prompt ghi ở [asset-generation-log.md](../../asset-generation-log.md).
- Ảnh concept là nguồn để cắt asset theo quy trình dưới; bản thân ảnh concept không import vào game.
- Khi README của màn khác style chung, README màn thắng **chỉ trong phạm vi màn đó** và phải ghi rõ đó là ngoại lệ (ví dụ cỡ nút S2).

## Quy trình asset theo màn

1. **Vẽ chung cả màn** thành một ảnh concept, duyệt, lưu vào folder màn ở đây.
2. **Cắt/tách asset từ concept** (crop + vẽ bù vùng bị che bằng AI được phép), mỗi phần một file, lưu **PNG gốc** tại `game/tycoon/assets/screens/<màn>/` (tên tiếng Anh kebab-case theo vai trò, ví dụ `logo.png`, `icon-history.png`) kèm `manifest.json` và prompt.
3. **QA trên PNG gốc** bằng đối chiếu từng phần với concept (silhouette, tỷ lệ hình nhìn thấy, hướng, chi tiết, contour/alpha) và style chung/ngoại lệ của màn. Lập danh sách cả phần decor bị bỏ khỏi prompt và nơi dựng lại chúng; không coi “đủ các PNG đã liệt kê” là đủ chi tiết của ảnh. File chưa đạt ghi vào `knownLimitations` và audit; không đánh dấu đạt QA chỉ vì đã xuất WebP hoặc UI chạy được.
4. **Khi code màn đó** mới xuất PNG sang định dạng runtime (WebP, hoặc SVG nếu vẽ lại vector) theo tên production ở [04 §2](../../04-asset-manifest-and-prompts.md), áp budget tải và optimize. PNG gốc không import vào runtime và không tính vào budget.

Code không import trực tiếp ảnh concept. Raster dùng trong game phải xuất từ nguồn theo bước 4; chữ là DOM text, surface co giãn bằng CSS/SVG, decor hình học đơn giản có thể dựng SVG code-native theo concept. Mỗi chi tiết nhìn thấy phải được giao cho một lớp rõ ràng; không vừa bỏ khỏi ảnh vừa bỏ khỏi code. Prompt lịch sử giữ nguyên, brief sửa mới ghi riêng và chỉ ghi “đã chạy” khi có output thật.
