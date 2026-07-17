import { useEffect } from 'react';
import { SocketService } from '@ola/shared/services';
import { registerAppNotificationRealtime } from '@ola/shared/stores/appNotificationRealtime';
import { useAppNotificationStore } from '@ola/shared/stores/appNotificationStore';
import { useAuthStore } from '@ola/shared/stores/authStore';

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
