import { MEGAPHONE_SOCKET_EVENTS } from '../../constants/socket';
import { SocketService } from '../../services/socket.service';
import type { MegaphoneNewEvent, MegaphoneRemovedEvent } from '../../types/realtime/megaphone.type';
import { useAuthStore } from '../auth/authStore';
import { claimRealtimeRegistration } from '../realtimeRegistration.state';
import { useMegaphoneStore } from './megaphoneStore';

export function registerMegaphoneRealtime() {
  if (!claimRealtimeRegistration('megaphone')) return;

  SocketService.onReconnect(() => {
    if (useAuthStore.getState().user) void useMegaphoneStore.getState().sync();
  });

  SocketService.on<MegaphoneNewEvent>(MEGAPHONE_SOCKET_EVENTS.created, (data) => {
    if (!useAuthStore.getState().user || data?.megaphone?.id == null) return;
    useMegaphoneStore.getState().receive(data.megaphone, data.serverTime);
  });

  SocketService.on<MegaphoneRemovedEvent>(MEGAPHONE_SOCKET_EVENTS.removed, (data) => {
    if (data?.id) useMegaphoneStore.getState().remove(data.id);
  });
}
