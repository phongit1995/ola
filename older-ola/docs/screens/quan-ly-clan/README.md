# Màn hình Quản lý Clan

- **Activity:** `chat.ola.vn.activity.ClanManagementActivity` — `jadx_out/sources/chat/ola/vn/activity/ClanManagementActivity.java` (375 dòng)
- **Layout:** `apktool_out/res/layout/clan_manager_layout.xml` (+ include `ola_top_action_bar_layout.xml`)
- **Chức năng:** màn quản trị dành cho **bang chủ**: bổ nhiệm/cách chức **Phó bang chủ** & **Đại sứ**, đổi **Chính sách** riêng tư của clan, **Chứng thực / Hủy chứng thực** thành viên.
- **Mở từ:** nút **"Quản lý Clan"** trên [Trang Clan](../trang-clan/README.md) — chỉ hiện khi bạn là bang chủ (`ClanManagementActivity.a(context, clan)`, `OlaClanMePageActivity.java:751`; object clan truyền qua **biến static `e`**).

## Ảnh chụp

> **Chưa có ảnh chụp màn này** (`fake-api/screenshots/` trống). Tài liệu dựng từ layout XML + code jadx.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_action_back` | ![back](../images/ic_action_back.png) | Nút back action bar |
| `ic_action_edit` | ![edit](../images/ic_action_edit.png) | Icon bút chì cuối 4 hàng (Manager/Assistant/Supervisor/Policy) |
| `ic_action_notification` | ![notif](../images/ic_action_notification.png) | Nút chuông action bar — **gone mặc định, màn này không bật** |
| `ic_more_white` | ![more](../images/ic_more_white.png) | Nút ⋯ action bar — **gone mặc định, màn này không bật** |
| `ic_clan_role_vice_leader` | ![vice](../images/ic_clan_role_vice_leader.png) | Icon tiêu đề **modal nhập nick Phó bang chủ** |
| `ic_clan_role_supporter` | ![supporter](../images/ic_clan_role_supporter.png) | Icon tiêu đề **modal nhập nick Đại sứ** |

> `ic_clan_policy` có khai báo trong APK nhưng là **PNG 1×1 trống** (placeholder) và không được layout/code nào dùng — không trích.

---

## 1. Bố cục (top → bottom)

```
FrameLayout (nền trắng #FFFFFF)
├─ ScrollView (marginTop 42dp — chừa action bar; marginBottom 48dp; padding 8dp)
│  └─ LinearLayout vertical, gravity=center_horizontal
│     ├─ Hàng "Bang chủ"     clanManagerViewLayout (margin T/B 8dp) — BẤM ĐƯỢC nhưng KHÔNG làm gì (không có case xử lý)
│     │   ├─ Nhãn "Bang chủ"       TextView 12sp #8A000000 (caption)
│     │   └─ [nick]                clanManagerTextView 14sp #DE000000, hint "Chưa có" (hint màu ĐỎ #E34545)
│     │       └─ ✏ icon bút        ImageView 20dp, nền tròn đen mờ #61000000 bo 4dp
│     ├─ ── divider 1px #1F000000 ──
│     ├─ Hàng "Phó bang chủ" clanAssistantViewLayout — bấm → modal nhập nick (§4.3.1)
│     │   └─ (cấu trúc y hệt: nhãn caption + nick body1 + icon bút)
│     ├─ ── divider ──
│     ├─ Hàng "Đại sứ"       clanSupervisorViewLayout — bấm → modal nhập nick (§4.3.2)
│     ├─ ── divider ──
│     ├─ Hàng "Chính sách"   clanPolicyViewLayout — bấm → modal chọn 1 trong 5 chính sách (§4.3.3)
│     │   └─ clanPolicyTextView (14sp, KHÔNG có hint đỏ)
│     └─ Hàng 2 nút          verificationTableRow (marginTop 16dp)
│         ├─ "Chứng thực thành viên"  Button verifyMemberButton (12sp #808080, nút trắng bo 2dp)
│         └─ "Hủy chứng thực thành viên" Button unverifyMemberButton (như trên, cách nhau 8dp)
└─ Action bar (include ola_top_action_bar_layout, ĐÈ LÊN TRÊN — nền #7CB342 cao 48dp)
   ├─ Nút back olaActionBarBackViewLayout (ic_action_back + badge unread — badge gone)
   ├─ Tiêu đề olaActionBarTitleTextView = "#<tên clan>" (14sp bold trắng)
   │   └─ [phụ đề] olaActionBarSubTitleTextView — gone (không dùng)
   └─ [nút chữ / chuông / ⋯] — cả 3 gone mặc định, màn này không bật
```

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện ẩn/hiện) |
|------------|----|----|--------|--------------------------|---------|
| Nền màn | — | trắng `#FFFFFF` | — | full màn | — |
| Action bar | `olaTopActionBarViewLayout` | nền `#7CB342` + bóng đáy (`bg_action_bar`) | — | cao 48dp, đè lên ScrollView (Frame overlay) | luôn hiện |
| Tiêu đề action bar | `olaActionBarTitleTextView` | chữ `#FFFFFF`, **bold** | 14sp (`defaultStyle.text.button`) | marginLeft 8dp, weight 1 | code set `"#"+clan` hoặc "Quản lý Clan" nếu thiếu tên (`L()`, dòng 72-76) |
| Phụ đề action bar | `olaActionBarSubTitleTextView` | `#B3FFFFFF` | 12sp | — | **gone mặc định — màn này không bật** |
| Nút chữ/chuông/⋯ action bar | `olaActionBarButtonTextView/ButtonImageView/MoreButtonImageView` | — | — | 48dp | **cả 3 gone mặc định — màn này không bật** |
| Badge unread trên nút back | `olaActionBarBackNotificationTextView` | chữ trắng 12sp bold, nền đỏ (`bg_uread_notify`) | 12sp | góc phải-trên nút back | **gone mặc định** |
| Nhãn 4 hàng | — | `#8A000000` (`defaultStyle.text.caption`) | 12sp | — | text: `string_clan_manager` / `string_clan_assistant` / `string_clan_supervisor` / `string_policy` |
| Nick bang chủ | `clanManagerTextView` | chữ `#DE000000` (`text.body1`), **hint đỏ `#E34545`** | 14sp | padding 2dp, marginTop 4dp, weight 1, 1 dòng | hint `string_unavaliable` ("Chưa có") khi trống |
| Nick phó bang | `clanAssistantTextView` | như trên | 14sp | như trên | hint đỏ "Chưa có" khi chưa bổ nhiệm |
| Nick đại sứ | `clanSupervisorTextView` | như trên | 14sp | như trên | hint đỏ "Chưa có" |
| Chính sách | `clanPolicyTextView` | `#DE000000` | 14sp | như trên (không có hint) | text = map mã → chuỗi (§4.2) |
| Icon bút ✏ ×4 | — | icon xám trên nền `#61000000` bo 4dp (`bg_round_rect_black_translucent`) | — | 20×20dp, padding 2dp | luôn hiện ở cả 4 hàng (kể cả hàng Bang chủ không sửa được) |
| Divider ×3 | — | `#1F000000` (`colorTextBlackDivider`) | — | cao 1px | giữa các hàng |
| Nút Chứng thực | `verifyMemberButton` | chữ `#808080` (`text_color_7`), nền nút trắng bo 2dp viền `#1F000000` (`btn_default_button_selector`) | 12sp | weight 1, marginRight 4dp | text `string_verify_clan_member` |
| Nút Hủy chứng thực | `unverifyMemberButton` | như trên | 12sp | weight 1, marginLeft 4dp | text `string_unverify_clan_member` |

## 3. CSS tương đương (dựng lại trên web)

```css
.clan-mgr { min-height: 100vh; background: #fff; font-family: Roboto, Arial, sans-serif; }
.clan-mgr__appbar {
  position: sticky; top: 0; height: 48px;
  background: #7CB342; color: #fff;
  display: flex; align-items: center; padding: 4px 16px 10px 8px;
}
.clan-mgr__appbar-title { font-size: 14px; font-weight: 700; margin-left: 8px; }

.clan-mgr__body { padding: 8px; margin-top: 0; }

.clan-mgr__row { padding: 8px 0; cursor: pointer; }
.clan-mgr__row + .clan-mgr__row { border-top: 1px solid rgba(0,0,0,.12); }
.clan-mgr__row-label { font-size: 12px; color: rgba(0,0,0,.54); }
.clan-mgr__row-value {
  display: flex; align-items: center; margin-top: 4px;
}
.clan-mgr__row-value span { flex: 1; font-size: 14px; color: rgba(0,0,0,.87); padding: 2px; }
.clan-mgr__row-value span:empty::before {          /* hint "Chưa có" màu đỏ */
  content: "Chưa có"; color: #E34545;
}
.clan-mgr__row-value img {                          /* icon bút ✏ */
  width: 20px; height: 20px; padding: 2px; box-sizing: border-box;
  background: rgba(0,0,0,.38); border-radius: 4px;
}

.clan-mgr__actions { display: flex; gap: 8px; margin-top: 16px; }
.clan-mgr__actions button {
  flex: 1;
  font-size: 12px; color: #808080;
  background: #fff; border: 1px solid rgba(0,0,0,.12); border-radius: 2px;
  padding: 10px; cursor: pointer;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
```

```html
<div class="clan-mgr">
  <div class="clan-mgr__appbar">
    <img src="../images/ic_action_back.png" width="32">
    <div class="clan-mgr__appbar-title">#teamviet</div>
  </div>
  <div class="clan-mgr__body">
    <div class="clan-mgr__row">
      <div class="clan-mgr__row-label">Bang chủ</div>
      <div class="clan-mgr__row-value"><span>bangchu01</span><img src="../images/ic_action_edit.png"></div>
    </div>
    <div class="clan-mgr__row">
      <div class="clan-mgr__row-label">Phó bang chủ</div>
      <div class="clan-mgr__row-value"><span></span><img src="../images/ic_action_edit.png"></div>
    </div>
    <div class="clan-mgr__row">
      <div class="clan-mgr__row-label">Đại sứ</div>
      <div class="clan-mgr__row-value"><span></span><img src="../images/ic_action_edit.png"></div>
    </div>
    <div class="clan-mgr__row">
      <div class="clan-mgr__row-label">Chính sách</div>
      <div class="clan-mgr__row-value"><span>Tự do gia nhập</span><img src="../images/ic_action_edit.png"></div>
    </div>
    <div class="clan-mgr__actions">
      <button>Chứng thực thành viên</button>
      <button>Hủy chứng thực thành viên</button>
    </div>
  </div>
</div>
```

## 4. Hành vi & luồng

### 4.1. Khởi tạo & render (`onCreate` → `J()` + `K()`, dòng 32-61)

- Clan hiện hành nằm ở **biến static `e`** (được set trước khi mở màn bởi `a(context, clan)` — KHÔNG truyền qua Intent).
- `K()`: nếu `e == null` → cả 4 hàng hiện "Chưa có"; ngược lại `L()` đổ nick + `M()` đổ chính sách.
- `L()` (dòng 64-103): tiêu đề = `#<tên clan>` (thiếu tên → "Quản lý Clan"); đổ `e.b/c/d` vào 3 hàng nick. ⚠️ **Bug decompile-được ở nhánh rỗng:** khi bang chủ (`e.b`) rỗng, code set nhầm vào `clanAssistantTextView` (`this.g`) thay vì `clanManagerTextView` (dòng 77-84) — hàng Bang chủ khi đó vẫn giữ hint đỏ, còn hàng Phó bang bị ghi rỗng.
- Màn cũng implement callback crop ảnh (`D()/E()` → `K()` refresh) do kế thừa flow đổi ảnh clan.

### 4.2. Map mã chính sách → chuỗi (`util/m.java:102-116`)

| Mã (`e.j`) | Resource | VI | Lệnh socket gửi |
|------------|----------|----|-----------------|
| 0 | `message_clan_privacy_free_post` | Tự do post Me | `@113 restrict #clan none` |
| 1 | `message_clan_privacy_free_join` | Tự do gia nhập | `@113 restrict #clan join` |
| 2 | `message_clan_privacy_verified_post` | Được xem nhưng cần chứng thực để post Me | `@113 restrict #clan write` |
| 3 | `message_clan_privacy_close` | Đóng cửa | `@113 restrict #clan all` |
| 4 | `message_clan_privacy_verified_view_and_post` | Chứng thực mới được xem và post | `@113 restrict #clan view` |

(Builder lệnh: `OlaNetworkService.m(id, privacy)`, dòng 2002-2046.)

### 4.3. Bảng tương tác (mọi cử chỉ)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| Nút back action bar | click | `finish()` (trượt phải) | nội bộ |
| Hàng **Bang chủ** | click | có listener nhưng **KHÔNG có case xử lý → không làm gì** (bang chủ không đổi được từ màn này) | — |
| Hàng **Phó bang chủ** | click | mở **modal nhập nick Phó bang chủ** (§4.4.1) | modal trong màn |
| Hàng **Đại sứ** | click | mở **modal nhập nick Đại sứ** (§4.4.2) | modal trong màn |
| Hàng **Chính sách** | click | mở **modal chọn chính sách** (§4.4.3) | modal trong màn |
| Nút **Chứng thực thành viên** | click | mở **modal nhập nick chứng thực** (§4.4.4) — chỉ khi `e != null` | modal trong màn |
| Nút **Hủy chứng thực thành viên** | click | mở **modal nhập nick hủy chứng thực** (§4.4.5) | modal trong màn |
| Phím Back | onBackPressed | `finish()` | nội bộ |

> **Không có long-press** trong màn này (đã rà toàn bộ listener — chỉ có 7 `onClick`).

### 4.4. Modal/Dialog mở trong màn (chi tiết từng cái)

Tất cả dùng 2 helper dialog chung: `i.a(...)` = **dialog nhập text 1 ô** (class `chat.ola.vn.i.p` — icon + tiêu đề + EditText có gợi ý + 2 nút) và `chat.ola.vn.i.m` = **dialog danh sách chọn 1**.

1. **Modal "Phó bang chủ"** (hàng Assistant, dòng 266-303)
   - Icon `ic_clan_role_vice_leader`, tiêu đề `string_clan_assistant` ("Phó bang chủ"), ô nhập hint `general_hint_nick` ("Nhập nick Ola"), **điền sẵn nick phó bang hiện tại**, tối đa 32 ký tự, có **gợi ý nick** từ danh bạ (`h.t.b()`).
   - Nút **"Đồng ý"** (`string_ok`):
     - Nhập nick mới → gán `e.c` + gửi `OlaNetworkService.e(clan, nick)` (lệnh `@113 PBC @nick #clan`) + render lại.
     - **Để trống** → mở tiếp **modal xác nhận cách chức**: tiêu đề "Xác nhận", nội dung `message_deprive_clan_assistant` ("Bạn có muốn cách chức phó bang chủ @x?"), nút **Có/Không**; Có → `e.c = null` + gửi `@113 PBC.X #clan`.
   - Nút **"Huỷ"** → đóng.
2. **Modal "Đại sứ"** (hàng Supervisor, dòng 308-345) — y hệt modal 1 nhưng: icon `ic_clan_role_supporter`, tiêu đề `string_clan_supervisor` ("Đại sứ"), lệnh `OlaNetworkService.f(clan, nick)` (`@113 DS @nick #clan` / gỡ `@113 DS.X #clan`), confirm `message_deprive_clan_supervisor` ("…cách chức đại sứ @x?").
3. **Modal "Chính sách"** (`N()`, dòng 110-158) — dialog **danh sách 5 lựa chọn** theo thứ tự: Tự do post Me / Tự do gia nhập / Được xem nhưng cần chứng thực để post Me / Chứng thực mới được xem và post / Đóng cửa. **Đánh dấu sẵn** chính sách hiện tại (map index: mã 0→0, 1→1, 2→2, 4→3, 3→4). Chọn 1 dòng → set `e.j` + gửi lệnh restrict (§4.2) + cập nhật hàng Chính sách; toast server trả `message_change_clan_privacy_format`.
4. **Modal "Chứng thực thành viên"** (`B()`, dòng 172-195) — tiêu đề `string_verify_clan_member`, ô nhập nick (trống), nút **"Xác Thực"** (`string_verify`) / "Huỷ". Xác Thực → gửi `OlaNetworkService.i(nick, clan)` (`@113 OK @nick #clan`) + toast `message_clan_verified_format` ("Đã xác thực @x trong Clan #y"). Nút OK chỉ bấm được khi ô ≠ trống (validator `!m.a(str)`).
5. **Modal "Hủy chứng thực thành viên"** (`C()`, dòng 197-217) — như modal 4 nhưng nút **"Hủy xác thực"** (`string_unvetify`) → `OlaNetworkService.j(nick, clan)` (`@113 OK.X @nick #clan`) + toast `message_clan_unverified_format`.

### 4.5. Đối chiếu web (`web/src/pages/`)

**Web hiện CHƯA có tính năng Clan** — chưa có màn quản trị tương ứng.

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|--------------------------|------------------------------|
| `string_manage_clan` | Manage Clan | Quản lý Clan |
| `string_clan_manager` | Manager | Bang chủ |
| `string_clan_assistant` | Assistant | Phó bang chủ |
| `string_clan_supervisor` | Supervisor | Đại sứ |
| `string_policy` | Policy | Chính sách |
| `string_unavaliable` | Unavailalbe *(sic — typo gốc trong APK)* | Chưa có |
| `string_verify_clan_member` | Verify member | Chứng thực thành viên |
| `string_unverify_clan_member` | Unverify member | Hủy chứng thực thành viên |
| `string_verify` | Verify | Xác Thực |
| `string_unvetify` | Discard verified | Hủy xác thực |
| `general_hint_nick` | Enter Ola account | Nhập nick Ola |
| `string_ok` / `string_cancel` | OK / Cancel | Đồng ý / Huỷ |
| `dialog_title_confirm` | Confirmation | Xác nhận |
| `string_yes` / `string_no` | Yes / No | Có / Không |
| `message_deprive_clan_assistant` | Do you want to deprive clan assistant %1$s? | Bạn có muốn cách chức phó bang chủ %1$s? |
| `message_deprive_clan_supervisor` | Do you want to deprive clan supervisor %1$s? | Bạn có muốn cách chức đại sứ %1$s? |
| `message_clan_verified_format` | Verified %1$s in Clan %2$s | Đã xác thực %1$s trong Clan %2$s |
| `message_clan_unverified_format` | Unverified %1$s in Clan %2$s | Đã hủy xác thực %1$s trong Clan %2$s |
| `message_clan_privacy_free_post` | Free to post | Tự do post Me |
| `message_clan_privacy_free_join` | Free to join | Tự do gia nhập |
| `message_clan_privacy_verified_post` | Required verification to post Me | Được xem nhưng cần chứng thực để post Me |
| `message_clan_privacy_verified_view_and_post` | Required verification to view and post Me | Chứng thực mới được xem và post |
| `message_clan_privacy_close` | Closed | Đóng cửa |
| `message_change_clan_privacy_format` | Changed policy of Clan %1$s | Đã thay đổi chính sách Clan %1$s |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| Nút back / phím Back | quay về [Trang Clan](../trang-clan/README.md) | [../trang-clan/README.md](../trang-clan/README.md) |

> Màn này **không mở màn mới nào khác** — mọi thao tác đều qua modal tại chỗ.
