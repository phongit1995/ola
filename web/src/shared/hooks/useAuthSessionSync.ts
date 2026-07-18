import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { setOnUnauthorized } from '@api';
import { authTokens, toast } from '@lib';
import { SocketService } from '@services';
import { useAuthStore } from '@/store/authStore';

function clearSession() {
  SocketService.disconnect();
  authTokens.clear();
  useAuthStore.getState().clearUser();
}

export function useAuthSessionSync() {
  const { t } = useTranslation();

  useEffect(() => {
    setOnUnauthorized(clearSession);
    return () => setOnUnauthorized(null);
  }, []);

  useEffect(() => {
    return SocketService.onSessionReplaced(() => {
      clearSession();
      toast.info(t('auth.sessionReplaced'));
    });
  }, [t]);

  useEffect(() => {
    return SocketService.onForceLogout(({ reason }) => {
      clearSession();
      if (reason === 'banned') toast.error(t('auth.banned'));
      else if (reason !== 'logged_out') toast.info(t('auth.sessionEnded'));
    });
  }, [t]);

  useEffect(() => {
    useAuthStore.getState().refreshUser();
  }, []);
}
