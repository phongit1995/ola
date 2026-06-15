import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import type { AdminAccount } from '@/types'

interface AuthState {
  admin: AdminAccount | null
  setAdmin: (admin: AdminAccount) => void
  clear: () => void
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      admin: null,
      setAdmin: (admin) => set({ admin }),
      clear: () => set({ admin: null }),
    }),
    {
      name: 'ola.admin.auth',
      partialize: (state) => ({ admin: state.admin }),
    },
  ),
)
