import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { ensureFreshToken } from '@ola/shared/api';
import { Avatar } from '@components';
import { useDraggable } from '@hooks';
import { colorForName } from '@lib';
import { useArcadeOverlayStore } from '@/store/arcadeOverlayStore';

interface GameBridgeMessage {
  source?: string;
  type?: string;
}

export function ArcadeOverlay() {
  const { t } = useTranslation();
  const active = useArcadeOverlayStore((s) => s.active);
  const minimized = useArcadeOverlayStore((s) => s.minimized);
  const notify = useArcadeOverlayStore((s) => s.notify);
  const minimize = useArcadeOverlayStore((s) => s.minimize);
  const restore = useArcadeOverlayStore((s) => s.restore);
  const close = useArcadeOverlayStore((s) => s.close);
  const iframeRef = useRef<HTMLIFrameElement>(null);
  const {
    ref: bubbleRef,
    onPointerDown: onBubbleDown,
    onPointerMove: onBubbleMove,
    onPointerUp: onBubbleUp,
  } = useDraggable<HTMLButtonElement>({ onClick: restore });

  useEffect(() => {
    if (!active) return;
    const gameOrigin = new URL(active.gameUrl).origin;

    async function onMessage(event: MessageEvent) {
      if (event.origin !== gameOrigin) return;
      const data = event.data as GameBridgeMessage;
      if (data?.source !== 'ola-game') return;
      if (data.type === 'get_token') {
        const token = await ensureFreshToken();
        iframeRef.current?.contentWindow?.postMessage(
          { source: 'ola-host', type: 'token', data: token },
          gameOrigin,
        );
      }
      if (data.type === 'exit') {
        close();
      }
    }

    window.addEventListener('message', onMessage);
    return () => window.removeEventListener('message', onMessage);
  }, [active, close]);

  if (!active) return null;

  return (
    <>
      <div className={`absolute inset-0 z-50 bg-[#0f0f23] ${minimized ? 'invisible' : ''}`}>
        <button
          type="button"
          aria-label={t('arcade.minimize')}
          onClick={minimize}
          className="absolute top-3 right-3 z-10 flex h-9 w-9 items-center justify-center rounded-full bg-black/45 text-white transition hover:bg-black/65"
        >
          <span className="block h-0.5 w-4 rounded-full bg-white" />
        </button>
        <iframe
          ref={iframeRef}
          src={active.gameUrl}
          title={active.name}
          className="h-full w-full border-0"
          allow="autoplay; fullscreen"
        />
      </div>

      {minimized && (
        <button
          type="button"
          aria-label={t('arcade.restore')}
          ref={bubbleRef}
          onPointerDown={onBubbleDown}
          onPointerMove={onBubbleMove}
          onPointerUp={onBubbleUp}
          className={`absolute right-4 bottom-24 z-50 flex h-14 w-14 cursor-grab touch-none select-none items-center justify-center rounded-full border-2 border-white bg-white shadow-lg active:cursor-grabbing ${
            notify ? 'animate-pulse ring-4 ring-ola-accent' : ''
          }`}
        >
          <Avatar
            name={active.name}
            color={colorForName(active.name)}
            src={active.iconUrl}
            size={52}
            rounded
          />
          {notify && (
            <span className="absolute -top-0.5 -right-0.5 h-3.5 w-3.5 rounded-full border-2 border-white bg-ola-accent" />
          )}
        </button>
      )}
    </>
  );
}
