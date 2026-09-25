import type { FarmCatalog } from './CatalogTypes';
import type { FarmItem } from './PlotTypes';
import type { Recipe } from './ProductionTypes';
import type { AnimalType } from './LivestockTypes';

/** Catalog after economy.json is applied; timing.json owns every job duration. */
export type FarmCatalogSource = Omit<FarmCatalog, 'farm' | 'products' | 'livestock' | 'boostSecondsPerGem'> & {
  farm: Omit<FarmItem, 'duration'>[];
  products: Omit<Recipe, 'duration'>[];
  livestock: Omit<AnimalType, 'duration'>[];
};

export interface TimingEntry {
  name: string;
  durationSeconds: number;
}

export interface FarmTimingConfig {
  version: 1;
  boostSecondsPerGem: number;
  crops: Record<string, TimingEntry>;
  animals: Record<string, TimingEntry>;
  recipes: Record<string, TimingEntry>;
}
