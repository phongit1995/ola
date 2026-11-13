import { TURN_SECONDS } from '../logic/constants';

export const URGENT_SECONDS = 10;

export function TurnRing({ leftMs }: { leftMs: number }) {
  const left = Math.max(0, Math.min(1, leftMs / (TURN_SECONDS * 1000))) * 100;
  return (
    <svg className="ty-s6-ring" viewBox="0 0 36 36" aria-hidden="true">
      <circle className="ty-s6-ring-track" cx="18" cy="18" r="16" />
      <circle className="ty-s6-ring-left" cx="18" cy="18" r="16" pathLength={100} strokeDasharray="100" strokeDashoffset={100 - left} />
    </svg>
  );
}
