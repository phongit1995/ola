import type { MachineType } from '../types/ProductionTypes';

/** Machine definitions for catalogs that predate explicit machineTypes. IDs are save contracts. */
export const legacyMachineTypes: MachineType[] = [
  { id: 1, key: 'bakery', name: 'Lò bánh' },
  { id: 2, key: 'grill', name: 'Bếp nướng' },
  { id: 3, key: 'washer', name: 'Máy rửa trái cây' },
  { id: 4, key: 'milk_factory', name: 'Xưởng sữa' },
];

const machineSites: Readonly<Record<number, readonly string[]>> = {
  1: ['bakery-1'],
  2: ['grill-1'],
  3: ['washer-1'],
  4: ['dairy-1'],
  5: ['feed-1', 'feed-2', 'feed-3'],
};

/** Only used when a historical machine type has neither buildSites nor buildingIds. */
export function legacyMachineSites(type: number): string[] {
  return [...(machineSites[type] ?? [])];
}
