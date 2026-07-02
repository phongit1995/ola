import { useEffect } from 'react';
import { SocketService } from '@services';

export function useReconnectOnVisible() {
  useEffect(() => {
    const onVisibility = () => {
      if (document.visibilityState === 'visible') SocketService.ensureAlive();
    };

    const onPageShow = (event: PageTransitionEvent) => {
      if (event.persisted) SocketService.ensureAlive();
    };

    const onOnline = () => {
      if (document.visibilityState === 'visible') SocketService.ensureAlive();
    };

    document.addEventListener('visibilitychange', onVisibility);
    window.addEventListener('pageshow', onPageShow);
    window.addEventListener('online', onOnline);
    return () => {
      document.removeEventListener('visibilitychange', onVisibility);
      window.removeEventListener('pageshow', onPageShow);
      window.removeEventListener('online', onOnline);
    };
  }, []);
}
