import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { setOnUnauthorized } from '@api';
import { ToastViewport } from '@components';
import { authTokens, toast } from '@lib';
import { SocketService } from '@services';
import { AppRouter } from '@/routes';
import { useAuthStore } from '@/store/authStore';

function App() {
  const { t } = useTranslation();

  useEffect(() => {
    setOnUnauthorized(() => useAuthStore.getState().clearUser());
    return () => setOnUnauthorized(null);
  }, []);

  useEffect(() => {
    return SocketService.onSessionReplaced(() => {
      SocketService.disconnect();
      authTokens.clear();
      useAuthStore.getState().clearUser();
      toast.info(t('auth.sessionReplaced'));
    });
  }, [t]);

  useEffect(() => {
    useAuthStore.getState().refreshUser();
  }, []);

  return (
    <>
      <AppRouter />
      <ToastViewport />
    </>
  );
}

export default App;
