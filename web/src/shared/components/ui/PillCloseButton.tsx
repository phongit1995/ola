import { CloseIcon } from './CloseIcon';
interface PillCloseButtonProps {
  label: string;
  onClick: () => void;
}

export function PillCloseButton({ label, onClick }: PillCloseButtonProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-label={label}
      className="pointer-events-auto flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-ola-primary-ink/70 transition-colors hover:bg-black/10"
    >
      <CloseIcon className="h-3.5 w-3.5" strokeWidth={2.5} />
    </button>
  );
}
