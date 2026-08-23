// Chụp toàn bộ màn Cờ Tướng từ harness mock (không cần game server).
// Tự bật vite dev, mở Chrome headless, chụp từng `mock-ui.html?screen=<tên>`
// ở viewport logic 390 x 844 CSS px, DPR 2 -> PNG 780 x 1688.
//
//   node scripts/xiangqi-shots.mjs [--out <dir>] [--only <a,b,c>] [--settle-ms <ms>] [--audit-motion] [--reduced-motion]
import { spawn } from 'node:child_process';
import { mkdirSync, rmSync, writeFileSync } from 'node:fs';
import { existsSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { fileURLToPath } from 'node:url';
import { dirname, resolve } from 'node:path';
import WebSocket from 'ws';

const GAME_DIR = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const DEBUG_PORT = Number(process.env.XQ_DEBUG_PORT ?? 9224);
const VITE_PORT = Number(process.env.XQ_VITE_PORT ?? 5175);
const WIDTH = 390;
const HEIGHT = 844;
const DPR = 2;
const PROFILE_DIR = resolve(tmpdir(), 'xiangqi-shot-profile');

const CHROME_CANDIDATES = [
  process.env.CHROME_PATH,
  'C:/Program Files/Google/Chrome/Application/chrome.exe',
  'C:/Program Files (x86)/Google/Chrome/Application/chrome.exe',
  'C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe',
  '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
  '/usr/bin/google-chrome',
  '/usr/bin/chromium',
].filter(Boolean);

function args(name) {
  const idx = process.argv.indexOf(name);
  return idx === -1 ? null : process.argv[idx + 1];
}

const OUT_DIR = resolve(GAME_DIR, args('--out') ?? 'xiangqi/docs/screenshots');
const ONLY = args('--only')?.split(',').map((s) => s.trim()).filter(Boolean) ?? null;
const SETTLE_MS = Number(args('--settle-ms') ?? 900);
const AUDIT_MOTION = process.argv.includes('--audit-motion');
const REDUCED_MOTION = process.argv.includes('--reduced-motion');

const MOTION_PROBES = {
  lobby: ['.xq-lobby', '.xq-lobby .xq-logo', '.xq-cta-stack > .xq-btn'],
  'lobby-error': ['.xq-lobby-status > *'],
  'bot-setup': ['.xq-modal', '.xq-bot-duel', '.xq-modal-actions'],
  rooms: ['.xq-ranked', '.xq-room-row', '.xq-ranked-footer'],
  'rooms-empty': ['.xq-empty-state'],
  'rooms-create': ['.xq-modal-form', '.xq-modal-form .xq-field', '.xq-modal-actions'],
  'pregame-ready': ['.xq-pregame', '.xq-pregame-panel', '.xq-seat', '.xq-pregame-actions'],
  board: ['.xq-board-screen', '.xq-board-wrap', '.xq-actionbar'],
  'board-chat': ['.xq-chat', '.xq-chat-row'],
  'result-win': ['.xq-result', '.xq-result-title', '.xq-result-summary'],
  history: ['.xq-list-screen', '.xq-list-row'],
  'history-loading': ['.xq-empty-loading', '.xq-empty-loading::before'],
  leaderboard: ['.xq-list-screen', '.xq-tab-active', '.xq-list-row'],
  toast: ['.xq-toast'],
};

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

async function waitFor(label, probe, timeoutMs = 30_000) {
  const started = Date.now();
  for (;;) {
    const value = await probe();
    if (value) return value;
    if (Date.now() - started > timeoutMs) throw new Error(`timeout waiting for ${label}`);
    await sleep(200);
  }
}

class Cdp {
  constructor(ws) {
    this.ws = ws;
    this.id = 0;
    this.pending = new Map();
    ws.on('message', (raw) => {
      const msg = JSON.parse(raw.toString());
      if (msg.id && this.pending.has(msg.id)) {
        this.pending.get(msg.id)(msg);
        this.pending.delete(msg.id);
      }
    });
  }

  send(method, params = {}) {
    const id = ++this.id;
    return new Promise((resolve) => {
      this.pending.set(id, resolve);
      this.ws.send(JSON.stringify({ id, method, params }));
    });
  }

  async eval(expression) {
    const res = await this.send('Runtime.evaluate', { expression, returnByValue: true, awaitPromise: true });
    if (res.result?.exceptionDetails) throw new Error(res.result.exceptionDetails.text);
    return res.result?.result?.value;
  }

  async shot(file) {
    const res = await this.send('Page.captureScreenshot', { format: 'png', captureBeyondViewport: false });
    writeFileSync(file, Buffer.from(res.result.data, 'base64'));
  }
}

async function openPage() {
  const list = await fetch(`http://localhost:${DEBUG_PORT}/json/list`).then((r) => r.json());
  const page = list.find((t) => t.type === 'page' && t.url.includes('mock-ui'));
  if (!page) throw new Error('mock-ui page target not found');
  const cdp = new Cdp(new WebSocket(page.webSocketDebuggerUrl));
  await sleep(400);
  await cdp.send('Page.enable');
  await cdp.send('Runtime.enable');
  await cdp.send('Emulation.setDeviceMetricsOverride', {
    width: WIDTH,
    height: HEIGHT,
    deviceScaleFactor: DPR,
    mobile: true,
  });
  if (REDUCED_MOTION) {
    await cdp.send('Emulation.setEmulatedMedia', {
      features: [{ name: 'prefers-reduced-motion', value: 'reduce' }],
    });
  }
  return cdp;
}

async function main() {
  const chromePath = CHROME_CANDIDATES.find((p) => existsSync(p));
  if (!chromePath) throw new Error(`Chrome not found; set CHROME_PATH. Tried:\n${CHROME_CANDIDATES.join('\n')}`);

  mkdirSync(OUT_DIR, { recursive: true });
  rmSync(PROFILE_DIR, { recursive: true, force: true });
  mkdirSync(PROFILE_DIR, { recursive: true });

  const vite = spawn(
    process.platform === 'win32' ? 'npx.cmd' : 'npx',
    ['vite', '--port', String(VITE_PORT), '--strictPort'],
    { cwd: GAME_DIR, stdio: 'ignore', shell: process.platform === 'win32' },
  );
  const base = `http://localhost:${VITE_PORT}/xiangqi/mock-ui.html`;
  await waitFor('vite dev server', async () => {
    try {
      const res = await fetch(base);
      return res.ok;
    } catch {
      return false;
    }
  });

  const chrome = spawn(
    chromePath,
    [
      '--headless=new',
      `--remote-debugging-port=${DEBUG_PORT}`,
      `--user-data-dir=${PROFILE_DIR}`,
      `--window-size=${WIDTH},${HEIGHT}`,
      '--hide-scrollbars',
      '--no-first-run',
      '--no-default-browser-check',
      '--force-device-scale-factor=1',
      `${base}?screen=lobby`,
    ],
    { stdio: 'ignore' },
  );

  const cleanup = () => {
    chrome.kill();
    vite.kill();
  };
  process.on('exit', cleanup);
  process.on('SIGINT', () => {
    cleanup();
    process.exit(130);
  });

  await waitFor('chrome devtools', async () => {
    try {
      const res = await fetch(`http://localhost:${DEBUG_PORT}/json/version`);
      return res.ok;
    } catch {
      return false;
    }
  });

  const cdp = await openPage();
  await waitFor('mock harness', () => cdp.eval('window.__mockReady === true'));
  const screens = await cdp.eval('window.__mockScreens');
  if (!Array.isArray(screens) || screens.length === 0) throw new Error('mock harness exposed no screens');
  const wanted = ONLY ? screens.filter((s) => ONLY.includes(s)) : screens;
  const missing = ONLY ? ONLY.filter((s) => !screens.includes(s)) : [];
  if (missing.length) throw new Error(`unknown screens: ${missing.join(', ')}`);

  console.log(`${wanted.length} màn -> ${OUT_DIR}`);
  const failures = [];
  for (const screen of wanted) {
    await cdp.send('Page.navigate', { url: `${base}?screen=${screen}` });
    try {
      await waitFor(`screen ${screen}`, () => cdp.eval(`window.__mockScreen === '${screen}' && window.__mockReady === true`), 20_000);
      // Mặc định chờ animation vào chỗ; --settle-ms cho phép QA chụp giữa choreography.
      await sleep(SETTLE_MS);
      const rendered = await cdp.eval("document.querySelectorAll('.xq-app > *').length");
      if (!rendered) throw new Error('không render được screen nào');
      if (AUDIT_MOTION && MOTION_PROBES[screen]) {
        const audit = await cdp.eval(`(${JSON.stringify(MOTION_PROBES[screen])}).map((selector) => {
          const pseudo = selector.endsWith('::before') ? '::before' : null;
          const baseSelector = pseudo ? selector.slice(0, -8) : selector;
          const element = document.querySelector(baseSelector);
          const style = element ? getComputedStyle(element, pseudo) : null;
          const durationMs = style
            ? Math.max(...style.animationDuration.split(',').map((value) => {
                const duration = Number.parseFloat(value);
                return value.trim().endsWith('ms') ? duration : duration * 1000;
              }))
            : 0;
          return {
            selector,
            found: Boolean(element),
            animationName: style?.animationName ?? 'none',
            durationMs,
          };
        })`);
        const missingMotion = audit.filter((item) => !item.found || item.animationName === 'none');
        if (missingMotion.length) {
          throw new Error(`motion audit thiếu: ${missingMotion.map((item) => item.selector).join(', ')}`);
        }
        const reducedMotionLeaks = REDUCED_MOTION ? audit.filter((item) => item.durationMs > 1) : [];
        if (reducedMotionLeaks.length) {
          throw new Error(`reduced-motion còn duration >1 ms: ${reducedMotionLeaks.map((item) => item.selector).join(', ')}`);
        }
      }
      await cdp.shot(resolve(OUT_DIR, `${screen}.png`));
      console.log(
        `  ok  ${screen}.png${AUDIT_MOTION && MOTION_PROBES[screen] ? ` · motion ${MOTION_PROBES[screen].length}` : ''}${REDUCED_MOTION ? ' · reduced' : ''}`,
      );
    } catch (error) {
      failures.push(`${screen}: ${error.message}`);
      console.log(`  FAIL ${screen}: ${error.message}`);
    }
  }

  cleanup();
  if (failures.length) {
    console.error(`\n${failures.length} màn lỗi:\n${failures.join('\n')}`);
    process.exit(1);
  }
  console.log('\nSHOTS_OK');
  process.exit(0);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
