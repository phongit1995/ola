export const ROUTES = {
  login: '/login',
  register: '/register',
  forgotPassword: '/forgot-password',
  terms: '/dieu-khoan',
  home: '/',
  profile: '/profile',
  profileEdit: '/profile/edit',
  vip: '/vip',
  vipBuy: '/vip/mua',
  notifications: '/thong-bao',
  ken: '/ken',
  media: '/hinh-anh',
  nearby: '/lan-can',
} as const;

export type RoutePath = (typeof ROUTES)[keyof typeof ROUTES];
