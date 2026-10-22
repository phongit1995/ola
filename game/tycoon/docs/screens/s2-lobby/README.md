# S2. Lobby — Nền trời thoáng

**Đã chốt phương án 1 — Nền trời thoáng.** Đây là đặc tả style để dựng lại màn lobby theo ảnh bên dưới. Phạm vi của tài liệu là S2; hành vi online theo [02 §S2](../../02-screen-specs.md#s2-lobby), luật chơi theo [05](../../05-gameplay-rules-and-protocol.md). **Đã dựng với dữ liệu mock** (`tycoon/screens/LobbyScreen.tsx`, mock `@minhanh` / VIP 3 / 12.500 KEN ở `tycoon/helpers/profile.ts`): `Vào bàn` tạm mở chơi với máy, `Lịch sử` và `Bảng xếp hạng` báo tính năng online đang làm. Đã có [S1 loading](../s1-loading/README.md) khi thiếu hồ sơ; API hồ sơ, lỗi và offline chưa triển khai.

![Lobby S2 đã chọn: nền trời pixel, Bác Tỷ, ba thẻ đất và menu vàng/kem](./concept-s2-lobby-pixel-16bit.png)

Ảnh gốc **853 × 1844 px**, giữ nguyên bản được chọn. [Log nguồn và prompt](../../asset-generation-log.md). Ảnh concept không import trực tiếp vào game; asset được **cắt từ concept** theo [quy trình asset theo màn](../README.md#quy-trình-asset-theo-màn), PNG gốc ở [`assets/screens/lobby/`](../../../assets/screens/lobby/README.md), khi code mới xuất WebP/SVG. Chữ (nhãn nút, tên, số KEN) không cắt từ ảnh, luôn là DOM text.

**Trạng thái sau review 2026-10-21:** có 13 PNG nguồn tại [assets/screens/lobby](../../../assets/screens/lobby/README.md) (8 bản v2 đã chọn sau khi so với concept + 5 v1); 10 bản WebP đã được xuất và import vào Lobby mock. **Chưa đạt visual QA.** Ảnh AI đã tái dựng một số chi tiết; tia vàng CTA, tia trắng hero, mặt CTA, contour nút kem và Luật chơi không pill đã dựng bằng SVG/CSS, chờ visual QA. Xem [audit từng ảnh, nguyên nhân từ prompt và việc cần sửa](./asset-audit.md). Có file runtime không có nghĩa artwork đã được duyệt.

## 1. Hướng hình ảnh và thứ tự ưu tiên

- Nền trời cyan thoáng, mây pixel ở viền; phố Việt Nam, cây, núi và sông ở phần dưới. Không đặt một panel lớn sau toàn bộ menu.
- Logo vàng viền navy nằm trên hero. Bác Tỷ bên trái; ba thẻ đất giấy kem có tranh pixel, hai quân con tốt vàng/xanh ở bên phải. Hero và logo tách khỏi vùng nút.
- Một nút chính vàng `Vào bàn`, hai nút kem `Lịch sử`, `Bảng xếp hạng`, rồi action chữ có sách `Luật chơi`. Footer chỉ có pill `Thoát game`, căn giữa thẳng hàng menu; không hiển thị version (`v1.0` trong ảnh bỏ đi).
- Bóng elip dưới chân Bác Tỷ trong ảnh không lấy: nhân vật không đổ bóng ngoài theo [03-characters](../../style/03-characters.md).
- Riêng S2, giữ họa tiết áo và shading gần concept; đây là ngoại lệ của màn so với nhân vật phẳng dùng chung. Không làm phẳng áo hoặc đảo hướng icon thoát dưới danh nghĩa “sửa QA” khi ảnh mẫu không yêu cầu.
- Pixel chỉ dùng cho phong cảnh. Mascot, quân cờ, thẻ, icon, nút và chữ mượt, contour navy. Ánh sáng nhẹ và mép dưới tạo độ nổi; không thêm glow, glass hay hạt liên tục.
- **Ảnh quyết định mỹ thuật và tương quan bố cục; tài liệu này quyết định kích thước triển khai, responsive và trạng thái.** Dùng [01-foundations](../../style/01-foundations.md) cho token UI chung; lớp phản sáng/cạnh CTA và họa tiết nhân vật S2 là ngoại lệ theo concept đã duyệt, chỉ áp dụng trong màn này như §3 và §6.
- Chữ `Minh Anh`, chân dung người, `12.500 KEN` trong ảnh là dữ liệu mẫu. Production dùng avatar VIP + `@username` theo [03 §18](../../03-component-specs.md#18-tên-người-chơi-và-icon-vip-playername-playeravatar) và số KEN thật. Không bake các dữ liệu này vào ảnh.

## 2. Bố cục tại 390 × 844

Tọa độ dưới đây tính trong vùng nội dung **sau khi đã trừ safe-area**, với vùng khả dụng 390 × 844. Đây là mốc kiểm bố cục, không dùng `position: absolute` cho cả màn. Dùng luồng dọc; khung lobby cao đúng một màn như caro (`height: 100dvh`, không cuộn), màn thấp thu hero trước.

| Vùng | Vị trí và kích thước CSS px | Nội dung |
|---|---|---|
| Topbar | x 12, y 28, rộng 366, cao 52 | profile pill, KEN pill, âm thanh |
| Logo | giữa ngang, y 100, khung tối đa 320 × 80 | logo `CỜ TỶ PHÚ`, crown và một viên xúc xắc nằm trong logo |
| Hero | x 12, y 188, rộng 366, cao 176 | Bác Tỷ trái; ba thẻ + hai quân bên phải |
| Menu | giữa ngang, y 376–648, rộng 280 | cao lần lượt 80 / 56 / 56 / 44; gap 12 |
| Cảnh phố dưới | chủ yếu từ y 648 đến đáy | trang trí, không nhận pointer events |
| Footer | giữa ngang, y 780–824; cách đáy 20 | nút thoát cao 44, căn giữa |

Các khoảng dọc chuẩn: topbar → logo 20; logo → hero 8; hero → menu 12. Footer dùng `margin-block-start: auto`, cách menu ít nhất 24. Tránh neo footer bằng `position: fixed` khiến nó che menu trên điện thoại thấp.

Khung lobby tối đa 520 px, căn giữa màn; nền trời tiếp tục phủ ngoài khung ở desktop. Topbar/hero có lề ngang 12. Menu dùng `clamp(256px, 0.8 × W − 32px, 320px)` với W là chiều rộng lobby **trước padding ngang**: 280 px tại 390, 256 px tại 360, tối đa 320 px tại 520. Khi phần trăm CSS tính trên content box đã trừ 24 px padding, dùng `calc((100% + 24px) * 0.8 - 32px)`. Logo tối đa 320 px, không kéo giãn sai tỷ lệ.

## 3. Chữ và màu

Font production là **Nunito**, tái dùng hai file đang được khai báo trong [style.css](../../../style.css): `Nunito-400-800-latin.woff2` và `Nunito-400-800-vietnamese.woff2` từ Caro. Chữ trong ảnh AI chỉ gần với Nunito, không phải mẫu font để trích xuất. Không tải thêm font từ CDN; logo là artwork riêng, không dựng bằng font nội dung.

| Thành phần | Font size / weight / line-height |
|---|---|
| `@username` | 16 / 800 / 1.2 |
| Số dư KEN | 17 / 800 / 1.2, `tabular-nums` |
| `Vào bàn` | 32 / 800 / 1.15 |
| `Lịch sử`, `Bảng xếp hạng` | 24 / 800 / 1.2 |
| `Luật chơi` | 22 / 800 / 1.2, underline offset 4 |
| `Thoát game` | 16 / 800 / 1.2 |
| Trợ giúp/lỗi | 13.5 / 600 / 1.35 |

Chữ và contour dùng navy `#1F2A44`; paper `#FCFDF0`, mép paper `#F0E4C8`. Các token gold chung là điểm bắt đầu, không đủ để mô tả mặt CTA đã duyệt: S2 cần mặt vàng sáng, highlight trắng, cạnh cam và đáy nâu tách biệt theo §6; không dùng một màu `#B98700` cho mọi lớp rồi coi là đã khớp. Nền trời `#35C1FC → #7FE3F7`; màu tiền/trạng thái hợp lệ jade `#1F8A5B`, lỗi/thoát coral `#E4573D`. Không đổi toàn bộ KEN thành gold: số dư vẫn navy để đọc rõ trên nền kem. Màu/chuyển sáng bổ sung cho artwork CTA chỉ áp dụng S2, không đổi token nút toàn game.

Các nhãn phải giữ đủ dấu tiếng Việt và đọc được tại 360 px.

## 4. Topbar và dữ liệu

- **Profile:** pill paper, viền navy 1.5; avatar VIP 44 × 44 bên trái, gap 6, tên `@username` ở phải. Ở lobby vẫn hiện username của chính mình, không đổi thành `Bạn`. Không gắn thêm badge VIP thứ hai, không dùng chân dung mẫu trong ảnh.
- **Tên dài:** phần tên có `min-width: 0`, cắt ellipsis theo chiều rộng còn lại; giới hạn tối đa 16 ký tự sau `@` theo quy ước list. Accessible name giữ đầy đủ tên. Không cắt chuỗi rồi dùng chuỗi đã cắt cho dữ liệu/aria-label.
- **KEN:** pill paper cùng cao topbar, `ic-ken` 24 + số dư đã format + hậu tố `KEN`. Không cho đổi số làm dịch nút âm thanh ra ngoài khung. Không dùng ellipsis hoặc tự làm tròn số dư thành K/M.
- **Âm thanh:** vùng chạm 44 × 44, căn giữa dọc; hình tròn paper viền navy 1.5, `ic-volume-on/off` 24. `aria-pressed` phản ánh bật/tắt; tên truy cập là hành động `Tắt âm` hoặc `Bật âm`.
- Hàng chuẩn dùng grid `minmax(0, 1fr) max-content 44px`, gap 8. Nếu số KEN không còn đủ chỗ cùng profile tối thiểu 108 px, chuyển KEN xuống hàng 2 hết chiều rộng, profile và loa ở hàng 1. Topbar tăng cao trong luồng; logo và menu dịch xuống theo, không chồng nhau.
- Chưa có dữ liệu user: skeleton đúng footprint, số dư chưa biết hiện `— KEN`, không giả thành `0 KEN` và không hiển thị mẫu `Minh Anh`. Lỗi tải hiển thị thông báo và action thử lại theo §8.

## 5. Hero và asset

Hero là một nhóm trang trí `aria-hidden="true"`, `pointer-events: none`; không phải bàn có thể chơi hoặc chọn ô.

| Lớp | Quy cách |
|---|---|
| Nền | Dùng chung `lobby/bg-board-pixel.webp`; mây ở rìa, trời trống sau logo/menu, phố neo đáy. Khi crop ưu tiên giữ cảnh phố và không kéo méo pixel. Không cần nền lobby mới. |
| Logo | `lobby/logo.webp`, transparent, contain trong khung 320 × 80. Tên game được cung cấp một lần bằng heading/accessible name. |
| Bác Tỷ | `chars/ty-idle-full.webp`, hình nhìn thấy cao 176, rộng khoảng 140; căn trái và đáy hero. Áo bà ba gold, quần navy, kính tròn, quạt giấy mở nhẹ như mẫu, nụ cười thân thiện. |
| Ba thẻ đất | Nhóm bên phải rộng khoảng 224, cao 132; ba thẻ xếp xòe nhẹ, dải đỏ/xanh dương/xanh lá nằm dưới, contour navy và mép paper. Hiện nằm trong `lobby/hero-properties.webp` cùng hai quân; không chữ/giá/quyền sở hữu. |
| Tranh trong thẻ | Giữ ba cảnh của concept trong artwork hero. Đây là decor, không ánh xạ giá/nhóm đất thật; không bắt buộc thay bằng `tiles/art` làm đổi hình đã duyệt. |
| Hai quân | Gold và blue, cao khoảng 64/58, ở vị trí tương đối như mẫu; hiện chung `hero-properties.webp`. Nếu tách lớp để animate, giữ silhouette/perspective; không tự thay bằng avatar hoặc token có dáng khác. |
| Tia trắng | `lobby/decor-hero-rays.svg`: cụm 3 tia cạnh quân vàng và cụm 3 tia (nhỏ – cao – nhỏ) phía phải quân xanh như concept. viewBox trùng khung `hero-properties.webp` (468 × 250); xuất lại hero với crop khác thì phải chỉnh tọa độ tia. Trang trí trắng đặc trên nền trời, không glow, không chớp liên tục. |

Thứ tự lớp: nền → tia trắng → thẻ → quân → mascot; mascot và cụm thẻ có thể chồng mép tối đa 8 px, không che mặt, quân hoặc logo. Trim vùng trong suốt khi đặt layout để **hình nhân vật**, không phải canvas PNG, đạt chiều cao 176. Kích thước canvas nguồn xem manifest; 256 × 256 trong guideline chung không phải kích thước PNG nguồn S2 hiện tại.

Nếu tắt nhân vật hoặc asset nhân vật chưa tải, giữ footprint hero và thay bằng glyph crown/coin gọn; CTA vẫn nằm đúng chỗ. Asset decor lỗi không được khóa navigation hoặc lặp tải vô hạn. Phong cảnh pixel export theo bội số nguyên, không filter làm mịn; UI và mascot vẫn mượt.

## 6. Nút và minh họa

Kích thước/font ở đây là biến thể **riêng S2**, không đổi nút trong bàn S6 hoặc modal. Nội dung icon + nhãn căn giữa như một nhóm, gap 10–12; không dành một cột icon riêng làm nhãn lệch tâm. Nhãn luôn là DOM text.

| Action | Surface và kích thước | Minh họa | Hành vi |
|---|---|---|---|
| `Vào bàn` | mặt vàng sáng, cao 80, pill, highlight trắng ở cung trên, cạnh cam và đáy nâu; một đường bao ngoài | xúc xắc trắng/navy 48; **2 tia vàng mỗi bên ngoài nút** | `openRanked()` → S3; preload RANKED |
| `Lịch sử` | paper, cao 56, pill, **một contour navy 1.5**, cạnh beige bên trong và bóng xanh nhẹ xuống dưới | đồng hồ/mũi tên blue 40 | mở S10 |
| `Bảng xếp hạng` | paper, cao 56, pill như trên | bục gold, blue, coral + crown, 40 | mở S11 |
| `Luật chơi` | **không nền pill, không border/shadow**; vùng chạm cao ít nhất 44, chữ navy gạch chân trên nền trời | sách paper/navy, 32 | modal luật có thể cuộn, nút Đóng; dùng offline |
| `Thoát game` | paper, cao 44, pill; rộng theo nội dung, padding ngang 18 | cửa/mũi tên coral, 24 | `bridge.exit()` |

Artwork kiểm lại từ nguồn: xúc xắc CTA có các mặt **3–2–1** (mặt lớn phía trên / trái / phải), đồng hồ không có chấm tâm. Icon thoát giữ thiết kế v1, tách thành 2 lớp cửa + mũi tên hướng phải, chồng trong một ô 24 px của nút Thoát game.

Mặt CTA có dải highlight trắng hở chạy theo cung trên và điểm sáng gần hai đầu; đó là phản sáng, **không phải outline trắng thứ hai chạy kín nút**. Cạnh cam nằm trong hình nút và kết thúc ở đáy nâu. Với nút kem, không kết hợp `border` với một outer spread-shadow navy tạo hai đường bao song song; đặt cạnh beige ở trong contour, chỉ bóng đổ nằm ngoài. Quy tắc một contour áp dụng default/hover/pressed; focus ring truy cập bàn phím vẫn hiện riêng khi `:focus-visible`.

Tia CTA là lớp SVG code-native `lobby/decor-cta-rays.svg`: cụm 2 tia vàng đặc dùng bên trái và mirror bên phải, tổng 4 tia. Mốc 390 px: mỗi cụm khoảng 20 × 36, cách mép nút khoảng 10; không clip ở 360 px, không chiếm slot icon/nhãn, `aria-hidden` và `pointer-events: none`. Không được bỏ qua vì prompt tách skin đã xóa tia; xem [audit §2](./asset-audit.md#2-thiếu-lớp-nào-vì-sao-thiếu).

Hai PNG `button-gold`/`button-paper` chỉ là mẫu surface; runtime hiện dựng nút CSS. CSS/SVG phải tái hiện các lớp trên. Nếu chuyển sang skin raster, kiểm tỷ lệ phần nhìn thấy và co giãn trước: gold v1 khoảng 4,13:1; bản v2 đã sửa về **3,50:1**, khớp khung 3,5:1. Không chồng thêm viền CSS lên contour đã có trong artwork.

Khi Luật chơi nằm trên cảnh phố (màn thấp, desktop), chữ và sách có viền sáng màu paper (`text-shadow`/`drop-shadow`) để đọc được; không thêm lại pill để che cảnh phố.

Các hình trong nút là **5 minh họa trang trí** `lobby/ill-{dice,history,leaderboard,rules,exit}`. Nguồn hiện tại là PNG cắt từ concept (`icon-*.png`, §10); khi code xuất WebP, hoặc vẽ lại SVG viewBox 48 × 48 nếu cần nét sắc. Contour navy, hình khối đơn giản, 2–3 màu và highlight nhỏ; không chữ, emoji. Chúng không thay hệ 30 icon `ic-*` dùng cho điều khiển chung. Màu và hình cần giữ cùng nét với ảnh mẫu.

Minh họa có `aria-hidden`, tên action chỉ đọc nhãn nút. Khi chưa có minh họa: dùng `ic-dice/history/leaderboard/exit-door`; `Luật chơi` có thể tạm chỉ có chữ, giữ slot và khoảng cách ổn định. Fallback này không phải trạng thái đạt visual QA cuối.

`Vào bàn` là nút gold duy nhất của S2. `Luật chơi` mở modal trên backdrop và khóa tương tác nền; nút Đóng dùng paper. Không gắn badge, đếm người online, quảng cáo, hàng tab hay CTA mới vào bố cục đã chọn.

## 7. Trạng thái và chuyển động

| Trạng thái | Biểu hiện |
|---|---|
| Default | Theo bảng §6, label không bị che bởi highlight/mascot |
| Hover (thiết bị có hover) | Sáng nhẹ, dịch lên 1 px; không scale làm thay đổi vùng chạm |
| Pressed | Dịch xuống 2 px, giảm mép nổi tương ứng; không đổi kích thước layout |
| Focus-visible | Ring navy 2 px, cách 3 px có nền paper ngăn với nút; không chỉ đổi màu vàng trên nút vàng |
| Disabled | `disabled` thật, opacity 45%, không hover/press; có lý do trạng thái bằng text ngoài nút |
| Pending | Spinner thay hình trong slot cũ, giữ nhãn/chiều rộng, `aria-busy`; chặn gửi lặp action |
| Lỗi action | Toast tiếng Việt có thể đọc bằng `aria-live`, phục hồi nút khi kết thúc request; không thay label thành mã lỗi |

Menu vào màn: fade + translateY 6 px, 180–220 ms, stagger tối đa 30 ms. Không lắc/nhấp nháy CTA lặp vô hạn; mây/phố mặc định đứng yên. Bác Tỷ chỉ bob nhẹ ở tier Full theo [08 §U2](../../08-fx-and-animation.md), tier Lite/Off đứng yên. Chọn tier trong menu tùy chọn S6, không thêm control cạnh loa trong S2. `prefers-reduced-motion` tắt translate/stagger và decor motion; focus, pending và error vẫn rõ bằng trạng thái tĩnh.

## 8. Loading, offline và responsive

S1 là trạng thái của cùng `LobbyScreen`, không dựng đồng thời hai logo hoặc hai menu. Code hiện dùng `profile === null` để hiện [bố cục S1](../s1-loading/README.md): logo + Bác Tỷ + Cung men nổi quay luân phiên với xúc xắc 3D lật một mặt mỗi lượt; giữ âm thanh/thoát, ẩn profile/KEN/menu/cụm thẻ. Có hồ sơ thì gỡ renderer và khôi phục S2 cùng phép đo topbar. Bản chơi máy khởi tạo `MOCK_PROFILE`; dev `/tycoon/?preview=loading` dùng để xem S1. `LOBBY_CRITICAL` và budget theo [04 §5](../../04-asset-manifest-and-prompts.md#5-preload-groups-assetsts); PNG concept 2 MB trong docs không tham gia tải game.

**Kế hoạch online:** khi mất kết nối trong S2, giữ các khối và hồ sơ đã hiển thị; ba action online (`Vào bàn`, `Lịch sử`, `Bảng xếp hạng`) disabled, thêm dòng lý do và action `Thử lại` paper trong luồng. `Luật chơi`, âm thanh và thoát vẫn dùng được. S1 error dùng CTA thử lại theo 02; không hiển thị đồng thời CTA thử lại S1 và menu S2. Bản client-only hiện có giữ luồng chơi máy cho đến khi triển khai online; nhãn `Vào bàn` trong đặc tả không có nghĩa S3 đã tồn tại.

| Vùng khả dụng | Quy tắc |
|---|---|
| 390 × 844 | Bám mốc §2, tất cả control nhìn thấy, phố ở phần đáy |
| Rộng 360 | Menu 256; secondary text có thể giảm xuống 22; logo tối đa `W − 48`; hero giảm đều theo chiều rộng. Topbar dùng quy tắc xuống hàng §4 nếu cần. Không cắt `Bảng xếp hạng`. |
| Rộng 520 | Menu tối đa 320; logo tối đa 320; hero tối đa 400, căn giữa. Thêm khoảng trời hai bên, không phóng font theo viewport. |
| Cao < 760 | Lề trên 16, logo cao 72, hero cao tối đa 144, CTA chính 64 / chữ 28, secondary 52 / chữ 22; gap menu giữ 12. Footer vẫn cao 44, có thể nằm dưới fold. |
| Cao < 760 hoặc font phóng lớn | Giống caro: khung cố định đúng một màn, không cuộn. Hero (mascot + cụm thẻ) co lại trước, có thể về 0; topbar, logo, menu và footer giữ cỡ. Không ép text, ẩn action hoặc đặt footer đè nội dung. |
| Cao > 900 | Giữ kích thước control, thêm khoảng trời giữa menu và footer; cảnh phố neo đáy |

Safe-area: như caro, dùng biến `--ty-safe-top`/`--ty-safe-bottom` (lấy từ `env(safe-area-inset-*)`, về 0 khi `data-ola-native-safe-area="handled"`), không gọi `env()` trực tiếp để WebView đã inset không bị cộng lần hai. Viewport meta giống caro, không chặn phóng to.

## 9. Checklist triển khai và kiểm ảnh

Các mục dưới đây là **việc triển khai tiếp theo**, không đánh dấu hoàn thành chỉ vì đã có concept/docs.

- [x] Dựng DOM/CSS theo vùng §2, font Nunito với glyph tiếng Việt; avatar VIP + `@username` (dữ liệu mock).
- [x] Đã xuất 10 WebP theo §10, tổng ~178 KiB; không import concept hoặc PNG gốc. Mục này chỉ xác nhận export, không xác nhận visual QA hay budget toàn bộ initial load.
- [ ] Xử lý các sai khác PNG trong [audit](./asset-audit.md), ưu tiên quầng/tỷ lệ icon sách, BXH và chi tiết xúc xắc/đồng hồ; giữ hướng icon thoát và không tự làm phẳng áo S2.
- [ ] Đủ 4 tia vàng CTA và 2 cụm tia trắng hero; CTA có highlight/cạnh cam, nút kem một contour, Luật chơi không pill; kiểm default/pressed và focus riêng.
- [ ] Nối action vào luồng được triển khai; phân biệt S1, S2 ready, pending, lỗi và offline.
- [ ] Chụp 390 × 844 đối chiếu concept: nền mở, logo, mascot trái, 3 thẻ/2 quân phải, menu vàng–kem–kem–text, footer; không mất hoặc thêm action.
- [ ] Chụp 360 × 640, 390 × 844 có safe-area, 520 × 900; thử username dài 24 ký tự, KEN 19 chữ số, user không VIP, zoom text 200%, reduced-motion, asset lỗi.
- [ ] Kiểm tên/VIP/số KEN đều là dữ liệu thật, không có placeholder ảnh lọt vào trạng thái ready.
- [ ] Tab theo thứ tự âm thanh → Vào bàn → Lịch sử → Bảng xếp hạng → Luật chơi → Thoát; modal quản lý focus và trả focus về nút mở.
- [ ] Nút không dưới vùng chạm 44 × 44; kiểm contrast và overflow, budget tải lobby ≤ 180 KB gzip; typecheck và kiểm tương tác sau khi có code UI.

## 10. Asset cắt từ concept → file production

PNG nguồn nằm ở [`assets/screens/lobby/`](../../../assets/screens/lobby/README.md) (8 bản v2 đã chọn + 5 giữ v1). Đã có 11 WebP (cắt theo alpha (> 8) + đệm trong suốt 4 px, thu LANCZOS về ~2× cỡ hiển thị, WebP q80/alpha q90; nền kín 780 px rộng, q68; script xuất không lưu trong repo). Tổng 182.316 byte (~178 KiB) chỉ là các WebP, không phải chứng nhận toàn bộ initial load ≤180 KB gzip. Loa dùng `ic-volume-on/off` có sẵn nên `icon-sound.png` chưa xuất. Hai SVG decor ở bảng dưới **đã có**.

| PNG gốc | File runtime khi code | Ghi chú QA trước khi xuất |
|---|---|---|
| `background.png` | `lobby/bg-board-pixel.webp` (nền trời dùng chung) | giữ bố cục; kiểm nét pixel trên PNG và bản export, không làm mịn thêm khi phóng |
| `logo.png` | `lobby/logo.webp` | so silhouette/dấu tiếng Việt và tỷ lệ phần nhìn thấy, không chỉ canvas |
| `mascot.png` (v2) | `chars/ty-idle-full.webp` | họa tiết áo dạng đồng xu gần concept; mặt/tóc/khuy vẫn tái dựng; bỏ bóng elip theo ngoại lệ đã ghi |
| `hero-properties.png` (v2) | `lobby/hero-properties.webp` | 3 thẻ + 2 quân chung một lớp; tia trắng là SVG riêng; tách lớp chỉ khi cần animate |
| `icon-dice.png`, `icon-history.png`, `icon-leaderboard.png`, `icon-rules.png` (v2) | `lobby/ill-{dice,history,leaderboard,rules}.webp` (hoặc `.svg` nếu vẽ lại vector) | xúc xắc 3–2–1, đồng hồ không chấm tâm, crown BXH viền nâu, sách gọn ~1,37:1 |
| `icon-exit-door.png` + `icon-exit-arrow.png` (tách từ v1) | `lobby/ill-exit-door.webp` + `lobby/ill-exit-arrow.webp` | chồng trong ô 24 px; giữ mũi tên hướng phải như concept; `icon-exit.png` chỉ còn làm đối chiếu |
| `icon-ken.png` | `lobby/ill-ken.webp` | chỉ dùng trong pill KEN của S2; `ic-ken` vẫn dùng ở chỗ khác |
| `icon-sound.png` | chưa xuất; runtime dùng `ic-volume-on/off` | chỉ cần bổ sung artwork off nếu thay cặp SVG đang dùng; không chặn luồng âm thanh hiện tại |
| `button-gold.png`, `button-paper.png` (v2) | không xuất | mẫu surface cho CSS/SVG §6; gold visible 3,50:1, paper 4,87:1; không được lược highlight/cạnh hoặc thêm viền kép |
| chưa có PNG; theo hình trong concept | `lobby/decor-cta-rays.svg` — **đã tạo** | SVG code-native, 2 tia mỗi bên CTA; không cần gen lại skin |
| chưa có PNG; theo hình trong concept | `lobby/decor-hero-rays.svg` — **đã tạo** | SVG code-native, 2 cụm trắng (3 tia trái, 3 tia phải), tọa độ theo khung `hero-properties.webp`; không cần gen lại hero |
