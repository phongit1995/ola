import { defineConfig, normalizePath, type Plugin } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import obfuscator from 'vite-plugin-javascript-obfuscator'
import { viteStaticCopy } from 'vite-plugin-static-copy'
import fs from 'node:fs'
import path from 'node:path'
import { ROUTES, STATIC_PAGES } from './src/shared/constants/routes'

// Nguồn gốc duy nhất cho VIP icons, dùng chung cho web/admin/game (xem packages/shared/assets).
const sharedVipIcons = normalizePath(path.resolve(__dirname, '../packages/shared/assets/vip-icons/*'))

const SITE_URL = 'https://olachat.net'

// Trang công khai có trong sitemap: mỗi trang cần canonical riêng trong HTML gốc, nginx phục vụ qua `$uri.html`.
const seoPages = [
  {
    path: '/tai-app',
    title: 'Tải app Ola Me (Ola Chat) miễn phí cho Android và iPhone',
    description:
      'Tải Ola Me, app của mạng xã hội Ola Chat, miễn phí trên Google Play và App Store: kết bạn, chia sẻ khoảnh khắc, nhắn tin, gọi video và nhận thông báo ngay trên điện thoại.',
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

const HOME_STATIC_PATTERN = /<main id="home-static">[\s\S]*?<\/main>/
const VI_LOCALE_PATH = path.resolve(__dirname, '../packages/shared/src/i18n/locales/vi.json')

interface GuestHomeCopy {
  title: string
  lead: string
  featuresTitle: string
  features: Record<string, { title: string; description: string }>
  explore: string
  about: string
  blog: string
  socialNetwork: string
  findFriends: string
  shareMoments: string
  chatRooms: string
  download: string
  terms: string
  privacy: string
}

function homeStaticHtml() {
  const locale = JSON.parse(fs.readFileSync(VI_LOCALE_PATH, 'utf-8'))
  const copy: GuestHomeCopy = locale.guestHome
  const link = ([href, label]: [string, string]) => `<a href="${href}">${escapeAttribute(label)}</a>`
  const topics: [string, string][] = [
    [STATIC_PAGES.socialNetwork, copy.socialNetwork],
    [STATIC_PAGES.findFriends, copy.findFriends],
    [STATIC_PAGES.shareMoments, copy.shareMoments],
    [STATIC_PAGES.chatRooms, copy.chatRooms],
    [STATIC_PAGES.blog, copy.blog],
    [STATIC_PAGES.about, copy.about],
  ]
  const legal: [string, string][] = [
    [ROUTES.downloadApp, copy.download],
    [ROUTES.terms, copy.terms],
    [ROUTES.privacy, copy.privacy],
  ]
  const features = Object.values(copy.features)
    .map((feature) => `<li><strong>${escapeAttribute(feature.title)}</strong> — ${escapeAttribute(feature.description)}</li>`)
    .join('')
  return [
    '<main id="home-static">',
    `<h1>${escapeAttribute(copy.title)}</h1>`,
    `<p>${escapeAttribute(copy.lead)}</p>`,
    `<p>${link([ROUTES.login, locale.login.submit])} · ${link([ROUTES.register, locale.login.createAccount])}</p>`,
    `<h2>${escapeAttribute(copy.featuresTitle)}</h2>`,
    `<ul>${features}</ul>`,
    `<h2>${escapeAttribute(copy.explore)}</h2>`,
    `<nav>${topics.map(link).join(' · ')}</nav>`,
    `<nav>${legal.map(link).join(' · ')}</nav>`,
    '</main>',
  ].join('')
}

const homeStaticPlugin: Plugin = {
  name: 'ola-home-static',
  transformIndexHtml(html) {
    const root = '<div id="root"></div>'
    if (!html.includes(root)) throw new Error('home-static: index.html thiếu <div id="root"></div>')
    return html.replace(root, `<div id="root">${homeStaticHtml()}</div>`)
  },
}

function withoutHomeStatic(html: string) {
  if (!HOME_STATIC_PATTERN.test(html)) throw new Error('seo-pages: index.html thiếu khối home-static')
  return html.replace(HOME_STATIC_PATTERN, '')
}

const seoPagesPlugin: Plugin = {
  name: 'ola-seo-pages',
  apply: 'build',
  writeBundle(options) {
    const dir = options.dir ?? path.resolve(__dirname, 'dist')
    const html = fs.readFileSync(path.join(dir, 'index.html'), 'utf-8')
    for (const page of seoPages) {
      fs.writeFileSync(path.join(dir, `${page.path.slice(1)}.html`), withPageMeta(withoutHomeStatic(html), page))
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
    homeStaticPlugin,
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
