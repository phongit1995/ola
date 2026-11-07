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

export function AppleIcon({ className = 'h-4 w-4' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M16.365 1.43c0 1.14-.493 2.27-1.177 3.08-.744.9-1.99 1.57-2.987 1.57-.12 0-.23-.02-.3-.03-.01-.06-.04-.22-.04-.39 0-1.15.572-2.27 1.206-2.98.804-.94 2.142-1.64 3.248-1.68.03.13.05.28.05.43zm4.565 15.71c-.03.07-.463 1.58-1.518 3.12-.945 1.34-1.94 2.71-3.43 2.71-1.517 0-1.9-.88-3.63-.88-1.698 0-2.302.91-3.67.91-1.377 0-2.332-1.26-3.428-2.8-1.287-1.82-2.323-4.63-2.323-7.28 0-4.28 2.797-6.55 5.552-6.55 1.448 0 2.675.95 3.6.95.865 0 2.222-1.01 3.902-1.01.613 0 2.886.06 4.374 2.19-.13.09-2.383 1.37-2.383 4.19 0 3.26 2.854 4.42 2.955 4.45z" />
    </svg>
  );
}

export function WindowsIcon({ className = 'h-4 w-4' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M3 5.4 10.4 4.3v7.2H3V5.4Zm8.6-1.3L21 2.8v8.7h-9.4V4.1ZM3 12.5h7.4v7.2L3 18.6v-6.1Zm8.6 0H21v8.7l-9.4-1.3v-7.4Z" />
    </svg>
  );
}

export function LinuxIcon({ className = 'h-4 w-4' }: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      fillRule="evenodd"
      aria-hidden="true"
    >
      <path d="M12 2C9.4 2 7.8 4 7.8 6.6c0 1.3-.3 2.2-1 3.3-1.2 1.8-2.3 3.7-2.3 5.9 0 .8.1 1.5.4 2.2-.9.3-1.4.9-1.4 1.6 0 1.3 2 1.5 3.8 2 1.3.3 2.2.4 2.7-.2h4c.5.6 1.4.5 2.7.2 1.8-.5 3.8-.7 3.8-2 0-.7-.5-1.3-1.4-1.6.3-.7.4-1.4.4-2.2 0-2.2-1.1-4.1-2.3-5.9-.7-1.1-1-2-1-3.3C16.2 4 14.6 2 12 2Zm0 7.8c-2.1 0-3.7 2.6-3.7 5.7 0 2.2 1.5 3.7 3.7 3.7s3.7-1.5 3.7-3.7c0-3.1-1.6-5.7-3.7-5.7ZM10.4 5a.9.9 0 1 0 0 1.8.9.9 0 0 0 0-1.8Zm3.2 0a.9.9 0 1 0 0 1.8.9.9 0 0 0 0-1.8Z" />
    </svg>
  );
}
