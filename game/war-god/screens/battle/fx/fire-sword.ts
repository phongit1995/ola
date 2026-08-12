import { Container, Graphics, Sprite, type Ticker } from 'pixi.js';
import { A, tex } from '../../../assets';
import { addTick, removeTick, sleep, tween } from '../../../kit';

export interface FireSwordFxContext {
  tileSize: number;
  boardX: number;
  boardY: number;
  grid: number;
  flyLayer: Container;
  cellRootPos(index: number): { x: number; y: number };
  spriteAt(index: number): Container | null;
  playSound(): void;
}

export async function playFireSwordFx(
  sources: readonly number[],
  removed: ReadonlySet<number>,
  context: FireSwordFxContext,
  preview = false,
): Promise<void> {
  if (sources.length === 0) return;
  context.playSound();
  fireBoardFlash(context);
  await Promise.all(
    sources.map((source, order) =>
      fireSwordExplosion(source, blastCells(source, removed, context.grid), order, preview, context),
    ),
  );
}

function blastCells(source: number, removed: ReadonlySet<number>, grid: number): number[] {
  const sourceX = source % grid;
  const sourceY = Math.floor(source / grid);
  const cells: number[] = [];
  for (let dy = -1; dy <= 1; dy++) {
    for (let dx = -1; dx <= 1; dx++) {
      const x = sourceX + dx;
      const y = sourceY + dy;
      if (x < 0 || x >= grid || y < 0 || y >= grid) continue;
      const index = y * grid + x;
      if (removed.has(index)) cells.push(index);
    }
  }
  return cells;
}

function fireBoardFlash(context: FireSwordFxContext): void {
  const { tileSize, grid, boardX, boardY, flyLayer } = context;
  const margin = tileSize * 0.35;
  const flash = new Graphics();
  flash.blendMode = 'add';
  flash
    .roundRect(
      boardX - margin,
      boardY - margin,
      tileSize * grid + margin * 2,
      tileSize * grid + margin * 2,
      tileSize * 0.2,
    )
    .fill({ color: 0xff6a20, alpha: 0.12 });
  flyLayer.addChildAt(flash, 0);
  void tween(flash, { alpha: 0 }, 240).then(() => flash.destroy());
}

function makeChargeIcon(source: number, context: FireSwordFxContext): Sprite {
  const point = context.cellRootPos(source);
  const icon = new Sprite(tex[A.items.fireSword]);
  icon.anchor.set(0.5);
  icon.scale.set(
    (context.tileSize * 0.82) / Math.max(icon.texture.width, icon.texture.height),
  );
  icon.position.set(point.x, point.y);
  return icon;
}

async function charge(icon: Sprite, context: FireSwordFxContext): Promise<void> {
  const { tileSize, flyLayer } = context;
  const glow = new Graphics();
  glow.blendMode = 'add';
  glow.circle(0, 0, tileSize * 0.34).fill({ color: 0xffffff, alpha: 0.5 });
  glow.circle(0, 0, tileSize * 0.52).fill({ color: 0xff7a24, alpha: 0.34 });
  glow.circle(0, 0, tileSize * 0.62).stroke({ width: 5, color: 0xffc34d, alpha: 0.9 });
  for (let ray = 0; ray < 8; ray++) {
    const angle = (Math.PI * 2 * ray) / 8;
    const inner = tileSize * 0.44;
    const outer = tileSize * (0.66 + (ray % 2) * 0.12);
    glow.moveTo(Math.cos(angle) * inner, Math.sin(angle) * inner);
    glow.lineTo(Math.cos(angle) * outer, Math.sin(angle) * outer);
    glow.stroke({ width: 3, color: 0xffdf72, alpha: 0.82, cap: 'round' });
  }
  glow.position.copyFrom(icon.position);
  glow.scale.set(0.48);
  flyLayer.addChild(glow, icon);
  const baseX = icon.x;
  const baseY = icon.y;
  const baseScale = icon.scale.x;
  const baseRotation = icon.rotation;
  const duration = 140;
  const shake = new Promise<void>((resolve) => {
    let elapsed = 0;
    const step = (ticker: Ticker): void => {
      if (icon.destroyed) {
        removeTick(step);
        resolve();
        return;
      }
      elapsed += ticker.deltaMS;
      const progress = Math.min(1, elapsed / duration);
      icon.x = baseX + Math.sin(elapsed * 0.22) * tileSize * 0.028 * progress;
      icon.y = baseY + Math.cos(elapsed * 0.27) * tileSize * 0.018 * progress;
      icon.rotation = baseRotation + Math.sin(elapsed * 0.18) * 0.055 * progress;
      icon.scale.set(baseScale * (1 + progress * 0.26 + Math.sin(elapsed * 0.24) * 0.025));
      glow.rotation = elapsed * 0.009;
      if (progress < 1) return;
      icon.position.set(baseX, baseY);
      icon.rotation = baseRotation;
      icon.scale.set(baseScale * 1.26);
      removeTick(step);
      resolve();
    };
    addTick(step);
  });
  await Promise.all([shake, tween(glow, { alpha: 0.3, scale: 1.28 }, duration)]);
  glow.destroy();
}

function embers(point: { x: number; y: number }, amount: number, context: FireSwordFxContext): Promise<void> {
  const { tileSize, flyLayer } = context;
  const jobs: Promise<void>[] = [];
  for (let order = 0; order < amount; order++) {
    const angle = (Math.PI * 2 * order) / amount + (Math.random() - 0.5) * 0.42;
    const distance = tileSize * (0.7 + Math.random() * 0.95);
    const ember = new Graphics();
    ember.blendMode = 'add';
    ember.circle(0, 0, tileSize * 0.075).fill({ color: 0xff5b1a, alpha: 0.58 });
    ember.circle(0, 0, tileSize * 0.032).fill({ color: 0xfff0a0, alpha: 1 });
    ember.position.set(point.x, point.y);
    flyLayer.addChild(ember);
    jobs.push(
      tween(
        ember,
        {
          x: point.x + Math.cos(angle) * distance,
          y: point.y + Math.sin(angle) * distance - tileSize * 0.18,
          alpha: 0,
          scale: 0.18,
        },
        310 + Math.random() * 150,
      ).then(() => ember.destroy()),
    );
  }
  return Promise.all(jobs).then(() => undefined);
}

function smoke(point: { x: number; y: number }, context: FireSwordFxContext): Promise<void> {
  const { tileSize, flyLayer } = context;
  const jobs: Promise<void>[] = [];
  for (let order = 0; order < 5; order++) {
    const angle = (Math.PI * 2 * order) / 5 + Math.random() * 0.45;
    const puff = new Graphics();
    puff.circle(0, 0, tileSize * (0.2 + Math.random() * 0.1)).fill({
      color: order % 2 === 0 ? 0x61180d : 0x9e3215,
      alpha: 0.3,
    });
    puff.position.set(point.x, point.y);
    puff.scale.set(0.65);
    flyLayer.addChildAt(puff, 0);
    jobs.push(
      tween(
        puff,
        {
          x: point.x + Math.cos(angle) * tileSize * (0.42 + Math.random() * 0.25),
          y: point.y + Math.sin(angle) * tileSize * 0.34 - tileSize * 0.22,
          alpha: 0,
          scale: 1.8,
        },
        390,
      ).then(() => puff.destroy()),
    );
  }
  return Promise.all(jobs).then(() => undefined);
}

function blast(point: { x: number; y: number }, context: FireSwordFxContext): Promise<void> {
  const { tileSize, flyLayer } = context;
  const cloud = new Container();
  cloud.blendMode = 'add';
  for (let lobe = 0; lobe < 8; lobe++) {
    const angle = (Math.PI * 2 * lobe) / 8 + (Math.random() - 0.5) * 0.22;
    const distance = tileSize * (0.16 + Math.random() * 0.18);
    const flame = new Graphics();
    flame.ellipse(0, 0, tileSize * 0.3, tileSize * 0.46).fill({
      color: lobe % 2 === 0 ? 0xff5a16 : 0xff8b20,
      alpha: 0.7,
    });
    flame.ellipse(0, tileSize * 0.04, tileSize * 0.17, tileSize * 0.3).fill({
      color: 0xffd653,
      alpha: 0.88,
    });
    flame.position.set(Math.cos(angle) * distance, Math.sin(angle) * distance);
    flame.rotation = angle + Math.PI / 2;
    cloud.addChild(flame);
  }
  cloud.position.set(point.x, point.y);
  cloud.scale.set(0.32);
  const hotCore = new Graphics();
  hotCore.blendMode = 'add';
  hotCore.circle(0, 0, tileSize * 0.24).fill({ color: 0xffffff, alpha: 1 });
  hotCore.circle(0, 0, tileSize * 0.42).fill({ color: 0xffdc62, alpha: 0.86 });
  hotCore.position.set(point.x, point.y);
  hotCore.scale.set(0.42);
  const wave = new Graphics();
  wave.blendMode = 'add';
  wave.circle(0, 0, tileSize * 0.64).fill({ color: 0xff5a18, alpha: 0.09 });
  wave.circle(0, 0, tileSize * 0.62).stroke({ width: 8, color: 0xff5a1b, alpha: 0.38 });
  wave.circle(0, 0, tileSize * 0.57).stroke({ width: 2.5, color: 0xfff0a0, alpha: 0.96 });
  wave.position.set(point.x, point.y);
  wave.scale.set(0.3);
  const echo = new Graphics();
  echo.blendMode = 'add';
  echo.circle(0, 0, tileSize * 0.55).stroke({ width: 4, color: 0xff9b36, alpha: 0.72 });
  echo.circle(0, 0, tileSize * 0.5).stroke({ width: 1.5, color: 0xffe7a0, alpha: 0.86 });
  echo.position.set(point.x, point.y);
  echo.scale.set(0.24);
  const tongues = new Graphics();
  tongues.blendMode = 'add';
  for (let ray = 0; ray < 8; ray++) {
    const angle = (Math.PI * 2 * ray) / 8 + (Math.random() - 0.5) * 0.18;
    const inner = tileSize * 0.16;
    const outer = tileSize * (0.92 + Math.random() * 0.3);
    const bend = (ray % 2 === 0 ? 1 : -1) * tileSize * (0.2 + Math.random() * 0.12);
    const startX = Math.cos(angle) * inner;
    const startY = Math.sin(angle) * inner;
    const endX = Math.cos(angle) * outer;
    const endY = Math.sin(angle) * outer;
    const controlX = Math.cos(angle) * outer * 0.56 - Math.sin(angle) * bend;
    const controlY = Math.sin(angle) * outer * 0.56 + Math.cos(angle) * bend;
    tongues.moveTo(startX, startY);
    tongues.quadraticCurveTo(controlX, controlY, endX, endY);
    tongues.stroke({ width: 9, color: 0xb82b0c, alpha: 0.2, cap: 'round' });
    tongues.moveTo(startX, startY);
    tongues.quadraticCurveTo(controlX, controlY, endX, endY);
    tongues.stroke({ width: 3.5, color: 0xff7620, alpha: 0.78, cap: 'round' });
    tongues.moveTo(startX, startY);
    tongues.quadraticCurveTo(controlX, controlY, endX * 0.72, endY * 0.72);
    tongues.stroke({ width: 1.2, color: 0xffef9c, alpha: 0.96, cap: 'round' });
  }
  tongues.position.set(point.x, point.y);
  tongues.scale.set(0.62);
  flyLayer.addChild(wave, echo, tongues, cloud, hotCore);
  return Promise.all([
    tween(hotCore, { alpha: 0, scale: 1.3 }, 245).then(() => hotCore.destroy()),
    tween(cloud, { alpha: 0, scale: 1.52 }, 350).then(() => cloud.destroy({ children: true })),
    tween(wave, { alpha: 0, scale: 2.2 }, 390).then(() => wave.destroy()),
    sleep(58).then(() => tween(echo, { alpha: 0, scale: 2.45 }, 360)).then(() => echo.destroy()),
    tween(tongues, { alpha: 0, scale: 1.34 }, 345).then(() => tongues.destroy()),
    embers(point, 14, context),
    smoke(point, context),
  ]).then(() => undefined);
}

async function cellImpact(index: number, source: number, context: FireSwordFxContext): Promise<void> {
  const { tileSize, grid, flyLayer, cellRootPos, spriteAt } = context;
  const sourceX = source % grid;
  const sourceY = Math.floor(source / grid);
  const x = index % grid;
  const y = Math.floor(index / grid);
  await sleep(32 + Math.hypot(x - sourceX, y - sourceY) * 48);
  const point = cellRootPos(index);
  const impact = new Container();
  impact.blendMode = 'add';
  const ring = new Graphics();
  ring.circle(0, 0, tileSize * 0.38).fill({ color: 0xff5b19, alpha: 0.16 });
  ring.circle(0, 0, tileSize * 0.34).stroke({ width: 4, color: 0xff9f32, alpha: 0.86 });
  ring.circle(0, 0, tileSize * 0.27).stroke({ width: 1.5, color: 0xfff0a0, alpha: 0.94 });
  ring.circle(0, 0, tileSize * 0.16).fill({ color: 0xffe276, alpha: 0.72 });
  const petals = new Graphics();
  for (let ray = 0; ray < 6; ray++) {
    const angle = (Math.PI * 2 * ray) / 6 + (Math.random() - 0.5) * 0.24;
    const outer = tileSize * (0.48 + Math.random() * 0.14);
    const startX = Math.cos(angle) * tileSize * 0.12;
    const startY = Math.sin(angle) * tileSize * 0.12;
    const endX = Math.cos(angle) * outer;
    const endY = Math.sin(angle) * outer;
    const side = (ray % 2 === 0 ? 1 : -1) * tileSize * 0.12;
    const controlX = Math.cos(angle) * outer * 0.6 - Math.sin(angle) * side;
    const controlY = Math.sin(angle) * outer * 0.6 + Math.cos(angle) * side;
    petals.moveTo(startX, startY);
    petals.quadraticCurveTo(controlX, controlY, endX, endY);
    petals.stroke({ width: 5, color: 0xff4d16, alpha: 0.28, cap: 'round' });
    petals.moveTo(startX, startY);
    petals.quadraticCurveTo(controlX, controlY, endX, endY);
    petals.stroke({ width: 1.7, color: 0xffdd73, alpha: 0.94, cap: 'round' });
  }
  const sparks = new Graphics();
  for (let spark = 0; spark < 5; spark++) {
    const angle = (Math.PI * 2 * spark) / 5 + Math.random() * 0.4;
    const radius = tileSize * (0.34 + Math.random() * 0.22);
    sparks
      .circle(Math.cos(angle) * radius, Math.sin(angle) * radius, tileSize * 0.025)
      .fill({ color: 0xfff4b0, alpha: 0.95 });
  }
  impact.addChild(ring, petals, sparks);
  impact.position.set(point.x, point.y);
  impact.scale.set(0.52);
  flyLayer.addChild(impact);
  const sprite = spriteAt(index);
  if (sprite?.visible) sprite.tint = 0xffad56;
  await tween(impact, { alpha: 0, scale: 1.38 }, 275);
  if (sprite && !sprite.destroyed) sprite.tint = 0xffffff;
  impact.destroy({ children: true });
}

async function fireSwordExplosion(
  source: number,
  affected: number[],
  order: number,
  preview: boolean,
  context: FireSwordFxContext,
): Promise<void> {
  await sleep(order * 72);
  const original = context.spriteAt(source);
  if (!preview && original) original.visible = false;
  const icon = makeChargeIcon(source, context);
  await charge(icon, context);
  const point = context.cellRootPos(source);
  const iconFade = tween(icon, { alpha: 0, scale: icon.scale.x * 1.65 }, 125).then(() =>
    icon.destroy(),
  );
  const impacts = affected
    .filter((index) => index !== source)
    .map((index) => cellImpact(index, source, context));
  await Promise.all([iconFade, blast(point, context), ...impacts]);
}
