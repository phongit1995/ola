import { Container, Graphics } from 'pixi.js';
import { HEADING, makeText, popIn, pressable, tween } from '../../../kit';
import { makeWoodBtn } from '../ui';
import { makeOverlayInput, placeOverlayInput } from './util';

const DESIGN_W = 520;
const CARD_W = 440;
const CARD_H = 470;
const FIELD_W = CARD_W - 68;
const FIELD_H = 46;
const BET_FIELD_Y = -122;
const PASS_FIELD_Y = 20;
const QUICK_BETS = [0, 1000, 5000, 10000];

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

function placeInputs(): void {
  placeOverlayInput(
    betInput,
    card.x - (FIELD_W / 2) * cardScale,
    card.y + BET_FIELD_Y * cardScale,
    FIELD_W * cardScale,
    FIELD_H * cardScale,
    16 * cardScale,
  );
  placeOverlayInput(
    passInput,
    card.x - (FIELD_W / 2) * cardScale,
    card.y + PASS_FIELD_Y * cardScale,
    FIELD_W * cardScale,
    FIELD_H * cardScale,
    16 * cardScale,
  );
}

function submit(): void {
  cb.onSubmit(Number(betInput.value || '0'), passInput.value);
}

function makeFieldBg(y: number): Graphics {
  return new Graphics()
    .roundRect(-FIELD_W / 2, y, FIELD_W, FIELD_H, 10)
    .fill({ color: 0x0a1522, alpha: 0.92 })
    .stroke({ width: 1.5, color: 0xf6c445, alpha: 0.5 });
}

function makeQuickBtn(value: number): Container {
  const b = new Container();
  const bg = new Graphics()
    .roundRect(-43, -17, 86, 34, 9)
    .fill({ color: 0x223650, alpha: 0.95 })
    .stroke({ width: 1.5, color: 0xf6c445, alpha: 0.55 });
  b.addChild(bg);
  const label = makeText(
    value > 0 ? value.toLocaleString('vi-VN') : 'MIỄN PHÍ',
    13,
    0xffe9a8,
    '800',
    HEADING,
  );
  b.addChild(label);
  pressable(b, () => {
    betInput.value = String(value);
  });
  return b;
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
  const bg = new Graphics()
    .roundRect(-CARD_W / 2, -CARD_H / 2, CARD_W, CARD_H, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  bg.eventMode = 'static';
  card.addChild(bg);

  const title = makeText('TẠO BÀN', 24, 0xffd84d, '700', HEADING);
  title.y = -CARD_H / 2 + 42;
  card.addChild(title);

  const betLabelText = makeText('MỨC CƯỢC (KEN)', 14, 0xc7d3e0, '800', HEADING);
  betLabelText.anchor.set(0, 0.5);
  betLabelText.x = -FIELD_W / 2;
  betLabelText.y = BET_FIELD_Y - 20;
  card.addChild(betLabelText);

  card.addChild(makeFieldBg(BET_FIELD_Y));

  QUICK_BETS.forEach((value, i) => {
    const btn = makeQuickBtn(value);
    btn.x = -143 + i * 95;
    btn.y = BET_FIELD_Y + FIELD_H + 30;
    card.addChild(btn);
  });

  const passLabelText = makeText('MẬT KHẨU (TÙY CHỌN)', 14, 0xc7d3e0, '800', HEADING);
  passLabelText.anchor.set(0, 0.5);
  passLabelText.x = -FIELD_W / 2;
  passLabelText.y = PASS_FIELD_Y - 20;
  card.addChild(passLabelText);

  card.addChild(makeFieldBg(PASS_FIELD_Y));

  const cancel = makeWoodBtn('HỦY', 150, 56, null, () => cb.onCancel());
  cancel.x = -105;
  cancel.y = CARD_H / 2 - 54;
  card.addChild(cancel);

  const ok = makeWoodBtn('TẠO BÀN', 185, 60, null, submit);
  ok.x = 92;
  ok.y = CARD_H / 2 - 54;
  card.addChild(ok);

  betInput = makeOverlayInput({ numeric: true, maxLength: 9, placeholder: '0' });
  passInput = makeOverlayInput({ maxLength: 64, placeholder: 'Để trống nếu không khóa' });
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
  cardScale = Math.min(1, (DESIGN_W * 0.94) / CARD_W, availH / CARD_H);
  card.scale.set(cardScale);
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
  placeInputs();
}
