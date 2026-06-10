# Màn hình Hồ sơ bản thân / Thông tin cá nhân (Edit Profile)

- **Activity:** `chat.ola.vn.activity.OlaUserProfileActivity` — `jadx_out/sources/chat/ola/vn/activity/OlaUserProfileActivity.java`
- **Layout:** `apktool_out/res/layout/persionnal_infomation_view_layout.xml`
- **Vào từ:** nút **"Cập Nhật Thông Tin"** (`string_update_info`) trong [trang cá nhân](../trang-ca-nhan/README.md) (chỉ hồ sơ của mình)
- **Action bar:** `ola_top_action_bar_center_title_layout` — tiêu đề **"Thông tin cá nhân"** (`string_persional_info`), nút **X** (`ic_action_quit`), ẩn nút back

> **Đây là màn SỬA hồ sơ của CHÍNH MÌNH** — khác `OlaUserMePageActivity` (xem hồ sơ người khác). Đặc điểm: **không có nút "Lưu"** — dữ liệu **tự lưu khi rời màn** (`onPause` gọi API cập nhật). Mỗi trường text mặc định khoá, bấm **icon ✏️** (`ic_action_edit`) bên phải để mở sửa.

> Phân tích 100% từ XML + code. Icon trích vào [images/icons/](images/icons/).

---

## 1. Bố cục màn (`persionnal_infomation_view_layout.xml`)

```
FrameLayout (nền trắng)
├─ ScrollView  scrollView1  (paddingTop 42dp = chừa action bar)
│   └─ LinearLayout (vertical, marginTop 8dp)
│       ├─ LinearLayout (padding 16dp) — 7 KHỐI THÔNG TIN (mỗi khối: nhãn caption + giá trị + kẻ 1px)
│       │   ├─ ① Họ và tên        fullnameEditText   + ✏️ fullnameEditImageView
│       │   ├─ ② Số điện thoại    txtPhoneNumber     + ✏️ phoneNumberEditImageView  (+ phoneStateTextView ẩn)
│       │   ├─ ③ Sinh nhật        txtMeUserBirthday  + ✏️ birthdayEditImageView
│       │   ├─ ④ Giới tính        txtSex             + ✏️ genderEditImageView
│       │   ├─ ⑤ Quan hệ          txtMarry           (bấm cả dòng)
│       │   ├─ ⑥ Mật khẩu         passwordStateTextView  (bấm → đổi mật khẩu)
│       │   └─ ⑦ Tham gia Ola     txtJoinOlaDate     (chỉ đọc)
│       ├─ Button  btnLinkFacebookAccount  (48dp, style button)        ← Liên kết Facebook
│       ├─ Button  btnSupportService       (48dp, style button.green)  ← Hỗ trợ khách hàng
│       └─ View (trong suốt, 48dp — đệm cuối)
└─ <include> ola_top_action_bar_center_title_layout
```

Mỗi khối có cấu trúc giống nhau:
```
LinearLayout (vertical, marginTop 16dp)
├─ TextView  (nhãn, style caption)                        ← "Họ và tên của bạn" …
├─ LinearLayout (ngang, center_vertical)
│   ├─ EditText/TextView  (giá trị, style body1, weight 1, marginTop 4dp, hint màu ĐỎ #e34545)
│   └─ ImageView ✏️  (20×20dp, nền bg_round_rect_black_translucent, padding 2dp, ic_action_edit)
└─ (sau khối) View kẻ ngăn 1px màu colorTextBlackDivider, marginTop 16dp
```

## 2. Các trường hồ sơ (đầy đủ)

| # | Trường | id | Kiểu | Nhãn / Hint (VI) | Sửa thế nào |
|---|--------|----|------|------------------|-------------|
| ① | **Họ và tên** | `fullnameEditText` | EditText (1 dòng) | nhãn "Họ và tên của bạn"; hint "Nhập tên đầy đủ của bạn" | bấm ✏️ → bật sửa + bàn phím |
| ② | **Số điện thoại** | `txtPhoneNumber` | EditText `inputType=phone` | "Số điện thoại"; hint "Nhập số điện thoại của bạn" | nếu **bị khoá** (`l.B`) → dialog mở khoá (gọi tổng đài 1900588883); nếu không → sửa. `phoneStateTextView` hiện trạng thái xác thực |
| ③ | **Sinh nhật** | `txtMeUserBirthday` | TextView → **DatePickerDialog** | "Sinh nhật"; hint "Nhập ngày sinh của bạn" | bấm → chọn ngày (Android DatePicker) |
| ④ | **Giới tính** | `txtSex` | TextView → **dialog chọn** | "Giới tính" | dialog `i.m`: **Nam** (1) / **Nữ** (0) / **Linh hoạt** (2) |
| ⑤ | **Quan hệ** (hôn nhân) | `txtMarry` | TextView (bấm) | "Quan hệ" | chưa cưới → `MarriageRequestComposerActivity` (cầu hôn); đã cưới → dialog **HỦY kết hôn** (`message_divorce_confirmation`) |
| ⑥ | **Mật khẩu** | `passwordStateTextView` | TextView (bấm) | "Mật khẩu" / "Chạm vào để đổi mật khẩu" | → `OlaChangePasswordActivity` |
| ⑦ | **Tham gia Ola** | `txtJoinOlaDate` | TextView | "Tham gia Ola" | **chỉ đọc** (ngày tạo tài khoản) |

> Hint dùng **màu đỏ `#e34545`** (gợi ý bắt buộc/chưa điền). Giá trị dùng style body1, nhãn dùng caption.

## 3. Hai nút dưới cùng

| Nút | id | Style | Hành động |
|-----|----|-------|-----------|
| **Liên kết Facebook** | `btnLinkFacebookAccount` | `defaultStyle.button` | đổi chữ theo trạng thái: **"Liên kết tài khoản Facebook"** ↔ **"Ngắt liên kết tài khoản Facebook"** (`string_(un)link_facebook_account`). Link → `OlaFacebookActivity` lấy token; Unlink → dialog xác nhận |
| **Hỗ trợ khách hàng** | `btnSupportService` | `defaultStyle.button.green` (xanh) | `string_customer_support` = "Hỗ trợ khách hàng" → gọi tổng đài 1900588883 |

## 4. Lưu & API

- **Không có nút Lưu.** Lưu **tự động** khi `onPause()` (dòng 507–526):
  ```java
  OlaApplication.b.a(fullname, phoneNumber, birthday, gender);
  ```
  (birthday = mili-giây nếu đã đặt; gender = byte 0/1/2 nếu đã chọn).
- **Đổi sinh nhật** gọi ngay `b.a(null, null, <millis>, null)` (dòng 501) khi chọn xong DatePicker.
- **Tải hồ sơ** lúc mở: `G()` → `b.b(nick, callback)` (hiện dialog "Please wait", trả về `entity.ag`).
- **Avatar / Ảnh bìa KHÔNG sửa ở màn này** (layout không có ô avatar/cover) — sửa ở [trang cá nhân](../trang-ca-nhan/README.md) qua icon máy ảnh (`OlaCropImageActivity`).

## 5. Màn / dialog liên quan

| Từ | Mở |
|----|----|
| Mật khẩu | `OlaChangePasswordActivity` |
| Quan hệ (chưa cưới) | `MarriageRequestComposerActivity` |
| Quan hệ (đã cưới) | dialog HỦY kết hôn → `OlaApplication.b.v()` |
| Số ĐT (xác thực) | `OlaPhoneVerificationActivity` |
| Liên kết FB | `OlaFacebookActivity` |

## 6. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `string_persional_info` | Profile | Thông tin cá nhân |
| `string_update_info` | Update Info | Cập Nhật Thông Tin |
| `string_first_and_last_name` | First and last name | Họ và tên của bạn |
| `hint_enter_fullname` | Enter your full name | Nhập tên đầy đủ của bạn |
| `string_phone_number` | Phone number | Số điện thoại |
| `hint_enter_phone_number` | Enter your phone number | Nhập số điện thoại của bạn |
| `string_birthday` | Birthday | Sinh nhật |
| `hint_enter_birthday` | Enter your birthday | Nhập ngày sinh của bạn |
| `string_sex` | Gender | Giới tính |
| `string_male` / `string_female` / `string_flexible` | Male / Female / Flexible | Nam / Nữ / Linh hoạt |
| `string_relationship` | Relationship | Quan hệ |
| `string_password` | Password | Mật khẩu |
| `string_tap_to_change_password` | Tap to change password | Chạm vào để đổi mật khẩu |
| `string_join_ola` | Joined Ola | Tham gia Ola |
| `string_link_facebook_account` | Link to Facebook account | Liên kết tài khoản Facebook |
| `string_unlink_facebook_account` | Unlink Facebook account | Ngắt liên kết tài khoản Facebook |
| `string_customer_support` | Customer support | Hỗ trợ khách hàng |
| `message_divorce_confirmation` | Do you want to divorce %1$s? | Bạn có muốn HỦY kết hôn với %1$s không? |

## 7. CSS tương đương

```css
.ola-edit-profile { background: #fff; font-family: Roboto, "Helvetica Neue", Arial, sans-serif; }
.ola-edit-profile__list { padding: 16px; }
.ola-edit-profile__field { padding-top: 16px; }
.ola-edit-profile__label { font-size: 12px; color: rgba(0,0,0,.54); }   /* caption */
.ola-edit-profile__row { display: flex; align-items: center; margin-top: 4px; }
.ola-edit-profile__value {
  flex: 1; border: none; background: none; padding: 0;
  font-size: 14px; color: rgba(0,0,0,.87);                              /* body1 */
}
.ola-edit-profile__value::placeholder { color: #e34545; }              /* hint đỏ */
.ola-edit-profile__edit {                                              /* ✏️ ic_action_edit */
  width: 20px; height: 20px; padding: 2px;
  background: rgba(0,0,0,.3); border-radius: 4px;                       /* bg_round_rect_black_translucent */
}
.ola-edit-profile__divider { height: 1px; background: rgba(0,0,0,.12); margin-top: 16px; }

.ola-edit-profile__btn {
  display: block; width: calc(100% - 32px); height: 48px; margin: 16px 16px 0;
  border: 1px solid #558B2F; background: #fff; border-radius: 4px;
}
.ola-edit-profile__btn--support { background: #9CCC65; color: #fff; border: none; }  /* button.green */
```

```html
<div class="ola-edit-profile">
  <div class="ola-edit-profile__list">
    <div class="ola-edit-profile__field">
      <div class="ola-edit-profile__label">Họ và tên của bạn</div>
      <div class="ola-edit-profile__row">
        <input class="ola-edit-profile__value" placeholder="Nhập tên đầy đủ của bạn">
        <img class="ola-edit-profile__edit" src="images/icons/ic_action_edit.png">
      </div>
    </div>
    <div class="ola-edit-profile__divider"></div>

    <div class="ola-edit-profile__field">
      <div class="ola-edit-profile__label">Giới tính</div>
      <div class="ola-edit-profile__row">
        <span class="ola-edit-profile__value">Nam</span>
        <img class="ola-edit-profile__edit" src="images/icons/ic_action_edit.png">
      </div>
    </div>
    <div class="ola-edit-profile__divider"></div>
  </div>
  <button class="ola-edit-profile__btn">Liên kết tài khoản Facebook</button>
  <button class="ola-edit-profile__btn ola-edit-profile__btn--support">Hỗ trợ khách hàng</button>
</div>
```

## 8. Icon & token UI

| UI | Icon | Drawable |
|----|------|----------|
| Sửa trường (✏️) | ![edit](images/icons/ic_action_edit.png) | `ic_action_edit` (20dp, nền tròn đen mờ) |
| Đóng (action bar) | ![quit](images/icons/ic_action_quit.png) | `ic_action_quit` |

| Thành phần | Giá trị |
|------------|---------|
| Action bar | tiêu đề giữa "Thông tin cá nhân", nút X, ẩn back |
| Nội dung | ScrollView, padding 16dp, các khối cách 16dp |
| Nhãn trường | caption 12sp, `rgba(0,0,0,.54)` |
| Giá trị | body1 14sp, `rgba(0,0,0,.87)` |
| Hint (gợi ý) | **đỏ `#e34545`** |
| Icon sửa | 20×20dp, nền `bg_round_rect_black_translucent`, padding 2dp |
| Kẻ ngăn | 1px `colorTextBlackDivider` (`rgba(0,0,0,.12)`) |
| Nút | cao 48dp, margin ngang 16dp; FB = style button, Hỗ trợ = button.green (xanh `#9CCC65`) |
| Lưu | **tự động ở `onPause`** (không có nút Lưu) |
| Số trường | 7 (Họ tên · SĐT · Sinh nhật · Giới tính · Quan hệ · Mật khẩu · Tham gia Ola) |
