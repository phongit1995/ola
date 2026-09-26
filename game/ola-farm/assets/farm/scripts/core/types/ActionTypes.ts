import type { Plot, FarmItem } from './PlotTypes';
import type { Machine } from './ProductionTypes';

export interface ActionResult {
  error?: string;
  message?: string;
  plot?: Plot;
  machine?: Machine;
  amount?: number;
  coins?: number;
  item?: FarmItem;
}

/** Every player intent the UI can raise. Views build these; only the session applies them. */
export type FarmAction =
  | { type: 'moveBuilding'; building: string; position: { x: number; y: number } }
  | { type: 'plant'; plot: number; crop: number }
  | { type: 'harvest'; plot: number }
  | { type: 'cancel'; plot: number }
  | { type: 'boost'; plot: number }
  | { type: 'improve'; plot: number }
  | { type: 'rescue' }
  | { type: 'dismissGuide' }
  | { type: 'produce'; recipe: number; machine?: number }
  | { type: 'collect'; machine: number; batch?: number }
  | { type: 'collectAll'; machine: number }
  | { type: 'cancelQueued'; machine: number; job: number }
  | { type: 'expandQueue'; machine: number }
  | { type: 'boostMachine'; machine: number }
  | { type: 'buyMachine'; machineType: number; building?: string }
  | { type: 'sellItem'; item: string; quantity: number }
  | { type: 'setPenSpecies'; plot: number; species: string | null }
  | { type: 'buyAnimal'; plot: number; slot?: number }
  | { type: 'buyPen'; plot: number }
  | { type: 'expandPen'; plot: number; slot?: number }
  | { type: 'sellAnimal'; plot: number; animal: number }
  | { type: 'feedAnimals'; plot: number; animal?: number }
  | { type: 'boostAnimal'; plot: number; animal: number }
  | { type: 'collectAnimals'; plot: number; animal?: number }
  | { type: 'buyCoins'; pack: number };
