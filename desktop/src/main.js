import { app, BrowserWindow, protocol, session, shell, net } from 'electron';
import path from 'node:path';
import fs from 'node:fs';
import { fileURLToPath, pathToFileURL } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const IS_DEV = process.env.OLA_DESKTOP_DEV === '1';
const IS_SMOKE = process.env.OLA_DESKTOP_SMOKE === '1';
const DEV_URL = process.env.OLA_DESKTOP_DEV_URL ?? 'http://localhost:3005';

const WEB_FIXED_WIDTH = 520;
const APP_SCHEME = 'app';
const APP_ORIGIN = `${APP_SCHEME}://ola`;
const WEB_DIST = path.join(__dirname, '..', 'dist');

// Origin mà server đã allow trong CORS_ALLOWED_ORIGINS (xem env.production).
const SERVER_ALLOWED_ORIGIN = 'https://olachat.net';
const API_URL_FILTERS = ['https://api.olachat.net/*', 'http://localhost:8080/*'];

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
    const filePath = path.join(WEB_DIST, relative);
    const inside = filePath === WEB_DIST || filePath.startsWith(WEB_DIST + path.sep);
    // SPA fallback: đường dẫn không phải file tĩnh (route của BrowserRouter) → index.html
    const target =
      inside && relative !== '' && fs.existsSync(filePath) && fs.statSync(filePath).isFile()
        ? filePath
        : path.join(WEB_DIST, 'index.html');
    return net.fetch(pathToFileURL(target).toString());
  });
}

function setupSession(ses) {
  // App chạy dưới origin app://ola (hoặc http://localhost khi dev) nên server sẽ chặn CORS.
  // Giả Origin thành domain đã được allow, và nới ACAO ở response để renderer chấp nhận.
  ses.webRequest.onBeforeSendHeaders({ urls: API_URL_FILTERS }, (details, callback) => {
    const headers = { ...details.requestHeaders };
    if (headers['Origin'] != null || details.resourceType === 'xhr') {
      headers['Origin'] = SERVER_ALLOWED_ORIGIN;
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

  if (IS_DEV) {
    win.loadURL(DEV_URL);
    win.webContents.openDevTools({ mode: 'detach' });
  } else {
    win.loadURL(`${APP_ORIGIN}/`);
  }

  return win;
}

app.whenReady().then(() => {
  // macOS bỏ qua BrowserWindow.icon; khi chưa đóng gói phải set dock icon tay,
  // bản đóng gói thì electron-builder đã nhúng icns từ build/icon.png.
  if (process.platform === 'darwin' && !app.isPackaged) {
    app.dock?.setIcon(path.join(__dirname, '..', 'build', 'icon.png'));
  }
  if (!IS_DEV) registerAppProtocol();
  setupSession(session.defaultSession);
  createWindow();

  if (IS_SMOKE) {
    setTimeout(async () => {
      const win = BrowserWindow.getAllWindows()[0];
      const shot = process.env.OLA_DESKTOP_SMOKE_SHOT;
      if (win != null && shot) {
        const image = await win.webContents.capturePage();
        fs.writeFileSync(shot, image.toPNG());
      }
      console.log('OLA_DESKTOP_SMOKE_TITLE:', win?.getTitle());
      console.log('OLA_DESKTOP_SMOKE_OK');
      app.quit();
    }, 5000);
  }

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});
