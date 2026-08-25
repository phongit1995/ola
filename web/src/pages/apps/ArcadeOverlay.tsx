import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ensureFreshToken } from '@ola/shared/api';
import {
  ARCADE_BRIDGE_EVENT,
  ARCADE_BRIDGE_SOURCE,
} from '@ola/shared/constants';
import type {
  ArcadeBridgeMessage,
  ArcadeKenUpdatedData,
} from '@ola/shared/types';
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

const DROP_TARGET_TOLERANCE = 18;

function TrashIcon({ open, chewing }: { open: boolean; chewing: boolean }) {
  const lidAnimation = open
    ? 'animate-trash-open'
    : chewing
      ? 'animate-trash-chomp'
      : '';
  return (
    <svg
      viewBox="0 0 32 32"
      fill="none"
      stroke="currentColor"
      strokeWidth={2.25}
      strokeLinecap="round"
      strokeLinejoin="round"
      className="h-8 w-8"
      aria-hidden="true"
    >
      <path
        d="m10 12 1.05 12.55A2.7 2.7 0 0 0 13.74 27h4.52a2.7 2.7 0 0 0 2.69-2.45L22 12Z"
        fill="currentColor"
        stroke="none"
        opacity={0.18}
      />
      <path d="m10 12 1.05 12.55A2.7 2.7 0 0 0 13.74 27h4.52a2.7 2.7 0 0 0 2.69-2.45L22 12" />
      <path d="M14 16v6.5M18 16v6.5" />
      <g
        className={`origin-[9px_10.5px] motion-reduce:animate-none ${lidAnimation}`}
      >
        <path d="M8 10h16" />
        <path d="M12.5 10V7.75A1.75 1.75 0 0 1 14.25 6h3.5a1.75 1.75 0 0 1 1.75 1.75V10" />
      </g>
    </svg>
  );
}

function isBubbleOverTarget(
  bubble: HTMLElement | null,
  target: HTMLElement | null
): boolean {
  if (!bubble || !target) return false;
  const area = target.getBoundingClientRect();
  const rect = bubble.getBoundingClientRect();
  const centerX = rect.left + rect.width / 2;
  const centerY = rect.top + rect.height / 2;
  return (
    centerX >= area.left - DROP_TARGET_TOLERANCE &&
    centerX <= area.right + DROP_TARGET_TOLERANCE &&
    centerY >= area.top - DROP_TARGET_TOLERANCE &&
    centerY <= area.bottom + DROP_TARGET_TOLERANCE
  );
}

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
  const closeTargetRef = useRef<HTMLSpanElement>(null);
  const bubbleElementRef = useRef<HTMLElement | null>(null);
  const [bubbleDragging, setBubbleDragging] = useState(false);
  const [bubbleOverClose, setBubbleOverClose] = useState(false);
  const handleBubbleDragChange = useCallback((dragging: boolean) => {
    setBubbleDragging(dragging);
    if (!dragging) setBubbleOverClose(false);
  }, []);
  const handleBubbleDragMove = useCallback(() => {
    setBubbleOverClose(
      isBubbleOverTarget(bubbleElementRef.current, closeTargetRef.current)
    );
  }, []);
  const handleBubbleDrop = useCallback(() => {
    const shouldClose = isBubbleOverTarget(
      bubbleElementRef.current,
      closeTargetRef.current
    );
    if (shouldClose) close();
    return shouldClose;
  }, [close]);
  const { setElement: setBubbleElement, dragHandlers: bubbleDragHandlers } =
    useDraggableOffset({
      initialOffset: readBubbleOffset(),
      onCommit: storeBubbleOffset,
      onTap: restore,
      visible: minimized,
      onDragChange: handleBubbleDragChange,
      onDragMove: handleBubbleDragMove,
      onDrop: handleBubbleDrop,
    });
  const setBubbleNode = useCallback(
    (element: HTMLDivElement | null) => {
      bubbleElementRef.current = element;
      setBubbleElement(element);
    },
    [setBubbleElement]
  );
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
        <>
          <div
            aria-hidden="true"
            className={`pointer-events-none absolute bottom-[calc(env(safe-area-inset-bottom,0px)+72px)] left-1/2 z-[60] -translate-x-1/2 transition-[opacity,transform] duration-200 ease-out motion-reduce:transition-none ${
              bubbleDragging
                ? 'translate-y-0 scale-100 opacity-100'
                : 'translate-y-6 scale-75 opacity-0'
            }`}
          >
            <span
              ref={closeTargetRef}
              className={`flex h-14 w-14 items-center justify-center rounded-full border-2 backdrop-blur-sm transition-[background-color,border-color,box-shadow,transform] duration-150 ease-out motion-reduce:transition-none ${
                bubbleOverClose
                  ? 'scale-110 border-white bg-ola-error text-white shadow-[0_0_0_8px_--alpha(var(--color-ola-error)/18%),0_10px_24px_rgba(0,0,0,0.35)]'
                  : 'animate-trash-hunger border-white bg-ola-surface-cool text-neutral-600 shadow-[0_8px_22px_rgba(0,0,0,0.2)] motion-reduce:animate-none'
              }`}
            >
              <TrashIcon open={bubbleOverClose} chewing={bubbleDragging} />
            </span>
          </div>

          <div
            ref={setBubbleNode}
            role="button"
            tabIndex={0}
            aria-keyshortcuts="Delete"
            aria-label={`${
              notify
                ? `${t('arcade.restore')}. ${t('arcade.hasNotification')}`
                : t('arcade.restore')
            }. ${t('arcade.dragToClose')}`}
            data-dragging={bubbleDragging ? 'true' : 'false'}
            data-over-close-target={bubbleOverClose ? 'true' : 'false'}
            {...bubbleDragHandlers}
            onKeyDown={(event) => {
              if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                restore();
              }
              if (event.key === 'Delete') {
                event.preventDefault();
                close();
              }
            }}
            className={`absolute right-4 bottom-24 flex h-14 w-14 cursor-grab touch-none items-center justify-center rounded-full border-2 transition-[background-color,border-color,box-shadow] duration-150 ease-out select-none [will-change:transform] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-ola-accent motion-reduce:transition-none active:cursor-grabbing ${
              bubbleDragging ? 'z-[70]' : 'z-50'
            } ${
              bubbleOverClose
                ? 'border-transparent bg-transparent shadow-none'
                : notify
                  ? 'border-ola-warning bg-white shadow-lg'
                  : 'border-white bg-white shadow-lg'
            }`}
          >
            <span
              className={`pointer-events-none transition-[opacity,transform] duration-150 ease-out motion-reduce:transition-none ${
                bubbleOverClose ? 'scale-50 opacity-0' : ''
              }`}
            >
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
        </>
      )}
    </>
  );
}
