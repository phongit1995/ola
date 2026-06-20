import { lazy, Suspense, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { setOnUnauthorized } from '@api';
import { ToastViewport } from '@components';
import { authTokens, toast } from '@lib';
import { SocketService } from '@services';
import { AppRouter } from '@/routes';
import { useAuthStore } from '@/store/authStore';
import { useLayoutStore } from '@/store/layoutStore';
import { useMediaViewerStore } from '@/store/mediaViewerStore';

const MediaViewer = lazy(() =>
  import('@/pages/me/components/MediaViewer').then((m) => ({ default: m.MediaViewer })),
);

function GlobalMediaViewer() {
  const open = useMediaViewerStore((s) => s.open);
  const photos = useMediaViewerStore((s) => s.photos);
  const index = useMediaViewerStore((s) => s.index);
  const closeViewer = useMediaViewerStore((s) => s.closeViewer);
  if (!open || photos.length === 0) return null;
  return (
    <Suspense fallback={null}>
      <MediaViewer key={`${index}-${photos[0]}`} photos={photos} index={index} onClose={closeViewer} />
    </Suspense>
  );
}

function App() {
  const { t } = useTranslation();
  const wide = useLayoutStore((s) => s.wide);

  useEffect(() => {
    setOnUnauthorized(() => {
      SocketService.disconnect();
      authTokens.clear();
      useAuthStore.getState().clearUser();
    });
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
    return SocketService.on<{ ken?: number }>('KEN_UPDATED', (data) => {
      if (typeof data?.ken !== 'number') return;
      const { user, setUser } = useAuthStore.getState();
      if (user) setUser({ ...user, ken: data.ken });
    });
  }, []);

  useEffect(() => {
    useAuthStore.getState().refreshUser();
  }, []);

  return (
    <>
      <div
        className={`relative mx-auto flex h-dvh w-full flex-col overflow-hidden bg-white shadow-2xl [transform:translateZ(0)] ${
          wide ? 'max-w-none' : 'max-w-[645px]'
        }`}
      >
        <AppRouter />
        <ToastViewport />
        <div id="ola-portal" />
      </div>
      <GlobalMediaViewer />
    </>
  );
}

export default App;
