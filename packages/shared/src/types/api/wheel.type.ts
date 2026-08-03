export type WheelSegmentKind =
  | 'miss'
  | 'ken_fixed'
  | 'ken_random'
  | 'vip_days'
  | 'vip_item'
  | 'vip_random';

export interface WheelPlayerOption {
  label: string;
  vipTypeId?: number;
  vipDays?: number;
  kenAmount?: number;
}

export interface WheelPlayerSegment {
  id: string;
  kind: WheelSegmentKind;
  label: string;
  kenAmount?: number;
  kenMin?: number;
  kenMax?: number;
  vipDays?: number;
  vipTypeId?: number;
  sortOrder: number;
  options?: WheelPlayerOption[];
}

export interface WheelConfig {
  id: string;
  name: string;
  kenCost: number;
  freeDailyEnabled: boolean;
  freeAvailable: boolean;
  segments: WheelPlayerSegment[];
}

export interface WheelSpinResult {
  spinId: string;
  wheelId: string;
  segmentIndex: number;
  segmentId: string;
  segmentKind: WheelSegmentKind;
  isWin: boolean;
  isSuperLucky: boolean;
  kenCost: number;
  isFree: boolean;
  kenBalance: number;
  kenBalanceAfterCost: number;
  freeAvailable: boolean;
  rewardLabel?: string;
  kenAmount?: number;
  vipDays?: number;
  vipTypeId?: number;
}

export interface WheelSpinHistoryItem {
  id: string;
  wheelId: string;
  wheelName: string;
  kenCost: number;
  isFree: boolean;
  segmentKind: WheelSegmentKind;
  rewardLabel?: string;
  kenAmount?: number;
  vipDays?: number;
  vipTypeId?: number;
  isSuperLucky: boolean;
  createdAt: string;
}

export interface WheelSpinHistoryResult {
  items: WheelSpinHistoryItem[];
  total: number;
  limit: number;
  offset: number;
}

export type WheelSpinHistoryFilter = 'all' | 'win' | 'miss';
