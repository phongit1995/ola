import { useEffect, useState } from 'react';
import { AnimatedKen } from './AnimatedKen';

const SHOW_MS = 3200;
const TWEEN_MS = 1100;
const START_DELAY_MS = 450;

interface KenBalanceBadgeProps {
  ken?: number;
  className?: string;
}

export function KenBalanceBadge({ ken, className = '' }: KenBalanceBadgeProps) {
  const [prevKen, setPrevKen] = useState(ken);
  const [visible, setVisible] = useState(false);

  if (ken !== prevKen) {
    setPrevKen(ken);
    if (typeof prevKen === 'number' && typeof ken === 'number') setVisible(true);
  }

  useEffect(() => {
    if (!visible) return;
    const id = setTimeout(() => setVisible(false), SHOW_MS);
    return () => clearTimeout(id);
  }, [visible, ken]);

  if (typeof ken !== 'number') return null;

  return (
    <div
      className={`pointer-events-none fixed right-2 top-6 z-[55] transition-opacity duration-300 ${
        visible ? 'opacity-100' : 'opacity-0'
      } ${className}`}
    >
      <span className="inline-flex items-center gap-1.5 rounded-full border border-ola-primary bg-white/80 px-3.5 py-1.5 shadow-[0_2px_10px_rgba(0,0,0,0.2)] backdrop-blur-sm">
        <AnimatedKen
          value={ken}
          tweenMs={TWEEN_MS}
          startDelayMs={START_DELAY_MS}
          numberClassName="text-lg font-extrabold leading-none text-[#f57f17] [text-shadow:0_1px_0_rgba(255,255,255,0.6)]"
          iconClassName="h-6 w-6"
        />
      </span>
    </div>
  );
}
