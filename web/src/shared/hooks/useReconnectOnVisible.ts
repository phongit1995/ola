import { useEffect } from 'react';
import { SocketService } from '@services';
import { resyncKenBalance } from '@ola/shared/stores/ken/kenRealtime';
import { useRoomFilterStore } from '@ola/shared/stores/room/roomFilterStore';

export function useReconnectOnVisible() {
  useEffect(() => {
    const resumeSession = () => {
      SocketService.ensureAlive();
      void resyncKenBalance();
      void useRoomFilterStore.getState().syncBlockedUsers();
    };

    const onVisibility = () => {
      if (document.visibilityState === 'visible') resumeSession();
    };

    const onPageShow = (event: PageTransitionEvent) => {
      if (event.persisted) resumeSession();
    };

    const onOnline = () => {
      if (document.visibilityState === 'visible') resumeSession();
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
