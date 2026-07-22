import { defineConfig, normalizePath } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import obfuscator from 'vite-plugin-javascript-obfuscator'
import { viteStaticCopy } from 'vite-plugin-static-copy'
import path from 'node:path'

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
    reservedStrings: ['Panel$', 'Page$', 'MediaViewer$', 'Overlay$', '^heic2any$'],
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
    tailwindcss(),
    obfuscatorPlugin,
    viteStaticCopy({ targets: [{ src: sharedVipIcons, dest: 'vip-icons', rename: { stripBase: true } }] }),
  ],
  resolve: {
    dedupe: ['react', 'react-dom'],
    alias: {
      '@api': path.resolve(__dirname, '../packages/shared/src/api'),
      '@config': path.resolve(__dirname, './src/shared/config'),
      '@constants': path.resolve(__dirname, './src/shared/constants'),
      '@lib': path.resolve(__dirname, './src/shared/lib'),
      '@hooks': path.resolve(__dirname, './src/shared/hooks'),
      '@services': path.resolve(__dirname, '../packages/shared/src/services'),
      '@app-types': path.resolve(__dirname, '../packages/shared/src/types'),
      '@components': path.resolve(__dirname, './src/shared/components'),
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3005,
    host: true,
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
