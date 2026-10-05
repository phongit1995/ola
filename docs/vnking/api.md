# Đọc truyện: REST API

Hợp đồng API cho tab RSS (đọc truyện) trên web và mobile. Dữ liệu lấy từ 2 bảng `stories`, `story_chapters` mô tả ở [database.md](database.md).

Mọi endpoint đều cần `Authorization: Bearer <token>` và nằm dưới `/api/v1/stories`. Response theo envelope chung của server:

```json
{ "success": true, "status": 200, "data": { }, "traceId": "…", "timestamp": "…", "path": "…" }
```

Truyện có `is_hidden = true` coi như không tồn tại (không có trong danh sách, chi tiết trả 404).

Code: server ở `server/internal/modules/story/`, client ở `StoryService` (`packages/shared/src/services/story.service.ts`).

## 1. Kiểu dữ liệu

### Story

```json
{
  "id": "16",
  "slug": "la-duyen-cung-la-menh",
  "title": "Là duyên cũng là mệnh",
  "authorName": "…",
  "kind": "long",
  "genres": ["Tiểu Thuyết", "Tình Cảm"],
  "tags": ["ngôn tình"],
  "intro": "Đoạn 1\n\nĐoạn 2",
  "coverUrl": "https://vnkings.com/wp-content/uploads/…",
  "status": "completed",
  "ageRating": "[T] Không dành cho trẻ dưới 13 tuổi",
  "chapterCount": 109,
  "wordCount": 120345,
  "viewCount": 25923,
  "commentCount": 12,
  "likeCount": 28,
  "sourceUrl": "https://vnkings.com/la-duyen-cung-la-menh.html",
  "publishedAt": "2024-02-06T03:12:45Z",
  "updatedAt": "2026-09-28T10:00:00Z",
  "lastChapterAt": "2026-09-27T17:00:00Z"
}
```

| Field | Ý nghĩa |
|---|---|
| `id` | ID trong DB của mình (`stories.id`), dạng chuỗi. Không phải ID post của Vnkings |
| `kind` | `short`: truyện ngắn, đúng 1 chương. `long`: truyện có chương |
| `intro` | Text thuần, các đoạn cách nhau bằng một dòng trống |
| `coverUrl` | `null` khi không có ảnh bìa |
| `status` | `ongoing` / `completed` / `unknown` |
| `ageRating` | Chuỗi rỗng khi nguồn không ghi |
| `updatedAt` | Ngày sửa gần nhất trên nguồn (`source_updated_at`) |
| `lastChapterAt` | Ngày đăng chương mới nhất, `null` khi chưa có chương |

### ChapterSummary

```json
{ "id": "254", "storyId": "16", "position": 1, "title": "Chương 1", "wordCount": 1096, "publishedAt": "2024-02-05T17:00:00Z" }
```

`position` bắt đầu từ 1 và liền nhau. `publishedAt` có thể là `null`.

### Chapter

`ChapterSummary` thêm 3 field:

| Field | Ý nghĩa |
|---|---|
| `content` | Nội dung chương, các đoạn cách nhau bằng một dòng trống |
| `prevPosition` | Vị trí chương trước, `null` ở chương đầu |
| `nextPosition` | Vị trí chương sau, `null` ở chương cuối |

## 2. Endpoint

### `GET /stories`

Danh sách truyện có phân trang.

| Query | Mặc định | Ý nghĩa |
|---|---|---|
| `sort` | `updated` | `updated`: có chương mới gần nhất (`COALESCE(lastChapterAt, updatedAt)`). `views`: lượt xem. `new`: ngày đăng. Giá trị khác coi như `updated` |
| `genre` | | Tên thể loại, khớp đúng một phần tử trong `genres` |
| `status` | `all` | `ongoing`, `completed`; giá trị khác coi như `all` |
| `q` | | Tìm trong tên truyện và tên tác giả, không phân biệt hoa thường và dấu ("oan gia" khớp "Oan Gia", "OAN GIÁ"). Tối đa 100 ký tự |
| `offset` | `0` | Bỏ qua bao nhiêu truyện |
| `limit` | `10` | Tối đa 50; lớn hơn thì lấy 50 |

```json
{ "items": [Story], "total": 100, "hasMore": true }
```

### `GET /stories/genres`

Thể loại và số truyện của mỗi thể loại, nhiều truyện đứng trước.

```json
{ "items": [{ "name": "Truyện Ngắn", "count": 25 }, { "name": "Tiểu Thuyết", "count": 14 }] }
```

### `GET /stories/{id}`

Một `Story`. Không có hoặc đã ẩn: `404 story not found`.

### `GET /stories/{id}/chapters`

Mọi chương của truyện theo thứ tự, không kèm nội dung.

```json
{ "items": [ChapterSummary] }
```

### `GET /stories/{id}/chapters/{position}`

Một `Chapter`. Truyện không có: `404 story not found`. Không có chương ở vị trí đó: `404 chapter not found`.

**Chương chưa có nội dung** (`content_text` rỗng, ví dụ nạp bằng `--no-content`): server lấy nội dung từ nguồn ngay trong request này, lưu vào `story_chapters` (kèm `word_count`, `content_hash`, cộng lại `stories.word_count`) rồi mới trả về. Các lần sau đọc thẳng từ DB.

- Chương của truyện dài: tải `source_url` (chỉ chấp nhận `https://vnkings.com/…`), lấy phần tử `#content`. Truyện ngắn: gọi REST `/wp/v2/posts/{source_story_id}` lấy `content.rendered`. Tách đoạn, bỏ dòng trang trí và đoạn đầu trùng tên chương giống hệt script `export_stories.py`.
- Nhiều request cùng chương trên một server chỉ gọi nguồn một lần (`singleflight`); mỗi server gọi nguồn tối đa 4 request song song, mỗi lần tối đa 15 giây. Request bị huỷ giữa chừng (người dùng thoát) thì lần lấy vẫn chạy tiếp và vẫn lưu.
- Lần đầu mất khoảng 0,6–2 giây, lần sau vài ms. Trang đọc trên web tải trước chương kế tiếp, nên bấm "Chương sau" thường không phải chờ.
- Lấy lỗi (nguồn lỗi, trang không có nội dung, link không phải Vnkings): trả `502` mã `STORY_CONTENT_UNAVAILABLE`, không ghi gì vào DB, lần gọi sau thử lại.

## 3. Lỗi

| HTTP | `error` | Khi nào |
|---|---|---|
| 401 | `authorization header required` | Thiếu token |
| 404 | `story not found` | `id` không phải số dương, không có truyện, hoặc truyện đã ẩn |
| 404 | `chapter not found` | `position` không phải số ≥ 1 hoặc vượt số chương |
| 502 | `chapter content unavailable` (`code: STORY_CONTENT_UNAVAILABLE`) | Chương chưa có nội dung và lấy từ nguồn thất bại |
