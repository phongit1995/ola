import {
  AnimatedSprite,
  Container,
  Graphics,
  Rectangle,
  Sprite,
  Texture,
  type Ticker,
} from 'pixi.js';
import { ARCADE_ATTENTION_REASON } from '@ola/shared/constants';
import { DESIGN_W } from '../../layout';
import {
  GAME_ERROR_CODE,
  bridge,
  type ErrorData,
  type MatchFoundData,
  type MatchOverData,
  type RoomStateData,
  type StateData,
  type UserInfoData,
} from '../../../src/sdk';
import {
  CELLS,
  GRID,
  applyGravity,
  areAdjacent,
  baseTileType,
  createBoard,
  findMatches,
  findValidMoves,
  computeExplosions,
  swapCells,
  type Board,
  type LightningArc,
  type TileType,
} from '../../logic/core';
import {
  ULT_COST,
  applyAuthoritativeEffects,
  applyTileEffects,
  botChooseMove,
  botShouldUlt,
  castUltimate,
  createFighter,
  decayArmor,
  type BotLevel,
  type EffectSummary,
  type Fighter,
} from '../../logic/battle';
import { recordBotMatch } from '../../logic/bot-history';
import {
  decodeBoard,
  decodeTile,
  type ServerMove,
  type ServerState,
  type Step,
} from '../../logic/server-types';
import { errorText } from '../../logic/error-text';
import { RecentMatchIds } from '../../logic/recent-match-ids';
import { pvp } from '../../pvp';
import { playSound } from '../../audio';
import { A, loadUltTexture, tex } from '../../assets';
import { HEADING, addTick, makeText, removeTick, sleep, tween } from '../../kit';
import {
  CONFIRM_CARD_H,
  CONFIRM_CARD_W,
  buildHud,
  hideConfirm,
  hud,
  showConfirm,
  showResult,
  setBattleMode,
  setFighterAvatar,
  setFighterBotAvatar,
  updateFighter,
} from './hud';
import {
  CHAT_W,
  buildChat,
  layoutChat,
  pushPvpChat,
  resetChat,
  setChatInputVisible,
  setChatPvp,
} from './chat';
import { betLabel, shortRoomCode } from '../lobby/rooms/util';
import {
  buildRoomPregame,
  hideRoomPregame,
  layoutRoomPregame,
  setRoomPregameView,
  showRoomPregame,
  type RoomPregameCallbacks,
  type RoomPregameView,
} from './pregame';
import { playLightningFx } from './fx/lightning';
import { playFireSwordFx, type FireSwordFxContext } from './fx/fire-sword';
import { buildVsIntro, type VsIntro } from './vs-intro';
import { buildBotVsIntroData, buildPvpVsIntroData } from './vs-intro-data';
import {
  ULTIMATE_CHAT_GAP,
  ULTIMATE_CONTROL_SIZE,
  buildUltimateControl,
  type UltimateControl,
} from './ultimate-control';
import { deriveUltimateControlState } from './ultimate-control-state';

const TURN_SECONDS = Number(new URLSearchParams(location.search).get('turnsec')) || 30;
const HINT_DELAY_MS = 10_000;
const FX_COLS = 6;
const FX_ROWS = 10;
const FX_FRAMES = 60;

export interface BattleDeps {
  getUserInfo(): UserInfoData | null;
  onGameStart(): void;
  onRequestLayout(): void;
  onExitToLobby(): void;
  onReplay(): void;
  onPvpError(text: string): void;
}

export interface BattleLayoutOpts {
  designH: number;
  insetTop: number;
  insetBottom: number;
  safeTop: number;
  safeBottom: number;
  rootX: number;
  scale: number;
}

let deps: BattleDeps;
let boardBox: Container;
let boardLayer: Container;
let fxLayer: Container;
let boardFrame: Sprite;
let cellLayer: Container;
let boardMask: Graphics;
let selector: Sprite;
let botSelectorA: Sprite;
let hintBox: Container;
let statusText: ReturnType<typeof makeText>;
let chatBox: Container;
let ultimateControl: UltimateControl;
let vsIntro: VsIntro;
let sprites: Array<Container | null> = new Array(CELLS).fill(null);
let tileSize = 0;
let fxFrames: Texture[] = [];
let pendingRefit = false;
let chatFocused = false;
let lastSafeTop = 0;
let lastSafeBottom = 0;

let board: Board = [];
let me: Fighter = createFighter();
let foe: Fighter = createFighter();
let myTurn = true;
let busy = false;
let over = false;
let turnNumber = 1;
let botModeExtraTurns: [number, number] = [0, 0];
let selected: number | null = null;
let turnDeadline = 0;
let hintDeadline = 0;
let inGame = false;
let botLevel: BotLevel = 'normal';
let mode: 'bot' | 'pvp' = 'bot';
let pvpMatchId = '';
let exitingPvpMatchId = '';
let pvpIdx = 0;
let myUserId = '';
let oppAwayUntil = 0;
let pausedTurnRemain = 0;
let selfDisconnected = false;
let roomPregame = false;
let flowEpoch = 0;
let pvpChain: Promise<unknown> = Promise.resolve();
const handledMatchOvers = new RecentMatchIds();

function changeBattleMode(next: 'bot' | 'pvp'): void {
  mode = next;
  setBattleMode(next);
}

const CHAT_ERROR_CODES = new Set<string>([
  GAME_ERROR_CODE.ChatRateLimited,
  GAME_ERROR_CODE.ChatTooLong,
  GAME_ERROR_CODE.InvalidChat,
]);

let turnAnnounce: Container;
let turnAnnounceLabel: ReturnType<typeof makeText>;
let flyLayer: Container;
let announceStep: ((ticker: Ticker) => void) | null = null;
let announceBaseX = DESIGN_W / 2;
let announceBaseY = 0;

function pos(i: number): { x: number; y: number } {
  return { x: (i % GRID) * tileSize, y: Math.floor(i / GRID) * tileSize };
}

function makeSelector(url: string): Sprite {
  const s = new Sprite(tex[url]);
  s.roundPixels = true;
  s.visible = false;
  return s;
}

function sizeSelector(s: Sprite): void {
  s.width = tileSize;
  s.height = tileSize;
}

function computeTileSize(): number {
  const scale0 = Math.min(window.innerWidth, DESIGN_W) / DESIGN_W;
  const designH0 = (window.innerHeight - lastSafeTop - lastSafeBottom) / scale0;
  const boardBudget = (designH0 - 164 - 68 - 30 - 6 - 10 - 96 - 10) / 1.1;
  return Math.max(24, Math.floor(Math.min(470, DESIGN_W - 50, boardBudget) / GRID));
}

function placeHint(): void {
  if (!hintBox) return;
  const boardW = tileSize * GRID;
  hintBox.x = Math.round(boardW / 2 - 180);
  hintBox.y = -Math.round(boardW * 0.05) - 16;
}

function rebuildBoardVisuals(): void {
  const boardW = tileSize * GRID;
  const frameOverhang = Math.round(boardW * 0.05);
  const frameSize = boardW + frameOverhang * 2;
  boardFrame.width = frameSize;
  boardFrame.height = frameSize;
  boardFrame.x = boardW / 2;
  boardFrame.y = boardW / 2;
  const cellInset = Math.max(1, Math.round(tileSize * 0.015));
  cellLayer.removeChildren().forEach((c) => c.destroy());
  for (let i = 0; i < CELLS; i++) {
    const cell = new Sprite(tex[A.board.cell]);
    const p = pos(i);
    cell.roundPixels = true;
    cell.width = tileSize - cellInset * 2;
    cell.height = tileSize - cellInset * 2;
    cell.x = p.x + cellInset;
    cell.y = p.y + cellInset;
    cellLayer.addChild(cell);
  }
  boardMask
    .clear()
    .roundRect(-tileSize * 0.05, -tileSize * 0.05, boardW + tileSize * 0.1, boardW + tileSize * 0.1, 8)
    .fill(0xffffff);
  sizeSelector(selector);
  sizeSelector(botSelectorA);
  setSelected(null);
  botSelectorA.visible = false;
  placeHint();
  rebuildSprites();
}

function endBusy(): void {
  busy = false;
  updateHud();
  if (pendingRefit) deps.onRequestLayout();
}

let hintPair: [number, number] | null = null;
let hintStep: ((ticker: Ticker) => void) | null = null;

function tileIconBaseScale(icon: Sprite): number {
  return (tileSize * 0.82) / Math.max(icon.texture.width, icon.texture.height);
}

function showHint(): void {
  if (hintPair) return;
  const moves = findValidMoves(board);
  if (moves.length === 0) return;
  hintPair = moves[Math.floor(Math.random() * moves.length)];
  const icons = hintPair
    .map((i) => sprites[i]?.children[0])
    .filter((c): c is Sprite => c instanceof Sprite);
  const bases = icons.map((s) => s.scale.x);
  let t = 0;
  hintStep = (ticker: Ticker) => {
    t += ticker.deltaMS;
    const k = 1 + Math.sin(t / 110) * 0.09;
    icons.forEach((icon, idx) => icon.scale.set(bases[idx] * k));
  };
  addTick(hintStep);
}

function clearHint(): void {
  if (!hintPair) return;
  const pair = hintPair;
  hintPair = null;
  if (hintStep) {
    removeTick(hintStep);
    hintStep = null;
  }
  pair.forEach((i) => {
    const icon = sprites[i]?.children[0];
    if (icon instanceof Sprite) icon.scale.set(tileIconBaseScale(icon));
  });
}

function makeTile(type: TileType, index: number): Container {
  const c = new Container();
  const icon = new Sprite(tex[A.items[type]]);
  icon.roundPixels = true;
  icon.anchor.set(0.5);
  icon.scale.set(tileIconBaseScale(icon));
  icon.x = tileSize / 2;
  icon.y = tileSize / 2;
  c.addChild(icon);
  const p = pos(index);
  c.x = p.x;
  c.y = p.y;
  c.eventMode = 'static';
  c.cursor = 'pointer';
  c.hitArea = new Rectangle(0, 0, tileSize, tileSize);
  c.on('pointertap', () => onTileTap(index));
  return c;
}

function rebuildSprites(): void {
  clearHint();
  sprites.forEach((s) => s?.destroy());
  sprites = new Array(CELLS).fill(null);
  if (roomPregame) return;
  for (let i = 0; i < CELLS; i++) {
    const sprite = makeTile(board[i], i);
    sprites[i] = sprite;
    boardLayer.addChild(sprite);
  }
}

function retargetTaps(): void {
  sprites.forEach((sprite, i) => {
    if (!sprite) return;
    sprite.removeAllListeners('pointertap');
    sprite.on('pointertap', () => onTileTap(i));
  });
}

function setSelected(i: number | null): void {
  selected = i;
  if (i == null) {
    selector.visible = false;
    return;
  }
  const p = pos(i);
  selector.position.set(p.x, p.y);
  selector.visible = true;
}

function setStatus(text: string): void {
  statusText.text = text;
}

function resetTurnClock(): void {
  const now = performance.now();
  turnDeadline = now + TURN_SECONDS * 1000;
  hintDeadline = now + HINT_DELAY_MS;
  clearHint();
}

function announce(text: string, color: number): void {
  if (!turnAnnounce) return;
  if (announceStep) {
    removeTick(announceStep);
    announceStep = null;
  }
  turnAnnounceLabel.text = text;
  turnAnnounceLabel.style.fill = color;
  turnAnnounce.alpha = 0;
  turnAnnounce.scale.set(0.7);
  turnAnnounce.position.set(announceBaseX, announceBaseY);
  turnAnnounce.visible = true;

  const IN = 160;
  const HOLD = 420;
  const RISE = 430;
  const END = IN + HOLD + RISE;
  let t = 0;
  announceStep = (ticker: Ticker): void => {
    t += ticker.deltaMS;
    if (t >= END) {
      turnAnnounce.visible = false;
      if (announceStep) removeTick(announceStep);
      announceStep = null;
      return;
    }
    let alpha: number;
    let scale: number;
    let dy: number;
    if (t < IN) {
      const k = t / IN;
      const e = 1 - (1 - k) * (1 - k);
      alpha = e;
      scale = 0.7 + 0.3 * e;
      dy = 0;
    } else if (t < IN + HOLD) {
      alpha = 1;
      scale = 1;
      dy = 0;
    } else {
      const k = (t - IN - HOLD) / RISE;
      const e = k * k;
      alpha = 1 - e;
      scale = 1;
      dy = -k * 120;
    }
    turnAnnounce.alpha = alpha;
    turnAnnounce.scale.set(scale);
    turnAnnounce.x = announceBaseX;
    turnAnnounce.y = announceBaseY + dy;
  };
  addTick(announceStep);
}

function announceTurn(side: 'me' | 'foe'): void {
  if (side === 'me') announce('ĐẾN LƯỢT BẠN', 0xffd75e);
  else announce(mode === 'pvp' ? 'ĐẾN LƯỢT ĐỐI THỦ' : 'ĐẾN LƯỢT MÁY', 0xff6b5e);
}

function announceExtraTurns(side: 'me' | 'foe', earned: number, remaining: number): void {
  const mine = side === 'me';
  const actor = mine ? 'BẠN' : mode === 'pvp' ? 'ĐỐI THỦ' : 'MÁY';
  const color = mine ? 0x7dff8a : 0xffa94d;
  let text = `${actor} CÒN ${remaining} LƯỢT!`;
  if (earned > 1) text = `${actor} +${earned} LƯỢT!`;
  else if (earned === 1) text = `${actor} THÊM LƯỢT!`;
  announce(text, color);
}

function spendBotModeExtraTurn(side: 'me' | 'foe'): void {
  const idx = side === 'me' ? 0 : 1;
  botModeExtraTurns[idx] = Math.max(0, botModeExtraTurns[idx] - 1);
}

function addBotModeExtraTurns(side: 'me' | 'foe', earned: number): number {
  const idx = side === 'me' ? 0 : 1;
  botModeExtraTurns[idx] += earned;
  return botModeExtraTurns[idx];
}

function cellRootPos(i: number): { x: number; y: number } {
  const p = pos(i);
  return { x: boardBox.x + p.x + tileSize / 2, y: boardBox.y + p.y + tileSize / 2 };
}

function flyMatched(cells: Set<number>, side: 'me' | 'foe'): Promise<void> {
  const defCard = side === 'me' ? hud.foe.card : hud.me.card;
  const swords: Array<{ index: number; type: 'sword' | 'fireSword' }> = [];
  cells.forEach((i) => {
    const type = board[i];
    if (type === 'sword' || type === 'fireSword') swords.push({ index: i, type });
  });
  if (swords.length === 0) return Promise.resolve();
  const jobs = swords.map((sword, idx) =>
    sleep(idx * 110).then(() => flySword(cellRootPos(sword.index), defCard, sword.type)),
  );
  return Promise.all(jobs).then(() => undefined);
}



async function explodeFx(
  matched: Iterable<number>,
  exploded: Iterable<number>,
  lightningArcs: LightningArc[],
): Promise<Set<number>> {
  const matchedCells = [...matched];
  const matchedSet = new Set(matchedCells);
  const removed = new Set([...matchedCells, ...exploded]);
  const fireSources = matchedCells.filter((index) => board[index] === 'fireSword');
  const jobs: Promise<unknown>[] = [];
  let fireFx = Promise.resolve();

  if (fireSources.length > 0) {
    fireFx = playFireSwordFx(fireSources, removed, fireSwordFxContext());
    jobs.push(fireFx);
  }

  const lightningContext = {
    tileSize,
    boardX: boardBox.x,
    boardY: boardBox.y,
    grid: GRID,
    flyLayer,
    cellRootPos,
    spriteAt: (index: number) => sprites[index],
    playSound: () => playSound('lightning'),
  };
  const directLightningArcs = lightningArcs.filter((arc) => matchedSet.has(arc.source));
  const fireTriggeredArcs = lightningArcs.filter((arc) => !matchedSet.has(arc.source));

  if (directLightningArcs.length > 0) {
    jobs.push(
      playLightningFx(directLightningArcs, lightningContext),
    );
  }

  if (fireTriggeredArcs.length > 0) {
    jobs.push(
      fireFx.then(() => playLightningFx(fireTriggeredArcs, lightningContext)),
    );
  }

  await Promise.all(jobs);
  return new Set(fireSources);
}

function fireSwordFxContext(): FireSwordFxContext {
  return {
    tileSize,
    boardX: boardBox.x,
    boardY: boardBox.y,
    grid: GRID,
    flyLayer,
    cellRootPos,
    spriteAt: (index) => sprites[index],
    playSound: () => playSound('explosion'),
  };
}

function spawnTrailDot(x: number, y: number): void {
  const g = new Graphics();
  const r = tileSize * 0.19;
  g.circle(0, 0, r).fill({ color: 0xff8a2a, alpha: 0.4 });
  g.circle(0, 0, r * 0.55).fill({ color: 0xffd75e, alpha: 0.8 });
  g.position.set(x, y);
  flyLayer.addChildAt(g, 0);
  void tween(g, { alpha: 0, scale: 0.2 }, 380).then(() => g.destroy());
}

function flySword(
  from: { x: number; y: number },
  card: Container,
  type: 'sword' | 'fireSword',
): Promise<void> {
  return new Promise((resolve) => {
    const icon = new Sprite(tex[A.items[type]]);
    icon.anchor.set(0.5);
    const scale0 = (tileSize * 0.68) / Math.max(icon.texture.width, icon.texture.height);
    icon.scale.set(scale0);
    icon.position.set(from.x, from.y);
    flyLayer.addChild(icon);

    const to = {
      x: card.x + 28 + Math.random() * 134,
      y: card.y + 30 + Math.random() * 84,
    };
    const mx = (from.x + to.x) / 2;
    const my = (from.y + to.y) / 2;
    const dx = to.x - from.x;
    const dy = to.y - from.y;
    const len = Math.hypot(dx, dy) || 1;
    const amp = len * (0.09 + Math.random() * 0.08) * (Math.random() < 0.5 ? -1 : 1);
    const cx = mx - (dy / len) * amp;
    const cy = my + (dx / len) * amp;
    const SWORD_BASE_ANGLE = (-3 * Math.PI) / 4;
    icon.rotation = Math.atan2(cy - from.y, cx - from.x) - SWORD_BASE_ANGLE;
    const DUR = 460;
    let t = 0;
    let trailAcc = 0;
    const step = (ticker: Ticker): void => {
      t += ticker.deltaMS;
      const k = Math.min(1, t / DUR);
      const e = k * k * (3 - 2 * k);
      const u = 1 - e;
      icon.x = u * u * from.x + 2 * u * e * cx + e * e * to.x;
      icon.y = u * u * from.y + 2 * u * e * cy + e * e * to.y;
      const tanX = u * (cx - from.x) + e * (to.x - cx);
      const tanY = u * (cy - from.y) + e * (to.y - cy);
      icon.rotation = Math.atan2(tanY, tanX) - SWORD_BASE_ANGLE;
      trailAcc += ticker.deltaMS;
      if (trailAcc >= 24 && k < 0.96) {
        trailAcc = 0;
        spawnTrailDot(icon.x, icon.y);
      }
      if (k >= 1) {
        removeTick(step);
        void tween(icon, { alpha: 0, scale: scale0 * 0.5 }, 130).then(() => {
          icon.destroy();
          resolve();
        });
      }
    };
    addTick(step);
  });
}

// Hàng đợi số nổi theo từng card: hiện tuần tự từng số một (xong cái này mới
// lên cái kế), ngay tại khu thanh thông tin của người chơi thay vì xếp chồng xa nhau.
const floatQueues = new Map<Container, Array<{ text: string; color: number }>>();
const floatBusy = new Set<Container>();

function floatNumber(card: Container, text: string, color: number): void {
  let q = floatQueues.get(card);
  if (!q) {
    q = [];
    floatQueues.set(card, q);
  }
  q.push({ text, color });
  if (!floatBusy.has(card)) void drainFloatQueue(card);
}

async function drainFloatQueue(card: Container): Promise<void> {
  floatBusy.add(card);
  const q = floatQueues.get(card)!;
  while (q.length > 0) {
    const next = q.shift()!;
    await showFloatOnce(card, next.text, next.color);
  }
  floatBusy.delete(card);
}

function showFloatOnce(card: Container, text: string, color: number): Promise<void> {
  return new Promise((resolve) => {
    const t = makeText(text, 16, color, '800');
    t.anchor.set(0.5);
    t.style.stroke = { color: 0x120d02, width: 4, join: 'round' };
    t.x = card.x + 95;
    t.y = card.y + 34;
    flyLayer.addChild(t);
    void (async () => {
      await tween(t, { y: t.y - 16, scale: 1.14 }, 220);
      await tween(t, { y: t.y - 30, alpha: 0 }, 240);
      t.destroy();
      resolve();
    })();
  });
}

function renderTurnClock(): void {
  if (!inGame) return;
  const left =
    pausedTurnRemain > 0 ? pausedTurnRemain : Math.max(0, turnDeadline - performance.now());
  // Deadline server có cộng thêm buffer animation nên có thể vượt 30s —
  // hiển thị kẹp về TURN_SECONDS, còn deadline thật vẫn dùng cho timeout.
  const total = Math.min(Math.ceil(left / 1000), TURN_SECONDS);
  hud.timer.text = String(total);
  if (mode === 'pvp' && !over && selfDisconnected) {
    setStatus('Mất kết nối, đang kết nối lại...');
    return;
  }
  if (mode === 'pvp' && !over && oppAwayUntil > 0) {
    const secs = Math.max(0, Math.ceil((oppAwayUntil - performance.now()) / 1000));
    setStatus(`Đối thủ mất kết nối, chờ ${secs}s...`);
    return;
  }
  if (!over && myTurn && !busy && !hud.confirm.visible) {
    if (left <= 0) {
      if (mode === 'pvp') {
        setStatus('Hết giờ...');
        return;
      }
      setStatus('Hết giờ — mất lượt!');
      void startBotTurn();
      return;
    }
    if (mode === 'bot' && performance.now() >= hintDeadline) showHint();
  }
}

function updateHud(): void {
  const meActive = myTurn && !over;
  const foeActive = !myTurn && !over;
  // Màu đồng hồ theo người đang giữ lượt: vàng = bạn, xanh nhạt = đối thủ
  // (đỏ bị chìm trên nền cờ đỏ nên phía đối thủ dùng xanh).
  hud.timer.style.fill = meActive ? 0xffd75e : 0x8fd3ff;
  updateFighter(hud.me, me, meActive, me.mp >= ULT_COST);
  updateFighter(hud.foe, foe, foeActive, foe.mp >= ULT_COST);

  const canUlt = meActive && !busy && me.mp >= ULT_COST;
  hud.me.ultBtn.eventMode = canUlt ? 'static' : 'none';
  hud.me.ultBtn.alpha = canUlt || !meActive ? 1 : 0.85;
  ultimateControl?.update(
    deriveUltimateControlState({
      mana: me.mp,
      cost: ULT_COST,
      inGame,
      roomPregame,
      over,
      myTurn,
      busy,
      disconnected: selfDisconnected,
    }),
  );

  hud.restart.setEnabled(mode === 'bot' && !busy);
  hud.forfeit.setEnabled(!over && !busy);
  hud.exit.setEnabled(!busy);
}

function buildFxFrames(sheet: Texture): Texture[] {
  const fw = sheet.width / FX_COLS;
  const fh = sheet.height / FX_ROWS;
  const frames: Texture[] = [];
  for (let i = 0; i < FX_FRAMES; i++) {
    const col = i % FX_COLS;
    const row = Math.floor(i / FX_COLS);
    frames.push(
      new Texture({
        source: sheet.source,
        frame: new Rectangle(col * fw, row * fh, fw, fh),
      }),
    );
  }
  return frames;
}

function preloadUltFx(): void {
  if (fxFrames.length > 0) return;
  void loadUltTexture()
    .then((sheet) => {
      if (fxFrames.length === 0) fxFrames = buildFxFrames(sheet);
    })
    .catch(() => {});
}

async function playUltFx(side: 'me' | 'foe'): Promise<void> {
  if (fxFrames.length === 0) {
    try {
      fxFrames = buildFxFrames(await loadUltTexture());
    } catch {
      await sleep(350);
      return;
    }
  }
  playSound('ultimate');
  const fx = new AnimatedSprite(fxFrames);
  fx.loop = false;
  fx.animationSpeed = 0.5;
  fx.anchor.set(0.5);
  const boardW = tileSize * GRID;
  fx.width = boardW;
  fx.height = boardW / 2;
  fx.x = boardW / 2;
  fx.y = boardW / 2;
  if (side === 'me') fx.scale.x = -Math.abs(fx.scale.x);
  fxLayer.addChild(fx);
  await new Promise<void>((resolve) => {
    fx.onComplete = () => resolve();
    fx.play();
  });
  fx.destroy();
}

async function showBotPick(a: number): Promise<void> {
  const pa = pos(a);
  botSelectorA.position.set(pa.x, pa.y);
  botSelectorA.visible = true;
  await sleep(500);
}

async function dropInBoard(): Promise<void> {
  const jobs: Promise<void>[] = [];
  for (let i = 0; i < CELLS; i++) {
    const sprite = sprites[i];
    if (!sprite) continue;
    const target = pos(i);
    const col = i % GRID;
    const row = Math.floor(i / GRID);
    sprite.y = target.y - (GRID + 2) * tileSize;
    const delay = col * 35 + (GRID - 1 - row) * 50;
    jobs.push(
      sleep(delay)
        .then(() => tween(sprite, { y: target.y + tileSize * 0.07 }, 300))
        .then(() => tween(sprite, { y: target.y }, 90)),
    );
  }
  await Promise.all(jobs);
}

async function animateSwap(a: number, b: number): Promise<void> {
  const sa = sprites[a]!;
  const sb = sprites[b]!;
  const pa = pos(a);
  const pb = pos(b);
  await Promise.all([tween(sa, pb, 180), tween(sb, pa, 180)]);
  sprites[a] = sb;
  sprites[b] = sa;
  retargetTaps();
}

function centerPivot(sprite: Container): void {
  sprite.pivot.set(tileSize / 2, tileSize / 2);
  sprite.position.set(sprite.x + tileSize / 2, sprite.y + tileSize / 2);
}

async function animateSwordEat(sprite: Container, order: number, count: number): Promise<void> {
  centerPivot(sprite);
  const flash = new Graphics()
    .roundRect(0, 0, tileSize, tileSize, tileSize * 0.2)
    .fill({ color: 0xffffff, alpha: 0.85 });
  sprite.addChild(flash);

  const boardW = tileSize * GRID;
  const spread = (order - (count - 1) / 2) * tileSize * 0.3;
  const dest = { x: boardW / 2 + spread, y: -tileSize * 1.5 };

  await tween(sprite, { scale: 1.4 }, 120);
  void tween(flash, { alpha: 0 }, 140);
  await tween(sprite, { x: dest.x, y: dest.y, alpha: 0, scale: 0.5 }, 280);
}

async function animateRemove(
  cells: Set<number>,
  explodedFireSources: ReadonlySet<number> = new Set(),
): Promise<void> {
  const jobs: Promise<void>[] = [];
  const swords: number[] = [];
  cells.forEach((i) => {
    if (baseTileType(board[i]) === 'sword') swords.push(i);
  });
  cells.forEach((i) => {
    const sprite = sprites[i];
    if (!sprite) return;
    if (explodedFireSources.has(i)) return;
    if (baseTileType(board[i]) === 'sword') {
      jobs.push(animateSwordEat(sprite, swords.indexOf(i), swords.length));
      return;
    }
    centerPivot(sprite);
    jobs.push(tween(sprite, { alpha: 0, scale: 0.2 }, 180));
  });
  await Promise.all(jobs);
  cells.forEach((i) => {
    sprites[i]?.destroy({ children: true });
    sprites[i] = null;
  });
}

interface WaveRenderOptions {
  side: 'me' | 'foe';
  actorLabel: string;
  matched: Iterable<number>;
  removed: Set<number>;
  exploded: readonly number[];
  lightningArcs: LightningArc[];
  result: EffectSummary;
}

async function renderWaveEffects(options: WaveRenderOptions): Promise<void> {
  const { side, actorLabel, matched, removed, exploded, lightningArcs, result } = options;
  playSound('match');
  const parts: string[] = [];
  if (result.damage > 0) parts.push(`-${result.damage} HP`);
  if ((result.armorDamage ?? 0) > 0) parts.push(`-${result.armorDamage} giáp`);
  if (result.heal > 0) parts.push(`+${result.heal} HP`);
  if (result.mana > 0) parts.push(`+${result.mana} MP`);
  if (result.armor > 0) parts.push(`+${result.armor} giáp`);
  if (parts.length > 0) setStatus(`${actorLabel}: ${parts.join('  ')}`);

  const explodedFireSources =
    exploded.length > 0
      ? await explodeFx(matched, exploded, lightningArcs)
      : new Set<number>();
  await Promise.all([animateRemove(removed, explodedFireSources), flyMatched(removed, side)]);
  updateHud();

  const atkCard = side === 'me' ? hud.me.card : hud.foe.card;
  const defCard = side === 'me' ? hud.foe.card : hud.me.card;
  if (result.damage > 0) floatNumber(defCard, `-${result.damage} HP`, 0xff6b5e);
  if ((result.armorDamage ?? 0) > 0) {
    floatNumber(defCard, `-${result.armorDamage} giáp`, 0x8fdcff);
  }
  if (result.furied) floatNumber(defCard, 'NỘ ×2!', 0xff5aa0);
  if (result.heal > 0) floatNumber(atkCard, `+${result.heal} HP`, 0x7dff8a);
  if (result.mana > 0) floatNumber(atkCard, `+${result.mana} MP`, 0x6ec1ff);
  if ((result.fury ?? 0) > 0) floatNumber(atkCard, `+${result.fury} NỘ`, 0xff9ecb);
  if ((result.reflect ?? 0) > 0) floatNumber(atkCard, `-${result.reflect} phản`, 0xffb36e);
  if (result.armor > 0) floatNumber(atkCard, `+${result.armor} giáp`, 0x9fd0ff);
}

async function animateGravity(
  falls: Array<{ from: number; to: number }>,
  spawns: Array<{ index: number; type: TileType; fromRow: number }>,
): Promise<void> {
  const jobs: Promise<void>[] = [];
  for (const fall of falls) {
    const sprite = sprites[fall.from];
    if (!sprite) continue;
    sprites[fall.to] = sprite;
    sprites[fall.from] = null;
    jobs.push(tween(sprite, pos(fall.to), 260));
  }
  for (const spawn of spawns) {
    const sprite = makeTile(spawn.type, spawn.index);
    const target = pos(spawn.index);
    sprite.x = target.x;
    sprite.y = spawn.fromRow * tileSize;
    sprites[spawn.index] = sprite;
    boardLayer.addChild(sprite);
    jobs.push(tween(sprite, { y: target.y }, 300));
  }
  await Promise.all(jobs);
  retargetTaps();
}

async function ensurePlayable(): Promise<void> {
  if (findValidMoves(board).length > 0) return;
  setStatus('Hết nước đi — đảo bàn!');
  await sleep(400);
  board = createBoard();
  rebuildSprites();
}

async function resolveCascades(side: 'me' | 'foe'): Promise<number> {
  const attacker = side === 'me' ? me : foe;
  const defender = side === 'me' ? foe : me;
  let bonusTurns = 0;

  for (;;) {
    const match = findMatches(board);
    if (!match) break;
    bonusTurns += match.bonusTurns;

    const explosionPlan = computeExplosions(board, match.cells);
    const { exploded, lightningArcs } = explosionPlan;
    for (const i of exploded) match.counts[board[i]]++;
    const removed = new Set<number>(match.cells);
    for (const i of exploded) removed.add(i);

    const result = applyTileEffects(attacker, defender, match.counts);
    await renderWaveEffects({
      side,
      actorLabel: side === 'me' ? 'Bạn' : 'Máy',
      matched: match.cells,
      removed,
      exploded,
      lightningArcs,
      result,
    });

    const gravity = applyGravity(board, removed);
    await animateGravity(gravity.falls, gravity.spawns);

    if (defender.hp <= 0 || attacker.hp <= 0) return bonusTurns;
  }

  await ensurePlayable();
  return bonusTurns;
}

function finish(won: boolean, reason: 'win' | 'forfeit', sub: string): void {
  over = true;
  endBusy();
  clearHint();
  updateHud();
  if (mode === 'bot') recordBotMatch({ level: botLevel, won, forfeit: reason === 'forfeit' });
  showResult({ outcome: won ? 'win' : 'lose', detail: sub });
  setChatInputVisible(false);
  playSound(won ? 'win' : 'lose');
  bridge.gameOver({ matchId: `wargod-${Date.now()}`, winnerId: won ? 'you' : 'bot', reason, won });
}

function checkEnd(): boolean {
  if (foe.hp <= 0) {
    finish(true, 'win', 'Bạn đã hạ gục Máy 🤖');
    return true;
  }
  if (me.hp <= 0) {
    finish(false, 'win', 'Máy 🤖 đã hạ gục bạn');
    return true;
  }
  return false;
}

async function onTileTap(i: number): Promise<void> {
  if (!myTurn || busy || over) return;
  if (selected === null) {
    setSelected(i);
    return;
  }
  if (selected === i) {
    setSelected(null);
    return;
  }
  if (!areAdjacent(selected, i)) {
    setSelected(i);
    return;
  }

  const a = selected;
  const b = i;
  setSelected(null);
  busy = true;
  clearHint();
  updateHud();

  swapCells(board, a, b);
  const valid = findMatches(board) != null;
  swapCells(board, a, b);
  if (!valid) {
    await animateSwap(a, b);
    await animateSwap(a, b);
    setStatus('Không tạo được combo');
    endBusy();
    return;
  }

  if (mode === 'pvp') {
    setStatus('Đang gửi nước đi...');
    pvp.sendSwap(a, b);
    return;
  }

  swapCells(board, a, b);
  await animateSwap(a, b);
  spendBotModeExtraTurn('me');
  decayArmor(me);
  const earnedExtraTurns = await resolveCascades('me');
  const remainingExtraTurns = addBotModeExtraTurns('me', earnedExtraTurns);
  if (checkEnd()) return;

  if (remainingExtraTurns > 0) {
    announceExtraTurns('me', earnedExtraTurns, remainingExtraTurns);
    setStatus(
      earnedExtraTurns > 0
        ? `Combo lớn — +${earnedExtraTurns} lượt · còn ${remainingExtraTurns}!`
        : `Bạn còn ${remainingExtraTurns} lượt thưởng!`,
    );
    endBusy();
    resetTurnClock();
    updateHud();
    return;
  }
  void startBotTurn();
}

async function castMyUltimate(): Promise<void> {
  if (!myTurn || busy || over || me.mp < ULT_COST) return;
  busy = true;
  setSelected(null);
  clearHint();
  updateHud();
  if (mode === 'pvp') {
    setStatus('Đang gửi tuyệt chiêu...');
    pvp.sendUlt();
    return;
  }
  spendBotModeExtraTurn('me');
  decayArmor(me);
  const ultDmg = castUltimate(me, foe);
  setStatus(`TUYỆT CHIÊU! -${ultDmg} HP`);
  updateHud();
  await playUltFx('me');
  if (checkEnd()) return;
  if (botModeExtraTurns[0] > 0) {
    announceExtraTurns('me', 0, botModeExtraTurns[0]);
    setStatus(`Bạn còn ${botModeExtraTurns[0]} lượt thưởng!`);
    endBusy();
    resetTurnClock();
    return;
  }
  void startBotTurn();
}

async function startBotTurn(): Promise<void> {
  const ep = flowEpoch;
  const stale = (): boolean => over || flowEpoch !== ep || mode !== 'bot';
  botModeExtraTurns[0] = 0;
  myTurn = false;
  busy = true;
  setSelected(null);
  resetTurnClock();
  updateHud();
  announceTurn('foe');
  setStatus('Máy đang nghĩ...');

  for (;;) {
    await sleep(700);
    if (stale()) return;

    if (botShouldUlt(foe, me, botLevel)) {
      spendBotModeExtraTurn('foe');
      decayArmor(foe);
      const ultDmg = castUltimate(foe, me);
      setStatus(`Máy tung TUYỆT CHIÊU! -${ultDmg} HP`);
      updateHud();
      await playUltFx('foe');
      if (stale()) return;
      if (checkEnd()) return;
      if (botModeExtraTurns[1] > 0) {
        announceExtraTurns('foe', 0, botModeExtraTurns[1]);
        setStatus(`Máy còn ${botModeExtraTurns[1]} lượt thưởng!`);
        continue;
      }
      break;
    }

    const move = botChooseMove(board, foe, me, botLevel);
    if (!move) {
      await ensurePlayable();
      if (stale()) return;
      continue;
    }
    await showBotPick(move[0]);
    if (stale()) return;
    spendBotModeExtraTurn('foe');
    swapCells(board, move[0], move[1]);
    await Promise.all([
      tween(botSelectorA, pos(move[1]), 180),
      animateSwap(move[0], move[1]),
    ]);
    await sleep(160);
    if (stale()) return;
    botSelectorA.visible = false;
    decayArmor(foe);
    const earnedExtraTurns = await resolveCascades('foe');
    const remainingExtraTurns = addBotModeExtraTurns('foe', earnedExtraTurns);
    if (stale()) return;
    if (checkEnd()) return;
    if (remainingExtraTurns === 0) break;
    announceExtraTurns('foe', earnedExtraTurns, remainingExtraTurns);
    setStatus(
      earnedExtraTurns > 0
        ? `Máy nhận +${earnedExtraTurns} lượt · còn ${remainingExtraTurns}!`
        : `Máy còn ${remainingExtraTurns} lượt thưởng!`,
    );
  }

  if (stale()) return;
  botModeExtraTurns[1] = 0;
  myTurn = true;
  endBusy();
  turnNumber++;
  resetTurnClock();
  announceTurn('me');
  setStatus('Lượt của bạn — ghép 3 ô để tấn công!');
  updateHud();
}

function clearRoomPregameVisuals(): void {
  if (!roomPregame) return;
  roomPregame = false;
  hideRoomPregame();
  hud.banner.visible = true;
  hud.bottomRow.visible = true;
  hintBox.visible = true;
}

export function isRoomPregameActive(): boolean {
  return roomPregame;
}

export function enterRoomPregame(callbacks: RoomPregameCallbacks): void {
  deps.onGameStart();
  preloadUltFx();
  flowEpoch++;
  vsIntro.cancel();
  changeBattleMode('pvp');
  inGame = false;
  over = false;
  busy = false;
  myTurn = false;
  pvpMatchId = '';
  oppAwayUntil = 0;
  pausedTurnRemain = 0;
  selfDisconnected = false;
  botModeExtraTurns = [0, 0];
  clearHint();
  setSelected(null);
  botSelectorA.visible = false;
  hud.result.hide();
  hideConfirm();
  roomPregame = true;
  rebuildSprites();
  me = createFighter();
  foe = createFighter();
  hud.me.name.text = `@${deps.getUserInfo()?.username ?? 'bạn'}`;
  hud.foe.name.text = 'Đang chờ...';
  setFighterAvatar(hud.me, deps.getUserInfo()?.vipType);
  setFighterAvatar(hud.foe, null);
  updateHud();
  hud.banner.visible = false;
  hud.bottomRow.visible = false;
  hintBox.visible = false;
  setChatPvp(true);
  resetChat();
  setChatInputVisible(false);
  showRoomPregame(callbacks);
  deps.onRequestLayout();
}

export function updateRoomPregame(
  state: RoomStateData | null,
  info: { roomId: string; bet: number; locked: boolean } | null,
): void {
  if (!roomPregame) return;
  const roomId = state?.roomId ?? info?.roomId ?? '';
  const bet = state?.bet ?? info?.bet ?? 0;
  const locked = state?.locked ?? info?.locked ?? false;
  const meMember = state ? (state.members.find((m) => m.id === state.youId) ?? null) : null;
  const foeMember = state ? (state.members.find((m) => m.id !== state.youId) ?? null) : null;
  const meOwner = state ? state.youId === state.ownerId : true;
  if (meMember) hud.me.name.text = `@${meMember.name}`;
  hud.foe.name.text = foeMember ? `@${foeMember.name}` : 'Đang chờ...';
  if (meMember) setFighterAvatar(hud.me, meMember.vipType);
  setFighterAvatar(hud.foe, foeMember?.vipType ?? null);
  let status: string;
  let main: RoomPregameView['main'] = null;
  if (!state) {
    status = 'Đang tải thông tin bàn...';
  } else if (!foeMember) {
    status = 'Đang chờ đối thủ vào bàn...';
  } else if (meOwner) {
    const guestReady = foeMember.ready === true;
    status = guestReady ? 'Cả hai đã sẵn sàng — bấm BẮT ĐẦU!' : 'Đang chờ đối thủ sẵn sàng...';
    main = { label: 'BẮT ĐẦU', action: 'start', enabled: guestReady };
  } else {
    const meReady = meMember?.ready === true;
    status = meReady ? 'Đang chờ chủ bàn bắt đầu...' : 'Đối thủ đã vào bàn — hãy bấm SẴN SÀNG';
    main = { label: meReady ? 'HỦY SẴN SÀNG' : 'SẴN SÀNG', action: 'toggle', enabled: true };
  }
  setRoomPregameView({
    betText: betLabel(bet),
    roomLine: roomId ? `Bàn #${shortRoomCode(roomId)}${locked ? ' 🔒' : ''}` : '',
    status,
    main,
    kickVisible: meOwner && foeMember != null,
  });
}

export function exitRoomPregame(): void {
  if (!roomPregame) return;
  clearRoomPregameVisuals();
  deps.onExitToLobby();
}

export function startBattle(level: BotLevel = botLevel): void {
  clearRoomPregameVisuals();
  deps.onGameStart();
  preloadUltFx();
  flowEpoch++;
  const ep = flowEpoch;
  vsIntro.cancel();
  changeBattleMode('bot');
  pvpMatchId = '';
  oppAwayUntil = 0;
  pausedTurnRemain = 0;
  selfDisconnected = false;
  botLevel = level;
  inGame = true;
  me = createFighter();
  foe = createFighter();
  botModeExtraTurns = [0, 0];
  board = createBoard();
  myTurn = true;
  busy = true;
  over = false;
  turnNumber = 1;
  setSelected(null);
  botSelectorA.visible = false;
  rebuildSprites();
  hud.result.hide();
  hideConfirm();
  const userInfo = deps.getUserInfo();
  if (userInfo) hud.me.name.text = `@${userInfo.username}`;
  hud.foe.name.text = '@Bot';
  setFighterAvatar(hud.me, userInfo?.vipType);
  setFighterBotAvatar(hud.foe, botLevel);
  setChatPvp(false);
  setChatInputVisible(false);
  resetChat('Chào! Chơi vui nhé 😄');
  setStatus('Chuẩn bị chiến đấu...');
  updateHud();
  const intro = vsIntro.play(buildBotVsIntroData(userInfo, botLevel));
  void Promise.all([dropInBoard(), intro]).then(() => {
    if (flowEpoch !== ep) return;
    endBusy();
    resetTurnClock();
    announceTurn('me');
    setStatus('Lượt của bạn — ghép 3 ô để tấn công!');
    setChatInputVisible(true);
    updateHud();
  });
}

function syncFighters(state: ServerState): void {
  const meF = state.fighters[pvpIdx];
  const foeF = state.fighters[1 - pvpIdx];
  if (meF) me = { hp: meF.hp, mp: meF.mp, armor: meF.armor, fury: meF.fury };
  if (foeF) foe = { hp: foeF.hp, mp: foeF.mp, armor: foeF.armor, fury: foeF.fury };
}

export function startPvpBattle(data: MatchFoundData<ServerState>): Promise<void> | void {
  clearRoomPregameVisuals();
  deps.onGameStart();
  preloadUltFx();
  flowEpoch++;
  const ep = flowEpoch;
  vsIntro.cancel();
  changeBattleMode('pvp');
  botModeExtraTurns = [0, 0];
  inGame = true;
  over = false;
  busy = true;
  pvpMatchId = data.matchId;
  pvpIdx = data.you;
  oppAwayUntil = 0;
  pausedTurnRemain = 0;
  selfDisconnected = false;
  clearHint();
  const state = data.state;
  syncFighters(state);
  board = decodeBoard(state.board);
  myTurn = data.turn === pvpIdx;
  turnNumber = state.moveCount + 1;
  setSelected(null);
  botSelectorA.visible = false;
  rebuildSprites();
  hud.result.hide();
  hideConfirm();
  const mePlayer = data.players[pvpIdx];
  const opponent = data.players[1 - pvpIdx];
  myUserId = mePlayer?.id ?? '';
  hud.me.name.text = `@${mePlayer?.name ?? deps.getUserInfo()?.username ?? 'bạn'}`;
  hud.foe.name.text = `@${opponent?.name ?? 'đối thủ'}`;
  setFighterAvatar(hud.me, mePlayer?.vipType ?? deps.getUserInfo()?.vipType);
  setFighterAvatar(hud.foe, opponent?.vipType);
  setChatPvp(true);
  if (!data.resumed) resetChat();
  setChatInputVisible(data.resumed === true);
  turnDeadline = performance.now() + (data.deadline - Date.now());
  updateHud();
  if (data.resumed) {
    endBusy();
    setStatus('Đã vào lại trận đấu');
    announceTurn(myTurn ? 'me' : 'foe');
    updateHud();
    bridge.turnChanged({ yourTurn: myTurn, deadline: data.deadline });
    return;
  }
  bridge.attention({ reason: ARCADE_ATTENTION_REASON.MatchStarted, matchId: data.matchId });
  setStatus('Chuẩn bị chiến đấu...');
  const intro = vsIntro.play(buildPvpVsIntroData(data, deps.getUserInfo()));
  return Promise.all([dropInBoard(), intro]).then(() => {
    if (flowEpoch !== ep) return;
    endBusy();
    announceTurn(myTurn ? 'me' : 'foe');
    setStatus(myTurn ? 'Lượt của bạn — ghép 3 ô để tấn công!' : 'Đợi đối thủ...');
    setChatInputVisible(true);
    updateHud();
    bridge.turnChanged({ yourTurn: myTurn, deadline: data.deadline });
  });
}

async function replayStep(step: Step, side: 'me' | 'foe'): Promise<void> {
  if (step.kind === 'swap') {
    if (side === 'foe') {
      await showBotPick(step.a);
      swapCells(board, step.a, step.b);
      await Promise.all([tween(botSelectorA, pos(step.b), 180), animateSwap(step.a, step.b)]);
      await sleep(160);
      botSelectorA.visible = false;
      return;
    }
    swapCells(board, step.a, step.b);
    await animateSwap(step.a, step.b);
    return;
  }
  if (step.kind === 'match') {
    const attacker = side === 'me' ? me : foe;
    const defender = side === 'me' ? foe : me;
    const cells = new Set(step.cells);
    for (const i of step.exploded ?? []) cells.add(i);
    const result = applyAuthoritativeEffects(attacker, defender, step.effects);
    await renderWaveEffects({
      side,
      actorLabel: side === 'me' ? 'Bạn' : 'Đối thủ',
      matched: step.cells,
      removed: cells,
      exploded: step.exploded ?? [],
      lightningArcs: step.lightningArcs ?? [],
      result,
    });
    return;
  }
  if (step.kind === 'gravity') {
    const falls = step.falls ?? [];
    for (const fall of falls) board[fall.to] = board[fall.from];
    const spawns = (step.spawns ?? []).map((spawn) => ({
      index: spawn.index,
      type: decodeTile(spawn.type),
      fromRow: spawn.fromRow,
    }));
    for (const spawn of spawns) board[spawn.index] = spawn.type;
    await animateGravity(falls, spawns);
    return;
  }
  if (step.kind === 'shuffle') {
    setStatus('Hết nước đi — đảo bàn!');
    await sleep(400);
    board = decodeBoard(step.board);
    rebuildSprites();
    return;
  }
  const attacker = side === 'me' ? me : foe;
  const defender = side === 'me' ? foe : me;
  attacker.mp = 0;
  defender.hp = Math.max(0, defender.hp - step.damage);
  setStatus(
    side === 'me'
      ? `TUYỆT CHIÊU! -${step.damage} HP`
      : `Đối thủ tung TUYỆT CHIÊU! -${step.damage} HP`,
  );
  updateHud();
  await playUltFx(side);
}

async function handlePvpState(data: StateData<ServerState, ServerMove>): Promise<void> {
  if (mode !== 'pvp' || !inGame || over || data.matchId !== pvpMatchId) return;
  busy = true;
  selfDisconnected = false;
  updateHud();
  const ep = flowEpoch;
  clearHint();
  setSelected(null);
  const state = data.state;
  const earnedExtraTurns = (state.steps ?? []).reduce(
    (total, step) => total + (step.kind === 'match' ? (step.bonusTurns ?? 0) : 0),
    0,
  );
  const remainingExtraTurns = state.extraTurns ?? (state.extraTurn ? 1 : 0);
  const side: 'me' | 'foe' = data.lastBy === pvpIdx ? 'me' : 'foe';
  let replayFailed = false;
  if (data.lastMove) {
    decayArmor(side === 'me' ? me : foe);
    updateHud();
    try {
      for (const step of state.steps) {
        if (over || flowEpoch !== ep || data.matchId !== pvpMatchId) return;
        await replayStep(step, side);
      }
    } catch {
      replayFailed = true;
    }
  }
  if (flowEpoch !== ep || data.matchId !== pvpMatchId) return;
  const authBoard = decodeBoard(state.board);
  const changed = authBoard.some((type, idx) => type !== board[idx]);
  board = authBoard;
  syncFighters(state);
  if (changed || replayFailed) rebuildSprites();
  if (over) return;
  myTurn = data.turn === pvpIdx;
  turnDeadline = performance.now() + (data.deadline - Date.now());
  pausedTurnRemain = 0;
  turnNumber = state.moveCount + 1;
  updateHud();
  if (!data.lastMove) {
    setStatus(data.lastBy === pvpIdx ? 'Hết giờ — bạn mất lượt!' : 'Đối thủ hết giờ — mất lượt!');
  } else if (data.turn === data.lastBy) {
    if (myTurn) {
      announceExtraTurns('me', earnedExtraTurns, remainingExtraTurns);
      setStatus(
        earnedExtraTurns > 0
          ? `Combo lớn — +${earnedExtraTurns} lượt · còn ${remainingExtraTurns}!`
          : `Bạn còn ${remainingExtraTurns} lượt thưởng!`,
      );
    } else {
      announceExtraTurns('foe', earnedExtraTurns, remainingExtraTurns);
      setStatus(
        earnedExtraTurns > 0
          ? `Đối thủ nhận +${earnedExtraTurns} lượt · còn ${remainingExtraTurns}!`
          : `Đối thủ còn ${remainingExtraTurns} lượt thưởng!`,
      );
    }
  } else {
    announceTurn(myTurn ? 'me' : 'foe');
    setStatus(myTurn ? 'Lượt của bạn — ghép 3 ô để tấn công!' : 'Đợi đối thủ...');
  }
  bridge.turnChanged({ yourTurn: myTurn, deadline: data.deadline });
  endBusy();
}

function matchOverSub(reason: MatchOverData['reason'], won: boolean, draw: boolean): string {
  if (draw) return 'Hai bên bất phân thắng bại';
  if (reason === 'forfeit') return won ? 'Đối thủ đã bỏ cuộc' : 'Bạn đã bỏ cuộc';
  if (reason === 'timeout') return 'Hết giờ 3 lần liên tiếp';
  if (reason === 'disconnect') return won ? 'Đối thủ mất kết nối' : 'Bạn đã mất kết nối';
  return won ? 'Bạn đã hạ gục đối thủ' : 'Đối thủ đã hạ gục bạn';
}

function formatKenDelta(delta: number): string {
  if (delta === 0) return '0 KEN';
  const sign = delta > 0 ? '+' : '-';
  return `${sign}${Math.abs(delta).toLocaleString('vi-VN')} KEN`;
}

async function handlePvpMatchOver(data: MatchOverData<ServerState>): Promise<void> {
  const exiting = data.matchId === exitingPvpMatchId;
  if (mode !== 'pvp' || (!exiting && data.matchId !== pvpMatchId)) return;
  if (!handledMatchOvers.mark(data.matchId)) return;
  const draw = data.winnerId == null || data.winnerId === '';
  const won = !draw && data.winnerId === myUserId;
  if (exiting) {
    exitingPvpMatchId = '';
    bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
    return;
  }
  over = true;
  busy = true;
  const ep = flowEpoch;
  updateHud();
  clearHint();
  oppAwayUntil = 0;
  pausedTurnRemain = 0;
  selfDisconnected = false;
  if (data.reason === 'win' && !draw && inGame && data.state.steps?.length) {
    const side: 'me' | 'foe' = won ? 'me' : 'foe';
    try {
      for (const step of data.state.steps) {
        if (flowEpoch !== ep) break;
        await replayStep(step, side);
      }
    } catch {
      botSelectorA.visible = false;
    }
  }
  if (flowEpoch !== ep) {
    bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
    return;
  }
  botSelectorA.visible = false;
  setSelected(null);
  board = decodeBoard(data.state.board);
  syncFighters(data.state);
  rebuildSprites();
  updateHud();
  const bet = data.bet ?? pvp.bet();
  const winnerNet = data.kenDelta ?? bet;
  const kenDelta = won ? winnerNet : -bet;
  showResult({
    outcome: draw ? 'draw' : won ? 'win' : 'lose',
    detail: matchOverSub(data.reason, won, draw),
    kenText: draw ? undefined : formatKenDelta(kenDelta),
  });
  setStatus(draw ? 'Ván đấu hòa!' : won ? 'Bạn thắng!' : 'Bạn thua!');
  setChatInputVisible(false);
  playSound(draw ? 'click' : won ? 'win' : 'lose');
  endBusy();
  bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
}

function queuePvp(fn: () => Promise<void> | void): void {
  pvpChain = pvpChain.then(fn).catch(() => undefined);
}

function bindPvpHandlers(): void {
  pvp.on({
    onMatchFound: (data) => queuePvp(() => startPvpBattle(data)),
    onState: (data) => queuePvp(() => handlePvpState(data)),
    onMatchOver: (data) => queuePvp(() => handlePvpMatchOver(data)),
    onChat: (data) => {
      if (mode !== 'pvp' || data.matchId !== pvpMatchId) return;
      const mine = data.userId === myUserId;
      pushPvpChat(`@${data.name}`, mine, data.text);
      if (!mine) {
        bridge.attention({ reason: ARCADE_ATTENTION_REASON.NewChat, matchId: data.matchId });
      }
    },
    onOpponentDisconnected: (data) => {
      if (mode !== 'pvp' || !inGame || over) return;
      oppAwayUntil = performance.now() + (data.graceDeadline - Date.now());
      if (data.turnRemainingMs != null && data.turnRemainingMs > 0) {
        pausedTurnRemain = data.turnRemainingMs;
      } else if (!myTurn) {
        // Compatibility with servers that predate turnRemainingMs.
        pausedTurnRemain = Math.max(0, turnDeadline - performance.now());
      }
      bridge.attention({
        reason: ARCADE_ATTENTION_REASON.OpponentDisconnected,
        matchId: pvpMatchId,
      });
    },
    onOpponentReconnected: () => {
      if (mode !== 'pvp' || !inGame || over) return;
      oppAwayUntil = 0;
      if (pausedTurnRemain > 0) {
        turnDeadline = performance.now() + pausedTurnRemain;
        pausedTurnRemain = 0;
      }
      setStatus('Đối thủ đã quay lại');
    },
    onError: (err: ErrorData) => {
      const text = errorText(err.code);
      if (mode === 'pvp' && inGame && !over) {
        if (!CHAT_ERROR_CODES.has(err.code)) endBusy();
        setStatus(text);
        return;
      }
      deps.onPvpError(text);
    },
    onConnectionChange: (connected) => {
      if (mode !== 'pvp' || !inGame || over) return;
      selfDisconnected = !connected;
      updateHud();
      if (connected) return;
      if (myTurn && pausedTurnRemain === 0) {
        pausedTurnRemain = Math.max(1000, turnDeadline - performance.now());
      }
      setStatus('Mất kết nối, đang kết nối lại...');
    },
  });
}

function teardownBattle(): void {
  clearRoomPregameVisuals();
  flowEpoch++;
  vsIntro.cancel();
  over = true;
  inGame = false;
  busy = false;
  botModeExtraTurns = [0, 0];
  oppAwayUntil = 0;
  pausedTurnRemain = 0;
  selfDisconnected = false;
  clearHint();
  setSelected(null);
  botSelectorA.visible = false;
  hud.result.hide();
  hideConfirm();
  setChatInputVisible(false);
  ultimateControl.reset();
}

function exitToLobby(): void {
  teardownBattle();
  deps.onExitToLobby();
}

function exitActiveMatch(): void {
  if (!inGame || over) {
    exitToLobby();
    return;
  }
  if (mode === 'pvp') {
    exitingPvpMatchId = pvpMatchId;
    pvp.leaveMatch();
    pvpMatchId = '';
  } else {
    recordBotMatch({ level: botLevel, won: false, forfeit: true });
    bridge.gameOver({
      matchId: `wargod-${Date.now()}`,
      winnerId: 'bot',
      reason: 'forfeit',
      won: false,
    });
  }
  exitToLobby();
}

function replayMatch(): void {
  if (mode === 'pvp') {
    teardownBattle();
    deps.onReplay();
    return;
  }
  startBattle();
}

export function battleChatFocused(): boolean {
  return chatFocused;
}

export function markBattleRefit(): void {
  pendingRefit = true;
}

function previewLightningFx(sourceCount = 3): boolean {
  if (!inGame || tileSize <= 0) return false;
  const requestedSources = Math.max(1, Math.floor(sourceCount));
  const sources = board
    .map((type, index) => ({ type, index }))
    .filter(({ type }) => type === 'lightning')
    .map(({ index }) => index)
    .slice(0, requestedSources);
  if (sources.length === 0) return false;
  const preferredTargets = [0, GRID - 1, CELLS - GRID, CELLS - 1];
  const targets = preferredTargets.filter((target) => !sources.includes(target));
  for (let i = 0; targets.length < sources.length && i < CELLS; i++) {
    if (!sources.includes(i) && !targets.includes(i)) targets.push(i);
  }
  const arcs = targets.slice(0, sources.length).map((target, order) => ({
    source: sources[order % sources.length],
    target,
  }));
  void explodeFx(sources, targets, arcs);
  return true;
}

function previewFireSwordFx(mode: 'center' | 'corner' | 'multi' = 'center'): boolean {
  if (!inGame || tileSize <= 0) return false;
  const center = Math.floor(GRID / 2) * GRID + Math.floor(GRID / 2);
  const sources =
    mode === 'corner'
      ? [0]
      : mode === 'multi'
        ? [center - GRID - 1, center]
        : [center];
  const removed = new Set<number>();
  sources.forEach((source) => {
    const sourceX = source % GRID;
    const sourceY = Math.floor(source / GRID);
    for (let dy = -1; dy <= 1; dy++) {
      for (let dx = -1; dx <= 1; dx++) {
        const x = sourceX + dx;
        const y = sourceY + dy;
        if (x >= 0 && x < GRID && y >= 0 && y < GRID) removed.add(y * GRID + x);
      }
    }
  });
  void playFireSwordFx(sources, removed, fireSwordFxContext(), true);
  return true;
}

function previewVsIntro(
  opponentName = 'đối thủ',
  selfName = 'phong',
  opponentVipType = '2',
  selfVipType = '135',
): boolean {
  void vsIntro.play({
    left: { name: opponentName, vipType: opponentVipType },
    right: { name: selfName, vipType: selfVipType },
  });
  return true;
}

export function battleDebug(): Record<string, unknown> {
  return {
    mode,
    matchId: pvpMatchId,
    myTurn,
    busy,
    over,
    inGame,
    botLevel,
    actions: {
      rowVisible: hud.bottomRow?.visible === true,
      restartVisible: hud.restart?.view.visible === true,
      restartEnabled: hud.restart?.isEnabled() === true,
      restartX: hud.restart?.view.x,
      forfeitX: hud.forfeit?.view.x,
      exitX: hud.exit?.view.x,
    },
    ultimate: ultimateControl?.getState(),
    turn: turnNumber,
    extraTurns: mode === 'bot' ? [...botModeExtraTurns] : undefined,
    status: statusText.text,
    hint: hintPair,
    announce: turnAnnounce?.visible ? turnAnnounceLabel.text : null,
    botPick: !!botSelectorA?.visible,
    selected,
    selectorVisible: !!selector?.visible,
    flying: flyLayer ? flyLayer.children.filter((c) => c instanceof Sprite).length : 0,
    vsIntroVisible: vsIntro?.isVisible() === true,
    previewLightning: previewLightningFx,
    previewFireSword: previewFireSwordFx,
    previewVsIntro,
  };
}

export function buildBattleScreen(root: Container, battleDeps: BattleDeps): void {
  deps = battleDeps;
  tileSize = computeTileSize();

  boardBox = new Container();
  boardFrame = new Sprite(tex[A.board.frame]);
  boardFrame.roundPixels = true;
  boardFrame.anchor.set(0.5);
  boardBox.addChild(boardFrame);

  cellLayer = new Container();
  boardBox.addChild(cellLayer);

  selector = makeSelector(A.board.selMine);
  botSelectorA = makeSelector(A.board.selFoe);
  const selectorLayer = new Container();
  selectorLayer.addChild(selector, botSelectorA);
  boardBox.addChild(selectorLayer);

  boardLayer = new Container();
  boardBox.addChild(boardLayer);

  boardMask = new Graphics();
  boardBox.addChild(boardMask);
  boardLayer.mask = boardMask;

  fxLayer = new Container();
  boardBox.addChild(fxLayer);

  hintBox = new Container();
  const hintBg = new Sprite(tex[A.hud.noteStrip]);
  hintBg.width = 360;
  hintBg.height = 30;
  hintBox.addChild(hintBg);
  statusText = makeText('Ghép 3 ô trở lên để tấn công đối thủ!', 11, 0xf6c445, '800');
  statusText.x = 180;
  statusText.y = 15;
  hintBox.addChild(statusText);
  boardBox.addChild(hintBox);

  root.addChild(boardBox);
  buildRoomPregame(root);

  buildHud(root, {
    onUlt: () => void castMyUltimate(),
    onResultClose: exitToLobby,
    onResultReplay: replayMatch,
    onRestart: () => {
      if (mode === 'pvp') return;
      if (busy) return;
      if (over) {
        startBattle();
        return;
      }
      showConfirm({
        kind: 'restart',
        message: 'Ván hiện tại sẽ kết thúc.\nBạn muốn chơi lại từ đầu?',
        confirmLabel: 'CHƠI LẠI',
        onConfirm: () => {
          if (!busy) startBattle();
        },
      });
    },
    onForfeit: () => {
      if (over) return;
      if (mode === 'pvp') {
        showConfirm({
          kind: 'forfeit',
          message: 'Bạn sẽ bị xử thua ván này.\nBạn vẫn có thể chơi ván tiếp theo.',
          confirmLabel: 'BỎ CUỘC',
          onConfirm: () => {
            if (!busy && !over) pvp.forfeit();
          },
        });
        return;
      }
      if (busy) return;
      showConfirm({
        kind: 'forfeit',
        message: 'Bạn sẽ bị xử thua ván này.\nBạn vẫn có thể chơi ván tiếp theo.',
        confirmLabel: 'BỎ CUỘC',
        onConfirm: () => {
          if (!busy && !over) finish(false, 'forfeit', 'Bạn đã bỏ cuộc');
        },
      });
    },
    onExit: () => {
      if (busy) return;
      if (over || !inGame) {
        exitToLobby();
        return;
      }
      showConfirm({
        kind: 'exit',
        message: 'Thoát sẽ bị xử thua và rời bàn.\nBạn có chắc muốn thoát?',
        confirmLabel: 'RỜI TRẬN',
        onConfirm: () => {
          if (!busy) exitActiveMatch();
        },
      });
    },
  });
  bindPvpHandlers();

  ultimateControl = buildUltimateControl(() => void castMyUltimate());
  root.addChild(ultimateControl.view);

  chatBox = buildChat({
    isOver: () => over,
    onFocusChange: (focused) => {
      chatFocused = focused;
      if (!focused && pendingRefit) {
        pendingRefit = false;
        deps.onRequestLayout();
      }
    },
  });
  root.addChild(chatBox);

  flyLayer = new Container();
  root.addChild(flyLayer);

  turnAnnounce = new Container();
  turnAnnounceLabel = makeText('', 30, 0xffd75e, '800', HEADING);
  turnAnnounceLabel.style.stroke = { color: 0x120d02, width: 6, join: 'round' };
  turnAnnounceLabel.style.dropShadow = {
    distance: 3,
    blur: 5,
    alpha: 0.7,
    color: 0x000000,
    angle: Math.PI / 2,
  };
  turnAnnounce.addChild(turnAnnounceLabel);
  turnAnnounce.visible = false;
  root.addChild(turnAnnounce);

  vsIntro = buildVsIntro();
  root.addChild(vsIntro.view);

  root.addChild(hud.result.view, hud.confirm);
  hud.result.hide();

  board = createBoard();
  rebuildBoardVisuals();

  setInterval(renderTurnClock, 250);
  resetTurnClock();
  updateHud();
}

export function layoutBattleScreen(opts: BattleLayoutOpts): void {
  const { designH, insetTop, insetBottom } = opts;
  lastSafeTop = opts.safeTop;
  lastSafeBottom = opts.safeBottom;

  hud.foe.card.x = 8;
  hud.foe.card.y = 8 + insetTop;
  hud.me.card.x = DESIGN_W - 8 - 190;
  hud.me.card.y = 8 + insetTop;
  hud.banner.x = (DESIGN_W - 92) / 2;
  hud.banner.y = 4 + insetTop;

  const bottomH = 46;
  hud.bottomRow.y = Math.round(designH - bottomH - 12 - insetBottom);
  hud.bottomRow.x = (DESIGN_W - 444) / 2;

  const want = computeTileSize();
  if (want !== tileSize) {
    if (busy) {
      pendingRefit = true;
    } else {
      pendingRefit = false;
      tileSize = want;
      rebuildBoardVisuals();
    }
  }

  const boardW = tileSize * GRID;
  const overhang = Math.round(boardW * 0.05);
  const topStart = 164 + insetTop;
  const bottomLimit = hud.bottomRow.y - 10;
  const HINT_SPACE = 20;
  const GAP_BOARD_CHAT = 10;

  let chatH = 150;
  const blockH = (): number =>
    HINT_SPACE + overhang + boardW + overhang + GAP_BOARD_CHAT + chatH;
  let slack = bottomLimit - topStart - blockH();
  if (slack < 0) {
    chatH = Math.max(96, chatH + slack);
    slack = bottomLimit - topStart - blockH();
  }

  const blockTop = topStart + Math.max(0, Math.round(slack / 2));
  boardBox.x = Math.round((DESIGN_W - boardW) / 2);
  boardBox.y = blockTop + HINT_SPACE + overhang;
  announceBaseX = DESIGN_W / 2;
  announceBaseY = boardBox.y + boardW / 2;
  if (turnAnnounce && !announceStep) {
    turnAnnounce.x = announceBaseX;
    turnAnnounce.y = announceBaseY;
  }
  const chatY = boardBox.y + boardW + overhang + GAP_BOARD_CHAT;
  const chatGroupW = CHAT_W + ULTIMATE_CHAT_GAP + ULTIMATE_CONTROL_SIZE;
  const chatGroupX = Math.round((DESIGN_W - chatGroupW) / 2);
  layoutChat(chatGroupX, chatY, chatH, opts.rootX, opts.scale);
  ultimateControl.layout(
    chatGroupX + CHAT_W + ULTIMATE_CHAT_GAP,
    chatY + chatH - ULTIMATE_CONTROL_SIZE,
  );
  layoutRoomPregame({
    boardX: boardBox.x,
    boardY: boardBox.y,
    boardW,
    rowY: hud.bottomRow.y,
    badgeMinY: hud.me.card.y + hud.me.card.height + 4,
    cardGapW: hud.me.card.x - (hud.foe.card.x + hud.foe.card.width) - 12,
  });

  hud.result.layout(designH, insetTop, insetBottom);
  vsIntro.layout(designH, insetTop, insetBottom);

  hud.confirmDim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.6 });
  const confirmCard = hud.confirm.getChildByLabel('confirm-card')!;
  confirmCard.x = (DESIGN_W - CONFIRM_CARD_W) / 2;
  confirmCard.y = insetTop + (designH - insetTop - insetBottom - CONFIRM_CARD_H) / 2;
}
