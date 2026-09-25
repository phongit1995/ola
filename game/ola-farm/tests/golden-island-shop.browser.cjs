'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, observe, build } = require('./browser-support.cjs');
const catalog = require('../tools/load-farm-catalog.cjs').loadFarmCatalog();
const islandRoot = path.resolve(__dirname, '../assets/farm/bundles/golden-island-ui');
const islandFrames = Object.fromEntries(Object.entries(require(path.join(islandRoot, 'manifest.json')).images).map(([key, info]) => {
  const meta = JSON.parse(fs.readFileSync(path.join(islandRoot, info.resource + '.png.meta')));
  return [key, Object.values(meta.subMetas).find(m => m.importer === 'sprite-frame').uuid];
}));
const out = process.env.COCOS_SHOP_OUT ? path.resolve(process.env.COCOS_SHOP_OUT)
  : path.resolve(__dirname, '../artifacts/golden-island-shop/prefab-runtime');
const yards = [
  { id: 'shop-animal-12', name: 'Chuồng gà', prefab: 'yard-coop' },
  { id: 'shop-animal-13', name: 'Chuồng bò', prefab: 'yard-cowshed' },
  { id: 'shop-animal-14', name: 'Chuồng heo', prefab: 'yard-pigpen' },
  { id: 'shop-animal-15', name: 'Chuồng cừu', prefab: 'yard-sheepfold' },
];
const cardAsset = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../assets/farm/prefabs/ui/ShopCard.prefab')));
const authoredTitle = cardAsset.find(o => o.__type__ === 'cc.Label' && cardAsset[o.node.__id__]._name === 'ShopName');
const titleRGBA = ['r', 'g', 'b', 'a'].map(key => authoredTitle._color[key]);
const coinFrame = '944e84bc-66e4-4bde-b6ff-43975d0d8c07@f9941';

async function snap(page) {
  return page.evaluate(() => ({ coins: testApp.game.state.coins, diamonds: testApp.game.state.diamonds,
    machines: JSON.parse(JSON.stringify(testApp.game.state.machines)),
    pens: testApp.game.state.plots.filter(p => p.residents).map(p => ({ id: p.id, residents: JSON.parse(JSON.stringify(p.residents)) })),
    inventory: JSON.parse(JSON.stringify(testApp.game.state.inventory)) }));
}

async function inspect(page) {
  return page.evaluate(({ expectedYards, importedFrames }) => {
    const a = testApp, cc = testCc, canvas = document.querySelector('#GameCanvas').getBoundingClientRect();
    const size = cc.view.getCanvasSize(), viewport = cc.view.getViewportRect();
    const rect = n => { const t = n.getComponent(cc.UITransform), p = n.worldPosition, s = n.worldScale;
      const left = viewport.x + (p.x - t.width * t.anchorX * s.x) * cc.view.getScaleX();
      const bottom = viewport.y + (p.y - t.height * t.anchorY * s.y) * cc.view.getScaleY();
      return { x: left / size.width * canvas.width, y: canvas.height - bottom / size.height * canvas.height,
        w: t.width * s.x * cc.view.getScaleX() / size.width * canvas.width,
        h: t.height * s.y * cc.view.getScaleY() / size.height * canvas.height }; };
    // Creator3.8 TTF actualFontSize includes texture raster scaling. Remove it before
    // converting local font units to CSS; otherwise1920 and DPR2 overstate glyph size.
    const fontMetrics = label => {
      const rasterScale = Math.max(1, label.fontSize < 100
        ? Math.min(label.textStyle.fontScale, 100 / label.fontSize) : label.textStyle.fontScale);
      return { authored: label.fontSize, raster: label.actualFontSize, rasterScale,
        css: label.actualFontSize / rasterScale * label.node.worldScale.y * cc.view.getScaleY() / size.height * canvas.height };
    };
    const card = a.panels.card, sprites = card.getComponentsInChildren(cc.Sprite).filter(s => s.node.activeInHierarchy),
      labels = card.getComponentsInChildren(cc.Label).filter(l => l.node.activeInHierarchy);
    // Authored SpriteFrames are imported assets; Art's generated frame objects need not share identity.
    const nativeKey = frame => Object.keys(importedFrames).find(k => frame?._uuid === importedFrames[k]
      || frame === a.art.frame('island-ui/' + k));
    const native = [...new Set(sprites.map(s => nativeKey(s.spriteFrame)).filter(Boolean))];
    const rgba = color => [color.r, color.g, color.b, color.a];
    const controls = [...a.ui.controls].filter(([id, n]) => id.startsWith('shop-') && n.activeInHierarchy)
      .map(([id, n]) => ({ id, ...rect(n), enabled: n.getComponent(cc.Button)?.interactable !== false }));
    const drawer = card.getChildByName('ShopDrawer'), scroll = a.panels.scroll;
    const children = n => [n, ...n.children.flatMap(children)];
    const activeChildren = n => n.active ? [n, ...n.children.flatMap(activeChildren)] : [];
    const frameIds = n => activeChildren(n).map(n => n.getComponent(cc.Sprite)).filter(s => s?.spriteFrame)
      .map(s => s.spriteFrame._uuid).sort();
    const yardModels = expectedYards.map(expected => {
      const action = a.ui.controls.get(expected.id); if (!action?.activeInHierarchy) return null;
      const item = scroll.content.children.find(n => children(n).includes(action));
      const model = item && children(item).find(n => n.name === 'ShopModel');
      const source = a.art.prefabs.get(expected.prefab);
      return { id: expected.id, name: item?.getComponentsInChildren(cc.Label).find(l => l.node.name === 'ShopName')?.string,
        childCount: model?.children.filter(n => n.active).length, modelFrames: model && frameIds(model), sourceFrames: source && frameIds(source.data) };
    }).filter(Boolean);
    const machineCards = a.game.machineTypes.map(type => {
      const action = a.ui.controls.get('shop-machine-' + type.id); if (!action?.activeInHierarchy) return null;
      const item = scroll.content.children.find(n => children(n).includes(action));
      const labels = item.getComponentsInChildren(cc.Label);
      return { type: type.id, owned: a.game.state.machines.some(m => m.type === type.id),
        quantity: labels.find(l => l.node.name === 'ShopQuantity')?.string,
        action: labels.find(l => l.node.name === 'Title')?.string,
        enabled: action.getComponent(cc.Button)?.interactable !== false };
    }).filter(Boolean);
    const priceCards = scroll.content.children.filter(n => n.name === 'ShopCard' && n.activeInHierarchy).map(item => {
      const view = item.getComponent('ShopCardView'), action = view.priceButton;
      const id = [...a.ui.controls].find(([, n]) => n === action)?.[0];
      const machine = id?.startsWith('shop-machine-'), numericId = Number(id?.split('-').at(-1));
      const plot = machine ? null : a.game.state.plots.find(p => p.id === numericId);
      const owned = machine ? a.game.state.machines.some(m => m.type === numericId) : !!plot?.residents;
      const price = owned ? null : machine ? a.game.machinePurchasePrice(numericId) : a.game.penPurchasePrice(numericId);
      const access = machine ? a.game.machineUnlockStatus(numericId) : a.game.penUnlockStatus(numericId);
      const animalType = !machine && a.game.catalog.livestock.find(t => t.key === plot?.residents?.species);
      const priceFont = fontMetrics(view.priceLabel), descriptionFont = fontMetrics(view.description);
      return { id, machine, owned, expectedPrice: price, locked: !owned && !access.unlocked,
        animalCount: plot?.residents?.animals.length, animalCapacity: plot?.residents?.capacity,
        expansionPrice: !machine && owned ? a.game.penExpansionPrice(numericId) : null, refillPrice: animalType?.price,
        reason: access.reason, description: view.description.string, descriptionVisible: view.description.node.activeInHierarchy,
        label: view.priceLabel.string, labelBounds: rect(view.priceLabel.node), labelFontCSS: priceFont.css,
        descriptionFontCSS: descriptionFont.css, priceFont, descriptionFont, hitBounds: rect(action),
        coin: { visible: view.coin.node.activeInHierarchy, uuid: view.coin.spriteFrame?._uuid, bounds: rect(view.coin.node) },
        lock: { visible: view.lock.activeInHierarchy, bounds: rect(view.lock) } };
    });
    return { view: a.panels.view, tab: a.panels.shopTab, root: card.name, native, controls,
      labels: labels.map(l => ({ text: l.string, font: l.font?.name, name: l.node.name, bounds: rect(l.node),
        rgba: rgba(l.color), cssFontSize: fontMetrics(l).css })), nativeFont: a.art.shopFont?.name,
      drawer: rect(drawer), canvas: { width: canvas.width, height: canvas.height },
      toast: a.toastView.visible ? { text: a.toastView.text, ...rect(a.toastBox) } : null,
      layers: card.children.filter(n => n.activeInHierarchy).map(n => ({ name: n.name, index: n.getSiblingIndex(), bounds: n.getComponent(cc.UITransform) ? rect(n) : null,
        nativeKey: nativeKey(n.getComponent(cc.Sprite)?.spriteFrame) ?? null })),
      bodyColor: rgba(drawer.getComponent(cc.Sprite)?.color ?? drawer.getComponent(cc.Graphics).fillColor),
      yardModels, machineCards, priceCards,
      cardBounds: scroll.content.children.filter(n => n.name === 'ShopCard' && n.activeInHierarchy).map(rect),
      priceFrames: sprites.filter(s => nativeKey(s.spriteFrame) === 'shopPrice').map(s => ({ rgba: rgba(s.color), grayscale: s.grayscale })),
      cards: scroll.content.children.filter(n => n.name === 'ShopCard' && n.activeInHierarchy).length,
      unownedMachines: a.game.machineTypes.filter(t => !a.game.state.machines.some(m => m.type === t.id)).length,
      overflow: scroll.content.getComponent(cc.UITransform).width - scroll.node.getComponent(cc.UITransform).width,
      horizontal: scroll.horizontal, vertical: scroll.vertical, offset: scroll.getScrollOffset(),
      built: a.map.town.diagnostics().buildings, yards: a.map.town.diagnostics().herds.map(h => h.id),
      buildingHits: farmCocos.buildings().map(b => b.buildingId), plotHits: farmCocos.targets().map(p => p.id) };
  }, { expectedYards: yards, importedFrames: islandFrames });
}

function visibleTargets(info, ids) {
  const targets = ids.map(id => { const target = info.controls.find(c => c.id === id); assert.ok(target, id); return target; });
  for (const t of targets) {
    assert.ok(t.w >= 43.9 && t.h >= 43.9, `${t.id}: ${t.w} × ${t.h} CSS px must be at least44`);
    assert.ok(t.x >= -.5 && t.x + t.w <= info.canvas.width + .5 && t.y - t.h >= -.5 && t.y <= info.canvas.height + .5,
      t.id + ' entire target fits canvas');
  }
  for (let i = 0; i < targets.length; i++) for (let j = i + 1; j < targets.length; j++) {
    const a = targets[i], b = targets[j], overlapX = Math.min(a.x + a.w, b.x + b.w) - Math.max(a.x, b.x);
    const overlapY = Math.min(a.y, b.y) - Math.max(a.y - a.h, b.y - b.h);
    assert.ok(overlapX <= .5 || overlapY <= .5, a.id + ' overlaps ' + b.id);
  }
  return targets;
}

function nativeShop(info, tab) {
  assert.equal(info.view, 'shop'); assert.equal(info.tab, tab); assert.equal(info.root, 'GoldenIslandShop');
  assert.equal(info.horizontal, true); assert.equal(info.vertical, false);
  assert.equal(info.cards, tab === 'animals' ? 4 : catalog.machineTypes.length);
  if (tab === 'buildings') {
    assert.deepEqual(info.machineCards.map(c => c.type), catalog.machineTypes.map(t => t.id), 'Shop keeps every production building in catalog order');
    for (const card of info.machineCards) {
      assert.equal(card.quantity, card.owned ? '1/1' : '0/1', 'Quantity reports actual building ownership');
      if (card.owned) { assert.equal(card.action, 'Đã xây'); assert.equal(card.enabled, false, 'Owned machine cannot be purchased again'); }
    }
  }
  if (tab === 'animals') for (const expected of yards) {
    const actual = info.yardModels.find(m => m.id === expected.id);
    assert.ok(actual, expected.id + ': real yard card exists');
    assert.equal(actual.name, expected.name, 'Animal category names the yard being managed');
    assert.equal(actual.childCount, 1, expected.prefab + ': exactly one complete source prefab preview');
    assert.ok(actual.sourceFrames?.length > 1, expected.prefab + ': source includes multiple yard layers');
    assert.deepEqual(actual.modelFrames, actual.sourceFrames, expected.prefab + ': preview renders every source yard layer');
  }
  for (const key of ['shopRim', 'shopTab', 'shopTabOpen', 'shopAnimal', 'shopBuilding', 'shopPrice', ...(info.cards ? ['shopQuantity'] : [])])
    assert.ok(info.native.includes(key), 'Native source component ' + key);
  assert.ok(!info.native.includes('window') && !info.native.includes('buildingWindow'), 'Shop uses BuildingUI drawer, without popup window');
  assert.match(info.nativeFont, /Poetsen/i);
  assert.ok(info.labels.every(l => l.font === info.nativeFont), 'Shop labels use the source Poetsen font');
  assert.ok(Math.abs(info.drawer.y - info.canvas.height) < 1, 'Drawer touches bottom edge');
  const layer = key => info.layers.find(l => l.nativeKey === key);
  const order = [layer('shopTab'), layer('shopRim'), layer('shopTabOpen'),
    info.layers.find(l => l.name === 'ShopDrawer'), info.layers.find(l => l.name === 'ShopScroll')];
  assert.ok(order.every(Boolean), 'Native category and drawer layers exist');
  for (let i = 1; i < order.length; i++) assert.ok(order[i - 1].index < order[i].index,
    'Native tabs sit behind the drawer and cards without flattening card peaks');
  assert.deepEqual(info.bodyColor, [255, 249, 211, 255], 'Native BuildingUI background RGBA');
  for (const price of info.priceFrames) {
    assert.deepEqual(price.rgba, [255, 255, 255, 255], 'Native price pixels are not tinted');
    assert.equal(price.grayscale, false, 'Locked price keeps the native cream strip');
  }
  for (const label of info.labels.filter(l => l.name === 'ShopQuantity')) assert.deepEqual(label.rgba, [255, 255, 255, 255], 'Source quantity text is white');
  for (const label of info.labels.filter(l => l.name === 'ShopName')) assert.deepEqual(label.rgba, titleRGBA, 'Shop name keeps its authored prefab color');
  const category = info.controls.filter(c => c.id.startsWith('shop-tab-'));
  const totalHeight = info.canvas.height - Math.min(...category.map(t => t.y - t.h));
  if (info.canvas.width === 1920 && info.canvas.height === 1080) {
    for (const card of info.cardBounds) {
      assert.ok(card.w >= 205 && card.w <= 225, 'Desktop card is about215 CSS px wide');
      assert.ok(card.h >= 290 && card.h <= 320, 'Desktop card is about305 CSS px tall');
    }
    assert.ok(totalHeight >= 435 && totalHeight <= 475, 'Desktop Shop is about455 CSS px tall, preserving more map space');
  }
  if (info.canvas.width === 390 && info.canvas.height === 844) {
    for (const card of info.cardBounds) {
      assert.ok(card.w >= 120 && card.w <= 136, 'Portrait card is about128 CSS px wide');
      assert.ok(card.h >= 180 && card.h <= 202, 'Portrait card is about190 CSS px tall');
    }
    assert.ok(totalHeight >= 244 && totalHeight <= 278, 'Portrait Shop is about260 CSS px tall');
  }
  if (info.canvas.width === 1280 && info.canvas.height === 720)
    assert.ok(totalHeight / info.canvas.height < .47, 'Smaller desktop Shop leaves more than half the map visible');
  assert.equal(info.controls.filter(c => c.id.startsWith('shop-tab-')).length, 2);
  const visibleNames = info.labels.filter(l => l.name === 'ShopName' && l.bounds.x >= 0 && l.bounds.x + l.bounds.w <= info.canvas.width);
  for (const label of visibleNames) assert.ok(label.cssFontSize >= 11.8, label.text + ': name remains readable at12 CSS px');
  for (const target of info.controls.filter(c => c.id !== 'shop-dismiss'))
    assert.ok(target.w >= 43.9 && target.h >= 43.9, target.id + ': compact layout preserves44 CSS px actions');
  pricePresentation(info);
}

function pricePresentation(info) {
  const inside = (inner, outer) => inner.x >= outer.x - .5 && inner.x + inner.w <= outer.x + outer.w + .5
    && inner.y <= outer.y + .5 && inner.y - inner.h >= outer.y - outer.h - .5;
  const overlaps = (a, b) => Math.min(a.x + a.w, b.x + b.w) - Math.max(a.x, b.x) > .5
    && Math.min(a.y, b.y) - Math.max(a.y - a.h, b.y - b.h) > .5;
  for (const card of info.priceCards) {
    const numeric = !card.owned && card.expectedPrice !== null;
    assert.equal(card.coin.visible, numeric, card.id + ': coin is reserved for an actual building price');
    if (numeric) {
      assert.equal(card.label, String(card.expectedPrice), card.id + ': visible amount matches the current domain price');
      assert.equal(card.coin.uuid, coinFrame, card.id + ': price uses the existing HUD coin asset');
      assert.ok(inside(card.coin.bounds, card.hitBounds), card.id + ': coin fits the purchase button');
      assert.ok(inside(card.labelBounds, card.hitBounds), card.id + ': numeric label fits the purchase button');
      assert.ok(!overlaps(card.coin.bounds, card.labelBounds), card.id + ': coin does not cover the numeric amount');
    } else if (card.machine && card.owned) assert.equal(card.label, 'Đã xây');
    else if (!card.machine && card.owned) {
      const expected = card.animalCount === 5 ? 'Đủ 5 con' : card.animalCount === card.animalCapacity
        ? `Mở ô + con\n${card.expansionPrice} xu` : `Mua con · ${card.refillPrice} xu`;
      assert.equal(card.label, expected, 'Animal actions distinguish a bundled new slot from refilling an existing slot');
    }
    assert.equal(card.lock.visible, card.locked, card.id + ': unlock status remains visible beside the price');
    if (card.locked) {
      assert.equal(card.descriptionVisible, true);
      assert.equal(card.description, card.reason, card.id + ': numeric price does not replace the unlock explanation');
      assert.ok(!overlaps(card.lock.bounds, card.labelBounds), card.id + ': lock leaves the price text clear');
      assert.ok(!overlaps(card.lock.bounds, card.coin.bounds), card.id + ': lock and coin remain separate');
    }
    if (card.hitBounds.x >= 0 && card.hitBounds.x + card.hitBounds.w <= info.canvas.width) {
      const small = Math.min(info.canvas.width, info.canvas.height) < 600;
      assert.ok(card.labelFontCSS >= 10.9 && card.labelFontCSS <= (small ? 11.5 : 16.2),
        card.id + ': smaller bottom text remains readable: ' + card.labelFontCSS + ' CSS px');
      // Wrapped SHRINK searches through floor(rasterFont + 1): at1920, authored13
      // becomes raster19.5 then20, i.e.13.333 CSS px. Allow that quantization only.
      if (card.descriptionVisible) assert.ok(card.descriptionFontCSS >= 9.8 && card.descriptionFontCSS <= 13.5,
        card.id + ': compact explanation remains readable: ' + card.descriptionFontCSS + ' CSS px');
    }
  }
}

function unobstructedToast(info) {
  const toast = info.toast; assert.ok(toast?.text, 'Successful expansion displays feedback');
  assert.ok(toast.x >= -.5 && toast.x + toast.w <= info.canvas.width + .5 && toast.y - toast.h >= -.5 && toast.y <= info.canvas.height + .5,
    'Shop purchase toast stays inside the canvas');
  const protectedRects = [...info.cardBounds, ...info.controls.filter(c => c.id !== 'shop-dismiss')];
  for (const box of protectedRects) {
    const overlapX = Math.min(toast.x + toast.w, box.x + box.w) - Math.max(toast.x, box.x);
    const overlapY = Math.min(toast.y, box.y) - Math.max(toast.y - toast.h, box.y - box.h);
    assert.ok(overlapX <= .5 || overlapY <= .5, 'Purchase feedback leaves Shop cards, prices and category controls clear');
  }
  return toast;
}

async function open(page, tab = 'animals') {
  if (await page.evaluate(() => testApp.panels.view !== '')) await page.evaluate(() => testApp.close());
  await tap(page, 'shop', true);
  if (await page.evaluate(tab => testApp.panels.shopTab !== tab, tab)) await tap(page, 'shop-tab-' + tab, true);
}

async function reveal(page, id) {
  for (let i = 0; i < 60; i++) {
    const info = await inspect(page), target = info.controls.find(c => c.id === id); assert.ok(target, id);
    const below = Math.max(0, -target.x), above = Math.max(0, target.x + target.w - info.canvas.width);
    if (below <= .5 && above <= .5) return info;
    const box = await page.locator('#GameCanvas').boundingBox();
    await page.mouse.move(box.x + box.width / 2, box.y + box.height - info.drawer.h / 2);
    const ratio = await page.evaluate(() => testApp.width / testCc.view.getFrameSize().width);
    await page.mouse.wheel(0, (above > 0 ? -1 : 1) * Math.min(220, Math.max(below, above) * ratio * 2 + 8));
    await page.waitForTimeout(100);
  }
  throw Error('Could not reveal shop card ' + id);
}

async function assertModel(page, key, pen = null) {
  await page.waitForFunction(({ key, pen }) => pen === null ? testApp.map.town.diagnostics().buildings.includes(key)
    : testApp.map.town.diagnostics().herds.some(h => h.id === pen), { key, pen });
  assert.ok(await page.evaluate(({ key, pen }) => pen === null ? farmCocos.buildings().some(b => b.buildingId === key)
    : farmCocos.targets().some(t => t.id === pen), { key, pen }), 'Purchased model becomes a real map target');
}

async function ownedPurchaseGuard(page, type) {
  const id = 'shop-machine-' + type;
  await reveal(page, id); await page.evaluate(() => testApp.panels.scroll.stopAutoScroll());
  const info = await inspect(page), [button] = visibleTargets(info, [id]);
  assert.equal(button.enabled, false); const before = await snap(page);
  const canvas = await page.locator('#GameCanvas').boundingBox();
  // Use real pointer input on the disabled card; the normal tap helper intentionally waits for enabled controls.
  await page.touchscreen.tap(canvas.x + button.x + button.w / 2, canvas.y + button.y - button.h / 2);
  await page.waitForTimeout(90);
  assert.deepEqual(await snap(page), before, 'Tapping an owned card cannot debit coins or add another machine');
  assert.equal(await page.evaluate(() => testApp.panels.view), 'shop');
  const rejection = await page.evaluate(type => testApp.game.buyMachine(type), type);
  assert.ok(rejection.error, 'Existing domain guard also rejects another purchase');
  assert.deepEqual(await snap(page), before, 'Domain rejection keeps ownership and wallet unchanged');
  return { type, disabledPointerBlocked: true, domainRejected: true, exactStatePreserved: true };
}

async function authoredPrefabProof(page) {
  // Inspector-equivalent edits target the loaded prefab assets before the host instantiates them.
  // Refresh Creator's compiled instantiate functions to simulate asset reimport, rather than live-instance editing.
  // This catches procedural rebuilds that silently replace serialized color, spacing, or card dimensions.
  const source = await page.evaluate(() => {
    const a = testApp, cc = testCc; a.close();
    const view = a.shopPrefab?.data.getComponent('ShopView');
    if (!view?.cardPrefab) throw Error('GameApp must use a real Shop prefab linked to the ShopCard prefab');
    const card = view.cardPrefab.data, rim = view.rim.getComponent(cc.Sprite);
    const quantity = card.getChildByName('QuantityBackground').getComponent(cc.Sprite), size = card.getComponent(cc.UITransform);
    globalThis.shopAuthoringFixture = { view, rim, quantity, size, gap: view.cardGap, width: size.width,
      rimColor: rim.color.clone(), quantityColor: quantity.color.clone() };
    rim.color = new cc.Color(217, 239, 251, 255); quantity.color = new cc.Color(249, 220, 204, 255);
    view.cardGap += 9; size.width += 11;
    view.cardPrefab.compileCreateFunction(); a.shopPrefab.compileCreateFunction();
    return { gap: view.cardGap, cardWidth: size.width, shopUuid: a.shopPrefab._uuid, cardUuid: view.cardPrefab._uuid,
      editMode: 'Prefab asset data edited and compiled instantiate cache refreshed, simulating Editor asset reimport' };
  });
  const rounds = [];
  try {
    await open(page);
    const capture = () => page.evaluate(() => {
      const a = testApp, cc = testCc, root = a.panels.card, view = root.getComponent('ShopView');
      const rgba = c => [c.r, c.g, c.b, c.a];
      const cards = view.scroll.content.children.filter(n => n.name === 'ShopCard' && n.activeInHierarchy);
      const first = cards[0], size = first.getComponent(cc.UITransform);
      return { root: root.uuid, shopUuid: root._prefab?.asset?._uuid, cardUuid: first._prefab?.asset?._uuid,
        component: !!first.getComponent('ShopCardView'),
        staticIds: [view.drawer, view.rim, view.animalTab, view.buildingTab, view.dismiss, view.scroll.node].map(n => n.uuid),
        rimRGBA: rgba(view.rim.getComponent(cc.Sprite).color),
        quantityRGBA: cards.map(n => rgba(n.getChildByName('QuantityBackground').getComponent(cc.Sprite).color)),
        gapRatio: cards.length > 1 ? (cards[1].position.x - first.position.x - size.width * first.scale.x) / (size.width * first.scale.x) : null };
    });
    const initial = await capture();
    const check = (actual, stage) => {
      assert.equal(actual.shopUuid, source.shopUuid, stage + ': actual Shop prefab instance');
      assert.equal(actual.cardUuid, source.cardUuid, stage + ': actual reusable ShopCard prefab instance');
      assert.equal(actual.component, true, stage + ': card is bound through ShopCardView');
      assert.equal(actual.root, initial.root, stage + ': Shop instance is reused');
      assert.deepEqual(actual.staticIds, initial.staticIds, stage + ': serialized static nodes survive');
      assert.deepEqual(actual.rimRGBA, [217, 239, 251, 255], stage + ': Inspector rim tint is preserved');
      for (const color of actual.quantityRGBA) assert.deepEqual(color, [249, 220, 204, 255], stage + ': Inspector card tint is preserved');
      assert.ok(Math.abs(actual.gapRatio - source.gap / source.cardWidth) < .001, stage + ': Inspector card width and spacing are used');
      rounds.push({ stage, ...actual });
    };
    check(initial, 'open');
    await tap(page, 'shop-tab-buildings', true); check(await capture(), 'tab');
    await page.evaluate(() => testApp.panels.refresh(true)); check(await capture(), 'refresh');
    await page.setViewportSize({ width: 1280, height: 720 }); await page.waitForTimeout(350);
    check(await capture(), 'resize');
    await tap(page, 'shop-tab-animals', true); check(await capture(), 'return-tab');
    return { source, rounds, passed: true };
  } finally {
    await page.evaluate(() => {
      testApp.close(); const f = globalThis.shopAuthoringFixture;
      f.view.cardGap = f.gap; f.size.width = f.width; f.rim.color = f.rimColor; f.quantity.color = f.quantityColor;
      f.view.cardPrefab.compileCreateFunction(); testApp.shopPrefab.compileCreateFunction();
      delete globalThis.shopAuthoringFixture;
    });
    await page.setViewportSize({ width: 1920, height: 1080 }); await page.waitForTimeout(350); await open(page);
  }
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const server = await serve(), browser = await launch(), results = [];
  const save = extra => fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ buildPath: build, testedAt: new Date().toISOString(),
    caseFilter: process.env.COCOS_SHOP_CASE ?? null,
    fixture: 'Fresh500coins covers chicken expansion/purchases and grill; then explicit20000coins+unlock flags isolate remaining shop UI transactions.', results, ...extra }, null, 2) + '\n');
  save({ passed: false, status: 'running' });
  try {
    const allCases = [[1920, 1080, 1], [1280, 720, 1], [390, 844, 1], [320, 568, 1], [844, 390, 1], [568, 320, 1], [320, 568, 2]];
    const cases = process.env.COCOS_SHOP_CASE ? allCases.filter(([w, h, d]) => `${w}x${h}-dpr${d}` === process.env.COCOS_SHOP_CASE) : allCases;
    assert.ok(cases.length, 'COCOS_SHOP_CASE must name one of the seven supported viewport/DPR cases');
    for (const [width, height, dpr] of cases) {
      const context = await browser.newContext({ viewport: { width, height }, deviceScaleFactor: dpr, hasTouch: true, isMobile: width < 1000 });
      const page = await context.newPage(), observed = observe(page), result = { width, height, dpr };
      try {
        await boot(page, server.url);
        await page.evaluate(() => { testApp.game.dismissGuide(); testApp.close(); testApp.save(); testApp.refresh(); });
        assert.equal((await snap(page)).coins, 500);
        await open(page); const fresh = await inspect(page); nativeShop(fresh, 'animals');
        assert.equal(fresh.built.length, 3); assert.deepEqual([...fresh.yards].sort(), [12, 13]);
        assert.ok(!fresh.plotHits.includes(14) && !fresh.plotHits.includes(15));
        for (const type of catalog.machineTypes.filter(t => t.purchasePrices.length)) {
          assert.ok(!fresh.built.includes(type.buildingIds[0])); assert.ok(!fresh.buildingHits.includes(type.buildingIds[0]));
        }
        assert.equal(fresh.controls.find(c => c.id === 'shop-animal-14').enabled, false);
        assert.equal(fresh.controls.find(c => c.id === 'shop-animal-15').enabled, false);
        result.unbuiltPenGates = true;
        result.initialTargets = visibleTargets(fresh, ['shop-tab-animals', 'shop-tab-buildings', 'shop-animal-12', 'shop-animal-13']);
        result.sourcePresentation = { nativeKeys: fresh.native, font: fresh.nativeFont, bodyRGBA: fresh.bodyColor,
          cardWidthCSS: fresh.cardBounds[0].w, cardHeightCSS: fresh.cardBounds[0].h, bodyHeightCSS: fresh.drawer.h,
          yardModels: fresh.yardModels, priceCards: fresh.priceCards,
          quantityRGBA: fresh.labels.find(l => l.name === 'ShopQuantity').rgba, priceFrames: fresh.priceFrames };
        const category = fresh.controls.filter(c => c.id.startsWith('shop-tab-'));
        result.drawerRatio = (height - Math.min(...category.map(t => t.y - t.h))) / height;
        await page.screenshot({ path: path.join(out, `animals-${width}x${height}-dpr${dpr}.png`) });
        if (width === 1920) {
          const before = await snap(page);
          result.prefabAuthoring = await authoredPrefabProof(page);
          assert.deepEqual(await snap(page), before, 'Prefab styling/layout edits do not mutate game state');
          nativeShop(await inspect(page), 'animals');
        }

        // Real fresh500 purchases: each paid slot includes exactly one animal, at slot fee plus animal price.
        for (const [capacity, price] of [[2, 125], [3, 155]]) {
          const before = await snap(page); await tap(page, 'shop-animal-12', true);
          const expanded = await snap(page), pen = expanded.pens.find(p => p.id === 12).residents;
          assert.equal(expanded.coins, before.coins - price); assert.equal(pen.capacity, capacity); assert.equal(pen.animals.length, capacity);
          assert.equal(pen.animals.at(-1).slot, capacity - 1);
          assert.deepEqual(pen.animals.slice(0, -1), before.pens.find(p => p.id === 12).residents.animals);
          assert.equal(await page.evaluate(() => testApp.panels.view), 'shop');
          pricePresentation(await inspect(page));
          const feedback = unobstructedToast(await inspect(page));
          (result.expansionFeedback ??= []).push({ capacity, ...feedback });
          if (capacity === 2) await page.screenshot({ path: path.join(out, `expansion-feedback-${width}x${height}-dpr${dpr}.png`) });
          await assertModel(page, '', 12);
        }
        assert.equal((await inspect(page)).controls.find(c => c.id === 'shop-animal-12').enabled, true, 'Third animal leaves two slots available');
        assert.equal((await snap(page)).coins, 220);
        await tap(page, 'shop-tab-buildings', true); const buildings = await inspect(page); nativeShop(buildings, 'buildings');
        assert.equal(buildings.machineCards.filter(c => c.owned).length, 3);
        assert.equal(buildings.machineCards.filter(c => !c.owned).length, 5);
        result.initialBuildingOwnership = buildings.machineCards;
        result.buildingPrices = buildings.priceCards;
        result.buildingNames = buildings.labels.filter(l => l.name === 'ShopName').map(l => ({ text: l.text, cssFontSize: l.cssFontSize }));
        assert.equal(buildings.controls.find(c => c.id === 'shop-machine-1021').enabled, false);
        await page.screenshot({ path: path.join(out, `buildings-${width}x${height}-dpr${dpr}.png`) });
        const camera = await page.evaluate(() => testApp.map.cameraState()), stockBeforeDrag = await snap(page);
        const box = await page.locator('#GameCanvas').boundingBox(), y = box.y + box.height - buildings.drawer.h / 2;
        await page.mouse.move(box.x + box.width * .7, y); await page.mouse.down();
        await page.mouse.move(box.x + box.width * .3, y, { steps: 12 }); await page.mouse.up(); await page.waitForTimeout(180);
        assert.deepEqual(await page.evaluate(() => testApp.map.cameraState()), camera);
        assert.deepEqual(await snap(page), stockBeforeDrag, 'Dragging the shop does not purchase or change stock');
        if (buildings.overflow > 1) assert.ok(Math.abs((await inspect(page)).offset.x) > Math.min(1, buildings.overflow / 4),
          'Real horizontal drag moves the content even when desktop overflow is only a few pixels');
        await tap(page, 'shop-machine-2', true); assert.equal((await snap(page)).coins, 20); await assertModel(page, 'grill-1');
        assert.equal(await page.evaluate(() => testApp.panels.view), '');
        await open(page, 'buildings');
        const afterGrill = await inspect(page); nativeShop(afterGrill, 'buildings');
        assert.equal(afterGrill.cards, 8); assert.equal(afterGrill.machineCards.filter(c => c.owned).length, 4);
        assert.equal((await snap(page)).coins, 20);
        result.grillDuplicateGuard = await ownedPurchaseGuard(page, 2);
        result.fresh500 = { finalCoins: 20, chickenCount: 3, grillBoughtOnce: true };
        await open(page); const poor = await inspect(page);
        assert.equal(poor.controls.find(c => c.id === 'shop-animal-13').enabled, false);
        assert.ok(poor.labels.some(l => l.text.includes('Cần thêm 145 xu')), 'Insufficient funds includes the cow in the165coin bundle');
        result.insufficientFunds = true;

        // Explicit fixture unlocks the rest; the purchases themselves still use visible Shop controls.
        await page.evaluate(() => { const a = testApp; a.close(); a.game.state.coins = 20000;
          Object.assign(a.game.state.husbandry, { feedReceived: true, eggsCollected: true, milkCollected: true, burgerCollected: true });
          a.game.validate(); a.save(); a.refresh(); });
        await page.evaluate(() => { testApp.paused = true; testApp.open('shop', { shopTab: 'animals' }); });
        const paused = await inspect(page), pausedState = await snap(page), button = paused.controls.find(c => c.id === 'shop-animal-13');
        assert.equal(button.enabled, false, 'Paused session disables an otherwise affordable purchase');
        const pausedBox = await page.locator('#GameCanvas').boundingBox();
        await page.touchscreen.tap(pausedBox.x + button.x + button.w / 2, pausedBox.y + button.y - button.h / 2);
        assert.deepEqual(await snap(page), pausedState);
        await page.evaluate(() => { testApp.paused = false; testApp.refresh(); }); result.pausedPurchaseBlocked = true;
        for (const [capacity, price] of [[4, 200], [5, 260]]) {
          await open(page); const before = await snap(page); await tap(page, 'shop-animal-12', true);
          const after = await snap(page), pen = after.pens.find(p => p.id === 12).residents;
          assert.equal(after.coins, before.coins - price); assert.equal(pen.capacity, capacity); assert.equal(pen.animals.length, capacity);
          assert.equal(pen.animals.at(-1).slot, capacity - 1);
          assert.deepEqual(pen.animals.slice(0, -1), before.pens.find(p => p.id === 12).residents.animals);
          pricePresentation(await inspect(page));
        }
        assert.equal((await inspect(page)).controls.find(c => c.id === 'shop-animal-12').enabled, false, 'Five animals is the Shop limit');
        result.fivePaidChickenSlots = { count: 5, slots: (await snap(page)).pens.find(p => p.id === 12).residents.animals.map(a => a.slot) };
        for (const id of [14, 15]) {
          await open(page); const before = await snap(page), definition = catalog.residentPens.find(p => p.cell === id);
          pricePresentation(await reveal(page, 'shop-animal-' + id));
          await tap(page, 'shop-animal-' + id, true);
          const built = await snap(page), pen = built.pens.find(p => p.id === id).residents;
          const price = catalog.livestock.find(a => a.key === definition.species).price;
          assert.equal(built.coins, before.coins - definition.purchasePrice - price); assert.equal(pen.capacity, 1);
          assert.equal(pen.animals.length, 1); assert.equal(pen.animals[0].slot, 0); assert.equal(pen.animals[0].job, null);
          assert.equal(await page.evaluate(() => testApp.panels.view), 'shop'); await assertModel(page, '', id);
          pricePresentation(await inspect(page));
        }
        for (const type of catalog.machineTypes.filter(t => t.purchasePrices.length && t.id !== 2 && t.id !== 1021)) {
          await open(page, 'buildings'); const before = await snap(page);
          await tap(page, 'shop-machine-' + type.id, true);
          const after = await snap(page); assert.equal(after.coins, before.coins - type.purchasePrices[0]);
          assert.equal(after.machines.length, before.machines.length + 1); await assertModel(page, type.buildingIds[0]);
        }
        let bought = await snap(page); assert.equal(bought.machines.length, 7); assert.equal(bought.pens.length, 4);
        await page.reload(); await boot(page, server.url); assert.deepEqual(await snap(page), bought, 'Reload preserves all bought assets and exact balance');

        // Pending source return and one-shot item deep link are UI state, never extra purchases.
        const bakery = bought.machines.find(m => m.type === 1);
        await page.evaluate(id => { testApp.panels.recipeReturnMachineId = id; testApp.panels.recipeReturnRecipeId = 7;
          testApp.open('shop', { shopTab: 'animals', shopItem: 'shop-animal-15' }); }, bakery.id);
        await page.waitForTimeout(180); const deep = await inspect(page);
        visibleTargets(deep, ['shop-tab-animals', 'shop-tab-buildings', 'shop-animal-15', 'shop-production-return']);
        assert.equal(await page.evaluate(() => testApp.panels.shopItemId), null);
        await tap(page, 'shop-production-return', true);
        assert.equal(await page.evaluate(() => testApp.panels.machineId), bakery.id);
        assert.equal(await page.evaluate(() => testApp.panels.selectedRecipeId), 7);
        assert.deepEqual(await snap(page), bought);
        result.sourceReturn = true;

        await open(page, 'buildings'); await reveal(page, 'shop-machine-1021');
        await page.setViewportSize({ width: height, height: width }); await page.waitForTimeout(350);
        const resized = await inspect(page); nativeShop(resized, 'buildings');
        visibleTargets(resized, ['shop-tab-animals', 'shop-tab-buildings']);
        const visibleLoom = await reveal(page, 'shop-machine-1021'); visibleTargets(visibleLoom, ['shop-machine-1021']);
        assert.deepEqual(await snap(page), bought); result.resize = true;
        await tap(page, 'shop-dismiss', true); assert.equal(await page.evaluate(() => testApp.panels.view), '');
        await open(page, 'buildings'); await tap(page, 'shop-machine-1021', true);
        assert.equal((await snap(page)).coins, bought.coins - 500); await assertModel(page, 'industry-loom');
        bought = await snap(page); assert.equal(bought.machines.length, 8);
        // A valid imported save may own a pen without collection markers. Gates apply to building,
        // while expanding/buying in an already owned pen follows the existing FarmGame rules.
        await page.evaluate(() => { const a = testApp;
          Object.assign(a.game.state.husbandry, { feedReceived: false, eggsCollected: false, milkCollected: false, burgerCollected: false });
          a.game.validate(); a.save(); });
        await page.reload(); await boot(page, server.url); await open(page, 'animals');
        const importedOwned = await inspect(page);
        assert.equal(importedOwned.controls.find(c => c.id === 'shop-animal-14').enabled, true, 'Owned pen expansion ignores cleared build milestones');
        await tap(page, 'shop-animal-14', true);
        const expandedPig = await snap(page);
        assert.equal(expandedPig.coins, bought.coins - 45 - 140);
        assert.equal(expandedPig.pens.find(p => p.id === 14).residents.animals.length, 2);
        const soldPig = expandedPig.pens.find(p => p.id === 14).residents.animals[0];
        // A domain sale creates an existing gap; the visible Shop action must refill it without charging another slot fee.
        await page.evaluate(id => { const a = testApp, result = a.game.sellAnimal(14, id); if (result.error) throw Error(result.error);
          a.save(); a.refresh(); }, soldPig.id);
        // The fixture bypasses app.act(), so let the regular panel refresh expose the changed action.
        await page.waitForFunction(() => {
          const action = testApp.ui.controls.get('shop-animal-14');
          return testApp.panels.scroll.content.children.some(n => {
            const card = n.getComponent('ShopCardView');
            return card?.priceButton === action && card.priceLabel.string === 'Mua con · 140 xu';
          });
        });
        const soldState = await snap(page);
        assert.equal(soldState.coins, expandedPig.coins + 70);
        pricePresentation(await inspect(page));
        assert.equal((await inspect(page)).controls.find(c => c.id === 'shop-animal-14').enabled, true, 'Owned pen refill ignores cleared build milestones');
        await tap(page, 'shop-animal-14', true);
        const refilled = await snap(page), pig = refilled.pens.find(p => p.id === 14).residents;
        assert.equal(refilled.coins, soldState.coins - 140); assert.equal(pig.capacity, 2); assert.equal(pig.animals.length, 2);
        assert.equal(pig.animals.at(-1).slot, soldPig.slot);
        assert.deepEqual(pig.animals[0], expandedPig.pens.find(p => p.id === 14).residents.animals[1]);
        result.importedOwnedPenClearedMarkers = { validatedAndReloaded: true, realExpansion: true, realAnimalPurchase: true, exactDebits: true };
        bought = await snap(page);
        await page.reload(); await boot(page, server.url); assert.deepEqual(await snap(page), bought);
        await open(page, 'buildings'); const allBuilt = await inspect(page); nativeShop(allBuilt, 'buildings');
        assert.equal(allBuilt.cards, 8); assert.equal(allBuilt.unownedMachines, 0);
        assert.ok(allBuilt.machineCards.every(c => c.owned && c.quantity === '1/1' && c.action === 'Đã xây' && !c.enabled));
        assert.ok(!allBuilt.controls.some(c => c.id === 'shop-all-built-close'), 'An owned catalog replaces the empty-shop state');
        result.allBuiltCatalog = allBuilt.machineCards;
        result.allBuiltViewport = allBuilt.canvas;
        result.loomDuplicateGuard = await ownedPurchaseGuard(page, 1021);
        await page.screenshot({ path: path.join(out, `all-owned-after-rotation-from-${width}x${height}-dpr${dpr}.png`) });
        await tap(page, 'shop-dismiss', true);
        assert.equal(await page.evaluate(() => testApp.panels.view), '');
        result.purchaseAndReload = { allEightMachines: true, fourPens: true, paidInitialAnimals: true, paidExpansionAnimals: true, exactDebits: true, purchasedCardsRemainOwned: true, allBuiltCatalogRetained: true };
        assert.deepEqual(observed.errors, []); result.errors = []; result.passed = true;
        console.log(`${width}×${height} DPR${dpr}: compact prefab Shop,yard models,44px,real purchases,hidden sites,scroll shield,deep link,resize/reload PASS`);
      } catch (error) {
        result.passed = false; result.error = String(error); result.errors = observed.errors;
        result.diagnostic = await page.evaluate(() => {
          const a = testApp, cc = testCc, scroll = a.panels.scroll;
          const rect = n => { const t = n.getComponent(cc.UITransform), p = n.worldPosition, s = n.worldScale;
            return { x: p.x - t.width * t.anchorX * s.x, y: p.y - t.height * t.anchorY * s.y, width: t.width * s.x, height: t.height * s.y }; };
          return { view: a.panels.view, tab: a.panels.shopTab, frame: cc.view.getFrameSize(), scaleX: cc.view.getScaleX(),
            canvas: cc.view.getCanvasSize(), viewport: cc.view.getViewportRect(), camera: a.map.cameraState(),
            scroll: scroll && { offset: scroll.getScrollOffset(), max: scroll.getMaxScrollOffset(), moving: scroll.isAutoScrolling(),
              content: rect(scroll.content), mask: rect(scroll.content.parent), horizontal: scroll.horizontal, vertical: scroll.vertical },
            controls: [...a.ui.controls].filter(([id,n]) => id.startsWith('shop-') && n.activeInHierarchy).map(([id,n]) => ({ id, bounds: rect(n) })) };
        }).catch(diagnosticError => ({ error: String(diagnosticError) }));
        await page.screenshot({ path: path.join(out, `failure-${width}x${height}-dpr${dpr}.png`) });
        console.error(`${width}×${height} DPR${dpr}: ${error}`);
      } finally { results.push(result); save({ passed: false, status: 'running' }); await context.close(); }
    }
    assert.ok(results.every(r => r.passed), 'Every shop viewport must pass; see results.json'); save({ passed: true });
  } catch (error) { save({ passed: false, error: String(error) }); throw error; }
  finally {
    const cleanup = { serverClosed: false, browserClosed: false };
    const mark = () => { const file = path.join(out, 'results.json'), report = JSON.parse(fs.readFileSync(file));
      fs.writeFileSync(file, JSON.stringify({ ...report, cleanup }, null, 2) + '\n'); };
    await server.close(); cleanup.serverClosed = true; mark();
    await browser.close(); cleanup.browserClosed = true; mark();
    console.log('Shop test cleanup: own server and browser closed');
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
