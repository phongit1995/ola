import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { DEFAULT_THEME_ID } from '../constants/theme';
import { sharedPersistStorage } from '../platform/persistStorage';
import type { ThemeState } from '../types/client/theme.type';

export const useThemeStore = create<ThemeState>()(
  persist(
    (set) => ({
      theme: DEFAULT_THEME_ID,
      setTheme: (theme) => set({ theme }),
    }),
    {
      name: 'ola.theme',
      storage: sharedPersistStorage<Pick<ThemeState, 'theme'>>(),
      partialize: (state) => ({ theme: state.theme }),
    }
  )
);
