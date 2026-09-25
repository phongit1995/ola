'use strict';
const { uiPrefabPath } = require('./ui-prefab-paths.cjs');
// Explicit reset of inventory authoring defaults. Normal builds use the editable prefab files.
const fs = require('node:fs'), path = require('node:path');
const { UiPrefabBuilder, assets, ref, color, assetRef, componentScript, componentTypeByName, read } = require('./ui-prefab-builder.cjs');
const { appendNested } = require('./prefab-graph.cjs');
const { stableId } = require('./cocos-ids.cjs');
const island = key => 'farm/bundles/golden-island-ui/images/' + key + '.png';
const skinInfo = read(path.join(assets, 'farm/bundles/golden-island-ui/manifest.json')).images;
const index = read(path.join(assets, 'resources/ported/asset-index.json'));
const genericFont = assetRef('resources/' + Object.entries(index).find(([source]) => source.endsWith('.ttf'))[1] + '.ttf', 'cc.TTFFont');
const buttonType = componentTypeByName('FarmButton');
const tint = [162, 66, 49];
function skin(b, parent, name, key, x, y, w, h) { return b.sprite(parent, name, island(key), x, y, w, h, { sliced: skinInfo[key].border.some(v => v > 0) }); }
function label(b, parent, name, value, x, y, w, h, size) { return b.label(parent, name, value, x, y, w, h, size, tint, { font: genericFont, lineHeight: size + 7 }); }
function button(b, node) { b.component(node, buttonType, { clickEvents: [], _interactable: true, _transition: 0, _target: ref(node) }); }
function write(b, name, fields) {
  const nodes = [...b.paths.keys()], baseline = nodes.map(id => {
    const node = b.objects[id], transform = b.getComponent(id, 'cc.UITransform');
    const text = node._components.map(r => b.objects[r.__id__]).find(c => c.__type__ === 'cc.Label');
    return { rect: { __type__: 'cc.Vec4', x: node._lpos.x, y: node._lpos.y, z: transform._contentSize.width, w: transform._contentSize.height },
      font: text?._fontSize ?? 0, color: text?._color ?? color([255, 255, 255]),
      frame: node._components.map(r => b.objects[r.__id__]).find(c => c.__type__ === 'cc.Sprite')?._spriteFrame ?? null };
  });
  const script = componentScript(name + 'View');
  if (!fs.existsSync(script + '.meta')) fs.writeFileSync(script + '.meta', JSON.stringify({ ver: '4.0.24', importer: 'typescript', imported: true, uuid: stableId('scripts/ui/' + name + 'View.ts'), files: [], subMetas: {}, userData: {} }, null, 2) + '\n');
  return b.write(uiPrefabPath(name), componentTypeByName(name + 'View'), { ...fields, layoutNodes: nodes.map(ref),
    referenceRects: baseline.map(v => v.rect), referenceFonts: baseline.map(v => v.font), referenceColors: baseline.map(v => v.color), referenceFrames: baseline.map(v => v.frame) });
}

const cell = new UiPrefabBuilder('StockCard', 148, 152); button(cell, cell.root);
const source = 'resources/' + index['assets/sprites/1.wheat.png'] + '.png', png = fs.readFileSync(path.join(assets, source));
const width = png.readUInt32BE(16), height = png.readUInt32BE(20), fit = 80 / Math.max(width, height);
const product = cell.sprite(cell.root, 'Product', source, 0, 22, width * fit, height * fit);
const badge = skin(cell, cell.root, 'CountBadge', 'info', 37.44, -8, 43, 43);
const count = label(cell, cell.root, 'Count', '4', 37.44, -8, 60, 36, 22);
const name = label(cell, cell.root, 'ItemName', 'Lúa mì', 0, -52, 146, 42, 20);
write(cell, 'StockCard', { product: cell.reference(product, 'cc.Sprite'), badge: ref(badge), count: cell.reference(count, 'cc.Label'), itemName: cell.reference(name, 'cc.Label') });

const b = new UiPrefabBuilder('InventoryBody', 1000, 900);
const summary = label(b, b.root, 'StorageCount', '4 sản phẩm · Không giới hạn kho', 0, 342, 900, 38, 23);
const tabs = [], tabTitles = [];
for (const [i, id] of ['raw', 'goods'].entries()) {
  const node = skin(b, b.root, 'tab-' + id, i ? 'tabInactive' : 'tab', (i - .5) * 460, 284, 455, 88); button(b, node); tabs.push(ref(node));
  const text = label(b, node, 'Title', i ? 'Thành phẩm' : 'Nguyên liệu', 0, 1, 431, 76, 25); tabTitles.push(b.reference(text, 'cc.Label'));
}
const grid = skin(b, b.root, 'StorageGrid', 'inset', 0, -32, 948, 540);
const scroll = b.node(b.root, 'Scroll', 0, -32, 936, 528), viewport = b.node(scroll, 'Viewport', 0, 0, 936, 528);
b.component(viewport, 'cc.Mask', { _type: 0, _inverted: false, _segments: 64, _alphaThreshold: .1 });
const content = b.node(viewport, 'Content', -468, 264, 936, 528); b.getComponent(content, 'cc.UITransform')._anchorPoint = { __type__: 'cc.Vec2', x: 0, y: 1 };
const scrollComponent = b.component(scroll, 'cc.ScrollView', { _content: ref(content), horizontal: false, vertical: true, inertia: true, brake: .5, elastic: true, bounceDuration: 1, scrollEvents: [], cancelInnerEvents: true });
const preview = b.node(content, 'EditorPreview', 0, 0, 936, 528);
const cardFile = path.join(assets, uiPrefabPath('StockCard')), card = read(cardFile), cardUuid = read(cardFile + '.meta').uuid;
for (let i = 0; i < 6; i++) appendNested(b.objects, { parentId: preview, ownerRootId: b.root, prefabUuid: cardUuid,
  sourceRootFileId: card[card[card[0].data.__id__]._prefab.__id__].fileId, instanceKey: 'InventoryBody/EditorPreview/' + i,
  name: 'EditorStock' + i, position: { x: 156 * (i + .5), y: -80 } });
const hint = label(b, b.root, 'SellHint', 'Chạm vào sản phẩm để chọn số lượng bán', 0, -324, 930, 34, 21);
const quick = skin(b, b.root, 'inventory-sales', 'card', 0, -392, 870, 88); button(b, quick);
const quickTitle = label(b, quick, 'Title', 'Bán nhanh', 0, 1, 846, 76, 25);
write(b, 'InventoryBody', { stockCardPrefab: { __uuid__: cardUuid, __expectedType__: 'cc.Prefab' }, count: b.reference(summary, 'cc.Label'), tabs, tabTitles,
  activeTab: assetRef(island('tab')), inactiveTab: assetRef(island('tabInactive')), grid: ref(grid), scroll: ref(scrollComponent), preview: ref(preview),
  hint: b.reference(hint, 'cc.Label'), quickSale: ref(quick), quickSaleTitle: b.reference(quickTitle, 'cc.Label'), rowHeight: 160 });
console.log('Authored InventoryBody and StockCard with native shelf, category tabs and six linked preview cells.');
