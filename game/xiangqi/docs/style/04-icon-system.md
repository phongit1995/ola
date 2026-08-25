# 04 — Icon system và quy trình tạo icon mới

## 1. Mục tiêu

Icon của “Mộc bản thủ công” phải cho cảm giác được một người thiết kế cùng một lúc: nét chắc, silhouette dễ nhận ra, hơi ấm của bảng hiệu in tay nhưng hình học vẫn sạch. Chất “thủ công” không đồng nghĩa với đường méo ngẫu nhiên.

Production không dùng emoji hệ điều hành vì hình dáng, màu, baseline và độ bóng thay đổi theo OS. Emoji chỉ được giữ cho reaction content nếu đó là quyết định sản phẩm; icon điều khiển luôn là SVG của hệ thống.

## 2. Thư mục và naming

Nguồn icon dự kiến:

```text
game/xiangqi/assets/icons/
  ic-arrow-left.svg
  ic-chevron-left.svg
  ic-chevron-right.svg
  ic-close.svg
  ic-refresh.svg
  ic-volume-on.svg
  ic-volume-off.svg
  ic-lock.svg
  ic-ken.svg
  ic-chat.svg
  ic-reaction.svg
  ic-flag.svg
  ic-exit-door.svg
  ic-send.svg
  ic-wifi-off.svg
  ic-warning.svg
  ic-check.svg
  ic-owner.svg
  ic-ranked.svg
  ic-bot.svg
  ic-history.svg
  ic-leaderboard.svg
```

Quy tắc tên:

- Prefix bắt buộc `ic-`.
- Dùng kebab-case tiếng Anh theo **ý nghĩa**, không theo hình thức: `ic-exit-door`, không phải `ic-box-arrow`.
- Cặp trạng thái dùng hậu tố rõ: `volume-on/off`, `eye-show/hide`.
- Không thêm kích thước vào tên file. Một SVG viewBox 24 phải scale được 16/20/24/32.
- Không dùng `final`, `new`, `v2`. Thay đổi lớn được quản lý bằng git và cập nhật docs.
- Icon chỉ dùng riêng cho Xiangqi nằm ở đây; icon dùng chung nhiều game phải chuyển vào package shared theo quy ước repo.

## 3. Grid chuẩn

### Master grid

- Artboard/viewBox: `0 0 24 24`.
- Safe area mặc định: từ `2` đến `22` ở cả hai trục.
- Stroke: `2` user units.
- Linecap: `round`.
- Linejoin: `round`.
- Miter limit: không phụ thuộc miter; tránh góc nhọn dài.
- Tọa độ ưu tiên số nguyên hoặc `.5` khi cần pixel alignment ở stroke 1.5/2.

### Kích thước render

| Kích thước | Vị trí dùng | Điều chỉnh |
|---:|---|---|
| 16 | inline badge, KEN, status nhỏ | bỏ chi tiết phụ; stroke vẫn nhìn tương đương 1.5–2 px |
| 18 | banner/status | icon đơn giản, không quá 2 chi tiết bên trong |
| 20 | button chuẩn, screen header | default compact |
| 24 | action bar, icon-only button | master size |
| 32 | empty state nhỏ | không thêm chi tiết mới chỉ vì icon lớn |

Không render icon điều khiển dưới `16 px`. Hit target do button quyết định, không do kích thước icon.

## 4. DNA hình học

### Được dùng

- Khối cơ bản rõ: circle, rounded rectangle, line, arc.
- Góc ngoài mềm, đầu nét tròn.
- Silhouette hơi nặng ở đáy hoặc trục chính, gợi cảm giác dấu in.
- Một mảng fill nhỏ tối đa khoảng 20% diện tích khi cần diễn tả active/notification.
- Bất đối xứng có chủ đích tối đa `1 px` để căn quang học, không “làm cũ” ngẫu nhiên.

### Không được dùng

- Nét wobble/noise tự động.
- Vết sứt ngẫu nhiên trên mỗi icon.
- Gradient, inner shadow, glow, 3D hoặc photorealistic material.
- Chi tiết dưới `1.5 px` ở master 24.
- Trộn stroke 1, 1.5, 2.5 trong cùng icon nếu không có lý do phân cấp rõ.
- Ornament rồng, mây, triện, mái đình hoặc pseudo-calligraphy để “làm Á Đông”.

Điểm nhận diện nằm ở palette và tỷ lệ nét, không nằm ở việc trang trí icon bằng họa tiết văn hóa.

## 5. Optical alignment

- Icon tròn có thể vượt safe area `0.25–0.5 px` để nhìn bằng kích thước với icon vuông.
- Tam giác/play/send dịch phải `0.5 px` nếu tâm thị giác lệch trái.
- Arrow có shaft nằm trên pixel grid; head không chạm safe edge.
- Icon có đáy nặng như door/flag có thể dịch lên `0.5 px`.
- Hai icon toggle phải có cùng bounding box để không nhảy layout.
- Preview bắt buộc ở 16, 20 và 24 px; không duyệt chỉ ở zoom 800%.

## 6. Màu

Mặc định SVG dùng `currentColor`:

```svg
<svg
  xmlns="http://www.w3.org/2000/svg"
  viewBox="0 0 24 24"
  fill="none"
  stroke="currentColor"
  stroke-width="2"
  stroke-linecap="round"
  stroke-linejoin="round"
  aria-hidden="true"
  focusable="false"
>
  <!-- paths -->
</svg>
```

- Trên wood: button đặt `color: var(--xq-cream)`.
- Trên paper: navy.
- Trên gold: navy.
- Danger: cream trên nền danger; ở action bar có thể dùng màu cảnh báo sáng đã kiểm tra contrast.
- Two-tone chỉ dùng khi trạng thái không thể đọc bằng một màu. Màu thứ hai lấy từ semantic token, không hardcode trong SVG.
- `ic-ken` có thể có fill gold khi nằm ngoài gold surface; khi ở CTA gold phải chuyển sang one-color navy.

## 7. SVG hygiene

Mỗi file phải:

- Có đúng một `viewBox="0 0 24 24"`.
- Không có `width`/`height` cứng trong source hoặc dùng `24` nhất quán nếu pipeline yêu cầu.
- Không có metadata editor, embedded bitmap, filter, mask phức tạp, clipPath không cần thiết.
- Không có transform matrix khó đọc; bake transform vào path trước khi commit.
- Dùng `currentColor`; không chứa màu hex ngoài exception đã ghi trong manifest.
- Không có `<text>`; glyph/icon được convert hoặc dựng path thủ công nếu thật sự cần.
- Path được tối giản nhưng không làm sai hình.
- `aria-hidden="true" focusable="false"` khi SVG nằm trong button có accessible name.

Giới hạn khuyến nghị: tối đa 6 path/shape và khoảng 1.5 KB/icon chưa gzip. Đây là guardrail, không phải lý do gộp path thành dữ liệu không bảo trì được.

## 8. Wrapper sử dụng

API gợi ý:

```tsx
type XqIconName =
  | 'arrow-left'
  | 'bot'
  | 'chevron-left'
  | 'chevron-right'
  | 'close'
  | 'refresh'
  | 'volume-on'
  | 'volume-off'
  | 'lock'
  | 'ken'
  | 'chat'
  | 'reaction'
  | 'flag'
  | 'history'
  | 'exit-door'
  | 'leaderboard'
  | 'send'
  | 'wifi-off'
  | 'warning'
  | 'check'
  | 'owner'
  | 'ranked';

<XqIcon name="chat" size={24} aria-hidden="true" />
```

Nếu icon tự mang nghĩa ngoài button, wrapper nhận `title`/accessible label. Nếu đã có visible label hoặc button `aria-label`, icon luôn aria-hidden để tránh screen reader đọc lặp.

Không dùng chuỗi tên icon nhận tùy ý từ server. Union/manifest là nguồn duy nhất để tránh file path injection và missing asset.

## 9. Inventory thay thế placeholder hiện tại

| Placeholder đang có | File thay thế | Size | Nơi dùng | Accessible name |
|---|---|---:|---|---|
| `←` | `ic-arrow-left.svg` | 20/24 | header History/Ranked/Leaderboard | Quay lại |
| `✕` | `ic-close.svg` | 20 | chat/modal | Đóng chat/Đóng |
| `🔊` | `ic-volume-on.svg` | 22 | lobby | Tắt âm |
| `🔇` | `ic-volume-off.svg` | 22 | lobby | Bật âm |
| `🔒` | `ic-lock.svg` | 16 | room/pregame | Có mật khẩu |
| `⛁` | `ic-ken.svg` | 16 | KEN/bet badge | số KEN nằm trong text chung |
| `💬` | `ic-chat.svg` | 24 | board action | Mở trò chuyện |
| `😊` | `ic-reaction.svg` | 24 | board action | Mở bảng cảm xúc |
| `🏳️` | `ic-flag.svg` | 24 | board action | Bỏ cuộc |
| `🚪` | `ic-exit-door.svg` | 24 | board action | Thoát bàn |
| pagination glyph | `ic-chevron-left/right.svg` | 20 | room footer | Trang trước/sau |
| refresh glyph | `ic-refresh.svg` | 20 | room footer | Làm mới danh sách |
| trophy | `ic-ranked.svg` | 22/24 | CTA lobby | Chơi xếp hạng |
| robot | `ic-bot.svg` | 22/24 | CTA lobby | Chơi với máy |
| clock/history | `ic-history.svg` | 20 | shortcut lobby | Xem lịch sử đấu |
| podium | `ic-leaderboard.svg` | 20 | shortcut lobby | Xem bảng xếp hạng |

Reaction content (`❤️`, vỗ tay…) là một hệ asset riêng. Không dùng reaction face làm icon điều khiển nếu style/size khác hệ line icon.

## 10. Công thức hình học cho icon lõi

Các mô tả dưới đây là constraint để người vẽ khác nhau tạo kết quả cùng họ.

### `ic-arrow-left`

- Shaft từ `(20,12)` đến `(5,12)`.
- Head từ `(11,6)` → `(5,12)` → `(11,18)`.
- Không thêm circle/background vào SVG; button cung cấp surface.

### `ic-chevron-left/right`

- Hai segment tạo góc, cao khoảng `10 px`, rộng `5 px`.
- Không có shaft.
- Left/right phải mirror chính xác cùng bounding box.

### `ic-close`

- Hai line từ khoảng `(7,7)` đến `(17,17)` và ngược lại.
- Không kéo tới safe edge; X phải cân ở 16 px.

### `ic-refresh`

- Arc chiếm khoảng 270°, bán kính 7–8.
- Arrow head liền với đầu arc, không dùng hai stroke weight.
- Không dùng hai arrow đối đầu gây giống sync nếu action chỉ là refresh.

### `ic-volume-on/off`

- Speaker body dùng cùng một path ở cả hai state.
- `on`: hai wave ngắn, không quá safe edge.
- `off`: bỏ wave, thêm slash hoặc X nhỏ rõ ràng; bounding box bằng bản on.

### `ic-lock`

- Body rounded rect từ khoảng y=10 đến y=20.
- Shackle arc cân tâm, không quá mảnh.
- Keyhole chỉ dùng một dot/short line; ở size 16 có thể bỏ keyhole.

### `ic-ken`

- Dùng đồng xu tròn đơn giản với một lỗ vuông/mark trung tâm, không mô phỏng tiền cổ chi tiết.
- Vòng ngoài stroke 2; chi tiết trong ít nhất 2 px.
- Không đưa chữ KEN hoặc Hán tự vào icon.

### `ic-chat`

- Rounded rectangle khoảng `(3,4)` đến `(21,18)`.
- Tail là một góc liền ở bottom-left hoặc bottom-right, không tách rời.
- Bên trong tối đa ba dot hoặc hai short line; ở size 16 bỏ bớt chi tiết.

### `ic-reaction`

- Circle chính khoảng 18 px.
- Hai mắt là dot/short line đối xứng.
- Miệng là một arc đơn; không thêm má hồng hoặc màu emoji.
- Silhouette phải khác `owner/user` khi nhìn ở 16 px.

### `ic-flag`

- Pole dọc từ y=3 đến y=21.
- Lá cờ là polygon mềm/line closed từ y=4 đến y=12, hướng phải.
- Chân pole ngắn; không dùng cờ trắng emoji hoặc animation phấp phới.

### `ic-exit-door`

- Door frame rounded/square từ x≈4 đến x≈14.
- Arrow hướng phải đi xuyên ngưỡng nhưng không cắt stroke khó đọc.
- Không dùng hình ngôi nhà; semantics là rời khỏi phòng hiện tại.

### `ic-send`

- Paper plane silhouette outline đơn giản, hướng phải.
- Một đường fold bên trong; không quá hai chi tiết trong.
- Căn quang học sang phải khoảng `0.5 px` nếu cần.

### `ic-wifi-off`

- Hai arc wifi + dot, sau đó slash rõ từ top-right xuống bottom-left hoặc ngược lại theo family.
- Slash không che hoàn toàn dot; icon vẫn đọc là wifi trước khi đọc là off.

### `ic-warning`

- Triangle bo nhẹ, không fill mặc định.
- Exclamation gồm line + dot với khoảng hở đủ ở 16 px.
- Dùng trong message lỗi/check; không dùng emoji ⚠.

### `ic-check`

- Hai segment, điểm thấp gần `(9,17)`, kết thúc `(20,6)`.
- Không thêm circle trừ khi component cần status contained; circle thuộc variant/component, không thuộc base icon.

### `ic-owner`

- Chọn một metaphor: crown tối giản **hoặc** badge star, không dùng cả hai.
- Nếu crown: tối đa ba đỉnh, đáy ngang; tránh vẻ casino/royal quá mức.
- Dùng gold/navy theo surface, size 16.

## 11. Quy trình tạo một icon mới

### Bước 1 — Viết yêu cầu semantic

Ghi rõ:

- tên hành động/trạng thái bằng tiếng Việt;
- nơi xuất hiện và surface;
- có visible label hay icon-only;
- size render nhỏ nhất;
- state/toggle liên quan;
- có icon gần nghĩa đã tồn tại hay không.

Không bắt đầu bằng câu “cần một hình đẹp”. Bắt đầu bằng hành vi mà icon phải truyền đạt.

### Bước 2 — Chọn metaphor

- Ưu tiên biểu tượng quen thuộc đa nền tảng.
- Tránh metaphor chỉ có nghĩa do màu.
- So sánh silhouette với icon cùng màn để không nhầm.
- Nếu cần giải thích dài, icon không đủ rõ; dùng visible label.

### Bước 3 — Phác thảo trên grid 24

- Vẽ 2–3 silhouette đen trắng.
- Kiểm tra ở 16 px trước khi thêm chi tiết.
- Chọn phương án ít path nhất nhưng còn rõ nghĩa.
- Căn optical center, không chỉ geometric center.

### Bước 4 — Chuẩn hóa nét

- Stroke 2, round cap/join.
- Safe area 2 px.
- Loại bỏ điểm/segment không thấy ở size thật.
- Dùng cùng góc/radius với icon inventory.

### Bước 5 — Export sạch

- viewBox 24; currentColor.
- Xóa metadata, layer name, transform dư, bitmap/filter.
- Chạy formatter/SVG optimizer của repo nếu có; kiểm tra optimizer không làm hỏng path.
- Lưu `game/xiangqi/assets/icons/ic-{name}.svg`.

### Bước 6 — Tích hợp semantics

- Thêm tên vào typed manifest/wrapper.
- Icon trong button là aria-hidden; button nhận `aria-label` nếu không có visible label.
- Toggle có `aria-pressed`; popover trigger có `aria-expanded`.
- Không gắn handler trực tiếp lên SVG; handler nằm trên button hit target.

### Bước 7 — Visual QA

Render icon trong ma trận:

| Size | wood | paper | gold | danger | disabled |
|---:|---|---|---|---|---|
| 16 | ✓ | ✓ | nếu dùng | nếu dùng | ✓ |
| 20 | ✓ | ✓ | ✓ | ✓ | ✓ |
| 24 | ✓ | ✓ | ✓ | ✓ | ✓ |

Kiểm tra thêm focus ring, hover, 200% zoom, Windows/Android/iOS browser và reduced-motion nếu icon có animation.

### Bước 8 — Screenshot và review

- Chụp màn thực ở 390×844, không chỉ icon gallery.
- So với icon bên cạnh về stroke, baseline, visual mass.
- Review bởi ít nhất một người không vẽ icon; hỏi họ hiểu hành động gì trước khi đọc label.
- Cập nhật inventory trong file này nếu icon trở thành pattern chính thức.

## 12. Template ticket/icon spec

```md
### Icon: ic-{name}

- Hành động/trạng thái:
- Màn/component:
- Surface:
- Render size: 16 / 20 / 24 / 32
- Visible label: có / không
- Accessible name:
- Toggle/expanded state:
- Metaphor đã chọn:
- Icon gần nghĩa đã kiểm tra:
- Ngoại lệ màu/two-tone:
- Screenshot QA:
```

## 13. Checklist duyệt icon

- [ ] Tên theo `ic-{semantic-name}.svg`.
- [ ] viewBox 24, safe area và stroke 2 đúng chuẩn.
- [ ] Dùng currentColor; không gradient/filter/bitmap.
- [ ] Không có emoji hoặc chi tiết pseudo-Asian.
- [ ] Rõ ở 16 px, không chỉ ở file thiết kế phóng lớn.
- [ ] Cân quang học với icon lân cận.
- [ ] Toggle pair không nhảy bounding box.
- [ ] Button hit target ≥44 px.
- [ ] Có accessible name đúng hành động.
- [ ] Đã test trên wood, paper, gold, disabled và focus.
- [ ] Đã chụp màn thật và thêm vào visual regression nếu ảnh baseline thay đổi.
