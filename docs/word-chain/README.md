# Phòng nối từ

Tài liệu tính năng phòng nối từ (word chain) của Ola: luật chơi, vòng đời phiên và cách dữ liệu được lưu. Hợp đồng REST và socket cho client xem ở [api.md](api.md).

Code backend: `server/internal/modules/room/wordchain/`. Luật chơi lấy từ nhánh PvP của [minhqnd/Noi-Tu-Discord](https://github.com/minhqnd/Noi-Tu-Discord) (MIT). Chỉ lấy luật, không lấy cơ chế riêng của Discord.

## 1. Tổng quan

- Toàn hệ thống chỉ có **1 phòng nối từ**. Phòng không gắn với bảng `rooms`, không có `roomId`, không có danh sách phòng, không đếm số người.
- Người chơi nối từ với nhau (PvP). **Bot chỉ làm trọng tài**: chấm từng từ, báo thắng, mở ván mới. Bot không tự nối từ.
- User đã đăng nhập là chơi được, không cần join phòng qua ticket. Join socket chỉ để nhận realtime.
- Dữ liệu ván chơi nằm ở **Redis**. Postgres chỉ giữ 3 thứ: tiền **Gợi ý** (`users.ken`, `ken_transactions`, `word_chain_hint_purchases`), lịch sử ghi điểm `word_chain_scores` để thống kê theo thời gian (xem mục 6), và cấu hình bật/tắt phòng, giá gợi ý trong `app_settings` (xem mục 9).
- Tính năng phụ: **Tra từ** (hộp tra từ mở từ nút bên trái ô nhập, và nút ⓘ nhỏ nằm ngoài bubble, cạnh mỗi từ nối đúng, để ai cũng xem được nghĩa), **Bảng xếp hạng** và **Gợi ý** (mất KEN).

## 2. Luật chơi

Một từ hợp lệ khi thỏa lần lượt các điều kiện dưới đây. Server dừng ở điều kiện đầu tiên bị sai và trả `code` tương ứng.

| Thứ tự | Điều kiện | `code` khi sai | Reaction |
|---|---|---|---|
| 1 | Đúng **2 âm tiết** (khoảng trắng thừa đã được gộp, xem phần chuẩn hoá) | `invalid_format` | ⚠️ |
| 2 | Âm tiết đầu trùng âm tiết cuối của từ hiện tại | `mismatch` | ❌ |
| 3 | Chưa dùng trong ván hiện tại | `repeated` | ❌ |
| 4 | Có trong từ điển tiếng Việt (gọi API dict.minhqnd.com) | `not_in_dict` | ❌ |

Kết quả của từ hợp lệ:

- Nếu còn từ để nối tiếp: `code = ok` (✅). Từ đó thành từ hiện tại.
- Nếu **không còn từ nào để nối tiếp**: `code = win` (🏆). Người vừa nối **thắng ván**, bot mở ngay ván mới với từ mới. Từ mở ván được đưa luôn vào lịch sử, nên không ai nối lại được từ đó.
  - Web hiện hiệu ứng chúc mừng cho mọi người đang mở phòng: pháo giấy bắn từ 2 góc, thẻ có cúp, tên người thắng, từ thắng và "+1 trận thắng", bubble từ thắng sáng viền vàng. Thẻ tự tắt sau khoảng 4 giây hoặc khi bấm vào, không chặn ô nhập. Chỉ chạy khi tin thắng tới realtime (socket hoặc response của chính người thắng), tải lại lịch sử không hiện lại; máy bật giảm chuyển động thì bỏ pháo giấy và hiệu ứng nảy.
- Mỗi từ hợp lệ (`ok` hoặc `win`) được **+1 điểm**. Từ `win` được thêm **+1 trận thắng**. Điểm và trận thắng cộng dồn mãi, không reset theo phiên.
- Bảng xếp hạng có 2 tab **Thắng** (mở mặc định) và **Điểm**, lọc theo **Hôm nay / Tuần này / Tháng này / Tất cả** (giờ Việt Nam, tuần bắt đầu thứ Hai), và tab **Lịch sử** các trận thắng (tất cả hoặc của mình).
- Từ sai không bị trừ điểm, nhưng **mỗi người chỉ có 3 lượt đoán cho mỗi từ hiện tại**. Mọi kiểu sai (`invalid_format`, `mismatch`, `repeated`, `not_in_dict`) đều trừ 1 lượt.
  - Mỗi lần sai, bot gửi 1 tin `wrong_answer` ngay sau tin sai: lý do sai, số lượt còn lại, và từ hiện tại.
  - Hết 3 lượt thì server chặn (`403 WORD_CHAIN_NO_GUESSES`), không lưu tin. Người đó phải chờ tới khi có người khác nối đúng.
  - Khi từ hiện tại đổi (có người nối đúng, thắng ván, hoặc bot thay từ vì 12 giờ không ai nối) thì mọi người có lại đủ 3 lượt.
  - Số lượt sai nằm trong state (`wrongCounts`, không trả ra client). Mỗi lần từ đổi, `turn` tăng 1.
- **Không được nối 2 lần liên tiếp.** State lưu `wordOwnerId` là người đã nối ra từ hiện tại. Người đó gửi gì cũng bị chặn (`403 WORD_CHAIN_WAIT_TURN`), không trừ lượt, không lưu tin, tới khi có người khác nối đúng.
  - Từ do bot đưa ra (mở phiên, mở ván sau khi thắng, thay từ sau 12 giờ) không thuộc về ai, nên ai cũng nối được, kể cả người vừa thắng ván.
- Một ván giữ tối đa 100 từ gần nhất để kiểm tra từ lặp.

Chuẩn hoá trước khi chấm (`wordchain.normalize.go`):

- Đưa về NFC, chữ thường, bỏ khoảng trắng hai đầu.
- Gộp mọi khoảng trắng giữa các âm tiết (nhiều dấu cách, tab, xuống dòng, NBSP và các khoảng trắng Unicode khác) thành 1 dấu cách, nên gõ thừa dấu cách không bị mất lượt.
- Đổi kiểu bỏ dấu cũ sang kiểu mới ở cuối âm tiết: `oà → òa`, `uý → úy` (trừ sau `q`, ví dụ `quý` giữ nguyên).
- Tin hiển thị giữ nguyên nội dung người gõ (`content`), từ đã chuẩn hoá nằm ở `word`.

### Gợi ý (mất KEN)

- Nút 💡 cạnh nút Gửi. Mỗi lần gợi ý tốn **500 KEN** theo mặc định, admin đổi được giá (mục 9). Server trả tối đa **5 từ** (`HintMaxWords`) nối được vào từ hiện tại.
- Từ gợi ý lấy từ từ điển local (từ còn nối tiếp được đứng trước) rồi tới `suggest`, bỏ từ đã dùng trong ván, và phải được API `lookup` chấp nhận, cùng tiêu chí với lúc chấm từ.
- Server tìm gợi ý **trước** (ngoài lock), có ít nhất 1 từ mới trừ KEN. Không tìm được thì trả `409 WORD_CHAIN_NO_HINT` và **không trừ tiền**. `suggest` lỗi thì trả `503` và cũng không trừ. `lookup` lỗi ở vài từ thì vẫn bán gợi ý nếu đã đủ 5 từ hợp lệ; chưa đủ 5 từ mà có lỗi thì trả `503`.
- Trước khi trừ tiền, server lấy lock toàn cục và đọc lại state. Nếu từ hiện tại vừa đổi (có người nối trước trong lúc tìm gợi ý) thì trả `409 WORD_CHAIN_WORD_CHANGED` và **không trừ tiền**.
- **Mỗi lượt chỉ trả tiền 1 lần.** Mỗi lần mua ghi 1 dòng vào bảng Postgres `word_chain_hint_purchases`, khoá chính (người mua, phiên, `turn`), **trong cùng transaction trừ KEN**: trừ tiền và ghi nhận đã mua cùng thành công hoặc cùng huỷ. Mua lại cho cùng lượt (bấm 2 lần, mạng gửi lại) thì server trả lại đúng danh sách cũ với `charged = false`, không gọi API từ điển và không trừ KEN. Client cũng giữ gợi ý đã mua trong store, nên đóng rồi mở lại hộp gợi ý vẫn thấy danh sách.
- Người đang không được chơi thì không mua được gợi ý: từ hiện tại do chính mình nối (`403 WORD_CHAIN_WAIT_TURN`) hoặc đã hết lượt đoán (`403 WORD_CHAIN_NO_GUESSES`). Không đủ KEN thì trả `400 WORD_CHAIN_INSUFFICIENT_KEN`.
- Trừ KEN trong một transaction Postgres có khoá dòng `users` (`FOR UPDATE`): kiểm tra lượt này đã mua chưa, trừ tiền, ghi `ken_transactions` loại `WORD_CHAIN_HINT` và dòng `word_chain_hint_purchases` (hiện trong lịch sử KEN của user với tên "Gợi ý nối từ"), rồi xoá user cache và bắn `KEN_UPDATED` cho mọi tab/thiết bị của user.
- Gợi ý chỉ là danh sách từ. Gửi từ gợi ý vẫn đi qua `POST /moves` như từ tự gõ, được chấm và cộng điểm bình thường. Nếu trong lúc đó có người khác nối trước thì gợi ý không còn khớp; client báo gợi ý đã cũ và khoá nút gửi.
- Tuỳ chọn **Tự động gửi** lưu ở máy người dùng (store `wordChainPrefsStore`, key `ola.word-chain.prefs`; web lưu ở localStorage). Bật thì mua xong client gửi luôn từ đầu tiên; tắt thì hiện danh sách gợi ý, mỗi từ có nút Gửi. Mobile chưa có màn nối từ.

## 3. Vòng đời phiên và ván

```text
Phiên (session)                         tạo 1 lần, không hết hạn, tin nhắn luôn giữ
 ├─ Ván 1: bot đưa từ → nối … → ngõ cụt → 🏆 thắng
 ├─ Ván 2: bot đưa từ mới
 │    └─ 12 giờ không ai nối từ của bot → bot thay từ khác
 └─ …
```

- **Phiên** chỉ được tạo khi chưa có state nào (lần đầu có người vào, hoặc Redis mất state). Phiên không hết hạn, `sessionId` giữ nguyên, **tin nhắn không bao giờ bị xoá theo thời gian**.
- **Từ do bot đưa ra** (từ mở phiên, từ mở ván sau khi thắng) có hạn **12 giờ** tính từ lúc bot đưa ra (`lastProgressAt`). Hết hạn mà chưa ai nối đúng thì bot thay bằng từ khác:
  - ghi đè tin bot đã đưa ra từ cũ (`session_started` hoặc `game_started`) thành tin `game_started` với từ mới, **giữ nguyên `id`**, `seq` mới nên tin chuyển xuống cuối danh sách. Không có tin thông báo "đổi từ";
  - event realtime gửi lại tin đó (cùng `id`), client gộp theo `id` nên tự thay tin cũ;
  - tin người chơi (kể cả các lần đoán sai từ cũ) giữ nguyên. `turn` tăng 1, mọi người có lại đủ lượt.
- **Từ do người chơi nối** thì không bao giờ hết hạn. Phòng chờ tới khi có người nối tiếp.
- Từ sai không kéo dài hạn của từ bot.
- State lưu `botMessageId` là id tin bot đang đưa ra từ hiện tại. "Từ hiện tại là của bot" được suy ra từ `history` chỉ có 1 từ.
- Server đặt timer đúng thời điểm từ bot hết hạn, và kiểm tra lại mỗi khi có request đọc hoặc nối từ, nên từ vẫn được thay đúng hạn kể cả khi server restart. Nếu lúc đó không chọn được từ mới (API từ điển lỗi) thì giữ nguyên từ cũ, vẫn cho nối, và thử lại sau 30 giây.
- **Ván mới** (sau khi có người thắng) vẫn nằm trong phiên. Tin nhắn giữ nguyên, bot đăng thêm tin `win` và `game_started`.

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

Ví dụ: từ điển local có "đẽ mị" nhưng API `lookup` trả 404, còn `suggest("đẽ")` chỉ ra "đẽo…". Vậy "đẹp đẽ" là ngõ cụt và người nối nó thắng. Nếu chỉ tin từ điển local, phòng sẽ kẹt mãi ở từ "đẽ", vì từ người chơi nối không hết hạn.

Chi phí: trung vị mỗi âm tiết có 5 ứng viên, nhiều nhất là 225 (âm "ăn"). Âm tiết nhiều ứng viên hầu như luôn gặp từ hợp lệ ngay đợt đầu, nên chỉ trường hợp gần như mọi ứng viên đều không hợp lệ mới phải gọi nhiều đợt. Việc này chạy ngoài lock.

Khác bot gốc: bot gốc chỉ tính một ứng viên khi bản thân nó cũng còn nối tiếp được. Ola chỉ cần còn 1 từ hợp lệ để nối, đúng với câu "không còn từ nào để nối tiếp".

Kết quả `lookup` (có hoặc không) được cache 24 giờ trong Redis, nên các lần sau thường không phải gọi API.

Nếu API lỗi, hoặc không chọn được từ mở ván còn nối được, thì:

- nước đi (kể cả nước đi thắng) trả `503 WORD_CHAIN_VERIFY_FAILED` và **không lưu gì**;
- mở phiên lúc có người vào (chưa có state) trả `503`, lần gọi sau sẽ thử lại;
- thay từ bot đã hết hạn thì giữ nguyên từ cũ, request vẫn chạy bình thường, timer thử lại sau 30 giây.

## 5. Khác biệt so với bot gốc

| Hạng mục | Bot gốc (Discord) | Ola |
|---|---|---|
| Kiểm tra từ tồn tại | Từ điển local (`listWordSet`) | Gọi API dict.minhqnd.com |
| Kiểm tra ngõ cụt | Chỉ từ điển local | Còn từ chưa dùng được API chấp nhận. Ứng viên lấy từ local + `suggest` |
| Lịch sử ván mới sau khi thắng | Rỗng (từ mở ván chơi lại được) | Có sẵn từ mở ván |
| Kênh chơi | Kênh Discord do admin thêm | 1 phòng cố định |
| Kết thúc | Thắng thì mở ván mới | Giống bot gốc, thêm: từ của bot sau 12 giờ không ai nối thì bot thay từ khác (ghi đè tin bot cũ, giữ tin người chơi) |
| Thống kê | Chuỗi, kỷ lục, số lần thắng | Điểm = số từ hợp lệ, số trận thắng, lọc theo ngày/tuần/tháng, lịch sử thắng |
| Luật sai 3 lần reset chuỗi | Có | Không |
| Nối 2 lần liên tiếp | Được | Không được, phải chờ người khác nối |
| Gợi ý | Có, miễn phí, thưởng theo chuỗi | Có, mất KEN (mặc định 500), mỗi lượt chỉ trả 1 lần |
| Xin ván mới (vote 15 giây), góp ý, thêm từ | Có | Không |
| Chơi với bot, DM | Có | Không |
| Phát hiện dán text / chống copy | Không có | Không có |

Về text dán vào: cả bot gốc và Ola đều không phân biệt được gõ hay dán. Server chỉ nhận chuỗi `content`. Chữ hoa, khoảng trắng (hai đầu, nhiều dấu cách, tab, xuống dòng, NBSP) và tổ hợp dấu kiểu macOS/iOS (NFD) đều được chuẩn hoá. Khác bot gốc, Ola không chấm `invalid_format` chỉ vì khoảng trắng thừa. Ký tự vô hình không phải khoảng trắng (ví dụ zero-width space) vẫn làm từ sai định dạng.

## 6. Lưu trữ

### Redis

| Key | Kiểu | Nội dung |
|---|---|---|
| `WORD_CHAIN:STATE` | STRING (JSON) | Phiên hiện tại: `sessionId`, `word`, `history`, `sessionStartedAt`, `lastProgressAt`, `revision`, `turn`, `wrongCounts`, `botMessageId`, `wordOwnerId` |
| `WORD_CHAIN:STATE_REV` | STRING (INCR) | Bộ đếm `revision` của state, tăng mỗi lần state đổi |
| `WORD_CHAIN:MSG` | HASH | `messageId → JSON tin nhắn`. Chỉ lưu `senderId`, không lưu tên, avatar, VIP |
| `WORD_CHAIN:MSG_INDEX` | ZSET | `messageId`, score = `seq` |
| `WORD_CHAIN:MSG_SEQ` | STRING (INCR) | Bộ đếm `seq` của tin nhắn |
| `WORD_CHAIN:LOOKUP_COOLDOWN:<userId>` | STRING, TTL 5 giây | Cooldown tra từ |
| `WORD_CHAIN:WORD_EXISTS:<từ>` | STRING, TTL 24 giờ | Cache kết quả API `lookup`: `1` có, `0` không |
| `WORD_CHAIN:LOOKUP:<từ đã chuẩn hoá>` | STRING (JSON), TTL 24 giờ | Toàn bộ kết quả API `lookup` (nghĩa, dịch, từ liên quan). Tra từ trúng cache thì không tính cooldown |
| `LOCK:WORD_CHAIN` | STRING, TTL 15 giây | Lock toàn cục khi xử lý nước đi, tạo phiên và thay từ bot |

- Phòng giữ tối đa 5000 tin gần nhất. Vượt thì xoá tin cũ nhất. Ngoài giới hạn này không tin nào bị xoá; tin bot đưa ra từ đã hết hạn chỉ bị ghi đè bằng từ mới.
- Mọi thao tác ghi Redis của một nước đi (state, tin người chơi, tin bot) nằm trong **một transaction Redis** (MULTI/EXEC). Điểm ghi vào Postgres ngay sau đó (xem bên dưới).
- Khi server đã lấy được lock, request bị hủy giữa chừng vẫn ghi đủ và vẫn phát event.
- **Không gọi API từ điển khi đang giữ lock.** Nước đi được chấm xong (kể cả chọn từ mở ván mới khi thắng) ở ngoài lock, dựa trên state có `revision` R. Vào lock, server chỉ kiểm tra state vẫn ở `revision` R rồi ghi.
- Client gửi kèm `sessionId` + `turn` của từ mà người chơi đang nhìn thấy. Nếu lúc chấm hoặc lúc ghi mà từ hiện tại đã đổi (có người nối trước, thắng ván, bot thay từ) thì server trả `409 WORD_CHAIN_WORD_CHANGED`: **không trừ lượt, không lưu tin**. Người chơi xem từ mới rồi gửi lại. Client không gửi `turn` thì server lấy `turn` ở lần đọc state đầu tiên.
- Nếu revision đổi nhưng từ vẫn vậy (ví dụ người khác vừa đoán sai) thì server chấm lại, tối đa 3 lần, sau đó trả `409` không có `code` (phòng bận).
- Tạo phiên (lúc vào lần đầu) và thay từ bot hết hạn cũng chọn và kiểm tra từ mới trước khi lấy lock.

### Postgres: `word_chain_scores`

Mỗi từ nối đúng là một dòng. Đây là nguồn cho thống kê theo thời gian và lịch sử thắng.

| Cột | Kiểu | Nội dung |
|---|---|---|
| `message_id` | uuid, PK | id tin nối từ. Ghi bằng `ON CONFLICT DO NOTHING` nên không bao giờ trùng |
| `session_id` | uuid | phiên chơi |
| `user_id` | uuid, FK `users` | người nối |
| `word`, `previous_word` | varchar(100) | từ vừa nối và từ được nối vào |
| `points` | smallint, mặc định 1 | điểm của lần nối này |
| `is_win` | boolean | đây có phải từ cuối (thắng) không |
| `created_at` | timestamptz | thời điểm nối |

Index:

- `(created_at)` cho bảng xếp hạng theo kỳ;
- `(created_at DESC, message_id DESC) WHERE is_win` cho lịch sử thắng;
- `(user_id, created_at DESC, message_id DESC) WHERE is_win` cho lịch sử thắng của một người;
- `(user_id) INCLUDE (points, is_win)` cho kỳ **Tất cả**: tổng điểm/thắng của một người, xếp hạng và đếm người chơi (migration `20261001000001`).

- Điểm trong kỳ = `SUM(points)`, trận thắng trong kỳ = `COUNT(*) FILTER (WHERE is_win)`. Muốn thống kê khoảng khác chỉ cần đổi điều kiện `created_at`.
- **Mọi kỳ, kể cả Tất cả, đều đọc từ bảng này.** Kỳ Tất cả là cùng câu truy vấn nhưng không giới hạn thời gian. Điểm của mình (`points` trong overview và response nối từ) và số người đã ghi điểm/đã thắng ở trang admin cũng đọc từ đây, nên mọi chỗ khớp nhau.
- Điểm ghi trước khi có bảng này (chỉ nằm ở 2 ZSET Redis cũ `WORD_CHAIN:POINTS`, `WORD_CHAIN:WINS`) không còn được tính. 2 key đó không còn dùng, xoá được.
- Mốc kỳ tính theo GMT+7: ngày từ 00:00, tuần từ 00:00 thứ Hai, tháng từ 00:00 ngày 1.
- Ghi Postgres **sau** khi transaction Redis thành công và **ngoài lock**, thử tối đa 3 lần (chờ 100 ms rồi 200 ms). Vẫn lỗi thì log, nước đi vẫn thành công nhưng thiếu 1 dòng điểm. Không ghi Postgres trước, vì Redis lỗi sau đó sẽ để lại dòng điểm không có thật.
- Đo trên 5 triệu dòng (khoảng 13.700 từ/ngày trong 1 năm): ghi 1 dòng ~0,1 ms; bảng xếp hạng hôm nay / tuần / tháng ~16 / 65 / 125 ms; lịch sử thắng dưới 1,5 ms. Thời gian truy vấn theo kỳ tăng theo số dòng trong kỳ, không theo tổng kích thước bảng. Khi lượng chơi tăng khoảng 10 lần thì nên thêm bảng cộng dồn theo ngày, dựng lại được từ bảng này.

### Postgres: `word_chain_hint_purchases`

Mỗi lần mua gợi ý là một dòng, ghi trong cùng transaction trừ KEN (migration `20261001000002`).

| Cột | Kiểu | Nội dung |
|---|---|---|
| `user_id`, `session_id`, `turn` | uuid, uuid, bigint, PK | người mua và lượt (từ hiện tại) đã mua gợi ý. Khoá chính chặn trừ tiền 2 lần cho cùng lượt |
| `word` | varchar(100) | từ hiện tại lúc mua |
| `hints` | text[] | danh sách gợi ý đã bán |
| `price` | integer | số KEN đã trừ |
| `ken_transaction_id` | uuid, FK `ken_transactions` | giao dịch trừ tiền tương ứng |
| `created_at` | timestamptz | thời điểm mua |

## 7. Luồng realtime

```text
API service ──Kafka CHAT.WORD_CHAIN.EVENT──▶ Chat service ──Socket.IO──▶ kênh "word_chain"
```

- API service publish event sau khi nhả lock. Vì vậy 2 nước đi gần nhau có thể tới client **đảo thứ tự**.
- Client dùng `revision` (state) và `seq` (tin nhắn) để sắp lại và bỏ dữ liệu cũ. Chi tiết ở [api.md](api.md#4-quy-tắc-phía-client).

## 8. File chính

| File | Nội dung |
|---|---|
| `wordchain.normalize.go` | Chuẩn hoá tiếng Việt, tách âm tiết |
| `wordchain.dictionary.go` | Từ điển local: ứng viên để nối, bốc từ mở đầu |
| `wordchain.verifier.go` | Client gọi dict.minhqnd.com (`lookup`, `suggest`) và cache kết quả `lookup` |
| `wordchain.oracle.go` | Tiêu chí chung: từ có tồn tại, còn từ để nối không, chọn từ mở ván |
| `wordchain.engine.go` | Luật chấm một nước đi, không có I/O |
| `wordchain.service.go` | Xử lý nước đi, tạo phiên, dựng mutation khi ghi nước đi |
| `wordchain.lock.go` | Lock toàn cục, gom event và phát sau khi nhả lock |
| `wordchain.timer.go` | Timer thay từ bot hết hạn |
| `wordchain.store.go` | Đọc và ghi Redis, transaction `Apply` |
| `wordchain.messages.go` | Nội dung tin bot |
| `wordchain.lookup.go` | Tra từ, cooldown chỉ áp dụng khi phải gọi API ngoài |
| `wordchain.hint.go` | Gợi ý: chọn từ, kiểm tra điều kiện, kiểm tra lại dưới lock, nhớ gợi ý đã mua |
| `wordchain.wallet.go` | Sau khi trừ KEN: xoá user cache, bắn `KEN_UPDATED` |
| `wordchain.leaderboard.go` | Ghi điểm vào Postgres, bảng xếp hạng theo điểm/thắng và theo kỳ (GMT+7), lịch sử thắng |
| `wordchain.repository.go` | Bảng `word_chain_scores` (điểm, bảng xếp hạng, lịch sử thắng) và transaction trừ KEN cho gợi ý (khoá dòng `users`, ghi `ken_transactions`) |
| `wordchain.config.go` | Đọc cấu hình `word_chain` (bật/tắt, giá gợi ý), chặn khi phòng bị tắt |
| `wordchain.admin.go` | Dữ liệu cho trang admin: tổng quan ván hiện tại, lịch sử tin, trận thắng |
| `wordchain.controller.go`, `wordchain.router.go` | REST |

Ngoài folder `wordchain`, tính năng này còn đụng tới:

- `constants/constant.go`: mọi hằng số của tính năng (cache key, thời gian, giới hạn, code, mã lỗi), Kafka topic và tên event socket;
- `domain/room`: handler Kafka → socket;
- `transport/kafka`: producer, adapter;
- `transport/websocket`: kênh `word_chain`, event join/leave;
- `modules/room/room.dig.go` và `room.router.go`: gắn DI và route;
- `modules/setting`: key `word_chain` trong `app_settings`, endpoint `GET /settings/word-chain`;
- `modules/admin/wordchain`: API admin `/admin/word-chain`.

## 9. Admin

Menu admin **Phòng chat** tách thành 2 mục con:

- **Danh sách phòng** (`/rooms`): các phòng chat thường, như trước.
- **Phòng nối từ** (`/rooms/word-chain`): thẻ tổng quan (từ hiện tại, người đưa ra từ, các từ trong ván, số người đã ghi điểm/đã thắng, trạng thái hiển thị và giá gợi ý) và 3 tab:
  - **Lịch sử nối từ**: tin nhắn của phòng, mới nhất trước, có nút tải thêm (Redis giữ 5000 tin gần nhất). Mỗi tin có nhãn kết quả: Đúng, Thắng, Sai âm đầu, Từ đã dùng, Không có trong từ điển, Sai định dạng, hoặc loại tin của trọng tài.
  - **Trận thắng**: đọc từ `word_chain_scores`, bấm vào người thắng để chỉ xem trận của người đó.
  - **Cấu hình**: bật/tắt hiển thị phòng và giá gợi ý.

Cấu hình lưu ở `app_settings`, key `word_chain`:

```json
{ "enabled": true, "hintPrice": 500 }
```

- Chưa có dòng nào thì dùng mặc định: **hiển thị**, gợi ý **500 KEN**.
- Admin lưu qua `PUT /admin/settings/word_chain`. Server bắt buộc có đủ 2 trường, `hintPrice` là số nguyên từ 1 đến 10.000.000, không nhận trường lạ.
- Tắt phòng (`enabled = false`):
  - web ẩn mục **Phòng nối từ** khỏi danh sách phòng (đọc `GET /settings/word-chain` mỗi lần mở tab Phòng chat và khi kéo làm mới);
  - server trả `403 WORD_CHAIN_DISABLED` cho `GET /rooms/word-chain`, `GET /messages`, `POST /moves` và `POST /hints`. Người đang ở trong phòng thì lần gửi tiếp theo bị từ chối, client báo "Phòng nối từ đang tạm đóng", đóng phòng và ẩn luôn mục đó;
  - lịch sử, điểm, trận thắng và bảng xếp hạng giữ nguyên; timer thay từ của trọng tài tạm dừng, không thay từ khi phòng tắt.
- Giá gợi ý đọc lại ở mỗi lần mua, nên đổi giá có hiệu lực ngay. `hintPrice` trong `GET /rooms/word-chain` và `price` trong response gợi ý là giá thật đã áp dụng; client cập nhật giá hiển thị theo response.
- Đọc cấu hình lỗi (DB lỗi) thì server **coi như phòng đóng**, để không vô tình mở lại phòng admin đã tắt: trả `503 WORD_CHAIN_UNAVAILABLE` cho các endpoint trên, timer thay từ thử lại sau 30 giây.
- API admin (cần quyền admin): `GET /admin/word-chain` (tổng quan, không tạo phiên mới), `GET /admin/word-chain/messages?limit&before`, `GET /admin/word-chain/wins?limit&before&userId`.
