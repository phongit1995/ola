import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';

function BackIcon() {
  return (
    <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
      <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
    </svg>
  );
}

interface ScreenHeaderProps {
  title: string;
  onBack: () => void;
  align?: 'start' | 'center';
  left?: ReactNode;
  subtitle?: ReactNode;
  onTitlePress?: () => void;
  children?: ReactNode;
}

export function ScreenHeader({
  title,
  onBack,
  align = 'start',
  left,
  subtitle,
  onTitlePress,
  children,
}: ScreenHeaderProps) {
  const { t } = useTranslation();

  if (align === 'center') {
    return (
      <header className="relative flex h-12 shrink-0 items-center justify-center bg-ola-primary px-12 text-white">
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={onBack}
          className="absolute left-2 flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <BackIcon />
        </button>
        <span className="truncate text-lg font-medium">{title}</span>
        {children != null && (
          <div className="absolute right-2 flex items-center">{children}</div>
        )}
      </header>
    );
  }

  return (
    <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
      <button
        type="button"
        aria-label={t('chat.back')}
        onClick={onBack}
        className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
      >
        <BackIcon />
      </button>
      {onTitlePress != null ? (
        <button
          type="button"
          onClick={onTitlePress}
          className="flex min-w-0 flex-1 items-center gap-2 text-left"
        >
          {left}
          {subtitle != null ? (
            <span className="flex min-w-0 flex-col leading-tight">
              <span className="truncate text-sm font-bold">{title}</span>
              <span className="truncate text-xs text-white/70">{subtitle}</span>
            </span>
          ) : (
            <span className="min-w-0 truncate text-lg font-medium">{title}</span>
          )}
        </button>
      ) : (
        <>
          {left}
          {subtitle != null ? (
            <span className="flex min-w-0 flex-1 flex-col leading-tight">
              <span className="truncate text-sm font-bold">{title}</span>
              <span className="truncate text-xs text-white/70">{subtitle}</span>
            </span>
          ) : (
            <span className="flex-1 truncate text-lg font-medium">{title}</span>
          )}
        </>
      )}
      {children}
    </header>
  );
}
