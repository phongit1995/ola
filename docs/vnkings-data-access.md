# Vnkings: danh sách truyện, thể loại và nội dung chương

Ngày kiểm tra: **28/09/2026**, bổ sung ngày **01/10/2026** và **03/10/2026** (số lượng truyện, cách web sắp xếp, theo dõi chương mới). Website: [vnkings.com](https://vnkings.com/).

Tài liệu tổng hợp kết quả HTTP request, HTML/JavaScript công khai và lần tải trang bằng Chrome headless trong phiên khảo sát. Đây là mô tả hành vi quan sát được, không phải tài liệu API chính thức hoặc cam kết ổn định từ Vnkings. Các số lượng bên dưới là số tại thời điểm kiểm tra.

## 1. Kết quả chính

| Dữ liệu cần lấy | Cách lấy đã kiểm tra | Kết quả |
| --- | --- | --- |
| Danh sách post công khai | WordPress REST `/wp/v2/posts` | JSON, có phân trang |
| Nội dung một post | REST `/wp/v2/posts/{id}` | HTML ở `content.rendered` |
| Chuyên mục/thể loại | REST `/wp/v2/categories` | ID, tên, slug, parent, count |
| Tags | REST `/wp/v2/tags` | Có thể dùng ID tag để lọc post |
| Danh sách chương của truyện | POST `admin-ajax.php`, action `vnk_single_chapters` | JSON chứa HTML tên/link/ngày đăng chương, 10 chương mỗi trang |
| Nội dung chương công khai đã thử | GET URL chương | HTML có sẵn trong `#content.vnkings-editor` |
| URL post/chương công khai | Sitemap | XML chứa URL |
| Truyện mới cập nhật và số chương mới | REST lọc `modified_after` + AJAX trang chương cuối | Xem mục 9 |
| Lượt xem, số bình luận | HTML trang thể loại, trang chủ | Không có trong REST |
| RSS | `/feed` | Đã tắt: chuyển hướng sang google.com |

Luồng phù hợp với kết quả khảo sát:

```text
REST posts → URL trang truyện
           → đọc story ID và nonce từ HTML
           → AJAX danh sách chương
           → lấy link trong data.items
           → GET URL chương
           → tách #content.vnkings-editor
```

**Phân biệt post và chương:** nội dung REST của một post có thể chỉ là phần giới thiệu truyện. Không được coi `content.rendered` của post là toàn bộ nội dung các chương.

## 2. Base URL và User-Agent

Hai dạng URL đã trả JSON thành công:

```text
https://vnkings.com/api/wp/v2/posts/255240
https://vnkings.com/?rest_route=/wp/v2/posts/255240
```

Với dạng `?rest_route=...`, nối tham số bằng `&`. Với dạng `/api/...`, tham số đầu tiên bắt đầu bằng `?`.

Đường dẫn `/wp-json/` đã thử trả `200` nhưng body là HTML trang chủ. Vì vậy phải kiểm tra cả `Content-Type` và cấu trúc response, không chỉ HTTP status.

Trong các request đối chiếu, User-Agent `argent` và `Mozilla/5.0` trả cùng nội dung. `argent` không phải token xác thực và không mở thêm quyền. Tuy nhiên kết quả có thể khác giữa các HTTP client: một request bằng Python `urllib` mặc định trả `403`, trong khi Chrome và PowerShell tải được trang. Chưa kiểm chứng mọi thư viện/client.

## 3. Danh sách post và phân trang

Ví dụ lấy danh sách nhẹ, không tải nội dung:

```text
GET https://vnkings.com/?rest_route=/wp/v2/posts&per_page=100&page=1&_fields=id,link,title,slug,categories,tags
```

Kết quả đã quan sát:

- `per_page=100` trả 100 phần tử.
- Header `X-WP-Total`: `10351`.
- Header `X-WP-TotalPages`: `104`.
- Schema công khai quy định `per_page` tối đa 100; mặc định 10, `page` mặc định 1.

Để duyệt toàn bộ tập kết quả REST, đọc `X-WP-TotalPages` rồi tăng `page`. Nếu dữ liệu thay đổi trong lúc duyệt, cần khử trùng theo `id` và đối chiếu lại số lượng. Duyệt theo `orderby=id&order=asc` giúp thứ tự rõ ràng.

**10.351 là số post công khai API báo, chưa phải số truyện độc lập đã được phân loại.** Các chuyên mục có cả bảng tin và nội dung khác. Phiên khảo sát chưa tải đủ 104 trang để đối chiếu toàn bộ ID với sitemap.

### Số lượng truyện (01/10/2026)

Trên WordPress, mọi bài đăng đều là post: truyện, thơ, tản văn, nhật ký, bảng tin. Với truyện ngắn, post là trọn truyện; với truyện dài, post chỉ là trang giới thiệu. Chương là post type riêng (`tap-truyen`), không tính vào số post.

| | Số lượng | Cách đếm |
| --- | --- | --- |
| Tổng post | 10.359 | `X-WP-Total` của `/wp/v2/posts` |
| Post truyện, không đếm trùng | 4.500 | `/wp/v2/posts&categories=<danh sách ID chuyên mục truyện>`, đọc `X-WP-Total` |
| • Nhánh "Đọc Truyện" | 4.407 | Gồm Truyện Ngắn 1.902, Tình Cảm 701, Tiểu Thuyết 378, Viễn Tưởng – Kỳ Ảo 224… |
| • Truyện Audio / Truyện Dự Thi / Truyện Việt Ra Mắt Mới | 63 / 29 / 1 | |
| Post không phải truyện | khoảng 5.859 | Góc Thơ 2.297, Tản Văn 1.282, Nhật Ký Online 534, Giao Lưu – Kết Bạn 366, Hội Họa 336… |
| Truyện có ít nhất 1 chương | khoảng 2.818 | Tách slug truyện từ URL trong sitemap chương |
| Tổng số chương | 30.160 | Sitemap `tap-truyen` |

Danh sách ID chuyên mục truyện đã dùng: nhánh Đọc Truyện `1,3,126,137,21,132,319,131,5,127,258,110,2,112,2639,267,129,111,22008,130,1776`, Truyện Dự Thi `844,1549,1548,4037`, Truyện Việt Ra Mắt Mới `17770,17774,17826`, Truyện Audio `209`. Khi tham số `categories` có nhiều ID, REST trả post thuộc **bất kỳ** ID nào, nên `X-WP-Total` là số đã bỏ trùng.

Phân bố số chương của truyện dài: 1 chương 221 truyện (7,8%), 2–5 chương 1.303 (46,2%), 6–20 chương 972 (34,5%), 21–100 chương 303 (10,8%), trên 100 chương 19 (0,7%). Trung bình 10,6, trung vị 5. Truyện dài nhất là "Tân Phong Vân Anh Hùng Truyện" (521 chương). Có 412 URL chương không nằm dưới link truyện nào.

Số truyện dài (khoảng 2.818) cộng Truyện Ngắn (1.902) vượt 4.500 khoảng 220. Có thể một số bài Truyện Ngắn cũng được đăng thành chương; muốn xác nhận phải kiểm tra từng truyện qua AJAX.

## 4. Thể loại, tags và sắp xếp

Lấy danh mục:

```text
GET https://vnkings.com/?rest_route=/wp/v2/categories&per_page=100
GET https://vnkings.com/?rest_route=/wp/v2/tags&per_page=100&page=1
```

Các category đã xác nhận:

| ID | Tên | Slug |
| --- | --- | --- |
| 137 | Tiểu Thuyết | `tieu-thuyet` |
| 129 | 12 Chòm Sao | `12-chom-sao` |
| 112 | Dị Giới | `di-gioi` |

Lọc post thuộc Tiểu Thuyết và sắp mới nhất trước:

```text
GET https://vnkings.com/?rest_route=/wp/v2/posts&categories=137&orderby=date&order=desc&per_page=100&page=1
```

Request lọc `categories=129&per_page=5&orderby=date&order=desc` đã trả `200`, tổng 31 post, 7 trang.

| Tham số | Ý nghĩa |
| --- | --- |
| `categories=137` | Lọc theo ID chuyên mục |
| `tags=1660` | Lọc theo ID tag |
| `orderby=date` | Sắp theo ngày xuất bản; mặc định |
| `orderby=modified` | Sắp theo ngày sửa post |
| `orderby=title` | Sắp theo tiêu đề |
| `orderby=id` | Sắp theo ID |
| `order=asc` / `desc` | Tăng/giảm; mặc định `desc` |

Schema GET của `posts` công bố đầy đủ các giá trị `orderby`:

```text
author, date, id, include, modified, parent, relevance, slug, include_slugs, title
```

Các giá trị trên được đọc từ schema; chưa chạy thử từng cách sort. `categories`/`tags` dùng để lọc, không có `orderby=category` trong schema đã đọc. Chưa xác nhận sort theo lượt xem, lượt thích, độ hoàn thành hoặc thời gian ra chương mới. `modified` là ngày sửa post, không đủ bằng chứng để coi là ngày cập nhật chương mới nhất.

Post mẫu `255240` có:

- `categories: [137]` — Tiểu Thuyết.
- `tags: [36760, 1660, 4133, 1593]` — tag tên truyện và các tag chung `truyen viet`, `truyenviet`, `viết truyện`.
- Các nhãn như Dị giới, Xuyên không, Tái sinh trong phần giới thiệu là text trong nội dung; chúng không xuất hiện thành nhiều category/tag tương ứng ở post này.

Do đó không nên suy ra mọi thể loại tác giả viết trong phần giới thiệu đều lọc được qua taxonomy.

### Cách web sắp xếp (01/10/2026)

Trang thể loại, ví dụ [Tiểu Thuyết](https://vnkings.com/doc-truyen/tieu-thuyet), có 2 khối:

| Khối | Sắp theo | Hiển thị |
| --- | --- | --- |
| "Top Tiểu Thuyết" | Lượt xem giảm dần, 15 truyện | Tên, tác giả, lượt xem, số bình luận |
| "Bài mới Tiểu Thuyết" | Ngày sửa (`modified`) giảm dần, 20 truyện mỗi trang, phân trang `/page/2` | Tên, tác giả, **ngày đăng**, lượt xem, bình luận |

- 12 mục đầu của "Bài mới" khớp hoàn toàn với REST `categories=137&orderby=modified&order=desc`. Vì trang hiện ngày đăng nhưng lại sắp theo ngày sửa, nên nhìn danh sách sẽ thấy ngày không theo thứ tự. Ví dụ "Là duyên cũng là mệnh" đăng 06/02/2024 nhưng đứng thứ 4 vì vừa sửa ngày 29/09/2026.
- Trang chủ có khối "Top View Tuần" và danh sách bài mới gộp mọi chuyên mục, kể cả thơ và tản văn.
- Lượt xem và số bình luận **không có trong REST**, chỉ đọc được từ HTML. Muốn sắp theo lượt xem phải đọc HTML trang thể loại hoặc trang chủ.
- Tên truyện trên trang có thể khác slug: tiêu đề "Định mệnh mang tên “oan gia”" là post `tiem-tra-va-ki-uc` (đổi tên nhưng giữ slug). Đối chiếu bằng ID hoặc link, không bằng tên.

## 5. Lấy nội dung post bằng REST

Endpoint đã kiểm tra:

```text
GET https://vnkings.com/api/wp/v2/posts/255240?_fields=id,title,content,excerpt,link
```

Response có `content.rendered`, `content.protected` và `excerpt.rendered`. Post mẫu trả `200`, phần `content.rendered` dài 1.433 ký tự HTML, là phần giới thiệu truyện.

Ví dụ JavaScript chạy phía server:

```js
const response = await fetch(
  "https://vnkings.com/api/wp/v2/posts/255240?_fields=id,title,content,link"
);
if (!response.ok) throw new Error(`HTTP ${response.status}`);
const post = await response.json();
const html = post.content.rendered;
```

Nếu dùng `_fields` để giới hạn dữ liệu, phải có `content` nếu muốn nhận nội dung. Ví dụ chỉ lấy `id,link,title,slug` sẽ không trả content.

Chưa kiểm tra CORS cho ứng dụng chạy từ domain khác. Ví dụ trên không khẳng định trình duyệt của ứng dụng có thể fetch trực tiếp. Khi hiển thị HTML lấy từ nguồn ngoài trong ứng dụng, cần xử lý HTML theo cơ chế an toàn của ứng dụng.

## 6. AJAX lấy danh sách chương

JavaScript công khai trên trang truyện dùng request:

```http
POST /wp-admin/admin-ajax.php HTTP/1.1
Host: vnkings.com
Content-Type: application/x-www-form-urlencoded

action=vnk_single_chapters&story_id=255240&page=1&chapter_nonce=<nonce-trong-html>
```

Trên trang truyện mẫu, phần tử chứa `data-story-id="255240"` có thuộc tính `data-nonce`. JavaScript đọc các thuộc tính này để gọi request. Trên trang chương đã xem, cấu hình `chapterPicker` chứa `storyId`, `currentId`, `chapterNonce`.

Nonce cần lấy từ HTML của trang đang truy cập, không hardcode hoặc xem là token mở quyền truy cập.

Với khách chưa đăng nhập, mọi trang truyện trả **cùng một nonce**, nên lấy từ một trang truyện bất kỳ là gọi được cho mọi `story_id`. Nonce đổi theo thời gian: ngày 01/10 là `260446f3b9`, ngày 03/10 là `ebbc4c4173`. Mỗi lần quét phải đọc lại nonce từ HTML.

Request với truyện `255240`, trang 1 đã trả thành công, gồm 2 chương. Cấu trúc rút gọn:

```json
{
  "success": true,
  "data": {
    "items": "<div class=\"vnk_list_chapter\">...<a href=\"URL_CHUONG\">Tên chương</a>...</div>",
    "pagination": "",
    "page": 1,
    "totalPages": 1
  }
}
```

`data.items` là **HTML danh sách**, không phải mảng chương JSON và không chứa toàn bộ nội dung chương. Có thể parse `.vnk_list_chapter a[href]` để lấy tên/link. `data.pagination` chứa HTML điều hướng khi có; dùng `page` và `totalPages` để duyệt.

Mỗi chương trong `data.items` có dạng:

```html
<div class="vnk_list_chapter">
  <h3 class="title_chapter">
    <a href="https://vnkings.com/the-great-uprising-dai-khoi-nghia/phan-1-chuong-1-p255139.html">Phần 1: Chương 1</a>
    <i class="pull-right">30/09/2026 lúc 1:41</i>
  </h3>
</div>
```

- `<i class="pull-right">` là **ngày giờ đăng chương**. Giờ hiện kiểu 12 tiếng nhưng không có SA/CH (23:18 hiện thành "11:18"), nên chỉ tin được phần ngày.
- ID chương là số sau `-p` trong URL (`p255139` → `255139`). ID tăng dần theo thời gian đăng.
- Chương xếp theo thứ tự đọc, **10 chương mỗi trang**. Số chương của truyện = `(totalPages - 1) × 10 + số chương ở trang cuối`, nên chỉ cần 2 request (trang 1 và trang cuối). Đã kiểm tra trên "Tân Phong Vân Anh Hùng Truyện" (`story_id=2467`): `totalPages=53`, trang cuối có 1 chương, ra 521 chương.
- Truyện không tồn tại hoặc chưa xuất bản trả `{"success": false, "data": {"message": "Truyện không tồn tại hoặc chưa được xuất bản."}}`.

Một truyện cũ với `story_id=189` trả `404` và thông báo truyện không tồn tại hoặc chưa được xuất bản, dù một URL chương cũ vẫn tải được HTML. Vì vậy cần xử lý lỗi từng truyện; không khẳng định mọi URL trong sitemap đều có truyện cha còn hoạt động.

**Đính chính kết luận ban đầu của phiên khảo sát:** không thấy REST route cho `tap-truyen` không có nghĩa là không có API danh sách chương. AJAX `vnk_single_chapters` đã được tìm thấy và gọi thành công.

## 7. Lấy nội dung chương từ HTML

Trang chương đã kiểm tra bằng Chrome headless:

[Chương 1 của truyện mẫu, ID 255242](https://vnkings.com/hanh-trinh-so-khong-bat-dau-cuoc-song-o-the-gioi-moi-phan-1-khoi-dau-o-the-gioi-moi/chuong-1-toi-da-den-mot-the-gioi-khac-p255242.html).

Kết quả:

- Chrome tải trang thành công; DOM có nội dung trong `#content`.
- Bộ tách text thử nghiệm thu được khoảng 12.266 ký tự trong vùng nội dung, chưa chuẩn hóa text.
- Log mạng ghi nhận 27 URL cùng site; không có request `/api/`, `wp-json`, `rest_route` hoặc `admin-ajax.php` trong lần tải trang đầu tiên này.
- GET bằng PowerShell cũng thấy `<div class="vnkings-editor" id="content">` trong response HTML.

Như vậy với chương mẫu, nội dung được server trả ngay trong HTML. Không cần một request JSON riêng để lấy nội dung. Kết quả này chỉ mô tả lần tải trang đã thử, không phủ nhận có request khác sau tương tác hoặc trên các loại chương khác.

Selector:

```css
#content.vnkings-editor
```

Ví dụ Python minh họa; cần cài `requests` và `beautifulsoup4`. Đây là đoạn hướng dẫn, chưa được chạy nguyên khối trong phiên khảo sát:

```python
import requests
from bs4 import BeautifulSoup

def get_chapter_content(chapter_url):
    response = requests.get(
        chapter_url,
        headers={"User-Agent": "Mozilla/5.0"},
        timeout=30,
    )
    response.raise_for_status()
    soup = BeautifulSoup(response.content, "html.parser")
    content = soup.select_one("#content.vnkings-editor")
    if content is None:
        raise ValueError("Không thấy vùng nội dung chương; cần kiểm tra response")
    return {
        "html": content.decode_contents(),
        "text": content.get_text("\n", strip=True),
    }
```

Selector có thể chứa thành phần trang trí; kiểm tra và loại bỏ thành phần không phải nội dung nếu cần text sạch. Với chương có yêu cầu đăng nhập/mua quyền đọc, phải kiểm tra trang thực tế và quyền truy cập; không coi việc tìm thấy selector là bằng chứng đã nhận toàn bộ chương.

REST `/wp/v2/tap-truyen` đã trả `404 rest_no_route`. Thử ID chương cũ `230` qua `/wp/v2/posts/230` trả `404 rest_post_invalid_id`; lọc `posts&include=230` trả mảng rỗng. Chưa tìm thấy REST JSON công khai trả nội dung post type chương.

## 8. Sitemap và phạm vi danh sách

Index: [wp-sitemap.xml](https://vnkings.com/wp-sitemap.xml).

| Nhóm sitemap | Số file đã kiểm tra | Tổng URL đếm được |
| --- | --- | --- |
| `wp-sitemap-posts-post-{n}.xml` | 6 | 10.351 |
| `wp-sitemap-posts-tap-truyen-{n}.xml` | 16 | 30.118 |

Ví dụ:

- [Sitemap post, trang 1](https://vnkings.com/wp-sitemap-posts-post-1.xml).
- [Sitemap chương, trang 1](https://vnkings.com/wp-sitemap-posts-tap-truyen-1.xml).

Sitemap cung cấp URL, không phải nội dung chương hay bảo đảm tất cả URL vẫn truy cập được. Số 30.118 là số URL chương/tập đếm được, không phải số truyện độc lập. Nên đọc sitemap index để lấy danh sách file hiện tại thay vì cố định 6 hoặc 16 file.

## 9. Theo dõi truyện mới cập nhật và số chương mới

Kiểm tra ngày 03/10/2026. Không có RSS để dùng (`/feed` chuyển hướng sang google.com), nhưng làm được bằng REST và AJAX.

**Cơ sở:** khi tác giả thêm chương, `modified` của post truyện được đặt đúng bằng giờ đăng chương mới nhất.

| Truyện | `modified` của post | Chương mới nhất trong AJAX |
| --- | --- | --- |
| `255129` The Great Uprising | 2026-10-03 02:52:53 | "Phần 1: Chương 2.2", 03/10/2026 lúc 2:52 |
| `255240` Hành Trình: Số Không | 2026-10-01 23:18:15 | "Chương 6", 01/10/2026 lúc 11:18 |

Ngày 01/10, `modified` của `255129` là 2026-10-01 02:24:14, đúng giờ đăng "Chương 2.1". Sau khi có "Chương 2.2" thì nhảy sang 03/10.

**Cách quét:**

1. Lấy truyện có sửa đổi từ lần quét trước, lùi thêm khoảng 1 giờ cho chắc, vì ngày giờ REST là giờ của site:

   ```text
   GET https://vnkings.com/?rest_route=/wp/v2/posts&categories=<ID chuyên mục truyện>&modified_after=2026-09-26T00:00:00&orderby=modified&order=desc&per_page=100&_fields=id,slug,date,modified
   ```

   `modified_after` hoạt động: từ 26/09 trả 21 truyện, từ 02/10 trả 5 truyện. Nhiều hơn 100 truyện thì duyệt tiếp theo `page`.
2. Lấy nonce mới từ HTML một trang truyện bất kỳ (mục 6).
3. Với mỗi truyện, gọi `vnk_single_chapters` ở **trang cuối**, đọc lùi về trang trước cho tới khi gặp chương đã biết. Chương mới luôn nằm cuối danh sách.
4. Chương mới là chương có ID lớn hơn ID chương lớn nhất đã lưu của truyện đó. So theo ID thay vì theo giờ, vì giờ hiển thị không có SA/CH.

**Kết quả thử 7 ngày (26/09 – 03/10/2026):** 21 truyện có `modified` mới, 19 truyện có chương mới, tổng 72 chương mới. Cả lần thử tốn khoảng 25 request. Nhiều nhất là "Nhân Tâm Sở Hướng" (11 chương), "Trầm niên đổi lấy mật đường" (8), rồi một số truyện 6 chương.

**Giới hạn:**

- `modified` cũng đổi khi chỉ sửa giới thiệu hoặc nội dung. Ví dụ "Thân phận thật sự của tôi" có `modified` 03/10 nhưng không có chương mới trong 7 ngày. Vì vậy phải đếm chương ở bước 3 mới biết có chương mới thật hay không.
- Post truyện mới đăng nhưng chưa có chương vẫn xuất hiện ở bước 1, với 0 chương.
- Cách này không phát hiện chương bị sửa nội dung hoặc bị xoá. Muốn biết thì định kỳ so lại tổng số chương (`totalPages` và trang cuối) với số đã lưu.

## 10. Phạm vi kiểm chứng và lưu ý triển khai

- Chỉ kiểm tra một số post/chương mẫu và metadata phân trang; chưa tải toàn bộ nội dung website.
- REST lấy post và AJAX danh sách chương mẫu không cần đăng nhập. Các endpoint `/wp/v2/settings`, `/wp/v2/users/me` đã trả `401` khi chưa xác thực.
- Không có bằng chứng User-Agent giúp vượt quyền. Không tiếp tục tự động khi gặp trang chặn, yêu cầu đăng nhập hoặc nội dung cần quyền đọc.
- Khi duyệt nhiều trang, dùng timeout, giới hạn tốc độ, cache kết quả và xử lý lỗi; tránh retry liên tục khi bị từ chối.
- Kiểm tra điều khoản và [robots.txt](https://vnkings.com/robots.txt) theo mục đích sử dụng. Website có thông báo không đăng tải lại nội dung; truy cập được bằng HTTP không đồng nghĩa được phép sao chép hoặc tái xuất bản.
- Không lưu nonce cố định, cookie hoặc log trình duyệt chứa thông tin phiên vào mã nguồn.

Tài liệu này tổng hợp khả năng truy cập dữ liệu đã quan sát. Nó không triển khai crawler hay tích hợp Vnkings vào ứng dụng Ola.
