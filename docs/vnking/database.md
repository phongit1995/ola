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
- **Giờ đăng chương:** vnkings không công khai giờ đăng đầy đủ của chương. REST chỉ có kiểu `post` (truyện), chương là kiểu `tap-truyen` không mở REST; RSS bị tắt; sitemap không có `lastmod`; trang chương không có meta thời gian. Nguồn duy nhất là nhãn trong danh sách AJAX dạng `09/04/2026 lúc 9:12`: ngày và phút đúng (giờ Việt Nam), nhưng giờ theo đồng hồ 12 giờ **không có sáng/chiều**. Vì vậy crawler chỉ ghi giờ khi chứng minh được, còn lại ghi 0 giờ của ngày đó (giờ Việt Nam):
  - một trong 2 khả năng (sáng/chiều) cách giờ đăng (`date_gmt`) hoặc giờ sửa (`modified_gmt`) của truyện không quá 5 phút. Đo thực tế: chương 1 luôn trùng giờ đăng truyện, và thêm chương mới làm giờ sửa truyện trùng giờ chương đó, nên chương mới được crawler bắt kịp thường có giờ chính xác;
  - hoặc chỉ còn một khả năng hợp lệ: không nằm ở tương lai, và không trái thứ tự với chương liền trước/sau đã biết giờ (chỉ dùng khi ngày trong danh sách tăng dần).
  Khi ghi, giá trị chỉ có ngày (0 giờ) không ghi đè giờ chính xác đã có của cùng ngày, nên chạy lại không làm mất giờ và không bị tính là "sửa chương". `last_chapter_at` lấy từ các giá trị này. Script export và `cmd/storyimport` vẫn chỉ ghi ngày; crawler bổ sung giờ khi chạy qua truyện.
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
| `published_at` | Ngày đăng chương, có giờ khi xác định chắc chắn được | Nhãn trong danh sách AJAX, xem ghi chú "Giờ đăng chương" bên dưới |
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
cd server && go run ./cmd/storyimport -reset               # xoá hết truyện vnkings rồi mới nạp
```

`-reset` xoá mọi dòng `stories` có `source` bằng `-source` (mặc định `vnkings`); chương bị xoá theo `ON DELETE CASCADE`. Trước khi xoá, lệnh in số truyện và DB đích (`host:port/tên`) rồi bắt **gõ đúng tên database** để xác nhận; gõ sai thì dừng, không xoá gì. File xuất không có truyện nào thì lệnh từ chối reset. Xoá xong mới nạp; nạp lỗi giữa chừng thì chạy lại lệnh (không cần `-reset`) để nạp tiếp.

Thường **không cần** `-reset`: lệnh nạp đã cập nhật truyện có sẵn và xoá chương không còn trên nguồn. Chỉ dùng khi muốn bỏ cả các truyện đã bị gỡ khỏi vnkings (lệnh nạp chỉ xử lý truyện có trong file). Reset làm mất:

- `is_hidden`: truyện admin đã ẩn sẽ hiện lại;
- `view_count`, `comment_count`;
- nội dung chương đã được API tải khi có người đọc (xuất bằng `--no-content` thì phải tải lại);
- id truyện: id là UUID sinh mới khi thêm, nên "Đọc tiếp" và tiến độ đọc lưu trên máy người dùng (`ola.story.prefs`, theo id truyện) trỏ vào truyện không còn.

Không chạy `-reset` trên prod nếu chưa sao lưu.

`cmd/storyimport` đọc thông tin DB từ `server/.env` (`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_SSL_MODE`) như lệnh migration. Mỗi truyện ghi trong một transaction:

1. Upsert `stories` theo `(source, source_story_id)`, cập nhật mọi cột lấy từ nguồn. `is_hidden` giữ nguyên.
2. Upsert từng chương theo `(story_id, source_chapter_id)`. Chương có `content_hash`, `title`, `position`, `source_url`, `published_at` không đổi thì không ghi lại. Nội dung trong `chapters/<id truyện>.json` ghép với chương theo id chương nguồn (truyện ngắn dùng id truyện), không theo số thứ tự, nên nguồn chèn hay đổi thứ tự chương cũng không ghép nhầm; xuất bằng `--no-content` thì script xoá file nội dung cũ của truyện đó. File xuất bằng bản script cũ (ghép theo số thứ tự) sẽ không khớp id nào nên bị bỏ qua, không ghi nhầm. Chương không có nội dung trong file (xuất bằng `--no-content`) chỉ ghi tên, vị trí, link, ngày đăng; nội dung đã có trong DB được giữ nguyên, chương mới thì `content_text` để trống. Nội dung các chương này do API tự lấy khi có người đọc (xem `GET /stories/{id}/chapters/{position}` trong [api.md](api.md)); muốn lấy hết một lần thì xuất lại không có `--no-content` rồi nạp lại.
3. Xoá chương của truyện đó không còn trong file (chương bị gỡ trên nguồn).
4. Tính lại `chapter_count`, `word_count`, `last_chapter_at` từ `story_chapters`.

Chạy lại nhiều lần không sinh dữ liệu trùng. Cuối mỗi lần chạy, lệnh in số truyện mới, số chương thêm, sửa, giữ nguyên và xoá. Ví dụ trên local, lần đầu: `stories: 100 (100 new); chapters: 700 added`, lần sau: `0 added, 0 updated, 700 unchanged`.

## 7. Tự động cập nhật truyện

API server tự hỏi vnkings định kỳ và kéo chương mới về, không cần chạy lại 2 bước ở mục 6. Admin cấu hình ở menu **Truyện → Cài đặt**, tab **Cập nhật tự động** (`/stories/settings?tab=crawler`), log xem ở nút **Xem log**; API xem ở mục 6 của [api.md](api.md). Code: `server/internal/modules/story/story.crawler.go` (lịch chạy, log), `story.catalog.go` (gọi vnkings, port từ `export_stories.py`), `story.import.go` (ghi DB, dùng chung với `cmd/storyimport`).

Mỗi lượt chạy:

1. Giữ khoá Redis `LOCK:STORY_CRAWL` (TTL 30 phút, mỗi lượt tối đa 25 phút) để nhiều instance API không chạy chồng.
2. Không lưu mốc quét. Mỗi lượt chỉ xét khoảng **3 ngày** tính tới lúc bắt đầu chạy (`since = giờ bắt đầu − 3 ngày`, hằng `StoryCrawlWindowDays`). Đo thực tế đầu 10/2026: vnkings có khoảng 4 bài truyện được sửa mỗi ngày (nhiều nhất 10) và khoảng 1 truyện mới mỗi ngày, nên 3 ngày dư cho mọi chu kỳ chạy (1–24 giờ).
3. Thử lại trước tối đa 100 truyện trong hàng chờ `retry` (cùng key `STORY_CRAWL:STATE`): lấy lại bài theo id (`wp/v2/posts&include=...`) rồi xử lý như bước 5. Thành công thì ra khỏi hàng chờ; bài không còn trên nguồn cũng bỏ khỏi hàng chờ.
4. Gọi REST `wp/v2/posts` lọc theo các danh mục truyện, `modified_after=<since theo UTC, có Z>`, `orderby=modified&order=desc&per_page=20`: chỉ lấy **đúng 20 bài sửa gần nhất** (hằng `StoryCrawlBatch`), không lấy trang sau. Header `X-WP-Total` lớn hơn 20 thì log ghi `truncated`. Giữa 2 lượt mà có hơn 20 bài bị sửa (crawler tắt lâu, vnkings sửa hàng loạt) thì các bài cũ hơn bị bỏ lỡ cho tới khi được sửa lại, nên nên để chu kỳ ≤ 12 giờ.
5. Với từng bài:
   - Chưa có trong DB mà tắt "Lấy cả truyện mới" thì bỏ qua (đếm `storiesSkippedNew`), không tải gì thêm. Vì không có mốc quét nên bật lại thì lượt sau vẫn thêm các truyện mới còn nằm trong 20 bài/3 ngày.
   - Đã có trong DB và `modified_gmt` của bài không mới hơn `source_updated_at` đã lưu thì bỏ qua (đếm `storiesUnchanged`), không tải trang truyện. Đây là cách biết truyện có chương mới: đo thực tế, thêm chương làm giờ sửa bài truyện trùng đúng giờ chương đó; giờ sửa cũng đổi khi vnkings sửa thông tin truyện, khi đó crawler tải lại nhưng không có chương nào đổi.
   - Còn lại thì tải trang truyện (tác giả, tình trạng, rating, lượt thích, ảnh bìa, nonce) và **đủ** danh sách chương qua AJAX `vnk_single_chapters`, rồi ghi như lệnh nạp: upsert truyện, thêm chương mới, cập nhật chương đổi vị trí/tên/ngày, xoá chương không còn. Trang thứ 2 trở đi của danh sách chương mà lỗi, rỗng hoặc lặp lại chương đã có (vnkings trả lại trang 1 khi hỏi quá số trang) thì cả truyện tính là lỗi và **không** ghi, để không xoá nhầm các chương chưa tải được. Không tải nội dung chương; nội dung vẫn tải khi người đọc mở lần đầu.
   - Truyện mới được thêm ở trạng thái hiện (`is_hidden = false`). Cột `is_hidden`, `view_count`, `comment_count` và nội dung chương đã có không bị đụng tới.
   - Truyện lỗi (mạng, `404`, danh sách chương dở dang, nguồn đổi truyện dài thành truyện ngắn…) vào hàng chờ `retry` để các lượt sau thử lại, tối đa 5 lần; quá 5 lần thì chuyển sang danh sách `gaveUp` (cùng key `STORY_CRAWL:STATE`, kèm giờ sửa lúc đó) và không thử nữa cho tới khi giờ sửa trên nguồn đổi. Hàng chờ giữ tối đa 500 truyện; `gaveUp` tự bỏ các mục có giờ sửa đã ra ngoài khoảng 3 ngày.
   - So chương khi đã tải: tải **đủ** danh sách chương rồi ghi theo khoá `(story_id, source_chapter_id)`. Id chương chưa có là chương mới (`chaptersAdded`), đã có mà đổi vị trí/tên/link/giờ đăng là sửa (`chaptersUpdated`), không đổi thì bỏ qua, có trong DB mà không còn trên nguồn thì xoá (`chaptersRemoved`).
6. Ghi log vào Redis `STORY_CRAWL:LOGS` (giữ 50 lượt gần nhất), tiến độ lượt đang chạy ở `STORY_CRAWL:PROGRESS`.
7. Lượt bị chặn hay lỗi giữa chừng không cần lưu gì thêm: các truyện chưa xử lý vẫn có giờ sửa mới hơn bản đã lưu nên lượt sau tự xử lý lại, truyện đã xử lý thì được bỏ qua nhờ so giờ sửa. Ghi lại không hại gì vì lệnh ghi chỉ đổi khi dữ liệu khác.

Lịch chạy: vòng lặp trong API kiểm tra mỗi tối đa 1 phút, đọc lại cấu hình từ DB mỗi lần nên lưu cấu hình xong không cần khởi động lại. Đến hạn khi `lastRunAt + chu kỳ ≤ bây giờ`; `lastRunAt` ghi ngay lúc bắt đầu chạy, nên lượt lỗi cũng phải đợi hết chu kỳ mới chạy lại.

Lịch sự với nguồn:

- Request cách nhau 1 giây. User-Agent mặc định cố định một bản Chrome; bật "User-Agent ngẫu nhiên" (`randomUserAgent`) thì mỗi lượt chọn ngẫu nhiên một dòng trong `server/internal/modules/story/user-agents.json` (105 dòng, nhúng vào server, sửa file rồi build lại; lấy từ API useragents.me tuần 27/09–04/10/2026, bỏ bot, UA cụt và trình duyệt cũ, bổ sung các bản Chrome 146–154, Firefox 150–157, Safari 26–27, Samsung, Cốc Cốc) và dùng chung cho cả lượt, không đổi theo từng request. Vnkings trả cùng cấu trúc HTML cho trình duyệt máy tính và điện thoại nên danh sách có cả hai. Lỗi mạng hoặc 5xx thử lại tối đa 2 lần.
- Cookie đăng nhập (`useCookies`): admin tự đăng nhập vnkings rồi dán cookie vào danh sách. Đầu mỗi lượt crawler xáo các cookie `active`, lấy lần lượt từng cái tải trang chủ để kiểm tra, rồi dùng cookie sống đầu tiên cho cả lượt (gửi ở mọi request, cả REST và AJAX). Trang trả về có link "Đăng nhập" (`class="login_plus"`) mà không có link `logout` thì coi là cookie đã bị đăng xuất: đổi sang `dead` kèm `deadAt` ngay trong `app_settings` bằng một câu `UPDATE` JSONB (chỉ sửa đúng cookie đó, không ghi đè phần cấu hình khác), rồi chuyển sang cookie kế tiếp. Trang truyện cũng được kiểm tra như vậy; cookie chết giữa lượt thì đổi cookie và tải lại trang truyện đó. Hết cookie sống thì lượt vẫn chạy tiếp như khách. Bị `403/429/503` vẫn dừng cả lượt chứ không đổi sang tài khoản khác để thử tiếp.
- Gặp `403`, `429`, `503` thì dừng cả lượt, trạng thái `blocked`, không cố thử tiếp.
- `404` hoặc AJAX `success:false` chỉ tính lỗi cho truyện đó.
- Truyện dài đã có mà không lấy được danh sách chương, hoặc nguồn trả về dạng truyện ngắn, thì báo lỗi và **không** ghi, để không xoá mất chương.

Đo trên local (khoảng 21 truyện đổi trong 3 ngày): mỗi lượt khoảng 62 request, chạy 1 phút.

`source_updated_at` đổi cả khi tác giả chỉ sửa giới thiệu hoặc site sửa hàng loạt, nên nhiều truyện được "kiểm tra" nhưng không có chương mới. Muốn hiện danh sách "truyện có chương mới" thì sắp theo `last_chapter_at` thay vì `source_updated_at`.

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
