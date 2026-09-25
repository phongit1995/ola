import type { TownUnlock as TownUnlockValues } from '../enums/TownUnlock';

export type TownUnlock = (typeof TownUnlockValues)[keyof typeof TownUnlockValues];

export interface UnlockStatus {
  unlocked: boolean;
  reason: string;
}

export interface BuildSite {
  buildingId: string;
  ordinal: number;
  requiredLevel: number;
  price: number | null;
  initial: boolean;
}

export interface ConstructionOffer extends UnlockStatus {
  count: number;
  limit: number;
  requiredLevel: number;
  price: number | null;
  buildingId: string | null;
  plotId?: number;
}
