import { useEffect, useRef, useState } from 'react';
import { formatKen } from '@lib';
import kenIconUrl from '@/assets/icons/apps/ken.png';

const SETTLE_MS = 700;

interface AnimatedKenProps {
  value: number;
  className?: string;
  numberClassName?: string;
  iconClassName?: string;
  showIcon?: boolean;
  bounce?: boolean;
  tweenMs?: number;
  startDelayMs?: number;
}

export function AnimatedKen({
  value,
  className = '',
  numberClassName = 'text-xl leading-none text-[#ffca28]',
  iconClassName = 'h-5 w-5',
  showIcon = true,
  bounce = true,
  tweenMs = 500,
  startDelayMs = 0,
}: AnimatedKenProps) {
  const [display, setDisplay] = useState(value);
  const [settled, setSettled] = useState(false);
  const [bump, setBump] = useState(0);
  const displayRef = useRef(value);
  const rafRef = useRef<number | null>(null);

  useEffect(() => {
    displayRef.current = display;
  });

  useEffect(() => {
    const id = setTimeout(() => setSettled(true), SETTLE_MS);
    return () => clearTimeout(id);
  }, []);

  useEffect(() => {
    const from = displayRef.current;
    const to = value;
    if (from === to) return;
    if (!settled) {
      rafRef.current = requestAnimationFrame(() => setDisplay(to));
      return () => {
        if (rafRef.current) cancelAnimationFrame(rafRef.current);
      };
    }
    const start = performance.now() + startDelayMs;
    let bumped = false;
    const step = (now: number) => {
      if (now < start) {
        rafRef.current = requestAnimationFrame(step);
        return;
      }
      if (!bumped) {
        bumped = true;
        setBump((b) => b + 1);
      }
      const progress = Math.min(1, (now - start) / tweenMs);
      const eased = 1 - (1 - progress) ** 3;
      setDisplay(Math.round(from + (to - from) * eased));
      if (progress < 1) rafRef.current = requestAnimationFrame(step);
    };
    rafRef.current = requestAnimationFrame(step);
    return () => {
      if (rafRef.current) cancelAnimationFrame(rafRef.current);
    };
  }, [value, settled, tweenMs, startDelayMs]);

  const bumpClass = bounce && bump > 0 ? ' animate-ola-ken-bump' : '';

  return (
    <span
      key={bump}
      className={`inline-flex items-center gap-1.5 leading-none ${className}${bumpClass}`}
    >
      <b className={numberClassName}>{formatKen(display)}</b>
      {showIcon && <img src={kenIconUrl} alt="KEN" className={`block shrink-0 ${iconClassName}`} />}
    </span>
  );
}
