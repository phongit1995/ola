import { useCallback, useRef, useState, type ReactNode } from 'react';
import { useDraggableOffset, type DragOffset } from '@hooks';
import { readDragOffset, storeDragOffset } from '@lib';

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

function isBubbleInDropZone(
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
    centerY >= area.top - DROP_TARGET_TOLERANCE
  );
}

interface FloatingBubbleProps {
  storageKey: string;
  label: string;
  notify: boolean;
  positionClassName: string;
  onRestore: () => void;
  onClose: () => void;
  children: ReactNode;
}

export function FloatingBubble({
  storageKey,
  label,
  notify,
  positionClassName,
  onRestore,
  onClose,
  children,
}: FloatingBubbleProps) {
  const closeTargetRef = useRef<HTMLSpanElement>(null);
  const bubbleElementRef = useRef<HTMLElement | null>(null);
  const [dragging, setDragging] = useState(false);
  const [overClose, setOverClose] = useState(false);
  const handleDragChange = useCallback((next: boolean) => {
    setDragging(next);
    if (!next) setOverClose(false);
  }, []);
  const handleDragMove = useCallback(() => {
    setOverClose(
      isBubbleInDropZone(bubbleElementRef.current, closeTargetRef.current)
    );
  }, []);
  const handleDrop = useCallback(() => {
    const shouldClose = isBubbleInDropZone(
      bubbleElementRef.current,
      closeTargetRef.current
    );
    if (shouldClose) onClose();
    return shouldClose;
  }, [onClose]);
  const commitOffset = useCallback(
    (offset: DragOffset) => storeDragOffset(storageKey, offset),
    [storageKey]
  );
  const { setElement, dragHandlers } = useDraggableOffset({
    initialOffset: readDragOffset(storageKey),
    onCommit: commitOffset,
    onTap: onRestore,
    visible: true,
    onDragChange: handleDragChange,
    onDragMove: handleDragMove,
    onDrop: handleDrop,
  });
  const setBubbleNode = useCallback(
    (element: HTMLDivElement | null) => {
      bubbleElementRef.current = element;
      setElement(element);
    },
    [setElement]
  );

  return (
    <>
      <div
        aria-hidden="true"
        className={`pointer-events-none absolute bottom-[calc(env(safe-area-inset-bottom,0px)+72px)] left-1/2 z-[60] -translate-x-1/2 transition-[opacity,transform] duration-200 ease-out motion-reduce:transition-none ${
          dragging
            ? 'translate-y-0 scale-100 opacity-100'
            : 'translate-y-6 scale-75 opacity-0'
        }`}
      >
        <span
          ref={closeTargetRef}
          className={`flex h-14 w-14 items-center justify-center rounded-full border-2 backdrop-blur-sm transition-[background-color,border-color,box-shadow,transform] duration-150 ease-out motion-reduce:transition-none ${
            overClose
              ? 'scale-110 border-white bg-ola-error text-white shadow-[0_0_0_8px_--alpha(var(--color-ola-error)/18%),0_10px_24px_rgba(0,0,0,0.35)]'
              : 'animate-trash-hunger border-white bg-ola-surface-cool text-neutral-600 shadow-[0_8px_22px_rgba(0,0,0,0.2)] motion-reduce:animate-none'
          }`}
        >
          <TrashIcon open={overClose} chewing={dragging} />
        </span>
      </div>

      <div
        ref={setBubbleNode}
        role="button"
        tabIndex={0}
        aria-keyshortcuts="Delete"
        aria-label={label}
        data-dragging={dragging ? 'true' : 'false'}
        data-over-close-target={overClose ? 'true' : 'false'}
        {...dragHandlers}
        onKeyDown={(event) => {
          if (event.key === 'Enter' || event.key === ' ') {
            event.preventDefault();
            onRestore();
          }
          if (event.key === 'Delete') {
            event.preventDefault();
            onClose();
          }
        }}
        className={`absolute flex h-14 w-14 cursor-grab touch-none items-center justify-center rounded-full border-2 transition-[background-color,border-color,box-shadow] duration-150 ease-out select-none [will-change:transform] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-ola-accent motion-reduce:transition-none active:cursor-grabbing ${positionClassName} ${
          dragging ? 'z-[70]' : 'z-50'
        } ${
          overClose
            ? 'border-transparent bg-transparent shadow-none'
            : notify
              ? 'border-ola-warning bg-white shadow-lg'
              : 'border-white bg-white shadow-lg'
        }`}
      >
        <span
          className={`pointer-events-none transition-[opacity,transform] duration-150 ease-out motion-reduce:transition-none ${
            overClose ? 'scale-50 opacity-0' : ''
          }`}
        >
          {children}
        </span>
        {notify && !overClose && (
          <span
            aria-hidden="true"
            className="pointer-events-none absolute -top-1 -right-1 h-4 w-4 animate-blink rounded-full border-2 border-white bg-ola-warning"
          />
        )}
      </div>
    </>
  );
}
