import { Container, Graphics, Text } from 'pixi.js';
import { HEADING, makeText, popIn, tween } from '../../../kit';
import { DESIGN_W } from '../../../layout';
import { makeWoodBtn } from '../ui';
import { makeOverlayInput, placeOverlayInput } from './util';

const CARD_W = 400;
const CARD_H = 300;
const FIELD_W = 320;
const FIELD_H = 46;
const FIELD_Y = -36;

interface PasswordCallbacks {
  onSubmit(password: string): void;
  onCancel(): void;
}

let cb: PasswordCallbacks;
let box: Container;
let dim: Graphics;
let card: Container;
let subText: Text;
let input: HTMLInputElement;
let cardScale = 1;

function placeInput(): void {
  placeOverlayInput(
    input,
    card.x - (FIELD_W / 2) * cardScale,
    card.y + FIELD_Y * cardScale,
    FIELD_W * cardScale,
    FIELD_H * cardScale,
    16 * cardScale,
  );
}

function submit(): void {
  cb.onSubmit(input.value);
}

export function openPasswordPopup(ownerName: string): void {
  subText.text = `Bàn của @${ownerName}`;
  input.value = '';
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
  placeInput();
  input.style.display = 'block';
  input.focus();
}

export function hidePasswordPopup(): void {
  if (!box) return;
  box.visible = false;
  input.style.display = 'none';
  input.blur();
}

export function isPasswordPopupOpen(): boolean {
  return box?.visible === true;
}

export function buildPasswordPopup(callbacks: PasswordCallbacks): Container {
  cb = callbacks;
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', () => cb.onCancel());
  box.addChild(dim);

  card = new Container();
  const bg = new Graphics()
    .roundRect(-CARD_W / 2, -CARD_H / 2, CARD_W, CARD_H, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  bg.eventMode = 'static';
  card.addChild(bg);

  const title = makeText('NHẬP MẬT KHẨU', 22, 0xffd84d, '700', HEADING);
  title.y = -CARD_H / 2 + 40;
  card.addChild(title);

  subText = makeText('', 15, 0xc7d3e0, '700');
  subText.y = -74;
  card.addChild(subText);

  const field = new Graphics()
    .roundRect(-FIELD_W / 2, FIELD_Y, FIELD_W, FIELD_H, 10)
    .fill({ color: 0x0a1522, alpha: 0.92 })
    .stroke({ width: 1.5, color: 0xf6c445, alpha: 0.5 });
  card.addChild(field);

  const cancel = makeWoodBtn('HỦY', 140, 54, null, () => cb.onCancel());
  cancel.x = -85;
  cancel.y = CARD_H / 2 - 52;
  card.addChild(cancel);

  const ok = makeWoodBtn('VÀO', 140, 54, null, submit);
  ok.x = 85;
  ok.y = CARD_H / 2 - 52;
  card.addChild(ok);

  input = makeOverlayInput({ secure: true, maxLength: 64, placeholder: 'Mật khẩu bàn' });
  input.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') submit();
  });

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutPasswordPopup(designH: number, insetTop: number, insetBottom: number): void {
  if (!box) return;
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const availH = designH - insetTop - insetBottom - 24;
  cardScale = Math.min(1, (DESIGN_W * 0.94) / CARD_W, availH / CARD_H);
  card.scale.set(cardScale);
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
  placeInput();
}
