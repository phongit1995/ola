# Màn hình Box - Kết Hôn (Marriage)

- **Activity chính:** `chat.ola.vn.activity.MarriageRequestComposerActivity` (màn soạn lời cầu hôn)
- **Layout:** `apktool_out/res/layout/marriage_request_composer_layout.xml`
- **Controller liên quan (dialog/menu trong màn khác):**
  - `chat.ola.vn.me.c` — fragment màn **Me**, mục drawer "Box - Kết Hôn" (gating theo trạng thái kết hôn)
  - `chat.ola.vn.me.OlaMeComposerActivity` — soạn bài, có loại bài **"Box - Kết Hôn"** (post type 11)
  - `chat.ola.vn.activity.OlaUserProfileActivity` — trang cá nhân người khác: nút **Gửi lời cầu hôn** + **Hủy kết hôn**
  - `chat.ola.vn.m.k` — màn **Thông báo**: nút **Đồng ý / Từ chối** lời cầu hôn
- **Chức năng:** Hệ thống "kết hôn ảo" giữa 2 nick Ola. Cho phép gửi/chấp nhận/từ chối lời cầu hôn, hủy kết hôn, và mở "Box - Kết Hôn" (nhật ký hôn nhân chung) — chỉ dùng được khi đã có trạng thái Kết Hôn.

## Trạng thái kết hôn (dữ liệu nền)

- `h.O.e` = **nick vợ/chồng** của user hiện tại.
  - Rỗng (`m.a(h.O.e)`) → **CHƯA kết hôn**.
  - Có giá trị → **ĐÃ kết hôn** với nick đó.
- `system_me_box_with` = `"Kết Hôn %1$s"` → nhãn hiển thị trạng thái (vd "Kết Hôn @abc").
- Item "Box - Kết Hôn" trong feed/menu Me là một `af` có `b()` == `"mariage diary"` (tạo ở `network/e.java`: `new af(system_me_box, "mariage diary")`).

## Ảnh chụp

> Chưa có ảnh chụp màn thật trong repo. Mô tả dưới đây dựng từ layout XML + jadx.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_indicate_box.png` (trái tim đặc xám) | ![box](images/ic_indicate_box.png) | Icon mục **"Box - Kết Hôn"** trong drawer Me |
| `border_heart_avatar.png` (khung viền trái tim) | ![heart](images/border_heart_avatar.png) ![heart1](images/border_heart_avatar-1.png) | Khung tim ôm avatar cặp đôi (12 biến thể màu `border_heart_avatar-1..11`) |
| `ic_notification_heart.png` (tim đỏ) | ![nheart](images/ic_notification_heart.png) | Icon thông báo **cầu hôn** (loại `proposal`) |
| `ic_notification_broken_heart.png` (tim vỡ) | ![broken](images/ic_notification_broken_heart.png) | Icon thông báo **ly hôn** (loại `divorce`) |
| `ic_marriage.png` (bản tối, rất nhỏ) | ![marriage](images/ic_marriage.png) | Icon "kết hôn" trong app gốc |
| `ic_profile_marriage.png` (tim xám) | ![pmarriage](images/ic_profile_marriage.png) | `drawableLeft` của dòng trạng thái kết hôn ở header trang cá nhân (`txtMeUserMarriesStatus`, layout `ola_user_me_page_header_layout.xml`) |
| `sticker_kiss.png` (nụ hôn) | ![kiss](images/sticker_kiss.png) | Hiệu ứng "nụ hôn bay" trong Activity nền `c.java` (hiệu ứng chung) |
| `ic_action_back` | — | Nút back trên action bar composer |
| `ic_action_send` | — | Nút gửi (góc phải action bar composer) |
| `ola_logo_trans` | — | Logo Ola cạnh nút back |
| `kul01` (`imgKulView`) | — | Sticker "kul" đính kèm lời cầu hôn (ẩn mặc định) |

---

## 1. Bố cục — màn soạn lời cầu hôn (top → bottom)

`marriage_request_composer_layout.xml` — root `LinearLayout` dọc, nền `#d6d6d6` (xám nhạt).

```
LinearLayout (vertical, bg #d6d6d6, match_parent)
├─ Action bar  (LinearLayout ngang, style defaultStyle.actionBar.background)
│  ├─ btnActionButtonLeft (LinearLayout, bấm = back + xác nhận hủy nháp)
│  │   ├─ ImageView  ic_action_back   (marginLeft 4dp, marginV 16dp)
│  │   └─ ImageView  ola_logo_trans   (marginLeft 4dp, marginV 8dp)
│  ├─ txtActionTitle (AutoScrollTextView, weight=1, style ?actionBar.title)
│  │      text = string_send_marry_request = "Gửi lời cầu hôn"
│  └─ btnActionButtonRight (ImageView 48dp, ic_action_send, style ?actionBar.button)
│
└─ ScrollView (weight=1, fillViewport, scrollbars=none)
   └─ LinearLayout (vertical, padding 8dp)
      ├─ receiverId  (OlaQuickTypingSuggestedText, match_parent, margin 4/8/4/8dp)
      │     hint = message_receiver_id_not_null = "Nhập nick người nhận"
      │     maxLines=1, imeOptions=actionNext, autocomplete nick bạn bè (dropdown)
      │     style defaultStyle.edittext.username
      └─ LinearLayout (ngang, bg bg_shadow_4_edges, padding 4dp)   ← khung viền đổ bóng
         ├─ imgKulView (ImageView, size general.icon.kul.message.size)
         │     src kul01, VISIBILITY=GONE mặc định  → chỉ hiện khi có đính kèm sticker kul
         └─ txtEditMe (OlaTypingSuggestedText, weight=1, bg bg_edit_text_border)
               hint = message_marriage_request_message_not_null = "Nhập thông điệp cầu hôn"
               minLines=5, inputType=textCapSentences|textMultiLine|textNoSuggestions
               style defaultStyle.text.body1
```

**Component ẩn/điều kiện:**
- `imgKulView`: `visibility=gone` mặc định; `B()` set VISIBLE khi `h != 0` (có sticker kul đính kèm) và set ảnh qua `chat.ola.vn.util.c.a(h)`. Bấm vào nó → gỡ sticker (`h=0`, ẩn lại).

## 2. Bảng style (composer)

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú |
|---|---|---|---|---|---|
| Root | linearEditWrapper | nền `#d6d6d6` | — | match_parent | |
| Action bar | linearWrap | `defaultStyle.actionBar.background` | theo style `?actionBar.title` | cao theo action bar | |
| Tiêu đề | txtActionTitle | theo `?actionBar.title` | theo style | weight=1, marginH 8dp | text "Gửi lời cầu hôn", chạy chữ (AutoScroll) |
| Nút back | btnActionButtonLeft | — | — | marginV 8–16dp | back + ola_logo |
| Nút gửi | btnActionButtonRight | `?actionBar.button` | — | 48dp | `ic_action_send` |
| Ô nhập nick | receiverId | `defaultStyle.edittext.username` | theo style | margin 4/8dp | hint "Nhập nick người nhận", có gợi ý nick |
| Khung lời nhắn | (LinearLayout) | nền `bg_shadow_4_edges` | — | padding 4dp | đổ bóng 4 cạnh |
| Ô lời cầu hôn | txtEditMe | nền `bg_edit_text_border`, `defaultStyle.text.body1` | body1 | minLines=5 | hint "Nhập thông điệp cầu hôn" |
| Sticker kul | imgKulView | nền `btn_transparent_image_selector` | — | `general.icon.kul.message.size` | ẩn mặc định |

## 3. CSS tương đương (dựng lại trên web)

```html
<div class="marriage-composer">
  <header class="ola-actionbar">
    <button class="back"><img src="ic_action_back"/> <img src="ola_logo"/></button>
    <h1 class="title">Gửi lời cầu hôn</h1>
    <button class="send"><img src="ic_action_send"/></button>
  </header>
  <div class="body">
    <input class="receiver" placeholder="Nhập nick người nhận" />
    <div class="message-box">
      <img class="kul" hidden />
      <textarea class="message" rows="5" placeholder="Nhập thông điệp cầu hôn"></textarea>
    </div>
  </div>
</div>
```
```css
.marriage-composer{display:flex;flex-direction:column;height:100%;background:#d6d6d6}
.ola-actionbar{display:flex;align-items:center;gap:8px;background:#5e3c20;color:#fff;padding:8px}
.title{flex:1;font-weight:600}
.body{padding:8px;display:flex;flex-direction:column;gap:8px}
.receiver{padding:8px;border-radius:6px;background:#fff}
.message-box{display:flex;background:#fff;border-radius:6px;padding:4px;box-shadow:0 1px 4px rgba(0,0,0,.2)}
.message{flex:1;border:1px solid #ddd;min-height:120px;resize:none}
```

## 4. Hành vi & luồng

### 4.1 Composer (MarriageRequestComposerActivity)

| Thành phần | Cử chỉ | Hành vi | Loại |
|---|---|---|---|
| Nút back (trái) | click | `o.a(...)` ẩn bàn phím → `finish()` | đóng màn |
| Back cứng (onBackPressed) | back | `E()`: nếu ô lời nhắn **có chữ** → dialog xác nhận hủy nháp (`confirm_discard_draft_content`, Có/Không); rỗng → thoát luôn | modal |
| Nút gửi (phải) | click | `D()` gửi lời cầu hôn | gọi API |
| imgKulView | click | gỡ sticker kul đính kèm (`h=0`, ẩn) | toggle |
| receiverId | nhập | gợi ý nick bạn bè (dropdown autocomplete) | — |

**`D()` — gửi lời cầu hôn:**
1. Trim nick người nhận; rỗng → toast `message_receiver_id_not_null` ("Nhập nick người nhận"), dừng.
2. Trim lời cầu hôn; rỗng → toast `message_marriage_request_message_not_null` ("Nhập thông điệp cầu hôn"), dừng.
3. Gọi `OlaApplication.b.b(nick, message, kul, null, callback)` — response code `(short)66`. Lỗi từ server → dialog `dialog_title_inform` + nội dung lỗi.
4. Toast `message_mariage_request_sent` = "Đã gởi lời cầu hôn đến @{nick}" → `finish()`.

**Vào màn:** `MarriageRequestComposerActivity.a(context)` hoặc `a(context, buddyId)`. Nếu truyền `buddyId` → điền sẵn ô nick người nhận.

### 4.2 Mục "Box - Kết Hôn" ở màn Me (`me/c.java`, `onItemClick`, list `u`)

Khi chạm item có `b()=="mariage diary"`:
- **CHƯA kết hôn** (`m.a(h.O.e)`): mở dialog
  - tiêu đề `dialog_title_inform` ("Thông báo")
  - nội dung `message_cannot_open_box_because_not_married` = "Tính năng chỉ dành cho người có trạng thái Kết Hôn trên Ola"
  - nút (+) `string_get_married` ("Kết Hôn") → `MarriageRequestComposerActivity.a()` (mở composer cầu hôn)
  - nút (−) `string_close` ("Đóng")
- **ĐÃ kết hôn**: `f("mariage diary")` → mở nội dung **Box - Kết Hôn** (nhật ký hôn nhân chung).

### 4.3 Soạn bài "Box - Kết Hôn" (`OlaMeComposerActivity.P()`)

Menu chọn quyền riêng tư/loại bài. Khi `E == 0` (đủ điều kiện) bổ sung 2 mục:
- `string_diary` = "Nhật ký (Bí mật)" → post type `N=10`
- `string_box` = "Box - Kết Hôn" → post type **`N=11`**

Đăng Box xong → toast `message_post_box_background_success1` ("Đã lưu Box Kết Hôn!") + `..._success2` ("Bấm vào để xem Box Kết Hôn bạn vừa viết"). Nhãn nút soạn: `general_tab_box_edit` = "Viết Box - Kết Hôn".

### 4.4 Từ trang cá nhân người khác (`OlaUserProfileActivity`)

| Cử chỉ | Hành vi |
|---|---|
| Chọn "Gửi lời cầu hôn" | line 413: `MarriageRequestComposerActivity.a(this)` (điền sẵn nick người đó) |
| Chọn "Hủy kết hôn" | `f(nick)` → dialog `dialog_title_confirm` ("Xác nhận") + `message_divorce_confirmation` ("Bạn có muốn HỦY kết hôn với @{nick} không?"), Có/Không. Có → `OlaApplication.b.v()` (API ly hôn), xoá spouse (`l.e=null`), refresh |

### 4.5 Nhận lời cầu hôn — màn Thông báo (`m/k.java`, layout `ola_notification_layout`)

Mỗi thông báo cầu hôn có 2 nút (`notificationButton1` / `notificationButton2`):
- **Đồng ý** (button1, khi `jVar.f != "3"`): dialog tiêu đề `string_box` ("Box - Kết Hôn") + `message_accept_married_proposal` ("Bạn có đồng ý kết hôn với @{nick}?") + nút `string_agree` ("Đồng ý") / `string_no` ("Không"). Đồng ý → `OlaApplication.b.C(nick)` (chấp nhận) + xoá thông báo.
- **Từ chối** (button2): dialog `string_box` + `message_deny_married_proposal` ("Bạn muốn từ chối lời cầu hôn của @{nick}?") + nút `string_deny` ("Từ chối") / `string_no`. Từ chối → `OlaApplication.b.D(nick)` (từ chối) + xoá thông báo.

### Modal/Dialog trong cụm Kết Hôn

| Dialog | Mở khi | Tiêu đề | Nội dung | Nút (+) | Nút (−) |
|---|---|---|---|---|---|
| Gating Box | chạm Box mà chưa cưới | Thông báo | "Tính năng chỉ dành cho người có trạng thái Kết Hôn trên Ola" | Kết Hôn → composer | Đóng |
| Hủy nháp | back khi đang soạn có chữ | Thông báo | `confirm_discard_draft_content` | Có → thoát | Không |
| Chấp nhận | bấm "Đồng ý" ở thông báo | Box - Kết Hôn | "Bạn có đồng ý kết hôn với @X?" | Đồng ý → accept | Không |
| Từ chối | bấm "Từ chối" ở thông báo | Box - Kết Hôn | "Bạn muốn từ chối lời cầu hôn của @X?" | Từ chối → deny | Không |
| Ly hôn | "Hủy kết hôn" ở profile | Xác nhận | "Bạn có muốn HỦY kết hôn với @X không?" | Có → divorce | Không |

### Luồng API (đối chiếu `OlaApplication.b`)

| Hành động | Lời gọi | Ghi chú |
|---|---|---|
| Gửi cầu hôn | `b(nick, msg, kul, null, cb)` | response code 66 |
| Chấp nhận | `C(nick)` | + xoá notif `d(new String[]{id})` |
| Từ chối | `D(nick)` | + xoá notif |
| Hủy kết hôn | `v()` | xoá spouse local |
| Đăng Box | post type `N=11` | qua OlaMeComposerActivity |

## 5. Strings (đa ngôn ngữ)

| Resource | EN | VI |
|---|---|---|
| `string_box` | Box - Marriage | Box - Kết Hôn |
| `string_get_married` | Married | Kết Hôn |
| `string_marry_with` | Married to | Kết hôn với |
| `string_send_marry_request` | Send marriage proposal | Gửi lời cầu hôn |
| `string_divorce` | Divorce | Hủy Kết Hôn |
| `string_diary` | Diary (Secret) | Nhật ký (Bí mật) |
| `string_box_to_your_marriage_diary` | Box - To your marriage diary | Box - Vào nhật ký hôn nhân |
| `general_tab_box_edit` | Box - Marriage | Viết Box - Kết Hôn |
| `system_me_box` | Box - Marriage | Box - Kết Hôn |
| `system_me_box_with` | — | Kết Hôn %1$s |
| `message_receiver_id_not_null` | Receiver nick name | Nhập nick người nhận |
| `message_marriage_request_message_not_null` | Proposal message | Nhập thông điệp cầu hôn |
| `message_mariage_request_sent` | Marriage proposal sent to %1$s | Đã gởi lời cầu hôn đến %1$s |
| `message_accept_married_proposal` | Do you agree to get married with @%1$s? | Bạn có đồng ký kết hôn với @%1$s? |
| `message_deny_married_proposal` | Do you want to reject marriage proposal from @%1$s? | Bạn muốn từ chối lời cầu hôn của @%1$s? |
| `message_divorce_confirmation` | Do you want to divorce %1$s? | Bạn có muốn HỦY kết hôn với %1$s không? |
| `message_cannot_open_box_because_not_married` | — | Tính năng chỉ dành cho người có trạng thái Kết Hôn trên Ola |
| `message_post_box_background_success1` | — | Đã lưu Box Kết Hôn! |
| `message_post_box_background_success2` | — | Bấm vào để xem Box Kết Hôn bạn vừa viết |
| `string_agree` / `string_deny` | Agree / Deny | Đồng ý / Từ chối |
| `string_close` / `string_yes` / `string_no` | Close / Yes / No | Đóng / Có / Không |
| `dialog_title_inform` / `dialog_title_confirm` | Inform / Confirmation | Thông báo / Xác nhận |

## 6. Đối chiếu web (`web/src/pages/me`)

- Mục drawer **"Box - Kết Hôn"** đã có sẵn ở [`MeLeftDrawer.tsx`](../../../../web/src/pages/me/components/MeLeftDrawer.tsx) (`key: 'marriage'`, icon `ic_indicate_box.png`, label `me.drawerMarriage` = "Box - Kết Hôn").
- **Nhưng chưa làm chức năng**: `MePanel.tsx` xử lý mọi mục drawer bằng `onSelect={() => toast.info(t('me.comingSoon'))}` → chỉ hiện "coming soon".
- i18n đã có sẵn: `me.marriageSingle` ("Độc thân"), `me.marriageMarried` ("Đã kết hôn"), `msg_proposal` ("muốn cầu hôn bạn"), `msg_divorce` ("đã từ chối lời cầu hôn của bạn") — nhưng chưa nối luồng.
- → Web cần dựng: (1) màn/sheet **soạn cầu hôn**, (2) **gating** Box theo trạng thái kết hôn, (3) dialog **chấp nhận/từ chối** ở thông báo, (4) dialog **hủy kết hôn** ở profile, (5) loại bài **Box - Kết Hôn**.

## 7. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích | Doc |
|---|---|---|
| Box (chưa cưới) → "Kết Hôn" | `MarriageRequestComposerActivity` | (màn này) |
| Profile người khác → "Gửi lời cầu hôn" | `MarriageRequestComposerActivity` | (màn này) |
| Box (đã cưới) | Nội dung Box/nhật ký hôn nhân (`f("mariage diary")`) | (chưa có doc — cần làm) |
| Soạn bài → "Box - Kết Hôn" | `OlaMeComposerActivity` (post type 11) | [ung-dung? / me composer] (chưa có doc — cần làm) |
