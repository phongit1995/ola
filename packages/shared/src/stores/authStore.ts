import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { authTokens } from '../lib';
import { sharedPersistStorage } from '../platform/persistStorage';
import { UserService } from '../services';
import type { AuthUser } from '../types';

interface AuthState {
  user: AuthUser | null;
  authReady: boolean;
  setUser: (user: AuthUser) => void;
  clearUser: () => void;
  refreshUser: () => Promise<void>;
}

const logoutListeners = new Set<() => void>();

export function registerOnLogout(listener: () => void): () => void {
  logoutListeners.add(listener);
  return () => logoutListeners.delete(listener);
}

interface PersistedAuthState {
  user: AuthUser | null;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      authReady: false,
      setUser: (user) => set({ user }),
      clearUser: () => {
        logoutListeners.forEach((listener) => listener());
        set({ user: null });
      },
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
      storage: sharedPersistStorage<PersistedAuthState>(),
      partialize: (state) => ({ user: state.user }),
    }
  )
);
