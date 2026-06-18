# Tab TIN NHẮN — danh sách hội thoại

> Thuộc màn [Chat (khung 2 tab)](README.md). Tab bên TRÁI (trang 0 của `OlaViewPager`).

- **Fragment:** `chat.ola.vn.m.o`
- **Layout:** `apktool_out/res/layout/conversation_tab_layout.xml`
- **Item:** `conversation_item_layout.xml`
- **Adapter:** `chat.ola.vn.b.r` (bọc nguồn dữ liệu chung `chat.ola.vn.h.t` = `message.g`)
- **Chức năng:** danh sách các cuộc trò chuyện gần đây; bấm 1 dòng mở [khung hội thoại](../chat-hoi-thoai/README.md).

![tin-nhan](images/01-tin-nhan.png)

---

## 1. Bố cục — `conversation_tab_layout.xml`

```
RelativeLayout
├─ EnhancedListView  conversationListView   (style list.noDivider)   ← VUỐT để xoá (undo) — mục 4
│   └─ footer: load_more_watting_span_view  (spinner, INVISIBLE — hiện khi tải thêm cuối list)
├─ conversationTipLayout (nền TRẮNG, match_parent, padding 16dp)     ← EMPTY STATE khi h.t.j()==0
│   ├─ conversationTipTextView  message_free_chat (subhead 16sp) — "<MESSAGE>" thay bằng icon ic_chat inline
│   └─ TextView                 message_make_friend_by_chat (body1 14sp)
└─ addConversationImageButton  FAB 56dp ↘ góc phải-dưới
      nền floating_action_bar_shape (oval xanh), src ic_action_compose_message ✎, tint trắng, margin 16dp
```

- `x()` bật/tắt empty-state: `h.t.j()>0` → hiện list, ẩn tip; ngược lại hiện tip, ẩn list.

## 2. Cấu tạo 1 dòng hội thoại — `conversation_item_layout.xml`

| Thành phần | id | Style / màu | Cỡ | Ghi chú |
|------------|----|-------------|-----|---------|
| Dòng | `conversationViewLayout` | nền `#CCFFFFFF` (trắng mờ 80%) | min-height **72dp**; padding **16dp** (ở `conversationContentViewLayout`) | bấm cả dòng |
| Avatar | `imgItemIcon` | `ic_contact_photo`, `centerCrop`, bo tròn (`OlaCachedImageView`) | **40×40dp** | |
| Icon thiết bị | `imgDeviceType` | `ic_device_type_android/ios` | 12dp, góc phải-dưới avatar | ẩn mặc định |
| Tên/nick | `txtItemTitle` | `subhead` **16sp**, `rgba(0,0,0,.87)` | 1 dòng, weight 1 | |
| Thời gian | `timeAgoTextView` | `caption` **12sp**, `rgba(0,0,0,.54)` | 1 dòng | "vừa tức thì" |
| Tin cuối | `txtItemSubTitle` | `body1` **14sp**, `rgba(0,0,0,.87)` | 1 dòng | preview tin nhắn cuối |
| Trạng thái gửi | `messageStateImageView` | icon 12dp | ẩn mặc định | đã gửi/đã nhận |
| Badge chưa đọc | `txtUnreadMessgage` | `bg_uread_notify` (hồng `#FF4081`), chữ trắng **đậm 12sp** | marginLeft 8dp | số tin chưa đọc |
| Divider | `bottomDividerView` | `#1F000000` (đen 12%) | 1dp, margin ngang 16dp | |

### Trạng thái CHƯA ĐỌC vs ĐÃ ĐỌC (code `message/n.java`)

| Thành phần | Đã đọc | **Chưa đọc** | Nguồn |
|------------|--------|--------------|-------|
| Nick (`txtItemTitle`) | thường | **in đậm** | `Typeface.create(.., BOLD)` |
| Thời gian (`timeAgoTextView`) | `rgba(0,0,0,.54)` (`f.z`) | **in đậm**, `rgba(0,0,0,.87)` (`f.y`) | đậm + đổi màu |
| Nền dòng (`conversationViewLayout`) | `rgba(255,255,255,.8)` (`f.d`) | **`#F1F8E9`** xanh lá nhạt (`f.I` = `colorOlaPrimaryLight`) | highlight |
| Badge (`txtUnreadMessgage`) | ẩn | **hiện số** (nền hồng `#FF4081`) | — |

> Tin chưa đọc = **nền xanh nhạt `#F1F8E9` + nick & giờ in đậm + badge số hồng**. Đọc xong → trở lại nền trắng mờ, chữ thường, badge biến mất.

## 3. Trạng thái hiển thị khác
- **Empty state** `conversationTipLayout`: hiện khi `h.t.j()==0`.
- **Icon loại thiết bị** (`imgDeviceType` Android/iOS) góc phải-dưới avatar — INVISIBLE mặc định, hiện khi biết loại thiết bị đối phương.
- **Footer spinner** (`load_more_watting_span_view`) — INVISIBLE, hiện khi cuộn cuối list để tải thêm.

---

## 4. Tương tác — bấm gì → ra gì (logic `m/o.java`)

| Thành phần | Hành vi | Loại |
|------------|---------|------|
| **Bấm 1 dòng** | Mở **`OlaChatViewActivity`** (loại thường); mục "người khác" (`k()==7`) → **`OlaOtherPeopleListActivity`**; quảng cáo (`k()==5/6`) xử lý riêng | → sang màn |
| **Bấm avatar** `imgItemIcon` | `k()==0` (1-1) → **`OlaUserMePageActivity`**; `k()==4` (loa loa) → **popup "Tắt loa loa"** (mục 6) | → màn / **modal** |
| **FAB ✎** | Mở **`OlaContactPickerActivity`**: chọn **1 người** → `OlaChatViewActivity` 1-1; chọn **≥2** → tạo nhóm "Chat group N members" rồi mở dạng nhóm | → sang màn |
| **Nút ⋮** action bar | Mở **popup menu TIN NHẮN** (mục 5) | **modal** |
| **Vuốt 1 dòng** (END) | **Xoá ngay + popup HOÀN TÁC (Undo)** kiểu sephiroth `SINGLE_POPUP`, timeout 180s. Text "Đã xoá <tên>". **KHÔNG phải dialog**. | undo popup |
| **Giữ (long-press) 1 dòng** | Mở **popup context theo loại hội thoại** (mục 6) | **modal** |

---

## 5. Menu ⋮ TIN NHẮN (`o.h_()`)

Nút ⋮ trên action bar → popup list `chat.ola.vn.i.m`:

| Mục | String (VI) | Hành động |
|-----|-------------|-----------|
| Xóa tất cả | `string_delete_all` = "Xóa tất cả" | → **dialog xác nhận** `message_delete_all_conversations_confirm` = "Bạn có muốn xóa tất cả tin nhắn chat" (nút **Xoá**/**Không**) |
| Hiện/Xóa người lạ | `string_show_strangers` = "Hiện người lạ" **hoặc** `string_delete_all_stranger` = "Xóa tất cả người lạ" (theo cờ `c.x.v`) | "Xóa tất cả người lạ" → dialog `string_delete_all_stranger_convsations_confirm` = "Bạn có muốn xóa tất cả trò chuyện với người lạ?"; "Hiện người lạ" → bật/tắt lọc ngay |
| Danh sách chặn | `string_block_list` = "Danh sách chặn" | → **`OlaChatBlockedListActivity`** (→ sang màn) |

---

## 6. Menu GIỮ (long-press) — popup theo loại hội thoại `f.k()`

Giữ 1 dòng → popup list `chat.ola.vn.i.m` (tiêu đề = tên hội thoại):

| Loại `k()` | Tiêu đề | Các mục | Mỗi mục làm gì |
|-----------|---------|---------|-----------------|
| **0** — chat 1-1 | tên người | Chat bong bóng / Xóa trò truyện / Copy nick / Chặn nick / Báo nick xấu | Chat bong bóng → bật chat nổi; Xóa → **dialog xoá** (mục 7); Copy nick → chép `@nick`; Chặn nick → **dialog Chặn** (mục 8); Báo nick xấu → dialog báo cáo |
| **1** — hội thoại tạm | — | Xóa trò truyện | → dialog xác nhận xoá (`i.i.d`, Có/Không) |
| **2** — nhóm chat | tên nhóm | Chat bong bóng / Xóa trò truyện / Rời nhóm | Rời nhóm → **dialog** `message_chatgroup_leave_confirm_format` = "Bạn có muốn rời nhóm chat %s" (Rời nhóm/Huỷ); Xóa → dialog xoá (mục 7) |
| **4** — phòng loa loa | — | Tắt loa loa | → **dialog** `message_quit_chat_room_confirm` = "Bạn có muốn ngưng chat toàn cộng đồng %s?" (Có/Không) |

## 7. Dialog **Xoá hội thoại** (`chat.ola.vn.i.h` + `delete_conversation_confirm_dialog_layout.xml`)

Mở khi chọn **"Xóa trò truyện"** trong menu giữ — KHÔNG phải khi vuốt (vuốt = undo, mục 4).

```
┌─────────────────────────────────────┐
│ [ⓘ ic_dialog_indicate_info]  Tiêu đề │  ← dialog.header
├─────────────────────────────────────┤
│ Bạn có muốn xóa cuộc trò chuyện này? │  ← dialog.content.text, minHeight 50dp
│ ☐ Xóa nội dung chat                  │  ← CheckBox ckbDeleteConversationContentHistory
├─────────────────────────────────────┤
│   [ Xoá (nền ĐỎ) ]   [ Huỷ ]         │  ← btnButton1 (btn_red_button_selector) / btnButton2
└─────────────────────────────────────┘
```
- Checkbox `message_clear_conversation_content_history` = **"Xóa nội dung chat"** → truyền vào `h.t.a(fVar, z)`.
- Nút **Xoá**: chữ trắng nền **đỏ** `btn_red_button_selector` (≈ `#E34545`); **Huỷ**: kiểu `commont.button`.

## 8. Dialog **Chặn nick** (`i.i.d(...)`)
- Tiêu đề `message_block_chat_title` = **"Chặn tin nhắn"**
- Nội dung `message_block_chat_confirm_format` = **"Bạn có muốn chặn tin nhắn từ @\<nick> không?"**
- Nút **Chặn** (`string_block`) / **Huỷ** (`string_cancel`).

---

## 9. CSS tương đương (dòng hội thoại + FAB)

```css
.ola-convo-item {
  display: flex; align-items: center; gap: 16px;
  min-height: 72px; padding: 16px;
  background: rgba(255,255,255,.8);          /* translucent_white_80_percent */
  border-bottom: 1px solid rgba(0,0,0,.12);
}
.ola-convo-item__avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; flex-shrink: 0; }
.ola-convo-item__body { flex: 1; min-width: 0; }
.ola-convo-item__line1 { display: flex; justify-content: space-between; gap: 8px; }
.ola-convo-item__name { font-size: 16px; color: rgba(0,0,0,.87); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.ola-convo-item__time { font-size: 12px; color: rgba(0,0,0,.54); white-space: nowrap; }
.ola-convo-item__last { font-size: 14px; color: rgba(0,0,0,.87); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.ola-convo-item__badge {        /* số chưa đọc */
  min-width: 16px; height: 16px; padding: 0 5px; border-radius: 999px;
  background: #FF4081; color: #fff; font-size: 12px; font-weight: bold;
  display: flex; align-items: center; justify-content: center;
}
/* CHƯA ĐỌC */
.ola-convo-item.is-unread { background: #F1F8E9; }                 /* colorOlaPrimaryLight */
.ola-convo-item.is-unread .ola-convo-item__name { font-weight: bold; }
.ola-convo-item.is-unread .ola-convo-item__time { font-weight: bold; color: rgba(0,0,0,.87); }
.ola-convo-item:not(.is-unread) .ola-convo-item__badge { display: none; }
/* FAB soạn tin */
.ola-chat-fab {
  position: absolute; right: 16px; bottom: 16px; width: 56px; height: 56px; border-radius: 50%;
  background: #7CB342; color: #fff; display: flex; align-items: center; justify-content: center;
  box-shadow: 0 3px 6px rgba(0,0,0,.3);
}
```

---

## 10. Strings

| Resource | EN | VI |
|----------|----|----|
| `string_messages` | MESSAGES | TIN NHẮN |
| `message_free_chat` | To begin a new chat, simply tap on the \<MESSAGE> icon… | Để bắt đầu chat, bạn chỉ cần chạm vào biểu tượng \<MESSAGE>… |
| `message_make_friend_by_chat` | You can start chatting by join public room… | Bạn có thể bắt đầu trò chuyện bằng cách tham gia phòng chat công cộng… |
| `string_delete_all` | Delete all | Xóa tất cả |
| `string_show_strangers` / `string_hide_strangers` | Show / Hide strangers | Hiện / Ẩn người lạ |
| `string_delete_all_stranger` | Delete all conversations of strangers | Xóa tất cả người lạ |
| `string_block_list` | Blocked list | Danh sách chặn |
| `string_popout_balloon_chat` | Balloon chat | Chat bong bóng |
| `string_delete_conversation` | Delete conversation | Xóa trò truyện |
| `string_copy_nick` | Copy nick | Copy nick |
| `string_block_chat` | Block | Chặn nick |
| `string_bad_nick_report` | Report bad account | Báo nick xấu |
| `string_quit_chat_room` | Broadcast off | Tắt loa loa |
| `message_block_chat_title` | Block messages | Chặn tin nhắn |
| `message_delete_conversation_confirm` | Do you want to delete this conversation? | Bạn có muốn xóa cuộc trò chuyện này? |
| `message_delete_all_conversations_confirm` | Do you want to delete all conversations | Bạn có muốn xóa tất cả tin nhắn chat |
| `string_yes` / `string_no` / `string_delete` / `string_cancel` | Yes / No / Delete / Cancel | Có / Không / Xoá / Huỷ |

---

## 11. Icon (trích từ APK — `images/icons/`)

| UI | Icon | Drawable |
|----|------|----------|
| FAB soạn tin | ![compose](images/icons/ic_action_compose_message.png) | `ic_action_compose_message` (tint trắng) |
| Menu ⋮ | ![more](images/icons/ic_more_white.png) | `ic_more_white` |
| Avatar mặc định | ![avatar](images/icons/ic_contact_photo.png) | `ic_contact_photo` |
| Thiết bị Android | ![android](images/icons/ic_device_type_android.png) | `ic_device_type_android` |
| Thiết bị iOS | ![apple](images/icons/ic_device_type_apple.png) | `ic_device_type_apple` |
| Badge chưa đọc | — | `bg_uread_notify` (`#FF4081`) |
| Nút Xoá (đỏ) | — | `btn_red_button_selector` (≈ `#E34545`) |
