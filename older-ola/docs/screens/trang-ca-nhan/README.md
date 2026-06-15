# Màn hình Trang cá nhân / Thông tin người dùng (User Info)

- **Activity:** `chat.ola.vn.me.OlaUserMePageActivity` — `jadx_out/sources/chat/ola/vn/me/OlaUserMePageActivity.java`
- **Layout header:** `apktool_out/res/layout/ola_user_me_page_header_layout.xml` (header cuộn cùng feed bài đăng của người đó)
- **Cụm nút quan hệ:** `add_follow_post_more_button_layout.xml` (`@id/relationMakerPan`)
- **Mở từ:** bấm avatar/tên trong feed Me, danh bạ, menu drawer trái màn Me, hoặc `OlaUserMePageActivity.a(context, "<nick>")`

> Đây là **trang hồ sơ một người** (giống profile Facebook): ảnh bìa + avatar + ID + nút quan hệ + số người quan tâm + nụ hôn + tiểu sử + thông tin cá nhân + Kho Media + Đang quan tâm + danh sách bài Me. Khi xem **chính mình** vs **người khác** thì các nút/menu khác nhau.

> Dựng từ **code + XML** (chưa chụp ảnh). Icon đã trích sẵn vào [images/icons/](images/icons/).

---

## 1. Cấu trúc header (`ola_user_me_page_header_layout.xml`)

Toàn bộ header gồm **3 thẻ** (mỗi thẻ nền `bg_shadow_span`, cách nhau 8dp): **(A) Thẻ hồ sơ** · **(B) Kho Media** · **(C) Đang quan tâm** — rồi tới tiêu đề **"ME Đã Đăng"** mở đầu danh sách bài.

```
vLinearUserInfo (vertical)
├─ [A] THẺ HỒ SƠ (bg_shadow_span)
│   ├─ FrameLayout (bìa + avatar)
│   │   ├─ coverPictureImageView   (OlaRatioImageView, nền colorOlaPrimaryDarkMore)   ← ẢNH BÌA
│   │   │   └─ editCoverPictureImageView  (ic_action_camera, ẩn — chỉ hồ sơ mình)
│   │   └─ khung avatar (bg_shadown_border, đè đáy bìa, marginBottom 48dp)
│   │       ├─ profilePictureImageView  96×96dp                                       ← AVATAR
│   │       │   └─ editProfilePictureImageView (ic_action_camera, ẩn)
│   │       └─ honeyProfilePictureImageView  96×96dp (ẩn — avatar bạn đời nếu đã cưới)
│   ├─ vLinearMeUserId (ngang, giữa)
│   │   ├─ contactIdTextView   (headline, màu .54)                                    ← NICK/ID
│   │   └─ imgCheckedPhoneNumberVerified  24dp (ic_checked, ẩn nếu chưa xác thực)     ← ✓ đã xác thực SĐT
│   ├─ ─── divider 1px ───
│   ├─ relationMakerPan = add_follow_post_more_button_layout   ← 5 NÚT QUAN HỆ (xem §2)
│   │   └─ btnUnBlockMe (Button đỏ, ẩn — hiện khi đang chặn người này) = "Bỏ chặn"
│   ├─ ─── divider 1px ───
│   ├─ vLinewarFanNumber (ngang, giữa)
│   │   └─ fanNumberTextView (title, đen) + "người quan tâm"                          ← SỐ FAN
│   ├─ kissViewLayout (ngang, giữa)
│   │   ├─ kissImageView (sticker_kiss, max 80dp) + kissTextView (title)              ← NỤ HÔN
│   ├─ linearStatusSpan (RelativeLayout, margin 16dp)
│   │   ├─ txtInfoStatusSpan (caption, tối đa 5 dòng)                                 ← TIỂU SỬ/STATUS
│   │   └─ imgStatusIcon  36×36dp (ic_media_photo) — ảnh kèm status
│   ├─ vipAccountGroup (ngang, ẩn nếu không VIP)
│   │   ├─ imgVipIcon 24dp (tải từ URL) + "Tài khoản VIP" (đậm, màu colorOlaAccent)   ← VIP
│   ├─ txtJoinOlaDate (caption)                                                       ← "Tham gia Ola …"
│   ├─ txtMeUserGender         (drawableLeft ic_indicate_dynamic_gender)              ← GIỚI TÍNH
│   ├─ txtMeUserMarriesStatus  (drawableLeft ic_profile_marriage)                     ← TÌNH TRẠNG HÔN NHÂN
│   ├─ txtMeUserBirthday       (drawableLeft ic_profile_birthday)                     ← SINH NHẬT
│   └─ txtMeUserNote (italic, màu colorOlaPrimaryDarkMore, drawableLeft ic_profile_note) ← "Xem bài viết"
├─ [B] mediaStorageViewLayout (bg_shadow_span)                                        ← KHO MEDIA
│   ├─ mediaStorageTextView = "Kho Media" (subhead)
│   ├─ lưới 2 hàng × 3 ô: mediaImageView1,2,5 / mediaImageView3,4,6 (OlaSquareCachedImageView, gap 4dp)
│   └─ "Xem Tất Cả Ảnh" (body1, giữa)
├─ [C] friendViewLayout (bg_shadow_span)                                             ← ĐANG QUAN TÂM
│   ├─ friendTextView = "Đang quan tâm" (subhead)
│   ├─ 5 ô: friendViewLayout1..5 — ảnh vuông + tên overlay (bg_gradient_black, chữ trắng, đáy)
│   └─ "Xem Tất Cả" (body1, giữa)
└─ TextView "ME Đã Đăng" (subhead, màu đen)                                          ← mở đầu list bài Me
```

## 2. Cụm 5 nút quan hệ (`add_follow_post_more_button_layout.xml`)

5 nút ngang đều nhau (weight 1), mỗi nút = icon 20dp + nhãn caption (màu `colorTextBlackHintOrDisable`). Hành động xử lý trong `OlaUserMePageActivity.onClick` (dòng 1200+):

| # | id | Icon | Nhãn (VI) | Bấm → làm gì |
|---|----|------|-----------|---------------|
| 1 | `addFriendViewLayout` | ![addf](images/icons/ic_add_friend_black_disable.png) `ic_add_friend_black_disable` | **Kết bạn** (`string_make_friend`) | gửi lời mời kết bạn `OlaApplication.b.d(nick)`; nếu đã là bạn → nhãn đổi **"Đã Kết Bạn"** (`string_already_friend`) |
| 2 | `followViewLayout` | ![follow](images/icons/ic_follow_black_disable.png) `ic_follow_black_disable` | **Quan tâm** (`string_follow`) | `Z()` theo dõi; đang theo dõi → **"Đang quan tâm"** (`string_following`) |
| 3 | `editProfileViewLayout` | ![edit](images/icons/ic_edit_profile_gray.png) `ic_edit_profile_gray` | **Cập Nhật Thông Tin** (`string_update_info`) | **chỉ hồ sơ MÌNH** (ẩn với người khác) → `OlaUserProfileActivity` ([tài liệu màn sửa hồ sơ](../thong-tin-ca-nhan/README.md)); có badge "!" nếu cần cập nhật |
| 4 | `postMeViewLayout` | ![postme](images/icons/ic_post_me_gray.png) `ic_post_me_gray` | **Viết Me** (`string_post_me`) | mình → `OlaMeComposerActivity`; người khác → soạn Me nhắc "@nick" |
| 5 | `moreViewLayout` | ![more](images/icons/ic_more_horizon_black_disable.png) `ic_more_horizon_black_disable` | **Khác** (`string_more`) | mở menu (xem §3) |

## 3. Menu "Khác" (đổi theo mình / người khác)

`moreViewLayout` → nếu là **hồ sơ mình** (`V()`) gọi `W()`, ngược lại gọi `X()`:

**Người khác** (`X()`, dòng 708) — list popup `chat.ola.vn.i.m`:

| Mục | String (VI) | Hành động |
|-----|-------------|-----------|
| Chặn | `string_block` = "Chặn" | chặn người này (sau đó nút **"Bỏ chặn"** `btnUnBlockMe` hiện) |
| Copy nick | `string_copy_nick` = "Copy nick" | sao chép nick |
| Báo nick xấu | `string_bad_nick_report` = "Báo nick xấu" | báo cáo |

**Hồ sơ mình** (`W()`) — chọn quyền riêng tư Me:

| Mục | VI |
|-----|----|
| `string_me_privacy_public` | Cộng đồng |
| `string_me_privacy_friend` | Bạn bè |
| `string_me_privacy_private` | Riêng tư |
| `string_me_privacy_help` | Hướng dẫn |

### Menu nút **Quan tâm** (ẩn — `Z()`, dòng 915)

Bấm nút **Quan tâm** không chỉ theo dõi ngay mà mở popup (khi đã có quan hệ) gồm:

| Mục | String (VI) | API |
|-----|-------------|-----|
| Hủy kết bạn | `string_unfriend` = "Hủy kết bạn" | `OlaApplication.b.e(nick)` |
| Ngừng quan tâm | `string_notfollow` = "Ngừng quan tâm" | `b.a(nick, false, 0)` |
| Quan tâm | `string_follow` = "Quan tâm" | `b.a(nick, true, 0)` |

## 4. Tính năng (tổng hợp các vùng bấm được — `onClick`)

| Vùng | id | Hành động |
|------|----|-----------|
| **Xem ảnh bìa** | `coverPictureImageView` (1220) | mở `OlaImageViewerActivity` xem bìa full |
| **Sửa ảnh bìa** | `editCoverPictureImageView` (1230) | `OlaCropImageActivity` (chỉ mình) |
| **Xem avatar** | `profilePictureImageView` (1318) | `OlaImageViewerActivity` xem avatar full |
| **Sửa avatar** | `editProfilePictureImageView` (1235) | `OlaCropImageActivity` (chỉ mình) |
| **Gửi nụ hôn** 💋 | `kissViewLayout` (1277) | `OlaApplication.b.i(nick)` + animation zoom; tăng số nụ hôn. Chưa ai hôn → "Chưa ai hôn" (`string_not_yet_been_kissed`) |
| **Xem ảnh status** | `imgStatusIcon` (1258) | mở ảnh đính kèm trong status |
| **Kho Media** | `mediaStorageViewLayout` (1289) | mình → `OlaCloudAlbumListActivity`; người khác → `OlaCloudPhotoListActivity` |
| **Số fan** | `vLinewarFanNumber` (1333) | `OlaPeopleListActivity` (danh sách người quan tâm) |
| **Đang quan tâm** | `friendViewLayout` (1246) | `OlaPeopleListActivity` (danh sách đang theo dõi) |
| **Tình trạng hôn nhân / avatar bạn đời** | `txtMeUserMarriesStatus`/`honeyProfilePictureImageView` (1252) | mở trang Me của bạn đời |
| **Xem note** | `txtMeUserNote` (1328) | mở `rss://note/<nick>` |
| **Bỏ chặn** | `btnUnBlockMe` (1211) | `OlaApplication.b.o(nick)` bỏ chặn |

### Trạng thái động (các text đổi theo dữ liệu)
- Giới tính: **Nam** (`string_male`) / **Nữ** (`string_female`).
- Hôn nhân: **Độc thân** (`string_marry_alone`/`string_single`) / **Chưa biết** (`string_unknown`) / đã cưới (hiện avatar bạn đời).
- Kết bạn: **Kết bạn** → **Đã Kết Bạn**. Theo dõi: **Quan tâm** → **Đang quan tâm**.

## 5. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `string_make_friend` | Make friend | Kết bạn |
| `string_already_friend` | Friend | Đã Kết Bạn |
| `string_follow` | Follow | Quan tâm |
| `string_following` | Following | Đang quan tâm |
| `string_update_info` | Update info | Cập Nhật Thông Tin |
| `string_post_me` | Post Me | Viết Me |
| `string_more` | More | Khác |
| `string_people_care` | people care | người quan tâm |
| `string_kiss` | Kiss | Nụ hôn |
| `string_not_yet_been_kissed` | — | Chưa ai hôn |
| `message_vip_account` | VIP account | Tài khoản VIP |
| `string_join_ola` | Join Ola | Tham gia Ola |
| `string_view_note` | View note | Xem bài viết |
| `string_media_store` | Photos | Kho Media |
| `string_view_all_photos` | View all photos | Xem Tất Cả Ảnh |
| `string_following` (mục) | Following | Đang quan tâm |
| `string_view_all_followings` | View all | Xem Tất Cả |
| `string_me_posts` | Me Posts | ME Đã Đăng |
| `string_unblock` | Unblock | Bỏ chặn |
| `string_block` | Block | Chặn |
| `string_copy_nick` | Copy nick | Copy nick |
| `string_bad_nick_report` | Report | Báo nick xấu |
| `string_male` / `string_female` | Male / Female | Nam / Nữ |
| `string_marry_alone` / `string_unknown` | Single / Unknown | Độc thân / Chưa biết |

## 6. Bảng icon & ảnh hiển thị

| Vị trí | Icon/ảnh | Nguồn |
|--------|----------|-------|
| Ảnh bìa | (tải từ URL) | `coverPictureImageView`, nền tạm `colorOlaPrimaryDarkMore` |
| Avatar | (tải từ URL) | `profilePictureImageView` 96dp |
| Avatar bạn đời | (tải từ URL) | `honeyProfilePictureImageView` (ẩn nếu chưa cưới) |
| Sửa ảnh | ![cam](images/icons/ic_action_camera.png) | `ic_action_camera` |
| Đã xác thực SĐT | ![check](images/icons/ic_checked.png) | `ic_checked` |
| Nụ hôn | ![kiss](images/icons/sticker_kiss.png) | `sticker_kiss` |
| Ảnh kèm status | ![photo](images/icons/ic_media_photo.png) | `ic_media_photo` (mặc định) |
| Giới tính | ![gender](images/icons/ic_indicate_dynamic_gender.png) | `ic_indicate_dynamic_gender` |
| Hôn nhân | ![marriage](images/icons/ic_profile_marriage.png) | `ic_profile_marriage` |
| Sinh nhật | ![bday](images/icons/ic_profile_birthday.png) | `ic_profile_birthday` |
| Note | ![note](images/icons/ic_profile_note.png) | `ic_profile_note` |
| VIP | (tải từ URL) | `imgVipIcon` |
| Nút Kết bạn | ![addf](images/icons/ic_add_friend_black_disable.png) | `ic_add_friend_black_disable` |
| Nút Quan tâm | ![follow](images/icons/ic_follow_black_disable.png) | `ic_follow_black_disable` |
| Nút Cập nhật | ![edit](images/icons/ic_edit_profile_gray.png) | `ic_edit_profile_gray` |
| Nút Viết Me | ![postme](images/icons/ic_post_me_gray.png) | `ic_post_me_gray` |
| Nút Khác | ![more](images/icons/ic_more_horizon_black_disable.png) | `ic_more_horizon_black_disable` |
| Tên bạn bè (overlay) | nền `bg_gradient_black`, chữ trắng | lưới Đang quan tâm |

## 7. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Thẻ | nền `bg_shadow_span`, cách nhau 8dp |
| Ảnh bìa | tỉ lệ (OlaRatioImageView), nền tạm `#33691E` |
| Avatar | **96×96dp**, khung `bg_shadown_border` (padding 4/4/4/6dp), đè đáy bìa (marginBottom 48dp) |
| Avatar bạn đời | 96×96dp, marginLeft 1dp |
| Nick/ID | headline, `rgba(0,0,0,.54)` |
| Icon ✓ xác thực | 24dp |
| Nút quan hệ | icon 20dp + nhãn caption `rgba(0,0,0,.26)` |
| Nút Bỏ chặn | nền đỏ `btn_red_button_selector`, chữ trắng, padding dọc 16dp |
| Số fan / nụ hôn | title, màu đen |
| Sticker nụ hôn | max 80dp |
| Tiểu sử | caption, tối đa 5 dòng; ảnh status 36dp |
| VIP | icon 24dp + chữ đậm `#FF4081` |
| Dòng thông tin (giới tính/hôn nhân/sinh nhật/note) | caption, marginLeft 16dp, marginTop 8dp, icon drawableLeft + padding 4dp; note in nghiêng màu `#33691E` |
| Lưới Kho Media | 2×3 ô vuông, gap 4dp |
| Lưới Đang quan tâm | 5 ô vuông, tên overlay `bg_gradient_black` (cao tối thiểu 24dp, chữ trắng caption) |
| Divider | 1px `rgba(0,0,0,.12)` |

---

## 8. Bản đồ API ↔ tính năng (gồm tính năng ẩn)

Tất cả lệnh gọi `OlaApplication.b.<method>` (= `OlaNetworkService`) trong `OlaUserMePageActivity`:

| Tính năng | API gọi (file:line) | Ghi chú |
|-----------|---------------------|---------|
| **Tải hồ sơ** người dùng | `b.a(nick, callback)` (387) | nạp toàn bộ thông tin profile |
| **Lấy tên hiển thị** | `b.a(nick, ["name"], cb)` (1014) | resolve field "name" |
| **Resolve nick** | `b.a(nick, p.i cb)` (1046) | tra cứu nick → thông tin |
| **Tải feed Me** (làm mới) | `b.a(nick, true, …)` (874) | bài đăng của người đó |
| **Tải feed Me** (cũ hơn) | `b.a(nick, false, …)` (883) | tải tiếp |
| **Tải thêm bài (paging)** 🔒 | `b.a(nick, n.k(), (short) 79)` (1159) | gọi khi cuộn cuối list (`a_(int)`), **svc 79** |
| **Kết bạn** | `b.d(nick)` (1203) | gửi lời mời / tạo hội thoại |
| **Hủy kết bạn** 🔒 | `b.e(nick)` (921) | trong menu nút Quan tâm |
| **Theo dõi / Bỏ theo dõi** | `b.a(nick, true/false, 0)` (925/928) | "Quan tâm" / "Ngừng quan tâm" |
| **Gửi nụ hôn** 💋 | `b.i(nick)` (1280) | tiêu **KEN** (`i()` kiểm `x.e()` + phát hiệu ứng); chặn tự hôn mình |
| **Chặn** | `b.m(nick)` (721) | menu "Khác" |
| **Bỏ chặn** | `b.o(nick)` (1214) | nút `btnUnBlockMe` |
| **Đặt quyền riêng tư Me** 🔒 | `b.g(0)` / `b.f(0)` / `b.e(0)` (773/790/824) | Cộng đồng / Bạn bè / Riêng tư (menu "Khác" của hồ sơ mình, `W()`) |

> 🔒 = **tính năng ẩn / có điều kiện** (chỉ hiện trong menu phụ hoặc khi đủ điều kiện), không thấy ngay trên màn.

### Tính năng/UI ẩn theo điều kiện (visibility=gone tới khi đủ điều kiện)

| Thành phần | Hiện khi | 
|------------|----------|
| `editProfileViewLayout` + badge `editProfileNotificationTextView` ("!") | **hồ sơ mình** / có thông tin cần cập nhật |
| `editCoverPictureImageView`, `editProfilePictureImageView` (ic_action_camera) | **hồ sơ mình** (sửa bìa/avatar) |
| `honeyProfilePictureImageView` (avatar bạn đời) + `kissViewLayout` cưới | đã **kết hôn** |
| `btnUnBlockMe` ("Bỏ chặn", nền đỏ) | đang **chặn** người này |
| `vipAccountGroup` ("Tài khoản VIP") | tài khoản **VIP** |
| `imgCheckedPhoneNumberVerified` (✓) | đã **xác thực SĐT** |
| Menu Quan tâm (`Z()`: Hủy kết bạn / Ngừng quan tâm) | đã là **bạn / đang theo dõi** |
| Menu "Khác" = privacy (`W()`) vs block/report (`X()`) | **mình** vs **người khác** |

---

## 9. CSS tương đương (dựng lại trên web)

```css
/* ===== Thẻ chung ===== */
.ola-profile { background: #ECEFF1; font-family: Roboto, "Helvetica Neue", Arial, sans-serif; }
.ola-profile__card {
  background: #FFFFFF; margin-bottom: 8px;
  box-shadow: 0 1px 2px rgba(0,0,0,.18);          /* bg_shadow_span */
}

/* ===== Bìa + avatar ===== */
.ola-profile__cover {
  position: relative; width: 100%; aspect-ratio: 16/6;
  background: #33691E center/cover no-repeat;      /* colorOlaPrimaryDarkMore */
  margin-bottom: 48px;
}
.ola-profile__avatar-frame {
  position: absolute; left: 50%; bottom: -48px; transform: translateX(-50%);
  background: #fff; padding: 4px 4px 6px;
  box-shadow: 0 1px 3px rgba(0,0,0,.3);            /* bg_shadown_border */
  display: flex;
}
.ola-profile__avatar { width: 96px; height: 96px; object-fit: cover; }
.ola-profile__avatar--honey { margin-left: 1px; }  /* avatar bạn đời */
.ola-profile__edit-cam {                            /* ic_action_camera */
  position: absolute; right: 4px; bottom: 4px; width: 24px; height: 24px;
}

/* ===== ID + xác thực ===== */
.ola-profile__id { display: flex; align-items: center; justify-content: center; gap: 4px; padding: 8px; }
.ola-profile__nick { font-size: 24px; color: rgba(0,0,0,.54); }   /* headline — contactIdTextView đặt textSize=headline trực tiếp (đè style caption) */
.ola-profile__verified { width: 24px; height: 24px; }

/* ===== 5 nút quan hệ ===== */
.ola-profile__actions { display: flex; padding: 8px; }
.ola-profile__btn {
  flex: 1; display: flex; flex-direction: column; align-items: center; gap: 4px;
  background: none; border: none;
  font-size: 12px; color: rgba(0,0,0,.26);          /* colorTextBlackHintOrDisable */
}
.ola-profile__btn img { height: 20px; }
.ola-profile__btn--unblock {                        /* btnUnBlockMe */
  width: 100%; padding: 16px 0; background: #dd4b39; color: #fff;   /* btn_red_button hardcode #dd4b39, không phải token red #E34545 */
  border: none; font-size: 12px;
}

/* ===== Số fan / nụ hôn ===== */
.ola-profile__fans, .ola-profile__kiss {
  display: flex; align-items: center; justify-content: center; gap: 2px; margin-top: 16px;
}
.ola-profile__fans b { font-size: 20px; color: #000; }     /* fanNumberTextView (title) */
.ola-profile__fans span { font-size: 12px; color: rgba(0,0,0,.54); }
.ola-profile__kiss img { max-height: 80px; }                /* sticker_kiss */
.ola-profile__kiss b { font-size: 20px; color: #000; }

/* ===== Tiểu sử + dòng thông tin ===== */
.ola-profile__bio {
  display: flex; gap: 8px; margin: 0 16px 8px;
  font-size: 12px; color: rgba(0,0,0,.54);
}
.ola-profile__bio-text { flex: 1; text-align: center;
  display: -webkit-box; -webkit-line-clamp: 5; -webkit-box-orient: vertical; overflow: hidden; }
.ola-profile__status-icon { width: 36px; height: 36px; object-fit: cover; }
.ola-profile__vip { display: flex; align-items: center; gap: 4px; margin-left: 16px; }
.ola-profile__vip img { width: 24px; height: 24px; }
.ola-profile__vip span { font-weight: bold; color: #FF4081; font-size: 12px; }  /* colorOlaAccent */
.ola-profile__info {                                /* giới tính / hôn nhân / sinh nhật / note */
  display: flex; align-items: center; gap: 4px;
  margin: 8px 0 0 16px; font-size: 12px; color: rgba(0,0,0,.54);
}
.ola-profile__info img { width: 16px; height: 16px; }       /* drawableLeft */
.ola-profile__info--note { font-style: italic; color: #33691E; }

/* ===== Kho Media (2×3) ===== */
.ola-profile__section-title { margin: 8px 16px; font-size: 16px; color: rgba(0,0,0,.54); }
.ola-profile__media-grid {
  display: grid; grid-template-columns: repeat(3, 1fr); gap: 4px; padding: 0 8px;
}
.ola-profile__media-grid img { width: 100%; aspect-ratio: 1; object-fit: cover; }

/* ===== Đang quan tâm (5 ô + tên overlay) ===== */
.ola-profile__friend-grid { display: flex; gap: 4px; padding: 0 8px; }
.ola-profile__friend { position: relative; flex: 1; aspect-ratio: 1; }
.ola-profile__friend img { width: 100%; height: 100%; object-fit: cover; }
.ola-profile__friend span {
  position: absolute; left: 0; right: 0; bottom: 0; min-height: 24px;
  padding: 4px; text-align: center;
  background: linear-gradient(transparent, rgba(0,0,0,.7));  /* bg_gradient_black */
  color: #fff; font-size: 12px;
}
.ola-profile__view-all { display: block; text-align: center; padding: 12px 0; font-size: 14px; color: rgba(0,0,0,.54); }
```

```html
<div class="ola-profile">
  <div class="ola-profile__card">
    <div class="ola-profile__cover" style="background-image:url(cover.jpg)">
      <div class="ola-profile__avatar-frame">
        <img class="ola-profile__avatar" src="avatar.jpg">
      </div>
    </div>
    <div class="ola-profile__id">
      <span class="ola-profile__nick">linhchi92</span>
      <img class="ola-profile__verified" src="images/icons/ic_checked.png">
    </div>
    <div class="ola-profile__actions">
      <button class="ola-profile__btn"><img src="images/icons/ic_add_friend_black_disable.png">Kết bạn</button>
      <button class="ola-profile__btn"><img src="images/icons/ic_follow_black_disable.png">Quan tâm</button>
      <button class="ola-profile__btn"><img src="images/icons/ic_post_me_gray.png">Viết Me</button>
      <button class="ola-profile__btn"><img src="images/icons/ic_more_horizon_black_disable.png">Khác</button>
    </div>
    <div class="ola-profile__fans"><b>128</b><span>người quan tâm</span></div>
    <div class="ola-profile__info"><img src="images/icons/ic_indicate_dynamic_gender.png">Nữ</div>
  </div>
</div>
```
