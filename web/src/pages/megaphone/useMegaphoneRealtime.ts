import { useEffect } from 'react';
import { registerMegaphoneRealtime } from '@ola/shared/stores/megaphone/megaphoneRealtime';
import { useMegaphoneStore } from '@ola/shared/stores/megaphone/megaphoneStore';
import { useAuthStore } from '@/store/authStore';

export function useMegaphoneRealtime() {
  const userId = useAuthStore((s) => s.user?.id);

  useEffect(() => {
    registerMegaphoneRealtime();
  }, []);

  useEffect(() => {
    if (userId != null) void useMegaphoneStore.getState().sync();
  }, [userId]);
}
