import type { StringKey } from '../../core/i18n/I18n.types';

/** String keys for each species' short name; translate with `t` where it is shown. */
export const penNames: Readonly<Record<string, StringKey>> = {
  layer: 'species.layer',
  'dairy-cow': 'species.dairyCow',
  pig: 'species.pig',
  sheep: 'species.sheep',
};

/** String keys for a slot whose product is ready, by species. */
export const READY_LABELS: Readonly<Record<string, StringKey>> = {
  layer: 'livestock.hasEggs',
  'dairy-cow': 'livestock.hasMilk',
  pig: 'livestock.hasBacon',
  sheep: 'livestock.hasWool',
};

export const yardPrefabs: Record<string, string> = {
  layer: 'yard-coop',
  'dairy-cow': 'yard-cowshed',
  pig: 'yard-pigpen',
  sheep: 'yard-sheepfold',
};
