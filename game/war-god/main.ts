import {
  AnimatedSprite,
  Application,
  Container,
  Graphics,
  Rectangle,
  Sprite,
  Texture,
  type Ticker,
} from 'pixi.js';
import { bridge } from '../src/sdk';
import {
  CELLS,
  GRID,
  applyGravity,
  areAdjacent,
  createBoard,
  findMatches,
  findValidMoves,
  swapCells,
  type Board,
  type TileType,
} from './core';
import {
  ULT_COST,
  ULT_DMG,
  applyTileEffects,
  botChooseMove,
  castUltimate,
  createFighter,
  type Fighter,
} from './battle';
import { A, loadAssets, tex } from './assets';
import { initKit, makeText, sleep, tween, addTick, removeTick } from './kit';
import { buildHud, hud, showConfirm, showOverlay, updateFighter } from './hud';
import { CHAT_W, buildChat, layoutChat, resetChat, setChatInputVisible } from './chat';

const DESIGN_W = 520;
const TURN_SECONDS = Number(new URLSearchParams(location.search).get('turnsec')) || 45;
const FX_COLS = 6;
const FX_ROWS = 10;
const FX_FRAMES = 60;

let app: Application;
let root: Container;
let bgSprite: Sprite;
let bgMask: Graphics;
let boardBox: Container;
let boardLayer: Container;
let fxLayer: Container;
let boardFrame: Sprite;
let cellLayer: Container;
let boardMask: Graphics;
let selector: Graphics;
let botSelectorA: Graphics;
let hintBox: Container;
let statusText: ReturnType<typeof makeText>;
let chatBox: Container;
let sprites: Array<Container | null> = new Array(CELLS).fill(null);
let tileSize = 0;
let fxFrames: Texture[] = [];
let designH = 980;
let pendingRefit = false;

let board: Board = [];
let me: Fighter = createFighter();
let foe: Fighter = createFighter();
let myTurn = true;
let busy = false;
let over = false;
let turnNumber = 1;
let selected: number | null = null;
let turnDeadline = 0;

function pos(i: number): { x: number; y: number } {
  return { x: (i % GRID) * tileSize, y: Math.floor(i / GRID) * tileSize };
}

function redrawSelector(g: Graphics, color: number): void {
  g.clear()
    .roundRect(1, 1, tileSize - 2, tileSize - 2, tileSize * 0.24)
    .stroke({ width: 3, color });
}

function makeSelector(color: number): Graphics {
  const g = new Graphics();
  redrawSelector(g, color);
  g.visible = false;
  return g;
}

function computeTileSize(): number {
  const scale0 = Math.min(window.innerWidth, DESIGN_W) / DESIGN_W;
  const designH0 = window.innerHeight / scale0;
  const boardBudget = (designH0 - 156 - 68 - 30 - 6 - 10 - 96 - 10) / 1.1;
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
  boardFrame.width = boardW * 1.1;
  boardFrame.height = boardW * 1.1;
  boardFrame.x = boardW / 2;
  boardFrame.y = boardW / 2;
  cellLayer.removeChildren().forEach((c) => c.destroy());
  for (let i = 0; i < CELLS; i++) {
    const cell = new Sprite(tex[A.board.cell]);
    const p = pos(i);
    cell.width = tileSize * 0.97;
    cell.height = tileSize * 0.97;
    cell.x = p.x + tileSize * 0.015;
    cell.y = p.y + tileSize * 0.015;
    cellLayer.addChild(cell);
  }
  boardMask
    .clear()
    .roundRect(-tileSize * 0.05, -tileSize * 0.05, boardW + tileSize * 0.1, boardW + tileSize * 0.1, 8)
    .fill(0xffffff);
  redrawSelector(selector, 0xffd75e);
  redrawSelector(botSelectorA, 0xff5a4d);
  setSelected(null);
  botSelectorA.visible = false;
  placeHint();
  rebuildSprites();
}

function endBusy(): void {
  busy = false;
  if (pendingRefit) layout();
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
  turnDeadline = performance.now() + TURN_SECONDS * 1000;
  clearHint();
}

function renderTurnClock(): void {
  const left = Math.max(0, turnDeadline - performance.now());
  const total = Math.ceil(left / 1000);
  const mm = String(Math.floor(total / 60)).padStart(2, '0');
  const ss = String(total % 60).padStart(2, '0');
  hud.timer.text = `${mm}:${ss}`;
  if (!over && myTurn && !busy) {
    if (left <= 0) {
      setStatus('Hết giờ — mất lượt!');
      void startBotTurn();
      return;
    }
    if (left <= 10_000) showHint();
  }
}

function updateHud(): void {
  const meActive = myTurn && !over;
  const foeActive = !myTurn && !over;
  updateFighter(hud.me, me, meActive, me.mp >= ULT_COST);
  updateFighter(hud.foe, foe, foeActive, foe.mp >= ULT_COST);

  const canUlt = meActive && !busy && me.mp >= ULT_COST;
  hud.me.ultBtn.eventMode = canUlt ? 'static' : 'none';
  hud.me.ultBtn.alpha = canUlt || !meActive ? 1 : 0.85;

  hud.turnCount.text = String(turnNumber);
  hud.forfeit.setEnabled(myTurn && !busy && !over);
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

async function playUltFx(side: 'me' | 'foe'): Promise<void> {
  if (fxFrames.length === 0) {
    await sleep(600);
    return;
  }
  const fx = new AnimatedSprite(fxFrames);
  fx.loop = false;
  fx.animationSpeed = 0.5;
  fx.anchor.set(0.5);
  const boardW = tileSize * GRID;
  fx.width = boardW;
  fx.height = boardW / 2;
  fx.x = boardW / 2;
  fx.y = boardW / 2;
  if (side === 'foe') fx.scale.x = -Math.abs(fx.scale.x);
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
  await sleep(550);
  botSelectorA.visible = false;
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

async function animateRemove(cells: Set<number>): Promise<void> {
  const jobs: Promise<void>[] = [];
  cells.forEach((i) => {
    const sprite = sprites[i];
    if (!sprite) return;
    sprite.pivot.set(tileSize / 2, tileSize / 2);
    sprite.position.set(sprite.x + tileSize / 2, sprite.y + tileSize / 2);
    jobs.push(tween(sprite, { alpha: 0, scale: 0.2 }, 180));
  });
  await Promise.all(jobs);
  cells.forEach((i) => {
    sprites[i]?.destroy();
    sprites[i] = null;
  });
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

async function resolveCascades(side: 'me' | 'foe'): Promise<boolean> {
  const attacker = side === 'me' ? me : foe;
  const defender = side === 'me' ? foe : me;
  let extraTurn = false;

  for (;;) {
    const match = findMatches(board);
    if (!match) break;
    if (match.maxRun >= 4) extraTurn = true;

    const result = applyTileEffects(attacker, defender, match.counts);
    const parts: string[] = [];
    if (result.damage > 0) parts.push(`-${result.damage} HP`);
    if (result.heal > 0) parts.push(`+${result.heal} HP`);
    if (result.mana > 0) parts.push(`+${result.mana} MP`);
    if (result.armor > 0) parts.push(`+${result.armor} giáp`);
    if (parts.length > 0) {
      setStatus(`${side === 'me' ? 'Bạn' : 'Máy'}: ${parts.join('  ')}`);
    }
    updateHud();

    await animateRemove(match.cells);
    const gravity = applyGravity(board, match.cells);
    await animateGravity(gravity.falls, gravity.spawns);

    if (defender.hp <= 0) return extraTurn;
  }

  await ensurePlayable();
  return extraTurn;
}

function finish(won: boolean, reason: 'win' | 'forfeit', sub: string): void {
  over = true;
  endBusy();
  clearHint();
  updateHud();
  showOverlay(won ? 'CHIẾN THẮNG!' : 'THẤT BẠI', won ? 0xffd75e : 0xff7a6e, sub, 'Chơi lại');
  setChatInputVisible(false);
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

  swapCells(board, a, b);
  if (!findMatches(board)) {
    swapCells(board, a, b);
    await animateSwap(a, b);
    await animateSwap(a, b);
    setStatus('Không tạo được combo');
    endBusy();
    return;
  }

  await animateSwap(a, b);
  const extraTurn = await resolveCascades('me');
  if (checkEnd()) return;

  if (extraTurn) {
    setStatus('Combo 4+ — bạn được thêm lượt!');
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
  castUltimate(me, foe);
  setStatus(`TUYỆT CHIÊU! -${ULT_DMG} HP`);
  updateHud();
  await playUltFx('me');
  if (checkEnd()) return;
  void startBotTurn();
}

async function startBotTurn(): Promise<void> {
  myTurn = false;
  busy = true;
  resetTurnClock();
  updateHud();
  setStatus('Máy đang nghĩ...');

  for (;;) {
    await sleep(700);
    if (over) return;

    if (foe.mp >= ULT_COST && (me.hp <= ULT_DMG + 10 || Math.random() < 0.5)) {
      castUltimate(foe, me);
      setStatus(`Máy tung TUYỆT CHIÊU! -${ULT_DMG} HP`);
      updateHud();
      await playUltFx('foe');
      if (checkEnd()) return;
      break;
    }

    const move = botChooseMove(board, foe, me);
    if (!move) {
      await ensurePlayable();
      continue;
    }
    await showBotPick(move[0]);
    if (over) return;
    swapCells(board, move[0], move[1]);
    await animateSwap(move[0], move[1]);
    const extraTurn = await resolveCascades('foe');
    if (checkEnd()) return;
    if (!extraTurn) break;
    setStatus('Máy được thêm lượt!');
  }

  myTurn = true;
  endBusy();
  turnNumber++;
  resetTurnClock();
  setStatus('Lượt của bạn — ghép 3 ô để tấn công!');
  updateHud();
}

function startGame(): void {
  me = createFighter();
  foe = createFighter();
  board = createBoard();
  myTurn = true;
  busy = true;
  over = false;
  turnNumber = 1;
  setSelected(null);
  rebuildSprites();
  hud.overlay.visible = false;
  setChatInputVisible(true);
  resetChat('Chào! Chơi vui nhé 😄');
  setStatus('Chuẩn bị chiến đấu...');
  updateHud();
  void dropInBoard().then(() => {
    endBusy();
    resetTurnClock();
    setStatus('Lượt của bạn — ghép 3 ô để tấn công!');
    updateHud();
  });
}

function layout(): void {
  const winW = window.innerWidth;
  const winH = window.innerHeight;
  const scale = Math.min(winW, DESIGN_W) / DESIGN_W;
  designH = winH / scale;

  root.scale.set(scale);
  root.x = Math.round((winW - DESIGN_W * scale) / 2);
  root.y = 0;

  const bgTex = bgSprite.texture;
  const cover = Math.max(DESIGN_W / bgTex.width, designH / bgTex.height);
  bgSprite.scale.set(cover);
  bgSprite.x = (DESIGN_W - bgTex.width * cover) / 2;
  bgSprite.y = 0;
  bgMask.clear().rect(0, 0, DESIGN_W, designH).fill(0xffffff);

  hud.me.card.x = 8;
  hud.me.card.y = 8;
  hud.foe.card.x = DESIGN_W - 8 - 190;
  hud.foe.card.y = 8;
  hud.banner.x = (DESIGN_W - 92) / 2;
  hud.banner.y = 4;

  const bottomH = 46;
  hud.bottomRow.y = Math.round(designH - bottomH - 12);
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
  const topStart = 156;
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
  const chatY = boardBox.y + boardW + overhang + GAP_BOARD_CHAT;
  layoutChat(Math.round((DESIGN_W - CHAT_W) / 2), chatY, chatH, root.x, scale);

  hud.overlayDim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.72 });
  const overlayCard = hud.overlay.getChildByLabel('overlay-card')!;
  overlayCard.x = (DESIGN_W - 340) / 2;
  overlayCard.y = Math.max(120, designH / 2 - 220);

  hud.confirmDim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: 0.6 });
  const confirmCard = hud.confirm.getChildByLabel('confirm-card')!;
  confirmCard.x = (DESIGN_W - 300) / 2;
  confirmCard.y = designH / 2 - 75;
}

async function main(): Promise<void> {
  await document.fonts.ready;

  app = new Application();
  await app.init({
    resizeTo: window,
    backgroundColor: 0x141428,
    antialias: true,
    resolution: window.devicePixelRatio || 1,
    autoDensity: true,
    preference: 'webgl',
  });
  document.getElementById('app')!.appendChild(app.canvas);
  initKit(app);

  await loadAssets();
  fxFrames = buildFxFrames(tex[A.fx.ult]);

  root = new Container();
  app.stage.addChild(root);

  const bgBox = new Container();
  bgSprite = new Sprite(tex[A.bg]);
  bgMask = new Graphics();
  bgBox.addChild(bgSprite);
  bgBox.mask = bgMask;
  bgBox.addChild(bgMask);
  root.addChild(bgBox);

  tileSize = computeTileSize();

  boardBox = new Container();
  boardFrame = new Sprite(tex[A.board.frame]);
  boardFrame.anchor.set(0.5);
  boardBox.addChild(boardFrame);

  cellLayer = new Container();
  boardBox.addChild(cellLayer);

  boardLayer = new Container();
  boardBox.addChild(boardLayer);

  boardMask = new Graphics();
  boardBox.addChild(boardMask);
  boardLayer.mask = boardMask;

  selector = makeSelector(0xffd75e);
  botSelectorA = makeSelector(0xff5a4d);
  const selectorLayer = new Container();
  selectorLayer.addChild(selector, botSelectorA);
  boardBox.addChild(selectorLayer);

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

  buildHud(root, {
    onUlt: () => void castMyUltimate(),
    onStart: () => startGame(),
    onRestart: () => {
      if (over) {
        startGame();
        return;
      }
      showConfirm('Chơi lại từ đầu?', () => startGame());
    },
    onForfeit: () => {
      if (over || !myTurn || busy) return;
      showConfirm('Bỏ cuộc trận này?', () => finish(false, 'forfeit', 'Bạn đã bỏ cuộc'));
    },
    onExit: () => bridge.exit(),
  });

  chatBox = buildChat({ isOver: () => over });
  root.addChild(chatBox);
  root.addChild(hud.overlay, hud.confirm);

  layout();
  window.addEventListener('resize', layout);

  board = createBoard();
  rebuildBoardVisuals();
  bridge.ready();

  setInterval(renderTurnClock, 250);

  resetTurnClock();
  updateHud();

  if (new URLSearchParams(location.search).has('autostart')) startGame();

  Object.defineProperty(window, '__wg', {
    get: () => ({ myTurn, busy, over, turn: turnNumber, status: statusText.text, hint: hintPair }),
  });
}

void main();
