import type { CSSProperties } from 'react';
import { useTranslation } from 'react-i18next';
import { cn } from '@lib';
import type { StoryIconName } from '@app-types';
import { StoryIcon } from './StoryIcons';

type StoryStateKind = 'empty' | 'error';

const BADGE: Record<
  StoryStateKind,
  { icon: StoryIconName; className: string }
> = {
  empty: { icon: 'search', className: 'bg-ola-primary' },
  error: { icon: 'priorityHigh', className: 'bg-ola-error' },
};

interface StoryStateMessageProps {
  kind: StoryStateKind;
  text: string;
  onRetry?: () => void;
  className?: string;
  style?: CSSProperties;
}

export function StoryStateMessage({
  kind,
  text,
  onRetry,
  className,
  style,
}: StoryStateMessageProps) {
  const { t } = useTranslation();
  return (
    <div
      role={kind === 'error' ? 'alert' : undefined}
      className={cn(
        'flex flex-col items-center gap-3 px-6 py-10 text-center text-sm text-black/54',
        className
      )}
      style={style}
    >
      <span className="relative">
        <StoryIcon name="menuBook" className="h-14 w-14 opacity-30" />
        <span
          className={cn(
            'absolute -right-1.5 -bottom-0.5 flex h-6 w-6 items-center justify-center rounded-full text-white',
            BADGE[kind].className
          )}
        >
          <StoryIcon name={BADGE[kind].icon} className="h-4 w-4" />
        </span>
      </span>
      {text}
      {onRetry && (
        <button
          type="button"
          onClick={onRetry}
          className="rounded-full bg-ola-button px-4 py-1.5 text-ola-on-primary"
        >
          {t('story.retry')}
        </button>
      )}
    </div>
  );
}
