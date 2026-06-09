# Màn hình Đăng ký

- **Activity:** `chat.ola.vn.signup.OlaSignUpActivity` (+ Facebook **AccountKit** ở bước đầu)
- **Layout:** `apktool_out/res/layout/ola_sign_up_layout.xml` → fragment chọn nick `register_ola_nick_by_fb_username.xml`
- **Chức năng:** đăng ký tài khoản Ola mới qua xác thực số điện thoại, rồi chọn nick name.

> ⚠️ **Không chụp được ảnh thật với fake server.** Nút "Tạo tài khoản Ola" gọi `OlaLoginActivity.D()` → mở **Facebook AccountKit** (`AccountKitActivity`, `LoginType.PHONE`) để xác thực SĐT qua SMS. AccountKit phụ thuộc **server Facebook**, không hoạt động offline → trên thiết bị test hiện hộp thoại lỗi của Facebook. Tài liệu dưới đây **dựng lại chính xác từ layout + code**.

---

## 1. Luồng đăng ký (2 bước)

```
[Login] nhấn "Tạo tài khoản Ola"
   │  OlaLoginActivity.btnRegisterWhite → G() → D()
   ▼
BƯỚC 1 — Xác thực SĐT (Facebook AccountKit)
   AccountKitActivity, LoginType.PHONE, ResponseType.TOKEN
   (UI của Facebook: com_accountkit_fragment_phone_login_*)
   nhập số điện thoại → nhận SMS → nhập mã OTP
   │  startActivityForResult(intent, 4)  → trả token
   ▼
BƯỚC 2 — Chọn nick (UI của Ola)
   OlaSignUpActivity  (ola_sign_up_layout.xml)
   fragment: register_ola_nick_by_fb_username.xml
   nhập nick → "Hoàn tất" → tạo tài khoản
```

Ngoài ra còn nhánh `OlaSignUpBySmsActivity` (đăng ký bằng SMS trực tiếp) dùng layout/luồng tương tự bước 2.

---

## 2. BƯỚC 2 — Màn chọn nick (UI Ola)

### Bố cục
```
FrameLayout (nền trắng #FFFFFF)
├─ Action bar trên (xanh #7CB342, cao 48dp, có bóng dưới)
│    ├─ "Huỷ"  (trái, chữ trắng 16sp)
│    ├─ Tiêu đề "Tạo tài khoản Ola"  (giữa, chữ trắng 16sp)
│    └─ nút phải (icon)
└─ ScrollView (paddingTop 42dp để chừa action bar)
   └─ LinearLayout vertical
      ├─ Vùng nội dung (padding 16dp, gravity center_vertical)
      │   ├─ Tiêu đề "Choose nick name"   TextView 24sp, đậm, màu #558B2F, canh giữa
      │   ├─ Ô nhập nick (viền)           LinearLayout bo viền:
      │   │     ├─ EditText "Nhập nick"   (weight 1, hint string_enter_username)
      │   │     └─ nút ▾                  ImageView 36dp (ic_expander_show_span)
      │   ├─ [Lỗi nick]                   TextView 12sp italic đỏ (#E34545), ẩn mặc định
      │   ├─ Gợi ý nick                   TextView 12sp #DE000000, canh giữa, marginTop 16dp
      │   └─ Nút "Hoàn tất"               Button cao 36dp, nền xanh #9CCC65, marginTop 16dp
      ├─ divider 1dp (#1F000000)
      └─ "Already have an account?"       TextView 12sp #8A000000, canh giữa, cao 48dp
```

### Bảng style chi tiết

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước | Ghi chú |
|------------|----|----|--------|-----------|---------|
| Nền màn | — | trắng `#FFFFFF` | — | full | |
| Action bar | `olaTopActionBarViewLayout` | nền xanh `#7CB342`, chữ trắng | 16sp | cao 48dp, padding ngang 8dp, bóng dưới 1dp | tiêu đề canh giữa |
| Tiêu đề bước | — | `#558B2F` (`colorOlaPrimaryDark`) | **24sp** đậm | gravity center | text `string_get_started` |
| Ô nhập nick | `usernameLayout` | viền `bg_edit_text_border`, padding 16dp | — | margin T 16dp | bọc EditText + nút ▾ |
| → EditText nick | `txtAccountId` | chữ `rgba(0,0,0,.87)`, nền trong suốt | 14sp | weight 1 | hint "Nhập nick", `imeOptions=actionDone` |
| → Nút mở danh sách | `btnAccountIdMenu` | icon | — | 36×36dp, padding 8dp | `ic_expander_show_span` (▾) |
| Thông báo lỗi | `txtAccountErrorInfo` | `#E34545` (`red`) in nghiêng | 12sp | margin T 4dp | `invisible` mặc định |
| Gợi ý nick | `txtAccountTipTextView` | `rgba(0,0,0,.87)` | 12sp | canh giữa, margin T 16dp | text `string_nick_hint` |
| **Nút Hoàn tất** | `nextStepButton` | chữ `#FFFFFF`, nền `#9CCC65` | 14sp | cao 36dp, margin T 16dp | viền 1px `#558B2F`, bo 2dp |
| Divider | — | `rgba(0,0,0,.12)` | — | cao 1dp | |
| "Đã có tài khoản?" | `alreadyHaveAccountTextView` | `rgba(0,0,0,.54)` | 12sp | canh giữa, cao 48dp | text `string_already_have_account` |

## 3. CSS tương đương (bước chọn nick)

```css
.ola-signup {
  min-height: 100vh;
  background: #FFFFFF;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
  display: flex; flex-direction: column;
}

/* Action bar trên */
.ola-signup__bar {
  height: 48px;
  display: flex; align-items: center;
  padding: 0 8px;
  background: #7CB342;                 /* colorOlaPrimary */
  color: #FFFFFF;
  box-shadow: 0 1px 0 rgba(0,0,0,.12); /* bg_action_bar: bóng mảnh dưới */
}
.ola-signup__bar .cancel { font-size: 16px; }
.ola-signup__bar .title  { flex: 1; text-align: center; font-size: 16px; }

/* Nội dung */
.ola-signup__body { padding: 16px; display: flex; flex-direction: column; }
.ola-signup__title {
  text-align: center;
  font-size: 24px; font-weight: bold;
  color: #558B2F;                       /* colorOlaPrimaryDark */
}

/* Ô nhập nick có viền */
.ola-signup__nick {
  display: flex; align-items: center;
  margin-top: 16px;
  border: 1px solid rgba(0,0,0,.12);
  border-radius: 2px;
  padding: 0 8px;
}
.ola-signup__nick input {
  flex: 1; border: none; outline: none;
  padding: 16px 8px;
  font-size: 14px;
  color: rgba(0,0,0,.87);
  background: transparent;
}
.ola-signup__nick .menu { width: 36px; height: 36px; padding: 8px; opacity: .54; }

.ola-signup__error {                    /* ẩn mặc định */
  margin-top: 4px;
  font-size: 12px; font-style: italic;
  color: #E34545;
  visibility: hidden;
}
.ola-signup__hint {
  margin-top: 16px;
  text-align: center;
  font-size: 12px;
  color: rgba(0,0,0,.87);
}

/* Nút Hoàn tất (xanh, thấp hơn nút login) */
.ola-signup__finish {
  height: 36px; margin-top: 16px;
  background: #9CCC65; border: 1px solid #558B2F; border-radius: 2px;
  color: #FFFFFF; font-size: 14px; cursor: pointer;
}

.ola-signup__divider { height: 1px; background: rgba(0,0,0,.12); }
.ola-signup__has-account {
  height: 48px; line-height: 48px; text-align: center;
  font-size: 12px; color: rgba(0,0,0,.54);
}
```

```html
<div class="ola-signup">
  <div class="ola-signup__bar">
    <span class="cancel">Huỷ</span>
    <span class="title">Tạo tài khoản Ola</span>
    <span style="width:48px"></span>
  </div>

  <div class="ola-signup__body">
    <div class="ola-signup__title">Choose nick name</div>
    <div class="ola-signup__nick">
      <input type="text" placeholder="Nhập nick">
      <img class="menu" src="../images/ic_expander_show_span.png">
    </div>
    <div class="ola-signup__error">Nick không hợp lệ</div>
    <div class="ola-signup__hint">
      Yêu cầu hơn 6 ký tự, không ký tự đặc biệt. Nên dùng nick dễ nhớ…
    </div>
    <button class="ola-signup__finish">Hoàn tất</button>
  </div>

  <div class="ola-signup__divider"></div>
  <div class="ola-signup__has-account">Already have an account?</div>
</div>
```

## 4. Khác biệt style so với màn đăng nhập

| Tiêu chí | Đăng nhập | Đăng ký (chọn nick) |
|----------|-----------|---------------------|
| Nền | Xanh `#7CB342` | Trắng `#FFFFFF` |
| Action bar | Không có | Có (xanh, cao 48dp) |
| Ô nhập | Thẻ trắng đổ bóng, chữ tối | Ô viền mảnh `#1F000000` |
| Nút chính | Cao **48dp**, chữ **24sp** | Cao **36dp**, chữ **14sp** |
| Chữ phụ | Trắng (trên nền xanh) | Đen (trên nền trắng) |

## 5. Strings

| Resource | EN | VI (dự kiến) |
|----------|----|--------------|
| `string_register_account` | Sign up Ola | Tạo tài khoản Ola |
| `string_get_started` | Choose nick name | Chọn nick |
| `string_enter_username` | Enter your nick name | Nhập nick |
| `string_finish` | Finish | Hoàn tất |
| `string_nick_hint` | Required more than 6 letters and no special characters… | Yêu cầu hơn 6 ký tự, không ký tự đặc biệt… |
| `string_already_have_account` | Already have an account? | Đã có tài khoản? |

## 6. Ghi chú khi tái hiện với fake server

- Để chạy được luồng đăng ký thật cần **server Facebook AccountKit** → fake server hiện **không** mô phỏng bước này.
- Có thể bỏ qua đăng ký: ở fake server, **mọi nick/mật khẩu đều đăng nhập thành công** (xem [màn đăng nhập](../dang-nhap/README.md) §4 và [../../api/socket-protocol.md](../../api/socket-protocol.md)).
- Nếu muốn mô phỏng đăng ký nội bộ: cần patch smali để `btnRegisterWhite` mở thẳng `OlaSignUpActivity` thay vì AccountKit (sửa `OlaLoginActivity.D()`), rồi fake REST trả nick hợp lệ.
