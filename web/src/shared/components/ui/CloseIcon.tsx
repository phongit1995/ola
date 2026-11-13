interface CloseIconProps {
  className?: string;
  strokeWidth?: number;
}

export function CloseIcon({
  className = 'h-5 w-5',
  strokeWidth = 2,
}: CloseIconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="none"
      stroke="currentColor"
      strokeWidth={strokeWidth}
      aria-hidden="true"
    >
      <path d="M6 6l12 12M18 6L6 18" strokeLinecap="round" />
    </svg>
  );
}
