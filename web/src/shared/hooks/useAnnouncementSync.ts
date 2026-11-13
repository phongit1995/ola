import { useEffect } from 'react';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useAnnouncementStore } from '@ola/shared/stores/announcementStore';

export function useAnnouncementSync() {
  const userId = useAuthStore((s) => s.user?.id);

  useEffect(() => {
    if (userId) {
      void useAnnouncementStore.getState().load();
    }
  }, [userId]);
}
