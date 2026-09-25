'use strict';
// Creates the Creator `.meta` files Git must carry for new scripts and folders under assets/.
// Existing metas are never touched, so UUIDs referenced by scenes and prefabs stay stable.
// Usage: node tools/script-meta.cjs [--check]
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');

const root = path.resolve(__dirname, '..', 'assets');
const check = process.argv.includes('--check');
const DIRECTORY_META = uuid => ({ ver: '1.2.0', importer: 'directory', imported: true, uuid, files: [], subMetas: {}, userData: {} });
const SCRIPT_META = uuid => ({ ver: '4.0.24', importer: 'typescript', imported: true, uuid, files: [], subMetas: {}, userData: {} });

const missing = [];
function visit(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const file = path.join(dir, entry.name);
    if (entry.isDirectory()) { ensure(file, DIRECTORY_META); visit(file); }
    else if (entry.name.endsWith('.ts')) ensure(file, SCRIPT_META);
  }
}
function ensure(file, template) {
  const meta = file + '.meta';
  if (fs.existsSync(meta)) return;
  missing.push(path.relative(root, meta));
  if (!check) fs.writeFileSync(meta, JSON.stringify(template(crypto.randomUUID()), null, 2) + '\n');
}
visit(root);
if (check && missing.length) { console.error('Thiếu .meta:\n' + missing.join('\n')); process.exit(1); }
console.log(missing.length ? `${check ? 'Thiếu' : 'Đã tạo'} ${missing.length} .meta:\n${missing.join('\n')}` : 'Mọi script và thư mục đã có .meta.');
