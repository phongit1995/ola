import { useEffect } from 'react';
import { registerKenRealtime } from './kenRealtime';

export function useKenRealtime() {
  useEffect(() => {
    registerKenRealtime();
  }, []);
}
