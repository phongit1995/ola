import type { CSSProperties } from 'react';
import { useTranslation } from 'react-i18next';
import { cn } from '@lib';
import { STORY_STATE_ART, type StoryStateKind } from '../constants';

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
      <img
        src={STORY_STATE_ART[kind]}
        alt=""
        className="h-24 w-24 select-none"
        draggable={false}
      />
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
