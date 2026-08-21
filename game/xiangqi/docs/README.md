# Cờ Tướng UI — Style: Mộc bản thủ công (Kỳ Đàn Son Mộc)

## Hướng duy nhất

**Mộc bản thủ công** là design system duy nhất cho UI Cờ Tướng (gameId `xiangqi`); **Kỳ Đàn Son Mộc** là codename nội bộ của cùng một style. Tài liệu tổng quan đặt trong `game/xiangqi/docs/`; đặc tả triển khai chi tiết nằm tại [`docs/style/`](./style/README.md).

Ngôn ngữ hình ảnh: nền gỗ trầm ấm, mặt bàn cờ giấy kem, quân son đỏ và mực đen khắc chữ Hán truyền thống, outline navy đồng nhất với hệ mini-game Ola, CTA vàng nắng, điểm nhấn đỏ son. Production ưu tiên CSS/SVG code-native (bàn cờ, lưới, cung, sông đều là SVG); raster chỉ dùng cho mặt quân và nền trang trí.

Source React quyết định chức năng, dữ liệu và state. Docs quyết định ngôn ngữ hình ảnh và spec. Server (`server/internal/game/games/xiangqi/`) là nguồn chân lý duy nhất về luật; client chỉ mirror luật để gợi ý nước đi (parity test bắt buộc).

## Phạm vi v1 (đã chốt)

- PvP 2 người, có đặt cược KEN (commission `XIANGQI_COMMISSION_PERCENT`, mặc định 5%).
- 30 giây/nước, hết giờ = thua ngay.
- Chiếu bí và hết nước đi (khốn tử) = thua bên tới lượt (đúng luật cờ tướng VN).
- Lặp thế 3 lần → phân xử: **chiếu dai một chiều = bên chiếu thua**; còn lại = hòa. 60 nước đôi không ăn quân = hòa. Không có nút cầu hòa (v2). Đuổi dai chưa phân xử (v2).
- Đầu hàng (FORFEIT), reconnect/resume, chat, reaction, lịch sử, bảng xếp hạng — dùng hạ tầng engine + SDK sẵn có.
- Chưa có chế độ chơi với máy (v2 — cần AI, khác caro bot đơn giản).
- Mặt quân: chữ Hán truyền thống (帥仕相俥炮傌兵 / 將士象車砲馬卒).

## Danh sách màn hình và tính năng

9 màn/khối UI + 3 lớp overlay, chi tiết trong [02-screen-specs.md](./02-screen-specs.md):

| # | Màn | Tính năng chính |
|---|---|---|
| S1 | Loading / Connecting | preload asset, tiến trình %, lỗi kết nối + thử lại |
| S2 | Lobby | logo, KEN + avatar, CTA Chơi xếp hạng, Lịch sử, Bảng xếp hạng, bật/tắt âm, thoát game |
| S3 | Danh sách bàn | list bàn + mức cược + khóa, Tạo bàn, Làm mới, tự re-sync, phân trang 9 hàng |
| S4 | Modal Tạo bàn / Vào bàn khóa | nhập cược, mật khẩu, validate KEN |
| S5 | Phòng chờ (pregame, render trong Board) | 2 ghế, Sẵn sàng/Hủy, Bắt đầu (chủ bàn), Mời ra, Thoát bàn, chat phòng |
| S6 | Bàn chơi | bàn 9×10, chọn quân → gợi ý nước, đi quân, highlight nước cuối, banner Chiếu, đồng hồ 30s, badge cược, KEN float, chat + reaction, Bỏ cuộc/Thoát |
| S7 | Kết quả | Thắng/Thua/Hòa + lý do, ±KEN, Chơi lại (về phòng chờ), Đóng |
| S8 | Lịch sử | tối đa 100 trận gần nhất (`matchHistoryLimit`), đối thủ, kết quả, ±KEN (`kenDelta` từ server), thời gian |
| S9 | Bảng xếp hạng | hôm nay/tuần này (SDK chỉ có `day\|week`), thắng-thua, KEN thắng ròng |
| O1 | Banner đối thủ mất kết nối | đếm ngược grace 30s |
| O2 | ConfirmModal | bỏ cuộc, thoát bàn, mời ra |
| O3 | Toast + turn announce | lỗi server, ĐẾN LƯỢT BẠN |

## Cấu trúc tài liệu

Đọc theo thứ tự:

1. [01-art-direction.md](./01-art-direction.md) — palette, typography, hình học, shadow, motion.
2. [02-screen-specs.md](./02-screen-specs.md) — spec từng màn: bố cục, kích thước, state.
3. [03-component-specs.md](./03-component-specs.md) — bàn cờ SVG, quân, gợi ý nước, đồng hồ, pod người chơi, nút, modal.
4. [04-asset-manifest-and-prompts.md](./04-asset-manifest-and-prompts.md) — manifest CSS/SVG/raster, script sinh quân, prompt.
5. [05-gameplay-rules-and-protocol.md](./05-gameplay-rules-and-protocol.md) — luật VN đầy đủ, state machine, socket protocol, steps replay, reconnect.
6. [06-screen-to-feature-map.md](./06-screen-to-feature-map.md) — mapping màn → store state → SDK event → component.
7. [screenshots/](./screenshots/README.md) — harness và hướng dẫn tạo cục bộ 37 ảnh màn/state bằng `scripts/xiangqi-shots.mjs`; PNG output không lưu trong Git.
8. [style/](./style/README.md) — design system Mộc bản thủ công: token, từng loại button/control, component, icon, responsive, accessibility và QA.

## Nguyên tắc bắt buộc

- viewport logic `390 × 844 CSS px`, hỗ trợ width 360–520 px;
- CSS token và SVG code-native trước, raster chỉ khi thật sự cần (mặt quân, nền);
- border navy thống nhất 1.5–2 px, radius chỉ dùng scale 8/12/16/20/28/999;
- label, tên, số, trạng thái luôn là live text — không bake chữ vào ảnh;
- quân cờ đặt trên **giao điểm** lưới, không phải trong ô;
- người chơi luôn thấy quân mình phía dưới (Đen xem bàn lật 180°);
- mọi state có focus, disabled, loading, reduced-motion khi phù hợp;
- chữ đạt WCAG AA, touch target tối thiểu 44 × 44 px (giao điểm bàn cờ dùng vùng chạm mở rộng);
- client không tự quyết kết quả — mọi kết thúc ván đến từ `MATCH_OVER`.

## Vị trí asset

```text
game/xiangqi/assets/
  app-icons/        # app icon: SVG nguồn + PNG bo góc 1024 px (convention thirteen)
  pieces/           # 14 mặt quân webp: r{k,a,e,h,r,c,p}.webp + b{...}.webp
  lobby/            # nền, logo, khung
  board/            # texture gỗ/giấy nếu cần (ưu tiên CSS/SVG)
  icons/            # ic-* SVG
  fx/               # hiệu ứng (chiếu, ăn quân) nếu cần raster
```

Reaction dùng lại `game/caro/assets/reactions/*.webp` qua import tương đối (như thirteen đã làm). Docs không thay đổi luật, network/store hay chức năng ngoài phạm vi UI.
