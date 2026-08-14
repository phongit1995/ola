import { Assets, Container, Graphics, Sprite, Text, Texture, type Ticker } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, addTick, makeText, removeTick } from '../../kit';
import { DESIGN_W } from '../../layout';
import { playSound } from '../../audio';
import { avatarIconUrl, DEFAULT_AVATAR_URL } from '../../vip';
import type { VsIntroCombatant, VsIntroData } from './vs-intro-data';
import {
  VS_INTRO_DURATION_MS,
  VS_INTRO_REDUCED_DURATION_MS,
  vsIntroFrame,
} from './vs-intro-timeline';

const ICON_SIZE = 34;
const ROW_TEXT_MAX_W = 120;
const ROW_LINE_INNER_X = 142;
const SWORD_SIZE = 182;

interface CombatantRow {
  view: Container;
  icon: Sprite;
  fallback: Container;
  fallbackInitial: Text;
  label: Text;
  mirrored: boolean;
}

export interface VsIntro {
  view: Container;
  play(data: VsIntroData): Promise<void>;
  cancel(): void;
  layout(designH: number, insetTop: number, insetBottom: number): void;
  isVisible(): boolean;
}

function fitText(text: Text, maxWidth: number): void {
  text.scale.set(1);
  if (text.width > maxWidth) text.scale.set(maxWidth / text.width);
}

function displayName(name: string): string {
  const clean = name.trim().replace(/^@+/, '') || 'người chơi';
  return `@${clean}`;
}

function firstInitial(name: string): string {
  return name.trim().replace(/^@+/, '').charAt(0).toLocaleUpperCase('vi-VN') || '?';
}

function drawTaperedBeam(
  target: Graphics,
  outerX: number,
  innerX: number,
  halfWidth: number,
  taperLength: number,
  color: number,
  alpha: number,
): void {
  const y = 24;
  const direction = Math.sign(innerX - outerX);
  const taperX = innerX - direction * taperLength;
  target
    .moveTo(outerX, y - halfWidth)
    .lineTo(taperX, y - halfWidth)
    .lineTo(innerX, y)
    .lineTo(taperX, y + halfWidth)
    .lineTo(outerX, y + halfWidth)
    .closePath()
    .fill({ color, alpha });
  target.circle(outerX, y, halfWidth).fill({ color, alpha });
}

function buildNeonUnderline(mirrored: boolean, color: number, glow: number, hot: number): Graphics {
  const line = new Graphics();
  const outerX = mirrored ? 18 : -18;
  const innerX = mirrored ? -ROW_LINE_INNER_X : ROW_LINE_INNER_X;
  const direction = Math.sign(innerX - outerX);
  drawTaperedBeam(line, outerX, innerX, 7, 52, glow, 0.2);
  drawTaperedBeam(line, outerX, innerX, 3.4, 40, color, 0.52);
  drawTaperedBeam(line, outerX, innerX, 1.35, 28, hot, 0.98);
  line
    .moveTo(outerX, 24)
    .lineTo(outerX + direction * 76, 24)
    .stroke({ width: 0.85, color: 0xffffff, alpha: 0.9, cap: 'round' });
  line.blendMode = 'add';
  return line;
}

function buildRow(mirrored: boolean, color: number, glow: number, hot: number): CombatantRow {
  const view = new Container();
  const line = buildNeonUnderline(mirrored, color, glow, hot);
  view.addChild(line);

  const fallback = new Container();
  const fallbackBg = new Graphics()
    .circle(0, 0, ICON_SIZE / 2)
    .fill({ color: 0x141826, alpha: 0.98 })
    .stroke({ width: 2, color, alpha: 0.92 });
  const fallbackInitial = makeText('?', 18, color, '800', HEADING);
  fallback.addChild(fallbackBg, fallbackInitial);
  view.addChild(fallback);

  const icon = new Sprite(Texture.EMPTY);
  icon.anchor.set(0.5);
  icon.visible = false;
  view.addChild(icon);

  const label = makeText('@người chơi', 25, color, '800', HEADING);
  label.style.stroke = { color: 0x05070d, width: 3, join: 'round' };
  label.style.dropShadow = {
    distance: 2,
    blur: 4,
    alpha: 0.9,
    color: 0x000000,
    angle: Math.PI / 2,
  };
  view.addChild(label);

  return { view, icon, fallback, fallbackInitial, label, mirrored };
}

function arrangeRow(row: CombatantRow, combatant: VsIntroCombatant): void {
  row.label.text = displayName(combatant.name);
  row.fallbackInitial.text = firstInitial(combatant.name);
  fitText(row.label, ROW_TEXT_MAX_W);
  const gap = 8;
  if (row.mirrored) {
    row.icon.x = -ICON_SIZE / 2;
    row.fallback.x = row.icon.x;
    row.label.x = -ICON_SIZE - gap - row.label.width / 2;
  } else {
    row.icon.x = ICON_SIZE / 2;
    row.fallback.x = row.icon.x;
    row.label.x = ICON_SIZE + gap + row.label.width / 2;
  }
  row.icon.y = 0;
  row.fallback.y = 0;
  row.label.y = 0;
}

function buildImpact(): Container {
  const impact = new Container();
  const glow = new Graphics()
    .circle(0, 0, 26)
    .fill({ color: 0xffc341, alpha: 0.18 })
    .circle(0, 0, 9)
    .fill({ color: 0xffffff, alpha: 0.95 });
  glow.blendMode = 'add';
  impact.addChild(glow);
  const rays = new Graphics();
  for (let i = 0; i < 10; i++) {
    const angle = (Math.PI * 2 * i) / 10;
    const inner = 13 + (i % 2) * 4;
    const outer = 31 + (i % 3) * 7;
    rays.moveTo(Math.cos(angle) * inner, Math.sin(angle) * inner);
    rays.lineTo(Math.cos(angle) * outer, Math.sin(angle) * outer);
  }
  rays.stroke({ width: 2, color: 0xffd568, alpha: 0.9, cap: 'round' });
  rays.blendMode = 'add';
  impact.addChild(rays);
  return impact;
}

export function buildVsIntro(): VsIntro {
  const view = new Container();
  const dim = new Graphics();
  dim.eventMode = 'static';
  view.addChild(dim);

  const leftRow = buildRow(false, 0xff7058, 0xd82f22, 0xffd1b3);
  const rightRow = buildRow(true, 0xffdf62, 0xf2a52b, 0xffffd6);
  view.addChild(leftRow.view, rightRow.view);

  const swordStage = new Container();
  const leftSword = new Container();
  const rightSword = new Container();
  const leftGlow = new Sprite(tex[A.items.sword]);
  const rightGlow = new Sprite(tex[A.items.sword]);
  const leftBlade = new Sprite(tex[A.items.sword]);
  const rightBlade = new Sprite(tex[A.items.sword]);
  for (const sprite of [leftGlow, rightGlow, leftBlade, rightBlade]) {
    sprite.anchor.set(0.5);
    sprite.width = SWORD_SIZE;
    sprite.height = SWORD_SIZE;
  }
  leftGlow.tint = 0xff542b;
  leftGlow.alpha = 0.26;
  leftGlow.scale.set(leftGlow.scale.x * 1.055);
  leftGlow.blendMode = 'add';
  rightGlow.tint = 0x2d9dff;
  rightGlow.alpha = 0.26;
  rightGlow.scale.set(-rightGlow.scale.x * 1.055, rightGlow.scale.y * 1.055);
  rightGlow.blendMode = 'add';
  rightBlade.scale.x = -Math.abs(rightBlade.scale.x);
  leftSword.addChild(leftGlow, leftBlade);
  rightSword.addChild(rightGlow, rightBlade);
  swordStage.addChild(leftSword, rightSword);
  view.addChild(swordStage);

  const impact = buildImpact();
  swordStage.addChild(impact);

  let designH = 900;
  let insetTop = 0;
  let insetBottom = 0;
  let centerY = designH / 2;
  let elapsed = 0;
  let reducedMotion = false;
  let generation = 0;
  let step: ((ticker: Ticker) => void) | null = null;
  let settle: (() => void) | null = null;
  let impactPlayed = false;

  function applyLayout(): void {
    const usableH = Math.max(320, designH - insetTop - insetBottom);
    centerY = insetTop + usableH / 2;
    const stageScale = Math.max(0.82, Math.min(1, usableH / 760));
    leftRow.view.y = Math.round(centerY);
    rightRow.view.y = Math.round(centerY);
    swordStage.position.set(DESIGN_W / 2, Math.round(centerY));
    swordStage.scale.set(stageScale);
  }

  function renderFrame(): void {
    const frame = vsIntroFrame(elapsed, reducedMotion);
    leftRow.view.x = 18 + frame.leftRowOffset;
    rightRow.view.x = DESIGN_W - 18 + frame.rightRowOffset;
    leftRow.view.alpha = frame.rowAlpha;
    rightRow.view.alpha = frame.rowAlpha;
    dim.alpha = frame.dimAlpha;
    leftSword.position.set(frame.leftSwordX, frame.swordY);
    rightSword.position.set(frame.rightSwordX, frame.swordY);
    leftSword.alpha = frame.swordAlpha;
    rightSword.alpha = frame.swordAlpha;
    leftSword.scale.set(frame.swordScale);
    rightSword.scale.set(frame.swordScale);
    impact.alpha = frame.impactAlpha;
    impact.scale.set(frame.impactScale);
    impact.rotation = elapsed * 0.0018;
  }

  function finish(): void {
    if (step) removeTick(step);
    step = null;
    view.visible = false;
    const resolve = settle;
    settle = null;
    resolve?.();
  }

  function cancel(): void {
    generation++;
    finish();
  }

  function loadRowIcon(row: CombatantRow, vipType: string | null | undefined, playGen: number): void {
    const requestedUrl = avatarIconUrl(vipType);
    row.icon.visible = false;
    row.fallback.visible = true;
    const load = (url: string, allowFallback: boolean): void => {
      void Assets.load<Texture>(url)
        .then((texture) => {
          if (generation !== playGen || row.icon.destroyed) return;
          row.icon.texture = texture;
          row.icon.scale.set(Math.min(ICON_SIZE / texture.width, ICON_SIZE / texture.height));
          row.icon.visible = true;
          row.fallback.visible = false;
        })
        .catch(() => {
          if (generation !== playGen || !allowFallback || requestedUrl === DEFAULT_AVATAR_URL) return;
          load(DEFAULT_AVATAR_URL, false);
        });
    };
    load(requestedUrl, true);
  }

  view.visible = false;
  return {
    view,
    play(data): Promise<void> {
      cancel();
      const playGen = generation;
      arrangeRow(leftRow, data.left);
      arrangeRow(rightRow, data.right);
      loadRowIcon(leftRow, data.left.vipType, playGen);
      loadRowIcon(rightRow, data.right.vipType, playGen);
      reducedMotion = window.matchMedia?.('(prefers-reduced-motion: reduce)').matches === true;
      elapsed = 0;
      impactPlayed = false;
      view.visible = true;
      applyLayout();
      renderFrame();
      return new Promise<void>((resolve) => {
        settle = resolve;
        const duration = reducedMotion ? VS_INTRO_REDUCED_DURATION_MS : VS_INTRO_DURATION_MS;
        step = (ticker: Ticker): void => {
          if (generation !== playGen || view.destroyed) {
            finish();
            return;
          }
          elapsed += ticker.deltaMS;
          if (!impactPlayed && !reducedMotion && elapsed >= 370) {
            impactPlayed = true;
            playSound('match');
          }
          renderFrame();
          if (elapsed >= duration) finish();
        };
        addTick(step);
      });
    },
    cancel,
    layout(nextDesignH, nextInsetTop, nextInsetBottom): void {
      designH = nextDesignH;
      insetTop = nextInsetTop;
      insetBottom = nextInsetBottom;
      dim.clear().rect(0, 0, DESIGN_W, designH).fill(0x05070d);
      applyLayout();
      if (view.visible) renderFrame();
    },
    isVisible(): boolean {
      return view.visible;
    },
  };
}
