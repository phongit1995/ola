interface PresenceBadgeProps {
  icon?: string;
  tone?: 'primary' | 'white';
  className?: string;
}

export function PresenceBadge({ icon, tone = 'primary', className = '' }: PresenceBadgeProps) {
  if (icon == null || icon === '') {
    return (
      <span className={`h-3 w-3 rounded-full border-2 border-white bg-ola-primary ${className}`} />
    );
  }
  if (tone === 'white') {
    return (
      <span
        className={`flex h-4 w-4 items-center justify-center rounded-full border border-white bg-white ${className}`}
      >
        <img src={icon} alt="" className="h-3 w-3 object-contain" />
      </span>
    );
  }
  return (
    <span
      className={`flex h-3.5 w-3.5 items-center justify-center rounded-full bg-ola-primary ring-1 ring-white ${className}`}
    >
      <img src={icon} alt="" className="h-2.5 w-2.5 object-contain" />
    </span>
  );
}
