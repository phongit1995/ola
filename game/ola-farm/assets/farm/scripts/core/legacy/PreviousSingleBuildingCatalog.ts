import type { FarmCatalog } from '../types/CatalogTypes';
import { machineSites, penPlotId } from '../FarmCatalog';

/** The v5/v6 validator sees only the original single-house catalog, never newly added sites. */
export function previousSingleBuildingCatalog(catalog: FarmCatalog): FarmCatalog {
  if (catalog.contentProfile !== 'simple-1') return catalog;
  return {
    ...catalog,
    residentPens: catalog.residentPens?.filter(site => penPlotId(site) < 50),
    machineTypes: catalog.machineTypes?.map(type => ({
      ...type,
      buildSites: undefined,
      buildingIds: machineSites(type).slice(0, 1),
    })),
  };
}
