import { Assets, Container, Graphics, Rectangle, Sprite, Texture, type Ticker } from 'pixi.js';
import lightningGodUrl from '../../assets/ultimate/lightning-god.webp';
import myriadSwordsUrl from '../../assets/ultimate/myriad-swords.webp';
import heartVacuumUrl from '../../assets/ultimate/heart-vacuum.webp';
import { HEADING, addTick, makeText, popIn, pressable, removeTick } from '../../kit';
import { DESIGN_W } from '../../layout';
import { LIGHTNING_GOD_DAMAGE, ULT_COST } from '../../logic/constants.gen';
import type { UltimateSkillId } from '../../logic/server-types';
import { HEART_VACUUM_RULES } from './heart-vacuum';

export type { UltimateSkillId } from '../../logic/server-types';
export type UltimatePickerSkillId = UltimateSkillId;
export type UltimatePickerVariant =
  | 'electric-pulse'
  | 'dual-halo'
  | 'orbit-sparks'
  | 'storm-hex'
  | 'arc-diamond'
  | 'rune-square'
  | 'shield-charge'
  | 'chain-link'
  | 'shock-burst'
  | 'minimal-breathe';

type FrameShape = 'circle' | 'diamond' | 'hexagon' | 'rounded-square' | 'shield' | 'none';
type EffectStyle =
  | 'pulse'
  | 'dual-halo'
  | 'orbit'
  | 'storm'
  | 'arc'
  | 'runes'
  | 'charge'
  | 'chain'
  | 'burst'
  | 'breathe';
type Point = readonly [x: number, y: number];

interface UltimatePickerAppearance {
  frameShape: FrameShape;
  frameColors: readonly number[];
  frameWidth: number;
  itemSize: number;
  iconSize: number;
  positions: readonly Point[];
  connector?: 'line' | 'arc';
  lightningBackdrop?: boolean;
  effect: EffectStyle;
}

const APPEARANCES: Record<UltimatePickerVariant, UltimatePickerAppearance> = {
  'electric-pulse': {
    frameShape: 'circle',
    frameColors: [0xa855f7, 0xff7a32],
    frameWidth: 3,
    itemSize: 72,
    iconSize: 64,
    positions: [[0, -122], [0, -46]],
    lightningBackdrop: true,
    effect: 'pulse',
  },
  'dual-halo': {
    frameShape: 'circle',
    frameColors: [0xc084fc, 0xff9b4a],
    frameWidth: 3,
    itemSize: 74,
    iconSize: 62,
    positions: [[0, -126], [0, -48]],
    lightningBackdrop: true,
    effect: 'dual-halo',
  },
  'orbit-sparks': {
    frameShape: 'circle',
    frameColors: [0x9333ea, 0xff6b24],
    frameWidth: 2,
    itemSize: 74,
    iconSize: 61,
    positions: [[0, -126], [0, -48]],
    lightningBackdrop: true,
    effect: 'orbit',
  },
  'storm-hex': {
    frameShape: 'hexagon',
    frameColors: [0xa855f7, 0xff7a32],
    frameWidth: 3,
    itemSize: 76,
    iconSize: 61,
    positions: [[0, -130], [0, -50]],
    lightningBackdrop: true,
    effect: 'storm',
  },
  'arc-diamond': {
    frameShape: 'diamond',
    frameColors: [0xc084fc, 0xff914d],
    frameWidth: 3,
    itemSize: 78,
    iconSize: 58,
    positions: [[0, -132], [0, -50]],
    lightningBackdrop: true,
    effect: 'arc',
  },
  'rune-square': {
    frameShape: 'rounded-square',
    frameColors: [0x8b5cf6, 0xff7a32],
    frameWidth: 3,
    itemSize: 74,
    iconSize: 60,
    positions: [[0, -126], [0, -48]],
    lightningBackdrop: true,
    effect: 'runes',
  },
  'shield-charge': {
    frameShape: 'shield',
    frameColors: [0xb76cff, 0xff8b3d],
    frameWidth: 3,
    itemSize: 76,
    iconSize: 57,
    positions: [[0, -130], [0, -50]],
    lightningBackdrop: true,
    effect: 'charge',
  },
  'chain-link': {
    frameShape: 'circle',
    frameColors: [0xa855f7, 0xff7a32],
    frameWidth: 3,
    itemSize: 70,
    iconSize: 61,
    positions: [[0, -120], [0, -46]],
    connector: 'line',
    lightningBackdrop: true,
    effect: 'chain',
  },
  'shock-burst': {
    frameShape: 'none',
    frameColors: [0xa855f7, 0xff7a32],
    frameWidth: 0,
    itemSize: 78,
    iconSize: 66,
    positions: [[0, -132], [0, -50]],
    lightningBackdrop: true,
    effect: 'burst',
  },
  'minimal-breathe': {
    frameShape: 'circle',
    frameColors: [0x7c3aed, 0xea580c],
    frameWidth: 2,
    itemSize: 68,
    iconSize: 61,
    positions: [[0, -116], [0, -44]],
    lightningBackdrop: true,
    effect: 'breathe',
  },
};

export const ULTIMATE_PICKER_VARIANTS = Object.keys(
  APPEARANCES,
) as UltimatePickerVariant[];

export function isUltimatePickerVariant(value: string | null): value is UltimatePickerVariant {
  return value != null && Object.hasOwn(APPEARANCES, value);
}

export interface UltimatePickerState {
  visible: boolean;
  selected: UltimatePickerSkillId | null;
  options: Array<{ id: UltimatePickerSkillId; name: string }>;
}

export interface UltimatePickerAnchor {
  x: number;
  y: number;
  width: number;
  height: number;
}

export interface UltimatePicker {
  view: Container;
  open(): void;
  close(): void;
  layout(
    designH: number,
    insetTop?: number,
    insetBottom?: number,
    anchor?: UltimatePickerAnchor | null,
  ): void;
  getState(): UltimatePickerState;
}

interface SkillDefinition {
  id: UltimatePickerSkillId;
  name: string;
  detail: string;
  texture: Texture;
}

export interface UltimatePickerOptions {
  /** Adds the Heart Vacuum option to the picker. */
  includeHeartVacuum?: boolean;
  /** Optional hook for mock-only previews; production confirms the skill normally. */
  onMockSkill?: () => void;
}

function skillAccent(
  appearance: UltimatePickerAppearance,
  skillId: UltimatePickerSkillId,
): number {
  if (skillId === 'heart-vacuum') return 0xff5d9f;
  if (skillId === 'myriad-swords') return appearance.frameColors[1] ?? 0xff7a32;
  return appearance.frameColors[0] ?? 0xa855f7;
}

const FLOAT_MARGIN = 10;
const ULTIMATE_FALLBACK_SIZE = 84;
const ULTIMATE_FALLBACK_RIGHT = 10;
const ULTIMATE_FALLBACK_BOTTOM = 58;

function clamp(value: number, min: number, max: number): number {
  if (max < min) return min;
  return Math.min(Math.max(value, min), max);
}

function drawFrame(
  frame: Graphics,
  shape: FrameShape,
  size: number,
  width: number,
  color: number,
): void {
  if (shape === 'none') return;
  const radius = size / 2 - width;
  if (shape === 'circle') {
    frame.circle(0, 0, radius);
  } else if (shape === 'diamond') {
    frame
      .moveTo(0, -radius)
      .lineTo(radius, 0)
      .lineTo(0, radius)
      .lineTo(-radius, 0)
      .closePath();
  } else if (shape === 'hexagon') {
    for (let index = 0; index < 6; index += 1) {
      const angle = -Math.PI / 2 + (index * Math.PI) / 3;
      const x = Math.cos(angle) * radius;
      const y = Math.sin(angle) * radius;
      if (index === 0) frame.moveTo(x, y);
      else frame.lineTo(x, y);
    }
    frame.closePath();
  } else if (shape === 'rounded-square') {
    frame.roundRect(-radius, -radius, radius * 2, radius * 2, 14);
  } else {
    frame
      .moveTo(0, -radius)
      .lineTo(radius * 0.78, -radius * 0.62)
      .lineTo(radius * 0.72, radius * 0.34)
      .lineTo(0, radius)
      .lineTo(-radius * 0.72, radius * 0.34)
      .lineTo(-radius * 0.78, -radius * 0.62)
      .closePath();
  }
  frame.stroke({ width, color, alpha: 1, join: 'round' });
}

function makeEffectLayer(style: EffectStyle, size: number, color: number, skillIndex: number): Container {
  const layer = new Container();
  const effect = new Graphics();
  const radius = size / 2;

  if (style === 'pulse') {
    if (skillIndex === 0) {
      const topBolt = new Graphics()
        .moveTo(-9, -radius - 7)
        .lineTo(-2, -radius - 1)
        .lineTo(-7, -radius + 2)
        .lineTo(2, -radius + 8)
        .stroke({ width: 2.2, color: 0xf3e8ff, alpha: 0.96, cap: 'round', join: 'round' });
      const leftBolt = new Graphics()
        .moveTo(-radius - 7, -7)
        .lineTo(-radius - 1, -1)
        .lineTo(-radius - 5, 3)
        .lineTo(-radius + 3, 9)
        .stroke({ width: 2, color: 0xc084fc, alpha: 0.92, cap: 'round', join: 'round' });
      const rightBolt = new Graphics()
        .moveTo(radius + 6, -5)
        .lineTo(radius, 1)
        .lineTo(radius + 5, 4)
        .lineTo(radius - 3, 10)
        .stroke({ width: 2, color: 0xd8b4fe, alpha: 0.92, cap: 'round', join: 'round' });
      layer.addChild(topBolt, leftBolt, rightBolt);
    } else {
      effect
        .circle(-radius - 2, -6, 2.2)
        .circle(radius + 1, 5, 1.8)
        .circle(8, -radius - 2, 1.5)
        .fill({ color, alpha: 0.84 });
    }
  } else if (style === 'dual-halo') {
    const firstRing = new Graphics()
      .circle(0, 0, radius - 2)
      .stroke({ width: 2.2, color, alpha: 0.72 });
    const secondRing = new Graphics()
      .circle(0, 0, radius - 2)
      .stroke({ width: 1.4, color: 0xffffff, alpha: 0.56 });
    layer.addChild(firstRing, secondRing);
  } else if (style === 'orbit') {
    for (let index = 0; index < 4; index += 1) {
      const angle = (index * Math.PI) / 2;
      effect
        .circle(Math.cos(angle) * (radius + 4), Math.sin(angle) * (radius + 4), index % 2 === 0 ? 3 : 2)
        .fill({ color: index % 2 === 0 ? 0xffffff : color, alpha: 0.95 });
    }
  } else if (style === 'storm') {
    for (let index = 0; index < 6; index += 1) {
      const angle = (index * Math.PI) / 3;
      const x = Math.cos(angle) * (radius - 2);
      const y = Math.sin(angle) * (radius - 2);
      const tx = Math.cos(angle) * (radius + 7);
      const ty = Math.sin(angle) * (radius + 7);
      effect.moveTo(x, y).lineTo(tx, ty);
    }
    effect.stroke({ width: 2.5, color, alpha: 0.9, cap: 'round' });
  } else if (style === 'arc') {
    effect
      .arc(0, 0, radius + 4, -Math.PI * 0.42, Math.PI * 0.2)
      .stroke({ width: 3, color, alpha: 0.9, cap: 'round' })
      .arc(0, 0, radius + 4, Math.PI * 0.58, Math.PI * 1.2)
      .stroke({ width: 3, color: 0xffffff, alpha: 0.62, cap: 'round' });
  } else if (style === 'runes') {
    const edge = radius + 3;
    const arm = 9;
    effect
      .moveTo(-edge + arm, -edge).lineTo(-edge, -edge).lineTo(-edge, -edge + arm)
      .moveTo(edge - arm, -edge).lineTo(edge, -edge).lineTo(edge, -edge + arm)
      .moveTo(edge, edge - arm).lineTo(edge, edge).lineTo(edge - arm, edge)
      .moveTo(-edge + arm, edge).lineTo(-edge, edge).lineTo(-edge, edge - arm)
      .stroke({ width: 3, color, alpha: 0.88, cap: 'round', join: 'round' });
  } else if (style === 'charge') {
    for (let index = 0; index < 8; index += 1) {
      const angle = (index * Math.PI) / 4;
      effect
        .moveTo(Math.cos(angle) * (radius - 1), Math.sin(angle) * (radius - 1))
        .lineTo(Math.cos(angle) * (radius + (index % 2 === 0 ? 8 : 4)), Math.sin(angle) * (radius + (index % 2 === 0 ? 8 : 4)));
    }
    effect.stroke({ width: 2, color, alpha: 0.7, cap: 'round' });
  } else if (style === 'chain') {
    effect
      .circle(0, -radius - 2, 4).stroke({ width: 2, color, alpha: 0.9 })
      .circle(0, radius + 2, 4).stroke({ width: 2, color, alpha: 0.9 });
  } else if (style === 'burst') {
    for (let index = 0; index < 12; index += 1) {
      const angle = (index * Math.PI) / 6;
      const inner = radius - (index % 2 === 0 ? 7 : 3);
      const outer = radius + (index % 2 === 0 ? 8 : 4);
      effect
        .moveTo(Math.cos(angle) * inner, Math.sin(angle) * inner)
        .lineTo(Math.cos(angle) * outer, Math.sin(angle) * outer);
    }
    effect.stroke({ width: 2.5, color, alpha: 0.86, cap: 'round' });
  } else {
    effect.circle(0, 0, radius + 1).fill({ color, alpha: 0.14 });
  }

  if (style !== 'dual-halo' && !(style === 'pulse' && skillIndex === 0)) {
    layer.addChild(effect);
  }
  return layer;
}

function animateEffect(effect: Container, style: EffectStyle, index: number): void {
  let elapsed = index * 370;
  const step = (ticker: Ticker): void => {
    if (effect.destroyed) {
      removeTick(step);
      return;
    }
    elapsed += ticker.deltaMS;
    const wave = (Math.sin(elapsed / 230) + 1) / 2;

    if (style === 'pulse' && index === 0) {
      effect.children.forEach((bolt, boltIndex) => {
        const flash = Math.sin(elapsed / (43 + boltIndex * 9) + boltIndex * 2.1);
        bolt.alpha = flash > 0.15 ? 0.88 : 0.12;
        bolt.x = flash > 0.72 ? (boltIndex - 1) * 1.2 : 0;
        bolt.y = flash < -0.55 ? 1 : 0;
      });
    } else if (style === 'pulse') {
      effect.rotation = elapsed / 3600;
      effect.alpha = 0.42 + wave * 0.46;
    } else if (style === 'dual-halo') {
      effect.children.forEach((ring, ringIndex) => {
        const ripple = ((elapsed / 1400) + ringIndex * 0.5) % 1;
        const scale = 0.9 + ripple * 0.34;
        ring.scale.set(scale);
        ring.alpha = Math.pow(1 - ripple, 1.6) * (ringIndex === 0 ? 0.72 : 0.5);
      });
    } else if (style === 'orbit') {
      effect.rotation = elapsed / 720;
      effect.alpha = 0.72 + wave * 0.28;
    } else if (style === 'storm' || style === 'burst') {
      effect.rotation = style === 'storm' ? elapsed / 2400 : -elapsed / 1800;
      effect.alpha = 0.48 + wave * 0.52;
    } else if (style === 'arc' || style === 'runes') {
      effect.rotation = (style === 'arc' ? 1 : -1) * elapsed / 2100;
      effect.alpha = 0.7 + wave * 0.3;
    } else if (style === 'charge') {
      const scale = 0.92 + wave * 0.14;
      effect.scale.set(scale);
      effect.alpha = 0.35 + wave * 0.65;
    } else if (style === 'chain') {
      effect.y = -2 + wave * 4;
      effect.alpha = 0.58 + wave * 0.42;
    } else {
      const intensity = style === 'breathe' ? 0.05 : 0.1;
      effect.scale.set(1 - intensity / 2 + wave * intensity);
      effect.alpha = 0.5 + wave * 0.5;
    }
  };
  addTick(step);
}

interface HeartPickerEffectParts {
  view: Container;
  aura: Graphics;
  outerRing: Graphics;
  innerRing: Graphics;
  rays: Graphics;
  sweep: Graphics;
  orbit: Graphics[];
  orbitRadius: number;
}

/**
 * Heart Vacuum has its own layered treatment. The generated icon is only the
 * central heart; the aura, runes, light rays and orbiting motes are separate
 * display objects so each can animate at a different speed.
 */
function makeHeartPickerEffect(size: number): HeartPickerEffectParts {
  const layer = new Container();
  const radius = size / 2;
  const aura = new Graphics()
    .circle(0, 0, radius * 0.86)
    .fill({ color: 0xff3a9f, alpha: 0.12 })
    .circle(0, 0, radius * 0.67)
    .fill({ color: 0xa836ff, alpha: 0.13 });
  aura.blendMode = 'add';

  const outerRing = new Graphics()
    .circle(0, 0, radius * 0.91)
    .stroke({ width: 2.2, color: 0xff78bd, alpha: 0.76 });
  outerRing.blendMode = 'add';
  const innerRing = new Graphics()
    .circle(0, 0, radius * 0.73)
    .stroke({ width: 1.4, color: 0xffd75e, alpha: 0.74 });
  innerRing.blendMode = 'add';

  const rays = new Graphics();
  for (let index = 0; index < 8; index += 1) {
    const angle = (index * Math.PI) / 4;
    const inner = radius * 0.94;
    const outer = radius * (index % 2 === 0 ? 1.11 : 1.03);
    rays
      .moveTo(Math.cos(angle) * inner, Math.sin(angle) * inner)
      .lineTo(Math.cos(angle) * outer, Math.sin(angle) * outer);
  }
  rays.stroke({ width: 1.5, color: 0xffd75e, alpha: 0.72, cap: 'round' });
  rays.blendMode = 'add';

  const sweep = new Graphics()
    .moveTo(-radius * 0.98, radius * 0.62)
    .lineTo(radius * 0.98, -radius * 0.62)
    .stroke({ width: 2.2, color: 0xffffff, alpha: 0.3, cap: 'round' });
  sweep.blendMode = 'add';

  const orbit: Graphics[] = [];
  for (let index = 0; index < 6; index += 1) {
    const mote = new Graphics()
      .circle(0, 0, index % 2 === 0 ? 2.6 : 1.8)
      .fill({ color: index % 2 === 0 ? 0xffd75e : 0xff9bd1, alpha: 0.95 });
    mote.blendMode = 'add';
    orbit.push(mote);
  }

  layer.addChild(aura, rays, outerRing, innerRing, sweep, ...orbit);
  return {
    view: layer,
    aura,
    outerRing,
    innerRing,
    rays,
    sweep,
    orbit,
    orbitRadius: radius * 0.76,
  };
}

function animateHeartPickerEffect(
  parts: HeartPickerEffectParts,
  icon: Sprite,
  iconBaseScale: number,
): void {
  let elapsed = 0;
  const step = (ticker: Ticker): void => {
    if (parts.view.destroyed || icon.destroyed) {
      removeTick(step);
      return;
    }
    elapsed += ticker.deltaMS;
    const wave = (Math.sin(elapsed / 185) + 1) / 2;
    const orbitPhase = elapsed / 920;

    parts.aura.scale.set(0.9 + wave * 0.14);
    parts.aura.alpha = 0.56 + wave * 0.44;
    parts.outerRing.rotation = elapsed / 2100;
    parts.outerRing.scale.set(0.96 + wave * 0.08);
    parts.outerRing.alpha = 0.56 + wave * 0.38;
    parts.innerRing.rotation = -elapsed / 1370;
    parts.innerRing.alpha = 0.5 + (1 - wave) * 0.42;
    parts.rays.rotation = -elapsed / 1650;
    parts.rays.alpha = 0.32 + wave * 0.58;
    parts.sweep.rotation = elapsed / 720;
    parts.sweep.alpha = 0.06 + wave * 0.42;
    icon.scale.set(iconBaseScale * (1 + wave * 0.075));
    icon.rotation = Math.sin(elapsed / 960) * 0.035;

    parts.orbit.forEach((mote, index) => {
      const angle = orbitPhase + (index * Math.PI * 2) / parts.orbit.length;
      const orbitRadius = parts.orbitRadius * (1 + (index % 2) * 0.13);
      mote.x = Math.cos(angle) * orbitRadius;
      mote.y = Math.sin(angle) * orbitRadius;
      mote.alpha = 0.3 + ((Math.sin(elapsed / 160 + index) + 1) / 2) * 0.7;
      mote.scale.set(0.78 + wave * 0.32);
    });
  };
  addTick(step);
}

function makeSkillLabel(
  name: string,
  detail: string,
  accent: number,
  itemSize: number,
): Container {
  const label = new Container();
  const right = -(itemSize / 2 + 14);
  const nameText = makeText(name, 13, accent, '800', HEADING);
  nameText.anchor.set(1, 0);
  nameText.style.align = 'right';
  nameText.style.stroke = { color: 0x120d02, width: 2.5, join: 'round' };
  const detailText = makeText(detail, 10, 0xfff2d5, '700', HEADING);
  detailText.anchor.set(1, 0);
  detailText.style.align = 'right';
  detailText.style.lineHeight = 12;
  const gap = 4;
  const totalH = nameText.height + gap + detailText.height;
  nameText.position.set(right, -totalH / 2);
  detailText.position.set(right, -totalH / 2 + nameText.height + gap);
  const width = Math.max(nameText.width, detailText.width);
  const bg = new Graphics()
    .roundRect(right - width - 10, -totalH / 2 - 7, width + 20, totalH + 14, 10)
    .fill({ color: 0x0b1524, alpha: 0.88 })
    .stroke({ width: 1.2, color: accent, alpha: 0.72 });
  label.addChild(bg, nameText, detailText);
  return label;
}

function makeSkillItem(
  texture: Texture,
  index: number,
  appearance: UltimatePickerAppearance,
  accent: number,
  isHeartVacuum: boolean,
  onSelect: () => void,
): Container {
  const view = new Container();

  if (appearance.lightningBackdrop === true && index === 0) {
    const lightning = new Graphics();
    const radius = appearance.itemSize / 2 - appearance.frameWidth - 1;
    lightning.circle(0, 0, radius).fill({ color: 0x4c1d95, alpha: 0.28 });
    lightning
      .moveTo(-17, -29)
      .lineTo(-27, -9)
      .lineTo(-18, -11)
      .lineTo(-27, 12)
      .moveTo(17, -27)
      .lineTo(26, -8)
      .lineTo(17, -10)
      .lineTo(25, 14)
      .moveTo(-8, 25)
      .lineTo(0, 14)
      .lineTo(4, 20)
      .lineTo(11, 7)
      .stroke({ width: 2.2, color: 0xd8b4fe, alpha: 0.95, cap: 'round', join: 'round' });
    view.addChild(lightning);
  }

  const heartEffect = isHeartVacuum ? makeHeartPickerEffect(appearance.itemSize) : null;
  const effect =
    heartEffect?.view ??
    makeEffectLayer(
      appearance.effect,
      appearance.itemSize,
      accent,
      index,
    );
  view.addChild(effect);

  const icon = new Sprite(texture);
  icon.anchor.set(0.5);
  const iconScale = Math.min(
    appearance.iconSize / icon.texture.width,
    appearance.iconSize / icon.texture.height,
  );
  icon.scale.set(iconScale);
  view.addChild(icon);
  if (heartEffect != null) animateHeartPickerEffect(heartEffect, icon, iconScale);
  else animateEffect(effect, appearance.effect, index);

  const frame = new Graphics();
  drawFrame(
    frame,
    appearance.frameShape,
    appearance.itemSize,
    appearance.frameWidth,
    accent,
  );
  view.addChild(frame);

  view.hitArea = new Rectangle(
    -appearance.itemSize / 2,
    -appearance.itemSize / 2,
    appearance.itemSize,
    appearance.itemSize,
  );
  pressable(view, onSelect);
  return view;
}

export async function buildUltimatePicker(
  onConfirm: (skill: UltimateSkillId) => void = () => {},
  variant: UltimatePickerVariant = 'electric-pulse',
  pickerOptions: UltimatePickerOptions = {},
): Promise<UltimatePicker> {
  const appearance = APPEARANCES[variant];
  // The picker is anchored to the ultimate button. Keep every option above
  // that anchor; placing the new third option below it makes the icon sit on
  // top of the button and steals its hit area.
  const itemPositions: readonly Point[] = pickerOptions.includeHeartVacuum
    ? [[0, -198], [0, -122], [0, -46]]
    : appearance.positions;
  const halfItem = appearance.itemSize / 2 + 9;
  let minX = Math.min(...itemPositions.map(([x]) => x - halfItem));
  const maxX = Math.max(...itemPositions.map(([x]) => x + halfItem));
  const minY = Math.min(...itemPositions.map(([, y]) => y - halfItem));
  const maxY = Math.max(...itemPositions.map(([, y]) => y + halfItem));
  let contentW = maxX - minX;
  const contentH = maxY - minY;
  const [lightningTexture, swordsTexture, heartVacuumTexture] = await Promise.all([
    Assets.load<Texture>(lightningGodUrl),
    Assets.load<Texture>(myriadSwordsUrl),
    pickerOptions.includeHeartVacuum ? Assets.load<Texture>(heartVacuumUrl) : null,
  ]);
  lightningTexture.source.autoGenerateMipmaps = false;
  swordsTexture.source.autoGenerateMipmaps = false;

  const skills: SkillDefinition[] = [
    {
      id: 'lightning-god',
      name: 'LÔI THẦN GIÁNG THẾ',
      detail: `${LIGHTNING_GOD_DAMAGE} ST + 4 tia phá 2×2\nÔ bị phá cộng hiệu ứng · Lôi bắn tia phụ`,
      texture: lightningTexture,
    },
  ];
  if (pickerOptions.includeHeartVacuum && heartVacuumTexture != null) {
    heartVacuumTexture.source.autoGenerateMipmaps = false;
    skills.push({
      id: 'heart-vacuum',
      name: 'THÁNH TÂM HỒI NGUYÊN',
      detail: `Tim +${HEART_VACUUM_RULES.healPerHeart} · Tim Lớn +${HEART_VACUUM_RULES.healPerGreaterHeart}\nHút hết Tim · hồi đến đầy máu · sập bàn`,
      texture: heartVacuumTexture,
    });
  }
  skills.push({
    id: 'myriad-swords',
    name: 'VẠN KIẾM QUY TÔNG',
    detail: `${ULT_COST / 2} sát thương chắc chắn\nĐòn dứt điểm ổn định`,
    texture: swordsTexture,
  });

  const view = new Container();
  const dismissLayer = new Graphics();
  const options = new Container();
  view.addChild(dismissLayer, options);

  if (appearance.connector != null) {
    const connector = new Graphics();
    const connectorPositions = itemPositions;
    if (appearance.connector === 'line') {
      for (let index = 0; index < connectorPositions.length - 1; index += 1) {
        const first = connectorPositions[index]!;
        const second = connectorPositions[index + 1]!;
        const middleY = (first[1] + second[1]) / 2;
        connector
          .moveTo(first[0], first[1])
          .lineTo(first[0], middleY)
          .stroke({
            width: 3,
            color: appearance.frameColors[index % appearance.frameColors.length] ?? 0xffffff,
            alpha: 0.78,
            cap: 'round',
          })
          .moveTo(second[0], middleY)
          .lineTo(second[0], second[1])
          .stroke({
            width: 3,
            color: appearance.frameColors[(index + 1) % appearance.frameColors.length] ?? 0xffffff,
            alpha: 0.78,
            cap: 'round',
          });
      }
    } else {
      for (let index = 0; index < connectorPositions.length - 1; index += 1) {
        const first = connectorPositions[index]!;
        const second = connectorPositions[index + 1]!;
        connector
          .moveTo(first[0], first[1])
          .quadraticCurveTo(-8, (first[1] + second[1]) / 2, second[0], second[1])
          .stroke({
            width: 3,
            color: appearance.frameColors[index % appearance.frameColors.length] ?? 0xffffff,
            alpha: 0.78,
            cap: 'round',
          });
      }
    }
    options.addChild(connector);
  }

  let selected: UltimatePickerSkillId | null = null;
  let fitScale = 1;
  const animatedPieces: Container[] = [];
  const stopPickerPops: Array<() => void> = [];

  const closePicker = (): void => {
    view.visible = false;
  };

  skills.forEach((skill, index) => {
    const accent = skillAccent(appearance, skill.id);
    const item = makeSkillItem(
      skill.texture,
      index,
      appearance,
      accent,
      skill.id === 'heart-vacuum',
      () => {
        if (skill.id === 'heart-vacuum') {
          selected = skill.id;
          closePicker();
          if (pickerOptions.onMockSkill) pickerOptions.onMockSkill();
          else onConfirm(skill.id);
          return;
        }
        selected = skill.id;
        closePicker();
        onConfirm(skill.id);
      },
    );
    item.position.set(...itemPositions[index]!);
    const label = makeSkillLabel(
      skill.name,
      skill.detail,
      accent,
      appearance.itemSize,
    );
    label.position.set(...itemPositions[index]!);
    options.addChild(label, item);
    animatedPieces.push(item, label);
    const labelLeft = itemPositions[index]![0] + label.getLocalBounds().minX;
    minX = Math.min(minX, labelLeft);
  });
  contentW = maxX - minX;

  dismissLayer.eventMode = 'static';
  dismissLayer.on('pointertap', closePicker);
  view.visible = false;

  return {
    view,
    open(): void {
      stopPickerPops.splice(0).forEach((stop) => stop());
      selected = null;
      view.visible = true;
      options.scale.set(fitScale);
      options.alpha = 1;
      // Giữ nhịp pop-in cũ của picker, đồng thời cho từng lựa chọn bật lên
      // tuần tự để người chơi nhận ra item mới vừa được thêm vào.
      stopPickerPops.push(popIn(options, 0, 260));
      animatedPieces.forEach((piece, index) => {
        stopPickerPops.push(popIn(piece, index * 65, 230));
      });
    },
    close: closePicker,
    layout(designH, insetTop = 0, insetBottom = 0, anchor = null): void {
      dismissLayer.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x000000, alpha: 0.001 });
      const fallbackAnchor: UltimatePickerAnchor = {
        x: DESIGN_W - ULTIMATE_FALLBACK_RIGHT - ULTIMATE_FALLBACK_SIZE,
        y: designH - insetBottom - ULTIMATE_FALLBACK_BOTTOM - ULTIMATE_FALLBACK_SIZE,
        width: ULTIMATE_FALLBACK_SIZE,
        height: ULTIMATE_FALLBACK_SIZE,
      };
      const target = anchor ?? fallbackAnchor;
      const availableW = DESIGN_W - FLOAT_MARGIN * 2;
      const availableH = Math.max(appearance.itemSize, target.y - insetTop - FLOAT_MARGIN);
      fitScale = Math.min(1, availableW / contentW, availableH / contentH);

      const targetCenterX = target.x + target.width / 2;
      const optionsX = clamp(
        targetCenterX,
        FLOAT_MARGIN - minX * fitScale,
        DESIGN_W - FLOAT_MARGIN - maxX * fitScale,
      );
      const optionsY = clamp(
        target.y,
        insetTop + FLOAT_MARGIN - minY * fitScale,
        designH - insetBottom - FLOAT_MARGIN - maxY * fitScale,
      );

      options.scale.set(fitScale);
      options.position.set(Math.round(optionsX), Math.round(optionsY));
    },
    getState(): UltimatePickerState {
      return {
        visible: view.visible,
        selected,
        options: skills.map((skill) => ({ id: skill.id, name: skill.name.replace('\n', ' ') })),
      };
    },
  };
}
