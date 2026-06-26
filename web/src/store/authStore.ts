import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { authTokens } from '@lib';
import { UserService } from '@services';
import type { AuthUser } from '@app-types';

interface AuthState {
  user: AuthUser | null;
  authReady: boolean;
  setUser: (user: AuthUser) => void;
  clearUser: () => void;
  refreshUser: () => Promise<void>;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      authReady: false,
      setUser: (user) => set({ user }),
      clearUser: () => set({ user: null }),
      refreshUser: async () => {
        if (!authTokens.getAccessToken()) {
          set({ authReady: true });
          return;
        }
        try {
          const user = await UserService.me();
          set({ user, authReady: true });
        } catch {
          set({ authReady: true });
        }
      },
    }),
    {
      name: 'ola.auth',
      partialize: (state) => ({ user: state.user }),
    }
  )
);
