import vipCrown from '@/assets/icons/apps/vip-crown.webp';
import kenCoin from '@/assets/icons/apps/ken.png';
import box from '../../../../packages/shared/assets/daily-checkin/box.webp';
import boxBig from '../../../../packages/shared/assets/daily-checkin/box-big.webp';
import boxMissed from '../../../../packages/shared/assets/daily-checkin/box-missed.webp';
import boxOpened from '../../../../packages/shared/assets/daily-checkin/box-opened.webp';
import boxBigOpened from '../../../../packages/shared/assets/daily-checkin/box-big-opened.webp';
import menu from '../../../../packages/shared/assets/daily-checkin/menu.webp';
import task from '../../../../packages/shared/assets/daily-checkin/task.webp';

export type DailyCheckinIconKind = 'menu' | 'box' | 'boxBig' | 'boxMissed' | 'boxOpened' | 'boxBigOpened' | 'vipBadge' | 'task' | 'vipDays' | 'ken';

export const DAILY_CHECKIN_ICONS: Record<DailyCheckinIconKind, string> = {
  menu,
  box,
  boxBig,
  boxMissed,
  boxOpened,
  boxBigOpened,
  vipBadge: vipCrown,
  task,
  vipDays: vipCrown,
  ken: kenCoin,
};
