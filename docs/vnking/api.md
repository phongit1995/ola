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
  "id": "6f1c2a7e-3b9d-4c51-9a0e-2d7b8f4c1e35",
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
  "viewCount": 0,
  "commentCount": 0,
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
{ "id": "b2e8d4a1-7c3f-4e09-8d6a-5f1e9c2b7a40", "storyId": "6f1c2a7e-3b9d-4c51-9a0e-2d7b8f4c1e35", "position": 1, "title": "Chương 1", "wordCount": 1096, "publishedAt": "2024-02-05T17:00:00Z" }
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
| 404 | `story not found` | `id` không phải UUID hợp lệ, không có truyện, hoặc truyện đã ẩn |
| 404 | `chapter not found` | `position` không phải số ≥ 1 hoặc vượt số chương |
| 502 | `chapter content unavailable` (`code: STORY_CONTENT_UNAVAILABLE`) | Chương chưa có nội dung và lấy từ nguồn thất bại |

## 4. API cho admin

Trang admin: menu **Truyện** (`/stories`), code ở `admin/src/pages/StoriesPage.tsx` và `StoryChaptersModal.tsx`. Mọi endpoint nằm dưới `/api/v1/admin/stories`, cần token admin (`RequireAdmin`), được ghi vào nhật ký admin như các module khác. Server: `server/internal/modules/admin/story/`, logic dùng chung `story.Service` (`story.admin.go`).

| Endpoint | Việc |
|---|---|
| `GET /admin/stories` | Danh sách gồm cả truyện ẩn. Query giống bản công khai (`q`, `genre`, `status`, `sort`, `offset`, `limit` mặc định 20 tối đa 100) thêm `kind` (`short`/`long`), `visibility` (`all`/`visible`/`hidden`, mặc định `all`) và `source` (ví dụ `vnkings`). Trả `{items, total, limit, offset}`, mỗi truyện thêm `source`, `sourceStoryId`, `isHidden`, `contentChapters` (số chương đã có nội dung), `crawledAt`, `createdAt` |
| `PATCH /admin/stories` | Ẩn/hiện nhiều truyện một lần. Body `{"isHidden": true, "ids": ["<uuid>", "<uuid>"]}` (tối đa 500 ID) hoặc `{"isHidden": true, "filter": {"q", "genre", "status", "kind", "visibility", "source"}}` để đổi mọi truyện khớp bộ lọc, giống bộ lọc của `GET /admin/stories`. Có `ids` thì bỏ qua `filter`; `filter: {}` là toàn bộ truyện. Trả `{"updated": n}`, chỉ đếm truyện thực sự đổi trạng thái. Thiếu cả hai hoặc ID sai: `400` |
| `GET /admin/stories/summary` | `stories`, `hiddenStories`, `longStories`, `shortStories`, `chapters`, `contentChapters`, `lastCrawledAt` |
| `GET /admin/stories/genres` | Thể loại, tính cả truyện ẩn |
| `GET /admin/stories/sources` | Các nguồn và số truyện mỗi nguồn, `{"items": [{"name": "vnkings", "count": 200}]}` |
| `GET /admin/stories/{id}` | Một truyện (kể cả đang ẩn) |
| `PATCH /admin/stories/{id}` | Body `{"isHidden": true}` để ẩn, `false` để hiện. Truyện ẩn trả 404 với người dùng; lệnh nạp không đụng tới cột này nên nạp lại vẫn giữ ẩn |
| `DELETE /admin/stories/{id}` | Xoá truyện và mọi chương. Nếu truyện còn trong file dữ liệu thì lần nạp sau sẽ thêm lại; muốn gỡ hẳn thì ẩn |
| `GET /admin/stories/{id}/chapters` | Mọi chương kèm `sourceUrl`, `hasContent`, `crawledAt` |
| `GET /admin/stories/{id}/chapters/{position}` | Xem nội dung đang lưu, **không** tự lấy từ nguồn |
| `POST /admin/stories/{id}/chapters/{position}/refetch` | Lấy lại từ nguồn và ghi đè nội dung cũ (kể cả khi đã có). Lỗi nguồn: `502 STORY_CONTENT_UNAVAILABLE`, nội dung cũ giữ nguyên |
| `POST /admin/stories/{id}/fetch-content` | Lấy nội dung mọi chương còn thiếu, chạy nền, trả `{"queued": n}`. Lấy lần lượt, cách nhau 0,5 giây, tối đa 30 phút; truyện đang chạy thì trả `409`. Trang admin tự tải lại danh sách chương mỗi 3 giây cho tới khi đủ |

## 5. Bật/tắt Truyện theo nền tảng

Setting `story` trong bảng `app_settings`, admin sửa ở menu **Truyện → Cài đặt** (`/stories/settings`). Chưa lưu lần nào thì mọi nền tảng đều bật.

```json
{
  "web":     { "enabled": true,  "disableVersions": [] },
  "android": { "enabled": true,  "disableVersions": ["1.0.1", "1.0.2"] },
  "ios":     { "enabled": false, "disableVersions": [] }
}
```

| Endpoint | Việc |
|---|---|
| `GET /settings/story` | Cần đăng nhập. Server đọc header `X-Platform` (`web`/`android`/`ios`) và `X-App-Version`, chỉ trả `{"enabled": true}` hoặc `{"enabled": false}` |
| `PUT /admin/settings/story` | Body `{"value": {...}}`. Bắt buộc đủ `web`, `android`, `ios`, mỗi nền tảng phải có `enabled`; `disableVersions` mỗi bản dạng `1.0.0` (1–4 số), không trùng, tối đa 50; web không có danh sách bản bị tắt. Sai thì `400` |

Cách server tính (`StoryConfig.EnabledFor` trong `server/internal/modules/setting/setting.story.go`):

- `X-Platform` là `android` hoặc `ios` thì dùng cấu hình nền tảng đó; thiếu header hoặc giá trị khác (web, desktop) tính là `web`.
- Nền tảng đang tắt thì trả `false`. Đang bật thì trả `false` nếu tên bản của app nằm trong `disableVersions`, ngược lại `true`.
- Tên bản lấy phần đầu của `X-App-Version` (`1.0.0` trong `1.0.0 (45)`), không tính số build; `1.2` và `1.2.0` coi là một. Tên bản phải đứng riêng (theo sau là hết chuỗi, dấu cách hoặc `(`), nên `1.0.0.0.1` hay `1.0.0-beta` coi như không đọc được.
- Không đọc được phiên bản mà nền tảng có danh sách bản bị tắt thì trả `false`; danh sách rỗng thì chỉ xét bật/tắt.

Phía app:

- Mọi request qua `http` của `@ola/shared` đều tự gửi `X-Platform` và `X-App-Version` lấy từ `configureDeviceInfo` lúc bootstrap (`deviceInfoInterceptor`).
- Store `useStoryConfigStore` gọi `GET /settings/story` mỗi lần mở trang chính, nên đổi cấu hình có hiệu lực ở lần mở sau. Lỗi mạng thì giữ kết quả cũ; ngay lần đầu đã lỗi thì coi là tắt. Chưa có kết quả thì web chưa hiện tab RSS (đang ở tab RSS thì để trống, không tải truyện).
- Chỉ ẩn ở app, server không chặn API truyện.
- Web: tắt thì ẩn tab RSS; đang ở tab RSS thì về tab Chat. Mobile chưa có màn Truyện (tab RSS đang tắt trong `RootNavigator`), khi làm thì hiện tab khi `useStoryConfigStore` trả `enabled === true`.
