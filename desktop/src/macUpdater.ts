import { net } from 'electron';
import type { UpdateInfo } from 'electron-updater';
import { execFile } from 'node:child_process';
import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import { Readable } from 'node:stream';
import { pipeline } from 'node:stream/promises';
import type { ReadableStream } from 'node:stream/web';
import { promisify } from 'node:util';

const PUBLIC_KEY = 'MCowBQYDK2VwAyEA2SScw2Z0WpGam6RjmJinfQiUMa0Uj6skQN1Rr9Sy3gU=';
const STAGING_PREFIX = '.ola-update-';

const run = promisify(execFile);
const removeTree = (target: string) => run('/bin/rm', ['-rf', target]);

interface StagedUpdate {
  dir: string;
  app: string;
}

let staged: StagedUpdate | null = null;

function installedApp(): string {
  const appPath = path.resolve(process.execPath, '..', '..', '..');
  if (!appPath.endsWith('.app')) throw new Error('not running from an app bundle');
  fs.accessSync(appPath, fs.constants.W_OK);
  fs.accessSync(path.dirname(appPath), fs.constants.W_OK);
  return appPath;
}

function verifySignature(version: string, sha512: string, signature: string): void {
  const key = crypto.createPublicKey({
    key: Buffer.from(PUBLIC_KEY, 'base64'),
    format: 'der',
    type: 'spki',
  });
  const message = Buffer.from(`${version}\n${sha512}`);
  if (!crypto.verify(null, message, key, Buffer.from(signature, 'base64'))) {
    throw new Error('update signature mismatch');
  }
}

async function download(url: string, target: string): Promise<string> {
  const response = await net.fetch(url);
  if (!response.ok || response.body == null) throw new Error(`download ${response.status}`);
  const hash = crypto.createHash('sha512');
  await pipeline(
    Readable.fromWeb(response.body as ReadableStream<Uint8Array>),
    async function* (source: AsyncIterable<Buffer>) {
      for await (const chunk of source) {
        hash.update(chunk);
        yield chunk;
      }
    },
    fs.createWriteStream(target),
  );
  return hash.digest('base64');
}

export async function stageMacUpdate(info: UpdateInfo, releaseBase: string): Promise<void> {
  const target = installedApp();
  const file = info.files.find((item) => item.url.endsWith('.zip'));
  const { updateSignature } = info as UpdateInfo & { updateSignature?: string };
  if (file == null || updateSignature == null) throw new Error('update is not signed');
  verifySignature(info.version, file.sha512, updateSignature);

  const dir = fs.mkdtempSync(path.join(path.dirname(target), STAGING_PREFIX));
  try {
    const zip = path.join(dir, 'update.zip');
    const sha512 = await download(new URL(file.url, releaseBase).toString(), zip);
    if (sha512 !== file.sha512) throw new Error('sha512 mismatch');

    const extracted = path.join(dir, 'new');
    await run('/usr/bin/ditto', ['-x', '-k', zip, extracted]);
    fs.rmSync(zip);

    const app = path.join(extracted, path.basename(target));
    await run('/usr/bin/codesign', ['--verify', '--deep', '--strict', app]);
    staged = { dir, app };
  } catch (error) {
    await removeTree(dir);
    throw error;
  }
}

export function applyStagedMacUpdate(): void {
  if (staged == null) return;
  const { dir, app } = staged;
  const target = installedApp();
  const previous = path.join(dir, 'previous.app');
  fs.renameSync(target, previous);
  try {
    fs.renameSync(app, target);
  } catch (error) {
    fs.renameSync(previous, target);
    throw error;
  }
  staged = null;
}

export async function clearMacUpdateLeftovers(): Promise<void> {
  const parent = path.dirname(path.resolve(process.execPath, '..', '..', '..'));
  const entries = await fs.promises.readdir(parent);
  await Promise.all(
    entries
      .filter((entry) => entry.startsWith(STAGING_PREFIX))
      .map((entry) => removeTree(path.join(parent, entry))),
  );
}
