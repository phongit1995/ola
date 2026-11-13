import { useEffect } from 'react';
import { registerMegaphoneRealtime } from './megaphoneRealtime';

export function useMegaphoneRealtime() {
  useEffect(() => {
    registerMegaphoneRealtime();
  }, []);
}
