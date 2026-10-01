import type { ReactNode } from 'react';

function StrokeIcon({
  className,
  children,
}: {
  className: string;
  children: ReactNode;
}) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
    >
      {children}
    </svg>
  );
}

export function LookupIcon({ className = 'h-5 w-5' }: { className?: string }) {
  return (
    <StrokeIcon className={className}>
      <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20V3H6.5A2.5 2.5 0 0 0 4 5.5z" />
      <path d="M4 19.5A2.5 2.5 0 0 0 6.5 22H20v-5" />
    </StrokeIcon>
  );
}

export function TrophyIcon({ className = 'h-5 w-5' }: { className?: string }) {
  return (
    <StrokeIcon className={className}>
      <path d="M8 21h8M12 17v4M7 4h10v5a5 5 0 0 1-10 0z" />
      <path d="M17 5h3v2a3 3 0 0 1-3 3M7 5H4v2a3 3 0 0 0 3 3" />
    </StrokeIcon>
  );
}

export function HelpIcon({ className = 'h-5 w-5' }: { className?: string }) {
  return (
    <StrokeIcon className={className}>
      <circle cx="12" cy="12" r="10" />
      <path d="M9.1 9a3 3 0 0 1 5.8 1c0 2-3 3-3 3M12 17h.01" />
    </StrokeIcon>
  );
}

export function InfoIcon({ className = 'h-5 w-5' }: { className?: string }) {
  return (
    <StrokeIcon className={className}>
      <circle cx="12" cy="12" r="10" />
      <path d="M12 11v5.5M12 7.5h.01" />
    </StrokeIcon>
  );
}
