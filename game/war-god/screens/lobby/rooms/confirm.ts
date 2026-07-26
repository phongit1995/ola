import { Container, Graphics, Sprite, Text } from 'pixi.js';
import { A, tex } from '../../../assets';
import { SERIF, makeText, popIn, pressable, tween } from '../../../kit';

const DESIGN_W = 520;
const PANEL_W = 430;
const BTN_W = 172;
const OK_X = PANEL_W / 2 - BTN_W / 2 - 34;

let box: Container;
let dim: Graphics;
let card: Container;
let titleText: Text;
let message: Text;
let cancelBtn: Container;
let okBtn: Container;
let onOkAction: (() => void) | null = null;
let noticeMode = false;
let animGen = 0;

function serifText(label: string, size: number, color: number): Text {
  const t = makeText(label, size, color, '700', SERIF);
  t.style.letterSpacing = 2;
  return t;
}

function openInternal(text: string, onOk: (() => void) | null, notice: boolean): void {
  animGen++;
  onOkAction = onOk;
  noticeMode = notice;
  titleText.text = notice ? 'THÔNG BÁO' : 'XÁC NHẬN';
  message.text = text;
  cancelBtn.visible = !notice;
  okBtn.x = notice ? 0 : OK_X;
  box.visible = true;
  card.alpha = 1;
  card.scale.set(1);
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
}

export function openRoomsConfirm(text: string, onOk: () => void): void {
  openInternal(text, onOk, false);
}

export function openRoomsNotice(text: string, onOk?: () => void): void {
  openInternal(text, onOk ?? null, true);
}

export function closeRoomsConfirm(): void {
  if (!box?.visible) return;
  const gen = ++animGen;
  onOkAction = null;
  void tween(dim, { alpha: 0 }, 160);
  void tween(card, { scale: 0.72, alpha: 0 }, 170).then(() => {
    if (gen !== animGen) return;
    box.visible = false;
    card.scale.set(1);
    card.alpha = 1;
  });
}

export function hideRoomsConfirm(): void {
  if (!box) return;
  animGen++;
  box.visible = false;
  card.scale.set(1);
  card.alpha = 1;
  onOkAction = null;
}

export function isRoomsConfirmOpen(): boolean {
  return box?.visible === true;
}

function makeConfirmBtn(label: string, texUrl: string, onTap: () => void): Container {
  const b = new Container();
  const bg = new Sprite(tex[texUrl]);
  bg.anchor.set(0.5);
  bg.width = BTN_W;
  bg.scale.y = bg.scale.x;
  b.addChild(bg);
  const t = serifText(label, 24, 0xffe9a8);
  b.addChild(t);
  pressable(b, onTap);
  return b;
}

export function buildRoomsConfirm(): Container {
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', () => {
    const action = noticeMode ? onOkAction : null;
    closeRoomsConfirm();
    action?.();
  });
  box.addChild(dim);

  card = new Container();

  const panel = new Sprite(tex[A.confirm.panel]);
  panel.anchor.set(0.5);
  panel.width = PANEL_W;
  panel.scale.y = panel.scale.x;
  panel.eventMode = 'static';
  card.addChild(panel);
  const panelH = panel.height;
  const halfH = panelH / 2;

  const header = new Sprite(tex[A.confirm.header]);
  header.anchor.set(0.5);
  header.width = PANEL_W * 0.62;
  header.scale.y = header.scale.x;
  header.y = -halfH;
  card.addChild(header);

  titleText = serifText('XÁC NHẬN', 26, 0xffe9a8);
  titleText.y = header.y;
  card.addChild(titleText);

  message = serifText('', 21, 0xfbead0);
  message.style.wordWrap = true;
  message.style.wordWrapWidth = PANEL_W - 110;
  message.style.align = 'center';
  message.style.lineHeight = 32;
  message.y = -14;
  card.addChild(message);

  const btnY = halfH - 46;
  cancelBtn = makeConfirmBtn('HỦY', A.confirm.btnCancel, closeRoomsConfirm);
  cancelBtn.x = -OK_X;
  cancelBtn.y = btnY;
  card.addChild(cancelBtn);

  okBtn = makeConfirmBtn('ĐỒNG Ý', A.confirm.btnOk, () => {
    const action = onOkAction;
    closeRoomsConfirm();
    action?.();
  });
  okBtn.x = OK_X;
  okBtn.y = btnY;
  card.addChild(okBtn);

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutRoomsConfirm(designH: number): void {
  if (!box) return;
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  card.x = DESIGN_W / 2;
  card.y = designH / 2;
}
