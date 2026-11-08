import { app, BrowserWindow, dialog, shell } from 'electron';
import type { MessageBoxOptions } from 'electron';
import electronUpdater from 'electron-updater';
import type { UpdateInfo } from 'electron-updater';
import path from 'node:path';
import fs from 'node:fs';
import { applyStagedMacUpdate, clearMacUpdateLeftovers, stageMacUpdate } from './macUpdater';

const CHECK_INTERVAL_MS = 6 * 60 * 60 * 1000;

let promptedVersion: string | null = null;
let macUpdateVersion: string | null = null;

function releasesUrl(): string | null {
  try {
    const config = fs.readFileSync(path.join(process.resourcesPath, 'app-update.yml'), 'utf8');
    const owner = /^owner:\s*(\S+)/m.exec(config)?.[1];
    const repo = /^repo:\s*(\S+)/m.exec(config)?.[1];
    if (owner == null || repo == null) return null;
    return `https://github.com/${owner}/${repo}/releases`;
  } catch {
    return null;
  }
}

function noticePath(): string {
  return path.join(app.getPath('userData'), 'app-update-notice.json');
}

function wasNoticed(version: string): boolean {
  try {
    const notice = JSON.parse(fs.readFileSync(noticePath(), 'utf8')) as { version?: string };
    return notice.version === version;
  } catch {
    return false;
  }
}

function showPrompt(options: MessageBoxOptions) {
  const win = BrowserWindow.getAllWindows()[0];
  return win == null ? dialog.showMessageBox(options) : dialog.showMessageBox(win, options);
}

async function promptRestart(version: string, restart: () => void): Promise<void> {
  if (promptedVersion === version) return;
  promptedVersion = version;
  const { response } = await showPrompt({
    type: 'info',
    buttons: ['Khởi động lại', 'Bỏ qua'],
    defaultId: 0,
    cancelId: 1,
    title: 'Ola',
    message: 'Đã có bản Ola mới',
    detail: 'Khởi động lại để cập nhật ngay. Nếu bỏ qua, app sẽ tự cập nhật ở lần mở sau.',
  });
  if (response === 0) restart();
}

async function promptDownload(version: string, page: string): Promise<void> {
  if (wasNoticed(version)) return;
  fs.writeFileSync(noticePath(), JSON.stringify({ version }));
  const { response } = await showPrompt({
    type: 'info',
    buttons: ['Tải bản mới', 'Để sau'],
    defaultId: 0,
    cancelId: 1,
    title: 'Ola',
    message: 'Đã có bản Ola mới',
    detail: 'Bản này cần tải và cài thủ công.',
  });
  if (response === 0) void shell.openExternal(page);
}

async function updateMacApp(info: UpdateInfo, releases: string): Promise<void> {
  if (macUpdateVersion === info.version) return;
  macUpdateVersion = info.version;
  const page = `${releases}/latest`;
  try {
    await stageMacUpdate(info, `${releases}/download/v${info.version}/`);
  } catch (error) {
    console.warn('[update] mac staging failed:', error);
    await promptDownload(info.version, page);
    return;
  }
  await promptRestart(info.version, () => {
    try {
      applyStagedMacUpdate();
    } catch (error) {
      console.warn('[update] mac install failed:', error);
      void promptDownload(info.version, page);
      return;
    }
    app.relaunch();
    app.quit();
  });
}

export function startAppUpdater(): void {
  if (!app.isPackaged) return;
  const releases = releasesUrl();
  if (releases == null) return;

  const updater = electronUpdater.autoUpdater;
  const installsWithUpdater = process.platform === 'win32' || process.env.APPIMAGE != null;
  updater.autoDownload = installsWithUpdater;
  updater.autoInstallOnAppQuit = installsWithUpdater;
  updater.logger = console;
  updater.on('error', (error) => console.warn('[update] failed:', error.message));

  if (installsWithUpdater) {
    updater.on('update-downloaded', ({ version }) => {
      void promptRestart(version, () => updater.quitAndInstall(true, true));
    });
  } else if (process.platform === 'darwin') {
    clearMacUpdateLeftovers().catch((error) => console.warn('[update] cleanup failed:', error));
    updater.on('update-available', (info) => void updateMacApp(info, releases));
    app.on('will-quit', () => {
      try {
        applyStagedMacUpdate();
      } catch (error) {
        console.warn('[update] mac install failed:', error);
      }
    });
  } else {
    updater.on('update-available', ({ version }) => void promptDownload(version, `${releases}/latest`));
  }

  const check = () => {
    updater.checkForUpdates().catch(() => undefined);
  };
  check();
  setInterval(check, CHECK_INTERVAL_MS);
}
