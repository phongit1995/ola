export const ROUTES = {
  login: '/login',
  register: '/register',
  forgotPassword: '/forgot-password',
  terms: '/dieu-khoan',
  home: '/',
} as const;

export type RoutePath = (typeof ROUTES)[keyof typeof ROUTES];
