import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { authTokens } from '../lib/tokenStorage';
import { sharedPersistStorage } from '../platform/persistStorage';
import { UserService } from '../services/user.service';
import type { AuthState, PersistedAuthState } from '../types/client/auth.type';
import { notifyLogoutListeners } from './authLogout.state';

export { registerOnLogout } from './authLogout.state';

export const useAuthStore = create<AuthState>()(
  persist(
    (set, get) => ({
      user: null,
      authReady: false,
      setUser: (user) => set({ user }),
      clearUser: () => {
        notifyLogoutListeners();
        set({ user: null });
      },
      refreshUser: async () => {
        if (!authTokens.getAccessToken()) {
          if (get().user != null) get().clearUser();
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
      storage: sharedPersistStorage<PersistedAuthState>(),
      partialize: (state) => ({ user: state.user }),
    }
  )
);
