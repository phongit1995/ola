'use strict';
// Import direction inside assets/farm/scripts: core → render → map → ui → app.
// A file may import its own layer and any layer to the left; `core` (including core/legacy) never imports
// the engine. Usage: node tools/check-layers.cjs
const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..', 'assets', 'farm', 'scripts');
const ORDER = ['core', 'render', 'map', 'ui', 'app'];
const rank = layer => ORDER.indexOf(layer);
const layerOf = file => path.relative(root, file).split(path.sep)[0];

const files = [];
(function walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const file = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(file);
    else if (entry.name.endsWith('.ts')) files.push(file);
  }
})(root);

const problems = [];
for (const file of files) {
  const layer = layerOf(file);
  if (rank(layer) < 0) {
    problems.push(`${path.relative(root, file)}: ngoài các lớp ${ORDER.join(', ')}`);
    continue;
  }
  const source = fs.readFileSync(file, 'utf8');
  for (const match of source.matchAll(/from\s+['"]([^'"]+)['"]/g)) {
    const spec = match[1];
    if (layer === 'core' && (spec === 'cc' || spec.startsWith('cc/'))) {
      problems.push(`${path.relative(root, file)}: core không được import '${spec}'`);
      continue;
    }
    if (!spec.startsWith('.')) continue;
    const target = path.resolve(path.dirname(file), spec);
    const targetLayer = layerOf(target);
    if (rank(targetLayer) > rank(layer)) {
      problems.push(`${path.relative(root, file)}: ${layer} không được import ${targetLayer} ('${spec}')`);
    }
  }
}

if (problems.length) {
  console.error('Sai hướng phụ thuộc giữa các lớp:\n' + problems.join('\n'));
  process.exit(1);
}
console.log(`Hướng phụ thuộc hợp lệ: ${ORDER.join(' → ')} (${files.length} file).`);
