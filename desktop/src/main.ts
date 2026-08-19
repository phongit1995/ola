import { app, BrowserWindow, ipcMain, Menu, protocol, session, shell, net } from 'electron';
import path from 'node:path';
import fs from 'node:fs';
import { fileURLToPath, pathToFileURL } from 'node:url';
import { checkForOtaUpdate, resolveWebDist, rollbackToBundled } from './updater';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const IS_DEV = process.env.OLA_DESKTOP_DEV === '1';
const IS_SMOKE = process.env.OLA_DESKTOP_SMOKE === '1';
const DEV_URL = process.env.OLA_DESKTOP_DEV_URL ?? 'http://localhost:3005';

const WEB_FIXED_WIDTH = 520;
const APP_SCHEME = 'app';
const APP_ORIGIN = `${APP_SCHEME}://ola`;
const BUNDLED_DIST = path.join(__dirname, '..', 'dist');

// Cho smoke test trỏ userData vào thư mục tạm để dựng state OTA giả.
if (process.env.OLA_DESKTOP_USERDATA) {
  app.setPath('userData', process.env.OLA_DESKTOP_USERDATA);
}

// dist đang phục vụ: bundle OTA ở userData nếu có, không thì dist trong asar.
let activeWebDist = BUNDLED_DIST;
let activeOtaVersion = 0;

// Origin mà server đã allow trong CORS_ALLOWED_ORIGINS (env.production /
// env.development ở root) — mỗi API host giả một origin nằm trong allowlist đó.
const ORIGIN_BY_API_HOST: Record<string, string> = {
  'api.olachat.net': 'https://olachat.net',
  'api-dev.olachat.net': 'https://chat-dev.olachat.net',
  'localhost:8080': 'http://localhost:3005',
};
// Cần cả wss:// vì handshake websocket không khớp pattern https:// —
// socket.io server cũng check Origin theo đúng allowlist CORS.
const API_URL_FILTERS = [
  'https://api.olachat.net/*',
  'wss://api.olachat.net/*',
  'https://api-dev.olachat.net/*',
  'wss://api-dev.olachat.net/*',
  'http://localhost:8080/*',
  'ws://localhost:8080/*',
];

protocol.registerSchemesAsPrivileged([
  {
    scheme: APP_SCHEME,
    privileges: { standard: true, secure: true, supportFetchAPI: true, stream: true },
  },
]);

function registerAppProtocol() {
  protocol.handle(APP_SCHEME, (request) => {
    const { pathname } = new URL(request.url);
    const relative = path.posix.normalize(decodeURIComponent(pathname)).replace(/^\/+/, '');
    const filePath = path.join(activeWebDist, relative);
    const inside = filePath === activeWebDist || filePath.startsWith(activeWebDist + path.sep);
    // SPA fallback: đường dẫn không phải file tĩnh (route của BrowserRouter) → index.html
    const target =
      inside && relative !== '' && fs.existsSync(filePath) && fs.statSync(filePath).isFile()
        ? filePath
        : path.join(activeWebDist, 'index.html');
    return net.fetch(pathToFileURL(target).toString());
  });
}

function setupSession(ses: Electron.Session) {
  // App chạy dưới origin app://ola (hoặc http://localhost khi dev) nên server sẽ chặn CORS.
  // Giả Origin thành domain đã được allow, và nới ACAO ở response để renderer chấp nhận.
  ses.webRequest.onBeforeSendHeaders({ urls: API_URL_FILTERS }, (details, callback) => {
    const headers = { ...details.requestHeaders };
    const spoofed = ORIGIN_BY_API_HOST[new URL(details.url).host];
    if (spoofed != null && (headers['Origin'] != null || details.resourceType === 'xhr')) {
      headers['Origin'] = spoofed;
    }
    callback({ requestHeaders: headers });
  });

  ses.webRequest.onHeadersReceived({ urls: API_URL_FILTERS }, (details, callback) => {
    const headers = { ...details.responseHeaders };
    for (const key of Object.keys(headers)) {
      if (/^access-control-allow-origin$/i.test(key)) delete headers[key];
    }
    headers['Access-Control-Allow-Origin'] = ['*'];
    callback({ responseHeaders: headers });
  });

  ses.setPermissionRequestHandler((_wc, permission, callback) => {
    const allowed = ['media', 'clipboard-sanitized-write', 'fullscreen', 'notifications'];
    callback(allowed.includes(permission));
  });

  ses.setPermissionCheckHandler((_wc, permission) => {
    return ['media', 'clipboard-sanitized-write', 'fullscreen', 'notifications'].includes(permission);
  });
}

function createWindow() {
  // Web fix khung max-w-[520px] (web/src/App.tsx) — khoá ngang đúng khổ đó, chỉ cho giãn dọc.
  const win = new BrowserWindow({
    useContentSize: true,
    width: WEB_FIXED_WIDTH,
    height: 820,
    minWidth: WEB_FIXED_WIDTH,
    maxWidth: WEB_FIXED_WIDTH,
    minHeight: 600,
    backgroundColor: '#ffffff',
    title: 'Ola Chat',
    icon: path.join(
      __dirname,
      '..',
      'build',
      process.platform === 'win32' ? 'icon-win.png' : 'icon.png',
    ),
    webPreferences: {
      preload: path.join(__dirname, 'preload.cjs'),
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: true,
      spellcheck: false,
    },
  });

  // Web đổi document.title (SEO dài dòng) — desktop giữ cố định "Ola Chat".
  win.on('page-title-updated', (event) => {
    event.preventDefault();
  });

  win.webContents.setWindowOpenHandler(({ url }) => {
    if (/^https?:\/\//.test(url)) shell.openExternal(url);
    return { action: 'deny' };
  });

  win.webContents.on('will-navigate', (event, url) => {
    const isInternal = url.startsWith(APP_ORIGIN) || (IS_DEV && url.startsWith(DEV_URL));
    if (!isInternal) {
      event.preventDefault();
      if (/^https?:\/\//.test(url)) shell.openExternal(url);
    }
  });

  // Bundle OTA hỏng nửa chừng (thiếu asset, giải nén dở...) → quay về dist
  // trong asar ngay trong phiên này thay vì trắng màn.
  win.webContents.on('did-fail-load', (_event, errorCode, _desc, _url, isMainFrame) => {
    if (!isMainFrame || errorCode === -3 || activeOtaVersion === 0) return;
    console.warn(`[ota] bundle v${activeOtaVersion} failed to load, rolling back to packaged dist`);
    rollbackToBundled();
    activeWebDist = BUNDLED_DIST;
    activeOtaVersion = 0;
    win.loadURL(`${APP_ORIGIN}/`);
  });

  if (IS_DEV) {
    win.loadURL(DEV_URL);
    win.webContents.openDevTools({ mode: 'detach' });
  } else {
    win.loadURL(`${APP_ORIGIN}/`);
  }

  return win;
}

app.whenReady().then(() => {
  // Win/Linux: bỏ menu bar File/Edit/View. macOS giữ menu hệ thống vì
  // Cmd+C/V/Q đi qua accelerator của menu, bỏ là mất phím tắt.
  if (process.platform !== 'darwin') {
    Menu.setApplicationMenu(null);
  }
  // macOS bỏ qua BrowserWindow.icon; khi chưa đóng gói phải set dock icon tay,
  // bản đóng gói thì electron-builder đã nhúng icns từ build/icon.png.
  if (process.platform === 'darwin' && !app.isPackaged) {
    app.dock?.setIcon(path.join(__dirname, '..', 'build', 'icon.png'));
  }

  if (!IS_DEV) {
    const resolved = resolveWebDist(BUNDLED_DIST);
    activeWebDist = resolved.dist;
    activeOtaVersion = resolved.otaVersion;
    if (activeOtaVersion > 0) console.log(`[ota] serving bundle desktop-v${activeOtaVersion}`);
    registerAppProtocol();
  }

  ipcMain.handle('ola-desktop:info', () => ({
    platform: process.platform,
    version: app.getVersion(),
    otaVersion: activeOtaVersion,
  }));

  setupSession(session.defaultSession);
  createWindow();

  if (!IS_DEV) void checkForOtaUpdate(activeOtaVersion);

  if (IS_SMOKE) {
    setTimeout(async () => {
      const win = BrowserWindow.getAllWindows()[0];
      const shot = process.env.OLA_DESKTOP_SMOKE_SHOT;
      if (win != null && shot) {
        const image = await win.webContents.capturePage();
        fs.writeFileSync(shot, image.toPNG());
      }
      // Probe CORS: fetch từ renderer (origin app://ola) tới API để chắc
      // Origin spoof hoạt động — ERR Failed to fetch nghĩa là bị chặn CORS.
      const probeUrl = process.env.OLA_DESKTOP_SMOKE_FETCH;
      if (win != null && probeUrl) {
        const script = probeUrl.startsWith('ws')
          ? `new Promise((res) => {
               const w = new WebSocket(${JSON.stringify(probeUrl)});
               w.onopen = () => { w.close(); res('WS OPEN'); };
               w.onerror = () => res('WS ERR');
               setTimeout(() => res('WS TIMEOUT'), 8000);
             })`
          : `fetch(${JSON.stringify(probeUrl)}).then((r) => 'HTTP ' + r.status).catch((e) => 'ERR ' + e.message)`;
        const result = await win.webContents.executeJavaScript(script);
        console.log('OLA_DESKTOP_SMOKE_FETCH:', result);
      }
      console.log('OLA_DESKTOP_SMOKE_DIST:', activeWebDist);
      console.log('OLA_DESKTOP_SMOKE_TITLE:', win?.getTitle());
      console.log('OLA_DESKTOP_SMOKE_OK');
      app.quit();
    }, 5000);
  }

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

// Đóng cửa sổ là thoát hẳn (kể cả macOS) — không giữ app chạy ngầm ở dock.
app.on('window-all-closed', () => {
  app.quit();
});
