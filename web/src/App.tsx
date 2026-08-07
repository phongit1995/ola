import { lazy, Suspense } from 'react';
import { ReconnectingBanner, ToastViewport } from '@components';
import { CALL_MODE } from '@constants';
import {
  useSoundUnlock,
  useAuthSessionSync,
  useReconnectOnVisible,
  useSettingsSync,
} from '@hooks';
import { AppRouter } from '@/routes';
import { useArcadeOverlayStore } from '@/store/arcadeOverlayStore';
import { useCallStore } from '@/store/callStore';
import { useMediaViewerStore } from '@/store/mediaViewerStore';
import { useKenTreasureStore } from '@/pages/games/ken-treasure/kenTreasureStore';
import { useKenRealtime } from '@/pages/games/ken-treasure/useKenRealtime';
import { useMeNotificationRealtime } from '@/pages/me/useMeNotificationRealtime';
import { useAppNotificationRealtime } from '@/pages/apps/useAppNotificationRealtime';
import { useSettingsStore } from '@/store/settingsStore';

const MediaViewer = lazy(() =>
  import('@/pages/me/components/MediaViewer').then((m) => ({
    default: m.MediaViewer,
  }))
);

const KenTreasureOverlay = lazy(() =>
  import('@/pages/games/ken-treasure/KenTreasureOverlay').then((m) => ({
    default: m.KenTreasureOverlay,
  }))
);

const ArcadeOverlay = lazy(() =>
  import('@/pages/apps/ArcadeOverlay').then((m) => ({
    default: m.ArcadeOverlay,
  }))
);

const CallOverlay = lazy(() =>
  import('@/pages/call/CallOverlay').then((m) => ({
    default: m.CallOverlay,
  }))
);

function GlobalCall() {
  const idle = useCallStore((s) => s.mode === CALL_MODE.idle);
  if (idle) return null;
  return (
    <Suspense fallback={null}>
      <CallOverlay />
    </Suspense>
  );
}

function GlobalArcade() {
  const hasActive = useArcadeOverlayStore((s) => s.active != null);
  if (!hasActive) return null;
  return (
    <Suspense fallback={null}>
      <ArcadeOverlay />
    </Suspense>
  );
}

function GlobalKenTreasure() {
  const hasChest = useKenTreasureStore((s) => Object.keys(s.chests).length > 0);
  if (!hasChest) return null;
  return (
    <Suspense fallback={null}>
      <KenTreasureOverlay />
    </Suspense>
  );
}

function GlobalMediaViewer() {
  const open = useMediaViewerStore((s) => s.open);
  const images = useMediaViewerStore((s) => s.images);
  const index = useMediaViewerStore((s) => s.index);
  const close = useMediaViewerStore((s) => s.close);
  if (!open || images.length === 0) return null;
  return (
    <Suspense fallback={null}>
      <MediaViewer
        key={`${index}-${images[0]}`}
        photos={images}
        index={index}
        onClose={close}
      />
    </Suspense>
  );
}

function App() {
  useSoundUnlock();
  useAuthSessionSync();
  useSettingsSync();
  useReconnectOnVisible();
  useKenRealtime();
  useMeNotificationRealtime();
  useAppNotificationRealtime();
  const fontSize = useSettingsStore((state) => state.settings.fontSize);

  return (
    <div data-font-size={fontSize}>
      <div className="relative mx-auto flex h-dvh w-full max-w-[520px] flex-col overflow-hidden bg-white shadow-2xl [transform:translateZ(0)]">
        <AppRouter />
        <ReconnectingBanner />
        <ToastViewport />
        <div id="ola-portal" />
        <GlobalKenTreasure />
        <GlobalArcade />
        <GlobalCall />
      </div>
      <div id="ola-call-portal" />
      <GlobalMediaViewer />
    </div>
  );
}

export default App;
