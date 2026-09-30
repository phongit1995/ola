# Phòng nối từ

Tài liệu tính năng phòng nối từ (word chain) của Ola: luật chơi, vòng đời phiên và cách dữ liệu được lưu. Hợp đồng REST và socket cho client xem ở [api.md](api.md).

Code backend: `server/internal/modules/room/wordchain/`. Luật chơi lấy từ nhánh PvP của [minhqnd/Noi-Tu-Discord](https://github.com/minhqnd/Noi-Tu-Discord) (MIT). Chỉ lấy luật, không lấy cơ chế riêng của Discord.

## 1. Tổng quan

- Toàn hệ thống chỉ có **1 phòng nối từ**. Phòng không gắn với bảng `rooms`, không có `roomId`, không có danh sách phòng, không đếm số người.
- Người chơi nối từ với nhau (PvP). **Bot chỉ làm trọng tài**: chấm từng từ, báo thắng, mở ván mới. Bot không tự nối từ.
- User đã đăng nhập là chơi được, không cần join phòng qua ticket. Join socket chỉ để nhận realtime.
- Mọi dữ liệu nằm ở **Redis**. Không có bảng, không có migration.
- Chỉ có 2 tính năng phụ: **Tra từ** và **Bảng xếp hạng**.

## 2. Luật chơi

Một từ hợp lệ khi thỏa lần lượt các điều kiện dưới đây. Server dừng ở điều kiện đầu tiên bị sai và trả `code` tương ứng.

| Thứ tự | Điều kiện | `code` khi sai | Reaction |
|---|---|---|---|
| 1 | Đúng **2 âm tiết**, cách nhau bởi **1 dấu cách** | `invalid_format` | ⚠️ |
| 2 | Âm tiết đầu trùng âm tiết cuối của từ hiện tại | `mismatch` | ❌ |
| 3 | Chưa dùng trong ván hiện tại | `repeated` | ❌ |
| 4 | Có trong từ điển tiếng Việt (gọi API dict.minhqnd.com) | `not_in_dict` | ❌ |

Kết quả của từ hợp lệ:

- Nếu còn từ để nối tiếp: `code = ok` (✅). Từ đó thành từ hiện tại.
- Nếu **không còn từ nào để nối tiếp**: `code = win` (🏆). Người vừa nối **thắng ván**, bot mở ngay ván mới với từ mới. Từ mở ván được đưa luôn vào lịch sử, nên không ai nối lại được từ đó.
- Mỗi từ hợp lệ (`ok` hoặc `win`) được **+1 điểm**. Điểm cộng dồn mãi, không reset theo phiên.
- Từ sai không bị trừ điểm và không có giới hạn số lần sai.
- Không có luật lượt. Một người được nối nhiều lần liên tiếp, giống bot gốc.
- Một ván giữ tối đa 100 từ gần nhất để kiểm tra từ lặp.

Chuẩn hoá trước khi chấm (`wordchain.normalize.go`):

- Đưa về NFC, chữ thường, bỏ khoảng trắng hai đầu.
- Đổi kiểu bỏ dấu cũ sang kiểu mới ở cuối âm tiết: `oà → òa`, `uý → úy` (trừ sau `q`, ví dụ `quý` giữ nguyên).
- Tin hiển thị giữ nguyên nội dung người gõ (`content`), từ đã chuẩn hoá nằm ở `word`.

## 3. Vòng đời phiên và ván

```text
Phiên (session)                         xoá toàn bộ tin nhắn khi sang phiên mới
 ├─ Ván 1: từ mở đầu → nối … → ngõ cụt → 🏆 thắng
 ├─ Ván 2: bot tự mở ván mới              tin nhắn vẫn giữ
 └─ …
    1 giờ không có từ hợp lệ nào → phiên mới
```

- **Phiên mới** được tạo khi:
  - có người vào lần đầu mà chưa có phiên nào;
  - phiên hiện tại đã quá **1 giờ** kể từ lần có từ hợp lệ gần nhất (`lastProgressAt`).
- Khi sang phiên mới, server **xoá toàn bộ tin nhắn phiên cũ**, chọn từ mở đầu mới và đăng tin bot `session_started`. Điểm vẫn giữ.
- Từ sai không kéo dài phiên. Chỉ từ hợp lệ mới cập nhật `lastProgressAt`.
- Server đặt timer đúng thời điểm hết hạn, và kiểm tra lại mỗi khi có request đọc hoặc nối từ, nên phiên vẫn được thay đúng hạn kể cả khi server restart.
- **Ván mới** (sau khi có người thắng) vẫn nằm trong phiên cũ. Tin nhắn giữ nguyên, bot đăng thêm tin `win` và `game_started`.

## 4. Từ điển

| Việc | Nguồn |
|---|---|
| Kiểm tra từ có tồn tại | Luôn gọi API `dict.minhqnd.com/api/v1/lookup`, chỉ nhận kết quả có `lang_code = vi` |
| Kiểm tra ngõ cụt (còn từ nối tiếp không) | Còn ít nhất 1 từ chưa dùng **được API `lookup` chấp nhận**, cùng tiêu chí với lúc chấm từ (xem bên dưới) |
| Chọn từ mở đầu phiên và ván | Bốc ngẫu nhiên từ từ điển local, rồi kiểm tra như trên. Thử tối đa 10 từ, không từ nào nối được thì báo lỗi, không mở ván bằng ngõ cụt |
| Tra từ cho người chơi | API `lookup` |

Từ điển local nằm ở `wordchain/assets/` (`wordPairs.json`, `customWords.json`, copy từ repo gốc) và được `go:embed` vào binary. **Hai file này phải có trong git**, thiếu thì server không build được.

Lý do vẫn cần từ điển local dù đã kiểm tra từ bằng API:

- API `lookup` chỉ trả lời "từ này có tồn tại không", không liệt kê được các từ bắt đầu bằng một âm tiết.
- API không có endpoint lấy từ ngẫu nhiên để mở ván.
- Từ điển local cho thêm ứng viên ngoài `suggest`, vì `suggest` chỉ trả tối đa khoảng 20 kết quả.

Cách kiểm tra "còn từ để nối" sau một từ đúng, ví dụ sau "đẹp đẽ" thì xét âm tiết "đẽ":

1. Lấy các từ chưa dùng bắt đầu bằng "đẽ" trong từ điển local. Nếu có từ nào đã được cache là hợp lệ thì kết luận còn từ.
2. Gọi API `suggest` để lấy thêm ứng viên.
3. Gọi `lookup` cho **mọi** ứng viên chưa biết kết quả, mỗi đợt 10 từ song song, ưu tiên ứng viên từ `suggest`. Gặp 1 từ hợp lệ là dừng ngay và kết luận còn từ.
4. Chỉ kết luận ngõ cụt (người vừa nối thắng) khi **đã kiểm tra hết** ứng viên và không từ nào hợp lệ. Nếu API lỗi ở ứng viên nào đó thì không kết luận thắng, nước đi trả `503` và không lưu gì.

Ví dụ: từ điển local có "đẽ mị" nhưng API `lookup` trả 404, còn `suggest("đẽ")` chỉ ra "đẽo…". Vậy "đẹp đẽ" là ngõ cụt và người nối nó thắng. Nếu chỉ tin từ điển local, phòng sẽ kẹt ở từ "đẽ" tới khi hết phiên.

Chi phí: trung vị mỗi âm tiết có 5 ứng viên, nhiều nhất là 225 (âm "ăn"). Âm tiết nhiều ứng viên hầu như luôn gặp từ hợp lệ ngay đợt đầu, nên chỉ trường hợp gần như mọi ứng viên đều không hợp lệ mới phải gọi nhiều đợt. Việc này chạy ngoài lock.

Khác bot gốc: bot gốc chỉ tính một ứng viên khi bản thân nó cũng còn nối tiếp được. Ola chỉ cần còn 1 từ hợp lệ để nối, đúng với câu "không còn từ nào để nối tiếp".

Kết quả `lookup` (có hoặc không) được cache 24 giờ trong Redis, nên các lần sau thường không phải gọi API.

Nếu API lỗi, hoặc không chọn được từ mở ván còn nối được, thì:

- nước đi (kể cả nước đi thắng) trả `503 WORD_CHAIN_VERIFY_FAILED` và **không lưu gì**;
- mở phiên lúc có người vào trả `503`, lần gọi sau sẽ thử lại;
- mở phiên do hết hạn (timer) thì thử lại sau 30 giây.

## 5. Khác biệt so với bot gốc

| Hạng mục | Bot gốc (Discord) | Ola |
|---|---|---|
| Kiểm tra từ tồn tại | Từ điển local (`listWordSet`) | Gọi API dict.minhqnd.com |
| Kiểm tra ngõ cụt | Chỉ từ điển local | Còn từ chưa dùng được API chấp nhận. Ứng viên lấy từ local + `suggest` |
| Lịch sử ván mới sau khi thắng | Rỗng (từ mở ván chơi lại được) | Có sẵn từ mở ván |
| Kênh chơi | Kênh Discord do admin thêm | 1 phòng cố định |
| Kết thúc | Thắng thì mở ván mới | Giống bot gốc, thêm hết hạn phiên sau 1 giờ và xoá tin nhắn |
| Thống kê | Chuỗi, kỷ lục, số lần thắng | Điểm = số từ hợp lệ |
| Luật sai 3 lần reset chuỗi | Có | Không |
| Xin ván mới (vote 15 giây), gợi ý, góp ý, thêm từ | Có | Không |
| Chơi với bot, DM | Có | Không |
| Phát hiện dán text / chống copy | Không có | Không có |

Về text dán vào: cả bot gốc và Ola đều không phân biệt được gõ hay dán. Server chỉ nhận chuỗi `content`. Chữ hoa, khoảng trắng hai đầu và tổ hợp dấu kiểu macOS/iOS (NFD) đều được chuẩn hoá. Còn các trường hợp sau sẽ bị chấm `invalid_format`, giống bot gốc:

- giữa 2 âm tiết có 2 dấu cách trở lên;
- xuống dòng hoặc tab;
- dấu cách không ngắt (NBSP) hoặc ký tự vô hình, thường gặp khi copy từ web.

## 6. Lưu trữ Redis

| Key | Kiểu | Nội dung |
|---|---|---|
| `WORD_CHAIN:STATE` | STRING (JSON) | Phiên hiện tại: `sessionId`, `word`, `history`, `sessionStartedAt`, `lastProgressAt`, `revision` |
| `WORD_CHAIN:STATE_REV` | STRING (INCR) | Bộ đếm `revision` của state, tăng mỗi lần state đổi |
| `WORD_CHAIN:MSG` | HASH | `messageId → JSON tin nhắn`. Chỉ lưu `senderId`, không lưu tên, avatar, VIP |
| `WORD_CHAIN:MSG_INDEX` | ZSET | `messageId`, score = `seq` |
| `WORD_CHAIN:MSG_SEQ` | STRING (INCR) | Bộ đếm `seq` của tin nhắn |
| `WORD_CHAIN:POINTS` | ZSET | `userId`, score = điểm |
| `WORD_CHAIN:LOOKUP_COOLDOWN:<userId>` | STRING, TTL 5 giây | Cooldown tra từ |
| `WORD_CHAIN:WORD_EXISTS:<từ>` | STRING, TTL 24 giờ | Cache kết quả API `lookup`: `1` có, `0` không |
| `LOCK:WORD_CHAIN` | STRING, TTL 15 giây | Lock toàn cục khi xử lý nước đi và đổi phiên |

- Mỗi phiên giữ tối đa 5000 tin. Vượt thì xoá tin cũ nhất.
- Mọi thao tác ghi của một nước đi (state, điểm, tin người chơi, tin bot) nằm trong **một transaction Redis** (MULTI/EXEC), nên không có chuyện đổi từ mà không cộng điểm.
- Khi server đã lấy được lock, request bị hủy giữa chừng vẫn ghi đủ và vẫn phát event.
- **Không gọi API từ điển khi đang giữ lock.** Nước đi được chấm xong (kể cả chọn từ mở ván mới khi thắng) ở ngoài lock, dựa trên state có `revision` R. Vào lock, server chỉ kiểm tra state vẫn ở `revision` R rồi ghi. Nếu có người khác vừa nối trước (revision đã đổi) thì server chấm lại theo state mới, tối đa 3 lần, sau đó trả `409`.
- Tạo phiên mới (lúc vào lần đầu, lúc hết hạn) cũng chọn và kiểm tra từ mở đầu trước khi lấy lock.

## 7. Luồng realtime

```text
API service ──Kafka CHAT.WORD_CHAIN.EVENT──▶ Chat service ──Socket.IO──▶ kênh "word_chain"
```

- API service publish event sau khi nhả lock. Vì vậy 2 nước đi gần nhau có thể tới client **đảo thứ tự**.
- Client dùng `revision` (state) và `seq` (tin nhắn) để sắp lại và bỏ dữ liệu cũ. Chi tiết ở [api.md](api.md#4-quy-tắc-phía-client).

## 8. File chính

| File | Nội dung |
|---|---|
| `wordchain.constants.go` | Mọi hằng số: thời gian, giới hạn, cache key, code, reaction |
| `wordchain.normalize.go` | Chuẩn hoá tiếng Việt, tách âm tiết |
| `wordchain.dictionary.go` | Từ điển local: ứng viên để nối, bốc từ mở đầu |
| `wordchain.verifier.go` | Client gọi dict.minhqnd.com (`lookup`, `suggest`) và cache kết quả `lookup` |
| `wordchain.oracle.go` | Tiêu chí chung: từ có tồn tại, còn từ để nối không, chọn từ mở ván |
| `wordchain.engine.go` | Luật chấm một nước đi, không có I/O |
| `wordchain.service.go` | Lock, xử lý nước đi, phiên, timer hết hạn, phát event |
| `wordchain.store.go` | Đọc và ghi Redis, transaction `Apply` |
| `wordchain.messages.go` | Nội dung tin bot |
| `wordchain.lookup.go` | Tra từ và cooldown |
| `wordchain.controller.go`, `wordchain.router.go` | REST |

Ngoài folder `wordchain`, tính năng này còn đụng tới:

- `constants/constant.go`: Kafka topic và tên event socket;
- `domain/room`: handler Kafka → socket;
- `transport/kafka`: producer, adapter;
- `transport/websocket`: kênh `word_chain`, event join/leave;
- `modules/room/room.dig.go` và `room.router.go`: gắn DI và route.
