# Vnkings: thiết kế database lưu truyện

Thiết kế 2 bảng để lưu truyện và chương lấy từ [vnkings.com](https://vnkings.com/). Cách lấy dữ liệu xem ở [vnkings-data-access.md](../vnkings-data-access.md).

## 1. Quy mô dữ liệu

Số liệu khảo sát ngày 01/10/2026:

| | Số lượng |
| --- | --- |
| Tổng post trên web (cả thơ, tản văn, nhật ký, bảng tin…) | 10.359 |
| Post truyện (thuộc các chuyên mục truyện, không đếm trùng) | 4.500 |
| • Truyện Ngắn (1 post là trọn truyện) | 1.902 |
| • Truyện dài (có ít nhất 1 chương, theo sitemap) | khoảng 2.818 |
| Chương của truyện dài | 30.160 |

Trên WordPress, mỗi truyện là một **post**: với truyện ngắn post là toàn bộ truyện, với truyện dài post chỉ là trang giới thiệu. Chương là post type riêng (`tap-truyen`), không tính vào số post.

## 2. Một truyện có những thông tin gì

| Thông tin | Lấy từ đâu | Đã kiểm tra |
| --- | --- | --- |
| ID gốc, slug, link | REST `posts`: `id`, `slug`, `link` | ✓ |
| Tiêu đề | REST `title.rendered` | ✓ |
| Giới thiệu (HTML), tóm tắt | REST `content.rendered`, `excerpt.rendered` | ✓ |
| Thể loại, tags | REST `categories`, `tags` (ID, tra tên qua `/wp/v2/categories`, `/wp/v2/tags`) | ✓ |
| Ngày đăng, ngày sửa | REST `date`, `modified` | ✓ |
| Tên tác giả | HTML trang danh sách | ✓ |
| ID tác giả, ảnh bìa | REST `author`, `featured_media` (field chuẩn của WordPress) | chưa thử |
| Lượt xem, số bình luận | Chỉ có trong HTML (trang thể loại, trang chủ) | ✓ |
| Danh sách chương và thứ tự | AJAX `vnk_single_chapters`, 10 chương mỗi trang | ✓ |
| Nội dung chương | HTML `#content.vnkings-editor` của trang chương | ✓ |
| Trạng thái hoàn thành | Chưa thấy nguồn nào | ✗ |

`date`, `modified` là giờ của site. Khi lưu vào `timestamptz` nên dùng `date_gmt`, `modified_gmt` (field chuẩn của WordPress) để khỏi lệch múi giờ.

## 3. Schema

```sql
CREATE TABLE stories (
  id bigserial PRIMARY KEY,
  source varchar(30) NOT NULL DEFAULT 'vnkings',
  source_story_id bigint NOT NULL,
  slug varchar(255) NOT NULL,
  source_url text NOT NULL,
  title varchar(500) NOT NULL,
  author_name varchar(200),
  source_author_id bigint,
  kind varchar(10) NOT NULL,
  genres text[] NOT NULL DEFAULT '{}',
  tags text[] NOT NULL DEFAULT '{}',
  intro_html text,
  cover_url text,
  status varchar(20) NOT NULL DEFAULT 'unknown',
  chapter_count int NOT NULL DEFAULT 0,
  word_count int NOT NULL DEFAULT 0,
  view_count bigint NOT NULL DEFAULT 0,
  comment_count int NOT NULL DEFAULT 0,
  published_at timestamptz,
  source_updated_at timestamptz,
  last_chapter_at timestamptz,
  crawled_at timestamptz,
  content_hash bytea,
  is_hidden boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (source, source_story_id)
);
CREATE INDEX idx_stories_updated ON stories (source_updated_at DESC) WHERE NOT is_hidden;
CREATE INDEX idx_stories_views ON stories (view_count DESC) WHERE NOT is_hidden;
CREATE INDEX idx_stories_genres ON stories USING gin (genres);
CREATE INDEX idx_stories_title_trgm ON stories USING gin (title gin_trgm_ops);

CREATE TABLE story_chapters (
  id bigserial PRIMARY KEY,
  story_id bigint NOT NULL REFERENCES stories(id) ON DELETE CASCADE,
  source_chapter_id bigint NOT NULL,
  position int NOT NULL,
  title varchar(500) NOT NULL,
  source_url text NOT NULL,
  content_html text,
  content_text text,
  word_count int NOT NULL DEFAULT 0,
  published_at timestamptz,
  crawled_at timestamptz,
  content_hash bytea,
  UNIQUE (story_id, source_chapter_id),
  UNIQUE (story_id, position) DEFERRABLE INITIALLY DEFERRED
);
```

Index `gin_trgm_ops` cần extension `pg_trgm` (`CREATE EXTENSION IF NOT EXISTS pg_trgm;`).

## 4. Ý nghĩa các cột

### `stories`

| Cột | Ý nghĩa | Nguồn |
| --- | --- | --- |
| `source`, `source_story_id` | Nguồn và ID post gốc. Cặp này là khoá duy nhất, cập nhật lại bằng upsert | REST `id` |
| `slug`, `source_url` | Slug và link trang truyện | REST `slug`, `link` |
| `title` | Tiêu đề (giải mã HTML entity trước khi lưu) | REST `title.rendered` |
| `author_name`, `source_author_id` | Tên và ID tác giả | HTML / REST `author` |
| `kind` | `short`: truyện ngắn, nội dung nằm trong post. `long`: truyện có chương | Chuyên mục Truyện Ngắn hoặc AJAX có chương |
| `genres` | Tên chuyên mục, ghi kèm cả chuyên mục cha (ví dụ `{Đọc Truyện, Tiểu Thuyết}`) | REST `categories` |
| `tags` | Tên tag | REST `tags` |
| `intro_html` | Phần giới thiệu của truyện dài | REST `content.rendered` |
| `cover_url` | Ảnh bìa | REST `featured_media` hoặc HTML |
| `status` | `ongoing` / `completed` / `unknown`. Nguồn chưa có thông tin này nên mặc định `unknown` | — |
| `chapter_count`, `word_count` | Tính sẵn khi lưu chương, để trang danh sách khỏi phải đếm | Tự tính |
| `view_count`, `comment_count` | Lượt xem, số bình luận | HTML |
| `published_at`, `source_updated_at` | Ngày đăng, ngày sửa gần nhất trên nguồn | REST `date_gmt`, `modified_gmt` |
| `last_chapter_at` | Thời điểm của chương mới nhất | Tự tính |
| `crawled_at`, `content_hash` | Lần lấy gần nhất và hash nội dung. Hash không đổi thì không ghi lại | Tự tính |
| `is_hidden` | Ẩn truyện (bị gỡ, chưa xin phép, truyện tạm…) | Tự quản |

### `story_chapters`

| Cột | Ý nghĩa | Nguồn |
| --- | --- | --- |
| `story_id` | Truyện chứa chương | — |
| `source_chapter_id` | ID chương gốc, là số sau `-p` trong URL (ví dụ `…-p255242.html` → `255242`) | URL chương |
| `position` | Thứ tự chương, bắt đầu từ 1 | Vị trí trong danh sách AJAX |
| `title`, `source_url` | Tên và link chương | Thẻ `<a>` trong `data.items` của AJAX |
| `content_html`, `content_text` | Nội dung chương: HTML gốc và text đã làm sạch | HTML `#content.vnkings-editor` |
| `word_count` | Số chữ | Tự tính |
| `published_at` | Ngày đăng chương. Chưa xác định nguồn; có thể để trống | — |
| `crawled_at`, `content_hash` | Như bên `stories` | Tự tính |

## 5. Cách dùng

- **Truyện ngắn** lưu với `kind = 'short'` và đúng 1 dòng chương (`position = 1`) chứa nội dung post. Nhờ vậy phần đọc truyện chỉ có một cách xử lý cho cả truyện ngắn lẫn truyện dài.
- **Lọc theo thể loại:** `WHERE genres @> ARRAY['Tiểu Thuyết']` (dùng index GIN).
- **Sắp xếp giống Vnkings:**
  - "Bài mới" của mỗi thể loại: `ORDER BY source_updated_at DESC`. Web sắp theo ngày sửa (`modified`) nhưng hiển thị ngày đăng.
  - "Top" (theo lượt xem): `ORDER BY view_count DESC`.
- **Danh sách chương:** `SELECT id, position, title FROM story_chapters WHERE story_id = $1 ORDER BY position`. Postgres cất text dài ở vùng riêng (TOAST) và chỉ đọc khi câu `SELECT` có cột `content_*`, nên để nội dung chung bảng không làm chậm danh sách chương.
- **Đổi thứ tự chương:** ràng buộc `UNIQUE (story_id, position)` là `DEFERRABLE`, nên khi web chèn hoặc đổi thứ tự chương có thể cập nhật lại cả loạt `position` trong một transaction mà không bị báo trùng giữa chừng.
- **Chương không có truyện cha:** có 412 URL chương không nằm dưới link truyện nào. Bỏ qua, hoặc gắn vào một truyện tạm có `is_hidden = true`.

## 6. Đồng bộ truyện mới cập nhật

Cách lấy truyện và chương mới xem mục 9 của [vnkings-data-access.md](../vnkings-data-access.md). Khi ghi vào 2 bảng trên:

1. Lấy mốc quét lần trước, ví dụ `max(source_updated_at)` của `stories` hoặc thời điểm lần quét trước. Gọi REST với `modified_after` = mốc đó lùi khoảng 1 giờ.
2. Upsert từng truyện trả về theo `(source, source_story_id)`: cập nhật `title`, `genres`, `tags`, `source_updated_at`…, và đặt `crawled_at = now()`.
3. Lấy ID chương lớn nhất đã lưu của truyện:

   ```sql
   SELECT coalesce(max(source_chapter_id), 0) FROM story_chapters WHERE story_id = $1;
   ```

4. Đọc danh sách chương qua AJAX từ trang cuối lùi về, cho tới khi gặp chương có ID nhỏ hơn hoặc bằng số trên. Mỗi chương có ID lớn hơn là chương mới: insert vào `story_chapters` với `position` nối tiếp, rồi lấy nội dung từ HTML trang chương.
5. Cập nhật lại `stories.chapter_count`, `word_count`, `last_chapter_at` theo các chương vừa thêm.
6. Định kỳ (ví dụ mỗi tuần) so `chapter_count` với số chương tính từ AJAX (`(totalPages - 1) × 10 + số chương ở trang cuối`). Lệch thì quét lại toàn bộ danh sách chương của truyện đó, để bắt được chương bị xoá hoặc chèn giữa.

`source_updated_at` đổi cả khi tác giả chỉ sửa giới thiệu, nên truyện có `source_updated_at` mới chưa chắc có chương mới. Muốn hiện danh sách "truyện có chương mới" thì sắp theo `last_chapter_at` thay vì `source_updated_at`.

## 7. Giới hạn của thiết kế 2 bảng

| Không có | Ảnh hưởng | Cách bù nếu cần |
| --- | --- | --- |
| Bảng tác giả riêng | Không làm được trang tác giả có ảnh, mô tả. Tác giả đổi tên phải sửa nhiều dòng | Lọc theo `source_author_id` vẫn được |
| Cây thể loại cha–con | Không biết thể loại nào thuộc nhóm nào | Ghi cả tên thể loại cha vào `genres` lúc lưu |
| Lượt xem theo ngày | Không tính được "Top view tuần" | Thêm cột `week_view_base`, `week_base_at`. Đầu mỗi tuần chép `view_count` sang `week_view_base`; lượt xem tuần = `view_count - week_view_base` |
| Khoá ngoại cho nguồn | `source` chỉ là chuỗi | Đủ dùng khi chỉ có một hai nguồn |

Khi cần trang tác giả, lọc theo cây thể loại hoặc thống kê lượt xem theo ngày thì tách thêm bảng `story_authors`, `story_categories` và `story_stat_snapshots`.

## 8. Dung lượng ước tính

- Chương mẫu dài khoảng 12 nghìn ký tự. Với 30.160 chương, phần text vào khoảng 0,4–0,5 GB; lưu cả HTML thì khoảng gấp đôi.
- Postgres tự nén text dài (TOAST), nên dung lượng thực tế còn khoảng vài trăm MB.
- Metadata của 4.500 truyện chỉ vài MB.

## 9. Lưu ý bản quyền

Vnkings ghi rõ không cho đăng tải lại nội dung. Truy cập được bằng HTTP không có nghĩa là được phép sao chép hay hiển thị lại. Trước khi lưu và hiển thị nội dung cần xin phép, và luôn giữ `source_url` cùng tên tác giả để ghi nguồn.
