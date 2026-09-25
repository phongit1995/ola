import fs from 'node:fs';
import path from 'node:path';
import { withFarmTiming } from '../assets/farm/scripts/core/FarmTiming';
import type { FarmContentSource } from '../assets/farm/scripts/core/types/EconomyTypes';
import { withFarmEconomy } from '../assets/farm/scripts/core/FarmEconomy';
import { withFarmGameplay } from '../assets/farm/scripts/core/FarmGameplay';
import { withFarmRuntime } from '../assets/farm/scripts/core/FarmRuntime';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';

/** Node equivalent of Art.loadTown; always reads the current files, including local timing edits. */
export function loadFarmCatalog(): FarmCatalog {
  const directory = path.join(__dirname, '../assets/farm/bundles/farm-town');
  const read = (name: string): unknown => JSON.parse(fs.readFileSync(path.join(directory, name), 'utf8'));
  const catalog = withFarmTiming(
    withFarmEconomy(read('catalog.json') as FarmContentSource, read('economy.json')),
    read('timing.json')
  );
  return withFarmRuntime(withFarmGameplay(catalog, read('gameplay.json')), read('runtime.json'));
}
