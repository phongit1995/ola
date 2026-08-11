import { Container, Graphics, Sprite, Text, Texture } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, makeText } from '../../kit';
import {
  disposeFighterUI,
  makeFighterCard,
  type FighterUI,
} from './hud/card';

export { updateFighter } from './hud/card';

export interface ButtonUI {
  view: Container;
  setEnabled(on: boolean): void;
}

export interface HudActions {
  onUlt(): void;
  onStart(): void;
  onRestart(): void;
  onForfeit(): void;
  onExit(): void;
}

export const hud = {} as {
  me: FighterUI;
  foe: FighterUI;
  banner: Container;
  turnCount: Text;
  timer: Text;
  restart: ButtonUI;
  forfeit: ButtonUI;
  exit: ButtonUI;
  bottomRow: Container;
  overlay: Container;
  overlayTitle: Text;
  overlaySub: Text;
  overlayKen: Text;
  overlayBtnLabel: Text;
  overlayDim: Graphics;
  confirm: Container;
  confirmDim: Graphics;
  confirmTitle: Text;
};

let confirmAction: (() => void) | null = null;


function makeMenuButton(label: string, icon: Texture, onTap: () => void): ButtonUI {
  const w = 140;
  const h = 46;
  const c = new Container();
  const bg = new Sprite(tex[A.menu.btnBlue]);
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
    setEnabled(on: boolean) {
      enabled = on;
      c.alpha = on ? 1 : 0.45;
      c.cursor = on ? 'pointer' : 'default';
    },
  };
}

function makeDialogCard(w: number, h: number): Container {
  const c = new Container();
  const g = new Graphics()
    .roundRect(0, 0, w, h, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  c.addChild(g);
  return c;
}

function buildOverlay(onStart: () => void): void {
  hud.overlay = new Container();
  hud.overlayDim = new Graphics();
  hud.overlayDim.eventMode = 'static';
  hud.overlay.addChild(hud.overlayDim);

  const cardW = 340;
  const cardH = 250;
  const card = makeDialogCard(cardW, cardH);
  card.label = 'overlay-card';
  hud.overlay.addChild(card);

  const logo = makeText('⚔️', 40, 0xffffff);
  logo.x = cardW / 2;
  logo.y = 48;
  card.addChild(logo);

  hud.overlayTitle = makeText('WAR GOD', 30, 0xf6c445, '700', HEADING);
  hud.overlayTitle.x = cardW / 2;
  hud.overlayTitle.y = 100;
  card.addChild(hud.overlayTitle);

  hud.overlaySub = makeText('', 12.5, 0xb9b39e, '700');
  hud.overlaySub.style.wordWrap = true;
  hud.overlaySub.style.wordWrapWidth = cardW - 50;
  hud.overlaySub.style.align = 'center';
  hud.overlaySub.x = cardW / 2;
  hud.overlaySub.y = 134;
  card.addChild(hud.overlaySub);

  hud.overlayKen = makeText('', 16, 0x7dff8a, '800');
  hud.overlayKen.style.stroke = { color: 0x120d02, width: 3, join: 'round' };
  hud.overlayKen.x = cardW / 2;
  hud.overlayKen.y = 160;
  hud.overlayKen.visible = false;
  card.addChild(hud.overlayKen);

  const btn = new Container();
  const btnBg = new Sprite(tex[A.menu.btnBlue]);
  btnBg.width = 190;
  btnBg.height = 52;
  btn.addChild(btnBg);
  hud.overlayBtnLabel = makeText('Chơi với máy', 16, 0xffffff, '700', HEADING);
  hud.overlayBtnLabel.x = 95;
  hud.overlayBtnLabel.y = 26;
  btn.addChild(hud.overlayBtnLabel);
  btn.x = (cardW - 190) / 2;
  btn.y = 180;
  btn.eventMode = 'static';
  btn.cursor = 'pointer';
  btn.on('pointertap', onStart);
  card.addChild(btn);
}

function buildConfirm(): void {
  hud.confirm = new Container();
  hud.confirmDim = new Graphics();
  hud.confirmDim.eventMode = 'static';
  hud.confirm.addChild(hud.confirmDim);

  const cardW = 300;
  const cardH = 150;
  const card = makeDialogCard(cardW, cardH);
  card.label = 'confirm-card';
  hud.confirm.addChild(card);

  hud.confirmTitle = makeText('', 14, 0xffffff, '800');
  hud.confirmTitle.style.wordWrap = true;
  hud.confirmTitle.style.wordWrapWidth = cardW - 40;
  hud.confirmTitle.style.align = 'center';
  hud.confirmTitle.x = cardW / 2;
  hud.confirmTitle.y = 45;
  card.addChild(hud.confirmTitle);

  const makeSmallBtn = (label: string, x: number, onTap: () => void): void => {
    const b = new Container();
    const bg = new Sprite(tex[A.menu.btnBlue]);
    bg.width = 120;
    bg.height = 42;
    b.addChild(bg);
    const t = makeText(label, 13, 0xffffff, '700', HEADING);
    t.x = 60;
    t.y = 21;
    b.addChild(t);
    b.x = x;
    b.y = 88;
    b.eventMode = 'static';
    b.cursor = 'pointer';
    b.on('pointertap', onTap);
    card.addChild(b);
  };

  makeSmallBtn('HUỶ', 22, () => {
    hud.confirm.visible = false;
    confirmAction = null;
  });
  makeSmallBtn('ĐỒNG Ý', cardW - 22 - 120, () => {
    hud.confirm.visible = false;
    const act = confirmAction;
    confirmAction = null;
    act?.();
  });

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
  const turnLabel = makeText('LƯỢT', 12, 0xffe9a8, '700', HEADING);
  turnLabel.x = 46;
  turnLabel.y = 38;
  hud.turnCount = makeText('1', 24, 0xffffff, '700', HEADING);
  hud.turnCount.x = 46;
  hud.turnCount.y = 58;
  hud.timer = makeText('00:45', 11, 0xffd9d2, '800');
  hud.timer.x = 46;
  hud.timer.y = 78;
  hud.banner.addChild(turnLabel, hud.turnCount, hud.timer);
  root.addChild(hud.banner);

  hud.restart = makeMenuButton('CHƠI LẠI', tex[A.menu.icRestart], actions.onRestart);
  hud.forfeit = makeMenuButton('BỎ CUỘC', tex[A.menu.icForfeit], actions.onForfeit);
  hud.exit = makeMenuButton('THOÁT', tex[A.menu.icExit], actions.onExit);

  hud.bottomRow = new Container();
  hud.restart.view.x = 0;
  hud.forfeit.view.x = 152;
  hud.exit.view.x = 304;
  hud.bottomRow.addChild(hud.restart.view, hud.forfeit.view, hud.exit.view);
  root.addChild(hud.bottomRow);

  buildOverlay(actions.onStart);
  buildConfirm();
  root.addChild(hud.overlay, hud.confirm);
}

export function disposeHud(): void {
  for (const fighter of [hud.me, hud.foe]) {
    if (fighter) disposeFighterUI(fighter);
  }
  confirmAction = null;
}

export function showOverlay(
  title: string,
  titleColor: number,
  sub: string,
  btnLabel: string,
  ken?: { text: string; color: number },
): void {
  hud.overlayTitle.text = title;
  hud.overlayTitle.style.fill = titleColor;
  hud.overlaySub.text = sub;
  hud.overlayKen.visible = ken != null;
  if (ken) {
    hud.overlayKen.text = ken.text;
    hud.overlayKen.style.fill = ken.color;
  }
  hud.overlayBtnLabel.text = btnLabel;
  hud.overlay.visible = true;
}

export function showConfirm(question: string, action: () => void): void {
  hud.confirmTitle.text = question;
  confirmAction = action;
  hud.confirm.visible = true;
}
