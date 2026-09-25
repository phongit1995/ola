/** Type-only compatibility exports. New code imports its domain under core/types directly. */
export type { StockItem, Ingredient, ItemAmount } from './types/ItemTypes';
export type { PlotGroup, FarmItem, CropSnapshot, Plot } from './types/PlotTypes';
export type { TownUnlock, UnlockStatus, BuildSite, ConstructionOffer } from './types/ConstructionTypes';
export type {
  ResidentPenDefinition,
  HusbandryProgress,
  AnimalType,
  AnimalJob,
  ResidentAnimal,
  ResidentPen,
} from './types/LivestockTypes';
export type { Recipe, MachineType, ProductionJob, ReadyBatch, Machine } from './types/ProductionTypes';
export type { FarmCatalog } from './types/CatalogTypes';
export type { FarmState } from './types/StateTypes';
export type { ActionResult } from './types/ActionTypes';
