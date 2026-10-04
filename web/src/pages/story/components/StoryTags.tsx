import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { cn } from '@lib';
import { STORY_STATUS } from '@constants';
import type { StoryStatus } from '@app-types';
import { STATUS_LABEL } from '../constants';

const STATUS_CLASS: Record<StoryStatus, string> = {
  [STORY_STATUS.ongoing]: 'bg-ola-warning/15 text-ola-warning',
  [STORY_STATUS.completed]: 'bg-ola-primary/15 text-ola-primary-dark',
  [STORY_STATUS.unknown]: 'bg-black/5 text-black/54',
};

export function StoryStatusBadge({ status }: { status: StoryStatus }) {
  const { t } = useTranslation();
  return (
    <span
      className={cn(
        'rounded px-1.5 py-0.5 text-[11px] leading-none font-medium',
        STATUS_CLASS[status]
      )}
    >
      {t(STATUS_LABEL[status])}
    </span>
  );
}

export function StoryTag({ children }: { children: ReactNode }) {
  return (
    <span className="rounded bg-black/5 px-1.5 py-0.5 text-[11px] leading-none text-black/60">
      {children}
    </span>
  );
}
