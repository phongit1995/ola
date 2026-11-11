# 06 — Kế hoạch làm lại bàn chơi (UI v4: cảnh pixel, UI mượt)

Chốt 11/11/2026: **cảnh pixel, UI mượt** (giữ nguyên tắc 2 trong `README.md`). Thử bản pixel toàn bộ rồi bỏ: khung, nút, chữ và modal quay về kiểu mượt (Nunito, bo tròn, viền navy); chỉ tranh ô, nền trời và vài chi tiết trên bàn (cờ, lồng đèn) là pixel. Giữ lại phần bố cục, modal gọn, animation và nhịp chơi của đợt làm lại. Logic `logic/engine.ts` không đổi.

## Quyết định đã chốt

| Việc | Chốt |
|---|---|
| Phong cách | Cảnh pixel (tranh ô, nền, cờ chủ, lồng đèn lễ hội); UI mượt: nút, sheet, modal, chữ, xúc xắc, hạt hiệu ứng |
| Font | Nunito như cũ, không thêm font pixel |
| Ảnh đã có | Giữ nguyên: 20 tranh ô, nền trời, logo, nhân vật, minh hoạ luật và sảnh, app icon |
| Modal, sheet | **Nhỏ gọn**: sheet tối đa ~56% màn (sheet dài 72%), modal rộng tối đa 320 px, không chữ phụ nhồi trong nút |
| Ảnh mới | Codex Astra, nháp ở `~/Desktop/co-ty-phu-astra/`; quân, nhà, minh hoạ thẻ vẽ phẳng viền navy (`assets/art/`); cờ và lồng đèn pixel (`assets/pixel/`) |
| Bảng ảnh | `components/art.ts` là chỗ duy nhất đổi ảnh quân / nhà / thẻ |
| Quân cũ `assets/tokens/tk-*.webp` | Không dùng, giữ file |

## Vấn đề của bản cũ (đo 11/11/2026)

- Bàn chỉ chiếm 43% chiều cao ở 390×844; trời trống ~80 px phía trên, khung nhật ký 130 px trắng đầu ván.
- Lượt của ai báo ở 4 chỗ, sự kiện báo ở 5 chỗ.
- Sở hữu ô chỉ là viền 2 px + chấm 6 px; giá mua và tiền thuê cùng dạng "xx tr"; nhà là icon xanh bé đè lên tranh.
- Quân là con tốt chung chung, che tên và nhà của ô.
- Một lượt máy 6–8,5 s (docs 08 đặt ≤ 4 s); 3 máy ~23 s mới tới lượt mình; băng rôn chặn 0,85–1,3 s mỗi lượt.
- ~10 họ nút + 5 kiểu nút đóng; 209 mã hex viết cứng trong `style.css`.
- Animation tìm phần tử bằng id rồi animate thẳng node React; thời lượng rải rác, không tua/bỏ qua được.

## Giai đoạn 0 — Nền

- [x] Tách CSS: `ui.css` (token `--ui-*`, nút, chip, xu, avatar, modal, sheet, segmented), `board.css` (bàn, dock, sheet, hộp nợ, kết quả); `style.css` giữ sảnh, phòng, toast.
- [x] Đồng xu vẽ bằng CSS (`.ui-coin`), icon dùng bộ `TyIcon` có sẵn.

## Giai đoạn 1 — Component dùng chung

- [x] `components/Ui.tsx`: `UiButton` (vàng / giấy / đỏ / xanh lá / xanh dương; lg-md-sm; nhấn lún; khoá; giá thành `MoneyBadge` cạnh chữ), `UiIconButton`, `MoneyBadge`, `UiAvatar`, `UiModal`, `UiSheet`.
- [x] Bàn chơi, sheet, hộp nợ, thông báo, kết quả dùng chung các component này.
- [ ] Sảnh, phòng, lịch sử, xếp hạng: đổi sang `UiButton` (hiện vẫn là họ nút cũ).

## Giai đoạn 2 — Bàn chơi

- [x] Bàn chiếm 55–60% chiều cao, căn giữa theo chiều dọc giữa header và dock; header gọn (vòng · giờ, âm thanh, menu ⋯); giữa bàn chỉ một thứ mỗi lúc; nút hành động ở dock dưới; một dòng sự kiện ở đáy.
- [x] Bỏ dải màu nhóm trên ô (11/11, user chốt) để tranh thành phố to như bản cũ; màu nhóm chỉ còn ở modal/sheet. "Giá" và "Thuê" khác kiểu (thuê là viên màu chủ).
- [x] Ô có chủ: cờ pixel tô màu ghế.
- [x] Nhà / biệt thự / khách sạn: hình vẽ phẳng ở mép trong ô.
- [x] 4 quân mới (xích lô, nón lá, trâu, xe máy), đế màu ghế, mũi tên quân đang đi.
- [x] Xúc xắc vẽ bằng code, chấm tròn.
- [x] Thẻ Cơ hội/Khí vận có minh hoạ theo tác dụng.
- [x] Lễ hội: lồng đèn pixel.
- [x] Khung người chơi: màu ghế, avatar + quân mini, tiền, số ô, icon tù / thẻ ra tù.

## Giai đoạn 3 — Modal và sheet (nhỏ gọn)

- [x] Hỏi mua / mua lại: modal giữa màn (`BuyModal`) có tranh ô, giá, chấm nhóm, bậc thuê; mua lại ghi rõ nhận luôn nhà cấp mấy; dock chỉ nhắc "Mua ô này?". Sheet ô của người khác chỉ hiện "Đáp vào trả" và "Mua lại".
- [x] Sheet ô đất: cầu thang 4 nấc thuê có hình nhà, nút Hạ / Nâng.
- [ ] Làm nổi ô đang xem trên bàn khi mở sheet.
- [x] Sheet tài sản: 3 ô số, nhóm theo màu, mỗi dòng có Lv + tiền thuê hiện tại; nút Hạ (+tiền nhận) / Nâng (giá) chỉ hiện khi trọn nhóm.
- [x] Chọn cấp muốn nâng hoặc hạ: chạm bậc trong sheet ô đất (bậc hạ tô đỏ, `sellPlan` hạ đều cả nhóm), nút Hạ ghi số tiền nhận lại; `buildPlan` (logic/rules-hint.ts) tính chuỗi nước BUILD nâng đều cả nhóm, `sendMoves` gửi một lần và diễn liền; nút ghi tổng giá + dòng "Nâng đều cả nhóm: …".
- [x] Hộp nợ: số nợ to, thanh tiền / bán nhà, danh sách bán thẳng cột, "Bán tự động và trả" là nút chính, Phá sản phụ có xác nhận.
- [x] Xác nhận / thông báo, kết quả (bục 1-2-3 với quân), menu ⋯ (tốc độ, tự kết thúc lượt, về sảnh, bỏ cuộc).

## Giai đoạn 4 — Animation

- [x] Easing mượt dùng chung (`--ui-spring`, `--ui-out`); modal bật, sheet trồi; không dùng `steps()`.
- [x] Bộ điều nhịp chung (`fx/runtime.ts`: `setTempo`, `scaled`): máy ×1,8; người chơi chọn ×1/×2; chạm bàn để bỏ qua.
- [x] Băng rôn chỉ lượt của mình; xúc xắc ~0,9 s; đi 112–140 ms/ô (chia theo nhịp).
- [ ] Lượt máy ≤ 3,5 s mọi trường hợp: đo 11/11 được 2,7–5,4 s (trước 6–8,5 s); lượt có đôi hoặc thẻ còn dài.
- [ ] Dẫn mắt theo quân: giữa bàn mờ khi quân đi, bong bóng kết quả cạnh ô vừa đáp.
- [x] Nhãn nổi trên ô (luôn nằm trong màn, nhãn mới thay nhãn cũ cùng ô): trả thuê (số tiền), bị mua lại ("… mua lại ô của bạn", đỏ), nâng / hạ nhà (của mình và người khác): nhãn nổi trên ô gồm hình nhà + "Nâng cấp Lv x → Lv y" (hạ cấp số màu đỏ); nâng nhiều cấp liền thì gộp một thông báo mỗi ô; bong bóng giữa bàn và diễn biến cùng dạng.
- [x] Trọn nhóm có băng rôn "TRỌN NHÓM!" + pháo giấy; khách sạn rung + vòng sáng; phá sản giữ hiệu ứng cũ.
- [x] Cảnh báo khi một người còn 1 ô là thắng ngay (`winThreats`): viền nét đứt nhấp nháy màu người đó trên ô còn thiếu + thông báo "… chỉ còn thiếu X là thắng"; khi thắng ngay, các ô thắng sáng lên + băng rôn "… THẮNG!" 2,4 s rồi mới hiện kết quả.
- [x] Phá sản: modal "Bạn phá sản" ghi nợ ai, bao nhiêu, tiền mặt + bán nhà được bao nhiêu, rồi mới sang chế độ xem.
- [x] Dock lượt của mình khi quân đang chạy: avatar + "Bạn đang đi" thay vì "…".
- [x] Xu bay người trả → người nhận; mua đất thì ô lật + cắm cờ.

## Giai đoạn 5 — Thao tác

- [x] Tự kết thúc lượt khi không còn việc (đếm 2 s, tắt được trong menu).
- [x] Chạm ô trên bàn để nâng cấp.
- [x] Lễ hội / Du lịch: ô chọn được nhấp nháy trên bàn, chạm ô rồi xác nhận trong sheet.

## Giai đoạn 6 — Kiểm tra

- [ ] `game/scripts/tycoon-shots.mjs`: bơm trạng thái giữa ván, chụp mọi màn và modal ở 360 / 390 / 430.
- [ ] Đo nhịp: báo lỗi nếu lượt máy > 3,5 s.
- [ ] Android cấu hình thấp; `prefers-reduced-motion`; lint.
- [x] Typecheck, test tycoon, build xanh (11/11).

## Ảnh mới (Codex Astra)

| Nhóm | Số lượng | Kiểu | Thư mục |
|---|---|---|---|
| Quân: xích lô, nón lá, trâu, xe máy | 4 | Phẳng, viền navy | `assets/art/pawn-*` |
| Nhà, biệt thự, khách sạn | 3 | Phẳng, viền navy | `assets/art/house-*` |
| Minh hoạ thẻ: tiền vào, tiền ra, đi tới ô, sân bay, vào tù, thẻ ra tù, sửa nhà, sinh nhật | 8 | Phẳng, viền navy | `assets/art/card-*` |
| Lồng đèn, cờ trắng (tô màu bằng code) | 2 | Pixel | `assets/pixel/fx-*` |

Quy trình: nền `#00FF00` → tách nền mềm (alpha theo độ trội xanh, khử viền xanh) → cắt theo vùng liền → thu nhỏ lanczos (cạnh dài 160–192 px) → webp. Ảnh pixel thì thu nhỏ nearest về lưới. Xúc xắc, nút, đồng xu, bụi vẽ bằng code.

## Definition of Done

1. Mọi màn / overlay có ảnh chụp ở 360 và 390.
2. Không mã màu ngoài token trong code mới.
3. Không chữ trong ảnh raster (trừ logo).
4. Lượt máy đo được ≤ 3,5 s ở tốc độ mặc định.
5. Docs trong thư mục này cập nhật cùng lúc với code.
