import { Container, Sprite, Text } from 'pixi.js';
import { A, tex } from '../../assets';
import { SERIF, makeText, pressable } from '../../kit';
import { createCardModal, type CardModal } from './card-modal';

const PANEL_W = 430;
const BTN_W = 172;
const BTN_LABEL_SIZE = 20;

let modal: CardModal;
let message: Text;
let onOkAction: (() => void) | null = null;

function serifText(label: string, size: number, color: number): Text {
  const t = makeText(label, size, color, '700', SERIF);
  t.style.letterSpacing = 2;
  return t;
}

export function openConfirmPopup(text: string, onOk: () => void): void {
  onOkAction = onOk;
  message.text = text;
  modal.open();
}

export function closeConfirmPopup(): void {
  onOkAction = null;
  modal.close();
}

export function hideConfirmPopup(): void {
  onOkAction = null;
  modal.hide();
}

function makeConfirmBtn(label: string, texUrl: string, onTap: () => void): Container {
  const b = new Container();
  const bg = new Sprite(tex[texUrl]);
  bg.anchor.set(0.5);
  bg.width = BTN_W;
  bg.scale.y = bg.scale.x;
  b.addChild(bg);
  const t = serifText(label, BTN_LABEL_SIZE, 0xffe9a8);
  b.addChild(t);
  pressable(b, onTap);
  return b;
}

export function buildConfirmPopup(): Container {
  modal = createCardModal(closeConfirmPopup);
  const { card } = modal;

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

  return modal.box;
}

export function layoutConfirmPopup(designH: number): void {
  modal.layout(designH);
}
