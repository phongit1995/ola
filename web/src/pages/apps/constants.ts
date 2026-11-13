import type { ParseKeys } from 'i18next';
import type { AppOverlayKind } from '@/store/appOverlayStore';
import iconNotify from '@/assets/icons/apps/notify.png';
import iconPersonal from '@/assets/icons/apps/personal.png';
import iconVip from '@/assets/icons/apps/vip-crown.webp';
import iconAvatarFrame from '@/assets/icons/apps/avatar-frame.webp';
import iconKen from '@/assets/icons/apps/ken.png';
import iconMedia from '@/assets/icons/apps/media.png';
import iconSetting from '@/assets/icons/apps/setting.png';
import iconRemoveAccount from '@/assets/icons/apps/delete-account.png';
import iconSupport from '@/assets/icons/apps/support.png';
import iconLogout from '@/assets/icons/apps/logout.png';
import iconEgg from '@/assets/icons/apps/egg.png';
import iconGift from '@/assets/icons/apps/gift.webp';
import iconGiftCode from '@/assets/icons/apps/gift-code.webp';
import iconMegaphone from '@/assets/images/member-megaphone.webp';
import iconSocial from '@/assets/icons/social/social-menu-light.png';
import iconPen from '@/assets/games/pen/pen_icon.webp';
import iconWheel from '@/assets/games/spin-wheel/wheel.webp';
import type { Venue } from './NearbyPlacesPage';

export interface AppItem {
  icon: string;
  titleKey: ParseKeys;
  app?: AppOverlayKind;
  overlay?: 'pen' | 'egg' | 'wheel';
  action?: 'logout' | 'social' | 'remove-account' | 'support' | 'gift-code';
  subtitleKey?: 'home.appGameSubtitle' | 'home.appMallSubtitle';
}

export const GAME_ITEMS: AppItem[] = [
  { icon: iconEgg, titleKey: 'home.apps.egg', overlay: 'egg' },
  { icon: iconPen, titleKey: 'home.apps.pen', overlay: 'pen' },
  { icon: iconWheel, titleKey: 'home.apps.wheel', overlay: 'wheel' },
];

export const PERSONAL_ITEMS: AppItem[] = [
  {
    icon: iconNotify,
    titleKey: 'home.apps.notifications',
    app: 'notifications',
  },
  { icon: iconPersonal, titleKey: 'home.apps.profile', app: 'profile' },
  { icon: iconVip, titleKey: 'home.apps.vip', app: 'vip' },
  {
    icon: iconAvatarFrame,
    titleKey: 'avatarFrame.storeTitle',
    app: 'avatarFrameStore',
  },
  { icon: iconKen, titleKey: 'home.apps.ken', app: 'ken' },
  { icon: iconGift, titleKey: 'home.apps.gifts', app: 'gifts' },
  { icon: iconMegaphone, titleKey: 'megaphone.menuTitle', app: 'megaphone' },
  { icon: iconMedia, titleKey: 'home.apps.photos', app: 'media' },
  { icon: iconSocial, titleKey: 'home.apps.social', action: 'social' },
  { icon: iconGiftCode, titleKey: 'giftCode.menuTitle', action: 'gift-code' },
  { icon: iconSetting, titleKey: 'home.apps.settings', app: 'settings' },
  {
    icon: iconRemoveAccount,
    titleKey: 'home.apps.removeAccount',
    action: 'remove-account',
  },
  { icon: iconSupport, titleKey: 'home.apps.support', action: 'support' },
  { icon: iconLogout, titleKey: 'home.logout', action: 'logout' },
];

export const MOCK_VENUES: Venue[] = [
  {
    id: '1',
    name: 'Highlands Coffee',
    distance: '120 m',
    visits: 342,
    address: '12 Nguyễn Huệ, Q.1',
    cover: 'linear-gradient(135deg,#8d6e63,#4e342e)',
  },
  {
    id: '2',
    name: 'Vincom Center',
    distance: '450 m',
    visits: 1280,
    address: '72 Lê Thánh Tôn, Q.1',
    cover: 'linear-gradient(135deg,#90a4ae,#37474f)',
  },
  {
    id: '3',
    name: 'Công viên 23/9',
    distance: '1,2 km',
    visits: 560,
    address: 'Phạm Ngũ Lão, Q.1',
    cover: 'linear-gradient(135deg,#aed581,#558b2f)',
  },
  {
    id: '4',
    name: 'Nhà thờ Đức Bà',
    distance: '1,5 km',
    visits: 2104,
    address: '1 Công xã Paris, Q.1',
    cover: 'linear-gradient(135deg,#ffb74d,#e65100)',
  },
  {
    id: '5',
    name: 'Phố đi bộ Bùi Viện',
    distance: '1,8 km',
    visits: 980,
    address: 'Bùi Viện, Q.1',
    cover: 'linear-gradient(135deg,#ba68c8,#6a1b9a)',
  },
];

