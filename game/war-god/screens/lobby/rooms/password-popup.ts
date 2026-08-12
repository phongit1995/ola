import { Container, Graphics, Rectangle, Sprite, Text } from 'pixi.js';
import { A, tex } from '../../../assets';
import { HEADING, makeText, popIn, pressable, tween } from '../../../kit';
import { DESIGN_W } from '../../../layout';
import { makeOverlayInput, placeOverlayInput } from './util';

const CARD_W = 404;

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
let cardH = 0;
let fieldY = 0;
let fieldW = 0;
let fieldH = 0;

function placeInput(): void {
  const w = fieldW * 0.88;
  const h = fieldH * 0.62;
  placeOverlayInput(
    input,
    card.x - (w / 2) * cardScale,
    card.y + (fieldY - h / 2) * cardScale,
    w * cardScale,
    h * cardScale,
    18 * cardScale,
  );
}

function submit(): void {
  cb.onSubmit(input.value);
}

function makeLabel(label: string): Container {
  const c = new Container();
  const frame = new Sprite(tex[A.lobby.fieldLabel]);
  frame.anchor.set(0.5);
  frame.width = CARD_W * 0.56;
  frame.scale.y = frame.scale.x;
  c.addChild(frame);
  const text = makeText(label, 18, 0xffe15a, '800', HEADING);
  text.style.stroke = { color: 0x5a1c08, width: 3, join: 'round' };
  c.addChild(text);
  return c;
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

  const panel = new Sprite(tex[A.lobby.createPanel]);
  panel.anchor.set(0.5);
  panel.width = CARD_W;
  panel.scale.y = panel.scale.x;
  panel.eventMode = 'static';
  card.addChild(panel);
  cardH = panel.height;
  const halfH = cardH / 2;

  fieldW = CARD_W * 0.84;
  fieldH = fieldW / (2321 / 432);
  fieldY = -halfH + cardH * 0.63;

  const lock = new Sprite(tex[A.lobby.lock]);
  lock.anchor.set(0.5);
  lock.width = CARD_W * 0.13;
  lock.scale.y = lock.scale.x;
  lock.position.set(0, -halfH + cardH * 0.32);
  card.addChild(lock);

  subText = makeText('', 15, 0xfff2d0, '700', HEADING);
  subText.style.stroke = { color: 0x4a1206, width: 3, join: 'round' };
  subText.position.set(0, -halfH + cardH * 0.42);
  card.addChild(subText);

  const label = makeLabel('MẬT KHẨU');
  label.position.set(0, -halfH + cardH * 0.51);
  card.addChild(label);
  const fieldBg = new Sprite(tex[A.lobby.fieldInput]);
  fieldBg.anchor.set(0.5);
  fieldBg.width = fieldW;
  fieldBg.scale.y = fieldBg.scale.x;
  fieldBg.position.set(0, fieldY);
  card.addChild(fieldBg);

  const ok = new Container();
  const okBg = new Sprite(tex[A.lobby.btnOk]);
  okBg.anchor.set(0.5);
  okBg.width = CARD_W * 0.22;
  okBg.scale.y = okBg.scale.x;
  ok.addChild(okBg);
  const okLabel = makeText('OK', 17, 0xfff2d0, '800', HEADING);
  okLabel.style.stroke = { color: 0x5a1c08, width: 3, join: 'round' };
  okLabel.y = -okBg.height * 0.06;
  ok.addChild(okLabel);
  ok.position.set(0, halfH - cardH * 0.09);
  ok.hitArea = new Rectangle(-okBg.width * 0.5, -okBg.height * 0.4, okBg.width, okBg.height * 0.8);
  pressable(ok, submit);
  card.addChild(ok);

  const title = new Container();
  const titleFrame = new Sprite(tex[A.lobby.createTitle]);
  titleFrame.anchor.set(0.5);
  titleFrame.width = CARD_W * 0.74;
  titleFrame.scale.y = titleFrame.scale.x;
  title.addChild(titleFrame);
  const titleText = makeText('THAM GIA', 27, 0xffe15a, '800', HEADING);
  titleText.style.stroke = { color: 0x4a1206, width: 4, join: 'round' };
  titleText.y = -titleFrame.height * 0.04;
  title.addChild(titleText);
  title.y = -halfH + cardH * 0.03;
  card.addChild(title);

  const close = new Container();
  const closeSprite = new Sprite(tex[A.lobby.btnX]);
  closeSprite.anchor.set(0.5);
  closeSprite.width = CARD_W * 0.15;
  closeSprite.scale.y = closeSprite.scale.x;
  close.addChild(closeSprite);
  const closeIcon = new Sprite(tex[A.lobby.icX]);
  closeIcon.anchor.set(0.5);
  closeIcon.width = CARD_W * 0.075;
  closeIcon.scale.y = closeIcon.scale.x;
  close.addChild(closeIcon);
  close.position.set(CARD_W / 2 - CARD_W * 0.04, -halfH + cardH * 0.14);
  close.hitArea = new Rectangle(-38, -38, 76, 76);
  pressable(close, () => cb.onCancel());
  card.addChild(close);

  input = makeOverlayInput({ secure: true, maxLength: 64, placeholder: 'Mật khẩu bàn' });
  input.style.textAlign = 'center';
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
  cardScale = Math.min(1, (DESIGN_W * 0.96) / CARD_W, availH / cardH);
  card.scale.set(cardScale);
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
  placeInput();
}
