import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { SettingsService } from '@services';
import { DEFAULT_USER_SETTINGS } from '@app-types';
import type { UserSettings, UpdateSettingsRequest } from '@app-types';

interface SettingsState {
  settings: UserSettings;
  loaded: boolean;
  hydrate: () => Promise<void>;
  update: (patch: UpdateSettingsRequest) => Promise<boolean>;
  reset: () => void;
}

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
      partialize: (state) => ({ settings: state.settings }),
    }
  )
);
