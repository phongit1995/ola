import { useEffect } from 'react';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';

export function useSettingsSync() {
  const userId = useAuthStore((s) => s.user?.id);

  useEffect(() => {
    if (userId) {
      useSettingsStore.getState().hydrate();
    }
  }, [userId]);
}
