# support-web — trang pháp lý & hỗ trợ tĩnh cho store

Site tĩnh chứa **Chính sách bảo mật** và **Điều khoản sử dụng** của app **Ola Me**, dùng để dán link vào App Store Connect / Google Play Console.

## Link production (Cloudflare Pages)

| Trang | URL | Dán vào ô nào |
|-------|-----|---------------|
| Chính sách bảo mật | https://ola-me.pages.dev/privacy | Apple *Privacy Policy URL*, Play *Privacy policy* |
| Hỗ trợ | https://ola-me.pages.dev/support | Apple *Support URL*, Play *Support website* |
| Xoá tài khoản | https://ola-me.pages.dev/delete-account | Play *Account/Data deletion URL* |
| Điều khoản sử dụng | https://ola-me.pages.dev/terms | Apple EULA / License Agreement |
| Trang chủ | https://ola-me.pages.dev/ | Apple *Marketing URL* (tuỳ chọn) |

Alias 301 có sẵn: `/chinh-sach-bao-mat`, `/privacy-policy` → `/privacy`; `/dieu-khoan`, `/terms-of-use`, `/tos` → `/terms`; `/ho-tro`, `/hotro`, `/help` → `/support`; `/xoa-tai-khoan`, `/delete-data`, `/data-deletion` → `/delete-account`.

Ép ngôn ngữ bằng query: `?lang=vi` hoặc `?lang=en` (mặc định theo ngôn ngữ trình duyệt, có nút chuyển VI/EN trên đầu trang).

## Nội dung lấy từ đâu

Hai trang pháp lý **sinh ra** từ i18n dùng chung của app, không viết tay:

```
packages/shared/src/i18n/locales/vi.json → privacyPolicy, terms
packages/shared/src/i18n/locales/en.json → privacyPolicy, terms
```

Sửa nội dung pháp lý thì **sửa file JSON đó** (app và web dùng chung), rồi build lại. Nhớ bump `updated` trong JSON khi đổi nội dung.

Hai trang hỗ trợ / xoá tài khoản chỉ có trên web nên nội dung nằm trong [`content.mjs`](content.mjs) (song ngữ VI/EN), cùng với:

- `PUBLISHER` — tên + địa chỉ nhà phát hành. **Đang để rỗng nên khối này bị ẩn**; điền vào là trang chủ và trang hỗ trợ tự hiện thẻ "Nhà phát hành" (Play Console yêu cầu địa chỉ liên hệ công khai).
- `CHANNELS`, `DOWNLOADS` — fanpage/group/TikTok và link TestFlight/APK, đồng bộ thủ công với `web/src/shared/constants/{socialLinks,appDownload}.ts`.
- `RESPONSE_TIME_HOURS` — cam kết thời gian phản hồi hiển thị trên trang.

Các mốc thời gian cam kết ở trang xoá tài khoản (xác minh 7 ngày làm việc, xoá dữ liệu trong 30 ngày, sao lưu ghi đè trong 90 ngày) nằm trong `PAGES['delete-account']` — sửa ở đó nếu vận hành thực tế khác.

## Build

```bash
node support-web/build.mjs
```

Sinh ra trong `public/`: `index.html`, `support.html`, `delete-account.html`, `privacy.html`, `terms.html`, `404.html`, `robots.txt`, `sitemap.xml`.
Các file khác trong `public/` (`favicon.png`, `apple-touch-icon.png`, `og-image.png`, `_headers`, `_redirects`) là tĩnh, không bị build ghi đè.

Xem thử local:

```bash
cd support-web/public && python3 -m http.server 5891
# http://127.0.0.1:5891/privacy.html
```

## Deploy

```bash
cd support-web
node build.mjs
npx wrangler pages deploy public --project-name ola-me --branch main --commit-dirty=true
```

Project Cloudflare Pages: `ola-me` (account `phongit1995@gmail.com`, tạo bằng `wrangler pages project create ola-me --production-branch main`). Deploy không qua Git nên mỗi lần chạy lệnh trên là ra một bản production mới.

## Gắn domain riêng (tuỳ chọn)

Nếu muốn URL đẹp hơn `*.pages.dev`:

```bash
npx wrangler pages domain add legal.olachat.net --project-name ola-me
```

Rồi thêm bản ghi `CNAME legal → ola-me.pages.dev` trong DNS của domain (nếu domain đã ở Cloudflare thì Pages tự thêm). Sau khi domain hoạt động, sửa `SITE_URL` trong `build.mjs` và build + deploy lại để canonical/OG/sitemap trỏ đúng.

## Cấu hình

- `wrangler.toml` — `pages_build_output_dir = "public"`.
- `public/_headers` — security headers + cache (HTML no-cache, ảnh 7 ngày).
- `public/_redirects` — alias URL tiếng Việt.
- Các hằng ở đầu `build.mjs`: `SITE_URL`, `APP_NAME`, `SUPPORT_EMAIL`.
