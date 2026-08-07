import { useEffect } from 'react';
import { registerKenRealtime } from '@ola/shared/stores/ken/kenRealtime';

export function useKenRealtime() {
  useEffect(() => {
    registerKenRealtime();
  }, []);
}
