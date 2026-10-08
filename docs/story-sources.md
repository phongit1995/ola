# Nguồn truyện sáng tác ngoài vnkings

Ngày kiểm tra: **07/10/2026**, từ mạng Việt Nam (cùng điều kiện với server crawler).

Mục tiêu: tìm thêm trang mà **tác giả Việt tự đăng truyện của mình, chia chương**, giống [vnkings](vnkings-data-access.md). Dembuon đã khảo sát riêng ở [dembuon-data-access.md](dembuon-data-access.md).

Tài liệu ghi lại kết quả request HTTP vào trang công khai, không đăng nhập, không phải API chính thức của các trang. Số lượng là số tại thời điểm kiểm tra.

## 1. Kết quả chính

| Nguồn | Đánh giá | Quy mô | Lý do chính |
| --- | --- | --- | --- |
| [TacGiaViet.com](https://tacgiaviet.com/) | **Nên làm trước** | ~567 truyện, 16.556 chương | Chỉ nhận truyện tự sáng tác, đang hoạt động mạnh, HTML có JSON-LD, sitemap có `lastmod` cho từng chương |
| [rookies.vn](https://rookies.vn/) | **Làm được** | 7.320 truyện miễn phí, ước ~50.000 chương | Mọi trang trả JSON, nhưng ít cập nhật và không có cách phát hiện cập nhật gọn |
| Hako, mục Sáng tác | Khó | ~470 truyện đã duyệt, ước ~10.000 chương | Bị chặn ở Việt Nam, nội dung chương bị mã hoá |
| Kênh Sinh Viên | Khó, giá trị thấp | 3.300 thread truyện dài | Mỗi chương một thread, lẫn truyện sưu tầm |
| Wattpad, Waka, NovelToon, Blogradio… | Không dùng được | | Bị chặn, cần đăng nhập, chỉ đọc trong app hoặc đã chết (mục 6) |

Cả TacGiaViet và rookies đều là nơi tác giả giữ bản quyền (rookies còn trả tiền cho tác giả), nên **cần xin phép trước khi nạp**.

## 2. Trang bị chặn ở Việt Nam

Nhiều trang bị nhà mạng chặn theo tên miền ngay lúc bắt tay TLS: kết nối bị reset (`curl: (35) Recv failure: Connection reset by peer`). Đã thử lấy IP đúng qua DNS `1.1.1.1` rồi gọi bằng `curl --resolve`, kết quả vẫn bị reset, nên **đổi DNS không qua được**. Server crawler đặt ở Việt Nam cũng sẽ gặp đúng lỗi này.

| Tình trạng | Tên miền |
| --- | --- |
| Bị reset (chặn) | `www.wattpad.com`, `api.wattpad.com`, `docln.net`, `ln.hako.vn`, `truyenyy.com`, `truyenyy.pro`, `gacsach.com`, `noveltoon.mobi`, `dtruyen.com`, `tangthuvien.net`, `sangtacviet.vip`, `vietwriter.com` |
| Hết thời gian chờ (server không phản hồi) | `truyen.tangthuvien.vn`, `vnfiction.com` |
| Không có DNS (đã chết) | `vietnovel.com`, `writerviet.com`, `writerviet.vn`, `bachngocsach.com.vn`, `bachngocsach.vip`, `truyenyy.vip`, `vietwriter.vn`, `enovel.vn` |
| Vào được | `tacgiaviet.com`, `rookies.vn`, `docln.sbs` (bản mirror của Hako), `kenhsinhvien.vn`, `sangtac.waka.vn`, `noveltoon.vn`, `blogradio.vn` |

Muốn lấy từ trang bị chặn thì phải đặt crawler ở nước ngoài. Ngoài chuyện kỹ thuật, đưa nội dung của trang đang bị chặn vào app Việt Nam cũng là rủi ro pháp lý.

## 3. TacGiaViet.com

Trang chỉ dành cho truyện sáng tác của **Bạch Ngọc Sách**, ra mắt khoảng 05/2026. Trang đọc truyện cũ của Bạch Ngọc Sách (`bachngocsach.cc`) đã đóng vì lý do bản quyền và chuyển link "Khu vực sáng tác" sang đây. Quy định của trang ([/quy-dinh](https://tacgiaviet.com/quy-dinh)): chỉ nhận truyện do tác giả tự viết, không đạo văn, mỗi chương ít nhất 1.000 chữ.

### 3.1. Truy cập

- Laravel chạy trên Apache, HTML render sẵn ở server, không có Cloudflare challenge.
- Không tìm thấy API hay RSS.
- `robots.txt` cho phép mọi trang truyện, chỉ chặn `/admin`, `/author`, `/tai-khoan`, `/tu-truyen`, `/thong-bao`, `/dang-nhap`, `/dang-ky`.

### 3.2. Quy mô và mức hoạt động

| Số liệu | Giá trị | Lấy từ |
| --- | ---: | --- |
| Truyện | ~567 | Trang `/truyen`: 48 trang, 12 truyện mỗi trang |
| Chương | 16.556 | `sitemap.xml`, thuộc 549 truyện |
| Chương mỗi truyện | Trung vị 12; 37 truyện trên 100 chương; dài nhất khoảng 600 | `sitemap.xml` |
| Chương có `lastmod` trong 30 ngày | 3.970 | `sitemap.xml` (gồm cả chương mới và chương bị sửa) |
| Chương mới trong 24 giờ | 110 chương, 44 truyện | Trang `/chuong-moi` |

Sitemap liệt kê mỗi truyện **2 lần** (984 dòng nhưng chỉ 500 truyện khác nhau) và thiếu khoảng 60 truyện có chương. Vì vậy đếm truyện theo trang `/truyen`, còn sitemap chỉ dùng để lấy chương và `lastmod`.

### 3.3. Cấu trúc URL

| Trang | URL |
| --- | --- |
| Danh sách truyện | `/truyen?page={n}` |
| Truyện | `/truyen/{slug}-{id 5 ký tự}`, ví dụ `/truyen/thuyen-linh-ago51` |
| Danh sách chương | Trên trang truyện, 20 chương mỗi trang: `?chapters_page={n}` |
| Chương | `/truyen/{slug truyện}/{slug chương}`, ví dụ `/truyen/thuyen-linh-ago51/chuong-1-hoi-tho-ngoai-nhan-gian` |
| Chương mới 24 giờ | `/chuong-moi?page={n}` |
| Sitemap | `/sitemap.xml`, một file, 18.559 URL, có `lastmod` |

### 3.4. Dữ liệu trong trang

**Trang truyện** có JSON-LD `@type: Book`:

```json
{
  "@type": "Book",
  "name": "Thuyền Linh",
  "description": "Một nghiên cứu sinh Việt Nam tình cờ trở thành chủ nhân…",
  "url": "https://tacgiaviet.com/truyen/thuyen-linh-ago51",
  "image": "https://tacgiaviet.com/storage/covers/….jpg",
  "author": { "@type": "Person", "name": "Thuyen Linh", "url": "https://tacgiaviet.com/tac-gia/thuyen-linh-n7m0j" },
  "genre": ["Tiên hiệp", "Huyền huyễn", "Hệ thống phụ trợ", "Tu luyện", "Bí pháp tu luyện"],
  "inLanguage": "vi",
  "datePublished": "2026-06-24T09:58:20+07:00",
  "dateModified": "2026-08-01T19:13:15+07:00"
}
```

Ngoài JSON-LD, HTML trang truyện còn có:
- tình trạng ("Đang ra");
- chương mới nhất kèm giờ đầy đủ (`27-09-2026 23:22:02`);
- số chương, lượt đọc, số chữ;
- tag (`#bí ẩn`…);
- danh sách chương `a.story-detail-chapter-row` gồm tên chương và `<time>` (chỉ có ngày `dd/mm/yyyy`).

Lỗi của trang: khoá `@context` trong JSON-LD bị thay bằng đoạn code Blade thô (`"<?php $__contextArgs = [];…"`). JSON vẫn hợp lệ nên vẫn parse được, chỉ không được dựa vào `@context`.

**Trang chương** có JSON-LD `@type: CreativeWork`, đủ để không phải đoán giờ như vnkings:

```json
{
  "@type": "CreativeWork",
  "name": "Chương 1: Hơi Thở Ngoài Nhân Gian",
  "isPartOf": { "@type": "Book", "name": "Thuyền Linh", "url": "https://tacgiaviet.com/truyen/thuyen-linh-ago51" },
  "position": 1,
  "datePublished": "2026-06-25T05:35:26+07:00",
  "dateModified": "2026-09-12T14:49:59+07:00"
}
```

Nội dung chương nằm trong HTML của trang. Nút chuyển chương là `chapter-nav-prev` / `chapter-nav-next`.

### 3.5. Chương thu phí

Tác giả có thể khoá chương, người đọc chuyển khoản 3.000đ mỗi chương để mở. Trang chương bị khoá có khối `paid-chapter-lock` ("Nội dung dành cho người ủng hộ") và **chỉ hiện đoạn trích**. Ví dụ: "Thuyền Linh" mở chương 1 nhưng khoá chương 350.

Crawler phải nhận ra `paid-chapter-lock` và không lưu đoạn trích như nội dung chương. Có 2 cách xử lý: bỏ hẳn chương đó, hoặc chỉ nạp tới chương cuối còn mở (giống cách xử lý chương khoá của Dembuon).

### 3.6. Theo dõi cập nhật

1. Mỗi lượt tải `sitemap.xml` (khoảng 4 MB, 1 request). Chương có `lastmod` mới hơn mốc lần trước là chương mới hoặc vừa sửa.
2. Chương chưa có trong DB thì tải trang chương. Chương đã có thì so `dateModified` để biết có cần tải lại nội dung không.
3. Truyện mới (có chương nhưng chưa có trong DB) thì tải trang truyện để lấy thông tin.
4. Muốn ít request hơn thì đọc `/chuong-moi`, vì trang này đã liệt kê chương mới trong 24 giờ. Nhưng cách này phải chạy ít nhất mỗi ngày một lần, nếu không sẽ sót.

Với khoảng 110 chương mỗi ngày, chạy mỗi giờ tốn khoảng 1 request sitemap cộng 5–10 request trang chương.

### 3.7. Map sang `stories`, `story_chapters`

| Cột | Lấy từ |
| --- | --- |
| `source`, `source_story_id` | `tacgiaviet`, ID 5 ký tự ở cuối slug truyện |
| `title`, `intro`, `cover_url` | JSON-LD `name`, `description`, `image` |
| `author_name`, `source_author_id` | JSON-LD `author.name`, ID ở cuối `author.url` |
| `genres` | JSON-LD `genre` (nhiều thể loại, giống vnkings) |
| `tags` | Khối Tag trong HTML |
| `status` | Nhãn tình trạng ở đầu trang truyện (mẫu đã gặp chỉ có "Đang ra"; trang có mục `/truyen-hoan-thanh`) |
| `published_at`, `source_updated_at` | JSON-LD `datePublished`, `dateModified` |
| `story_chapters.source_chapter_id` | ID số `data-chapter-id` trong trang chương (chương 1 của "Thuyền Linh" là `5170`; trang có nhiều `data-chapter-id` nên phải lấy đúng phần tử của chương đang đọc). Slug chương dùng dự phòng |
| `story_chapters.position`, `title`, `published_at` | JSON-LD chương `position`, `name`, `datePublished` |
| `story_chapters.content_text` | HTML trang chương, bỏ qua chương có `paid-chapter-lock` |
| `age_rating`, `kind` | Không có. `kind` tự suy theo số chương |

**Không lưu** khối "Ủng hộ tác giả": khối này hiện tên ngân hàng, số tài khoản và tên chủ tài khoản của tác giả.

## 4. rookies.vn

Nền tảng thương mại của Cross Media. Tác giả được trả tiền: chương VIP giá 30 "bánh phở" (đơn vị xu của trang), mỗi "bánh phở" quy ra 30đ cho tác giả.

### 4.1. Truy cập

- Laravel + Inertia.js (giao diện React). Có Cloudflare nhưng không gặp trang challenge trong lần kiểm tra; IP khác có thể khác.
- Giới hạn **80 request/phút** (header `x-ratelimit-limit: 80`).
- `robots.txt` chỉ chặn `/chatbox` và `/tim-kiem`.
- Gửi 3 header sau thì mọi trang trả JSON thay cho HTML:

```text
X-Inertia: true
X-Inertia-Version: ef9cb1965a6081ba22ebb2c5d67cfc33
X-Requested-With: XMLHttpRequest
```

`X-Inertia-Version` lấy từ thuộc tính `data-page` của HTML và đổi sau mỗi lần trang deploy. Crawler phải đọc lại giá trị này khi server trả `409`.

### 4.2. Dữ liệu

**Truyện** `GET /truyen/{slug}` → `props.novels.novels_detail`:

- thông tin: `id`, `title`, `short` (giới thiệu), `picture` (đường dẫn ảnh bìa tương đối), `user.username`, `user.full_name`;
- trạng thái: `is_complete`, `is_mature`, `is_vip`;
- thời gian: `created_at`, `updated_at`, `published_at`, `chapter_at`;
- thống kê: `novels_views_count`, `novels_like_count`, `novels_comment_count`;
- `novels_filter[]` gồm `{id, group_id}`:
  - nhóm 1 "Phân loại": Truyện sáng tác / Truyện dịch;
  - nhóm 2 "Hình thức": Fanfic, Truyện ngắn, Tiểu thuyết…;
  - các nhóm còn lại là thể loại và tag;
- `novels_chapters_count`, `novels_chapters_detail[]` gồm `{id, title, show_order, published_at, is_vip, price_coin_1, price_coin_2, is_preview}`.

**Chương** `GET /truyen/{slug}/{chapterId}` → `props.novels.chapter_detail`:
- `title[]`, `content` (HTML đã escape), `word_count`;
- `published_at`, `updated_at`;
- `is_vip`, `price_coin_1`, `price_coin_2`.

Giờ không thống nhất múi: cùng một truyện, `published_at` của truyện là `08:50:50` còn của chương 1 là `01:50:50`, lệch đúng 7 giờ. Cần kiểm tra thêm trước khi lưu.

### 4.3. Hai lỗi của trang cần tránh

- **Chương VIP vẫn trả đủ nội dung khi chưa mua.** Ví dụ chương VIP `41098` trả nguyên 23.705 ký tự mà không cần đăng nhập. Crawler phải **bỏ qua mọi chương có `is_vip = 1` hoặc giá > 0**: lấy những chương này là lấy nội dung trả phí của tác giả.
- **Object `user` lộ dữ liệu cá nhân**, gồm `email`, `phone`, `birthday`, `address`, `pass_reset`, `login_token`, `token_login`, `session`, số dư ví… Chỉ đọc `username` và `full_name`, không lưu và không log nguyên object `user`. Nên báo cho rookies nếu liên hệ xin phép.

### 4.4. Quy mô và mức hoạt động

| Số liệu | Giá trị | Lấy từ |
| --- | ---: | --- |
| Truyện miễn phí | 7.320 | `/truyen/mien-phi` (`total`, 10 truyện mỗi trang, 732 trang) |
| Truyện sáng tác / truyện dịch | 6.493 / 179 | `/the-loai/truyen-sang-tac`, `/the-loai/truyen-dich` |
| Truyện có chương trả phí | 62 | `/truyen/tra-phi` |
| Chương | Ước ~50.000 | Mẫu 15 truyện trung bình 7,3 chương |
| Truyện mới | ~750/tháng | ID truyện tăng ~1.430 từ 12/08 tới 07/10/2026 (gồm cả bản nháp) |
| Có chương mới trong 30 ngày | 1/15 truyện mẫu | |

Kho lớn nhưng phần lớn là truyện cũ, ít chương. Trang `/the-loai/truyen-sang-tac` nặng khoảng 7 MB mỗi trang, nên duyệt qua `/truyen/mien-phi` rồi lọc theo `novels_filter`.

### 4.5. Theo dõi cập nhật

Không có cách gọn:
- không có RSS;
- `lastmod` trong sitemap bị đổi mỗi khi có lượt xem (6.775/7.381 truyện có `lastmod` trong 30 ngày, kể cả truyện có chương cuối từ 2023);
- sắp xếp `orderby[published_at]` không trả đúng thứ tự cập nhật.

Cách làm được:
1. Lấy danh sách truyện từ sitemap (7.381 URL truyện; 212.753 URL còn lại là trang cá nhân người dùng).
2. Định kỳ quét lại từng truyện, so `chapter_at` và `novels_chapters_count`. Một vòng quét khoảng 7.400 request; với giới hạn 80 request/phút là khoảng 1,5 giờ.
3. Bổ sung các danh sách ở trang chủ (`novels_rising`, `novels_trending`, `list_novels_reading`) để bắt truyện đang hot nhanh hơn.

## 5. Nguồn khó

### 5.1. Hako, mục Sáng tác (OLN)

- **Truy cập:** `docln.net` và `ln.hako.vn` bị chặn; bản mirror `docln.sbs` vào được, cùng dữ liệu, có Cloudflare, giới hạn 60 request/phút.
- **Không có** sitemap, RSS hay API (`/sitemap.xml`, `/feed`, `/rss`, `/api/series` đều `404`).
- **Danh sách:** `/danh-sach?sangtac=1&sapxep=capnhat&page={n}`, 40 truyện mỗi trang.
- **Quy mô:** khoảng 470 truyện đã duyệt và khoảng 500 truyện chưa duyệt; ước khoảng 10.000 chương.
- **Mức hoạt động:** khoảng 40 truyện có chương mới trong tháng.
- **Nội dung chương bị mã hoá:** `<div id="chapter-c-protected" data-s="xor_shuffle" data-k="…" data-c="[…]">`, trình duyệt giải mã bằng `app.js`. Phải viết lại bộ giải mã, và đây là dấu hiệu rõ ràng trang không muốn bị lấy dữ liệu.
- **Kết luận:** chỉ nên làm nếu hợp tác được với Hako.

### 5.2. Kênh Sinh Viên

- **Truy cập:** XenForo 2, vào được.
- **Các mục truyện:** Truyện dài (`/f/truyen-dai.301/`, 3.300 thread, 55.600 post) và Truyện ngắn (`/f/truyen-ngan.297/`, 3.400 thread).
- **RSS:** `/f/{slug}.{id}/index.rss`, chỉ báo thread mới, 50 mục.
- **Không ghép được như Dembuon:** nội quy yêu cầu đăng mỗi chương là một trả lời trong thread truyện, nhưng tác giả hiện nay mở mỗi chương thành một thread riêng (ví dụ "Nguyên | Chương 74…"). Muốn ghép phải nhóm theo tiền tố tên thread và lọc theo độ dài post.
- **Mức hoạt động:** 50 thread mới ở Truyện dài trong khoảng 29/08–07/10/2026, nhưng chỉ từ 7 tác giả (một người chiếm 25 thread).
- **Nội dung lẫn lộn:** nội quy cho phép truyện "[Sưu tầm]"; mục Truyện ngắn có cả truyện dịch.

## 6. Nguồn không dùng được

| Nguồn | Lý do |
| --- | --- |
| Wattpad | Bị chặn ở Việt Nam từ 2019. Điều khoản cấm crawl ("Don't scrape Wattpad") và cấm dùng nội dung để cạnh tranh với Wattpad. Tác giả giữ bản quyền. Truyện tiếng Việt lẫn nhiều truyện dịch, "chuyển ver", fanfic. API v3 không chính thức thì có, nhưng không có tham số kiểu `modified_after` |
| Waka Sáng Tác (`sangtac.waka.vn`) | Có API (`beta-api.waka.vn`, 2.844 truyện, rất sôi động) nhưng **nội dung chương bắt buộc đăng nhập** ("Bạn cần đăng nhập để đọc chương này"). Waka ký hợp đồng độc quyền với tác giả |
| NovelToon (`noveltoon.vn`) | Web chỉ có tóm tắt, muốn đọc phải tải app (API có chữ ký, trả bằng xu) |
| Blogradio | Không có cấu trúc truyện–chương (truyện nhiều phần là các bài "Phần 1/2/cuối" rời nhau). Bài mới nhất từ 18/08/2026 |
| TruyenYY, Tàng Thư Viện, Gác Sách | Bị chặn hoặc không phản hồi. Chủ yếu là truyện dịch/convert, Gác Sách là trang tổng hợp |
| Mê Truyện Chữ (`metruyencv.com`) | Đóng cửa từ 10/02/2026 |
| enovel | `enovel.vn` không còn DNS; `enovel.mobi` bị chiếm làm trang chuyển hướng quảng cáo, không mở bằng trình duyệt |
| Vietnovel, Writerviet, vnfiction, Bạch Ngọc Sách (trang đọc cũ) | Đã chết hoặc đóng |
| Sàn Truyện, dtruyen.net, sangtacviet, medoctruyen | Trang chép truyện hoặc convert: `santruyen.com` chuyển hướng sang `truyenhoan.com`, `dtruyen.net` sang `wetruyen.com` |

## 7. Đề xuất

1. **Làm TacGiaViet trước:**
   - truyện đều là sáng tác;
   - khoảng 110 chương mới mỗi ngày;
   - JSON-LD có đủ thông tin truyện và giờ đăng chương chính xác;
   - sitemap đủ để đánh dấu và cập nhật;
   - không bị chặn.
2. **rookies.vn làm sau:**
   - kho lớn nhưng ít cập nhật;
   - phải quét định kỳ cả kho;
   - phải cẩn thận với chương VIP và dữ liệu người dùng (mục 4.3).

Việc cần làm trên server giống Dembuon:
- tách `Catalog` của crawler theo nguồn;
- dùng lại `ImportStory`;
- thêm `tacgiaviet` / `rookies` vào bộ lọc nguồn trong admin.
