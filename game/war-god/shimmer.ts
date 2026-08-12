import { Container, Sprite, Texture, type Ticker } from 'pixi.js';
import { addTick, removeTick } from './kit';

let streakTex: Texture | null = null;

function getStreakTexture(): Texture {
  if (streakTex) return streakTex;
  const c = document.createElement('canvas');
  c.width = 64;
  c.height = 4;
  const ctx = c.getContext('2d')!;
  const g = ctx.createLinearGradient(0, 0, 64, 0);
  g.addColorStop(0, 'rgba(255,255,255,0)');
  g.addColorStop(0.5, 'rgba(255,255,255,1)');
  g.addColorStop(1, 'rgba(255,255,255,0)');
  ctx.fillStyle = g;
  ctx.fillRect(0, 0, 64, 4);
  streakTex = Texture.from(c);
  return streakTex;
}

export interface ShimmerOptions {
  thickness: number;
  length: number;
  rotation?: number;
  period?: number;
  sweep?: number;
  delay?: number;
  alpha?: number;
  isActive?: () => boolean;
}

export function attachShimmer(host: Container, shape: Sprite, opts: ShimmerOptions): () => void {
  const rotation = opts.rotation ?? -0.4;
  const period = opts.period ?? 4200;
  const sweep = opts.sweep ?? 850;
  const delay = opts.delay ?? 0;
  const maxAlpha = opts.alpha ?? 0.55;
  const isActive = opts.isActive ?? (() => true);

  const streak = new Sprite(getStreakTexture());
  streak.anchor.set(0.5);
  streak.blendMode = 'add';
  streak.width = opts.thickness;
  streak.height = opts.length;
  streak.rotation = rotation;
  streak.visible = false;
  host.addChild(streak);

  const mask = new Sprite(shape.texture);
  mask.anchor.set(0.5);
  mask.width = shape.width;
  mask.height = shape.height;
  mask.position.set(shape.x, shape.y);
  host.addChild(mask);
  streak.mask = mask;

  const travel = shape.width / 2 + opts.thickness;
  let clock = -delay;
  let disposed = false;
  const tick = (ticker: Ticker): void => {
    if (host.destroyed || streak.destroyed || mask.destroyed) {
      dispose();
      return;
    }
    if (!isActive()) return;
    clock += ticker.deltaMS;
    const t = ((clock % period) + period) % period;
    if (t < sweep) {
      const k = t / sweep;
      streak.visible = true;
      streak.x = shape.x - travel + 2 * travel * k;
      streak.y = shape.y;
      streak.alpha = maxAlpha * Math.sin(k * Math.PI);
    } else {
      streak.visible = false;
    }
  };
  const dispose = (): void => {
    if (disposed) return;
    disposed = true;
    removeTick(tick);
    if (!streak.destroyed) streak.destroy();
    if (!mask.destroyed) mask.destroy();
  };
  addTick(tick);
  return dispose;
}
