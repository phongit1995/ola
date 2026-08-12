import { Container, Graphics, Rectangle, Sprite } from 'pixi.js';
import { A, tex } from '../../../assets';
import { HEADING, makeText, popIn, pressable, tween } from '../../../kit';
import { DESIGN_W } from '../../../layout';
import { makeOverlayInput, placeOverlayInput } from './util';

const CARD_W = 404;

interface CreateRoomCallbacks {
  onSubmit(bet: number, password: string): void;
  onCancel(): void;
}

let cb: CreateRoomCallbacks;
let box: Container;
let dim: Graphics;
let card: Container;
let betInput: HTMLInputElement;
let passInput: HTMLInputElement;
let cardScale = 1;
let cardH = 0;
let betFieldY = 0;
let passFieldY = 0;
let fieldW = 0;
let fieldH = 0;

function placeOne(input: HTMLInputElement, fieldY: number): void {
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

function placeInputs(): void {
  placeOne(betInput, betFieldY);
  placeOne(passInput, passFieldY);
}

function submit(): void {
  cb.onSubmit(Number(betInput.value || '0'), passInput.value);
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

function makeFieldBg(): Sprite {
  const f = new Sprite(tex[A.lobby.fieldInput]);
  f.anchor.set(0.5);
  f.width = fieldW;
  f.scale.y = f.scale.x;
  return f;
}

export function openCreateRoomPopup(): void {
  betInput.value = '0';
  passInput.value = '';
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
  placeInputs();
  betInput.style.display = 'block';
  passInput.style.display = 'block';
}

export function hideCreateRoomPopup(): void {
  if (!box) return;
  box.visible = false;
  betInput.style.display = 'none';
  passInput.style.display = 'none';
  betInput.blur();
  passInput.blur();
}

export function isCreateRoomPopupOpen(): boolean {
  return box?.visible === true;
}

export function buildCreateRoomPopup(callbacks: CreateRoomCallbacks): Container {
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
  betFieldY = -halfH + cardH * 0.47;
  passFieldY = -halfH + cardH * 0.78;

  const betLabel = makeLabel('SỐ KEN');
  betLabel.position.set(0, -halfH + cardH * 0.34);
  card.addChild(betLabel);
  const betBg = makeFieldBg();
  betBg.position.set(0, betFieldY);
  card.addChild(betBg);

  const passLabel = makeLabel('MẬT KHẨU');
  passLabel.position.set(0, -halfH + cardH * 0.65);
  card.addChild(passLabel);
  const passBg = makeFieldBg();
  passBg.position.set(0, passFieldY);
  card.addChild(passBg);

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
  const titleText = makeText('TẠO BÀN', 27, 0xffe15a, '800', HEADING);
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

  betInput = makeOverlayInput({ numeric: true, maxLength: 9, placeholder: '0' });
  passInput = makeOverlayInput({
    secure: true,
    maxLength: 64,
    placeholder: 'Để trống nếu không khóa',
  });
  betInput.style.textAlign = 'center';
  passInput.style.textAlign = 'center';
  const onEnter = (e: KeyboardEvent): void => {
    if (e.key === 'Enter') submit();
  };
  betInput.addEventListener('keydown', onEnter);
  passInput.addEventListener('keydown', onEnter);

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutCreateRoomPopup(
  designH: number,
  insetTop: number,
  insetBottom: number,
): void {
  if (!box) return;
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const availH = designH - insetTop - insetBottom - 24;
  cardScale = Math.min(1, (DESIGN_W * 0.96) / CARD_W, availH / cardH);
  card.scale.set(cardScale);
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
  placeInputs();
}
