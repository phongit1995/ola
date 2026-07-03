const terserMinifier = require('metro-minify-terser');
const JavaScriptObfuscator = require('javascript-obfuscator');

const OBFUSCATE_OPTIONS = {
  compact: true,
  simplify: true,
  identifierNamesGenerator: 'mangled',
  renameGlobals: false,
  stringArray: true,
  stringArrayEncoding: ['base64'],
  stringArrayThreshold: 0.75,
  splitStrings: true,
  splitStringsChunkLength: 10,
  numbersToExpressions: true,
  controlFlowFlattening: false,
  deadCodeInjection: false,
  selfDefending: false,
  debugProtection: false,
  disableConsoleOutput: false,
};

function isAppModule(filename) {
  if (!filename) return false;
  const normalized = filename.replace(/\\/g, '/');
  if (normalized.includes('/node_modules/')) return false;
  return normalized.includes('/mobile/src/') || normalized.includes('/packages/shared/src/');
}

module.exports = async function obfuscatingMinifier(options) {
  const minified = await terserMinifier(options);
  if (!isAppModule(options.filename)) {
    return minified;
  }
  const obfuscated = JavaScriptObfuscator.obfuscate(minified.code, OBFUSCATE_OPTIONS);
  return { code: obfuscated.getObfuscatedCode(), map: minified.map };
};
