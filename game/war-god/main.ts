import { Application, Container, Graphics, Text, type Ticker } from 'pixi.js';
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
  MAX_HP,
  MAX_MP,
  ULT_COST,
  ULT_DMG,
  applyTileEffects,
  botChooseMove,
  castUltimate,
  createFighter,
  type Fighter,
} from './battle';

const EMOJI: Record<TileType, string> = {
  sword: '⚔️',
  fire: '🔥',
  heart: '❤️',
  water: '💧',
  shield: '🛡️',
  stone: '🪨',
};

const el = {
  status: document.getElementById('status')!,
  turnCount: document.getElementById('turn-count')!,
  hint: document.getElementById('hint')!,
  host: document.getElementById('board-host')!,
  overlay: document.getElementById('overlay')!,
  overlayTitle: document.getElementById('overlay-title')!,
  overlaySub: document.getElementById('overlay-sub')!,
  btnStart: document.getElementById('btn-start') as HTMLButtonElement,
  btnUlt: document.getElementById('btn-ult') as HTMLButtonElement,
  btnForfeit: document.getElementById('btn-forfeit') as HTMLButtonElement,
  btnExit: document.getElementById('btn-exit')!,
  fMe: document.getElementById('f-me')!,
  fFoe: document.getElementById('f-foe')!,
  meHp: document.getElementById('me-hp')!,
  meHpText: document.getElementById('me-hp-text')!,
  meMp: document.getElementById('me-mp')!,
  meMpText: document.getElementById('me-mp-text')!,
  meArmor: document.getElementById('me-armor')!,
  foeHp: document.getElementById('foe-hp')!,
  foeHpText: document.getElementById('foe-hp-text')!,
  foeMp: document.getElementById('foe-mp')!,
  foeMpText: document.getElementById('foe-mp-text')!,
  foeArmor: document.getElementById('foe-armor')!,
  foeUlt: document.getElementById('foe-ult')!,
};

let app: Application;
let boardLayer: Container;
let selector: Graphics;
let sprites: Array<Container | null> = new Array(CELLS).fill(null);
let tileSize = 0;

let board: Board = [];
let me: Fighter = createFighter();
let foe: Fighter = createFighter();
let myTurn = true;
let busy = false;
let over = false;
let turnNumber = 1;
let selected: number | null = null;

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function pos(i: number): { x: number; y: number } {
  return { x: (i % GRID) * tileSize, y: Math.floor(i / GRID) * tileSize };
}

function tween(
  obj: Container,
  to: Partial<{ x: number; y: number; alpha: number; scale: number }>,
  dur: number,
): Promise<void> {
  const from = { x: obj.x, y: obj.y, alpha: obj.alpha, scale: obj.scale.x };
  return new Promise((resolve) => {
    let t = 0;
    const step = (ticker: Ticker): void => {
      t += ticker.deltaMS;
      const k = Math.min(1, t / dur);
      const e = 1 - (1 - k) * (1 - k);
      if (to.x !== undefined) obj.x = from.x + (to.x - from.x) * e;
      if (to.y !== undefined) obj.y = from.y + (to.y - from.y) * e;
      if (to.alpha !== undefined) obj.alpha = from.alpha + (to.alpha - from.alpha) * e;
      if (to.scale !== undefined) obj.scale.set(from.scale + (to.scale - from.scale) * e);
      if (k >= 1) {
        app.ticker.remove(step);
        resolve();
      }
    };
    app.ticker.add(step);
  });
}

function makeTile(type: TileType, index: number): Container {
  const c = new Container();
  const bg = new Graphics()
    .roundRect(2, 2, tileSize - 4, tileSize - 4, tileSize * 0.22)
    .fill(0x16162b)
    .stroke({ width: 1, color: 0x2a2a4a });
  const label = new Text({ text: EMOJI[type], style: { fontSize: tileSize * 0.52 } });
  label.anchor.set(0.5);
  label.x = tileSize / 2;
  label.y = tileSize / 2;
  c.addChild(bg, label);
  const p = pos(index);
  c.x = p.x;
  c.y = p.y;
  c.eventMode = 'static';
  c.cursor = 'pointer';
  c.on('pointertap', () => onTileTap(index));
  return c;
}

function rebuildSprites(): void {
  sprites.forEach((s) => s?.destroy());
  sprites = new Array(CELLS).fill(null);
  for (let i = 0; i < CELLS; i++) {
    const sprite = makeTile(board[i], i);
    sprites[i] = sprite;
    boardLayer.addChild(sprite);
  }
  boardLayer.addChild(selector);
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
  el.status.textContent = text;
}

function updateHud(): void {
  el.meHp.style.width = `${(me.hp / MAX_HP) * 100}%`;
  el.meHpText.textContent = `${me.hp}/${MAX_HP}`;
  el.meHp.parentElement!.classList.toggle('low', me.hp <= 30);
  el.meMp.style.width = `${(me.mp / MAX_MP) * 100}%`;
  el.meMpText.textContent = `${me.mp}/${MAX_MP}`;
  el.meArmor.textContent = me.armor > 0 ? `🛡️ ${me.armor}` : '';

  el.foeHp.style.width = `${(foe.hp / MAX_HP) * 100}%`;
  el.foeHpText.textContent = `${foe.hp}/${MAX_HP}`;
  el.foeHp.parentElement!.classList.toggle('low', foe.hp <= 30);
  el.foeMp.style.width = `${(foe.mp / MAX_MP) * 100}%`;
  el.foeMpText.textContent = `${foe.mp}/${MAX_MP}`;
  el.foeArmor.textContent = foe.armor > 0 ? `🛡️ ${foe.armor}` : '';
  el.foeUlt.classList.toggle('ready', foe.mp >= ULT_COST);

  el.fMe.classList.toggle('active', myTurn && !over);
  el.fFoe.classList.toggle('active', !myTurn && !over);
  el.turnCount.textContent = String(turnNumber);
  el.btnUlt.disabled = !myTurn || busy || over || me.mp < ULT_COST;
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

async function animateGravity(falls: Array<{ from: number; to: number }>, spawns: Array<{ index: number; type: TileType; fromRow: number }>): Promise<void> {
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
  boardLayer.addChild(selector);
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
    if (result.damage > 0) parts.push(`⚔️ -${result.damage} HP`);
    if (result.heal > 0) parts.push(`❤️ +${result.heal}`);
    if (result.mana > 0) parts.push(`💧 +${result.mana} MP`);
    if (result.armor > 0) parts.push(`🛡️ +${result.armor}`);
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

function finish(won: boolean, reason: string): void {
  over = true;
  busy = false;
  el.btnForfeit.disabled = true;
  updateHud();
  el.overlay.classList.remove('hidden');
  el.overlayTitle.textContent = won ? 'CHIẾN THẮNG!' : 'THẤT BẠI';
  el.overlayTitle.className = won ? 'win' : 'lose';
  el.overlaySub.textContent = reason;
  el.btnStart.innerHTML = el.btnStart.innerHTML.replace('Chơi với máy', 'Chơi lại');
  bridge.gameOver({ matchId: `wargod-${Date.now()}`, winnerId: won ? 'you' : 'bot', reason: 'win', won });
}

function checkEnd(): boolean {
  if (foe.hp <= 0) {
    finish(true, 'Bạn đã hạ gục Máy 🤖');
    return true;
  }
  if (me.hp <= 0) {
    finish(false, 'Máy 🤖 đã hạ gục bạn');
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

  swapCells(board, a, b);
  if (!findMatches(board)) {
    swapCells(board, a, b);
    await animateSwap(a, b);
    await animateSwap(a, b);
    setStatus('Không tạo được combo');
    busy = false;
    return;
  }

  await animateSwap(a, b);
  const extraTurn = await resolveCascades('me');
  if (checkEnd()) return;

  if (extraTurn) {
    setStatus('Combo 4+ — bạn được thêm lượt!');
    busy = false;
    updateHud();
    return;
  }
  void startBotTurn();
}

async function castMyUltimate(): Promise<void> {
  if (!myTurn || busy || over || me.mp < ULT_COST) return;
  busy = true;
  setSelected(null);
  castUltimate(me, foe);
  setStatus(`🔥 TUYỆT CHIÊU! -${ULT_DMG} HP`);
  updateHud();
  await sleep(600);
  if (checkEnd()) return;
  void startBotTurn();
}

async function startBotTurn(): Promise<void> {
  myTurn = false;
  busy = true;
  updateHud();
  setStatus('Máy đang nghĩ...');

  for (;;) {
    await sleep(700);
    if (over) return;

    if (foe.mp >= ULT_COST && (me.hp <= ULT_DMG + 10 || Math.random() < 0.5)) {
      castUltimate(foe, me);
      setStatus(`Máy tung TUYỆT CHIÊU! -${ULT_DMG} HP`);
      updateHud();
      await sleep(600);
      if (checkEnd()) return;
      break;
    }

    const move = botChooseMove(board, foe, me);
    if (!move) {
      await ensurePlayable();
      continue;
    }
    swapCells(board, move[0], move[1]);
    await animateSwap(move[0], move[1]);
    const extraTurn = await resolveCascades('foe');
    if (checkEnd()) return;
    if (!extraTurn) break;
    setStatus('Máy được thêm lượt!');
  }

  myTurn = true;
  busy = false;
  turnNumber++;
  setStatus('Lượt của bạn');
  updateHud();
}

function startGame(): void {
  me = createFighter();
  foe = createFighter();
  board = createBoard();
  myTurn = true;
  busy = false;
  over = false;
  turnNumber = 1;
  setSelected(null);
  rebuildSprites();
  el.overlay.classList.add('hidden');
  el.btnForfeit.disabled = false;
  setStatus('Lượt của bạn');
  updateHud();
}

async function main(): Promise<void> {
  const size = Math.min(el.host.clientWidth, el.host.clientHeight, 520 - 16);
  tileSize = Math.floor(size / GRID);
  const boardSize = tileSize * GRID;

  app = new Application();
  await app.init({ width: boardSize, height: boardSize, background: 0x141428, antialias: true });
  el.host.appendChild(app.canvas);

  boardLayer = new Container();
  app.stage.addChild(boardLayer);

  selector = new Graphics()
    .roundRect(1, 1, tileSize - 2, tileSize - 2, tileSize * 0.24)
    .stroke({ width: 3, color: 0xa78bfa });
  selector.visible = false;

  board = createBoard();
  rebuildSprites();
  bridge.ready();

  el.btnStart.addEventListener('click', startGame);
  el.btnUlt.addEventListener('click', () => void castMyUltimate());
  el.btnForfeit.addEventListener('click', () => {
    if (!over && window.confirm('Bỏ cuộc trận này?')) finish(false, 'Bạn đã bỏ cuộc');
  });
  el.btnExit.addEventListener('click', () => {
    bridge.exit();
  });

  updateHud();
}

void main();
