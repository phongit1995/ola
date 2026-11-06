import { MEGAPHONE_SOCKET_EVENTS } from '../../constants/socket';
import { SocketService } from '../../services/socket.service';
import type { MegaphonePlayEvent, MegaphoneRemovedEvent } from '../../types/realtime/megaphone.type';
import { useAuthStore } from '../auth/authStore';
import { claimRealtimeRegistration } from '../realtimeRegistration.state';
import { useMegaphoneStore } from './megaphoneStore';

export function registerMegaphoneRealtime() {
  if (!claimRealtimeRegistration('megaphone')) return;

  SocketService.on<MegaphonePlayEvent>(MEGAPHONE_SOCKET_EVENTS.play, (data) => {
    if (!useAuthStore.getState().user || data?.megaphone?.id == null) return;
    useMegaphoneStore.getState().play(data.megaphone);
  });

  SocketService.on<MegaphoneRemovedEvent>(MEGAPHONE_SOCKET_EVENTS.removed, (data) => {
    if (data?.id) useMegaphoneStore.getState().remove(data.id);
  });
}
