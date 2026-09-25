import type { TownUnlock } from './ConstructionTypes';

export interface CollectionRequirement {
  items: string[];
  quantity: number;
  label: string;
}

export interface CollectionGate {
  mode: 'all' | 'any';
  requirements: CollectionRequirement[];
}

export interface FarmGameplayConfig {
  version: 1;
  startingInventory: Record<string, number>;
  showWelcome: boolean;
  rescueEnabled: boolean;
  growthStageFraction: number;
  requireFeedMill: boolean;
  animals: Record<
    string,
    {
      name: string;
      maxPens: number;
      maxCapacity: number;
      startingCapacity: number;
      startingAnimals: number;
      feedPerAnimal: number;
    }
  >;
  machines: Record<
    string,
    { name: string; maxBuildings: number; maxQueueCapacity: number; startingCapacity: number; trayCapacity: number }
  >;
  gates: Record<TownUnlock, CollectionGate>;
}
