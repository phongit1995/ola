import { Application, Container, Sprite, Text, type Ticker } from 'pixi.js';
import { tex } from './assets';

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

export function pressable(target: Container, onTap: () => void): void {
  target.eventMode = 'static';
  target.cursor = 'pointer';
  target.on('pointertap', onTap);
  target.on('pointerdown', () => target.scale.set(0.95));
  target.on('pointerup', () => target.scale.set(1));
  target.on('pointerupoutside', () => target.scale.set(1));
}

export function iconSprite(url: string, height: number): Sprite {
  const s = new Sprite(tex[url]);
  s.anchor.set(0.5);
  s.scale.set(height / s.texture.height);
  return s;
}

export function popIn(target: Container, delay: number, dur = 420): void {
  const base = target.scale.x;
  target.alpha = 0;
  target.scale.set(base * 0.6);
  let t = -delay;
  const step = (ticker: Ticker): void => {
    t += ticker.deltaMS;
    if (t < 0) return;
    const k = Math.min(1, t / dur);
    const c1 = 1.70158;
    const e = 1 + (c1 + 1) * Math.pow(k - 1, 3) + c1 * Math.pow(k - 1, 2);
    target.scale.set(base * (0.6 + 0.4 * e));
    target.alpha = Math.min(1, k * 2.5);
    if (k >= 1) {
      target.scale.set(base);
      target.alpha = 1;
      removeTick(step);
    }
  };
  addTick(step);
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
