import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import path from 'node:path'

export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      '@api': path.resolve(__dirname, './src/shared/api'),
      '@config': path.resolve(__dirname, './src/shared/config'),
      '@constants': path.resolve(__dirname, './src/shared/constants'),
      '@lib': path.resolve(__dirname, './src/shared/lib'),
      '@hooks': path.resolve(__dirname, './src/shared/hooks'),
      '@services': path.resolve(__dirname, './src/shared/services'),
      '@app-types': path.resolve(__dirname, './src/shared/types'),
      '@components': path.resolve(__dirname, './src/shared/components'),
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3005,
    host: true,
  },
})
