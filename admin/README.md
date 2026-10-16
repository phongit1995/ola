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

## Thêm một màn mới

1. Thêm type request/response vào `src/types.ts` và hàm gọi API vào `src/services/adminXxx.service.ts`.
2. Tạo `src/pages/<màn>/` gồm `XxxPage.tsx` + `useXxxQueries.ts`, thêm `constants.ts` / `utils.ts` / `types.ts` khi cần.
3. Khai báo route trong `src/routes/router.tsx` và mục menu trong `src/layout/AdminLayout.tsx`.
