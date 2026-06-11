export const API_PATH = {
  auth: {
    login: '/auth/login',
    register: '/auth/register',
    refresh: '/auth/refresh',
    changePassword: '/auth/change-password',
    logout: '/auth/logout',
  },
  rooms: {
    browse: '/rooms',
    detail: (id: string) => `/rooms/${id}`,
    members: (id: string) => `/rooms/${id}/members`,
    messages: (id: string) => `/rooms/${id}/messages`,
    message: (id: string, messageId: string) => `/rooms/${id}/messages/${messageId}`,
  },
  adminRooms: {
    base: '/admin/rooms',
    detail: (id: string) => `/admin/rooms/${id}`,
  },
} as const;
