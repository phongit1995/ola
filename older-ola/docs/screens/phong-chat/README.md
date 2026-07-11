# Màn hình Phòng chat (Public Chat Room)

- **Tab:** Bottom tab thứ 2 — string `general_tab_publicroom` = "Chat room" → hiển thị **"Phòng chat"**.
- **Fragment:** `chat.ola.vn.m.l` — `jadx_out/sources/chat/ola/vn/m/l.java`
- **Layout màn:** `apktool_out/res/layout/ola_public_room_layout.xml`
- **Adapter list:** `chat.ola.vn.b.y` — `jadx_out/sources/chat/ola/vn/b/y.java` (item = `entity.s`)
- **Activity mở 1 phòng:** `OlaChatViewActivity` (dùng chung với chat 1-1, xem [màn Chat](../chat/README.md))
- **Activity bộ lọc:** `OlaPublicRoomFilterSettingActivity` + layout `ola_public_room_filter_setting_layout.xml`

> **Phòng chat là gì:** đây là khu vực **chat công cộng theo phòng** (giống chat room cổ điển của Yahoo!/YMSG). Người dùng vào 1 phòng đông người, chat chung ("loa loa"/broadcast), tìm phòng theo giới tính/khu vực, hoặc để hệ thống **tự ghép vào phòng còn trống** ("Quick join"). Khác hẳn chat 1-1: không có danh sách bạn, chỉ có **tên phòng + số người + mô tả**, và một phòng có thể bị **đầy** (cần VIP để chen vào).

## Ảnh chụp (thiết bị thật + fake server)

| Phòng chat (danh sách trống) |
|---|
| ![phong-chat](images/01-phong-chat.png) |

> Danh sách trống vì **fake server chưa cấp dữ liệu phòng** — action bar tiêu đề giữa "Phòng chat" và bottom bar (tab thứ 2 đang chọn, màu xanh) vẫn đúng. Bố cục item bên dưới dựng lại từ layout/adapter thật.

---

## 1. Bố cục màn (`ola_public_room_layout.xml`)

```
FrameLayout (gốc)
├─ DrawerLayout  @id/roomDrawerLayout
│   ├─ [Nội dung chính] FrameLayout
│   │   ├─ FrameLayout (paddingTop 42dp = chừa chỗ action bar)
│   │   │   └─ SwipeRefreshLayout  @id/roomPullToRefreshLayout   ← kéo-để-làm-mới
│   │   │       └─ ListView  @id/roomListView   (style list.noDivider)   ← DANH SÁCH PHÒNG
│   │   ├─ LinearLayout  @id/roomChatMessageViewLayout  (góc phải-dưới)  ← "bong bóng" tin mới
│   │   │   ├─ TextView  @id/roomChatMessageBubbleTextView  (nền chat_incoming, max 200dp×72dp, 5 dòng)
│   │   │   └─ FrameLayout
│   │   │       ├─ ImageButton  @id/roomChatMessageImageButton  56dp, nền floating_action_bar_shape,
│   │   │       │                src=ic_notify_new_chat_group_message, tint trắng   ← FAB tròn
│   │   │       └─ TextView  @id/roomUnreadMessageTextView  (badge số chưa đọc, style ?commont.text.unread)
│   │   └─ <include> ola_top_action_bar_center_title_layout   ← action bar tiêu đề giữa "Phòng chat"
│   └─ [Drawer trái] RelativeLayout  rộng 240dp, nền trắng
│       └─ ListView  @id/roomDrawerListView   ← danh sách phòng đang tham gia / yêu thích
└─ FrameLayout  @id/roomProgressBar  (phủ toàn màn, nền rgba(0,0,0,.38), ẩn)  ← overlay loading
    └─ ProgressBar  48dp (giữa)
```

Thành phần đặc trưng (không có ở chat 1-1):
- **Kéo-để-làm-mới** (SwipeRefreshLayout) — vuốt xuống gọi `OlaApplication.b.a((short)0)` tải lại danh sách phòng.

> ⚠️ **Đối chiếu WEB & MOBILE — action bar CÓ THÊM nút "Làm mới":**
> APK gốc action bar danh sách phòng **chỉ có tiêu đề giữa "Phòng chat"**, làm mới **duy nhất bằng kéo-xuống**. Cả WEB ([RoomPanel.tsx](../../../../web/src/pages/room/RoomPanel.tsx)) lẫn MOBILE ([RoomListScreen.tsx](../../../../mobile/src/screens/room/RoomListScreen.tsx)) **bổ sung nút refresh góc phải header** (icon Material refresh trắng 20dp, `t('room.refresh')`) gọi lại `RoomService.browse` — đây là **tính năng thêm ngoài APK**, không phải bám gốc. Mobile vẫn giữ kéo-để-làm-mới (`RefreshControl`) song song.
- **FAB tròn góc phải-dưới** + bong bóng tin nhắn cuối: nút quay lại phòng đang chat ("loa loa"), kèm badge số tin chưa đọc.
- **Drawer trái 240dp**: danh sách phòng đang tham gia / yêu thích, vuốt từ mép trái.

## 2. Item 1 phòng (`room_item_layout.xml`)

```
LinearLayout vertical  @id/roomRowViewLayout  (nền translucent_white_80_percent, minHeight 72dp)
├─ <include> top_warning_layout  @id/warningLayout  (ẩn)
├─ LinearLayout horizontal  (padding 16dp)
│   ├─ FrameLayout
│   │   ├─ OlaCachedImageView  @id/roomIconImageView  64×64dp, nền bg_shadown_border, centerCrop  ← avatar phòng
│   │   └─ ProgressBar  @id/roomProgressBar  24dp (giữa)  ← loading avatar
│   ├─ LinearLayout vertical (weight 1, paddingLeft 8dp)
│   │   ├─ TextView  @id/roomTitleTextView  (style subhead, 1 dòng)        ← TÊN PHÒNG
│   │   └─ TextView  @id/roomSubtitleTextView  (body1, màu .54, marginTop 4dp, 1 dòng)  ← mô tả
│   └─ TextView  @id/roomSizeTextView  (style button, drawableLeft=ic_indicate_privacy_friends, padding 4dp)  ← SỐ NGƯỜI
└─ View  @id/listViewBottomDividerView  1dp, màu divider (.12), marginL/R 16dp  ← kẻ ngăn
```

### 4 loại item trong list (`y.getItemViewType`, `entity.s.h()`)

| `h()` | viewType | Layout | Ý nghĩa | Hiển thị đặc biệt |
|------:|:--------:|--------|---------|-------------------|
| `2` | 1 | `list_view_section_item_layout` | **Tiêu đề nhóm** (section header) | chỉ chữ label (`roomTitleTextView` = `d()`) |
| `4` | 2 | `conversation_admob_native_item_layout` | **Quảng cáo AdMob** | native ad, refresh mỗi 180s |
| `6` | 3 | `room_warning_item_layout` | **Banner cảnh báo** VIP / xác thực SĐT | xem §4 |
| `1` | 0 | `room_item_layout` | **"Xung quanh bạn"** (theo GPS) | icon `ic_tab_friend_location`, tên = `string_around_you`, mô tả = `string_around_you_description`, ẩn số người |
| `5` | 0 | `room_item_layout` | **"Chọn phòng nhanh"** (auto-join) | icon `ic_action_auto_join_room`, ẩn số người |
| `3` | 0 | `room_item_layout` | **Link/Promo** (mở web) | bỏ nền avatar, ẩn số người |
| `0` | 0 | `room_item_layout` | **Phòng thường** | avatar tải từ URL `g()`, hiện số người |

## 3. Số thành viên — màu theo độ đông (`roomSizeTextView`)

Logic ở `y.java` (dòng 156–174), giá trị màu tra trong `chat.ola.vn.f`:

| Số người `a()` | Hiển thị | Màu chữ | Token | Ý nghĩa |
|---------------:|----------|---------|-------|---------|
| **≥ 200** | `200+` | **#FF4081** (hồng) | `f.L` = `colorOlaAccent` | phòng rất đông / gần đầy |
| **100–199** | số thật | `rgba(0,0,0,.54)` | `f.z` = `colorTextBlackSecondaryOrIcon` | đông vừa |
| **< 100** | số thật | `rgba(0,0,0,.26)` | `f.A` = `colorTextBlackHintOrDisable` | còn vắng |

Kèm icon `ic_indicate_privacy_friends` bên trái số (drawablePadding 4dp).

### Nền dòng — phòng đang ở (`y.java` dòng 72–82)

| Trạng thái | Nền dòng | Token |
|------------|----------|-------|
| Phòng **đang tham gia** (`s.c() == h.x.k()`) | **#F1F8E9** (xanh lá nhạt) | `f.I` = `colorOlaPrimaryLight` |
| Phòng thường | **rgba(255,255,255,.80)** | `f.d` = `translucent_white_80_percent` |

## 4. Banner cảnh báo VIP / xác thực (`h()==6`, `room_warning_item_layout`)

Hiện 1 trong 3 trạng thái (ưu tiên từ trên xuống, `y.java` dòng 103–121):

| Điều kiện | Nút | Dòng 1 | Dòng 2 | Bấm → |
|-----------|-----|--------|--------|-------|
| `O.u == 0` (chưa VIP) | "Mua VIP" (`string_buy_vip`) | `message_register_vip_account` | `message_register_vip_explaination` | `BuyVipActivity` |
| `0 < O.q < 3` (VIP sắp hết) | "Gia hạn VIP" (`string_extend_vip`) | `message_extend_vip_account` | `message_extend_vip_explaination` | `BuyVipActivity` (gia hạn) |
| `!O.x` (chưa xác thực SĐT) | "Xác thực" (`string_verify`) | `message_phone_number_not_validate` | `message_warning_need_verify_phone_to_protect_your_account` | `OlaPhoneVerificationActivity` |

> Phòng đầy: thông báo `message_room_full_format` = "Phòng chat đã đầy. Để vào ngay, bạn cần có VIP".

## 5. Bộ lọc phòng (`chat.ola.vn.room.OlaPublicRoomFilterSettingActivity` / `ola_public_room_filter_setting_layout.xml`)

Mở từ icon lọc trên action bar màn phòng chat → mở **một Activity full-screen riêng** (KHÔNG phải dialog), nền trắng, có action bar tiêu đề `string_select_filter_mode` = **"Chọn chế độ lọc"** + nút back trái `string_back` = **"Trở về"**. Thân màn là `LinearLayout` dọc (padding top 42dp chừa action bar + ngang 16dp) gồm **5 CheckBox**:

| # | CheckBox id | String | VI thật | Bit |
|---|-------------|--------|---------|-----|
| 1 | `filterShowAllCheckBox` | `filter_show_all` | **Hiện tất cả** | = 255 (`f.e`) |
| 2 | `filterMediaCheckBox` | `filter_media_status` | **Hiện thông điệp hình** | 8 (`f.d`) |
| 3 | `filterFemaleCheckBox` | `filter_gender_female` | **Hiện nữ** | 1 (`f.a`) |
| 4 | `filterMaleCheckBox` | `filter_gender_male` | **Hiện nam** | 2 (`f.b`) |
| 5 | `filterFlexibleCheckBox` | `filter_gender_flexible` | **Hiện giới tính linh hoạt** | 4 (`f.c`) |

> Bitmask định nghĩa ở `chat.ola.vn.r.a.f`: `a=1` (nữ) · `b=2` (nam) · `c=4` (linh hoạt) · `d=8` (media) · `e=255` (tất cả). Cờ hiện hành lưu/đọc qua `chat.ola.vn.h.x` (`q()`=đọc short, `a(short)`=ghi, `r()`=có đang lọc cụ thể không). **Mặc định = 255 (hiện tất cả).**

### 5.1. Logic checkbox & lưu (không có nút "Áp dụng")

- **Nạp khi mở** (`C()` chạy ở `a()`/resume): đọc `h.x.q()`. Nếu đang lọc cụ thể (`r()`) → tick các ô theo bit đang bật (media/nữ/nam/linh hoạt); nếu không → tick **"Hiện tất cả"**.
- **Đồng bộ tự động** (`onCheckedChanged` + `D()`):
  - Tick **"Hiện tất cả"** → tự **tick cả 4 ô** còn lại.
  - **Bỏ tick** bất kỳ 1 trong 4 ô → tự **bỏ tick "Hiện tất cả"**.
  - Tick đủ **cả 4 ô** (media+nữ+nam+linh hoạt) → tự **tick lại "Hiện tất cả"** (`D()`).
- **Lưu khi rời màn** (`E()` gọi trong `finish()` — tức bấm **"Trở về"**/back, KHÔNG có nút Apply): nếu "Hiện tất cả" đang tick → lưu `255`; nếu không → **OR các bit** đang tick (vd chỉ "Hiện nữ" + "media" → `1|8 = 9`). Ghi vào `h.x.a(s)`.
- **Áp dụng vào list**: lớp dữ liệu phòng `r.a.f` giữ field cờ `g` (mặc định `= e = 255`); danh sách phòng/tin được lọc theo `g` khi dựng lại (lọc theo giới tính + có/không media).

> Đối chiếu web: web có dialog `RoomFilterDialog` cùng 5 lựa chọn nhưng cơ chế khác — **có nút Áp dụng** (APK lưu khi back), và cần kiểm tra cờ có thực sự lọc danh sách phòng không. (Xem mục đối chiếu khi dựng lại UI.)

## 6. Bấm vào 1 phòng → chuyện gì xảy ra

### 6.1. Luồng xử lý theo loại phòng (`l.onItemClick` dòng 635 → `l.a(entity.s)` dòng 96)

```
Bấm 1 dòng phòng
   │  l.onItemClick (đóng drawer trái trước: closeDrawer(3))
   ▼
l.a(entity.s)  — rẽ nhánh theo s.h()
   ├─ type 1 / mặc định ─► l.b(s) (dòng 181):
   │        ├─ phòng thường  (s.e()==false) → hiện progress → OlaApplication.b.a(roomId, …)  → JOIN
   │        └─ "Xung quanh bạn" (s.e()==true)→ xin quyền GPS → lấy toạ độ → a(-1, lat, lng, 0) → JOIN
   ├─ type 3 (link/promo) ─► mở trình duyệt: util.b.n(getActivity(), url)  + log "wap"  (KHÔNG vào chat)
   ├─ type 5 (chọn phòng nhanh) ─► hiện progress → OlaApplication.b.b((short)0)  (server tự ghép phòng)
   └─ type 6 (banner VIP/xác thực) ─► không vào, xử lý ở banner (mua VIP / xác thực SĐT)
   │
   ▼  (server trả lời)
   ├─ OK  ─► OlaChatViewActivity mở ra (khung chat phòng — broadcast type=4)
   └─ lỗi code 14 = PHÒNG ĐẦY (l.a(...) dòng 422):
          dialog `message_room_full_format` = "Phòng chat đã đầy. Để vào ngay, bạn cần có VIP"
          [Đăng ký VIP] → BuyVipActivity / OlaSmsSendingActivity   ·   [Đóng]
```

> Lưu ý: **bấm phòng không mở chat ngay tại client** — nó gửi lệnh join lên server (kèm progress overlay), server chấp nhận rồi mới bật `OlaChatViewActivity`. Phòng "Xung quanh bạn" cần **quyền GPS** (xin permission code 101 nếu chưa có).

### 6.2. Khung chat phòng (`OlaChatViewActivity`, layout `ola_chat_view_and_drawer_layout.xml`)

Mở qua `OlaChatViewActivity.a(context, OlaApplication.b, message.f)` (dòng 674) — set biến tĩnh `e=roomId`, `f=roomType` (**4 = phòng broadcast**). Khung chat phòng **khác chat 1-1** ở:

| Điểm | Chat 1-1 | **Phòng chat (broadcast)** |
|------|----------|----------------------------|
| Tiêu đề action bar | nick người kia | **tên phòng** |
| Hint ô nhập | "Viết tin nhắn cho \<nick>" | `string_write_a_message_room` = **"Viết tin nhắn gởi đến \"phòng %1$s\""** |
| Mỗi tin nhắn đến | chỉ bong bóng | **+ tên người gửi + avatar 32dp** (vì nhiều người) |
| Drawer phải | — | **danh sách thành viên** (`rightSliderListView`), tiêu đề `string_broadcasting_members` = **"Thành viên đang Loa Loa"** |
| FAB drawer phải | — | `rightMenuAddMemberButton` (ic_add_friend, 56dp) — **mời thành viên** |

Bố cục `ola_chat_view_and_drawer_layout.xml`:
```
FrameLayout chatViewGlobalLayout
└─ DrawerLayout chatDrawerLayout
    ├─ <include> ola_chat_view_and_action_bar_layout   ← action bar + list tin + thanh nhập
    ├─ left_drawer  240dp   leftSliderListView + leftMenuTitleTextView (42dp)   ← menu trái
    └─ right_drawer 240dp                                                       ← THÀNH VIÊN
        ├─ rightMenuTitleTextView  (42dp, "Thành viên đang Loa Loa")
        ├─ rightSliderListView     (danh sách thành viên, list.noDivider)
        └─ rightMenuAddMemberButton  FAB ic_add_friend 56dp ↘  ← mời vào phòng
   (+ chatAttachmentFrameLayout dưới cùng, 100dp, ẩn — bảng đính kèm)
```

#### 6.2.1. Dòng thành viên — `contact_item_layout.xml` (adapter `chat.ola.vn.b.n`, view-holder `chat.ola.vn.g.k`)

Danh sách thành viên trong drawer phải dùng **cùng layout item với DANH BẠ** (`contact_item_layout.xml`) nhưng **adapter khác** (`b/n`, không phải `h.t` của DANH BẠ). Trong `b/n.a(...)` (getView) mỗi dòng được set **2 cờ quyết định hiển thị**: `kVar.k = true; kVar.l = false;` → đây là điểm khác cốt lõi so với DANH BẠ.

Hệ quả của `k=true, l=false` (logic trong `g/k.java`):

| Thành phần (id) | DANH BẠ (`l=true`) | **Phòng chat (`b/n`: `k=true, l=false`)** |
|---|---|---|
| **Icon giới tính** `imgGenderIcon` (12dp, trái) | hiện ♂/♀ (`c()` khi `l=true` & type 0) | **ẨN hẳn** — `c()` nhánh `else` → `setVisibility(8)`. **Phòng KHÔNG hiện giới tính.** |
| **Avatar** `imgItemIcon` (40dp, bo, centerCrop) | hiện | hiện (load theo `o.j()`) |
| **Badge thiết bị** `imgDeviceType` (12dp, góc phải-dưới avatar, nền tròn `bg_contact_item_device`) | `j()`: online → ✓ `ic_checked` | `k()`: online (`g()==2`) → **icon theo LOẠI THIẾT BỊ** `o.h()`; sinh nhật (`f()!=0`) → 🎂 `ic_buddy_birthday`; còn lại **ẩn** |
| **Nick** `txtItemTitle` | `o.L()`, style `subhead` | `o.L()`, **subhead 16sp, MỘT màu** `colorTextBlackPrimary` #DE000000 (.87) — **không tách 2 màu, không kèm tên thật** |
| **Phụ đề** `txtItemSubTitle` (caption 12sp .54) | trạng thái | = `o.M()` (mô tả/ghi chú) nếu có, rỗng thì ẩn |
| **Icon VIP** `vipImageHolder` (24dp) | hiện nếu online+VIP | `l()`: chỉ hiện khi member **không phải type 4/1/2** + online + `i()!=0`; phòng broadcast thường **ẩn** |
| Nền dòng | `translucent_white_80_percent` #CCFFFFFF | như nhau (override `f.d` mặc định) |
| Divider | 1dp #1F000000, margin ngang 16dp | như nhau |

**Badge thiết bị** (`k()` đọc `o.h()` khi online): `0` → `ic_device_type_phone` · `1`/`2` → `ic_device_type_pc` · `3` → `ic_device_type_apple` (iOS) · `4` → `ic_device_type_android` · `5` → `ic_device_type_winphone`. (Các glyph này là **icon trắng** đặt trên nền tròn `bg_contact_item_device`.)

| `ic_device_type_phone` | `ic_device_type_pc` | `ic_device_type_apple` | `ic_device_type_android` | `ic_device_type_winphone` | `ic_buddy_birthday` |
|---|---|---|---|---|---|
| ![phone](images/icons/ic_device_type_phone.png) | ![pc](images/icons/ic_device_type_pc.png) | ![apple](images/icons/ic_device_type_apple.png) | ![android](images/icons/ic_device_type_android.png) | ![winphone](images/icons/ic_device_type_winphone.png) | ![bd](images/icons/ic_buddy_birthday.png) |

> ⚠️ **Đối chiếu WEB ([RoomMembersTab.tsx](../../../../web/src/pages/room/components/RoomMembersTab.tsx)) — đang LỆCH so với APK:**
> 1. Web **hiện icon giới tính bên trái** mỗi dòng → APK phòng chat **ẩn giới tính** (`l=false`). (DANH BẠ mới là nơi hiện giới tính.)
> 2. Web hiển thị nick **2 màu** (`username` .87 + ` · fullName` .54) → APK chỉ **1 nick `L()` một màu** (.87), không kèm tên thật.
> 3. Web **hard-code badge Android** cho mọi thành viên → APK đổi badge **theo `o.h()`** (phone/pc/apple/android/winphone) và **chỉ khi online**.
> 4. Web luôn hiện chữ "online" bên phải → APK không có nhãn chữ đó (trạng thái thể hiện qua badge + phụ đề).
>
> Nếu muốn "bám APK" đúng: bỏ icon giới tính khỏi dòng thành viên phòng, nick 1 màu, và map badge theo loại thiết bị (field `deviceType` cần bổ sung vào `RoomMember`).

> **Thứ tự vào phòng: KHÔNG có màn "danh sách user online" chắn trước.** Bấm phòng → join server → **vào thẳng khung chat** (khi khởi tạo, `W()` gọi `closeDrawer(3)+closeDrawer(5)` đóng cả 2 drawer). Danh sách thành viên là **drawer phải**, mở **chỉ bằng vuốt mép phải** — trong cả `OlaChatViewActivity` **không có lệnh `openDrawer` nào**; nút ⋮ phòng (`v()`) chỉ là menu 1 mục `string_quit_chat_room` = "Tắt loa loa", không mở drawer.

### 6.3. Dòng tin nhắn ĐẾN trong phòng (`incoming_chat_message_layout.xml`)

Vì phòng có nhiều người, tin **đến** hiển thị **tên + avatar người gửi** (chat 1-1 không cần):

```
LinearLayout chatMessageBubbleView (padding 8dp)
├─ TextView chatMessageTimeTextView   (thời gian, canh giữa, caption, màu hint .26)
├─ TextView messageSenderTextview     (TÊN NGƯỜI GỬI, marginLeft 48dp, body1, màu .54)   ← riêng phòng/nhóm
├─ LinearLayout (ngang)
│   ├─ OlaCachedImageView senderAvatarImageView  32×32dp (ic_contact_photo)   ← avatar người gửi
│   ├─ <include> chat_message_content_layout                                   ← bong bóng nội dung
│   └─ ImageButton bookmarkImageButton  (ic_star_gray, 24dp, ẩn)               ← lưu (bookmark)
└─ OlaCachedImageView readPeopleImageView  16dp (ic_message_sent, ẩn)          ← trạng thái đã đọc
```

> Tin **đi** (của mình) dùng `outgoing_chat_message_layout.xml` — **không có** `messageSenderTextview`/avatar, canh phải. Adapter tin phòng là `chat.ola.vn.b.z` (`j<message.f>`), khác adapter chat 1-1 (`r`).

### 6.4. Rời phòng (`l.g_()` dòng 532 → `l.v()` dòng 332)

Bấm Back khi đang trong 1 phòng (`h.x.e()==1`) → dialog xác nhận:
- Tiêu đề `string_quit_room` = **"Rời phòng"**
- Nội dung `string_do_you_want_to_quit_room` = **"Bạn muốn rời phòng \"%1$s\"?"**
- Nút **Có** (`string_yes`) → `l.v()` gọi `OlaApplication.b.c(roomId)` rời phòng, xoá phòng hiện tại, làm mới list · **Không** (`string_no`)

### 6.5. Loa loa / Broadcast

- `string_chat_in_room` = "Loa loa" — phát tin cho cả phòng; `string_quit_chat_room` = "Tắt loa loa".
- `string_broadcast_to_clan` = **"Loan tin toàn clan"** (boost cả clan).
- Phòng không hỗ trợ broadcast → `string_room_not_support_broadcast_message` = "Phòng \"%1$s\" không hỗ trợ chat loa loa".
- Ngưng broadcast clan → `message_quit_chat_room_confirm` = "Bạn có muốn ngưng chat toàn cộng đồng %1$s?".

## 7. Khác biệt so với Chat 1-1

| | Chat 1-1 (tab Chat) | Phòng chat |
|--|--|--|
| Đối tượng | 1 người bạn | nhiều người trong 1 phòng công cộng |
| Item list | avatar + nick + tin cuối + giờ | avatar phòng + tên + mô tả + **số người** |
| Vào/Rời | luôn mở được | **Vào / Rời phòng**, có thể **đầy** (cần VIP) |
| Theo GPS | không | "Xung quanh bạn" (type 1) |
| Tự ghép | không | "Chọn phòng nhanh" / auto-join (type 5) |
| Lọc | không | lọc giới tính / ảnh / show-all |
| Làm mới | — | **kéo-để-làm-mới** |
| Drawer | không | drawer trái: phòng đang tham gia |
| Xác thực | không bắt buộc | **bắt buộc xác thực SĐT** để vào phòng |

## 8. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `general_tab_publicroom` | Chat room | Phòng chat |
| `string_enter_chat_room` | Join chat room | Vào phòng chat |
| `string_quit_room` | Quit room | Rời phòng |
| `string_do_you_want_to_quit_room` | Do you want to quit room "%1$s"? | Bạn muốn rời phòng "%1$s"? |
| `string_around_you` | Around you | Xung quanh bạn |
| `string_around_you_description` | Find all people who are around you | Tìm mọi người quanh bạn |
| `string_auto_join_room` | Quick join chat room | Chọn phòng nhanh |
| `string_auto_join_room_description` | We will help you to choose the available chat room quickly | Hệ thống sẽ giúp bạn chọn ngay phòng đang trống |
| `message_room_member_count` | %1$s members | %1$s thành viên |
| `message_public_room_count` | %1$s chat room(s) | %1$s phòng chat |
| `message_room_full_format` | Chat room is full. Subscribe VIP account to join | Phòng chat đã đầy. Để vào ngay, bạn cần có VIP |
| `string_chat_in_room` | Broadcast | Loa loa |
| `string_quit_chat_room` | Broadcast off | Tắt loa loa |
| `string_select_filter_mode` | Select filter | Chọn bộ lọc |
| `message_warning_need_verify_phone_to_join_room` | Verified phone number before joining public room | Yêu cầu xác thực SĐT trước khi vào phòng chat |
| `string_write_a_message_room` | Write a message to "%1$s room" | Viết tin nhắn gửi đến "phòng %1$s" |
| `string_broadcasting_members` | Broadcasting members | Thành viên đang Loa Loa |
| `string_member_list` | Member list | Danh sách thành viên |
| `string_public_room_member` | Room members | Thành viên phòng chat |
| `message_room_member_count` | %1$s members | %1$s thành viên |
| `string_broadcast_to_clan` | Boost whole Clan | Loan tin toàn clan |
| `string_room_not_support_broadcast_message` | "%1$s" room does not support broadcast message | Phòng "%1$s" không hỗ trợ chat loa loa |
| `message_quit_chat_room_confirm` | Do you want to quit broadcast chat room %1$s? | Bạn có muốn ngưng chat toàn cộng đồng %1$s? |

## 9. CSS tương đương

```css
/* ===== Item 1 phòng ===== */
.ola-room-item {
  display: flex; align-items: center;
  min-height: 72px; padding: 16px;
  background: rgba(255,255,255,.80);   /* f.d */
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
  border-bottom: 1px solid rgba(0,0,0,.12);
}
.ola-room-item.is-joined { background: #F1F8E9; }    /* f.I — phòng đang ở */

.ola-room-item__avatar {
  width: 64px; height: 64px; border-radius: 4px;
  object-fit: cover;
  box-shadow: 0 1px 3px rgba(0,0,0,.2);              /* bg_shadown_border */
  flex-shrink: 0;
}
.ola-room-item__body { flex: 1; padding-left: 8px; min-width: 0; }
.ola-room-item__title {
  font-size: 16px; color: rgba(0,0,0,.87);
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.ola-room-item__subtitle {
  margin-top: 4px; font-size: 14px; color: rgba(0,0,0,.54);
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.ola-room-item__size {
  display: flex; align-items: center; gap: 4px;
  font-size: 14px; color: rgba(0,0,0,.26);          /* < 100 người (f.A) */
}
.ola-room-item__size::before {
  content: ""; width: 16px; height: 16px;
  background: url(images/icons/ic_indicate_privacy_friends.png) center/contain no-repeat;
}
.ola-room-item__size.is-medium { color: rgba(0,0,0,.54); }   /* 100–199 (f.z) */
.ola-room-item__size.is-full   { color: #FF4081; }           /* ≥ 200 → "200+" (f.L) */

/* ===== FAB quay lại phòng đang chat ===== */
.ola-room-fab {
  position: fixed; right: 16px; bottom: 16px;
  width: 56px; height: 56px; border-radius: 50%;
  background: #7CB342;                /* floating_action_bar_shape */
  display: flex; align-items: center; justify-content: center;
  box-shadow: 0 3px 6px rgba(0,0,0,.3); border: none;
}
.ola-room-fab img { width: 24px; height: 24px; filter: brightness(0) invert(1); }  /* tint trắng */
.ola-room-fab__badge {
  position: absolute; top: 0; right: 0;
  min-width: 16px; height: 16px; padding: 0 4px;
  border-radius: 12px; background: #FF4081; border: 2px solid #fff;
  color: #fff; font-size: 12px; font-weight: bold; line-height: 16px; text-align: center;
}
```

```html
<div class="ola-room-item">
  <img class="ola-room-item__avatar" src="...">
  <div class="ola-room-item__body">
    <div class="ola-room-item__title">Sài Gòn vui vẻ</div>
    <div class="ola-room-item__subtitle">Phòng tám chuyện 24/7</div>
  </div>
  <div class="ola-room-item__size is-full">200+</div>
</div>

<button class="ola-room-fab">
  <img src="images/icons/ic_notify_new_chat_group_message.png">
  <span class="ola-room-fab__badge">5</span>
</button>
```

## 10. Icon / drawable đặc trưng

| Icon | File | Dùng cho |
|------|------|----------|
| ![tab](images/icons/ic_bottom_tab_public_room.png) ![tab sel](images/icons/ic_bottom_tab_public_room_selected.png) | `ic_bottom_tab_public_room(_selected)` | icon bottom tab (chưa/đang chọn) |
| ![autojoin](images/icons/ic_action_auto_join_room.png) | `ic_action_auto_join_room` | item "Chọn phòng nhanh" (type 5) |
| ![members](images/icons/ic_indicate_privacy_friends.png) | `ic_indicate_privacy_friends` | icon trước số thành viên |
| ![public](images/icons/ic_indicate_privacy_public.png) | `ic_indicate_privacy_public` | chỉ báo phòng công khai |
| ![notify](images/icons/ic_notify_new_chat_group_message.png) | `ic_notify_new_chat_group_message` | icon FAB quay lại phòng |
| ![filter](images/icons/ic_filter_unselected.png) ![filter sel](images/icons/ic_filter_selected.png) | `ic_filter_(un)selected` | nút bật/tắt bộ lọc |
| ![addmem](images/icons/ic_add_friend.png) | `ic_add_friend` | FAB **mời thành viên** (drawer phải khung chat phòng) |
| ![star](images/icons/ic_star_gray.png) | `ic_star_gray` | nút **lưu/bookmark** 1 tin nhắn trong phòng |
| ![sent](images/icons/ic_message_sent.png) | `ic_message_sent` | chỉ báo **đã đọc/đã gửi** tin |

> "Xung quanh bạn" (type 1) dùng icon `ic_tab_friend_location` (chia sẻ với màn theo vị trí).

## 11. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Action bar | nền `#7CB342`, cao 48dp, tiêu đề giữa "Phòng chat" trắng 16sp |
| Nền dòng phòng (thường) | `rgba(255,255,255,.80)` |
| Nền dòng phòng (đang ở) | `#F1F8E9` |
| Avatar phòng | 64×64dp, có shadow border |
| Tên phòng | subhead 16sp, `rgba(0,0,0,.87)` |
| Mô tả phòng | body1 14sp, `rgba(0,0,0,.54)` |
| Số người ≥200 | `200+`, `#FF4081` |
| Số người 100–199 | `rgba(0,0,0,.54)` |
| Số người <100 | `rgba(0,0,0,.26)` |
| Kẻ ngăn | 1dp `rgba(0,0,0,.12)`, marginL/R 16dp |
| FAB | 56dp tròn, nền `#7CB342`, icon trắng 24dp |
| Badge FAB | nền `#FF4081`, viền 2dp trắng, chữ trắng đậm 12sp |
| Drawer trái | rộng 240dp, nền trắng |
| Overlay loading | phủ `rgba(0,0,0,.38)`, ProgressBar 48dp |
