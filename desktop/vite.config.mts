import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { defineConfig, mergeConfig } from 'vite';
import webConfig from '../web/vite.config';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const WEB_DIR = path.resolve(__dirname, '..', 'web');

// Vite của desktop chạy trên source web/ nhưng env đọc riêng tại desktop/.env*
// (envDir) — dev dùng .env.development, đóng gói dùng .env.production.
export default mergeConfig(
  webConfig,
  defineConfig({
    root: WEB_DIR,
    envDir: __dirname,
    cacheDir: path.join(WEB_DIR, 'node_modules', '.vite-desktop'),
    build: {
      outDir: path.resolve(__dirname, 'dist'),
      emptyOutDir: true,
    },
  }),
);
