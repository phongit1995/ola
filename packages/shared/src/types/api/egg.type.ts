export type EggCategoryKind = 'nothing' | 'vip_icon' | 'ken' | 'vip_days';

export interface EggReward {
  id: string;
  label: string;
  weight: number;
  vipTypeId?: number;
  kenAmount?: number;
  vipDays?: number;
  isSuperLucky: boolean;
  isActive: boolean;
  sortOrder: number;
}

export interface EggCategory {
  id: string;
  type: EggCategoryKind;
  label: string;
  weight: number;
  isActive: boolean;
  sortOrder: number;
  rewards: EggReward[];
}

export interface EggPack {
  id: string;
  name: string;
  kenCost: number;
  isEnabled: boolean;
  sortOrder: number;
  categories?: EggCategory[];
}

export interface EggPackListResult {
  items: EggPack[];
}

export interface EggDrawResult {
  drawId: string;
  packId: string;
  kenCost: number;
  kenBalance: number;
  categoryType: EggCategoryKind;
  isWin: boolean;
  isSuperLucky: boolean;
  rewardType?: string;
  rewardLabel?: string;
  vipTypeId?: number;
  kenAmount?: number;
  vipDays?: number;
}

export interface EggDrawHistoryItem {
  id: string;
  packId: string;
  packName: string;
  kenCost: number;
  categoryType: EggCategoryKind;
  rewardType?: string;
  rewardLabel?: string;
  vipTypeId?: number;
  kenAmount?: number;
  vipDays?: number;
  isSuperLucky: boolean;
  createdAt: string;
}

export interface EggDrawHistoryResult {
  items: EggDrawHistoryItem[];
  total: number;
  limit: number;
  offset: number;
}

export type EggDrawHistoryFilter = 'all' | 'win' | 'miss';
