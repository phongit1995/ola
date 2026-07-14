import { useEffect } from 'react';
import { registerKenRealtime } from '@ola/shared/stores/kenRealtime';

export function useKenRealtime() {
  useEffect(() => {
    registerKenRealtime();
  }, []);
}
