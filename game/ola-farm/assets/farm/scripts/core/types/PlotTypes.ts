import type { PlotGroup as PlotGroupValues } from '../enums/PlotGroup';
import type { ItemAmount } from './ItemTypes';
import type { ResidentPen } from './LivestockTypes';

export type PlotGroup = (typeof PlotGroupValues)[keyof typeof PlotGroupValues];

export interface FarmItem {
  id: number;
  name: string;
  key: string;
  price: number;
  duration: number;
  yields: number[];
  group: PlotGroup;
  image: string;
  itemKey?: string;
  sellPrice?: number;
  prefab?: string;
  requiredLevel?: number;
  harvestXP?: number;
}

export interface CropSnapshot {
  output: ItemAmount;
  harvestXP: number;
  paidCoins: number;
  refundCoins: number;
  duration: number;
  rescue: boolean;
}

export interface Plot {
  id: number;
  cell: number | null;
  group: PlotGroup;
  unlocked: boolean;
  level: number;
  crop: number | null;
  started: number;
  ready: number;
  boosted: boolean;
  snapshot: CropSnapshot | null;
  residents: ResidentPen | null;
}
