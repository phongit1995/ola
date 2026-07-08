import { useAuthStore } from './authStore';

export function syncAuthKen(ken: number) {
  useAuthStore.setState((state) => (state.user ? { user: { ...state.user, ken } } : state));
}
