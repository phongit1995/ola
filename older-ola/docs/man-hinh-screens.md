# Ola 2.1.11 — Danh sách màn hình (Activity)

> Nguồn: phân tích ngược từ `Ola_2.1.11_APKPure.apk` (package `chat.ola.vn`).
> Trích từ `apktool_out/AndroidManifest.xml` và code trong `jadx_out/`.

## Tổng quan số lượng

| Thành phần | Số lượng |
|------------|---------:|
| **Activity (màn hình)** — tổng cộng | **85** |
| &nbsp;&nbsp;→ thuộc app Ola (`chat.ola.vn.*`) | **77** |
| &nbsp;&nbsp;→ thuộc thư viện (Facebook, Google, AccountKit…) | 8 |
| Service | 13 |
| Broadcast Receiver | 4 |
| Content Provider | 4 |

> **77 màn hình** là của riêng ứng dụng Ola. Phần còn lại do các SDK bên thứ ba mang vào.

## Danh sách 77 màn hình của Ola (theo nhóm chức năng)

### Đăng nhập / Đăng ký / Tài khoản (12)
- `LoginActivity`
- `OlaLoginActivity`
- `OlaWebLoginActivity`
- `OlaOAuthenLoginActivity`
- `OlaOAuthenRegisterHtmlActivity`
- `OlaFacebookActivity`
- `signup.OlaSignUpActivity`
- `signup.OlaSignUpBySmsActivity`
- `signup.fb.OlaSignUpByFacebookActivity`
- `OlaChangePasswordActivity`
- `RecoverPassStep1Activity`
- `OlaRecoveredAccountListActivity`

### Xác thực số điện thoại / SMS (3)
- `OlaPhoneVerificationActivity`
- `OlaPhoneVerifyByAccountKitActivity`
- `sms.OlaSmsSendingActivity`

### Chat / Tin nhắn (6)
- `OlaChatViewActivity`
- `OlaBalloonChatViewActivity`
- `OlaChatGroupListActivity`
- `ChangeChatGroupTopticDialog`
- `message.OlaChatBlockedListActivity`
- `message.OlaOtherPeopleListActivity`

### Trang chủ / Điều hướng (3)
- `OlaBottomTabActivity` (màn hình tab chính)
- `OlaMallHandlerIntent`
- `OlaMeHandlerIntent`

### Trang cá nhân "Me" / Nhật ký / Bạn bè (10)
- `me.OlaUserMePageActivity`
- `me.OlaClanMePageActivity`
- `me.OlaDiaryActivity`
- `me.OlaMeComposerActivity`
- `me.OlaMeCommentActivity`
- `me.OlaMeLikerListActivity`
- `me.OlaAdMeLikeListActivity`
- `me.OlaPeopleListActivity`
- `me.OlaVisitorListActivity`
- `OlaUserProfileActivity`

### Danh bạ / Bạn bè (5)
- `ContactFinderActivity`
- `OlaAddContactActivity`
- `OlaSuggestedFriendListActivity`
- `contactpicker.OlaContactPickerActivity`
- `pickercontacts.OlaPickerContactActivity`

### Ảnh / Cloud / Gallery (8)
- `OlaImageViewerActivity`
- `OlaImageCropToolActivity`
- `OlaCropImageActivity`
- `OlaAttachmentPhotoListActivity`
- `OlaSnapPicViewerActivity`
- `cloud.OlaCloudAlbumListActivity`
- `cloud.OlaCloudPhotoListActivity`
- `cloud.OlaCloudPhotoChooserActivity`
- `cloud.OlaGalleryAlbumListActivity`
- `cloud.OlaGalleryPhotoListActivity`
- `cloud.OlaLocalPhotoChooserActivity`

### Clan (nhóm/bang hội) (3)
- `ClanManagementActivity`
- `CreateClanActivity`
- *(trang Clan cá nhân: `me.OlaClanMePageActivity` — đã liệt kê ở mục Me)*

### Check-in / Địa điểm (6)
- `checkin.OlaCheckInActivity`
- `checkin.OlaCheckInChooseActionActivity`
- `checkin.OlaCheckInCreateVenueItemActivity`
- `checkin.OlaCheckInNearbyPlacesActivity`
- `checkin.OlaCheckInSelectOrCreateItemActivity`
- `checkin.OlaVenueDetailActivity`

### VIP / Tiền tệ "KEN" / Mua bán (6)
- `BuyVipActivity`
- `OlaVipStoreActivity`
- `tradingvip.OlaTraddingVipActivity`
- `PurchaseKENActivity`
- `transferken.OlaTransferKenActivity`
- *(cửa hàng game/mall mở qua HandlerIntent)*

### Tiện ích khác (15)
- `OlaAppSettingActivity` (cài đặt)
- `OlaLanguageChooser` (chọn ngôn ngữ)
- `countrypicker.OlaCountryPickerActivity`
- `lock.OlaLockScreenActivity` (khóa màn hình)
- `lock.OlaPasscodeSettingActivity`
- `note.OlaNoteComposerActivity`
- `OlaQuickReplyComposerActivity`
- `OlaReplyMeOnNotificationActivity`
- `OlaBirthdayCheerActivity` (chúc mừng sinh nhật)
- `MarriageRequestComposerActivity` (cầu hôn ảo)
- `room.OlaPublicRoomFilterSettingActivity` (phòng chat công khai)
- `game.caro.CaroActivity` (game cờ caro)
- `tutorial.OlaTutorialActivity`
- `OlaReleaseAppActivity`

---

> Lưu ý: code bị obfuscate một phần (nhiều lớp helper đặt tên `a/b/c.java`), nhưng các Activity vẫn giữ nguyên tên gốc nên phân loại trên đáng tin cậy.
