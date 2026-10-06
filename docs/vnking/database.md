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
| Tên tác giả | HTML trang truyện (`Tác giả`) | ✓ |
| ID tác giả | REST `author` | ✓ |
| Ảnh bìa | HTML trang truyện (`img.lazyload[data-original]`, không có thì `og:image`) | ✓ |
| Lượt thích, độ tuổi | HTML trang truyện (`Lượt thích`, `Rating`) | ✓ |
| Lượt xem, bình luận | Không lấy từ nguồn, bắt đầu từ 0 | — |
| Danh sách chương và thứ tự | AJAX `vnk_single_chapters`, 10 chương mỗi trang | ✓ |
| Nội dung chương | HTML `#content.vnkings-editor` của trang chương | ✓ |
| Trạng thái hoàn thành | HTML trang truyện (`Tình trạng`: "Chưa hoàn thành" / "Hoàn thành") | ✓ |

`date`, `modified` là giờ của site. Khi lưu vào `timestamptz` nên dùng `date_gmt`, `modified_gmt` (field chuẩn của WordPress) để khỏi lệch múi giờ.

## 3. Schema

Migration: [`server/cmd/migrations/postgres/20261005000001_create_stories.up.sql`](../../server/cmd/migrations/postgres/20261005000001_create_stories.up.sql). Bản rút gọn:

```sql
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS unaccent;

CREATE TABLE stories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  source varchar(30) NOT NULL DEFAULT 'vnkings',
  source_story_id varchar(100) NOT NULL,
  slug varchar(255) NOT NULL,
  source_url text NOT NULL,
  title varchar(500) NOT NULL,
  author_name varchar(200) NOT NULL DEFAULT '',
  source_author_id varchar(100),
  kind varchar(10) NOT NULL,                       -- short | long
  genres text[] NOT NULL DEFAULT '{}',
  tags text[] NOT NULL DEFAULT '{}',
  intro text NOT NULL DEFAULT '',
  cover_url text,
  status varchar(20) NOT NULL DEFAULT 'unknown',   -- ongoing | completed | unknown
  age_rating varchar(100) NOT NULL DEFAULT '',
  chapter_count int NOT NULL DEFAULT 0,
  word_count int NOT NULL DEFAULT 0,
  view_count bigint NOT NULL DEFAULT 0,
  comment_count int NOT NULL DEFAULT 0,
  like_count int NOT NULL DEFAULT 0,
  published_at timestamptz NOT NULL,
  source_updated_at timestamptz NOT NULL,
  last_chapter_at timestamptz,
  crawled_at timestamptz,
  content_hash bytea,
  search_text text NOT NULL DEFAULT '',            -- trigger tự điền
  is_hidden boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (source, source_story_id)
);
CREATE INDEX idx_stories_activity ON stories ((COALESCE(last_chapter_at, source_updated_at)) DESC, id DESC) WHERE NOT is_hidden;
CREATE INDEX idx_stories_views ON stories (view_count DESC, (COALESCE(last_chapter_at, source_updated_at)) DESC, id DESC) WHERE NOT is_hidden;
CREATE INDEX idx_stories_published ON stories (published_at DESC, id DESC) WHERE NOT is_hidden;
CREATE INDEX idx_stories_genres ON stories USING gin (genres);
CREATE INDEX idx_stories_search_text ON stories USING gin (search_text gin_trgm_ops);

CREATE TABLE story_chapters (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id uuid NOT NULL REFERENCES stories(id) ON DELETE CASCADE,
  source_chapter_id varchar(100) NOT NULL,
  position int NOT NULL,
  title varchar(500) NOT NULL,
  source_url text NOT NULL,
  content_text text NOT NULL DEFAULT '',
  word_count int NOT NULL DEFAULT 0,
  published_at timestamptz,
  crawled_at timestamptz,
  content_hash bytea,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (story_id, source_chapter_id),
  UNIQUE (story_id, position) DEFERRABLE INITIALLY DEFERRED
);
```

Trigger `stories_search_text` (chạy khi thêm truyện hoặc sửa `title`, `author_name`) ghi `search_text = lower(unaccent(title || ' ' || author_name))`, ví dụ "Định mệnh mang tên “oan gia”" của "Miêu Dạ Mạn" thành `dinh menh mang ten "oan gia" mieu da man`. Hai extension `pg_trgm`, `unaccent` có sẵn trong image `postgres:15-alpine` đang dùng ở cả local lẫn prod.

So với bản thiết kế đầu:
- Chỉ lưu text đã làm sạch (`intro`, `content_text`), không lưu HTML gốc. Script xuất đã tách đoạn sẵn, các đoạn cách nhau bằng một dòng trống.
- Thêm `age_rating`, `like_count` (trang truyện có, UI có hiện) và `search_text` để tìm không dấu.
- `published_at`, `source_updated_at` của truyện là `NOT NULL` vì REST luôn trả `date_gmt`, `modified_gmt`. Nhờ vậy sắp xếp không phải xử lý `NULL`.

## 4. Ý nghĩa các cột

### `stories`

| Cột | Ý nghĩa | Nguồn |
| --- | --- | --- |
| `id` | Khoá chính UUID (`gen_random_uuid()`) như các bảng khác; API và app chỉ dùng ID này | Tự sinh |
| `source`, `source_story_id` | Nguồn và ID truyện gốc. Lưu dạng chữ (`varchar`) vì mỗi nguồn có kiểu ID khác nhau (Vnkings là số). Cặp này là khoá duy nhất, cập nhật lại bằng upsert | REST `id` |
| `slug`, `source_url` | Slug và link trang truyện | REST `slug`, `link` |
| `title` | Tiêu đề (đã giải mã HTML entity) | REST `title.rendered` |
| `author_name`, `source_author_id` | Tên và ID tác giả | HTML / REST `author` |
| `kind` | `short`: truyện ngắn, nội dung nằm trong post. `long`: truyện có chương | Chuyên mục Truyện Ngắn hoặc AJAX có chương |
| `genres` | Tên chuyên mục, bỏ "Đọc Truyện" (chuyên mục gốc) | REST `categories` |
| `tags` | Tên tag | REST `tags` |
| `intro` | Giới thiệu: nội dung post của truyện dài, tóm tắt (`excerpt`) của truyện ngắn | REST `content.rendered` / `excerpt.rendered` |
| `cover_url` | Ảnh bìa | HTML |
| `status` | `ongoing` / `completed` / `unknown` | HTML `Tình trạng` |
| `age_rating` | Nhãn độ tuổi, ví dụ `[T] Không dành cho trẻ dưới 13 tuổi` | HTML `Rating` |
| `chapter_count`, `word_count` | Tính lại sau mỗi lần nạp chương, để trang danh sách khỏi phải đếm | Tự tính |
| `view_count`, `comment_count` | Lượt xem, bình luận của app. Không lấy từ nguồn; truyện mới bắt đầu từ 0 và lệnh nạp không ghi đè hai cột này | Tự tính |
| `like_count` | Lượt thích | HTML |
| `published_at`, `source_updated_at` | Ngày đăng, ngày sửa gần nhất trên nguồn | REST `date_gmt`, `modified_gmt` |
| `last_chapter_at` | Ngày đăng của chương mới nhất | Tự tính |
| `crawled_at` | Thời điểm script xuất chạy (`generatedAt` của `index.json`) | Tự tính |
| `content_hash` | SHA-256 của `intro` | Tự tính |
| `search_text` | Tên truyện và tác giả viết thường, bỏ dấu | Trigger |
| `is_hidden` | Ẩn truyện (bị gỡ, chưa xin phép…). Lệnh nạp không đụng tới cột này | Tự quản |

### `story_chapters`

| Cột | Ý nghĩa | Nguồn |
| --- | --- | --- |
| `story_id` | Truyện chứa chương | — |
| `source_chapter_id` | ID chương gốc, lưu dạng chữ. Với Vnkings là số sau `-p` trong URL (ví dụ `…-p255242.html` → `255242`); truyện ngắn dùng luôn ID post | URL chương |
| `position` | Thứ tự chương, bắt đầu từ 1 | Vị trí trong danh sách AJAX |
| `title`, `source_url` | Tên và link chương | Thẻ `<a>` trong `data.items` của AJAX |
| `content_text` | Nội dung chương, các đoạn cách nhau bằng một dòng trống | HTML `#content.vnkings-editor` |
| `word_count` | Số chữ (đếm theo khoảng trắng) | Tự tính |
| `published_at` | Ngày đăng chương | Meta `article:published_time` của trang chương, không có thì ngày trong danh sách AJAX |
| `crawled_at`, `content_hash` | Lần xuất gần nhất và SHA-256 của `content_text` | Tự tính |

## 5. Cách dùng

- **Truyện ngắn** lưu với `kind = 'short'` và đúng 1 dòng chương (`position = 1`) chứa nội dung post. Nhờ vậy phần đọc truyện chỉ có một cách xử lý cho cả truyện ngắn lẫn truyện dài.
- **Lọc theo thể loại:** `WHERE genres @> ARRAY['Tiểu Thuyết']` (dùng index GIN).
- **Tìm theo tên truyện hoặc tác giả, không phân biệt dấu:** `WHERE search_text LIKE '%' || lower(unaccent($1)) || '%'` (dùng index trigram). API escape `%`, `_` trong từ khoá trước khi ghép.
- **Sắp xếp** (API `GET /stories?sort=`):
  - `updated`: `ORDER BY COALESCE(last_chapter_at, source_updated_at) DESC`. Dùng ngày có chương mới thay cho `modified`, vì `modified` đổi cả khi chỉ sửa giới thiệu hoặc khi web sửa hàng loạt (mục 9 của [vnkings-data-access.md](../vnkings-data-access.md)).
  - `views` ("Top"): `ORDER BY view_count DESC, COALESCE(last_chapter_at, source_updated_at) DESC, id DESC`. Hiện mọi truyện đều 0 lượt xem nên "Top" thực tế là truyện mới có chương gần nhất, cho tới khi app tự đếm lượt xem.
  - `new`: `ORDER BY published_at DESC`.
- **Danh sách chương:** `SELECT id, position, title, word_count, published_at FROM story_chapters WHERE story_id = $1 ORDER BY position`. Postgres cất text dài ở vùng riêng (TOAST) và chỉ đọc khi câu `SELECT` có `content_text`, nên để nội dung chung bảng không làm chậm danh sách chương.
- **Đổi thứ tự chương:** ràng buộc `UNIQUE (story_id, position)` là `DEFERRABLE`, nên khi web chèn hoặc đổi thứ tự chương có thể cập nhật lại cả loạt `position` trong một transaction mà không bị báo trùng giữa chừng.
- **Chương không có truyện cha:** có 412 URL chương không nằm dưới link truyện nào. Bỏ qua, hoặc gắn vào một truyện tạm có `is_hidden = true`.

API đọc 2 bảng này mô tả ở [api.md](api.md).

## 6. Nạp dữ liệu

Hai bước: script Python lấy truyện từ Vnkings ra file JSON, lệnh Go đọc file đó và ghi vào Postgres. Tách ra để chỉ phải lấy dữ liệu một lần rồi nạp vào bao nhiêu môi trường cũng được (local, dev, prod).

```bash
python3 scripts/vnkings/export_stories.py --limit 100      # ghi ra scripts/vnkings/data/
cd server && go run ./cmd/migrations up postgres            # tạo 2 bảng nếu chưa có
cd server && go run ./cmd/storyimport                       # mặc định đọc ../scripts/vnkings/data
cd server && go run ./cmd/storyimport -dir /đường/dẫn/khác
```

`cmd/storyimport` đọc thông tin DB từ `server/.env` (`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_SSL_MODE`) như lệnh migration. Mỗi truyện ghi trong một transaction:

1. Upsert `stories` theo `(source, source_story_id)`, cập nhật mọi cột lấy từ nguồn. `is_hidden` giữ nguyên.
2. Upsert từng chương theo `(story_id, source_chapter_id)`. Chương có `content_hash`, `title`, `position`, `source_url`, `published_at` không đổi thì không ghi lại. Chương không có nội dung trong file (xuất bằng `--no-content`) chỉ ghi tên, vị trí, link, ngày đăng; nội dung đã có trong DB được giữ nguyên, chương mới thì `content_text` để trống. Nội dung các chương này do API tự lấy khi có người đọc (xem `GET /stories/{id}/chapters/{position}` trong [api.md](api.md)); muốn lấy hết một lần thì xuất lại không có `--no-content` rồi nạp lại.
3. Xoá chương của truyện đó không còn trong file (chương bị gỡ trên nguồn).
4. Tính lại `chapter_count`, `word_count`, `last_chapter_at` từ `story_chapters`.

Chạy lại nhiều lần không sinh dữ liệu trùng. Cuối mỗi lần chạy, lệnh in số truyện mới, số chương thêm, sửa, giữ nguyên và xoá. Ví dụ trên local, lần đầu: `stories: 100 (100 new); chapters: 700 added`, lần sau: `0 added, 0 updated, 700 unchanged`.

## 7. Đồng bộ truyện mới cập nhật

Phần này chưa làm. Hiện muốn cập nhật thì chạy lại 2 bước ở mục 6; lệnh nạp tự bỏ qua chương không đổi.

Cách lấy truyện và chương mới xem mục 9 của [vnkings-data-access.md](../vnkings-data-access.md). Khi làm đồng bộ tăng dần, ghi vào 2 bảng như sau:

1. Lấy mốc quét lần trước, ví dụ `max(source_updated_at)` của `stories` hoặc thời điểm lần quét trước. Gọi REST với `modified_after` = mốc đó lùi khoảng 1 giờ.
2. Upsert từng truyện trả về theo `(source, source_story_id)`: cập nhật `title`, `genres`, `tags`, `source_updated_at`…, và đặt `crawled_at = now()`.
3. Lấy ID chương lớn nhất đã lưu của truyện:

   ```sql
   SELECT coalesce(max(source_chapter_id::bigint), 0) FROM story_chapters WHERE story_id = $1;
   ```

4. Đọc danh sách chương qua AJAX từ trang cuối lùi về, cho tới khi gặp chương có ID nhỏ hơn hoặc bằng số trên. Mỗi chương có ID lớn hơn là chương mới: insert vào `story_chapters` với `position` nối tiếp, rồi lấy nội dung từ HTML trang chương.
5. Cập nhật lại `stories.chapter_count`, `word_count`, `last_chapter_at` theo các chương vừa thêm.
6. Định kỳ (ví dụ mỗi tuần) so `chapter_count` với số chương tính từ AJAX (`(totalPages - 1) × 10 + số chương ở trang cuối`). Lệch thì quét lại toàn bộ danh sách chương của truyện đó, để bắt được chương bị xoá hoặc chèn giữa.

`source_updated_at` đổi cả khi tác giả chỉ sửa giới thiệu, nên truyện có `source_updated_at` mới chưa chắc có chương mới. Muốn hiện danh sách "truyện có chương mới" thì sắp theo `last_chapter_at` thay vì `source_updated_at`.

## 8. Giới hạn của thiết kế 2 bảng

| Không có | Ảnh hưởng | Cách bù nếu cần |
| --- | --- | --- |
| Bảng tác giả riêng | Không làm được trang tác giả có ảnh, mô tả. Tác giả đổi tên phải sửa nhiều dòng | Lọc theo `source_author_id` vẫn được |
| Cây thể loại cha–con | Không biết thể loại nào thuộc nhóm nào | Ghi cả tên thể loại cha vào `genres` lúc lưu |
| Lượt xem theo ngày | Không tính được "Top view tuần" | Thêm cột `week_view_base`, `week_base_at`. Đầu mỗi tuần chép `view_count` sang `week_view_base`; lượt xem tuần = `view_count - week_view_base` |
| Khoá ngoại cho nguồn | `source` chỉ là chuỗi | Đủ dùng khi chỉ có một hai nguồn |

Khi cần trang tác giả, lọc theo cây thể loại hoặc thống kê lượt xem theo ngày thì tách thêm bảng `story_authors`, `story_categories` và `story_stat_snapshots`.

## 9. Dung lượng ước tính

- Chương mẫu dài khoảng 12 nghìn ký tự. Với 30.160 chương, phần text vào khoảng 0,4–0,5 GB.
- Postgres tự nén text dài (TOAST), nên dung lượng thực tế còn khoảng vài trăm MB.
- Đo trên local với 100 truyện, 700 chương: `story_chapters` 5,8 MB, `stories` 0,6 MB (tính cả index). Tính theo tỉ lệ thì 30.160 chương vào khoảng 250 MB.
- Metadata của 4.500 truyện chỉ vài MB.

## 10. Lưu ý bản quyền

Vnkings ghi rõ không cho đăng tải lại nội dung. Truy cập được bằng HTTP không có nghĩa là được phép sao chép hay hiển thị lại. Trước khi lưu và hiển thị nội dung cần xin phép, và luôn giữ `source_url` cùng tên tác giả để ghi nguồn.
