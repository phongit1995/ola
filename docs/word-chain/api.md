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
| `code` | Tin `move` (kết quả chấm) và tin `wrong_answer` (lý do sai). Client chọn icon trạng thái theo `code` |
| `reaction` | Chỉ có ở tin `move`, là emoji tương ứng với `code` (bảng dưới). Web hiện icon riêng theo `code`, không dùng emoji này |
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

`hintPrice` là giá một lần gợi ý (KEN) theo cấu hình admin (mặc định 500), client dùng để hiện trên bảng gợi ý.

Admin tắt phòng thì trả `403 WORD_CHAIN_DISABLED`. Server không đọc được cấu hình thì trả `503 WORD_CHAIN_UNAVAILABLE`.

### `GET /rooms/word-chain/messages?limit=50&before=<messageId>`

Tin nhắn của phiên hiện tại, **mới nhất trước**.

| Query | Mặc định | Ghi chú |
|---|---|---|
| `limit` | 50 | Tối đa 100 |
| `before` | trống | Truyền `nextBefore` của trang trước để lấy tin cũ hơn |

```json
{ "items": [ "Message…" ], "hasMore": true, "nextBefore": "0b7c…" }
```

- Nếu `before` trỏ tới tin đã bị xoá (tin cũ quá giới hạn 5000) thì trả `items: []`.
- Tin bot bị thay từ sau 12 giờ **không bị xoá**: nó giữ `id` và nhận `seq` mới (xuống cuối). Nếu `before` trỏ tới đúng tin đó thì trang trả về tính từ vị trí mới, nên có thể lặp lại tin client đã có. Client gộp theo `id` nên không bị trùng khi hiển thị. Client nên lấy cursor là tin cũ nhất **của phiên hiện tại** đang có.
- Trang có tin của phiên cũ nghĩa là đã tới đầu phiên hiện tại; client coi như hết tin để tải thêm.
- Admin tắt phòng thì trả `403 WORD_CHAIN_DISABLED`, không đọc được cấu hình thì `503 WORD_CHAIN_UNAVAILABLE`.

### `POST /rooms/word-chain/moves`

Gửi một từ. Rate limit 3 lần / 2 giây / người. Bucket này (`rl:room_message:<userId>`) **dùng chung** với `POST /hints` và gửi tin ở phòng chat thường.

```json
{ "content": "chân trời", "sessionId": "5f1e…", "turn": 5 }
```

- `content` bắt buộc, dài 1–200 ký tự.
- `sessionId`, `turn` (không bắt buộc): `state.sessionId` và `state.turn` của từ người chơi đang nhìn thấy. Có thì server so với từ hiện tại; từ đã đổi thì trả `409 WORD_CHAIN_WORD_CHANGED` thay vì chấm sai theo từ mới. `turn` phải ≥ 0.

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
| 409 | `WORD_CHAIN_WORD_CHANGED` | Từ hiện tại đã đổi so với `sessionId`/`turn` client gửi (có người nối trước, thắng ván, bot thay từ) | Toast, giữ nội dung trong ô nhập, tải lại state. **Không trừ lượt**, server không lưu gì |
| 409 | | Server đang bận: chờ lock quá 10 giây, hoặc state đổi liên tục 3 lần mà từ vẫn vậy | Toast "Phòng nối từ đang xử lý, vui lòng thử lại." |
| 429 | | Vượt rate limit | Toast, cho gửi lại sau |
| 403 | `WORD_CHAIN_NO_GUESSES` | Người gửi đã sai đủ 3 lần với từ hiện tại | Toast, khoá ô nhập tới khi `turn` đổi. Server không lưu gì |
| 403 | `WORD_CHAIN_WAIT_TURN` | Từ hiện tại do chính người gửi nối ra (`wordOwnerId`) | Toast, khoá ô nhập tới khi có người khác nối. Không trừ lượt, server không lưu gì |
| 403 | `WORD_CHAIN_DISABLED` | Admin đã tắt phòng nối từ | Toast "Phòng nối từ đang tạm đóng", đóng phòng, ẩn mục khỏi danh sách phòng |
| 503 | `WORD_CHAIN_VERIFY_FAILED` | Không gọi được API từ điển | Toast, giữ nội dung trong ô nhập để gửi lại. Server không lưu gì |
| 503 | `WORD_CHAIN_UNAVAILABLE` | Server không đọc được cấu hình phòng | Toast, thử lại sau |

### `POST /rooms/word-chain/hints`

Mua gợi ý cho từ hiện tại. Không có body. Server chỉ trừ KEN khi tìm được ít nhất 1 từ, và mỗi người chỉ trả tiền 1 lần cho mỗi lượt (`sessionId` + `turn`).

```json
{
  "sessionId": "5f1e…",
  "turn": 5,
  "word": "quãng đường",
  "hints": ["đường phố", "đường xá", "đường đi"],
  "price": 500,
  "kenBalance": 12000,
  "charged": true
}
```

- `hints`: tối đa 5 từ, đều bắt đầu bằng âm tiết cuối của `word`, chưa dùng trong ván, có trong từ điển.
- `charged`: `true` nếu lần gọi này vừa trừ KEN. `false` nếu người này đã mua gợi ý cho lượt này rồi (ghi nhận trong Postgres cùng transaction trừ tiền, không hết hạn): server trả lại đúng danh sách cũ, không gọi API từ điển và không trừ tiền.
- `price`: giá đã trả cho gợi ý này (với `charged = false` là giá của lần mua trước). Khi `charged = true` client cập nhật giá hiển thị theo số này.
- `kenBalance`: số dư hiện tại (sau khi trừ nếu có), client ghi vào `user.ken`. Khi trừ tiền, server cũng bắn `KEN_UPDATED` `{ "ken": kenBalance }` tới mọi socket của user.
- Gợi ý chỉ đúng với `sessionId` + `turn` này. Khi state đổi `turn` thì client coi gợi ý là cũ.

Lỗi:

| HTTP | `code` | Khi nào |
|---|---|---|
| 400 | `WORD_CHAIN_INSUFFICIENT_KEN` | Không đủ KEN. Câu `error` ghi giá hiện tại |
| 403 | `WORD_CHAIN_DISABLED` | Admin đã tắt phòng nối từ. Không trừ KEN |
| 403 | `WORD_CHAIN_WAIT_TURN` | Từ hiện tại do chính người gửi nối ra |
| 403 | `WORD_CHAIN_NO_GUESSES` | Người gửi đã hết lượt đoán với từ hiện tại |
| 409 | `WORD_CHAIN_NO_HINT` | Không tìm được gợi ý. Không trừ KEN |
| 409 | `WORD_CHAIN_WORD_CHANGED` | Từ hiện tại đổi trong lúc server tìm gợi ý. Không trừ KEN |
| 409 | | Server đang bận (chờ lock quá 10 giây). Phân biệt với 2 dòng trên bằng `code` |
| 429 | | Vượt rate limit (bucket chung với `POST /moves`) |
| 503 | `WORD_CHAIN_VERIFY_FAILED` | API từ điển lỗi: `suggest` lỗi, hoặc `lookup` lỗi khi chưa đủ 5 từ hợp lệ. Không trừ KEN |
| 503 | `WORD_CHAIN_UNAVAILABLE` | Server không đọc được cấu hình phòng. Không trừ KEN |

### `GET /rooms/word-chain/leaderboard?sort=points&period=all`

Top 10 theo điểm hoặc theo số trận thắng, trong một kỳ.

| Tham số | Giá trị | Mặc định |
|---|---|---|
| `sort` | `points`, `wins` | `points` |
| `period` | `day` (hôm nay), `week` (tuần này, từ thứ Hai), `month` (tháng này), `all` (từ trước tới nay) | `all` |

Giá trị lạ được coi là mặc định. Mốc ngày/tuần/tháng tính theo giờ Việt Nam (GMT+7).

```json
{
  "items": [
    { "rank": 1, "userId": "…", "username": "alice", "fullName": "…", "avatar": "…", "points": 120, "wins": 7 }
  ],
  "total": 37,
  "me": { "rank": 12, "userId": "…", "username": "bob", "points": 8, "wins": 0 },
  "sort": "points",
  "period": "all"
}
```

- Mỗi dòng có cả `points` lẫn `wins` trong kỳ đó, sắp theo `sort`. Bằng nhau thì xét tiếp chỉ số còn lại.
- `total` là số người có `sort` > 0 trong kỳ (tab Thắng chỉ đếm người đã thắng ít nhất 1 trận).
- `me` là `null` nếu mình chưa có điểm (hoặc chưa thắng, với `sort=wins`) trong kỳ.
- Mọi kỳ, kể cả `all`, đọc từ bảng `word_chain_scores`, nên `points` ở đây khớp với `points` trong `GET /rooms/word-chain`.

### `GET /rooms/word-chain/wins?limit=20&before=<id>&mine=true`

Lịch sử các trận thắng, mới nhất trước (sắp theo `createdAt` rồi `id`). `limit` mặc định 20, tối đa 50. `mine=true` chỉ lấy trận thắng của mình.

```json
{
  "items": [
    {
      "id": "…",
      "userId": "…",
      "username": "alice",
      "fullName": "…",
      "avatar": "…",
      "word": "phùn phụt",
      "previousWord": "mưa phùn",
      "createdAt": "2026-09-30T15:20:27.826173Z"
    }
  ],
  "hasMore": true,
  "nextBefore": "…"
}
```

- `id` là id tin nối từ thắng.
- `word` là từ cuối người đó nối được, `previousWord` là từ được nối vào.
- Phân trang bằng cursor: tải thêm thì gửi `before` = `nextBefore` của trang trước. Có trận thắng mới xen vào giữa hai lần tải cũng không làm trùng hay sót dòng. `nextBefore` chỉ có khi `hasMore = true`.
- `before` không phải UUID thì trả `400 WORD_CHAIN_INVALID_CURSOR`. `before` là UUID nhưng không tồn tại thì trả danh sách rỗng.

### `GET /rooms/word-chain/lookup?word=<từ>`

Tra nghĩa của từ qua dict.minhqnd.com. Server chuẩn hoá từ (giống lúc chấm) rồi mới gọi API, nên tra "Hoà Bình" hay "hòa  bình" đều ra cùng kết quả với "hòa bình". Khi không tìm thấy, `word` trong response là từ người dùng gõ. Kết quả được cache 24 giờ trong Redis. Từ đã có trong cache (mọi từ đã được chấm khi nối, hoặc đã có người tra) trả ngay và **không tính cooldown**. Chỉ khi phải gọi API ngoài thì mỗi người mới bị giới hạn 1 lần mỗi 5 giây (`429 WORD_CHAIN_COOLDOWN`).

Client dùng endpoint này cho cả hộp **Tra từ** lẫn nút ⓘ nhỏ nằm ngoài bubble, cạnh từ đã nối đúng (`ok`/`win`; tin người khác thì ở bên phải, tin của mình ở bên trái): bấm ⓘ mở hộp nghĩa của từ đó (tiêu đề là từ, không có ô tìm kiếm) và tra luôn. `source` là tên hiển thị dưới kết quả ("Nguồn: Ola Me"), dữ liệu vẫn lấy từ dict.minhqnd.com.

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
  "source": "Ola Me"
}
```

- Khi không tìm thấy: `found = false`, `results = []`, và `message` là câu thông báo để hiển thị.
- Lỗi:
  - `400`: từ trống hoặc dài quá 80 ký tự;
  - `429 WORD_CHAIN_COOLDOWN`: câu `error` dạng "⏳ Vui lòng chờ 3s trước khi tra tiếp.";
  - `502`: API tra từ lỗi.

### `GET /settings/word-chain`

Nằm ngoài `/rooms/word-chain`, cần đăng nhập. Client đọc để biết có hiện mục **Phòng nối từ** trong danh sách phòng hay không.

```json
{ "enabled": true, "hintPrice": 500 }
```

Chưa cấu hình thì trả mặc định như trên. Client ẩn mục cho tới khi đọc xong cấu hình; gọi lỗi thì client coi như đang bật (server vẫn tự chặn nếu phòng tắt).

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
POST /moves (kèm sessionId + turn đang hiển thị)
            → hiện ngay message trong response (dedupe theo id khi event tới sau)
            → cập nhật state nếu revision mới hơn; số lượt còn lại chỉ ghi đè bản có revision cũ hơn
            → lỗi WORD_CHAIN_WORD_CHANGED: giữ nội dung ô nhập, gọi lại GET /rooms/word-chain
```

Hiển thị gợi ý:

- Header: "Từ hiện tại: **{state.word}**".
- Ô nhập: placeholder `Nối tiếp "{state.requiredSyllable}"…`. Bên trái ô nhập là nút **Tra từ**, bên phải là nút **Gợi ý** và **Gửi**; header chỉ còn **Bảng xếp hạng** và **Luật chơi**.
