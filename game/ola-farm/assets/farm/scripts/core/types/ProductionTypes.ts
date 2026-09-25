import type { Ingredient, ItemAmount } from './ItemTypes';
import type { TownUnlock, BuildSite } from './ConstructionTypes';

export interface Recipe {
  id: number;
  key?: string;
  name: string;
  image: string;
  duration: number;
  price: number;
  machine: number;
  ingredients: Ingredient[];
  outputs?: ItemAmount[];
  xp?: number;
  unlock?: TownUnlock;
  requiredLevel?: number;
}

export interface MachineType {
  id: number;
  key: string;
  name: string;
  prefab?: string;
  image?: string;
  buildSites?: BuildSite[];
  purchasePrices?: number[];
  buildingIds?: string[];
  unlock?: TownUnlock;
}

export interface ProductionJob {
  id: number;
  product: number;
  recipeKey: string;
  started: number;
  ready: number;
  duration: number;
  inputs: ItemAmount[];
  outputs: ItemAmount[];
  xp: number;
}

export interface ReadyBatch {
  id: number;
  product: number;
  outputs: ItemAmount[];
  xp: number;
}

export interface Machine {
  id: number;
  type: number;
  capacity: number;
  job: ProductionJob | null;
  waiting: ProductionJob[];
  tray: ReadyBatch[];
  buildingId: string | null;
}
