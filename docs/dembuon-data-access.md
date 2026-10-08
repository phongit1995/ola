# Dembuon: truyện, chương và cách lấy dữ liệu

Ngày kiểm tra: **07/10/2026**. Website: [dembuon.vn](https://dembuon.vn/) (tên diễn đàn "Việt Nam Overnight").

Tài liệu ghi lại kết quả request HTTP vào các trang công khai trong phiên khảo sát, không phải API chính thức của Dembuon. Số lượng là số tại thời điểm kiểm tra. Cách lấy dữ liệu của nguồn đang chạy xem ở [vnkings-data-access.md](vnkings-data-access.md), bảng lưu truyện ở [vnking/database.md](vnking/database.md).

## 1. Kết quả chính

Dembuon **không lấy được theo cách của vnkings**. Đây là diễn đàn **XenForo 2.3** chạy sau Cloudflare, không phải WordPress:

| Thứ vnkings đang dùng | Ở Dembuon |
| --- | --- |
| REST `?rest_route=/wp/v2/posts` | Không có. `/wp-json/` trả `404` |
| AJAX `vnk_single_chapters` (danh sách chương) | Không có |
| Trang chương riêng (`#content`) | Không có. Chương là một post trong thread |
| API của nền tảng | XenForo có `/api/` nhưng cần API key do admin cấp (`no_api_key_in_request`), không dùng được |

### Có API không

| Cách thử | Kết quả |
| --- | --- |
| XenForo REST `/api/…` (`/api/threads/{id}/`, `/api/forums/{id}/threads`, cả dạng `/index.php?api/…`) | Có tồn tại, nhưng mọi request đều trả `400 no_api_key_in_request`. Key phải do admin Dembuon tạo, gửi trong header `XF-Api-Key` |
| `?_xfResponseType=json` trên trang thường | Thiếu token: `400` "Có lỗi về vấn đề bảo mật". Có cookie và `_xfToken` thì trả JSON, nhưng `html.content` vẫn là HTML của trang, không hơn gì đọc HTML |
| JSON-LD (`<script type="application/ld+json">`) trong trang thread | Có, schema.org `DiscussionForumPosting`: tên, tác giả kèm ID, ngày đăng, ngày sửa, tags, mục, ảnh bìa, lượt xem, số trả lời, text post đầu. **Không có chương** |
| RSS từng mục | Có, XML (mục 6) |
| `/wp-json/`, `/graphql` | `404` |
| App mobile riêng (có thể có API riêng) | Không thấy link app nào trên trang chủ |

Kết luận: **không có API công khai để lấy chương**. Crawler dùng RSS để biết truyện nào có cập nhật, JSON-LD cho thông tin truyện, và HTML trang thread cho chương. Nếu muốn dùng REST chính thức của XenForo (JSON có sẵn `post_date`, nội dung BBCode của từng post) thì phải xin admin Dembuon cấp API key.

Lấy được đầy đủ từ trang công khai:

| Dữ liệu cần lấy | Cách lấy | Kết quả |
| --- | --- | --- |
| Danh sách truyện của một mục | `GET /forums/{slug}.{id}/page-{n}` | HTML, 100 thread mỗi trang, xếp theo post mới nhất |
| Truyện vừa có cập nhật | `GET /forums/{slug}.{id}/index.rss` | RSS, tối đa 100 thread, `pubDate` = giờ post mới nhất, `guid` = ID thread |
| Giới thiệu, chương, nội dung | `GET /threads/{slug}.{id}/page-{n}` | HTML, 20 post mỗi trang, **có sẵn nội dung** |
| Giờ đăng chương | Thuộc tính `data-timestamp` của mỗi post | Unix time, chính xác tới giây |
| Giờ sửa chương | Khối `message-lastEdit` ("Chỉnh sửa cuối") | Unix time, chỉ có khi post từng bị sửa |
| Mục lục | Link trong post đầu (chỉ một số truyện) | Trỏ tới đúng post của từng chương |
| Thông tin truyện có cấu trúc | JSON-LD trong trang thread | Tên, tác giả, tags, ảnh bìa, lượt xem, giới thiệu |
| Một post bất kỳ | `GET /posts/{postId}/` | `301` tới trang chứa post, ví dụ `/threads/…59406/page-7#post-957815` |

`robots.txt` cho phép `/forums/` và `/threads/` (chỉ chặn tài khoản, tin nhắn, đăng nhập… và vài bot SEO). Không cần đăng nhập để đọc truyện.

Luồng lấy dữ liệu:

```text
RSS từng mục ──► thread có post mới hơn mốc lần trước
                 └► GET /threads/{slug}.{id}/page-1 … page-N
                    ├► post #1: tên, tác giả, thể loại, giới thiệu, ảnh bìa, mục lục
                    └► post #2…: mỗi post của tác giả là một chương (kèm nội dung, giờ đăng)
```

So với vnkings:

| | vnkings | Dembuon |
| --- | --- | --- |
| Lấy danh sách chương | AJAX, 10 chương/request, không có nội dung | Trang thread, 20 chương/request, **có nội dung** |
| Nội dung chương | Tải riêng từng chương (lúc người dùng đọc) | Có luôn khi lấy danh sách |
| Giờ đăng chương | Nhãn "dd/mm/yyyy lúc h:mm", không có sáng/chiều, phải đoán | Timestamp chính xác |
| Phát hiện cập nhật | REST `modified_after` | RSS từng mục |
| Dung lượng mỗi request | Nhỏ (JSON) | Khoảng 370 KB HTML |

## 2. Các mục truyện và số chương

Các mục nằm trong nhóm "C - BOX TRUYỆN VNO". Quét toàn bộ 74 trang danh sách ngày 07/10/2026, được **7.247 thread**:

| Mục | URL | Ý nghĩa | Số truyện | Số chương (ước) | Có post mới trong 30 / 365 ngày |
| --- | --- | --- | ---: | ---: | --- |
| Truyện Của Tôi | `/forums/truyen-cua-toi.206/` | Truyện dài đang ra | 63 | ~3.976 | 5 / 40 |
| Hoàn Thành | `/forums/hoan-thanh.213/` | Truyện dài đã xong | 298 | ~13.703 | 3 / 30 |
| Truyện Hay | `/forums/truyen-hay.244/` | Truyện được chọn | 74 | ~3.283 | 0 / 1 |
| Truyện Ngắn | `/forums/truyen-ngan.210/` | Truyện ngắn, có cả truyện vài chương | 6.654 | ~11.636 | 71 / 468 |
| Chờ Duyệt | `/forums/cho-duyet.211/` | Truyện mới, **chưa được duyệt** | 158 | ~3.411 | 19 / 99 |

"Số chương" lấy theo số trả lời của thread. Trong các truyện đã kiểm tra, chỉ tác giả đăng trong thread nên số trả lời gần đúng bằng số chương (xem mục 4.4).

**Truyện dài có nhiều chương:** trung vị khoảng 30–37 chương mỗi truyện.

| Số chương | Truyện Của Tôi | Hoàn Thành | Truyện Hay | Chờ Duyệt | Truyện Ngắn |
| --- | ---: | ---: | ---: | ---: | ---: |
| 0 (cả truyện trong 1 post) | 0 | 1 | 3 | 7 | 4.129 |
| 1 | 0 | 0 | 0 | 8 | 707 |
| 2–5 | 0 | 0 | 4 | 34 | 1.149 |
| 6–20 | 11 | 99 | 16 | 75 | 610 |
| 21–50 | 32 | 118 | 28 | 25 | 52 |
| 51–100 | 13 | 51 | 16 | 5 | 7 |
| 101–300 | 5 | 28 | 7 | 3 | 0 |
| Trên 300 | 2 | 1 | 0 | 1 | 0 |
| **Trung vị** | 37 | 29 | 32 | 10 | 0 |

Truyện dài nhất: "Tam Diện Trùm Giải Trí" (848, Chờ Duyệt), "Đại Kiếm Sĩ" (568), "Thanh Kiếm Của Quỷ" (450), "Hàn Thiên Ký" (422).

Truyện Ngắn: 4.129 truyện nằm trọn trong 1 post, 2.525 truyện có từ 2 post trở lên.

**Tổng lấy được** (Hoàn Thành tính cả 1 truyện ghim):

| Phạm vi | Truyện | Chương (ước) | Chương đọc được |
| --- | ---: | ---: | --- |
| 3 mục truyện dài (Truyện Của Tôi, Hoàn Thành, Truyện Hay) | 436 | ~21.000 | ~18.100–18.800, trừ chương khoá (mục 4.5) |
| + Truyện Ngắn | 7.090 | ~32.600 | Mẫu 20 truyện không có chương khoá |
| + Chờ Duyệt (cả 5 mục) | 7.248 | ~36.000 | Chưa quét chương khoá |

Để so sánh, vnkings hiện có khoảng 4.500 truyện dài với 30.160 chương, cộng 1.902 truyện ngắn.

### Tần suất cập nhật

Đếm chương thật sự đăng mới bằng cách tải trang cuối của 236 thread có post trong 90 ngày (326 request, không lỗi):

| Mục | Chương mới 7 / 30 / 90 ngày | Truyện có chương mới 7 / 30 / 90 ngày | Truyện mới 30 / 90 ngày |
| --- | --- | --- | --- |
| Truyện Của Tôi | 16 / 72 / 208 | 2 / 4 / 17 | 0 / 0 |
| Hoàn Thành | 2 / 3 / 53 | 2 / 3 / 9 | 0 / 1 |
| Truyện Hay | 0 / 0 / 0 | 0 / 0 / 0 | 0 / 0 |
| Truyện Ngắn | 6 / 47 / 173 | 6 / 30 / 83 | 17 / 83 |
| Chờ Duyệt | 152 / 213 / 1.469 | 8 / 18 / 37 | 4 / 23 |
| **Tổng** | **176 / 335 / 1.903** | **18 / 55 / 146** | **21 / 107** |

- Hơn một nửa số chương trong 90 ngày (1.098/1.903) là của một tác giả đăng dồn 2 truyện ở Chờ Duyệt ("Tam Diện Trùm Giải Trí" 848 chương, "Tịnh Thổ Của Những Kẻ Bị Ruồng Bỏ" 250 chương). Bỏ tác giả này thì cả site còn khoảng **270 chương/tháng**, từ khoảng 30 tác giả.
- Ba mục truyện dài chỉ có 7 truyện ra chương trong 30 ngày, và riêng "Đại Kiếm Sĩ" đã chiếm 64/75 chương. Truyện Hay không có chương mới trong 90 ngày, cả năm chỉ có 1 thread có post mới.
- Số truyện mới mỗi năm giảm dần: 1.604 (2020), 1.749 (2021), 756 (2022), 513 (2023), 427 (2024), 550 (2025), 288 (01/01–07/10/2026).
- Theo tuần, số chương lên xuống thất thường (từ 39 tới 464 chương) vì tác giả hay đăng dồn nhiều chương một lúc.

Vì vậy chạy cập nhật mỗi 1–3 giờ là đủ. Mỗi lượt tốn 3–5 request RSS, cộng 1–2 request cho mỗi truyện có chương mới.

### Lấy tất cả hay theo từng mục

**Thể loại không cần chia:** thể loại chỉ là nhãn prefix gắn trên từng thread, đọc một mục là có đủ mọi thể loại trong mục đó.

**Mục thì phải đọc từng mục**, vì Dembuon không có trang nào liệt kê riêng "tất cả truyện":

| Cách thử | Kết quả |
| --- | --- |
| Trang mục cha "Truyện Của Tôi" (206) | Chỉ liệt kê thread của chính nó, không gồm thread của các mục con (210, 211, 213, 244) |
| RSS toàn site `/forums/-/index.rss` | 100 thread mới nhất của mọi mục (nhạc, ảnh, thơ…). Lần kiểm tra chỉ có vài thread truyện, không dùng để theo dõi truyện được |
| Sitemap `/sitemap.xml` | 96.213 thread toàn site, có `lastmod`, nhưng không ghi thread thuộc mục nào. Chứa đủ 7.246/7.247 thread truyện, nhưng muốn lọc phải tải từng thread |

Vì vậy crawler giữ một danh sách ID mục cần lấy và lặp qua từng mục: mỗi lượt 1 request RSS cho mỗi mục, lần nạp đầu đọc hết các trang danh sách (5 mục = 74 trang). Danh sách mục là cấu hình, không phải giới hạn kỹ thuật.

### Thể loại

Mỗi thread có một nhãn thể loại (prefix). Có **18 thể loại** ở 3 mục truyện dài và 20 ở Truyện Ngắn, gần như trùng nhau. Chỉ 15/435 truyện dài không gắn nhãn.

3 mục truyện dài (Truyện Của Tôi, Hoàn Thành, Truyện Hay), 435 truyện:

| Thể loại | Truyện | Chương | Trung vị chương | Nhiều nhất |
| --- | ---: | ---: | ---: | ---: |
| Ngôn Tình | 152 | 6.414 | 30 | 179 |
| Đam Mỹ | 54 | 2.736 | 32 | 222 |
| Tiểu Thuyết | 47 | 2.425 | 38 | 212 |
| Hiện Đại | 31 | 1.714 | 31 | 252 |
| Xuyên Không | 24 | 1.201 | 33 | 195 |
| Không nhãn | 15 | 331 | 12 | 70 |
| Trọng Sinh | 14 | 726 | 40 | 142 |
| Truyện Teen | 14 | 515 | 28 | 98 |
| Bách Hợp | 13 | 350 | 20 | 82 |
| Truyện Ma | 12 | 753 | 22 | 450 |
| Huyền Ảo | 12 | 728 | 36 | 276 |
| Cổ Đại | 11 | 633 | 45 | 230 |
| Tiên Hiệp | 11 | 1.000 | 60 | 422 |
| Viễn Tưởng | 8 | 846 | 24 | 568 |
| Trinh Thám | 8 | 233 | 20 | 65 |
| Tự Truyện | 4 | 100 | 24 | 41 |
| Kiếm Hiệp | 3 | 107 | 27 | 54 |
| Full | 2 | 150 | 75 | 150 |

Truyện Ngắn, 6.654 truyện: chủ yếu là Truyện Ngắn (2.965), Tản Văn (1.892), Tự Truyện (424), Ngôn Tình (412), Đam Mỹ (225), Truyện Ma (165). Trung vị 0–8 chương tuỳ thể loại.

"Full" là nhãn trạng thái tác giả tự gắn, không phải thể loại. Khi lưu `genres` nên bỏ nhãn này, coi như truyện đã hoàn thành.

Ngoài nhãn prefix, mỗi thread còn có tags tự do (JSON-LD `keywords`, ví dụ `hiện đại, ngôn tình, tình cảm`), lưu vào `tags`.

### Các mục không nên lấy

Ngoài khu Box Truyện còn vài mục có chữ "truyện", nhưng không phải truyện sáng tác của thành viên. Đề xuất không lấy:

| Mục | Số thread (ước) | Nội dung |
| --- | ---: | --- |
| Truyện Ngắn (`/forums/truyen-ngan.70/`, Góc Thư Giãn) | ~1.100 | Phần lớn ghi "Sưu Tầm" (đăng lại) |
| Thiếu Nhi (`/forums/thieu-nhi.81/`, Thư Viện Sách) | ~700 | Truyện cổ Grimm, cổ tích |
| Văn Học (`/forums/van-hoc.79/`, Thư Viện Sách) | ~50 | Tác phẩm đã xuất bản (Nam Cao…) |
| Văn Thơ (`/forums/van-tho.114/`) | ~2.900 | Chủ yếu là thơ |
| Cần Sửa Bài (`/forums/can-sua-bai.172/`, Thùng Rác - Tái Chế) | ~2.100 | Bài bị trả về để sửa |
| Kinh Dị (`/forums/kinh-di.75/`, Thế Giới Ảnh) | ~30 | Bài ảnh, không phải truyện |

## 3. Một truyện là một thread

### 3.1. Dòng thread trong trang danh sách

Mỗi thread là một `div.structItem--thread`, có sẵn:

| Thông tin | Vị trí trong HTML |
| --- | --- |
| ID thread | class `js-threadListItem-{id}` |
| Link | `a[data-tp-primary="on"]`, dạng `/threads/{slug}.{id}/` |
| Tên | Text của link trên, thường dạng `Tên truyện - Tác giả` |
| Thể loại | Nhãn prefix `span.label` (Ngôn Tình, Đam Mỹ, Tiểu Thuyết, Tiên Hiệp, Xuyên Không, Truyện Ngắn, Tản Văn…) |
| Người mở thread | `data-author` |
| Ngày tạo | `.structItem-startDate time[data-timestamp]` |
| Số trả lời, lượt đọc | `<dt>Trả lời</dt><dd>568</dd>`, `<dt>Đọc</dt><dd>52K</dd>` (lượt đọc đã làm tròn) |
| Giờ post mới nhất | `time.structItem-latestDate[data-timestamp]` |

### 3.2. Trang thread

- URL `/threads/{slug}.{id}/`, trang sau là `/threads/{slug}.{id}/page-{n}`. Mỗi trang 20 post, số trang là `ceil((số trả lời + 1) / 20)`.
- Mỗi post là `article.message--post` với `data-author` (tên người đăng) và `data-content="post-{postId}"`. Nội dung ở `div.bbWrapper`, giờ đăng ở `time.u-dt[data-timestamp]` đầu tiên, giờ sửa (nếu có) ở `div.message-lastEdit time[data-timestamp]`.
- Nội dung chương thường bọc trong `div.mySpoiler-content` với nút "Xem nội dung ẩn". Khối này **chỉ ẩn bằng CSS**, nội dung có sẵn trong HTML.
- Tags của thread là các link `/tags/{slug}/`.

### 3.3. Post đầu (giới thiệu)

Post đầu là trang giới thiệu, tác giả tự viết nên không theo mẫu cố định. Thường có:

```text
Truyện: Là Duyên Cũng Là Mệnh
Tác giả: Cap- A
Thể loại: Hiện đại
[ảnh bìa: img.bbImage, thường host trên flickr]
Văn án:
…
[Mục lục: link tới từng chương – không phải truyện nào cũng có]
```

## 4. Ghép một thread thành nhiều chương

Một truyện ghép được thành nhiều chương: **thread → 1 dòng `stories`, mỗi post chương → 1 dòng `story_chapters`**.

### 4.1. Quy tắc

1. Tải mọi trang của thread.
2. Post #1 là giới thiệu. Nếu sau khi lọc (điều kiện 3) không còn post chương nào thì đó là truyện ngắn: `kind = short`, nội dung post #1 là chương duy nhất (giống truyện ngắn vnkings). Trường hợp này gồm cả thread chỉ có 1 post và thread truyện ngắn mà các post sau chỉ là bình luận.
3. Các post sau post #1 là chương nếu thoả cả 3 điều kiện:
   - người đăng là người mở thread;
   - post không bắt đầu bằng trích dẫn (`<blockquote>`), vì đó là tác giả trả lời bình luận;
   - dòng đầu là tiêu đề chương (`Chương`, `Chap`, `Phần`, `Hồi`, `Tập`, `Quyển`, `Tự chương`, `Ngoại truyện`, `Phiên ngoại`, `Vĩ thanh`, `Mở đầu`, `Lời kết`…), **hoặc** post dài từ 1.500 ký tự trở lên.
4. `position` do mình đánh từ 1 theo thứ tự post trong thread. Không lấy số tác giả ghi, vì có truyện đánh số lại theo từng phần (ví dụ "Phần 1: …", "Chương 2: …" rồi lại "Chương 4: …").
5. `title` là dòng đầu của post (bỏ ký tự zero-width `U+200B`). Post không có dòng tiêu đề thì dùng `Chương {position}`. Nội dung chương là phần còn lại của post. Bỏ thẻ BBCode thô còn sót trong text (ví dụ `[COLOR=rgb(77, 166, 255) ]…[/COLOR]` khi tác giả gõ sai).
6. Thread **ghim** trong danh sách: có nhãn thể loại thì là truyện (ví dụ "Vương Tử Khuynh Thành", 141 chương, ghim ở Hoàn Thành), không có nhãn thì là nội quy/báo danh, bỏ qua. RSS cũng trả các thread ghim này.
7. Nếu post #1 có mục lục, các link trỏ vào **chính thread này** (`/posts/{postId}/` hoặc `/threads/{slug}.{id}/post-{postId}`) dùng để đối chiếu thứ tự. Link sang thread khác (ví dụ thread "Thảo luận - Góp ý") bỏ qua. Lệch giữa mục lục và kết quả quét thì ghi log, vẫn dùng kết quả quét.

### 4.2. Chạy thử

Tải đủ mọi trang của 3 truyện và ghép theo quy tắc trên:

| Truyện | Request | Post | Chương | Post bị bỏ | Mục lục |
| --- | ---: | ---: | ---: | --- | --- |
| Là Duyên Cũng Là Mệnh | 6 | 113 | 112 | Không | Không có |
| Trọng Sinh Sủng Trung Thần | 7 | 140 | 139 | Không | 139 link, **khớp 139/139, đúng thứ tự** |
| Đại Đế Quốc | 4 | 72 | 70 | "Nhạc chủ đề cho Đại Đế Quốc" (27 ký tự) | Chỉ có link sang thread thảo luận |

Ví dụ kết quả "Là Duyên Cũng Là Mệnh": chương 1 là post `1136937`, đăng `05/02/2024 23:14:02`, 1.103 chữ; chương 112 là post `1324400`, đăng `27/09/2026 22:45:06`.

### 4.3. Trường hợp đặc biệt đã gặp

- **Truyện Ngắn có bình luận:** thread "Hoàng Tử Bé Và Người Thắp Đèn" có 13/23 post là của người khác, và tác giả trả lời bằng post bắt đầu bằng trích dẫn ("Lunarchen nói: …"). Điều kiện 3 loại được cả hai.
- **Post #1 chỉ có tên truyện:** "Thế Giới Thượng Lưu" có post #1 dài 58 ký tự, nội dung nằm ở 2 post sau. Theo quy tắc, truyện này thành truyện dài 2 chương.
- **Chương gần như rỗng:** "Phiên ngoại 2" của "Trọng Sinh Sủng Trung Thần" chỉ có 16 chữ (nội dung có thể là ảnh hoặc link). Vẫn nhận là chương.
- **Post rác của tác giả:** "Đến Khi Tuyết Tạnh Trời Quang" có 55 post liên tiếp chỉ ghi "Hết" (3 ký tự) ở trang cuối. Điều kiện 3 loại hết, còn đúng 175 chương.
- **Truyện ngắn có bình luận phía sau:** post #1 là trọn truyện, các post sau là góp ý của người khác và lời cảm ơn của tác giả. Sau khi lọc không còn post chương nào, nên post #1 thành chương duy nhất (điều kiện 2).
- **Giờ đăng lạ:** chương 8 của "Hẹn Anh Ngày Bình Yên" có giờ đăng `07/10/2026 11:56` nhưng "Chỉnh sửa cuối" là `19/06/2026`, có lẽ post từng bị chuyển hoặc đổi ngày. Đa số post khác có giờ hợp lý.

### 4.4. Kiểm tra trên mẫu

Tải **đủ mọi trang** của 61 truyện chọn ngẫu nhiên (179 request, không lỗi HTTP nào, không gặp trang chặn của Cloudflare) rồi ghép chương theo mục 4.1:

| Mục | Truyện | Trả lời | Chương ghép được | Post bị bỏ | Chương không có dòng tiêu đề |
| --- | ---: | ---: | ---: | --- | ---: |
| Truyện Của Tôi | 10 | 715 | 715 | 0 | 1 |
| Hoàn Thành | 15 | 767 | 712 | 55 post "Hết" | 12 |
| Truyện Hay | 8 | 282 | 283 | 0 (1 truyện 1 post) | 1 |
| Chờ Duyệt | 8 | 957 | 958 | 0 | 1 |
| Truyện Ngắn | 20 | 38 | 38 | 8 bình luận người khác, 4 trả lời có trích dẫn, 2 post ngắn | 2 |

- Số post đọc được khớp đúng `số trả lời + 1` ở 61/61 thread, nên không sót trang nào.
- Ở các mục truyện dài, gần như mọi post sau post #1 đều là chương. Bình luận của độc giả nằm ở mục riêng "Bàn Luận Truyện" (`/forums/ban-luan-truyen.222/`); chỉ mục Truyện Ngắn có bình luận lẫn trong thread.
- Không thấy post nào chứa 2 chương. Các post có nhiều dòng "Chương N" đều là post #1 có mục lục.
- Không thấy chương nào bị chia thành 2 post kiểu "(1/2)", "(2/2)". Chỉ có trường hợp tác giả tự đặt tên chương như vậy, mỗi phần vẫn là một post.
- Ghép được chương không có nghĩa là đọc được nội dung: một số chương bị khoá (mục 4.5).

### 4.5. Chương bị khoá

Một số tác giả khoá chương bằng thẻ ẩn của XenForo. Khách xem chỉ thấy khung `bbCodeBlock--hide hideBlock--hide-hidethanks hideBlock--hidden` với dòng "Cần đăng nhập và nhấn Thích để xem", **không có nội dung trong HTML**. Dòng tiêu đề, giờ đăng và ID post vẫn đọc được, nên vẫn ghép được chương, chỉ thiếu nội dung.

Đã quét trang 1 của cả 436 truyện ở 3 mục truyện dài (436 request, không lỗi):

| Mục | Truyện | Truyện có chương khoá | Chương khoá (ước) |
| --- | ---: | ---: | ---: |
| Truyện Của Tôi | 63 | 1 | ~36 |
| Hoàn Thành | 299 | 41 | ~2.550 |
| Truyện Hay | 74 | 6 | ~320 |
| **Tổng** | **436** | **48 (11%)** | **~2.200–2.900 (10–13,5%)** |

- Kiểu khoá duy nhất gặp là `hide-hidethanks` (đăng nhập + bấm Thích).
- Gần như luôn **mở 10 chương đầu, khoá từ chương 11** (47/48 truyện; 1 truyện khoá từ chương 5). 28 truyện khoá hết các chương sau đó, 20 truyện chỉ khoá xen kẽ vài chương. Con số 2.900 là trần (coi mọi chương từ chương khoá đầu tiên là khoá), 2.200 là ước theo tỉ lệ khoá trên trang 1.
- Khoá tập trung ở vài tác giả: 48 truyện thuộc 23 người, riêng 2 người đã chiếm 22 truyện.
- Ví dụ: "Người Con Gái Của Diệp Vô Ảnh" (thread 68116, 111 chương), "Trường Sinh Bất Tử" (thread 144206, 46 chương), "Sao Băng Qua Trời" (thread 143874, 252 chương).
- Chỉ quét trang 1 (20 post đầu), nên truyện bắt đầu khoá sau chương 19 không được đếm; số truyện thật có thể cao hơn một ít.
- Mẫu 20 truyện ở mục Truyện Ngắn không có truyện nào bị khoá. Mục Chờ Duyệt chưa quét.

Muốn đọc được thì phải dùng một tài khoản đăng nhập và bấm Thích từng post. Việc này **không nên làm tự động**: crawler sẽ tạo hàng nghìn lượt thích giả, trái mục đích của tác giả khi khoá, và tài khoản dễ bị khoá. Các cách xử lý:

1. Nạp đủ chương, chương khoá để trống nội dung và hiện "Đọc tiếp trên Dembuon" kèm link post.
2. Chỉ nạp tới chương cuối còn đọc được, các chương sau bỏ qua.
3. Không nạp truyện có chương khoá (bỏ 48 truyện).
4. Xin Dembuon API key hoặc sự đồng ý của tác giả.

Phân biệt được chương khoá ngay lúc nạp (có `hideBlock--hidden` trong post), nên cách nào cũng làm được. Cần chốt trước khi viết crawler.

## 5. Map sang bảng `stories`, `story_chapters`

**Dùng chung 2 bảng của vnkings, không cần migration**: bảng đã có cột `source`, ID nguồn lưu dạng chuỗi. Gần như mọi cột đều có dữ liệu tương ứng; khác biệt chỉ ở `age_rating` (Dembuon không có), `genres` (1 nhãn thay vì nhiều chuyên mục) và cách lấy `status`.

Tỉ lệ có dữ liệu đo trên 40 truyện dài và 10 truyện ngắn chọn ngẫu nhiên (trang đầu của thread).

### `stories`

| Cột | vnkings lấy từ | Dembuon lấy từ | Có dữ liệu (dài / ngắn) |
| --- | --- | --- | --- |
| `source` | `vnkings` | `dembuon` | — |
| `source_story_id` | REST `id` | ID thread | 100% |
| `slug`, `source_url` | REST `slug`, `link` | URL `/threads/{slug}.{id}/` | 100% |
| `title` | REST `title` | Tên thread (JSON-LD `headline`) bỏ phần ` - Tác giả` ở cuối; dòng `Truyện:` để đối chiếu | 40/40, 10/10 có dạng "Tên - Tác giả" |
| `author_name` | HTML `Tác giả` | Dòng `Tác giả:` của post #1, không có thì lấy phần sau ` - ` cuối cùng trong tên thread | Dòng `Tác giả:` 36/40, 9/10 |
| `source_author_id` | REST `author` | ID người mở thread (JSON-LD `author.@id`, dạng `/u/{tên}.{id}/`) | 100% |
| `kind` | Chuyên mục Truyện Ngắn hoặc AJAX có chương | `short` nếu thread chỉ có post #1, còn lại `long` | 100% |
| `genres` | REST `categories` (nhiều chuyên mục) | Prefix của thread (**1 nhãn**), bỏ nhãn "Full" | 39/40, 10/10 |
| `tags` | REST `tags` | JSON-LD `keywords` | 40/40, 10/10 |
| `intro` | REST `content` / `excerpt` | Text post #1 (JSON-LD `articleBody`), bỏ các dòng `Truyện:`, `Tác giả:`, `Thể loại:` và mục lục | 100%; có đoạn "Văn án"/"Giới thiệu" rõ ràng 37/40, 2/10 |
| `cover_url` | HTML `img.lazyload` / `og:image` | JSON-LD `image` (ảnh đầu tiên của post #1) | 36/40, 6/10 |
| `status` | HTML `Tình trạng` | Theo mục: Hoàn Thành → `completed`, Truyện Của Tôi → `ongoing`, mục khác → `unknown` (nhãn "Full" → `completed`) | 100% |
| `age_rating` | HTML `Rating` | **Không có**, để rỗng | — |
| `like_count` | HTML `Lượt thích` | Điểm reaction của post #1 (`title="First message reaction score: 7"` trong danh sách) | 40/40, 8/10 |
| `view_count`, `comment_count` | Không lấy, bắt đầu từ 0 | Không lấy (JSON-LD có lượt xem chính xác, ví dụ 36.464, nếu sau này cần) | — |
| `published_at` | REST `date_gmt` | JSON-LD `datePublished` (giờ đăng post #1) | 100% |
| `source_updated_at` | REST `modified_gmt` | Giờ post mới nhất (`pubDate` của RSS, hoặc `structItem-latestDate`) | 100% |
| `last_chapter_at`, `chapter_count`, `word_count` | Tự tính | Tự tính | — |

### `story_chapters`

| Cột | vnkings lấy từ | Dembuon lấy từ | Ghi chú |
| --- | --- | --- | --- |
| `source_chapter_id` | ID trong link chương (`-p{id}.html`) | ID post | |
| `position` | Thứ tự trong danh sách AJAX | Thứ tự post trong thread (mục 4.1) | |
| `title` | Tên trong danh sách AJAX | Dòng đầu của post | 644/660 post chương (97,6%) có dòng tiêu đề; còn lại dùng `Chương {position}` |
| `source_url` | Link trang chương | `https://dembuon.vn/threads/{slug}.{id}/post-{postId}` | |
| `content_text` | Tải lúc người dùng đọc lần đầu | Có ngay trong trang thread, **lưu luôn lúc nạp** | |
| `word_count`, `content_hash` | Tự tính | Tự tính | |
| `published_at` | Nhãn "dd/mm/yyyy lúc h:mm", phải đoán sáng/chiều | `data-timestamp` của post, chính xác tới giây | Tốt hơn vnkings |

Thread được chuyển giữa các mục (ví dụ từ Truyện Của Tôi sang Hoàn Thành khi xong truyện) vẫn giữ ID nên vẫn là cùng một dòng `stories`; chỉ cần cập nhật `status`.

## 6. Đánh dấu và theo dõi cập nhật

### 6.1. Lưu gì để đánh dấu

| Mốc | Lưu ở đâu | Dùng để |
| --- | --- | --- |
| Giờ post mới nhất của mỗi mục đã xử lý | Redis, giống `STORY_CRAWL:STATE` của vnkings | Biết thread nào trong RSS là mới |
| Giờ post mới nhất của truyện | `stories.source_updated_at` | So với RSS để biết truyện có post mới |
| ID post của từng chương | `story_chapters.source_chapter_id` | Biết post nào đã có, post nào mới |

### 6.2. Một lượt cập nhật

1. Tải RSS của từng mục đang lấy (mỗi mục 1 request). RSS xếp theo giờ post mới nhất giảm dần, tối đa 100 thread; đã kiểm tra `pubDate` trùng giờ post mới nhất ở cả 100/100 thread của mục Truyện Ngắn.
2. Thread có `pubDate` mới hơn `source_updated_at` (hoặc chưa có trong DB) là thread cần xử lý. Nếu cả 100 thread đều mới hơn mốc (bị nghẽn lâu ngày), quét tiếp trang danh sách `/forums/{slug}.{id}/page-{n}` cho tới khi gặp thread cũ hơn mốc.
3. Thread mới: tải mọi trang (mục 4).
4. Thread đã có: gọi `GET /posts/{ID post chương cuối đã lưu}/`. Server trả `301` tới đúng trang chứa post đó, ví dụ `…/page-29#post-1325374`. Chỉ tải từ trang đó tới trang cuối, lấy các post đứng sau post đã lưu, rồi dời mốc sang post mới nhất. Cách này đúng cả khi có post bị xoá làm lệch trang.
5. Truyện được chuyển mục (ví dụ sang Hoàn Thành) thì cập nhật `status`.

Đã chạy thử trên "Đại Kiếm Sĩ", giả sử DB đang lưu tới chương 560 (post `1325374`):

```text
GET /posts/1325374/                         → 301 …/dai-kiem-si-vu-khuc.154808/page-29#post-1325374
GET /threads/dai-kiem-si-vu-khuc.154808/page-29
→ 6 chương mới: 561 (05/10/2026 06:32:41) … 566 (07/10/2026 13:29:06), đủ nội dung
→ mốc mới: post 1325655
```

Tổng **2 request** cho 6 chương mới.

### 6.3. Giới hạn

- Tác giả **sửa** chương cũ không làm thread có post mới, nên lượt cập nhật không thấy. Muốn bắt được thì định kỳ đọc lại toàn bộ thread và so `message-lastEdit` hoặc `content_hash`.
- Post bị xoá chỉ phát hiện được khi đọc lại toàn bộ thread. Import hiện có (`ImportStory`) đã xử lý xoá chương không còn trên nguồn.

## 7. Chi phí request

Lượt nạp đầu, tính theo số trang thread (mỗi trang khoảng 370 KB, mỗi request cách nhau 1,4 giây):

| Mục | Request | Thời gian | Dung lượng |
| --- | ---: | ---: | ---: |
| Truyện Của Tôi | 233 | ~5 phút | ~0,1 GB |
| Hoàn Thành | 834 | ~19 phút | ~0,3 GB |
| Truyện Hay | 205 | ~5 phút | ~0,1 GB |
| Truyện Ngắn | 6.728 | ~2,6 giờ | ~2,6 GB |
| Chờ Duyệt | 269 | ~6 phút | ~0,1 GB |

Ba mục truyện dài (Truyện Của Tôi, Hoàn Thành, Truyện Hay) tốn khoảng 1.300 request, chưa tới 30 phút. Các lượt cập nhật sau chỉ tốn vài request cho RSS, cộng 1–2 request cho mỗi truyện có chương mới.

## 8. Truyện có trên cả hai nguồn

Một số tác giả đăng cùng truyện ở cả vnkings và Dembuon. Ví dụ "Là Duyên Cũng Là Mệnh": bên Dembuon có 112 chương (chương mới nhất 27/09/2026), còn ví dụ trong [vnking/api.md](vnking/api.md) ghi 109 chương.

`UNIQUE (source, source_story_id)` không chặn được trùng giữa hai nguồn, nên nếu lấy cả hai thì danh sách sẽ có 2 truyện giống nhau. Cần chọn cách xử lý trước khi chạy:

- giữ cả hai;
- hoặc so tên truyện + tác giả (viết thường, bỏ dấu, giống `search_text`) và ẩn bản ít chương hơn.

## 9. Rủi ro

- **Chương bị khoá.** Khoảng 11% truyện dài khoá chương từ chương 11 (mục 4.5). Không tự động bấm Thích để mở khoá.
- **Cấu trúc dựa vào thói quen tác giả.** "Mỗi post một chương" và "chỉ tác giả đăng" là nội quy/thói quen của diễn đàn, không phải ràng buộc kỹ thuật. Bộ lọc ở mục 4.1 cần log các post bị bỏ để còn kiểm tra.
- **Cloudflare.** Trong khảo sát (khoảng 150 request, mỗi request cách 1,2 giây) chưa gặp trang chặn. Nếu gặp `403`, `429`, `503` hoặc trang challenge thì dừng cả lượt, giống crawler vnkings.
- **Trang nặng.** Mỗi trang thread khoảng 370 KB vì có nội dung 20 chương.
- **XenForo đổi giao diện** có thể làm sai các selector ở mục 3.
- **Bản quyền** thuộc tác giả, giống trường hợp vnkings.

## 10. Việc cần làm nếu thêm nguồn Dembuon

- **Server:**
  - thêm bộ đọc RSS, trang danh sách và trang thread của Dembuon;
  - interface `Catalog` của crawler hiện viết riêng cho WordPress (`ModifiedPosts`, `PostsByID`, `ChapterLinks`…), nên cần tách thành nguồn riêng hoặc chạy một crawler thứ hai;
  - dùng lại `ImportStory` để nạp, và nạp kèm nội dung chương;
  - `loadContent` (lấy nội dung lúc người dùng đọc) hiện chỉ nhận link vnkings. Chương Dembuon đã có nội dung nên không cần, nhưng nút "Tải lại nội dung" trong admin phải gọi `/posts/{postId}/` để lấy lại.
- **Admin:**
  - cấu hình crawler theo từng nguồn (bật/tắt, chọn mục);
  - bộ lọc nguồn có thêm `dembuon`.
- **Cần chốt trước:**
  - lấy những mục nào (đề xuất Truyện Của Tôi, Hoàn Thành, Truyện Hay; Truyện Ngắn tuỳ chọn; bỏ Chờ Duyệt);
  - cách xử lý truyện trùng với vnkings (mục 8);
  - cách xử lý chương bị khoá (mục 4.5).
