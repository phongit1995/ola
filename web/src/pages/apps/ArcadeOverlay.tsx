import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ensureFreshToken } from '@ola/shared/api';
import { Avatar } from '@components';
import { colorForName } from '@lib';
import { useArcadeOverlayStore } from '@/store/arcadeOverlayStore';

interface GameBridgeMessage {
  source?: string;
  type?: string;
}

const BUBBLE_SIZE = 56;
const DRAG_THRESHOLD = 4;

export function ArcadeOverlay() {
  const { t } = useTranslation();
  const active = useArcadeOverlayStore((s) => s.active);
  const minimized = useArcadeOverlayStore((s) => s.minimized);
  const notify = useArcadeOverlayStore((s) => s.notify);
  const minimize = useArcadeOverlayStore((s) => s.minimize);
  const restore = useArcadeOverlayStore((s) => s.restore);
  const close = useArcadeOverlayStore((s) => s.close);
  const iframeRef = useRef<HTMLIFrameElement>(null);

  const [bubblePos, setBubblePos] = useState<{ x: number; y: number } | null>(null);
  const dragRef = useRef<{ startX: number; startY: number; offX: number; offY: number; moved: boolean } | null>(null);

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

  function onBubblePointerDown(event: React.PointerEvent<HTMLButtonElement>) {
    const rect = event.currentTarget.getBoundingClientRect();
    dragRef.current = {
      startX: event.clientX,
      startY: event.clientY,
      offX: event.clientX - rect.left,
      offY: event.clientY - rect.top,
      moved: false,
    };
    event.currentTarget.setPointerCapture(event.pointerId);
  }

  function onBubblePointerMove(event: React.PointerEvent<HTMLButtonElement>) {
    const drag = dragRef.current;
    if (!drag) return;
    if (
      Math.abs(event.clientX - drag.startX) > DRAG_THRESHOLD ||
      Math.abs(event.clientY - drag.startY) > DRAG_THRESHOLD
    ) {
      drag.moved = true;
    }
    if (!drag.moved) return;
    const container = event.currentTarget.offsetParent as HTMLElement | null;
    const rect = container?.getBoundingClientRect();
    const baseLeft = rect?.left ?? 0;
    const baseTop = rect?.top ?? 0;
    const width = rect?.width ?? window.innerWidth;
    const height = rect?.height ?? window.innerHeight;
    const x = Math.min(Math.max(0, event.clientX - drag.offX - baseLeft), width - BUBBLE_SIZE);
    const y = Math.min(Math.max(0, event.clientY - drag.offY - baseTop), height - BUBBLE_SIZE);
    setBubblePos({ x, y });
  }

  function onBubblePointerUp(event: React.PointerEvent<HTMLButtonElement>) {
    const drag = dragRef.current;
    dragRef.current = null;
    event.currentTarget.releasePointerCapture(event.pointerId);
    if (drag && !drag.moved) restore();
  }

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
          onPointerDown={onBubblePointerDown}
          onPointerMove={onBubblePointerMove}
          onPointerUp={onBubblePointerUp}
          style={bubblePos ? { left: bubblePos.x, top: bubblePos.y } : undefined}
          className={`absolute z-50 flex h-14 w-14 touch-none items-center justify-center rounded-full border-2 border-white bg-white shadow-lg ${
            bubblePos ? '' : 'right-4 bottom-24'
          } ${notify ? 'animate-pulse ring-4 ring-ola-accent' : ''}`}
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
