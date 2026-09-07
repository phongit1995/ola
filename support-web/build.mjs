import { readFileSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = dirname(fileURLToPath(import.meta.url));
const localesDir = resolve(root, '../packages/shared/src/i18n/locales');
const outDir = resolve(root, 'public');

const SITE_URL = 'https://ola-me.pages.dev';
const APP_NAME = 'Ola Me';
const SUPPORT_EMAIL = 'support@olachat.net';

const LOCALES = ['vi', 'en'];
const DOCS = [
  { file: 'privacy.html', namespace: 'privacyPolicy', slug: 'privacy' },
  { file: 'terms.html', namespace: 'terms', slug: 'terms' },
];

const UI = {
  vi: {
    home: 'Trang chủ',
    privacy: 'Chính sách bảo mật',
    terms: 'Điều khoản sử dụng',
    contact: 'Liên hệ',
    tagline: 'Mạng xã hội giải trí — trò chuyện, phòng cộng đồng, bảng tin và trò chơi.',
    privacyDesc: 'Cách chúng tôi thu thập, sử dụng và bảo vệ dữ liệu của bạn.',
    termsDesc: 'Quy định khi sử dụng dịch vụ, tài khoản và vật phẩm ảo.',
    contactDesc: 'Mọi câu hỏi, khiếu nại hoặc yêu cầu xóa tài khoản.',
  },
  en: {
    home: 'Home',
    privacy: 'Privacy Policy',
    terms: 'Terms of Use',
    contact: 'Contact',
    tagline: 'Entertainment social network — chat, community rooms, feed and games.',
    privacyDesc: 'How we collect, use and protect your data.',
    termsDesc: 'Rules for using the service, accounts and virtual items.',
    contactDesc: 'Any question, complaint or account deletion request.',
  },
};

const locales = Object.fromEntries(
  LOCALES.map((code) => [
    code,
    JSON.parse(readFileSync(resolve(localesDir, `${code}.json`), 'utf8')),
  ])
);

const escapeHtml = (value) =>
  String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');

const linkifyEmail = (value) =>
  escapeHtml(value).replace(
    /[\w.+-]+@[\w-]+\.[\w.]+/g,
    (email) => `<a href="mailto:${email}">${email}</a>`
  );

const renderBlock = (block) =>
  block.type === 'ul'
    ? `<ul>${block.items.map((item) => `<li>${linkifyEmail(item)}</li>`).join('')}</ul>`
    : `<p>${linkifyEmail(block.text)}</p>`;

const renderSection = (section) =>
  `<section class="card"><h2>${escapeHtml(section.title)}</h2>${section.blocks
    .map(renderBlock)
    .join('')}</section>`;

const styles = `
:root{--green:#7cb342;--green-dark:#558b2f;--green-darker:#33691e;--bg:#f0f7f0;--ink:#1f2937;--muted:#5a7a5d}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif;line-height:1.6}
a{color:var(--green-dark)}
header{background:linear-gradient(135deg,var(--green-dark),var(--green));padding:20px 0 28px}
.wrap{max-width:720px;margin:0 auto;padding:0 16px}
.topbar{display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap}
.topbar a{color:rgba(255,255,255,.92);text-decoration:none;font-size:14px}
.langs{display:flex;gap:6px}
.langs button{border:1px solid rgba(255,255,255,.55);background:transparent;color:#fff;border-radius:999px;padding:4px 12px;font-size:13px;cursor:pointer}
.langs button[aria-pressed="true"]{background:#fff;color:var(--green-darker);border-color:#fff;font-weight:700}
.hero{text-align:center;margin-top:14px}
.hero img{width:64px;height:64px;border-radius:16px;box-shadow:0 6px 18px rgba(0,0,0,.18)}
.hero h1{margin:12px 0 0;font-size:20px;letter-spacing:.5px;color:#fff}
.hero p{margin:6px 0 0;font-size:13px;color:rgba(255,255,255,.86)}
main{max-width:720px;margin:0 auto;padding:24px 16px 56px}
.updated{text-align:center;font-size:12px;color:var(--muted);margin:0 0 16px}
.card{background:#fff;border-radius:12px;padding:20px 16px;margin-bottom:16px;box-shadow:0 2px 10px rgba(0,0,0,.06)}
.card h2{margin:0 0 10px;font-size:16px;font-weight:800;letter-spacing:.4px;color:var(--green-darker)}
.card p,.card li{font-size:14px;margin:0 0 8px}
.card ul{padding-left:20px;margin:0 0 8px}
.nav-card{display:block;text-decoration:none;color:inherit}
.nav-card h2{margin-bottom:4px}
.nav-card span{font-size:13px;color:var(--muted)}
footer{padding:0 16px 24px;text-align:center;font-size:12px;color:#7a9a7d}
[data-lang]{display:none}
[data-lang].is-active{display:block}
`;

const langScript = `
(function(){
  var supported=['vi','en'];
  function apply(lang){
    if(supported.indexOf(lang)<0)lang='vi';
    document.documentElement.lang=lang;
    document.querySelectorAll('[data-lang]').forEach(function(el){
      el.classList.toggle('is-active',el.getAttribute('data-lang')===lang);
    });
    document.querySelectorAll('.langs button').forEach(function(btn){
      btn.setAttribute('aria-pressed',String(btn.dataset.setLang===lang));
    });
    var title=document.querySelector('[data-lang].is-active [data-title]');
    if(title)document.title=title.getAttribute('data-title');
    try{localStorage.setItem('ola-legal-lang',lang)}catch(e){}
  }
  var param=new URLSearchParams(location.search).get('lang');
  var stored=null;
  try{stored=localStorage.getItem('ola-legal-lang')}catch(e){}
  apply(param||stored||(navigator.language||'vi').slice(0,2));
  document.querySelectorAll('.langs button').forEach(function(btn){
    btn.addEventListener('click',function(){apply(btn.dataset.setLang)});
  });
})();
`;

const page = ({ title, description, canonical, body }) => `<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>${escapeHtml(title)}</title>
<meta name="description" content="${escapeHtml(description)}">
<link rel="canonical" href="${SITE_URL}${canonical}">
<link rel="icon" href="/favicon.png">
<link rel="apple-touch-icon" href="/apple-touch-icon.png">
<meta property="og:type" content="website">
<meta property="og:title" content="${escapeHtml(title)}">
<meta property="og:description" content="${escapeHtml(description)}">
<meta property="og:image" content="${SITE_URL}/og-image.png">
<meta property="og:url" content="${SITE_URL}${canonical}">
<meta name="twitter:card" content="summary_large_image">
<style>${styles}</style>
</head>
<body>
${body}
<script>${langScript}</script>
</body>
</html>
`;

const topbar = (code, current) => {
  const ui = UI[code];
  const link = (href, label, active) =>
    active
      ? `<span style="color:#fff;font-weight:700;font-size:14px">${label}</span>`
      : `<a href="${href}">${label}</a>`;
  return `<div class="topbar">
<nav style="display:flex;gap:14px;flex-wrap:wrap">
${link('/', ui.home, current === 'home')}
${link('/privacy', ui.privacy, current === 'privacy')}
${link('/terms', ui.terms, current === 'terms')}
</nav>
<div class="langs">
<button type="button" data-set-lang="vi" aria-pressed="false">Tiếng Việt</button>
<button type="button" data-set-lang="en" aria-pressed="false">English</button>
</div>
</div>`;
};

const buildDoc = ({ namespace, slug, file }) => {
  const body = LOCALES.map((code) => {
    const doc = locales[code][namespace];
    const title = `${doc.title} — ${APP_NAME}`;
    return `<div data-lang="${code}">
<span hidden data-title="${escapeHtml(title)}"></span>
<header>
<div class="wrap">
${topbar(code, slug)}
<div class="hero">
<img src="/favicon.png" alt="${APP_NAME}">
<h1>${escapeHtml(doc.title)}</h1>
<p>${escapeHtml(doc.subtitle)}</p>
</div>
</div>
</header>
<main>
<p class="updated">${escapeHtml(doc.updated)}</p>
${doc.sections.map(renderSection).join('\n')}
</main>
<footer>${escapeHtml(doc.footer)}</footer>
</div>`;
  }).join('\n');

  writeFileSync(
    resolve(outDir, file),
    page({
      title: `${locales.vi[namespace].title} — ${APP_NAME}`,
      description: locales.vi[namespace].sections[0].blocks[0].text ?? APP_NAME,
      canonical: `/${slug}`,
      body,
    })
  );
};

const buildHome = () => {
  const body = LOCALES.map((code) => {
    const ui = UI[code];
    return `<div data-lang="${code}">
<span hidden data-title="${escapeHtml(`${APP_NAME} — ${ui.privacy} &amp; ${ui.terms}`)}"></span>
<header>
<div class="wrap">
${topbar(code, 'home')}
<div class="hero">
<img src="/favicon.png" alt="${APP_NAME}">
<h1>${APP_NAME}</h1>
<p>${escapeHtml(ui.tagline)}</p>
</div>
</div>
</header>
<main>
<a class="card nav-card" href="/privacy?lang=${code}"><h2>${escapeHtml(ui.privacy)}</h2><span>${escapeHtml(ui.privacyDesc)}</span></a>
<a class="card nav-card" href="/terms?lang=${code}"><h2>${escapeHtml(ui.terms)}</h2><span>${escapeHtml(ui.termsDesc)}</span></a>
<section class="card"><h2>${escapeHtml(ui.contact)}</h2><p>${escapeHtml(ui.contactDesc)}</p><p><a href="mailto:${SUPPORT_EMAIL}">${SUPPORT_EMAIL}</a></p></section>
</main>
<footer>${escapeHtml(locales[code].privacyPolicy.footer)}</footer>
</div>`;
  }).join('\n');

  writeFileSync(
    resolve(outDir, 'index.html'),
    page({
      title: `${APP_NAME} — ${UI.vi.privacy} & ${UI.vi.terms}`,
      description: UI.vi.tagline,
      canonical: '/',
      body,
    })
  );
};

buildHome();
DOCS.forEach(buildDoc);

writeFileSync(
  resolve(outDir, 'robots.txt'),
  `User-agent: *\nAllow: /\nSitemap: ${SITE_URL}/sitemap.xml\n`
);

const today = new Date().toISOString().slice(0, 10);
writeFileSync(
  resolve(outDir, 'sitemap.xml'),
  `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${['/', '/privacy', '/terms']
  .map((path) => `  <url><loc>${SITE_URL}${path}</loc><lastmod>${today}</lastmod></url>`)
  .join('\n')}
</urlset>
`
);

console.log('Built: index.html, privacy.html, terms.html, robots.txt, sitemap.xml');
