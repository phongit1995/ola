import type { ReactNode } from 'react';
import type { MomentTextAlign } from '@app-types';

interface IconProps {
  className?: string;
}

function Svg({ className, children }: IconProps & { children: ReactNode }) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth={2}
      strokeLinecap="round"
      strokeLinejoin="round"
      className={className ?? 'h-5 w-5'}
      aria-hidden="true"
    >
      {children}
    </svg>
  );
}

export function MomentPlusIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M12 5v14M5 12h14" />
    </Svg>
  );
}

export function MomentCloseIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M6 6l12 12M18 6L6 18" />
    </Svg>
  );
}

export function MomentMoreIcon({ className }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="currentColor"
      className={className ?? 'h-5 w-5'}
      aria-hidden="true"
    >
      <circle cx="5" cy="12" r="2" />
      <circle cx="12" cy="12" r="2" />
      <circle cx="19" cy="12" r="2" />
    </svg>
  );
}

export function MomentChevronIcon({
  className,
  direction,
}: IconProps & { direction: 'left' | 'right' }) {
  return (
    <Svg className={className}>
      <path d={direction === 'left' ? 'M15 6l-6 6 6 6' : 'M9 6l6 6-6 6'} />
    </Svg>
  );
}

export function MomentEyeIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" />
      <circle cx="12" cy="12" r="3" />
    </Svg>
  );
}

export function MomentCheckIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="m5.5 12.5 4 4L18.5 8" strokeWidth={3.2} />
    </Svg>
  );
}

export function MomentCommentIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M7.5 4.5h9a4 4 0 0 1 4 4v5a4 4 0 0 1-4 4H10L5.5 21v-3.8a4 4 0 0 1-2-3.5V8.5a4 4 0 0 1 4-4Z" strokeWidth={1.8} />
      <g fill="currentColor" stroke="none">
        <circle cx="7.8" cy="11" r="1" />
        <circle cx="12" cy="11" r="1" />
        <circle cx="16.2" cy="11" r="1" />
      </g>
    </Svg>
  );
}

export function MomentSendIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M21 3L10 14M21 3l-7 18-4-7-7-4z" />
    </Svg>
  );
}

export function MomentEyeOffIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M10.6 5.1A10.7 10.7 0 0 1 12 5c6.5 0 10 7 10 7a17.6 17.6 0 0 1-2.6 3.6M6.6 6.6C3.8 8.4 2 12 2 12s3.5 7 10 7a9.7 9.7 0 0 0 5.4-1.6" />
      <path d="M9.9 9.9a3 3 0 0 0 4.2 4.2M3 3l18 18" />
    </Svg>
  );
}

export function MomentGlobeIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <circle cx="12" cy="12" r="9" />
      <path d="M3 12h18M12 3a14 14 0 0 1 0 18M12 3a14 14 0 0 0 0 18" />
    </Svg>
  );
}

export function MomentFriendsIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <circle cx="9" cy="8" r="3.5" />
      <path d="M2.5 20a6.5 6.5 0 0 1 13 0M16 4.6a3.5 3.5 0 0 1 0 6.8M18 14.2a6.5 6.5 0 0 1 3.5 5.8" />
    </Svg>
  );
}

export function MomentClockIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <circle cx="12" cy="12" r="9" />
      <path d="M12 7v5l3 2" />
    </Svg>
  );
}

export function MomentPauseIcon({ className }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="currentColor"
      className={className ?? 'h-5 w-5'}
      aria-hidden="true"
    >
      <rect x="6" y="5" width="4" height="14" rx="1" />
      <rect x="14" y="5" width="4" height="14" rx="1" />
    </svg>
  );
}

export function MomentPlayIcon({ className }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="currentColor"
      className={className ?? 'h-5 w-5'}
      aria-hidden="true"
    >
      <path d="M7 5.5v13a1 1 0 0 0 1.5.86l11-6.5a1 1 0 0 0 0-1.72l-11-6.5A1 1 0 0 0 7 5.5z" />
    </svg>
  );
}

export function MomentSoundIcon({
  className,
  muted,
}: IconProps & { muted: boolean }) {
  return (
    <Svg className={className}>
      <path d="M4 9h4l5-4v14l-5-4H4z" />
      {muted ? (
        <path d="M17 9l4 6M21 9l-4 6" />
      ) : (
        <path d="M16.5 8.5a5 5 0 0 1 0 7M19 6a8.5 8.5 0 0 1 0 12" />
      )}
    </Svg>
  );
}

export function MomentVideoIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <rect x="3" y="4" width="18" height="16" rx="2" />
      <path d="M7 4v16M17 4v16M3 9h4M3 15h4M17 9h4M17 15h4" />
    </Svg>
  );
}

export function MomentImageIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <rect x="3" y="4" width="18" height="16" rx="2" />
      <circle cx="9" cy="10" r="2" />
      <path d="M21 16l-5-5-9 9" />
    </Svg>
  );
}

export function MomentTrashIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <path d="M4 7h16M10 11v6M14 11v6M6 7l1 13h10l1-13M9 7V4h6v3" />
    </Svg>
  );
}

export function MomentAlignIcon({
  className,
  align,
}: IconProps & { align: MomentTextAlign }) {
  const lines =
    align === 'left'
      ? 'M4 6h16M4 10h10M4 14h16M4 18h10'
      : align === 'right'
        ? 'M4 6h16M10 10h10M4 14h16M10 18h10'
        : 'M4 6h16M7 10h10M4 14h16M7 18h10';
  return (
    <Svg className={className}>
      <path d={lines} />
    </Svg>
  );
}

export function MomentTextStyleIcon({ className }: IconProps) {
  return (
    <Svg className={className}>
      <rect x="3" y="5" width="18" height="14" rx="3" />
      <path d="M9 15l3-7 3 7M10 13h4" />
    </Svg>
  );
}
