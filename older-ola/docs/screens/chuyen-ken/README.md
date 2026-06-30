# Màn hình Chuyển KEN

- **Activity:** `chat.ola.vn.transferken.OlaTransferKenActivity`
- **Layout container:** `apktool_out/res/layout/ola_transfer_ken_layout.xml`
- **2 fragment bước:** `ola_transfer_ken_step1_fragment_layout.xml` (nhập) · `ola_transfer_ken_step2_fragment_layout.xml` (xác nhận)
- **Bubble trong chat:** `chat_ken_transferred_layout.xml`
- **Chức năng:** chuyển KEN cho một tài khoản khác theo **nick**, qua luồng **2 bước** (nhập → xác nhận có mật khẩu), có validate min/max; chuyển thành công sẽ chèn một dòng tin "đã chuyển KEN" vào hội thoại với người nhận.

## Ảnh chụp

> Chưa có ảnh chụp màn thật trong repo (`fake-api/screenshots`, `apk-images` không có). Mô tả dưới đây dựng từ layout + jadx.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_ken_white` | ![ken](images/ic_ken_white.png) | Icon đồng KEN (trắng) trong bubble "đã chuyển KEN" |
| `bg_primary_color_circle` | (shape XML — hình tròn đặc màu `#7CB342`) | Nền tròn xanh bọc icon KEN trong bubble |
| `ic_action_quit` | (dấu ×) | Nút đóng ở góc phải action bar |
| `ic_contact_photo` | (avatar mặc định) | `src` tĩnh của avatar người nhận ở bước 2 (thực tế nạp ảnh thật qua `OlaCachedImageView`) |

---

## 1. Bố cục (top → bottom)

**Container** (`ola_transfer_ken_layout`):
```
FrameLayout (match_parent)
├─ ScrollView (#scrollView, paddingTop 42dp = chừa action bar, fillViewport)
│   └─ FrameLayout #transferKenFragment   ← chỗ nạp fragment bước 1 / bước 2 (replace)
├─ <include ola_top_action_bar_layout>    ← thanh action bar XANH (bg_action_bar), padding ngang 8dp / dưới 6dp
│   ├─ olaActionBarBackViewLayout         ImageView ic_action_back (mũi tên ← trắng, centerInside)
│   ├─ olaActionBarTitleTextView          tiêu đề: chữ TRẮNG 14sp bold (style text.button), đổi theo bước
│   └─ olaActionBarMoreButtonImageView    48dp, src set runtime = ic_action_quit (× đóng); các nút phải khác GONE
└─ FrameLayout #transferKenProgressBar    ← overlay nền đen 38%, clickable, ẨN mặc định (visibility=gone)
    └─ ProgressBar 48×48dp (giữa)
```

**Bước 1 — Nhập** (`ola_transfer_ken_step1_fragment_layout`), LinearLayout vertical, nền trắng, padding 16dp:
```
├─ Hàng "Số dư"   LinearLayout ngang, gravity=center
│   ├─ TextView "Đang có"           (title 20sp bold, #8A000000)
│   └─ TextView #txtKenAvaliable    (title 20sp bold) ← "{số dư} KEN", marginLeft 8dp
├─ divider 1px (#1F000000), marginTop 8dp
├─ TextView "Người nhận"            (subhead 16sp), marginTop 16dp
├─ #txtKenReceiver  OlaQuickTypingSuggestedText  ← ô nick có gợi ý, hint "Nick Ola của người nhận", maxLines 1, imeNext
├─ TextView "Lượng KEN cần chuyển"  (subhead 16sp), marginTop 16dp
├─ #txtKenValue  EditText           ← số (numberDecimal), hint "Nhập số KEN cần chuyển", imeNext
└─ #nextStepButton  Button "OK"     ← FULL WIDTH (match_parent), cao 36dp, nền xanh #9CCC65 chữ trắng, marginTop 24dp
```

**Bước 2 — Xác nhận** (`ola_transfer_ken_step2_fragment_layout`), LinearLayout vertical, nền trắng, padding 16dp:
```
├─ TextView "Người nhận"            (subhead 16sp, #8A000000), marginTop 16dp
├─ RelativeLayout (cao 48dp), marginTop 8dp
│   ├─ #receiverProfileImageView  OlaCachedImageView 48×48dp (avatar người nhận, centerCrop)
│   └─ cột chữ (toRightOf avatar, marginLeft 16dp):
│       ├─ #receiverNickTextView      (subhead 16sp, 1 dòng, ellipsize end) ← nick
│       └─ #receiverFullnameTextView  (caption 12sp, #8A000000), marginTop 2dp ← họ tên (ẨN nếu rỗng)
├─ TextView "Số KEN cần chuyển"     (subhead 16sp, #8A000000), marginTop 16dp
├─ #kenAmountTextView               (title 20sp bold) ← số KEN, marginTop 8dp
├─ divider 1px (#1F000000), marginTop 16dp
├─ #txtTransferPasswordViewLayout  LinearLayout vertical, marginTop 16dp   ← khối MẬT KHẨU (ẩn/hiện CÓ ĐIỀU KIỆN, xem 4.3)
│   ├─ TextView "Mật khẩu"           (subhead 16sp)
│   └─ #transferKenPasswordEditText  EditText textPassword, hint "Nhập mật khẩu", maxLines 1, imeNext
└─ Hàng 2 nút (marginTop 24dp):
    ├─ #editButton     Button "Chỉnh sửa" (weight 1, cao 36dp, nền xám mặc định) ← quay lại bước 1
    └─ #transferButton Button "OK"        (weight 1, cao 36dp, nền xanh #9CCC65) ← xác nhận chuyển
```

**Bubble "đã chuyển KEN" trong hội thoại** (`chat_ken_transferred_layout`), LinearLayout ngang:
```
├─ ImageView 16×16dp  nền tròn xanh (bg_primary_color_circle #7CB342), padding 1dp, icon ic_ken_white (centerInside)
└─ #kenAmountTextView  TextView 32sp (headline #DE000000), marginLeft 4dp ← số KEN đã chuyển
```

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú |
|------------|----|----|--------|--------------------------|---------|
| Action bar | `olaTopActionBarViewLayout` | nền xanh (`bg_action_bar`) | — | padding ngang 8dp, dưới 6dp; ScrollView chừa top 42dp | style `actionBar.background` |
| ↳ Nút back | `olaActionBarBackImageView` | icon trắng | — | wrap, cao full bar | `ic_action_back` (←) |
| ↳ Tiêu đề | `olaActionBarTitleTextView` | chữ `#FFFFFF` | 14sp **bold** | weight 1, marginLeft 8dp | style `text.button`; đổi theo bước (b1 "Nhập thông tin giao dịch KEN" / b2 "Xác nhận") |
| ↳ Nút đóng | `olaActionBarMoreButtonImageView` | icon trắng | — | 48dp, padding 8dp | src runtime = `ic_action_quit` (×) → `finish()` |
| Nền 2 bước | (LinearLayout) | nền `#FFFFFF` (`white`) | — | padding 16dp | |
| Overlay loading | `transferKenProgressBar` | nền `#61000000` (đen 38%) | — | full màn, spinner 48dp | **ẩn mặc định**, hiện khi tra nick / đang chuyển; tự ẩn sau **60s** |
| "Đang có" | `textView1` | `#8A000000` (`…SecondaryOrIcon`) | 20sp bold | gravity center | `string_ballance` (style `text.title`) |
| Số dư | `txtKenAvaliable` | `#DE000000` (`…BlackPrimary`) | 20sp bold | marginLeft 8dp | text = `"{m.a(h.o)} KEN"` |
| Label "Người nhận" (b1) | — | `#DE000000` | 16sp | marginTop 16dp | `string_nick_receiver` (style `text.subhead`) |
| Ô nick người nhận | `txtKenReceiver` | chữ `#DE000000` | 16sp | full, 1 dòng | `OlaQuickTypingSuggestedText` (autocomplete), hint `general_hint_remind_receiver_nick`, bg `bg_edit_text_border`, padding 16dp |
| Label "Lượng KEN" | — | `#DE000000` | 16sp | marginTop 16dp | `string_number_ken` |
| Ô số KEN | `txtKenValue` | chữ `#DE000000` | 16sp | full | `inputType=numberDecimal`, hint `general_hint_ken_transfer_amount`; tự format dấu phẩy khi mất focus |
| **Nút OK (b1)** | `nextStepButton` | chữ `#FFFFFF`, nền `#9CCC65` (`buttonGreen`) | 14sp | cao 36dp, marginTop 24dp | style `button.green`, minWidth 64dp, bg `btn_green_button_selector` |
| Label "Người nhận" (b2) | — | `#8A000000` | 16sp | marginTop 16dp | `string_receiver` |
| Avatar người nhận | `receiverProfileImageView` | — | — | 48×48dp, centerCrop | `OlaCachedImageView`, src mặc định `ic_contact_photo` |
| Nick người nhận | `receiverNickTextView` | `#DE000000` | 16sp | 1 dòng, ellipsize end | đổ từ `c.c` (entity người nhận) |
| Họ tên người nhận | `receiverFullnameTextView` | `#8A000000` | 12sp | marginTop 2dp, 1 dòng | **ẩn (`GONE`) nếu họ tên rỗng** (`c.c.k`) |
| Label "Số KEN cần chuyển" | — | `#8A000000` | 16sp | marginTop 16dp | `string_transferred_ken_amount` |
| Số KEN xác nhận | `kenAmountTextView` | `#DE000000` | 20sp bold | marginTop 8dp | style `text.title` |
| divider | — | `#1F000000` (`…Divider`) | — | cao 1px, marginTop 16dp | |
| Khối mật khẩu | `txtTransferPasswordViewLayout` | — | — | marginTop 16dp | **ẩn/hiện theo điều kiện** (account FB / cửa sổ 3 giờ — xem 4.3) |
| Label "Mật khẩu" | — | `#DE000000` | 16sp | — | `string_password` |
| **Ô mật khẩu chuyển** | `transferKenPasswordEditText` | chữ `#DE000000` | 16sp | full, 1 dòng | `inputType=textPassword`, hint `general_hint_ken_transfer_password` — **PIN giao dịch** gửi kèm khi chuyển; bị xoá trắng khi khối ẩn |
| Nút "Chỉnh sửa" | `editButton` | style `button` (nền xám mặc định, chữ `#DE000000`) | 14sp | weight 1, cao 36dp, marginRight 4dp | quay lại bước 1 |
| **Nút OK (b2)** | `transferButton` | chữ `#FFFFFF`, nền `#9CCC65` | 14sp | weight 1, cao 36dp, marginLeft 4dp | xác nhận chuyển |
| Bubble: nền tròn KEN | — | nền `#7CB342` (`bg_primary_color_circle`) | — | 16×16dp, padding 1dp | icon `ic_ken_white` centerInside |
| Bubble: số KEN | `kenAmountTextView` | `#DE000000` | **32sp** | marginLeft 4dp | style `text.headline`, `text.size.32sp` |

> Giá trị màu/cỡ chữ resolve từ `colors.xml` / `dimens.xml` / `styles.xml`: `text.title`=20sp bold, `text.subhead`=16sp, `text.caption`=12sp, `text.headline`=24sp, `edittext`=16sp; `colorTextBlackPrimary`=`#DE000000` (87% đen), `colorTextBlackSecondaryOrIcon`=`#8A000000` (54%), `colorTextBlackDivider`=`#1F000000` (12%).

## 3. CSS tương đương (dựng lại trên web)

```css
.ken-transfer { background:#fff; padding:16px; font-family:Roboto,Arial,sans-serif; }

/* Bước 1 */
.ken-transfer__balance { display:flex; align-items:center; justify-content:center; gap:8px; }
.ken-transfer__balance .label { color:#8A000000; font-size:20px; font-weight:700; }
.ken-transfer__balance .value { color:#DE000000; font-size:20px; font-weight:700; }
.ken-transfer__divider { height:1px; background:rgba(0,0,0,.12); margin-top:8px; }
.ken-transfer__label { color:#DE000000; font-size:16px; margin-top:16px; }
.ken-transfer__input {
  width:100%; box-sizing:border-box; padding:16px; margin-top:4px;
  border:1px solid rgba(0,0,0,.12); border-radius:2px;
  font-size:16px; color:rgba(0,0,0,.87); background:#fff;
}
.ken-transfer__btn-green {
  height:36px; min-width:64px; margin-top:24px;
  background:#9CCC65; color:#fff; font-size:14px; border:none; border-radius:2px; cursor:pointer;
}

/* Bước 2 — xác nhận */
.ken-confirm__receiver { display:flex; align-items:center; gap:16px; height:48px; margin-top:8px; }
.ken-confirm__avatar { width:48px; height:48px; object-fit:cover; }  /* XML không bo góc; OlaCachedImageView có thể tự bo */
.ken-confirm__nick { font-size:16px; color:rgba(0,0,0,.87); }
.ken-confirm__fullname { font-size:12px; color:rgba(0,0,0,.54); margin-top:2px; }  /* ẩn nếu rỗng */
.ken-confirm__amount { font-size:20px; font-weight:700; color:rgba(0,0,0,.87); margin-top:8px; }
.ken-confirm__actions { display:flex; gap:8px; margin-top:24px; }
.ken-confirm__actions button { flex:1; height:36px; border-radius:2px; font-size:14px; }
.ken-confirm__edit { background:#eee; color:rgba(0,0,0,.87); border:1px solid #ccc; }
.ken-confirm__ok { background:#9CCC65; color:#fff; border:none; }

/* Bubble trong chat */
.ken-bubble { display:inline-flex; align-items:flex-start; }
.ken-bubble__coin { width:16px; height:16px; padding:1px; border-radius:50%; background:#7CB342; box-sizing:border-box; }
.ken-bubble__amount { margin-left:4px; font-size:32px; color:rgba(0,0,0,.87); }
```

```html
<!-- Bước 1 -->
<div class="ken-transfer">
  <div class="ken-transfer__balance"><span class="label">Đang có</span><span class="value">1,234,000 KEN</span></div>
  <div class="ken-transfer__divider"></div>
  <div class="ken-transfer__label">Người nhận</div>
  <input class="ken-transfer__input" placeholder="Nick Ola của người nhận">
  <div class="ken-transfer__label">Lượng KEN cần chuyển</div>
  <input class="ken-transfer__input" inputmode="decimal" placeholder="Nhập số KEN cần chuyển">
  <button class="ken-transfer__btn-green">OK</button>
</div>
```

## 4. Hành vi & luồng

### 4.1. Mở màn & điều hướng 2 bước
- **Mở màn:** `OlaTransferKenActivity.a(ctx)` (chuyển tự do) hoặc `a(ctx, buddyId)` — truyền extra `_buddy_id`; khi có buddy thì bước 1 **điền sẵn nick + khoá ô nick + focus thẳng ô số KEN** (mở từ hội thoại với người đó). Hiệu ứng trượt trái khi vào.
- `onCreate`: `setContentView(ola_transfer_ken_layout)` → nạp action bar (nút back + nút × `ic_action_quit`) → add fragment **bước 1** (`b`) vào `#transferKenFragment`. Tiêu đề action bar = tiêu đề fragment hiện tại.
- **Cơ chế bước:** mỗi fragment kế thừa base `a` với `c()`=fragment kế, `d()`=fragment trước (lưu qua `a(prev)`). Activity `B()` = tiến (bước1→bước2, animate vào-từ-phải), `C()` = lùi (bước2→bước1, vào-từ-trái). **Back** (`onBackPressed`): nếu `C()` trả null (đang ở bước 1) → thoát màn.
- **Tiêu đề đổi theo bước:** bước 1 = `string_enter_ken_transaction_info` ("Nhập thông tin giao dịch KEN"); bước 2 = `string_confirm` ("Xác nhận").

### 4.2. Bước 1 — nhập & validate (`v()`)
- **Số dư:** hiển thị `"{h.o} KEN"` (h.o = số dư hiện tại), làm mới qua `OlaApplication.b.r()`.
- **Ô nick** dùng `OlaQuickTypingSuggestedText` + adapter gợi ý từ danh bạ bạn bè (`g.a()`); chọn gợi ý → điền nick.
- **Ô số KEN:** khi mất focus tự format dấu phẩy (`m.a(...)`), khi focus thì bỏ phẩy.
- **Validate khi bấm "OK"** (theo thứ tự — vi phạm thì dừng):
  1. Ô số KEN trống → `false` (không làm gì).
  2. Nick = **chính mình** (`m.b(nick, h.a())`) → toast `message_cannot_transfer_ken_to_you`.
  3. Số KEN rỗng sau khi bỏ phẩy → **rung** ô số (`R.anim.shake`).
  4. Số KEN **< 1000** → toast `message_tradding_min_ken_value_format` (tối thiểu 1.000).
  5. Số KEN **> 100.000.000** → toast `message_max_vip_price_tradding_format` (tối đa 100 triệu).
  6. Nick trống → **rung** ô nick.
- **Hợp lệ** → lưu `c.b = số KEN`; bật overlay; gọi `OlaApplication.b.a(nick, cb)` **tra cứu người nhận**:
  - Lỗi → dialog tiêu đề `dialog_title_fail`, nội dung `string_buddy_is_not_exist` ("Tài khoản không tồn tại!").
  - OK → `c.c = entity người nhận`, tắt overlay, `B()` sang bước 2.

### 4.3. Bước 2 — xác nhận & chuyển
- `onResume` → `v()` đổ dữ liệu: số KEN (`c.b`), nick (`c.c.c`), họ tên (lấy từ cache danh bạ hoặc `c.c.k`, **ẩn `GONE` nếu rỗng**), avatar (`OlaCachedImageView` theo `c.c.c`).
- **Khối mật khẩu (PIN) ẩn/hiện CÓ ĐIỀU KIỆN** (xác định trong `v()`):
  - `h.b()` = mật khẩu tài khoản đã lưu; `h.a(x)` = `!x.startsWith("fb:")`.
  - Tài khoản **đăng nhập Facebook** (mật khẩu dạng `fb:…`) → **ẩn** ô PIN (xoá trắng) — chuyển không cần PIN.
  - Tài khoản **mật khẩu thường**: so `now − c.a` với hằng `0xA4CB80` = **10.800.000ms (3 giờ)** (`c.a` = mốc giao dịch thành công gần nhất, khởi tạo `0`):
    - **≥ 3 giờ** (hoặc lần đầu khi `c.a = 0`) → **hiện** ô PIN + auto-focus, bắt nhập lại.
    - **< 3 giờ** → **ẩn** ô PIN (nhớ phiên, không hỏi lại).
- **"Chỉnh sửa"** (`editButton`) hoặc Back → `C()` quay lại bước 1 (giữ dữ liệu).
- **"OK"** (`transferButton`) → `x()`: gửi `OlaApplication.b.a(c.c, password, c.b, (short)0)` qua **socket** — kèm PIN nếu ô đang hiện, hoặc chuỗi rỗng nếu ô ẩn (server dựa vào phiên/grace 3 giờ); bật overlay.

### 4.4. Phản hồi từ server (callback `OlaTransferKenActivity.a(int i, …)`)
| Mã `i` | Ý nghĩa | UI |
|--------|---------|----|
| `7` / `10` | **Sai mật khẩu** chuyển | Dialog `dialog_title_fail` + `message_notify_wrong_password` ("Sai mật khẩu") |
| `8` | **Nick người nhận không hợp lệ** | Dialog `dialog_title_fail` + `message_fail_transfer_ken_invalide_receiver` ("Nick người nhận không đúng") |
| `39` | Ack/cập nhật mốc thời gian | đặt `c.a = now`, không hiện UI |
| (thành công) `a(short)` | Chuyển OK | Tắt overlay; **chèn 1 dòng tin "đã chuyển KEN"** vào hội thoại với người nhận (`e.b(...)`, message type 2); dialog `dialog_title_inform` + `message_transfer_ken_success_format` (kèm nick); **đóng dialog → `finish()` thoát màn** |
- **Overlay** `c(true/false)`: phủ đen 38% + spinner, **tự ẩn sau 60.000ms** nếu không có phản hồi.
- **Người nhận** sẽ nhận push notification (string `message_receive_ken_from_someone` / title `message_receive_ken_from_someone_notification_title`).

### 4.5. Modal/Dialog trong màn
- **Dialog lỗi tra nick** (`string_buddy_is_not_exist`) — 1 nút đóng.
- **Dialog lỗi chuyển** (sai mật khẩu / nick không hợp lệ) — như bảng 4.4.
- **Dialog thành công** (`message_transfer_ken_success_format`) — đóng → thoát màn.
> Màn này **không mở Activity khác**; mọi phản hồi đều qua dialog rồi tự đóng.

### 4.6. Đối chiếu bản web (`web/`)
- Web hiện chỉ có mục **"Tặng Ken"** trong `AttachmentBar` (panel More) của chat 1-1 → bấm ra **toast "coming soon"** (`ChatConversationView` nối `onSend` = `toast.info(chat.comingSoon)`), **chưa dựng UI** chuyển KEN.
- API server mới `POST /ken/transfer` (`internal/modules/ken`): nhận `toUserId` + `amount` (**1.000–10.000.000**), ghi `TRANSFER_OUT/IN`, bắn `KEN_UPDATED` 2 phía. **Khác bản gốc:** chọn người nhận bằng **userId** (gốc dùng **nick** + autocomplete), **chưa có mật khẩu (PIN) giao dịch**, max **10 triệu** (gốc 100 triệu), và **chưa chèn message** vào hội thoại.

## 5. Strings (đa ngôn ngữ)

| Resource | EN | VI |
|----------|----|----|
| `string_ballance` | Balance | Đang có |
| `string_nick_receiver` | Receiver account | Người nhận |
| `general_hint_remind_receiver_nick` | Receiver nick name | Nick Ola của người nhận |
| `string_number_ken` | Transferred KEN amount | Lượng KEN cần chuyển |
| `general_hint_ken_transfer_amount` | Enter KEN amount | Nhập số KEN cần chuyển |
| `string_enter_ken_transaction_info` | Enter KEN transaction info | Nhập thông tin giao dịch KEN |
| `string_ok` | OK | OK |
| `string_receiver` | Receiver | Người nhận |
| `string_transferred_ken_amount` | Transferred KEN amount | Số KEN cần chuyển |
| `string_password` | Password | Mật khẩu |
| `general_hint_ken_transfer_password` | Type password | Nhập mật khẩu |
| `string_edit` | Edit | Chỉnh sửa |
| `string_confirm` | Confirmation | Xác nhận |
| `string_buddy_is_not_exist` | Account is not exist! | Tài khoản không tồn tại! |
| `message_cannot_transfer_ken_to_you` | Cannot transfer KEN to yourself | Không thể chuyển KEN cho chính mình |
| `message_tradding_min_ken_value_format` | Minimum transaction is %1$s KEN | Giá trị giao dịch tối thiểu là %1$s KEN |
| `message_max_vip_price_tradding_format` | Maximum KEN transferring is %1$s | Số lượng KEN trong giao dịch phải nhỏ hơn %1$s |
| `message_not_enought_ken` | Not enough KEN for transaction | Bạn không đủ KEN để thực hiện giao dịch |
| `message_transfer_ken_confirm_format` | You transfer %1$s KEN to %2$s | Bạn sẽ chuyển %1$s KEN cho %2$s |
| `message_transfer_ken_success_format` | Transfer KEN successfully to %1$s | Đã chuyển KEN thành công cho %1$s |
| `message_transfer_ken_success_notification_title` | Transfer KEN successfully | Chuyển KEN thành công! |
| `message_notify_wrong_password` | Invalid password | Sai mật khẩu |
| `message_fail_transfer_ken_invalide_receiver` | Invalid receiver account | Nick người nhận không đúng |
| `message_receive_ken_from_someone` | You receive %1$s KEN from %2$s to account %3$s. | Bạn vừa nhận được %1$s KEN từ %2$s vào tài khoản %3$s. |
| `message_receive_ken_from_someone_notification_title` | Receive KEN! | Nhận KEN vào tài khoản! |
| `dialog_title_fail` | Error | Lỗi hệ thống |
| `dialog_title_inform` | Inform | Thông báo |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| Vào màn (từ hội thoại / kho KEN) | `transferken.OlaTransferKenActivity` (chính màn này) | — |
| Nút × / back / chuyển xong | đóng màn, quay lại màn gọi | — |

> Màn không điều hướng sang Activity mới nào khác — toàn bộ xử lý nằm trong 2 fragment + dialog của chính nó.
