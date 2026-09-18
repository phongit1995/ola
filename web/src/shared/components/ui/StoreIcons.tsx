interface IconProps {
  className?: string;
}

export function GooglePlayIcon({ className = 'h-4 w-4' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M3.6 2.3a1.6 1.6 0 0 0-.6 1.3v16.8a1.6 1.6 0 0 0 .6 1.3l9-9.4-9-10ZM14 11.1l2.9-3-11-6.2a1.5 1.5 0 0 0-1.5 0L14 11.1Zm0 1.8-9.6 10a1.5 1.5 0 0 0 1.5 0l11-6.2-2.9-3.8ZM21.1 9.8l-2.8-1.6L15.2 12l3.1 4 2.8-1.6a1.7 1.7 0 0 0 0-2.9Z" />
    </svg>
  );
}
