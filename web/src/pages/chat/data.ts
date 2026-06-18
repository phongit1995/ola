import type { Conversation, SuggestedFriend } from './types';

export const CONVERSATIONS: Conversation[] = [
  { name: 'linhchi92', last: 'Hôm nay trời đẹp ☀️', time: 'vừa tức thì', color: '#7cb342', unread: 3 },
  { name: 'tuananh', last: 'Đang bận...', time: '5 phút', color: '#5d4037', unread: 0 },
  { name: 'maiphuong', last: 'Nghe nhạc 🎧', time: '12 phút', color: '#6d4c41', unread: 1 },
  { name: 'quanghuy', last: 'Xin chào!', time: '1 giờ', color: '#4dd0e1', unread: 0 },
  { name: 'thuhuong', last: 'Yêu đời 💚', time: 'hôm qua', color: '#5d4037', unread: 0 },
];

export const SUGGESTED_FRIENDS: SuggestedFriend[] = [
  { name: 'anhthu', color: '#ec407a' },
  { name: 'baolong', color: '#26a69a' },
  { name: 'cammy', color: '#7e57c2' },
];
