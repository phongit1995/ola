# 11 — Voice chat trong bàn (plan)

Trạng thái: **plan, chưa code**. Tài liệu này chốt phạm vi, đánh giá khả thi, việc cần làm theo từng phần và thiết kế giao diện.

## 1. Phạm vi đã chốt

- **Bật voice khi tạo bàn.** Chủ bàn bật công tắc "Voice" trong modal Tạo bàn. Server chỉ cho bật nếu chủ bàn **còn hạn VIP lúc tạo bàn**. VIP hết hạn giữa chừng thì voice vẫn giữ tới khi giải tán bàn.
- **Ai nói, ai nghe.** Người ngồi ghế (chủ bàn và khách) bấm mic để nói, bấm lại để tắt, không cần xin phép ai. Người xem chỉ nghe.
- **Tắt tiếng người khác.** Ai cũng tắt tiếng được bất kỳ ai, nhưng **chỉ trên máy mình**. Không có chuyện một người tắt mic người khác cho cả bàn.
- **Không làm:** khoá mic theo người, xin mở mic, chủ bàn duyệt, chỉ định người được nói.
- **Âm thanh chạy ngay trong game** (`livekit-client` trong trang game), không chuyển sang native của app.
- **Backend động ít nhất có thể:** chỉ lưu cờ voice của bàn và cấp token LiveKit.

## 2. Đánh giá khả thi

**Kết luận: khả thi**, rủi ro chính nằm ở WebView trên điện thoại, không nằm ở server.

| Hạng mục | Hiện trạng | Đánh giá |
|---|---|---|
| Server voice | LiveKit đã chạy cho tính năng gọi điện (`LIVEKIT_URL/API_KEY/API_SECRET` trong config, `github.com/livekit/protocol` đã có trong `go.mod`) | Dùng lại cùng server LiveKit, không dựng thêm hạ tầng |
| Biết ai ở bàn | Engine game lưu bàn (`Room`: chủ, khách, `AllowSpectators`) và người xem theo ván trong Redis | Đủ dữ liệu để quyết định ai được nói, ai chỉ được nghe |
| VIP chủ bàn | `Room.OwnerVipType` chỉ có giá trị khi VIP còn hạn lúc tạo bàn (`GetUserInfo` lọc theo `VipEndTime`) | Kiểm tra VIP không cần truy vấn thêm |
| Web | Game chạy trong `<iframe allow="autoplay; fullscreen">` | Cần thêm `microphone` vào `allow`, nếu không trình duyệt chặn mic |
| Mobile | Game chạy trong `react-native-webview` 14, app đã khai quyền mic (`NSMicrophoneUsageDescription`, `RECORD_AUDIO`) cho tính năng gọi | iOS cần thêm prop `mediaCapturePermissionGrantType` cho WebView; Android tự hỏi quyền runtime |
| App bản cũ | Chưa có các thay đổi trên | Vẫn **nghe** được (nghe không cần quyền mic); bấm mic thì báo cập nhật app |
| Tái sử dụng | Mọi game dùng chung SDK socket ở `game/src/sdk` | Viết phần voice trong SDK, game khác (caro, cờ tướng…) dùng lại về sau |

**Rủi ro và cách xử lý:**
1. **WebRTC trong WebView:** cần iOS 14.3+ và Android System WebView đời mới. Máy không hỗ trợ thì ẩn nút mic và chỉ cho nghe.
2. **Âm lượng trên iOS:** khi WKWebView đang thu mic, iOS chuyển sang chế độ thoại và có thể làm âm lượng phát nhỏ đi. Vì vậy khi tắt mic phải **dừng hẳn track mic** (`stopMicTrackOnMute`), không chỉ mute, để iOS trả âm thanh về chế độ thường.
3. **Đụng cuộc gọi trong app:** đang gọi điện trong app mà mở game bật mic thì iOS có thể ngắt một bên. Game bắt lỗi track kết thúc, tự tắt mic và báo cho người dùng.
4. **Chạy nền:** app vào nền thì iOS dừng âm thanh WebView. Quay lại thì LiveKit tự kết nối lại; nếu token đã hết hạn thì game xin token mới.
5. **Người bị kick nghe lén:** client bình thường tự rời phòng voice khi nhận `ROOM_KICKED`. App bị sửa có thể nghe tiếp tới khi thoát. Mức này chấp nhận được; nếu cần chặn hẳn, bổ sung sau một lệnh để server đuổi người đó khỏi phòng LiveKit.
6. **Chi phí:** chỉ có âm thanh (Opus khoảng 32 kbps mỗi người nói), mỗi bàn tối đa 4 người nói và 20 người nghe, băng thông thấp. Nên có công tắc tổng ở admin để tắt nhanh khi cần.

## 3. Thiết kế tổng thể

```text
Game (iframe/WebView)                 Service game (cmd/game)            LiveKit
──────────────────────                ───────────────────────            ───────
ROOM_CREATE { voice: true } ───────▶  kiểm tra VIP chủ bàn
                                      lưu Room.VoiceEnabled
ROOM_STATE / ROOM_UPSERT  ◀─────────  { voiceEnabled }

VOICE_TOKEN { roomId }    ───────▶    kiểm tra thành viên / người xem
VOICE_TOKEN { url, token,  ◀───────   tạo token phòng game:<gameId>:<roomId>
              canPublish }
livekit-client.connect(url, token) ──────────────────────────────────▶  phòng voice của bàn
bật/tắt mic, ai đang nói, tắt tiếng người khác  ◀────────────────────▶  (không qua server game)
```

- Mỗi bàn là một phòng LiveKit `game:<gameId>:<roomId>`. Voice có từ **phòng chờ** cho tới khi bàn giải tán, không đứt giữa các ván.
- Identity trong LiveKit là `userId`, để game khớp người nói với ghế.
- Bật/tắt mic, ai đang nói, tắt tiếng phía mình đều do LiveKit và client lo. Server game không biết và không cần biết.

### 3.1 Vòng đời phòng voice

**ID bàn giữ nguyên qua các ván.**
- Lúc bắt đầu ván, engine xoá bàn khỏi danh sách bàn chờ nhưng `Match` vẫn giữ bản sao `Room` (lưu cả vào snapshot Redis).
- Hết ván, bàn được dựng lại với cùng ID (`prepareNextRound`).
- Vì vậy phòng LiveKit `game:<gameId>:<roomId>` sống liền mạch từ phòng chờ, qua nhiều ván, tới khi giải tán bàn. **Giữa các ván không ngắt và không kết nối lại.**

**Phòng LiveKit không cần tạo hay xoá tay.**
- LiveKit tự tạo phòng khi người đầu tiên vào.
- Người cuối cùng rời thì LiveKit tự đóng phòng sau khoảng 20 giây (`departure_timeout`).
- Phòng trống không tốn tài nguyên; chi phí chỉ tính theo người đang kết nối.
- Module gọi điện hiện cũng dựa vào cơ chế này.

| Tình huống | Điều xảy ra |
|---|---|
| Người mới vào bàn (giữa các ván) | Client nhận `ROOM_STATE` có `voiceEnabled`, xin `VOICE_TOKEN` rồi kết nối. Người cũ nhận sự kiện `ParticipantConnected` và ghế mới hiện trạng thái voice. **Người cũ không phải kết nối lại.** |
| Một người rời bàn hoặc bị kick | Client người đó gọi `leave()`. Người còn lại nhận `ParticipantDisconnected`, ghế bỏ hiệu ứng voice. Người tiếp theo vào ghế đó kết nối như dòng trên. |
| Người xem vào xem giữa ván | Xin token chỉ nghe rồi kết nối, nghe được ngay. Thôi xem thì `leave()`. |
| Mất mạng ngắn | LiveKit tự kết nối lại bằng token cũ. Mất lâu, token hết hạn thì game xin token mới. |
| App bị tắt ngang (không kịp `leave()`) | LiveKit tự loại người đó sau khoảng 15–20 giây không có tín hiệu. |
| Giải tán bàn (chủ bàn rời, bàn đóng) | Mọi client nhận `ROOM_CLOSED`/`ROOM_REMOVED` rồi `leave()`. Người cuối rời thì LiveKit tự đóng phòng. |

**Tuỳ chọn chặn hẳn (chưa làm ở đợt đầu).**
- Muốn chắc chắn người đã rời hoặc bị kick không ở lại nghe lén bằng app đã sửa, có thể thêm ở server:
  - `RemoveParticipant` khi một người rời bàn hoặc bị kick.
  - `DeleteRoom` khi giải tán bàn.
- Cách làm: gắn vào chỗ engine phát sự kiện đóng bàn và kick (`emitRoomClosed`, `KickRoomMember`). Khoảng 20–30 dòng, không đổi luồng bàn/ván.

## 4. Backend (service game)

| File | Thay đổi |
|---|---|
| `internal/game/protocol/protocol.go` | `RoomCreateData` thêm `Voice *bool`. Dữ liệu bàn gửi về client (`ROOM_UPSERT`, `ROOM_STATE`) thêm `voiceEnabled`. Thêm lệnh `VOICE_TOKEN` (C2S và S2C) và các mã lỗi `VOICE_DISABLED`, `VOICE_NOT_MEMBER`, `VOICE_UNAVAILABLE` |
| `internal/game/engine/room_store.go` | `Room` thêm `VoiceEnabled bool` |
| `internal/game/engine/room.go` | Lúc tạo bàn: `VoiceEnabled = voice && owner.VipType != nil` |
| `internal/game/engine/room_emit.go` | Gửi kèm `voiceEnabled` trong dữ liệu bàn |
| `internal/game/engine` | Thêm 1 hàm chỉ đọc trả về `voiceEnabled` và vai trò của người hỏi (người chơi, người xem, người ngoài). Hàm này phải xét 2 trạng thái: **đang chờ** thì đọc `Room` trong store bàn; **đang đánh** thì bàn không còn trong store, phải đọc `Match` có `listedRoomID` trùng, lấy người chơi của ván, người xem của ván và cờ voice từ bản sao `Room` trong match |
| `internal/game/voice.go` (mới) | Xử lý `VOICE_TOKEN` theo 4 bước bên dưới |
| `internal/game/server.go` | Thêm 1 `case` trong `handleMessage` |
| Hàm tạo token LiveKit | Tách `mintToken` của `internal/modules/call` ra gói dùng chung (cho phép tham số `canPublish`), module call và game cùng dùng |
| Deploy | Service game cần thêm 3 biến môi trường `LIVEKIT_*`; thiếu thì trả `VOICE_UNAVAILABLE` |

Các bước xử lý `VOICE_TOKEN` trong `voice.go`:
1. Bàn không bật voice thì trả `VOICE_DISABLED`.
2. Chủ bàn và khách nhận token có `canPublish = true`, `canSubscribe = true`.
3. Người xem nhận token có `canPublish = false`, `canSubscribe = true`, với điều kiện bàn cho phép người xem và người đó đang xem bàn. "Đang xem" có 2 trường hợp:
   - **Xem bàn đang chờ** (màn xem phòng chờ, lệnh `roomWatch`): kiểm tra map `roomWatching` của chính kết nối socket đó trong `server.go`.
   - **Xem ván đang đánh** (`SPECTATE_JOIN`): kiểm tra danh sách người xem của ván.
4. Người ngoài bàn nhận `VOICE_NOT_MEMBER`.

Token sống 15 phút. Game xin lại khi kết nối lại, hoặc khi người xem được mời ngồi vào ghế (lúc đó cần quyền nói).

Không đổi: luồng bàn/ván, settlement, lịch sử, DB (không migration). Dữ liệu bàn cũ trong Redis không có `voiceEnabled` thì coi như tắt.

**Test backend** (thêm vào file test có sẵn của engine): tạo bàn có/không VIP; token cho chủ bàn, khách, người xem, người ngoài; bàn tắt voice.

## 5. Game client

### 5.1 SDK dùng chung (`game/src/sdk`)

- Thêm `livekit-client` vào `game/package.json`.
- **Module voice mới** trong SDK, có các hàm:
  - `join(roomId)`: xin token qua socket rồi kết nối LiveKit.
  - `leave()`.
  - `setMic(on)`: tắt thì dừng hẳn track mic.
  - `setSpeaker(on)`: tắt/bật mọi âm thanh nhận về.
  - `setPeerMuted(userId, muted)`: chỉnh âm lượng người đó về 0 trên máy mình.
- **Sự kiện đẩy ra cho UI:** trạng thái kết nối, ai đang nói (`ActiveSpeakersChanged`), ai đang tắt mic, lỗi (bị từ chối quyền, không hỗ trợ, mất kết nối).
- **Xử lý autoplay:** gọi `room.startAudio()` ở lần chạm đầu tiên nếu trình duyệt chặn phát âm thanh.
- **Ghi nhớ:** danh sách người mình đã tắt tiếng lưu theo bàn trong bộ nhớ; rời bàn là xoá.

### 5.2 Tiến lên (`game/thirteen`)

- Store `useThirteen`: thêm `voiceEnabled` của bàn, trạng thái voice của mình, `speakingIds`, `micOffIds`, `peerMutedIds`.
- Lệnh `createRoom` gửi thêm `voice`.
- **Vòng đời:**
  - Vào phòng chờ hoặc vào ván của bàn có voice thì `join`. Người xem cũng `join`, chỉ nghe.
  - `ROOM_KICKED`, rời bàn, bàn giải tán hoặc thoát game thì `leave`.
  - Thu nhỏ game thì vẫn giữ voice.
- Ván tập luyện (`practice`) không có voice.

## 6. App chủ (bắt buộc, 2 chỗ)

- **Web** `web/src/pages/apps/ArcadeOverlay.tsx`: `allow="autoplay; fullscreen; microphone"`.
- **Mobile** `mobile/src/screens/apps/ArcadeOverlay.tsx`: thêm `mediaCapturePermissionGrantType="grantIfSameHostElsePrompt"` cho `WebView`. Cần phát hành bản app mới; bản cũ vẫn nghe được.

## 7. Thiết kế giao diện

Theo design system Style 02 (`01-art-direction.md`, `03-component-specs.md`): viền navy, nút tròn, touch target tối thiểu 44 × 44 px, chữ live. Icon voice vẽ bằng SVG trong code, không cần sinh ảnh.

### 7.1 Modal Tạo bàn

Thêm 1 hàng dưới ô mật khẩu:

```text
┌──────────────────────────────────────┐
│ Mật khẩu (bỏ trống nếu công khai)    │
│ [ Không đặt mật khẩu              ]  │
│                                      │
│ 🎙 Voice chat                 [●──]  │
│ Mọi người trong bàn nói chuyện bằng  │
│ giọng nói. Người xem chỉ nghe.       │
│                                      │
│        [ Hủy ]      [ Tạo bàn ]      │
└──────────────────────────────────────┘
```

- **Chủ bàn có VIP:** bật được, mặc định **tắt**. Lần sau mở modal thì nhớ lựa chọn lần trước (`localStorage`).
- **Chủ bàn không có VIP:** công tắc mờ, có nhãn vương miện "VIP", dòng phụ "Cần VIP để mở voice cho bàn". Bấm vào thì hiện gợi ý mua VIP. Nếu bridge có lệnh mở cửa hàng VIP thì mở, không thì chỉ hiện chữ.

### 7.2 Sảnh: danh sách bàn

- Bàn có voice: thêm icon mic nhỏ cạnh số cược trên thẻ bàn, để người vào biết trước là bàn có voice.

### 7.3 Phòng chờ (chưa chơi, đang bấm Sẵn sàng)

Voice dùng được ngay từ phòng chờ. Vào bàn là tự kết nối, nên mọi người nói chuyện được trong lúc chờ đủ người, bấm Sẵn sàng hoặc chờ chủ bàn bấm Bắt đầu. Sang ván thì vẫn nối tiếp cùng phòng voice.

```text
┌──────────────────────────────────────┐
│ [←]  Bàn của Minh Anh · 🎙     [🔊]  │  ← nút loa trên thanh trên
│                                      │
│   ┌──────┐ ┌──────┐ ┌──────┐ ┌────┐  │
│   │ ◯🎙  │ │ ◯🔇  │ │  +   │ │ +  │  │  ← ô ghế: chấm voice ở góc avatar,
│   │Minh A│ │ Bảo  │ │ Trống│ │    │  │     viền xanh khi đang nói
│   └──────┘ └──────┘ └──────┘ └────┘  │
│                                      │
│ [ khung chat phòng chờ            ]  │
│                                      │
│ [🎙]   [      Sẵn sàng          ]    │  ← nút mic tròn cạnh nút Sẵn sàng / Bắt đầu
└──────────────────────────────────────┘
```

- **Nút mic** là nút tròn 44 px đặt bên trái nút "Sẵn sàng" / "Bắt đầu" trong `tl-room-actions`, dễ với bằng ngón cái. Bốn trạng thái giống nút mic ở bàn chơi (mục 7.4). Chỉ người ngồi ghế mới có nút mic.
- **Nút loa** ở thanh trên cùng (`tl-topbar`, vị trí `tl-topbar-spacer`).
- **Ô ghế** (`tl-seat-grid`): chấm voice ở góc avatar và viền xanh khi đang nói, theo bảng trạng thái ở mục 7.4. Bấm vào ô ghế của người khác mở menu "Tắt tiếng / Bật tiếng" phía mình. Ô "Trống" không có gì.
- **Tiêu đề bàn:** có icon mic nhỏ để biết bàn này có voice.
- **Màn xem bàn đang chờ** (người xem, `WatchedRoomScreen`): chỉ có nút loa, nghe được cả bàn, không có nút mic.
- **Ở sảnh** (chưa vào bàn nào): không có voice; chỉ thấy icon mic trên thẻ bàn có voice (mục 7.2).

### 7.4 Bàn chơi

```text
┌──────────────────────────────────────┐
│ [←]  Tiến Lên Miền Nam   [🔊] [💬]   │  ← thêm nút loa cạnh nút chat
│                                      │
│              (ghế trên)              │
│   (ghế trái)              (ghế phải) │
│        ◯ viền xanh = đang nói        │
│        🔇 góc avatar = tắt mic       │
│                                      │
│ [avatar Bạn] Bạn        [🎙] [💡]    │  ← nút mic cạnh nút Gợi ý
│ [   bài trên tay                  ]  │
│ [ Bỏ lượt ]          [ Đánh ]        │
└──────────────────────────────────────┘
```

**Nút mic** đặt ở hàng "Bạn" (`tl-my-row`), cạnh nút Gợi ý, để dễ với bằng ngón cái. Nút có 4 trạng thái:

| Trạng thái | Hiển thị |
|---|---|
| Tắt (mặc định) | Nền kem, icon mic gạch chéo navy |
| Bật | Nền xanh aqua, icon mic trắng, vòng sóng nhẹ theo âm lượng giọng mình |
| Đang kết nối | Icon mic mờ kèm vòng xoay nhỏ, không bấm được |
| Lỗi (không có quyền, máy không hỗ trợ) | Icon mic với chấm đỏ; bấm vào thì hiện lý do |

**Nút loa** ở thanh trên cùng, cạnh nút Trò chuyện: tắt/bật toàn bộ âm thanh voice nhận về. Bàn không bật voice thì ẩn cả nút mic và nút loa.

**Ghế người chơi:** trạng thái voice của mỗi người lấy trực tiếp từ LiveKit, không qua server game. Cùng một trạng thái thì hiển thị giống nhau ở ghế người khác và ở hàng "Bạn".

| Trạng thái | Lấy từ LiveKit | Hiển thị ở ghế |
|---|---|---|
| Chưa vào voice (app cũ, chưa cấp quyền, mất kết nối voice) | Người đó không có trong phòng LiveKit | Không có chấm voice |
| Tắt mic | Có trong phòng nhưng không có kênh mic, hoặc kênh mic `muted` (sự kiện `TrackMuted`) | Chấm tròn nhỏ có icon mic gạch chéo ở góc dưới avatar |
| Mở mic, đang im lặng | Kênh mic không `muted` (sự kiện `TrackUnmuted`) | Chấm tròn nhỏ có icon mic, nền xanh aqua |
| Đang nói | Có trong `ActiveSpeakersChanged` / `isSpeaking`, độ trễ khoảng 0,2–0,5 giây | Giữ chấm mic xanh và thêm viền xanh aqua nhấp nháy quanh avatar, nhịp theo `audioLevel` |
| Mình đã tắt tiếng người này | Chỉ có trên máy mình | Chấm có icon loa gạch chéo thay cho chấm mic. Người đó có nói cũng không hiện viền sóng, để khỏi gây khó chịu |

- Viền "đang nói" phải khác viền vàng của lượt đánh (`TurnRing`). Nếu trùng lượt thì cả hai cùng hiện, viền xanh nằm ngoài.
- Tắt mic dùng `stopMicTrackOnMute`: micro được giải phóng nhưng kênh mic vẫn còn ở trạng thái `muted`, nên người khác vẫn thấy đúng là "tắt mic".
- **Bấm vào avatar** (hiện chưa có hành động nào) mở popover nhỏ cạnh ghế gồm tên người chơi và 1 nút "Tắt tiếng" hoặc "Bật tiếng" (chỉ trên máy bạn).

**Người xem:** thanh dưới (`tl-spectator-bar`) chỉ có nút loa, không có nút mic. Danh sách người xem không cần hiện trạng thái voice.

### 7.5 Xin quyền mic và thông báo

- **Lần đầu bấm mic:** hiện sheet ngắn "Cho phép micro để nói chuyện với cả bàn" và nút "Tiếp tục". Bấm Tiếp tục thì hộp xin quyền của trình duyệt hoặc điện thoại mới hiện ra, để người dùng không bị bất ngờ.
- **Toast ngắn theo style chat hiện có:**
  - "Đã bật mic" / "Đã tắt mic"
  - "Chưa có quyền micro, mở Cài đặt để cho phép"
  - "Bản app này chưa hỗ trợ mic, hãy cập nhật"
  - "Voice đang tạm gián đoạn, đang kết nối lại…"
- **Bị ngắt mic** vì đang có cuộc gọi khác: tự chuyển nút mic về Tắt và hiện toast.

### 7.6 Accessibility

- `aria-pressed` cho nút mic và nút loa.
- `aria-label` đọc trạng thái, ví dụ "Mic đang bật" hoặc "Tắt tiếng Minh Anh".
- Hiệu ứng "đang nói" có thêm chấm tĩnh khi bật `prefers-reduced-motion`.

## 8. Thứ tự làm và kiểm thử

1. **Backend:** cờ voice khi tạo bàn và `VOICE_TOKEN`, kèm test engine.
2. **SDK voice và store `useThirteen`:** vòng đời join/leave.
3. **UI:** modal Tạo bàn, phòng chờ, bàn chơi, popover tắt tiếng, xin quyền.
4. **App chủ:** sửa 2 dòng ở mục 6, phát hành bản mobile.
5. **Test:**
   - **Trên máy:** chạy `livekit-server --dev` với 3–4 trình duyệt; dùng thêm `game/scripts/thirteen-e2e-browser.mjs` để kiểm tra:
     - chủ bàn có/không VIP
     - người chơi nói, người xem chỉ nghe
     - tắt tiếng phía mình
     - bị kick hoặc rời bàn thì rời voice
     - qua nhiều ván liên tiếp không đứt voice
   - **Máy thật:** iPhone (kiểm tra âm lượng khi bật/tắt mic, tai nghe bluetooth, thu nhỏ game, đang có cuộc gọi) và Android (xin quyền runtime, WebView đời cũ).
6. **Phát hành:** bật công tắc tổng ở admin theo từng nền tảng; theo dõi chi phí LiveKit tuần đầu.

## 9. Điểm còn mở

- Công tắc tổng ở admin có làm trong đợt này không, hay chỉ tắt bằng cách bỏ biến môi trường `LIVEKIT_*` của service game.
- Gợi ý mua VIP trong modal Tạo bàn: cần một lệnh bridge mở cửa hàng VIP của app, hiện chưa có.
