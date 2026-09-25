'use strict';
// Edit prefab.data and refresh Creator's compiled clone cache, as an Editor reimport would.
// No live instance is styled by this test. Gameplay input remains real mouse/touch input.
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, state, observe, build } = require('./browser-support.cjs');
const out = process.env.COCOS_TEST_OUTPUT ? path.resolve(process.env.COCOS_TEST_OUTPUT)
  : path.resolve(__dirname, '../artifacts/ui-prefabs/dialog-inventory');

async function prepare(page) {
  return page.evaluate(() => {
    const a = testApp, cc = testCc, g = a.game;
    g.dismissGuide(); a.close();
    // Geometry fixture: stocked categories and no crops that could change the inventory while checking reuse.
    for (const p of g.state.plots.filter(p => p.group === 'crop')) Object.assign(p, { crop: null, snapshot: null, boosted: false, started: 0, ready: 0 });
    for (const item of g.items) g.state.inventory[item.key] = 5;
    g.validate(); a.save(); a.refresh();
    const shellAsset = a.ui.prefabs.dialogShell, bodyAsset = a.ui.prefabs.inventoryBody;
    const shell = shellAsset.data.getComponent('DialogShellView'), body = bodyAsset.data.getComponent('InventoryBodyView');
    const stockAsset = body.stockCardPrefab, stock = stockAsset.data.getComponent('StockCardView');
    const restore = [], set = (object, key, value) => { restore.push(() => { object[key] = value?.clone ? old.clone() : old; }); const old = object[key]?.clone ? object[key].clone() : object[key]; object[key] = value; };
    const move = (node, x, y) => { const old = node.position.clone(); restore.push(() => node.setPosition(old)); node.setPosition(old.x + x, old.y + y, old.z); };
    const originalFont = shell.title.font;
    set(shell.title, 'color', new cc.Color(35, 88, 145, 255));
    set(shell.title, 'fontSize', shell.title.fontSize + 4); move(shell.title.node, 9, 4);
    set(shell.title, 'font', shell.buildingTitleFont);
    set(shell, 'buildingTitleFont', originalFont); // Responsive headings have their own explicit Inspector font property.
    set(shell.window, 'spriteFrame', shell.factoryFrame.spriteFrame);
    set(body.count, 'color', new cc.Color(46, 116, 82, 255)); set(body.count, 'fontSize', body.count.fontSize + 2); move(body.count.node, 7, 3);
    set(body.grid.getComponent(cc.Sprite), 'color', new cc.Color(230, 240, 250, 255));
    set(body.tabTitles[0], 'fontSize', body.tabTitles[0].fontSize + 3);
    set(body.tabs[0].getComponent(cc.Sprite), 'spriteFrame', body.inactiveTab);
    set(stock.itemName, 'color', new cc.Color(32, 90, 160, 255));
    set(stock.itemName, 'fontSize', stock.itemName.fontSize + 2); move(stock.itemName.node, 5, 2);
    set(stock.badge.getComponent(cc.Sprite), 'color', new cc.Color(220, 235, 255, 255));
    set(stock.product, 'color', new cc.Color(255, 225, 200, 255));
    const assets = [stockAsset, bodyAsset, shellAsset]; assets.forEach(asset => asset.compileCreateFunction());
    globalThis.inventoryAuthoring = { restore: () => { restore.reverse().forEach(fn => fn()); assets.forEach(asset => asset.compileCreateFunction()); },
      expected: { titleFont: shell.title.font._uuid, buildingFont: shell.buildingTitleFont._uuid, skin: shell.window.spriteFrame._uuid,
        customTab: body.inactiveTab._uuid, titleSize: shell.title.fontSize } };
    return { fixture: 'all 35 items x5; no active crop jobs', sourceAssets: assets.map(asset => asset._uuid), ...inventoryAuthoring.expected };
  });
}

async function inspect(page) {
  return page.evaluate(() => {
    const a = testApp, cc = testCc, card = a.panels.card, shell = card.parent.getComponent('DialogShellView');
    const body = shell.body.getComponentInChildren('InventoryBodyView');
    const rgba = color => [color.r, color.g, color.b, color.a];
    const pos = node => ({ x: node.position.x, y: node.position.y });
    const t = card.getComponent(cc.UITransform), frame = cc.view.getFrameSize();
    const box = node => {
      // UITransform.getBoundingBoxToWorld includes children: a ScrollView viewport must use its own rect.
      const transform = node.getComponent(cc.UITransform), camera = a.node.getComponent(cc.Canvas).cameraComponent;
      const left = -transform.width * transform.anchorX, bottom = -transform.height * transform.anchorY;
      const points = [[left, bottom], [left + transform.width, bottom], [left, bottom + transform.height], [left + transform.width, bottom + transform.height]]
        .map(([x, y]) => cc.Vec3.transformMat4(new cc.Vec3(), new cc.Vec3(x, y, 0), node.worldMatrix))
        .map(point => camera.worldToScreen(point));
      const lower = { x: Math.min(...points.map(p => p.x)), y: Math.min(...points.map(p => p.y)) };
      const upper = { x: Math.max(...points.map(p => p.x)), y: Math.max(...points.map(p => p.y)) };
      const canvas = document.querySelector('#GameCanvas').getBoundingClientRect(), pixels = cc.view.getCanvasSize();
      return { x: canvas.x + lower.x / pixels.width * canvas.width, y: canvas.y + (1 - upper.y / pixels.height) * canvas.height,
        width: (upper.x - lower.x) / pixels.width * canvas.width, height: (upper.y - lower.y) / pixels.height * canvas.height };
    };
    return { view: a.panels.view, tab: a.panels.inventoryTab, shell: shell.node.uuid, card: card.uuid,
      title: { node: shell.title.node.uuid, text: shell.title.string, color: rgba(shell.title.color), font: shell.title.font?._uuid,
        size: shell.title.fontSize, position: pos(shell.title.node), rect: box(shell.title.node) },
      height: t.height, width: t.width, cssWidth: frame.width, designWidth: a.width, skin: shell.window.spriteFrame?._uuid,
      body: body && { id: body.node.uuid, count: { color: rgba(body.count.color), size: body.count.fontSize, position: pos(body.count.node) },
        gridColor: rgba(body.grid.getComponent(cc.Sprite).color), static: [body.count.node, ...body.tabs, body.grid, body.scroll.node, body.hint.node, body.quickSale].map(n => n.uuid),
        tabs: body.tabs.map((n, i) => ({ frame: n.getComponent(cc.Sprite).spriteFrame._uuid, size: body.tabTitles[i].fontSize })),
        horizontal: body.scroll.horizontal, vertical: body.scroll.vertical, cancelInnerEvents: body.scroll.cancelInnerEvents,
        offset: { x: body.scroll.getScrollOffset().x, y: body.scroll.getScrollOffset().y }, max: body.scroll.getMaxScrollOffset().y,
        viewport: box(body.scroll.content.parent), cards: body.scroll.content.children.map(n => n.getComponent('StockCardView')).filter(Boolean).map(v => ({
          id: v.node.uuid, key: v.node.name, color: rgba(v.itemName.color), size: v.itemName.fontSize, position: pos(v.itemName.node),
          badge: rgba(v.badge.getComponent(cc.Sprite).color), product: rgba(v.product.color), active: v.node.activeInHierarchy,
        })) }, errors: [] };
  });
}

function inventoryStyles(current, expected, identity) {
  assert.equal(current.view, 'inventory'); assert.ok(current.body);
  assert.equal(current.body.horizontal, false); assert.equal(current.body.vertical, true); assert.equal(current.body.cancelInnerEvents, true);
  assert.deepEqual(current.title.color, [35, 88, 145, 255]); assert.equal(current.title.font, expected.titleFont);
  assert.equal(current.title.size, 40); assert.equal(current.title.position.x, 9);
  assert.ok(Math.abs(current.title.position.y - (current.height / 2 - 48 + 4)) < .01);
  assert.equal(current.skin, expected.skin, 'Edited shell skin survives data binding');
  assert.deepEqual(current.body.count.color, [46, 116, 82, 255]); assert.equal(current.body.count.size, 25);
  assert.equal(current.body.count.position.x, 7); assert.equal(current.body.count.position.y, current.height / 2 - 105);
  assert.deepEqual(current.body.gridColor, [230, 240, 250, 255]);
  assert.equal(current.body.tabs[0].frame, expected.customTab, 'Edited tab skin survives active/inactive state changes');
  assert.equal(current.body.tabs[0].size, Math.max(26, Math.ceil(13 * current.designWidth / current.cssWidth)) + 3,
    'Inspector font delta survives touch-target fitting');
  assert.ok(current.body.cards.length >= 8);
  for (const card of current.body.cards) {
    assert.equal(card.active, true); assert.deepEqual(card.color, [32, 90, 160, 255]); assert.equal(card.size, 22);
    assert.deepEqual(card.position, { x: 5, y: -50 }); assert.deepEqual(card.badge, [220, 235, 255, 255]);
    assert.deepEqual(card.product, [255, 225, 200, 255]);
  }
  if (identity) {
    assert.equal(current.shell, identity.shell, 'Shell instance survives refresh/tab/resize');
    assert.equal(current.card, identity.card); assert.equal(current.title.node, identity.title.node);
    assert.equal(current.body.id, identity.body.id, 'Inventory body survives refresh/tab/resize');
    assert.deepEqual(current.body.static, identity.body.static);
  }
}

(async () => {
  fs.mkdirSync(out, { recursive: true }); const server = await serve(); let browser;
  const report = { passed: false, buildPath: build, testedAt: new Date().toISOString(), fixture: 'Inspector asset reimport simulation; real inventory sale input', cases: [], cleanup: {} };
  const save = () => fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(report, null, 2) + '\n');
  try {
    browser = await launch();
    for (const [name, width, height, touch] of [['desktop', 1280, 720, false], ['portrait', 390, 844, true]]) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: touch }), page = await context.newPage(), observed = observe(page);
      try {
        await boot(page, server.url); const expected = await prepare(page); await tap(page, 'inventory', touch);
        const initial = await inspect(page); inventoryStyles(initial, expected);
        await page.evaluate(() => testApp.panels.refresh(true)); const refreshed = await inspect(page); inventoryStyles(refreshed, expected, initial);
        assert.deepEqual(refreshed.body.cards.map(c => c.id), initial.body.cards.map(c => c.id), 'Unchanged stock cards are reused');
        await tap(page, 'tab-goods', touch); const goods = await inspect(page); inventoryStyles(goods, expected, initial); assert.equal(goods.tab, 'goods');
        assert.ok(goods.body.max > 20, 'Stocked goods fixture requires actual scrolling');
        const viewport = goods.body.viewport;
        await page.mouse.move(viewport.x + viewport.width / 2, viewport.y + viewport.height / 2); await page.mouse.wheel(0, 120);
        await page.waitForTimeout(350); await page.evaluate(() => testApp.panels.scroll.stopAutoScroll());
        const scrolled = await inspect(page); assert.ok(scrolled.body.offset.y > 1, 'Mouse wheel scrolls the authored mask');
        await page.evaluate(() => testApp.panels.refresh(true)); const kept = await inspect(page); inventoryStyles(kept, expected, initial);
        assert.ok(Math.abs(kept.body.offset.y - scrolled.body.offset.y) < 1, 'Refresh preserves the scroll position');
        assert.deepEqual(kept.body.cards.map(c => c.id), scrolled.body.cards.map(c => c.id));
        await page.screenshot({ path: path.join(out, name + '-edited-prefabs.png') });
        await page.setViewportSize({ width: height, height: width }); await page.waitForTimeout(650);
        const resized = await inspect(page); inventoryStyles(resized, expected, initial);
        assert.ok(resized.body.offset.y >= -.5 && resized.body.offset.y <= resized.body.max + .5, 'Resize retains a bounded inventory offset');
        await page.screenshot({ path: path.join(out, name + '-resized.png') });
        await page.setViewportSize({ width, height }); await page.waitForTimeout(650); await tap(page, 'tab-raw', touch);
        inventoryStyles(await inspect(page), expected, initial);
        const before = await state(page), price = await page.evaluate(() => testApp.game.item('raw:1').sellPrice);
        await tap(page, 'stock-raw:1', touch); assert.equal((await inspect(page)).view, 'inventory-item');
        await tap(page, 'sale-confirm', touch); const after = await state(page);
        assert.equal(after.inventory['raw:1'], before.inventory['raw:1'] - 1); assert.equal(after.coins, before.coins + price);
        const returned = await inspect(page); inventoryStyles(returned, expected);
        assert.equal(returned.shell, initial.shell, 'Sale and return share the dialog chrome');
        assert.notEqual(returned.body.id, initial.body.id, 'Switching panel type recreates only its content');
        // Test the separate responsive-font property on the same shell; no production action is performed.
        await page.evaluate(() => { testApp.panels.machineId = testApp.game.state.machines[0].id; testApp.open('factory'); });
        const factory = await inspect(page); assert.equal(factory.shell, initial.shell); assert.equal(factory.title.font, expected.buildingFont);
        assert.deepEqual(factory.title.color, [35, 88, 145, 255]); assert.equal(factory.title.position.x, 9);
        assert.deepEqual(observed.errors, []);
        report.cases.push({ name, passed: true, expected, initial, scrolled: kept, resized, afterSale: { inventory: after.inventory['raw:1'], coins: after.coins }, responsiveFont: factory.title.font, errors: observed.errors });
        save(); console.log(name + ': authored shell/body/card edits, reuse, scroll, resize and one real sale passed');
      } catch (error) {
        await page.screenshot({ path: path.join(out, name + '-failure.png') }).catch(() => {}); report.error = String(error); save(); throw error;
      } finally {
        await page.evaluate(() => { testApp.close(); inventoryAuthoring?.restore(); }).catch(() => {}); await context.close();
      }
    }
    report.passed = true; save();
  } finally {
    if (browser) { await browser.close(); report.cleanup.browserClosed = true; }
    await server.close(); report.cleanup.serverClosed = true; save();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
