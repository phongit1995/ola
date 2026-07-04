import { lazy, Suspense } from 'react';
import { ReconnectingBanner, ToastViewport } from '@components';
import { useSoundUnlock, useAuthSessionSync, useReconnectOnVisible, useSettingsSync } from '@hooks';
import { AppRouter } from '@/routes';
import { useLayoutStore } from '@/store/layoutStore';
import { useMediaViewerStore } from '@/store/mediaViewerStore';
import { useKenTreasureStore } from '@/pages/games/ken-treasure/kenTreasureStore';
import { useKenRealtime } from '@/pages/games/ken-treasure/useKenRealtime';
import { useMeNotificationRealtime } from '@/pages/me/useMeNotificationRealtime';

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
  const wide = useLayoutStore((s) => s.wide);

  useSoundUnlock();
  useAuthSessionSync();
  useSettingsSync();
  useReconnectOnVisible();
  useKenRealtime();
  useMeNotificationRealtime();

  return (
    <>
      <div
        className={`relative mx-auto flex h-dvh w-full flex-col overflow-hidden bg-white shadow-2xl [transform:translateZ(0)] ${
          wide ? 'max-w-none' : 'max-w-[580px]'
        }`}
      >
        <AppRouter />
        <ReconnectingBanner />
        <ToastViewport />
        <div id="ola-portal" />
        <GlobalKenTreasure />
      </div>
      <GlobalMediaViewer />
    </>
  );
}

export default App;
