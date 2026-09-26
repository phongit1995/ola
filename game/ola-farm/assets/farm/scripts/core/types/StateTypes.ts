import type { BuildingLayout } from './BuildingTypes';
import type { HusbandryProgress } from './LivestockTypes';
import type { Plot } from './PlotTypes';
import type { Machine } from './ProductionTypes';

export interface FarmState {
  version: 3 | 5 | 6 | 7;
  buildingLayout?: BuildingLayout;
  contentProfile?: 'simple-1';
  guideDismissed?: boolean;
  husbandry?: HusbandryProgress;
  rulesVersion: string;
  mode: 'free';
  coins: number;
  diamonds: number;
  xp: number;
  /** Highest level whose diamond reward has been paid; older saves gain it on their next XP. */
  rewardedLevel?: number;
  time: number;
  earned: number;
  harvested: number;
  sold: number;
  planted: Record<string, number>;
  produced: Record<string, number>;
  soldProducts: Record<string, number>;
  inventory: Record<string, number>;
  plots: Plot[];
  machines: Machine[];
  nextId: number;
  guide: {
    plantedNew: boolean;
    harvestedNew: boolean;
    cookedTortilla: boolean;
    collectedTortilla: boolean;
    soldTortilla: boolean;
  };
}
