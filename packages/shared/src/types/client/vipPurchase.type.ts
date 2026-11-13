import type { VipDayTransferConfig, VipPackageItem } from '../api/vip.type';

export type BuyVipMode = 'buy' | 'give' | 'giveDays' | 'transferDays' | 'extend';

export interface VipDayTransferConfigState {
  config: VipDayTransferConfig | null;
  load: () => Promise<void>;
  refresh: () => Promise<void>;
}

export interface VipConfirmInput {
  mode: BuyVipMode;
  selectedPackage: VipPackageItem | null;
  vipName: string;
  shopItemKenPrice: number;
  receiver: string;
}

export interface VipPickerItem {
  key: string;
  typeId: number;
  name: string;
  price?: number;
}
