# Màn hình Cài đặt (Settings)

- **Activity:** `chat.ola.vn.activity.OlaAppSettingActivity` — `jadx_out/sources/chat/ola/vn/activity/OlaAppSettingActivity.java`
- **Layout:** `apktool_out/res/layout/app_config_layout.xml` (+ `app_config_category_item_layout.xml`, `app_config_item_layout.xml`)
- **Vào từ:** mục **"Cài đặt"** trong tab **Ứng dụng** (string `general_tab_setting` = "Cài đặt")
- **Lưu giá trị:** static trong `chat.ola.vn.c.x`, persist qua `chat.ola.vn.h.b`; mỗi thay đổi gọi `OlaAppSettingActivity.a(id, value)`

> **Khác PreferenceActivity chuẩn:** Ola tự dựng bằng **`ExpandableListView`** (`lvAppConfigList`) — danh sách **5 nhóm** có thể bung/gập, mỗi mục là 1 `entry.a.c` (kiểu toggle / list / action / info). Tự build trong `B()`, adapter `chat.ola.vn.b.b` (BaseExpandableListAdapter).

> Dựng từ **code + XML** (chưa chụp ảnh). Icon đã trích vào [images/icons/](images/icons/).

---

## 1. Bố cục màn (`app_config_layout.xml`)

```
FrameLayout
├─ ExpandableListView  lvAppConfigList   (paddingTop 42dp, margin ngang 16dp, marginBottom 64dp,
│                                          groupIndicator=null, list.noDivider)   ← 5 NHÓM CÀI ĐẶT
├─ LinearLayout (đáy, cao 64dp, nền bg_white_with_top_border)                     ← THANH FACEBOOK
│   ├─ TextView  message_join_us_on_facebook
│   └─ com.facebook.share.widget.LikeView  fbLikeView
└─ <include> ola_top_action_bar_center_title_layout   ← action bar tiêu đề giữa "Cài đặt" + nút X
```

### Item — tiêu đề nhóm (`app_config_category_item_layout.xml`)
`txtCategoryTitle`: caption **in đậm**, màu **cam `#e79200`**, cao 72dp, nền `bg_me_comment_top_item`.

### Item — 1 dòng cài đặt (`app_config_item_layout.xml`)
```
LinearLayout (ngang, nền bg_me_comment_item)
├─ LinearLayout (vertical, weight 1, margin 8dp)
│   ├─ txtConfigTitle     (body1, đen)              ← tên cài đặt
│   └─ txtConfigSubTitle  (caption, xám #8f8f8f)    ← mô tả
└─ txtConfigAction        (caption, xanh dương #28a1ee, phải)  ← GIÁ TRỊ / trạng thái toggle
```

> `entry.a.c.f` = loại: **0** toggle (on/off) · **1** list (chọn từ mảng) · **2** info · **3/4** action (mở màn khác / dialog). Cột phải `txtConfigAction` hiển thị giá trị hiện tại (list), nút bật/tắt (toggle), hoặc mũi tên (action).

---

## 2. Năm nhóm cài đặt (đầy đủ)

### Nhóm 1 — Tổng quát (`title_general_setting` = "Tổng quát")

| ID | Loại | Tên (VI) | Mô tả (VI) | Giá trị |
|----|------|----------|------------|---------|
| 63 | list | **Âm báo** | Bật tắt âm thanh thông báo | On / Off / Im lặng theo khung giờ (6 lựa chọn) |
| 66 | list | **Kiểu âm báo** | Âm thanh báo tin nhắn | Default / Ola |
| 64 | list | **Thông báo rung** | Rung khi có sự kiện mới | On / Off / Im lặng theo giờ |
| 65 | toggle | **Thông báo đèn** | Nhấp nháy đèn LED | mặc định **bật** |
| 100 | list | **Ngôn ngữ** | Ngôn ngữ hiển thị | Theo máy / Tiếng Việt / English → đổi gọi `x.b()` + "khởi động lại Ola" |
| 45 | action | **Mật khẩu** | Mật khẩu để mở Ola | → `OlaPasscodeSettingActivity` |

### Nhóm 2 — Hiển thị (`title_display_setting` = "Hiển thị")

| ID | Loại | Tên (VI) | Giá trị |
|----|------|----------|---------|
| 67 | toggle | **Thông báo khi có Me mới** | bật |
| 59 | list | **Ảnh đại diện** (kiểu khung) | Vuông / Tròn / Bo góc / Trái tim |
| 93 | list | **Hình nền Ola** | Mặc định / Tuỳ chỉnh → `OlaCropImageActivity` |
| 110 | toggle | **Trình duyệt nhanh** (mở link trong Ola) | bật |
| 101 | list | **Hiển thị video** | Cửa sổ nổi / Toàn màn hình |
| 91 | toggle | **Gợi ý khi nhập liệu** (gợi ý nick/clan khi gõ @ #) | bật |

### Nhóm 3 — Cửa sổ Chat (`title_chat_setting` = "Cửa sổ Chat")

| ID | Loại | Tên (VI) | Giá trị |
|----|------|----------|---------|
| 56 | list | **Thông báo tin nhắn** | Bong bóng chat / Thông báo / Không hiển thị |
| 112 | toggle | **Trả lời nhanh** (câu soạn sẵn) | tắt; cấu hình → `OlaQuickReplyComposerActivity` |
| 86 | list | **Hiệu ứng tin nhắn** | Không / Mờ dần / Bay vào |

### Nhóm 4 — RSS (`title_rss_setting` = "RSS")

| ID | Loại | Tên (VI) | Giá trị |
|----|------|----------|---------|
| 104 | toggle | **Ghi nhớ trang đã xem** | bật |
| 87 | action | **Cỡ chữ** (RSS) | dialog **SeekBar** 0–10 (mặc định 5) |

### Nhóm 5 — Thông tin Ola (`title_ola_info` = "Thông tin Ola")

| ID | Loại | Tên (VI) | Hành động |
|----|------|----------|-----------|
| 19 | action | **Đánh giá** | mở Google Play (`?write_review=true`) |
| 20 | action | **Ola Beta** | mở URL beta |
| 92 | info | **Thông tin phiên bản** | Phiên bản + Mã + Giao thức 5.10.19 + Nguồn + Ngày phát hành + Bản quyền (bấm nhiều lần → debug console) |
| 108 | action | **Đăng xuất mọi nơi** | → dialog xác nhận đăng xuất (xem §4) |

## 3. Màn / dialog mở từ Cài đặt

| Mục | Mở | Ghi chú |
|-----|----|---------|
| Mật khẩu | `OlaPasscodeSettingActivity` | đặt passcode mở app (liên quan `OlaLockScreenActivity`) |
| Hình nền tuỳ chỉnh | `OlaCropImageActivity` | chọn/cắt ảnh nền |
| Trả lời nhanh | `OlaQuickReplyComposerActivity` | soạn câu trả lời nhanh |
| Cỡ chữ RSS | Dialog SeekBar (0–10) | lưu `x.i` |
| Đánh giá / Beta | trình duyệt / Play Store | URL ngoài |

## 4. Luồng Đăng xuất (`C()`, dòng 112–152)

Bấm **Đăng xuất mọi nơi** → dialog `chat.ola.vn.i.j` (tiêu đề `dialog_title_inform` = "Thông báo", nội dung `message_logout_hint` = "Bạn sẽ không nhận được tin nhắn từ bạn bè"). Đồng ý:
1. Xoá DB cục bộ (`util.c.b.f`)
2. Đăng xuất: Facebook `LoginManager.logOut()` + `OlaApplication.b.a(false)`
3. Xoá lịch sử tin (`h.t.l()`) + xoá DB (`OlaApplication.c.b()`)
4. Hiện toast `message_logout_waiting` = "Đang đăng xuất, vui lòng chờ!" → quay về.

## 5. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `general_tab_setting` | Settings | Cài đặt |
| `title_general_setting` | General | Tổng quát |
| `title_display_setting` | Display | Hiển thị |
| `title_chat_setting` | Chat | Cửa sổ Chat |
| `title_rss_setting` | RSS | RSS |
| `title_ola_info` | About Ola | Thông tin Ola |
| `title_chat_rintone_notification` | Ringtone | Âm báo |
| `title_ringtone_sound` | Ringtone sound | Kiểu âm báo |
| `title_chat_vibrate_notification` | Vibration | Thông báo rung |
| `setting_led_notification_title` | Light | Thông báo đèn |
| `title_language_setting` | Language | Ngôn ngữ |
| `title_passcode` | Passcode | Mật khẩu |
| `setting_new_me_notification_enable_title` | Notify unread Me | Thông báo khi có Me mới |
| `setting_general_show_avatar_title` | Show avatar | Ảnh đại diện |
| `settings_ola_app_wallpaper_message` | Ola Wallpaper | Hình nền Ola |
| `setting_general_choice_web_browser_mode_title` | Quick browser | Trình duyệt nhanh |
| `setting_general_play_video_mode_title` | Play video | Hiển thị video |
| `setting_typing_suggestion_enable_title` | Typing suggestion | Gợi ý khi nhập liệu |
| `message_show_popup_message` | Message notification | Thông báo tin nhắn |
| `setting_quick_reply_enable_title` | Quick reply | Trả lời nhanh |
| `setting_message_appearance_animation_title` | Message visual effect | Hiệu ứng tin nhắn |
| `setting_rss_save_history_title` | Remember Rss history | Ghi nhớ trang đã xem |
| `setting_rss_font_size_title` | Font size | Cỡ chữ |
| `title_ola_rating` | Rating | Đánh giá |
| `title_ola_beta` | Ola Beta | Ola Beta |
| `string_logout_all` | Logout all sessions | Đăng xuất mọi nơi |
| `message_logout_hint` | You will not be able to receive message… | Bạn sẽ không nhận được tin nhắn từ bạn bè |
| `message_logout_waiting` | Sign out Ola, please wait! | Đang đăng xuất, vui lòng chờ! |
| `message_restart_ola_after_change_language` | Restart Ola after changing language | Bạn cần khởi động lại Ola sau khi cài đặt ngôn ngữ |
| `message_join_us_on_facebook` | Join us on Facebook | (thanh FB dưới cùng) |

## 6. CSS tương đương

```css
.ola-settings { background: #ECEFF1; font-family: Roboto, "Helvetica Neue", Arial, sans-serif; padding: 0 16px; }

/* Tiêu đề nhóm */
.ola-settings__group {
  display: flex; align-items: center; height: 72px; margin-top: 16px; padding: 8px;
  font-size: 12px; font-weight: bold; color: #e79200;       /* cam */
  background: #fff;
}

/* 1 dòng cài đặt */
.ola-settings__item {
  display: flex; align-items: center; background: #fff;
  border-bottom: 1px solid rgba(0,0,0,.08);
}
.ola-settings__item-body { flex: 1; margin: 8px; }
.ola-settings__title { font-size: 14px; color: #000; }
.ola-settings__summary { font-size: 12px; color: #8f8f8f; }   /* mô tả xám */
.ola-settings__value { margin: 0 8px; font-size: 12px; color: #28a1ee; }  /* giá trị xanh dương */

/* Toggle (loại 0) — cột phải hiện switch */
.ola-settings__switch { width: 40px; height: 22px; }

/* Thanh Facebook dưới cùng */
.ola-settings__fb {
  position: fixed; left: 0; right: 0; bottom: 0; height: 64px;
  display: flex; align-items: center; gap: 16px; padding: 16px;
  background: #fff; border-top: 1px solid rgba(0,0,0,.12);
}
```

```html
<div class="ola-settings">
  <div class="ola-settings__group">Tổng quát</div>
  <div class="ola-settings__item">
    <div class="ola-settings__item-body">
      <div class="ola-settings__title">Âm báo</div>
      <div class="ola-settings__summary">Bật tắt âm thanh thông báo</div>
    </div>
    <span class="ola-settings__value">Bật</span>
  </div>
  <div class="ola-settings__item">
    <div class="ola-settings__item-body">
      <div class="ola-settings__title">Mật khẩu</div>
      <div class="ola-settings__summary">Mật khẩu để mở Ola</div>
    </div>
    <img class="ola-settings__value" src="images/icons/ic_arrow_right.png">
  </div>
</div>
```

## 7. Icon

| UI | Icon | Drawable |
|----|------|----------|
| App "Cài đặt" (tab Ứng dụng) | ![set](images/icons/ic_tab_setting.png) | `ic_tab_setting` |
| Preference (chung) | ![pref](images/icons/ic_menu_preferences.png) | `ic_menu_preferences` |
| Mục action (mở màn khác) | ![arrow](images/icons/ic_arrow_right.png) | `ic_arrow_right` |
| Nút đóng action bar | ![quit](images/icons/ic_action_quit.png) | `ic_action_quit` |

## 8. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Action bar | tiêu đề giữa "Cài đặt", nút X (`ic_action_quit`) |
| List | ExpandableListView, margin ngang 16dp, không divider, không group indicator |
| Tiêu đề nhóm | caption đậm, **`#e79200`** (cam), cao 72dp |
| Tên mục | body1, đen |
| Mô tả mục | caption, **`#8f8f8f`** (xám) |
| Giá trị/toggle | caption, **`#28a1ee`** (xanh dương) |
| Thanh FB | cao 64dp dưới cùng, nền trắng viền trên |
| Số nhóm / mục | 5 nhóm · ~19 mục |
| Lưu trữ | `c.x` static + `h.b` (save ở onPause/onDestroy qua `x.h()`) |
