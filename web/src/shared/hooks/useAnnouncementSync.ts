import { useEffect } from 'react';
import { useAuthStore } from '@/store/authStore';
import { useAnnouncementStore } from '@/store/announcementStore';

export function useAnnouncementSync() {
  const userId = useAuthStore((s) => s.user?.id);

  useEffect(() => {
    if (userId) {
      void useAnnouncementStore.getState().load();
    }
  }, [userId]);
}
