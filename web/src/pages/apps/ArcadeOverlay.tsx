import { useEffect, useRef, useState, type PointerEvent as ReactPointerEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { ensureFreshToken } from '@ola/shared/api';
import { Avatar } from '@components';
import { colorForName } from '@lib';
import { useArcadeOverlayStore } from '@/store/arcadeOverlayStore';

interface GameBridgeMessage {
  source?: string;
  type?: string;
}

interface BubbleDrag {
  startX: number;
  startY: number;
  baseX: number;
  baseY: number;
  minX: number;
  maxX: number;
  minY: number;
  maxY: number;
  moved: boolean;
}

const DRAG_THRESHOLD = 4;

function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), Math.max(min, max));
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
  const [bubblePos, setBubblePos] = useState({ x: 0, y: 0 });
  const dragRef = useRef<BubbleDrag | null>(null);

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

  function handleBubbleDown(event: ReactPointerEvent<HTMLDivElement>) {
    const el = event.currentTarget;
    const container = el.offsetParent as HTMLElement | null;
    const rect = el.getBoundingClientRect();
    const bounds = container?.getBoundingClientRect();
    const left = bounds?.left ?? 0;
    const top = bounds?.top ?? 0;
    const width = bounds?.width ?? window.innerWidth;
    const height = bounds?.height ?? window.innerHeight;
    const startLeft = rect.left - left;
    const startTop = rect.top - top;
    dragRef.current = {
      startX: event.clientX,
      startY: event.clientY,
      baseX: bubblePos.x,
      baseY: bubblePos.y,
      minX: -startLeft,
      maxX: width - rect.width - startLeft,
      minY: -startTop,
      maxY: height - rect.height - startTop,
      moved: false,
    };
    el.setPointerCapture(event.pointerId);
  }

  function handleBubbleMove(event: ReactPointerEvent<HTMLDivElement>) {
    const drag = dragRef.current;
    if (!drag) return;
    const dx = event.clientX - drag.startX;
    const dy = event.clientY - drag.startY;
    if (Math.abs(dx) > DRAG_THRESHOLD || Math.abs(dy) > DRAG_THRESHOLD) drag.moved = true;
    if (!drag.moved) return;
    setBubblePos({
      x: drag.baseX + clamp(dx, drag.minX, drag.maxX),
      y: drag.baseY + clamp(dy, drag.minY, drag.maxY),
    });
  }

  function handleBubbleUp(event: ReactPointerEvent<HTMLDivElement>) {
    const drag = dragRef.current;
    if (!drag) return;
    dragRef.current = null;
    event.currentTarget.releasePointerCapture(event.pointerId);
    if (!drag.moved) restore();
  }

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
        <div
          role="button"
          tabIndex={0}
          aria-label={t('arcade.restore')}
          onPointerDown={handleBubbleDown}
          onPointerMove={handleBubbleMove}
          onPointerUp={handleBubbleUp}
          onKeyDown={(event) => {
            if (event.key === 'Enter' || event.key === ' ') {
              event.preventDefault();
              restore();
            }
          }}
          style={{ transform: `translate(${bubblePos.x}px, ${bubblePos.y}px)` }}
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
            <span className="pointer-events-none absolute -top-0.5 -right-0.5 h-3.5 w-3.5 rounded-full border-2 border-white bg-ola-accent" />
          )}
        </div>
      )}
    </>
  );
}
