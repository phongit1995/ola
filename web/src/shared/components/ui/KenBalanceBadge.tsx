import { AnimatedKen } from './AnimatedKen';

interface KenBalanceBadgeProps {
  ken?: number;
  className?: string;
}

export function KenBalanceBadge({ ken, className = '' }: KenBalanceBadgeProps) {
  if (typeof ken !== 'number') return null;
  return (
    <div className={`pointer-events-none fixed right-2 top-6 z-[55] ${className}`}>
      <span className="inline-flex items-center gap-1.5 rounded-full border border-ola-primary bg-white/80 px-3.5 py-1.5 shadow-[0_2px_10px_rgba(0,0,0,0.2)] backdrop-blur-sm">
        <AnimatedKen
          value={ken}
          numberClassName="text-lg font-extrabold leading-none text-[#f57f17] [text-shadow:0_1px_0_rgba(255,255,255,0.6)]"
          iconClassName="h-6 w-6"
        />
      </span>
    </div>
  );
}
