import type { MouseEvent, PointerEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { useDraggable } from '@hooks';
import { CloseIcon, DownloadIcon } from './platformIcons';

interface DownloadFabProps {
  hidden: boolean;
  onOpen: () => void;
  onDismiss: () => void;
}

export function DownloadFab({ hidden, onOpen, onDismiss }: DownloadFabProps) {
  const { t } = useTranslation();
  const drag = useDraggable<HTMLDivElement>({ onClick: onOpen });

  function handleKeyboardActivate(event: MouseEvent<HTMLButtonElement>) {
    if (event.detail === 0) onOpen();
  }

  function keepDragFromStarting(event: PointerEvent<HTMLButtonElement>) {
    event.stopPropagation();
  }

  return (
    <div
      {...drag}
      className={`absolute bottom-3 left-3 z-30 cursor-grab touch-none active:cursor-grabbing ${
        hidden ? 'hidden' : ''
      }`}
    >
      <button
        type="button"
        onClick={handleKeyboardActivate}
        className="flex h-12 items-center gap-2 rounded-full bg-white pr-3.5 pl-1.5 shadow-[0_4px_16px_rgba(0,0,0,0.28)] ring-1 ring-black/5 transition-transform active:scale-95"
      >
        <span className="relative shrink-0">
          <img src="/favicon.png" alt="" className="h-9 w-9 rounded-xl" />
          <span className="absolute -right-1 -bottom-1 flex h-5 w-5 items-center justify-center rounded-full border-2 border-white bg-ola-primary text-ola-on-primary">
            <DownloadIcon className="h-2.5 w-2.5" />
          </span>
        </span>
        <span className="text-[13px] font-bold whitespace-nowrap text-ola-primary-dark">
          {t('download.fab')}
        </span>
      </button>
      <button
        type="button"
        aria-label={t('download.hideFab')}
        onPointerDown={keepDragFromStarting}
        onClick={onDismiss}
        className="absolute -top-1.5 -right-1.5 flex h-6 w-6 items-center justify-center rounded-full border-2 border-white bg-black/55 text-white shadow"
      >
        <CloseIcon className="h-3 w-3" />
      </button>
    </div>
  );
}
