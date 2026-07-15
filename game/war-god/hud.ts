import { Container, Graphics, Sprite, Text, Texture } from 'pixi.js';
import { MAX_HP, MAX_MP, type Fighter } from './battle';
import { A, tex } from './assets';
import { HEADING, makeText } from './kit';

export interface BarUI {
  fill: Graphics;
  label: Text;
  width: number;
  color: number;
}

export interface FighterUI {
  card: Container;
  border: Sprite;
  ring: Sprite;
  hp: BarUI;
  mp: BarUI;
  armor: Container;
  armorText: Text;
  ultFrame: Sprite;
  ultFlame: Sprite;
  ultLabel: Text;
  ultOn: Texture;
  ultOff: Texture;
  ultBtn: Container;
}

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
  overlayBtnLabel: Text;
  overlayDim: Graphics;
  confirm: Container;
  confirmDim: Graphics;
  confirmTitle: Text;
};

let confirmAction: (() => void) | null = null;

function makeBar(
  icon: Texture,
  color: number,
  width: number,
  mirror: boolean,
): { view: Container; bar: BarUI } {
  const c = new Container();
  const ic = new Sprite(icon);
  ic.anchor.set(0.5);
  ic.scale.set(17 / Math.max(ic.texture.width, ic.texture.height));

  const track = new Graphics().roundRect(0, 0, width, 14, 7).fill({ color: 0x000000, alpha: 0.55 });
  track.stroke({ width: 1, color: 0xffffff, alpha: 0.2 });
  const fill = new Graphics();
  const label = makeText('', 9.5, 0xffffff, '800');
  label.y = 7;

  const barX = mirror ? 0 : 22;
  ic.x = mirror ? width + 11 : 9;
  ic.y = 7;
  track.x = barX;
  fill.x = barX;
  label.x = barX + width / 2;

  c.addChild(track, fill, ic, label);
  return { view: c, bar: { fill, label, width, color } };
}

function updateBar(bar: BarUI, cur: number, max: number): void {
  const frac = Math.max(0, Math.min(1, cur / max));
  const w = bar.width * frac;
  bar.fill.clear();
  if (w > 1) {
    bar.fill.roundRect(0, 0, w, 14, Math.min(7, w / 2)).fill(bar.color);
  }
  bar.label.text = `${cur}/${max}`;
}

function makeFighterCard(side: 'me' | 'foe', onUlt?: () => void): FighterUI {
  const mirror = side === 'foe';
  const w = 190;
  const h = 140;
  const card = new Container();

  const bg = new Graphics().roundRect(0, 0, w, h, 14).fill({ color: 0x101c2c, alpha: 0.88 });
  card.addChild(bg);

  const border = new Sprite(tex[A.hud.cardBorderIdle]);
  border.width = w;
  border.height = h;
  card.addChild(border);

  const ring = new Sprite(tex[A.hud.ringIdle]);
  ring.width = 36;
  ring.height = 36;
  ring.x = mirror ? w - 12 - 36 : 12;
  ring.y = 8;
  card.addChild(ring);

  const face = makeText(mirror ? '🤖' : 'Bạn', 11, 0xffe9b8, '800');
  face.x = ring.x + 18;
  face.y = ring.y + 18;
  card.addChild(face);

  const name = makeText(mirror ? '@máy' : '@bạn', 13, 0xffffff, '800');
  name.anchor.set(mirror ? 1 : 0, 0.5);
  name.x = mirror ? w - 56 : 56;
  name.y = 26;
  card.addChild(name);

  const rank = new Sprite(tex[A.hud.rankFrame]);
  rank.width = 26;
  rank.height = 30;
  rank.x = mirror ? 12 : w - 12 - 26;
  rank.y = 11;
  card.addChild(rank);

  const rankNum = makeText(mirror ? '2' : '1', 13, 0xf6c445, '700', HEADING);
  rankNum.x = rank.x + 13;
  rankNum.y = rank.y + 15;
  card.addChild(rankNum);

  const hpRow = makeBar(tex[A.hud.icHp], 0xe6392e, 140, mirror);
  hpRow.view.x = 12;
  hpRow.view.y = 48;
  card.addChild(hpRow.view);

  const mpRow = makeBar(tex[A.hud.icMp], 0x2f7fe0, 140, mirror);
  mpRow.view.x = 12;
  mpRow.view.y = 70;
  card.addChild(mpRow.view);

  const armor = new Container();
  const armorIc = new Sprite(tex[A.items.shield]);
  armorIc.anchor.set(0.5);
  armorIc.scale.set(13 / Math.max(armorIc.texture.width, armorIc.texture.height));
  const armorText = makeText('0', 10, 0x9fd0ff, '800');
  armorText.anchor.set(0, 0.5);
  armorText.x = 8;
  armor.addChild(armorIc, armorText);
  armor.x = mirror ? 14 : w - 34;
  armor.y = 40;
  armor.visible = false;
  card.addChild(armor);

  const ultOn = tex[mirror ? A.hud.ultRightOn : A.hud.ultLeftOn];
  const ultOff = tex[mirror ? A.hud.ultRightOff : A.hud.ultLeftOff];
  const ultBtn = new Container();
  const ultFrame = new Sprite(ultOff);
  ultFrame.width = 166;
  ultFrame.height = 36;
  ultBtn.addChild(ultFrame);

  const ultFlame = new Sprite(tex[A.hud.flameOff]);
  ultFlame.anchor.set(0.5);
  ultFlame.scale.set(24 / Math.max(ultFlame.texture.width, ultFlame.texture.height));
  ultFlame.x = mirror ? 166 - 17 : 17;
  ultFlame.y = 18;
  ultBtn.addChild(ultFlame);

  const ultLabel = makeText('TUYỆT CHIÊU', 11, 0xcfc9b8, '700', HEADING);
  ultLabel.x = mirror ? (166 - 34) / 2 : 34 + (166 - 34) / 2;
  ultLabel.y = 18;
  ultBtn.addChild(ultLabel);

  ultBtn.x = 12;
  ultBtn.y = 94;
  card.addChild(ultBtn);

  if (onUlt) {
    ultBtn.eventMode = 'static';
    ultBtn.cursor = 'pointer';
    ultBtn.on('pointertap', onUlt);
  }

  return {
    card,
    border,
    ring,
    hp: hpRow.bar,
    mp: mpRow.bar,
    armor,
    armorText,
    ultFrame,
    ultFlame,
    ultLabel,
    ultOn,
    ultOff,
    ultBtn,
  };
}

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
  hud.overlaySub.y = 140;
  card.addChild(hud.overlaySub);

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

export function updateFighter(f: FighterUI, fighter: Fighter, active: boolean, ready: boolean): void {
  updateBar(f.hp, fighter.hp, MAX_HP);
  updateBar(f.mp, fighter.mp, MAX_MP);
  f.armor.visible = fighter.armor > 0;
  f.armorText.text = String(fighter.armor);
  f.border.texture = active ? tex[A.hud.cardBorderActive] : tex[A.hud.cardBorderIdle];
  f.ring.texture = active ? tex[A.hud.ringActive] : tex[A.hud.ringIdle];
  f.card.alpha = active ? 1 : 0.92;
  f.ultFrame.texture = ready ? f.ultOn : f.ultOff;
  f.ultFlame.texture = ready ? tex[A.hud.flameOn] : tex[A.hud.flameOff];
  f.ultLabel.style.fill = ready ? 0xffe9a8 : 0xcfc9b8;
}

export function showOverlay(title: string, titleColor: number, sub: string, btnLabel: string): void {
  hud.overlayTitle.text = title;
  hud.overlayTitle.style.fill = titleColor;
  hud.overlaySub.text = sub;
  hud.overlayBtnLabel.text = btnLabel;
  hud.overlay.visible = true;
}

export function showConfirm(question: string, action: () => void): void {
  hud.confirmTitle.text = question;
  confirmAction = action;
  hud.confirm.visible = true;
}
