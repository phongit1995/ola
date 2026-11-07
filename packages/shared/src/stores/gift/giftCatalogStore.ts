import { create } from 'zustand';
import { DEFAULT_GIFT_SETTINGS } from '../../constants/gift';
import { GiftService } from '../../services/gift.service';
import type { GiftCatalogState } from '../../types/client/gift.type';
import { loadAppConfig } from '../appConfigStore';

export const useGiftCatalogStore = create<GiftCatalogState>((set, get) => ({
  items: [],
  settings: DEFAULT_GIFT_SETTINGS,
  loaded: false,
  loading: false,
  error: false,
  load: async (force = false) => {
    const state = get();
    if (state.loading || (state.loaded && !force)) return;
    set({ loading: true, error: false });
    try {
      const [catalog, config] = await Promise.all([GiftService.catalog(), loadAppConfig('gift')]);
      set({ items: catalog.items, settings: config ?? catalog.settings, loaded: true, loading: false });
    } catch {
      set({ loading: false, error: true });
    }
  },
  loadSettings: async () => {
    const config = await loadAppConfig('gift');
    if (config != null) set({ settings: config });
  },
  reset: () =>
    set({ items: [], settings: DEFAULT_GIFT_SETTINGS, loaded: false, loading: false, error: false }),
}));
