'use strict';
// Check source ownership with the local TypeScript parser; runtime helpers/caches stay in logic modules.
const fs = require('node:fs');
const path = require('node:path');
const ts = require('typescript');

const root = path.resolve(__dirname, '../assets/farm/scripts');
const relative = file => path.relative(root, file).split(path.sep).join('/');

function role(file) {
  const name = relative(file), parts = name.split('/');
  if (name.startsWith('core/legacy/') || parts.includes('generated')) return 'exempt';
  if (name === 'core/FarmTypes.ts' || parts.includes('types') || name.endsWith('.types.ts')) return 'types';
  if (parts.includes('constants') || name.endsWith('.constants.ts')) return 'constants';
  if (parts.includes('enums') || /\.enums?\.ts$/.test(name)) return 'enums';
  return 'logic';
}

function filesUnder(dir) {
  return fs.readdirSync(dir, { withFileTypes: true }).flatMap(entry => {
    const file = path.join(dir, entry.name);
    return entry.isDirectory() ? filesUnder(file) : file.endsWith('.ts') ? [file] : [];
  });
}

function typeOnlyImport(node) {
  if (ts.isImportEqualsDeclaration(node)) return !!node.isTypeOnly;
  const clause = node.importClause;
  if (!clause) return false;
  if (clause.isTypeOnly) return true;
  return !clause.name && clause.namedBindings && ts.isNamedImports(clause.namedBindings) &&
    clause.namedBindings.elements.length > 0 && clause.namedBindings.elements.every(item => item.isTypeOnly);
}

function typeOnlyExport(node) {
  return node.isTypeOnly || (node.exportClause && ts.isNamedExports(node.exportClause) &&
    node.exportClause.elements.every(item => item.isTypeOnly));
}

function importTarget(file, node) {
  const specifier = node.moduleSpecifier;
  if (!specifier || !ts.isStringLiteral(specifier) || !specifier.text.startsWith('.')) return null;
  const target = path.resolve(path.dirname(file), specifier.text);
  return [target, target + '.ts', path.join(target, 'index.ts')]
    .find(candidate => fs.existsSync(candidate) && fs.statSync(candidate).isFile()) ?? null;
}

function executableDeclaration(node) {
  return ts.isFunctionDeclaration(node) || ts.isFunctionExpression(node) || ts.isArrowFunction(node) ||
    ts.isMethodDeclaration(node) || ts.isGetAccessorDeclaration(node) || ts.isSetAccessorDeclaration(node) ||
    ts.isClassDeclaration(node) || ts.isClassExpression(node);
}

function inspect(file, text = fs.readFileSync(file, 'utf8')) {
  const kind = role(file);
  if (kind === 'exempt') return [];
  const source = ts.createSourceFile(file, text, ts.ScriptTarget.Latest, true, ts.ScriptKind.TS);
  const problems = [];
  function report(node, message) {
    const { line } = source.getLineAndCharacterOfPosition(node.getStart(source));
    problems.push(`${relative(file)}:${line + 1}: ${message}`);
  }
  function checkInitializer(node) {
    if (executableDeclaration(node)) {
      report(node, 'constants/enums giữ dữ liệu; chuyển function/class hoặc object method sang module logic.');
      return;
    }
    ts.forEachChild(node, checkInitializer);
  }
  for (const node of source.statements) {
    if (ts.isEmptyStatement(node)) continue;
    if (ts.isImportDeclaration(node) || ts.isImportEqualsDeclaration(node)) {
      const target = importTarget(file, node);
      if ((kind === 'types' || (target && role(target) === 'types')) && !typeOnlyImport(node))
        report(node, "Dùng 'import type' cho khai báo từ module types.");
      continue;
    }
    if (ts.isExportDeclaration(node)) {
      if (kind === 'types' && !typeOnlyExport(node))
        report(node, "Module types chỉ re-export bằng 'export type'.");
      continue;
    }
    if (kind === 'types') {
      if (!ts.isInterfaceDeclaration(node) && !ts.isTypeAliasDeclaration(node))
        report(node, 'Module types chỉ chứa interface/type và import/export type; chuyển giá trị hoặc logic sang module sở hữu.');
      continue;
    }
    if (kind === 'logic') {
      if (ts.isInterfaceDeclaration(node) || ts.isTypeAliasDeclaration(node))
        report(node, `Chuyển ${node.name.text} sang module .types.ts hoặc thư mục types của chức năng.`);
      else if (ts.isEnumDeclaration(node))
        report(node, `Chuyển enum ${node.name.text} sang module .enum.ts hoặc thư mục enums.`);
      continue;
    }
    if (kind === 'enums' && ts.isEnumDeclaration(node)) {
      for (const member of node.members) if (member.initializer) checkInitializer(member.initializer);
      continue;
    }
    if (!ts.isVariableStatement(node)) {
      report(node, 'Module constants/enums chỉ chứa import/re-export và khai báo const dữ liệu; tách types và logic.');
      continue;
    }
    if (!(node.declarationList.flags & ts.NodeFlags.Const))
      report(node, 'Dữ liệu constants/enums phải dùng const, không dùng let/var.');
    for (const declaration of node.declarationList.declarations) {
      if (!declaration.initializer) report(declaration, 'Hằng số cần giá trị khởi tạo.');
      else checkInitializer(declaration.initializer);
    }
  }
  return problems;
}

function main() {
  const files = filesUnder(root).sort(), problems = files.flatMap(file => inspect(file));
  if (problems.length) {
    console.error('Sai phạm vi logic/types/constants/enums:\n' + problems.join('\n'));
    process.exitCode = 1;
  } else console.log(`Cấu trúc logic/types/constants/enums hợp lệ (${files.length} file).`);
}

if (require.main === module) main();
module.exports = { inspect };
