import { lazy, Suspense, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { setOnUnauthorized } from '@api';
import { ReconnectingBanner, ToastViewport } from '@components';
import { authTokens, toast } from '@lib';
import { SocketService } from '@services';
import { AppRouter } from '@/routes';
import { useAuthStore } from '@/store/authStore';
import { useLayoutStore } from '@/store/layoutStore';
import { useMediaViewerStore } from '@/store/mediaViewerStore';
import { useKenTreasureStore } from '@/pages/games/ken-treasure/kenTreasureStore';

const MediaViewer = lazy(() =>
  import('@/pages/me/components/MediaViewer').then((m) => ({ default: m.MediaViewer })),
);

const KenTreasureOverlay = lazy(() =>
  import('@/pages/games/ken-treasure/KenTreasureOverlay').then((m) => ({
    default: m.KenTreasureOverlay,
  })),
);

function GlobalKenTreasure() {
  const phase = useKenTreasureStore((s) => s.phase);
  if (phase === 'idle') return null;
  return (
    <Suspense fallback={null}>
      <KenTreasureOverlay />
    </Suspense>
  );
}

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
  const userId = useAuthStore((s) => s.user?.id);

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
    const reconnectWhenVisible = () => {
      if (document.visibilityState === 'visible') SocketService.ensureConnected();
    };
    document.addEventListener('visibilitychange', reconnectWhenVisible);
    return () => document.removeEventListener('visibilitychange', reconnectWhenVisible);
  }, []);

  useEffect(() => {
    return SocketService.on<{ ken?: number }>('KEN_UPDATED', (data) => {
      if (typeof data?.ken !== 'number') return;
      const { user, setUser } = useAuthStore.getState();
      if (user) setUser({ ...user, ken: data.ken });
    });
  }, []);

  useEffect(() => {
    if (!userId) return;
    void useKenTreasureStore.getState().syncFromActive();
  }, [userId]);

  useEffect(() => {
    const offAvailable = SocketService.on<{ id: string; expiresAt: string }>(
      'KEN_CHEST_AVAILABLE',
      (data) => {
        if (data?.id) useKenTreasureStore.getState().show({ id: data.id, expiresAt: data.expiresAt });
      }
    );
    const offClosed = SocketService.on<{ id: string }>('KEN_CHEST_CLOSED', (data) => {
      const state = useKenTreasureStore.getState();
      if (data?.id && state.chestId === data.id && state.phase === 'closed') state.dismiss();
    });
    const offReconnect = SocketService.onReconnect(() => {
      void useKenTreasureStore.getState().syncFromActive();
    });
    return () => {
      offAvailable();
      offClosed();
      offReconnect();
    };
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
        <ReconnectingBanner />
        <ToastViewport />
        <div id="ola-portal" />
      </div>
      <GlobalMediaViewer />
      <GlobalKenTreasure />
    </>
  );
}

export default App;
