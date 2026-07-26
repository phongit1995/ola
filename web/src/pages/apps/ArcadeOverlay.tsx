import {
  useCallback,
  useEffect,
  useRef,
  useState,
  type PointerEvent as ReactPointerEvent,
} from 'react';
import { useTranslation } from 'react-i18next';
import { ensureFreshToken } from '@ola/shared/api';
import {
  ARCADE_BRIDGE_EVENT,
  ARCADE_BRIDGE_SOURCE,
  type ArcadeBridgeMessage,
} from '@ola/shared/types';
import { Avatar } from '@components';
import { colorForName } from '@lib';
import { useArcadeOverlayStore } from '@/store/arcadeOverlayStore';

interface BubblePosition {
  x: number;
  y: number;
}

interface BubbleDrag {
  pointerId: number;
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
const BUBBLE_POSITION_STORAGE_KEY = 'ola.arcade.bubble-position';
const DEFAULT_BUBBLE_POSITION: BubblePosition = { x: 0, y: 0 };

function clamp(value: number, min: number, max: number): number {
  if (min > max) return (min + max) / 2;
  return Math.min(Math.max(value, min), max);
}

function readStoredBubblePosition(): BubblePosition {
  if (typeof window === 'undefined') return DEFAULT_BUBBLE_POSITION;
  try {
    const raw = window.localStorage.getItem(BUBBLE_POSITION_STORAGE_KEY);
    if (!raw) return DEFAULT_BUBBLE_POSITION;
    const parsed = JSON.parse(raw) as Partial<BubblePosition>;
    if (!Number.isFinite(parsed.x) || !Number.isFinite(parsed.y)) {
      return DEFAULT_BUBBLE_POSITION;
    }
    return { x: parsed.x as number, y: parsed.y as number };
  } catch {
    return DEFAULT_BUBBLE_POSITION;
  }
}

function storeBubblePosition(position: BubblePosition) {
  try {
    window.localStorage.setItem(
      BUBBLE_POSITION_STORAGE_KEY,
      JSON.stringify(position)
    );
  } catch {
    // Storage can be unavailable in private/embedded browser contexts.
  }
}

function applyBubbleTransform(
  element: HTMLDivElement | null,
  position: BubblePosition
) {
  if (!element) return;
  element.style.transform = `translate3d(${position.x}px, ${position.y}px, 0)`;
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
  const bubbleRef = useRef<HTMLDivElement>(null);
  const [bubblePos, setBubblePos] = useState(readStoredBubblePosition);
  const bubblePosRef = useRef(bubblePos);
  const pendingBubblePosRef = useRef(bubblePos);
  const dragFrameRef = useRef<number | null>(null);
  const dragRef = useRef<BubbleDrag | null>(null);
  const setBubbleElement = useCallback((element: HTMLDivElement | null) => {
    bubbleRef.current = element;
    applyBubbleTransform(element, bubblePosRef.current);
  }, []);

  useEffect(() => {
    if (!active) return;
    const gameOrigin = new URL(active.gameUrl).origin;

    async function onMessage(event: MessageEvent) {
      if (event.origin !== gameOrigin) return;
      const data = event.data as ArcadeBridgeMessage;
      if (data?.source !== ARCADE_BRIDGE_SOURCE.Game) return;
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
  }, [active, close]);

  useEffect(
    () => () => {
      if (dragFrameRef.current != null)
        cancelAnimationFrame(dragFrameRef.current);
    },
    []
  );

  useEffect(() => {
    if (!minimized) return;
    const el = bubbleRef.current;
    if (!el) return;
    const bubbleElement: HTMLDivElement = el;
    const container = bubbleElement.offsetParent as HTMLElement | null;

    function keepBubbleInBounds() {
      if (dragRef.current || dragFrameRef.current != null) return;
      const rect = bubbleElement.getBoundingClientRect();
      const bounds = container?.getBoundingClientRect();
      const left = bounds?.left ?? 0;
      const top = bounds?.top ?? 0;
      const width = bounds?.width ?? window.innerWidth;
      const height = bounds?.height ?? window.innerHeight;
      const startLeft = rect.left - left;
      const startTop = rect.top - top;
      const next = {
        x:
          bubblePosRef.current.x +
          clamp(0, -startLeft, width - rect.width - startLeft),
        y:
          bubblePosRef.current.y +
          clamp(0, -startTop, height - rect.height - startTop),
      };
      if (
        next.x === bubblePosRef.current.x &&
        next.y === bubblePosRef.current.y
      )
        return;
      bubblePosRef.current = next;
      pendingBubblePosRef.current = next;
      applyBubbleTransform(bubbleElement, next);
      setBubblePos(next);
      storeBubblePosition(next);
    }

    const initialFrame = requestAnimationFrame(keepBubbleInBounds);
    const resizeObserver =
      typeof ResizeObserver === 'undefined'
        ? null
        : new ResizeObserver(keepBubbleInBounds);
    if (container) resizeObserver?.observe(container);
    window.addEventListener('resize', keepBubbleInBounds);
    window.visualViewport?.addEventListener('resize', keepBubbleInBounds);
    return () => {
      cancelAnimationFrame(initialFrame);
      resizeObserver?.disconnect();
      window.removeEventListener('resize', keepBubbleInBounds);
      window.visualViewport?.removeEventListener('resize', keepBubbleInBounds);
    };
  }, [minimized]);

  if (!active) return null;

  function commitPendingBubblePosition() {
    if (dragFrameRef.current != null) {
      cancelAnimationFrame(dragFrameRef.current);
      dragFrameRef.current = null;
    }
    const next = pendingBubblePosRef.current;
    bubblePosRef.current = next;
    applyBubbleTransform(bubbleRef.current, next);
    setBubblePos((current) =>
      current.x === next.x && current.y === next.y ? current : next
    );
    storeBubblePosition(next);
  }

  function scheduleBubblePosition(next: BubblePosition) {
    pendingBubblePosRef.current = next;
    if (dragFrameRef.current != null) return;
    dragFrameRef.current = requestAnimationFrame(() => {
      dragFrameRef.current = null;
      const pending = pendingBubblePosRef.current;
      bubblePosRef.current = pending;
      applyBubbleTransform(bubbleRef.current, pending);
    });
  }

  function positionFromPointer(
    drag: BubbleDrag,
    clientX: number,
    clientY: number
  ) {
    const dx = clientX - drag.startX;
    const dy = clientY - drag.startY;
    return {
      x: drag.baseX + clamp(dx, drag.minX, drag.maxX),
      y: drag.baseY + clamp(dy, drag.minY, drag.maxY),
    };
  }

  function handleBubbleDown(event: ReactPointerEvent<HTMLDivElement>) {
    if (!event.isPrimary || event.button !== 0 || dragRef.current) return;
    event.preventDefault();
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
      pointerId: event.pointerId,
      startX: event.clientX,
      startY: event.clientY,
      baseX: bubblePosRef.current.x,
      baseY: bubblePosRef.current.y,
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
    if (!drag || drag.pointerId !== event.pointerId) return;
    const dx = event.clientX - drag.startX;
    const dy = event.clientY - drag.startY;
    if (Math.hypot(dx, dy) > DRAG_THRESHOLD) drag.moved = true;
    if (!drag.moved) return;
    event.preventDefault();
    scheduleBubblePosition(
      positionFromPointer(drag, event.clientX, event.clientY)
    );
  }

  function handleBubbleUp(event: ReactPointerEvent<HTMLDivElement>) {
    const drag = dragRef.current;
    if (!drag || drag.pointerId !== event.pointerId) return;
    const dx = event.clientX - drag.startX;
    const dy = event.clientY - drag.startY;
    const moved = drag.moved || Math.hypot(dx, dy) > DRAG_THRESHOLD;
    if (moved) {
      pendingBubblePosRef.current = positionFromPointer(
        drag,
        event.clientX,
        event.clientY
      );
      commitPendingBubblePosition();
    }
    dragRef.current = null;
    if (event.currentTarget.hasPointerCapture(event.pointerId)) {
      event.currentTarget.releasePointerCapture(event.pointerId);
    }
    if (!moved) restore();
  }

  function handleBubbleCancel(event: ReactPointerEvent<HTMLDivElement>) {
    const drag = dragRef.current;
    if (!drag || drag.pointerId !== event.pointerId) return;
    dragRef.current = null;
    commitPendingBubblePosition();
  }

  function handleBubbleLostCapture(event: ReactPointerEvent<HTMLDivElement>) {
    const drag = dragRef.current;
    if (!drag || drag.pointerId !== event.pointerId) return;
    dragRef.current = null;
    commitPendingBubblePosition();
  }

  return (
    <>
      <div
        className={`absolute inset-0 z-50 bg-[#0f0f23] ${minimized ? 'invisible' : ''}`}
      >
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
          ref={setBubbleElement}
          role="button"
          tabIndex={0}
          aria-label={
            notify
              ? `${t('arcade.restore')}. ${t('arcade.hasNotification')}`
              : t('arcade.restore')
          }
          onPointerDown={handleBubbleDown}
          onPointerMove={handleBubbleMove}
          onPointerUp={handleBubbleUp}
          onPointerCancel={handleBubbleCancel}
          onLostPointerCapture={handleBubbleLostCapture}
          onDragStart={(event) => event.preventDefault()}
          onKeyDown={(event) => {
            if (event.key === 'Enter' || event.key === ' ') {
              event.preventDefault();
              restore();
            }
          }}
          className={`absolute right-4 bottom-24 z-50 flex h-14 w-14 cursor-grab touch-none select-none items-center justify-center rounded-full border-2 border-white bg-white shadow-lg [will-change:transform] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-ola-accent active:cursor-grabbing ${
            notify ? 'border-red-600' : ''
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
              className="pointer-events-none absolute -top-1 -right-1 h-4 w-4 animate-pulse rounded-full border-2 border-white bg-red-600"
            />
          )}
        </div>
      )}
    </>
  );
}
