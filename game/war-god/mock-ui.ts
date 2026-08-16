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
import { DESIGN_W } from './layout';
import { createBoard } from './logic/core';
import { TILE_ORDER, type ServerState } from './logic/server-types';
import type { BotLevel } from './logic/battle';
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
import { openRoomListPopup, renderRoomList, setRoomListUser } from './screens/lobby/rooms/list-popup';
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
import {
  buildUltimatePicker,
  isUltimatePickerVariant,
  type UltimatePicker,
  type UltimateSkillId,
} from './screens/battle/ultimate-picker';

const params = new URLSearchParams(location.search);
const screen = params.get('screen') ?? 'lobby';
const state = params.get('state') ?? '';
const variantParam = params.get('variant');
const ultimateVariant = isUltimatePickerVariant(variantParam) ? variantParam : undefined;
const replyDelay = Number(params.get('delay') ?? 120);

const ME: UserInfoData = {
  id: 'me',
  username: 'thanhlong',
  vipType: '4',
  vipDays: 30,
  ken: 1_284_500,
  maxBet: 500_000,
};
const FOE_VIP = '15';

const NAMES = [
  'thanhlong', 'mrbeast_vn', 'huyenthoai', 'kiemvuong', 'bangchu',
  'ducanh97', 'noname', 'chienthan', 'saobang', 'hoangtu_be',
  'linhmiu', 'tuananh', 'quyvuong', 'phuongthao', 'baolong',
  'minhtu', 'thienlong', 'catuong', 'ngocbich', 'vantruong',
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
  return Array.from({ length: count }, (_, i) => ({
    id: `m${i + 1}`,
    playedAt: now - (i + 1) * 3_600_000,
    opponentId: `u${i + 1}`,
    opponentName: NAMES[(i + 3) % NAMES.length]!,
    bet: [0, 10_000, 50_000, 200_000][i % 4]!,
    outcome: outcomes[i % 3]!,
  }));
}

function makeRooms(count: number): RoomInfo[] {
  return Array.from({ length: count }, (_, i) => ({
    id: `room-${i + 1}f3k92a1`,
    owner: NAMES[i % NAMES.length]!,
    ownerVipType: i % 3 === 0 ? null : String((i % 20) + 1),
    bet: [0, 10_000, 50_000, 200_000, 500_000][i % 5]!,
    locked: i % 4 === 1,
    players: i % 5 === 0 ? 2 : 1,
    full: i % 5 === 0,
  }));
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
    { id: 'owner', name: 'thanhlong', owner: true, ready: true, vipType: ME.vipType },
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

function makeMatch(): MatchFoundData<ServerState> {
  const myMana =
    state === 'mana-empty' ? 0 : state === 'mana-loading' ? 25 : state === 'mana-ready' ? 50 : 62;
  return {
    matchId: 'wg-match-mock',
    gameId: 'war-god',
    players: [
      { id: 'me', name: 'thanhlong', vipType: ME.vipType },
      { id: 'foe', name: 'kiemvuong', vipType: FOE_VIP },
    ],
    you: 0,
    turn: state === 'foe-turn' ? 1 : 0,
    deadline: Date.now() + 30_000,
    bet: 50_000,
    state: {
      board: createBoard().map((t) => TILE_ORDER.indexOf(t)),
      fighters: [
        { hp: 148, mp: myMana, armor: 12, fury: 40 },
        { hp: 96, mp: 34, armor: 0, fury: 70 },
      ],
      rng: 'mock',
      moveCount: 11,
      extraTurn: false,
      steps: [],
    },
  };
}

const noop = (): void => {};
let ultimatePicker: UltimatePicker;
let chosenUltimate: UltimateSkillId | null = null;

async function openPvpBattle(): Promise<void> {
  await startPvpBattle(makeMatch());
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
    enterRoomPregame({ onToggleReady: noop, onStart: noop, onKick: noop, onLeave: noop });
    updateRoomPregame(makeRoomState(), null);
  },

  // state: my-turn | foe-turn | mana-empty | mana-loading | mana-ready | ultimate-picker | win | lose | draw
  async battle() {
    await openPvpBattle();
    if (state === 'ultimate-picker') {
      ultimatePicker.open();
      return;
    }
    if (state !== 'win' && state !== 'lose' && state !== 'draw') return;
    // Trận kết thúc thì ô chat bị khoá, giống nhánh finish() thật.
    setChatInputVisible(false);
    if (state === 'win') showResult({ outcome: 'win', detail: 'Bạn đã hạ gục @kiemvuong' });
    else if (state === 'lose') showResult({ outcome: 'lose', detail: '@kiemvuong đã hạ gục bạn' });
    else showResult({ outcome: 'draw', detail: 'Hai bên bất phân thắng bại' });
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

  // state: easy | normal | hard
  bot() {
    startBattle((state || 'normal') as BotLevel);
  },
};

let requestLayout: () => void = () => {};

async function main(): Promise<void> {
  await document.fonts.ready;

  const resolution = Math.max(1, window.devicePixelRatio || 1);
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
    onUltimateRequest: () => {
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

  await SCENES[screen]?.();
  layout();

  Object.defineProperty(window, '__mockBattle', { get: () => battleDebug() });
  Object.defineProperty(window, '__mockUltimatePicker', {
    get: () => ({ ...ultimatePicker.getState(), chosen: chosenUltimate }),
  });
  Object.defineProperty(window, '__mockReady', { value: true });
}

void main();
