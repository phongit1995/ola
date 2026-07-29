import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { DEFAULT_USER_SETTINGS } from '../constants/settings';
import { SettingsService } from '../services/settings.service';
import type { SettingsState } from '../types/client/settings.type';
import { sharedPersistStorage } from '../platform/persistStorage';

export const useSettingsStore = create<SettingsState>()(
  persist(
    (set, get) => ({
      settings: DEFAULT_USER_SETTINGS,
      loaded: false,
      hydrate: async () => {
        try {
          const settings = await SettingsService.get();
          set({ settings, loaded: true });
        } catch {
          set({ loaded: true });
        }
      },
      update: async (patch) => {
        const previous = get().settings;
        set({ settings: { ...previous, ...patch } });
        try {
          const saved = await SettingsService.update(patch);
          set({ settings: saved });
          return true;
        } catch {
          set({ settings: previous });
          return false;
        }
      },
      reset: () => set({ settings: DEFAULT_USER_SETTINGS, loaded: false }),
    }),
    {
      name: 'ola.settings',
      storage: sharedPersistStorage<Pick<SettingsState, 'settings'>>(),
      partialize: (state) => ({ settings: state.settings }),
    }
  )
);
