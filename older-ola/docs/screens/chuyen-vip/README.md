# Màn hình Chuyển / Giao dịch VIP

- **Activity:** `chat.ola.vn.tradingvip.OlaTraddingVipActivity`
- **Layout container:** `apktool_out/res/layout/ola_tradding_vip_layout.xml`
- **3 fragment bước:** `ola_tradding_vip_step1_fragment_layout.xml` (chọn vỏ VIP) · `ola_tradding_vip_step2_fragment_layout.xml` (nhập nick + ngày + giá) · `ola_tradding_vip_step3_fragment_layout.xml` (xác nhận)
- **Bubble trong chat:** `chat_sent_tradding_vip_layout.xml` (đã gửi) · `chat_received_tradding_vip_layout.xml` (đã nhận — có nút Đồng ý/Không)
- **Dialog phụ:** `vip_icon_picker_layout.xml`, `tradding_vip_request_input_layout.xml`, `tradding_vip_input_confirm_layout.xml`
- **Chức năng:** "bán/tặng" một **vỏ (icon) VIP** mà mình đang sở hữu cho tài khoản khác theo **nick**, kèm **thời hạn (ngày)** và **giá (KEN)**. Luồng **3 bước** (chọn vỏ VIP → nhập người nhận/ngày/giá → xác nhận). Gửi xong sẽ chèn một bubble "giao dịch VIP" vào hội thoại; **người nhận bấm Đồng ý/Không** ngay trên bubble để chốt giao dịch (trả KEN đổi lấy vỏ VIP).

> Mở từ **chat 1-1** qua tab "+" (đính kèm) → nút **"Giao dịch VIP"**. Khác với "Chuyển KEN" (chỉ chuyển tiền KEN), đây là giao dịch **vỏ VIP ↔ KEN** hai chiều có bước người nhận chấp nhận.

## Ảnh chụp

> Chưa có ảnh chụp màn thật trong repo (`fake-api/screenshots`, `apk-images` không có). Mô tả dưới đây dựng từ layout + jadx.

### Assets dùng trong màn

| Asset | Nguồn | Dùng cho |
|-------|-------|----------|
| Icon vỏ VIP | **Tải động từ server** qua image-cache (`chat.ola.vn.j.a().a(vipId)`) — không phải drawable tĩnh trong APK | `vipIconImageView` (40dp) ở step 2/3 và trong bubble |
| `ic_contact_photo` | `res/drawable/` | Avatar mặc định người nhận (step 3) trước khi nạp ảnh thật (`OlaCachedImageView`) |
| `chat_incoming` / `chat_outgoing` | 9-patch (`.9.png`) | Nền bong bóng nhận/gửi bọc ngoài 2 layout bubble |
| `smiles_online` | `res/drawable/` | Icon mặc định trong dialog `tradding_vip_request_input_layout` |
| nền nút xanh | `btn_green_button_selector` (shape, `buttonGreen` `#9CCC65`) | Nút "Đồng ý"/xác nhận |

---

## 1. Bố cục (top → bottom)

**Container** (`ola_tradding_vip_layout`):
```
FrameLayout (match_parent)
├─ FrameLayout #traddingVipFragment   ← chỗ nạp fragment step 1/2/3 (replace), paddingTop 42dp (chừa action bar)
├─ <include ola_top_action_bar_layout>   ← action bar XANH
│   ├─ olaActionBarBackViewLayout        (mũi tên ← trắng)
│   ├─ olaActionBarTitleTextView         tiêu đề trắng 14sp bold — đổi theo bước
│   └─ olaActionBarMoreButtonImageView   nút × (ic_action_quit) → finish()
└─ FrameLayout #traddingVipProgressBar   ← overlay đen 38% (#61000000), clickable, ẨN mặc định (gone); spinner 48dp; tự ẩn sau 60s
```

**Bước 1 — Chọn vỏ VIP** (`ola_tradding_vip_step1_fragment_layout`):
```
ListView #vipIconListView (match_parent, nền trắng, style list.noDivider — dividerHeight 0)
└─ mỗi dòng = icon vỏ VIP (40dp) + tên vỏ VIP  ← adapter `ad`, data nạp từ server (lọc bỏ vỏ của chính mình)
```
> Tiêu đề action bar bước 1 = **"Chọn vỏ VIP để giao dịch"** (`string_select_vip_icon_for_tradding`).

**Bước 2 — Nhập thông tin** (`ola_tradding_vip_step2_fragment_layout`), ScrollView → LinearLayout vertical, nền trắng, padding 16dp:
```
├─ Hàng vỏ VIP đã chọn
│   ├─ #vipIconImageView   ImageView 40×40dp (icon vỏ VIP)
│   └─ #vipTitleTextView   TextView 12sp bold #4C4C4C, weight 1, marginLeft 8dp (tên vỏ VIP)
├─ divider 1px (#1F000000), marginTop 8dp
├─ TextView "Người nhận"        (subhead 16sp #DE000000), marginTop 16dp
├─ #receiverIdEditText  OlaQuickTypingSuggestedText  ← ô nick có gợi ý, hint "Nick Ola của người nhận", maxLines 1, imeNext
├─ TextView "Thời hạn VIP"      (subhead 16sp), marginTop 16dp
├─ #vipDurationEditText  EditText  ← numberDecimal, hint "Nhập số ngày VIP", imeNext
├─ TextView "Giá VIP"           (subhead 16sp), marginTop 16dp
├─ #kenEditText  EditText        ← numberDecimal, hint "Nhập giá KEN của VIP", imeDone
└─ Hàng 2 nút (marginTop 24dp):
    ├─ #editButton      Button "Chọn VIP khác" (weight 1, cao 36dp, nền xám) ← quay lại bước 1
    └─ #nextStepButton  Button "Đồng ý"        (weight 1, cao 36dp, nền xanh #9CCC65) ← tra người nhận → bước 3
```
> Tiêu đề bước 2 = **"Thông tin giao dịch"** (`string_transaction_info`).

**Bước 3 — Xác nhận** (`ola_tradding_vip_step3_fragment_layout`), ScrollView → LinearLayout vertical, nền trắng, padding 16dp:
```
├─ TextView "Người nhận"        (subhead 16sp #8A000000), marginTop 16dp
├─ RelativeLayout (cao 48dp), marginTop 8dp
│   ├─ #receiverProfileImageView  OlaCachedImageView 48×48dp (avatar, centerCrop, mặc định ic_contact_photo)
│   └─ cột chữ (toRightOf avatar, marginLeft 16dp):
│       ├─ #receiverNickTextView      (subhead 16sp, 1 dòng, ellipsize end) ← nick
│       └─ #receiverFullnameTextView  (caption 12sp #8A000000), marginTop 2dp ← họ tên
├─ TextView "VIP đã chọn"       (subhead 16sp #8A000000), marginTop 16dp
├─ Hàng vỏ VIP (marginTop 8dp): #vipIconImageView 40dp + #vipTitleTextView 12sp bold
├─ TextView "Thời hạn VIP"      (subhead 16sp #8A000000), marginTop 16dp
├─ #vipDurationTextView         (title 20sp bold #DE000000), marginTop 8dp ← số ngày
├─ TextView "Giá VIP"           (subhead 16sp #8A000000), marginTop 16dp
├─ #kenAmountTextView           (title 20sp bold #DE000000), marginTop 8dp ← số KEN
├─ divider 1px (#1F000000), marginTop 16dp
└─ Hàng 2 nút (marginTop 24dp):
    ├─ #editButton  Button "Chỉnh sửa" (weight 1, cao 36dp, nền xám) ← quay lại bước 2
    └─ #okButton    Button "Đồng ý"    (weight 1, cao 36dp, nền xanh) ← gửi giao dịch → finish()
```
> Tiêu đề bước 3 = **"Xác nhận"** (`string_confirm`).

**Bubble "đã gửi giao dịch VIP"** (`chat_sent_tradding_vip_layout`) — LinearLayout vertical, bọc trong bong bóng **gửi**, **chữ trắng**:
```
├─ Hàng: #vipIconImageView 40dp + #vipTitleTextView (12sp bold, #FFFFFF)   ← vỏ VIP
├─ "Thời hạn VIP" (subhead 16sp #B3FFFFFF), marginTop 16dp
├─ #vipDurationTextView (title 20sp bold #FFFFFF), marginTop 8dp
├─ "Giá VIP" (subhead 16sp #B3FFFFFF), marginTop 16dp
├─ #kenAmountTextView (title 20sp bold #FFFFFF), marginTop 8dp
├─ divider 1px (#1FFFFFFF), marginTop 8dp
├─ "Trạng thái" (subhead 16sp #B3FFFFFF), marginTop 16dp
└─ #statusTextView (body1 14sp #FFFFFF), marginTop 8dp   ← trạng thái giao dịch (đổi màu theo mã, xem 4.4)
```

**Bubble "đã nhận giao dịch VIP"** (`chat_received_tradding_vip_layout`) — như trên nhưng bọc trong bong bóng **nhận**, **chữ đen**, và **thêm hàng nút**:
```
… (giống bubble gửi, đổi #FFFFFF→#DE000000, #B3FFFFFF→#8A000000, divider #1FFFFFFF→#1F000000)
└─ #responsButtonViewLayout  LinearLayout ngang, marginTop 16dp   ← CHỈ có ở bubble NHẬN
    ├─ #noButton  Button "Không"   (96×36dp, nền xám), marginRight 4dp  ← từ chối
    └─ #okButton  Button "Đồng ý"  (96×36dp, nền xanh #9CCC65), marginLeft 4dp  ← chấp nhận
```

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú |
|------------|----|----|--------|--------------------------|---------|
| Action bar | — | nền xanh (`bg_action_bar`) | — | fragment chừa top 42dp | tiêu đề đổi theo bước |
| ↳ Tiêu đề | `olaActionBarTitleTextView` | `#FFFFFF` | 14sp bold | — | b1 "Chọn vỏ VIP để giao dịch" / b2 "Thông tin giao dịch" / b3 "Xác nhận" |
| ↳ Nút đóng | `olaActionBarMoreButtonImageView` | icon trắng | — | 48dp | src runtime `ic_action_quit` (×) → `finish()` |
| Overlay loading | `traddingVipProgressBar` | nền `#61000000` (đen 38%) | — | full, spinner 48dp | **ẩn mặc định**, hiện khi tải danh sách vỏ / tra nick / gửi; tự ẩn sau **60s** |
| **B1** ListView vỏ VIP | `vipIconListView` | nền `#FFFFFF` | — | full, không divider | style `defaultStyle.list.noDivider`; item = icon 40dp + tên |
| **B2** Icon vỏ VIP | `vipIconImageView` | — | — | 40×40dp | nạp bitmap từ server |
| **B2** Tên vỏ VIP | `vipTitleTextView` | `#4C4C4C` | 12sp bold | weight 1, marginLeft 8dp | style `?vip.text.item` |
| divider | — | `#1F000000` | — | 1px, marginTop 8dp | |
| Label "Người nhận" (b2) | — | `#DE000000` | 16sp | marginTop 16dp | `string_nick_receiver`, style `text.subhead` |
| Ô nick người nhận | `receiverIdEditText` | `#DE000000` | 16sp | full, 1 dòng | `OlaQuickTypingSuggestedText` (autocomplete), hint `general_hint_remind_receiver_nick`, bg `bg_edit_text_border`, padding 16dp |
| Label "Thời hạn VIP" | — | `#DE000000` | 16sp | marginTop 16dp | `string_vip_duration` |
| Ô số ngày | `vipDurationEditText` | `#DE000000` | 16sp | full | `numberDecimal`, hint `general_hint_vip_duration_in_day` |
| Label "Giá VIP" | — | `#DE000000` | 16sp | marginTop 16dp | `string_vip_price` |
| Ô giá KEN | `kenEditText` | `#DE000000` | 16sp | full | `numberDecimal`, hint `general_hint_vip_price_in_ken` |
| Nút "Chọn VIP khác" (b2) | `editButton` | style `button` (nền xám, chữ `#DE000000`) | 14sp | weight 1, cao 36dp, marginRight 4dp | `string_reselect_vip` → về bước 1 |
| **Nút "Đồng ý" (b2)** | `nextStepButton` | chữ `#FFFFFF`, nền `#9CCC65` (`buttonGreen`) | 14sp | weight 1, cao 36dp, marginLeft 4dp | style `button.green`, bg `btn_green_button_selector`; `string_ok` |
| **B3** Label "Người nhận" | — | `#8A000000` | 16sp | marginTop 16dp | `string_receiver` |
| Avatar người nhận | `receiverProfileImageView` | — | — | 48×48dp, centerCrop | `OlaCachedImageView`, src mặc định `ic_contact_photo` |
| Nick người nhận | `receiverNickTextView` | `#DE000000` | 16sp | 1 dòng, ellipsize end | từ profile `d.c` |
| Họ tên người nhận | `receiverFullnameTextView` | `#8A000000` | 12sp | marginTop 2dp, 1 dòng | từ profile |
| Vỏ VIP đã chọn (b3) | `vipIconImageView`/`vipTitleTextView` | icon + `#4C4C4C` 12sp bold | — | icon 40dp | `string_selected_vip` là label phía trên |
| Số ngày (b3) | `vipDurationTextView` | `#DE000000` | 20sp bold | marginTop 8dp | style `text.title` |
| Giá KEN (b3) | `kenAmountTextView` | `#DE000000` | 20sp bold | marginTop 8dp | style `text.title` |
| Nút "Chỉnh sửa" (b3) | `editButton` | style `button` (xám) | 14sp | weight 1, cao 36dp | `string_edit` → về bước 2 |
| **Nút "Đồng ý" (b3)** | `okButton` | chữ `#FFFFFF`, nền `#9CCC65` | 14sp | weight 1, cao 36dp | gửi giao dịch |
| **Bubble** nhãn phụ (gửi) | — | `#B3FFFFFF` | 16sp | — | "Thời hạn VIP"/"Giá VIP"/"Trạng thái" — chữ trắng mờ |
| **Bubble** nhãn phụ (nhận) | — | `#8A000000` | 16sp | — | như trên, chữ đen mờ |
| Bubble: số ngày / giá | `vipDurationTextView`/`kenAmountTextView` | gửi `#FFFFFF` · nhận `#DE000000` | 20sp bold | marginTop 8dp | |
| Bubble: trạng thái | `statusTextView` | **màu theo mã** (xem 4.4) | 14sp | marginTop 8dp | |
| Bubble nhận: nút "Không" | `noButton` | style `button` (xám) | 14sp | 96×36dp, marginRight 4dp | từ chối |
| Bubble nhận: nút "Đồng ý" | `okButton` | chữ `#FFFFFF`, nền `#9CCC65` | 14sp | 96×36dp, marginLeft 4dp | chấp nhận |

> Màu resolve từ `colors.xml`: `colorTextBlackPrimary` `#DE000000` (87% đen), `colorTextBlackSecondaryOrIcon` `#8A000000` (54%), `colorTextBlackDivider` `#1F000000` (12%), `colorTextWhitePrimary` `#FFFFFF`, `colorTextWhiteSecondary` `#B3FFFFFF` (70% trắng), `colorTextWhiteDivider` `#1FFFFFF` (12% trắng), `buttonGreen` `#9CCC65`, `colorOlaPrimary` `#7CB342`, `translucent_black_38_percent` `#61000000`. Cỡ chữ: `text.title`=20sp bold, `text.subhead`=16sp, `text.body1`=14sp, `text.caption`=12sp, `?vip.text.item`=12sp bold `#4C4C4C`.

## 3. CSS tương đương (dựng lại trên web)

```css
.vip-trade { background:#fff; padding:16px; font-family:Roboto,Arial,sans-serif; }

/* Hàng vỏ VIP */
.vip-trade__vip { display:flex; align-items:center; }
.vip-trade__vip img { width:40px; height:40px; }
.vip-trade__vip .name { flex:1; margin-left:8px; font-size:12px; font-weight:700; color:#4C4C4C; }

.vip-trade__divider { height:1px; background:rgba(0,0,0,.12); margin-top:8px; }
.vip-trade__label { color:#DE000000; font-size:16px; margin-top:16px; }
.vip-trade__input {
  width:100%; box-sizing:border-box; padding:16px; margin-top:4px;
  border:1px solid rgba(0,0,0,.12); border-radius:2px; font-size:16px; color:rgba(0,0,0,.87);
}
.vip-trade__actions { display:flex; gap:8px; margin-top:24px; }
.vip-trade__actions button { flex:1; height:36px; border-radius:2px; font-size:14px; }
.vip-trade__edit { background:#eee; color:rgba(0,0,0,.87); border:1px solid #ccc; }
.vip-trade__ok { background:#9CCC65; color:#fff; border:none; }

/* Bubble giao dịch VIP (bản NHẬN — chữ đen) */
.vip-bubble { display:inline-flex; flex-direction:column; }
.vip-bubble .sub { font-size:16px; color:rgba(0,0,0,.54); margin-top:16px; }
.vip-bubble .val { font-size:20px; font-weight:700; color:rgba(0,0,0,.87); margin-top:8px; }
.vip-bubble .divider { height:1px; background:rgba(0,0,0,.12); margin-top:8px; }
.vip-bubble .status { font-size:14px; margin-top:8px; }         /* màu theo trạng thái */
.vip-bubble .status--waiting  { color:#F9A825; }                 /* chờ (vàng) */
.vip-bubble .status--denied   { color:#E53935; }                 /* từ chối/lỗi (đỏ) */
.vip-bubble .status--done     { color:#7CB342; }                 /* hoàn tất (xanh) */
.vip-bubble .actions { display:flex; gap:8px; margin-top:16px; }
.vip-bubble .actions button { width:96px; height:36px; border-radius:2px; font-size:14px; }

/* Bản GỬI — chữ trắng: đổi rgba(0,0,0,*) thành rgba(255,255,255,*) tương ứng */
```

```html
<!-- Bước 2 -->
<div class="vip-trade">
  <div class="vip-trade__vip"><img src="vip-icon.png"><span class="name">Vỏ VIP Vàng</span></div>
  <div class="vip-trade__divider"></div>
  <div class="vip-trade__label">Người nhận</div>
  <input class="vip-trade__input" placeholder="Nick Ola của người nhận">
  <div class="vip-trade__label">Thời hạn VIP</div>
  <input class="vip-trade__input" inputmode="decimal" placeholder="Nhập số ngày VIP">
  <div class="vip-trade__label">Giá VIP</div>
  <input class="vip-trade__input" inputmode="decimal" placeholder="Nhập giá KEN của VIP">
  <div class="vip-trade__actions">
    <button class="vip-trade__edit">Chọn VIP khác</button>
    <button class="vip-trade__ok">Đồng ý</button>
  </div>
</div>
```

## 4. Hành vi & luồng

### 4.1. Mở màn & điều hướng 3 bước
- **Điểm mở:** trong chat 1-1, tab "+" (`ola_attachment_more_tab_layout`) có nút `tradingVipButton` text **"Giao dịch VIP"** (`string_tradding_vip`). Bấm → `chat.ola.vn.view.f.onClick()` gọi listener `P()` → `OlaChatViewActivity.P()` → `OlaTraddingVipActivity.a(context, buddyId)` (buddyId = id người đang chat, từ `this.C.j()`).
- `onCreate`: `setContentView(ola_tradding_vip_layout)` → nạp action bar (back + × `ic_action_quit`). Nếu static field `OlaTraddingVipActivity.e == null` → nạp fragment **bước 1** (`b`, chọn vỏ VIP); nếu đã có vỏ chọn sẵn → vào thẳng **bước 2** (`c`).
- **Cơ chế bước:** mỗi fragment kế thừa base `a` có `c()` = fragment kế, `d()` = fragment trước. Activity `B()` = tiến (animate vào-từ-phải), `C()` = lùi (vào-từ-trái). **Back**: nếu `C()` trả null (đang bước 1) → thoát màn.

### 4.2. Bước 1 — chọn vỏ VIP (`b`)
- ListView `vipIconListView` đổ danh sách **vỏ VIP** nạp từ server (socket request `OlaApplication.b.j(...)`, type 22); **lọc bỏ vỏ VIP của chính mình**. Lưu vị trí cuộn qua static.
- **onItemClick** → set `OlaTraddingVipActivity.e = vỏ VIP được chọn` → `B()` sang bước 2.

### 4.3. Bước 2 — nhập & tra người nhận (`c`)
- Hiển thị icon + tên vỏ VIP đã chọn (từ `OlaTraddingVipActivity.e`).
- **Ô nick** dùng `OlaQuickTypingSuggestedText` (autocomplete từ danh bạ). Ô **số ngày** (`vipDurationEditText`) và **giá KEN** (`kenEditText`) nhập số.
- **Nút "Chọn VIP khác"** (`editButton`) → `C()` về bước 1.
- **Nút "Đồng ý"** (`nextStepButton`) → `x()`:
  1. `y()`: nếu **nick trống** → **rung** ô nick (`R.anim.shake`), dừng.
  2. Parse `giá KEN` (long, bỏ dấu phẩy) và `số ngày` (int) → lưu static `d.a = giá`, `d.b = số ngày`.
  3. Gọi REST **tra profile người nhận**: `GET /id/profile?un={nick}` (class `network.a.a.w`):
     - Lỗi / không tồn tại → dialog `dialog_title_fail` + `string_buddy_is_not_exist` ("Tài khoản không tồn tại!"). Mã 38 = không đủ quyền xem.
     - OK → `d.c = profile` → `B()` sang bước 3.
- **Giới hạn giá trị:** app có sẵn chuỗi tối thiểu/tối đa — `message_tradding_min_ken_value_format` (KEN tối thiểu), `message_max_vip_price_tradding_format` (KEN tối đa), `message_max_vip_day_tradding_format` (ngày tối đa). *(Bản decompile của `y()` chỉ thấy chặn nick trống; các mức min/max nhiều khả năng do server/nhánh khác kiểm — độ tin: trung bình.)*

### 4.4. Bước 3 — xác nhận & gửi (`d`)
- `onResume` đổ dữ liệu: nick + họ tên + avatar (từ `d.c`), vỏ VIP (từ `OlaTraddingVipActivity.e`), số ngày (`d.b`), giá KEN (`d.a`).
- **Nút "Chỉnh sửa"** (`editButton`) hoặc Back → `C()` về bước 2 (giữ dữ liệu).
- **Nút "Đồng ý"** (`okButton`) → `x()`:
  - Gửi **socket packet type 166** (qua `OlaNetworkService.a(receiver, vipId, days, priceKen, (short)74)`): `p`=id người nhận, `A`=id vỏ VIP, `Q`=thời hạn ms (`days*24*60*60*1000`), `U`=giá KEN, `aj`=74 (mã lệnh).
  - Chèn **1 bubble "đã gửi giao dịch VIP"** (message type **16**) vào hội thoại với người nhận (`message.e.a(...)`, mark type = 2), timestamp = now.
  - Bật overlay (tự ẩn sau 60s) rồi `finish()` thoát màn.

### 4.5. Bubble giao dịch trong hội thoại & trạng thái
- **View type** (adapter `b.o.getItemViewType` = `type + direction*19`): message **type 16** = *đã gửi* (adapter `entry.b.af`, layout `chat_sent_tradding_vip_layout`, chữ trắng); **type 17** = *đã nhận* (adapter `entry.b.ae`, layout `chat_received_tradding_vip_layout`, chữ đen + nút). Cả hai được bọc trong `incoming_chat_message_layout`/bubble và **ẩn ô text tin nhắn** thường.
- **Nội dung bubble:** icon + tên vỏ VIP · "Thời hạn VIP" + số ngày (dùng `string_day`/`string_days` = "Ngày") · "Giá VIP" + số KEN · "Trạng thái" + `statusTextView`.
- **Trạng thái (`statusTextView`)** theo mã (`E()`), **đổi màu động** (định nghĩa trong `chat.ola.vn.f`, không nằm trong `colors.xml`):

  | Mã | Ý nghĩa | Text (EN → VI) | Màu (tham chiếu) |
  |----|---------|----------------|------------------|
  | 0 | Thất bại/lỗi | `message_fail` "Error" → **"Lỗi"** (kèm lý do nếu có) | `f.k` (đỏ) |
  | 1 | Chờ trả lời | `message_watting_answer` "Waiting answer" → **"Đang chờ trả lời"** | `f.C`/`f.y` (vàng/cam) |
  | 2 | Bị từ chối | `string_denied` "Denied" → **"Bị từ chối"** | `f.D`/`f.z` |
  | 3 | Hoàn tất | `string_transaction_finished` "Transaction done!" → **"Giao dịch hoàn tất"** | `f.L` (xanh) |
  | — | Quá hạn | `message_transaction_timeout` → **"Giao dịch hết hiệu lực"** | (như thất bại) |

- **Nút Đồng ý/Không (chỉ bubble NHẬN, `responsButtonViewLayout`):**
  - **Chỉ hiện khi trạng thái = 1 (chờ).** Trạng thái 0/2/3 → ẩn nút. **Quá thời hạn**: nếu `now − thời điểm nhận ≥ 300000ms (5 phút)` mà vẫn "chờ" → **ẩn nút**, chuyển trạng thái = 0, hiện "Giao dịch hết hiệu lực".
  - **"Không"** (`noButton`) → đặt trạng thái = 2 (từ chối), làm mới bubble, báo server (`message_vip_tradding_deny` / `..._format` "%1$s từ chối giao dịch VIP").
  - **"Đồng ý"** (`okButton`) → nếu **giá KEN > 0** thì mở **dialog nhập lại giá** để xác nhận (`message_retype_the_price` / `message_tradding_confirm_content_format` "Bạn hãy nhập lại đúng số KEN %1$s…"); nhập sai → `message_please_enter_correct_the_vip_price` ("Vui lòng nhập chính xác giá của VIP"). Đúng (hoặc giá = 0) → đặt trạng thái = 3 (hoàn tất), báo server (`message_vip_tradding_accept` / `..._format` "%1$s chấp nhận giao dịch VIP").

### 4.6. Modal/Dialog trong màn
- **Dialog lỗi tra nick** — nội dung `string_buddy_is_not_exist`, 1 nút đóng (bước 2).
- **Dialog xác nhận giá khi chấp nhận** (`tradding_vip_input_confirm_layout`): header icon 48dp + tiêu đề `message_tradding_confirm` ("Xác nhận giao dịch"); nội dung `message_tradding_confirm_content_format` ("nhập lại đúng số KEN %1$s…") + ô `txtInputContent` (numberSigned); nút `btnConfirm` "Xác nhận" (xanh) + `btnCancel` "Huỷ". → dùng khi **người nhận bấm Đồng ý** trên bubble.
- **Dialog chọn vỏ VIP** (`vip_icon_picker_layout`): tiêu đề `string_select_vip` ("Chọn VIP"); `lvVipList` + `progressBar` + `txtEmptyLable` (`message_empty_vip` "Không có VIP", `invisible` mặc định); nút `btnCancel` "Đóng" + `btnBuyNewVip` "Đăng ký VIP" (xanh). → biến thể **dialog** của bước chọn vỏ (dùng ở nhánh giao dịch nhanh).
- **Dialog giao dịch nhanh** (`tradding_vip_request_input_layout`): tiêu đề `string_tradding_vip`; icon `imgVipThumbnail` + tên; ô nick `txtVipReceiver` (autocomplete); ô ngày `txtVipDay` (+ "Ngày"); ô giá `txtVipPrice` (+ "x 1,000 KEN"); nút `btnAccept` "Giao dịch KEN, VIP" (xanh) + `btnCancel` "Huỷ". → nhánh **một-dialog** thay cho wizard 3 bước (vd mở từ trang cá nhân/kho VIP).
> Màn **không mở Activity mới** trong luồng chính; mọi phản hồi đều qua dialog/bubble rồi tự đóng.

### 4.7. Đối chiếu bản web (`web/`)
- Web đã có nút **"Giao dịch VIP"** trong `AttachmentBar` (panel More của chat 1-1): `key: 'trading-vip'`, `onClick → onSend({ kind: 'vip', vipDirection: 'sent' })` — cùng có mục **"Tặng ngày VIP"** (`send-vip-days`).
- Web định nghĩa sẵn **message kind `vip`** với `vipDirection: 'sent' | 'received'` (mô phỏng bubble gửi/nhận), nhưng hiện `onClick` chỉ gửi **mẫu tĩnh** — **chưa dựng wizard 3 bước** (chọn vỏ VIP → nhập ngày/giá → xác nhận), **chưa có luồng người nhận Đồng ý/Không**, **chưa có trạng thái giao dịch** (chờ/từ chối/hoàn tất/quá hạn 5 phút) và **chưa có API/socket** đổi vỏ VIP ↔ KEN như bản gốc.

## 5. Strings (đa ngôn ngữ)

| Resource | EN | VI |
|----------|----|----|
| `string_tradding_vip` | Trading VIP icon | Giao dịch VIP |
| `string_select_vip_icon_for_tradding` | Select VIP icon for tradding | Chọn vỏ VIP để giao dịch |
| `string_transaction_info` | Transaction info | Thông tin giao dịch |
| `string_confirm` | Confirmation | Xác nhận |
| `string_nick_receiver` | Receiver account | Người nhận |
| `string_receiver` | Receiver | Người nhận |
| `general_hint_remind_receiver_nick` | Receiver nick name | Nick Ola của người nhận |
| `string_vip_duration` | VIP duration | Thời hạn VIP |
| `general_hint_vip_duration_in_day` | Enter VIP duration in day | Nhập số ngày VIP |
| `string_vip_price` | VIP Price | Giá VIP |
| `general_hint_vip_price_in_ken` | Enter VIP price in KEN | Nhập giá KEN của VIP |
| `string_selected_vip` | Selected VIP | VIP đã chọn |
| `string_reselect_vip` | Re-select VIP | Chọn VIP khác |
| `string_ok` | OK | Đồng ý |
| `string_edit` | Edit | Chỉnh sửa |
| `string_no` | No | Không |
| `string_status` | Status | Trạng thái |
| `string_day` / `string_days` | Day / Days | Ngày / Ngày |
| `string_select_vip` | Select VIP | Chọn VIP |
| `string_buy_vip` | Buy VIP | Đăng ký VIP |
| `string_close` | Close | Đóng |
| `string_cancel` | Cancel | Huỷ |
| `string_tradding` | KEN, VIP transaction | Giao dịch KEN, VIP |
| `message_empty_vip` | No VIP | Không có VIP |
| `message_tradding_confirm` | Confirm transaction | Xác nhận giao dịch |
| `message_tradding_confirm_content_format` | Re-type exactly KEN amount %1$s to confirm VIP transaction | Bạn hãy nhập lại đúng số KEN %1$s để xác nhận giao dịch VIP |
| `message_retype_the_price` | Re-type the price | Nhập lại giá |
| `message_please_enter_correct_the_vip_price` | Please enter the VIP price correctly | Vui lòng nhập chính xác giá của VIP |
| `string_buddy_is_not_exist` | Account is not exist! | Tài khoản không tồn tại! |
| `message_tradding_min_ken_value_format` | Minimum transaction is %1$s KEN | Giá trị giao dịch tối thiểu là %1$s KEN |
| `message_max_vip_price_tradding_format` | Maximum KEN transferring is %1$s | Số lượng KEN trong giao dịch phải nhỏ hơn %1$s |
| `message_max_vip_day_tradding_format` | Maximum VIP days for transferring is %1$s | Số ngày VIP trong giao dịch phải nhỏ hơn %1$s |
| `message_watting_answer` | Waiting answer | Đang chờ trả lời |
| `string_denied` | Denied | Bị từ chối |
| `string_transaction_finished` | Transaction done! | Giao dịch hoàn tất |
| `message_transaction_timeout` | Transaction timeout | Giao dịch hết hiệu lực |
| `message_fail` | Error | Lỗi |
| `message_vip_tradding_accept` / `_format` | VIP transaction is accepted / %1$s accepts VIP transaction | Giao dịch VIP đã được chấp nhận / %1$s chấp nhận giao dịch VIP |
| `message_vip_tradding_deny` / `_format` | VIP transaction is denied / %1$s denies VIP transaction | Giao dịch VIP bị từ chối / %1$s từ chối giao dịch VIP |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| Chat 1-1 → tab "+" → "Giao dịch VIP" | `tradingvip.OlaTraddingVipActivity` (chính màn này) | — |
| Dialog chọn vỏ → "Đăng ký VIP" | `OlaVipStoreActivity` / `BuyVipActivity` (mua/đăng ký VIP) | [kho-vip/](../kho-vip/README.md) |
| Nút × / back / gửi xong | đóng màn, quay lại hội thoại | — |

> Luồng chính xử lý trong 3 fragment + dialog của chính nó; chỉ điều hướng ra ngoài khi bấm "Đăng ký VIP" (sang Kho VIP / mua VIP).
