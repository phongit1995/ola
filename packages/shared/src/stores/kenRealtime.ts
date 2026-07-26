import { SocketService } from '../services';
import { playKenCreditSound } from '../platform/sound';
import { useAuthStore } from './authStore';
import { useKenTreasureStore } from './kenTreasureStore';

let registered = false;

export function registerKenRealtime() {
  if (registered) return;
  registered = true;

  SocketService.on<{ ken?: number }>('KEN_UPDATED', (data) => {
    if (typeof data?.ken !== 'number') return;
    const { user, setUser } = useAuthStore.getState();
    if (!user) return;
    if (data.ken > (user.ken ?? 0)) playKenCreditSound();
    setUser({ ...user, ken: data.ken });
  });

  SocketService.on<{ id: string; expiresAt: string }>('KEN_CHEST_AVAILABLE', (data) => {
    if (!useAuthStore.getState().user) return;
    if (data?.id && data.expiresAt)
      useKenTreasureStore.getState().show({ id: data.id, expiresAt: data.expiresAt });
  });

  SocketService.on<{ id: string }>('KEN_CHEST_CLOSED', (data) => {
    const state = useKenTreasureStore.getState();
    const chest = data?.id ? state.chests[data.id] : undefined;
    if (chest && chest.phase === 'closed') state.dismiss(data.id);
  });
}
