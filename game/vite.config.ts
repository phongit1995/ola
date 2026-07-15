import { resolve } from 'path';
import { defineConfig } from 'vite';

export default defineConfig({
  build: {
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
