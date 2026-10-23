# 02 — Screen specifications

Mọi số đo tại viewport logic `390 × 844`. Width hỗ trợ 360–520 px: bàn cờ vuông `min(100vw − 24, 480)`, các khối khác dùng % + clamp. Safe area: `env(safe-area-inset-*)`, host WebView đã set `data-ola-native-safe-area` (xem `caro/main.tsx`).

Điều hướng không dùng router: mỗi màn là boolean/enum trên store `useTycoon` (pattern caro `App.tsx`). Sheet (S7, S8, O3) là lớp trượt lên đè S6, không phải màn riêng.

**Tên người chơi:** mọi chỗ hiện người chơi dùng `@username` kèm icon VIP; avatar là icon VIP; chính mình ghi `Bạn` ở pod, chip lượt và câu log. Quy tắc đầy đủ ở [03 §18](./03-component-specs.md).

---

## S1. Loading / Connecting

UI đã tích hợp trong `LobbyScreen` khi `profile === null`; style và renderer đã chốt tại [S1 loading](./screens/s1-loading/README.md). Store hiện vẫn dùng `MOCK_PROFILE`, nên game chơi máy vào S2 như trước; xem S1 trong dev bằng `/tycoon/?preview=loading`.

- Giữ nền trời pixel, logo, Bác Tỷ đứng yên, nút âm thanh và Thoát game. Ẩn tên/avatar, KEN, menu và cụm thẻ/quân trong lúc chờ hồ sơ.
- Logo ở y 18,8%; nhân vật ở x 11%, y 34,8%; tâm loader x 50%, y 67% trong vùng sau safe-area. Khung loader `min(33cqw, 15cqh, 144px)`.
- Xúc xắc WebGL bo góc, phía sau trong suốt, không đĩa trắng/kem. Dùng viền **Cung men nổi đã chốt** tại [style S1](./screens/s1-loading/README.md). Mỗi lượt 2,8 giây: viền quay 1,4 giây → nghỉ 0,2 giây → xúc xắc lật đúng một mặt (90°) trong 0,7 giây → giữ mặt mới 0,5 giây rồi đến lượt viền tiếp theo. Hai lớp không quay cùng lúc; không reset mặt sau mỗi lượt. Không có phần trăm giả hoặc chữ loading hiển thị; screen reader đọc “Đang tải hồ sơ”.
- Reduced motion giữ tư thế đầu và dừng viền; tab ẩn dừng animation; thiếu WebGL/context bị mất dùng minh họa xúc xắc tĩnh. Có hồ sơ thì gỡ loader và hiện S2.

**Phần online chưa triển khai:** `lobbyPhase = 'loading' | 'connecting' | 'ready' | 'error'`, preload nhóm LOBBY_CRITICAL trước first paint (04 §5), timeout/error/retry/auth. Khi có `error`, map lỗi sang tiếng Việt và hiện `Thử lại` (CTA vàng 240×52) gọi lại `init()`. Nếu đã hiện S2 rồi mới mất kết nối, giữ hồ sơ/layout S2 và báo lỗi theo [S2 lobby §8](./screens/s2-lobby/README.md#8-loading-offline-và-responsive), không reset hồ sơ về null để hiện lại S1.

---

## S2. Lobby

**Ảnh đã chốt: phương án 1 — Nền trời thoáng.** Xem [concept S2](./screens/s2-lobby/concept-s2-lobby-pixel-16bit.png) (bản 22/10/2026 có nút chơi máy) và [style lobby](./screens/s2-lobby/README.md) cho font, màu, hero, asset, trạng thái và responsive. Các mốc dưới đây ở vùng khả dụng 390 × 844 sau safe-area; bố cục dùng luồng dọc, không khóa toàn màn bằng tọa độ tuyệt đối.

### 2.1 Cấu trúc dọc
| Vùng | y | Nội dung |
|---|---|---|
| Topbar | 28–80 | avatar VIP + `@username` (trái, 03 §18), badge KEN (phải), nút âm thanh; KEN dài được xuống hàng. Component `LobbyTopbar` dùng chung với S3, cùng vị trí, không animate khi chuyển màn |
| Logo | 100–180 | logo "CỜ TỶ PHÚ", khung tối đa 320 × 80 |
| Hero | 188–364 | Bác Tỷ trái, 3 thẻ đất có tranh pixel và 2 quân con tốt vàng/xanh bên phải |
| CTA stack | 376–716 | 5 action dọc, rộng 280, cách 12 px |
| Footer | đáy − 64 đến đáy − 20 | nút Thoát game (`bridge.exit()`) cao 44, không version; cách menu ít nhất 24 |

### 2.2 CTA stack
| Nút | Style | Hành vi |
|---|---|---|
| `Vào bàn` | CTA vàng 280×80, Nunito navy 32/800, minh họa xúc xắc | `openRanked()` → S3, preload nhóm RANKED |
| `Chơi với máy` | xanh ngọc 280×56, Nunito navy 24/800, robot xanh–trắng 40 | `setSetupOpen(true)` → BotSetupModal, mặc định Bot 1; thêm/xóa tối đa 3 bot và chọn mức độ từng bot (§2.3) rồi vào ván |
| `Lịch sử` | giấy kem viền navy 280×56, Nunito 24/800, minh họa đồng hồ blue | S10 |
| `Bảng xếp hạng` | giấy kem viền navy 280×56, Nunito 24/800, minh họa bục/crown | S11 |
| `Luật chơi` | nút text 280×44, Nunito navy 22/800 gạch chân, minh họa sách | mở modal luật: 6 mục ngắn (gieo, mua, thuê, xây, tù, kết thúc), scroll, nút Đóng |

CTA online disabled khi `lobbyPhase !== 'ready'`. Chơi với máy, Luật chơi, âm thanh và thoát dùng được offline. Kích thước/font riêng S2 không đổi control S6; co giãn và màn thấp theo [S2 lobby §8](./screens/s2-lobby/README.md#8-loading-offline-và-responsive).

### 2.3 Modal Chơi với máy (`BotSetupModal`)

**Trạng thái: đã dựng UI ngày 23/10/2026 (`components/BotSetupModal.tsx`).** Ảnh [mở mới 1 bot](./screens/s2-lobby/modal-bot-01-one-bot.webp) và [đủ 3 bot](./screens/s2-lobby/modal-bot-02-three-bots.webp); chỗ docs khác ảnh ở [S2 §11](./screens/s2-lobby/README.md#11-modal-chơi-với-máy). Mức độ được lưu vào `SeatInfo.level` nhưng `botMove` chưa dùng: mọi máy vẫn chơi mức Thường cho tới khi làm [05 §12](./05-gameplay-rules-and-protocol.md#12-máy-chơi-và-mức-độ-bản-chơi-với-máy); nhãn mức ở pod S6/S9 cũng chưa làm. Thiết kế mới dưới đây thay hoàn toàn bộ chọn số máy `1 · 2 · 3` và danh sách Bác Tỷ/Cô Ngân/Anh Tèo của đặc tả trước.

Mở từ nút `Chơi với máy` ở S2. Mỗi lần mở từ sảnh luôn tạo danh sách mới gồm **1 bot, tên `Bot 1`, mức `Thường`**. Thêm từng bot bằng nút bên dưới, tối đa **3 bot** (ván 2–4 người kể cả bạn). Số lượng chỉ là thông tin đọc, **không có chip, dropdown hay ô nhập chọn số lượng**. Chơi offline, không cược, không người xem ([11](./11-room-settings.md)).

Khung paper rộng `min(100% − 32, 340)`, radius 22, viền navy 2, padding 18, cùng họ nút S4. Phần giữa cuộn khi thiếu cao; header và Hủy/Bắt đầu luôn nhìn thấy. Từ trên xuống:

| # | Phần | Nội dung |
|---|---|---|
| 1 | Header | icon robot xanh–trắng **cùng asset với nút sảnh** `assets/lobby/ill-bot.webp`, 32 px, cạnh trái tiêu đề `Chơi với máy` 21/800; cả nhóm icon + title căn giữa phần chừa cho X 44 góc phải; dưới header một vạch mint mảnh như ảnh. Icon trang trí, không đọc lặp tên |
| 2 | Thông tin số bot | `Danh sách bot` 14/800 bên trái, nhãn `1/3 bot` bên phải (đổi thành 2/3 hoặc 3/3 theo danh sách). Nhãn không bấm được |
| 3 | Danh sách bot | lần đầu chỉ **Bot 1**; sau thêm có Bot 2, Bot 3. Mỗi bot có mức độ riêng và nút `−` trên cùng một hàng với tên (§2.3.1) |
| 4 | Thêm bot | nút `+ Thêm bot` ở **ngay dưới toàn bộ danh sách**, rộng hết nội dung, cao 44, nền mint nhạt và viền jade theo ảnh modal (ngoại lệ riêng S2, [asset v2](./screens/s2-lobby/README.md#asset-của-modal)); thêm một bot mỗi lần. Đủ 3 bot thì disabled thật, vẫn giữ nhãn, có dòng `Đã đủ 3 bot` |
| 5 | Tóm tắt và gợi ý | khối nền `#e4f3fd` (đo từ ảnh) bo 16: `Ván {n + 1} người: bạn và {n} bot` 14/800; bên dưới `Tối đa {MAX_ROUNDS} vòng hoặc {phút} phút, mỗi hành động {TURN_SECONDS} giây. Máy đi tự động.` 13 navy 70%, căn giữa. Số giới hạn đọc từ constants: hiện 30 vòng / 25 phút / 30 giây. Icon hai người đã có: `assets/bot-setup/users-blue.svg`, 28 × 21, trang trí trước dòng tổng người, render img để giữ hai màu xanh |
| 6 | Hàng nút | `Hủy` paper trái · `Bắt đầu` gold phải, chia đều, cao 52 |

**2.3.1 Một bot trong danh sách.** Theo chỉnh sửa mới, mỗi bot nằm trên **một hàng duy nhất**: avatar + tên → nhóm mức độ → nút `−`. Thay bố cục hai hàng và icon thùng rác ở bản trước.

- Avatar VIP 24 · gap 4 · tên `Bot 1` / `Bot 2` / `Bot 3` navy 14/800, không xuống dòng. Avatar dùng VIP như pod S6; robot ở header vẫn là `ill-bot.webp`. Giữ avatar gắn với bot khi thêm/xóa.
- Cùng hàng với tên là pill `Dễ · Thường · Khó`, cao 40, vùng chạm cao 44. Ô `Dễ`/`Khó` rộng 44, ô `Thường` 72 (chữ ~51 px + đệm 10 mỗi bên), cộng viền là 163. Ô chọn gold, chữ navy 14/800; ô khác paper/navy 70%. Mặc định bot mới **Thường**, mỗi bot chọn độc lập. Không có nhãn Mức độ riêng phía trên hay một dòng selector bên dưới; tên truy cập radiogroup vẫn đủ.
- Cuối hàng là nút tròn dấu **`−`**, hình nhìn thấy 30–32, vùng chạm **44 × 44**, màu coral khi hoạt động. Artwork đã có `assets/bot-setup/minus-circle.svg` và `minus-circle-disabled.svg` (đã gồm vòng tròn); `ic-minus` chỉ là glyph thay thế nếu dựng vòng tròn bằng CSS. Tên truy cập vẫn `Xóa Bot 2`… Không dùng thùng rác hoặc chữ X cho thao tác xóa bot; X ở header vẫn để đóng modal.
- Hàng cao khoảng 60, căn giữa dọc avatar/tên/selector/nút trừ; các hàng cách nhau bằng đường beige mảnh. Thứ tự đọc và Tab: tên → mức độ → nút trừ. Cột mức độ và nút trừ thẳng nhau giữa các bot.
- Layout: nhóm avatar + tên 64 (avatar 24 + 4 + `Bot 3` ~36 px ở 14/800), nhóm mức độ 163, nút trừ 44, gap giữa các nhóm 4 → **279 px**; nội dung modal ở màn 360 là 288 (340 − 32 lề − 36 padding − 4 viền đã kẹp về 328), còn dư 9. Đo bằng Nunito ngày 23/10/2026; nếu dùng ô Dễ/Khó 48 như bản trước thì tổng 287, chỉ dư 1 px. Giữ **một hàng ở 360–520 px**, không đẩy selector xuống dòng hoặc cắt chữ Thường; dưới 360 ngoài phạm vi S2 ([S2 §8](./screens/s2-lobby/README.md#8-loading-offline-và-responsive)), nếu cần thì giảm padding ngang modal xuống 12 trước. Khi phóng chữ cần kiểm riêng overflow/trợ năng, không thu nhỏ chữ chỉ để vừa ảnh.
- Chỉ còn 1 bot: nút `−` của bot đó **disabled**, màu xám, tên truy cập `Không thể xóa bot cuối cùng`; có mô tả trợ năng `Cần ít nhất 1 bot để bắt đầu`. Không cho danh sách về 0.
- Có 2 hoặc 3 bot: xóa được bất kỳ bot nào, không cần popup xác nhận. Chỉ xóa bot đó, không reset mức độ hay avatar các bot còn lại. Đánh số nhãn lại liên tục theo thứ tự: ví dụ xóa Bot 2 trong ba bot thì Bot 3 cũ thành Bot 2, giữ mức độ cũ.
- `+ Thêm bot` thêm cuối danh sách, tên là số kế tiếp, mức Thường; không khôi phục mức của bot đã xóa. Dùng ID ổn định cho mỗi item để đổi nhãn không làm chuyển lựa chọn sang bot khác. Avatar mới dùng VIP còn trống trong bộ 1–3.
- Đủ 3: chặn thêm cả ở handler, không chỉ làm mờ nút. Sau xóa, nút thêm hoạt động lại ngay. Thay đổi số bot cập nhật nhãn đếm và dòng tổng người ngay.

**Bộ asset v2 đã sửa/kiểm (23/10/2026):** [inventory đầy đủ](./screens/s2-lobby/README.md#asset-của-modal) gồm robot và VIP 001–003 dùng lại; 6 SVG icon riêng cho X navy đậm, hai người, cộng/trừ tròn và hai bản xám; 4 nền nút SVG không chữ cho mint/disabled/paper/gold. Màu riêng lấy từ ảnh modal, không thay token chung. Dấu cộng hiển thị 24 trong nút Thêm bot. SVG nhiều màu render img, không mask; khung, nền nút co giãn, pill mức độ, divider và khối tóm tắt dựng CSS theo ảnh/palette SVG. Đã dùng trong `BotSetupModal`; nền nút dựng CSS theo màu SVG, không kéo giãn SVG.

**Bắt đầu và lưu lựa chọn.** Validate 1–3 bot và từng mức `easy | normal | hard`, tạo ván ngay với bạn + danh sách bot, không có phòng chờ:

- `SeatInfo` của máy có tên hiển thị `Bot 1`… theo thứ tự danh sách, avatar của item và `level`; store gọi `botMove(state, seat, level)` theo [05 §12](./05-gameplay-rules-and-protocol.md#12-máy-chơi-và-mức-độ-bản-chơi-với-máy). Các tên này dùng xuyên suốt modal, S6, S9 và log, không có `@`.
- Store giữ cấu hình ván vừa bắt đầu (`lastBots`, danh sách `{ id, vip, level }`, helper ở `helpers/bot.ts`) để `Chơi lại` S9 giữ nguyên số bot, avatar và mức độ; `playAgain` dùng danh sách này thay cho `playerCount`. Không cần localStorage: mở mới luôn reset, ván cũng không sống qua lần tải lại trang. Modal mới không đọc `ola:tycoon:players` nữa; không tạo key `ola:tycoon:bot-levels`.
- **Mở mới từ sảnh vẫn reset về Bot 1 / Thường**, không lấy cấu hình đã lưu để tự thêm 2–3 bot. Phân biệt rõ mở modal mới với Chơi lại ván vừa xong.

**Đóng.** Hủy, X, Escape, bấm nền: đóng và bỏ thay đổi nháp, không lưu. Mở lại từ sảnh luôn về trạng thái mặc định một bot.

**Bàn phím và trợ năng.** Mỗi nhóm mức là một `radiogroup`, nhãn `Mức độ của Bot 1`…; trái/phải đổi mức, Tab sang nhóm/nút tiếp. Mở modal focus vào mức Thường của Bot 1. Thêm bot thì focus vào nhóm mức của bot vừa thêm; xóa thì focus vào nhóm mức của bot thế chỗ (xóa bot cuối thì bot đứng trước), không đặt lên nút `−` có thể vừa bị disabled và không rơi ra backdrop. Cập nhật số bot bằng aria-live polite. Xóa/thêm disabled không nhận thao tác. Đóng trả focus về nút Chơi với máy ngoài sảnh.

**Trong ván.** Pod S6 và bảng S9 hiện tên Bot 1/2/3, thêm pill paper viền beige với mức Dễ/Thường/Khó 11/800 navy 70%; người chơi không có pill mức. Ví dụ tên truy cập `Bot 2, máy mức Khó`.

**Các trạng thái phải kiểm khi dựng:** mở mới 1 bot; thêm bot thứ 2 và 3; đủ 3 không thêm được; xóa bot giữa giữ mức của bot còn lại; còn 1 không xóa được; Hủy rồi mở lại về một bot; Chơi lại giữ cấu hình ván; màn thấp cuộn thân, header/footer không bị che.

---

## S3. Danh sách bàn (RankedScreen)

Copy hành vi caro/xiangqi `RankedScreen.tsx`. Ảnh mẫu, số đo và trạng thái hàng: [style S3](./screens/s3-room-list/README.md).

- Trên cùng là topbar của S2 (`LobbyTopbar`: avatar + `@username`, KEN, âm thanh), cùng vị trí với S2 và không chạy hiệu ứng vào màn, nên đứng yên khi chuyển S2 ↔ S3. Thêm 22/10/2026.
- Header 56 (cách topbar 12): back, pill tiêu đề `Bàn tỷ phú` 20/800, nút reload tròn riêng chỉ có `ic-refresh`, tách khỏi nền pill bằng khoảng trống. Không hiện chữ `Làm mới`; giữ `aria-label="Làm mới danh sách bàn"`. Số đo theo [style S3](./screens/s3-room-list/README.md).
- Cột: `Chủ bàn | KEN | Chỗ | Tham gia / Xem`. Cột `KEN` hiện mức cược với đồng KEN bên phải, bàn 0 ghi `0` ([11 §1.3](./11-room-settings.md#13-hiển-thị)).
- 9 hàng/trang cố định, hàng cao 8.85% vùng list, absolute theo %.
- Hàng: avatar VIP chủ bàn 32 (03 §18), `@username` 15/600, badge chỗ `2/4` (viền jade khi còn chỗ, mờ 50% + Tham gia disabled khi đầy), icon khóa khi `locked`, nằm cuối ô chủ bàn (sát phải). Bàn `status = 'playing'`: có bật cho xem thì cột cuối là nút `Xem` paper (`SPECTATE_JOIN {matchId}`), không thì chip `Đang chơi` ([11 §2.4](./11-room-settings.md#24-nút-vào-xem-ở-s3)).
- Footer: `Tạo bàn` (CTA vàng) giữa, phân trang ‹ › hai bên.
- `ROOM_LIST` khi mở + Làm mới; `ROOM_UPSERT/REMOVED` realtime; auto re-sync 90–120 s jitter.

---

## S4. Modal Tạo bàn / Vào bàn khóa

Hai modal mở từ S3, cùng khung modal chung (03 §12): rộng `min(100% − 32, 340)`, radius 22, nền paper, viền navy 2, giữ focus trong modal, trả focus về nút đã mở khi đóng. Người dùng đã chốt [sáu ảnh S4/O5](./screens/s3-room-list/README.md#8-modal-trên-danh-sách-bàn-s4-o5) theo style S3 ngày 22/10/2026; bố cục dưới đây vẫn là thứ tự và nội dung bắt buộc, không lấy kích thước AI thay số đo. Dùng các ngoại lệ docs thắng ảnh ở README S3, không cần sinh thêm concept cho trạng thái cùng kiểu.

### 4a Tạo bàn

Mở bằng nút `Tạo bàn` ở footer S3. Từ trên xuống:

| # | Phần | Nội dung | Mặc định |
|---|---|---|---|
| 1 | Header | tiêu đề `Tạo bàn` 21/800 **căn giữa**, không có ô biểu tượng; nút đóng `ic-close` 44 góc phải | — |
| 2 | `Số người` | 3 chip `2 · 3 · 4`, chọn một; chip đang chọn nền gold | **4** |
| 3 | `Số KEN cược` | ô nhập số có đồng KEN trước số, dấu chấm hàng nghìn; dòng phụ `0 = bàn giao lưu, không mất KEN` hoặc `Bạn có {ken} KEN` ([11 §1.1](./11-room-settings.md#11-chọn-ở-s4-tạo-bàn)) | **0** |
| 4 | `Khóa bàn` | công tắc; dòng phụ `Người vào chơi phải nhập mật khẩu`. Bật thì hiện ô mật khẩu ngay bên dưới (4a.1) | **tắt** |
| 5 | `Cho người khác xem` | công tắc; dòng phụ `Người ngoài bàn xem được ván, không thao tác được` ([11 §2.1](./11-room-settings.md#21-chọn-ở-s4-tạo-bàn)) | **tắt** |
| 6 | Hàng nút | `Hủy` paper trái · `Tạo bàn` gold phải, chia đều, cao 52 | — |

Mỗi nhóm có nhãn 14/800 navy phía trên; khoảng cách giữa các nhóm 14. Công tắc nằm bên phải nhãn, trong công tắc có chữ `Tắt` (nền xám, núm trái) hoặc `Bật` (nền `--ty-jade`, núm phải); dòng phụ 13 navy 70% dưới nhãn. Lỗi của nhóm nào hiện ngay dưới nhóm đó: chữ 13/700 `--ty-coral` + `ic-warning` 16, ô viền coral. Modal cao quá màn thì cuộn bên trong, hàng nút luôn nằm cuối modal.

**4a.1 Ô mật khẩu khi bật Khóa bàn.** Hiện bằng mở rộng xuống 150 ms (reduced motion: hiện ngay), focus vào ô ngay khi bật. Có nhãn `Mật khẩu` 14/800 phía trên như các nhóm khác. Ô kiểu mật khẩu, placeholder `Nhập mật khẩu`, tối đa **64 ký tự** như server, không có độ dài tối thiểu; nút mắt bên phải để hiện/ẩn chữ (`aria-pressed`). Tắt công tắc thì ẩn ô và bỏ mật khẩu đã nhập.

**Kiểm tra trước khi gửi**, theo thứ tự, dừng ở lỗi đầu tiên:

| Điều kiện | Câu lỗi | Ở đâu |
|---|---|---|
| cược không phải số nguyên ≥ 0 hoặc > `maxBet` | `Số KEN cược không hợp lệ` | dưới ô cược |
| cược > số KEN đang có | `Bạn không đủ KEN để tạo bàn` | dưới ô cược |
| bật Khóa bàn mà để trống | `Nhập mật khẩu hoặc tắt Khóa bàn` | dưới ô mật khẩu |
| mật khẩu > 64 ký tự | `Mật khẩu tối đa 64 ký tự` | dưới ô mật khẩu |

Sửa ô nào thì xoá lỗi của ô đó. Có lỗi thì focus vào ô lỗi đầu tiên.

**Gửi.** `ROOM_CREATE {bet, password, maxPlayers, allowSpectators}`; `password` rỗng khi tắt Khóa bàn. Đang gửi: nút `Tạo bàn` có spinner, khóa mọi ô và nút `Hủy`; `Escape` và bấm nền không đóng. Thành công (`ROOM_WAITING`) → đóng modal, sang S5. Lỗi từ server theo bảng 4c; modal giữ nguyên các lựa chọn đã nhập.

**Đóng.** `Hủy`, nút đóng, `Escape`, bấm nền: đóng và bỏ thay đổi. Mở lại thì về mặc định, riêng `Số người` nhớ lần chọn gần nhất.

**Bàn phím.** Ô cược dùng bàn phím số; `Enter` trong ô cược hoặc ô mật khẩu = bấm `Tạo bàn`.

### 4b Vào bàn khóa

Mở khi bấm `Tham gia` ở hàng có ổ khóa trong S3. Không áp dụng cho nút `Xem`: xem bàn khóa không cần mật khẩu ([11 §2.3](./11-room-settings.md#23-khi-bật)).

| # | Phần | Nội dung |
|---|---|---|
| 1 | Header | `ic-lock` trong ô biểu tượng (như O5) + tiêu đề `Vào bàn khóa` 21/800 **căn trái** cạnh ô biểu tượng + nút đóng `ic-close` 44; đường kẻ mảnh dưới header |
| 2 | Thông tin bàn | avatar VIP 32 + `Bàn của @owner`; dưới là chip cược (`{bet} KEN` hoặc `Giao lưu`) và chip chỗ `2/4` |
| 3 | Ô mật khẩu | nhãn `Mật khẩu` 14/800; ô kiểu mật khẩu, placeholder `Nhập mật khẩu`, tối đa 64 ký tự, nút mắt hiện/ẩn; focus ngay khi mở |
| 4 | Hàng nút | `Hủy` paper · `Vào bàn` gold; `Vào bàn` disabled khi ô trống |

- **Trước khi mở modal**, client kiểm số KEN theo cược của bàn. Thiếu thì hiện O5 `Chưa đủ KEN` ([11 §1.2](./11-room-settings.md#12-vào-bàn-có-cược)), không mở modal mật khẩu.
- Gửi `ROOM_JOIN {roomId, password}`; `Enter` trong ô = bấm `Vào bàn`. Đang gửi: spinner ở `Vào bàn`, khóa ô và `Hủy`.
- `WRONG_PASSWORD`: ô rung ngang 300 ms (reduced motion: không rung), viền coral, chữ lỗi `Sai mật khẩu` dưới ô; giữ chữ đã nhập, bôi đen toàn bộ để gõ lại. Gõ lại thì xoá lỗi.
- Lỗi khác theo bảng 4c; lỗi làm bàn không còn vào được (`ROOM_FULL`, `ROOM_NOT_FOUND`) thì đóng modal rồi báo.

### 4c Thông báo khi tạo bàn và vào bàn

Luồng vào bàn không khóa: bấm `Tham gia` → kiểm KEN như 4b → `ROOM_JOIN {roomId}`, nút `Tham gia` của hàng đó có spinner, khóa các nút khác trong bảng → `ROOM_WAITING` → S5. Không có phản hồi sau 10 s thì coi như lỗi mạng.

Câu chữ theo caro (`caro/helpers/errorText.ts`), đổi `Ken` thành `KEN`.

| Mã lỗi | Câu | Hiển thị | Sau đó |
|---|---|---|---|
| `WRONG_PASSWORD` | `Sai mật khẩu` | dưới ô mật khẩu 4b | giữ modal |
| `INVALID_PASSWORD` | `Mật khẩu tối đa 64 ký tự` | dưới ô mật khẩu 4a | giữ modal |
| `INVALID_BET` | `Số KEN cược không hợp lệ` | dưới ô cược 4a | giữ modal |
| `INSUFFICIENT_KEN` | O5 cảnh báo, icon `ken`: `Chưa đủ KEN` · `Bàn này cược {bet} KEN. Bạn đang có {ken} KEN.` · `Đã hiểu` | modal O5 | đóng modal 4a/4b nếu đang mở |
| `BET_NOT_ALLOWED` | O5 cảnh báo, icon `ken`: `Chưa thể chơi bàn cược` · `Tài khoản của bạn chưa thể chơi bàn có cược KEN. Hãy chọn bàn Giao lưu.` · `Đã hiểu` | modal O5 | khi tạo bàn: chữ lỗi dưới ô cược thay cho O5 |
| `ROOM_FULL` | `Bàn đã đủ người` | toast | đóng modal, làm mới danh sách |
| `ROOM_NOT_FOUND` | `Bàn không còn nữa` | toast | đóng modal, làm mới danh sách |
| `ROOM_BUSY` | `Bàn đang được cập nhật, vui lòng thử lại` | toast | giữ nguyên |
| `ALREADY_IN_ROOM`, `IN_ROOM` | `Bạn đang ở trong một bàn khác` | toast | giữ nguyên |
| `OWN_ROOM` | `Đây là bàn của bạn` | toast | giữ nguyên |
| `ROOM_JOIN_FAILED` | `Không thể vào bàn, vui lòng thử lại` | toast | giữ nguyên |
| `ROOM_CREATE_FAILED` | `Không thể tạo bàn, vui lòng thử lại` | toast | giữ modal 4a |
| không phản hồi 10 s / mất mạng | O5 lỗi, icon `wifi-off`: `Mất kết nối` · `Chưa thể kết nối vào bàn. Kiểm tra mạng rồi thử lại nhé.` · `Để sau` / `Thử lại` | modal O5 | `Thử lại` gửi lại đúng yêu cầu vừa rồi |

Toast theo O6: một dòng, tự ẩn 2,5 s. Các lỗi khi bấm `Xem` ở [11 §2.4](./11-room-settings.md#24-nút-vào-xem-ở-s3).

---

## S5. Phòng chờ (pregame)

Render trong BoardScreen với `boardMode = 'pregame'`: bàn cờ hiện mờ 40% phía dưới, panel ghế đè giữa.

### 5.1 Panel ghế (340 × auto, paper, radius 28)
- Title `Bàn của @owner` + badge chỗ `3/4` + icon khóa; chip `Cược {bet} KEN` hoặc `Giao lưu` (11 §1.3).
- Lưới ghế 2 × 2 (hoặc 1 × 2, 1 × 3 theo `maxPlayers`): mỗi ghế 150 × 88: avatar VIP 40 viền màu ghế, `@username` 15/600 (ghế của mình cũng ghi `@username`), chip `Chủ bàn` (ic-owner) hoặc `Sẵn sàng` jade / `Chưa sẵn sàng` mờ; ghế trống hiện dấu `+` nét đứt `Đang chờ...`.
- Màu ghế theo seat index (01 §2.3) — cho người chơi biết trước mình màu gì.

### 5.2 Hành động
| Vai | Nút |
|---|---|
| Chủ bàn | `Bắt đầu` CTA vàng (enabled khi ≥ 2 người và tất cả khách sẵn sàng), `Mời ra` trên từng ghế khách (ic-user-minus, O5 confirm), `Thoát bàn` |
| Khách | `Sẵn sàng` jade ⇄ `Hủy sẵn sàng` paper, `Thoát bàn` |

- `ROOM_START` → `MATCH_FOUND` → `boardMode='playing'`. Lỗi `ROOM_NOT_READY`/`ROOM_NOT_FULL` → toast. Bàn 3–4 chỗ được bắt đầu khi có từ 2 người: engine chỉ kiểm `playerCount ≥ MinPlayers` (`engine.go` `startRoom`), không bắt buộc đầy.
- Chat phòng: nút ic-chat góc dưới phải mở ChatDrawer (`CHAT_SEND {roomId}`).
- `ROOM_KICKED` → O5 thông tin `Bạn đã rời bàn` · `Chủ bàn đã mời bạn ra khỏi bàn. Bạn có thể chọn bàn khác.` · `Về danh sách` → S3. `ROOM_CLOSED` → toast `Bàn đã đóng` → S3.

---

## S6. Bàn chơi (BoardScreen, `boardMode='playing'`)

> **UI v3 (concept 20/10/2026).** Ảnh chuẩn duy nhất: [`concept-s6-board-pixel-16bit.png`](./screens/s6-board/concept-s6-board-pixel-16bit.png) (pixel 16-bit, bàn 32 ô). Cả 4 thẻ người chơi nằm **một hàng dưới bàn**, cụm lượt (đồng hồ, xúc xắc, nút) nằm **giữa bàn**, footer là thanh tiện ích. Ảnh chỉ để lấy bố cục và phong cách: tên ô, giá, màu nhóm luôn lấy từ `logic/board.json`; bàn khóa tỷ lệ 1:1, dải nhóm chỉ ở mép trong, chỉ một vùng log (xem [README ảnh mẫu](./screens/s6-board/README.md)).
>
> Thay thế UI v2 (17/10): `TurnPanel` và `GameLog` dưới hàng pod được bỏ; nội dung `TurnPanel` chuyển vào giữa bàn (6.3), `GameLog` thu thành dòng sự kiện ở footer (6.5).

### 6.1 Sơ đồ dọc

```text
┌──────────────────────────────────────────┐
│ [CỜ TỶ PHÚ]   ( Vòng 7/30 · 18:20 )   (♪)  (≡)   │ header
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │  NHÀ TÙ · 7 ô hàng trên · LỄ HỘI     │ │
│ │  ·   ┌────────────────────────┐  ·   │ │
│ │  ·   │ [CƠ HỘI]    [KHÍ VẬN]  │  ·   │ │
│ │  7   │                        │  7   │ │
│ │  ô   │ (Lượt của bạn) (0:28)  │  ô   │ │  bàn 32 ô
│ │  ·   │       [3]   [5]        │  ·   │ │  + cụm lượt
│ │  ·   │   [  Gieo xúc xắc  ]   │  ·   │ │
│ │  ·   └────────────────────────┘  ·   │ │
│ │  XUẤT PHÁT · 7 ô hàng dưới · DU LỊCH │ │
│ └──────────────────────────────────────┘ │
├──────────────────────────────────────────┤
│ [o Bạn  ] [o @linh] [o @khoa] [o @mai ]  │ hàng pod
│ [ 1.240 ] [  980  ] [  760  ] [ 1.100 ]  │
├──────────────────────────────────────────┤
│ [Tài sản] [Diễn biến] │ @linh vừa qua …  │ footer
└──────────────────────────────────────────┘
```

| Vùng | Khung concept 3:4 (% cao) | Tại 390 × 844 (y, px) | Nội dung |
|---|---|---|---|
| Header | 0–5% | 0–52 (+ safe-area trên) | logo trái, chip vòng giữa, âm thanh + menu phải (6.4) |
| Bàn | 5–87% | 56–422 | bàn vuông `min(100vw − 24, 480)` = 366; 32 ô + vùng trong (6.2, 6.3) |
| Hàng pod | 88–95% | 430–494 (compact) | 2–4 pod chia đều 1 hàng (6.5, 03 §5) |
| Footer | 96–100% | đáy − 52 → đáy (+ safe-area dưới) | `Tài sản`, `Diễn biến`, dòng sự kiện mới nhất (6.5) |

Lề ngang 12 cho mọi khối; bàn, hàng pod và footer cùng chiều rộng `var(--ty-board)` để các mép thẳng hàng.

**Co giãn theo chiều cao.** Concept là khung 3:4, gần như không dư chỗ. Điện thoại 390 × 844 dư khoảng 290 px giữa hàng pod và footer. Thứ tự lấp chỗ dư:
1. Dư ≥ 32 px: pod sang biến thể **mở rộng** (03 §5), thêm hàng chip đất/nhà/thẻ tù và thanh tổng tài sản. Pod cao 64 → 96.
2. Còn dư ≥ 72 px: dòng sự kiện của footer mở lên thành **thẻ Diễn biến** đặt ngay trên thanh nút footer. Thẻ hiện 2–6 dòng gần nhất (mới ở trên) và lấp hết phần còn lại, giống `GameLog` v2.
3. Khung không dư (3:4, tablet, màn ngắn < 700): giữ đúng concept — pod compact, footer 1 dòng.

Không kéo giãn bàn theo chiều dọc. Bàn luôn vuông (ảnh concept hơi cao hơn rộng, ≈ 1 : 1.12, nhưng spec giữ vuông).

Width 360: bàn 336, pod 4 × 79. Width ≥ 480: bàn 456–480, pod đủ rộng cho bố cục ngang như concept (03 §5).

### 6.2 Bàn — vị trí ô và thông tin trên ô

- Góc cố định (không xoay bàn, mọi người thấy cùng hướng): **dưới-trái** `XUẤT PHÁT` (mũi tên jade chỉ lên + `+160 tr` jade), **trên-trái** `NHÀ TÙ` (tranh pixel phòng giam có Anh Tèo, dải `Thăm tù` ở đáy ô), **trên-phải** `LỄ HỘI` (nền navy đậm, tranh pixel đèn lồng + ngôi sao vàng, `Thuê x2`), **dưới-phải** `DU LỊCH` (vali cam có máy bay, `Bay lượt sau`). Chi tiết ở `style/02-board-tiles.md` §3. Đi **thuận kim đồng hồ** từ Xuất phát: cột trái dưới → trên, hàng trên trái → phải, cột phải trên → dưới, hàng dưới phải → trái. Thứ tự 32 ô ở 05 §1.
- Mỗi ô cạnh, mọi phía, chữ luôn đứng thẳng, đọc từ trên xuống:
  1. **tên ô** (ngắn, `shortName`) sát mép trên ô;
  2. **tranh/glyph** ở giữa: tranh pixel 16-bit địa danh cho ô đất, tranh pixel máy bay cho sân bay, glyph cho Cơ hội/Khí vận/Thuế;
  3. **giá** sát mép dưới ô (`220 tr`); ô Thuế hiện `−10%` màu coral; ô Cơ hội/Khí vận không có dòng giá.
- **Dải màu nhóm** luôn nằm ở mép **phía trong** bàn: hàng trên → dải ở đáy ô; hàng dưới → dải ở đỉnh ô; cột trái → dải ở mép phải ô; cột phải → dải ở mép trái ô. Cấp nhà (1–2 nhà hoặc khách sạn) đặt trên dải. Ô không phải đất không có dải.
- Ô có chủ: nền nhạt màu ghế + vạch 3 px màu ghế ở mép **ngoài**, để không lẫn với dải nhóm ở mép trong. Dòng giá đổi thành viên tiền thuê hiện tại (nền paper sáng, viền màu chủ).
- Quân: con tốt màu ghế (03 §3). Đế quân đứng trên mép **trong** của ô; thân nhô vào vùng trong bàn, không che tên/giá. Ô 8: quân trong tù đứng trong tranh phòng giam, quân thăm tù đứng dải `Thăm tù`.
- Tap ô bất kỳ (kể cả ô góc, ô đặc biệt) → S7. Vùng chạm mở rộng 4 px mỗi phía.

### 6.3 Vùng trong bàn — chồng thẻ và cụm lượt

Vùng trong = phần bàn trừ 4 cạnh ô (72.8% cạnh bàn, 266 × 266 tại 390). Nền paper trơn; không logo/watermark và không cảnh lớn phía sau nút. Logo đã chuyển lên header.

| Phần tử | Vị trí trong vùng trong (% theo cạnh vùng trong) | Kích thước tại 390 | Ghi chú |
|---|---|---|---|
| Chồng `CƠ HỘI` | góc **trên-trái**, cách mép trên 4%, mép trái 6% | 58 × 41 (22% rộng) | `--ty-chance` cam, chữ `CƠ HỘI` + `?` cream; 3 lớp nổi khối (03 §10); chỉ trang trí, không bấm |
| Chồng `KHÍ VẬN` | góc **trên-phải**, đối xứng | 58 × 41 | `--ty-chest` xanh trời, chữ `KHÍ VẬN` + glyph gió |
| Cụm lượt | căn giữa ngang; tâm dọc ở 53% (thấp hơn tâm một chút để chừa chỗ hai chồng thẻ) | rộng tối đa 246, cao 140–170 | 3 hàng + dòng gợi ý, xem dưới |

Cụm lượt (`TurnCluster`, 03 §6), từ trên xuống:

| Hàng | Trái → phải | Kích thước tại 390 |
|---|---|---|
| 1. Chip lượt + đồng hồ | chip pill gold `(avatar) Lượt của bạn` · khoảng 8 · vòng đồng hồ `0:28` bên phải chip; cả hàng căn giữa | chip cao 34, đồng hồ ⌀ 40 |
| 2. Xúc xắc | hai viên cạnh nhau, khoảng 16 | 40 × 40 mỗi viên |
| 3. Nút theo pha | xem bảng pha | cao 48; CTA đơn rộng 196 (≈ 74% vùng trong), pill nổi khối |
| 4. Gợi ý thắng ngay | pill `Thắng ngay: 3 nhóm · 1 cạnh · 4 sân bay`, chỉ ở pha `roll` của mình | cao 24, chữ 12.5/600 navy 70% |

Khoảng cách giữa các hàng 10. Ảnh mẫu đặt chip ở 31–40%, xúc xắc 43–60%, CTA 63–74%, gợi ý 77–81% chiều cao vùng trong.

**Nút theo pha.** Luật có 9 pha (`PHASES` trong `logic/constants.ts`). Hàng 1 luôn giữ nguyên; hàng 2–3 đổi theo pha. Cột cuối là dòng phụ dưới chip lượt khi **người khác** đang ở pha đó.

| phase | Hàng 2 (của mình) | Hàng 3 (của mình, trái → phải) | Hết giờ (server làm thay) | Dòng phụ khi chờ người khác |
|---|---|---|---|---|
| `roll` | 2 xúc xắc (mặt lần gieo trước, hoặc 1–1 lúc đầu ván) | `Gieo xúc xắc` CTA vàng 196 (ic-dice); đang có đôi: `Gieo thêm lượt (đôi!)`. Dòng gợi ý `Thắng ngay` bên dưới | gieo | `đang gieo xúc xắc…` |
| `jail` | 2 xúc xắc | 3 nút đứng đều 74 × 56: `Gieo đôi` gold (dòng phụ `lần n/3`) · `Nộp phạt` paper (`50 tr`) · `Dùng thẻ` paper (`còn n`, disabled khi 0) | gieo; lượt 3 thì nộp phạt | `đang ở tù, chọn cách ra…` |
| `decide` | thẻ sổ đỏ thu gọn 246 × 52 thay xúc xắc: dải nhóm trái, tên + tranh nhỏ, `Giá`, `Thuê`, `x/y của bạn`; chạm mở S7 | `Bỏ qua` paper 40% · `Mua {giá} tr` CTA vàng 60% kèm dòng phụ `còn lại …` (không đủ tiền → disabled, `cần …`) | bỏ qua | `đang cân nhắc mua {ô}…` |
| `takeover` | thẻ sổ đỏ thu gọn 246 × 52: dải nhóm, tên ô, chip chủ cũ (avatar VIP + `@username` + màu ghế), `Cấp n`, `Giá mua lại {x} tr` (= 2 × (giá đất + chi phí các cấp)); chạm mở S7 | `Bỏ qua` paper 40% · `Mua lại {x} tr` CTA vàng 60% kèm dòng phụ `còn lại …` (pha chỉ mở khi đủ tiền, nên không có trạng thái thiếu tiền) | bỏ qua | `đang cân nhắc mua lại {ô} của @username…` |
| `festival` | dòng `Chọn thành phố của bạn để tổ chức Lễ hội · thuê ×2` + hàng chip thành phố của mình cuộn ngang (tên ngắn + `thuê …` sau ×2; ô đang có Lễ hội viền gold). Trên bàn: thành phố của mình sáng, ô khác mờ 45% | `Bỏ qua` paper 196. **Không có nút vàng ở cụm lượt:** chạm chip hoặc ô → S7 với nút vàng `Tổ chức Lễ hội ở đây` (7.4) | chọn thành phố có tiền thuê cao nhất | `đang chọn nơi tổ chức Lễ hội…` |
| `travel` | `tg-travel` + dòng `Du lịch — chạm ô bất kỳ để bay tới`. Trên bàn: ô đang đứng mờ 45% | `Không bay, gieo xúc xắc` paper 196. **Không có nút vàng ở cụm lượt:** chạm ô → S7 với nút vàng `Bay tới đây` (7.4) | gieo bình thường | `đang chọn nơi bay tới…` |
| `card` | O2 thay **cả** hàng 2 và 3 (xem O2) | `Làm theo thẻ` nằm trong thẻ | làm theo thẻ | thẻ O2 hiện cho mọi người, không có nút; dòng phụ `đang đọc thẻ…` |
| `manage` | 2 xúc xắc (mặt vừa gieo) | `Nâng cấp` paper 40% (mở S8; ẩn nếu chưa trọn nhóm nào, khi đó CTA rộng 196) · `Kết thúc lượt ›` CTA vàng 60%; vừa gieo đôi → `Gieo tiếp (đôi!)` (vẫn gửi END_TURN) | kết thúc lượt | `đang xây nhà…` |
| `debt` | dòng cảnh báo coral `Bạn đang nợ {x} tr` | không nút; O3 mở giữa màn (nút vàng `Trả {x} tr` nằm trong O3) | tự hạ cấp nhà rồi trả, không đủ thì phá sản | `đang xoay tiền trả nợ…` |

Hết giờ local (deadline qua): hàng 3 thay bằng dòng `Hết giờ, hệ thống đang đi thay bạn…`, mọi nút disabled cho đến STATE mới. Khi `movePending`: nút vừa bấm hiện spinner, cả hàng 3 disabled.

**Không tới lượt mình:** hàng 1 là chip paper `(avatar VIP) Lượt của @username` viền màu ghế người đó, đồng hồ thay bằng 3 chấm "đang nghĩ". Dưới chip là dòng phụ 12.5 navy 70% theo cột cuối bảng trên (lúc replay: `đang di chuyển…`). Hàng 2 chỉ hiện xúc xắc khi người đó gieo (O1). Hàng 3 trống, không có dòng gợi ý. Cụm co lại nhưng vẫn giữ tâm ở 53%.

**Nút vàng:** mỗi lúc chỉ có **một** nút gold trên màn (style/05 §1). Mặc định nó ở hàng 3 cụm lượt. Ngoại lệ: pha `festival`/`travel` nút gold nằm trong S7 (cụm lượt chỉ có nút paper); pha `debt` nút gold nằm trong O3. Sheet mở ở pha có gold trong cụm lượt (ví dụ S7 lúc `decide`) không có nút gold thứ hai.

### 6.4 Header

| Vị trí | Phần tử | Kích thước tại 390 | Hành vi |
|---|---|---|---|
| Trái, lề 12 | logo chữ `CỜ TỶ PHÚ` + xúc xắc nhỏ (raster `lobby/logo.webp` hoặc live text) | cao 32, rộng ≤ 120 | không bấm |
| Giữa (căn theo màn, không theo phần còn trống) | `RoundChip` `Vòng 7/30 · 18:20` (vòng / 30 + giờ còn lại của 25 phút) pill paper viền navy | 108 × 32 | không bấm; đổi màu từ vòng 28 (O7); giờ đổi đỏ khi còn ≤ 3 phút |
| Phải, cách mép 12 | nút âm thanh tròn | 44 × 44 | bật/tắt âm, `aria-pressed` |
| Phải cùng | nút menu tròn (☰ trong concept) | 44 × 44 | popover paper: `Về sảnh` · `Luật chơi` · `Hiệu ứng: Đầy đủ / Nhẹ / Tắt` (radio, 08 §5) · `Bỏ cuộc` (coral) |

Width < 370: ẩn chữ logo, chỉ giữ biểu tượng xúc xắc để chip vòng không bị đẩy lệch.

### 6.5 Hàng pod và footer

**Hàng pod.** Ngay dưới bàn, cách 8. 2–4 pod chia đều một hàng; thứ tự trái → phải theo seat (seat 0 gold, 1 xanh, 2 san hô, 3 tím), không đổi theo lượt. Có thể là `Bạn` ở bất kỳ vị trí nào; pod của mình ghi `Bạn`, pod người khác ghi `@username`; avatar mọi pod là icon VIP (03 §18). Bố cục bên trong pod ở 03 §5. Tap pod → S8 xem tài sản người đó (của mình thì có nút xây/bán).

**Footer.** Một hàng cao 44, đáy màn + safe-area:

| Vị trí | Phần tử | Hành vi |
|---|---|---|
| Trái | nút pill `Tài sản` (icon danh sách/sổ) | mở S8 của mình |
| Kế bên | nút pill `Diễn biến` (icon cột) | mở sheet diễn biến đầy đủ |
| Vạch ngăn dọc | — | — |
| Phần còn lại | dòng sự kiện mới nhất: icon xúc xắc + câu log, người chơi hiện icon VIP 14 + `@username` tô màu ghế (03 §18), số tiền jade/coral (`@linh vừa qua Xuất phát +160 tr`), cắt `…` nếu dài | chạm mở sheet diễn biến |
| Phải cùng (bản online) | nút `ic-chat` 44 có chấm đỏ khi có tin mới | mở ChatDrawer; bản chơi với máy không có |

Khi màn dư chỗ (6.1 mục 2), dòng sự kiện thành thẻ Diễn biến nhiều dòng, đặt trên thanh nút. Lúc đó thanh footer chỉ còn hai nút + chat.

### 6.6 Lớp phủ trong S6 — vị trí

| Lớp | Vị trí |
|---|---|
| O1 xúc xắc | đúng ô xúc xắc của hàng 2 cụm lượt — không có khay riêng |
| O2 thẻ bài | giữa vùng trong, thay cụm lượt (che cả 3 hàng), không đè pod |
| Turn announce `ĐẾN LƯỢT BẠN` | giữa vùng trong, đè lên cụm lượt 1.2 s |
| O7 `Vòng cuối!` | giữa vùng trong, 2.5 s |
| O6 toast | mép trên vùng trong, đè lên hai chồng thẻ (z trên), rộng tối đa 240, tự ẩn 2.5 s |
| O4 mất kết nối | dải 100% × 36 dính ngay dưới header, đè lên hàng ô trên; không đẩy layout |
| Tiền bay `+200` / `−120` | bay lên từ dòng tiền của pod tương ứng |
| S7, S8, sheet diễn biến | bottom sheet đè toàn màn |
| O3, O5, S9 | modal giữa màn |

### 6.7 Sự kiện trong S6
- `STATE` → replay steps (01 §8) → cập nhật pod/bàn/cụm lượt.
- `turnAnnounce` khi `turn` đổi sang mình: `ĐẾN LƯỢT BẠN` + `bridge.attention(YourTurn)`.
- `OPPONENT_DISCONNECTED` → O4 với icon VIP + `@username` người rớt; nếu người rớt đang tới lượt, đồng hồ dừng (engine pause).
- Bỏ cuộc: menu header → `Bỏ cuộc` (ic-flag) → O5 `Bỏ cuộc? Bạn sẽ bị tính phá sản và xếp cuối.` → `FORFEIT`.

---

## S7. Sheet chi tiết ô

Bottom sheet 100% × auto (max 62% chiều cao), paper, radius 28 trên, handle 36×4.

### 7.1 Ô đất (`street`)
- Dải màu nhóm cao 44 trên cùng, tên nhóm 12.5/500 navy trên dải màu sáng hoặc cream trên dải tối.
- Tên ô 20/800, chip chủ sở hữu (avatar VIP 20 + `@username`; của mình ghi `Bạn`) hoặc `Chưa có chủ`.
- Dòng giá `Giá 220 tr` · `Nhà 150 tr`.
- Dòng `Giá nâng mỗi cấp 150 tr`.
- Bảng tiền thuê 4 hàng: `Đất trống` (ghi `×2 khi trọn nhóm`), `Cấp 1 · Nhà`, `Cấp 2 · Biệt thự`, `Cấp 3 · Khách sạn`; hàng đang áp dụng (theo cấp hiện tại và chủ) highlight gold 30%.
- Hàng `Cấp hiện tại`: 1–2 glyph nhà hoặc 1 khách sạn + tên cấp.
- Nút theo ngữ cảnh: `Mua 220 tr` (khi `decide` và là ô đang đứng), `Nâng cấp (150 tr)` / `Hạ cấp (+75 tr)` (khi của mình + pha manage/debt + hợp lệ), disabled kèm lý do 12.5 coral (`Cần sở hữu trọn nhóm — thiếu Huế`, `Nâng đều: Huế mới ở cấp 1`, `Đã đạt cấp tối đa (cấp 3)`).

### 7.2 Sân bay
- Bảng 4 hàng số sân bay ↔ tiền thuê; highlight hàng hiện tại.

### 7.3 Ô đặc biệt
- Mô tả 1–2 dòng (`Nhận 160 tr mỗi lần đi qua`, `Lượt sau được bay tới bất kỳ ô nào…`, `Đóng 10% tổng tài sản…`), không nút.

### 7.4 Nút theo pha Mua lại / Lễ hội / Du lịch
- Pha `festival` của mình: S7 của thành phố mình có nút gold `Tổ chức Lễ hội ở đây` (dòng phụ `thuê … → …`). S7 của ô khác chỉ xem, không nút. Cụm lượt hiện hàng chip thành phố + `Bỏ qua` (6.3).
- Pha `travel` của mình: chạm ô bất kỳ trên bàn (trừ ô đang đứng) → S7 có nút gold `Bay tới đây` (dòng phụ `+160 tr` nếu bay qua Xuất phát). Cụm lượt hiện hướng dẫn + `Không bay, gieo xúc xắc` (6.3).
- Pha `takeover` của mình: S7 của ô đó chỉ xem (bảng thuê, chủ cũ, cấp nhà, giá mua lại); nút `Mua lại` ở cụm lượt. Ô Khách sạn và sân bay không vào pha này.
- Ô đang có Lễ hội: sheet thêm hàng `Đang có Lễ hội · Thuê ×2`; số thuê trên bàn đã gồm ×2.

---

## S8. Sheet quản lý tài sản

Bottom sheet max 70%.
- Header: `Tài sản của bạn` + tổng `2.340 tr` 22/800 (tiền mặt + đất + nhà) + dòng `Tiền mặt 820 tr`.
- Danh sách theo nhóm: header nhóm = chip màu + tên + `2/2` (sở hữu/tổng; mỗi nhóm 2 thành phố); hàng ô: tên, nhà hiện có, nút `+` (xây) / `−` (bán) 36×36 với giá bên cạnh; disabled kèm tooltip lý do.
- Nhóm chưa trọn: hiện mờ, chú thích `Thiếu Đà Nẵng`.
- Sân bay liệt kê cuối, không nút.
- Mọi `BUILD/SELL_HOUSE` gửi ngay, sheet không đóng; số cập nhật khi STATE về (có `movePending` theo ô).

---

## S9. Kết quả

Modal 340 × auto, radius 28, không đóng khi tap backdrop.
- Title theo hạng của mình: `Tỷ phú số 1!` gold / `Hạng 2` / `Hạng 3` / `Phá sản` coral; dòng lý do (`@username sở hữu trọn 3 nhóm màu — thắng ngay` / `… trọn thành phố một cạnh bàn — thắng ngay` / `… cả 4 sân bay — thắng ngay` / `Bạn đã phá sản` / `Hết 30 vòng — xếp hạng theo tổng tài sản` / `Hết 25 phút — xếp hạng theo tổng tài sản` / `Chỉ còn một tỷ phú trụ lại` / `Bạn đã bỏ cuộc`).
- Bảng 2–4 hàng: hạng, avatar VIP + `@username` (cả hàng của mình), tổng tài sản 15/800, chip XP `+50` (từ `expGains`). Hàng mình viền màu ghế.
- Bàn có cược: mỗi hàng thêm `±KEN` (hạng 1 jade, còn lại coral); bàn 0 không hiện (11 §1.3).
- Nút `Chơi lại` CTA vàng (→ `ROOM_READY`, về S5 nếu phòng còn) + `Đóng` (→ S3).

---

## S10. Lịch sử

Giống xiangqi S8: 100 trận gần nhất; mỗi hàng: hạng của mình (`#1`…`#4`, màu gold cho #1), số người, thời gian, chip `Bỏ cuộc` nếu `reason` tương ứng. Cột `KEN` theo `kenDelta` của mình; bàn giao lưu ghi `—`.

## S11. Bảng xếp hạng

Giống xiangqi S9: tab Hôm nay/Tuần này, mỗi hàng hạng + avatar VIP + `@username` (03 §18), cột thắng (hạng 1) – trận. Không có cột KEN ở v1.

---

## O1. Xúc xắc

Hai viên 40 × 40 tại 390 (44 khi bàn ≥ 456) radius 12 mặt trắng viền navy 2, nổi khối và nghiêng nhẹ (03 §4), dot navy, nằm ở hàng 2 của cụm lượt (6.3). Lăn theo 01 §8. Dừng → chip tổng `= 7` 15/800 ngay bên phải viên thứ hai; double → chip `Đôi!` gold thay chip tổng. Chip tự ẩn khi quân bắt đầu di chuyển 200 ms, xúc xắc ở lại hiện mặt vừa gieo.

## O2. Thẻ bài

Thẻ 236 × 168 tại 390 (tối đa 280 × 180 khi bàn ≥ 456), đặt giữa vùng trong và thay cả cụm lượt (6.6). Mặt sau = dải màu loại + glyph (ic-chance `?` / ic-chest). Lật → mặt trước:
- dải đầu 28 px ghi tên loại `CƠ HỘI`/`KHÍ VẬN`;
- nội dung 15/600, tối đa 3 dòng; số tiền màu jade/coral;
- nút `Làm theo thẻ` CTA vàng 100% × 44 dính đáy thẻ, chỉ người rút thấy.

Người khác thấy thẻ không có nút; thẻ tự ẩn khi có STATE kế tiếp. Thẻ bay ra từ chồng tương ứng ở góc trên vùng trong (08).

## O3. Trả nợ

Modal 340: `Bạn cần trả {amount} tr cho @username/ngân hàng` (có icon VIP trước `@username`), dòng `Tiền mặt {cash} tr`, dòng `Bán nhà có thể thu tối đa {x} tr`. Danh sách ô có nhà với nút `Bán −` (+ giá). Nút `Trả nợ` CTA vàng enabled khi `cash ≥ amount`; `Phá sản` danger (O5 confirm). Đồng hồ 30 s hiện trong modal. Khi tổng khả năng < amount: chỉ hiện `Phá sản` + giải thích.

## O4. Banner mất kết nối

Top banner 100% × 44: ic-wifi-off + icon VIP + `@username mất kết nối · 23s`; nhiều người rớt → gộp `2 người mất kết nối`. Tắt khi `OPPONENT_RECONNECTED` hoặc người đó bị quit (step `bankrupt`).

## O5. NoticeModal

Bỏ cuộc, thoát bàn, mời ra, phá sản, hạ cấp (chỉ khi hạ từ Khách sạn xuống Biệt thự). Cùng khung có thêm loại **thông báo** (một hoặc hai nút) cho tin người chơi phải đọc. Loại, tông, kích thước, hành vi và chữ theo [style O5 modal](./screens/o5-modal/README.md).

## O6. Toast + turn announce

Lỗi server (map `errorText`) là toast ở mép trên vùng trong bàn (6.6). `ĐẾN LƯỢT BẠN` đè giữa cụm lượt. `+160 tr qua Xuất phát` không cần toast riêng: nó đã hiện ở dòng sự kiện footer và tiền bay ở pod.

## O7. Banner vòng

Chip vòng ở giữa header kèm giờ còn lại; vòng 28–29 coral; vòng 30 hiện banner 1 lần `Vòng cuối! Xếp hạng theo tổng tài sản` 2.5 s ở giữa vùng trong bàn.
