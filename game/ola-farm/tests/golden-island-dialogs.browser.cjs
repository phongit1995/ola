'use strict';
// Focused native-skin regression. Explicit stock/coin fixtures isolate UI from economy timing.
const assert = require('node:assert/strict');
const fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, site, observe, build } = require('./browser-support.cjs');
const out = process.env.COCOS_DIALOG_OUT ? path.resolve(process.env.COCOS_DIALOG_OUT)
  : path.resolve(__dirname, '../artifacts/golden-island-modal/runtime');

async function dialog(page, view, required = []) {
  const result = await page.evaluate(() => {
    const a = testApp, cc = testCc, card = a.panels.card;
    const canvas = document.querySelector('#GameCanvas').getBoundingClientRect();
    const viewport = cc.view.getViewportRect(), size = cc.view.getCanvasSize();
    // getBoundingBoxToWorld includes active descendants (including scrolled-off content).
    // Centering belongs to the frame itself; clipping/controls are checked separately.
    const transform = card.getComponent(cc.UITransform), p = card.worldPosition, scale = card.worldScale;
    const box = { xMin: p.x - transform.width * transform.anchorX * scale.x,
      xMax: p.x + transform.width * (1 - transform.anchorX) * scale.x,
      yMin: p.y - transform.height * transform.anchorY * scale.y,
      yMax: p.y + transform.height * (1 - transform.anchorY) * scale.y };
    const sx = cc.view.getScaleX() / size.width * canvas.width, sy = cc.view.getScaleY() / size.height * canvas.height;
    const bounds = { left: (viewport.x / size.width * canvas.width) + box.xMin * sx,
      right: (viewport.x / size.width * canvas.width) + box.xMax * sx,
      top: canvas.height - (viewport.y / size.height * canvas.height) - box.yMax * sy,
      bottom: canvas.height - (viewport.y / size.height * canvas.height) - box.yMin * sy };
    const all = card.getComponentsInChildren(cc.Sprite).filter(s => s.node.activeInHierarchy && s.spriteFrame);
    const native = Object.keys(a.art.islandUi.images).filter(key => all.some(s => (s.spriteFrame._uuid === testUiFrames.island[key] || s.spriteFrame === a.art.frame('island-ui/' + key))));
    const town = Object.keys(a.art.townUi.images).filter(key => all.some(s => (s.spriteFrame._uuid === testUiFrames.town[key] || s.spriteFrame === a.art.frame('town-ui/' + key))));
    const frameNode = a.panels.view === 'factory' ? card.getChildByName('FactoryDialogFrame')
      : a.panels.view === 'livestock' ? card.getChildByName('LivestockFrame') : card;
    const rootSprite = frameNode?.getComponent('FactoryDialogFrameView')?.background ?? frameNode?.getComponent(cc.Sprite);
    return { view: a.panels.view, name: card.name, bounds, canvas: { width: canvas.width, height: canvas.height }, native, town,
      frameNode: frameNode?.name,
      rootSkin: Object.keys(a.art.islandUi.images).find(key => (rootSprite?.spriteFrame?._uuid === testUiFrames.island[key] || rootSprite?.spriteFrame === a.art.frame('island-ui/' + key))),
      oldFrame: !!card.getComponentsInChildren(cc.UITransform).find(t => /TownDialog|TownWindow/.test(t.node.name)) };
  });
  assert.equal(result.view, view);
  assert.equal(result.name, 'GoldenIslandDialog');
  if (view === 'factory') assert.equal(result.frameNode, 'FactoryDialogFrame', 'Factory owns its original-art frame prefab');
  if (view === 'livestock') assert.equal(result.frameNode, 'LivestockFrame', 'Livestock owns its native responsive frame');
  assert.equal(result.rootSkin, ['factory', 'industry', 'livestock'].includes(view) ? 'buildingWindow' : 'window');
  assert.equal(result.oldFrame, false);
  assert.deepEqual(result.town.filter(key => key !== 'coin'), [], view + ': no Farm Town modal decoration remains');
  for (const key of required) assert.ok(result.native.includes(key), view + ': native ' + key);
  const b = result.bounds, c = result.canvas;
  assert.ok(b.left >= 0 && b.top >= 0 && b.right <= c.width && b.bottom <= c.height, view + ': frame stays inside canvas');
  assert.ok(Math.abs((b.left + b.right) / 2 - c.width / 2) < 1 && Math.abs((b.top + b.bottom) / 2 - c.height / 2) < 1,
    view + ': frame centered in the actual CSS viewport');
  return result;
}

async function targets(page, ids) {
  const result = await page.evaluate(ids => {
    const cc = testCc, canvas = cc.view.getCanvasSize(), box = document.querySelector('#GameCanvas').getBoundingClientRect();
    return ids.map(id => {
      const t = farmCocos.controls().find(t => t.id === id);
      if (!t) throw Error('Missing control ' + id + ' in ' + testApp.panels.view);
      return { id, x: t.x * box.width, y: t.y * box.height,
        w: t.w * cc.view.getScaleX() / canvas.width * box.width,
        h: t.h * cc.view.getScaleY() / canvas.height * box.height,
        viewport: { width: box.width, height: box.height } };
    });
  }, ids);
  for (const t of result) {
    assert.ok(t.w >= 43.9 && t.h >= 43.9, `${t.id}: ${t.w.toFixed(3)} × ${t.h.toFixed(3)} CSS px, requires44`);
    assert.ok(t.x - t.w / 2 >= -1 && t.x + t.w / 2 <= t.viewport.width + 1 && t.y - t.h / 2 >= -1 && t.y + t.h / 2 <= t.viewport.height + 1,
      t.id + ': entire target inside viewport');
  }
  for (let i = 0; i < result.length; i++) for (let j = i + 1; j < result.length; j++) {
    const a = result[i], b = result[j];
    assert.ok((a.w + b.w) / 2 - Math.abs(a.x - b.x) <= 1 || (a.h + b.h) / 2 - Math.abs(a.y - b.y) <= 1,
      a.id + ' overlaps ' + b.id);
  }
  return result;
}

async function shield(page, scroll = false) {
  const before = await page.evaluate(() => ({ camera: testApp.map.cameraState(), view: testApp.panels.view,
    offset: testApp.panels.scroll?.getScrollOffset().y ?? null,
    overflow: testApp.panels.scroll ? testApp.panels.scroll.content.getComponent(testCc.UITransform).height - testApp.panels.scroll.node.getComponent(testCc.UITransform).height : 0 }));
  const box = await page.locator('#GameCanvas').boundingBox();
  await page.mouse.move(box.x + 5, box.y + box.height / 2); await page.mouse.wheel(0, 200); await page.waitForTimeout(120);
  await page.mouse.move(box.x + 5, box.y + box.height / 2); await page.mouse.down();
  await page.mouse.move(box.x + 20, box.y + box.height / 2 + 50, { steps: 5 }); await page.mouse.up(); await page.waitForTimeout(120);
  assert.deepEqual(await page.evaluate(() => testApp.map.cameraState()), before.camera, 'modal shield blocks map wheel and drag');
  assert.equal(await page.evaluate(() => testApp.panels.view), before.view, 'shield input keeps current modal');
  if (!scroll) return { blockedMapWheelAndDrag: true };
  const p = await page.evaluate(() => {
    const cc = testCc, n = testApp.panels.scroll.node, world = n.worldPosition, viewport = cc.view.getViewportRect(), canvas = cc.view.getCanvasSize();
    return { x: (viewport.x + world.x * cc.view.getScaleX()) / canvas.width,
      y: 1 - (viewport.y + world.y * cc.view.getScaleY()) / canvas.height };
  });
  await page.mouse.move(box.x + p.x * box.width, box.y + p.y * box.height); await page.mouse.wheel(0, 400); await page.waitForTimeout(250);
  if (before.overflow <= 1) await page.waitForFunction(offset => Math.abs(testApp.panels.scroll.getScrollOffset().y - offset) < 1,
    before.offset, { timeout: 3000 }); // Allow Cocos' elastic overscroll to return to rest.
  const after = await page.evaluate(() => ({ camera: testApp.map.cameraState(), offset: testApp.panels.scroll.getScrollOffset().y }));
  assert.deepEqual(after.camera, before.camera, 'scrolling content does not zoom/pan map');
  if (before.overflow > 1) assert.ok(after.offset > before.offset + 1, 'overflowing native content scrolls inside modal');
  else {
    assert.ok(Math.abs(after.offset - before.offset) < 1, 'content that fits keeps its scroll offset');
    const recipeIds = await page.evaluate(() => [...testApp.ui.controls].filter(([id, n]) => id.startsWith('select-recipe-') && n.activeInHierarchy).map(([id]) => id));
    if (recipeIds.length) await targets(page, recipeIds);
  }
  return { blockedMapWheelAndDrag: true, contentScrolled: before.overflow > 1, overflow: before.overflow, before: before.offset, after: after.offset };
}

async function selectRecipe(page, recipe) { await tap(page, 'choose-recipe', true); await tap(page, 'select-recipe-' + recipe, true); }

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const server = await serve(), browser = await launch(), results = [];
  const save = extra => fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ buildPath: build, testedAt: new Date().toISOString(),
    caseFilter: process.env.COCOS_DIALOG_CASE ?? null,
    fixture: '20,000 coins and100of each stock item after a fresh boot; no economy/playthrough claim.', results, ...extra }, null, 2) + '\n');
  save({ passed: false, status: 'running' });
  try {
    const allCases = [[1920, 1080], [390, 844], [320, 568], [844, 390], [568, 320], [1280, 720]];
    const requested = (process.env.COCOS_DIALOG_CASE ?? '').split(',').map(value => value.trim()).filter(Boolean);
    assert.ok(requested.every(value => allCases.some(([w, h]) => `${w}x${h}` === value)), 'COCOS_DIALOG_CASE must name supported widthxheight cases');
    const cases = requested.length ? allCases.filter(([w, h]) => requested.includes(`${w}x${h}`)) : allCases;
    for (const [width, height] of cases) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true, isMobile: width < 1000 });
      const page = await context.newPage(), observed = observe(page), result = { width, height, dialogs: [] };
      try {
        await boot(page, server.url);
        await page.evaluate(() => { const a = testApp; a.game.dismissGuide(); a.close(); a.game.state.coins = 20000;
          for (const item of a.game.items) a.game.state.inventory[item.key] = 100;
          a.game.validate(); a.save(); a.refresh(); });
        // Real building taps: house, barn and owned machine. Unbuilt sites now live in Shop.
        await site(page, 'farm-house', true);
        result.dialogs.push(await dialog(page, 'pause', ['window', 'inset', 'card', 'close']));
        result.houseTargets = await targets(page, ['close-panel', 'resume']);
        const paused = await page.evaluate(() => ({ paused: testApp.paused, time: testApp.game.state.time }));
        assert.equal(paused.paused, true); await page.waitForTimeout(400);
        assert.equal(await page.evaluate(() => testApp.game.state.time), paused.time, 'house menu pauses clock');
        await shield(page); await page.screenshot({ path: path.join(out, `house-${width}x${height}.png`) });
        await tap(page, 'close-panel', true); assert.equal(await page.evaluate(() => testApp.paused), false);

        await site(page, 'barn', true);
        result.dialogs.push(await dialog(page, 'inventory', ['window', 'inset', 'tab', 'tabInactive', 'close']));
        result.barnTargets = await targets(page, ['close-panel', 'tab-raw', 'tab-goods', 'inventory-sales']);
        await tap(page, 'tab-goods', true); await shield(page, true);
        await page.screenshot({ path: path.join(out, `barn-${width}x${height}.png`) });
        await tap(page, 'inventory-sales', true); await tap(page, 'tab-all', true);
        result.dialogs.push(await dialog(page, 'inventory-sales', ['window', 'inset', 'card', 'close']));
        const sale = await page.evaluate(() => ({ coins: testApp.game.state.coins, wheat: testApp.game.quantity('raw:1'), price: testApp.game.item('raw:1').sellPrice }));
        // Reveal and sell through genuine input; the common helper measures the masked viewport.
        await tap(page, 'sell-raw-1', true);
        assert.equal(await page.evaluate(() => testApp.game.quantity('raw:1')), sale.wheat - 1);
        assert.equal(await page.evaluate(() => testApp.game.state.coins), sale.coins + sale.price);
        result.saleTargets = await targets(page, ['sell-raw-1', 'sell-all-raw-1', 'inventory-sales']);
        result.quickSale = { realSingleSale: true, correctStockAndCoins: true, targetsSeparated: true };
        await page.screenshot({ path: path.join(out, `quick-sale-${width}x${height}.png`) });
        await tap(page, 'inventory-sales', true); await dialog(page, 'inventory', ['window', 'inset']);
        await tap(page, 'close-panel', true);

        assert.ok(!await page.evaluate(() => farmCocos.buildings().some(b => b.buildingId === 'industry-loom')));
        // Retained detail renderer regression; actual Shop purchases are covered by golden-island-shop.browser.cjs.
        await page.evaluate(() => testApp.open('industry', { machineType: 1021 }));
        result.dialogs.push(await dialog(page, 'industry', ['buildingWindow', 'panelInfo', 'card', 'close']));
        assert.equal(await page.evaluate(() => farmCocos.controls().find(c => c.id === 'purchase-industry').enabled), false, 'locked loom cannot be purchased');
        result.purchaseTargets = await targets(page, ['close-panel', 'all-buildings', 'purchase-industry', 'focus-industry']);
        await page.screenshot({ path: path.join(out, `locked-building-${width}x${height}.png`) });
        await tap(page, 'close-panel', true);

        assert.ok(!await page.evaluate(() => farmCocos.buildings().some(b => b.buildingId === 'grill-1')));
        await page.evaluate(() => testApp.open('industry', { machineType: 2 }));
        await dialog(page, 'industry', ['buildingWindow', 'panelInfo', 'card']);
        const purchase = await page.evaluate(() => ({ coins: testApp.game.state.coins, count: testApp.game.state.machines.length,
          price: testApp.game.machinePurchasePrice(testApp.panels.machineTypeId), type: testApp.panels.machineTypeId }));
        await tap(page, 'purchase-industry', true);
        assert.equal(await page.evaluate(() => testApp.panels.view), 'factory');
        assert.equal(await page.evaluate(() => testApp.game.state.coins), purchase.coins - purchase.price);
        assert.equal(await page.evaluate(() => testApp.game.state.machines.length), purchase.count + 1);
        assert.equal(await page.evaluate(() => testApp.game.state.machines.find(m => m.id === testApp.panels.machineId).type), purchase.type);
        result.purchase = { exactlyOneMachine: true, exactlyPriceCharged: true };
        await tap(page, 'close-panel', true);

        await site(page, 'bakery-1', true); await selectRecipe(page, 7);
        result.dialogs.push(await dialog(page, 'factory', ['buildingWindow', 'slot', 'material', 'info', 'close']));
        const machine = await page.evaluate(() => testApp.panels.machineId);
        const fixed = ['close-panel', 'all-buildings', 'collect-' + machine, 'choose-recipe', 'produce-7'];
        result.factoryTargets = await targets(page, fixed);
        await page.screenshot({ path: path.join(out, `factory-${width}x${height}.png`) });
        await tap(page, 'choose-recipe', true); await dialog(page, 'factory', ['recipe', 'selected', 'slot']);
        result.scrollShield = await shield(page, true);
        await targets(page, fixed);
        await tap(page, 'select-recipe-100207', true);
        await tap(page, 'pin-recipe', true);
        await tap(page, 'recipe-ingredient-0', true);
        result.dialogs.push(await dialog(page, 'ingredients', ['window', 'inset', 'close']));
        const sourceId = await page.evaluate(() => [...testApp.ui.controls].find(([id, n]) => id.startsWith('ingredient-source-') &&
          n.getComponentsInChildren(testCc.Label).some(l => l.string.includes('Đến ruộng')))?.[0]);
        assert.ok(sourceId); await tap(page, sourceId, true);
        assert.equal(await page.evaluate(() => testApp.panels.view), '');
        await tap(page, 'return-production', true);
        assert.equal(await page.evaluate(() => testApp.panels.machineId), machine);
        assert.equal(await page.evaluate(() => testApp.panels.selectedRecipeId), 100207);
        result.sourceReturn = true;

        await selectRecipe(page, 7); await tap(page, 'expand-queue', true);
        const wheat = await page.evaluate(() => testApp.game.quantity('raw:1'));
        await tap(page, 'produce-7', true); await tap(page, 'produce-7', true);
        const queued = await page.evaluate(machine => { const m = testApp.game.state.machines.find(m => m.id === machine);
          return { running: m.job?.product, waiting: m.waiting.map(j => ({ id: j.id, product: j.product })), wheat: testApp.game.quantity('raw:1') }; }, machine);
        assert.equal(queued.running, 7); assert.equal(queued.waiting.length, 1); assert.equal(queued.waiting[0].product, 7); assert.equal(queued.wheat, wheat - 4);
        await tap(page, 'cancel-job-' + queued.waiting[0].id, true);
        assert.equal(await page.evaluate(() => testApp.game.quantity('raw:1')), wheat - 2);
        const bread = await page.evaluate(() => testApp.game.quantity('goods:7'));
        await page.evaluate(() => { testApp.game.tick(46); testApp.game.validate(); testApp.save(); testApp.refresh(); });
        await tap(page, 'collect-' + machine, true);
        assert.equal(await page.evaluate(() => testApp.game.quantity('goods:7')), bread + 1);
        assert.equal(await page.evaluate(machine => testApp.game.state.machines.find(m => m.id === machine).tray.length, machine), 0);
        result.production = { realQueueActions: 2, oneWaitingCancelRefunded: true, collectExactlyOnce: true };
        assert.deepEqual(observed.errors, []);
        result.passed = true;
        console.log(`${width}×${height}: Golden Island house/barn/purchase/factory,44px controls,scroll shield,pause,source return and production passed`);
      } catch (error) {
        result.passed = false; result.error = String(error);
        result.view = await page.evaluate(() => globalThis.testApp?.panels.view).catch(() => null);
        result.errors = observed.errors;
        await page.screenshot({ path: path.join(out, `failure-${width}x${height}.png`) });
        console.error(`${width}×${height}: ${error}`);
      } finally { results.push(result); save({ passed: false, status: 'running' }); await context.close(); }
    }
    assert.ok(results.every(r => r.passed), 'Every selected viewport case must pass; see results.json');
    save({ passed: true });
  } catch (error) { save({ passed: false, error: String(error) }); throw error; }
  finally { await browser.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
