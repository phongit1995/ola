import { Container, Graphics } from 'pixi.js';
import type { LightningArc } from '../../../logic/core';
import { sleep, tween } from '../../../kit';

export interface LightningFxContext {
  tileSize: number;
  boardX: number;
  boardY: number;
  grid: number;
  flyLayer: Container;
  cellRootPos(index: number): { x: number; y: number };
  spriteAt(index: number): Container | null;
  playSound(): void;
}

interface LightningBoltOptions {
  power?: number;
  forks?: number;
  spread?: number;
}

export async function playLightningFx(
  lightningArcs: LightningArc[],
  context: LightningFxContext,
): Promise<void> {
  if (lightningArcs.length === 0) return;
  context.playSound();
  lightningFlash(context);
  new Set(lightningArcs.map((arc) => arc.source)).forEach((source) =>
    lightningPulse(source, context),
  );
  await Promise.all(
    lightningArcs.map((arc, order) => playLightningArc(arc, order, context)),
  );
  await sleep(130);
}

export async function playUltimateLightningFx(
  targets: readonly number[],
  context: LightningFxContext,
): Promise<void> {
  if (targets.length === 0) return;
  context.playSound();
  lightningFlash(context);
  await Promise.all(
    targets.map(async (target, order) => {
      const targetRow = Math.floor(order / 2);
      const targetColumn = order % 2;
      await sleep(targetRow * 260 + targetColumn * 24);
      const to = context.cellRootPos(target);
      const from = {
        x: context.boardX + context.tileSize * (0.7 + order * 2.2),
        y: context.boardY - context.tileSize * 3.2,
      };
      const targetSprite = context.spriteAt(target);
      const originalTint = targetSprite?.tint ?? 0xffffff;
      for (let flicker = 0; flicker < 4; flicker += 1) {
        const bolt = lightningBolt(from, to, context, {
          power: 1.48,
          forks: 7,
          spread: 1.18,
        });
        context.flyLayer.addChild(bolt);
        if (targetSprite) targetSprite.tint = flicker % 2 === 0 ? 0xffffff : 0xbfa8ff;
        await sleep(58);
        bolt.destroy();
        await sleep(14);
      }
      if (targetSprite && !targetSprite.destroyed) targetSprite.tint = originalTint;
      lightningImpact(target, context, 1.35);
    }),
  );
  await sleep(180);
}

function lightningBolt(
  from: { x: number; y: number },
  to: { x: number; y: number },
  context: LightningFxContext,
  options: LightningBoltOptions = {},
): Graphics {
  const { tileSize } = context;
  const power = options.power ?? 1;
  const forkCount = options.forks ?? 5;
  const spread = options.spread ?? 1;
  const dx = to.x - from.x;
  const dy = to.y - from.y;
  const distance = Math.max(1, Math.hypot(dx, dy));
  const nx = -dy / distance;
  const ny = dx / distance;
  const segments = Math.max(8, Math.ceil(distance / (tileSize * 0.3)));
  const bolt = new Graphics();
  bolt.blendMode = 'add';

  const makePath = (lane: number, jitterScale: number): Array<{ x: number; y: number }> => {
    const points: Array<{ x: number; y: number }> = [];
    for (let i = 0; i <= segments; i++) {
      const t = i / segments;
      const edgeFade = Math.sin(Math.PI * t);
      const jitter =
        (lane * tileSize * 0.14 * spread +
          (Math.random() * 2 - 1) * tileSize * jitterScale * spread) *
        edgeFade;
      points.push({
        x: from.x + dx * t + nx * jitter,
        y: from.y + dy * t + ny * jitter,
      });
    }
    return points;
  };
  const strokePath = (
    points: Array<{ x: number; y: number }>,
    width: number,
    color: number,
    alpha: number,
  ): void => {
    bolt.moveTo(points[0].x, points[0].y);
    for (let i = 1; i < points.length; i++) bolt.lineTo(points[i].x, points[i].y);
    bolt.stroke({ width, color, alpha, cap: 'round', join: 'round' });
  };

  const main = makePath(0, 0.2);
  const left = makePath(-1, 0.14);
  const right = makePath(1, 0.14);
  strokePath(main, 18 * power, 0x3816b8, 0.16);
  strokePath(left, 11 * power, 0x5526dc, 0.14);
  strokePath(right, 11 * power, 0x176ee8, 0.14);
  strokePath(main, 10 * power, 0x6334ef, 0.28);
  strokePath(left, 5.5 * power, 0x8557ff, 0.36);
  strokePath(right, 5.5 * power, 0x4aa9ff, 0.36);
  strokePath(left, 2.6 * power, 0xd8bcff, 0.96);
  strokePath(right, 2.6 * power, 0xa9e7ff, 0.96);
  strokePath(main, 5.5 * power, 0xa879ff, 1);
  strokePath(main, 2 * power, 0xffffff, 1);

  const forkIndexes = Array.from({ length: forkCount }, (_, order) => {
    const t = 0.14 + ((order + 0.5) / forkCount) * 0.72;
    return Math.max(1, Math.min(main.length - 2, Math.round(t * segments)));
  });
  forkIndexes.forEach((index, order) => {
    const start = main[index];
    const direction = order % 2 === 0 ? 1 : -1;
    const length = tileSize * (0.42 + Math.random() * 0.42) * spread;
    const tangent = (Math.random() * 2 - 1) * length * 0.38;
    const end = {
      x: start.x + nx * length * direction + (dx / distance) * tangent,
      y: start.y + ny * length * direction + (dy / distance) * tangent,
    };
    const fork = [
      start,
      {
        x: start.x + (end.x - start.x) * 0.42 + nx * (Math.random() * 2 - 1) * tileSize * 0.12,
        y: start.y + (end.y - start.y) * 0.42 + ny * (Math.random() * 2 - 1) * tileSize * 0.12,
      },
      {
        x: start.x + (end.x - start.x) * 0.72 - nx * (Math.random() * 2 - 1) * tileSize * 0.08,
        y: start.y + (end.y - start.y) * 0.72 - ny * (Math.random() * 2 - 1) * tileSize * 0.08,
      },
      end,
    ];
    strokePath(fork, 7 * power, 0x5726db, 0.2);
    strokePath(fork, 3.2 * power, order % 2 === 0 ? 0x9f73ff : 0x67c8ff, 0.62);
    strokePath(fork, 1.25 * power, 0xf4fbff, 0.96);

    if (order % 2 === 0) {
      const twigStart = fork[2];
      const twig = [
        twigStart,
        {
          x: twigStart.x - nx * direction * length * 0.26 + (dx / distance) * length * 0.12,
          y: twigStart.y - ny * direction * length * 0.26 + (dy / distance) * length * 0.12,
        },
      ];
      strokePath(twig, 3.5 * power, 0x4f2ad1, 0.2);
      strokePath(twig, 1.1 * power, 0xcfe9ff, 0.82);
    }
  });
  return bolt;
}

function lightningFlash(context: LightningFxContext): void {
  const { tileSize, boardX, boardY, grid, flyLayer } = context;
  const margin = tileSize * 0.45;
  const flash = new Graphics();
  flash.blendMode = 'add';
  flash
    .roundRect(
      boardX - margin,
      boardY - margin,
      tileSize * grid + margin * 2,
      tileSize * grid + margin * 2,
      tileSize * 0.25,
    )
    .fill({ color: 0xb9d7ff, alpha: 0.2 });
  flyLayer.addChildAt(flash, 0);
  void tween(flash, { alpha: 0 }, 260).then(() => flash.destroy());
}

function lightningBurst(index: number, strength: number, context: LightningFxContext): void {
  const { tileSize, flyLayer, cellRootPos } = context;
  const p = cellRootPos(index);
  const burst = new Graphics();
  burst.blendMode = 'add';
  const rayCount = 12;
  burst.circle(0, 0, tileSize * 0.3).fill({ color: 0xffffff, alpha: 0.9 });
  burst.circle(0, 0, tileSize * 0.52).fill({ color: 0x7c4dff, alpha: 0.2 });
  burst.circle(0, 0, tileSize * 0.48).stroke({ width: 6, color: 0x8f63ff, alpha: 0.92 });
  burst.circle(0, 0, tileSize * 0.7).stroke({ width: 3, color: 0x8cd8ff, alpha: 0.76 });
  for (let ray = 0; ray < rayCount; ray++) {
    const angle = (Math.PI * 2 * ray) / rayCount + (Math.random() - 0.5) * 0.2;
    const inner = tileSize * (0.28 + Math.random() * 0.1);
    const outer = tileSize * (0.82 + Math.random() * 0.42) * strength;
    const bend = angle + (Math.random() - 0.5) * 0.32;
    const points = [
      { x: Math.cos(angle) * inner, y: Math.sin(angle) * inner },
      {
        x: Math.cos(bend) * (inner + outer) * 0.55,
        y: Math.sin(bend) * (inner + outer) * 0.55,
      },
      { x: Math.cos(angle) * outer, y: Math.sin(angle) * outer },
    ];
    burst.moveTo(points[0].x, points[0].y);
    burst.lineTo(points[1].x, points[1].y);
    burst.lineTo(points[2].x, points[2].y);
    burst.stroke({ width: 5, color: 0x6231e6, alpha: 0.22, cap: 'round' });
    burst.moveTo(points[0].x, points[0].y);
    burst.lineTo(points[1].x, points[1].y);
    burst.lineTo(points[2].x, points[2].y);
    burst.stroke({
      width: 1.5,
      color: ray % 2 === 0 ? 0xffffff : 0xa9e7ff,
      alpha: 0.96,
      cap: 'round',
    });
  }
  burst.position.set(p.x, p.y);
  burst.scale.set(0.68);
  flyLayer.addChild(burst);
  void tween(burst, { alpha: 0, scale: 1.55 }, 420).then(() => burst.destroy());
}

function lightningSparks(index: number, amount: number, context: LightningFxContext): void {
  const { tileSize, flyLayer, cellRootPos } = context;
  const p = cellRootPos(index);
  for (let order = 0; order < amount; order++) {
    const angle = (Math.PI * 2 * order) / amount + (Math.random() - 0.5) * 0.5;
    const distance = tileSize * (0.72 + Math.random() * 0.68);
    const spark = new Graphics();
    spark.blendMode = 'add';
    spark.circle(0, 0, tileSize * 0.065).fill({ color: 0x7547f2, alpha: 0.45 });
    spark.circle(0, 0, tileSize * 0.025).fill({ color: 0xf8fdff, alpha: 1 });
    spark.position.set(p.x, p.y);
    flyLayer.addChild(spark);
    void tween(
      spark,
      {
        x: p.x + Math.cos(angle) * distance,
        y: p.y + Math.sin(angle) * distance,
        alpha: 0,
        scale: 0.15,
      },
      280 + Math.random() * 180,
    ).then(() => spark.destroy());
  }
}

function lightningPulse(index: number, context: LightningFxContext): void {
  const { tileSize, flyLayer, cellRootPos } = context;
  const p = cellRootPos(index);
  const pulse = new Graphics();
  pulse.blendMode = 'add';
  pulse.circle(0, 0, tileSize * 0.48).fill({ color: 0xf4f8ff, alpha: 0.76 });
  pulse.circle(0, 0, tileSize * 0.62).stroke({ width: 6, color: 0x8b5cff, alpha: 1 });
  pulse.circle(0, 0, tileSize * 0.82).stroke({ width: 3, color: 0x78cfff, alpha: 0.84 });
  pulse.position.set(p.x, p.y);
  pulse.scale.set(0.7);
  flyLayer.addChild(pulse);
  void tween(pulse, { alpha: 0, scale: 2.15 }, 460).then(() => pulse.destroy());
  lightningBurst(index, 1.05, context);
  lightningSparks(index, 10, context);
}

function lightningImpact(index: number, context: LightningFxContext, strength = 1): void {
  const { tileSize, flyLayer, cellRootPos } = context;
  const p = cellRootPos(index);
  const hit = new Graphics();
  hit.blendMode = 'add';
  hit.circle(0, 0, tileSize * 0.24).fill({ color: 0xffffff, alpha: 1 });
  hit.circle(0, 0, tileSize * 0.43).fill({ color: 0x895cff, alpha: 0.24 });
  hit.circle(0, 0, tileSize * 0.5).stroke({ width: 6, color: 0x9c6fff, alpha: 1 });
  hit.circle(0, 0, tileSize * 0.72).stroke({ width: 3, color: 0xa9e7ff, alpha: 0.9 });
  hit.position.set(p.x, p.y);
  hit.scale.set(0.72 * strength);
  flyLayer.addChild(hit);
  void tween(hit, { alpha: 0, scale: 1.85 * strength }, 420).then(() => hit.destroy());
  lightningBurst(index, 0.9 * strength, context);
  lightningSparks(index, Math.round(8 * strength), context);
}

async function playLightningArc(
  arc: LightningArc,
  order: number,
  context: LightningFxContext,
): Promise<void> {
  await sleep(order * 76);
  const from = context.cellRootPos(arc.source);
  const to = context.cellRootPos(arc.target);
  const targetSprite = context.spriteAt(arc.target);
  const originalTint = targetSprite?.tint ?? 0xffffff;
  for (let flicker = 0; flicker < 4; flicker++) {
    const bolt = lightningBolt(from, to, context, { power: 1.08, forks: 5, spread: 1.08 });
    context.flyLayer.addChild(bolt);
    if (targetSprite) targetSprite.tint = flicker % 2 === 0 ? 0xc9e9ff : 0xe0d2ff;
    await sleep(50);
    bolt.destroy();
    await sleep(16);
  }
  if (targetSprite && !targetSprite.destroyed) targetSprite.tint = originalTint;
  lightningImpact(arc.target, context);
}
