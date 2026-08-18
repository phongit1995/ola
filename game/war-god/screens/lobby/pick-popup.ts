import { Container, Graphics, Sprite, type Ticker } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, addTick, makeText, popIn, pressable, removeTick, tween } from '../../kit';
import { DESIGN_W } from '../../layout';
import { attachShimmer } from '../../shimmer';
import { LEVEL_LABELS, type BotLevel } from '../../logic/battle';

const PANEL_W = 312;

const LEVEL_BARS: Record<BotLevel, string> = {
  easy: A.pick.levelEasy,
  normal: A.pick.levelMid,
  hard: A.pick.levelHard,
  expert: A.pick.levelExpert,
};

let box: Container;
let dim: Graphics;
let card: Container;
let panelH = 0;
let bars: Container[] = [];

function makeExpertSparkle(size: number): Graphics {
  return new Graphics()
    .moveTo(0, -size)
    .lineTo(size * 0.42, 0)
    .lineTo(0, size)
    .lineTo(-size * 0.42, 0)
    .closePath()
    .fill(0xffe77c);
}

function attachExpertAnimation(host: Container, shape: Sprite, isActive: () => boolean): void {
  const aura = new Sprite(shape.texture);
  aura.anchor.set(0.5);
  aura.width = shape.width;
  aura.height = shape.height;
  aura.tint = 0xa56bff;
  aura.blendMode = 'add';
  aura.alpha = 0;
  host.addChildAt(aura, 0);
  const baseScaleX = aura.scale.x;
  const baseScaleY = aura.scale.y;

  const sparkles = [
    { view: makeExpertSparkle(3.2), x: -shape.width * 0.43, y: -shape.height * 0.13, phase: 0 },
    { view: makeExpertSparkle(2.6), x: shape.width * 0.42, y: shape.height * 0.12, phase: 0.38 },
    { view: makeExpertSparkle(2.1), x: shape.width * 0.34, y: -shape.height * 0.3, phase: 0.72 },
  ];
  for (const sparkle of sparkles) {
    sparkle.view.blendMode = 'add';
    sparkle.view.alpha = 0;
    host.addChild(sparkle.view);
  }

  let clock = 0;
  let disposed = false;
  const tick = (ticker: Ticker): void => {
    if (host.destroyed || aura.destroyed || sparkles.some(({ view }) => view.destroyed)) {
      dispose();
      return;
    }
    const active = isActive();
    aura.visible = active;
    for (const sparkle of sparkles) sparkle.view.visible = active;
    if (!active) return;

    clock += ticker.deltaMS;
    const pulse = (Math.sin((clock / 1500) * Math.PI * 2) + 1) / 2;
    const auraScale = 1 + pulse * 0.035;
    aura.scale.set(baseScaleX * auraScale, baseScaleY * auraScale);
    aura.alpha = 0.1 + pulse * 0.18;

    for (const sparkle of sparkles) {
      const progress = (clock / 1750 + sparkle.phase) % 1;
      sparkle.view.x = sparkle.x + Math.sin(progress * Math.PI * 2) * 2.5;
      sparkle.view.y = sparkle.y - progress * 8;
      sparkle.view.alpha = Math.sin(progress * Math.PI) * 0.95;
      sparkle.view.rotation = progress * Math.PI;
      sparkle.view.scale.set(0.72 + Math.sin(progress * Math.PI) * 0.38);
    }
  };
  const dispose = (): void => {
    if (disposed) return;
    disposed = true;
    removeTick(tick);
  };
  addTick(tick);
}

function makeLevelBar(
  level: BotLevel,
  w: number,
  fontSize: number,
  delay: number,
  isActive: () => boolean,
  onTap: () => void
): Container {
  const b = new Container();
  const bg = new Sprite(tex[LEVEL_BARS[level]]);
  bg.anchor.set(0.5);
  bg.width = w;
  bg.scale.y = bg.scale.x;
  b.addChild(bg);
  const t = makeText(LEVEL_LABELS[level], fontSize, 0xffffff, '800', HEADING);
  t.y = Math.max(1, Math.round(fontSize * 0.1));
  b.addChild(t);
  attachShimmer(b, bg, {
    thickness: w * 0.14,
    length: bg.height * 1.9,
    rotation: -0.42,
    period: level === 'expert' ? 1350 : 1900,
    sweep: level === 'expert' ? 520 : 650,
    delay,
    alpha: level === 'expert' ? 0.82 : 0.55,
    isActive,
  });
  if (level === 'expert') attachExpertAnimation(b, bg, isActive);
  pressable(b, onTap);
  return b;
}

export function openPickPopup(): void {
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
  bars.forEach((bar, i) => popIn(bar, 130 + i * 95, 300));
}

export function hidePickPopup(): void {
  box.visible = false;
}

export function buildPickPopup(onPlay: (level: BotLevel) => void): Container {
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', hidePickPopup);
  box.addChild(dim);

  card = new Container();

  const panel = new Sprite(tex[A.pick.panel]);
  panel.anchor.set(0.5);
  panel.width = PANEL_W;
  panel.scale.y = panel.scale.x;
  card.addChild(panel);
  panelH = panel.height;
  const halfH = panelH / 2;

  const banner = new Sprite(tex[A.pick.title]);
  banner.anchor.set(0.5);
  banner.width = PANEL_W * 0.76;
  banner.scale.y = banner.scale.x;
  banner.y = -halfH + banner.height / 2 + panelH * 0.115;
  card.addChild(banner);
  const bannerLabel = makeText(
    'ĐẤU VỚI MÁY',
    Math.round(PANEL_W * 0.064),
    0xffe36b,
    '800',
    HEADING
  );
  const bannerMax = banner.width * 0.64;
  if (bannerLabel.width > bannerMax) bannerLabel.scale.set(bannerMax / bannerLabel.width);
  bannerLabel.y = banner.y - banner.height * 0.04;
  card.addChild(bannerLabel);

  const close = new Container();
  const closeBase = new Sprite(tex[A.pick.closeBase]);
  closeBase.anchor.set(0.5);
  closeBase.width = PANEL_W * 0.145;
  closeBase.scale.y = closeBase.scale.x;
  close.addChild(closeBase);
  const closeX = new Sprite(tex[A.pick.closeX]);
  closeX.anchor.set(0.5);
  closeX.width = PANEL_W * 0.07;
  closeX.scale.y = closeX.scale.x;
  close.addChild(closeX);
  close.x = PANEL_W / 2 - PANEL_W * 0.078;
  close.y = -halfH + PANEL_W * 0.082;
  pressable(close, hidePickPopup);
  card.addChild(close);

  const levels = Object.keys(LEVEL_LABELS) as BotLevel[];
  const compact = levels.length >= 4;
  const barW = PANEL_W * (compact ? 0.55 : 0.62);
  const barFont = Math.round(PANEL_W * (compact ? 0.054 : 0.062));
  const firstBar = new Sprite(tex[LEVEL_BARS.easy]);
  const barH = (firstBar.height / firstBar.width) * barW;
  const gap = barH * (compact ? 0.08 : 0.14);
  const blockH = levels.length * barH + (levels.length - 1) * gap;
  const areaTop = banner.y + banner.height / 2 + panelH * 0.02;
  const areaBottom = halfH - panelH * 0.06;
  // Bốn cấp độ dùng nguyên panel cũ: thu nhẹ để đủ chỗ, rồi hạ cả cụm
  // một nhịp cho cân phần thân modal mà vẫn chừa khoảng thở dưới SIÊU KHÓ.
  const bias = panelH * (compact ? 0.01 : 0.06);
  let startY = (areaTop + areaBottom) / 2 - blockH / 2 + barH / 2 + bias;
  const maxStartY = areaBottom - blockH + barH / 2;
  if (startY > maxStartY) startY = maxStartY;
  bars = [];
  levels.forEach((level, idx) => {
    const bar = makeLevelBar(
      level,
      barW,
      barFont,
      idx * 320,
      () => box.visible,
      () => {
        hidePickPopup();
        onPlay(level);
      }
    );
    bar.y = startY + idx * (barH + gap);
    card.addChild(bar);
    bars.push(bar);
  });

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutPickPopup(designH: number, insetTop: number, insetBottom: number): void {
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const availW = DESIGN_W * 0.94;
  const availH = designH - insetTop - insetBottom - 24;
  const fitScale = Math.min(1, availW / PANEL_W, availH / panelH);
  card.scale.set(fitScale);
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
}
