import { app, net } from 'electron';
import path from 'node:path';
import fs from 'node:fs';
import crypto from 'node:crypto';
import extractZip from 'extract-zip';

// Dùng chung repo GitHub Releases với mobile nhưng tag prefix riêng, và release
// desktop PHẢI đánh --prerelease: updater mobile gọi /releases/latest (chỉ trả
// release thường mới nhất) — release desktop mà thành "latest" là mobile mù bản mới.
const OTA_REPO = 'ducphanvanntq/ola';
const TAG_PREFIX = 'desktop-v';
const ASSET_NAME = 'desktop-bundle.zip';
const RELEASES_URL =
  process.env.OLA_DESKTOP_OTA_URL ?? `https://api.github.com/repos/${OTA_REPO}/releases?per_page=30`;

interface OtaState {
  current: number;
}

interface ReleaseBody {
  shell_version: string;
  sha256: string;
  notes?: string;
}

interface GithubRelease {
  tag_name?: string;
  body?: string;
  assets?: Array<{ name: string; browser_download_url: string }>;
}

function otaRoot(): string {
  return path.join(app.getPath('userData'), 'ota');
}

function statePath(): string {
  return path.join(otaRoot(), 'state.json');
}

function bundleDir(version: number): string {
  return path.join(otaRoot(), 'bundles', String(version));
}

export function readOtaState(): OtaState {
  try {
    const raw = JSON.parse(fs.readFileSync(statePath(), 'utf8')) as Partial<OtaState>;
    if (typeof raw.current === 'number' && raw.current > 0) return { current: raw.current };
  } catch {
    // chưa từng OTA hoặc state hỏng → coi như đang chạy bundle đóng gói sẵn
  }
  return { current: 0 };
}

// Trả về dist đang hiệu lực: bundle OTA nếu có và còn nguyên vẹn, không thì
// dist đóng gói trong asar — asar read-only nên OTA bắt buộc nằm ở userData.
export function resolveWebDist(bundledDist: string): { dist: string; otaVersion: number } {
  const state = readOtaState();
  if (state.current > 0) {
    const dir = bundleDir(state.current);
    if (fs.existsSync(path.join(dir, 'index.html'))) {
      return { dist: dir, otaVersion: state.current };
    }
  }
  return { dist: bundledDist, otaVersion: 0 };
}

// Bundle OTA load fail → xoá state để lần resolve sau quay về dist trong asar.
export function rollbackToBundled(): void {
  fs.rmSync(statePath(), { force: true });
}

function parseReleases(releases: GithubRelease[]): {
  version: number;
  meta: ReleaseBody;
  downloadUrl: string;
} | null {
  for (const release of releases) {
    const tag = release.tag_name ?? '';
    if (!tag.startsWith(TAG_PREFIX)) continue;
    const version = parseInt(tag.slice(TAG_PREFIX.length), 10);
    if (Number.isNaN(version)) continue;

    let meta: ReleaseBody;
    try {
      meta = JSON.parse(release.body ?? '') as ReleaseBody;
    } catch {
      continue;
    }
    // Bundle web có thể gọi API preload/CORS mà shell cũ chưa có — chỉ nhận
    // bundle phát hành cho đúng version shell này (giống app_version bên mobile).
    if (meta.shell_version !== app.getVersion()) continue;

    const asset = release.assets?.find((item) => item.name === ASSET_NAME);
    if (!asset) continue;
    return { version, meta, downloadUrl: asset.browser_download_url };
  }
  return null;
}

async function download(url: string): Promise<Buffer> {
  const response = await net.fetch(url, { headers: { Accept: 'application/octet-stream' } });
  if (!response.ok) throw new Error(`download ${response.status}`);
  return Buffer.from(await response.arrayBuffer());
}

async function install(version: number, zip: Buffer, expectedSha256: string): Promise<void> {
  const actual = crypto.createHash('sha256').update(zip).digest('hex');
  if (actual !== expectedSha256.toLowerCase()) throw new Error('sha256 mismatch');

  const zipPath = path.join(otaRoot(), 'tmp.zip');
  const target = bundleDir(version);
  fs.mkdirSync(path.dirname(target), { recursive: true });
  fs.rmSync(target, { recursive: true, force: true });
  fs.writeFileSync(zipPath, zip);
  try {
    await extractZip(zipPath, { dir: target });
  } finally {
    fs.rmSync(zipPath, { force: true });
  }
  if (!fs.existsSync(path.join(target, 'index.html'))) {
    fs.rmSync(target, { recursive: true, force: true });
    throw new Error('bundle missing index.html');
  }

  const previous = readOtaState().current;
  fs.writeFileSync(statePath(), JSON.stringify({ current: version }));

  // Chỉ giữ bundle mới + bundle đang chạy (lỡ cần rollback tay), dọn phần còn lại.
  const keep = new Set([String(version), String(previous)]);
  const bundlesRoot = path.join(otaRoot(), 'bundles');
  for (const entry of fs.readdirSync(bundlesRoot)) {
    if (!keep.has(entry)) fs.rmSync(path.join(bundlesRoot, entry), { recursive: true, force: true });
  }
}

// Bản mới apply ở LẦN MỞ SAU (không relaunch giữa chừng phiên chat/call của user).
export async function checkForOtaUpdate(runningVersion: number): Promise<void> {
  if (!app.isPackaged && process.env.OLA_DESKTOP_OTA_FORCE !== '1') return;
  try {
    const response = await net.fetch(RELEASES_URL, {
      headers: { Accept: 'application/vnd.github.v3+json' },
    });
    if (!response.ok) return;
    const found = parseReleases((await response.json()) as GithubRelease[]);
    if (!found || found.version <= runningVersion) return;

    console.log(`[ota] downloading desktop-v${found.version}`);
    await install(found.version, await download(found.downloadUrl), found.meta.sha256);
    console.log(`[ota] desktop-v${found.version} installed, applies on next launch`);
  } catch (error) {
    console.warn('[ota] update check failed:', error);
  }
}
