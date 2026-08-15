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
let badgeFrame: Sprite;
let badgeCoin: Sprite;
let badgeText: Text;
let badgePos: {
  boardY: number;
  overhang: number;
  minY: number;
  cardGapW: number;
} | null = null;
let actionRow: Container;
let kickBtn: ButtonUI;
let leaveBtn: ButtonUI;
let kickShown = false;

// Texture kenFrame có hốc tròn khoét trong suốt bên trái (tâm ≈13% chiều
// rộng, đường kính ≈82% chiều cao, thân xanh bắt đầu từ ≈23.5%) — coin phải
// nằm đúng hốc, chữ canh giữa phần thân xanh; pill co giãn ôm sát chữ.
function fitBadge(): void {
  const w = Math.max(120, (badgeText.width + 28) / 0.745);
  badgeFrame.width = w;
  badgeFrame.scale.y = badgeFrame.scale.x;
  badgeCoin.width = badgeFrame.height * 0.88;
  badgeCoin.scale.y = badgeCoin.scale.x;
  badgeCoin.x = -w / 2 + w * 0.13;
  badgeText.x = w * 0.1075;
  placeBadge();
}

function placeBadge(): void {
  if (!badgePos) return;
  badge.scale.set(1);
  const wantY = badgePos.boardY - badgePos.overhang - badge.height / 2 - 10;
  if (wantY >= badgePos.minY + badge.height / 2) {
    badge.position.set(DESIGN_W / 2, wantY);
    return;
  }
  // Màn ngắn: khe dọc giữa card và bàn không đủ — vẫn giữ badge ngay trên mép
  // bàn một chút, co lại cho lọt khe ngang giữa 2 card (badge nằm giữa nên
  // không bị card che).
  const fit = Math.min(1, badgePos.cardGapW / badge.width);
  badge.scale.set(fit);
  badge.position.set(DESIGN_W / 2, badgePos.boardY - badgePos.overhang - badge.height / 2 - 6);
}

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
  badgeFrame = new Sprite(tex[A.lobby.kenFrame]);
  badgeFrame.anchor.set(0.5);
  badge.addChild(badgeFrame);
  badgeCoin = new Sprite(tex[A.lobby.coin]);
  badgeCoin.anchor.set(0.5);
  badge.addChild(badgeCoin);
  badgeText = makeText('', 13, 0xffffff, '800');
  badge.addChild(badgeText);
  fitBadge();

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
  fitBadge();
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
  badgeMinY: number;
  cardGapW: number;
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
  // Màn ngắn: bàn cờ bị đẩy lên cao, badge neo theo mép bàn sẽ chui vào vùng
  // 2 card đấu thủ (và bị card che) — kẹp không cho vượt qua đáy card.
  badgePos = { boardY, overhang, minY: opts.badgeMinY, cardGapW: opts.cardGapW };
  placeBadge();
  actionRow.y = opts.rowY;
  placeRowButtons();
}
