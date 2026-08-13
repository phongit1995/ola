import { Container, Graphics, Rectangle, Sprite, Text } from 'pixi.js';
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
let passwordToggle: Container;
let passwordToggleBg: Graphics;
let passwordSwitchBg: Graphics;
let passwordSwitchKnob: Graphics;
let passwordToggleState: Text;
let passBg: Sprite;
let passwordEnabled = false;
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
  if (passwordEnabled) placeOne(passInput, passFieldY);
}

function submit(): void {
  if (passwordEnabled && passInput.value.trim().length === 0) {
    showPasswordRequired();
    passInput.focus();
    return;
  }
  cb.onSubmit(Number(betInput.value || '0'), passwordEnabled ? passInput.value.trim() : '');
}

function drawPasswordToggle(): void {
  passwordToggleBg
    .clear()
    .roundRect(-fieldW / 2, -28, fieldW, 56, 17)
    .fill({ color: passwordEnabled ? 0x143b63 : 0xf7ecd7, alpha: passwordEnabled ? 0.94 : 0.78 })
    .stroke({ width: 2, color: passwordEnabled ? 0xffd45a : 0x9b5a1c, alpha: 0.96 });
  const switchX = fieldW / 2 - 45;
  passwordSwitchBg
    .clear()
    .roundRect(switchX - 35, -15, 70, 30, 15)
    .fill({ color: passwordEnabled ? 0xb34217 : 0x68421f, alpha: 0.96 })
    .stroke({ width: 1.5, color: 0xffd45a, alpha: 0.98 });
  passwordSwitchKnob
    .clear()
    .circle(switchX + (passwordEnabled ? 20 : -20), 0, 11)
    .fill(passwordEnabled ? 0xffe15a : 0xf7ecd7)
    .stroke({ width: 1, color: 0x6a3a13 });
  passwordToggleState.text = passwordEnabled ? 'BẬT' : 'TẮT';
  passwordToggleState.x = switchX + (passwordEnabled ? -11 : 11);
  passwordToggleState.style.fill = passwordEnabled ? 0xfff2d0 : 0xffe15a;
}

function setPasswordEnabled(enabled: boolean, focus = false): void {
  passwordEnabled = enabled;
  passInput.value = '';
  passInput.type = 'password';
  passBg.visible = enabled;
  drawPasswordToggle();
  placeInputs();
  passInput.style.display = box.visible && enabled ? 'block' : 'none';
  if (!enabled) passInput.blur();
  if (enabled && focus) requestAnimationFrame(() => passInput.focus());
}

function showPasswordRequired(): void {
  passBg.tint = 0xffb8a0;
  window.setTimeout(() => {
    if (!passBg.destroyed) passBg.tint = 0xffffff;
  }, 520);
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
  box.visible = true;
  setPasswordEnabled(false);
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
  placeInputs();
  betInput.style.display = 'block';
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

  passwordToggle = new Container();
  passwordToggleBg = new Graphics();
  passwordToggle.addChild(passwordToggleBg);
  const toggleLock = new Sprite(tex[A.lobby.lock]);
  toggleLock.anchor.set(0.5);
  toggleLock.width = 33;
  toggleLock.scale.y = toggleLock.scale.x;
  toggleLock.x = -fieldW / 2 + 30;
  passwordToggle.addChild(toggleLock);
  const toggleTitle = makeText('MẬT KHẨU', 16, 0xffe15a, '800', HEADING);
  toggleTitle.anchor.set(0, 0.5);
  toggleTitle.x = -fieldW / 2 + 55;
  toggleTitle.y = -8;
  toggleTitle.style.stroke = { color: 0x5a1c08, width: 3, join: 'round' };
  passwordToggle.addChild(toggleTitle);
  const toggleHint = makeText('(TÙY CHỌN)', 11, 0xfff2d0, '700', HEADING);
  toggleHint.anchor.set(0, 0.5);
  toggleHint.x = -fieldW / 2 + 55;
  toggleHint.y = 13;
  toggleHint.style.stroke = { color: 0x5a1c08, width: 2, join: 'round' };
  passwordToggle.addChild(toggleHint);
  passwordSwitchBg = new Graphics();
  passwordSwitchKnob = new Graphics();
  passwordToggle.addChild(passwordSwitchBg, passwordSwitchKnob);
  passwordToggleState = makeText('', 10, 0xffe15a, '800', HEADING);
  passwordToggle.addChild(passwordToggleState);
  passwordToggle.position.set(0, -halfH + cardH * 0.65);
  passwordToggle.hitArea = new Rectangle(-fieldW / 2, -28, fieldW, 56);
  pressable(passwordToggle, () => setPasswordEnabled(!passwordEnabled, true));
  card.addChild(passwordToggle);

  passBg = makeFieldBg();
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
    placeholder: 'Nhập mật khẩu',
  });
  betInput.style.textAlign = 'center';
  passInput.style.textAlign = 'center';
  passInput.setAttribute('aria-label', 'Mật khẩu bàn');
  const onEnter = (e: KeyboardEvent): void => {
    if (e.key === 'Enter') submit();
  };
  betInput.addEventListener('keydown', onEnter);
  passInput.addEventListener('keydown', onEnter);

  setPasswordEnabled(false);

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
