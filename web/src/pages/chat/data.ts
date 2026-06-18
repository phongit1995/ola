import type { Contact, Conversation, SuggestedFriend } from './types';
import statusPhotoA from '@/assets/stickers/kul/kul01.png';
import statusPhotoB from '@/assets/stickers/kul/kul05.png';

export const CONVERSATIONS: Conversation[] = [
  { name: 'linhchi92', last: 'Hôm nay trời đẹp ☀️', time: 'vừa tức thì', color: '#7cb342', unread: 3 },
  { name: 'tuananh', last: 'Đang bận...', time: '5 phút', color: '#5d4037', unread: 0 },
  { name: 'maiphuong', last: 'Nghe nhạc 🎧', time: '12 phút', color: '#6d4c41', unread: 1 },
  { name: 'quanghuy', last: 'Xin chào!', time: '1 giờ', color: '#4dd0e1', unread: 0 },
  { name: 'thuhuong', last: 'Yêu đời 💚', time: 'hôm qua', color: '#5d4037', unread: 0 },
];

export const CONTACTS: Contact[] = [
  { name: 'linhchi92', alias: 'Linh Chi', color: '#7cb342', vip: true, online: true, deviceType: 'apple', statusImage: statusPhotoA, group: 'birthday' },
  { name: 'tuananh', color: '#5d4037', vip: false, online: true, deviceType: 'android', group: 'new' },
  { name: 'maiphuong', alias: 'Mai Phương', color: '#6d4c41', vip: false, online: false, deviceType: 'pc', group: 'new', lastActive: '20 phút trước' },
  { name: 'olabot', alias: 'Trợ lý Ola', color: '#9c27b0', vip: false, online: true, deviceType: 'phone', group: 'utility' },
  { name: 'quanghuy', color: '#4dd0e1', vip: true, online: true, deviceType: 'phone', statusImage: statusPhotoB, group: 'friend' },
  { name: 'thuhuong', color: '#5d4037', vip: false, online: true, deviceType: 'winphone', group: 'friend' },
  { name: 'minhduc', color: '#ef6c00', vip: false, online: false, deviceType: 'android', group: 'friend', lastActive: '5 phút trước' },
  { name: 'ngockhanh', alias: 'Khánh', color: '#00897b', vip: true, online: false, deviceType: 'apple', group: 'friend', lastActive: '1 giờ trước' },
];

export const SUGGESTED_FRIENDS: SuggestedFriend[] = [
  { name: 'anhthu', color: '#ec407a' },
  { name: 'baolong', color: '#26a69a' },
  { name: 'cammy', color: '#7e57c2' },
];
