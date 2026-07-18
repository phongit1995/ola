import { Application, Container, Graphics, Sprite } from 'pixi.js';
import { bridge, joinGame, type GameSession, type UserInfoData } from '../src/sdk';
import { A, loadAssets, tex } from './assets';
import { initKit } from './kit';
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
  layoutLobby,
  lobbySetConnecting,
  lobbySetError,
  lobbySetReady,
  lobbySetVisible,
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
let session: GameSession | null = null;
let userInfo: UserInfoData | null = null;

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

function waitUserInfo(gameSession: GameSession, timeoutMs: number): Promise<UserInfoData> {
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

async function connectToServer(): Promise<void> {
  lobbySetConnecting();
  try {
    session ??= await joinGame('war-god');
    userInfo = await waitUserInfo(session, 8000);
    lobbySetReady(userInfo);
  } catch {
    session?.disconnect();
    session = null;
    lobbySetError();
  }
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
  });

  lobbyBox = buildLobby({
    onPlay: (level) => startBattle(level),
    onRetry: () => void connectToServer(),
    onExit: () => bridge.exit(),
  });
  root.addChild(lobbyBox);

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
