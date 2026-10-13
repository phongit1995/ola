import { useCallback, useRef, useState, type PointerEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { useOutsideClick } from '@hooks';
import { cn } from '@lib';
import type { StoryAccess } from '@app-types';
import { StoryIcon } from './StoryIcons';

function isMouse(event: PointerEvent) {
  return event.pointerType === 'mouse';
}

export function StoryFreeReadsBadge({ access }: { access: StoryAccess }) {
  const { t } = useTranslation();
  const ref = useRef<HTMLDivElement>(null);
  const [hovered, setHovered] = useState(false);
  const [pinned, setPinned] = useState(false);
  const unpin = useCallback(() => setPinned(false), []);
  useOutsideClick(ref, pinned, unpin);

  const left = Math.max(0, access.freeLimit - access.freeUsed);
  const open = hovered || pinned;
  const summary =
    left > 0
      ? t('story.accessFree', { left, limit: access.freeLimit })
      : t('story.accessNoneLeft', { limit: access.freeLimit });

  return (
    <div
      ref={ref}
      className="relative shrink-0"
      onPointerEnter={(event) => {
        if (isMouse(event)) setHovered(true);
      }}
      onPointerLeave={(event) => {
        if (isMouse(event)) setHovered(false);
      }}
    >
      <button
        type="button"
        aria-label={summary}
        aria-expanded={open}
        onClick={() => setPinned((value) => !value)}
        className={cn(
          'flex h-8 items-center gap-1 rounded-full px-2.5 text-sm font-semibold text-white tabular-nums',
          left > 0 ? 'bg-white/15 hover:bg-white/25' : 'bg-ola-error'
        )}
      >
        <StoryIcon name="menuBook" className="h-4 w-4 shrink-0" />
        {left}/{access.freeLimit}
      </button>
      {open && (
        <div className="absolute top-full right-0 z-20 w-64 pt-2">
          <div className="rounded-lg bg-white p-3 text-[13px] leading-5 text-black/60 shadow-lg ring-1 ring-black/5">
            <p
              className={cn(
                'font-semibold',
                left > 0 ? 'text-black/87' : 'text-ola-error'
              )}
            >
              {summary}
            </p>
            <p className="mt-1">{t('story.lockedVip')}</p>
            <p>
              {t('story.commentUnlockHint', { count: access.commentMinChars })}
            </p>
          </div>
        </div>
      )}
    </div>
  );
}
