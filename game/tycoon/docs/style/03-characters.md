# 03 — Dàn nhân vật

Sáu nhân vật mascot, sáng tác riêng, không mô phỏng người thật hay nhân vật thương mại nào. Vai trò: làm sự kiện trong ván có "mặt" (ai thu tiền, ai bắt vào tù, ai mừng bạn qua Xuất phát), không làm nền và không thay icon điều khiển.

## 1. Quy tắc chung

- Phong cách: flat vector, contour navy `#1F2A44` dày đồng nhất (≈ 3 px ở canvas 256), 2–3 màu phẳng/nhân vật + 1 vùng highlight sáng hơn 12%, không gradient, không đổ bóng ngoài.
- Tỷ lệ: 2.5 đầu (đầu to, thân ngắn) để đọc được ở 30 px; mắt là 2 chấm navy, miệng 1 nét; không răng, không chi tiết nhỏ hơn 4 px ở canvas 256.
- Mỗi nhân vật có **4 pose**: `idle`, `happy`, `sad`, `point`. Thêm pose mới phải cập nhật bảng §2 và manifest.
- Mỗi pose 2 biến thể crop: `full` (toàn thân, 256 × 256) và `bust` (đầu + vai, 128 × 128). Bust dùng trên ô góc và pod badge; full dùng ở sheet/thẻ/modal/kết quả/lobby.
- File: `assets/chars/{char}-{pose}-{crop}.webp`, nền trong suốt thật. Ví dụ `chars/loc-happy-bust.webp`.
- Không chữ, không ký hiệu tiền trên người nhân vật (tiền là icon riêng bên cạnh).
- Nhân vật không bao giờ đứng sau chữ; vị trí cố định trong component (02-board-tiles §5, §4 dưới đây).

## 2. Dàn nhân vật

| id | Tên | Vai trò trong game | Màu chính | Màu phụ | Highlight | Nhận diện silhouette |
|---|---|---|---|---|---|---|
| `ty` | Bác Tỷ | mascot chính, "chủ trò" — lobby, thẻ Cơ hội, hạng 1 | áo bà ba gold `#F2B807` | quần navy, da `#F3C9A0` | kính tròn cream | bụng tròn, kính tròn, quạt giấy (mở nhẹ ở idle S2 theo ảnh đã chọn) |
| `ngan` | Cô Ngân | ngân hàng — thu thuế, trả lương, Khí vận, modal trả nợ | áo dài jade `#1F8A5B` | tóc navy, da `#F3C9A0` | nơ cream | tóc búi, cầm sổ cái |
| `canh` | Chú Cảnh | cảnh sát — step jail-in (thẻ Vào tù, đôi 3 lần) | áo cream `#FFF8EA` | mũ navy, còi coral `#E4573D` | — | mũ kê-pi, tay cầm còi |
| `teo` | Anh Tèo | tù nhân hài — ô Nhà tù, pod badge trong tù | áo sọc cream/navy | tóc nâu `#8D5B3C` | — | sọc ngang, cổ áo tròn, mặt méo |
| `loc` | Bé Lộc | may mắn — ô Xuất phát, +200, thẻ tiền vào | áo đỏ `#D64545` | lì xì gold | má hồng `#E58FB5` | nhỏ nhất dàn, tay giơ lì xì |
| `dau` | Mèo Đậu | vui — ô Lễ hội, trạng thái chờ người khác | lông cam `#F2994A` | sọc nâu `#8D5B3C` | mũi hồng | tai tròn, đuôi cong, mắt híp |

Màu chính của nhân vật trùng accent/nhóm đất là cố ý (6 nhân vật = 6 họ màu, không thêm họ mới); contour navy giữ họ nhất quán. Không nhân vật nào dùng sky (dành riêng cho dải Khí vận để thẻ không bị "đồng màu").

## 3. Pose

| Pose | Mô tả | Dùng khi |
|---|---|---|
| `idle` | đứng thẳng, tay buông/cầm đạo cụ, miệng cười nhẹ | header sheet, lobby, mặc định |
| `happy` | hai tay giơ, mắt cong, miệng mở | +tiền, qua Xuất phát, hạng 1, mua xong |
| `sad` | vai xệ, miệng cong xuống, một giọt mồ hôi | −tiền, trả nợ, phá sản, hạng cuối |
| `point` | một tay chỉ sang phải, mặt nghiêm | hướng dẫn (ĐẾN LƯỢT BẠN, Vào tù, thuế, lý do disabled) |

Pose `point` luôn chỉ **sang phải**; đặt nhân vật bên trái nội dung. Cần chỉ trái thì `transform: scaleX(-1)` ở CSS (đạo cụ đối xứng được chấp nhận).

## 4. Nơi xuất hiện và kích thước

| Nơi | Nhân vật | Pose | Crop | Size (390) |
|---|---|---|---|---|
| S2 lobby, trái cụm thẻ dưới logo | Bác Tỷ | idle | full | hình nhìn thấy cao 176; màn thấp 144, theo [style S2 lobby](./screens/s2-lobby/README.md) |
| S2 lobby, lỗi kết nối | Bác Tỷ | sad | full | 96 |
| Ô 8 Nhà tù (UI v3) | Anh Tèo | vẽ pixel sẵn trong tranh `art/nha-tu` | — | theo tranh |
| S7 header | theo kind (02 §5) | idle/point | full | 64 |
| O2 thẻ Cơ hội | Bác Tỷ | happy nếu +tiền/di chuyển, sad nếu −tiền, point nếu vào tù | full | 72, góc trái dưới thẻ |
| O2 thẻ Khí vận | Cô Ngân | như trên | full | 72 |
| O3 trả nợ | Cô Ngân (nợ ngân hàng) / avatar chủ nợ (nợ người) | point | full | 64 |
| Step `pay` reason tax/fine/repair | Cô Ngân | point | bust | 24, bay cùng chip tiền |
| Step `jail-in` | Chú Cảnh | point | bust | 32, hiện 800 ms cạnh ô 8 |
| Pod badge trong tù | Anh Tèo | sad | bust | 14 (thay `ic-jail-bars` khi nhân vật bật) |
| Turn announce ĐẾN LƯỢT BẠN | Bác Tỷ | point | bust | 40 |
| Chờ người khác (bar) | Mèo Đậu | idle | bust | 24 |
| S9 kết quả hạng 1 | Bác Tỷ | happy | full | 96 |
| S9 phá sản/hạng cuối | Bé Lộc | sad | full | 80 |
| Empty state lịch sử | Mèo Đậu | idle | full | 96 |
| Toast lỗi | Chú Cảnh | point | bust | 20 |

Tổng file: 6 nhân vật × 4 pose × 2 crop = **48 webp**. Ước lượng 4–8 KB/full, 2–3 KB/bust → ≈ 260 KB. Preload: UI v3 không còn bust trên ô góc; các pose khác idle batch; lobby chỉ cần `ty-idle-full`.

Cắt giảm nếu budget căng: bỏ crop `bust` của Bác Tỷ/Cô Ngân pose sad (không dùng), còn 44 file.

## 5. Prompt sinh

Base (nối với prompt base ở `../04-asset-manifest-and-prompts.md` §6): "ONE cute flat vector mascot character, 2.5-heads-tall chibi proportion, thick uniform navy (#1F2A44) contour, 2–3 flat colors with a single lighter highlight area, two dot eyes and one-line mouth, centered, filling 85% of a square canvas, genuinely transparent background, no text, no shadow, no ground".

| id | Prompt riêng |
|---|---|
| ty | "a jolly round-bellied Vietnamese uncle in a golden (#F2B807) ba-ba shirt and navy trousers, round cream glasses, holding a paper fan" |
| ngan | "a calm young woman in a jade (#1F8A5B) ao dai, hair in a bun with a cream bow, holding a ledger book" |
| canh | "a friendly traffic police officer in a cream shirt and navy kepi cap, holding a coral (#E4573D) whistle" |
| teo | "a comical prisoner in cream and navy horizontal stripes, messy brown hair, round collar, lopsided grin" |
| loc | "a small toddler in a red (#D64545) festive shirt with pink cheeks, raising a golden lucky-money envelope with both hands" |
| dau | "a plump orange (#F2994A) tabby cat with brown stripes, round ears, squinting content eyes, curled tail" |

Pose thêm vào cuối: `idle` "standing straight, slight smile"; `happy` "both arms raised, eyes curved, open smile"; `sad` "slumped shoulders, downturned mouth, one sweat drop"; `point` "pointing to the right with one arm, serious face". Bust sinh riêng với "head and shoulders only, filling 90% of canvas" — không crop từ full để contour không bị cắt.

Riêng `ty-idle-full` dùng ở S2: thêm "paper fan partly open, matching the selected lobby mascot silhouette" và tham chiếu [concept lobby đã chọn](./screens/s2-lobby/concept-s2-lobby-pixel-16bit.png); giữ nguyên palette/contour, không lấy chữ hoặc hoa văn ký hiệu tiền trên áo trong ảnh AI.

Mỗi lần sinh ghi log theo `../asset-generation-log.template.md`; QA: 6 nhân vật xếp cạnh nhau ở 30 px phải phân biệt được bằng silhouette khi chuyển grayscale.

## 6. Fallback và tắt nhân vật

- Store flag `charsEnabled` (mặc định true; tắt khi preload nhóm chars lỗi hoặc `navigator.deviceMemory < 2`).
- Khi tắt: ô góc dùng glyph `tg-*` 26 px; header sheet dùng glyph 40 px; thẻ bài không có nhân vật; pod badge dùng `ic-jail-bars`. Mọi vị trí phải có fallback để UI không trống.
- Không có nhân vật nào là bắt buộc cho gameplay; test E2E chạy với `charsEnabled=false`.
