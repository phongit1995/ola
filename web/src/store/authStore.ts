import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { authTokens } from '@lib';
import { UserService } from '@services';
import type { AuthUser } from '@app-types';

interface AuthState {
  user: AuthUser | null;
  setUser: (user: AuthUser) => void;
  clearUser: () => void;
  refreshUser: () => Promise<void>;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      setUser: (user) => set({ user }),
      clearUser: () => set({ user: null }),
      refreshUser: async () => {
        if (!authTokens.getAccessToken()) return;
        try {
          const user = await UserService.me();
          set({ user });
        } catch {
          return;
        }
      },
    }),
    {
      name: 'ola.auth',
      partialize: (state) => ({ user: state.user }),
    }
  )
);
