import {
  APP_STORE_ID,
  APP_STORE_URL,
  FANPAGE_URL,
  LEGAL_LINKS,
  LOGO_URL,
  OG_IMAGE_URL,
  PLAY_STORE_URL,
  SITE_URL,
  TIKTOK_URL,
  TOPICS,
} from './site.mjs';

const WORDS_PER_MINUTE = 200;

export function escapeHtml(value) {
  return value
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

export function stripTags(value) {
  return value
    .replace(/<[^>]+>/g, '')
    .replace(/&amp;/g, '&')
    .replace(/&quot;/g, '"')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .trim();
}

function indent(text, spaces) {
  const pad = ' '.repeat(spaces);
  return text
    .split('\n')
    .map((line) => (line === '' ? line : pad + line))
    .join('\n');
}

function jsonLd(graph) {
  const text = JSON.stringify({ '@context': 'https://schema.org', '@graph': graph }, null, 2);
  return indent(text, 6);
}

function organizationRef() {
  return { '@type': 'Organization', '@id': `${SITE_URL}/#organization`, name: 'Ola Chat', url: `${SITE_URL}/` };
}

function websiteRef() {
  return { '@type': 'WebSite', '@id': `${SITE_URL}/#website`, name: 'Ola Chat', url: `${SITE_URL}/` };
}

function breadcrumb(items) {
  return {
    '@type': 'BreadcrumbList',
    itemListElement: items.map(([name, item], index) => ({
      '@type': 'ListItem',
      position: index + 1,
      name,
      item,
    })),
  };
}

function faqPage(faq) {
  return {
    '@type': 'FAQPage',
    mainEntity: faq.map(([question, answer]) => ({
      '@type': 'Question',
      name: stripTags(question),
      acceptedAnswer: { '@type': 'Answer', text: stripTags(answer) },
    })),
  };
}

function appEntities() {
  const publisher = { '@id': `${SITE_URL}/#organization` };
  const offers = { '@type': 'Offer', price: '0', priceCurrency: 'VND' };
  return [
    {
      '@type': 'WebApplication',
      '@id': `${SITE_URL}/#webapp`,
      name: 'Ola Chat',
      url: `${SITE_URL}/`,
      applicationCategory: 'SocialNetworkingApplication',
      operatingSystem: 'Web',
      inLanguage: 'vi-VN',
      offers,
      publisher,
    },
    {
      '@type': 'MobileApplication',
      '@id': `${SITE_URL}/#android`,
      name: 'Ola Me',
      operatingSystem: 'Android',
      applicationCategory: 'SocialNetworkingApplication',
      downloadUrl: PLAY_STORE_URL,
      installUrl: PLAY_STORE_URL,
      inLanguage: 'vi-VN',
      offers,
      publisher,
    },
    {
      '@type': 'MobileApplication',
      '@id': `${SITE_URL}/#ios`,
      name: 'Ola Me',
      operatingSystem: 'iOS 15.1+',
      applicationCategory: 'SocialNetworkingApplication',
      downloadUrl: APP_STORE_URL,
      installUrl: APP_STORE_URL,
      inLanguage: 'vi-VN',
      offers,
      publisher,
    },
  ];
}

function formatDate(isoDate) {
  const [year, month, day] = isoDate.split('-');
  return `${day}/${month}/${year}`;
}

function head({ url, title, description, graph, ogType = 'website' }) {
  const safeTitle = escapeHtml(title);
  const safeDescription = escapeHtml(description);
  return `  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/png" href="/favicon.png" />
    <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
    <meta name="theme-color" content="#7cb342" />
    <meta name="apple-itunes-app" content="app-id=${APP_STORE_ID}" />

    <title>${safeTitle}</title>
    <meta name="description" content="${safeDescription}" />
    <meta name="robots" content="index, follow" />
    <link rel="canonical" href="${url}" />

    <meta property="og:type" content="${ogType}" />
    <meta property="og:site_name" content="Ola Chat" />
    <meta property="og:url" content="${url}" />
    <meta property="og:title" content="${safeTitle}" />
    <meta property="og:description" content="${safeDescription}" />
    <meta property="og:image" content="${OG_IMAGE_URL}" />
    <meta property="og:locale" content="vi_VN" />

    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="${safeTitle}" />
    <meta name="twitter:description" content="${safeDescription}" />
    <meta name="twitter:image" content="${OG_IMAGE_URL}" />

    <link rel="stylesheet" href="/landing.css" />
    <script defer src="/landing.js"></script>

    <script type="application/ld+json">
${jsonLd(graph)}
    </script>
  </head>`;
}

function crumbNav(items) {
  const parts = items.map(([label, href]) => (href ? `<a href="${href}">${label}</a>` : `<span>${label}</span>`));
  return `      <nav class="crumb" aria-label="Breadcrumb">
        ${parts.join(' › ')}
      </nav>`;
}

function siteHeader() {
  return `      <header>
        <a class="brand" href="/">
          <img src="/apple-touch-icon.png" alt="Logo Ola Chat" width="36" height="36" />
          <span>Ola Chat</span>
        </a>
        <a class="login" href="/">Đăng nhập</a>
      </header>`;
}

function stores(spaces) {
  return indent(
    `<div class="stores">
  <a class="store" href="${PLAY_STORE_URL}" rel="noopener" target="_blank" data-track="store_click" data-store="android">
    <small>Tải Ola Me trên</small>
    <strong>Google Play</strong>
  </a>
  <a class="store" href="${APP_STORE_URL}" rel="noopener" target="_blank" data-track="store_click" data-store="ios">
    <small>Tải Ola Me trên</small>
    <strong>App Store</strong>
  </a>
</div>
<p class="stores-note">App trên điện thoại tên <strong>Ola Me</strong>, dùng chung tài khoản với Ola Chat trên web.</p>`,
    spaces,
  );
}

function ctaButtons(spaces) {
  return indent(
    `<div class="cta">
  <a class="btn btn-primary" href="/register" data-track="cta_click" data-cta="register">Đăng ký miễn phí</a>
  <a class="btn btn-outline" href="/" data-track="cta_click" data-cta="open_web">Dùng Ola Chat trên web</a>
</div>`,
    spaces,
  );
}

function section(cls, inner) {
  return `        <section class="${cls}">
${inner}
        </section>`;
}

function landingSection(data, alt) {
  const cls = alt ? 'block alt' : 'block';
  const lines = [];
  if (data.eyebrow) lines.push(`          <p class="eyebrow">${data.eyebrow}</p>`);
  lines.push(`          <h2>${data.h2}</h2>`);
  if (data.lead) lines.push(`          <p class="section-lead">${data.lead}</p>`);
  if (data.type === 'cards') {
    lines.push(`          <div class="${data.three ? 'grid three' : 'grid'}">`);
    for (const [icon, title, body] of data.items) {
      lines.push('            <article class="card">');
      lines.push(`              <div class="ic" aria-hidden="true">${icon}</div>`);
      lines.push(`              <h3>${title}</h3>`);
      lines.push(`              <p>${body}</p>`);
      lines.push('            </article>');
    }
    lines.push('          </div>');
  } else if (data.type === 'steps') {
    lines.push('          <div class="steps">');
    data.items.forEach(([title, body], index) => {
      lines.push('            <div class="step">');
      lines.push(`              <div class="num">${index + 1}</div>`);
      lines.push(`              <h3>${title}</h3>`);
      lines.push(`              <p>${body}</p>`);
      lines.push('            </div>');
    });
    lines.push('          </div>');
  } else if (data.type === 'prose') {
    lines.push('          <div class="prose">');
    for (const paragraph of data.paragraphs) lines.push(`            <p>${paragraph}</p>`);
    lines.push('          </div>');
  } else if (data.type === 'list') {
    lines.push('          <ul class="tips">');
    for (const [title, body] of data.items) lines.push(`            <li><strong>${title}</strong> ${body}</li>`);
    lines.push('          </ul>');
  }
  return section(cls, lines.join('\n'));
}

function faqSection(title, faq, alt) {
  const items = faq.map(
    ([question, answer], index) => `          <details${index === 0 ? ' open' : ''}>
            <summary>${question}</summary>
            <p>${answer}</p>
          </details>`,
  );
  return section(
    alt ? 'block alt' : 'block',
    `          <p class="eyebrow">Câu hỏi thường gặp</p>
          <h2>${title}</h2>
${items.join('\n')}`,
  );
}

function relatedSection(currentPath, alt, extraLinks = []) {
  const links = [...extraLinks, ...TOPICS.filter(([path]) => path !== currentPath)].map(
    ([path, label, hint]) => `            <a href="${path}">${label}<span>${hint}</span></a>`,
  );
  return section(
    alt ? 'block alt' : 'block',
    `          <p class="eyebrow">Khám phá thêm</p>
          <h2>Tìm hiểu thêm về Ola Chat</h2>
          <div class="related">
${links.join('\n')}
          </div>`,
  );
}

function finalCta(title, text) {
  return `        <section class="final">
          <h2>${title}</h2>
          <p>${text}</p>
          <a class="btn btn-primary" href="/register" data-track="cta_click" data-cta="register">Tạo tài khoản miễn phí</a>
        </section>`;
}

function siteFooter() {
  const links = [...TOPICS.map(([path, label]) => [path, label]), ...LEGAL_LINKS]
    .map(([path, label]) => `          <a href="${path}">${label}</a>`)
    .join('\n');
  return `      <footer>
        <div class="links">
${links}
          <a href="${FANPAGE_URL}" rel="noopener" target="_blank">Fanpage Facebook</a>
          <a href="${TIKTOK_URL}" rel="noopener" target="_blank">TikTok</a>
        </div>
        <p>© Ola Chat — mạng xã hội kết bạn, trò chuyện và chia sẻ khoảnh khắc của người Việt.</p>
      </footer>`;
}

function documentHtml(headHtml, bodyInner) {
  return `<!doctype html>
<html lang="vi">
${headHtml}
  <body>
    <div class="wrap">
${bodyInner}
    </div>
  </body>
</html>
`;
}

export function renderLanding(page) {
  const url = SITE_URL + page.path;
  const graph = [
    {
      '@type': 'WebPage',
      '@id': `${url}#webpage`,
      url,
      name: page.title,
      description: page.description,
      inLanguage: 'vi-VN',
      isPartOf: websiteRef(),
      about: organizationRef(),
    },
    ...(page.apps ? appEntities() : []),
    breadcrumb([
      ['Trang chủ', `${SITE_URL}/`],
      [page.crumb, url],
    ]),
    faqPage(page.faq),
  ];
  const sections = [];
  let alt = true;
  for (const data of page.sections) {
    sections.push(landingSection(data, alt));
    alt = !alt;
  }
  sections.push(faqSection(page.faq_title, page.faq, alt));
  sections.push(relatedSection(page.path, !alt));
  const pills = page.pills.map((pill) => `            <span class="pill">${pill}</span>`).join('\n');
  const body = `${crumbNav([
    ['Trang chủ', '/'],
    [page.crumb, null],
  ])}

${siteHeader()}

      <main>
        <section class="hero">
          <img src="/apple-touch-icon.png" alt="${escapeHtml(page.hero_alt)}" width="88" height="88" />
          <p class="eyebrow">${page.eyebrow}</p>
          <h1>${page.h1}</h1>
          <p class="lead">${page.lead}</p>
${ctaButtons(10)}
${stores(10)}
          <div class="stats">
${pills}
          </div>
        </section>

${sections.join('\n\n')}

${finalCta(page.final_title, page.final_text)}
      </main>

${siteFooter()}`;
  return documentHtml(head({ url, title: page.title, description: page.description, graph }), body);
}

function articleBlock(block) {
  if (block.p) return `          <p>${block.p}</p>`;
  if (block.h3) return `          <h3>${block.h3}</h3>`;
  if (block.ul) return `          <ul>\n${block.ul.map((item) => `            <li>${item}</li>`).join('\n')}\n          </ul>`;
  if (block.ol) return `          <ol>\n${block.ol.map((item) => `            <li>${item}</li>`).join('\n')}\n          </ol>`;
  if (block.note) return `          <p class="note">${block.note}</p>`;
  throw new Error(`blog: khối không hợp lệ ${JSON.stringify(block)}`);
}

function postText(post) {
  const blocks = post.sections.flatMap((item) => [item.h2, ...item.blocks.map((block) => Object.values(block).flat().join(' '))]);
  return stripTags([post.h1, ...post.intro, ...blocks].join(' '));
}

export function readMinutes(post) {
  return Math.max(1, Math.round(postText(post).split(/\s+/).length / WORDS_PER_MINUTE));
}

export function postUrl(post) {
  return `${SITE_URL}/blog/${post.slug}/`;
}

export function renderPost(post, allPosts) {
  const url = postUrl(post);
  const graph = [
    {
      '@type': 'BlogPosting',
      '@id': `${url}#article`,
      headline: post.h1,
      description: post.description,
      image: OG_IMAGE_URL,
      datePublished: post.published,
      dateModified: post.updated,
      inLanguage: 'vi-VN',
      mainEntityOfPage: url,
      author: organizationRef(),
      publisher: { ...organizationRef(), logo: { '@type': 'ImageObject', url: LOGO_URL } },
      isPartOf: { '@type': 'Blog', '@id': `${SITE_URL}/blog/#blog`, name: 'Blog Ola Chat', url: `${SITE_URL}/blog/` },
    },
    breadcrumb([
      ['Trang chủ', `${SITE_URL}/`],
      ['Blog', `${SITE_URL}/blog/`],
      [post.crumb, url],
    ]),
    faqPage(post.faq),
  ];
  const toc = post.sections.map((item) => `              <li><a href="#${item.id}">${item.h2}</a></li>`).join('\n');
  const sections = post.sections
    .map((item) => [`          <h2 id="${item.id}">${item.h2}</h2>`, ...item.blocks.map(articleBlock)].join('\n'))
    .join('\n\n');
  const otherPosts = allPosts
    .filter((other) => other.slug !== post.slug)
    .map((other) => [`/blog/${other.slug}/`, other.crumb, other.description]);
  const body = `${crumbNav([
    ['Trang chủ', '/'],
    ['Blog', '/blog/'],
    [post.crumb, null],
  ])}

${siteHeader()}

      <main>
        <article class="article">
          <p class="eyebrow">Blog Ola Chat</p>
          <h1>${post.h1}</h1>
          <p class="post-meta">Đội ngũ Ola Chat · Cập nhật <time datetime="${post.updated}">${formatDate(post.updated)}</time> · ${readMinutes(post)} phút đọc</p>
${post.intro.map((paragraph) => `          <p>${paragraph}</p>`).join('\n')}
          <nav class="toc" aria-label="Mục lục">
            <p>Mục lục</p>
            <ol>
${toc}
            </ol>
          </nav>

${sections}

          <aside class="callout">
            <h2>${post.cta_title}</h2>
            <p>${post.cta_text}</p>
${ctaButtons(12)}
${stores(12)}
          </aside>
        </article>

${faqSection(post.faq_title, post.faq, true)}

${relatedSection(`/blog/${post.slug}/`, false, otherPosts)}
      </main>

${siteFooter()}`;
  return documentHtml(head({ url, title: post.title, description: post.description, graph, ogType: 'article' }), body);
}

export function renderBlogIndex(posts) {
  const url = `${SITE_URL}/blog/`;
  const title = 'Blog Ola Chat — Mẹo kết bạn, bắt chuyện và dùng mạng xã hội';
  const description =
    'Blog của Ola Chat: mẹo làm quen bạn mới qua mạng, cách bắt chuyện tự nhiên, kết bạn an toàn và dùng mạng xã hội vui hơn mỗi ngày.';
  const graph = [
    {
      '@type': 'Blog',
      '@id': `${url}#blog`,
      name: 'Blog Ola Chat',
      url,
      description,
      inLanguage: 'vi-VN',
      publisher: organizationRef(),
      blogPost: posts.map((post) => ({
        '@type': 'BlogPosting',
        headline: post.h1,
        url: postUrl(post),
        datePublished: post.published,
      })),
    },
    breadcrumb([
      ['Trang chủ', `${SITE_URL}/`],
      ['Blog', url],
    ]),
  ];
  const cards = posts
    .map(
      (post) => `            <a href="/blog/${post.slug}/">
              <strong>${post.h1}</strong>
              <span>${post.description}</span>
              <small><time datetime="${post.published}">${formatDate(post.published)}</time> · ${readMinutes(post)} phút đọc</small>
            </a>`,
    )
    .join('\n');
  const body = `${crumbNav([
    ['Trang chủ', '/'],
    ['Blog', null],
  ])}

${siteHeader()}

      <main>
        <section class="hero">
          <p class="eyebrow">Blog</p>
          <h1>Blog Ola Chat</h1>
          <p class="lead">Mẹo làm quen bạn mới, cách bắt chuyện tự nhiên và kết bạn an toàn trên mạng xã hội, từ đội ngũ Ola Chat.</p>
        </section>

        <section class="block">
          <h2>Bài viết mới</h2>
          <div class="post-list">
${cards}
          </div>
        </section>

${relatedSection('/blog/', true)}

${finalCta('Thử Ola Chat ngay', 'Tạo tài khoản miễn phí để kết bạn, chia sẻ khoảnh khắc và trò chuyện cùng cộng đồng.')}
      </main>

${siteFooter()}`;
  return documentHtml(head({ url, title, description, graph }), body);
}
