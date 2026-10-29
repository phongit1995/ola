import { defineConfig, normalizePath, type Plugin } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import obfuscator from 'vite-plugin-javascript-obfuscator'
import { viteStaticCopy } from 'vite-plugin-static-copy'
import fs from 'node:fs'
import path from 'node:path'

// Nguồn gốc duy nhất cho VIP icons, dùng chung cho web/admin/game (xem packages/shared/assets).
const sharedVipIcons = normalizePath(path.resolve(__dirname, '../packages/shared/assets/vip-icons/*'))

const SITE_URL = 'https://olachat.net'

// Trang công khai có trong sitemap: mỗi trang cần canonical riêng trong HTML gốc, nginx phục vụ qua `$uri.html`.
const seoPages = [
  {
    path: '/tai-app',
    title: 'Tải ứng dụng Ola Chat — Nhắn tin, nghe gọi, chơi game trên điện thoại',
    description:
      'Cài Ola trên điện thoại để nhận thông báo tin nhắn ngay lập tức, nghe gọi và chơi game mượt hơn.',
  },
  {
    path: '/dieu-khoan',
    title: 'Điều khoản sử dụng — Ola Chat',
    description:
      'Điều khoản sử dụng mạng xã hội Ola: điều kiện tài khoản, quy tắc ứng xử, nội dung người dùng, vật phẩm ảo KEN/VIP và quyền riêng tư.',
  },
  {
    path: '/chinh-sach-bao-mat',
    title: 'Chính sách bảo mật — Ola Chat',
    description:
      'Chính sách bảo mật của Ola Chat: thông tin được thu thập, cách sử dụng và bảo vệ dữ liệu, chia sẻ với bên thứ ba và quyền của bạn với dữ liệu cá nhân.',
  },
]

function escapeAttribute(value: string) {
  return value.replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;')
}

function withPageMeta(html: string, page: (typeof seoPages)[number]) {
  const url = `${SITE_URL}${page.path}`
  const title = escapeAttribute(page.title)
  const description = escapeAttribute(page.description)
  const replacements: [RegExp, string][] = [
    [/(<title>)[^<]*/, title],
    [/(<link rel="canonical" href=")[^"]*/, url],
    [/(property="og:url"\s+content=")[^"]*/, url],
    [/(name="description"\s+content=")[^"]*/, description],
    [/(property="og:title"\s+content=")[^"]*/, title],
    [/(property="og:description"\s+content=")[^"]*/, description],
    [/(name="twitter:title"\s+content=")[^"]*/, title],
    [/(name="twitter:description"\s+content=")[^"]*/, description],
  ]
  return replacements.reduce((out, [pattern, value]) => {
    if (!pattern.test(out)) throw new Error(`seo-pages: index.html thiếu thẻ khớp ${pattern}`)
    return out.replace(pattern, (_match, prefix: string) => prefix + value)
  }, html)
}

const seoPagesPlugin: Plugin = {
  name: 'ola-seo-pages',
  apply: 'build',
  writeBundle(options) {
    const dir = options.dir ?? path.resolve(__dirname, 'dist')
    const html = fs.readFileSync(path.join(dir, 'index.html'), 'utf-8')
    for (const page of seoPages) {
      fs.writeFileSync(path.join(dir, `${page.path.slice(1)}.html`), withPageMeta(html, page))
    }
  },
}

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
    seoPagesPlugin,
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
