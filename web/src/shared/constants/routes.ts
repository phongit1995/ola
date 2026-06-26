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
  kenBuy: '/ken/nap',
  media: '/hinh-anh',
  nearby: '/lan-can',
  eggGame: '/dap-trung',
  penGame: '/sut-pen',
} as const;

export type RoutePath = (typeof ROUTES)[keyof typeof ROUTES];
