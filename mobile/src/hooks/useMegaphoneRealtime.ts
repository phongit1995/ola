import { useEffect } from 'react';
import { registerMegaphoneRealtime } from '@ola/shared/stores/megaphone/megaphoneRealtime';

export function useMegaphoneRealtime() {
  useEffect(() => {
    registerMegaphoneRealtime();
  }, []);
}
