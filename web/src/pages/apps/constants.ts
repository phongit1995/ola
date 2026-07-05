import type { AppOverlayKind } from '@/store/appOverlayStore';
import icFriend from '@/assets/icons/notify/ic_notification_add_friend.png';
import icMention from '@/assets/icons/notify/ic_notification_mention.png';
import icLike from '@/assets/icons/notify/ic_notification_like.png';
import icPhoto from '@/assets/icons/notify/ic_notification_photo.png';
import icHeart from '@/assets/icons/notify/ic_notification_heart.png';
import icBrokenHeart from '@/assets/icons/notify/ic_notification_broken_heart.png';
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
import iconPen from '@/assets/games/pen/pen_icon.webp';
import iconWheel from '@/assets/games/spin-wheel/wheel.png';
import type { NotificationType, NotificationItem } from './NotificationsPage';
import type { Venue } from './NearbyPlacesPage';

export interface AppItem {
  icon: string;
  app?: AppOverlayKind;
  overlay?: 'pen' | 'egg' | 'wheel';
  subtitleKey?: 'home.appGameSubtitle' | 'home.appMallSubtitle';
}

export const TYPE_ICON: Partial<Record<NotificationType, string>> = {
  friend: icFriend,
  mention: icMention,
  like: icLike,
  photo: icPhoto,
  proposal: icHeart,
  divorce: icBrokenHeart,
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
  { icon: iconNotify, app: 'notifications' },
  { icon: iconEgg, overlay: 'egg' },
  { icon: iconPen, overlay: 'pen' },
  { icon: iconWheel, overlay: 'wheel' },
  { icon: iconGame, subtitleKey: 'home.appGameSubtitle' },
  { icon: iconPersonal, app: 'profile' },
  { icon: iconVip, app: 'vip' },
  { icon: iconKen, app: 'ken' },
  { icon: iconAdme },
  { icon: iconMedia, app: 'media' },
  { icon: iconMall, subtitleKey: 'home.appMallSubtitle' },
  { icon: iconNearby, app: 'nearby' },
  { icon: iconSetting },
];

export const MOCK_VENUES: Venue[] = [
  { id: '1', name: 'Highlands Coffee', distance: '120 m', visits: 342, address: '12 Nguyễn Huệ, Q.1', cover: 'linear-gradient(135deg,#8d6e63,#4e342e)' },
  { id: '2', name: 'Vincom Center', distance: '450 m', visits: 1280, address: '72 Lê Thánh Tôn, Q.1', cover: 'linear-gradient(135deg,#90a4ae,#37474f)' },
  { id: '3', name: 'Công viên 23/9', distance: '1,2 km', visits: 560, address: 'Phạm Ngũ Lão, Q.1', cover: 'linear-gradient(135deg,#aed581,#558b2f)' },
  { id: '4', name: 'Nhà thờ Đức Bà', distance: '1,5 km', visits: 2104, address: '1 Công xã Paris, Q.1', cover: 'linear-gradient(135deg,#ffb74d,#e65100)' },
  { id: '5', name: 'Phố đi bộ Bùi Viện', distance: '1,8 km', visits: 980, address: 'Bùi Viện, Q.1', cover: 'linear-gradient(135deg,#ba68c8,#6a1b9a)' },
];

export const KEN_LOW_THRESHOLD = 10_000;
export const MIN_AMOUNT = 10_000;
export const STEP_AMOUNT = 1_000;
export const PRESET_AMOUNTS = [10_000, 20_000, 50_000, 100_000, 200_000, 500_000];
export const QR_MODULES = 29;
