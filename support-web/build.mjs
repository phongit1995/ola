import { createHash } from 'node:crypto';
import { readFileSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  APP_NAME,
  CHANNELS,
  DOWNLOADS,
  FORM,
  INTRO,
  NAV,
  PAGES,
  PUBLISHER,
  SITE_URL,
  SUPPORT_EMAIL,
  UI,
} from './content.mjs';

const root = dirname(fileURLToPath(import.meta.url));
const localesDir = resolve(root, '../packages/shared/src/i18n/locales');
const outDir = resolve(root, 'public');

const LOCALES = ['vi', 'en'];

const I18N_DOCS = [
  { file: 'privacy.html', namespace: 'privacyPolicy', slug: 'privacy' },
  { file: 'terms.html', namespace: 'terms', slug: 'terms' },
];

const STATIC_DOCS = [
  { file: 'support.html', key: 'support', slug: 'support' },
  { file: 'delete-account.html', key: 'delete-account', slug: 'delete-account' },
  { file: 'child-safety.html', key: 'child-safety', slug: 'child-safety' },
];

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

const linkify = (value) =>
  escapeHtml(value)
    .replace(
      /[\w.+-]+@[\w-]+\.[\w.]+/g,
      (email) => `<a href="mailto:${email}">${email}</a>`
    )
    .replace(
      /trang Xoá tài khoản/g,
      '<a href="/delete-account">trang Xoá tài khoản</a>'
    )
    .replace(
      /the Delete account page/g,
      'the <a href="/delete-account">Delete account</a> page'
    );

const renderChannels = () =>
  `<ul class="links">${CHANNELS.map(
    (channel) =>
      `<li><a href="${channel.href}" target="_blank" rel="noopener">${escapeHtml(
        channel.label
      )}</a></li>`
  ).join('')}<li><a href="mailto:${SUPPORT_EMAIL}">${SUPPORT_EMAIL}</a></li></ul>`;

const renderDownloads = (code) => {
  const ios = code === 'vi' ? 'iOS — TestFlight' : 'iOS — TestFlight';
  const android =
    code === 'vi'
      ? `Android — tải APK (${DOWNLOADS.androidSize})`
      : `Android — download APK (${DOWNLOADS.androidSize})`;
  return `<ul class="links">
<li><a href="${DOWNLOADS.ios}" target="_blank" rel="noopener">${escapeHtml(ios)}</a></li>
<li><a href="${DOWNLOADS.android}" target="_blank" rel="noopener">${escapeHtml(android)}</a></li>
</ul>`;
};

const renderForm = (code) => {
  const form = FORM[code];
  const id = (field) => `df-${code}-${field}`;
  return `<form class="deletion-form" data-lang-code="${code}" novalidate>
<div class="field">
<label for="${id('username')}">${escapeHtml(form.usernameLabel)}</label>
<input id="${id('username')}" name="username" type="text" autocomplete="username" required placeholder="${escapeHtml(form.usernamePlaceholder)}">
</div>
<div class="field">
<label for="${id('email')}">${escapeHtml(form.emailLabel)}</label>
<input id="${id('email')}" name="email" type="email" autocomplete="email" required placeholder="${escapeHtml(form.emailPlaceholder)}">
</div>
<div class="field">
<label for="${id('note')}">${escapeHtml(form.noteLabel)}</label>
<textarea id="${id('note')}" name="note" rows="3" placeholder="${escapeHtml(form.notePlaceholder)}"></textarea>
</div>
<label class="check"><input type="checkbox" name="confirm"> <span>${escapeHtml(form.confirm)}</span></label>
<input class="trap" type="text" name="website" tabindex="-1" autocomplete="off" aria-hidden="true">
<p class="form-error" hidden></p>
<button type="submit">${escapeHtml(form.submit)}</button>
</form>
<div class="form-success" hidden>
<h3>${escapeHtml(form.successTitle)}</h3>
<p>${escapeHtml(form.successText)}</p>
</div>`;
};

const renderBlock = (block, code) => {
  if (block.type === 'form') return renderForm(code);
  if (block.type === 'ul') {
    return `<ul>${block.items.map((item) => `<li>${linkify(item)}</li>`).join('')}</ul>`;
  }
  if (block.type === 'ol') {
    return `<ol>${block.items.map((item) => `<li>${linkify(item)}</li>`).join('')}</ol>`;
  }
  if (block.type === 'faq') {
    return block.items
      .map(
        (item) =>
          `<div class="faq"><h3>${escapeHtml(item.q)}</h3><p>${linkify(item.a)}</p></div>`
      )
      .join('');
  }
  if (block.type === 'note') {
    return `<p class="note">${linkify(block.text)}</p>`;
  }
  if (block.type === 'channels') return renderChannels();
  if (block.type === 'downloads') return renderDownloads(code);
  return `<p>${linkify(block.text)}</p>`;
};

const renderSection = (section, code) =>
  `<section class="card"><h2>${escapeHtml(section.title)}</h2>${section.blocks
    .map((block) => renderBlock(block, code))
    .join('')}</section>`;

const renderPublisher = (code) => {
  if (!PUBLISHER.name) return '';
  const title = code === 'vi' ? 'Nhà phát hành' : 'Publisher';
  const address = PUBLISHER.address
    ? `<p>${escapeHtml(PUBLISHER.address)}</p>`
    : '';
  return `<section class="card"><h2>${title}</h2><p>${escapeHtml(
    PUBLISHER.name
  )}</p>${address}<p><a href="mailto:${SUPPORT_EMAIL}">${SUPPORT_EMAIL}</a></p></section>`;
};

const styles = `
:root{--green:#7cb342;--green-dark:#558b2f;--green-darker:#33691e;--bg:#f0f7f0;--ink:#1f2937;--muted:#5a7a5d}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif;line-height:1.6}
a{color:var(--green-dark)}
header{background:linear-gradient(135deg,var(--green-dark),var(--green));padding:20px 0 28px}
.wrap{max-width:720px;margin:0 auto;padding:0 16px}
.topbar{display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap}
.topbar nav{display:flex;gap:14px;flex-wrap:wrap}
.topbar a,.topbar strong{color:rgba(255,255,255,.92);text-decoration:none;font-size:13px;font-weight:400}
.topbar strong{color:#fff;font-weight:700}
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
.card h3{margin:16px 0 4px;font-size:14px;font-weight:700;color:var(--ink)}
.card p,.card li{font-size:14px;margin:0 0 8px}
.card ul,.card ol{padding-left:20px;margin:0 0 8px}
.card ol li{margin-bottom:8px}
.faq:first-of-type h3{margin-top:0}
.faq p{color:#374151}
.note{background:#fff8e1;border-left:3px solid #f0b429;border-radius:6px;padding:10px 12px;color:#5c4400}
ul.links{list-style:none;padding:0;margin:12px 0 0;display:flex;flex-wrap:wrap;gap:8px}
ul.links li{margin:0}
ul.links a{display:inline-block;background:var(--bg);border:1px solid #d8e6d8;border-radius:8px;padding:8px 14px;text-decoration:none;font-weight:600}
.field{margin-bottom:14px}
.field label{display:block;font-size:12px;font-weight:700;letter-spacing:.4px;text-transform:uppercase;color:var(--muted);margin-bottom:6px}
.field input,.field textarea{width:100%;font:inherit;font-size:14px;color:var(--ink);background:#fff;border:1px solid #cfe0cf;border-radius:8px;padding:10px 12px}
.field input:focus,.field textarea:focus{outline:2px solid var(--green);outline-offset:1px;border-color:var(--green)}
.field textarea{resize:vertical;min-height:76px}
.check{display:flex;gap:10px;align-items:flex-start;font-size:13px;color:#374151;margin-bottom:14px}
.check input{margin-top:3px;width:16px;height:16px;accent-color:var(--green-dark);flex:none}
.trap{position:absolute;left:-9999px;width:1px;height:1px;opacity:0}
.deletion-form button{width:100%;font:inherit;font-size:15px;font-weight:700;color:#fff;background:var(--green-dark);border:0;border-radius:10px;padding:12px 16px;cursor:pointer}
.deletion-form button:hover{background:var(--green-darker)}
.form-error{background:#fdecea;border-left:3px solid #d93025;border-radius:6px;padding:10px 12px;color:#8c1d16;font-size:13px}
.form-success{background:#eaf6e6;border:1px solid #bfe0b5;border-radius:10px;padding:16px}
.form-success h3{margin:0 0 6px;font-size:15px;font-weight:800;color:var(--green-darker)}
.form-success p{margin:0 0 6px;font-size:14px}
.lead{font-size:15px;color:#374151}
.group-title{margin:28px 0 12px;font-size:13px;font-weight:800;letter-spacing:1px;text-transform:uppercase;color:var(--muted)}
ul.features{list-style:none;padding:0;margin:0;display:grid;grid-template-columns:repeat(auto-fit,minmax(210px,1fr));gap:14px}
ul.features li{margin:0;display:grid;grid-template-columns:28px 1fr;column-gap:10px;row-gap:2px;align-items:start}
ul.features .ico{grid-row:span 2;font-size:20px;line-height:1.2}
ul.features strong{font-size:14px}
ul.features li>span:last-child{font-size:13px;color:var(--muted)}
ol.steps{list-style:none;counter-reset:step;padding:0;margin:0}
ol.steps li{counter-increment:step;position:relative;padding-left:38px;margin-bottom:14px}
ol.steps li::before{content:counter(step);position:absolute;left:0;top:1px;width:26px;height:26px;border-radius:50%;background:var(--green-dark);color:#fff;font-size:13px;font-weight:700;display:flex;align-items:center;justify-content:center}
ol.steps strong{display:block;font-size:14px}
ol.steps span{font-size:13px;color:var(--muted)}
.nav-card{display:block;text-decoration:none;color:inherit}
.nav-card h2{margin-bottom:4px}
.nav-card span{font-size:13px;color:var(--muted)}
footer{padding:0 16px 24px;text-align:center;font-size:12px;color:#7a9a7d}
[data-lang="en"]{display:none}
html.js-ready [data-lang]{display:none}
html.js-ready [data-lang].is-active{display:block}
`;

const langScript = `
(function(){
  var supported=['vi','en'];
  function apply(lang){
    if(supported.indexOf(lang)<0)lang='vi';
    document.documentElement.lang=lang;
    document.documentElement.classList.add('js-ready');
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

const formScript = `
(function(){
  var MESSAGES=${JSON.stringify(
    Object.fromEntries(
      LOCALES.map((code) => [
        code,
        {
          errUsername: FORM[code].errUsername,
          errEmail: FORM[code].errEmail,
          errConfirm: FORM[code].errConfirm,
        },
      ])
    )
  )};
  var USERNAME=/^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$/;
  var EMAIL=/^[^\\s@]+@[^\\s@]+\\.[^\\s@]{2,}$/;
  document.querySelectorAll('.deletion-form').forEach(function(form){
    var text=MESSAGES[form.dataset.langCode];
    var errorBox=form.querySelector('.form-error');
    var success=form.parentElement.querySelector('.form-success');
    function fail(message){errorBox.textContent=message;errorBox.hidden=false}
    form.addEventListener('submit',function(event){
      event.preventDefault();
      errorBox.hidden=true;
      var username=form.username.value.trim();
      var email=form.email.value.trim();
      if(!USERNAME.test(username))return fail(text.errUsername);
      if(!EMAIL.test(email))return fail(text.errEmail);
      if(!form.confirm.checked)return fail(text.errConfirm);
      form.hidden=true;
      success.hidden=false;
      success.scrollIntoView({block:'center',behavior:'smooth'});
    });
  });
})();
`;

const appScript = `${langScript}
${formScript}`;

const assetVersion = (content) =>
  createHash('sha256').update(content).digest('hex').slice(0, 8);

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
<link rel="stylesheet" href="/styles.css?v=${assetVersion(styles)}">
</head>
<body>
${body}
<script src="/app.js?v=${assetVersion(appScript)}" defer></script>
</body>
</html>
`;

const topbar = (code, current) => {
  const ui = UI[code];
  const items = NAV.map((item) =>
    item.slug === current
      ? `<strong>${escapeHtml(ui[item.key])}</strong>`
      : `<a href="${item.href}">${escapeHtml(ui[item.key])}</a>`
  ).join('');
  return `<div class="topbar">
<nav>${items}</nav>
<div class="langs">
<button type="button" data-set-lang="vi" aria-pressed="false">Tiếng Việt</button>
<button type="button" data-set-lang="en" aria-pressed="false">English</button>
</div>
</div>`;
};

const documentBody = ({ code, slug, doc, extra = '' }) => {
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
${doc.sections.map((section) => renderSection(section, code)).join('\n')}
${extra}
</main>
<footer>${escapeHtml(doc.footer)}</footer>
</div>`;
};

const firstText = (doc) => {
  const block = doc.sections[0].blocks[0];
  if (block.type === 'p') return block.text;
  if (block.type === 'ol' || block.type === 'ul') return block.items[0];
  return doc.subtitle;
};

const buildI18nDoc = ({ namespace, slug, file }) => {
  const body = LOCALES.map((code) =>
    documentBody({ code, slug, doc: locales[code][namespace] })
  ).join('\n');

  writeFileSync(
    resolve(outDir, file),
    page({
      title: `${locales.vi[namespace].title} — ${APP_NAME}`,
      description: firstText(locales.vi[namespace]),
      canonical: `/${slug}`,
      body,
    })
  );
};

const buildStaticDoc = ({ key, slug, file }) => {
  const body = LOCALES.map((code) =>
    documentBody({
      code,
      slug,
      doc: PAGES[key][code],
      extra: key === 'support' ? renderPublisher(code) : '',
    })
  ).join('\n');

  writeFileSync(
    resolve(outDir, file),
    page({
      title: `${PAGES[key].vi.title} — ${APP_NAME}`,
      description: firstText(PAGES[key].vi),
      canonical: `/${slug}`,
      body,
    })
  );
};

const buildHome = () => {
  const cards = [
    { key: 'support', href: '/support', desc: 'supportDesc' },
    { key: 'deleteAccount', href: '/delete-account', desc: 'deleteAccountDesc' },
    { key: 'privacy', href: '/privacy', desc: 'privacyDesc' },
    { key: 'terms', href: '/terms', desc: 'termsDesc' },
    { key: 'childSafety', href: '/child-safety', desc: 'childSafetyDesc' },
  ];

  const body = LOCALES.map((code) => {
    const ui = UI[code];
    const intro = INTRO[code];

    const navCards = cards
      .map(
        (card) =>
          `<a class="card nav-card" href="${card.href}?lang=${code}"><h2>${escapeHtml(
            ui[card.key]
          )}</h2><span>${escapeHtml(ui[card.desc])}</span></a>`
      )
      .join('\n');

    const features = intro.features
      .map(
        (feature) =>
          `<li><span class="ico" aria-hidden="true">${feature.icon}</span><strong>${escapeHtml(
            feature.name
          )}</strong><span>${escapeHtml(feature.desc)}</span></li>`
      )
      .join('');

    const steps = intro.steps
      .map(
        (step) =>
          `<li><strong>${escapeHtml(step.name)}</strong><span>${escapeHtml(step.desc)}</span></li>`
      )
      .join('');

    return `<div data-lang="${code}">
<span hidden data-title="${escapeHtml(`${APP_NAME} — ${intro.headline}`)}"></span>
<header>
<div class="wrap">
${topbar(code, 'home')}
<div class="hero">
<img src="/favicon.png" alt="${APP_NAME}">
<h1>${APP_NAME}</h1>
<p>${escapeHtml(intro.headline)}</p>
</div>
</div>
</header>
<main>
<section class="card"><p class="lead">${escapeHtml(intro.lead)}</p>${renderDownloads(code)}</section>

<section class="card"><h2>${escapeHtml(intro.aboutTitle)}</h2>${intro.about
      .map((paragraph) => `<p>${escapeHtml(paragraph)}</p>`)
      .join('')}<p class="note">${escapeHtml(intro.ageNote)}</p></section>

<section class="card"><h2>${escapeHtml(
      intro.featuresTitle
    )}</h2><ul class="features">${features}</ul></section>

<section class="card"><h2>${escapeHtml(
      intro.stepsTitle
    )}</h2><ol class="steps">${steps}</ol></section>

<section class="card"><h2>${escapeHtml(intro.downloadTitle)}</h2><p>${escapeHtml(
      intro.downloadDesc
    )}</p>${renderDownloads(code)}</section>

<h2 class="group-title">${escapeHtml(intro.linksTitle)}</h2>
${navCards}

<section class="card"><h2>${escapeHtml(ui.contact)}</h2><p>${escapeHtml(
      ui.contactDesc
    )}</p>${renderChannels()}</section>
${renderPublisher(code)}
</main>
<footer>${escapeHtml(locales[code].privacyPolicy.footer)}</footer>
</div>`;
  }).join('\n');

  writeFileSync(
    resolve(outDir, 'index.html'),
    page({
      title: `${APP_NAME} — ${INTRO.vi.headline}`,
      description: INTRO.vi.lead,
      canonical: '/',
      body,
    })
  );
};

const NOT_FOUND = {
  vi: { title: 'KHÔNG TÌM THẤY TRANG', text: 'Đường dẫn bạn mở không tồn tại.' },
  en: { title: 'PAGE NOT FOUND', text: 'The page you opened does not exist.' },
};

const buildNotFound = () => {
  const body = LOCALES.map((code) => {
    const ui = UI[code];
    const notFound = NOT_FOUND[code];
    return `<div data-lang="${code}">
<span hidden data-title="${escapeHtml(`${notFound.title} — ${APP_NAME}`)}"></span>
<header>
<div class="wrap">
${topbar(code, '')}
<div class="hero">
<img src="/favicon.png" alt="${APP_NAME}">
<h1>${escapeHtml(notFound.title)}</h1>
<p>${escapeHtml(notFound.text)}</p>
</div>
</div>
</header>
<main>
<a class="card nav-card" href="/?lang=${code}"><h2>${escapeHtml(ui.home)}</h2><span>${escapeHtml(ui.tagline)}</span></a>
<a class="card nav-card" href="/support?lang=${code}"><h2>${escapeHtml(ui.support)}</h2><span>${escapeHtml(ui.supportDesc)}</span></a>
</main>
<footer>${escapeHtml(locales[code].privacyPolicy.footer)}</footer>
</div>`;
  }).join('\n');

  writeFileSync(
    resolve(outDir, '404.html'),
    page({
      title: `${NOT_FOUND.vi.title} — ${APP_NAME}`,
      description: NOT_FOUND.vi.text,
      canonical: '/',
      body,
    })
  );
};

writeFileSync(resolve(outDir, 'styles.css'), `${styles.trim()}\n`);
writeFileSync(resolve(outDir, 'app.js'), `${appScript.trim()}\n`);

buildHome();
buildNotFound();
I18N_DOCS.forEach(buildI18nDoc);
STATIC_DOCS.forEach(buildStaticDoc);

writeFileSync(
  resolve(outDir, 'robots.txt'),
  `User-agent: *\nAllow: /\nSitemap: ${SITE_URL}/sitemap.xml\n`
);

const today = new Date().toISOString().slice(0, 10);
writeFileSync(
  resolve(outDir, 'sitemap.xml'),
  `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${NAV.map(
  (item) =>
    `  <url><loc>${SITE_URL}${item.href === '/' ? '/' : item.href}</loc><lastmod>${today}</lastmod></url>`
).join('\n')}
</urlset>
`
);

console.log(
  'Built: index.html, support.html, delete-account.html, child-safety.html, privacy.html, terms.html, 404.html, styles.css, app.js, robots.txt, sitemap.xml'
);
