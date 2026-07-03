import { useEffect } from 'react';
import { useAuthStore } from '@/store/authStore';
import { useSettingsStore } from '@/store/settingsStore';

export function useSettingsSync() {
  const userId = useAuthStore((s) => s.user?.id);

  useEffect(() => {
    if (userId) {
      useSettingsStore.getState().hydrate();
    }
  }, [userId]);
}
