import { useEffect } from 'react';
import { SocketService } from '@services';

export function useReconnectOnVisible() {
  useEffect(() => {
    const reconnectWhenVisible = () => {
      if (document.visibilityState === 'visible') SocketService.ensureConnected();
    };
    document.addEventListener('visibilitychange', reconnectWhenVisible);
    return () => document.removeEventListener('visibilitychange', reconnectWhenVisible);
  }, []);
}
