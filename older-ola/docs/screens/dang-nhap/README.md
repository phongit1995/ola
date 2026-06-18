# Màn hình Đăng nhập

- **Activity:** `chat.ola.vn.activity.OlaLoginActivity`
- **Layout:** `apktool_out/res/layout/login_view_layout.xml`
- **Chức năng:** đăng nhập bằng nick/mật khẩu, hoặc chuyển sang đăng ký / đăng nhập Facebook / quên mật khẩu.

## Ảnh chụp (thiết bị thật + fake server)

| Đã có tài khoản lưu sẵn | Trạng thái trống (hint) |
|---|---|
| ![login prefilled](images/01-login-prefilled.png) | ![login empty](images/02-login-empty.png) |

> Khi **2 ô trống**, nút xanh hiển thị **"Tạo tài khoản Ola"**; khi đã nhập, nút đổi thành **"Đăng nhập"**. Nếu từng đăng nhập, app hiện **avatar account đã lưu** (vùng `OlaGalleryView`) phía trên ô nhập, kèm nút `×` để xoá account khỏi danh sách.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ola_logo_trans` | ![logo](../images/ola_logo_trans.png) (mặt cười trắng, nền trong suốt — hiện rõ trên nền xanh) | Logo trên đầu màn |
| `ic_input_clear` | ![clear](../images/ic_input_clear.png) | Nút `×` xoá nội dung ô nhập |

> Ảnh asset dùng chung đặt ở [../images/](../images/); ảnh chụp màn hình riêng của màn này ở [images/](images/).

---

## 1. Bố cục (top → bottom)

```
ScrollView (nền xanh #7CB342, fillViewport)
└─ LinearLayout vertical, gravity=center, padding ngang 16dp
   ├─ Logo Ola            ImageView 56×56dp, margin trên/dưới 16dp (ola_logo_trans)
   ├─ [Account gallery]   OlaGalleryView (ẩn nếu chưa lưu account; hiện avatar tròn + nick)
   ├─ Thẻ nhập (card)     LinearLayout nền trắng bo góc + đổ bóng (bg_shadow_4_edges)
   │   ├─ Ô "Tên đăng nhập"  EditText + nút × (ic_input_clear)
   │   ├─ divider 1px        (#1F000000, margin ngang 4dp)
   │   ├─ Ô "Mật khẩu"       EditText (ẩn ký tự) + nút ×
   │   └─ [Captcha]          ẩn mặc định — chỉ hiện khi server yêu cầu
   ├─ Nút "Đăng nhập"     Button cao 48dp, nền xanh #9CCC65, chữ trắng 24sp
   ├─ "Bạn quên mật khẩu?"  TextView 14sp, chữ trắng, canh phải
   ├─ "Tạo tài khoản Ola"   TextView 20sp, chữ trắng 70%, canh giữa, cao 48dp
   ├─ "Đăng ký bằng Facebook" TextView 20sp, chữ trắng 70%, canh giữa, cao 48dp
   └─ "Phiên bản: …"        TextView 9sp, chữ trắng 70%, canh phải-dưới
+ Overlay loading (ProgressBar giữa màn, nền đen 38%) — ẩn mặc định
```

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú |
|------------|----|----|--------|--------------------------|---------|
| Nền màn hình | (ScrollView) | nền `#7CB342` (`colorOlaPrimary`) | — | full màn | cuộn được khi bàn phím mở |
| Logo | `olaLogoImageView` | — | — | 56×56dp, margin T/B 16dp | `ola_logo_trans` (mặt cười trắng) |
| Avatar account đã lưu | `accountGallery` | — | nick: trắng | cao tối thiểu 96dp, spacing 16dp | ẩn nếu chưa có account |
| Thẻ nhập (card) | `inputSpan` | nền trắng | — | bo góc + bóng (9-patch `bg_shadow_4_edges`), margin dưới 8dp | bọc 2 ô nhập |
| Ô tên đăng nhập | `txtUserName` | chữ `rgba(0,0,0,.87)`, nền trong suốt | 16sp | 1 dòng | hint "Tên đăng nhập", `inputType=textEmailAddress`, Enter→ô kế |
| Nút xoá tên | `btnClearUserName` | icon xám | — | 36×36dp, padding 6dp | `ic_input_clear` (dấu ×) |
| Divider | — | `rgba(0,0,0,.12)` | — | cao 1px, margin ngang 4dp | kẻ giữa 2 ô |
| Ô mật khẩu | `txtPassword` | chữ `rgba(0,0,0,.87)`, nền trong suốt | 16sp | 1 dòng | hint "Mật khẩu", `inputType=textPassword`, Enter→đăng nhập |
| Nút xoá mật khẩu | `btnClearPassword` | icon xám | — | 36×36dp, padding 6dp | `ic_input_clear` |
| **Nút Đăng nhập** | `btnLogin` | chữ `#FFFFFF`, nền `#9CCC65` (`buttonGreen`) | **24sp** | cao 48dp, margin T 8dp / B 12dp | viền 1px `#558B2F`, bo góc 2dp |
| Quên mật khẩu | `forgotPasswordTextView` | chữ `#FFFFFF` | 14sp | padding T/B 12dp, canh phải | mở màn khôi phục |
| Tạo tài khoản Ola | `btnRegisterWhite` | chữ `rgba(255,255,255,.70)` | 20sp | cao 48dp, margin T 4dp, canh giữa | → [màn đăng ký](../dang-ky/README.md) |
| Đăng ký bằng Facebook | `btnLoginFacebook` | chữ `rgba(255,255,255,.70)` | 20sp | cao 48dp, margin T 20dp, canh giữa | qua Facebook SDK |
| Phiên bản | `versionCodeTextView` | chữ `rgba(255,255,255,.70)` | 9sp | margin T 16dp, canh phải-dưới | "Phiên bản: <build>" |
| Captcha (ẩn) | `validationCodeLayout` | thông báo `#E34545` in nghiêng | 12sp | ẩn mặc định | hiện khi server bắt nhập mã |
| Overlay loading | `loadingProgressBar` | nền `rgba(0,0,0,.38)` | — | full màn | spinner 48dp ở giữa |

## 3. CSS tương đương (dựng lại trên web)

```css
/* ===== Nền màn hình ===== */
.ola-login {
  min-height: 100vh;
  background: #7CB342;            /* colorOlaPrimary */
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0 16px;
  box-sizing: border-box;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
}

/* Logo */
.ola-login__logo {
  width: 56px; height: 56px;
  margin: 16px 0;
  object-fit: contain;
}

/* ===== Thẻ nhập (card trắng đổ bóng) ===== */
.ola-login__card {
  width: 100%;
  background: #FFFFFF;
  border-radius: 2px;
  box-shadow: 0 1px 4px rgba(0,0,0,.24), 0 0 2px rgba(0,0,0,.12); /* mô phỏng bg_shadow_4_edges */
  margin-bottom: 8px;
  overflow: hidden;
}
.ola-login__field {
  position: relative;
  display: flex;
  align-items: center;
}
.ola-login__field input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  color: rgba(0,0,0,.87);        /* colorTextBlackPrimary */
  padding: 16px;
}
.ola-login__field input::placeholder { color: rgba(0,0,0,.38); }
.ola-login__field--user input { font-size: 16px; }   /* subhead (style defaultStyle.edittext.username override = 16sp) */
.ola-login__field--pass input { font-size: 16px; }   /* subhead */
.ola-login__divider {
  height: 1px;
  margin: 0 4px;
  background: rgba(0,0,0,.12);   /* colorTextBlackDivider */
}
.ola-login__clear {                /* nút × xoá nội dung */
  width: 36px; height: 36px; padding: 6px;
  opacity: .54; cursor: pointer;
  box-sizing: border-box;
}

/* ===== Nút Đăng nhập ===== */
.ola-login__btn {
  width: 100%;
  height: 48px;
  margin: 8px 0 12px;
  background: #9CCC65;           /* buttonGreen */
  border: 1px solid #558B2F;     /* colorOlaPrimaryDark */
  border-radius: 2px;
  color: #FFFFFF;
  font-size: 24px;               /* text.size.headline */
  cursor: pointer;
}
.ola-login__btn:active { border-width: 2px; }

/* ===== Link phụ ===== */
.ola-login__forgot {
  align-self: flex-end;
  color: #FFFFFF;
  font-size: 14px;
  padding: 12px 0;
}
.ola-login__register,
.ola-login__fb {
  width: 100%;
  height: 48px;
  line-height: 48px;
  text-align: center;
  color: rgba(255,255,255,.70);  /* colorTextWhiteSecondary */
  font-size: 20px;               /* text.size.title */
}
.ola-login__register { margin-top: 4px; }
.ola-login__fb { margin-top: 20px; }
.ola-login__version {
  width: 100%;
  text-align: right;
  margin-top: 16px;
  color: rgba(255,255,255,.70);
  font-size: 9px;
}

/* ===== Overlay loading ===== */
.ola-login__overlay {
  position: fixed; inset: 0;
  background: rgba(0,0,0,.38);    /* translucent_black_38_percent */
  display: none;                  /* bật khi đang đăng nhập */
  align-items: center; justify-content: center;
}
```

```html
<div class="ola-login">
  <img class="ola-login__logo" src="../images/ola_logo_trans.png" alt="Ola">

  <div class="ola-login__card">
    <div class="ola-login__field ola-login__field--user">
      <input type="text" placeholder="Tên đăng nhập">
      <img class="ola-login__clear" src="../images/ic_input_clear.png">
    </div>
    <div class="ola-login__divider"></div>
    <div class="ola-login__field ola-login__field--pass">
      <input type="password" placeholder="Mật khẩu">
      <img class="ola-login__clear" src="../images/ic_input_clear.png">
    </div>
  </div>

  <button class="ola-login__btn">Đăng nhập</button>
  <a class="ola-login__forgot">Bạn quên mật khẩu?</a>
  <a class="ola-login__register">Tạo tài khoản Ola</a>
  <a class="ola-login__fb">Đăng ký bằng Facebook</a>
  <div class="ola-login__version">Phiên bản: 15240093</div>
</div>
```

## 4. Hành vi & luồng

### 4.1. Khởi tạo màn (`onCreate` → `F()`)

- **Kiểm tra phiên bản cũ:** nếu version đã lưu `e.a().b()` trong khoảng `1..88` → gọi `chat.ola.vn.h.b.g()` dọn dữ liệu account đã lưu (migrate).
- **Bắt buộc chọn ngôn ngữ lần đầu:** nếu **chưa từng chọn ngôn ngữ** (`!e.a().m()`):
  - Quét locale của máy — nếu có **tiếng Việt** (`vi`) → tự đặt ngôn ngữ `default` và vào thẳng màn login.
  - Nếu **không có** locale `vi` → mở màn **Chọn ngôn ngữ** `OlaLanguageChooser` rồi `finish()` màn login (sẽ quay lại sau khi chọn).
- **Tự bỏ qua login nếu còn phiên:** ở `a()` (khi đã kết nối lại), nếu `h.g()` = đang đăng nhập hợp lệ → vào thẳng [Trang chủ](../trang-chu/README.md) `OlaBottomTabActivity` và `finish()`, **không hiện màn login**.
- **AppLink (Facebook deferred deep link):** `onCreate` fetch `AppLinkData` để log analytics "Launch From AppLink" (không đổi UI).
- **Điền sẵn tài khoản:** đọc danh sách account đã lưu `v = chat.ola.vn.h.b.a(this)`.
  - Danh sách **rỗng** → ẩn gallery (`accountGallery` GONE), hiện logo.
  - Có account → hiện gallery, **ẩn logo**.
  - Lấy username gần nhất `e.a().i()`: nếu rỗng → điền account `[0]`; nếu có → tìm account trùng tên trong danh sách rồi điền **nick + mật khẩu** đã lưu.
- **Nhãn nút xanh tự đổi** (TextWatcher 2 ô): **cả 2 ô trống** → nút hiện **"Tạo tài khoản Ola"** (`string_register_account`); **có nhập** → **"Đăng nhập"** (`string_login`). Nút `×` của mỗi ô chỉ hiện khi ô đó có chữ.

### 4.2. Bảng tương tác (mọi cử chỉ)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| Vùng nền `olaLoginPageFrameLayout` | chạm (onTouch) | Ẩn bàn phím của ô đang focus | nội bộ |
| Ô tên `txtUserName` | Enter (`imeOptions=actionNext`) | Nhảy xuống ô mật khẩu | nội bộ |
| Ô mật khẩu `txtPassword` | Enter (`actionGo`, action id 2) | Gọi `B()` = đăng nhập | nội bộ |
| Ô captcha `validationCodeEditText` | Enter (`actionGo`) | Gửi đăng nhập kèm mã | nội bộ |
| Nút × tên `btnClearUserName` | click | Xoá ô tên, focus + mở bàn phím | nội bộ |
| Nút × mật khẩu `btnClearPassword` | click | Xoá ô mật khẩu, focus + mở bàn phím | nội bộ |
| **Nút xanh** `btnLogin` | click | **2 ô trống** → `G()`=mở **AccountKit (SĐT)** tạo tài khoản (req 4); **có nhập** → `B()` đăng nhập | hỗn hợp |
| "Bạn quên mật khẩu?" `forgotPasswordTextView` | click | Mở **dialog Quên mật khẩu** (xem 4.4) | modal trong màn |
| "Tạo tài khoản Ola" `btnRegisterWhite` | click | `G()` → **AccountKit (SĐT)** xác thực (req 4) → đăng ký/đăng nhập | sang màn khác |
| "Đăng ký bằng Facebook" `btnLoginFacebook` | click | Đăng nhập Facebook rồi liên kết account Ola (xem 4.5) | sang màn khác |
| Avatar account `imgIcon` | click | Điền nick+mật khẩu của account đó; nếu đủ 2 ô → `B()` đăng nhập luôn | nội bộ |
| Tên account `txtAccountName` | click | (như trên) điền + đăng nhập | nội bộ |
| Nút × trên account `imgAccountRemoveAction` | click | Mở **dialog xoá account đã lưu** (xem 4.4) | modal trong màn |
| Phím Back | onBackPressed | `finish()` — thoát app | nội bộ |

> **Lưu ý:** gallery account **không có long-press** — mỗi item (`user_account_icon`) chỉ có 3 vùng click (avatar / tên / nút ×), đều uỷ quyền về `onClick` của Activity qua `view.getTag()`.

### 4.3. Luồng đăng nhập `B()` + kiểm tra `C()`

- **`C()` validate trước khi gửi:**
  1. Tên trống → **rung** ô tên (`R.anim.shake`), dừng.
  2. Tên chứa `@` → **cắt bỏ** phần sau `@` (vd `user@abc` → `user`).
  3. Tên sai định dạng (`m.a(name,1)`) → dialog cảnh báo `message_invalid_username_format`.
  4. Mật khẩu trống/quá ngắn (`m.c`) → **rung** ô mật khẩu, dừng.
  5. Captcha đang hiện mà **bỏ trống** → **rung** ô captcha, dừng.
- **Gửi đăng nhập:** ẩn bàn phím → nếu **đã kết nối sẵn** (`OlaApplication.b.h()`) thì `w()` vào thẳng [Trang chủ](../trang-chu/README.md). Ngược lại thu thập (nick đã trim/lowercase, mật khẩu, mã captcha nếu có, token `d` của account) rồi `a(...)` → `OlaApplication.b.a(...)` mở **socket** (xem [../../api/socket-protocol.md](../../api/socket-protocol.md)): handshake svc `96` → login svc `206` → online svc `97`. Nếu gửi lỗi → **tự thử lại sau mỗi 3000ms**. Với fake server: nick/mật khẩu bất kỳ đều vào được.
- **Đếm số lần sai (`r`):** mỗi lần đổi nick thì reset; cùng một nick mà sai liên tiếp thì tăng. **Sai ≥ 3 lần** → chuyển sang gợi ý khôi phục mật khẩu (xem 4.4 dialog `message_recommend_recovery_password`).
- **Overlay loading `c(true)`:** hiện spinner phủ đen 38% + đặt timeout (**15s** nếu đang kết nối, **60s** nếu chưa). Quá hạn mà vẫn chưa kết nối → dialog `message_process_timeout` (Hỗ trợ → gọi hotline / Đóng) và ẩn loading.

**Xử lý lỗi từ server (callback `a(int i,…)`):**

| Mã `i` | Ý nghĩa | Hành vi UI |
|--------|---------|------------|
| `0` | Lỗi chung | Dialog `dialog_title_fail` + nút **Hỗ trợ** (→ gọi `1900588883`) / **Đóng** |
| `2` | Yêu cầu / sai **captcha** | Hiện ảnh captcha (`validationCodeLayout` VISIBLE), focus ô captcha, rung, toast |
| `7` | Sai **nick hoặc mật khẩu** | `r<3`: rung cả 2 ô + focus nick + toast `…fail_usernameorpassword`; `r≥3`: gợi ý khôi phục `f()` |
| `10` | Sai **mật khẩu** | `r<3`: toast `…fail_password` + rung ô mật khẩu; `r≥3`: gợi ý khôi phục `f()` |
| `1` (svc 59) | Mất mạng | Dialog `message_connection_lost_network_title` (Hỗ trợ/Đóng) |
| khác | Lỗi có mã | Dialog `message_login_fail_with_error_code: <i>` (Hỗ trợ/Đóng) |

### 4.4. Modal/Dialog mở trong màn (chi tiết)

1. **Dialog "Quên mật khẩu"** — mở khi bấm *"Bạn quên mật khẩu?"* (`L()`).
   - Tiêu đề `dialog_title_forgot_password` ("Quên mật khẩu"), nội dung `dialog_forgot_password_content`.
   - Nút **"Bắt đầu"** (`string_start`) → `E()` mở **AccountKit xác thực SĐT** (req 6); nút **"Đóng"** (`string_close`) → tắt.
2. **Dialog gợi ý khôi phục mật khẩu** — mở khi sai mật khẩu ≥ 3 lần (`f()`).
   - Nội dung `message_recommend_recovery_password`. **Có** (`string_yes`) → dialog hướng dẫn `message_tip_to_recover_password` ("Soạn RESET nickOla gửi 8031…") + nút **Đóng**. **Không** → tắt.
3. **Dialog xoá account đã lưu** — mở khi bấm nút × trên avatar account (`a(account)`).
   - Nội dung `message_delete_me_account_format` (kèm `@<nick>`). **Xoá** (`string_delete`) → gỡ account khỏi máy, dọn ô nhập nếu đang là account đó, cập nhật gallery (nếu hết account → ẩn gallery, hiện lại logo). **Không** → tắt.
4. **Dialog "không có tài khoản gắn SĐT"** — sau AccountKit khôi phục (callback `H()`), nếu SĐT chưa gắn account nào.
   - Nội dung `message_fail_no_account_linked_to_phone`. **Có** → mở [màn Đăng ký](../dang-ky/README.md) `OlaSignUpActivity` với SĐT đó. **Không** → tắt.
5. **Dialog khôi phục thất bại** — callback `c_()`: nội dung `message_fail_recover_password`, nút **Hỗ trợ** (gọi hotline) / **Đóng** (→ `finish()`).
6. **Dialog gọi hỗ trợ `K()`:** nếu máy gọi được → quay số `1900588883`; nếu không → dialog thông báo `message_tip_to_call_cse`.

### 4.5. Đăng nhập / Đăng ký qua Facebook & AccountKit

- **"Đăng ký bằng Facebook"** (`btnLoginFacebook`): nếu chưa có `AccessToken` hoặc hết hạn → mở `OlaFacebookActivity` đăng nhập FB; có token rồi → `b.a(token, F)` liên kết tài khoản Ola. Callback `F`:
  - Liên kết lỗi → dialog `message_login_by_facebook_account_error`.
  - 1 account → đăng nhập account đó; **nhiều** account → mở `OlaSignUpByFacebookActivity` chọn; đăng nhập xong `b(str,…)` → lưu account + vào [Trang chủ](../trang-chu/README.md).
- **AccountKit (xác thực SĐT của Facebook):** dùng `LoginType.PHONE`.
  - **req 4** (từ "Tạo tài khoản Ola"/nút xanh khi trống): có token → `OlaApplication.b.a(token, I())`; callback `I()`: có account → đăng nhập / mở `OlaRecoveredAccountListActivity` (nếu nhiều), không có → mở `OlaSignUpActivity`. Hủy/không token → mở thẳng `OlaSignUpActivity`.
  - **req 6** (từ "Quên mật khẩu"): có token → `OlaApplication.b.a(token, H())`; callback `H()` xử lý khôi phục như mục 4.4.
- **req 7 / req 1** (trả về từ `OlaRecoveredAccountListActivity` / `OlaSignUpActivity`): nhận `_username` + `_pass` → điền 2 ô và gọi `B()` đăng nhập.

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|--------------------------|------------------------------|
| `string_username` | Nick name | Tên đăng nhập |
| `string_password` | Password | Mật khẩu |
| `string_login` | Log In | Đăng nhập |
| `string_forgot_pass_tip` | Forgot password? | Bạn quên mật khẩu? |
| `string_register_account` | Sign up Ola | Tạo tài khoản Ola |
| `string_login_facebook_account` | Signup by Facebook | Đăng ký bằng Facebook |
| `string_version` | Version | Phiên bản |
| `string_require_captcha_dialog_title` | Type the captcha code | Nhập mã bảo vệ |
| `string_require_captcha_dialog_message` | Type the displayed content | Bạn vui lòng nhập lại nội dung trong hình vào ô bên cạnh |
| `string_wrong_captcha_dialog_message` | Wrong validation code… | Sai mã bảo vệ. Vui lòng nhập lại chính xác nội dung trong hình |
| `dialog_title_forgot_password` | Forgot password | Quên mật khẩu |
| `dialog_forgot_password_content` | Enter exactly the phone number… Touch START | Bạn nhập chính xác số điện thoại đã đăng ký… Bấm BẮT ĐẦU |
| `string_start` | Start | Bắt đầu |
| `string_close` | Close | Đóng |
| `message_recommend_recovery_password` | Invalid nick name or password. Do you want to recover your password? | Tên đăng nhập hoặc mật khẩu không đúng. Bạn có muốn Ola giúp bạn khôi phục lại mật khẩu không? |
| `message_tip_to_recover_password` | Compose RESET nickOla send to 8031. Or call %1$s… | Soạn tin RESET nickOla gởi 8031. Hoặc gọi %1$s để được hướng dẫn cụ thể |
| `message_delete_me_account_format` | Do you want to delete all saved data of account %1$s on device? | Bạn có muốn xoá toàn bộ thông tin lưu trữ của tài khoản %1$s trên thiết bị không? |
| `string_delete` / `string_no` / `string_yes` | Delete / No / Yes | Xoá / Không / Có |
| `message_fail_no_account_linked_to_phone` | No account linked to phone number %s… | Không tìm thấy tài khoản nào đang được đăng ký với số điện thoại %s… |
| `message_fail_recover_password` | Sorry, we do not able to reset your password… | Rất tiếc, chúng tôi không thể khôi phục lại được mật khẩu của bạn… |
| `message_invalid_username_format` | Invalid username format. Username only contains A-Z, 0-9, _ and . | Tên đăng nhập không hợp lệ. Tên đăng nhập chỉ được chứa các ký tự A-Z, 0-9, _ … |
| `message_connection_login_fail_password` | Invalid password | Sai mật khẩu |
| `message_connection_login_fail_usernameorpassword` | Invalid nick name or password | Sai tên đăng nhập hoặc sai mật khẩu |
| `message_connection_lost_network_title` | Cannot connect to Ola with Internet problem | Không thể kết nối Ola do lỗi đường truyền Internet |
| `message_process_timeout` | Request timeout. Please try again | Hết thời gian thực thi. Xin thử lại |
| `message_login_fail_with_error_code` | Login fail with error code | Đăng nhập không thành công. Mã lỗi |
| `message_tip_to_call_cse` | Dial to %1$s for instructions from Ola | Vui lòng gọi số %1$s để nhận được sự hướng dẫn tận tình từ Ola |
| `button_support` | Support | Hỗ trợ |
| `dialog_title_fail` / `dialog_title_inform` / `dialog_title_warning` | Error / Inform / Warning | Lỗi hệ thống / Thông báo / Chú ý |
| `string_select_account_to_login` | Select account to login | Chọn tài khoản để đăng nhập |
| `message_login_by_facebook_account_error` | (lỗi liên kết FB) | (lỗi liên kết Facebook) |

### 4.6. Đối chiếu bản web (`web/src/pages/login/LoginPage.tsx`)

Web đã dựng lại UI bám sát (nền `bg-ola-primary`, card trắng đổ bóng, logo 56px, nút submit, nhãn 9px version `15240093`). **Khác biệt** so với APK:

- **Đăng nhập bằng REST** (`AuthService.login`) thay vì socket; lỗi hiện inline + toast (không có dialog Hỗ trợ/hotline).
- **Chưa có**: gallery account đã lưu, đăng nhập **Facebook/AccountKit**, **captcha**, dialog gợi ý khôi phục/đếm số lần sai, nút xanh đổi nhãn "Tạo tài khoản Ola" khi trống.
- **"Quên mật khẩu"** → route riêng `forgot-password`; **"Tạo tài khoản Ola"** → route `register` (web tách trang, APK đi qua AccountKit trước).
- Có **`LanguageSwitcher`** hiện thường trực góc trên (APK chỉ hỏi ngôn ngữ 1 lần ở `onCreate`).
- Validate client: username `USERNAME_MIN=5..USERNAME_MAX` + `USERNAME_PATTERN`, password `PASSWORD_MIN..MAX` — tương ứng `C()` của APK.

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| `onCreate` — máy không có locale `vi` | `OlaLanguageChooser` (chọn ngôn ngữ) | (chưa có doc — cần làm) |
| Đăng nhập thành công / phiên còn hiệu lực | `OlaBottomTabActivity` (Trang chủ) | [../trang-chu/README.md](../trang-chu/README.md) |
| "Tạo tài khoản Ola" / nút xanh khi trống → AccountKit → không có account | `signup.OlaSignUpActivity` (Đăng ký) | [../dang-ky/README.md](../dang-ky/README.md) |
| "Đăng ký bằng Facebook" | `OlaFacebookActivity` (login Facebook SDK) | (chưa có doc — cần làm) |
| FB có nhiều account Ola | `signup.fb.OlaSignUpByFacebookActivity` | (chưa có doc — cần làm) |
| "Tạo tài khoản Ola" / "Quên mật khẩu" → SĐT có nhiều account | `OlaRecoveredAccountListActivity` (chọn tài khoản) | (chưa có doc — cần làm) |
| "Tạo tài khoản Ola" (req 4) / "Quên mật khẩu" (req 6) | `AccountKitActivity` (xác thực SĐT — thư viện Facebook) | (thư viện bên thứ 3) |
| Nút **Hỗ trợ** trong các dialog lỗi | Trình gọi điện hệ thống → `1900588883` | (hệ thống) |
