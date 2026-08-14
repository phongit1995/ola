import { Container, Graphics, Sprite, Text } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, makeText, pressable } from '../../kit';
import { DESIGN_W } from '../../layout';
import { makeMenuButton, type ButtonUI } from './hud';

export interface RoomPregameCallbacks {
  onToggleReady(): void;
  onStart(): void;
  onKick(): void;
  onLeave(): void;
}

export interface RoomPregameView {
  betText: string;
  roomLine: string;
  status: string;
  main: { label: string; action: 'toggle' | 'start'; enabled: boolean } | null;
  kickVisible: boolean;
}

const ROW_BTN_W = 140;
const ROW_GAP = 12;

let cb: RoomPregameCallbacks | null = null;
let panel: Container;
let panelBg: Graphics;
let statusText: Text;
let roomText: Text;
let mainBtn: Container;
let mainLabel: Text;
let mainEnabled = false;
let mainAction: 'toggle' | 'start' = 'toggle';
let badge: Container;
let badgeText: Text;
let actionRow: Container;
let kickBtn: ButtonUI;
let leaveBtn: ButtonUI;
let kickShown = false;

function placeRowButtons(): void {
  kickBtn.view.visible = kickShown;
  if (kickShown) {
    const total = ROW_BTN_W * 2 + ROW_GAP;
    kickBtn.view.x = (DESIGN_W - total) / 2;
    leaveBtn.view.x = kickBtn.view.x + ROW_BTN_W + ROW_GAP;
  } else {
    leaveBtn.view.x = (DESIGN_W - ROW_BTN_W) / 2;
  }
}

export function buildRoomPregame(root: Container): void {
  panel = new Container();
  panelBg = new Graphics();
  panelBg.eventMode = 'static';
  panel.addChild(panelBg);

  statusText = makeText('', 17, 0xffe9a8, '800', HEADING);
  statusText.style.wordWrap = true;
  statusText.style.align = 'center';
  statusText.style.stroke = { color: 0x120d02, width: 4, join: 'round' };
  panel.addChild(statusText);

  roomText = makeText('', 13, 0xcfd9e6, '700');
  panel.addChild(roomText);

  mainBtn = new Container();
  const mainBg = new Sprite(tex[A.lobby.btnWood]);
  mainBg.anchor.set(0.5);
  mainBg.width = 224;
  mainBg.height = 64;
  mainBtn.addChild(mainBg);
  mainLabel = makeText('', 19, 0xffd84d, '800', HEADING);
  mainBtn.addChild(mainLabel);
  pressable(mainBtn, () => {
    if (!cb || !mainEnabled) return;
    if (mainAction === 'start') cb.onStart();
    else cb.onToggleReady();
  });
  panel.addChild(mainBtn);

  badge = new Container();
  const badgeFrame = new Sprite(tex[A.lobby.kenFrame]);
  badgeFrame.anchor.set(0.5);
  badgeFrame.width = 148;
  badgeFrame.scale.y = badgeFrame.scale.x;
  badge.addChild(badgeFrame);
  const coin = new Sprite(tex[A.lobby.coin]);
  coin.anchor.set(0.5);
  coin.width = badgeFrame.height * 0.95;
  coin.scale.y = coin.scale.x;
  coin.x = -badgeFrame.width / 2 + coin.width * 0.2;
  badge.addChild(coin);
  badgeText = makeText('', 13, 0xffffff, '800');
  badgeText.x = coin.width * 0.16;
  badge.addChild(badgeText);

  actionRow = new Container();
  kickBtn = makeMenuButton('MỜI RA', A.menu.btnForfeit, tex[A.menu.icForfeit], () => cb?.onKick());
  leaveBtn = makeMenuButton('RỜI BÀN', A.menu.btnExit, tex[A.menu.icExit], () => cb?.onLeave());
  actionRow.addChild(kickBtn.view, leaveBtn.view);

  panel.visible = false;
  badge.visible = false;
  actionRow.visible = false;
  root.addChild(panel, badge, actionRow);
}

export function showRoomPregame(callbacks: RoomPregameCallbacks): void {
  cb = callbacks;
  panel.visible = true;
  badge.visible = true;
  actionRow.visible = true;
}

export function hideRoomPregame(): void {
  if (!panel) return;
  cb = null;
  panel.visible = false;
  badge.visible = false;
  actionRow.visible = false;
}

export function setRoomPregameView(view: RoomPregameView): void {
  if (!panel) return;
  badgeText.text = view.betText;
  roomText.text = view.roomLine;
  statusText.text = view.status;
  if (view.main) {
    mainBtn.visible = true;
    mainLabel.text = view.main.label;
    mainAction = view.main.action;
    mainEnabled = view.main.enabled;
    mainBtn.alpha = view.main.enabled ? 1 : 0.55;
    mainBtn.eventMode = view.main.enabled ? 'static' : 'none';
  } else {
    mainBtn.visible = false;
  }
  kickShown = view.kickVisible;
  placeRowButtons();
}

export function layoutRoomPregame(opts: {
  boardX: number;
  boardY: number;
  boardW: number;
  rowY: number;
}): void {
  if (!panel) return;
  const { boardX, boardY, boardW } = opts;
  const overhang = boardW * 0.05;
  panel.position.set(boardX, boardY);
  panelBg
    .clear()
    .roundRect(-overhang, -overhang, boardW + overhang * 2, boardW + overhang * 2, 12)
    .fill({ color: 0x0b131f, alpha: 0.58 });
  statusText.style.wordWrapWidth = boardW * 0.82;
  statusText.position.set(boardW / 2, boardW * 0.36);
  roomText.position.set(boardW / 2, boardW * 0.46);
  mainBtn.position.set(boardW / 2, boardW * 0.6);
  badge.position.set(DESIGN_W / 2, boardY - overhang - badge.height / 2 - 6);
  actionRow.y = opts.rowY;
  placeRowButtons();
}
