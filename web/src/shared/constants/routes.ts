export const ROUTES = {
  login: '/login',
  register: '/register',
  forgotPassword: '/forgot-password',
  terms: '/dieu-khoan',
  home: '/',
  profile: '/profile',
  profileEdit: '/profile/edit',
} as const;

export type RoutePath = (typeof ROUTES)[keyof typeof ROUTES];
