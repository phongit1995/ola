interface PanelRowProps {
  icon: string;
  title: string;
  subtitle?: string;
  badge?: number;
  onClick?: () => void;
}

export function PanelRow({
  icon,
  title,
  subtitle,
  badge,
  onClick,
}: PanelRowProps) {
  return (
    <li className="border-b border-black/12 last:border-b-0">
      <button
        type="button"
        onClick={onClick}
        className="flex min-h-[72px] w-full items-center gap-4 bg-white/80 px-4 text-left active:bg-black/5"
      >
        <img
          src={icon}
          alt=""
          className="h-10 w-10 shrink-0 rounded-lg object-contain"
        />
        <span className="min-w-0 flex-1">
          <span className="block truncate text-base font-bold text-black/87">
            {title}
          </span>
          {subtitle && (
            <span className="block truncate text-sm text-black/54">
              {subtitle}
            </span>
          )}
        </span>
        {badge != null && badge > 0 && (
          <span className="flex h-5 min-w-5 shrink-0 items-center justify-center rounded-full bg-ola-accent px-1.5 text-xs font-bold text-white">
            {badge > 99 ? '99+' : badge}
          </span>
        )}
      </button>
    </li>
  );
}
