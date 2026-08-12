import { Container, Graphics, Rectangle, Sprite, type Text } from 'pixi.js';
import type { GameSession, MatchHistoryOutcome } from '../../../src/sdk';
import { A, tex } from '../../assets';
import { HEADING, makeText, pressable, tween } from '../../kit';
import { DESIGN_W } from '../../layout';
import { LEVEL_LABELS } from '../../logic/battle';
import { readBotHistory } from '../../logic/bot-history';

const PANEL_W = 456;
const PANEL_FILL_RATIO = 919 / 925;
const TABLE_W = PANEL_W * 0.868;
const TABLE_Y = PANEL_W * 0.04;
const TABLE_HEADER_BOTTOM = 100 / 1244;
const TABLE_BODY_BOTTOM = 1241 / 1244;
const TABLE_ROW_CENTERS = [157, 271, 384, 496.5, 608, 719, 830, 942, 1054.5, 1175.5].map(
  (value) => value / 1244,
);
const PAGE_SIZE = 10;
const ERROR_PAGE_SIZE = 8;
const MAX_ROWS = 100;
const LOAD_TIMEOUT = 8000;
const COLUMN_EDGES = [5 / 885, 229 / 885, 457 / 885, 664 / 885, 874 / 885] as const;

interface HistoryRow {
  playedAt: number;
  opponent: string;
  bet: number;
  outcome: MatchHistoryOutcome;
}

interface PagerControl {
  view: Container;
  label: Text;
  setEnabled(enabled: boolean): void;
}

const OUTCOME_LABEL: Record<MatchHistoryOutcome, string> = {
  win: 'THẮNG',
  lose: 'THUA',
  draw: 'HÒA',
};

let box: Container;
let dim: Graphics;
let card: Container;
let panelH = 0;
let tableTop = 0;
let tableH = 0;
let headerH = 0;
let rowH = 0;
let rowsLayer: Container;
let statusText: Text;
let retryBtn: Container;
let prevBtn: PagerControl;
let nextBtn: PagerControl;
let pageLabel: Text;
let page = 0;
let getSession: () => GameSession | null = () => null;
let pvpRows: HistoryRow[] | null = null;
let loadState: 'loading' | 'error' | 'done' = 'done';
let offHistory: (() => void) | null = null;
let loadTimer: number | undefined;
let loadGen = 0;

function fitText(text: Text, maxWidth: number): void {
  text.scale.set(1);
  if (text.width > maxWidth) text.scale.set(maxWidth / text.width);
}

function tableText(label: string, size: number, weight: '700' | '800' = '800'): Text {
  const text = makeText(label, size, 0x17120b, weight, HEADING);
  text.style.dropShadow = false;
  return text;
}

function ellipsizeText(text: Text, label: string, maxWidth: number): void {
  text.text = label;
  text.scale.set(1);
  if (text.width <= maxWidth) return;
  for (let end = label.length - 1; end >= 3; end--) {
    text.text = `${label.slice(0, end)}…`;
    if (text.width <= maxWidth) return;
  }
  fitText(text, maxWidth);
}

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

function columnX(index: number): number {
  return ((COLUMN_EDGES[index] + COLUMN_EDGES[index + 1]) / 2 - 0.5) * TABLE_W;
}

function columnW(index: number): number {
  return (COLUMN_EDGES[index + 1] - COLUMN_EDGES[index]) * TABLE_W;
}

function makeOutcomeBadge(outcome: MatchHistoryOutcome): Container {
  const badge = new Container();
  const width = columnW(3) * 0.8;
  const height = rowH * 0.55;
  if (outcome === 'draw') {
    const bg = new Graphics()
      .roundRect(-width / 2, -height / 2, width, height, height / 2)
      .fill({ color: 0x718798 })
      .stroke({ width: 1.5, color: 0xe7f0f5, alpha: 0.86 });
    badge.addChild(bg);
  } else {
    const bg = new Sprite(tex[outcome === 'win' ? A.history.outcomeWin : A.history.outcomeLose]);
    bg.anchor.set(0.5);
    bg.width = width;
    bg.scale.y = bg.scale.x;
    badge.addChild(bg);
  }
  const label = makeText(OUTCOME_LABEL[outcome], 13, 0xffffff, '800', HEADING);
  fitText(label, width * 0.78);
  badge.addChild(label);
  return badge;
}

function makeRow(row: HistoryRow, slot: number): Container {
  const view = new Container();
  view.y = tableTop + tableH * TABLE_ROW_CENTERS[slot];

  const time = tableText(formatTime(row.playedAt), 13);
  time.x = columnX(0);
  fitText(time, columnW(0) * 0.88);
  view.addChild(time);

  const opponent = tableText(row.opponent, 14);
  opponent.x = columnX(1);
  ellipsizeText(opponent, row.opponent, columnW(1) * 0.88);
  view.addChild(opponent);

  const bet = tableText(String(row.bet), 14);
  bet.x = columnX(2);
  fitText(bet, columnW(2) * 0.86);
  view.addChild(bet);

  const outcome = makeOutcomeBadge(row.outcome);
  outcome.x = columnX(3);
  view.addChild(outcome);
  return view;
}

function setPagerEnabled(control: PagerControl, enabled: boolean): void {
  control.setEnabled(enabled);
}

function render(): void {
  if (!rowsLayer) return;
  rowsLayer.removeChildren().forEach((child) => child.destroy({ children: true }));

  const rows = loadState === 'loading' ? [] : mergedRows();
  const partialError = loadState === 'error' && rows.length > 0;
  const pageSize = partialError ? ERROR_PAGE_SIZE : PAGE_SIZE;
  const pageCount = Math.max(1, Math.ceil(rows.length / pageSize));
  page = Math.max(0, Math.min(page, pageCount - 1));
  const offsetSlots = partialError ? PAGE_SIZE - ERROR_PAGE_SIZE : 0;
  rows
    .slice(page * pageSize, page * pageSize + pageSize)
    .forEach((row, index) => rowsLayer.addChild(makeRow(row, index + offsetSlots)));

  const bodyCenter = tableTop + (tableH * (TABLE_HEADER_BOTTOM + TABLE_BODY_BOTTOM)) / 2;
  statusText.visible = false;
  retryBtn.visible = false;
  if (loadState === 'loading') {
    statusText.text = 'Đang tải lịch sử...';
    statusText.y = bodyCenter;
    statusText.visible = true;
  } else if (loadState === 'error') {
    statusText.text = 'Không tải được lịch sử PvP';
    statusText.visible = true;
    retryBtn.visible = true;
    if (partialError) {
      statusText.y = tableTop + tableH * TABLE_ROW_CENTERS[0];
      retryBtn.y = tableTop + tableH * TABLE_ROW_CENTERS[1];
    } else {
      statusText.y = bodyCenter - 28;
      retryBtn.y = bodyCenter + 24;
    }
  } else if (rows.length === 0) {
    statusText.text = 'Chưa có trận nào';
    statusText.y = bodyCenter;
    statusText.visible = true;
  }

  pageLabel.text = `TRANG ${page + 1}`;
  fitText(pageLabel, PANEL_W * 0.17);
  setPagerEnabled(prevBtn, rows.length > 0 && page > 0);
  setPagerEnabled(nextBtn, rows.length > 0 && page < pageCount - 1);
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
  try {
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
  } catch {
    if (gen !== loadGen) return;
    cleanupLoad();
    loadState = 'error';
    render();
  }
}

export function openHistoryPopup(next: () => GameSession | null): void {
  getSession = next;
  page = 0;
  pvpRows = null;
  box.visible = true;
  dim.alpha = 0;
  void tween(dim, { alpha: 1 }, 200);
  card.alpha = 0;
  void tween(card, { alpha: 1 }, 200);
  startLoad();
}

export function hideHistoryPopup(): void {
  loadGen++;
  cleanupLoad();
  box.visible = false;
}

function makePageControl(
  asset: string,
  width: number,
  label: string,
  fontSize: number,
  onTap: () => void,
): PagerControl {
  const view = new Container();
  const bg = new Sprite(tex[asset]);
  bg.anchor.set(0.5);
  bg.width = width;
  bg.scale.y = bg.scale.x;
  view.addChild(bg);
  const text = makeText(label, fontSize, 0x17120b, '800', HEADING);
  text.y = -1;
  view.addChild(text);
  pressable(view, onTap);
  return {
    view,
    label: text,
    setEnabled(enabled): void {
      view.eventMode = enabled ? 'static' : 'none';
      view.cursor = enabled ? 'pointer' : 'default';
      view.alpha = enabled ? 1 : 0.42;
      view.scale.set(1);
    },
  };
}

function makeRetryButton(): Container {
  const button = new Container();
  const bg = new Sprite(tex[A.history.pageNumber]);
  bg.anchor.set(0.5);
  bg.width = 116;
  bg.scale.y = bg.scale.x;
  button.addChild(bg);
  const label = makeText('THỬ LẠI', 14, 0x17120b, '800', HEADING);
  button.addChild(label);
  pressable(button, startLoad);
  return button;
}

export function buildHistoryPopup(): Container {
  box = new Container();
  dim = new Graphics();
  dim.eventMode = 'static';
  dim.on('pointertap', hideHistoryPopup);
  box.addChild(dim);

  card = new Container();

  const panelFill = new Sprite(tex[A.history.panelFill]);
  panelFill.anchor.set(0.5);
  panelFill.width = PANEL_W * PANEL_FILL_RATIO;
  panelFill.scale.y = panelFill.scale.x;
  card.addChild(panelFill);

  const panelFrame = new Sprite(tex[A.history.panelFrame]);
  panelFrame.anchor.set(0.5);
  panelFrame.width = PANEL_W;
  panelFrame.scale.y = panelFrame.scale.x;
  panelFrame.eventMode = 'none';
  panelH = panelFrame.height;
  const halfH = panelH / 2;

  card.eventMode = 'static';
  card.hitArea = new Rectangle(-PANEL_W / 2, -halfH, PANEL_W, panelH);

  const table = new Sprite(tex[A.history.table]);
  table.anchor.set(0.5);
  table.width = TABLE_W;
  table.scale.y = table.scale.x;
  table.y = TABLE_Y;
  card.addChild(table);
  tableH = table.height;
  tableTop = table.y - tableH / 2;
  headerH = tableH * TABLE_HEADER_BOTTOM;
  rowH = (tableH * (TABLE_BODY_BOTTOM - TABLE_HEADER_BOTTOM)) / PAGE_SIZE;

  const headers = ['THỜI GIAN', 'ĐỐI THỦ', 'KEN CƯỢC', 'KẾT QUẢ'];
  headers.forEach((label, index) => {
    const text = tableText(label, 13);
    text.x = columnX(index);
    text.y = tableTop + headerH / 2;
    fitText(text, columnW(index) * 0.9);
    card.addChild(text);
  });

  rowsLayer = new Container();
  card.addChild(rowsLayer);

  statusText = makeText('', 16, 0x573511, '800', HEADING);
  statusText.style.dropShadow = false;
  statusText.style.wordWrap = true;
  statusText.style.wordWrapWidth = TABLE_W * 0.72;
  statusText.style.align = 'center';
  statusText.visible = false;
  card.addChild(statusText);

  retryBtn = makeRetryButton();
  retryBtn.visible = false;
  card.addChild(retryBtn);

  const pagerY = halfH - panelH * 0.057;
  prevBtn = makePageControl(A.history.pageArrow, 66, '<', 23, () => {
    if (page <= 0) return;
    page--;
    render();
  });
  prevBtn.view.x = -90;
  prevBtn.view.y = pagerY;
  card.addChild(prevBtn.view);

  const pageFrame = new Sprite(tex[A.history.pageNumber]);
  pageFrame.anchor.set(0.5);
  pageFrame.width = 106;
  pageFrame.scale.y = pageFrame.scale.x;
  pageFrame.y = pagerY;
  card.addChild(pageFrame);
  pageLabel = makeText('TRANG 1', 17, 0x17120b, '800', HEADING);
  pageLabel.y = pagerY - 1;
  card.addChild(pageLabel);

  nextBtn = makePageControl(A.history.pageArrow, 66, '>', 23, () => {
    page++;
    render();
  });
  nextBtn.view.x = 90;
  nextBtn.view.y = pagerY;
  card.addChild(nextBtn.view);

  card.addChild(panelFrame);

  const titleFrame = new Sprite(tex[A.history.titleFrame]);
  titleFrame.anchor.set(0.5);
  titleFrame.width = PANEL_W * 0.74;
  titleFrame.scale.y = titleFrame.scale.x;
  titleFrame.y = -halfH + panelH * 0.065;
  card.addChild(titleFrame);
  const title = makeText('LỊCH SỬ ĐẤU', 34, 0xffef9c, '800', HEADING);
  title.rotation = -0.02;
  title.y = titleFrame.y - 3;
  fitText(title, titleFrame.width * 0.7);
  card.addChild(title);

  const close = new Container();
  const closeBase = new Sprite(tex[A.history.closeBase]);
  closeBase.anchor.set(0.5);
  closeBase.width = PANEL_W * 0.128;
  closeBase.scale.y = closeBase.scale.x;
  close.addChild(closeBase);
  const closeX = new Sprite(tex[A.history.closeX]);
  closeX.anchor.set(0.5);
  closeX.width = PANEL_W * 0.065;
  closeX.scale.y = closeX.scale.x;
  close.addChild(closeX);
  close.x = PANEL_W / 2 - PANEL_W * 0.067;
  close.y = titleFrame.y;
  close.hitArea = new Rectangle(-36, -36, 72, 72);
  pressable(close, hideHistoryPopup);
  card.addChild(close);

  box.addChild(card);
  box.visible = false;
  render();
  return box;
}

export function layoutHistoryPopup(designH: number, insetTop: number, insetBottom: number): void {
  if (!box) return;
  dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const availW = DESIGN_W * 0.94;
  const availH = designH - insetTop - insetBottom - 24;
  const fitScale = Math.min(1, availW / PANEL_W, availH / panelH);
  card.scale.set(fitScale);
  card.x = DESIGN_W / 2;
  card.y = insetTop + (designH - insetTop - insetBottom) / 2;
}
