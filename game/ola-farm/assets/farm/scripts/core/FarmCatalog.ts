import type { FarmCatalog } from './types/CatalogTypes';
import type { FarmItem, Plot } from './types/PlotTypes';
import type { Recipe, MachineType } from './types/ProductionTypes';
import type { StockItem, ItemAmount } from './types/ItemTypes';
import type { ResidentPenDefinition } from './types/LivestockTypes';
import { legacyMachineSites, legacyMachineTypes } from './legacy/LegacyMachineCatalog';
import { contentName } from './i18n/LocalizeContent';

export const cropItemKey = (f: FarmItem): string => f.itemKey ?? `raw:${f.id}`;
export const recipeKey = (r: Recipe): string => r.key ?? `recipe:goods:${r.id}`;
export const recipeInputs = (r: Recipe): ItemAmount[] =>
  r.ingredients.map(i => ({ key: i.key ?? `raw:${i.id}`, quantity: i.quantity }));
export const recipeOutputs = (r: Recipe): ItemAmount[] => r.outputs ?? [{ key: `goods:${r.id}`, quantity: 1 }];
export function stockCatalog(catalog: FarmCatalog): StockItem[] {
  const result = new Map<string, StockItem>();
  for (const f of catalog.farm)
    result.set(cropItemKey(f), {
      key: cropItemKey(f),
      name: f.id === 7 ? contentName('Sữa bò') : f.name,
      image: f.image,
      sellPrice: f.sellPrice ?? Math.ceil(f.price * 0.6),
      tab: 'raw',
      legacyId: f.id,
    });
  for (const r of catalog.products) {
    const output = recipeOutputs(r)[0];
    if (!result.has(output.key))
      result.set(output.key, {
        key: output.key,
        name: r.name,
        image: r.image,
        sellPrice: r.price,
        tab: 'goods',
        legacyId: r.id,
      });
  }
  for (const item of catalog.items ?? []) result.set(item.key, item);
  return Array.from(result.values());
}
export const penPlotId = (site: ResidentPenDefinition): number => site.plotId ?? site.cell!;
export const penBuildingId = (site: ResidentPenDefinition): string => site.buildingId ?? 'pen:' + penPlotId(site);
export const penDefinition = (
  catalog: FarmCatalog,
  plot: Pick<Plot, 'id'> | undefined
): ResidentPenDefinition | undefined =>
  plot ? catalog.residentPens?.find(site => penPlotId(site) === plot.id) : undefined;

/** Catalog-owned sites let new factories share purchasing and validation with existing mills. */
export function machineSites(type: MachineType): string[] {
  return type.buildSites?.map(site => site.buildingId) ?? type.buildingIds ?? legacyMachineSites(type.id);
}

/** Per-machine gameplay overrides, keyed by the machine type's catalog key. */
export function machineGameplay(catalog: FarmCatalog, type: number) {
  const key = (catalog.machineTypes ?? legacyMachineTypes).find(t => t.id === type)?.key;
  return key ? catalog.gameplay?.machines[key] : undefined;
}
