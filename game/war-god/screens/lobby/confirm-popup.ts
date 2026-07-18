import { Container, Graphics, Sprite, Text } from 'pixi.js';
import { A, tex } from '../../assets';
import { SERIF, makeText, popIn, pressable, tween } from '../../kit';

const DESIGN_W = 520;
const PANEL_W = 430;
const BTN_W = 172;

let box: Container;
let dim: Graphics;
let card: Container;
let message: Text;
let onOkAction: (() => void) | null = null;
let animGen = 0;

function serifText(label: string, size: number, color: number): Text {
  const t = makeText(label, size, color, '700', SERIF);
  t.style.letterSpacing = 2;
  return t;
}

export function openConfirmPopup(text: string, onOk: () => void): void {
  animGen++;
  onOkAction = onOk;
  message.text = text;
  box.visible = true;
  card.alpha = 1;
  card.scale.set(1);
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
}

export function closeConfirmPopup(): void {
  if (!box.visible) return;
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

export function hideConfirmPopup(): void {
  animGen++;
  box.visible = false;
  card.scale.set(1);
  card.alpha = 1;
  onOkAction = null;
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

export function buildConfirmPopup(): Container {
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', closeConfirmPopup);
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

  const title = serifText('XÁC NHẬN', 26, 0xffe9a8);
  title.y = header.y;
  card.addChild(title);

  message = serifText('', 21, 0xfbead0);
  message.style.wordWrap = true;
  message.style.wordWrapWidth = PANEL_W - 110;
  message.style.align = 'center';
  message.style.lineHeight = 32;
  message.y = -14;
  card.addChild(message);

  const btnY = halfH - 46;
  const cancel = makeConfirmBtn('HỦY', A.confirm.btnCancel, closeConfirmPopup);
  cancel.x = -PANEL_W / 2 + BTN_W / 2 + 34;
  cancel.y = btnY;
  card.addChild(cancel);

  const ok = makeConfirmBtn('ĐỒNG Ý', A.confirm.btnOk, () => {
    const action = onOkAction;
    closeConfirmPopup();
    action?.();
  });
  ok.x = PANEL_W / 2 - BTN_W / 2 - 34;
  ok.y = btnY;
  card.addChild(ok);

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutConfirmPopup(designH: number): void {
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  card.x = DESIGN_W / 2;
  card.y = designH / 2;
}
