import { fileURLToPath, URL } from 'node:url'
import path from 'node:path'
import { defineConfig, normalizePath } from 'vite'
import react from '@vitejs/plugin-react'
import obfuscator from 'vite-plugin-javascript-obfuscator'
import { viteStaticCopy } from 'vite-plugin-static-copy'

// Nguồn gốc duy nhất cho VIP icons, dùng chung cho web/admin/game (xem packages/shared/assets).
const sharedVipIcons = normalizePath(path.resolve(__dirname, '../packages/shared/assets/vip-icons/*'))

const obfuscatorPlugin = obfuscator({
  apply: 'build',
  exclude: [/node_modules/],
  options: {
    compact: true,
    simplify: true,
    identifierNamesGenerator: 'hexadecimal',
    controlFlowFlattening: true,
    controlFlowFlatteningThreshold: 0.5,
    deadCodeInjection: false,
    stringArray: true,
    stringArrayEncoding: ['base64'],
    stringArrayThreshold: 1,
    splitStrings: false,
    numbersToExpressions: false,
    selfDefending: false,
    debugProtection: false,
    disableConsoleOutput: false,
  },
})

export default defineConfig({
  plugins: [
    react(),
    obfuscatorPlugin,
    viteStaticCopy({ targets: [{ src: sharedVipIcons, dest: 'vip-icons', rename: { stripBase: true } }] }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  server: {
    port: 3006,
  },
  build: {
    sourcemap: false,
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
      },
      mangle: true,
      format: {
        comments: false,
      },
    },
  },
})
