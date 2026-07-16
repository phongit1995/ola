import { useEffect } from 'react';
import { SocketService } from '@ola/shared/services';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import type { MeNotification } from '@ola/shared/types';

interface MeNotificationIncoming {
  notification?: MeNotification | null;
  removedId?: string | null;
  unreadCount: number;
}

export function useMeNotificationRealtime() {
  const userId = useAuthStore((s) => s.user?.id ?? null);

  useEffect(() => {
    return SocketService.on<MeNotificationIncoming>('ME_NOTIFICATION', (data) => {
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
