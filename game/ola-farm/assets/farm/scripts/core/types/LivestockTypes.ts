import type { TownUnlock } from './ConstructionTypes';
import type { ItemAmount } from './ItemTypes';

export interface ResidentPenDefinition {
  cell: number | null;
  plotId?: number;
  buildingId?: string;
  ordinal?: number;
  requiredLevel?: number;
  initial?: boolean;
  species: string;
  purchasePrice?: number;
  unlock?: TownUnlock;
}

/** Collection milestones survive sales and are separate from inventory quantities. */
export interface HusbandryProgress {
  version: 1;
  feedReceived: boolean;
  eggsCollected: boolean;
  milkCollected: boolean;
  burgerCollected: boolean;
}

export interface AnimalType {
  key: string;
  name: string;
  feed: string;
  output: string;
  duration: number;
  price: number;
  image: string;
  prefab: string;
  quantity: number;
}

export interface AnimalJob {
  started: number;
  ready: number;
  output: ItemAmount;
  xp: number;
}

export interface ResidentAnimal {
  id: number;
  slot: number;
  job: AnimalJob | null;
}

export interface ResidentPen {
  species: string;
  capacity: number;
  animals: ResidentAnimal[];
}
