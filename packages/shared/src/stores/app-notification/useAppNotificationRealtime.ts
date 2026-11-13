import { useEffect } from 'react';
import { SocketService } from '../../services/socket.service';
import { useAuthStore } from '../auth/authStore';
import { registerAppNotificationRealtime } from './appNotificationRealtime';
import { useAppNotificationStore } from './appNotificationStore';

export function useAppNotificationRealtime() {
  const userId = useAuthStore((s) => s.user?.id ?? null);

  useEffect(() => {
    registerAppNotificationRealtime();
  }, []);

  useEffect(() => {
    if (userId == null) return;
    void useAppNotificationStore.getState().refreshUnread();
    return SocketService.onReconnect(() => {
      void useAppNotificationStore.getState().refreshUnread();
    });
  }, [userId]);
}
