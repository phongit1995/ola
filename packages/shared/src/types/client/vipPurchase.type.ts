import type { VipPackageItem } from '../api/vip.type';

export type BuyVipMode = 'buy' | 'give' | 'giveDays' | 'extend';

export interface VipConfirmInput {
  mode: BuyVipMode;
  selectedPackage: VipPackageItem | null;
  vipName: string;
  shopItemKenPrice: number;
  receiver: string;
}
