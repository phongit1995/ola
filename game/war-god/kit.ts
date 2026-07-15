import { Application, Container, Text, type Ticker } from 'pixi.js';

export const HEADING = 'Fredoka, system-ui, sans-serif';
export const BODY = 'Nunito, system-ui, sans-serif';

let appRef: Application;

export function initKit(app: Application): void {
  appRef = app;
}

export function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

export function tween(
  obj: Container,
  to: Partial<{ x: number; y: number; alpha: number; scale: number }>,
  dur: number,
): Promise<void> {
  const from = { x: obj.x, y: obj.y, alpha: obj.alpha, scale: obj.scale.x };
  return new Promise((resolve) => {
    let t = 0;
    const step = (ticker: Ticker): void => {
      t += ticker.deltaMS;
      const k = Math.min(1, t / dur);
      const e = 1 - (1 - k) * (1 - k);
      if (to.x !== undefined) obj.x = from.x + (to.x - from.x) * e;
      if (to.y !== undefined) obj.y = from.y + (to.y - from.y) * e;
      if (to.alpha !== undefined) obj.alpha = from.alpha + (to.alpha - from.alpha) * e;
      if (to.scale !== undefined) obj.scale.set(from.scale + (to.scale - from.scale) * e);
      if (k >= 1) {
        appRef.ticker.remove(step);
        resolve();
      }
    };
    appRef.ticker.add(step);
  });
}

export function addTick(step: (ticker: Ticker) => void): void {
  appRef.ticker.add(step);
}

export function removeTick(step: (ticker: Ticker) => void): void {
  appRef.ticker.remove(step);
}

export function makeText(
  text: string,
  size: number,
  color: number,
  weight: '400' | '700' | '800' = '700',
  family = BODY,
): Text {
  const t = new Text({
    text,
    style: {
      fontFamily: family,
      fontSize: size,
      fontWeight: weight,
      fill: color,
      dropShadow: { distance: 1, blur: 2, alpha: 0.85, color: 0x000000 },
    },
  });
  t.anchor.set(0.5);
  return t;
}
