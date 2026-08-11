import { Container, Graphics, Rectangle, Sprite, type Text } from 'pixi.js';
import type {
  GameSession,
  LeaderboardData,
  LeaderboardEntry,
  LeaderboardPeriod,
} from '../../../src/sdk';
import { A, tex } from '../../assets';
import { HEADING, makeText, popIn, pressable, tween } from '../../kit';
import { DESIGN_W } from '../../layout';
import { bindDragScroll } from './drag-scroll';
import { makeWoodBtn } from './ui';

const PANEL_W = 400;
const TAB_W = 150;
const LIST_W = 340;
const ROW_H = 36;
const LOAD_TIMEOUT = 8000;
const MEDALS = ['🥇', '🥈', '🥉'];
const ERR_TEXT = 'Không tải được BXH';
const EMPTY_TEXT = 'Chưa có ai lên bảng — thắng trận cược để ghi danh!';

let box: Container;
let dim: Graphics;
let card: Container;
let panelH = 0;
let tabDayBg: Sprite;
let tabWeekBg: Sprite;
let tabDayLabel: Text;
let tabWeekLabel: Text;
let listLayer: Container;
let stateText: Text;
let retryBtn: Container;
let listTop = 0;
let listH = 0;
let contentH = 0;
let scrollY = 0;
let getSession: () => GameSession | null = () => null;
let wiredSession: GameSession | null = null;
let off: (() => void) | null = null;
let period: LeaderboardPeriod = 'day';
let cache: Partial<Record<LeaderboardPeriod, LeaderboardEntry[]>> = {};
let loadTimer: number | undefined;
let openGen = 0;

function clearLoadTimer(): void {
  if (loadTimer !== undefined) {
    window.clearTimeout(loadTimer);
    loadTimer = undefined;
  }
}

function applyScroll(): void {
  const maxScroll = Math.max(0, contentH - listH);
  scrollY = Math.max(0, Math.min(maxScroll, scrollY));
  listLayer.y = listTop - scrollY;
}

function clearList(): void {
  listLayer.removeChildren().forEach((c) => c.destroy({ children: true }));
  contentH = 0;
  scrollY = 0;
  applyScroll();
}

function showState(message: string, canRetry: boolean): void {
  clearList();
  stateText.text = message;
  stateText.visible = true;
  retryBtn.visible = canRetry;
}

function renderRows(items: LeaderboardEntry[]): void {
  if (!items.length) {
    showState(EMPTY_TEXT, false);
    return;
  }
  clearList();
  stateText.visible = false;
  retryBtn.visible = false;
  items.forEach((entry, idx) => {
    const row = new Container();
    row.y = idx * ROW_H;
    if (idx % 2 === 0) {
      const strip = new Graphics()
        .roundRect(-LIST_W / 2 + 4, 2, LIST_W - 8, ROW_H - 4, 8)
        .fill({ color: 0xffffff, alpha: 0.07 });
      row.addChild(strip);
    }
    const midY = ROW_H / 2;
    const topRank = entry.rank >= 1 && entry.rank <= 3;
    const rank = makeText(
      topRank ? MEDALS[entry.rank - 1] : String(entry.rank),
      topRank ? 19 : 15,
      0xffffff,
      '800',
      HEADING,
    );
    rank.x = -LIST_W / 2 + 26;
    rank.y = midY;
    row.addChild(rank);
    const ken = makeText(entry.ken.toLocaleString('vi-VN'), 15, 0xffd84d, '800');
    ken.anchor.set(1, 0.5);
    ken.x = LIST_W / 2 - 12;
    ken.y = midY;
    row.addChild(ken);
    const name = makeText(`@${entry.username}`, 15, 0xffffff, '700');
    name.anchor.set(0, 0.5);
    name.x = -LIST_W / 2 + 50;
    name.y = midY;
    const nameMax = ken.x - ken.width - 12 - name.x;
    if (name.width > nameMax) name.scale.set(nameMax / name.width);
    row.addChild(name);
    listLayer.addChild(row);
  });
  contentH = items.length * ROW_H;
  scrollY = 0;
  applyScroll();
}

function requestPeriod(p: LeaderboardPeriod): void {
  clearLoadTimer();
  const session = getSession();
  if (!session) {
    showState(ERR_TEXT, true);
    return;
  }
  if (session !== wiredSession) {
    off?.();
    off = session.onLeaderboard(handleLeaderboard);
    wiredSession = session;
  }
  showState('Đang tải bảng xếp hạng...', false);
  session.getLeaderboard(p);
  const gen = openGen;
  loadTimer = window.setTimeout(() => {
    loadTimer = undefined;
    if (gen !== openGen || !box.visible || period !== p || cache[p]) return;
    showState(ERR_TEXT, true);
  }, LOAD_TIMEOUT);
}

function showPeriod(p: LeaderboardPeriod): void {
  const items = cache[p];
  if (items) {
    renderRows(items);
    return;
  }
  requestPeriod(p);
}

function refreshPeriod(): void {
  delete cache[period];
  requestPeriod(period);
}

function updateTabs(): void {
  const dayActive = period === 'day';
  tabDayBg.tint = dayActive ? 0xffffff : 0x8a8a8a;
  tabDayLabel.alpha = dayActive ? 1 : 0.75;
  tabWeekBg.tint = dayActive ? 0x8a8a8a : 0xffffff;
  tabWeekLabel.alpha = dayActive ? 0.75 : 1;
}

function setPeriod(p: LeaderboardPeriod): void {
  if (period === p) return;
  period = p;
  updateTabs();
  showPeriod(p);
}

function handleLeaderboard(data: LeaderboardData): void {
  if (!box.visible) return;
  if (data.error) {
    if (data.period === period) {
      clearLoadTimer();
      showState(ERR_TEXT, true);
    }
    return;
  }
  cache[data.period] = data.items;
  if (data.period === period) {
    clearLoadTimer();
    renderRows(data.items);
  }
}

function closeLeaderboardPopup(): void {
  openGen++;
  clearLoadTimer();
  off?.();
  off = null;
  wiredSession = null;
  cache = {};
  box.visible = false;
}

export function hideLeaderboardPopup(): void {
  if (box?.visible) closeLeaderboardPopup();
}

export function openLeaderboardPopup(nextGetSession: () => GameSession | null): void {
  openGen++;
  clearLoadTimer();
  off?.();
  off = null;
  wiredSession = null;
  getSession = nextGetSession;
  cache = {};
  period = 'day';
  updateTabs();
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  popIn(card, 0, 380);
  requestPeriod('day');
}

function makeTab(
  label: string,
  onTap: () => void,
): { tab: Container; bg: Sprite; text: Text } {
  const tab = new Container();
  const bg = new Sprite(tex[A.pick.levelMid]);
  bg.anchor.set(0.5);
  bg.width = TAB_W;
  bg.scale.y = bg.scale.x;
  tab.addChild(bg);
  const text = makeText(label, 17, 0xffffff, '800', HEADING);
  tab.addChild(text);
  pressable(tab, onTap);
  return { tab, bg, text };
}

export function buildLeaderboardPopup(): Container {
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', closeLeaderboardPopup);
  box.addChild(dim);

  card = new Container();

  const panel = new Sprite(tex[A.pick.panel]);
  panel.anchor.set(0.5);
  panel.width = PANEL_W;
  panel.scale.y = panel.scale.x;
  panel.eventMode = 'static';
  card.addChild(panel);
  panelH = panel.height;
  const halfH = panelH / 2;

  const banner = new Sprite(tex[A.pick.title]);
  banner.anchor.set(0.5);
  banner.width = PANEL_W * 0.72;
  banner.scale.y = banner.scale.x;
  banner.y = -halfH + banner.height / 2 + panelH * 0.03;
  card.addChild(banner);
  const bannerLabel = makeText('BẢNG XẾP HẠNG', Math.round(PANEL_W * 0.058), 0xffe36b, '800', HEADING);
  const bannerMax = banner.width * 0.64;
  if (bannerLabel.width > bannerMax) bannerLabel.scale.set(bannerMax / bannerLabel.width);
  bannerLabel.y = banner.y - banner.height * 0.04;
  card.addChild(bannerLabel);

  const close = new Container();
  const closeBase = new Sprite(tex[A.pick.closeBase]);
  closeBase.anchor.set(0.5);
  closeBase.width = PANEL_W * 0.145;
  closeBase.scale.y = closeBase.scale.x;
  close.addChild(closeBase);
  const closeX = new Sprite(tex[A.pick.closeX]);
  closeX.anchor.set(0.5);
  closeX.width = PANEL_W * 0.07;
  closeX.scale.y = closeX.scale.x;
  close.addChild(closeX);
  close.x = PANEL_W / 2 - PANEL_W * 0.078;
  close.y = -halfH + PANEL_W * 0.082;
  pressable(close, closeLeaderboardPopup);
  card.addChild(close);

  const dayTab = makeTab('TOP NGÀY', () => setPeriod('day'));
  const weekTab = makeTab('TOP TUẦN', () => setPeriod('week'));
  tabDayBg = dayTab.bg;
  tabDayLabel = dayTab.text;
  tabWeekBg = weekTab.bg;
  tabWeekLabel = weekTab.text;
  const tabH = dayTab.bg.height;
  const tabY = banner.y + banner.height / 2 + 16 + tabH / 2;
  dayTab.tab.x = -(TAB_W / 2 + 8);
  dayTab.tab.y = tabY;
  weekTab.tab.x = TAB_W / 2 + 8;
  weekTab.tab.y = tabY;
  card.addChild(dayTab.tab, weekTab.tab);
  updateTabs();

  listTop = tabY + tabH / 2 + 12;
  const noteY = halfH - 106;
  listH = noteY - 20 - listTop;

  const listBg = new Graphics()
    .roundRect(-LIST_W / 2 - 8, listTop - 8, LIST_W + 16, listH + 16, 14)
    .fill({ color: 0x241503, alpha: 0.42 });
  card.addChild(listBg);

  listLayer = new Container();
  card.addChild(listLayer);

  const listMask = new Graphics().rect(-LIST_W / 2, listTop, LIST_W, listH).fill(0xffffff);
  card.addChild(listMask);
  listLayer.mask = listMask;

  const scrollZone = new Container();
  scrollZone.eventMode = 'static';
  scrollZone.hitArea = new Rectangle(-LIST_W / 2, listTop, LIST_W, listH);
  bindDragScroll(scrollZone, {
    scale: () => card.worldTransform.a,
    offset: () => scrollY,
    setOffset: (value) => {
      scrollY = value;
    },
    apply: applyScroll,
  });
  card.addChild(scrollZone);

  const listCenter = listTop + listH / 2;
  stateText = makeText('', 16, 0xffffff, '700');
  stateText.style.wordWrap = true;
  stateText.style.wordWrapWidth = LIST_W - 36;
  stateText.style.align = 'center';
  stateText.y = listCenter - 26;
  stateText.visible = false;
  card.addChild(stateText);

  retryBtn = makeWoodBtn('THỬ LẠI', 170, 54, null, refreshPeriod);
  retryBtn.y = listCenter + 32;
  retryBtn.visible = false;
  card.addChild(retryBtn);

  const note = makeText('Chỉ tính các trận có cược', 13, 0x6b4310, '700');
  note.y = noteY;
  card.addChild(note);

  const refresh = makeWoodBtn('LÀM MỚI', 165, 56, null, refreshPeriod);
  refresh.x = -88;
  refresh.y = halfH - 58;
  card.addChild(refresh);

  const closeBtn = makeWoodBtn('ĐÓNG', 165, 56, null, closeLeaderboardPopup);
  closeBtn.x = 88;
  closeBtn.y = halfH - 58;
  card.addChild(closeBtn);

  box.addChild(card);
  box.visible = false;
  return box;
}

export function layoutLeaderboardPopup(designH: number, insetTop: number, insetBottom: number): void {
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const availW = DESIGN_W * 0.94;
  const availH = designH - insetTop - insetBottom - 24;
  const fitScale = Math.min(1, availW / PANEL_W, availH / panelH);
  card.scale.set(fitScale);
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
}
