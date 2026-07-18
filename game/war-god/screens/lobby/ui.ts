import { Container, Sprite } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, iconSprite, makeText, pressable } from '../../kit';

export const PILL_W = 160;
export const PILL_H = 61;

export function makeWoodBtn(
  label: string,
  w: number,
  h: number,
  iconUrl: string | null,
  onTap: () => void,
): Container {
  const b = new Container();
  const bg = new Sprite(tex[A.lobby.btnWood]);
  bg.anchor.set(0.5);
  bg.width = w;
  bg.height = h;
  b.addChild(bg);
  let labelX = 0;
  if (iconUrl) {
    const ring = iconSprite(A.lobby.ring, h * 0.72);
    ring.x = -w / 2 + h * 0.7;
    b.addChild(ring);
    const icon = iconSprite(iconUrl, h * 0.46);
    icon.x = ring.x;
    b.addChild(icon);
    labelX = h * 0.4;
  }
  const t = makeText(label, Math.round(h * 0.31), 0xffd84d, '700', HEADING);
  t.x = labelX;
  b.addChild(t);
  pressable(b, onTap);
  return b;
}

export function makePill(label: string, iconUrl: string, onTap: () => void): Container {
  const b = new Container();
  const bg = new Sprite(tex[A.lobby.menuPill]);
  bg.anchor.set(0.5);
  bg.width = PILL_W;
  bg.height = PILL_H;
  b.addChild(bg);
  const ring = iconSprite(A.lobby.ring, 44);
  ring.x = -PILL_W / 2 + 34;
  b.addChild(ring);
  const icon = iconSprite(iconUrl, 26);
  icon.x = ring.x;
  b.addChild(icon);
  const t = makeText(label, 13, 0xffe9a8, '700', HEADING);
  t.x = 20;
  b.addChild(t);
  pressable(b, onTap);
  return b;
}
