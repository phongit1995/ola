import { useEffect } from 'react';
import { playKenCreditSound } from '@lib';
import { SocketService } from '@services';
import { useAuthStore } from '@/store/authStore';
import { useKenTreasureStore } from './kenTreasureStore';

export function useKenRealtime() {
  useEffect(() => {
    return SocketService.on<{ ken?: number }>('KEN_UPDATED', (data) => {
      if (typeof data?.ken !== 'number') return;
      const { user, setUser } = useAuthStore.getState();
      if (!user) return;
      if (data.ken > (user.ken ?? 0)) playKenCreditSound();
      setUser({ ...user, ken: data.ken });
    });
  }, []);

  useEffect(() => {
    const offAvailable = SocketService.on<{ id: string; expiresAt: string }>(
      'KEN_CHEST_AVAILABLE',
      (data) => {
        if (data?.id && data.expiresAt)
          useKenTreasureStore.getState().show({ id: data.id, expiresAt: data.expiresAt });
      }
    );
    const offClosed = SocketService.on<{ id: string }>('KEN_CHEST_CLOSED', (data) => {
      const state = useKenTreasureStore.getState();
      const chest = data?.id ? state.chests[data.id] : undefined;
      if (chest && chest.phase === 'closed') state.dismiss(data.id);
    });
    return () => {
      offAvailable();
      offClosed();
    };
  }, []);
}
