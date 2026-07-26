import { Container, Graphics, Rectangle, type Text } from 'pixi.js';
import type { GameSession, MatchHistoryOutcome } from '../../../src/sdk';
import { HEADING, makeText, popIn, tween } from '../../kit';
import { LEVEL_LABELS } from '../../logic/battle';
import { readBotHistory } from '../../logic/bot-history';
import { makeWoodBtn } from './ui';

const DESIGN_W = 520;
const CARD_W = 456;
const LIST_W = CARD_W - 44;
const ROW_H = 34;
const MAX_ROWS = 100;
const LOAD_TIMEOUT = 8000;

interface HistoryRow {
  playedAt: number;
  opponent: string;
  bet: number;
  outcome: MatchHistoryOutcome;
}

const OUTCOME_LABEL: Record<MatchHistoryOutcome, string> = {
  win: 'Thắng',
  lose: 'Thua',
  draw: 'Hòa',
};

const OUTCOME_COLOR: Record<MatchHistoryOutcome, number> = {
  win: 0x7dff8a,
  lose: 0xff6b5e,
  draw: 0xffd75e,
};

let box: Container;
let dim: Graphics;
let card: Container;
let bg: Graphics;
let title: Text;
let statusText: Text;
let retryBtn: Container;
let closeBtn: Container;
let listLayer: Container;
let listMask: Graphics;
let scrollZone: Container;
let cardH = 560;
let listTop = -212;
let listBottom = 192;
let extraTop = 0;
let scrollY = 0;
let contentH = 0;
let dragY: number | null = null;
let getSession: () => GameSession | null = () => null;
let pvpRows: HistoryRow[] | null = null;
let loadState: 'loading' | 'error' | 'done' = 'done';
let offHistory: (() => void) | null = null;
let loadTimer: number | undefined;
let loadGen = 0;

function formatTime(ts: number): string {
  const d = new Date(ts);
  const p = (n: number): string => String(n).padStart(2, '0');
  return `${p(d.getDate())}/${p(d.getMonth() + 1)} ${p(d.getHours())}:${p(d.getMinutes())}`;
}

function levelLabel(level: string): string {
  return (LEVEL_LABELS as Record<string, string>)[level] ?? level.toUpperCase();
}

function botRows(): HistoryRow[] {
  return readBotHistory().map((entry) => ({
    playedAt: entry.playedAt,
    opponent: `Máy · ${levelLabel(entry.level)}`,
    bet: 0,
    outcome: entry.outcome,
  }));
}

function mergedRows(): HistoryRow[] {
  return [...(pvpRows ?? []), ...botRows()]
    .sort((a, b) => b.playedAt - a.playedAt)
    .slice(0, MAX_ROWS);
}

function viewH(): number {
  return Math.max(0, listBottom - listTop - extraTop);
}

function applyScroll(): void {
  const maxBack = Math.max(0, contentH - viewH());
  scrollY = Math.max(0, Math.min(maxBack, scrollY));
  listLayer.y = listTop + extraTop - scrollY;
}

function makeRow(row: HistoryRow): Container {
  const r = new Container();
  const time = makeText(formatTime(row.playedAt), 12, 0x9fb3cc, '700');
  time.anchor.set(0, 0.5);
  time.y = ROW_H / 2;
  r.addChild(time);
  const opp = makeText(row.opponent, 13, 0xffffff, '700');
  opp.anchor.set(0, 0.5);
  opp.x = 82;
  opp.y = ROW_H / 2;
  const oppMax = 146;
  if (opp.width > oppMax) opp.scale.set(oppMax / opp.width);
  r.addChild(opp);
  const bet = makeText(
    row.bet > 0 ? `${row.bet.toLocaleString('vi-VN')} KEN` : '—',
    12,
    row.bet > 0 ? 0xffd84d : 0x9fb3cc,
    '700',
  );
  bet.anchor.set(1, 0.5);
  bet.x = LIST_W - 58;
  bet.y = ROW_H / 2;
  r.addChild(bet);
  const outcome = makeText(OUTCOME_LABEL[row.outcome], 13, OUTCOME_COLOR[row.outcome], '800');
  outcome.anchor.set(1, 0.5);
  outcome.x = LIST_W;
  outcome.y = ROW_H / 2;
  r.addChild(outcome);
  const line = new Graphics().rect(0, ROW_H - 1, LIST_W, 1).fill({ color: 0xffffff, alpha: 0.07 });
  r.addChild(line);
  return r;
}

function render(): void {
  if (!listLayer) return;
  listLayer.removeChildren().forEach((c) => c.destroy({ children: true }));
  const rows = loadState === 'loading' ? [] : mergedRows();
  extraTop = loadState === 'error' && rows.length > 0 ? 96 : 0;
  rows.forEach((row, idx) => {
    const r = makeRow(row);
    r.y = idx * ROW_H;
    listLayer.addChild(r);
  });
  contentH = rows.length * ROW_H;
  const centerY = (listTop + listBottom) / 2;
  if (loadState === 'loading') {
    statusText.visible = true;
    statusText.text = 'Đang tải...';
    statusText.y = centerY;
    retryBtn.visible = false;
  } else if (loadState === 'error') {
    statusText.visible = true;
    statusText.text = 'Không tải được lịch sử';
    if (rows.length === 0) {
      statusText.y = centerY - 34;
      retryBtn.y = centerY + 22;
    } else {
      statusText.y = listTop + 16;
      retryBtn.y = listTop + 62;
    }
    retryBtn.visible = true;
  } else if (rows.length === 0) {
    statusText.visible = true;
    statusText.text = 'Chưa có trận nào';
    statusText.y = centerY;
    retryBtn.visible = false;
  } else {
    statusText.visible = false;
    retryBtn.visible = false;
  }
  const top = listTop + extraTop;
  listMask.clear().rect(-CARD_W / 2 + 12, top, CARD_W - 24, viewH()).fill(0xffffff);
  scrollZone.hitArea = new Rectangle(-CARD_W / 2 + 12, top, CARD_W - 24, viewH());
  applyScroll();
}

function cleanupLoad(): void {
  if (offHistory) {
    offHistory();
    offHistory = null;
  }
  if (loadTimer !== undefined) {
    window.clearTimeout(loadTimer);
    loadTimer = undefined;
  }
}

function startLoad(): void {
  cleanupLoad();
  const gen = ++loadGen;
  const session = getSession();
  if (!session) {
    pvpRows = null;
    loadState = 'error';
    render();
    return;
  }
  loadState = 'loading';
  render();
  offHistory = session.onHistory((data) => {
    if (gen !== loadGen) return;
    cleanupLoad();
    if (data.error) {
      loadState = 'error';
      render();
      return;
    }
    pvpRows = data.items.map((entry) => ({
      playedAt: entry.playedAt,
      opponent: `@${entry.opponentName}`,
      bet: entry.bet,
      outcome: entry.outcome,
    }));
    loadState = 'done';
    render();
  });
  loadTimer = window.setTimeout(() => {
    if (gen !== loadGen) return;
    cleanupLoad();
    loadState = 'error';
    render();
  }, LOAD_TIMEOUT);
  session.getHistory();
}

export function openHistoryPopup(next: () => GameSession | null): void {
  getSession = next;
  scrollY = 0;
  dragY = null;
  pvpRows = null;
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
  startLoad();
}

export function hideHistoryPopup(): void {
  loadGen++;
  cleanupLoad();
  dragY = null;
  box.visible = false;
}

function drawCard(): void {
  bg.clear()
    .roundRect(-CARD_W / 2, -cardH / 2, CARD_W, cardH, 18)
    .fill({ color: 0x101c2c, alpha: 0.96 })
    .stroke({ width: 2, color: 0xf6c445 });
  title.y = -cardH / 2 + 40;
  closeBtn.y = cardH / 2 - 48;
  listTop = -cardH / 2 + 68;
  listBottom = cardH / 2 - 88;
}

export function buildHistoryPopup(): Container {
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', hideHistoryPopup);
  box.addChild(dim);

  card = new Container();
  bg = new Graphics();
  bg.eventMode = 'static';
  card.addChild(bg);

  title = makeText('LỊCH SỬ ĐẤU', 24, 0xffd84d, '700', HEADING);
  card.addChild(title);

  listLayer = new Container();
  listLayer.x = -CARD_W / 2 + 22;
  card.addChild(listLayer);

  listMask = new Graphics();
  card.addChild(listMask);
  listLayer.mask = listMask;

  scrollZone = new Container();
  scrollZone.eventMode = 'static';
  scrollZone.on('pointerdown', (e) => {
    dragY = e.global.y;
  });
  scrollZone.on('pointermove', (e) => {
    if (dragY == null) return;
    const scale = card.worldTransform.a || 1;
    scrollY -= (e.global.y - dragY) / scale;
    dragY = e.global.y;
    applyScroll();
  });
  const endDrag = (): void => {
    dragY = null;
  };
  scrollZone.on('pointerup', endDrag);
  scrollZone.on('pointerupoutside', endDrag);
  scrollZone.on('wheel', (e) => {
    scrollY += e.deltaY / 3;
    applyScroll();
  });
  card.addChild(scrollZone);

  statusText = makeText('', 15, 0xffe9a8, '700');
  statusText.visible = false;
  card.addChild(statusText);

  retryBtn = makeWoodBtn('THỬ LẠI', 180, 52, null, startLoad);
  retryBtn.visible = false;
  card.addChild(retryBtn);

  closeBtn = makeWoodBtn('ĐÓNG', 200, 60, null, hideHistoryPopup);
  card.addChild(closeBtn);

  box.addChild(card);
  box.visible = false;
  drawCard();
  return box;
}

export function layoutHistoryPopup(designH: number, insetTop: number, insetBottom: number): void {
  if (!box) return;
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const availH = designH - insetTop - insetBottom - 28;
  cardH = Math.max(320, Math.min(640, availH));
  drawCard();
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
  render();
}
