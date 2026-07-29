import type { AuthUser } from '../api/auth.type';

export interface AuthState {
  user: AuthUser | null;
  authReady: boolean;
  setUser: (user: AuthUser) => void;
  clearUser: () => void;
  refreshUser: () => Promise<void>;
}

export interface PersistedAuthState {
  user: AuthUser | null;
}
