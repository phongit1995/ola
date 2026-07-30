import { resolve } from 'path';
import { defineConfig, normalizePath } from 'vite';
import react from '@vitejs/plugin-react';
import { viteStaticCopy } from 'vite-plugin-static-copy';

// Nguồn gốc duy nhất cho asset dùng chung (xem packages/shared/assets).
const sharedAssets = resolve(__dirname, '../packages/shared/assets');

export default defineConfig({
  plugins: [
    react(),
    viteStaticCopy({
      targets: [
        { src: normalizePath(`${sharedAssets}/vip-icons/*`), dest: 'vip-icons', rename: { stripBase: true } },
        { src: normalizePath(`${sharedAssets}/ola_smiley_online.png`), dest: '.', rename: { stripBase: true } },
      ],
    }),
  ],
  resolve: {
    alias: {
      '@ola/shared': resolve(__dirname, '../packages/shared/src'),
    },
  },
  build: {
    assetsInlineLimit(filePath) {
      // Caro controls image priority at runtime; data-URI inlining would force
      // even modal-only icons into the initial JavaScript chunk.
      return normalizePath(filePath).includes('/game/caro/assets/') ? false : undefined;
    },
    rollupOptions: {
      input: {
        hub: resolve(__dirname, 'index.html'),
        caro: resolve(__dirname, 'caro/index.html'),
        wargod: resolve(__dirname, 'war-god/index.html'),
      },
    },
  },
  server: {
    port: 5174,
    proxy: {
      '/socket.io': {
        target: 'http://localhost:8082',
        ws: true,
      },
    },
  },
});
