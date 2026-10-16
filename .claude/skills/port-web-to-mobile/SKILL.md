---
name: port-web-to-mobile
description: >
  Quét khác biệt và clone/port một màn (hoặc tính năng) từ web app Ola (`web/src`) sang
  mobile React Native (`mobile/src`). Dùng khi user nói "clone/port web sang app/mobile",
  "đồng bộ mobile theo web", "màn X web đã có, làm cho mobile", "check mobile khác gì web",
  "quét diff web vs mobile", "bê tính năng Y từ web qua app". Skill nêu KIẾN TRÚC shared
  (`@ola/shared` — store/type/service/i18n/lib dùng chung, ĐỪNG viết lại logic), bảng ánh xạ
  primitive web→RN, khác biệt Tailwind↔NativeWind, các thứ per-platform PHẢI viết lại
  (renderRichText, ô nhập emoji, toast, chọn ảnh, media viewer, .svg→.png),
  quy trình quét-diff-port, quy ước file/alias/theme/dialog/bàn phím của mobile, và checklist
  (typecheck + lint + chạy iOS).
---

# Clone / port màn & tính năng từ web (`web/`) sang mobile (`mobile/`)

App web (`web/`, React + Vite + Tailwind v4 DOM) và app mobile (`mobile/`, React Native 0.86 + NativeWind + FlashList) **chia sẻ toàn bộ tầng logic** qua package `@ola/shared`. Port một màn = **viết lại tầng VIEW**, KHÔNG viết lại logic. Đọc kỹ mục 1 trước khi gõ dòng nào.

## 0. Quy ước bắt buộc
- **KHÔNG viết comment** trong code (giống `web/CLAUDE.md`): không `//`, `/* */`, JSDoc, JSX `{/* */}`. Khó hiểu → tách hàm/đặt tên lại. Ngoại lệ: chỉ thị công cụ (`// @ts-expect-error`) kèm lý do ngắn.
- **i18n type-safe**: `t('key')` chỉ dùng key có trong `packages/shared/src/i18n/locales/en.json` (sinh type) VÀ `vi.json`. Web và mobile **dùng CHUNG** locale này ⇒ port thường **không cần thêm key** (web đã thêm rồi). Nếu thiếu, thêm vào CẢ HAI file.
- **Shell hay reset cwd** về `/Volumes/D/ola` — chạy lệnh mobile thì `cd /Volumes/D/ola/mobile` trước.
- **Đặt file trong màn** theo `mobile/README.md` mục "Quy ước trong màn" (giống web/admin): `XxxScreen.tsx` + `components/`, `useXxx.ts`, `constants.ts`, `utils.ts` (hàm thuần), `types.ts` (KHÔNG tạo `interface.ts`), `xxxAssets.ts`. Web và mobile dùng CÙNG tên file cho cặp màn tương ứng (`pages/room/utils.ts` ↔ `screens/room/utils.ts`) để dễ đối chiếu.
- **Import alias**: vượt thư mục thì dùng `@components/…`, `@screens/…`, `@hooks/…`, `@lib/…`, `@store/…`, `@assets/…` (kể cả `require('@assets/...')`); cùng màn thì tương đối `./utils`. Thứ đã có ở `@ola/shared` thì import thẳng, không tạo file re-export.
- **Màu theo theme**: KHÔNG hardcode hex xanh (`#7cb342`, `#558b2f`, `#33691e`…). className dùng token `ola-*`; inline style dùng `useThemeColors()` (`@hooks/useThemeColors`), alpha dùng `withAlpha(color, x)` từ `@ola/shared/lib` (modifier `bg-ola-primary/15` KHÔNG chạy với màu var).
- Xong việc: `cd /Volumes/D/ola/mobile && pnpm typecheck && pnpm lint` PHẢI sạch, rồi chạy thử iOS (mục 7).

## 1. KIẾN TRÚC — cái gì dùng chung, cái gì phải viết lại

### Dùng chung qua `@ola/shared` — TÁI DÙNG, TUYỆT ĐỐI đừng viết lại
Web `@/store/*` phần lớn chỉ `export * from '@ola/shared/stores/*'`. Cả 2 app import cùng nguồn:
- **Store (zustand)**: `@ola/shared/stores/<feature>/<store>` — `room/roomChatStore`, `chat/chatStore`, `auth/authStore`, `feed/meFeedStore`, `toast/toastStore`... (store đứng một mình thì phẳng: `settingsStore`, `themeStore`). Actions realtime/optimistic/API **đã có sẵn** (vd `roomChatStore` đã có `sendImage`, `resendRoomImage`, `reactionNotice`, `deleteRoomMessage`). Mobile chỉ việc **gọi + render**.
- **Types**: `@ola/shared/types` — `RoomMessage`, `ReactionType`, `MeNotificationType`... Nguồn sự thật DUY NHẤT của kiểu. Web đổi type → mobile phải theo (đây là nguồn lỗi `tsc` khi mobile tụt hậu).
- **Services / API**: `@ola/shared/services` (`RoomService`, `MeService`...) + `@ola/shared/api`. Upload nhận `UploadFile = Blob | NativeUploadFile{uri,name,type}` ⇒ service **đã hỗ trợ file RN**, mobile chỉ cần tạo `{uri,name,type}`.
- **Lib platform-agnostic**: `@ola/shared/lib` — `colorForName`, `createTimeFormatter`, `createDateFormatter`, `formatKen`/`formatVnd`, `withAlpha`, `toast`, VIP helpers (`activeVipTypeId`, `isVipActive`), `buildRoomFeed`, `chatBotGrouping`… Đừng tự viết hash màu / parse / format. (Riêng `kulImageForText`/`kulToken` là per-platform: mobile `@lib/kul`, web `@lib` — vì mobile trả `require()` asset.)
- **i18n locales**: `@ola/shared/i18n/locales/*.json`.

### Per-platform — PHẢI viết/port riêng cho mobile
Không tồn tại hoặc khác bản chất giữa DOM và RN:
- **Render rich text**: web `renderRichText` (JSX + `<img>`) ↔ mobile `@lib/richText` (`renderRichText`, `SmileyText`). Bong bóng chat có emoji/smiley dùng `@components/ui/RichTextView` (native `OlaRichText`, đo đồng bộ qua JSI). Đã có bản mobile — dùng nó.
- **Toast**: web `toast.success/error` (`@lib`) ↔ mobile `useToastStore` (`@ola/shared/stores/toast/toastStore`) render qua `@components/ui/ToastHost`. Trong component mobile: `const push = useToastStore(s=>s.push); push('error', t('...'))`; ngoài component (hook/store) gọi `toast` từ `@ola/shared/lib` cũng đẩy vào cùng store.
- **Nén / chọn ảnh**: web `compressImageForUpload` (canvas) + `<input type=file>` ↔ mobile ĐÃ CÓ `@lib/imagePicker` (`pickSingleImage`, `pickCroppedImage`, `pickValidatedCroppedImage`, `uploadFileFromAsset`, `pastedImageFile` — dùng `react-native-image-picker` + `react-native-image-crop-picker`) và `@lib/compressImage` (`compressImagesForUpload` nhận `NativeUploadFile`). Đừng cài lib picker mới.
- **Media viewer** (xem ảnh full): web `useMediaViewerStore` → mobile `@components/ui/MediaViewer` (`MediaViewer` host store-driven ở App root + `MediaViewerModal` presentational). ⚠️ Màn nào tự render trong `<Modal>` (vd `UserProfileScreen`) thì global host ở App root KHÔNG present được (iOS từ chối present Modal thứ 2 từ root khi Modal khác đang mở) → dùng state cục bộ + `<MediaViewerModal images index onClose>` render BÊN TRONG Modal của màn đó.
- **Con absolute tràn ra ngoài bounds parent** (vd avatar `-bottom-12` đè lên cover): Android không nhận touch ở phần nằm ngoài bounds parent (vẽ vẫn thấy nhưng không tap được). Fix: wrapper `paddingBottom` bằng phần tràn, đặt phần tử `absolute bottom-0` so với wrapper thay vì `-bottom-X` so với parent bị tràn.
- **Long-press / sticky-scroll / attach-panel**: web hooks `useLongPress`, `useStickyScroll` (`@hooks`), `useAttachPanel` (`pages/room/useAttachPanel.ts`) — đều DOM. Mobile: long-press = `Pressable onLongPress`; dính đáy list chat = `@hooks/useStickyBottomList` (BẮT BUỘC, có vòng tự hồi phục — KHÔNG dùng `scrollToEnd` của FlashList). Đừng import hook web.
- **Store có `persist`**: store persist nằm ở shared và dùng `sharedPersistStorage()` (vd `stores/room/roomFilterStore`, `themeStore`); mobile cắm **MMKV** qua `platform/configureStorage.ts`. Store mới cần persist → đặt ở shared theo mẫu đó, KHÔNG dùng localStorage.
- **`.svg`**: metro mobile **không** import `.svg` làm `Image` (không có transformer). Web icon `.svg` (vd `ic_menu_copy.svg`, `ic_menu_block.svg`) → tìm/tạo bản `.png` bỏ vào `mobile/src/assets/...`.
- **Ô nhập có emoji/smiley inline (WYSIWYG)**: web dùng `SmileyInput` (`contentEditable` div chèn `<img>`) ↔ mobile dùng `@components/ChatComposer` (native `OlaChatComposer` = UITextView/EditText thật, ảnh nhúng trong buffer). API giống web: `insertCode(code, trailingSpace)`, `insertText`, `backspace` (xoá nguyên token), `value`/`onChange` là chuỗi token, `onPasteImage`. Đang dùng ở `RoomMessagesTab`, `ChatDetailScreen`, `MeCommentComposer`, `MeComposerModal`. ⚠️ Hack cũ "TextInput chữ trong suốt + overlay `SmileyText`" (SmileyDraftOverlay, useSmileyDraft, TextRangeRects) ĐÃ XOÁ — ĐỪNG dựng lại. Đổi spec native thì phải `pod install` + rebuild.

## 2. Ánh xạ primitive web → React Native
| Web (DOM/JSX) | Mobile (RN) | Ghi chú |
|---|---|---|
| `<div>` | `<View>` | container |
| `<span>` / `<p>` chứa chữ | `<Text>` | **Mọi chữ PHẢI trong `<Text>`** (RN crash nếu text trần trong View) |
| `<button onClick>` | `<Pressable onPress>` | thêm `onLongPress` khi cần |
| `<img src={x}>` (import) | `<Image source={require('...')}/>` hoặc `source={{uri}}` | import tĩnh → `require`; URL remote → `{{uri}}` |
| `<input>` / `<textarea>` | `<TextInput>` | `multiline`, `value`, `onChangeText` |
| `<ul>/<li>` danh sách dài | `<FlashList data renderItem keyExtractor>` | `@shopify/flash-list`; danh sách ngắn cố định thì `.map` trong `View` |
| `onClick` | `onPress` | |
| `overflow-y-auto` khối cuộn | `ScrollView` hoặc `FlashList` | View không tự cuộn |
| CSS `:hover`/`:focus`/`hover:`/`focus:` | **bỏ** | RN không có hover; state nhấn dùng `active:` (nativewind) hoặc `style={{opacity}}` |
| position overlay (`FullScreenOverlay`) | `OlaModal` (`@components/ui/OlaModal`) hoặc `<View className="absolute inset-0">` | ⚠️ `absolute inset-0` trong TAB SCREEN chỉ phủ tới mép trên bottom tab bar (không full màn). Drawer/overlay cần phủ cả tab bar → `OlaModal transparent animationType="none"` (slide/backdrop tự chạy bằng `Animated` bên trong). KHÔNG dùng `Modal` của RN trực tiếp: `OlaModal` lồng `SafeAreaProvider` nên insets đúng trên mọi máy Android; component đọc insets phải nằm DƯỚI provider lồng. Nút bám đáy: `height: 48 + inset` + `paddingBottom: inset` với `inset = useBottomBarInset()` |
| `Dialog` / `ConfirmDialog` / `ListOptionDialog` / `UserListDialog` (web `shared/components/ui`) | cùng tên ở `@components/ui/…` | Map thẳng 1-1, KHÔNG tự dựng Modal cho dialog mới. Dialog không có ô nhập phải `avoidKeyboard={false}` |
| `<a>` | `<Pressable>` + navigation | |

## 3. Tailwind (web) → NativeWind (mobile) — khác biệt
NativeWind cho dùng `className` nhưng **KHÔNG phải class Tailwind nào cũng chạy**:
- **OK**: layout (`flex`, `flex-1`, `flex-row`, `items-*`, `justify-*`, `gap-*`), spacing (`p-*`,`m-*`,`px-*`), size (`h-*`,`w-*`), màu nền/chữ (`bg-*`,`text-*` gồm token `ola-*`), bo góc (`rounded-*`), `absolute/relative`, `text-sm/base/xs`, `font-bold/semibold`, `active:bg-*`.
- **KHÁC / phải đổi sang `style={{...}}`**:
  - `hover:` / `focus:` / `group-*` / `peer-*` → bỏ (không có).
  - `shadow-*` → RN dùng `shadowColor/shadowOpacity/shadowRadius/shadowOffset` (iOS) + `elevation` (Android) trong `style`.
  - `ring-*` → không có; dùng `borderWidth`+`borderColor`.
  - Gradient (`bg-gradient-*`, `bg-[repeating-linear-gradient(...)]`) → không có; dùng `react-native-linear-gradient` (đã cài) hoặc vẽ tay bằng nhiều `View` nhỏ.
  - `animate-*` (blink, custom keyframes) → không có; dùng `react-native-reanimated` (đã cài) hoặc `Animated`.
  - Arbitrary value `text-[11px]`, `bg-[#7cb342]`, `max-w-[80%]` → phần lớn OK, nhưng khi không ăn thì chuyển `style`.
  - `object-cover/contain` → `<Image resizeMode="cover|contain">` (prop, không phải class).
  - `truncate` / `line-clamp-n` → `<Text numberOfLines={1|n}>` (prop).
  - `divide-*`, `space-x/y-*` → dùng `gap-*` hoặc border thủ công.
- **Màu opacity kiểu `text-black/54`**: nativewind hỗ trợ với màu cố định, nhưng bản mobile hiện tại hay dùng `style={{ color: 'rgba(0,0,0,0.54)' }}` cho chắc — theo pattern file cùng thư mục. Màu theme (`ola-*`) thì dùng `withAlpha` (mục 0).
- **`TextInput`**: className KHÔNG áp màu chữ cho `TextInput` (chữ trắng trên nền trắng) → set `color` bằng inline style.
- **Bàn phím**: màn có ô nhập bọc `<KeyboardView className="flex-1">` (`@components/KeyboardView`, ruột là `react-native-keyboard-controller`); màn chat dùng `@components/ChatKeyboardArea`; khoảng đệm đáy dùng `useBottomBarInset()` (về 0 khi bàn phím mở). KHÔNG import `KeyboardAvoidingView` trực tiếp, KHÔNG `Keyboard.addListener` tay.

## 3b. ⚠️ Bẫy web→mobile hay gặp NHẤT — soi kỹ mỗi lần port
Đây là lỗi do **bê thẳng DOM/CSS sang RN** mà quên khác biệt nền tảng. Kiểm tra HẾT danh sách này trước khi coi là xong:

1. **Header chui dưới notch / Dynamic Island (thiếu safe-area)** — LỖI HAY GẶP NHẤT.
   - *Tại sao*: header web ngồi trong overlay full-screen, **trình duyệt không có status bar/notch** nên CSS không chừa gì. Trên iPhone, màn RN vẽ từ **y=0 dưới status bar/Dynamic Island**. Bê nguyên `h-12` (cao 48px) từ web sang → dải xanh chỉ cao 48px tính từ đỉnh máy, **phần status bar KHÔNG được tô màu** và tiêu đề **bị Dynamic Island che** → nhìn như "header bị mất / quá nhỏ".
   - *Sửa*: dùng `@components/ui/ScreenHeader` (props `title`, `subtitle?`, `onBack`, `right?`, `centerTitle?`) — đã tự chừa `insets.top` và đọc đúng provider kể cả trong `OlaModal`. KHÔNG tự dựng bar với ký tự `‹`. Ngoại lệ đã duyệt giữ header custom: `RoomChatScreen`, `ChatDetailScreen`, `EggGameScreen` — header custom thì phải tự bọc `View` nền màu + `style={{ paddingTop: insets.top }}` trước hàng `h-12`.
   - *Verify*: chạy trên máy có notch (iPhone 16/17 Pro Max) và nhìn: dải màu phải phủ **tận đỉnh**, tiêu đề nằm **dưới** island. Đừng chỉ tin typecheck — lỗi này build sạch nhưng nhìn là biết.

2. **Text trần trong View** → RN crash `Text strings must be rendered within a <Text>`. Web cho text trực tiếp trong `<div>`; RN thì mọi chuỗi PHẢI bọc `<Text>`.
3. **`.svg` không import được** (metro không có transformer) → tạo `.png` (xem mục 1 & 6). Build web-svg thành png trắng bằng `rsvg-convert -w 72 -h 72 icon.svg -o icon.png`.
4. **Không có hover** → nút chỉ đổi trạng thái khi `active:`; đừng để hiệu ứng chỉ chạy trên hover.
5. **`position:absolute; left/right` %:** RN hỗ trợ nhưng cha phải có kích thước xác định; kiểm tra lại vị trí thực (vd nút quick-mention float).
6. **Ảnh remote không tự co**: `<img>` web tự theo tỉ lệ; RN `<Image source={{uri}}>` cần `width/height` cố định (hoặc `aspectRatio`).

## 4. ⚠️ react-hooks purity (giống web — eslint/TS chặn)
- **KHÔNG** `Date.now()` / `new Date()` (không tham số) / `Math.random()` khi render. Tính ở store/mapper ngoài render. `new Date(iso)` (CÓ tham số) thì OK.
- Reset state theo prop: pattern render-phase (`if (x!==prev){setPrev(x);...}`), đừng `setState` đồng bộ trong `useEffect`.

## 5. Quy trình QUÉT DIFF + PORT một màn
1. **Định vị cặp file**: web `web/src/pages/<feature>/` ↔ mobile `mobile/src/screens/<feature>/`. Liệt kê component 2 bên.
2. **Đọc song song** file view tương ứng + `utils.ts` (view-mapper) + `constants.ts` 2 bên. So: JSX vs RN, class vs style, asset, LOGIC hiển thị (điều kiện hiện/ẩn), action gọi store.
3. **Lập bảng diff** theo 3 nhóm: (A) tính năng web có mobile thiếu; (B) khác style/vị trí/logic; (C) giống. (Xem output mẫu ở lần review phòng chat.)
4. **Đối chiếu store shared**: tính năng "thiếu" thường **đã có action trong `@ola/shared`** (vd `sendImage`) — chỉ thiếu UI mobile. Grep store trước khi kết luận phải viết logic.
5. **Port view**: dịch primitive (mục 2) + class→style (mục 3); tái dùng component mobile sẵn có (`VipAvatar`, `Avatar`, `ConfirmDialog`, `MessageActionSheet`, `ToastHost`, `richText`); asset `.svg`→`.png`.
6. **Xử lý per-platform** (mục 1): toast qua store, ảnh cần image-picker (mục 6), viewer, persist qua MMKV.
7. **Giữ nguyên hành vi**. Nếu buộc phải đổi hiển thị (vd bỏ nhãn giờ lặp) → đã là "sửa cho khớp web", cứ làm; nếu mơ hồ → hỏi user.
8. `pnpm typecheck && pnpm lint` sạch → chạy iOS xem thật (mục 7). Commit tiếng Việt, prefix `feat(mobile/<feature>)` hoặc `fix(mobile/...)`.

## 5b. ⚠️ ĐỪNG chỉ port `*View` — truy WRAPPER + nơi MOUNT (nguyên nhân gốc hay bị sót NHẤT)
Web tách mỗi màn thành **2 tầng**: component **inner** `*View` / `*List` (nội dung nhìn thấy) + một **wrapper** `*Overlay` / `*Panel` + **nơi mount** trong app-shell (`pages/home/HomePage.tsx`). Khi port, rất dễ chỉ port cái inner `*View` → một `*Screen` mobile, rồi **bỏ sót toàn bộ logic nằm ở wrapper và nơi mount** — build vẫn sạch, nhìn màn vẫn "giống", nhưng thiếu hành vi.

**Wrapper / nơi mount thường giữ những thứ KHÔNG có trong `*View`:**
- **Xác nhận đóng/rời màn** (quit confirm) — vd `RoomChatOverlay` bọc `RoomChatView`, `onClose` → `ConfirmDialog` "rời phòng". Mobile port `RoomChatView`→`RoomChatScreen` mà quên → back thẳng không hỏi.
- **Dialog phụ / chặn hành động** — vd `RoomPanel.enterRoom`: phòng đầy (`members>=CAP`) → dialog "mua VIP", KHÔNG cho vào. Mobile bỏ → vào thẳng phòng đầy.
- **Nút action trên header** — vd nút refresh nằm ở `RoomPanel` (header), không ở `RoomList`.
- **Overlay join/loading** — `RoomJoiningOverlay` (đang vào phòng) nằm ở `RoomChatOverlay`.
- **VỊ TRÍ mount = hành vi cấu trúc** — `RoomChatOverlay` render TRONG vùng nội dung (trên `BottomTabBar`) → tab bar vẫn hiện; `ActiveConversationOverlay` render ở cấp gốc → che tab bar. Đây là lý do room giữ tab bar còn chat 1-1 thì không. Mobile phải dịch sang cấu trúc navigator (nested stack trong tab vs push trên RootStack) — xem lịch sử.

**Biến thể hay gặp #2 — panel/grid data-driven thiếu CẢ DATA + ASSET (không chỉ UI):**
Khi port một panel liệt kê ảnh (emoji/smiley/sticker), mobile có thể **chưa có bộ dữ liệu lẫn thư mục ảnh** — nên tab đó bị bỏ hẳn, không phải "quên UI". Vd panel chọn kul: web có **3 tab Emoji/Smiley/Kul** (`SmileyGroupPanel`), mobile chỉ có Smiley/Kul vì **thiếu toàn bộ emoji** (`lib/emoji.ts` + 31 ảnh `assets/icons/emoji/`). Bẫy kỹ thuật:
- Web nạp cả thư mục ảnh bằng `import.meta.glob('.../*.png')` → **RN Metro KHÔNG có glob runtime**. Phải **copy nguyên thư mục ảnh** sang `mobile/src/assets/...` rồi **tự sinh danh sách `require()` tĩnh** (vd `emojiImages.ts` — 1 dòng `require` mỗi file, sort theo tên khớp thứ tự index của web).
- Nếu data dùng **token dạng chuỗi** (`[e:5]`, `(y)`), phải thêm token đó vào **bộ tách của mobile** (`splitSmileys`/`renderRichText`) — không thì tin đã gửi sẽ hiện **chữ thô `[e:5]`** thay vì ảnh. Mirror đúng regex + resolver của web (vd `new RegExp('\\[e:\\d{1,2}\\]|'+SMILEY_PATTERN)` + `SMILEY_MAP[code] ?? emojiImageForToken(code)`).
- Nhớ copy cả **icon tab** (`.png`) cho tab bar; đối chiếu **thứ tự tab** với web (Emoji → Smiley → Kul).

**Cách làm ĐÚNG mỗi khi port `XView`:**
1. `grep -rn "<XView\|XOverlay\|XPanel" web/src` → tìm wrapper bọc nó.
2. Mở **`web/src/pages/home/HomePage.tsx`** xem feature mount Ở ĐÂU (trong `flex-1` hay cấp gốc), có anh-em `ConfirmDialog`/overlay/`BottomTabBar` nào → suy ra tab bar ẩn/hiện + các dialog phải port.
3. Đọc wrapper: `onClose`/`onBack` có confirm không? có secondary dialog (full/VIP/block) không? có nút header nào không?
4. Trên mobile, wrapper thường dịch thành: **back handler** (`navigation.addListener('beforeRemove')` + `preventDefault` + `ConfirmDialog`, kèm `gestureEnabled:false` để vuốt không bỏ qua) + các `ConfirmDialog`/overlay đặt trong `*Screen` + **vị trí trong navigator** (nested stack trong tab để giữ tab bar).

## 6. Thêm tính năng ẢNH cho mobile (khi port chat/room images)
- **Type**: `GroupedMessage` nằm ở `@ola/shared/types` (dựng feed bằng `buildRoomFeed` trong `@ola/shared/lib`), cần có `type?`,`imageUrl?`,`status?` — nếu không, ảnh người khác gửi cũng không hiện.
- **Hiển thị**: trong bong bóng room/chat mobile, xử lý `message.type==='image'` → `<Image source={{uri}}>`, `status==='uploading'` → overlay spinner, `'failed'` → nút resend gọi `resendRoomImage`. Bấm ảnh → mở viewer.
- **Chọn ảnh**: dùng `@lib/imagePicker` có sẵn (mục 1) → ra `NativeUploadFile{uri,name,type}` → gọi `sendImage`/`sendMessage(image)`. Nếu buộc phải thêm native dep mới: `pod install` + rebuild (thiếu link native gây redbox `NativeModule ... is null`).
- ⚠️ **Preview ảnh TRƯỚC khi gửi (state `pendingImages` của composer) — RẤT DỄ BỎ SÓT.** Web (`RoomComposerBar`) **KHÔNG gửi ngay** khi chọn ảnh: nạp vào mảng `pendingImages[]`, **thay ô nhập** bằng dải preview ngang (thumbnail ~44px bo góc, nút **×** xoá từng ảnh, nút **Cancel** xoá hết, hỗ trợ **nhiều ảnh**), bấm **Send** mới loop `onSendImage`. Nếu mobile chỉ làm `pickAndSendImage` (chọn xong gửi luôn) là **thiếu nguyên tính năng này** — đúng kiểu bẫy 5b (chỉ port hành vi trong cùng, bỏ **state của composer**). Mẫu đã làm đúng: `screens/room/components/RoomComposerBar.tsx` và `screens/chat/ChatDetailScreen.tsx`. *Cách khớp*: chọn nhiều ảnh (`selectionLimit: 0`) → `setPendingImages` → khi `pendingImages.length>0` thì render `<ScrollView horizontal>` các thumbnail `<Image source={{uri}}>` + nút ×/Cancel thay cho `TextInput`, và nút phải đổi thành **Send** (`pendingImages.length>0 ? Send : isTyping ? Send : Like`) gọi `sendPendingImages()` loop từng `onSendImage(file)`. Không có `URL.createObjectURL`/revoke như web — RN dùng thẳng `asset.uri`.
- Nén ảnh: mobile dùng `compressImagesForUpload` từ `@lib/compressImage` (cùng tên với web, nhận `NativeUploadFile`).
- **Composer đăng bài (`MeComposerDialog` → `MeComposerModal`)**: store `createPost(payload, files, imageUrls)` / `updatePost(id, ...)` **tự upload files**, mobile chỉ truyền `NativeUploadFile[]`. Port đủ: privacy pills (public/friend/private), ảnh + preview strip (MAX 5), sticker (kul grid → code `kul:N`), smiley (reuse `SmileyKulPanel` `hideKul` + overlay WYSIWYG chèn vào nội dung), thanh 5 nút attach, **edit mode** (prop `editPost` → seed state qua `useEffect(...,[visible])` + gọi `updatePost`; mở khoá item "Edit" trong menu bài, có check `EDIT_WINDOW_MS`). ⚠️ Nút attach mở panel bị `autoFocus`→`onFocus={()=>setPanel(null)}` của input đóng ngay khi VERIFY (dùng thật thì OK) — tắt autoFocus khi chụp.
- **Tag bạn bè**: web `friendsStore` là web-local nhưng `RelationshipService.friends()` **có ở shared** → tạo `mobile/src/store/friendsStore.ts` mobile-local gọi service shared (KHÔNG cần API mới).
- **Check-in vị trí**: `GeoService.nearby/reverse` (fetch + `GEOAPIFY_KEY` — mobile `.env` ĐÃ có key) chạy trên RN, NHƯNG lấy toạ độ web dùng `navigator.geolocation` (web-only) → RN cần **native dep `@react-native-community/geolocation`** + `pod install` + **rebuild** (`run-ios`). `Geolocation.requestAuthorization()` rồi `getCurrentPosition(cb, errCb, {enableHighAccuracy, timeout})` — callback style, KHÔNG promise. ⚠️ `Info.plist` có thể ĐÃ có `NSLocationWhenInUseUsageDescription` nhưng **chuỗi RỖNG** → phải điền mô tả không rỗng, nếu không iOS từ chối hỏi quyền.
- **Verify tính năng GPS trên simulator (không tap được)**: ① `xcrun simctl location <udid> set 21.028511,105.804817` (vị trí giả Hà Nội); ② dialog quyền không bấm được → `xcrun simctl privacy <udid> grant location-always <bundleId>`; ③ dialog quyền CŨ treo trên SpringBoard (persist qua relaunch app) → `xcrun simctl spawn <udid> launchctl stop com.apple.SpringBoard` (SpringBoard tự khởi động lại, dialog biến mất).
- **Badge VIP cạnh tên (web `VipIcon`)**: mobile dùng `@components/ui/VipIcon` / `VipBadge` (prop `typeId`, size mặc định 24) + `activeVipTypeId(vipUsed, vipEndTime)` từ `@ola/shared/lib`. Web hay kèm `UserName` (title + `@username` phụ) — mobile render 2 `<Text>` xếp dọc.

## 7. Chạy thử iOS (bắt buộc sau khi port)
- Simulator có sẵn (`xcrun simctl list devices available`): iPhone 17 Pro (`F569E280-5BFF-4173-9F1B-61B4BB923810`), iPhone 17 Pro Max (`419D8097-955F-4780-A830-B76D0EDA4B2C`), iPhone 17, iPhone Air, iPhone 16e, các iPad Pro M4/M5. Bundle id: `com.ola.me.net.org.vn`.
- Chỉ đổi JS (không đổi native): cài sẵn `.app` ở `mobile/ios/build/Build/Products/Debug-iphonesimulator/OlaMobile.app` (`xcrun simctl install booted …`), chạy Metro `pnpm start --reset-cache`, rồi `xcrun simctl launch booted com.ola.me.net.org.vn` — không cần build lại.
- Nếu vừa thêm native dep: `cd mobile/ios && pod install` rồi rebuild — nếu không sẽ redbox `RNXxx is null`.
- **Sau khi `pnpm --filter mobile add <lib>`**: Metro cache module-map cũ → lỗi `Unable to resolve module <lib>` dù đã cài (pnpm hoist về root `node_modules`). **Kill Metro cũ rồi khởi lại `npx react-native start --reset-cache`**, sau đó relaunch app.
- Lib native cần quyền iOS: thêm key vào `ios/OlaMobile/Info.plist` (vd `react-native-image-picker` cần `NSPhotoLibraryUsageDescription` + `NSCameraUsageDescription`), nếu không app crash khi mở picker.
- Lệnh: khởi Metro nền (`npx react-native start`), rồi `npx react-native run-ios --udid <id> --no-packager`. Chụp: `xcrun simctl io <id> screenshot out.png` và Read ảnh để kiểm tra redbox + đối chiếu layout với web.
- ⚠️ `mobile/.env` và `.app` Debug có sẵn nhúng API **PROD** (`api.olachat.net`) — KHÔNG thử tính năng ghi dữ liệu trên prod. Test với backend local: tạm sửa `mobile/src/platform/env.ts` (`apiUrl`, `socketUrl` trỏ `localhost`), xong phải khôi phục. Đăng nhập cần tài khoản test (hỏi user).
- RN 0.86: `console.log` KHÔNG ra terminal Metro — đọc qua CDP (`curl localhost:8081/json` lấy `webSocketDebuggerUrl`, nghe `Runtime.consoleAPICalled`).
- **Tap tự động bằng idb**: `brew install facebook/fb/idb-companion` + venv python 3.13 `pip install fb-idb` (python 3.14 lỗi pyexpat). `idb ui describe-all --udid U` trả nhãn + frame → `idb ui tap <x> <y> --udid U` (toạ độ point = px/3), `--duration 1.2` = long-press. Gõ tiếng Việt: `printf '…' | xcrun simctl pbcopy U` rồi long-press ô nhập → Paste. Cấp quyền không bấm được dialog: `applesimutils --byId U --bundle com.ola.me.net.org.vn --setPermissions notifications=YES,photos=YES`.
- Khi luồng thường không tới được màn/dialog ở sâu, **ép tạm rồi REVERT**:
  - Vào thẳng màn: tạm thêm `initialRouteName` cho tab (`<Tabs.Navigator initialRouteName={TAB_ROUTES.Room}>`) + cho nested stack (`<RoomStack.Navigator initialRouteName={ROOM_ROUTES.RoomChat}>`) + `initialParams={{...}}` cho screen cần param.
  - Ép hiện dialog: tạm đổi `visible={cond}` → `visible` (true) trên `ConfirmDialog`/overlay muốn chụp.
  - Ép hiện overlay/menu cần STATE (vd bottom-sheet menu mở theo id post): tạm thêm `useEffect(() => { if (posts.length>0) setMenuPostId(posts[0].id); }, [posts.length])`.
  - Reload → `simctl ... screenshot` → Read ảnh → **revert HẾT các sửa tạm** (grep lại `initialRouteName`/param giả cho chắc sạch) → reload lại về luồng thật. Đây là cách duy nhất thấy tận mắt trong môi trường hiện tại.
  - ⚠️ Khi ép tạm bằng cách **thêm/bớt HOOK** (`useEffect`/`useMemo`) lúc app đang chạy, fast-refresh sẽ redbox `Rendered more hooks than during the previous render` (số hook lệch giữa 2 lần render). **Không phải lỗi thật** — cứ **terminate + launch lại** (không chỉ reload) là hết. Luôn full-relaunch sau khi ép/revert hook.

## 8. Tham chiếu chéo
- Chuẩn code web (helper/component/store sẵn có) → skill `refactor-ola-web`.
- Màn hình gốc APK (style/logic thật để biết bên nào "đúng") → skill `docs-screens-apk` (`older-ola/docs/screens/`).
- Đánh giá UI/UX sâu → skill `ui-ux-pro-max`.
