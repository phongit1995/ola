'use strict';
// Identity helpers shared by the prefab tools: Creator's compressed UUID for script components and stable fileIds.
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');

const BASE64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

/** Creator stores component types as the first five hex digits plus the remaining 27 packed three-per-two into base64. */
function compressUuid(uuid) {
  const hex = uuid.replace(/-/g, '');
  if (!/^[0-9a-f]{32}$/i.test(hex)) throw Error('UUID không hợp lệ: ' + uuid);
  let out = hex.slice(0, 5);
  for (let i = 5; i < 32; i += 3) {
    const value = parseInt(hex.slice(i, i + 3), 16);
    out += BASE64[value >> 6] + BASE64[value & 63];
  }
  return out;
}

/** The serialized `__type__` of a script component, read from its .meta so renames never break the link. */
function componentType(scriptFile) {
  const meta = JSON.parse(fs.readFileSync(scriptFile + '.meta', 'utf8'));
  return compressUuid(meta.uuid);
}

/** Deterministic fileId so re-running a tool produces a byte-identical prefab. */
function stableId(key) {
  const h = crypto.createHash('sha1').update(key).digest('hex');
  return `${h.slice(0, 8)}-${h.slice(8, 12)}-${h.slice(12, 16)}-${h.slice(16, 20)}-${h.slice(20, 32)}`;
}

const scripts = path.resolve(__dirname, '..', 'assets', 'farm', 'scripts');
let componentScripts;

/** Authoring lookup by the explicit @ccclass name; feature folders do not define component identity. */
function componentScript(name) {
  if (!componentScripts) {
    const found = new Map();
    function visit(dir) {
      for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
        const file = path.join(dir, entry.name);
        if (entry.isDirectory()) visit(file);
        else if (entry.name.endsWith('.ts')) {
          const source = fs.readFileSync(file, 'utf8');
          for (const match of source.matchAll(/^\s*@ccclass\s*\(\s*(['"])([^'"]+)\1\s*\)/gm)) {
            const className = match[2], previous = found.get(className);
            if (previous) throw Error(`Duplicate @ccclass '${className}': ${previous} and ${file}`);
            found.set(className, file);
          }
        }
      }
    }
    visit(scripts);
    componentScripts = found;
  }
  const file = componentScripts.get(name);
  if (!file) throw Error(`Missing @ccclass '${name}' under ${scripts}`);
  return file;
}

/** Resolve the current script location, then read its existing UUID instead of deriving one from the path. */
function componentTypeByName(name) {
  return componentType(componentScript(name));
}

/** Types of the map components by class name. */
function mapComponentTypes() {
  return Object.fromEntries(['FarmItemLibrary', 'FarmMapLayout', 'FacilityTrigger', 'CropPlotView', 'ItemParts']
    .map(name => [name, componentTypeByName(name)]));
}

module.exports = { compressUuid, componentType, componentScript, componentTypeByName, stableId, mapComponentTypes };
