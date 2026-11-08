# Ola Admin

Trang quản trị: **React 19 + Vite + TypeScript + Ant Design 6 + TanStack Query**.

> Dùng **pnpm** (workspace của monorepo, phụ thuộc `@ola/shared`).

## Chạy

```bash
pnpm install
pnpm dev           # http://localhost:3006
```

## Biến môi trường

`.env.development` đã commit sẵn. Muốn đổi cho máy mình thì tạo `.env.development.local` (không commit), xem mẫu ở `.env.example`.

| Biến | Mặc định | Ý nghĩa |
|------|----------|---------|
| `VITE_API_URL` | `http://localhost:8080/api/v1` | Địa chỉ API server |
| `VITE_API_TIMEOUT` | `15000` | Timeout mỗi request (ms) |
| `VITE_API_GUARD_SECRET` | rỗng | Secret ký HMAC cho request (API guard của server) |

## Scripts

| Lệnh | Tác dụng |
|------|----------|
| `pnpm dev` | Dev server (HMR), cổng 3006 |
| `pnpm build` | Type-check (`tsc -b`) + build production vào `dist/` |
| `pnpm lint` | ESLint |
| `pnpm preview` | Xem thử bản build |

## Cấu trúc

```
admin/src/
├── main.tsx            # entry: QueryClient, ConfigProvider (vi_VN), RouterProvider
├── theme.ts            # theme antd
├── types.ts            # type request/response của API admin
├── config/env.ts       # đọc VITE_*
├── api/                # axios instance (http.ts), interceptor token + API guard
├── services/           # adminXxx.service.ts: gọi API, mỗi nghiệp vụ một file
├── hooks/              # hook react-query dùng chung nhiều màn, useDebounce
├── lib/                # tiện ích dùng chung: format, apiError, dateRange, constants…
├── components/         # component dùng chung nhiều màn (DateRangeFilter, UserBriefCell…)
├── store/              # zustand (authStore)
├── layout/             # AdminLayout: menu + header
├── routes/router.tsx   # khai báo route
└── pages/              # mỗi màn / nghiệp vụ một thư mục
    ├── settings/
    │   ├── NotificationSettingsPage.tsx
    │   ├── AnnouncementPage.tsx
    │   ├── useAnnouncementQueries.ts
    │   ├── constants.ts
    │   └── utils.ts
    └── games/
        ├── OddsSunburst.tsx      # dùng chung cho egg + wheel
        ├── useUserStatsTable.ts  # dùng chung cho các trang thống kê game
        ├── utils.ts
        ├── egg/
        └── wheel/
```

Luồng dữ liệu: `pages` gọi hook `useXxxQueries` → hook gọi `services/adminXxx.service.ts` → service gọi `api/http.ts`.

## Quy ước trong `pages/<màn>/`

| File | Chứa gì | Ví dụ |
|------|---------|-------|
| `XxxPage.tsx`, `XxxModal.tsx`, `XxxTab.tsx` | Component: state, xử lý sự kiện, JSX | `ClansPage.tsx` |
| `useXxxQueries.ts` | Hook react-query (`useQuery`/`useMutation`) gọi service, kèm query key | `useClanQueries.ts` |
| `constants.ts` | Hằng số `UPPER_CASE`: nhãn/màu theo trạng thái, options của Select, setting key, page size riêng | `CREDENTIAL_KEY`, `STATUS_META` |
| `utils.ts` | Hàm thuần không có JSX: parse, validate, format, đổi dữ liệu form ↔ request | `parseServiceAccount` |
| `types.ts` | Type / interface dùng cho nhiều file trong màn | `AutoJobFormValues` |

Chỉ tạo `constants.ts` / `utils.ts` / `types.ts` khi màn có nội dung cho file đó.

**Đặt code ở đâu**

- Chỉ một màn dùng → để trong thư mục của màn đó.
- Nhiều màn con cùng một nhóm dùng → để ở thư mục cha, ví dụ `pages/games/OddsSunburst.tsx` cho egg + wheel.
- Nhiều nhóm màn dùng → đưa lên `src/hooks`, `src/lib` hoặc `src/components`.
- Import trong cùng nhóm dùng đường dẫn tương đối (`./constants`, `../utils`); import từ ngoài `pages/` dùng alias `@/` (`@/lib/format`).

**Đặt tên**

- File hook react-query đặt tên `useXxxQueries.ts`. Hậu tố `Store` để dành cho zustand (`useAuthStore`).
- Tên trong `constants.ts` / `utils.ts` dùng chung cho cả thư mục, nên phải rõ nghĩa ngoài file gốc: `MODAL_PAGE_SIZE`, `STORY_STATUS_TAG`, `CRAWL_STATUS_TAG` thay vì `PAGE_SIZE`, `STATUS_TAG`.

**Giữ lại trong component**

- Hằng số có JSX hoặc `ReactNode` (icon, badge), cấu hình cột bảng có `render`, style object. File `.ts` không chứa được JSX, và những thứ này gắn với giao diện của màn.

**Dùng lại thứ đã có**

| Việc | Dùng |
|------|------|
| Phân trang 20 dòng | `PAGE_SIZE` từ `@/lib/constants`. Số khác thì khai báo trong `constants.ts` của màn |
| Thông báo lỗi API | `errorMessage(err, 'Fallback')` từ `@/lib/apiError` |
| Hiển thị ngày giờ, số, Ken | `formatDateTime`, `formatCount`, `formatKen` từ `@/lib/format` |
| Lọc theo khoảng ngày | `DateRangeFilter` (`@/components/DateRangeFilter`) + `toIsoRange`, `isoDaysAgo` (`@/lib/dateRange`) |
| Ô người dùng trong bảng | `UserBriefCell` (`@/components/UserBriefCell`), `UserCell` (`@/components/UserCell`) |
| Số Ken ròng có dấu +/− | `NetText` (`@/components/NetText`) |
| Ô tìm kiếm | `useDebounce` (`@/hooks/useDebounce`) |

## Cấu hình bật/tắt và `app_settings`

Mọi cài đặt lưu ở admin nằm trong bảng Postgres `app_settings`: mỗi nhóm là một dòng, gồm `key` và `value` (JSONB). Chưa lưu lần nào thì không có dòng, server dùng giá trị mặc định trong code.

**Khi bấm Lưu**

1. Admin gọi `PUT /admin/settings/:key`, server kiểm tra rồi ghi vào bảng.
2. Server xoá cache Redis `app_settings:cache`, lần đọc sau có giá trị mới ngay.
3. App nhận giá trị mới ở lần mở màn cần nó hoặc lần mở lại app, không đẩy realtime.

Sửa tay bằng SQL thì phải xoá key `app_settings:cache`, nếu không Redis có thể giữ giá trị cũ tới 1 giờ.

**App lấy config thế nào**

Sau khi đăng nhập, app gọi `GET /settings/app` một lần để lấy cả nhóm. Server đã tính sẵn theo nền tảng và phiên bản của máy gọi, nên `enabled` trả về là kết quả cuối cùng.

| Key `app_settings` | Tên trong `/settings/app` | Bật/tắt theo nền tảng |
|--------------------|---------------------------|-----------------------|
| `topup` | `topup` | Có |
| `username_change` | `usernameChange` | Có |
| `word_chain` | `wordChain` | Không |
| `story` | `story` | Có |
| `chat_bot` | `chatBot` | Có, theo từng bot |
| `moment` | `moment` | Có |
| `gift` | `gift` | Có |
| `megaphone` | `megaphone` | Có |

Những phần không nằm trong `/settings/app`:

- `app_update`: gọi trước khi đăng nhập, dùng `GET /settings/app-update`.
- Danh sách quà: dùng `GET /gifts`, vì đây là dữ liệu bán hàng chứ không phải cài đặt.
- Số lượt loa hôm nay, thời gian chờ, hàng đợi: dùng `GET /megaphones/config`, vì mỗi người một số và đổi liên tục. Để chung sẽ làm `version` của `/settings/app` đổi liên tục.
- Các key chỉ server và admin dùng, như `topup_bank`, `mail_resend`, `push_firebase`: có secret, không bao giờ trả cho app.

**Công tắc tổng và công tắc nền tảng**

Quà và loa có hai lớp, tính năng chỉ chạy khi cả hai cùng bật:

- `enabled`: công tắc tổng cho mọi nền tảng.
- `platforms`: bật/tắt riêng web, Android, iOS, và tắt riêng từng bản Android, iOS (so theo tên bản `1.0.0`, không tính build).

Dòng lưu trước khi có `platforms` được tính là mở ở mọi nền tảng.

| Tắt | Tặng quà | Loa |
|-----|----------|-----|
| Công tắc tổng | Mọi nền tảng ẩn nút tặng, server từ chối | Server từ chối loa mới và ngừng phát cho mọi nền tảng |
| Một nền tảng | Nền tảng đó ẩn nút tặng, server từ chối lượt tặng từ nền tảng đó | Nền tảng đó không phát được và không hiện viên loa; nền tảng khác vẫn thấy |
| Vẫn xem được | Tường quà, bảng xếp hạng, menu Quà | Lịch sử loa, menu Loa |

Tặng quà từ nền tảng đã tắt loa thì quà vẫn gửi được, chỉ không lên loa. App bản cũ chưa có phần này vẫn hiện viên loa khi tắt theo nền tảng, nhưng vẫn bị server chặn phát.

**Thêm một key mới cho app**

1. Server: thêm config và hàm kiểm tra trong `server/internal/modules/setting`, nối vào `PUT` ở `modules/admin/setting`.
2. Server: thêm key vào `appConfigSources()` trong `setting.app.go`. Không đổi tên key hoặc ý nghĩa field cũ, vì app đã phát hành đang đọc.
3. Shared: thêm type vào `AppConfigs` và đọc bằng `loadAppConfig('<key>')`.
4. Admin: dùng `PlatformRulesTable` và `cleanPlatformRules` nếu cần bật theo nền tảng, rồi cập nhật bảng trên.

## Thêm một màn mới

1. Thêm type request/response vào `src/types.ts` và hàm gọi API vào `src/services/adminXxx.service.ts`.
2. Tạo `src/pages/<màn>/` gồm `XxxPage.tsx` + `useXxxQueries.ts`, thêm `constants.ts` / `utils.ts` / `types.ts` khi cần.
3. Khai báo route trong `src/routes/router.tsx` và mục menu trong `src/layout/AdminLayout.tsx`.
