import { Container, Graphics, Sprite, Text, Texture } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, makeText, popIn, pressable } from '../../kit';
import {
  disposeFighterUI,
  makeFighterCard,
  type FighterUI,
} from './hud/card';
import {
  buildResultPopup,
  type ResultPopup,
  type ResultPopupData,
} from './result-popup';
import { battleActionLayout, type BattleMode } from './action-layout';

export { setFighterAvatar, setFighterBotAvatar, setFighterName, updateFighter } from './hud/card';

export interface ButtonUI {
  view: Container;
  isEnabled(): boolean;
  setEnabled(on: boolean): void;
}

export interface HudActions {
  onUlt(): void;
  onResultClose(): void;
  onResultReplay(): void;
  onRestart(): void;
  onForfeit(): void;
  onExit(): void;
}

export type ConfirmKind = 'restart' | 'forfeit' | 'exit' | 'kick' | 'leaveRoom';

export interface ConfirmOptions {
  kind: ConfirmKind;
  message: string;
  confirmLabel: string;
  cancelLabel?: string;
  onConfirm(): void;
}

export const CONFIRM_CARD_W = 340;
export const CONFIRM_CARD_H = 227;

export const hud = {} as {
  me: FighterUI;
  foe: FighterUI;
  banner: Container;
  timer: Text;
  restart: ButtonUI;
  forfeit: ButtonUI;
  exit: ButtonUI;
  bottomRow: Container;
  result: ResultPopup;
  confirm: Container;
  confirmDim: Graphics;
  confirmCard: Container;
  confirmHeading: Text;
  confirmMessage: Text;
  confirmIcon: Sprite;
  confirmAcceptBg: Sprite;
  confirmAcceptText: Text;
  confirmCancelText: Text;
};

export function setBattleMode(mode: BattleMode): void {
  const layout = battleActionLayout(mode);
  hud.restart.view.visible = layout.restartVisible;
  hud.restart.view.x = layout.restartX;
  hud.forfeit.view.x = layout.forfeitX;
  hud.exit.view.x = layout.exitX;
}

let confirmAction: (() => void) | null = null;


export function makeMenuButton(label: string, background: string, icon: Texture, onTap: () => void): ButtonUI {
  const w = 140;
  const h = 46;
  const c = new Container();
  const bg = new Sprite(tex[background]);
  bg.width = w;
  bg.height = h;
  c.addChild(bg);

  const ic = new Sprite(icon);
  ic.anchor.set(0.5);
  ic.scale.set(18 / Math.max(ic.texture.width, ic.texture.height));

  const t = makeText(label, 13, 0xffffff, '700', HEADING);
  const totalW = 24 + t.width;
  ic.x = w / 2 - totalW / 2 + 9;
  ic.y = h / 2;
  t.x = w / 2 + 12;
  t.y = h / 2;
  c.addChild(ic, t);

  let enabled = true;
  c.eventMode = 'static';
  c.cursor = 'pointer';
  c.on('pointertap', () => {
    if (enabled) onTap();
  });
  c.on('pointerdown', () => {
    if (enabled) c.scale.set(0.96);
  });
  c.on('pointerup', () => c.scale.set(1));
  c.on('pointerupoutside', () => c.scale.set(1));

  return {
    view: c,
    isEnabled: () => enabled,
    setEnabled(on: boolean) {
      enabled = on;
      c.alpha = on ? 1 : 0.45;
      c.cursor = on ? 'pointer' : 'default';
    },
  };
}

function fitText(text: Text, maxWidth: number): void {
  text.scale.set(1);
  if (text.width > maxWidth) text.scale.set(maxWidth / text.width);
}

export function hideConfirm(): void {
  hud.confirm.visible = false;
  confirmAction = null;
}

function buildConfirm(): void {
  hud.confirm = new Container();
  hud.confirmDim = new Graphics();
  hud.confirmDim.eventMode = 'static';
  hud.confirmDim.cursor = 'pointer';
  hud.confirmDim.on('pointertap', hideConfirm);
  hud.confirm.addChild(hud.confirmDim);

  hud.confirmCard = new Container();
  hud.confirmCard.label = 'confirm-card';
  hud.confirmCard.eventMode = 'static';
  const panel = new Sprite(tex[A.battleConfirm.panel]);
  panel.width = CONFIRM_CARD_W;
  panel.height = CONFIRM_CARD_H;
  hud.confirmCard.addChild(panel);
  hud.confirm.addChild(hud.confirmCard);

  hud.confirmHeading = makeText('', 18, 0xffe9b0, '800', HEADING);
  hud.confirmHeading.x = CONFIRM_CARD_W / 2;
  // Khung + hoa văn của panel chiếm ~32px trên cùng, đặt cao hơn là chữ chui vào khung.
  hud.confirmHeading.y = 53;
  hud.confirmCard.addChild(hud.confirmHeading);

  hud.confirmIcon = new Sprite(tex[A.menu.icForfeit]);
  hud.confirmIcon.anchor.set(0.5);
  hud.confirmIcon.x = CONFIRM_CARD_W / 2;
  hud.confirmIcon.y = 86;
  hud.confirmCard.addChild(hud.confirmIcon);

  hud.confirmMessage = makeText('', 13, 0xfff1ce, '700');
  hud.confirmMessage.style.wordWrap = true;
  hud.confirmMessage.style.wordWrapWidth = 278;
  hud.confirmMessage.style.align = 'center';
  hud.confirmMessage.style.lineHeight = 17;
  hud.confirmMessage.x = CONFIRM_CARD_W / 2;
  hud.confirmMessage.y = 125;
  hud.confirmCard.addChild(hud.confirmMessage);

  function makeSmallBtn(background: string, x: number, onTap: () => void): { bg: Sprite; text: Text } {
    const button = new Container();
    const bg = new Sprite(tex[background]);
    bg.width = 128;
    bg.height = 39;
    button.addChild(bg);
    const text = makeText('', 12, 0xfff1ce, '800', HEADING);
    text.x = 64;
    text.y = 20;
    button.addChild(text);
    button.x = x;
    button.y = 172;
    pressable(button, onTap);
    hud.confirmCard.addChild(button);
    return { bg, text };
  }

  const cancel = makeSmallBtn(A.battleConfirm.btnSafe, 35, hideConfirm);
  hud.confirmCancelText = cancel.text;
  const accept = makeSmallBtn(A.menu.btnForfeit, CONFIRM_CARD_W - 35 - 128, () => {
    const act = confirmAction;
    hideConfirm();
    act?.();
  });
  hud.confirmAcceptBg = accept.bg;
  hud.confirmAcceptText = accept.text;

  hud.confirm.visible = false;
}

export function buildHud(root: Container, actions: HudActions): void {
  if (hud.me && hud.foe) disposeHud();
  hud.me = makeFighterCard('me', actions.onUlt);
  hud.foe = makeFighterCard('foe');
  root.addChild(hud.me.card, hud.foe.card);

  hud.banner = new Container();
  const bannerBg = new Sprite(tex[A.hud.turnBanner]);
  bannerBg.width = 92;
  bannerBg.height = 118;
  hud.banner.addChild(bannerBg);
  hud.timer = makeText('30', 36, 0xffffff, '800', HEADING);
  hud.timer.x = 46;
  hud.timer.y = 68;
  hud.banner.addChild(hud.timer);
  root.addChild(hud.banner);

  hud.restart = makeMenuButton('CHƠI LẠI', A.menu.btnBlue, tex[A.menu.icRestart], actions.onRestart);
  hud.forfeit = makeMenuButton('BỎ CUỘC', A.menu.btnForfeit, tex[A.menu.icForfeit], actions.onForfeit);
  hud.exit = makeMenuButton('THOÁT', A.menu.btnExit, tex[A.menu.icExit], actions.onExit);

  hud.bottomRow = new Container();
  hud.bottomRow.addChild(hud.restart.view, hud.forfeit.view, hud.exit.view);
  root.addChild(hud.bottomRow);
  setBattleMode('bot');

  hud.result = buildResultPopup(actions.onResultClose, actions.onResultReplay);
  buildConfirm();
  root.addChild(hud.result.view, hud.confirm);
}

export function disposeHud(): void {
  for (const fighter of [hud.me, hud.foe]) {
    if (fighter) disposeFighterUI(fighter);
  }
  hideConfirm();
}

export function showResult(data: ResultPopupData): void {
  hud.result.show(data);
}

const CONFIRM_HEADINGS: Record<ConfirmKind, string> = {
  restart: 'XÁC NHẬN CHƠI LẠI',
  forfeit: 'XÁC NHẬN BỎ CUỘC',
  exit: 'XÁC NHẬN RỜI TRẬN',
  kick: 'XÁC NHẬN MỜI RA',
  leaveRoom: 'XÁC NHẬN RỜI BÀN',
};

export function showConfirm(options: ConfirmOptions): void {
  const heading = CONFIRM_HEADINGS[options.kind];
  const icon =
    options.kind === 'forfeit' || options.kind === 'kick'
      ? A.menu.icForfeit
      : options.kind === 'exit' || options.kind === 'leaveRoom'
        ? A.menu.icExit
        : A.menu.icRestart;
  const actionBackground =
    options.kind === 'forfeit' || options.kind === 'kick'
      ? A.menu.btnForfeit
      : options.kind === 'exit' || options.kind === 'leaveRoom'
        ? A.menu.btnExit
        : A.battleConfirm.btnSafe;

  hud.confirmHeading.text = heading;
  fitText(hud.confirmHeading, 238);
  hud.confirmMessage.text = options.message;
  hud.confirmIcon.texture = tex[icon];
  hud.confirmIcon.scale.set(29 / Math.max(hud.confirmIcon.texture.width, hud.confirmIcon.texture.height));
  hud.confirmAcceptBg.texture = tex[actionBackground];
  hud.confirmAcceptBg.width = 128;
  hud.confirmAcceptBg.height = 39;
  hud.confirmAcceptText.text = options.confirmLabel;
  fitText(hud.confirmAcceptText, 94);
  hud.confirmCancelText.text = options.cancelLabel ?? 'TIẾP TỤC';
  fitText(hud.confirmCancelText, 94);
  confirmAction = options.onConfirm;
  hud.confirm.visible = true;
  popIn(hud.confirmCard, 0, 300);
}
