# Ghi chú kỹ thuật (chuyển từ comment trong code)

Quy ước repo là không viết comment trong code. Các ghi chú dưới đây trước đây nằm cạnh code, giải thích **vì sao** code được viết như vậy. Đọc trước khi sửa những chỗ này, vì phần lớn là workaround cho lỗi nền tảng: sửa "cho gọn" rất dễ làm lỗi cũ quay lại.

## Mobile — Cuộc gọi (`mobile/src/screens/call/`)

- **`CallOverlay.tsx` — `FullscreenLayer`**: khi thu nhỏ, lớp fullscreen chỉ ẩn bằng `opacity` + `pointerEvents`, không unmount. Unmount sẽ làm rớt audio session / foreground service giữa cuộc gọi.
- **`CallOverlay.tsx` — effect dọn PiP**: `setPipSupported(false, false)` + `exitPip()` chỉ chạy khi cuộc gọi kết thúc (unmount). Nếu đặt trong cleanup của effect phụ thuộc `[mode]` thì lúc chuyển outgoing → active trong khi đang PiP sẽ đóng nhầm cửa sổ.
- **`CallOverlay.tsx` — `useCallSession`**: LiveKit publish mic ngay khi connect, nên phải đợi audio session native cấu hình xong mới cho `LiveKitRoom` mount. Mount trước thì track lên trước khi route âm thanh sẵn sàng.
- **`CallOverlay.tsx` — foreground service đang tắt**: xem `docs/hidden-features.md`.
- **`CallVideoArea.tsx`**: `SurfaceView` của VideoTrack trên Android không tôn trọng `opacity: 0`. Khi overlay bị ẩn (thu nhỏ) phải gỡ hẳn renderer, không chỉ làm mờ.
- **`lib/callPermissionGuard.ts`**: khác web. Web coi `'failed'` là qua vì trình duyệt sẽ xin quyền lại lúc publish. Trên máy thật, mở được thiết bị là điều kiện cần: mở không được mà vẫn tạo call thì server có cuộc gọi còn client câm.
- **`lib/callForegroundService.ts`**: Android 14+ cắt mic/camera khi app xuống nền nếu không có foreground service đúng type. iOS lo phần này bằng `UIBackgroundModes` audio nên không cần gì thêm.
- **`lib/callAudioSession.ts`**:
  - Mọi thao tác vào/ra được nối tiếp nhau: nếu overlay unmount khi `configureAudio` còn đang await thì cleanup phải đợi setup xong mới chạy, không thì `stop()` rơi vào giữa và session bị bỏ lại ở trạng thái đang bật.
  - Ba thứ tranh nhau audio route: react-native-sound (SFX, category Ambient đặt ở top-level `lib/sound.ts`), nitro-sound (ghi/phát voice message) và WebRTC. Vào cuộc gọi phải nhả hẳn voice playback rồi mới đổi category, nếu không iOS giữ route cũ và cuộc gọi không có tiếng.
- **`lib/primeCallPermissions.ts`**:
  - `BLUETOOTH_CONNECT` là quyền runtime từ Android 12: không xin thì tai nghe bluetooth không có trong danh sách audio output. Thiếu nó vẫn gọi được bằng loa / tai nghe trong, nên không phải điều kiện bắt buộc.
  - Quyền thông báo không phải điều kiện để FGS chạy, nhưng Android 13+ ẩn thông báo cuộc gọi khỏi notification drawer nếu chưa cấp.
  - iOS không có API xin quyền riêng như Android: prompt hệ thống chỉ bật khi thật sự mở thiết bị, nên phải `getUserMedia` rồi tắt ngay track vừa mở.

## Mobile — Voice message (`VoiceBubble.tsx`, `chat/voice/VoicePreviewBar.tsx`, `lib/voicePlaybackSession.ts`, `hooks/useVoiceRecorder.ts`)

- Khi huỷ: huỷ luôn lượt load đang chạy để callback của nó không phát sau khi recorder (hoặc voice khác) đã giành playback session. `release()` native dừng và gỡ player khỏi pool trong cùng một lệnh.
- Tiếp tục sau pause thì `start()` tự chạy từ chỗ đang dừng, không cần seek. Chỉ seek khi player biết độ dài thật: seek trên player có `duration = 0` bị coi là "past end" và làm media extractor của máy abort.
- Phát xong là bỏ hẳn player, lần sau tạo mới. Dùng lại MediaPlayer ở trạng thái PlaybackCompleted làm media extractor chết (MIUI: `libmmparser_lite.so` abort → `MEDIA_ERROR_SERVER_DIED`), lần phát thứ hai luôn hỏng.
- `mixWithOthers` phải là `true` như mọi chỗ khác trong app. Mặc định `false` của lib bật nhánh audio-focus của react-native-sound trên Android; nhánh đó không nhả focus đúng và đụng MediaPlayer từ main thread.
- Đăng ký quyền phát ngay từ lúc bắt đầu load, không đợi load xong: bấm ghi âm giữa chừng thì `releaseVoicePlayback()` mới thấy và huỷ được lượt này.
- Ghi âm phải giải phóng hẳn playback đang chạy, không chỉ pause: không để audio phát vào mic và không giữ player cũ qua lần đổi audio route trên iOS. Release trước khi mở mic cũng là lớp bảo vệ khi audio route của iOS thay đổi.
- `useVoiceRecorder`: giá trị `AudioSet` số tự đặt có thể bridge sai trong bản release iOS, nên để AVAudioRecorder dùng mặc định của Nitro Sound.

## Mobile — Bàn phím và danh sách chat

- **`App.tsx` — `KeyboardProvider statusBarTranslucent`**: `ChatKeyboardArea` đo tọa độ từ mép màn hình; giữ `statusBarTranslucent` để `content.height` của RNKC dùng cùng gốc y = 0 trên Android.
- **`components/ChatKeyboardArea.tsx`**:
  - Vùng nội dung có composer: clip (`overflow: hidden`) + translate-with-padding để suốt animation chỉ transform trên UI thread, list không relayout từng frame.
  - Android bắt buộc `automaticOffset` (RNKC lấy tọa độ tuyệt đối bằng `viewPositionInWindow` native): `measureInWindow` không tin cậy khi cờ edge-to-edge của RN đang tắt (Android ≤ 14), Fabric trừ status-bar inset dù cửa sổ đã edge-to-edge, khiến composer bị IME che đúng phần inset bị trừ.
  - iOS giữ cách đo `measureInWindow` như trước. Lỗi edge-to-edge chỉ thuộc Android nên tách theo nền tảng để không đổi cách tính trên iOS.
  - Composer giữ safe-area padding khi bàn phím mở; phần padding đó được trừ khỏi translation để nút vẫn sát bàn phím. Prop `bottomInset` là safe-area padding đã render sẵn bên trong composer.
- **`components/KeyboardView.tsx`**: chỉ đăng ký NativeWind interop cho `KeyboardView`, không đăng ký toàn cục cho `KeyboardAvoidingView` của RNKC; các chỗ dùng RNKC trực tiếp không cần `className`.
- **`hooks/useStickyBottomList.ts`**: viewport nhỏ lại thì phải chỉnh offset để tin mới nhất vẫn hiện. Khi viewport lớn lên (vd bàn phím đang đóng), scroll view native tự kẹp offset về đáy mới; gọi thêm `scrollToEnd` từ JS sẽ chạy trễ một frame và gây giật.
- **`hooks/useTabSwipeGesture.ts`**: không chặn native responder, vì chặn thì `GestureHandlerRootView` trên Android huỷ touch JS ngay sau khi grant.
- **`screens/room/components/MessageActionSheet.tsx`**: giữ preview trùng vị trí tin thật. Nếu bên dưới không đủ chỗ cho menu thì lật menu lên trên (menu trên preview, thanh reaction trên menu) thay vì kéo preview lên, nhờ vậy tin sát đáy vẫn không bị lệch.

## Mobile — App lock, cập nhật, đánh giá

- **`components/applock/appLockModal.tsx`**: Dialog / OlaModal chỉ phụ thuộc file nhẹ này; `AppLockOverlay` (kéo theo services, native module) tự đăng ký khi app khởi động qua `AppLockGate`.
- **`components/applock/AppLockOverlay.tsx`**: lớp khoá / che đặt ở root và bên trong MỌI Modal (OlaModal, Dialog). Modal native luôn nằm trên view thường nên không đè từ ngoài vào được; thay vì ẩn modal (mất bản nháp), mỗi modal tự vẽ lớp này lên trên nội dung của nó.
- **`components/AppUpdateGate.tsx`**: iOS bỏ qua lần present Modal nếu lúc đó có màn khác chen vào (vừa mở app, redbox…) và không tự thử lại; chưa thấy `onShow` thì gắn lại Dialog.
- **`lib/appUpdate.ts`**:
  - Bản Android lấy native module ngay lúc import; APK chưa build kèm module (vd nhận bundle OTA) mà require là crash.
  - Play chỉ trả versionCode nên Android so với build number; app không cài từ Google Play thì Play Core báo lỗi → unknown.
  - Không hỏi được server thì trả `null` để giữ nguyên hộp thoại đang hiện, tránh việc rớt mạng là thoát được màn bắt buộc cập nhật.
- **`store/appUpdateStore.ts`**: hỏi store trước; store chưa có bản mới hơn thì thôi, khỏi gọi API (cũng không chặn oan khi store chưa duyệt xong bản mới). Không hỏi được store (máy không có Google Play, mất mạng…) thì vẫn gọi API để danh sách bản phải cập nhật còn hiệu lực.
- **`services/otaUpdate.ts`**: link tải asset đi qua CDN của GitHub, không dính giới hạn 60 request/giờ/IP của API. Manifest gộp dồn: mỗi `app_version` (versionName / MARKETING_VERSION) giữ bundle mới nhất của nó. Không khởi động lại giữa chừng: bundle mới được nạp ở lần mở app sau.
- **`lib/appReview.ts`**: gọi ở những khoảnh khắc người dùng vừa nhận được thứ gì đó vui, KHÔNG gọi lúc mở app. Cả Apple lẫn Google đều giới hạn số lần hiện popup và không báo lại kết quả, nên mỗi lần gọi là tiêu một lượt.
- **`screens/profile/useProfileActions.ts`**: lỗi khi tải lại profile được bỏ qua có chủ đích (giữ dữ liệu đang hiện).

## Shared (`packages/shared/src/`)

- **`stores/appConfigStore.ts`**: màn nào cũng tải lại config khi vào; các màn mở cách nhau vài giây dùng chung một request, config không đổi chỉ tốn một lượt notModified.
- **`stores/chat/chatConversationActions.ts`**:
  - `checkDirect` và `createDirect` đều trả về không có `otherUser`, nên một hội thoại chưa có trong cache (đã ẩn, hoặc phiên mới) sẽ vào danh sách mà không có peer: `openConversation` bỏ qua bước tải profile, `peerRelationship` null và mọi thao tác cần peer bị chết. `name` / `avatar` của chúng đã mô tả người kia, nên dựng lại peer từ đó cộng với profile nếu đúng người.
  - Gửi voice và bắt đầu gọi đều có thể "nâng" cùng một draft thành hội thoại thật. Nếu không dùng chung request, bên chậm hơn thấy `draftRecipient` đã bị xoá và nhận `null`; nhánh voice sẽ báo lỗi chung sau khi đã vứt bản ghi âm.
- **`stores/chat/chatRealtime.ts`**: tin đến vẫn phải có tiếng ngay cả khi đang mở hội thoại đó; adapter của nền tảng vẫn áp cài đặt âm thanh thông báo của người dùng. Tắt tiếng theo từng hội thoại vẫn được ưu tiên.
- **`lib/eggGiftFixture.constants.ts`**: danh mục quà tĩnh dự phòng cho client. **`lib/eggGame.constants.ts`**: hình học, thời gian và chuỗi animation tĩnh của game đập trứng.

## Web

- **`src/index.css` — `input, textarea, select { font-size: max(16px, …) }`**: giữ cỡ chữ tối thiểu 16px để iOS Safari không tự zoom khi focus ô nhập, mà vẫn tôn trọng chế độ chữ lớn.
