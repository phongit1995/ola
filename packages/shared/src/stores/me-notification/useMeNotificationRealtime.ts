import { useEffect } from 'react';
import { ME_NOTIFICATION_SOCKET_EVENT } from '../../constants/socket';
import { SocketService } from '../../services/socket.service';
import type { MeNotificationIncoming } from '../../types/realtime/notification.type';
import { useAuthStore } from '../auth/authStore';
import { useMeNotificationStore } from './meNotificationStore';

export function useMeNotificationRealtime() {
  const userId = useAuthStore((s) => s.user?.id ?? null);

  useEffect(() => {
    return SocketService.on<MeNotificationIncoming>(ME_NOTIFICATION_SOCKET_EVENT, (data) => {
      if (data?.notification == null && data?.removedId == null) return;
      useMeNotificationStore.getState().handleIncoming(data);
    });
  }, []);

  useEffect(() => {
    if (userId == null) return;
    void useMeNotificationStore.getState().refreshUnread();
    return SocketService.onReconnect(() => {
      void useMeNotificationStore.getState().refreshUnread();
    });
  }, [userId]);
}
