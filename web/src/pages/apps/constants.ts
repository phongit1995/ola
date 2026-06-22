import { ROUTES, type RoutePath } from '@constants';
import icFriend from '@/assets/icons/notify/ic_notification_add_friend.png';
import icMention from '@/assets/icons/notify/ic_notification_mention.png';
import icLike from '@/assets/icons/notify/ic_notification_like.png';
import icPhoto from '@/assets/icons/notify/ic_notification_photo.png';
import iconNotify from '@/assets/icons/apps/notify.png';
import iconGame from '@/assets/icons/apps/game.png';
import iconPersonal from '@/assets/icons/apps/personal.png';
import iconVip from '@/assets/icons/apps/vip.png';
import iconKen from '@/assets/icons/apps/ken.png';
import iconAdme from '@/assets/icons/apps/adme.png';
import iconMedia from '@/assets/icons/apps/media.png';
import iconMall from '@/assets/icons/apps/mall.png';
import iconNearby from '@/assets/icons/apps/nearby.png';
import iconSetting from '@/assets/icons/apps/setting.png';
import iconEgg from '@/assets/icons/apps/egg.png';
import type { NotificationType, NotificationItem } from './NotificationsPage';
import type { Venue } from './NearbyPlacesPage';
import type { Album } from './MediaStorePage';

export interface AppItem {
  icon: string;
  route?: RoutePath;
  subtitleKey?: 'home.appGameSubtitle' | 'home.appMallSubtitle';
}

export const TYPE_ICON: Partial<Record<NotificationType, string>> = {
  friend: icFriend,
  mention: icMention,
  like: icLike,
  photo: icPhoto,
};

export const MOCK_NOTIFICATIONS: NotificationItem[] = [
  { id: '1', sender: 'Minh Anh', type: 'friend', time: '5 phút trước' },
  { id: '2', sender: 'Hoàng Nam', type: 'mention', time: '12 phút trước' },
  { id: '3', sender: 'Lan Phương', type: 'like', time: '1 giờ trước' },
  { id: '4', sender: 'Đức Huy', type: 'photo', time: '2 giờ trước' },
  { id: '5', sender: 'Thu Trang', type: 'proposal', time: 'Hôm qua' },
  { id: '6', sender: 'Bảo Ngọc', type: 'divorce', time: '3 ngày trước' },
];

export const APP_ITEMS: AppItem[] = [
  { icon: iconNotify, route: ROUTES.notifications },
  { icon: iconEgg, route: ROUTES.eggGame },
  { icon: iconGame, subtitleKey: 'home.appGameSubtitle' },
  { icon: iconPersonal, route: ROUTES.profileEdit },
  { icon: iconVip, route: ROUTES.vip },
  { icon: iconKen, route: ROUTES.ken },
  { icon: iconAdme },
  { icon: iconMedia, route: ROUTES.media },
  { icon: iconMall, subtitleKey: 'home.appMallSubtitle' },
  { icon: iconNearby, route: ROUTES.nearby },
  { icon: iconSetting },
];

export const MOCK_VENUES: Venue[] = [
  { id: '1', name: 'Highlands Coffee', distance: '120 m', visits: 342, address: '12 Nguyễn Huệ, Q.1', cover: 'linear-gradient(135deg,#8d6e63,#4e342e)' },
  { id: '2', name: 'Vincom Center', distance: '450 m', visits: 1280, address: '72 Lê Thánh Tôn, Q.1', cover: 'linear-gradient(135deg,#90a4ae,#37474f)' },
  { id: '3', name: 'Công viên 23/9', distance: '1,2 km', visits: 560, address: 'Phạm Ngũ Lão, Q.1', cover: 'linear-gradient(135deg,#aed581,#558b2f)' },
  { id: '4', name: 'Nhà thờ Đức Bà', distance: '1,5 km', visits: 2104, address: '1 Công xã Paris, Q.1', cover: 'linear-gradient(135deg,#ffb74d,#e65100)' },
  { id: '5', name: 'Phố đi bộ Bùi Viện', distance: '1,8 km', visits: 980, address: 'Bùi Viện, Q.1', cover: 'linear-gradient(135deg,#ba68c8,#6a1b9a)' },
];

export const MOCK_ALBUMS: Album[] = [
  { id: '1', name: 'Ảnh của tôi', count: 128, privacy: 'public', kind: 'photo', cover: 'linear-gradient(135deg,#90caf9,#1976d2)' },
  { id: '2', name: 'Du lịch', count: 54, privacy: 'public', kind: 'photo', cover: 'linear-gradient(135deg,#a5d6a7,#388e3c)' },
  { id: '3', name: 'Video', count: 12, privacy: 'friends', kind: 'video', cover: 'linear-gradient(135deg,#ffcc80,#f57c00)' },
  { id: '4', name: 'Riêng tư', count: 7, privacy: 'private', kind: 'photo', cover: 'linear-gradient(135deg,#ce93d8,#7b1fa2)' },
  { id: '5', name: 'Ghi âm', count: 31, privacy: 'friends', kind: 'sound', cover: 'linear-gradient(135deg,#ef9a9a,#c62828)' },
  { id: '6', name: 'Kỷ niệm', count: 203, privacy: 'public', kind: 'photo', cover: 'linear-gradient(135deg,#b0bec5,#546e7a)' },
];

export const MIN_AMOUNT = 10_000;
export const STEP_AMOUNT = 1_000;
export const PRESET_AMOUNTS = [10_000, 20_000, 50_000, 100_000, 200_000, 500_000];
export const QR_MODULES = 29;
