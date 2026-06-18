# Màn hình Hội thoại 1-1 (KHUNG CHAT)

> Tài liệu **chuyên sâu** cho màn mở 1 cuộc trò chuyện 1-1 (`OlaChatViewActivity`). Phần danh sách hội thoại + danh bạ xem ở [chat/README.md](../chat/README.md). Phòng chat nhóm công cộng xem [phong-chat/README.md](../phong-chat/README.md).

- **Activity:** `chat.ola.vn.activity.OlaChatViewActivity`
- **Layout gốc:** `apktool_out/res/layout/ola_chat_view_resizable_layout.xml`
- **Mở từ:** dòng hội thoại (tab TIN NHẮN), 1 contact (tab DANH BẠ), "Xem Me → Chat", lời mời, hoặc thông báo đẩy.
- **Chức năng:** trao đổi tin nhắn 1-1 (và nhóm — cùng activity, phân biệt qua `C.k()`): gửi text/sticker/ảnh/voice/vị trí/ảnh tự huỷ/YouTube/Ken/VIP; chỉ báo **đang gõ**, trạng thái **gửi/lỗi/đã xem**; menu kết bạn–chặn–xem trang; ngăn cài đặt (tắt thông báo, đổi hình nền).

---

## 1. Cây layout (include lồng nhau)

```
ola_chat_view_resizable_layout            SoftKeyLinearLayout #softKeyResizableViewLayout (co giãn theo bàn phím)
└─ ola_chat_view_and_drawer_layout        DrawerLayout #chatDrawerLayout
   ├─ ola_chat_view_and_action_bar_layout (FrameLayout — nội dung chính)
   │  ├─ ola_chat_view_layout             (paddingTop 42dp)
   │  │  ├─ ola_chat_message_list_layout            ← list bong bóng + đang gõ + dải ngày (mục 3)
   │  │  └─ chatInputAndAttachmentViewLayout        (bg_chat_input_with_top_border)
   │  │     ├─ ola_chat_message_input_layout        ← ô nhập + nút 👍/Gửi (mục 8)
   │  │     └─ ola_chat_message_attachment_layout   ← toolbar 7 nút đính kèm (mục 9)
   │  └─ ola_chat_view_top_action_bar_layout        ← header (overlay trên cùng, mục 2)
   ├─ left_drawer    RelativeLayout 240dp   #leftSliderListView   ← CÀI ĐẶT hội thoại (mục 11)
   ├─ right_drawer   FrameLayout   240dp   #rightSliderListView  ← thành viên nhóm + FAB thêm bạn
   └─ chatAttachmentFrameLayout   đáy 100dp (ẩn)                  ← panel đính kèm trượt lên (mục 9)
```

> `SoftKeyLinearLayout` tự co chiều cao khi bàn phím/panel đính kèm bật lên. Action bar **overlay** lên trên list (list có `paddingTop 42dp` để chừa chỗ).

---

## 2. Header — `ola_chat_view_top_action_bar_layout.xml`

LinearLayout ngang `olaTopActionBarViewLayout`, nền action bar xanh `#7CB342` (`defaultStyle.actionBar.background`).

| View | id | Ghi chú |
|------|----|---------|
| Nút back | `olaActionBarBackImageView` | `ic_action_back`, centerInside; badge số chưa đọc `olaActionBarBackNotificationTextView` (ẩn) |
| VIP | `vipIconImageView` | padding 4dp — ẩn nếu đối phương không VIP |
| **Tên** người/nhóm | `olaActionBarTitleTextView` | `#FFFFFF`, `text.button` (đậm ~14sp), 1 dòng `ellipsize=end` |
| **Trạng thái** | `olaActionBarSubTitleTextView` | `#B3FFFFFF` caption 12sp — **ẩn mặc định**; hiện "vừa đăng nhập/đăng xuất" hoặc "đang trả lời…" |
| Nút text | `olaActionBarButtonTextView` | ẩn mặc định |
| Nút thông báo | `olaActionBarButtonImageView` | `ic_action_notification` 48dp, ẩn — đổi `ic_action_notification_mute` khi đã tắt thông báo |
| Nút **⋮** | `olaActionBarMoreButtonImageView` | `ic_more_white` 48dp — mở menu trong cuộc chat (mục 10) |

> Tên + trạng thái nằm trong cột `olaActionBarTitleViewLayout` (flex 1, marginLeft 8dp). Trạng thái lấy từ `message_contact_status_online` = "%s vừa đăng nhập" / `message_contact_status_offline` = "%s vừa đăng xuất", hoặc "đang trả lời…" khi nhận sự kiện typing.

---

## 3. Vùng danh sách tin — `ola_chat_message_list_layout.xml`

| Thành phần | id | Mô tả |
|------------|----|-------|
| List bong bóng | `lvBubbleList` | `ListView` style `list.noDivider` |
| **Đang gõ** | `txtTypingLinear` | dải đáy nền đen mờ 25%, minHeight 24dp: `txtTypingState` chữ **nghiêng** trắng + animation `imgEditAnimation` (`edit_typing_animation`) + `txtNewMessage` (mũi tên `ic_new_incom_message`) |
| **Nút cuộn xuống** | `scrollDownIndicatorView` | 48×36dp góc phải-dưới, nền trắng mờ bo tròn, `icon_down_indicator` — ẩn khi đang ở đáy |
| **Dải ngày nổi** | `txtMessageTime` | nổi giữa-trên, nền `bg_time_line` (đen mờ 25%, bo 3pt), chữ trắng caption 12sp — hiện khi cuộn |

Ngoài ra giữa các cụm tin khác ngày có **vạch ngăn ngày** riêng `chat_item_time_line.xml`: 2 đường kẻ mảnh `#1F000000` 2 bên + pill `bg_time_line` chứa `messageTimeText`.

---

## 4. Cấu trúc 1 DÒNG tin nhắn

2 layout riêng cho **nhận / gửi**, cùng id gốc `chatMessageBubbleView` (LinearLayout **dọc**, padding ngang 8dp / dọc 1dp). **Giờ nằm ở TRÊN** bong bóng (canh giữa), không phải bên cạnh.

### 4.1. Tin ĐẾN — `incoming_chat_message_layout.xml` (`gravity=left`)
```
chatMessageBubbleView (vertical, left)
├─ messageSeparatorView        View 8dp, ẩn — chèn khi đổi cụm tin
├─ chatMessageTimeTextView     GIỜ, canh giữa, caption 12sp, #42000000 (hint)
├─ messageSenderTextview       tên người gửi — CHỈ chat nhóm, marginLeft 48dp, body1 14sp, #8A000000
├─ LinearLayout (horizontal)
│  ├─ senderAvatarImageView    avatar 32dp (chỉ tin ĐẾN), ic_contact_photo, marginRight 4dp
│  ├─ include chat_message_content_layout   ← bong bóng (mục 5)
│  └─ bookmarkImageButton      ⭐ ic_star_gray 24dp (invisible — đánh dấu tin)
└─ readPeopleImageView         16dp, marginLeft 36dp, ic_message_sent (ẩn)
```

### 4.2. Tin ĐI — `outgoing_chat_message_layout.xml` (`gravity=right`)
```
chatMessageBubbleView (vertical, right)
├─ messageSeparatorView
├─ chatMessageTimeTextView     giờ, canh giữa
├─ LinearLayout (horizontal, wrap)
│  ├─ bookmarkImageButton      ⭐ (invisible)
│  ├─ resendImageView          btn_resend_d 32dp (ẩn → hiện khi gửi LỖI)
│  ├─ sendingProgressBar       spinner 24dp (ẩn → hiện khi ĐANG GỬI)
│  └─ include chat_message_content_layout   ← bong bóng (KHÔNG avatar)
├─ readPeopleImageView         16dp, ic_contact_photo (ẩn — avatar người ĐÃ XEM)
└─ failReasonTextView          "Không thể gởi tin nhắn", colorOlaAccent, caption (ẩn)
```

---

## 5. Bong bóng nội dung — `chat_message_content_layout.xml` (DÙNG CHUNG)

```
LinearLayout (vertical)
└─ chatMessageTextContentView   background=@drawable/chat_incoming  (mặc định trong XML)
   minWidth 32dp, minHeight 32dp
   ├─ messageTextContentTextview   OlaTextView, subhead 16sp, maxWidth 400dp
   └─ chatAttachmentViewStub       ViewStub (ẩn) — bơm layout media/sticker/voice… khi cần, marginTop 8dp
```

- Tin **đến** giữ nền `chat_incoming` (trắng); tin **đi** code đổi sang `chat_outgoing` (xanh nhạt).
- 9-patch: `chat_incoming.9` / `chat_outgoing.9` + biến thể `_top` / `_mid` / `_bottom` cho các tin **liền nhau cùng người** (bo góc nối), và `chat_outgoing_fail.9` khi gửi lỗi.

| | Drawable | Màu |
|---|---|---|
| Đến (trái) | ![in](images/icons/chat_incoming.9.png) `chat_incoming.9` | trắng `#FFFFFF` |
| Đi (phải) | ![out](images/icons/chat_outgoing.9.png) `chat_outgoing.9` | xanh nhạt `#DCEDC8` |

---

## 6. Trạng thái gửi (tin đi)

| Trạng thái | Hiển thị |
|------------|----------|
| Đang gửi | `sendingProgressBar` (spinner) hiện cạnh trái bong bóng |
| **Lỗi** | `resendImageView` ![resend](images/icons/btn_resend_d.png) + `failReasonTextView` = "Không thể gởi tin nhắn"; bong bóng đổi `chat_outgoing_fail.9` |
| Đã gửi / đã xem | `readPeopleImageView` hiện — ![sent](images/icons/ic_message_sent.png) `ic_message_sent` hoặc **avatar người đã xem** |

---

## 7. Các loại bong bóng (bơm vào `chatAttachmentViewStub`)

| Loại | Layout | Chi tiết hiển thị |
|------|--------|-------------------|
| **Text** | `chat_message_content_layout` | chữ subhead 16sp, maxWidth 400dp |
| **Nhiều ảnh** | `chat_attached_media_layout` | khung **360dp**, tối đa 5 ô (2 trên + 3 dưới); ô thứ 5 phủ `moreMediaTextView` "+N" (nền đen mờ 60%, chữ 32sp) khi còn ảnh |
| **Sticker** | `chat_sticker_layout` | ![play] `stickerImageView` cao **120dp** fitCenter + `stickerProgressBar`; `addStickerImageView` (➕ thêm bộ sticker) |
| **Ghi âm** | `chat_voice_message_item` | khung **164×40dp**: ![play](images/icons/ic_play_media.png) `voicePlayIconImageView` + đường sóng `voiceLineView` + thời lượng `voiceDurationTextView` "0:00" + `voiceDurationProgressBar` (`outgoing_voice_playback_progress`) |
| **Vị trí** | `chat_message_location_item` | thumbnail bản đồ **164×164dp** (`bg_shadown_border`) + `addressTextView` (địa chỉ, body1) |
| **Ảnh tự huỷ (snap pic)** | `chat_snap_pic_item` | ![snap](images/icons/icon_snap_pic.png) `icon_snap_pic` + đếm ngược `snapPicTimeRemainTextView` (đậm, nền `bg_progress_player`) + `timeRemainProgress` + mẹo `snapPicTipTextView` = **"Chạm vào để xem"**. Xem 1 lần rồi tự xoá |
| **YouTube** | `chat_youtube_attachment_layout` | thumbnail + ![play](images/icons/ic_play_media.png) play + tiêu đề `meYouTubeTitle` + thời lượng `meYouTubeDuration` (overlay đen mờ 60% đáy) |
| **Chuyển KEN** | `chat_ken_transferred_layout` | ![ken](images/icons/ic_ken_white.png) `ic_ken_white` trong vòng tròn xanh 16dp + `kenAmountTextView` **32sp** headline (số xu tặng) |
| **Trao đổi VIP** | `chat_sent_tradding_vip_layout` / `chat_received_tradding_vip_layout` | thẻ gửi/nhận quà VIP |
| **Trạng thái / Thẻ người lạ** | `chat_status_bubble_layout` | xem mục 7.1 |
| **RSS** | `chat_rss_layout` | thẻ tin RSS |
| **Vạch ngày** | `chat_item_time_line` | mục 3 |
| **Lời mời vào nhóm** | `chat_invitation_to_chatgroup_layout` | thẻ mời vào chat nhóm |

### 7.1. Thẻ giới thiệu người lạ — `chat_status_bubble_layout.xml`

Khi **người lạ nhắn lần đầu**, bong bóng đầu là 1 **thẻ hồ sơ** (nền trắng viền trên-dưới, margin 16dp):
```
├─ coverImageView                 ảnh bìa (OlaRatioImageView, centerCrop)
│  └─ overlay trắng mờ 60% (dưới):
│     ├─ imgMeAvatarThumbnail 56dp + imgDeviceType 12dp (góc)
│     └─ cột thông tin:
│        ├─ vipIconImageView + vipTitleTextView (tên) + verificationImageView (tích)
│        ├─ ageTextView           tuổi
│        ├─ joinOlaTextView       ngày tham gia Ola
│        ├─ fanTextView           số người quan tâm
│        ├─ antiFanTextView       số anti-fan
│        └─ statusMessageTextView trạng thái (tối đa 3 dòng)
├─ attachedPhotoListView          HListView ảnh đính kèm 164dp (ẩn nếu trống)
├─ addFriendCommandViewLayout     [ Đóng ] [ Chặn ]  …  [ Kết bạn ➕ (xanh) ]
└─ unblockViewLayout              cảnh báo "Bạn đang chặn người này…" + [ Bỏ chặn ]
```
- Hàng nút: **Đóng** (`closeTextView`) · **Chặn** (`blockTextView`) · **Kết bạn** (`addFriendButton`, nền xanh `button.green`, icon `ic_action_add_small`).
- Khi đã chặn → ẩn hàng trên, hiện `unblockViewLayout`: cảnh báo `message_chat_blocking_warning` = "Bạn đang chặn người này. Bạn cần bỏ chặn trước khi trò chuyện với họ" + nút **Bỏ chặn**.

---

## 8. Thanh nhập — `ola_chat_message_input_layout.xml`

```
chatTextInputLayout (horizontal, gravity bottom, minHeight 36dp, padding 8/2dp)
├─ chatMessageEditText   EditText flex-1, maxLines 1, inputType textCapSentences, imeOptions actionSend
└─ FrameLayout 36dp (phải)
   ├─ sendTextView   "Gửi"  #7CB342  (ẩn mặc định)
   └─ likeButton     smiley_35  (hiện mặc định)
```

- **Ô trống** → hiện nút **👍** ![like](images/icons/smiley_35.png) `smiley_35` (gửi nhanh 1 like/sticker).
- **Đang gõ** (có chữ) → đổi thành nút **"Gửi"** màu `#7CB342`. Chuyển đổi có animation `disappear_animation`/`appear_animation` 200ms.
- Bấm Gửi → `a(text, 0, true)` → thêm bong bóng đi (đang gửi) → server ACK; lỗi thì hiện `resendImageView`.

---

## 9. Toolbar đính kèm — `ola_chat_message_attachment_layout.xml`

7 nút bằng nhau (`layout_weight 1`, cao 36dp):

| # | id | Icon (thường / chọn) | Drawable | Chức năng |
|---|----|----|----|----------|
| 1 | `quickReplyImageButton` | ![qr](images/icons/ic_quick_reply_gray.png) | `ic_quick_reply_gray` | Trả lời nhanh (ẩn mặc định) |
| 2 | `chatTextSmileyImageButton` | ![sm](images/icons/ic_smiley.png) ![sm2](images/icons/ic_smiley_selected.png) | `btn_smiley_selector` (`ic_smiley` / `_selected`) | Biểu cảm / emoji |
| 3 | `kulImageButton` | ![kul](images/icons/ic_kul.png) ![kul2](images/icons/ic_kul_selected.png) | `btn_kul_selector` (`ic_kul` / `_selected`) | **KUL** (sticker động của Ola) |
| 4 | `cameraImageButton` | ![cam](images/icons/ic_camera.png) ![cam2](images/icons/ic_camera_selected.png) | `btn_camera_selector` (`ic_camera` / `_selected`) | Chụp ảnh / quay |
| 5 | `localPhotoImageButton` | ![loc](images/icons/ic_local.png) ![loc2](images/icons/ic_local_selected.png) | `btn_local_photo_selector` (`ic_local` / `_selected`) | Ảnh trong máy |
| 6 | `voiceImageButton` | ![v](images/icons/ic_voice.png) ![v2](images/icons/ic_voice_selected.png) | `btn_voice_selector` (`ic_voice` / `_selected`) | Ghi âm (voice) |
| 7 | `moreImageButton` | ![mo](images/icons/ic_more.png) ![mo2](images/icons/ic_more_selected.png) | `btn_more_selector` (`ic_more` / `_selected`) | Khác (vị trí, YouTube, snap pic, KEN, VIP…) |

> Mỗi nút có 2 bản: bình thường (xám) + `_selected` (xanh `#7CB342`) khi tab đang mở.

**Kích thước thật** (`ola_chat_message_attachment_layout.xml`): thanh cao `metric.36dp`, padding L/R `8dp`, T/B `2dp`; mỗi nút `layout_weight=1` (chia đều), `scaleType=centerInside`, nền trong suốt; padding nút: smiley/kul/camera = `2dp`, local/voice/more = `4dp`.

> ⚠️ **Nút #1 `quickReplyImageButton` có `visibility="gone"`** → mặc định **chỉ 6 nút hiển thị** (Biểu cảm · KUL · Máy ảnh · Ảnh · Ghi âm · Khác). Đây chính là 6 nút bản web đang dựng.

### 9.1. Hành vi từng nút (`OlaChatViewActivity.onClick`, ~dòng 3050)

Biến trạng thái: `this.ae` = tab panel đang chọn · `this.M.a()` = panel đang mở (bấm lại để toggle / chỉ ẩn bàn phím) · `f(false)` = ẩn bàn phím · `j(false)` = mở panel `chatAttachmentFrameLayout`.

| Nút | id | Cử chỉ | Hành vi |
|-----|----|--------|---------|
| Biểu cảm | `chatTextSmileyImageButton` | click | `ae=1` → mở panel **Biểu cảm** (emoji); nếu panel đang mở thì chỉ ẩn bàn phím |
| KUL | `kulImageButton` | click | ẩn bàn phím, `ae=2` → panel **KUL** (sticker động) |
| Máy ảnh | `cameraImageButton` | click | `an()` → xin quyền `CAMERA` → `ao()` **mở camera trực tiếp** (KHÔNG qua panel) |
| Ảnh | `localPhotoImageButton` | click | `U()` → xin quyền `READ_EXTERNAL_STORAGE` → `ae=3` → panel **lưới ảnh trong máy** |
| Ghi âm | `voiceImageButton` | click | ẩn bàn phím, `ae=4` → panel **Ghi âm** |
| Khác | `moreImageButton` | click | **Nếu ô nhập có chữ → GỬI tin** (`a(text,0,true)`); nếu trống → `ae=5` → panel **Khác** |
| Trả lời nhanh (ẩn) | `quickReplyImageButton` | click | `au()` — bảng trả lời nhanh (chỉ hiện khi được bật, mặc định `gone`) |

→ Panel chung `chatAttachmentFrameLayout` trượt lên thay bàn phím, nội dung theo `ae`: **1** Biểu cảm · **2** KUL · **3** Ảnh máy · **4** Ghi âm · **5** Khác. Tab **Khác** gồm: vị trí, YouTube, snap pic, KEN, VIP… (chi tiết panel ở [chat/README.md §9](../chat/README.md)).

### 9.2. Đối chiếu web ([AttachmentBar.tsx](../../../../web/src/pages/chat/components/AttachmentBar.tsx))

- ✅ Đúng **6 nút** khớp tập nút hiện mặc định của APK (quick-reply ẩn); có đủ icon thường + `_selected`.
- ❌ Web cho **mọi nút toggle panel tab** (kể cả **Máy ảnh**) → APK **Máy ảnh mở camera trực tiếp** (`ao()`), không qua panel.
- ❌ Web nút **"Khác"** chỉ mở panel → APK **"Khác" kiêm nút Gửi** khi ô nhập có chữ.
- ⚠️ Web tab "Ảnh máy" và "Máy ảnh" tách 2 nút riêng; APK: nút Ảnh = panel tab 3, nút Máy ảnh = camera activity (khác cơ chế).

---

## 10. Menu ⋮ trong cuộc chat (`OlaChatViewActivity`, code ~dòng 2210)

Bấm ⋮ (hoặc avatar đối phương) → popup danh sách:

| Mục | String (VI) | Hành động |
|-----|-------------|-----------|
| Kết bạn | `string_make_friend` = "Kết bạn" | gửi lời mời (ẩn nếu đã là bạn) |
| Chat | `string_chat` = "Chat" | mở/đi tới khung chat |
| **Xem Me** | `string_view_me` = "Xem Me" | mở trang cá nhân (`me.c.a(...)`) |
| Chặn | `string_block` = "Chặn" | → dialog xác nhận (ẩn nếu đã là bạn) |
| Chat nhóm | `string_chat_group` = "Chat nhóm" | tạo/mời vào nhóm |

> Dialog chặn: tiêu đề `message_block_chat_title` = "Chặn tin nhắn", nội dung `message_block_chat_confirm_format` = "Bạn có muốn chặn tin nhắn từ @<nick> không?", nút **Chặn** / **Huỷ** — xem [chat/README.md §8.3](../chat/README.md).

---

## 11. Ngăn cài đặt hội thoại — `left_drawer`

`leftSliderListView` (240dp) liệt kê cài đặt cuộc trò chuyện:

| Mục | String (VI) | Hành động |
|-----|-------------|-----------|
| **Tắt thông báo** | `string_mute_notification` = "Tắt thông báo" | mở chọn thời lượng: `string_mute_until_i_turn_it_back_on` = "Đến khi tôi bật lại" / `string_turn_off_mute` = "Tắt chế độ im lặng". Khi đang tắt → header dùng icon `ic_action_notification_mute` |
| **Đổi hình nền Chat** | `string_set_conversation_wallpaper` = "Thay đổi hình nền Chat" | chọn ảnh nền → "Đang đổi hình nền…" → `message_change_chat_background_success` |
| **Xoá hình nền Chat** | `string_clear_conversation_wallpaper` = "Xóa hình nền Chat" | gỡ hình nền |

> `right_drawer` (240dp, `rightSliderListView`) dùng cho **chat nhóm**: danh sách thành viên + FAB ➕ `ic_add_friend` (`rightMenuAddMemberButton`) để thêm bạn vào nhóm.

---

## 12. Luồng realtime

| Sự kiện | Cơ chế (trích activity) |
|---------|--------------------------|
| **Phát "đang gõ"** | `onTextChanged`: nếu có ký tự mới và **>1500ms** kể từ lần trước → emit. 1-1: `OlaApplication.b.g(peerId)`; nhóm: `OlaApplication.b.f(groupId)` (throttle 1.5s) |
| **Nhận "đang gõ"** | hiển thị `txtTypingLinear` + `message_chat_typing` = "%s đang trả lời…" (fallback `message_chat_typing_message` = "Đang trả lời…") |
| **Gửi tin** | bong bóng đi hiện ngay (sending spinner) → ACK đổi sang đã gửi (`ic_message_sent`) → lỗi hiện resend + `chat_outgoing_fail.9` |
| **Đã xem** | `readPeopleImageView` đổi thành avatar người đã đọc |
| **Tin mới đến khi đang cuộn lên** | `txtNewMessage` + nút `scrollDownIndicatorView` |

---

## 13. Strings (đa ngôn ngữ)

| Resource | EN | VI |
|----------|----|----|
| `message_chat_typing` | %s is typing... | %s đang trả lời... |
| `message_chat_typing_message` | Typing... | Đang trả lời... |
| `message_fail_send_message` | Send message fail | Không thể gởi tin nhắn |
| `message_snap_pic_tip` | Touch to view | Chạm vào để xem |
| `message_chat_blocking_warning` | You blocked this person. You need to unblock her/him before chatting | Bạn đang chặn người này. Bạn cần bỏ chặn trước khi trò chuyện với họ |
| `string_make_friend` | Add friend | Kết bạn |
| `string_view_me` | View Me | Xem Me |
| `string_chat_group` | Chat group | Chat nhóm |
| `string_mute_notification` | Mute notification | Tắt thông báo |
| `string_mute_until_i_turn_it_back_on` | Until I turn it back on | Đến khi tôi bật lại |
| `string_turn_off_mute` | Turn off mute | Tắt chế độ im lặng |
| `string_set_conversation_wallpaper` | Change conversation wallpaper | Thay đổi hình nền Chat |
| `string_clear_conversation_wallpaper` | Clear conversation wallpaper | Xóa hình nền Chat |
| `string_close` | Close | Đóng |
| `message_contact_status_online` | %s just logged in | %s vừa đăng nhập |
| `message_contact_status_offline` | %s just logged out | %s vừa đăng xuất |

---

## 14. CSS — dựng lại trên web

```css
/* ===== Khung hội thoại ===== */
.ola-chat-screen { display: flex; flex-direction: column; height: 100%; background: #ECE5DD; }
.ola-chat-screen__bar {                         /* header */
  display: flex; align-items: center; gap: 8px;
  height: 48px; padding: 0 8px; background: #7CB342; color: #fff;
}
.ola-chat-screen__title { flex: 1; min-width: 0; }
.ola-chat-screen__name { font-size: 14px; font-weight: bold; color: #fff;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.ola-chat-screen__status { font-size: 12px; color: rgba(255,255,255,.70); }  /* online / đang gõ */

/* ===== List tin ===== */
.ola-msglist { flex: 1; overflow-y: auto; padding: 4px 0; display: flex; flex-direction: column; }
.ola-msg { display: flex; flex-direction: column; padding: 1px 8px; }
.ola-msg__time { align-self: center; font-size: 12px; color: rgba(0,0,0,.26); margin-top: 4px; }  /* giờ TRÊN bong bóng */
.ola-msg__row { display: flex; align-items: flex-end; gap: 4px; }
.ola-msg--in  { align-items: flex-start; }
.ola-msg--out { align-items: flex-end; }
.ola-msg__avatar { width: 32px; height: 32px; border-radius: 50%; object-fit: cover; }  /* chỉ tin ĐẾN */

/* ===== Bong bóng ===== */
.ola-bubble { max-width: 400px; min-width: 32px; min-height: 32px;
  padding: 8px 12px; border-radius: 8px; font-size: 16px; color: rgba(0,0,0,.87); }
.ola-bubble--in  { background: #FFFFFF; }                 /* chat_incoming */
.ola-bubble--out { background: #DCEDC8; }                 /* chat_outgoing */
.ola-bubble--fail { background: #F8D7D7; }                /* chat_outgoing_fail */

/* trạng thái gửi (tin đi) */
.ola-msg__sending { width: 24px; height: 24px; }         /* spinner */
.ola-msg__resend  { width: 32px; height: 32px; }         /* btn_resend_d */
.ola-msg__fail    { align-self: flex-end; font-size: 12px; color: #FF5252; }
.ola-msg__seen    { width: 16px; height: 16px; margin-top: 4px; }  /* ic_message_sent / avatar */

/* ===== Thanh nhập ===== */
.ola-chat-input { display: flex; align-items: flex-end; min-height: 36px;
  padding: 2px 8px; background: #fff; border-top: 1px solid rgba(0,0,0,.12); }
.ola-chat-input__field { flex: 1; border: none; background: none; font-size: 16px;
  line-height: 36px; max-height: 36px; color: rgba(0,0,0,.87); }
.ola-chat-input__field::placeholder { color: rgba(0,0,0,.38); }
.ola-chat-input__action { width: 36px; height: 36px; margin-left: 4px;
  display: flex; align-items: center; justify-content: center; background: none; border: none; }
.ola-chat-input__like { width: 28px; height: 28px; }      /* ô trống */
.ola-chat-input__send { display: none; color: #7CB342; font-size: 16px; }  /* đang gõ */
.ola-chat-input.is-typing .ola-chat-input__like { display: none; }
.ola-chat-input.is-typing .ola-chat-input__send { display: inline-block; }

/* ===== Toolbar đính kèm ===== */
.ola-attach-toolbar { display: flex; height: 36px; padding: 2px 8px; background: #fff; }
.ola-attach-toolbar__btn { flex: 1; display: flex; align-items: center; justify-content: center;
  background: none; border: none; }
.ola-attach-toolbar__btn img { width: 24px; height: 24px; }
```

```html
<div class="ola-chat-screen">
  <header class="ola-chat-screen__bar">
    <img src="images/icons/ic_action_back.png" width="24">
    <div class="ola-chat-screen__title">
      <div class="ola-chat-screen__name">thuhuong</div>
      <div class="ola-chat-screen__status">đang trả lời…</div>
    </div>
    <img src="images/icons/ic_more_white.png" width="24">
  </header>

  <div class="ola-msglist">
    <!-- tin đến -->
    <div class="ola-msg ola-msg--in">
      <span class="ola-msg__time">09:30</span>
      <div class="ola-msg__row">
        <img class="ola-msg__avatar" src="images/icons/ic_contact_photo.png">
        <div class="ola-bubble ola-bubble--in">Chào bạn 👋</div>
      </div>
    </div>
    <!-- tin đi đã xem -->
    <div class="ola-msg ola-msg--out">
      <span class="ola-msg__time">09:31</span>
      <div class="ola-msg__row">
        <div class="ola-bubble ola-bubble--out">Mình khỏe, cảm ơn nhé!</div>
      </div>
      <img class="ola-msg__seen" src="images/icons/ic_message_sent.png">
    </div>
  </div>

  <div class="ola-chat-input is-typing">
    <input class="ola-chat-input__field" placeholder="Viết tin nhắn cho thuhuong">
    <button class="ola-chat-input__action">
      <img class="ola-chat-input__like" src="images/icons/smiley_35.png">
      <span class="ola-chat-input__send">Gửi</span>
    </button>
  </div>

  <div class="ola-attach-toolbar">
    <button class="ola-attach-toolbar__btn"><img src="images/icons/ic_smiley.png"></button>
    <button class="ola-attach-toolbar__btn"><img src="images/icons/ic_kul.png"></button>
    <button class="ola-attach-toolbar__btn"><img src="images/icons/ic_camera.png"></button>
    <button class="ola-attach-toolbar__btn"><img src="images/icons/ic_local.png"></button>
    <button class="ola-attach-toolbar__btn"><img src="images/icons/ic_voice.png"></button>
    <button class="ola-attach-toolbar__btn"><img src="images/icons/ic_more.png"></button>
  </div>
</div>
```

---

## 15. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Action bar | nền `#7CB342`, cao 48dp |
| Tên / trạng thái | `#FFFFFF` đậm 14sp / `rgba(255,255,255,.70)` caption 12sp |
| Bong bóng đến | nền trắng `#FFFFFF`, chữ `rgba(0,0,0,.87)` 16sp |
| Bong bóng đi | nền xanh nhạt `#DCEDC8` |
| Bong bóng lỗi | `chat_outgoing_fail.9` (hồng nhạt) |
| Giờ tin | caption 12sp, `rgba(0,0,0,.26)` — **canh giữa, phía trên** bong bóng |
| Avatar tin đến | 32×32dp bo tròn |
| maxWidth bong bóng | 400dp |
| Sticker | cao 120dp |
| Voice | 164×40dp |
| Vị trí | 164×164dp |
| Khung nhiều ảnh | 360dp (2+3 ô) |
| Ô nhập | minHeight 36dp; trống=👍 `smiley_35`, gõ="Gửi" `#7CB342` |
| Toolbar đính kèm | 7 nút cao 36dp |
| Drawer trái/phải | 240dp |
| Throttle typing | 1500ms |

---

## 16. Icon & drawable thật (trích từ APK)

> Copy sẵn vào [images/icons/](images/icons/). Tên = tên resource trong `apktool_out/res/drawable-*` / dump `images/`.

| UI | Icon | Drawable |
|----|------|----------|
| Back | ![back](images/icons/ic_action_back.png) | `ic_action_back` |
| Menu ⋮ | ![more](images/icons/ic_more_white.png) | `ic_more_white` |
| Avatar mặc định | ![avatar](images/icons/ic_contact_photo.png) | `ic_contact_photo` |
| Nút 👍 / gửi nhanh | ![like](images/icons/smiley_35.png) | `smiley_35` (`likeButton`) |
| Nút Gửi | — | text "Gửi" `#7CB342` (`sendTextView`) |
| Bong bóng đến | ![in](images/icons/chat_incoming.9.png) | `chat_incoming.9` (9-patch) |
| Bong bóng đi | ![out](images/icons/chat_outgoing.9.png) | `chat_outgoing.9` (9-patch) |
| Đã gửi/đã xem | ![sent](images/icons/ic_message_sent.png) | `ic_message_sent` |
| Gửi lại (lỗi) | ![resend](images/icons/btn_resend_d.png) | `btn_resend_d` |
| Đánh dấu tin | ![star](images/icons/ic_star_gray.png) | `ic_star_gray` |
| Tin mới đến | ![new](images/icons/ic_new_incom_message.png) | `ic_new_incom_message` |
| Play (voice/youtube) | ![play](images/icons/ic_play_media.png) | `ic_play_media` |
| Ảnh tự huỷ | ![snap](images/icons/icon_snap_pic.png) | `icon_snap_pic` |
| Chuyển KEN | ![ken](images/icons/ic_ken_white.png) | `ic_ken_white` |
| Thêm thành viên (nhóm) | ![add](images/icons/ic_add_friend.png) | `ic_add_friend` |
| Kết bạn (thẻ người lạ) | ![addsm](images/icons/ic_action_add_small.png) | `ic_action_add_small` |
| Loại thiết bị | ![dev](images/icons/ic_device_type_android.png) | `ic_device_type_android` / `_apple` |
| Cuộn xuống đáy | ![down](images/icons/icon_down_indicator.png) | `icon_down_indicator` |
| Bong bóng gửi lỗi | ![fail](images/icons/chat_outgoing_fail.9.png) | `chat_outgoing_fail.9` |
| Thông báo (bật) | ![noti](images/icons/ic_action_notification.png) | `ic_action_notification` |
| Đã tắt thông báo | ![mute](images/icons/ic_action_notification_mute.png) | `ic_action_notification_mute` |

### Toolbar đính kèm (7 nút — bản thường / `_selected`)

| Nút | Thường | Đang chọn | Drawable |
|-----|--------|-----------|----------|
| Trả lời nhanh | ![qr](images/icons/ic_quick_reply_gray.png) | — | `ic_quick_reply_gray` |
| Biểu cảm | ![sm](images/icons/ic_smiley.png) | ![sm2](images/icons/ic_smiley_selected.png) | `ic_smiley` / `ic_smiley_selected` |
| KUL | ![kul](images/icons/ic_kul.png) | ![kul2](images/icons/ic_kul_selected.png) | `ic_kul` / `ic_kul_selected` |
| Máy ảnh | ![cam](images/icons/ic_camera.png) | ![cam2](images/icons/ic_camera_selected.png) | `ic_camera` / `ic_camera_selected` |
| Ảnh máy | ![loc](images/icons/ic_local.png) | ![loc2](images/icons/ic_local_selected.png) | `ic_local` / `ic_local_selected` |
| Ghi âm | ![v](images/icons/ic_voice.png) | ![v2](images/icons/ic_voice_selected.png) | `ic_voice` / `ic_voice_selected` |
| Khác | ![mo](images/icons/ic_more.png) | ![mo2](images/icons/ic_more_selected.png) | `ic_more` / `ic_more_selected` |

### Bong bóng 9-patch (gồm biến thể nối nhóm)

| | Đầu cụm | Giữa | Cuối |
|---|---|---|---|
| Đến | ![it](images/icons/chat_incoming_top.9.png) `_top` | ![im](images/icons/chat_incoming_mid.9.png) `_mid` | ![ib](images/icons/chat_incoming_bottom.9.png) `_bottom` |
| Đi | ![ot](images/icons/chat_outgoing_top.9.png) `_top` | ![om](images/icons/chat_outgoing_mid.9.png) `_mid` | ![ob](images/icons/chat_outgoing_bottom.9.png) `_bottom` |

---

## 17. Checklist độ phủ tài liệu

| Hạng mục | Trạng thái |
|----------|-----------|
| Cây layout (include) | ✅ mục 1 |
| Header (back/tên/trạng thái/⋮/mute) | ✅ mục 2 |
| List tin + đang gõ + cuộn xuống + dải ngày | ✅ mục 3 |
| Cấu trúc dòng tin đến / đi | ✅ mục 4 |
| Bong bóng nội dung + 9-patch | ✅ mục 5 |
| Trạng thái gửi (đang gửi/lỗi/đã xem) | ✅ mục 6 |
| 13 loại bong bóng (text/ảnh/sticker/voice/vị trí/snap/youtube/ken/vip/thẻ lạ/rss/ngày/mời nhóm) | ✅ mục 7 |
| Thẻ giới thiệu người lạ (close/block/add friend/unblock) | ✅ mục 7.1 |
| Thanh nhập + toggle 👍/Gửi | ✅ mục 8 |
| Toolbar đính kèm 7 nút + panel 6 tab | ✅ mục 9 |
| Menu ⋮ trong cuộc chat | ✅ mục 10 |
| Drawer cài đặt (mute/wallpaper) + drawer nhóm | ✅ mục 11 |
| Luồng realtime (typing 1.5s / send / seen) | ✅ mục 12 |
| Strings (vi/en) | ✅ mục 13 |
| CSS dựng lại web | ✅ mục 14 |
| Token UI | ✅ mục 15 |
| Icon & drawable thật | ✅ mục 16 |
| Ảnh chụp màn (thiết bị thật) | ⏳ chưa chụp — xem tạm ảnh khung chat ở [chat/README.md](../chat/README.md) |
