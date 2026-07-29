import { useEffect, type RefObject } from 'react';

const POINTER_MAX_TICK_DEG = 15;

function wheelAngleFromTransform(transform: string): number {
  if (!transform || transform === 'none') return 0;
  const open = transform.indexOf('(');
  const close = transform.indexOf(')');
  if (open < 0 || close < 0) return 0;
  const parts = transform.slice(open + 1, close).split(',');
  const a = Number(parts[0]);
  const b = Number(parts[1]);
  if (Number.isNaN(a) || Number.isNaN(b)) return 0;
  return (Math.atan2(b, a) * 180) / Math.PI;
}

function pointerTickDeg(wheelAngle: number, angle: number): number {
  if (angle <= 0) return 0;
  const phase = (((wheelAngle - angle / 2) % angle) + angle) % angle;
  const t = phase / angle;
  return -POINTER_MAX_TICK_DEG * t * t;
}

export function usePointerTick(
  wheelRef: RefObject<HTMLDivElement | null>,
  pointerRef: RefObject<HTMLImageElement | null>,
  spinning: boolean,
  angle: number
) {
  useEffect(() => {
    const pointer = pointerRef.current;
    if (!spinning) {
      if (pointer) pointer.style.rotate = '0deg';
      return;
    }
    let frame = 0;
    const step = () => {
      const wheel = wheelRef.current;
      if (wheel && pointer) {
        const wheelAngle = wheelAngleFromTransform(
          getComputedStyle(wheel).transform
        );
        pointer.style.rotate = `${pointerTickDeg(wheelAngle, angle)}deg`;
      }
      frame = requestAnimationFrame(step);
    };
    frame = requestAnimationFrame(step);
    return () => {
      cancelAnimationFrame(frame);
      if (pointer) pointer.style.rotate = '0deg';
    };
  }, [wheelRef, pointerRef, spinning, angle]);
}
