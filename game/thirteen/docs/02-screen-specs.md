# 02 — Screen specifications

## 1. Hệ tọa độ và safe area

Mọi màn dùng viewport logic 390 × 844.

```css
.tl-screen {
  position: absolute;
  inset: 0;
  min-height: 100%;
  padding-top: max(12px, env(safe-area-inset-top));
  padding-bottom: max(12px, env(safe-area-inset-bottom));
}
```

Grid ngang chuẩn:

- gutter ở 360 px: 16 px;
- gutter ở 390 px: 20 px;
- gutter từ 430 px: 24 px;
- max content width: 472 px;
- khoảng cách dọc thuộc scale 4/8/12/16/20/24/32/40.

Không đặt nội dung quan trọng sát đường cong biên chiếu dưới 12 px.

## 2. Loading

Concept tham chiếu đã duyệt: [concept-loading-style-02-ngay-vui.png](./screenshots/concept-loading-style-02-ngay-vui.png). Concept thể hiện state `connecting` tối giản với nền kem, mảng chiếu aqua, nhận diện “TIẾN LÊN / MIỀN NAM”, dòng “Đang kết nối...” và ba progress dot; không thêm control hoặc dữ liệu ngoài source.

### 2.1 Bố cục

- toàn màn `cream.100`;
- một mảng chiếu aqua hình ellipse chiếm 70% width, nằm giữa y 290–560;
- đường coral/cream/navy chạy theo ellipse;
- title ở tâm y khoảng 360;
- subtitle dưới title 12 px;
- progress indicator dưới subtitle 20 px.

### 2.2 Title

- text thật: “TIẾN LÊN MIỀN NAM”;
- `title.lg`, navy;
- không plaque, không logo raster;
- có thể tách “MIỀN NAM” coral nếu layout cho phép.

### 2.3 Progress

- track 160 × 8, radius pill, `cream.300`;
- fill aqua hoặc sun;
- nếu không có progress thật: ba dot 8 px, chuyển opacity;
- reduced motion: giữ một dot sun tĩnh và text trạng thái.

### 2.4 Error/reconnect

- subtitle đổi sang `coral.500`;
- thêm button secondary “Thử lại” 120 × 44;
- không đổi toàn background thành đỏ.

## 3. Lobby

### 3.1 Cấu trúc dọc tại 390 × 844

| Vùng | Y dự kiến | Chiều cao |
|---|---:|---:|
| topbar | 12–64 | 52 |
| logo | 70–166 | 96 |
| đường cong chuyển nền | 160–194 | 34 |
| CTA stack | 194–338 | 144 |
| room header | 348–392 | 44 |
| room list | 400–832 | flexible |

Ở màn thấp 740–799:

- logo giảm `display.xl` từ 44 xuống 38;
- khoảng logo→CTA giảm 8 px;
- room list vẫn scroll độc lập;
- không giảm vùng chạm button.

### 3.2 Nền

- 0–21%: `cream.100`;
- từ khoảng 19% đến đáy: `mat.bg` + pattern;
- vùng giao dùng curve lớn, không đường ngang thẳng;
- coral outer line 4 px;
- cream gap 7 px;
- navy/teal inner line 2 px;
- không có tường, cây, đồ vật hoặc phong cảnh.

### 3.3 Topbar

- display flex, justify-between, align-center;
- icon back trái 44 × 44;
- balance pill phải, cao 44, rộng theo nội dung 146–174;
- khoảng cách đến safe edge tối thiểu 16 px;
- nền transparent.

Back button:

- `surface.default`, border navy 2 px, radius 12;
- icon 24 px;
- shadow control;
- pressed translateY 2 px.

Balance pill:

- surface cream, border navy 2, radius pill;
- padding 4 px 12 px 4 px 4 px;
- avatar 34 px;
- khoảng avatar→số 8 px;
- coin 20 px bên phải, cách số 8 px;
- số Ken `body.lg`, tabular nums, navy;
- VIP icon nếu có nằm đè avatar góc phải dưới, tối đa 14 px.

### 3.4 Logo

- không frame;
- “TIẾN LÊN”: `display.xl`, navy, center;
- “MIỀN NAM”: 18/22, weight 800, coral, letter-spacing 0.28em;
- có thể đặt bốn suit mini hai bên subtitle: club teal, diamond coral, heart coral, spade teal;
- suit chỉ 12–14 px, opacity 90%, không cạnh tranh title;
- tổng logo width tối đa 320 px.

### 3.5 CTA stack

Container:

- width `calc(100% - 40px)`;
- max-width 440 px;
- margin auto;
- gap 14 px;

“CHƠI NGAY”:

- width 100%, min-height 72 px;
- fill `action.primary` gradient cho phép;
- border navy 2 px;
- radius 20 px;
- shadow control;
- label `title.lg`, navy;
- subtitle `body.sm`, navy 86%;
- label và subtitle cách 2–4 px;
- không icon, không glow.

Queueing:

- label: “ĐANG TÌM BÀN...”;
- subtitle thay bằng trạng thái tìm;
- giữ vàng nhưng giảm saturation 8%;
- thêm ba dot hoặc spinner navy 16 px;
- button vẫn có nút hủy theo logic hiện tại; không pulse scale.

“+ Tạo bàn riêng”:

- min-height 52 px;
- cream fill;
- border navy 2;
- radius 16;
- chữ 17 px weight 800;
- dấu plus là text/icon navy, không màu khác;
- shadow control.

### 3.6 Room list header

- layout: title trái, refresh button phải;
- title `title.md`, navy;
- số trong ngoặc `teal.600`;
- refresh 40 × 40, radius 12, cream fill, navy border;
- icon 22 px;
- khoảng header→row đầu 10 px.

### 3.7 Room list

- scroll dọc;
- padding-bottom tính safe area + 16 px;
- gap 10–12 px;
- scrollbar 4 px teal alpha 25%;
- không có frame bao ngoài danh sách.

Room row tại 390:

- width 100%;
- min-height 78 px;
- cream fill;
- border navy 2 px;
- radius 16;
- shadow control;
- padding 10 px 12 px;
- grid: `48px minmax(0,1fr) auto`;
- column gap 10 px.

Nội dung:

- avatar 48 px;
- room name 15–16 px, weight 800, ellipsis một dòng;
- lock icon 14 px ngay sau tên;
- meta row cách tên 4 px;
- seat dots 9 px, gap 4 px;
- filled `aqua.500`, empty `aqua.100` với outline teal 15%;
- occupancy `body.sm`, `teal.600`, tabular nums;
- action 84–96 × 42 px.

State:

- joinable: action vàng, label “Vào bàn”;
- playing: row vẫn cream, badge coral nhỏ “Đang chơi”, action aqua nhạt, label navy;
- full: action `cream.200`, border `teal.700`, label “Đầy”;
- locked: lock icon sun/coral nhưng tên vẫn navy;
- muted không dùng opacity cho toàn row vì sẽ làm text khó đọc;
- hover pointer: fill `#FFF7DF`;
- focus-within: ring blue 3 px cách 2 px.

Empty state:

- nằm giữa vùng list;
- icon bốn lá bài outline navy/aqua, 56 px;
- text “Chưa có bàn nào — hãy tạo bàn đầu tiên!” `body.md`;
- không dùng ảnh minh họa AI.

## 4. Modal tạo bàn và nhập mật khẩu

Concept tham chiếu đã duyệt cho state tạo bàn: [concept-create-room-style-02-ngay-vui.png](./screenshots/concept-create-room-style-02-ngay-vui.png). Concept giữ nguyên lobby phía sau backdrop, dùng modal kem, mặc định chọn “4 người”, placeholder “Không đặt mật khẩu” và hai hành động “Hủy”/“Tạo bàn”. Modal nhập mật khẩu tái sử dụng cùng shell, input và action family nhưng lấy title/nội dung runtime từ source.

### 4.1 Backdrop

- `rgba(8,46,74,.38)`;
- backdrop blur tối đa 3 px, có fallback không blur;
- click ngoài đóng nếu logic cho phép;
- focus trap bắt buộc.

### 4.2 Modal

- width `min(350px, calc(100% - 32px))`;
- cream fill;
- navy border 2 px;
- radius 20 px;
- shadow overlay;
- padding 20 px;
- không title plaque;
- top accent là line coral 48 × 4 px, radius pill, căn giữa, optional.

Title:

- `title.lg`, navy;
- center hoặc left nhất quán; mặc định center;
- margin-bottom 18 px.

Field label:

- 13/18, weight 800, navy;
- margin-bottom 6 px;

Capacity selector:

- hàng 3 segment 2/3/4 người;
- gap 8 px;
- mỗi segment min 64 × 44;
- inactive cream, navy border;
- active aqua.100 fill + navy 3 px hoặc sun fill;
- có check mini hoặc thay đổi border để không dựa riêng màu.

Input:

- height 46 px;
- cream.50 fill;
- navy border 2 px;
- radius 12 px;
- horizontal padding 12 px;
- font 15/20 weight 700;
- placeholder navy 52%;
- focus ring blue 3 px ngoài border;
- error border coral + error text 12 px dưới input.

Actions:

- hai nút cùng height 48;
- gap 10 px;
- cancel cream;
- confirm vàng;
- ở width dưới 350 vẫn giữ một hàng nếu label vừa, nếu không stack dọc confirm trước.

### 4.3 Loading submit

- giữ width nút;
- spinner navy 16 px;
- label vẫn còn hoặc dùng “Đang tạo...”;
- disable capacity/input để tránh submit kép;
- không giảm opacity modal.

## 5. Phòng chờ

Concept tham chiếu đã duyệt: [concept-room-style-02-ngay-vui.png](./screenshots/concept-room-style-02-ngay-vui.png). Concept thể hiện góc nhìn chủ bàn, 3/4 người, hai khách đã sẵn sàng, một ghế trống, chat phòng và cặp hành động “Rời bàn”/“Bắt đầu”. Source React vẫn là chuẩn cho tên, dữ liệu và trạng thái runtime.

### 5.1 Background

- toàn màn `mat.bg` + pattern;
- topbar đặt trên dải cream cao 72–82 px;
- mép dưới topbar có coral 4 px + cream 6 px + navy 2 px;
- không có kiến trúc hoặc frame ngoài.

### 5.2 Topbar/title

- back 44 × 44 bên trái;
- title center trong phần còn lại;
- title tối đa hai dòng: “Bàn của {owner}” và occupancy/password meta;
- dòng chính 17 px weight 800 navy;
- meta 12 px teal;
- spacer phải bằng width back để title căn giữa quang học.

### 5.3 Seat grid

- 2 cột;
- gap 12 px;
- padding 16–20 px;
- row min-height 126 px;
- tối đa 4 seat;
- ở phòng 2 người vẫn giữ grid 2 cột và không render hàng trống thứ hai.

Occupied seat:

- cream surface;
- navy border 2;
- radius 18;
- shadow control;
- padding 12 px;
- avatar 58 px ở tâm trên;
- name 15 px, max một dòng, ellipsis;
- badge dưới name 4 px;
- owner có crown sun ở góc trái trên và border-top accent sun 4 px;
- kick button 32 × 32 góc phải trên, cream/coral state, chỉ host thấy.

Empty seat:

- aqua.100 35% hoặc transparent;
- navy border 2 px dashed, dash 7 gap 5;
- plus circle 42 px, cream fill, navy outline;
- text “Chỗ trống” 13 px navy 70%;
- không illustration ghế.

### 5.4 Chat phòng

- cream panel;
- navy border 2;
- radius 16;
- margin 12–20 px;
- min-height 136 px, max-height 190 px;
- log scroll, padding 10 px 12 px;
- input row divider navy alpha 16%;
- input flex 1;
- send button 44 × 44 hoặc label 64 × 44.

Chat line:

- username weight 800, navy;
- dấu hai chấm cùng màu;
- message weight 600;
- line-height 18 px;
- không cần bubble cho log phòng;
- link/mention dùng teal.700 và underline.

### 5.5 Actions đáy

- sticky trong safe bottom;
- gradient fade aqua→transparent ở phía trên 20 px chỉ khi nội dung scroll;
- hai nút, gap 10 px;
- “Rời bàn” cream;
- host: “Bắt đầu” vàng;
- player: “Sẵn sàng” vàng, khi ready đổi cream + check teal;
- disabled dùng cream.200 + dashed/soft border và label rõ.

## 6. Bàn chơi

### 6.1 Cấu trúc

| Vùng | Y tại 390×844 | Ghi chú |
|---|---:|---|
| topbar kem | 0–68 | back/title/chat |
| curve trên | 62–88 | coral/cream/navy |
| opponent top | 82–176 | avatar/name/count |
| opponent left/right | 205–348 | bám cạnh |
| trick center | 300–520 | vùng bài đã đánh |
| local identity | 556–620 | avatar/name/status |
| hand | 610–758 | fan bài |
| action bar | 764–832 | safe bottom |
| curve dưới | 824–844 | trang trí, sau action |

Các giá trị co giãn theo chiều cao bằng `clamp()`; trick center không được chồng hand.

### 6.2 Nền bàn

- vùng chính aqua + pattern;
- topbar và strip đáy cream;
- curve trên/dưới đồng bộ lobby;
- không vành gỗ, không bàn oval 3D, không huy hiệu trung tâm;
- pattern giảm opacity còn 2–3% tại trick center để bài rõ.

### 6.3 Topbar

- back và chat 44 × 44;
- title “Tiến Lên Miền Nam” 17–20 px navy;
- title truncate nếu viewport nhỏ nhưng không xuống hai dòng;
- background cream;
- z-index trên card animation.

### 6.4 Opponent pod

Pod không có panel bao toàn bộ. Nó là stack:

1. avatar 48–54 px;
2. nameplate cream;
3. card stack + count hoặc badge.

Top opponent:

- centered;
- avatar 50 px;
- nameplate min 80, max 132, height 28;
- card mini đặt bên trái count;
- toàn pod width không quá 150.

Left/right opponent:

- inset cạnh 12–16 px;
- avatar 50 px;
- nameplate max 100 px;
- mini stack và count hướng vào tâm bàn;
- không che trick center.

Nameplate:

- cream fill;
- navy border 1.5–2 px;
- radius pill;
- padding 2 px 10 px;
- text 13–14 px weight 800;
- ellipsis.

Mini card stack:

- dùng `back.webp` hiện có hoặc card-back SVG được duyệt;
- 3 lá lệch x 5 px và rotate -6/0/6° tối đa;
- width mỗi lá 20–24 px;
- count 14 px navy, tabular nums.

### 6.5 Turn state

- ring conic sun quanh avatar, dày 4 px;
- track cream 60%;
- active thêm outer navy 1 px để giữ hình;
- urgent ≤5 giây chuyển phần còn lại sang coral và pulse opacity;
- không glow;
- inactive không render progress ring, chỉ avatar outline chuẩn.

### 6.6 Trick center

- vùng logic khoảng 150 × 158 tại 390;
- không có panel fill;
- chỉ dùng dashed cream border 2 px khi bàn trống hoặc cần gợi vùng đánh;
- border radius 18 px;
- khi có bài, dashed border giảm opacity 20% hoặc ẩn;
- card giữ tỷ lệ asset hiện tại;
- tối đa 4 lá hiển thị có overlap nhưng rank vẫn đọc được;
- owner chip cream, navy border, pill, nằm dưới trick 10 px;
- hint khi chưa có bài dùng cùng chip nhưng text teal/navy.

Chop FX:

- 6–10 tia coral/sun dạng SVG nét phẳng;
- scale 0.85→1, opacity 0→1→0 trong 500 ms;
- không particle kim loại hoặc glow.

### 6.7 Local player

- avatar 54–60 px ở trái, bám trên hand;
- active ring sun rõ hơn opponent;
- nameplate “Bạn” cream, gắn cạnh avatar;
- badge/place/pass nằm dưới hoặc phải nameplate, không chồng hand;
- disconnect state có coral pill, không phủ tối toàn bàn.

### 6.8 Hand

- giữ logic fan hiện tại;
- card width theo `clamp(48px, 14.1vw, 68px)` tùy số lá và viewport;
- overlap đủ để rank/suit góc trái hiện rõ;
- baseline cong nhẹ, tổng rotate không quá ±6°;
- shadow card: `0 3px 6px rgba(8,46,74,.20)`;
- selected: translateY -14 px, outline sun 3 px hoặc shadow sun ngắn;
- multi-select giữ cùng độ nâng;
- dealing state không khóa khả năng đọc action quá lâu.

### 6.9 Action bar

- hai nút chính “Bỏ lượt” và “Đánh”;
- gap 12 px;
- margin 20 px;
- height 52–56 px;
- “Bỏ lượt”: cream fill;
- “Đánh”: sun fill;
- width bằng nhau;
- action bar nền transparent;
- nếu có “Bỏ chọn”, dùng button compact 40–44 px trước hai nút hoặc text link phía trên, không làm ba nút chật.

Disabled:

- cream.200 fill;
- navy border alpha 48%;
- text navy alpha 58%;
- shadow bỏ;
- cursor và `aria-disabled` đúng;
- không chỉ giảm opacity toàn element dưới 50%.

## 7. Chat overlay trên bàn

Concept tham chiếu đã duyệt: [concept-table-chat-style-02-ngay-vui.png](./screenshots/concept-table-chat-style-02-ngay-vui.png). Concept giữ nguyên bàn chơi dưới backdrop, dùng bottom sheet kem với sáu reaction tile, chat log không bubble, input “Nhập tin nhắn...” và CTA “Gửi”; nội dung tin nhắn thực tế vẫn là dữ liệu runtime.

- backdrop navy 30%;
- bottom sheet cream;
- width 100%, max-width theo app;
- radius 24 px 24 px 0 0;
- border navy 2 px, bỏ border-bottom;
- max-height 62vh;
- padding bottom safe area;
- drag handle 40 × 4 teal alpha 35%, chỉ trang trí.

Reaction row:

- horizontal scroll;
- mỗi button 44 × 44;
- cream.100 fill, navy 1.5 px border, radius 12;
- reaction asset hiện có max 28 px;
- selected/press aqua.100.

Chat log và input dùng quy cách phòng chờ. Nút gửi vàng 48 px. Nút đóng là icon 44 px ở header sheet hoặc click backdrop.

## 8. Disconnect, toast và banner

Disconnect:

- pill coral.500, text cream.50;
- navy border 2 px;
- icon wifi-off 16 px;
- nằm trên local info, không che bài;
- countdown dùng tabular nums.

Toast:

- top-center dưới safe area;
- max-width 342 px;
- cream fill;
- navy border 2;
- left accent 5 px theo semantic color;
- radius 14;
- shadow panel;
- text 13–14 px navy;
- không black toast.

Finish banner:

- cream hoặc sun fill theo ý nghĩa;
- navy border 2;
- radius pill/16;
- live text;
- width theo nội dung, max 300 px;
- animation scale 0.96→1, không particle bắt buộc.

## 9. Result screen

Concept tham chiếu đã duyệt: [concept-result-style-02-ngay-vui.png](./screenshots/concept-result-style-02-ngay-vui.png). Concept thể hiện kết quả thường của bốn người trên backdrop bàn chơi đã giảm contrast, gồm đủ biến thể hạng nhất, người hiện tại, hàng trung tính, hạng cuối và cặp hành động “Rời bàn”/“Chơi tiếp”. Các trường hợp tới trắng, disconnect và forfeit tiếp tục theo state spec bên dưới/source React.

### 9.1 Backdrop/card

- backdrop navy 38%;
- result card cream, width `min(354px, calc(100% - 28px))`;
- border navy 2;
- radius 24;
- shadow overlay;
- padding 18–20 px;
- max-height `calc(100vh - safe areas - 32px)`;
- nội dung ranking scroll nếu cần.

### 9.2 Banner

- “KẾT QUẢ” `display.md` navy;
- underline coral 56 × 4 px;
- không ribbon 3D;
- instant win là sun/coral pill dưới title.

### 9.3 Ranking row

- min-height 58 px;
- border navy 1.5 px;
- radius 14;
- cream.50 fill;
- grid `32px 40px minmax(0,1fr) auto`;
- gap 8 px;
- place số 18 px weight 800;
- avatar 36 px;
- name ellipsis;
- badge kết quả live.

Variants:

- first: sun.300 tint 35%, left accent sun 5 px;
- me: aqua.100 tint 55%, outline navy 2 px;
- last: coral.300 tint 16%, badge coral;
- nếu vừa first vừa me, dùng fill sun và thêm dot teal “Bạn”, không chồng hai background.

### 9.4 Actions

- “Về sảnh” cream;
- “Chơi tiếp” sun;
- height 48;
- gap 10;
- sticky dưới card nếu rows scroll.

## 10. Responsive

### 10.1 Width 360–389

- gutter 16;
- logo 38–42 px;
- room row action 80 px;
- opponent name max 88 px;
- hand giảm card width/overlap tự động;
- không giảm touch target dưới 44.

### 10.2 Width 430–520

- content max 472 và center;
- topbar vẫn theo app width;
- room row có thể tăng padding 14;
- card hand không vượt 72 px;
- không kéo radius/border theo tỷ lệ.

### 10.3 Landscape

Game ưu tiên portrait. Nếu landscape được phép:

- table chuyển dùng safe area ngang;
- lobby/modal center với max-width;
- nếu chiều cao dưới 520, room list/table phải scroll hoặc dùng layout landscape riêng;
- không đơn giản scale toàn canvas xuống gây chữ/touch quá nhỏ.

## 11. Z-index

| Layer | z-index |
|---|---:|
| page/mat | 0 |
| normal content | 10 |
| hand/trick animation | 20 |
| sticky actions/topbar | 30 |
| toast | 50 |
| chat backdrop/panel | 60/61 |
| modal backdrop/card | 70/71 |
| result | 80/81 |

Không tạo z-index tùy ý ngoài scale nếu không cập nhật bảng này.

## 12. Screen QA bắt buộc

Mỗi release chụp các state:

- loading, reconnect error;
- lobby 0/1/4+ phòng;
- lobby queueing;
- create room default/error/loading;
- password room default/error;
- room 2/3/4 người, host và guest;
- ready/not-ready/start-disabled;
- table đầu lượt, đang chọn, có thể đánh, không thể đánh;
- pass, chop, finish, disconnect;
- chat empty/full/keyboard open;
- result normal/instant/disconnect/forfeit;
- 360×800, 390×844, 520×932;
- reduced motion và keyboard focus.
