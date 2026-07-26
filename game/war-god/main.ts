import { Application, Container, Graphics, Sprite } from 'pixi.js';
import { GAME_ERROR_CODE, bridge, joinGame, type UserInfoData } from '../src/sdk';
import { A, loadAssets, tex } from './assets';
import { initKit } from './kit';
import { pvp, type PvpGameSession } from './pvp';
import { hasActiveRoom, initRooms, openWaitingRoom } from './rooms';
import type { ServerMove, ServerState } from './logic/server-types';
import {
  battleChatFocused,
  battleDebug,
  buildBattleScreen,
  layoutBattleScreen,
  markBattleRefit,
  startBattle,
} from './screens/battle';
import {
  buildLobby,
  hideSearchPopup,
  isSearchPopupOpen,
  layoutLobby,
  lobbyEnterAnimated,
  lobbySetConnecting,
  lobbySetError,
  lobbySetReady,
  lobbySetVisible,
  lobbyShowToast,
  lobbyUpdateKen,
  openSearchPopup,
} from './screens/lobby';

const DESIGN_W = 520;

let app: Application;
let root: Container;
let bgSprite: Sprite;
let bgMask: Graphics;
let lobbyBox: Container;
let designH = 980;
let safeTop = 0;
let safeBottom = 0;
let session: PvpGameSession | null = null;
let userInfo: UserInfoData | null = null;
let wiredSession: PvpGameSession | null = null;

const roomsDeps = {
  getSession: () => session,
  getUserInfo: () => userInfo,
  toast: (msg: string) => lobbyShowToast(msg),
};

function readSafeInsets(): void {
  const probe = document.createElement('div');
  probe.style.cssText =
    'position:fixed;top:0;left:0;height:0;visibility:hidden;pointer-events:none;' +
    'padding-top:env(safe-area-inset-top);padding-bottom:env(safe-area-inset-bottom);';
  document.body.appendChild(probe);
  const cs = getComputedStyle(probe);
  safeTop = parseFloat(cs.paddingTop) || 0;
  safeBottom = parseFloat(cs.paddingBottom) || 0;
  probe.remove();
}

function waitUserInfo(gameSession: PvpGameSession, timeoutMs: number): Promise<UserInfoData> {
  return new Promise((resolve, reject) => {
    const cleanup = (): void => {
      offInfo();
      clearTimeout(timer);
    };
    const offInfo = gameSession.onUserInfo((data) => {
      cleanup();
      resolve(data);
    });
    const timer = setTimeout(() => {
      cleanup();
      reject(new Error('connect timeout'));
    }, timeoutMs);
  });
}

function wireSessionEvents(next: PvpGameSession): void {
  if (wiredSession === next) return;
  wiredSession = next;
  next.onUserInfo((data) => {
    userInfo = data;
    lobbyUpdateKen(data.ken);
  });
  next.onError((err) => {
    if (
      (err.code === GAME_ERROR_CODE.InRoom || err.code === GAME_ERROR_CODE.AlreadyInRoom) &&
      isSearchPopupOpen()
    ) {
      hideSearchPopup();
      openWaitingRoom();
    }
  });
}

async function connectToServer(): Promise<void> {
  lobbySetConnecting();
  try {
    session ??= await joinGame<ServerState, ServerMove>('war-god');
    pvp.init(session);
    initRooms(roomsDeps);
    wireSessionEvents(session);
    userInfo = await waitUserInfo(session, 8000);
    lobbySetReady(userInfo);
  } catch {
    session?.disconnect();
    session = null;
    lobbySetError();
  }
}

function startPvpQueue(): void {
  if (hasActiveRoom()) {
    openWaitingRoom();
    return;
  }
  if (session && userInfo) {
    openSearchPopup();
    pvp.startQueue();
    return;
  }
  void connectToServer().then(() => {
    if (!session || !userInfo) return;
    if (hasActiveRoom()) {
      openWaitingRoom();
      return;
    }
    openSearchPopup();
    pvp.startQueue();
  });
}

function layout(): void {
  if (battleChatFocused()) {
    markBattleRefit();
    return;
  }
  readSafeInsets();
  const winW = window.innerWidth;
  const winH = window.innerHeight;
  const scale = Math.min(winW, DESIGN_W) / DESIGN_W;
  designH = winH / scale;
  const insetTop = Math.round(safeTop / scale);
  const insetBottom = Math.round(safeBottom / scale);

  root.scale.set(scale);
  root.x = Math.round((winW - DESIGN_W * scale) / 2);
  root.y = 0;

  const bgTex = bgSprite.texture;
  const cover = Math.max(DESIGN_W / bgTex.width, designH / bgTex.height);
  bgSprite.scale.set(cover);
  bgSprite.x = (DESIGN_W - bgTex.width * cover) / 2;
  bgSprite.y = 0;
  bgMask.clear().rect(0, 0, DESIGN_W, designH).fill(0xffffff);

  layoutBattleScreen({
    designH,
    insetTop,
    insetBottom,
    safeTop,
    safeBottom,
    rootX: root.x,
    scale,
  });
  layoutLobby(designH, insetTop, insetBottom);
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

  root = new Container();
  app.stage.addChild(root);

  const bgBox = new Container();
  bgSprite = new Sprite(tex[A.bg]);
  bgMask = new Graphics();
  bgBox.addChild(bgSprite);
  bgBox.mask = bgMask;
  bgBox.addChild(bgMask);
  root.addChild(bgBox);

  buildBattleScreen(root, {
    getUserInfo: () => userInfo,
    onGameStart: () => lobbySetVisible(false),
    onRequestLayout: layout,
    onExitToLobby: () => {
      lobbyEnterAnimated();
      if (!userInfo && !session) void connectToServer();
      if (hasActiveRoom()) openWaitingRoom();
    },
    onPvpError: (text) => lobbyShowToast(text),
  });

  lobbyBox = buildLobby({
    getSession: () => session,
    onPlay: (level) => startBattle(level),
    onPvp: startPvpQueue,
    onCancelQueue: () => {
      pvp.cancelQueue();
      hideSearchPopup();
    },
    onRetry: () => void connectToServer(),
    onExit: () => bridge.exit(),
  });
  root.addChild(lobbyBox);
  initRooms(roomsDeps);

  layout();
  window.addEventListener('resize', layout);
  bridge.ready();

  if (new URLSearchParams(location.search).has('autostart')) {
    startBattle('normal');
  } else {
    void connectToServer();
  }

  Object.defineProperty(window, '__wg', {
    get: () => ({ ...battleDebug(), userInfo }),
  });
}

void main();
