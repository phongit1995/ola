import type { Gift, GiftSettings } from '../api/gift.type';

export interface GiftCatalogState {
  items: Gift[];
  settings: GiftSettings;
  loaded: boolean;
  loading: boolean;
  error: boolean;
  load: (force?: boolean) => Promise<void>;
  reset: () => void;
}
