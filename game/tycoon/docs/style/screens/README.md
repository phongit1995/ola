# Style theo từng màn

Mỗi màn có ảnh mẫu đã duyệt thì có **một folder riêng** ở đây, gồm style riêng của màn và ảnh mẫu. Phần dùng chung (token, nút, icon, nhân vật, bảng 32 ô) vẫn ở [`style/`](../README.md); hành vi và dữ liệu của màn ở [02-screen-specs.md](../../02-screen-specs.md).

| Màn | Folder | Ảnh mẫu | Trạng thái |
|---|---|---|---|
| S2. Lobby | [s2-lobby](./s2-lobby/README.md) | `concept-s2-lobby-pixel-16bit.png` | phương án 1 — Nền trời thoáng, đã chốt; chưa dựng UI |
| S6. Bàn chơi | [s6-board](./s6-board/README.md) | `concept-s6-board-pixel-16bit.png` | ảnh chuẩn pixel 16-bit, nền mỹ thuật chung; chưa dựng UI |

Các màn khác chưa có ảnh mẫu. Điều kiện bắt đầu dựng theo [kế hoạch triển khai, giai đoạn 0](../06-implementation-plan.md) — **duyệt theo từng màn**:
- S7, O2, S9 đã lên kế hoạch vẽ concept: chờ concept của chính màn đó được duyệt rồi mới dựng.
- S1, S3–S5, S8, S10, S11, O1, O3–O7: dựng theo [02-screen-specs.md](../../02-screen-specs.md) + style chung, duyệt bằng ảnh chụp thật.

## Quy ước

- Folder: `s{số màn}-{tên màn}` theo mã màn trong 02 (ví dụ `s7-tile-sheet`, `s9-result`). Lớp phủ dùng `o{số}-{tên}` (ví dụ `o2-card`).
- Trong folder: `README.md` (style riêng của màn, ảnh mẫu nhúng ở đầu) và ảnh `concept-s{số màn}-{tên màn}-{style}.png`.
- Chỉ đưa ảnh đã duyệt vào; ảnh nháp, ảnh verify không commit. Nguồn và prompt ghi ở [asset-generation-log.md](../../asset-generation-log.md).
- Ảnh mẫu là tài liệu tham chiếu: code không import, không cắt ảnh làm asset game.
- Khi README của màn khác style chung, README màn thắng **chỉ trong phạm vi màn đó** và phải ghi rõ đó là ngoại lệ (ví dụ cỡ nút S2).
