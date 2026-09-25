import { legacyMachineTypes } from './legacy/LegacyMachineCatalog';
import { PlotGroup as PlotGroups } from './enums/PlotGroup';
import type { FarmCatalog } from './types/CatalogTypes';
import type { FarmState } from './types/StateTypes';
import type { Plot } from './types/PlotTypes';
import { machineGameplay, machineSites, penDefinition, penPlotId } from './FarmCatalog';
import { EMPTY_LAYOUT } from './constants/PlacementDefaults';

const clone = <T>(v: T): T => JSON.parse(JSON.stringify(v));

/** Pens added after the original 50 plots; they are appended to every simple farm, new or migrated. */
export function additionalPenPlots(catalog: FarmCatalog): Plot[] {
  return (catalog.residentPens ?? [])
    .filter(site => penPlotId(site) >= 50)
    .map(site => ({
      id: penPlotId(site),
      cell: null,
      group: PlotGroups.Pen,
      unlocked: false,
      level: 1,
      crop: null,
      started: 0,
      ready: 0,
      boosted: false,
      snapshot: null,
      residents: null,
    }));
}

/** A brand-new `simple-1` farm: starter pens hold their first animals, everything else waits for coins or level. */
export function freshSimpleFarm(catalog: FarmCatalog): FarmState {
  const machineTypes = catalog.machineTypes ?? legacyMachineTypes;
  let nextId = 1;
  const plots: Plot[] = Array.from({ length: 50 }, (_, id) => {
    const group = id < 12 || id >= 22 ? PlotGroups.Crop : id < 18 ? PlotGroups.Pen : PlotGroups.Pond;
    const pen = penDefinition(catalog, { id });
    const starter = pen && (pen.initial ?? pen.purchasePrice === undefined);
    const field = group === PlotGroups.Crop ? catalog.economy?.fields[id] : undefined;
    return {
      id,
      cell: id < 22 ? id : null,
      group,
      unlocked: group === PlotGroups.Crop ? (field?.initiallyUnlocked ?? true) : !!starter,
      level: field?.initialLevel ?? 1,
      crop: null,
      started: 0,
      ready: 0,
      boosted: false,
      snapshot: null,
      residents: null,
    };
  });
  plots.push(...additionalPenPlots(catalog));
  for (const plot of plots) {
    const site = penDefinition(catalog, plot);
    if (!site || !(site.initial ?? site.purchasePrice === undefined)) continue;
    const config = catalog.gameplay?.animals[site.species];
    plot.unlocked = true;
    plot.residents = {
      species: site.species,
      capacity: config?.startingCapacity ?? 1,
      animals: Array.from({ length: config?.startingAnimals ?? 1 }, (_, slot) => ({ id: nextId++, slot, job: null })),
    };
  }
  return {
    version: 7,
    buildingLayout: clone(EMPTY_LAYOUT),
    contentProfile: 'simple-1',
    rulesVersion: catalog.rulesVersion!,
    mode: 'free',
    ...(catalog.economy?.startingWallet ?? { coins: 500, diamonds: 10, xp: 0 }),
    time: 0,
    earned: 0,
    harvested: 0,
    sold: 0,
    inventory: clone(catalog.gameplay?.startingInventory ?? {}),
    planted: {},
    produced: {},
    soldProducts: {},
    plots,
    nextId,
    machines: catalog.initialMachines!.map((type, id) => ({
      id,
      type,
      capacity: machineGameplay(catalog, type)?.startingCapacity ?? 1,
      job: null,
      waiting: [],
      tray: [],
      buildingId: machineSites(machineTypes.find(t => t.id === type)!)[0],
    })),
    husbandry: {
      version: 1,
      feedReceived: false,
      eggsCollected: false,
      milkCollected: false,
      burgerCollected: false,
    },
    guideDismissed: catalog.gameplay?.showWelcome === false,
    guide: {
      plantedNew: false,
      harvestedNew: false,
      cookedTortilla: false,
      collectedTortilla: false,
      soldTortilla: false,
    },
  };
}

/** The original 40-field farm in its v2 storage shape; `migrateLegacy` turns it into the current state. */
export function freshLegacyFarm(): unknown {
  const plots = Array.from({ length: 50 }, (_, id) => {
    const group = id < 12 || id >= 22 ? PlotGroups.Crop : id < 18 ? PlotGroups.Pen : PlotGroups.Pond;
    return {
      id,
      cell: id < 22 ? id : null,
      group,
      unlocked: group === PlotGroups.Crop || id < 15 || (id >= 18 && id < 20),
      level: 1,
      crop: null as number | null,
      started: 0,
      ready: 0,
      boosted: false,
    };
  });
  [1, 1, 2, 2, 1, 3, 4, 1].forEach((crop, i) =>
    Object.assign(plots[i], { crop, started: i < 3 ? -102 : -60, ready: i < 3 ? 0 : 42 })
  );
  [5, 7, 6, 8, 9].forEach((crop, i) =>
    Object.assign(plots[[12, 13, 14, 18, 19][i]], { crop, started: -50, ready: 58 })
  );
  return {
    version: 2,
    mode: 'free',
    coins: 500,
    diamonds: 10,
    xp: 0,
    time: 0,
    earned: 0,
    harvested: 0,
    sold: 0,
    planted: {},
    produced: {},
    soldProducts: {},
    raw: { 1: 4, 2: 2, 7: 2 },
    goods: { 7: 1 },
    plots,
    machines: [1, 2, 3, 4].map((type, id) => ({ id, type, job: null })),
  };
}
