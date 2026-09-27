import type { ArtLoadProgress } from '../../render/types/Art.types';
import type { StringKey } from '../../core/i18n/I18n.types';

/** String key shown for each loading phase. */
export const STATUS: Record<ArtLoadProgress['phase'], StringKey> = {
  data: 'loading.data',
  town: 'loading.town',
  ported: 'loading.ported',
  'town-ui': 'loading.townUi',
  'plot-ui': 'loading.plotUi',
  'island-ui': 'loading.islandUi',
  ready: 'loading.ready',
};
