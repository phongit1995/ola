import { KEN_SOCKET_EVENTS } from '../constants/socket';
import { SocketService } from '../services/socket.service';
import { playKenCreditSound } from '../platform/sound';
import type {
  KenChestAvailableEvent,
  KenChestClosedEvent,
  KenUpdatedEvent,
} from '../types/realtime/ken.type';
import { useAuthStore } from './authStore';
import {
  markKenRealtimeUpdate,
  resyncKenBalance,
} from './kenResync.state';
import { useKenTreasureStore } from './kenTreasureStore';
import { claimRealtimeRegistration } from './realtimeRegistration.state';

export { resyncKenBalance } from './kenResync.state';

export function registerKenRealtime() {
  if (!claimRealtimeRegistration('ken')) return;

  SocketService.onReconnect(() => {
    void resyncKenBalance();
  });

  SocketService.on<KenUpdatedEvent>(KEN_SOCKET_EVENTS.updated, (data) => {
    if (typeof data?.ken !== 'number') return;
    markKenRealtimeUpdate();
    const { user, setUser } = useAuthStore.getState();
    if (!user) return;
    if (data.ken > (user.ken ?? 0)) playKenCreditSound();
    setUser({ ...user, ken: data.ken });
  });

  SocketService.on<KenChestAvailableEvent>(KEN_SOCKET_EVENTS.chestAvailable, (data) => {
    if (!useAuthStore.getState().user) return;
    if (data?.id && data.expiresAt)
      useKenTreasureStore.getState().show({ id: data.id, expiresAt: data.expiresAt });
  });

  SocketService.on<KenChestClosedEvent>(KEN_SOCKET_EVENTS.chestClosed, (data) => {
    const state = useKenTreasureStore.getState();
    const chest = data?.id ? state.chests[data.id] : undefined;
    if (chest && chest.phase === 'closed') state.dismiss(data.id);
  });
}
