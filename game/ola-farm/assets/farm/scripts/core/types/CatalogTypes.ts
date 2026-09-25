import type { FarmItem } from './PlotTypes';
import type { Recipe, MachineType } from './ProductionTypes';
import type { StockItem } from './ItemTypes';
import type { AnimalType, ResidentPenDefinition } from './LivestockTypes';
import type { FarmEconomyConfig } from './EconomyTypes';
import type { FarmGameplayConfig } from './GameplayTypes';
import type { FarmRuntimeConfig } from './RuntimeTypes';

export interface FarmCatalog {
  farm: FarmItem[];
  products: Recipe[];
  items?: StockItem[];
  machineTypes?: MachineType[];
  livestock?: AnimalType[];
  rulesVersion?: string;
  contentProfile?: 'simple-1';
  initialMachines?: number[];
  residentPens?: ResidentPenDefinition[];
  timeMode?: 'real';
  saleXpCoins?: number;
  plantingXP?: number;
  boostSecondsPerGem?: number;
  economy?: FarmEconomyConfig;
  gameplay?: FarmGameplayConfig;
  runtime?: FarmRuntimeConfig;
}
