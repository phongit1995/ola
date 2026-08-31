// Harness dev-only: dựng lobby + màn PK y như main.ts nhưng bằng dữ liệu giả,
// để xem/chụp mọi màn mà không cần server game. Không được import từ code thật.
//
//   /war-god/mock-ui.html?screen=<tên>&state=<trạng thái>
//
// Xem SCENES bên dưới để biết đủ tên màn và trạng thái.
import { Application, Container, Graphics, Sprite } from 'pixi.js';
import type {
  GameSession,
  LeaderboardData,
  LeaderboardEntry,
  LeaderboardPeriod,
  MatchFoundData,
  MatchHistoryData,
  MatchHistoryOutcome,
  RoomInfo,
  RoomMember,
  RoomStateData,
  UserInfoData,
} from '../src/sdk';
import { A, loadAssets, tex } from './assets';
import { initKit } from './kit';
import { installKeyboardDismiss } from './keyboard-dismiss';
import { DESIGN_W, renderResolution, watchDevicePixelRatio } from './layout';
import {
  LIGHTNING_GOD_DAMAGE,
  applyDamageThroughArmor,
  applyTileEffects,
  botChooseUltimateSkill,
  botShouldUlt,
  castUltimate,
  grantExtraTurns,
  type Fighter,
} from './logic/battle';
import {
  applyGravity,
  computeExplosions,
  computeLightningArcs,
  createBoard,
  emptyCounts,
  expandDartTriggeredSpecials,
  findFlyingDartCreation,
  findMatches,
  findValidMoves,
  GRID,
  randomFourTwoByTwoBlocks,
  swapCells,
  type Board,
} from './logic/core';
import { TILE_ORDER, type ServerMove, type ServerState } from './logic/server-types';
import { botChooseMove, type BotLevel } from './logic/battle';
import { pvp } from './pvp';
import {
  buildLobby,
  layoutLobby,
  lobbySetConnecting,
  lobbySetError,
  lobbySetReady,
  lobbySetVisible,
  lobbyShowToast,
} from './screens/lobby';
import { openConfirmPopup } from './screens/lobby/confirm-popup';
import { openGuidePopup } from './screens/lobby/guide-popup';
import { openHistoryPopup } from './screens/lobby/history-popup';
import { openLeaderboardPopup } from './screens/lobby/leaderboard-popup';
import { openPickPopup } from './screens/lobby/pick-popup';
import { openRoomsConfirm, openRoomsNotice } from './screens/lobby/rooms/confirm';
import { openCreateRoomPopup } from './screens/lobby/rooms/create-popup';
import {
  openRoomListPopup,
  renderRoomList,
  setRoomListUser,
} from './screens/lobby/rooms/list-popup';
import { openPasswordPopup } from './screens/lobby/rooms/password-popup';
import {
  battleDebug,
  buildBattleScreen,
  enterRoomPregame,
  layoutBattleScreen,
  startBattle,
  startPvpBattle,
  ultimateControlAnchor,
  updateRoomPregame,
} from './screens/battle';
import { showConfirm, showResult } from './screens/battle/hud';
import { pushPvpChat, setChatInputVisible } from './screens/battle/chat';
import { isBotStarRating, type BotStarRating } from './logic/bot-rating';
import {
  buildUltimatePicker,
  isUltimatePickerVariant,
  type UltimatePicker,
  type UltimateSkillId,
} from './screens/battle/ultimate-picker';

const params = new URLSearchParams(location.search);
// Một số client copy URL Markdown giữ lại dấu `\\` trước `&`, ví dụ
// `screen=battle\\&state=...`. Khi đó URLSearchParams trả về `battle\\` và
// scene không được tìm thấy, làm người dùng tưởng bot không hoạt động.
const cleanQueryValue = (value: string | null, fallback = ''): string =>
  (value ?? fallback).replace(/\\+$/g, '');
const screen = cleanQueryValue(params.get('screen'), 'lobby');
const state = cleanQueryValue(params.get('state'));
const variantParam = params.get('variant');
const ultimateVariant = isUltimatePickerVariant(variantParam) ? variantParam : undefined;
const replyDelay = Number(cleanQueryValue(params.get('delay'), '120'));
const starParam = params.get('stars');
const parsedStars = starParam == null ? Number.NaN : Number(starParam);
const mockStarRating: BotStarRating | undefined = isBotStarRating(parsedStars)
  ? parsedStars
  : undefined;
// query exp=<gained> (+ expBefore=<exp tích luỹ>) bật thanh kinh nghiệm PvP;
// ví dụ exp=70&expBefore=80 trình diễn nhịp LÊN CẤP!.
const expParam = Number(params.get('exp') ?? Number.NaN);
const expBeforeParam = Number(params.get('expBefore') ?? 0);
const mockExp =
  Number.isFinite(expParam) && expParam > 0
    ? { gained: expParam, before: Number.isFinite(expBeforeParam) ? expBeforeParam : 0 }
    : undefined;

const ME: UserInfoData = {
  id: 'me',
  username: 'thanhlong',
  vipType: '4',
  vipDays: 30,
  ken: 1_284_500,
  maxBet: 500_000,
  level: 7,
  exp: 2_260,
};
const FOE_VIP = '15';

const NAMES = [
  'thanhlong',
  'mrbeast_vn',
  'huyenthoai',
  'kiemvuong',
  'bangchu',
  'ducanh97',
  'noname',
  'chienthan',
  'saobang',
  'hoangtu_be',
  'linhmiu',
  'tuananh',
  'quyvuong',
  'phuongthao',
  'baolong',
  'minhtu',
  'thienlong',
  'catuong',
  'ngocbich',
  'vantruong',
];

function makeLeaderboard(count: number, top: number): LeaderboardEntry[] {
  return Array.from({ length: count }, (_, i) => ({
    rank: i + 1,
    userId: `u${i + 1}`,
    username: NAMES[i % NAMES.length]!,
    ken: Math.round(top * Math.pow(0.86, i)),
    wins: 40 - i,
    losses: i * 2,
  }));
}

function makeHistory(count: number): MatchHistoryData['items'] {
  const outcomes: MatchHistoryOutcome[] = ['win', 'lose', 'draw'];
  const now = Date.now();
  return Array.from({ length: count }, (_, i) => {
    const bet = [0, 10_000, 50_000, 200_000][i % 4]!;
    const outcome = outcomes[i % 3]!;
    return {
      id: `m${i + 1}`,
      playedAt: now - (i + 1) * 3_600_000,
      opponentId: `u${i + 1}`,
      opponentName: NAMES[(i + 3) % NAMES.length]!,
      bet,
      outcome,
      kenDelta: outcome === 'win' ? bet - Math.round(bet * 0.05) : outcome === 'lose' ? -bet : 0,
    };
  });
}

function makeRooms(count: number): RoomInfo[] {
  return Array.from({ length: count }, (_, i) => {
    const playing = i % 7 === 0;
    const full = playing || i % 5 === 0;
    return {
      id: `room-${i + 1}f3k92a1`,
      owner: NAMES[i % NAMES.length]!,
      ownerVipType: i % 3 === 0 ? null : String((i % 20) + 1),
      bet: [0, 10_000, 50_000, 200_000, 500_000][i % 5]!,
      locked: i % 4 === 1,
      players: full ? 2 : 1,
      full,
      ...(playing ? { status: 'playing' as const } : {}),
    };
  });
}

// Một session giả duy nhất phục vụ cả bảng xếp hạng lẫn lịch sử đấu. Trả lời
// trễ như socket thật để bắt được cả trạng thái đang tải.
function makeMockSession(): GameSession {
  const boards: Record<LeaderboardPeriod, LeaderboardEntry[]> = {
    day: makeLeaderboard(state === 'short' ? 4 : 20, 1_284_500),
    week: makeLeaderboard(state === 'short' ? 3 : 20, 8_640_000),
  };
  let onBoard: ((payload: LeaderboardData) => void) | null = null;
  let onHist: ((payload: MatchHistoryData) => void) | null = null;
  const session = {
    onLeaderboard(next: (payload: LeaderboardData) => void) {
      onBoard = next;
      return () => {
        onBoard = null;
      };
    },
    getLeaderboard(period: LeaderboardPeriod) {
      if (state === 'loading') return;
      window.setTimeout(() => {
        if (!onBoard) return;
        const now = Date.now();
        onBoard({
          period,
          from: now - 86_400_000,
          to: now,
          items: state === 'empty' ? [] : boards[period],
          ...(state === 'error' ? { error: 'mock_error' } : {}),
        });
      }, replyDelay);
    },
    onHistory(next: (payload: MatchHistoryData) => void) {
      onHist = next;
      return () => {
        onHist = null;
      };
    },
    getHistory() {
      if (state === 'loading') return;
      window.setTimeout(() => {
        if (!onHist) return;
        onHist({
          items: state === 'empty' ? [] : makeHistory(12),
          ...(state === 'error' ? { error: 'mock_error' } : {}),
        });
      }, replyDelay);
    },
  };
  return session as unknown as GameSession;
}

// Phòng chờ: chủ bàn luôn sẵn sàng, chỉ khách mới bấm SẴN SÀNG.
function makeRoomState(): RoomStateData {
  const asGuest = state.startsWith('guest');
  const guestReady = state === 'ready' || state === 'guest-ready';
  const members: RoomMember[] = [
    {
      id: 'owner',
      name: 'thanhlong',
      owner: true,
      ready: true,
      vipType: ME.vipType,
    },
  ];
  if (state !== 'alone') {
    members.push({
      id: 'guest',
      name: 'kiemvuong',
      owner: false,
      ready: guestReady,
      vipType: FOE_VIP,
    });
  }
  return {
    roomId: '7f3k92a1b4c8',
    ownerId: 'owner',
    youId: asGuest ? 'guest' : 'owner',
    bet: 50_000,
    locked: true,
    members,
  };
}

function createMockDartBoard(): Board {
  const baseTiles: readonly Board[number][] = [
    'sword',
    'peach',
    'heart',
    'water',
    'shield',
    'lightning',
  ];
  const board: Board = Array.from(
    { length: GRID * GRID },
    (_, index) => baseTiles[((index % GRID) + Math.floor(index / GRID) * 2) % baseTiles.length]!,
  );

  // Đổi ô (50, 51) sẽ ăn Phi Tiêu ngang; đổi ô (18, 19) sẽ ăn Phi Tiêu dọc.
  const horizontalStart = (GRID - 2) * GRID;
  board[horizontalStart] = 'sword';
  board[horizontalStart + 1] = 'sword';
  board[horizontalStart + 2] = 'peach';
  board[horizontalStart + 3] = 'flyingDartHorizontal';
  board[horizontalStart + 4] = 'fireSword';
  board[horizontalStart + 5] = 'lightning';
  const verticalTop = GRID + 2;
  board[verticalTop] = 'heart';
  board[verticalTop + GRID] = 'peach';
  board[verticalTop + GRID + 1] = 'heart';
  board[verticalTop + GRID * 2] = 'flyingDartVertical';
  board[verticalTop + GRID * 3] = 'fireSword';
  board[verticalTop + GRID * 4] = 'lightning';
  return board;
}

function makeMatch(): MatchFoundData<ServerState> {
  const myMana =
    state === 'mana-empty'
      ? 0
      : state === 'mana-loading'
      ? 50
      : state === 'mana-ready' || state === 'ultimate-picker'
      ? 100
      : 62;
  const mockBoard = state === 'flying-dart' ? createMockDartBoard() : createBoard();
  return {
    matchId: 'wg-match-mock',
    gameId: 'war-god',
    players: [
      { id: 'me', name: 'thanhlong', vipType: ME.vipType, level: ME.level },
      { id: 'foe', name: 'kiemvuong', vipType: FOE_VIP, level: 12 },
    ],
    you: 0,
    turn: state === 'foe-turn' ? 1 : 0,
    deadline: Date.now() + 30_000,
    bet: 50_000,
    state: {
      board: mockBoard.map((t) => TILE_ORDER.indexOf(t)),
      fighters: [
        { hp: 148, mp: myMana, armor: 12, fury: state === 'fury-full' ? 100 : 40 },
        { hp: 96, mp: 34, armor: 0, fury: 70 },
      ],
      rng: 'mock',
      moveCount: 11,
      extraTurn: false,
      steps: [],
    },
  };
}

function mockRandom(seed: number): () => number {
  let value = seed >>> 0;
  return () => {
    value = (Math.imul(value, 1_664_525) + 1_013_904_223) >>> 0;
    return value / 0x1_0000_0000;
  };
}

function encodeMockBoard(board: Board): number[] {
  return board.map((type) => TILE_ORDER.indexOf(type));
}

interface MockResolvedSwap {
  board: Board;
  fighters: Fighter[];
  steps: ServerState['steps'];
  extraTurns: number;
}

interface MockPvpSession extends GameSession<ServerState, ServerMove> {
  startBotTurn(): void;
}

function resolveMockCascades(
  board: Board,
  fighters: Fighter[],
  attackerIndex: number,
  random: () => number,
  steps: ServerState['steps'],
  initialExtraTurns: number,
  startingCascadeLevel: number,
  preferredDartCells: readonly number[] = [],
  furyChain: { active: boolean } = { active: false },
): number {
  const attacker = fighters[attackerIndex]!;
  const defender = fighters[1 - attackerIndex]!;
  let extraTurns = initialExtraTurns;
  let cascadeLevel = startingCascadeLevel;
  let preferred = preferredDartCells;

  for (let wave = 0; wave < 32; wave++) {
    const match = findMatches(board);
    if (!match) break;

    const creation = findFlyingDartCreation(board, preferred);
    const plan = computeExplosions(board, match.cells, random);
    const counts = { ...match.counts };
    for (const index of plan.exploded) counts[board[index]]++;

    const removed = new Set(match.cells);
    for (const index of plan.exploded) removed.add(index);
    if (creation) removed.delete(creation.index);

    const effects = applyTileEffects(attacker, defender, counts, cascadeLevel, furyChain);
    const extra = grantExtraTurns(extraTurns, match.bonusTurns);
    extraTurns = extra.remaining;
    steps.push({
      kind: 'match',
      cells: [...match.cells],
      exploded: plan.exploded,
      lightningArcs: plan.lightningArcs,
      dartActivations: plan.dartActivations,
      fireSwordActivations: plan.fireSwordActivations,
      dartCreations: creation
        ? [{ index: creation.index, type: TILE_ORDER.indexOf(creation.type) }]
        : [],
      counts,
      maxRun: match.maxRun,
      bonusTurns: match.bonusTurns,
      cascadeLevel,
      effects,
    });

    if (creation) board[creation.index] = creation.type;
    const gravity = applyGravity(board, removed, random);
    steps.push({
      kind: 'gravity',
      falls: gravity.falls,
      spawns: gravity.spawns.map((spawn) => ({
        index: spawn.index,
        type: TILE_ORDER.indexOf(spawn.type),
        fromRow: spawn.fromRow,
      })),
    });
    preferred = [];
    cascadeLevel++;
    if (attacker.hp <= 0 || defender.hp <= 0) break;
  }

  return extraTurns;
}

function resolveMockSwap(
  initialBoard: Board,
  initialFighters: Fighter[],
  a: number,
  b: number,
  seed: number,
  initialExtraTurns = 0,
  attackerIndex = 0,
): MockResolvedSwap {
  const board = [...initialBoard];
  const fighters = initialFighters.map((fighter) => ({ ...fighter }));
  const random = mockRandom(seed);
  const steps: ServerState['steps'] = [{ kind: 'swap', a, b }];

  swapCells(board, a, b);
  const extraTurns = resolveMockCascades(
    board,
    fighters,
    attackerIndex,
    random,
    steps,
    initialExtraTurns,
    0,
    [b, a],
  );

  if (findValidMoves(board).length === 0) {
    const shuffled = createBoard(random);
    board.splice(0, board.length, ...shuffled);
    steps.push({ kind: 'shuffle', board: encodeMockBoard(board) });
  }

  return { board, fighters, steps, extraTurns };
}

interface MockResolvedUltimate {
  board: Board;
  fighters: Fighter[];
  steps: ServerState['steps'];
  extraTurns: number;
}

function resolveMockUltimate(
  initialBoard: Board,
  initialFighters: Fighter[],
  skill: UltimateSkillId,
  seed: number,
  initialExtraTurns = 0,
  attackerIndex = 0,
): MockResolvedUltimate {
  const board = [...initialBoard];
  const fighters = initialFighters.map((fighter) => ({ ...fighter }));
  const attacker = fighters[attackerIndex]!;
  const defender = fighters[1 - attackerIndex]!;
  const random = mockRandom(seed);
  const steps: ServerState['steps'] = [];
  let extraTurns = initialExtraTurns;

  if (skill === 'myriad-swords') {
    const direct = castUltimate(attacker, defender);
    steps.push({
      kind: 'ult',
      skill,
      damage: direct.damage,
      armorDamage: direct.armorDamage,
    });
    return { board, fighters, steps, extraTurns };
  }

  attacker.mp = 0;
  const direct = applyDamageThroughArmor(defender, LIGHTNING_GOD_DAMAGE);
  const cells = randomFourTwoByTwoBlocks(random).flat();
  const struck = new Set(cells);
  const directFireSwords = new Set(
    cells.filter((index) => board[index] === 'fireSword'),
  );
  const specialExpansion = expandDartTriggeredSpecials(board, struck, directFireSwords);
  const lightningArcs = computeLightningArcs(board, struck, struck, random);
  lightningArcs.forEach((arc) => struck.add(arc.target));

  const primary = new Set(cells);
  const exploded = [...struck].filter((index) => !primary.has(index)).sort((a, b) => a - b);
  const counts = emptyCounts();
  struck.forEach((index) => counts[board[index]]++);
  const furyChain = { active: false };
  const effects = applyTileEffects(attacker, defender, counts, 0, furyChain);
  steps.push({
    kind: 'ult',
    skill,
    damage: direct.damage,
    armorDamage: direct.armorDamage,
    cells,
    exploded,
    lightningArcs,
    dartActivations: specialExpansion.dartActivations,
    fireSwordActivations: specialExpansion.fireSwordActivations,
    counts,
    effects,
  });

  const gravity = applyGravity(board, struck, random);
  steps.push({
    kind: 'gravity',
    falls: gravity.falls,
    spawns: gravity.spawns.map((spawn) => ({
      index: spawn.index,
      type: TILE_ORDER.indexOf(spawn.type),
      fromRow: spawn.fromRow,
    })),
  });
  if (attacker.hp > 0 && defender.hp > 0) {
    extraTurns = resolveMockCascades(
      board,
      fighters,
      attackerIndex,
      random,
      steps,
      extraTurns,
      1,
      [],
      furyChain,
    );
    if (findValidMoves(board).length === 0) {
      const shuffled = createBoard(random);
      board.splice(0, board.length, ...shuffled);
      steps.push({ kind: 'shuffle', board: encodeMockBoard(board) });
    }
  }

  return { board, fighters, steps, extraTurns };
}

// PvP mock transport: the visual harness calls startPvpBattle directly, so it
// has no real socket to answer a board tap. Resolve the swap with the shared
// client rules and return the same step sequence that the server sends, so
// match, gravity, dart and other special-tile FX can be tested from the board.
function makeMockPvpSession(
  match: MatchFoundData<ServerState>,
): MockPvpSession {
  let onState:
    | ((payload: {
        matchId: string;
        state: ServerState;
        turn: number;
        deadline: number;
        lastMove?: ServerMove;
        lastBy: number;
      }) => void)
    | null = null;
  let board: Board = match.state.board.map((code) => TILE_ORDER[code]!);
  let fighters: Fighter[] = match.state.fighters.map((fighter) => ({ ...fighter }));
  let moveCount = match.state.moveCount;
  let extraTurns = match.state.extraTurns ?? (match.state.extraTurn ? 1 : 0);
  let mockTurn = match.turn;
  let botTimer: number | null = null;

  let pendingSteps: ServerState['steps'] = [];
  const emitResolvedState = (lastMove: ServerMove, lastBy: number, turn: number): void => {
    onState?.({
      matchId: match.matchId,
      state: {
        ...match.state,
        board: encodeMockBoard(board),
        fighters: fighters.map((fighter) => ({ ...fighter })),
        moveCount,
        extraTurn: extraTurns > 0,
        extraTurns,
        steps: pendingSteps,
      },
      turn,
      deadline: Date.now() + 30_000,
      lastMove,
      lastBy,
    });
  };

  const scheduleBotTurn = (): void => {
    if (botTimer != null || mockTurn !== 1 || !onState) return;
    botTimer = window.setTimeout(() => {
      botTimer = null;
      if (!onState || mockTurn !== 1) return;
      const consumedExtraTurns = Math.max(0, extraTurns - 1);
      if (botShouldUlt(fighters[1]!, fighters[0]!, 'normal')) {
        const skill = botChooseUltimateSkill(fighters[1]!, fighters[0]!, 'normal');
        const resolved = resolveMockUltimate(
          board,
          fighters,
          skill,
          moveCount + 1,
          consumedExtraTurns,
          1,
        );
        board = resolved.board;
        fighters = resolved.fighters;
        extraTurns = resolved.extraTurns;
        pendingSteps = resolved.steps;
        moveCount += 1;
        mockTurn = extraTurns > 0 ? 1 : 0;
        emitResolvedState({ type: 'ult', skill }, 1, mockTurn);
        if (mockTurn === 1) scheduleBotTurn();
        return;
      }
      let botMove = botChooseMove(board, fighters[1]!, fighters[0]!, 'normal');
      if (!botMove) {
        board.splice(0, board.length, ...createBoard(mockRandom(moveCount + 1)));
        botMove = botChooseMove(board, fighters[1]!, fighters[0]!, 'normal');
      }
      if (!botMove) return;
      const resolved = resolveMockSwap(
        board,
        fighters,
        botMove[0],
        botMove[1],
        moveCount + 1,
        consumedExtraTurns,
        1,
      );
      board = resolved.board;
      fighters = resolved.fighters;
      extraTurns = resolved.extraTurns;
      pendingSteps = resolved.steps;
      moveCount += 1;
      mockTurn = extraTurns > 0 ? 1 : 0;
      emitResolvedState(
        { type: 'swap', a: botMove[0], b: botMove[1] },
        1,
        mockTurn === 1 ? 1 : 0,
      );
      if (mockTurn === 1) scheduleBotTurn();
    }, 700);
  };

  const subscription =
    <T extends (...args: never[]) => void>(_handler: T): (() => void) =>
    () => {};
  const session = {
    userId: 'me',
    joinQueue: () => {},
    leaveQueue: () => {},
    onMatchFound: subscription,
    onState(handler: typeof onState) {
      onState = handler;
      return () => {
        if (onState === handler) onState = null;
      };
    },
    onMatchOver: subscription,
    onChat: subscription,
    onReaction: subscription,
    onOpponentDisconnected: subscription,
    onOpponentReconnected: subscription,
    onError: subscription,
    onConnectionChange: subscription,
    sendMove(matchId: string, move: ServerMove) {
      if (matchId !== match.matchId || !onState || mockTurn !== 0) return;
      window.setTimeout(() => {
        if (!onState) return;
        if (move.type === 'swap') {
          const resolved = resolveMockSwap(
            board,
            fighters,
            move.a,
            move.b,
            moveCount + 1,
            Math.max(0, extraTurns - 1),
          );
          board = resolved.board;
          fighters = resolved.fighters;
          extraTurns = resolved.extraTurns;
          pendingSteps = resolved.steps;
          moveCount += 1;
          mockTurn = extraTurns > 0 ? 0 : 1;
          emitResolvedState(move, 0, mockTurn);
          if (mockTurn === 1) scheduleBotTurn();
          return;
        }
        const resolved = resolveMockUltimate(
          board,
          fighters,
          move.skill,
          moveCount + 1,
          Math.max(0, extraTurns - 1),
        );
        board = resolved.board;
        fighters = resolved.fighters;
        extraTurns = resolved.extraTurns;
        pendingSteps = resolved.steps;
        moveCount += 1;
        mockTurn = extraTurns > 0 ? 0 : 1;
        emitResolvedState(move, 0, mockTurn);
        if (mockTurn === 1) scheduleBotTurn();
      }, Math.max(0, replyDelay));
    },
    sendChat: () => {},
    sendRoomChat: () => {},
    sendReaction: () => {},
    forfeit: () => {},
    createRoom: () => {},
    joinRoom: () => {},
    leaveRoom: () => {},
    kickRoomMember: () => {},
    setRoomReady: () => {},
    startRoom: () => {},
    listRooms: () => {},
    getLeaderboard: () => {},
    getHistory: () => {},
    spectateList: () => {},
    spectateJoin: () => {},
    spectateLeave: () => {},
    onUserInfo: subscription,
    onQueueWaiting: subscription,
    onRoomList: subscription,
    onRoomUpsert: subscription,
    onRoomRemoved: subscription,
    onRoomWaiting: subscription,
    onRoomState: subscription,
    onRoomSync: subscription,
    onRoomClosed: subscription,
    onRoomKicked: subscription,
    onConnectionError: subscription,
    onLeaderboard: subscription,
    onHistory: subscription,
    onSpectateList: subscription,
    onSpectateJoined: subscription,
    onSpectateLeft: subscription,
    startBotTurn: scheduleBotTurn,
    disconnect: () => {
      if (botTimer != null) window.clearTimeout(botTimer);
      botTimer = null;
    },
  };
  return session;
}

const noop = (): void => {};
let ultimatePicker: UltimatePicker;
let chosenUltimate: UltimateSkillId | null = null;
let pendingUltimateCast: ((skill: UltimateSkillId) => void) | null = null;

async function openPvpBattle(): Promise<void> {
  const match = makeMatch();
  const session = makeMockPvpSession(match);
  pvp.init(session);
  Object.defineProperty(window, '__mockInitialBoard', {
    configurable: true,
    value: match.state.board,
  });
  await startPvpBattle(match);
  // Chỉ bắt đầu lượt bot sau intro + drop-in, tránh state bot chạy đè lên
  // Promise khởi tạo trận khi mock mở sẵn ở `state=foe-turn`.
  session.startBotTurn();
  pushPvpChat('kiemvuong', false, 'Chơi hay đấy 😎');
  pushPvpChat('thanhlong', true, 'Xem lượt này của tôi!');
}

const SCENES: Record<string, () => Promise<void> | void> = {
  // state: ready | connecting | error | toast | pick | guide | confirm
  lobby() {
    if (state === 'connecting') return lobbySetConnecting();
    if (state === 'error') return lobbySetError();
    lobbySetReady(ME);
    if (state === 'toast') lobbyShowToast('Không đủ Ken để vào bàn này');
    if (state === 'pick') openPickPopup();
    if (state === 'guide') openGuidePopup();
    if (state === 'confirm') openConfirmPopup('Bạn có chắc muốn\nthoát game?', noop);
  },

  // state: full | short | empty | error | loading
  leaderboard() {
    lobbySetReady(ME);
    openLeaderboardPopup(makeMockSession);
  },

  // state: full | empty | error | loading
  history() {
    lobbySetReady(ME);
    openHistoryPopup(makeMockSession);
  },

  // state: list | list-empty | create | password | confirm | notice
  rooms() {
    lobbySetReady(ME);
    if (state === 'create') return openCreateRoomPopup();
    if (state === 'password') return openPasswordPopup('kiemvuong');
    if (state === 'confirm') return openRoomsConfirm('Bạn có chắc muốn\nrời bàn?', noop);
    if (state === 'notice') return openRoomsNotice('Chủ bàn đã rời, bàn bị đóng');
    setRoomListUser(ME);
    renderRoomList(makeRooms(state === 'list-empty' ? 0 : 14));
    openRoomListPopup();
  },

  // state: alone | not-ready | ready | guest | guest-ready
  pregame() {
    enterRoomPregame({
      onToggleReady: noop,
      onStart: noop,
      onKick: noop,
      onLeave: noop,
    });
    updateRoomPregame(makeRoomState(), null);
  },

  // state: my-turn | foe-turn | flying-dart | flying-dart-test | flying-dart-test-vertical | mana-empty | mana-loading | mana-ready | ultimate-picker | fury-full | win | lose | draw
  // query stars=0..3 theo bước 0.5 bật biến thể rating khi chơi với Máy.
  async battle() {
    await openPvpBattle();
    if (state === 'flying-dart-test' || state === 'flying-dart-test-vertical') {
      const preview = battleDebug().previewFlyingDartWildcard;
      if (typeof preview === 'function') {
        preview(state === 'flying-dart-test-vertical' ? 'vertical' : 'horizontal');
      }
      return;
    }
    if (state === 'ultimate-picker') {
      ultimatePicker.open();
      return;
    }
    if (state !== 'win' && state !== 'lose' && state !== 'draw') return;
    // Trận kết thúc thì ô chat bị khoá, giống nhánh finish() thật.
    setChatInputVisible(false);
    if (state === 'win') {
      showResult({
        outcome: 'win',
        detail: 'Bạn đã hạ gục @kiemvuong',
        starRating: mockStarRating,
        kenText: mockExp ? '+9.500 KEN' : undefined,
        exp: mockExp,
      });
    } else if (state === 'lose') {
      showResult({
        outcome: 'lose',
        detail: '@kiemvuong đã hạ gục bạn',
        starRating: mockStarRating,
        kenText: mockExp ? '-10.000 KEN' : undefined,
        exp: mockExp,
      });
    } else {
      showResult({ outcome: 'draw', detail: 'Hai bên bất phân thắng bại', exp: mockExp });
    }
  },

  // state: restart | forfeit | exit
  async 'battle-confirm'() {
    await openPvpBattle();
    if (state === 'restart') {
      showConfirm({
        kind: 'restart',
        message: 'Ván hiện tại sẽ kết thúc.\nBạn muốn chơi lại từ đầu?',
        confirmLabel: 'CHƠI LẠI',
        onConfirm: noop,
      });
      return;
    }
    if (state === 'exit') {
      showConfirm({
        kind: 'exit',
        message: 'Thoát sẽ bị xử thua và rời bàn.\nBạn có chắc muốn thoát?',
        confirmLabel: 'RỜI TRẬN',
        onConfirm: noop,
      });
      return;
    }
    showConfirm({
      kind: 'forfeit',
      message: 'Bạn sẽ bị xử thua ván này.\nBạn vẫn có thể chơi ván tiếp theo.',
      confirmLabel: 'BỎ CUỘC',
      onConfirm: noop,
    });
  },

  // state: easy | normal | hard | expert | flying-dart
  bot() {
    const level: BotLevel =
      state === 'easy' || state === 'normal' || state === 'hard' || state === 'expert'
        ? state
        : 'normal';
    startBattle(level, state === 'flying-dart' ? createMockDartBoard() : undefined);
  },
};

let requestLayout: () => void = () => {};

async function main(): Promise<void> {
  await document.fonts.ready;
  const disposeKeyboardDismiss = installKeyboardDismiss();
  window.addEventListener('pagehide', disposeKeyboardDismiss, { once: true });

  const resolution = renderResolution(window.devicePixelRatio);
  const app = new Application();
  await app.init({
    resizeTo: window,
    backgroundColor: 0x141428,
    antialias: true,
    resolution,
    autoDensity: true,
    roundPixels: true,
    preference: 'webgl',
  });
  document.getElementById('app')!.appendChild(app.canvas);
  initKit(app);

  await loadAssets();
  ultimatePicker = await buildUltimatePicker((skill) => {
    chosenUltimate = skill;
    const cast = pendingUltimateCast;
    pendingUltimateCast = null;
    cast?.(skill);
  }, ultimateVariant);

  const root = new Container();
  app.stage.addChild(root);

  const bgBox = new Container();
  const bgSprite = new Sprite(tex[A.bg]);
  const bgMask = new Graphics();
  bgBox.addChild(bgSprite);
  bgBox.mask = bgMask;
  bgBox.addChild(bgMask);
  root.addChild(bgBox);

  buildBattleScreen(root, {
    getUserInfo: () => ME,
    // Vào trận thì lobby phải ẩn, không thì nó nằm đè lên màn PK.
    onGameStart: () => lobbySetVisible(false),
    onRequestLayout: () => requestLayout(),
    onExitToLobby: noop,
    onReplay: noop,
    onPvpError: (text) => console.log('pvp error', text),
    onUltimateRequest: (cast) => {
      pendingUltimateCast = cast;
      ultimatePicker.open();
      return true;
    },
  });

  // buildLobby dựng luôn mọi popup lobby bên trong (pick, guide, confirm,
  // search, rooms, history, leaderboard) nên không được build lại lần nữa —
  // các popup đó giữ state ở cấp module.
  root.addChild(
    buildLobby({
      getSession: makeMockSession,
      onPlay: noop,
      onRetry: noop,
      onExit: noop,
    }),
  );
  root.addChild(ultimatePicker.view);

  function layout(): void {
    const nextResolution = renderResolution(window.devicePixelRatio);
    if (app.renderer.resolution !== nextResolution) {
      app.renderer.resolution = nextResolution;
    }
    const scale = Math.min(window.innerWidth, DESIGN_W) / DESIGN_W;
    const designH = window.innerHeight / scale;
    root.scale.set(scale);
    root.x = Math.round((window.innerWidth - DESIGN_W * scale) / 2);
    root.y = 0;

    const bgTex = bgSprite.texture;
    const cover = Math.max(DESIGN_W / bgTex.width, designH / bgTex.height);
    bgSprite.scale.set(cover);
    bgSprite.x = (DESIGN_W - bgTex.width * cover) / 2;
    bgSprite.y = 0;
    bgMask.clear().rect(0, 0, DESIGN_W, designH).fill(0xffffff);

    layoutBattleScreen({
      designH,
      insetTop: 0,
      insetBottom: 0,
      safeTop: 0,
      safeBottom: 0,
      rootX: root.x,
      scale,
    });
    layoutLobby(designH, 0, 0);
    ultimatePicker.layout(designH, 0, 0, ultimateControlAnchor());
  }

  requestLayout = layout;
  layout();
  window.addEventListener('resize', layout);
  const disposeResolutionWatcher = watchDevicePixelRatio(window, layout);
  window.addEventListener('pagehide', (event) => {
    if (event.persisted) return;
    window.removeEventListener('resize', layout);
    disposeResolutionWatcher();
  });

  await SCENES[screen]?.();
  layout();

  Object.defineProperty(window, '__mockBattle', { get: () => battleDebug() });
  Object.defineProperty(window, '__mockUltimatePicker', {
    get: () => ({ ...ultimatePicker.getState(), chosen: chosenUltimate }),
  });
  Object.defineProperty(window, '__mockReady', { value: true });
}

void main();
