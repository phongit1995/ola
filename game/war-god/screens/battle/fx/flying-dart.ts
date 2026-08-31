import { Container, Graphics, Sprite, type Ticker } from 'pixi.js';
import { A, tex } from '../../../assets';
import { addTick, removeTick, sleep, tween } from '../../../kit';
import type { DartActivation, DartCreation, FlyingDartAxis } from '../../../logic/core';

export interface FlyingDartFxContext {
  tileSize: number;
  boardX: number;
  boardY: number;
  grid: number;
  flyLayer: Container;
  cellRootPos(index: number): { x: number; y: number };
  playSound(): void;
}

function makeDartIcon(point: { x: number; y: number }, context: FlyingDartFxContext): Sprite {
  const icon = new Sprite(tex[A.items.flyingDart]);
  icon.anchor.set(0.5);
  icon.scale.set(
    (context.tileSize * 0.84) / Math.max(icon.texture.width, icon.texture.height),
  );
  icon.position.copyFrom(point);
  return icon;
}

function lineCells(source: number, axis: FlyingDartAxis, grid: number): number[] {
  const x = source % grid;
  const y = Math.floor(source / grid);
  return Array.from(
    { length: grid },
    (_, offset) => (axis === 'horizontal' ? y * grid + offset : offset * grid + x),
  );
}

function rotateIn(icon: Sprite, from: number, to: number, duration: number): Promise<void> {
  let elapsed = 0;
  return new Promise((resolve) => {
    const step = (ticker: Ticker): void => {
      if (icon.destroyed) {
        removeTick(step);
        resolve();
        return;
      }
      elapsed += ticker.deltaMS;
      const progress = Math.min(1, elapsed / duration);
      const eased = 1 - Math.pow(1 - progress, 3);
      icon.rotation = from + (to - from) * eased;
      if (progress < 1) return;
      removeTick(step);
      icon.rotation = to;
      resolve();
    };
    addTick(step);
  });
}

export function directionDecorator(axis: FlyingDartAxis, tileSize: number): Graphics {
  const decorator = new Graphics();
  // Giữ blend normal cho decorator: ở kích thước ô nhỏ, additive quá nhạt trên nền vàng.
  decorator.blendMode = 'normal';
  const horizontal = axis === 'horizontal';
  const barStart = tileSize * 0.52;
  const barEnd = tileSize * 0.72;
  const barWidth = tileSize * 0.065;
  for (const sign of [-1, 1]) {
    if (horizontal) {
      decorator
        .roundRect(sign > 0 ? barStart : -barEnd, -barWidth / 2, barEnd - barStart, barWidth, barWidth / 2)
        .fill({ color: 0xffdf69, alpha: 1 });
      decorator
        .circle(sign * tileSize * 0.49, 0, tileSize * 0.055)
        .fill({ color: 0x55e5ff, alpha: 1 });
    } else {
      decorator
        .roundRect(-barWidth / 2, sign > 0 ? barStart : -barEnd, barWidth, barEnd - barStart, barWidth / 2)
        .fill({ color: 0xffdf69, alpha: 1 });
      decorator
        .circle(0, sign * tileSize * 0.49, tileSize * 0.055)
        .fill({ color: 0x55e5ff, alpha: 1 });
    }
  }
  decorator
    .circle(0, 0, tileSize * 0.45)
    .stroke({ width: 2.5, color: 0x55e5ff, alpha: 0.9 });
  for (let spark = 0; spark < 4; spark++) {
    const angle = Math.PI / 4 + (Math.PI * 2 * spark) / 4;
    const radius = tileSize * 0.56;
    decorator
      .circle(Math.cos(angle) * radius, Math.sin(angle) * radius, tileSize * 0.045)
      .fill({ color: spark % 2 ? 0x55e5ff : 0xffe070, alpha: 1 });
  }
  return decorator;
}

async function charge(source: number, context: FlyingDartFxContext): Promise<void> {
  const point = context.cellRootPos(source);
  const icon = makeDartIcon(point, context);
  const glow = new Graphics();
  glow.blendMode = 'add';
  glow.circle(0, 0, context.tileSize * 0.56).fill({ color: 0x33d9ff, alpha: 0.3 });
  glow.circle(0, 0, context.tileSize * 0.44).stroke({ width: 4, color: 0xffd45c, alpha: 0.95 });
  glow.circle(0, 0, context.tileSize * 0.28).fill({ color: 0xffffff, alpha: 0.36 });
  glow.position.copyFrom(point);
  glow.scale.set(0.42);

  const rays = new Graphics();
  rays.blendMode = 'add';
  for (let ray = 0; ray < 8; ray++) {
    const angle = (Math.PI * 2 * ray) / 8;
    const inner = context.tileSize * 0.48;
    const outer = context.tileSize * (0.72 + (ray % 2) * 0.1);
    rays
      .moveTo(Math.cos(angle) * inner, Math.sin(angle) * inner)
      .lineTo(Math.cos(angle) * outer, Math.sin(angle) * outer)
      .stroke({ width: 3, color: ray % 2 ? 0x55e5ff : 0xffdf69, alpha: 0.9, cap: 'round' });
  }
  rays.position.copyFrom(point);
  rays.scale.set(0.35);
  context.flyLayer.addChild(rays, glow, icon);

  const baseScale = icon.scale.x;
  const spin = new Promise<void>((resolve) => {
    let elapsed = 0;
    const step = (ticker: Ticker): void => {
      if (icon.destroyed) {
        removeTick(step);
        resolve();
        return;
      }
      elapsed += ticker.deltaMS;
      const progress = Math.min(1, elapsed / 260);
      const eased = 1 - Math.pow(1 - progress, 3);
      icon.rotation = eased * Math.PI * 2.1;
      icon.scale.set(baseScale * (1 + eased * 0.28));
      glow.rotation = -eased * Math.PI * 1.4;
      rays.rotation = eased * Math.PI * 0.5;
      if (progress < 1) return;
      removeTick(step);
      resolve();
    };
    addTick(step);
  });
  await Promise.all([
    spin,
    tween(glow, { alpha: 0.12, scale: 1.25 }, 260),
    tween(rays, { alpha: 0, scale: 1.2 }, 260),
  ]);
  icon.destroy();
  glow.destroy();
  rays.destroy();
}

async function sweep(activation: DartActivation, context: FlyingDartFxContext): Promise<void> {
  const { source, axis } = activation;
  const boardSize = context.tileSize * context.grid;
  const point = context.cellRootPos(source);
  const beam = new Graphics();
  beam.blendMode = 'add';
  if (axis === 'horizontal') {
    beam
      .roundRect(context.boardX, point.y - context.tileSize * 0.14, boardSize, context.tileSize * 0.28, 8)
      .fill({ color: 0x35d9ff, alpha: 0.34 });
    beam
      .moveTo(context.boardX, point.y)
      .lineTo(context.boardX + boardSize, point.y)
      .stroke({ width: 4, color: 0xffdd67, alpha: 0.92, cap: 'round' });
  } else {
    beam
      .roundRect(point.x - context.tileSize * 0.14, context.boardY, context.tileSize * 0.28, boardSize, 8)
      .fill({ color: 0x35d9ff, alpha: 0.34 });
    beam
      .moveTo(point.x, context.boardY)
      .lineTo(point.x, context.boardY + boardSize)
      .stroke({ width: 4, color: 0xffdd67, alpha: 0.92, cap: 'round' });
  }
  beam.alpha = 0;
  context.flyLayer.addChild(beam);

  const traveler = new Container();
  const travelerIcon = makeDartIcon({ x: 0, y: 0 }, context);
  travelerIcon.rotation = axis === 'vertical' ? Math.PI / 2 : 0;
  travelerIcon.position.set(0, 0);
  traveler.addChild(directionDecorator(axis, context.tileSize), travelerIcon);
  traveler.scale.set(0.34);
  traveler.alpha = 0.96;
  const travelFrom =
    axis === 'horizontal'
      ? { x: context.boardX - context.tileSize * 0.8, y: point.y }
      : { x: point.x, y: context.boardY - context.tileSize * 0.8 };
  const travelTo =
    axis === 'horizontal'
      ? { x: context.boardX + boardSize + context.tileSize * 0.8, y: point.y }
      : { x: point.x, y: context.boardY + boardSize + context.tileSize * 0.8 };
  traveler.position.set(travelFrom.x, travelFrom.y);
  context.flyLayer.addChild(traveler);

  const flashes = lineCells(source, axis, context.grid).map(async (index, order) => {
    await sleep(order * 26);
    const cell = context.cellRootPos(index);
    const flash = new Graphics();
    flash.blendMode = 'add';
    flash
      .roundRect(
        -context.tileSize * 0.39,
        -context.tileSize * 0.39,
        context.tileSize * 0.78,
        context.tileSize * 0.78,
        context.tileSize * 0.16,
      )
      .fill({ color: 0x9ff7ff, alpha: 0.36 })
      .roundRect(
        -context.tileSize * 0.28,
        -context.tileSize * 0.28,
        context.tileSize * 0.56,
        context.tileSize * 0.56,
        context.tileSize * 0.12,
      )
      .stroke({ width: 3, color: 0xffffff, alpha: 0.92 });
    flash.circle(0, 0, context.tileSize * 0.16).fill({ color: 0xffffff, alpha: 0.9 });
    flash.position.copyFrom(cell);
    flash.scale.set(0.32);
    context.flyLayer.addChild(flash);
    await tween(flash, { alpha: 0, scale: 1.35 }, 250);
    flash.destroy();
  });

  await Promise.all([
    tween(beam, { alpha: 1 }, 70).then(() => tween(beam, { alpha: 0 }, 330)),
    tween(traveler, { x: travelTo.x, y: travelTo.y, alpha: 0, scale: 0.12 }, 360).then(() =>
      traveler.destroy(),
    ),
    ...flashes,
  ]);
  beam.destroy();
}

export async function playFlyingDartFx(
  activations: readonly DartActivation[],
  context: FlyingDartFxContext,
): Promise<void> {
  if (activations.length === 0) return;
  context.playSound();
  for (const [order, activation] of activations.entries()) {
    if (order > 0) await sleep(70);
    await charge(activation.source, context);
    await sweep(activation, context);
  }
}

export async function playFlyingDartCreationFx(
  creation: DartCreation,
  context: FlyingDartFxContext,
): Promise<void> {
  const point = context.cellRootPos(creation.index);
  const icon = makeDartIcon(point, context);
  const glow = new Graphics();
  glow.blendMode = 'add';
  glow.circle(0, 0, context.tileSize * 0.62).fill({ color: 0x2ddcff, alpha: 0.36 });
  glow.circle(0, 0, context.tileSize * 0.46).stroke({ width: 5, color: 0xffda57, alpha: 0.95 });
  glow.position.copyFrom(point);
  glow.scale.set(0.18);

  const ring = new Graphics();
  ring.blendMode = 'add';
  ring
    .circle(0, 0, context.tileSize * 0.56)
    .stroke({ width: 3, color: 0xffffff, alpha: 0.9 })
    .circle(0, 0, context.tileSize * 0.78)
    .stroke({ width: 7, color: 0x42e6ff, alpha: 0.58 });
  ring.position.copyFrom(point);
  ring.scale.set(0.12);

  const rays = new Graphics();
  rays.blendMode = 'add';
  for (let ray = 0; ray < 8; ray++) {
    const angle = (Math.PI * 2 * ray) / 8;
    const inner = context.tileSize * 0.42;
    const outer = context.tileSize * (0.84 + (ray % 2) * 0.14);
    rays
      .moveTo(Math.cos(angle) * inner, Math.sin(angle) * inner)
      .lineTo(Math.cos(angle) * outer, Math.sin(angle) * outer)
      .stroke({ width: 3.5, color: ray % 2 ? 0x4eeaff : 0xffe070, alpha: 0.94, cap: 'round' });
  }
  rays.position.copyFrom(point);
  rays.scale.set(0.12);

  const direction = directionDecorator(
    creation.type === 'flyingDartHorizontal' ? 'horizontal' : 'vertical',
    context.tileSize,
  );
  direction.position.copyFrom(point);
  direction.scale.set(0.16);

  const core = new Graphics();
  core.blendMode = 'add';
  core.circle(0, 0, context.tileSize * 0.2).fill({ color: 0xffffff, alpha: 0.92 });
  core.position.copyFrom(point);
  core.scale.set(0.2);

  icon.alpha = 0;
  icon.scale.set(icon.scale.x * 0.35);
  icon.rotation = -Math.PI * 0.7;
  context.flyLayer.addChild(ring, rays, direction, glow, core, icon);
  await Promise.all([
    tween(icon, { alpha: 1, scale: icon.scale.x / 0.35 }, 420),
    rotateIn(icon, -Math.PI * 0.7, 0, 420),
    tween(glow, { alpha: 0, scale: 1.5 }, 480),
    tween(ring, { alpha: 0, scale: 1.65 }, 520),
    tween(rays, { alpha: 0, scale: 1.42 }, 390),
    tween(direction, { alpha: 0, scale: 1.46 }, 440),
    tween(core, { alpha: 0, scale: 1.8 }, 250),
  ]);
  icon.destroy();
  glow.destroy();
  ring.destroy();
  rays.destroy();
  direction.destroy();
  core.destroy();
}
