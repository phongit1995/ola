import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { AuthUser } from '@app-types';

interface AuthState {
  user: AuthUser | null;
  setUser: (user: AuthUser) => void;
  clearUser: () => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      setUser: (user) => set({ user }),
      clearUser: () => set({ user: null }),
    }),
    {
      name: 'ola.auth',
      partialize: (state) => ({ user: state.user }),
    }
  )
);
