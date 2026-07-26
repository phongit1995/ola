import type { EggGiftSection } from '../types';
import { vipName } from './vip';

const FIXTURE_KEN_AMOUNTS = [
  2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000,
];

const FIXTURE_VIP_DAYS = [1, 2, 5, 10, 30];

const FIXTURE_VIP_TYPE_IDS = [
  22, 64, 32, 38, 91, 13, 28, 45, 10, 46, 48, 60, 84, 39, 25, 83, 52, 61, 119, 31, 50, 55, 4,
];

export const EGG_GIFT_FIXTURE: EggGiftSection[] = [
  {
    type: 'ken',
    rewards: FIXTURE_KEN_AMOUNTS.map((kenAmount) => ({
      label: `${kenAmount.toLocaleString('vi-VN')} Ken`,
      kenAmount,
      isSuperLucky: kenAmount >= 500000,
    })),
  },
  {
    type: 'vip_days',
    rewards: FIXTURE_VIP_DAYS.map((vipDays) => ({
      label: `${vipDays} ngày VIP`,
      vipDays,
      isSuperLucky: vipDays >= 30,
    })),
  },
  {
    type: 'vip_icon',
    rewards: FIXTURE_VIP_TYPE_IDS.map((vipTypeId) => ({
      label: vipName(vipTypeId),
      vipTypeId,
      isSuperLucky: false,
    })),
  },
];
