import { cn } from '@lib';

type SpinnerTone = 'primary' | 'light' | 'muted';

const TONE_CLASS: Record<SpinnerTone, string> = {
  primary: 'text-ola-primary-ink',
  light: 'text-white',
  muted: 'text-black/40',
};

interface SpinnerProps {
  size?: number;
  thickness?: number;
  tone?: SpinnerTone;
  className?: string;
}

export function Spinner({
  size = 24,
  thickness = 2,
  tone = 'primary',
  className,
}: SpinnerProps) {
  return (
    <span
      role="status"
      aria-label="loading"
      className={cn(
        'inline-block animate-spin rounded-full border-solid border-current border-t-transparent',
        TONE_CLASS[tone],
        className
      )}
      style={{ width: size, height: size, borderWidth: thickness }}
    />
  );
}
