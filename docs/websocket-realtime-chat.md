# WebSocket realtime cho Chat — Sự kiện & khả năng triển khai 1-1

> Mục tiêu: liệt kê **đầy đủ event socket** của ola, đối chiếu với project tham chiếu `D:\TEST\chat-service`, và trả lời: **ola có triển khai WebSocket cho chat 1-1 giống reference được không?**
>
> Nguồn đã đọc & kiểm chứng:
> - Backend ola: `server/internal/transport/websocket/{server,event_handler}.go`, `server/internal/utils/message.emit.go`, `server/internal/domain/{message,conversation,call}/*.handler.go`, `server/internal/constants/constant.go`.
> - Backend reference: `chat-service/internal/transport/websocket/*`, `internal/domain/*/handler.go` (cấu trúc gần như **giống hệt** — ola được dựng theo reference).
> - Client reference: `chat-service/clients/packages/shared/src/{services/socket.ts, store/chat.realtime.ts, store/chatStore.ts}`.
> - Client ola: `web/src/shared/services/socket.service.ts`, `web/src/store/roomChatStore.ts`.

---

## 0. Kết luận (TL;DR)

✅ **Có — triển khai giống reference được, gần như không có rào cản.** Lý do:

1. Backend ola **đã phát mọi event qua đúng 1 envelope** `socket.on('message', {type, data})` — **giống hệt** cách `roomChatStore` của ola đang nghe và giống hệt reference.
2. Backend ola **đã có đủ event 1-1**: `NEW_MESSAGE`, `MESSAGE_UPDATED/DELETED`, `MESSAGE_REACTION_UPDATED`, `CONVERSATION_CREATED/UPDATED/DELETED`, `USER_TYPING/USER_STOP_TYPING` (verify ở `domain/message` & `domain/conversation`).
3. ola web **đã có nửa hạ tầng**: `SocketService` (connect theo token) + mẫu nghe envelope (`roomChatStore`). Thiếu **lớp 1-1**: `conversation.service` + `message.service` + `chatStore`.

→ Việc còn lại **chỉ là code phía client**, không cần đụng backend. Khác biệt duy nhất so với reference: reference gom dispatch trong `socket.ts` (pub/sub nội bộ); ola dispatch ngay trong store (`socket.on('message')` + `switch`). Cả hai đều hợp lệ.

---

## 1. Hợp đồng truyền tải (transport contract) — điểm cốt lõi

Backend dùng **Socket.IO v3** (`zishang520/socket.io`) + **Redis adapter** (scale ngang). Có **2 loại kênh**:

### (A) Kênh envelope `message` — chở gần như tất cả
Server bọc payload bằng `utils.WrapWebSocketMessage(eventType, data)` rồi emit trên **một** event Socket.IO tên `"message"`:

```go
// server/internal/utils/message.emit.go
type WebSocketMessage struct {
    Type string      `json:"type"`
    Data interface{} `json:"data"`
}
// → emit: io.To("user:<id>").Emit("message", { "type": "<EVENT>", "data": {...} })
```

Client chỉ cần nghe **một** chỗ và phân nhánh theo `type`:

```ts
socket.on('message', (envelope) => {        // envelope = { type, data }
  switch (envelope.type) {
    case 'NEW_MESSAGE': ...
    case 'USER_TYPING': ...
  }
})
```

> Đây **chính xác** là pattern `roomChatStore` đang dùng (`ROOM_SOCKET_EVENTS.message = 'message'` → `switch(envelope.type)`) và pattern reference dùng (`WebSocketTransportEvent.MESSAGE = 'message'`).

### (B) Sự kiện thô (raw) — không bọc envelope
Một số ít event emit trực tiếp theo tên (nghe bằng `socket.on('<TÊN>')`):

| Event | Hướng | Ý nghĩa |
|---|---|---|
| `SESSION_REPLACED` | server→client | Bị đăng nhập nơi khác (ép 1 user 1 kết nối — last wins). Sau đó server `DisconnectSockets`. |
| `ping` | client→server | Heartbeat, refresh TTL presence (+ refresh room nếu có). |
| `ROOM:JOIN` / `ROOM:LEAVE` | client→server (có ack) | Vào/rời phòng chat (dùng ticket). **Chat 1-1 KHÔNG cần** (xem §3). |

---

## 2. Xác thực & định tuyến

- **Auth**: `io.Use(...)` đọc token từ `handshake.auth.token` (hoặc query `?token=`) → `JWTService.GetUserIDFromToken` → gắn `SocketData{UserID}`. Thiếu/sai token → từ chối kết nối. (`server.go:75-113`)
- **Định tuyến theo user**: khi connect, socket `Join("user:<userID>")`. Mọi event 1-1 bắn bằng `EmitToUser/EmitToUsers` → `io.To("user:<id>").Emit(...)`. **Client KHÔNG cần join hội thoại** — server tự route theo phòng `user:{id}` (giống reference, ở đó `joinConversation` là no-op).
- **Ép 1 kết nối/user (last-wins)**: lúc connect, server emit `SESSION_REPLACED` cho các socket cũ cùng user rồi ngắt chúng (`event_handler.go:42-46`). → Frontend **phải** nghe `SESSION_REPLACED` và **không reconnect** (đã ghi nhớ trong memory dự án).
- **Scale ngang**: Redis adapter đồng bộ room giữa nhiều instance API/chat (`server.go:58-61`). API service publish Kafka → Chat service consume → broadcast WS.

---

## 3. Danh mục đầy đủ event socket (ola)

### 3.1 Server → Client, qua envelope `message` (`{type, data}`)

| `type` | Khi nào | `data` (rút gọn) | Nơi phát (backend) |
|---|---|---|---|
| `NEW_MESSAGE` | có tin mới trong hội thoại | `{ conversation, message }` | `domain/message/message.handler.go:112` |
| `MESSAGE_UPDATED` | sửa tin | `{ conversation, message }` | `message.handler.go:301` |
| `MESSAGE_DELETED` | xoá tin | `{ conversation, messageId }` | `message.handler.go:205` |
| `MESSAGE_REACTION_UPDATED` | thả/gỡ reaction | `{ conversationId, messageId, reactions, actorUserId, type, action }` | `message.handler.go:356` |
| `CONVERSATION_CREATED` | tạo hội thoại | `Conversation` | `domain/conversation/conversation.handler.go:85` |
| `CONVERSATION_UPDATED` | đổi hội thoại (vd `seen`) | `Conversation` (đôi khi chỉ `{id, seen}`) | `conversation.handler.go:148` |
| `CONVERSATION_DELETED` | xoá/ẩn hội thoại | `{ conversationId }` | `conversation.handler.go` |
| `USER_TYPING` | ai đó đang gõ | `{ conversationId, userId, username, time }` | `conversation.handler.go:281` |
| `USER_STOP_TYPING` | ngừng gõ | như trên | `conversation` |
| `INCOMING_CALL` / `CALL_ACCEPTED` / `CALL_DECLINED` / `CALL_ENDED` | cuộc gọi | `{ callId, conversationId, ... }` | `domain/call/handler.go` (reference có; ola có hằng nhưng chưa dùng ở web) |
| `NEW_ROOM_MESSAGE` | tin trong **phòng** | `{ room, message }` | `EmitToRoom` (room) |
| `ROOM_MESSAGE_DELETED` | xoá tin phòng | `{ roomId, messageId }` | room |
| `ROOM_MEMBER_JOINED` / `ROOM_MEMBER_LEFT` | thành viên phòng | `{ roomId, userId, memberCount }` | `event_handler.go:132/168` |

### 3.2 Server → Client, raw
| Event | `data` | Xử lý phía client |
|---|---|---|
| `SESSION_REPLACED` | `{ reason: 'logged_in_elsewhere' }` | Hiện thông báo + **dừng reconnect** + về màn đăng nhập. |

### 3.3 Client → Server
| Event | Payload | Ack | Dùng cho |
|---|---|---|---|
| `ping` | — | không | Heartbeat giữ presence (reference gửi mỗi 60s). |
| `ROOM:JOIN` | `{ roomId, ticket }` | có (`{ok, data:{memberCount}}`) | Vào phòng chat. **Không dùng cho 1-1.** |
| `ROOM:LEAVE` | `{ roomId }` | có | Rời phòng. **Không dùng cho 1-1.** |

> ⚠️ Gửi tin 1-1 / typing / đánh dấu đã đọc **KHÔNG đi qua socket** mà qua **REST** (xem §4). Socket chỉ để **nhận** (trừ ping & room join/leave).

---

## 4. Gửi/nhận 1-1 đi đường nào? (REST vào — WS ra)

| Hành động | Kênh | Endpoint / Event |
|---|---|---|
| Gửi tin | **REST** | `POST /messages` `{conversationId,type,content,clientMsgId}` hoặc `POST /messages/direct` `{recipientId,...}` |
| Gửi ảnh / voice | **REST** | `POST /messages/images` · `POST /messages/audio` (multipart) |
| Lấy tin (phân trang) | **REST** | `GET /messages/:conversationId?limit&before` |
| Sửa / xoá / reaction | **REST** | `PATCH` · `DELETE` · `POST /:id/reactions` |
| Báo đang gõ | **REST** | `POST /conversations/typing` `{conversationId}` |
| Đánh dấu đã đọc | **REST** | `PUT /conversations/:id/read` |
| **Nhận lại realtime** | **WS** | server bắn `NEW_MESSAGE` / `USER_TYPING` / … qua envelope `message` |

Cơ chế **optimistic + chống nhân đôi** (giống reference): client tạo `clientMsgId` (UUID) → chèn tin tạm (status `sending`) → REST trả về → thay tin tạm; **đồng thời** server bắn `NEW_MESSAGE` về chính mình → client **dedup theo `id`/`clientMsgId`** nên không bị đúp.

---

## 5. ola đang ở đâu so với reference?

| Hạng mục | Backend ola | Reference | Web ola |
|---|---|---|---|
| Envelope `message` `{type,data}` | ✅ | ✅ | ✅ (`roomChatStore`) |
| Auth token handshake | ✅ | ✅ | ✅ (`SocketService`) |
| Route theo `user:{id}` | ✅ | ✅ | n/a (server lo) |
| Event 1-1 đầy đủ | ✅ | ✅ | — |
| Lớp client phòng chat | ✅ | ✅ | ✅ `roomChatStore` |
| **Lớp client 1-1** (service + store + listener) | n/a | ✅ `chatStore`+`chat.realtime` | ❌ **chưa có** |
| Optimistic `clientMsgId` | n/a | ✅ | ❌ (room chưa cần) |
| `ping` keepalive | nhận | gửi 60s | ❌ chưa gửi |
| `SESSION_REPLACED` handling | phát | — | ❓ cần kiểm tra/bổ sung |

→ Backend **sẵn sàng 100%**. Web **đúng kiến trúc**, chỉ thiếu lớp 1-1.

---

## 6. Kế hoạch triển khai 1-1 cho web ola (khả thi, không đụng backend)

Theo đúng khuôn `roomChatStore` + học cách tổ chức của reference:

1. **API path & service**
   - Thêm `API_PATH.conversations` + `API_PATH.messages` ([web/src/shared/config/api.ts](../web/src/shared/config/api.ts)).
   - `conversation.service.ts`: `list / get / createDirect / checkDirect / markRead / hide / mute / typing`.
   - `message.service.ts`: `getMessages(convId, limit, before) / send / sendDirect / sendImage / sendAudio / update / delete / toggleReaction`.

2. **Store `chatStore.ts`** (zustand, đặt cạnh `roomChatStore`)
   - State: `conversations / currentConversation / messages / typingUsers`.
   - `open(convId)`: `SocketService.connect()` → đăng ký listener (nếu chưa) → load messages + detail.
   - **Listener** trên `socket.on('message', envelope => switch(envelope.type))`:
     `NEW_MESSAGE` (push/replace theo `clientMsgId`, cập nhật list + unread), `MESSAGE_UPDATED/DELETED`, `MESSAGE_REACTION_UPDATED`, `USER_TYPING`/`USER_STOP_TYPING` (auto-clear ~3s), `CONVERSATION_*`.
   - **Gửi** optimistic: `clientMsgId` → REST → dedup echo.
   - **Typing**: gọi `POST /conversations/typing` có throttle ~1.5–3s.
   - **Đã đọc**: `PUT /conversations/:id/read` khi mở/nhận tin (read ở **mức hội thoại**, không phải từng tin).

3. **Nối UI**: thay phần mock trong [ChatConversationView](../web/src/pages/chat/components/ChatConversationView.tsx) bằng dữ liệu store; viết mapper `MessageResponse → ChatMessage`.

4. **Vòng đời & độ bền** (nên có, học reference):
   - Chuyển `SocketService.connect/disconnect` về **theo phiên đăng nhập** (login/loadUser/logout) thay vì `HomePage` mount/unmount.
   - Nghe **`SESSION_REPLACED`** → toast + dừng reconnect + đăng xuất.
   - (Tuỳ chọn) gửi `ping` định kỳ; thêm `transports:['websocket','polling']` để có fallback.

### Lưu ý mapping loại tin
Backend chỉ hỗ trợ `text / image / file / video / audio`. Các kind mock của web (`sticker / location / snap / youtube / ken / vip / stranger`) **không có** type backend → giữ là **UI mock**, hoặc encode trong `metadata` của tin `text`/`file` nếu muốn lưu thật.

---

## 7. Bảng tham chiếu nhanh (cheat-sheet)

```
KẾT NỐI:   io(socketUrl, { auth: { token }, transports: ['websocket'] })
NGHE:      socket.on('message', ({type, data}) => switch(type){ ... })
           socket.on('SESSION_REPLACED', () => logout())   // raw
GỬI 1-1:   REST POST /messages (kèm clientMsgId)           // KHÔNG qua socket
TYPING:    REST POST /conversations/typing                 // KHÔNG qua socket
ĐÃ ĐỌC:    REST PUT  /conversations/:id/read               // mức hội thoại
ROUTE:     server tự đẩy theo room user:{id} — client không join hội thoại
```
