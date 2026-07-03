import { useEffect } from 'react';
import { SocketService } from '@services';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useAuthStore } from '@/store/authStore';
import type { MeNotification } from '@app-types';

interface MeNotificationIncoming {
  notification: MeNotification;
  unreadCount: number;
}

export function useMeNotificationRealtime() {
  const userId = useAuthStore((s) => s.user?.id ?? null);

  useEffect(() => {
    return SocketService.on<MeNotificationIncoming>('ME_NOTIFICATION', (data) => {
      if (data?.notification == null) return;
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
