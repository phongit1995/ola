# Màn hình Tạo Clan

- **Activity:** `chat.ola.vn.activity.CreateClanActivity` — `jadx_out/sources/chat/ola/vn/activity/CreateClanActivity.java` (271 dòng)
- **Layout:** `apktool_out/res/layout/create_clan_input_layout.xml`
- **Chức năng:** nhập tên clan → **Kiểm tra** tên còn trống hay đã có chủ → nếu trống thì **Tạo Clan** (tốn phí); nếu đã có chủ thì hiện **preview thông tin clan** đó.
- **Mở từ:** nút **"Tạo Clan"** trên [Trang Clan](../trang-clan/README.md) khi clan chưa có chủ (`CreateClanActivity.a(context, clanId)` — tên clan được **điền sẵn** `#<tên>` vào ô nhập, `OlaClanMePageActivity.java:737`).

> Thuật ngữ trong app: **Clan = "bang hội"/phòng cộng đồng** có id dạng `#tên`. Bang chủ = Manager, Phó bang chủ = Assistant, Đại sứ = Supervisor.

## Ảnh chụp

> **Chưa có ảnh chụp màn này** (`fake-api/screenshots/` trống). Tài liệu dựng từ layout XML + code jadx.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_action_back` | ![back](../images/ic_action_back.png) | Nút back trên action bar |
| `ic_clan_role_leader` | ![leader](../images/ic_clan_role_leader.png) | Icon dòng **Bang chủ** trong preview |
| `ic_clan_role_vice_leader` | ![vice](../images/ic_clan_role_vice_leader.png) | Icon dòng **Phó bang chủ** trong preview |
| `ic_clan_role_supporter` | ![supporter](../images/ic_clan_role_supporter.png) | Icon dòng **Đại sứ** trong preview |
| `ic_clan_member` | ![member](../images/ic_clan_member.png) | Icon dòng **số thành viên** |
| `ic_clan_visit` | ![visit](../images/ic_clan_visit.png) | Icon dòng **lượt xem** |

> Asset dùng chung đặt ở [../images/](../images/).

---

## 1. Bố cục (top → bottom)

```
LinearLayout vertical
├─ Action bar `linearWrap` (nền #7CB342 + viền bóng đáy — bg_action_bar, cao 48dp)
│   ├─ Nút back `btnActionButtonLeft`   ImageView 48dp (ic_action_back)
│   └─ Tiêu đề "Tạo Clan"               TextView 16sp trắng, canh giữa (bù marginRight 48dp)
└─ ScrollView (padding 8dp, animateLayoutChanges)
   ├─ Hộp nhập (bg_conversation_blank_box: trắng bo 5dp viền #1F000000, padding 15+8dp)
   │   ├─ Ô "Nhập tên Clan"  EditText txtClanNameInput (16sp, viền 1dp #7CB342, padding 16dp)
   │   └─ Nút "Kiểm tra"     TextView btnClanValidate (14sp #4C4C4C, nền nút trắng bo 2dp)
   ├─ [Thông báo kết quả]    TextView txtClanValidateMessage — ẨN mặc định (gone)
   │                          12sp bold+italic; ĐỎ khi tên đã có chủ / XANH DƯƠNG khi hợp lệ
   ├─ [Nút "Tạo Clan"]       Button btnCreateClan (14sp trắng, nền xanh #9CCC65, margin T 16dp)
   │                          — có trong XML nhưng bị logic ẨN cho tới khi tên được xác nhận trống
   └─ [Preview clan đã tồn tại]  LinearLayout linearClanWrapper — ẨN mặc định (code ẩn ở onCreate)
       ├─ #<tên clan>        TextView txtClanName (bold, canh giữa, nền nút trong suốt — bấm được về mặt style nhưng KHÔNG gắn listener)
       ├─ 👑 <bang chủ>      TextView txtClanAdmin (12sp #636363, icon ic_clan_role_leader)
       ├─ 🛡 <phó bang chủ>   TextView txtClanSupporter (12sp #636363, icon ic_clan_role_vice_leader)
       ├─ 🎖 <đại sứ>         TextView txtClanMessenger (12sp #636363, icon ic_clan_role_supporter)
       ├─ 👥 <n> Thành viên   TextView txtClanNumOfMem (12sp #636363, icon ic_clan_member)
       └─ 👁 <n> Lượt xem     TextView txtClanVisitCount (12sp #636363, icon ic_clan_visit)
```

> Lưu ý đặt tên id hơi "lệch" so với vai trò: `txtClanAdmin` = **Bang chủ**, `txtClanSupporter` = **Phó bang chủ** (icon vice_leader), `txtClanMessenger` = **Đại sứ** (icon supporter). Đây là mapping thật từ code `a(bVar.a, bVar.b, bVar.c, bVar.d, …)` (`CreateClanActivity.java:65-73` — entity `b`: `b`=leader, `c`=assistant, `d`=supervisor).

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện ẩn/hiện) |
|------------|----|----|--------|--------------------------|---------|
| Action bar | `linearWrap` | nền `#7CB342` (`colorOlaPrimary`) + 6 lớp bóng đáy (`bg_action_bar`) | — | cao 48dp, padding ngang 8dp, đáy 6dp | luôn hiện |
| Nút back | `btnActionButtonLeft` | icon trắng | — | 48dp × full | `ic_action_back`; style `?actionBar.button` (padding 8dp, minWidth 48dp) |
| Tiêu đề | — | chữ `#FFFFFF` (`colorTextWhitePrimary`) | 16sp (`?actionBar.title` → `text.size.subhead`) | weight 1, marginRight 48dp, canh giữa | text `string_create_clan` |
| Hộp nhập | — | nền trắng, viền 1dp `#1F000000`, bo 5dp | — | padding trong 15dp (drawable) + 8dp | `bg_conversation_blank_box` |
| Ô tên clan | `txtClanNameInput` | chữ `#DE000000`, viền 1dp `#7CB342` (`bg_edit_text_border`) | 16sp (`defaultStyle.edittext`) | weight 1, padding 16dp, marginRight 4dp | hint `general_hint_clan` ("Nhập tên Clan"), `inputType=textEmailAddress`, `imeOptions=actionDone`, 1 dòng |
| Nút Kiểm tra | `btnClanValidate` | chữ `#4C4C4C`, nền nút trắng bo 2dp viền `#1F000000` (`btn_default_button_selector`) | 14sp (`defaultStyle.button.small` ← `text.medium`) | padding 4dp | text `string_validate` ("Kiểm tra") |
| Thông báo kết quả | `txtClanValidateMessage` | **đỏ `#FF0000`** khi tên đã có chủ / **xanh dương `#0000FF`** khi hợp lệ (set bằng code) | 12sp (`text.size.caption`), **bold + italic** | marginTop 8dp | **gone mặc định**; hiện sau khi bấm Kiểm tra (xem §4.2) |
| Nút Tạo Clan | `btnCreateClan` | chữ `#FFFFFF`, nền `#9CCC65` viền 1px `#558B2F` bo 2dp (`btn_green_button_selector`) | 14sp (`defaultStyle.button.green` → `text.size.body1`) | full ngang, marginTop 16dp | visible trong XML nhưng **bị ẩn ngay khi gõ chữ**; chỉ hiện khi server xác nhận **tên còn trống** |
| Khối preview | `linearClanWrapper` | nền trắng bo 5dp viền `#1F000000` | — | marginTop 16dp | **code ẩn ở onCreate** (`h.a()`, dòng 269); chỉ hiện khi tên **đã có chủ** |
| Tên clan (preview) | `txtClanName` | mặc định `#DE000000`, **bold**, nền `?commont.button.image` (ripple trong suốt) | 14sp (mặc định theme) | full ngang, canh giữa | text `#<tên>` |
| Bang chủ (preview) | `txtClanAdmin` | `#636363` (`?me.info.text` ← `defaultStyle.me.info`) | 12sp | marginTop 8dp, icon trái + drawablePadding 4dp (style cho 5dp — XML override 4dp) | **bấm được** → mở trang Me của nick (§4.3) |
| Phó bang chủ (preview) | `txtClanSupporter` | `#636363` | 12sp | marginTop 4dp, icon trái 4dp | bấm được → mở trang Me của nick |
| Đại sứ (preview) | `txtClanMessenger` | `#636363` | 12sp | marginTop 4dp, icon trái 4dp | bấm được → mở trang Me của nick |
| Số thành viên | `txtClanNumOfMem` | `#636363` | 12sp | marginTop 4dp, icon trái 4dp | text "`<n>` Thành viên" (`m.a(int)` format số) — KHÔNG có listener |
| Lượt xem | `txtClanVisitCount` | `#636363` | 12sp | marginTop 4dp, icon trái 4dp | text "`<n>` Lượt xem" — KHÔNG có listener |

## 3. CSS tương đương (dựng lại trên web)

```css
.create-clan {
  min-height: 100vh;
  background: #fff;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
}
.create-clan__appbar {
  height: 48px;
  background: #7CB342;                 /* colorOlaPrimary */
  box-shadow: 0 1px 0 rgba(0,0,0,.07); /* mô phỏng 6 lớp bóng bg_action_bar */
  display: flex; align-items: center;
  padding: 0 8px 6px;
  color: #fff;
}
.create-clan__back { width: 48px; height: 100%; padding: 8px; box-sizing: border-box; }
.create-clan__title { flex: 1; text-align: center; font-size: 16px; margin-right: 48px; }

.create-clan__body { padding: 8px; }

/* Hộp nhập */
.create-clan__inputbox {
  display: flex; align-items: center; gap: 4px;
  background: #fff;
  border: 1px solid rgba(0,0,0,.12);   /* colorTextBlackDivider */
  border-radius: 5px;
  padding: 23px;                        /* 15dp (drawable) + 8dp (layout) */
}
.create-clan__inputbox input {
  flex: 1;
  font-size: 16px; color: rgba(0,0,0,.87);
  border: 1px solid #7CB342;            /* bg_edit_text_border */
  background: transparent;
  padding: 16px;
}
.create-clan__validate {
  font-size: 14px; color: #4C4C4C;
  background: #fff;
  border: 1px solid rgba(0,0,0,.12);
  border-radius: 2px;
  padding: 4px; cursor: pointer;
}

/* Thông báo kết quả — ẩn mặc định */
.create-clan__msg {
  display: none;
  margin-top: 8px;
  font-size: 12px; font-weight: 700; font-style: italic;
}
.create-clan__msg--exist    { display: block; color: #F00; }
.create-clan__msg--available{ display: block; color: #00F; }

/* Nút Tạo Clan — chỉ hiện khi tên đã xác nhận trống */
.create-clan__submit {
  display: none;
  width: 100%; margin-top: 16px;
  font-size: 14px; color: #fff;
  background: #9CCC65;                 /* buttonGreen */
  border: 1px solid #558B2F;           /* colorOlaPrimaryDark */
  border-radius: 2px;
  padding: 12px; cursor: pointer;
}

/* Preview clan đã có chủ — ẩn mặc định */
.create-clan__preview {
  display: none;
  margin-top: 16px;
  background: #fff;
  border: 1px solid rgba(0,0,0,.12);
  border-radius: 5px;
  padding: 15px;
}
.create-clan__preview-name { font-weight: 700; text-align: center; font-size: 14px; color: rgba(0,0,0,.87); }
.create-clan__preview-row {
  display: flex; align-items: center; gap: 4px;
  margin-top: 4px;
  font-size: 12px; color: #636363;      /* defaultStyle.me.info */
}
.create-clan__preview-row img { width: 17px; height: 15px; }  /* icon 51×46 gốc thu nhỏ */
.create-clan__preview-row--clickable { cursor: pointer; }
```

```html
<div class="create-clan">
  <div class="create-clan__appbar">
    <img class="create-clan__back" src="../images/ic_action_back.png">
    <div class="create-clan__title">Tạo Clan</div>
  </div>
  <div class="create-clan__body">
    <div class="create-clan__inputbox">
      <input type="text" placeholder="Nhập tên Clan">
      <button class="create-clan__validate">Kiểm tra</button>
    </div>
    <div class="create-clan__msg create-clan__msg--exist">Clan #teamviet hiện đang có người sở hữu. Hãy chọn tên khác</div>
    <button class="create-clan__submit">Tạo Clan</button>
    <div class="create-clan__preview">
      <div class="create-clan__preview-name">#teamviet</div>
      <div class="create-clan__preview-row create-clan__preview-row--clickable"><img src="../images/ic_clan_role_leader.png"> bangchu01</div>
      <div class="create-clan__preview-row create-clan__preview-row--clickable"><img src="../images/ic_clan_role_vice_leader.png"> phobang02</div>
      <div class="create-clan__preview-row create-clan__preview-row--clickable"><img src="../images/ic_clan_role_supporter.png"> daisu03</div>
      <div class="create-clan__preview-row"><img src="../images/ic_clan_member.png"> 1.234 Thành viên</div>
      <div class="create-clan__preview-row"><img src="../images/ic_clan_visit.png"> 5.678 Lượt xem</div>
    </div>
  </div>
</div>
```

## 4. Hành vi & luồng

### 4.1. Khởi tạo màn (`onCreate`, dòng 217-270)

- Đọc Intent extra `"clanId"` — nếu có thì **điền sẵn** `#<clanId>` vào ô nhập (dòng 223-226; luồng đến từ nút "Tạo Clan" của [Trang Clan](../trang-clan/README.md)).
- Trạng thái đầu: `txtClanValidateMessage` **ẩn** (dòng 264), preview **ẩn** (`h.a()`, dòng 269), `btnCreateClan` **hiện** (theo XML — nhưng sẽ ẩn ngay khi user gõ, xem TextWatcher dưới).
- **TextWatcher trên ô nhập** (dòng 239-261): mỗi lần text đổi —
  - text **khác** tên đã kiểm tra lần trước (`i`) → **ẩn preview + ẩn nút Tạo Clan + ẩn thông báo** (phải Kiểm tra lại).
  - text **trùng** tên đã kiểm tra và tên đó **đã có chủ** → hiện lại preview + thông báo đỏ, giữ nút Tạo Clan ẩn.

### 4.2. Luồng Kiểm tra tên → Tạo clan

```
[Nhập tên] → bấm "Kiểm tra" (hoặc Enter/Done) → B()
  ├─ C(): tên trống → rung ô nhập (anim shake) + toast "Nhập tên Clan" → DỪNG
  └─ hợp lệ → hiện dialog loading "Kiểm tra tên Clan" (timeout 15s)
              → gửi socket OlaNetworkService.f(tên, mã lệnh 46)
       ├─ Server trả entity clan (callback a(b, 46), dòng 140-158)  = TÊN ĐÃ CÓ CHỦ
       │    → ẩn nút Tạo Clan; thông báo ĐỎ "Clan #x hiện đang có người sở hữu. Hãy chọn tên khác"
       │    → hiện preview (tên, bang chủ, phó bang, đại sứ, số thành viên, lượt xem)
       │    → bàn phím mở lại + select-all ô nhập để sửa tên
       └─ Server trả string (callback a(str, 46), dòng 160-176)     = TÊN CÒN TRỐNG
            → lưu j = str (chuỗi chi phí server trả); ẩn preview
            → thông báo XANH DƯƠNG "Tên clan hợp lệ. Bạn có thể tạo clan này"
            → HIỆN nút "Tạo Clan"

[Bấm "Tạo Clan"] → C() lại → f(tên): mở modal xác nhận (xem §4.4)
  └─ đồng ý → gửi socket o(tên đã bỏ "#", mã lệnh 47)
             → toast "Đã gửi yêu cầu tạo Clan \"#x\"" + refresh dữ liệu (b.r()) + ĐÓNG màn
```

- Mã lệnh socket: **46** = kiểm tra tên clan, **47** = tạo clan (builder trong `network/OlaNetworkService.java:1751, 2069`; giao thức text `@113 …` — xem [../../api/socket-protocol.md](../../api/socket-protocol.md)).

### 4.3. Bảng tương tác (mọi cử chỉ)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| Nút back `btnActionButtonLeft` | click | `finish()` — đóng màn (trượt phải) | nội bộ |
| Ô tên `txtClanNameInput` | Enter / IME Done | `B()` = Kiểm tra tên | nội bộ |
| Ô tên `txtClanNameInput` | gõ chữ (TextWatcher) | ẩn/hiện lại preview + nút Tạo theo §4.1 | nội bộ |
| Nút "Kiểm tra" `btnClanValidate` | click | `B()` = Kiểm tra tên (loading 15s) | nội bộ |
| Nút "Tạo Clan" `btnCreateClan` | click | mở **modal xác nhận tạo clan** (§4.4) | modal trong màn |
| Nick bang chủ `txtClanAdmin` | click | mở trang Me của nick đó (`me.c.a(...)`) rồi **đóng màn này** | sang màn khác |
| Nick phó bang `txtClanSupporter` | click | như trên | sang màn khác |
| Nick đại sứ `txtClanMessenger` | click | như trên | sang màn khác |
| Dòng thành viên / lượt xem | click | (không có listener — không làm gì) | — |
| Phím Back | onBackPressed | `finish()` — trượt phải (`push_right_in/out`) | nội bộ |

> **Không có long-press** ở bất kỳ thành phần nào trong màn này (đã rà toàn bộ listener trong Activity).

### 4.4. Modal/Dialog mở trong màn (chi tiết)

1. **Dialog loading "Kiểm tra tên Clan"** — mở khi bấm Kiểm tra (`chat.ola.vn.i.c`, dòng 84-90).
   - Nội dung `message_clan_validate` ("Kiểm tra tên Clan") + spinner; tự đóng sau **15s** hoặc khi server trả lời.
2. **Modal xác nhận tạo clan** (`i.b(...)`, dòng 118-133) — mở khi bấm "Tạo Clan".
   - Tiêu đề: `string_create_clan` ("Tạo Clan"). Nội dung: `message_create_clan_confirm_format` — "Bạn sẽ tốn **%1$s** để tạo Clan" (`%1$s` = chuỗi **chi phí** server trả về ở bước kiểm tra tên).
   - Nút **"Tạo"** (`string_create`) → gửi lệnh 47 + toast `message_create_clan_request_sent_format` + `finish()`.
   - Nút **"Huỷ"** (`string_cancel`) → đóng modal, ở lại màn.

### 4.5. Đối chiếu web (`web/src/pages/`)

**Web hiện CHƯA có tính năng Clan** — không có trang tạo clan tương ứng trong `web/src/pages/`. Tài liệu này là nguồn để dựng mới khi cần.

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|--------------------------|------------------------------|
| `string_create_clan` | Create Clan | Tạo Clan |
| `general_hint_clan` | Enter Clan name | Nhập tên Clan |
| `string_validate` | Validate | Kiểm tra |
| `message_input_clan_name` | Enter Clan name | Nhập tên Clan |
| `message_clan_validate` | Check Clan name | Kiểm tra tên Clan |
| `message_clan_exist_format` | Clan %1$s is not available. Please choose another | Clan %1$s hiện đang có người sở hữu. Hãy chọn tên khác |
| `message_clan_available_format` | Clan is available. You can use this | Tên clan hợp lệ. Bạn có thể tạo clan này |
| `message_create_clan_confirm_format` | You will pay %1$s to create Clan | Bạn sẽ tốn %1$s để tạo Clan |
| `message_create_clan_request_sent_format` | Sending request to create Clan %1$s | Đã gửi yêu cầu tạo Clan %1$s |
| `message_create_clan_waitting_format` | Creating Clan %1$s | Đang tạo Clan %1$s |
| `message_create_clan_success_format` | Create Clan %1$s OK | Tạo Clan %1$s thành công |
| `message_can_not_create_clan` | Cannot create Clan | Không thể tạo Clan |
| `string_create` | Create | Tạo |
| `string_cancel` | Cancel | Huỷ |
| `string_members` | Members | Thành viên |
| `string_visit_count` | Visits | Lượt xem |
| `string_member` | Member | Thành viên |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| Click nick bang chủ / phó bang / đại sứ trong preview | `me.OlaUserMePageActivity` (Trang cá nhân) | [../trang-ca-nhan/README.md](../trang-ca-nhan/README.md) |
| Tạo clan thành công / back | quay về màn trước (thường là [Trang Clan](../trang-clan/README.md)) | [../trang-clan/README.md](../trang-clan/README.md) |
