import { bgImage } from './penUi';

interface PenButtonProps {
  bg: string;
  label?: string;
  icon?: string;
  ariaLabel?: string;
  onClick?: () => void;
  disabled?: boolean;
  className?: string;
  labelClassName?: string;
  iconClassName?: string;
  gapClassName?: string;
}

export function PenButton({
  bg,
  label,
  icon,
  ariaLabel,
  onClick,
  disabled = false,
  className = '',
  labelClassName = '',
  iconClassName = 'h-5 w-5',
  gapClassName = 'gap-2',
}: PenButtonProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      disabled={disabled}
      aria-label={ariaLabel ?? label}
      style={bgImage(bg)}
      className={`flex items-center justify-center ${gapClassName} bg-center bg-no-repeat font-bold text-white drop-shadow transition active:scale-95 disabled:opacity-60 ${className}`}
    >
      {icon != null && <img src={icon} alt="" className={`shrink-0 object-contain ${iconClassName}`} />}
      {label != null && <span className={labelClassName}>{label}</span>}
    </button>
  );
}
