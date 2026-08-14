// Harness dev-only: mở riêng từng màn của game với dữ liệu giả để xem/chụp UI
// mà không cần server game. Không được import từ code chạy thật.
//
//   /war-god/mock-ui.html?popup=leaderboard&state=full|short|empty|error|loading
//   /war-god/mock-ui.html?popup=create-room
//   /war-god/mock-ui.html?popup=pregame&state=alone|not-ready|ready|guest|guest-ready
//   /war-god/mock-ui.html?popup=battle&state=my-turn|foe-turn|win|lose
//   /war-god/mock-ui.html?popup=bot&state=easy|normal|hard
import { Application, Container, Graphics, Sprite } from 'pixi.js';
import type {
  GameSession,
  LeaderboardData,
  LeaderboardEntry,
  LeaderboardPeriod,
  MatchFoundData,
  RoomMember,
  RoomStateData,
  UserInfoData,
} from '../src/sdk';
import { A, loadAssets, tex } from './assets';
import { initKit } from './kit';
import { DESIGN_W } from './layout';
import { createBoard } from './logic/core';
import { TILE_ORDER, type ServerState } from './logic/server-types';
import {
  buildLeaderboardPopup,
  layoutLeaderboardPopup,
  openLeaderboardPopup,
} from './screens/lobby/leaderboard-popup';
import {
  buildCreateRoomPopup,
  layoutCreateRoomPopup,
  openCreateRoomPopup,
} from './screens/lobby/rooms/create-popup';
import {
  buildBattleScreen,
  enterRoomPregame,
  layoutBattleScreen,
  startBattle,
  startPvpBattle,
  updateRoomPregame,
} from './screens/battle';
import type { BotLevel } from './logic/battle';
import { showResult } from './screens/battle/hud';
import { pushPvpChat, setChatInputVisible } from './screens/battle/chat';

type PopupName = 'leaderboard' | 'create-room' | 'pregame' | 'battle' | 'bot';

const params = new URLSearchParams(location.search);
const popupName = (params.get('popup') ?? 'leaderboard') as PopupName;
const state = params.get('state') ?? 'full';
const replyDelay = Number(params.get('delay') ?? 120);

const ME: UserInfoData = {
  id: 'me',
  username: 'thanhlong',
  vipType: '4',
  vipDays: 30,
  ken: 1_284_500,
};
const FOE_VIP = '15';

const NAMES = [
  'thanhlong', 'mrbeast_vn', 'huyenthoai', 'kiemvuong', 'bangchu',
  'ducanh97', 'noname', 'chienthan', 'saobang', 'hoangtu_be',
  'linhmiu', 'tuananh', 'quyvuong', 'phuongthao', 'baolong',
  'minhtu', 'thienlong', 'catuong', 'ngocbich', 'vantruong',
];

function makeEntries(count: number, top: number): LeaderboardEntry[] {
  return Array.from({ length: count }, (_, i) => ({
    rank: i + 1,
    userId: `u${i + 1}`,
    username: NAMES[i % NAMES.length]!,
    ken: Math.round(top * Math.pow(0.86, i)),
    wins: 40 - i,
    losses: i * 2,
  }));
}

function makeMockSession(): GameSession {
  const data: Record<LeaderboardPeriod, LeaderboardEntry[]> = {
    day: makeEntries(state === 'short' ? 4 : 20, 1_284_500),
    week: makeEntries(state === 'short' ? 3 : 20, 8_640_000),
  };
  let handler: ((payload: LeaderboardData) => void) | null = null;
  const session = {
    onLeaderboard(next: (payload: LeaderboardData) => void) {
      handler = next;
      return () => {
        handler = null;
      };
    },
    getLeaderboard(period: LeaderboardPeriod) {
      if (state === 'loading') return;
      window.setTimeout(() => {
        if (!handler) return;
        const now = Date.now();
        handler({
          period,
          from: now - 86_400_000,
          to: now,
          items: state === 'empty' ? [] : data[period],
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
  const foeTurn = state === 'foe-turn';
  return {
    matchId: 'wg-match-mock',
    gameId: 'war-god',
    players: [
      { id: 'me', name: 'thanhlong', vipType: ME.vipType },
      { id: 'foe', name: 'kiemvuong', vipType: FOE_VIP },
    ],
    you: 0,
    turn: foeTurn ? 1 : 0,
    deadline: Date.now() + 38_000,
    bet: 50_000,
    state: {
      board: createBoard().map((t) => TILE_ORDER.indexOf(t)),
      fighters: [
        { hp: 148, mp: 62, armor: 12, fury: 40 },
        { hp: 96, mp: 34, armor: 0, fury: 70 },
      ],
      rng: 'mock',
      moveCount: 11,
      extraTurn: false,
      steps: [],
    },
  };
}

interface MockScene {
  mount(root: Container): void;
  layout(designH: number, insetTop: number, insetBottom: number, rootX: number, scale: number): void;
  open(): Promise<void> | void;
}

let requestLayout: () => void = () => {};

function simpleScene(
  view: Container,
  layout: (designH: number, insetTop: number, insetBottom: number) => void,
  open: () => void,
): MockScene {
  return {
    mount: (root) => root.addChild(view),
    layout: (designH, insetTop, insetBottom) => layout(designH, insetTop, insetBottom),
    open,
  };
}

function makeScene(): MockScene {
  if (popupName === 'create-room') {
    return simpleScene(
      buildCreateRoomPopup({
        onSubmit: (bet, password) => console.log('submit', { bet, password }),
        onCancel: () => console.log('cancel'),
      }),
      layoutCreateRoomPopup,
      openCreateRoomPopup,
    );
  }

  if (popupName === 'pregame' || popupName === 'battle' || popupName === 'bot') {
    return {
      mount: (root) => {
        buildBattleScreen(root, {
          getUserInfo: () => ME,
          onGameStart: () => {},
          onRequestLayout: () => requestLayout(),
          onExitToLobby: () => console.log('exit to lobby'),
          onReplay: () => console.log('replay'),
          onPvpError: (text) => console.log('pvp error', text),
        });
      },
      layout: (designH, insetTop, insetBottom, rootX, scale) =>
        layoutBattleScreen({
          designH,
          insetTop,
          insetBottom,
          safeTop: 0,
          safeBottom: 0,
          rootX,
          scale,
        }),
      open: async () => {
        if (popupName === 'bot') {
          startBattle(state as BotLevel);
          return;
        }
        if (popupName === 'pregame') {
          // Phòng chờ nằm ngay trong màn PK: bàn trống, chưa thả quân cờ.
          enterRoomPregame({
            onToggleReady: () => console.log('toggle ready'),
            onStart: () => console.log('start'),
            onKick: () => console.log('kick'),
            onLeave: () => console.log('leave'),
          });
          updateRoomPregame(state === 'loading' ? null : makeRoomState(), null);
          return;
        }
        await startPvpBattle(makeMatch());
        pushPvpChat('kiemvuong', false, 'Chơi hay đấy 😎');
        pushPvpChat('thanhlong', true, 'Xem lượt này của tôi!');
        if (state === 'win' || state === 'lose') {
          // Trận kết thúc thì ô chat bị khoá, giống nhánh finish() thật.
          setChatInputVisible(false);
          showResult(
            state === 'win'
              ? { outcome: 'win', detail: 'Bạn đã hạ gục @kiemvuong' }
              : { outcome: 'lose', detail: '@kiemvuong đã hạ gục bạn' },
          );
        }
      },
    };
  }

  return simpleScene(buildLeaderboardPopup(), layoutLeaderboardPopup, () =>
    openLeaderboardPopup(makeMockSession),
  );
}

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

  const root = new Container();
  app.stage.addChild(root);

  const bgBox = new Container();
  const bgSprite = new Sprite(tex[A.bg]);
  const bgMask = new Graphics();
  bgBox.addChild(bgSprite);
  bgBox.mask = bgMask;
  bgBox.addChild(bgMask);
  root.addChild(bgBox);

  const scene = makeScene();
  scene.mount(root);

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

    scene.layout(designH, 0, 0, root.x, scale);
  }

  requestLayout = layout;
  layout();
  window.addEventListener('resize', layout);

  await scene.open();
  layout();

  Object.defineProperty(window, '__mockReady', { value: true });
}

void main();
