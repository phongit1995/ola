import { Application, Container, Graphics, Sprite } from 'pixi.js';
import { bridge } from '../src/sdk';
import { A, loadAssets, tex } from './assets';
import { disposeAudio } from './audio';
import { initKit } from './kit';
import { installKeyboardDismiss } from './keyboard-dismiss';
import { DESIGN_W, renderResolution, watchDevicePixelRatio } from './layout';
import { createSessionController } from './session-controller';
import { updateRoomListUser } from './rooms';
import { disposeChat } from './screens/battle/chat';
import {
  battleChatFocused,
  battleDebug,
  buildBattleScreen,
  layoutBattleScreen,
  markBattleRefit,
  startBattle,
  ultimateControlAnchor,
} from './screens/battle';
import {
  buildUltimatePicker,
  type UltimatePicker,
  type UltimateSkillId,
} from './screens/battle/ultimate-picker';
import {
  buildLobby,
  layoutLobby,
  lobbyEnterAnimated,
  lobbySetConnecting,
  lobbySetError,
  lobbySetReady,
  lobbySetVisible,
  lobbyShowToast,
  lobbyUpdateUser,
} from './screens/lobby';


let app: Application;
let root: Container;
let bgSprite: Sprite;
let bgMask: Graphics;
let lobbyBox: Container;
let designH = 980;
let safeTop = 0;
let safeBottom = 0;
let ultimatePicker: UltimatePicker;

function displayResolution(): number {
  return renderResolution(window.devicePixelRatio);
}

function setBootProgress(fraction: number): void {
  const fill = document.querySelector<HTMLElement>('#boot-loader .boot-bar-fill');
  const label = document.querySelector<HTMLElement>('#boot-loader .boot-percent');
  const percent = Math.round(fraction * 100);
  if (fill) fill.style.width = `${percent}%`;
  if (label) label.textContent = `${percent}%`;
}

function hideBootLoader(): void {
  const loader = document.getElementById('boot-loader');
  if (!loader) return;
  loader.classList.add('done');
  window.setTimeout(() => loader.remove(), 400);
}

const sessionController = createSessionController({
  setConnecting: lobbySetConnecting,
  setReady: lobbySetReady,
  setError: lobbySetError,
  updateUser: (user) => {
    lobbyUpdateUser(user);
    updateRoomListUser(user);
  },
  toast: lobbyShowToast,
});

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

function layout(): void {
  const resolution = displayResolution();
  if (app.renderer.resolution !== resolution) {
    app.renderer.resolution = resolution;
  }
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
  ultimatePicker.layout(designH, insetTop, insetBottom, ultimateControlAnchor());
  layoutLobby(designH, insetTop, insetBottom);
}

async function main(): Promise<void> {
  await document.fonts.ready;
  const disposeKeyboardDismiss = installKeyboardDismiss();

  app = new Application();
  await app.init({
    resizeTo: window,
    backgroundColor: 0x141428,
    antialias: true,
    resolution: displayResolution(),
    autoDensity: true,
    roundPixels: true,
    preference: 'webgl',
  });
  document.getElementById('app')!.appendChild(app.canvas);
  initKit(app);

  await loadAssets(setBootProgress);

  root = new Container();
  app.stage.addChild(root);

  const bgBox = new Container();
  bgSprite = new Sprite(tex[A.bg]);
  bgMask = new Graphics();
  bgBox.addChild(bgSprite);
  bgBox.mask = bgMask;
  bgBox.addChild(bgMask);
  root.addChild(bgBox);

  let pendingUltimateCast: ((skill: UltimateSkillId) => void) | null = null;
  ultimatePicker = await buildUltimatePicker((skill) => {
    const cast = pendingUltimateCast;
    pendingUltimateCast = null;
    cast?.(skill);
  });

  buildBattleScreen(root, {
    getUserInfo: sessionController.getUserInfo,
    onGameStart: () => lobbySetVisible(false),
    onRequestLayout: layout,
    onExitToLobby: () => {
      lobbyEnterAnimated();
      if (!sessionController.getUserInfo() && !sessionController.getSession()) {
        void sessionController.connect();
      }
      sessionController.openActiveRoom();
    },
    // Trận trong bàn: chơi lại nghĩa là quay về bàn cũ rồi bấm BẮT ĐẦU tiếp,
    // không còn hàng chờ để ghép trận mới.
    onReplay: () => {
      lobbyEnterAnimated();
      sessionController.openActiveRoom();
    },
    onPvpError: (text) => lobbyShowToast(text),
    onUltimateRequest: (cast) => {
      pendingUltimateCast = cast;
      ultimatePicker.open();
      return true;
    },
  });

  lobbyBox = buildLobby({
    getSession: sessionController.getSession,
    onPlay: (level) => startBattle(level),
    onRetry: () => void sessionController.connect(),
    onExit: () => bridge.exit(),
  });
  root.addChild(lobbyBox);
  root.addChild(ultimatePicker.view);
  sessionController.initRooms();

  layout();
  window.addEventListener('resize', layout);
  const disposeResolutionWatcher = watchDevicePixelRatio(window, layout);
  window.addEventListener('pagehide', (event) => {
    if (event.persisted) return;
    window.removeEventListener('resize', layout);
    disposeResolutionWatcher();
    disposeKeyboardDismiss();
    disposeAudio();
    sessionController.dispose();
    disposeChat();
  });
  bridge.ready();
  hideBootLoader();

  if (new URLSearchParams(location.search).has('autostart')) {
    startBattle('normal');
  } else {
    void sessionController.connect();
  }

  Object.defineProperty(window, '__wg', {
    get: () => ({ ...battleDebug(), userInfo: sessionController.getUserInfo() }),
  });
}

function showStartupError(error: unknown): void {
  console.error('Failed to start War God', error);
  try {
    app?.destroy({ removeView: true }, { children: true, context: true });
  } catch {
    // The renderer may only be partially initialized.
  }
  const host = document.getElementById('app');
  if (!host) return;
  host.replaceChildren();
  const panel = document.createElement('div');
  panel.className = 'startup-error';
  const message = document.createElement('p');
  message.textContent = 'Không thể tải trò chơi. Vui lòng thử lại.';
  const retry = document.createElement('button');
  retry.type = 'button';
  retry.textContent = 'THỬ LẠI';
  retry.addEventListener('click', () => location.reload());
  panel.append(message, retry);
  host.appendChild(panel);
}

void main().catch(showStartupError);
