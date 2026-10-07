import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { cn } from '@lib';
import { STORY_STATUS } from '@constants';
import type { StoryIconName, StoryStatus } from '@app-types';
import { STATUS_ICON, STATUS_LABEL } from '../constants';
import { StoryIcon } from './StoryIcons';

const STATUS_CLASS: Record<StoryStatus, string> = {
  [STORY_STATUS.ongoing]: 'bg-ola-warning/15 text-ola-warning',
  [STORY_STATUS.completed]: 'bg-ola-primary/15 text-ola-primary-dark',
  [STORY_STATUS.unknown]: 'bg-black/5 text-black/54',
};

export function StoryStatusBadge({ status }: { status: StoryStatus }) {
  const { t } = useTranslation();
  const icon = STATUS_ICON[status];
  return (
    <span
      className={cn(
        'inline-flex items-center gap-0.5 rounded px-1.5 py-0.5 text-[11px] leading-none font-medium',
        STATUS_CLASS[status]
      )}
    >
      {icon && <StoryIcon name={icon} className="h-3 w-3" monochrome />}
      {t(STATUS_LABEL[status])}
    </span>
  );
}

interface StoryMetaProps {
  icon: StoryIconName;
  className?: string;
  iconClassName?: string;
  children: ReactNode;
}

export function StoryMeta({
  icon,
  className,
  iconClassName = 'h-3.5 w-3.5 text-black/70',
  children,
}: StoryMetaProps) {
  return (
    <span className={cn('inline-flex items-center gap-1', className)}>
      <StoryIcon name={icon} className={cn('shrink-0', iconClassName)} />
      {children}
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
