import { buildSync } from 'esbuild';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

// Bundle cả dependency thuần JS (extract-zip) vào out/ — runtime không cần
// node_modules, electron-builder chỉ phải đóng gói out/ + dist/.
const shared = {
  bundle: true,
  platform: 'node',
  target: 'node22',
  external: ['electron'],
  sourcemap: true,
  logLevel: 'info',
};

buildSync({
  ...shared,
  entryPoints: [path.join(ROOT, 'src', 'main.ts')],
  format: 'esm',
  outfile: path.join(ROOT, 'out', 'main.js'),
  // Bundle ESM trên platform node: esbuild không tự polyfill require cho
  // dep CJS (extract-zip) — tự chèn createRequire.
  banner: {
    js: "import { createRequire } from 'node:module'; const require = createRequire(import.meta.url);",
  },
});

// Preload chạy trong renderer sandbox: bắt buộc CJS một file.
buildSync({
  ...shared,
  entryPoints: [path.join(ROOT, 'src', 'preload.ts')],
  format: 'cjs',
  outfile: path.join(ROOT, 'out', 'preload.cjs'),
});
