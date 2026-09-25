'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, site, observe } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/construction-reset');

// Every viewport owns a fresh, temporary browser context. This never connects to the user's browser/profile.
async function snapshot(page) {
  return page.evaluate(() => {
    const s = JSON.parse(JSON.stringify(testApp.game.state));
    delete s.time; // Idle wall-clock time can advance while a disabled button is inspected.
    return s;
  });
}
async function card(page, id) {
  return page.evaluate(id => {
    const n = testApp.ui.controls.get(id);
    const v = testApp.panels.card.getComponentsInChildren('ShopCardView').find(v => v.priceButton === n);
    if (!v) throw Error('Missing Shop card ' + id);
    return { count: v.quantity.string, reason: v.description.string, price: v.priceLabel.string,
      enabled: n.getComponent(testCc.Button).interactable, coin: v.coin.node.activeInHierarchy };
  }, id);
}
async function openCard(page, id) {
  await page.evaluate(id => {
    testApp.close();
    testApp.open('shop', { shopTab: id.startsWith('shop-machine-') ? 'buildings' : 'animals', shopItem: id });
  }, id);
  await page.waitForTimeout(120);
}
async function enabledConstructionCards(page) {
  return page.evaluate(() => [...testApp.ui.controls]
    .filter(([id, n]) => /^shop-(machine|animal)-/.test(id) && n.activeInHierarchy && n.getComponent(testCc.Button).interactable)
    .map(([id]) => id).sort());
}
async function disabledTap(page, id) {
  // Shop's authored focus positions the selected card inside its mask, including disabled controls.
  const t = await page.evaluate(id => {
    testApp.panels.scroll?.stopAutoScroll();
    const n = testApp.ui.controls.get(id), cc = testCc;
    const rect = node => { const s = node.worldScale, p = node.worldPosition, r = node.getComponent(cc.UITransform);
      return { x: p.x - r.width * r.anchorX * s.x, y: p.y - r.height * r.anchorY * s.y, w: r.width * s.x, h: r.height * s.y }; };
    const b = rect(n); let clip;
    for (let p = n.parent; p; p = p.parent) if (p.getComponent(cc.Mask)) clip = rect(p);
    if (clip && (b.x < clip.x - 1 || b.x + b.w > clip.x + clip.w + 1 || b.y < clip.y - 1 || b.y + b.h > clip.y + clip.h + 1)) throw Error('Disabled card is clipped: ' + id);
    return farmCocos.controls().find(c => c.id === id);
  }, id);
  assert.equal(t.enabled, false, id + ' must be disabled before pointer input');
  assert.ok(t.x > 0 && t.x < 1 && t.y > 0 && t.y < 1);
  const b = await page.locator('#GameCanvas').boundingBox();
  await page.touchscreen.tap(b.x + t.x * b.width, b.y + t.y * b.height);
  await page.waitForTimeout(120);
}
async function locked(page, id, level, count = '0/2') {
  await openCard(page, id);
  const c = await card(page, id); assert.equal(c.enabled, false); assert.equal(c.count, count);
  assert.match(c.reason, new RegExp('level ' + level + '(?:\\D|$)'));
  assert.match(c.price, /^\d+$/); assert.equal(c.coin, true);
  const before = await snapshot(page); await disabledTap(page, id);
  assert.deepEqual(await snapshot(page), before, id + ': disabled pointer cannot spend or build');
  return c;
}
async function setLevel(page, level, below = false, fund = false) {
  const before = await snapshot(page);
  await page.evaluate(({ level, below, fund }) => {
    // Publish a new game snapshot, as GameSession does after a committed action.
    // Mutating the live XP in place bypasses the panel's state-change contract.
    const session = testApp.session, g = session.createGame(session.game.state), c = g.catalog.economy.experience.curve;
    let threshold = 0;
    for (let n = 1; n < level; n++) threshold += c.baseXP + c.linearXP * (n - 1) + c.quadraticXP * Math.max(0, n - c.quadraticAfterLevel) ** 2;
    g.state.xp = threshold - Number(below);
    if (fund) g.state.coins = 50000;
    g.validate();
    session.game = g;
    if (!session.save()) throw Error('Cannot save the level fixture');
    // No explicit render: the open Shop must observe the published snapshot.
  }, { level, below, fund });
  await page.waitForFunction(() => !testApp.panels.view || testApp.panels.renderedGame === testApp.game, undefined, { timeout: 10000 });
  const after = await snapshot(page);
  for (const key of ['machines', 'plots', 'buildingLayout', 'nextId']) {
    assert.deepEqual(after[key], before[key], 'Changing XP must not automatically build or populate: ' + key);
  }
}
async function buy(page, id, expectedBuilding, expectedPrice) {
  await openCard(page, id); const c = await card(page, id);
  assert.equal(c.enabled, true, id + ': enough level and coins');
  assert.equal(c.price, String(expectedPrice));
  const before = await snapshot(page); await tap(page, id, true);
  const after = await snapshot(page);
  assert.equal(after.coins, before.coins - expectedPrice, id + ': exact price charged once');
  assert.equal(after.xp, before.xp, 'Construction does not grant XP');
  if (id.startsWith('shop-machine-')) {
    assert.equal(after.machines.length, before.machines.length + 1);
    assert.equal(after.machines.filter(m => m.buildingId === expectedBuilding).length, 1);
    await page.waitForFunction(key => testApp.map.town.diagnostics().buildings.includes(key), expectedBuilding);
    assert.ok(await page.evaluate(key => farmCocos.buildings().some(b => b.buildingId === key), expectedBuilding));
  } else {
    const pen = Number(expectedBuilding.split(':')[1]);
    assert.equal(after.plots.filter(p => p.residents).length, before.plots.filter(p => p.residents).length + 1);
    assert.equal(after.plots.find(p => p.id === pen).residents.animals.length, 1);
    await page.waitForFunction(pen => testApp.map.town.diagnostics().herds.some(h => h.id === pen), pen);
    assert.ok(await page.evaluate(pen => farmCocos.targets().some(p => p.id === pen), pen));
  }
  return { id, expectedBuilding, price: expectedPrice };
}
async function emptyFarm(page, wallet) {
  await page.waitForFunction(() => {
    const d = testApp.map.town.diagnostics();
    return !d.buildings.length && !d.herds.length && !d.animals.length;
  });
  const s = await snapshot(page);
  assert.deepEqual(s.machines, []); assert.equal(s.plots.filter(p => p.residents).length, 0);
  assert.equal(s.plots.filter(p => p.group === 'pen' && p.unlocked).length, 0);
  assert.deepEqual({ coins: s.coins, diamonds: s.diamonds, xp: s.xp }, wallet);
  assert.deepEqual(s.buildingLayout.positions, {});
  const visible = await page.evaluate(() => ({ machines: farmCocos.buildings().filter(b => testApp.game.machineTypes.some(t => t.buildSites.some(s => s.buildingId === b.buildingId))),
    pens: farmCocos.targets().filter(t => testApp.game.catalog.residentPens.some(p => p.plotId === t.id)) }));
  assert.deepEqual(visible, { machines: [], pens: [] }, 'No render or input ghosts after fresh start/restart');
}
async function clearedProductionNavigation(page) {
  const navigation = await page.evaluate(() => {
    const p = testApp.panels;
    return { machine: p.machineId, type: p.machineTypeId, recipe: p.selectedRecipeId, source: p.sourceRecipeId,
      pinned: p.pinnedRecipeId, returnMachine: p.recipeReturnMachineId, returnRecipe: p.recipeReturnRecipeId,
      expanded: p.factoryRecipesExpanded, shortcut: farmCocos.controls().some(c => c.id === 'return-production') };
  });
  assert.deepEqual(navigation, { machine: 0, type: 1, recipe: 0, source: 0, pinned: 0, returnMachine: -1,
    returnRecipe: 0, expanded: false, shortcut: false }, 'A reset farm cannot retain navigation to removed production buildings');
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const external = process.env.COCOS_TEST_URL;
  const server = external ? { url: external, close: async () => {} } : await serve();
  const browser = await launch(), results = [];
  try {
    const cases = [[393, 585], [1280, 720]].filter(([w, h]) => !process.env.COCOS_UI_VIEWPORT || process.env.COCOS_UI_VIEWPORT === `${w}x${h}`);
    for (const [width, height] of cases) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true });
      const page = await context.newPage(), events = observe(page);
      const start = async () => {
        await boot(page, server.url);
        if (external && await page.locator('#view-select').count()) {
          await page.locator('#view-select').click(); await page.locator('[data-device="FullScreen"]').click();
        }
        await page.waitForTimeout(250);
        assert.deepEqual(await page.evaluate(() => ({ width: testCc.view.getFrameSize().width, height: testCc.view.getFrameSize().height })), { width, height });
      };
      try {
        await start();
        const wallet = await page.evaluate(() => testApp.game.catalog.economy.startingWallet);
        assert.deepEqual(await page.evaluate(() => testApp.game.catalog.initialMachines), [], 'Preview must import the current no-starter catalog');
        await page.evaluate(() => { testApp.game.dismissGuide(); testApp.close(); });
        await emptyFarm(page, wallet);
        console.log(`READY ${width}x${height}: current catalog imported, zero buildings and map targets`);
        await page.locator('#GameCanvas').screenshot({ path: path.join(out, `fresh-${width}x${height}.png`) });
        // The ordinary production shortcut must not expose the authored dummy factory body.
        await tap(page, 'factory', true);
        const productionView = await page.evaluate(() => testApp.panels.view);
        assert.ok(['shop', 'industries'].includes(productionView), 'Empty farm production shortcut routes to construction/navigation, got ' + productionView);
        await page.evaluate(() => testApp.close());
        await locked(page, 'shop-machine-1', 5);
        await locked(page, 'shop-machine-4', 10); await locked(page, 'shop-animal-13', 10);
        await openCard(page, 'shop-machine-5');
        assert.deepEqual(await enabledConstructionCards(page), ['shop-machine-5'], 'Feed mill is the only level-1 production building');
        const purchases = [await buy(page, 'shop-machine-5', 'feed-1', 200)];
        await openCard(page, 'shop-animal-12');
        assert.deepEqual(await enabledConstructionCards(page), ['shop-animal-12'], 'After buying feed mill, chicken is the only level-1 pen');
        const animalPrices = await page.evaluate(() => Object.fromEntries(testApp.game.catalog.livestock.map(a => [a.key, a.price])));
        purchases.push(await buy(page, 'shop-animal-12', 'pen:12', 100 + animalPrices.layer));
        assert.equal((await snapshot(page)).coins, 80, 'Natural 500-coin start funds both buildings and leaves planting capital');
        await setLevel(page, 3, false, true);
        await locked(page, 'shop-machine-1', 5); assert.deepEqual(await enabledConstructionCards(page), []);
        await page.locator('#GameCanvas').screenshot({ path: path.join(out, `locked-level3-buildings-${width}x${height}.png`) });
        await locked(page, 'shop-animal-13', 10); assert.deepEqual(await enabledConstructionCards(page), []);
        await page.locator('#GameCanvas').screenshot({ path: path.join(out, `locked-level3-animals-${width}x${height}.png`) });
        const level3 = await snapshot(page);
        assert.deepEqual(level3.machines.map(m => m.buildingId), ['feed-1']);
        assert.deepEqual(level3.plots.filter(p => p.residents).map(p => p.id), [12], 'Level 3 still has only the explicitly purchased feed mill and chicken pen');
        await setLevel(page, 5, true); await locked(page, 'shop-machine-1', 5);
        await setLevel(page, 5);
        assert.equal((await card(page, 'shop-machine-1')).enabled, true, 'Shop refreshes eligibility after the XP snapshot is published');
        purchases.push(await buy(page, 'shop-machine-1', 'bakery-1', 100));
        await setLevel(page, 10, true);
        await locked(page, 'shop-machine-4', 10); await locked(page, 'shop-animal-13', 10);
        await setLevel(page, 10);
        purchases.push(await buy(page, 'shop-machine-4', 'dairy-1', 400));
        purchases.push(await buy(page, 'shop-animal-13', 'pen:13', 200 + animalPrices['dairy-cow']));
        const later = await page.evaluate(() => testApp.game.machineTypes.find(t => t.id === 2).buildSites[0]);
        assert.equal(later.requiredLevel, 15, 'The first grill opens at the new milestone');
        await setLevel(page, later.requiredLevel, true); await locked(page, 'shop-machine-2', later.requiredLevel);
        await setLevel(page, later.requiredLevel); purchases.push(await buy(page, 'shop-machine-2', later.buildingId, later.price));
        const second = await page.evaluate(() => testApp.game.machineTypes.find(t => t.id === 1).buildSites[1]);
        assert.equal(second.requiredLevel, 18, 'The second bakery has its own later milestone');
        await setLevel(page, second.requiredLevel, true); await locked(page, 'shop-machine-1', second.requiredLevel, '1/2');
        await setLevel(page, second.requiredLevel); purchases.push(await buy(page, 'shop-machine-1', second.buildingId, second.price));
        console.log(`CHECKED ${width}x${height}: disabled pointer guards and ${purchases.length} explicit purchases`);
        await page.locator('#GameCanvas').screenshot({ path: path.join(out, `built-${width}x${height}.png`) });
        // Persisted ownership survives reload; only the explicit Menu restart clears it.
        await page.evaluate(() => { testApp.close(); testApp.save(); });
        const owned = await snapshot(page); await start();
        assert.deepEqual(await snapshot(page), owned, 'Purchases persist through reload');
        // Pinning and ingredient lookup both retain a production route while the player visits the map.
        await site(page, 'feed-1', true); await tap(page, 'pin-recipe', true); await tap(page, 'recipe-ingredient-0', true);
        await tap(page, 'close-panel', true);
        assert.deepEqual(await page.evaluate(() => ({ pinned: testApp.panels.pinnedRecipeId,
          returnRecipe: testApp.panels.recipeReturnRecipeId, shortcut: farmCocos.controls().some(c => c.id === 'return-production') })),
          { pinned: 24, returnRecipe: 24, shortcut: true });
        await tap(page, 'pause-menu', true); await tap(page, 'restart', true); await tap(page, 'confirm', true);
        await emptyFarm(page, wallet);
        await clearedProductionNavigation(page);
        await page.locator('#GameCanvas').screenshot({ path: path.join(out, `reset-${width}x${height}.png`) });
        await start(); await emptyFarm(page, wallet);
        assert.deepEqual(events.errors, []);
        results.push({ width, height, passed: true, level1Construction: ['feed-1', 'pen:12'], level3NoAdditionalConstruction: true,
          purchases, resetPersisted: true, noMapGhosts: true, resetClearsProductionNavigation: true });
        console.log(`PASS ${width}x${height}: fresh zero buildings, level gates, real construction, restart and reload`);
      } catch (error) {
        await page.screenshot({ path: path.join(out, `failure-${width}x${height}.png`) }).catch(() => {});
        results.push({ width, height, passed: false, error: String(error), errors: events.errors }); throw error;
      } finally { await context.close(); }
    }
  } finally {
    fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(results, null, 2) + '\n');
    await browser.close(); await server.close();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
