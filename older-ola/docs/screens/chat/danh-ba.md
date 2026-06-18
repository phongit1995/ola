# Tab DANH BẠ — danh bạ bạn bè

> Thuộc màn [Chat (khung 2 tab)](README.md). Tab bên PHẢI (trang 1 của `OlaViewPager`).

- **Fragment:** `chat.ola.vn.m.n`
- **Layout:** `apktool_out/res/layout/ola_contact_list_view_layout.xml`
- **Item:** `contact_item_layout.xml` · **Header:** `edit_view_search_layout.xml` · **Panel cá nhân:** `contact_status_panel_layout.xml`
- **Adapter:** dùng thẳng `chat.ola.vn.h.t` (`message.g`) làm `ListAdapter` (panel cá nhân do `chat.ola.vn.g.f` dựng).
- **Chức năng:** tìm bạn theo nick/SĐT, xem danh bạ (giới tính/VIP/online), mời bạn, tạo nhóm, và **hiển thị + cập nhật trạng thái cá nhân của chính mình**.

![danh-ba](images/02-danh-ba.png)

---

## 1. Bố cục — `ola_contact_list_view_layout.xml`

```
RelativeLayout
├─ ListView  lvBuddyList   (style list.noDivider, match_parent)
│   ├─ HEADER (addHeaderView) = edit_view_search_layout.xml      ← ô TÌM KIẾM (mục 2)
│   ├─ [adapter] contact_status_panel_layout                      ← PANEL CÁ NHÂN của mình (mục 3)
│   ├─ [adapter] contact_suggest_friend_layout                    ← "Có thể bạn muốn làm quen" (mục 3b)
│   ├─ [adapter] Mời thêm bạn + Chat nhóm                         ← 2 dòng đặc biệt (mục 5)
│   └─ [adapter] contact_item_layout × N                          ← các dòng bạn bè (mục 4)
└─ addContactImageButton  FAB 56dp ↘ góc phải-dưới
      nền floating_action_bar_shape (oval xanh #7CB342), src ic_add_friend (👤+), tint trắng, margin 16dp
```

> Vì có 1 header (ô search), `onItemClick` trừ `i--` trước khi map sang dữ liệu.

## 2. Header = ô tìm kiếm — `edit_view_search_layout.xml`

| Thành phần | Giá trị (đã resolve) |
|------------|----------------------|
| Khung ngoài `searchViewLayout` | nền `app_background_color` = **#d5d5d5** (xám nhạt), padding **16dp** ngang / **12dp** dọc |
| Hộp search (drawable `bg_search_box`) | nền **TRẮNG** (`@color/white`), **viền 1px** `top_tab_unselect_color` **#b2b2b2**, **bo góc 5dp**, cao **40dp**, padding 4/2dp, gravity center |
| Icon 🔍 | `ic_action_search_small_gray` (xám) **16×16dp** |
| Ô nhập `searchSuggestedText` | `OlaQuickTypingSuggestedText`, style `edittext.nobackground` → **textSize 16sp** (`subhead`), chữ `colorTextBlackPrimary` rgba(0,0,0,.87), nền trong suốt, marginLeft 4dp, 1 dòng, `imeOptions=actionSearch`, gợi ý nick (`@`) khi focus |
| Placeholder (hint) | màu `colorTextBlackHintOrDisable` = **#42000000** (rgba(0,0,0,.26)); cờ `h.O.x` bật → `string_enter_nick_or_phone_number_to_chat` "Nhập tên nick hoặc số điện thoại cần chat"; tắt → `string_enter_nick_to_chat` "Nhập nick cần chat" (**ảnh người dùng** = locale tắt → "Nhập nick cần chat") |
| Divider dưới | View **1dp** màu `top_tab_unselect_color` **#b2b2b2** |

> ⚠️ **Quan trọng (web hay nhầm):** nền NGOÀI **xám #d5d5d5**, hộp search **TRẮNG có viền xám** — KHÔNG phải hộp xám trên nền trắng. `bg_search_box` là **drawable** (solid `@color/white` + stroke + corners 5dp), KHÔNG phải color `#a4a4a4` trùng tên.

```css
.ola-search-wrap {                 /* searchViewLayout */
  background: #d5d5d5;             /* app_background_color */
  padding: 12px 16px;
  border-bottom: 1px solid #b2b2b2;  /* top_tab_unselect_color */
}
.ola-search-box {                  /* bg_search_box */
  display: flex; align-items: center; gap: 4px;
  height: 40px; padding: 2px 4px;
  background: #fff; border: 1px solid #b2b2b2; border-radius: 5px;
}
.ola-search-box__icon { width: 16px; height: 16px; }          /* ic_action_search_small_gray */
.ola-search-box__input {
  flex: 1; border: none; background: none; outline: none;
  font-size: 16px; color: rgba(0,0,0,.87);
}
.ola-search-box__input::placeholder { color: rgba(0,0,0,.26); } /* colorTextBlackHintOrDisable */
```

> ⚠️ Header **chỉ có ô tìm kiếm**. "Mời thêm bạn"/"Chat nhóm" KHÔNG ở header — chúng là **dòng trong list** (mục 5).

## 3. Panel cá nhân của mình — `contact_status_panel_layout.xml`

Dòng ĐẦU danh bạ (do adapter `chat.ola.vn.g.f` dựng) hiển thị **thông tin của chính người dùng**:

```
LinearLayout (vertical, nền translucent_white_80_percent #CCFFFFFF, minHeight 72dp)
├─ include warningLayout (top_warning_layout) — GONE mặc định (banner VIP/xác thực — xem 3a)
├─ LinearLayout (horizontal, padding L/R 16dp · T/B 8dp)
│   ├─ vipIconImageView   40×40dp, centerInside   ← BIỂU TƯỢNG VIP/smiley, KHÔNG phải ảnh đại diện
│   │     mặc định src smiles_online (mặt cười xanh "Online"); có VIP → đổi theo cấp VIP
│   │     qua bitmap `chat.ola.vn.j.a().a(h.H)` (h.H = cấp VIP, server cấp ảnh smiley theo cấp)
│   ├─ statusMessageTextView   body1 (16sp), IN NGHIÊNG, weight 1, 1 dòng, nền trong suốt
│   │     hint general_hint_status = "Bạn đang nghĩ gì..." (EN "What's on your mind?"), màu hint .26
│   └─ statusImageView   36dp, centerCrop — GONE (thumbnail ảnh/media đính kèm vào status)
└─ listViewBottomDividerView  1dp #1F000000 (margin ngang 16dp)
```

> ⚠️ **`vipIconImageView` KHÔNG phải avatar người dùng.** Đây là **icon VIP/smiley**: mặc định mặt cười xanh `smiles_online` (chỉ số 0 = "Online"); khi có VIP, `b()` gọi `e.setImageBitmap(j.a().a(h.H))` → đổi sang smiley theo **cấp VIP** (`h.H`). Nick/tên KHÔNG hiển thị ở đây — chỉ có icon + dòng status in nghiêng.

**Tương tác — panel có 3 vùng bấm RIÊNG (logic `g/m.java#onClick`):**

| Bấm vào | Hành vi | Loại |
|---------|---------|------|
| `statusMessageTextView` (dòng "Bạn đang nghĩ gì...") | Mở **`OlaMeComposerActivity`** kèm status hiện tại (`x.c`) — đăng/sửa trạng thái cá nhân | → sang màn |
| `statusImageView` (thumbnail ảnh status) | Mở **`OlaImageViewerActivity`** — xem ảnh đính kèm của status | → sang màn |
| `vipIconImageView` (icon VIP/smiley) | Mở **popup menu tài khoản** `chat.ola.vn.i.m` (mục 7) | **modal** |
| `warningLayout` (banner, khi hiện) | Theo tag: → `BuyVipActivity` / `OlaPhoneVerificationActivity` (mục 3a) | → sang màn |

> Đây là phần "info cá nhân của mình" trên DANH BẠ. **Chỉ gồm icon VIP/smiley + dòng status IN NGHIÊNG** (không có tên/nick, không chevron, không chip "VIP"). Hint nghiêng "Bạn đang nghĩ gì..." (màu .26) hiện khi chưa đặt status; khi có status thì hiện status (vẫn in nghiêng) + thumbnail `statusImageView` bên phải nếu status có ảnh/media.

### 3a. Banner cảnh báo `warningLayout` (`top_warning_layout`) — GONE mặc định

`g/m.java#b()` bật banner (nền bo viền cam `bg_round_border_orange`, margin 8dp) theo trạng thái tài khoản — **chỉ hiện 1 trong 3**, ưu tiên từ trên xuống:

| Điều kiện (`h.O`) | tag | Dòng 1 (`warningLine1`, màu accent #FF4081) | Dòng 2 (`warningLine2`, .54) | Nút (`warningButton`) | Bấm banner → |
|---|---|---|---|---|---|
| `O.u == 0` (chưa từng VIP) | "0" | `message_register_vip_account` = "Đăng ký VIP" | `message_register_vip_explaination` = "Có thể vào ngay phòng chat đang đầy, đọc tin HOT…" | `string_buy_vip` = "Đăng ký VIP" | `BuyVipActivity.a()` |
| `0 < O.q < 3` (VIP sắp hết hạn) | "1" | `message_extend_vip_account` = "Gia hạn VIP" | `message_extend_vip_explaination` = "Tài khoản VIP của bạn sắp hết hạn…" | `string_extend_vip` = "Gia hạn VIP" | `BuyVipActivity.b()` |
| `!O.x` (SĐT chưa xác thực) | "2" | `message_phone_number_not_validate` = "Số điện thoại chưa xác thực" | `message_warning_need_verify_phone_to_protect_your_account` = "Bạn cần xác thực số điện thoại…" | `string_verify` = "Xác Thực" | `OlaPhoneVerificationActivity.a()` |

## 3b. Panel "Có thể bạn muốn làm quen" — `contact_suggest_friend_layout.xml`

Dòng gợi ý kết bạn (ngay dưới panel cá nhân):

```
LinearLayout (vertical, nền translucent_white_80_percent, padding 16/8dp)
├─ ImageView  ic_tab_find_friend  40×40dp                       ← icon kính lúp/tìm bạn (trái)
├─ LinearLayout (vertical, weight 1, marginLeft 8dp)
│   ├─ TextView  string_may_be_you_want_to_make_friend (subhead) = "Có thể bạn muốn làm quen"
│   └─ LinearLayout (horizontal, marginTop 8dp)                  ← 3 avatar gợi ý
│       ├─ profilePicImageView1  40dp
│       ├─ profilePicImageView2  40dp (marginLeft 16dp)
│       └─ profilePicImageView3  40dp (marginLeft 16dp)
├─ numberPhoneFriendTextView  badge (style contact.text.unread, nền hồng) = số gợi ý ("1")
└─ ImageView  ic_arrow_right  ❯
```

- Bấm cả dòng → mở danh sách gợi ý/tìm bạn (`string_find_suggested_friend` = "Tìm người quen").
- ⚠️ Panel này **web đang THIẾU** — cần bổ sung khi làm danh bạ thật (dữ liệu gợi ý từ API).

## 4. Item bạn bè — `contact_item_layout.xml`

| Thành phần | id | Style / kích thước | Ghi chú |
|------------|----|--------------------|---------|
| Khung dòng | (LinearLayout) | nền `#CCFFFFFF`, padding 16dp | |
| Icon giới tính | `imgGenderIcon` | **rộng 12dp** (`contact.item.device.size`), cao match dòng, marginRight 8dp, gravity left\|top | `ic_indicate_male` / `ic_indicate_female` |
| Avatar | `imgItemIcon` | **40×40dp**, `centerCrop`, bo tròn | trong FrameLayout `imgMeAvatarThumbnail` |
| Icon thiết bị | `imgDeviceType` | 12dp, nền `bg_contact_item_device`, góc phải-dưới avatar | INVISIBLE mặc định |
| Icon VIP | `vipImageHolder` | 24dp, marginRight 4dp | **GONE** nếu không VIP |
| Nick | `txtItemTitle` | `subhead` 16sp, `ellipsize=end`, 1 dòng | |
| Trạng thái | `txtItemSubTitle` | `caption` 12sp, marginTop 2dp, 1 dòng | status message của bạn |
| Ảnh đính kèm | `imgMediaThumbnail` | 40×40dp, `centerCrop`, marginLeft 8dp | **GONE** mặc định — bấm mở `OlaImageViewerActivity` |
| Online/offline | `timeOfflineTextView` | `caption` 12sp, marginLeft 8dp | **GONE** mặc định — "online"/thời gian offline |
| Divider | `listViewBottomDividerView` | `#1F000000` 1dp, margin ngang 16dp | |

## 5. Dòng đặc biệt trong list (adapter chèn)

| Dòng | Icon | Tiêu đề (VI) | Phụ đề (VI) | Bấm vào |
|------|------|--------------|-------------|---------|
| **Mời thêm bạn** | logo Facebook xanh | `string_invite_friend` = "Mời thêm bạn" | `string_invite_fb_friend_description` = "Càng đông càng vui" | → luồng **mời bạn qua Facebook** |
| **Chat nhóm** | icon nhóm Ola (+ ❯) | `string_chat_group` = "Chat nhóm" | `string_chat_group_description` = "Trò chuyện trong nhóm với cùng lúc những bạn bè khác" | → **tạo nhóm chat** |

> 2 dòng này **có cả EN lẫn VI**, hiển thị theo locale thiết bị. Ảnh `02-danh-ba.png` chụp ở locale EN ("Invite more friends / Chat group"); thực tế VI là **"Mời thêm bạn / Càng đông càng vui / Chat nhóm"** (xem ảnh người dùng cung cấp).

---

## 6. Tương tác — bấm gì → ra gì (logic `m/n.java`)

| Thành phần | Hành vi | Loại |
|------------|---------|------|
| **Gõ search + Enter** | Tìm nick/SĐT: tồn tại → **`OlaChatViewActivity`** (chat 1-1); không tồn tại → **dialog "Tài khoản không tồn tại!"** (mục 8) | → màn / **modal** |
| **Bấm 1 dòng contact** | Mở chat 1-1 (adapter `h.t` xử lý) | → sang màn |
| **Bấm avatar** `imgItemIcon` | `k()==0` (người) → **`OlaUserMePageActivity`**; `k()==2` (nhóm) → **popup nhóm** [Đổi chủ đề/Đổi tên/Rời nhóm] (mục 9) | → màn / **modal** |
| **Bấm ảnh đính kèm** `imgMediaThumbnail` | Mở **`OlaImageViewerActivity`** | → sang màn |
| **FAB** `addContactImageButton` (👤+) | Mở **`OlaAddContactActivity`** (thêm liên hệ) | → sang màn |
| **Nút ⋮** action bar (hoặc `vipIconImageView` panel cá nhân) | Mở **popup menu tài khoản** (mục 7) | **modal** |

---

## 7. Menu ⋮ DANH BẠ — menu tài khoản (`n.h_()`)

Nút ⋮ → popup list `chat.ola.vn.i.m` (thứ tự theo code):

| Mục | String (VI) | Hành động |
|-----|-------------|-----------|
| (tuỳ VIP) Đăng ký/Mua ngày VIP | `string_buy_vip` = "Đăng ký VIP" / `string_buy_vip_day` = "Mua ngày VIP" | chèn đầu tuỳ trạng thái VIP (`h.H`, `h.K`) → **`BuyVipActivity`** (→ sang màn) |
| Đổi hình đại diện | `string_change_ovatar` = "Đổi hình đại diện" | → **`OlaCropImageActivity`** (→ sang màn) |
| Đăng xuất | `string_logout` = "Đăng xuất" | → **dialog xác nhận đăng xuất thiết bị này** (mục 8b) |
| Đăng xuất mọi nơi | `string_logout_all` = "Đăng xuất mọi nơi" | → **dialog xác nhận đăng xuất TẤT CẢ** (mục 8b) |

## 8. Dialog **"Tài khoản không tồn tại"** (search)
Gõ nick/SĐT + Enter, không tìm thấy → dialog 1 nút `chat.ola.vn.i.i.a(...)`: tiêu đề `dialog_title_inform` = "Thông báo", nội dung `string_buddy_is_not_exist` = **"Tài khoản không tồn tại!"** (SĐT sai → `message_fail_phone_number_invalid`). Đang tìm hiện `ProgressDialog` `message_checking_account` = "Đang kiểm tra tài khoản".

## 8b. Dialog xác nhận **Đăng xuất** (`chat.ola.vn.i.j`)
Chọn "Đăng xuất" (z=false) / "Đăng xuất mọi nơi" (z=true) → dialog xác nhận. Xác nhận → luồng đăng xuất (có FB thì `LoginManager.logOut()`, dọn `h.t.l()`), hiện `message_logout_waiting` = **"Đang đăng xuất, vui lòng chờ!"** (≤3s) rồi về màn đăng nhập.

## 9. Popup NHÓM (bấm avatar 1 nhóm, `m/n.java#a(view,fVar)`)
Bấm avatar dòng nhóm (`k()==2`) → popup list `chat.ola.vn.i.m`:

| Mục | String (VI) | Làm gì |
|-----|-------------|--------|
| Đổi chủ đề | `string_change_topic` = "Đổi chủ đề" | → **`ChangeChatGroupTopticDialog`** |
| Đổi tên | `string_rename` = "Đổi tên" | (mục hiển thị; build này không gắn hành động) |
| Rời nhóm | `string_quit_group` = "Rời nhóm" | → **dialog** `message_chatgroup_leave_confirm_format` (Rời nhóm/Huỷ) |

---

## 10. CSS tương đương (dòng danh bạ + panel cá nhân)

```css
.ola-contact-item {
  display: flex; align-items: center;
  min-height: 72px; padding: 16px;
  background: rgba(255,255,255,.80);              /* translucent_white_80_percent */
  border-bottom: 1px solid rgba(0,0,0,.12);
}
.ola-contact-item__gender {                        /* imgGenderIcon */
  width: 12px; margin-right: 8px;                  /* contact.item.device.size = 12dp */
  align-self: flex-start;                          /* gravity left|top */
}
.ola-contact-item__avatar { position: relative; width: 40px; height: 40px; border-radius: 50%; object-fit: cover; flex-shrink: 0; }
.ola-contact-item__device { position: absolute; right: 0; bottom: 0; width: 12px; height: 12px; border-radius: 50%; background: #fff; }
.ola-contact-item__body { flex: 1; margin-left: 16px; min-width: 0; }
.ola-contact-item__title-row { display: flex; align-items: center; }
.ola-contact-item__vip { width: 24px; height: 24px; margin-right: 4px; }   /* GONE nếu không VIP */
.ola-contact-item__name { font-size: 16px; color: rgba(0,0,0,.87); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.ola-contact-item__status { margin-top: 2px; font-size: 12px; color: rgba(0,0,0,.54); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.ola-contact-item__online { margin-left: 8px; font-size: 12px; color: rgba(0,0,0,.54); }   /* GONE mặc định */

/* Panel cá nhân (contact_status_panel_layout) */
.ola-me-status {
  display: flex; align-items: center; gap: 8px;
  min-height: 72px; padding: 8px 16px;
  background: rgba(255,255,255,.80);
  border-bottom: 1px solid rgba(0,0,0,.12);
}
.ola-me-status__avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; flex-shrink: 0; }
.ola-me-status__text { flex: 1; min-width: 0; font-style: italic; color: rgba(0,0,0,.38); }   /* hint "Bạn đang nghĩ gì..." */
.ola-me-status__text.has-value { font-style: normal; color: rgba(0,0,0,.87); }
```

```html
<li class="ola-contact-item">
  <img class="ola-contact-item__gender" src="images/icons/ic_indicate_female.png">
  <div class="ola-contact-item__avatar">
    <img src="images/icons/ic_contact_photo.png" style="width:100%;height:100%;border-radius:50%">
    <img class="ola-contact-item__device" src="images/icons/ic_device_type_android.png">
  </div>
  <div class="ola-contact-item__body">
    <div class="ola-contact-item__title-row">
      <img class="ola-contact-item__vip" src="...vip.png">
      <span class="ola-contact-item__name">linhchi92</span>
    </div>
    <div class="ola-contact-item__status">Hôm nay vui ghê 🌸</div>
  </div>
  <span class="ola-contact-item__online">online</span>
</li>
```

---

## 11. Strings

| Resource | EN | VI |
|----------|----|----|
| `string_contacts` | CONTACTS | DANH BẠ |
| `string_search` | Search | Tìm kiếm |
| `string_enter_nick_or_phone_number_to_chat` | Enter nick name or phone number to chat | Nhập tên nick hoặc số điện thoại cần chat |
| `string_enter_nick_to_chat` | Enter nick to chat | Nhập nick cần chat |
| `general_hint_status` | What's on your mind? | Bạn đang nghĩ gì... |
| `string_buddy_is_not_exist` | Account is not exist! | Tài khoản không tồn tại! |
| `string_invite_friend` | Invite more friends | Mời thêm bạn |
| `string_invite_fb_friend_description` | More friends, more fun | Càng đông càng vui |
| `string_chat_group` | Chat group | Chat nhóm |
| `string_chat_group_description` | Chat to friends as group | Trò chuyện trong nhóm với cùng lúc những bạn bè khác |
| `string_may_be_you_want_to_make_friend` | (suggested friends) | Có thể bạn muốn làm quen |
| `string_find_suggested_friend` | Find friends | Tìm người quen |
| `string_change_ovatar` | Change my profile picture | Đổi hình đại diện |
| `string_logout` / `string_logout_all` | Log Out / Logout all sessions | Đăng xuất / Đăng xuất mọi nơi |
| `string_buy_vip` / `string_buy_vip_day` | Buy VIP / Purchase VIP duration | Đăng ký VIP / Mua ngày VIP |
| `string_change_topic` / `string_rename` / `string_quit_group` | Change topic / Rename / Leave group | Đổi chủ đề / Đổi tên / Rời nhóm |
| `message_logout_waiting` | Sign out Ola, please wait! | Đang đăng xuất, vui lòng chờ! |

---

## 12. Icon (trích từ APK — `images/icons/`)

| UI | Icon | Drawable |
|----|------|----------|
| FAB thêm liên hệ | ![add](images/icons/ic_add_friend.png) | `ic_add_friend` (tint trắng) |
| Menu ⋮ | ![more](images/icons/ic_more_white.png) | `ic_more_white` |
| Avatar mặc định | ![avatar](images/icons/ic_contact_photo.png) | `ic_contact_photo` |
| Giới tính nam | ![male](images/icons/ic_indicate_male.png) | `ic_indicate_male` |
| Giới tính nữ | ![female](images/icons/ic_indicate_female.png) | `ic_indicate_female` |
| Thiết bị Android/iOS | ![android](images/icons/ic_device_type_android.png) ![apple](images/icons/ic_device_type_apple.png) | `ic_device_type_android` / `ic_device_type_apple` |
