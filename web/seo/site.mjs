export const SITE_URL = 'https://olachat.net';
export const PLAY_STORE_URL =
  'https://play.google.com/store/apps/details?id=com.ola.me.net.org.vn';
export const APP_STORE_URL =
  'https://apps.apple.com/vn/app/ola-me/id6812642941';
export const APP_STORE_ID = '6812642941';
export const FANPAGE_URL = 'https://www.facebook.com/ola2vn';
export const TIKTOK_URL = 'https://www.tiktok.com/@olachat.net';
export const OG_IMAGE_URL = `${SITE_URL}/og-image.png`;
export const LOGO_URL = `${SITE_URL}/apple-touch-icon.png`;
export const DEFAULT_LASTMOD = '2026-10-30';

export const TOPICS = [
  ['/mang-xa-hoi-ket-ban/', 'Mạng xã hội kết bạn', 'Làm quen, kết nối và giữ liên lạc với bạn bè'],
  ['/tim-ban-bon-phuong/', 'Tìm bạn bốn phương', 'Gặp người mới mỗi ngày, kết bạn online an toàn'],
  ['/chia-se-khoanh-khac/', 'Chia sẻ khoảnh khắc', 'Khoảnh khắc 24 giờ, bảng tin và ảnh cùng bạn bè'],
  ['/phong-chat/', 'Phòng chat online', 'Trò chuyện nhóm cùng cộng đồng, chơi nối từ'],
  ['/blog/', 'Blog Ola Chat', 'Mẹo kết bạn, bắt chuyện và dùng mạng xã hội'],
  ['/gioi-thieu/', 'Giới thiệu Ola Chat', 'Tất cả tính năng của mạng xã hội Ola Chat'],
  ['/tai-app', 'Tải app Ola Me', 'Hướng dẫn cài app cho Android và iPhone'],
];

export const LEGAL_LINKS = [
  ['/dieu-khoan', 'Điều khoản sử dụng'],
  ['/chinh-sach-bao-mat', 'Chính sách bảo mật'],
];

export const APP_ROUTES_IN_SITEMAP = [
  { path: '/', changefreq: 'daily', priority: '1.0' },
  { path: '/tai-app', changefreq: 'weekly', priority: '0.8' },
  { path: '/dieu-khoan', changefreq: 'monthly', priority: '0.3' },
  { path: '/chinh-sach-bao-mat', changefreq: 'monthly', priority: '0.3' },
];
