import type { ParseKeys } from 'i18next';
import type { AppOverlayKind } from '@/store/appOverlayStore';
import iconNotify from '@/assets/icons/apps/notify.png';
// TODO: mở lại các import icon dưới khi bật lại mục Kho game / Đăng quảng cáo / OlaMall / Lân cận
// import iconGame from '@/assets/icons/apps/game.png';
import iconPersonal from '@/assets/icons/apps/personal.png';
import iconVip from '@/assets/icons/apps/vip-crown.webp';
import iconKen from '@/assets/icons/apps/ken.png';
// import iconAdme from '@/assets/icons/apps/adme.png';
import iconMedia from '@/assets/icons/apps/media.png';
// import iconMall from '@/assets/icons/apps/mall.png';
// import iconNearby from '@/assets/icons/apps/nearby.png';
import iconSetting from '@/assets/icons/apps/setting.png';
import iconLogout from '@/assets/icons/apps/logout.png';
import iconEgg from '@/assets/icons/apps/egg.png';
import iconPen from '@/assets/games/pen/pen_icon.webp';
import iconWheel from '@/assets/games/spin-wheel/wheel.webp';
import type { Venue } from './NearbyPlacesPage';

export interface AppItem {
  icon: string;
  titleKey: ParseKeys;
  app?: AppOverlayKind;
  overlay?: 'pen' | 'egg' | 'wheel';
  action?: 'logout';
  subtitleKey?: 'home.appGameSubtitle' | 'home.appMallSubtitle';
}

export const APP_ITEMS: AppItem[] = [
  {
    icon: iconNotify,
    titleKey: 'home.apps.notifications',
    app: 'notifications',
  },
  { icon: iconEgg, titleKey: 'home.apps.egg', overlay: 'egg' },
  { icon: iconPen, titleKey: 'home.apps.pen', overlay: 'pen' },
  { icon: iconWheel, titleKey: 'home.apps.wheel', overlay: 'wheel' },
  // TODO: mở lại mục Kho game khi có tính năng thật
  // { icon: iconGame, titleKey: 'home.apps.gameStore', subtitleKey: 'home.appGameSubtitle' },
  { icon: iconPersonal, titleKey: 'home.apps.profile', app: 'profile' },
  { icon: iconVip, titleKey: 'home.apps.vip', app: 'vip' },
  { icon: iconKen, titleKey: 'home.apps.ken', app: 'ken' },
  // TODO: mở lại mục Đăng quảng cáo khi có tính năng thật
  // { icon: iconAdme, titleKey: 'home.apps.advertise' },
  { icon: iconMedia, titleKey: 'home.apps.photos', app: 'media' },
  // TODO: mở lại mục OlaMall khi có tính năng thật
  // { icon: iconMall, titleKey: 'home.apps.mall', subtitleKey: 'home.appMallSubtitle' },
  // TODO: mở lại mục Lân cận khi NearbyPlacesPage hết dữ liệu mock (MOCK_VENUES)
  // { icon: iconNearby, titleKey: 'home.apps.nearby', app: 'nearby' },
  { icon: iconSetting, titleKey: 'home.apps.settings', app: 'settings' },
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

export const KEN_LOW_THRESHOLD = 10_000;
export const MIN_AMOUNT = 10_000;
export const STEP_AMOUNT = 1_000;
export const PRESET_AMOUNTS = [
  10_000, 20_000, 50_000, 100_000, 200_000, 500_000,
];
