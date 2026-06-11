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
  me: {
    base: '/me',
    mine: '/me/mine',
    users: (userId: string) => `/me/users/${userId}`,
    detail: (id: string) => `/me/${id}`,
    images: '/me/images',
    react: (id: string) => `/me/${id}/react`,
    comments: (id: string) => `/me/${id}/comments`,
    comment: (id: string, commentId: string) => `/me/${id}/comments/${commentId}`,
  },
} as const;
