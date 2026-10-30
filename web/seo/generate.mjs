import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { LANDING_PAGES } from './content/landing.mjs';
import { BLOG_POSTS } from './content/blog.mjs';
import { renderBlogIndex, renderLanding, renderPost } from './render.mjs';
import { APP_ROUTES_IN_SITEMAP, DEFAULT_LASTMOD, SITE_URL } from './site.mjs';

const PUBLIC_DIR = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../public');

function writePage(urlPath, html) {
  const target = path.join(PUBLIC_DIR, urlPath, 'index.html');
  fs.mkdirSync(path.dirname(target), { recursive: true });
  fs.writeFileSync(target, html);
  console.log(`wrote ${path.relative(process.cwd(), target)}`);
}

function sitemapEntry({ path: urlPath, lastmod = DEFAULT_LASTMOD, changefreq, priority }) {
  return `  <url>
    <loc>${SITE_URL}${urlPath}</loc>
    <lastmod>${lastmod}</lastmod>
    <changefreq>${changefreq}</changefreq>
    <priority>${priority}</priority>
  </url>`;
}

function writeSitemap(posts) {
  const latestPost = posts.reduce((latest, post) => (post.updated > latest ? post.updated : latest), DEFAULT_LASTMOD);
  const entries = [
    ...APP_ROUTES_IN_SITEMAP,
    ...LANDING_PAGES.map((page) => ({
      path: page.path,
      lastmod: page.updated,
      changefreq: 'weekly',
      priority: page.priority ?? '0.8',
    })),
    { path: '/blog/', lastmod: latestPost, changefreq: 'weekly', priority: '0.7' },
    ...posts.map((post) => ({
      path: `/blog/${post.slug}/`,
      lastmod: post.updated,
      changefreq: 'monthly',
      priority: '0.6',
    })),
  ];
  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${entries.map(sitemapEntry).join('\n')}
</urlset>
`;
  fs.writeFileSync(path.join(PUBLIC_DIR, 'sitemap.xml'), xml);
  console.log(`wrote sitemap.xml (${entries.length} urls)`);
}

const posts = [...BLOG_POSTS].sort((a, b) => b.published.localeCompare(a.published));

for (const page of LANDING_PAGES) writePage(page.path, renderLanding(page));
writePage('/blog/', renderBlogIndex(posts));
for (const post of posts) writePage(`/blog/${post.slug}/`, renderPost(post, posts));
writeSitemap(posts);
