import { useCallback, useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { ensureFreshToken } from '@ola/shared/api';
import { ARCADE_BRIDGE_EVENT, ARCADE_BRIDGE_SOURCE } from '@ola/shared/constants';
import type { ArcadeBridgeMessage, ArcadeKenUpdatedData } from '@ola/shared/types';
import { Avatar } from '@components';
import { colorForName } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { useArcadeOverlayStore } from '@/store/arcadeOverlayStore';
import {
  readBubbleOffset,
  readMinimizeOffset,
  storeBubbleOffset,
  storeMinimizeOffset,
} from './arcadePositions';
import { useDraggableOffset } from './useDraggableOffset';

interface MinimizeHandleProps {
  slug: string;
  label: string;
  visible: boolean;
  onMinimize: () => void;
}

function MinimizeHandle({
  slug,
  label,
  visible,
  onMinimize,
}: MinimizeHandleProps) {
  const storeOffset = useCallback(
    (offset: Parameters<typeof storeMinimizeOffset>[1]) =>
      storeMinimizeOffset(slug, offset),
    [slug]
  );
  const { setElement, dragHandlers } = useDraggableOffset({
    initialOffset: readMinimizeOffset(slug),
    onCommit: storeOffset,
    onTap: onMinimize,
    visible,
  });

  return (
    <button
      ref={setElement}
      type="button"
      aria-label={label}
      {...dragHandlers}
      className="absolute top-3 right-3 z-10 flex h-9 w-9 cursor-grab touch-none items-center justify-center rounded-full bg-black/45 text-white transition-colors select-none [will-change:transform] hover:bg-black/65 active:cursor-grabbing"
    >
      <span className="pointer-events-none block h-0.5 w-4 rounded-full bg-white" />
    </button>
  );
}

export function ArcadeOverlay() {
  const { t } = useTranslation();
  const active = useArcadeOverlayStore((s) => s.active);
  const minimized = useArcadeOverlayStore((s) => s.minimized);
  const notify = useArcadeOverlayStore((s) => s.notify);
  const minimize = useArcadeOverlayStore((s) => s.minimize);
  const restore = useArcadeOverlayStore((s) => s.restore);
  const close = useArcadeOverlayStore((s) => s.close);
  const ken = useAuthStore((s) => s.user?.ken);
  const iframeRef = useRef<HTMLIFrameElement>(null);
  const {
    setElement: setBubbleElement,
    dragHandlers: bubbleDragHandlers,
  } = useDraggableOffset({
    initialOffset: readBubbleOffset(),
    onCommit: storeBubbleOffset,
    onTap: restore,
    visible: minimized,
  });
  const postKenToGame = useCallback(
    (nextKen: number | undefined) => {
      if (
        !active ||
        typeof nextKen !== 'number' ||
        !Number.isSafeInteger(nextKen) ||
        nextKen < 0
      ) {
        return;
      }
      iframeRef.current?.contentWindow?.postMessage(
        {
          source: ARCADE_BRIDGE_SOURCE.Host,
          type: ARCADE_BRIDGE_EVENT.KenUpdated,
          data: { ken: nextKen } satisfies ArcadeKenUpdatedData,
        } satisfies ArcadeBridgeMessage<ArcadeKenUpdatedData>,
        new URL(active.gameUrl).origin
      );
    },
    [active]
  );

  useEffect(() => {
    if (!active) return;
    const gameOrigin = new URL(active.gameUrl).origin;

    async function onMessage(event: MessageEvent) {
      if (event.origin !== gameOrigin) return;
      if (event.source !== iframeRef.current?.contentWindow) return;
      const data = event.data as ArcadeBridgeMessage;
      if (data?.source !== ARCADE_BRIDGE_SOURCE.Game) return;
      if (data.type === ARCADE_BRIDGE_EVENT.Ready) {
        postKenToGame(useAuthStore.getState().user?.ken);
      }
      if (data.type === ARCADE_BRIDGE_EVENT.GetToken) {
        try {
          const token = await ensureFreshToken();
          iframeRef.current?.contentWindow?.postMessage(
            {
              source: ARCADE_BRIDGE_SOURCE.Host,
              type: ARCADE_BRIDGE_EVENT.Token,
              data: token,
            },
            gameOrigin
          );
        } catch {
          iframeRef.current?.contentWindow?.postMessage(
            {
              source: ARCADE_BRIDGE_SOURCE.Host,
              type: ARCADE_BRIDGE_EVENT.Token,
              data: null,
            },
            gameOrigin
          );
        }
      }
      if (data.type === ARCADE_BRIDGE_EVENT.RefreshUser) {
        void useAuthStore.getState().refreshUser();
      }
      const overlay = useArcadeOverlayStore.getState();
      if (
        overlay.minimized &&
        (data.type === ARCADE_BRIDGE_EVENT.AttentionRequired ||
          data.type === ARCADE_BRIDGE_EVENT.GameOver ||
          (data.type === ARCADE_BRIDGE_EVENT.TurnChanged &&
            (data.data as { yourTurn?: boolean } | undefined)?.yourTurn ===
              true))
      ) {
        overlay.setNotify(true);
      }
      if (data.type === ARCADE_BRIDGE_EVENT.Exit) {
        close();
      }
    }

    window.addEventListener('message', onMessage);
    return () => window.removeEventListener('message', onMessage);
  }, [active, close, postKenToGame]);

  useEffect(() => {
    postKenToGame(ken);
  }, [ken, postKenToGame]);

  if (!active) return null;

  return (
    <>
      <div
        className={`absolute inset-0 z-50 bg-[#0f0f23] ${
          minimized ? 'invisible' : ''
        }`}
      >
        <MinimizeHandle
          key={active.slug}
          slug={active.slug}
          label={t('arcade.minimize')}
          visible={!minimized}
          onMinimize={minimize}
        />
        <iframe
          ref={iframeRef}
          src={active.gameUrl}
          title={active.name}
          className="h-full w-full border-0"
          allow="autoplay; fullscreen"
        />
      </div>

      {minimized && (
        <div
          ref={setBubbleElement}
          role="button"
          tabIndex={0}
          aria-label={
            notify
              ? `${t('arcade.restore')}. ${t('arcade.hasNotification')}`
              : t('arcade.restore')
          }
          {...bubbleDragHandlers}
          onKeyDown={(event) => {
            if (event.key === 'Enter' || event.key === ' ') {
              event.preventDefault();
              restore();
            }
          }}
          className={`absolute right-4 bottom-24 z-50 flex h-14 w-14 cursor-grab touch-none select-none items-center justify-center rounded-full border-2 border-white bg-white shadow-lg [will-change:transform] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-ola-accent active:cursor-grabbing ${
            notify ? 'border-ola-warning' : ''
          }`}
        >
          <span className="pointer-events-none">
            <Avatar
              name={active.name}
              color={colorForName(active.name)}
              src={active.iconUrl}
              size={52}
              rounded
            />
          </span>
          {notify && (
            <span
              aria-hidden="true"
              className="pointer-events-none absolute -top-1 -right-1 h-4 w-4 animate-blink rounded-full border-2 border-white bg-ola-warning"
            />
          )}
        </div>
      )}
    </>
  );
}
