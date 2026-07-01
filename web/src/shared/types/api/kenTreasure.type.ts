export interface ActiveChest {
  id: string;
  expiresAt: string;
  durationSeconds: number;
  opened: boolean;
}

export interface ActiveChestListResult {
  items: ActiveChest[];
}

export interface OpenChestResult {
  chestId: string;
  isEmpty: boolean;
  kenAmount: number;
  kenBalance: number;
}
