# Màn hình Chat (TIN NHẮN + DANH BẠ)

- **Activity:** `chat.ola.vn.activity.OlaBottomTabActivity` — tab **Chat** (index 0), fragment `chat.ola.vn.e`
- **Khung 2 tab con:** `apktool_out/res/layout/contact_view_layout.xml` (action bar + ViewPager)
  - Trang **TIN NHẮN**: `conversation_tab_layout.xml` → item `conversation_item_layout.xml`
  - Trang **DANH BẠ**: contacts fragment → item `contact_item_layout.xml`
- **Khung hội thoại (mở 1 cuộc chat):** `OlaChatViewActivity` → `ola_chat_view_resizable_layout.xml`
- **Chức năng:** tab đầu tiên sau đăng nhập — gồm **2 tab con**: danh sách hội thoại (TIN NHẮN) và danh bạ bạn bè (DANH BẠ). Bấm 1 dòng để mở khung chat.

## Ảnh chụp (thiết bị thật + fake server)

| TIN NHẮN (list hội thoại) | DANH BẠ (contacts) | Khung chat (bong bóng) | Auto-reply |
|---|---|---|---|
| ![tin-nhan](images/01-tin-nhan.png) | ![danh-ba](images/02-danh-ba.png) | ![chat](images/03-khung-chat.png) | ![reply](images/04-auto-reply.png) |

> Avatar hiển thị chữ cái đầu của nick (màu nền ngẫu nhiên) khi chưa có ảnh. Thời gian "vừa tức thì" do fake server đẩy timestamp hiện tại.

---

## 1. Bố cục tổng — `contact_view_layout.xml`

```
FrameLayout
├─ OlaViewPager  contactFragmentHolder   paddingTop 42dp   ← 2 trang: [TIN NHẮN] | [DANH BẠ]
├─ Action bar (LinearLayout, style actionBar.background — nền xanh #7CB342)
│   ├─ conversationTabLeftButton   (ẩn)
│   ├─ btnTabConversation   "TIN NHẮN"   ← chữ TRẮNG, in đậm; gạch chân khi chọn
│   │   └─ txtTabConversationInfo  badge số chưa đọc (góc phải-trên, ẩn mặc định)
│   ├─ btnTabContactList    "DANH BẠ"    ← chữ trắng mờ rgba(255,255,255,.70) khi không chọn
│   └─ conversationTabRightButton  ⋮  (ic_more_white — menu)
└─ ProgressBar  loadingProgressBar   (giữa màn, khi tải)
```

- 2 tab con dùng style `actionBar.tab.button` (in **đậm**, cỡ **14sp** button, nền `btn_action_tab_selector` → **gạch chân trắng** khi đang chọn).
- Tab đang chọn: chữ `#FFFFFF`. Tab không chọn: `rgba(255,255,255,.70)` (`colorTextWhiteSecondary`).
- Mỗi tab có **badge số chưa đọc** riêng (kiểu `bg_uread_notify` — hồng `#FF4081`).

---

## 2. Trang TIN NHẮN — danh sách hội thoại

Layout `conversation_tab_layout.xml`:

```
RelativeLayout
├─ EnhancedListView  conversationListView   (style list.noDivider)   ← VUỐT để xoá hội thoại
├─ conversationTipLayout (nền trắng, padding 16dp)   ← hiện khi DANH SÁCH TRỐNG
│   ├─ TextView  message_free_chat   (subhead 16sp)
│   └─ TextView  message_make_friend_by_chat   (body1 14sp)
└─ addConversationImageButton  FAB  56dp  ↘ góc phải-dưới (ic_action_compose_message)
```

### Cấu tạo 1 dòng hội thoại (`conversation_item_layout.xml`)

| Thành phần | id | Style / màu | Cỡ | Ghi chú |
|------------|----|-----|-----|---------|
| Dòng | `conversationViewLayout` | nền `#CCFFFFFF` (trắng mờ 80%) | min-height **72dp**, padding **16dp** | bấm cả dòng |
| Avatar | `imgItemIcon` | `ic_contact_photo`, `centerCrop` | **40×40dp** | `OlaCachedImageView`, bo tròn |
| Icon thiết bị | `imgDeviceType` | `ic_device_type_android/ios` | 12dp, góc phải-dưới avatar | ẩn mặc định |
| Tên/nick | `txtItemTitle` | `subhead` **16sp**, `rgba(0,0,0,.87)` | 1 dòng, weight 1 | |
| Thời gian | `timeAgoTextView` | `caption` **12sp**, `rgba(0,0,0,.54)` | 1 dòng | "vừa tức thì" |
| Tin cuối | `txtItemSubTitle` | `body1` **14sp**, `rgba(0,0,0,.87)` | 1 dòng | preview tin nhắn cuối |
| Trạng thái gửi | `messageStateImageView` | icon 12dp | ẩn mặc định | đã gửi/đã nhận |
| Badge chưa đọc | `txtUnreadMessgage` | `bg_uread_notify` (hồng `#FF4081`), chữ trắng **đậm 12sp** | marginLeft 8dp | số tin chưa đọc |
| Divider | `bottomDividerView` | `#1F000000` (đen 12%) | 1dp, margin ngang 16dp | |

### Tính năng TIN NHẮN
- **Vuốt sang để xoá** hội thoại (`EnhancedListView` của sephiroth) → dialog xác nhận (`delete_conversation_confirm_dialog_layout`).
- **FAB ✎** mở màn soạn tin mới (`conversation_create_new_layout`): ô "Nhập tên nick hoặc số điện thoại cần chat", **Invite more friends**, **Chat group**.
- **Badge số chưa đọc** trên từng dòng + trên tab.
- **Empty state**: khi chưa có hội thoại → hiện hướng dẫn "Để bắt đầu chat, chạm vào biểu tượng ✎ góc dưới phải".
- Icon **loại thiết bị** (Android/iOS) ở góc avatar.

---

## 3. Trang DANH BẠ — danh bạ bạn bè

Item `contact_item_layout.xml` (gần giống dòng hội thoại, thêm giới tính + VIP):

| Thành phần | id | Style | Ghi chú |
|------------|----|-------|---------|
| Icon giới tính | `imgGenderIcon` | `ic_indicate_male` / `ic_indicate_female` | bên trái, marginRight 8dp |
| Avatar | `imgItemIcon` | 40×40dp, `centerCrop` | |
| Icon VIP | `vipImageHolder` | 24dp | ẩn nếu không phải VIP |
| Nick | `txtItemTitle` | `subhead` 16sp, `ellipsize=end` | |
| Trạng thái | `txtItemSubTitle` | `caption` 12sp | status message của bạn |
| Online | `timeOfflineTextView` | `caption` 12sp | "online" / thời gian offline (ẩn mặc định) |
| Divider | `listViewBottomDividerView` | `#1F000000` 1dp | |

### Tính năng DANH BẠ
- Header: **ô tìm kiếm** "Nhập tên nick hoặc số điện thoại", **Invite more friends** ("More friends, more fun"), **Chat group** ("Chat to friends as group").
- Hiển thị **giới tính** (icon nam/nữ), **huy hiệu VIP**, **trạng thái online**.
- Bấm 1 contact → mở khung chat 1-1 với người đó.

---

## 4. Khung chat (mở 1 hội thoại) — `OlaChatViewActivity`

- **Bong bóng tin nhắn** dùng 9-patch:
  - **Đến** (incoming): `chat_incoming.9.png` — canh **trái**, nền sáng.
  - **Đi** (outgoing): `chat_outgoing.9.png` — canh **phải**, nền xanh.
  - Nội dung text: `messageTextContentTextview` (`subhead` 16sp, `maxWidth` 400dp).
- **Thanh nhập dưới**: ô "Viết tin nhắn cho \<nick>" + icon **emoji / camera / ảnh / ghi âm** + nút **👍** (thumbs-up gửi nhanh).
- **Nhiều loại tin nhắn** (mỗi loại 1 layout riêng):

| Loại | Layout |
|------|--------|
| Text | `chat_balloon_text_message_item` |
| Sticker | `chat_sticker_layout` |
| Ghi âm (voice) | `chat_voice_message_item` |
| Vị trí (location) | `chat_message_location_item` |
| YouTube | `chat_youtube_attachment_layout` |
| Snap pic (ảnh tự huỷ) | `chat_snap_pic_item` |
| Chuyển KEN | `chat_ken_transferred_layout` |
| Trao đổi VIP | `chat_sent_tradding_vip_layout` / `chat_received_tradding_vip_layout` |
| Trạng thái | `chat_status_bubble_layout` |
| RSS | `chat_rss_layout` |

> Trong fake server: gửi tin → ACK "đã gửi ✓" → **auto-reply** từ bot (xem ảnh 04).

---

## 5. CSS tương đương (dựng lại trên web)

```css
/* ===== Action bar 2 tab con ===== */
.ola-chat-tabs {
  display: flex; align-items: center;
  height: 48px; background: #7CB342; padding: 0 8px;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
}
.ola-chat-tabs__btn {
  flex: 1; height: 100%;
  display: flex; align-items: center; justify-content: center;
  font-size: 14px; font-weight: bold;
  color: rgba(255,255,255,.70);              /* tab không chọn */
  background: none; border: none; position: relative;
}
.ola-chat-tabs__btn.is-active {
  color: #FFFFFF;
  box-shadow: inset 0 -2px 0 #FFFFFF;        /* gạch chân trắng */
}
.ola-chat-tabs__more { width: 24px; color: #fff; }   /* ⋮ */

/* ===== 1 dòng hội thoại ===== */
.ola-convo-item {
  display: flex; align-items: center; gap: 16px;
  min-height: 72px; padding: 16px;
  background: rgba(255,255,255,.8);          /* translucent_white_80_percent */
  border-bottom: 1px solid rgba(0,0,0,.12);
}
.ola-convo-item__avatar {
  width: 40px; height: 40px; border-radius: 50%;
  object-fit: cover; flex-shrink: 0;
}
.ola-convo-item__body { flex: 1; min-width: 0; }
.ola-convo-item__line1 { display: flex; justify-content: space-between; gap: 8px; }
.ola-convo-item__name {
  font-size: 16px; color: rgba(0,0,0,.87);
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.ola-convo-item__time { font-size: 12px; color: rgba(0,0,0,.54); white-space: nowrap; }
.ola-convo-item__last {
  font-size: 14px; color: rgba(0,0,0,.87);
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.ola-convo-item__badge {        /* số chưa đọc */
  min-width: 16px; height: 16px; padding: 0 5px;
  border-radius: 999px; background: #FF4081;
  color: #fff; font-size: 12px; font-weight: bold;
  display: flex; align-items: center; justify-content: center;
}

/* ===== FAB soạn tin ===== */
.ola-chat-fab {
  position: absolute; right: 16px; bottom: 16px;
  width: 56px; height: 56px; border-radius: 50%;
  background: #7CB342; color: #fff;
  display: flex; align-items: center; justify-content: center;
  box-shadow: 0 3px 6px rgba(0,0,0,.3);
}

/* ===== Bong bóng chat ===== */
.ola-bubble { max-width: 400px; padding: 8px 12px; border-radius: 8px; font-size: 16px; }
.ola-bubble--in  { align-self: flex-start; background: #FFFFFF; color: rgba(0,0,0,.87); }
.ola-bubble--out { align-self: flex-end;   background: #DCEDC8; color: rgba(0,0,0,.87); }
```

```html
<li class="ola-convo-item">
  <img class="ola-convo-item__avatar" src="avatar.png">
  <div class="ola-convo-item__body">
    <div class="ola-convo-item__line1">
      <span class="ola-convo-item__name">linhchi92</span>
      <span class="ola-convo-item__time">vừa tức thì</span>
    </div>
    <div class="ola-convo-item__last">Hôm nay trời đẹp ☀️</div>
  </div>
  <span class="ola-convo-item__badge">3</span>
</li>
```

---

## 6. Strings (đa ngôn ngữ)

| Resource | EN | VI (hiển thị) |
|----------|----|----|
| `string_messages` | MESSAGES | TIN NHẮN |
| `string_contacts` | CONTACTS | DANH BẠ |
| `message_free_chat` | To begin a new chat, simply tap on the \<MESSAGE> icon at the bottom right corner | Để bắt đầu chat, bạn chỉ cần chạm vào biểu tượng \<MESSAGE> ở góc phía dưới bên phải. |
| `message_make_friend_by_chat` | You can start chatting by join public room… | Bạn có thể bắt đầu trò chuyện bằng cách tham gia phòng chat công cộng… |

---

## 7. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Action bar | nền `#7CB342`, cao 48dp |
| Tab chọn / không chọn | chữ `#FFFFFF` (đậm 14sp) gạch chân trắng / `rgba(255,255,255,.70)` |
| Nền dòng (hội thoại & contact) | `rgba(255,255,255,.8)` (`#CCFFFFFF`) |
| Dòng | min-height 72dp, padding 16dp |
| Avatar | 40×40dp, bo tròn, `centerCrop` |
| Nick | subhead 16sp, `rgba(0,0,0,.87)` |
| Tin cuối / trạng thái | body1 14sp / caption 12sp |
| Thời gian | caption 12sp, `rgba(0,0,0,.54)` |
| Badge chưa đọc | nền `#FF4081`, chữ trắng đậm 12sp |
| Divider | `#1F000000`, 1dp, margin ngang 16dp |
| FAB | 56dp, nền `#7CB342`, icon ✎ trắng, góc phải-dưới |
| Bong bóng | maxWidth 400dp, text 16sp; đến=trái sáng, đi=phải xanh |

---

## 8. Modal & Menu

### 8.1. Menu ⋮ trong khung chat (list popup `m`)
Bấm nút ⋮ (hoặc avatar đối phương) trong `OlaChatViewActivity` → popup danh sách (code dòng 2210–2243):

| Mục | String | Hành động |
|-----|--------|-----------|
| Kết bạn | `string_make_friend` | gửi lời mời kết bạn (ẩn nếu đã là bạn) |
| Chat | `string_chat` | mở/đi tới khung chat |
| Xem Me | `string_view_me` | mở trang cá nhân (`me.c.a(...)`) |
| Chặn | `string_block` | → **dialog xác nhận chặn** (ẩn nếu đã là bạn) |
| Chat nhóm | `string_chat_group` | tạo/mời vào nhóm chat |

### 8.2. Dialog xác nhận **Chặn** (`i.i.d(...)`)
- Tiêu đề: `message_block_chat_title` = **"Chặn tin nhắn"**
- Nội dung: `message_block_chat_confirm_format` = **"Bạn có muốn chặn tin nhắn từ @\<nick> không?"**
- Nút: **Chặn** (`string_block`) / **Huỷ** (`string_cancel`). Khung dialog dùng kiểu chung — xem [modal-dialog/](../modal-dialog/README.md).

### 8.3. Dialog **Xoá hội thoại** (`delete_conversation_confirm_dialog_layout.xml`)
Vuốt 1 dòng hội thoại (hoặc giữ) → dialog:
```
┌─────────────────────────────────────┐
│ [ⓘ ic_dialog_indicate_info]  Tiêu đề │  ← dialog.header
├─────────────────────────────────────┤
│ <nội dung cảnh báo xoá>              │  ← dialog.content.text, minHeight 50dp
│ ☐ Xóa nội dung chat                  │  ← CheckBox ckbDeleteConversationContentHistory
├─────────────────────────────────────┤
│   [ Xoá (nền ĐỎ) ]   [ Huỷ ]         │  ← btnButton1 (btn_red_button_selector) / btnButton2
└─────────────────────────────────────┘
```
- Checkbox `message_clear_conversation_content_history` = **"Xóa nội dung chat"** (xoá cả lịch sử đã lưu).
- Nút **Xoá**: chữ trắng, nền **đỏ** `btn_red_button_selector` (≈ `#E34545`). Nút **Huỷ**: kiểu `commont.button`.

---

## 9. Bảng đính kèm (khung chat) — `ola_attachment_*_tab_layout`

Thanh nhập có nút mở **bảng đính kèm** trượt lên, gồm 6 tab:

| Tab | Layout | String (VI) | Nội dung |
|-----|--------|-------------|----------|
| Biểu cảm | `ola_attachment_smiley_tab_layout` | `string_smiley` = "Biểu cảm" | lưới emoji/mặt cười |
| Sticker | `ola_attachment_sticker_tab_layout` | `string_sticker` = "Sticker" | album sticker (`sticker_album_item`, `sticker_object_item`) |
| Ảnh | `ola_attachment_photo_tab_layout` | — | lưới ảnh trong máy (`photo_item`, `photo_selection_item`) |
| Máy ảnh | `ola_attachment_camera_tab_layout` | `string_camera` = "Máy ảnh" | chụp ảnh / quay phim (`string_camera_capture_image`, `string_camera_record`) |
| Ghi âm | `ola_attachment_voice_tab_layout` | `string_voice_recorder` = "Ghi âm" | thu âm gửi voice |
| Khác | `ola_attachment_more_tab_layout` | `string_more` = "Khác" | vị trí, YouTube, snap pic, chuyển KEN, trao đổi VIP… |

> Các loại tin nhắn tạo ra tương ứng với layout bong bóng ở **mục 4** (sticker, voice, location, youtube, snap pic, KEN, VIP…).

---

## 10. Tính năng nâng cao

| Tính năng | Entry point | Layout |
|-----------|-------------|--------|
| **Soạn tin mới** | FAB ✎ ở TIN NHẮN | `conversation_create_new_layout` — ô "Nhập nick / SĐT cần chat" + Invite more friends + Chat group |
| **Chat nhóm** | "Chat group" (menu / màn soạn) | `contact_chatgroup_layout`, `chat_invitation_to_chatgroup_layout`, `invite_chat_group_footer_button` |
| **Mời bạn** | "Invite more friends" (DANH BẠ) | `contact_invite_fb_friend_layout` |
| **Chặn / Bỏ chặn** | menu ⋮ → Chặn | `blocked_contact_layout`, `ola_blocked_list_layout` (`OlaChatBlockedListActivity`) |
| **Đổi nhóm danh bạ** | DANH BẠ | `change_contact_group_layout` |
| **Tìm bạn** | ô tìm kiếm DANH BẠ | `contact_finder_fragment_layout`, `contact_search_layout` |
| **Vuốt xoá hội thoại** | TIN NHẮN (EnhancedListView) | `delete_conversation_confirm_dialog_layout` (mục 8.3) |

---

## 11. Checklist độ phủ tài liệu

| Hạng mục | Trạng thái |
|----------|-----------|
| Bố cục 2 tab con + action bar | ✅ mục 1 |
| List hội thoại (item + style) | ✅ mục 2 |
| Danh bạ (item + style) | ✅ mục 3 |
| Khung chat + 11 loại bong bóng | ✅ mục 4 |
| CSS (tab, dòng, FAB, bong bóng) | ✅ mục 5 |
| CSS chi tiết dòng danh bạ riêng | ⚠️ dùng chung mục 5 (chỉ khác icon giới tính/VIP) |
| Strings (vi/en) | ✅ mục 6 |
| Token UI tóm tắt | ✅ mục 7 |
| Menu ⋮ khung chat | ✅ mục 8.1 |
| Dialog Chặn | ✅ mục 8.2 |
| Dialog Xoá hội thoại | ✅ mục 8.3 |
| Bảng đính kèm 6 tab | ✅ mục 9 |
| Soạn tin / chat nhóm / chặn / tìm bạn | ✅ mục 10 |
| Ảnh chụp đính kèm/sticker/voice/group | ❌ chưa chụp (fake server chưa hỗ trợ các luồng này) |
| CSS cho attachment panel & input bar | ❌ chưa viết (cần nếu dựng lại khung chat đầy đủ) |
