export { AppleIcon, GooglePlayIcon } from '@components';

interface IconProps {
  className?: string;
}

export function AndroidIcon({ className = 'h-6 w-6' }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} aria-hidden="true">
      <g
        fill="none"
        stroke="currentColor"
        strokeWidth="1.5"
        strokeLinecap="round"
      >
        <path d="M8.4 3.5 9.9 6" />
        <path d="M15.6 3.5 14.1 6" />
      </g>
      <path
        fill="currentColor"
        fillRule="evenodd"
        clipRule="evenodd"
        d="M12 5.6c-3.48 0-6.3 2.6-6.3 5.8h12.6c0-3.2-2.82-5.8-6.3-5.8Zm-2.3 2.5a.85.85 0 1 0 0 1.7.85.85 0 0 0 0-1.7Zm4.6 0a.85.85 0 1 0 0 1.7.85.85 0 0 0 0-1.7Z"
      />
      <rect
        x="8.6"
        y="17"
        width="2.2"
        height="5"
        rx="1.1"
        fill="currentColor"
      />
      <rect
        x="13.2"
        y="17"
        width="2.2"
        height="5"
        rx="1.1"
        fill="currentColor"
      />
      <rect
        x="6.6"
        y="12.4"
        width="10.8"
        height="7.8"
        rx="1.7"
        fill="currentColor"
      />
      <rect
        x="3.9"
        y="12.4"
        width="2.3"
        height="6.4"
        rx="1.15"
        fill="currentColor"
      />
      <rect
        x="17.8"
        y="12.4"
        width="2.3"
        height="6.4"
        rx="1.15"
        fill="currentColor"
      />
    </svg>
  );
}

export function DownloadIcon({ className = 'h-4 w-4' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M5 20h14v-2H5v2ZM19 9h-4V3H9v6H5l7 7 7-7Z" />
    </svg>
  );
}

export function CopyIcon({ className = 'h-4 w-4' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M16 1H4a2 2 0 0 0-2 2v14h2V3h12V1Zm3 4H8a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h11a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2Zm0 16H8V7h11v14Z" />
    </svg>
  );
}

export function WarningIcon({ className = 'h-5 w-5' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M1 21h22L12 2 1 21Zm12-3h-2v-2h2v2Zm0-4h-2v-4h2v4Z" />
    </svg>
  );
}

export function ShieldIcon({ className = 'h-5 w-5' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M12 1 3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4Zm-1 15-3.5-3.5 1.41-1.41L11 13.17l4.09-4.08 1.41 1.41L11 16Z" />
    </svg>
  );
}

export function PhoneIcon({ className = 'h-5 w-5' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M17 1H7a2.5 2.5 0 0 0-2.5 2.5v17A2.5 2.5 0 0 0 7 23h10a2.5 2.5 0 0 0 2.5-2.5v-17A2.5 2.5 0 0 0 17 1Zm.5 18h-11V5h11v14Z" />
    </svg>
  );
}

export function CloseIcon({ className = 'h-4 w-4' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41Z" />
    </svg>
  );
}

export function ChevronIcon({ className = 'h-5 w-5' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6-1.41-1.41Z" />
    </svg>
  );
}
