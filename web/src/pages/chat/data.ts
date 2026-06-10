import type { Contact, Conversation } from './types';

export const CONVERSATIONS: Conversation[] = [
  { name: 'linhchi92', last: 'Hôm nay trời đẹp ☀️', time: 'vừa tức thì', color: '#7cb342', unread: 3 },
  { name: 'tuananh', last: 'Đang bận...', time: '5 phút', color: '#5d4037', unread: 0 },
  { name: 'maiphuong', last: 'Nghe nhạc 🎧', time: '12 phút', color: '#6d4c41', unread: 1 },
  { name: 'quanghuy', last: 'Xin chào!', time: '1 giờ', color: '#4dd0e1', unread: 0 },
  { name: 'thuhuong', last: 'Yêu đời 💚', time: 'hôm qua', color: '#5d4037', unread: 0 },
];

export const CONTACTS: Contact[] = [
  { name: 'linhchi92', status: 'Hôm nay trời đẹp ☀️', color: '#7cb342', gender: 'female', vip: true, online: true },
  { name: 'tuananh', status: 'Đang bận...', color: '#5d4037', gender: 'male', vip: false, online: true },
  { name: 'maiphuong', status: 'Nghe nhạc 🎧', color: '#6d4c41', gender: 'female', vip: false, online: false },
  { name: 'quanghuy', status: 'Xin chào!', color: '#4dd0e1', gender: 'male', vip: true, online: false },
  { name: 'thuhuong', status: 'Yêu đời 💚', color: '#5d4037', gender: 'female', vip: false, online: true },
];
