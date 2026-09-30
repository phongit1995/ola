# Phòng nối từ: REST và socket

Hợp đồng API cho web và mobile. Luật chơi và vòng đời phiên xem ở [README.md](README.md).

Mọi endpoint đều cần `Authorization: Bearer <token>` và nằm dưới `/api/v1/rooms/word-chain`. Response theo envelope chung của server:

```json
{ "success": true, "status": 200, "data": { }, "traceId": "…", "timestamp": "…", "path": "…" }
```

Khi lỗi thì `success = false`, câu báo lỗi (tiếng Việt) nằm ở `error`, mã lỗi riêng (nếu có) nằm ở `code`.

## 1. Kiểu dữ liệu

### Message

```json
{
  "id": "0b7c…",
  "seq": 42,
  "sessionId": "5f1e…",
  "type": "move",
  "senderType": "user",
  "senderId": "a1b2…",
  "senderName": "alice",
  "senderAvatar": "https://…",
  "senderGender": "female",
  "senderVip": "gold",
  "senderVipEnd": "2026-12-31T00:00:00Z",
  "content": "Chân Trời",
  "word": "chân trời",
  "code": "ok",
  "reaction": "✅",
  "requiredSyllable": "chân",
  "createdAt": "2026-09-29T09:36:21.567Z"
}
```

| Field | Ý nghĩa |
|---|---|
| `seq` | Số thứ tự tăng dần theo đúng thứ tự server lưu. **Dùng field này để sắp tin**, không dùng `createdAt` |
| `senderType` | `user` (người chơi) hoặc `bot`. Dùng field này để chọn cách hiển thị tin |
| `type` | Loại tin cụ thể (bảng dưới) |
| `senderId` | Chỉ có ở tin `move`. Tin bot không có người gửi |
| `senderName`, `senderAvatar`, `senderGender`, `senderVip`, `senderVipEnd` | Chỉ có ở tin `move`. Không lưu trong Redis, server lấy từ user cache mỗi lần trả tin, giống phòng chat. User đổi tên hoặc avatar thì tin cũ cũng hiện thông tin mới |
| `content` | Nội dung hiển thị. Tin bot có `**…**` để in đậm và `\n` để xuống dòng |
| `word` | Tin `move`: từ đã chuẩn hoá. Tin bot: từ liên quan (từ thắng, từ mở ván) |
| `code`, `reaction` | Chỉ có ở tin `move`. Client hiển thị `reaction` như badge trên tin |
| `requiredSyllable` | Âm tiết mà từ này lẽ ra phải bắt đầu bằng, dùng để hiện gợi ý khi sai |

| `type` | `senderType` | Khi nào |
|---|---|---|
| `move` | `user` | Mỗi lần gửi từ, cả đúng lẫn sai |
| `session_started` | `bot` | Tin đầu tiên của phiên, đưa ra từ đầu tiên |
| `win` | `bot` | Có người thắng ván. Tin `move` thắng là tin ngay trước nó (`seq` nhỏ hơn 1) |
| `game_started` | `bot` | Ngay sau `win`, báo từ mở ván mới. Cũng dùng khi từ của bot 12 giờ không ai nối: server ghi đè tin bot đã đưa ra từ cũ, **giữ nguyên `id`**, đổi `word` sang từ mới và cho `seq` mới (xuống cuối danh sách) |
| `wrong_answer` | `bot` | Ngay sau một tin `move` sai (`seq` nhỏ hơn 1). Có `code` (lý do), `requiredSyllable`, `remainingGuesses` (số lượt còn lại của người vừa sai) và `word` (từ hiện tại). Client hiện dạng reply, trích tin sai ngay trước nó |

Server không gửi id, tên hay avatar của bot. Client tự hiển thị tin bot khi `senderType = bot`.

| `code` | `reaction` | Khi nào |
|---|---|---|
| `ok` | ✅ | Từ hợp lệ, +1 điểm |
| `win` | 🏆 | Từ hợp lệ và không còn từ nối tiếp, +1 điểm, bot mở ván mới |
| `invalid_format` | ⚠️ | Không đúng 2 âm tiết |
| `mismatch` | ❌ | Sai âm tiết đầu |
| `repeated` | ❌ | Từ đã dùng trong ván |
| `not_in_dict` | ❌ | Không có trong từ điển |

### State

```json
{
  "sessionId": "5f1e…",
  "revision": 17,
  "turn": 5,
  "guessLimit": 3,
  "word": "chân trời",
  "requiredSyllable": "trời",
  "historyCount": 5,
  "sessionStartedAt": "2026-09-29T08:00:00Z",
  "lastProgressAt": "2026-09-29T09:36:21Z",
  "wordOwnerId": "a1b2…"
}
```

- `revision` tăng mỗi lần state đổi.
- `wordExpiresAt` chỉ có khi từ hiện tại do bot đưa ra: `lastProgressAt + 12 giờ`, tới lúc đó chưa ai nối thì bot thay từ. Từ do người chơi nối không có field này vì không hết hạn.
- `wordOwnerId` là id người đã nối ra từ hiện tại, không có khi từ do bot đưa ra. Nếu bằng id của mình thì client khoá ô nhập ("chờ người khác nối tiếp"), vì server sẽ trả `403 WORD_CHAIN_WAIT_TURN`.

## 2. REST

### `GET /rooms/word-chain`

Lấy state phiên hiện tại và điểm của mình. Nếu chưa có phiên thì server tạo luôn. Nếu từ của bot đã quá 12 giờ chưa ai nối thì server thay từ trước khi trả.

```json
{ "state": { "…": "State" }, "points": 12, "remainingGuesses": 3, "hintPrice": 500 }
```

`hintPrice` là giá một lần gợi ý (KEN), client dùng để hiện trên bảng gợi ý.

### `GET /rooms/word-chain/messages?limit=50&before=<messageId>`

Tin nhắn của phiên hiện tại, **mới nhất trước**.

| Query | Mặc định | Ghi chú |
|---|---|---|
| `limit` | 50 | Tối đa 100 |
| `before` | trống | Truyền `nextBefore` của trang trước để lấy tin cũ hơn |

```json
{ "items": [ "Message…" ], "hasMore": true, "nextBefore": "0b7c…" }
```

Nếu `before` trỏ tới tin đã bị xoá (tin bot bị thay, hoặc tin cũ quá giới hạn 5000) thì trả `items: []`.

### `POST /rooms/word-chain/moves`

Gửi một từ. Rate limit 3 lần / 2 giây / người.

```json
{ "content": "chân trời" }
```

`content` bắt buộc, dài 1–200 ký tự.

Response:

```json
{
  "message": { "…": "Message của người gửi" },
  "botMessages": [ "Message…" ],
  "state": { "…": "State" },
  "points": 13,
  "remainingGuesses": 3
}
```

- Từ sai vẫn trả **200** kèm `code` và `reaction` tương ứng. Tin sai vẫn được lưu và broadcast cho mọi người.
- Khi thắng, `botMessages` có 2 tin: `win` rồi `game_started`. Khi sai có 1 tin `wrong_answer`. Nối đúng mà chưa thắng thì là mảng rỗng.
- `remainingGuesses`: số lượt đoán còn lại của người gửi cho từ hiện tại (sau lượt này).
- `points` là tổng điểm hiện tại của người gửi.

Lỗi:

| HTTP | `code` | Khi nào | Client nên làm |
|---|---|---|---|
| 400 | | `content` sai định dạng body | Báo lỗi nhập |
| 409 | | Server đang bận: chờ lock quá 10 giây, hoặc có người nối trước liên tục 3 lần | Toast "Phòng nối từ đang xử lý, vui lòng thử lại." |
| 429 | | Vượt rate limit | Toast, cho gửi lại sau |
| 403 | `WORD_CHAIN_NO_GUESSES` | Người gửi đã sai đủ 3 lần với từ hiện tại | Toast, khoá ô nhập tới khi `turn` đổi. Server không lưu gì |
| 403 | `WORD_CHAIN_WAIT_TURN` | Từ hiện tại do chính người gửi nối ra (`wordOwnerId`) | Toast, khoá ô nhập tới khi có người khác nối. Không trừ lượt, server không lưu gì |
| 503 | `WORD_CHAIN_VERIFY_FAILED` | Không gọi được API từ điển | Toast, giữ nội dung trong ô nhập để gửi lại. Server không lưu gì |

### `POST /rooms/word-chain/hints`

Mua gợi ý cho từ hiện tại. Không có body. Server chỉ trừ KEN khi tìm được ít nhất 1 từ.

```json
{
  "sessionId": "5f1e…",
  "turn": 5,
  "word": "quãng đường",
  "hints": ["đường phố", "đường xá", "đường đi"],
  "price": 500,
  "kenBalance": 12000
}
```

- `hints`: tối đa 5 từ, đều bắt đầu bằng âm tiết cuối của `word`, chưa dùng trong ván, có trong từ điển.
- `kenBalance`: số dư sau khi trừ, client ghi vào `user.ken`. Server cũng bắn `KEN_UPDATED` `{ "ken": kenBalance }` tới mọi socket của user.
- Gợi ý chỉ đúng với `sessionId` + `turn` này. Khi state đổi `turn` thì client coi gợi ý là cũ.

Lỗi:

| HTTP | `code` | Khi nào |
|---|---|---|
| 400 | `WORD_CHAIN_INSUFFICIENT_KEN` | Không đủ KEN |
| 403 | `WORD_CHAIN_WAIT_TURN` | Từ hiện tại do chính người gửi nối ra |
| 403 | `WORD_CHAIN_NO_GUESSES` | Người gửi đã hết lượt đoán với từ hiện tại |
| 409 | `WORD_CHAIN_NO_HINT` | Không tìm được gợi ý. Không trừ KEN |
| 429 | | Vượt rate limit |
| 503 | `WORD_CHAIN_VERIFY_FAILED` | API từ điển lỗi: `suggest` lỗi, hoặc `lookup` lỗi ở bất kỳ từ nào đang xét. Không trừ KEN |

### `GET /rooms/word-chain/leaderboard`

Top 10 theo điểm.

```json
{
  "items": [
    { "rank": 1, "userId": "…", "username": "alice", "fullName": "…", "avatar": "…", "points": 120 }
  ],
  "total": 37,
  "me": { "rank": 12, "userId": "…", "username": "bob", "points": 8 }
}
```

- `total` là tổng số người đã có điểm.
- `me` là `null` nếu mình chưa có điểm nào.

### `GET /rooms/word-chain/lookup?word=<từ>`

Tra nghĩa của từ qua dict.minhqnd.com. Mỗi người chỉ được tra 1 lần mỗi 5 giây.

```json
{
  "word": "chân trời",
  "found": true,
  "results": [
    {
      "langCode": "vi",
      "langName": "Tiếng Việt",
      "meanings": [ { "definition": "…", "pos": "danh từ", "subPos": "", "example": "…" } ],
      "translations": [ { "translation": "horizon", "langName": "English" } ],
      "relations": [ { "word": "…", "type": "đồng nghĩa" } ]
    }
  ],
  "source": "dict.minhqnd.com"
}
```

- Khi không tìm thấy: `found = false`, `results = []`, và `message` là câu thông báo để hiển thị.
- Lỗi:
  - `400`: từ trống hoặc dài quá 80 ký tự;
  - `429 WORD_CHAIN_COOLDOWN`: câu `error` dạng "⏳ Vui lòng chờ 3s trước khi tra tiếp.";
  - `502`: API tra từ lỗi.

## 3. Socket

Dùng lại kết nối Socket.IO sẵn có (auth bằng token như chat).

### Client → server

| Event | Payload | Ack |
|---|---|---|
| `WORD_CHAIN:JOIN` | không có | `{ "ok": true, "data": { "joined": true } }` |
| `WORD_CHAIN:LEAVE` | không có | `{ "ok": true, "data": { "joined": false } }` |

Gửi `WORD_CHAIN:JOIN` khi mở màn nối từ và **gửi lại sau mỗi lần socket reconnect**, vì server không nhớ kênh qua các lần kết nối. Gửi `WORD_CHAIN:LEAVE` khi đóng màn.

### Server → client

Event đi qua envelope chung `message`, giống chat:

```ts
socket.on('message', ({ type, data }) => { … })
```

| `type` | `data` |
|---|---|
| `WORD_CHAIN_NEW_MESSAGE` | `{ "message": Message }` |
| `WORD_CHAIN_STATE_UPDATED` | `{ "state": State }` |

- Người gửi cũng nhận lại event cho chính tin của mình.
- Khi thắng ván, client nhận lần lượt 3 tin (`move`, `win`, `game_started`) rồi 1 state.
- Khi sai, client nhận 2 tin (`move`, `wrong_answer`) rồi 1 state (revision tăng vì số lượt sai thay đổi, từ hiện tại giữ nguyên).
- Khi từ của bot hết hạn, client nhận 1 state (`turn` tăng, từ mới) và 1 tin `game_started` trùng `id` với tin bot cũ. Gộp theo `id` là tin cũ tự được thay.
- Chỉ khi chưa có state nào server mới tạo phiên, client nhận state có `sessionId` mới và tin `session_started`.

## 4. Quy tắc phía client

Event có thể tới **đảo thứ tự**, và có thể trùng với dữ liệu vừa nhận từ REST. Client cần:

1. **Tin nhắn**
   - Gộp tin theo `id`: tin tới sau thay tin cùng `id` đang có (kể cả khi `seq` đổi).
   - Chèn và sắp danh sách theo `seq`.
   - Bỏ tin có `sessionId` khác phiên đang hiển thị.
2. **State**
   - Chỉ nhận state có `revision` **lớn hơn** revision đang giữ. Áp dụng cho cả state từ event, từ response của `/moves` và từ `GET /rooms/word-chain`.
3. **Đổi phiên**: khi nhận state hợp lệ có `sessionId` khác phiên đang hiển thị thì xoá danh sách tin và gọi lại `GET /messages`.

Luồng khi mở màn. **JOIN trước, tải dữ liệu sau**, để không lỡ event phát ra giữa hai bước:

```text
1. emit WORD_CHAIN:JOIN, chờ ack có ok = true
   → từ đây event bắt đầu tới. Giữ chúng vào hàng đợi, chưa hiển thị
2. GET /rooms/word-chain          → state + điểm
3. GET /rooms/word-chain/messages → trang tin đầu tiên
4. Gộp event trong hàng đợi vào dữ liệu vừa tải theo quy tắc ở trên
   (bỏ tin trùng theo id, sắp theo seq, chỉ nhận state có revision lớn hơn), rồi hiển thị
```

Nếu tải trước rồi mới JOIN, tin và state phát ra trong khoảng giữa hai bước sẽ bị mất.

Sau mỗi lần socket reconnect, làm lại đúng 4 bước trên để bù phần bị lỡ.

Luồng gửi từ:

```text
POST /moves → hiện ngay message trong response (dedupe theo id khi event tới sau)
            → cập nhật state và điểm nếu revision mới hơn
```

Hiển thị gợi ý:

- Header: "Từ hiện tại: **{state.word}**".
- Ô nhập: placeholder `Nhập từ bắt đầu bằng "{state.requiredSyllable}"…`.
