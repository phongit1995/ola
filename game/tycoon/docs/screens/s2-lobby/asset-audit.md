# S2 — kiểm ảnh nguồn và phần còn thiếu

Kiểm ngày **2026-10-21**, đối chiếu trực tiếp [concept đã duyệt](./concept-s2-lobby-pixel-16bit.png), toàn bộ [13 PNG nguồn v1](../../../assets/screens/lobby/README.md), [prompt đã chạy](../../../assets/screens/lobby/prompts.md) và UI hiện tại. Hash của 13 PNG khớp [manifest](../../../assets/screens/lobby/manifest.json). §1–4 ghi audit v1 và các bước sửa UI sau đó. **Đợt tách lại v2 và đính chính mới nhất ở §5**; chưa phải duyệt visual QA runtime.

**Kết luận:** bộ gen giữ được chủ đề và các vật thể chính, nhưng là ảnh AI tái dựng, không phải cắt giữ nguyên pixel. Có chi tiết bị đổi ngay trong PNG; có chi tiết đã bị prompt loại bỏ mà chưa có lớp thay thế; còn viền kép và nút phẳng là lỗi dựng CSS. Không dùng kết quả typecheck hoặc số lượng file để kết luận giống concept.

## 1. Đối chiếu từng PNG

Các tỷ lệ dưới đây tính trên **phần hình nhìn thấy**, không tính khoảng alpha quanh canvas. Những mục ghi giữ không có nghĩa đã đạt QA toàn màn.

| PNG | Kết quả đối chiếu | Việc cần làm |
|---|---|---|
| `background.png` | Giữ khá sát trời cyan, mây ở rìa, phố/sông/cầu ở đáy; không còn UI. Phần đường dưới footer đã được dựng bù, một số nét cảnh có độ mềm do tái dựng. | Giữ bố cục này. Kiểm pixel ở 100% và tại cỡ render; không gen lại toàn cảnh chỉ để đổi nút. Không thêm tia trang trí vào nền. |
| `logo.png` | Có title, crown và die đúng nhóm; độ dày viền, highlight và dáng chữ đã được tái dựng. | Giữ để kiểm lắp ghép; đối chiếu dấu tiếng Việt, silhouette và kích thước phần nhìn thấy. Logo nhỏ trong UI còn phụ thuộc khung contain/padding, không mặc định là thiếu asset. |
| `mascot.png` | Đủ đầu, kính, quạt, áo vàng, quần navy và dép; tư thế gần mẫu. Họa tiết áo, khuy, lọn tóc và shading đã được vẽ lại. | Nếu sửa ảnh, giữ mặt/tư thế/quạt và họa tiết gần concept; không tự đổi thành áo phẳng chỉ vì guideline chung. Bỏ bóng elip là ngoại lệ đã ghi trong README S2, không phải phần bị quên. |
| `hero-properties.png` | Đúng 3 thẻ đỏ/xanh dương/xanh lá và 2 quân vàng/xanh. Phối cảnh, tương quan quân/thẻ và chi tiết tranh có thay đổi; không có tia trắng. | Giữ nhóm 5 vật thể ở bước lắp ghép, so lại tỷ lệ trước khi đổi ảnh. Bổ sung lớp tia trắng riêng; chỉ tách quân/thẻ nếu cần animate. |
| `icon-dice.png` | Vẫn là xúc xắc trắng viền navy, nhưng góc nhìn, vị trí chấm và độ bóng đã thay đổi so với icon trên CTA mẫu. | Khi sửa, dùng đúng crop xúc xắc CTA làm nguồn; không lấy xúc xắc trong logo và không tự thiết kế lại mặt chấm. |
| `icon-history.png` | Đúng đồng hồ + mũi tên xanh; kim, tâm đồng hồ và highlight dày/bóng hơn mẫu. | Giảm chi tiết nổi thêm, giữ hướng mũi tên và độ gọn của mẫu; so ở cỡ hiển thị 40 px. |
| `icon-leaderboard.png` | Đúng 3 cột và crown, nhưng bo góc/highlight khác; nghi quầng xanh ở lần xem đầu, xem đính chính §5. | So contour/crown và composite trên trắng, kem, cyan; không coi RGB ẩn dưới alpha = 0 là glow. |
| `icon-rules.png` | Đúng sách mở, nhưng dáng sách bè ngang hơn mẫu, bìa và gáy khác; nhận xét quầng ban đầu được đính chính ở §5. | Sửa tỷ lệ sách; không kéo méo PNG trong CSS để bù tỷ lệ. Kiểm mép bằng compositing. |
| `icon-exit.png` | Cửa cam và mũi tên hướng phải đúng hướng trong concept; nét được làm dày và bóng hơn. | Giữ hướng. Bỏ ghi chú cũ “đổi chỉ ra ngoài”: đó là đề xuất thay thiết kế, không phải lỗi so với ảnh đã duyệt. |
| `icon-ken.png` | Có đồng xu/crown đúng motif; rim và các vệt sáng được làm đậm hơn. | Giữ để so tại 24 px, tránh để highlight làm mất silhouette crown. Không cần gen lại chỉ vì số KEN là DOM text. |
| `icon-sound.png` | Có loa navy và hai sóng; chưa có bản off trong bộ PNG. | Runtime hiện dùng cặp `ic-volume-on/off` có sẵn, nên không bị thiếu chức năng. Nếu chuyển sang artwork này mới cần cặp on/off cùng nét. |
| `button-gold.png` | Có vệt sáng trắng, mặt vàng và cạnh cam đúng hướng; không có tia vàng ngoài nút. Tỷ lệ visible bounds alpha ≥128 khoảng **4,13:1**, trong khi khung CTA 280 × 80 là **3,5:1**. | Không coi là skin đúng tỷ lệ để import nguyên. CSS/SVG phải dựng lại mặt, highlight và cạnh theo concept; nếu dùng raster thì sửa tỷ lệ hoặc chia lát, không kéo dãn tùy ý. Tia ngoài nút là lớp riêng. |
| `button-paper.png` | Gần mẫu hơn: một contour navy, mặt kem, cạnh beige bên trong và bóng xanh phía dưới; tỷ lệ visible bounds khoảng **4,96:1**, gần khung 280 × 56. | Dùng làm mẫu surface. Không chồng thêm border + outer spread-shadow navy tạo viền kép. File này hiện không được runtime import. |

## 2. Thiếu lớp nào, vì sao thiếu

Prompt lịch sử của `button-gold` có câu `Remove sky, external floating yellow rays`; prompt `hero-properties` có `Remove all cyan sky, white sparkle rays`. Background cũng yêu cầu bỏ sparkles. Bộ 13 PNG không chứa hai lớp decor này; sau audit, code đã bổ sung hai SVG riêng như bảng dưới.

| Phần thiếu | Đích triển khai đã chọn | Điều kiện đối chiếu |
|---|---|---|
| Tia vàng CTA | `lobby/decor-cta-rays.svg`, **đã tạo**; một cụm 2 tia, dùng hai bên bằng mirror | Tổng 4 tia vàng đặc, 2 trái + 2 phải. Ở mốc 390 px, mỗi cụm khoảng 20 × 36 px, cách mép nút khoảng 10 px; theo góc/mức xòe trong concept. Tia nằm ngoài nút, không biến thành icon trong nút. |
| Tia trắng hero | `lobby/decor-hero-rays.svg`, **đã tạo**; nhóm vector theo tọa độ hero | Cụm 3 tia cạnh quân vàng và cụm 3 tia (nhỏ – cao – nhỏ) phía phải quân xanh như concept; nằm trên nền trời, không phủ mặt quân/thẻ. |

Hai nhóm trên là nét hình học đơn giản: dựng SVG code-native theo concept, không cần gen lại cả nút hay cả hero. `aria-hidden`, `pointer-events: none`; đứng yên mặc định, không thêm chớp sáng. Ghi là SVG đã tạo, không tính vào số PNG hoặc coi việc tạo file là đã duyệt visual QA.

## 3. Phần phải sửa ở UI, không quy lỗi cho PNG

| Hiện trạng code | Đặc tả đúng theo ảnh |
|---|---|
| CTA chỉ có gradient vàng và shadow nâu | Thêm dải highlight trắng theo cung trên, điểm sáng hai đầu, cạnh cam bên trong và mép tối ở đáy. Không thêm vòng outline trắng khép kín. |
| Nút kem có `border` rồi thêm shadow navy có spread 1.5 px | Một contour navy ngoài cùng; cạnh beige nằm **bên trong** contour, bóng xanh đổ xuống ngoài nút. Không có hai đường navy song song ngăn bởi khe kem. Kiểm ở trạng thái không focus; focus ring bàn phím vẫn phải có. |
| “Luật chơi” có pill paper mờ | Bỏ surface/viền/shadow của action chữ; giữ sách + nhãn gạch chân, vùng chạm ít nhất 44 px. Màn thấp phải chỉnh khoảng trống/nền cảnh để chữ đọc được, không tự thêm pill. |
| Logo/cụm thẻ nhìn nhỏ hơn mẫu | Đối chiếu phần hình có alpha và khoảng trống trong asset, không chỉ kích thước `<img>`. Không ép sai tỷ lệ. |

**Cập nhật 2026-10-21 (sau audit):** đã dựng bước 1 trong code: 2 SVG tia, mặt CTA (mặt vàng hai tông, highlight trắng hở theo cung trên, điểm sáng hai đầu, cạnh cam trong, viền nâu), nút kem một contour navy + cạnh beige trong + bóng xanh, Luật chơi không nền. Khung lobby sau đó được chỉnh cao đúng một màn như caro (không cuộn, hero co lại trên màn thấp); Luật chơi có viền sáng paper để đọc trên cảnh phố. Focus chỉ dùng outline navy. Chưa qua visual QA; mục logo/cụm thẻ và bước 2–3 vẫn mở.

Avatar VIP, `@username`, số dư thật, font Nunito, bỏ version ở footer và việc bỏ bóng elip của mascot là các khác biệt chủ động đã ghi trong [README S2](./README.md). Chúng không cho phép tự bỏ tia, làm phẳng mặt nút hoặc thêm viền kép. Riêng họa tiết/shading trên áo S2 giữ theo concept, là ngoại lệ trong màn này so với style nhân vật phẳng dùng chung.

## 4. Thứ tự sửa và tiêu chí kết thúc

1. **Sửa spec và dựng các lớp thiếu:** 2 nhóm tia, surface CTA, một contour nút kem, action Luật chơi không pill. Những việc này chưa cần gen lại ảnh.
2. **Sửa ảnh sai rõ:** icon sách và BXH (quầng/tỷ lệ), xúc xắc và đồng hồ (chi tiết bị tái dựng), mascot nếu đối chiếu gần còn lệch đáng kể. Mỗi lần chỉ sửa một asset với concept/crop đúng làm chuẩn; giữ prompt cũ làm lịch sử.
3. **Xuất và kiểm lại:** cập nhật PNG/hash khi thực sự đổi ảnh, xuất WebP, chụp UI ở 390 × 844 và 360 × 640. So mặt nút/viền/tia ở trạng thái default và pressed; kiểm focus riêng. Xem alpha trên trắng, kem, cyan, navy ở cỡ gốc và cỡ hiển thị.

- [ ] Đủ 4 tia vàng CTA và hai cụm tia trắng hero, không bị clip ở 360 px.
- [ ] CTA có highlight + cạnh cam; nút kem chỉ một contour; Luật chơi không pill.
- [ ] Không còn quầng xanh ngoài icon; không đổi hướng icon thoát.
- [ ] Phần nhìn thấy của logo/mascot/thẻ và tỷ lệ skin đã được so với concept, không chỉ kiểm canvas.
- [ ] Lưu kết quả visual QA mới; trạng thái `trial-not-production` chỉ đổi sau khi kiểm thật. Có WebP/build chạy được không đồng nghĩa đã duyệt mỹ thuật.

## 5. Tách lại v2 và lựa chọn cuối

Sau audit, 10 asset được gen lại bằng built-in imagegen (các icon thêm một lượt sửa nét). Ngày **2026-10-21** đã so từng file v1/v2 cạnh crop concept trên nền trời; **chọn v2 cho 8 file và thay v1** trong [`assets/screens/lobby/`](../../../assets/screens/lobby/README.md). Nền, logo, thoát, KEN, loa giữ v1. Thư mục tách lại tạm và các trang preview đã bỏ; tóm tắt lượt v2 ở [prompts.md](../../../assets/screens/lobby/prompts.md#lượt-v2-2026-10-21--đã-chọn).

| Asset | Lý do chọn v2 |
|---|---|
| Xúc xắc | Đúng **3–2–1** (mặt lớn trên / trái / phải), chấm phẳng như CTA; v1 sai số chấm, chấm bóng. |
| Đồng hồ | Kim gấp khúc **không chấm tâm**; v1 có chấm tâm và bóng dày. |
| BXH | Crown nhỏ viền nâu, cột gọn như mẫu; v1 crown to, bóng hơn. |
| Sách | Dáng gọn ~1,37:1, dòng xám như mẫu; v1 bè ngang ~1,6:1, dòng xanh. |
| Thoát | **Giữ v1** theo quyết định người dùng; bản v2 tách cửa + mũi tên đỏ viền kem đã bỏ. |
| Mascot | Họa tiết áo dạng đồng xu gần nguồn hơn; mặt/kính/quạt/tư thế tương đương v1. |
| Hero | Tỷ lệ quân/thẻ và vị trí quân xanh trên thẻ giữa gần mẫu hơn. Tọa độ `decor-hero-rays.svg` đã chỉnh theo khung WebP mới 468 × 264. |
| Skin vàng / kem | Vàng visible **3,50:1** (v1 4,13:1); kem một contour 4,87:1. Vẫn chỉ là mẫu surface cho CSS. |

**Đính chính quầng:** một số màu ngoài hình nằm dưới alpha = 0; viewer xem RGB riêng có thể hiện haze không tồn tại khi composite. Kết luận viền phải dựa trên ảnh đã ghép nền.

**Còn khác nguồn:** nét mặt/tóc/khuy áo và một số chi tiết tranh/phối cảnh hero vẫn do AI tái dựng; không phải bản cắt trùng pixel. Prompt của lượt sửa nét các icon v2 không được lưu. Checklist §4 vẫn chờ visual QA runtime.

## 6. Modal Chơi với máy — asset v2

Ngày **23/10/2026**. Đối chiếu 10 SVG ở `assets/bot-setup/` ([danh sách](./README.md#asset-của-modal)) với [ảnh 1 bot](./modal-bot-01-one-bot.webp) / [3 bot](./modal-bot-02-three-bots.webp) (935 × 1683, không sửa ảnh). **Đã sửa các sai lệch của lượt v1:** màu cộng/trừ, hai bản xám, màu X, dáng và màu hai người; thêm bốn nền nút riêng. Robot và VIP giữ nguồn gốc. Đã dùng trong `BotSetupModal` (23/10/2026).

Cách kiểm: render 14 cặp / 28 ảnh bằng Chrome, canh theo alpha > 8 của file và phần nhìn thấy trong concept, giữ tỷ lệ. Ảnh so sánh, HTML và số đo dựng local trong `output/tycoon-bot-modal-assets/`, không lưu trong repo.

### Kết quả sau sửa

| Phần | Đã sửa / giữ | Kết quả và giới hạn |
|---|---|---|
| Robot WebP + PNG nguồn | Giữ cùng robot nút sảnh | Đúng nguồn theo 02 §2.3; concept AI có mắt/mặt hơi khác, không đổi robot chung để chạy theo biến dạng AI |
| VIP 001–003 | Giữ file shared | Đúng danh tính theo docs; concept vẽ lại vài chi tiết khuôn mặt/mũ |
| X | Thêm `close-navy.svg`, màu `#010636`; giữ hình học X đậm | Màu sát mẫu, không ảnh hưởng X ở S4; nền tròn vẫn thuộc CSS |
| Cộng active | Đổi xanh lá đậm sang xanh ngọc, nét gần trắng, shading nhẹ | Hình tròn, dấu cộng bo tròn và màu đã gần mẫu |
| Trừ active | Đổi cam sang coral đỏ hồng, chỉnh nhẹ độ dài dấu trừ | Không còn lệch tông cam; giữ nút trừ, không dùng X/thùng rác |
| Hai bản disabled | Tách xám cộng `#9ea0aa` và trừ `#b2b6be` | Cùng hình học với active; xám cộng đậm hơn xám trừ như hai ảnh |
| Hai người | Vai bớt vòm, thân phải nhỏ hơn, đổi hai sắc xanh | Dáng và màu gần mẫu hơn; cạnh vector sạch, không giữ nhòe/texture AI |
| Mint | Nền SVG riêng, mặt mint nhẹ, viền jade, cạnh dưới xanh vừa | Không còn gradient mạnh và viền navy của PNG lobby |
| Mint disabled | Thêm nền SVG xám cùng hình học với mint | Đủ trạng thái 3 bot, không phải lấy nền active rồi làm mờ cả ảnh |
| Paper | Nền SVG riêng, mặt kem, viền beige/nâu, cạnh kem | Đã bỏ dải xanh và viền navy của PNG lobby |
| Gold | Nền SVG riêng, vàng trên/cam dưới, highlight nhỏ góc trái | Đã bỏ đốm sáng lớn hai đầu và dải trắng dày của PNG lobby |

Bốn nền SVG không chứa nhãn hay icon. Kích thước thiết kế là 304 × 44 (mint/disabled) và 160 × 52 (paper/gold). Mẫu dùng tỷ lệ AI; khi dựng layout co giãn phải giữ kích thước theo 02 §2.3 và chuyển bề mặt sang CSS theo palette/SVG, không kéo dãn sai góc bo/viền.

### Kiểm màu sau sửa

Đo trung vị RGB trên ô 7 × 7 bên trong vùng màu của concept, tránh nét trắng/biên. File SVG được render bằng Chrome, lấy vùng tương ứng bên trong hình; vì có shading rất nhẹ nên màu giữa gradient và từng điểm có thể lệch 1 đơn vị. Không dùng các ô mẫu này để tuyên bố trùng toàn ảnh.

| Vùng | V1 | Concept | V2 render |
|---|---|---|---|
| Cộng active | `#1f8a5b` | `#14a774` | `#15a875` |
| Trừ active | `#e4573d` | `#f26b64` | `#f26c65` |
| Cộng disabled | `#a8adb6` | `#9ea0aa` | `#9ea0aa` |
| Trừ disabled | `#a8adb6` | `#b2b6be` | `#b2b6be` |
| Người xanh đậm | `#395a8c` | `#3c5994` | `#3c5994` |
| Người xanh nhạt | `#8cafcf` | `#90b0da` | `#90b0da` |

V1 dùng token chung, dẫn tới lệch màu. V2 dùng palette riêng cho artwork modal: 02 §2.3 đã đổi viền Thêm bot sang jade; token game và nền/icon các màn khác không đổi.

### Giới hạn của lần kiểm

Các sai lệch rõ đã được xử lý ở cấp asset. SVG là bản dựng hình học, không tái tạo nhiễu, shading không đều và nét méo trong ảnh AI. Robot/VIP gốc vẫn khác nhẹ hình AI theo ngoại lệ docs. Bảng asset không chứng minh cả modal giống ảnh; modal runtime đã chụp đối chiếu riêng ở 390 × 844 và 360 × 640 (S2 §11).

Khung, nền tròn X, divider, thanh mức độ, khối tóm tắt, font và các trạng thái tương tác sẽ kiểm khi dựng UI. Lần này không thêm logic game, không sửa component modal.
