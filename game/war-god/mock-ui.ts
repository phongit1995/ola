// Harness dev-only: mở riêng từng popup của lobby với dữ liệu giả để xem/chụp
// UI mà không cần server game. Không được import từ code chạy thật.
//
//   /war-god/mock-ui.html?popup=leaderboard&state=full|short|empty|error|loading
//   /war-god/mock-ui.html?popup=create-room
import { Application, Container, Graphics, Sprite } from 'pixi.js';
import type { GameSession, LeaderboardData, LeaderboardEntry, LeaderboardPeriod } from '../src/sdk';
import { A, loadAssets, tex } from './assets';
import { initKit } from './kit';
import { DESIGN_W } from './layout';
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

type PopupName = 'leaderboard' | 'create-room';
type MockState = 'full' | 'short' | 'empty' | 'error' | 'loading';

const params = new URLSearchParams(location.search);
const popupName = (params.get('popup') ?? 'leaderboard') as PopupName;
const state = (params.get('state') ?? 'full') as MockState;
const replyDelay = Number(params.get('delay') ?? 120);

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

interface MockPopup {
  view: Container;
  layout(designH: number, insetTop: number, insetBottom: number): void;
  open(): void;
}

function makePopup(): MockPopup {
  if (popupName === 'create-room') {
    return {
      view: buildCreateRoomPopup({
        onSubmit: (bet, password) => console.log('submit', { bet, password }),
        onCancel: () => console.log('cancel'),
      }),
      layout: layoutCreateRoomPopup,
      open: openCreateRoomPopup,
    };
  }
  return {
    view: buildLeaderboardPopup(),
    layout: layoutLeaderboardPopup,
    open: () => openLeaderboardPopup(makeMockSession),
  };
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

  const popup = makePopup();
  root.addChild(popup.view);

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

    popup.layout(designH, 0, 0);
  }

  layout();
  window.addEventListener('resize', layout);

  popup.open();
  layout();

  Object.defineProperty(window, '__mockReady', { value: true });
}

void main();
