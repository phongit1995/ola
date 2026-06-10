export const ROUTES = {
  root: '/',
  login: '/login',
  register: '/register',
  forgotPassword: '/forgot-password',
  terms: '/dieu-khoan',
  home: '/home',
} as const;

export type RoutePath = (typeof ROUTES)[keyof typeof ROUTES];
