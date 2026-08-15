import {
  Container,
  Graphics,
  Rectangle,
  Sprite,
  Texture,
  type Ticker,
} from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, addTick, makeText, removeTick } from '../../kit';
import type { UltimateControlState } from './ultimate-control-state';

export const ULTIMATE_CONTROL_SIZE = 84;
export const ULTIMATE_CHAT_GAP = 10;

export interface UltimateControl {
  view: Container;
  update(state: UltimateControlState): void;
  layout(x: number, y: number): void;
  reset(): void;
  getState(): UltimateControlState;
}

const EMPTY_STATE: UltimateControlState = {
  visible: false,
  charge: 0,
  chargePct: 0,
  charged: false,
  canCast: false,
};

const RING_STEPS = 24;
const RING_WIDTH = 5;
const RING_COLOR_FROM = 0x86e05c;
const RING_COLOR_TO = 0xffd45d;

function lerpColor(from: number, to: number, t: number): number {
  const r = Math.round(((from >> 16) & 255) + ((((to >> 16) & 255) - ((from >> 16) & 255)) * t));
  const g = Math.round(((from >> 8) & 255) + ((((to >> 8) & 255) - ((from >> 8) & 255)) * t));
  const b = Math.round((from & 255) + (((to & 255) - (from & 255)) * t));
  return (r << 16) | (g << 8) | b;
}

function orbTexture(source: Texture): Texture {
  const size = Math.min(source.width, source.height);
  return new Texture({
    source: source.source,
    frame: new Rectangle(source.frame.x, source.frame.y, size, size),
  });
}

export function buildUltimateControl(onCast: () => void): UltimateControl {
  const view = new Container();
  const visual = new Container();
  const center = ULTIMATE_CONTROL_SIZE / 2;
  const ringRadius = center - 8;
  visual.pivot.set(center, center);
  visual.position.set(center, center);

  const glow = new Graphics()
    .circle(center, center, center - 1)
    .fill({ color: 0xff7a18, alpha: 0.24 })
    .circle(center, center, center - 4)
    .stroke({ width: 5, color: 0xffcf55, alpha: 0.72 });
  glow.blendMode = 'add';
  glow.visible = false;
  glow.pivot.set(center, center);
  glow.position.set(center, center);
  visual.addChild(glow);

  const frameOff = orbTexture(tex[A.hud.ultLeftOff]);
  const frameOn = orbTexture(tex[A.hud.ultLeftOn]);
  const frame = new Sprite(frameOff);
  frame.width = ULTIMATE_CONTROL_SIZE;
  frame.height = ULTIMATE_CONTROL_SIZE;
  // Texture nút ult có thân banner dính vào mép phải orb — mask tròn để
  // không lộ mẩu thừa ngoài hình tròn.
  const frameMask = new Graphics().circle(center, center, center - 1).fill(0xffffff);
  frame.mask = frameMask;
  visual.addChild(frame, frameMask);

  const chargeTrack = new Graphics()
    .circle(center, center, ringRadius)
    .stroke({ width: RING_WIDTH, color: 0x07111d, alpha: 0.55 });
  const chargeArc = new Graphics();
  visual.addChild(chargeTrack, chargeArc);

  const flame = new Sprite(tex[A.hud.flameOff]);
  flame.anchor.set(0.5);
  const flameScale = 29 / Math.max(flame.texture.width, flame.texture.height);
  flame.scale.set(flameScale);
  flame.position.set(center, 29);
  visual.addChild(flame);

  const title = makeText('CHƯỞNG', 8.5, 0xc4cfda, '800', HEADING);
  title.position.set(center, 52);
  const percent = makeText('0%', 14, 0xbfe8a8, '800', HEADING);
  percent.style.stroke = { color: 0x09101a, width: 3, join: 'round' };
  percent.position.set(center, 67);
  visual.addChild(title, percent);

  view.addChild(visual);
  view.hitArea = new Rectangle(-4, -4, ULTIMATE_CONTROL_SIZE + 8, ULTIMATE_CONTROL_SIZE + 8);
  view.eventMode = 'static';
  view.visible = false;

  let state = { ...EMPTY_STATE };
  let pulse: ((ticker: Ticker) => void) | null = null;

  const stopPulse = (): void => {
    if (pulse) removeTick(pulse);
    pulse = null;
    glow.scale.set(1);
    glow.alpha = state.charged ? 0.34 : 0;
    flame.scale.set(flameScale);
  };

  const startPulse = (): void => {
    if (pulse) return;
    let elapsed = 0;
    pulse = (ticker: Ticker): void => {
      if (view.destroyed || !state.canCast) {
        stopPulse();
        return;
      }
      elapsed += ticker.deltaMS;
      const wave = (Math.sin(elapsed / 170) + 1) / 2;
      glow.alpha = 0.38 + wave * 0.42;
      glow.scale.set(1 + wave * 0.07);
      flame.scale.set(flameScale * (1 + wave * 0.11));
    };
    addTick(pulse);
  };

  const render = (): void => {
    view.visible = state.visible;
    frame.texture = state.charged ? frameOn : frameOff;
    flame.texture = tex[state.charged ? A.hud.flameOn : A.hud.flameOff];
    percent.text = `${state.chargePct}%`;
    percent.style.fill = state.charged ? 0xfff0a3 : 0xbfe8a8;
    title.style.fill = state.charged ? 0xffd56b : 0xc4cfda;
    glow.visible = state.charged;
    view.alpha = state.canCast ? 1 : state.charged ? 0.86 : 0.74;
    view.cursor = state.canCast ? 'pointer' : 'default';
    if (!state.canCast) visual.scale.set(1);

    // Vòng sạc dạng nấc: mỗi nấc một màu chuyển dần xanh lá → vàng gold.
    chargeArc.clear();
    const filled = state.charged ? RING_STEPS : Math.floor(state.charge * RING_STEPS);
    const slice = (Math.PI * 2) / RING_STEPS;
    const gap = slice * 0.09;
    for (let i = 0; i < filled; i++) {
      const start = -Math.PI / 2 + i * slice + gap / 2;
      chargeArc
        .beginPath()
        .arc(center, center, ringRadius, start, start + slice - gap)
        .stroke({
          width: RING_WIDTH,
          color: lerpColor(RING_COLOR_FROM, RING_COLOR_TO, i / (RING_STEPS - 1)),
          alpha: 0.98,
          cap: 'butt',
        });
    }

    if (state.canCast) startPulse();
    else stopPulse();
  };

  const resetPress = (): void => {
    visual.scale.set(1);
  };
  view.on('pointerdown', () => {
    if (state.canCast) visual.scale.set(0.95);
  });
  view.on('pointerup', resetPress);
  view.on('pointerupoutside', resetPress);
  view.on('pointertap', () => {
    resetPress();
    if (state.canCast) onCast();
  });

  return {
    view,
    update(next): void {
      state = { ...next };
      render();
    },
    layout(x, y): void {
      view.position.set(Math.round(x), Math.round(y));
    },
    reset(): void {
      state = { ...EMPTY_STATE };
      render();
    },
    getState: () => ({ ...state }),
  };
}
