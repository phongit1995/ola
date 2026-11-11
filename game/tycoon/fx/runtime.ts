export interface Point {
  x: number;
  y: number;
}

export const reducedMotion = (): boolean => window.matchMedia?.('(prefers-reduced-motion: reduce)').matches ?? false;

let tempo = 1;

export function setTempo(value: number): void {
  tempo = Math.max(0.25, value);
}

export function scaled(ms: number): number {
  return ms / tempo;
}

export function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, reducedMotion() ? Math.min(ms, 30) : scaled(ms)));
}

export function animate(el: Element | null | undefined, keyframes: Keyframe[], options: KeyframeAnimationOptions): Promise<void> {
  if (!el || reducedMotion()) return Promise.resolve();
  const timing = { ...options, duration: typeof options.duration === 'number' ? scaled(options.duration) : options.duration, delay: options.delay ? scaled(options.delay) : options.delay };
  return el.animate(keyframes, timing).finished.then(
    () => undefined,
    () => undefined,
  );
}

export function centerOf(el: Element): Point {
  const rect = el.getBoundingClientRect();
  return { x: rect.left + rect.width / 2, y: rect.top + rect.height / 2 };
}

export const byId = (id: string): HTMLElement | null => document.getElementById(id);
export const tileEl = (idx: number): HTMLElement | null => document.querySelector(`[data-tile="${idx}"]`);
export const pawnEl = (seat: number): HTMLElement | null => document.querySelector(`[data-pawn="${seat}"]`);
export const podEl = (seat: number): HTMLElement | null => document.querySelector(`[data-pod="${seat}"]`);

export function boardUnit(): number {
  return (byId('ty-s6-grid')?.getBoundingClientRect().width ?? 340) / 100;
}

export function boardCenter(): Point {
  const grid = byId('ty-s6-grid');
  return grid ? centerOf(grid) : { x: innerWidth / 2, y: innerHeight / 2 };
}

export function seatPoint(seat: number): Point {
  const pod = seat >= 0 ? podEl(seat) : null;
  return pod ? centerOf(pod) : boardCenter();
}

export function tilePoint(idx: number): Point {
  const tile = tileEl(idx);
  return tile ? centerOf(tile) : boardCenter();
}

export function pawnFoot(seat: number): Point {
  const rect = pawnEl(seat)?.querySelector('[data-pawn-body]')?.getBoundingClientRect();
  return rect ? { x: rect.left + rect.width / 2, y: rect.bottom - rect.height * 0.1 } : boardCenter();
}
