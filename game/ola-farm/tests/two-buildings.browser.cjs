'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, plot, site, observe } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/two-buildings');
const catalog = require('../tools/load-farm-catalog.cjs').loadFarmCatalog();
async function shop(page, tab) { await page.evaluate(tab => { testApp.close(); testApp.panels.shopTab = tab; testApp.open('shop'); }, tab); }
async function card(page, id) {
  return page.evaluate(id => {
    const n = testApp.ui.controls.get(id), v = testApp.panels.card.getComponentsInChildren('ShopCardView').find(v => v.priceButton === n);
    return { count: v.quantity.string, reason: v.description.string, price: v.priceLabel.string,
      coin: v.coin.node.activeInHierarchy, enabled: n.getComponent(testCc.Button).interactable };
  }, id);
}
async function panel(page) { return page.evaluate(() => ({ view: testApp.panels.view, machine: testApp.panels.machineId,
  pen: testApp.panels.penId, title: testApp.panels.card.parent.getComponent('DialogShellView').title.string })); }
(async () => {
  fs.mkdirSync(out, { recursive: true }); const server = await serve(), browser = await launch(), results = [];
  try {
    for (const [width, height] of [[393, 585], [568, 320], [1280, 720]]) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true }), page = await context.newPage(), events = observe(page);
      try {
        await boot(page, server.url);
        await page.evaluate(() => {
          const a = testApp, g = a.game, ok = r => { if (r.error) throw Error(r.error); };
          g.dismissGuide(); a.close(); g.state.coins = 50000; g.state.diamonds = 1000; g.state.xp = 2519;
          g.state.husbandry = { version: 1, feedReceived: true, eggsCollected: true, milkCollected: true, burgerCollected: true };
          for (const item of g.items) g.state.inventory[item.key] = 100;
          for (const t of g.machineTypes) if (!g.state.machines.some(m => m.type === t.id)) ok(g.buyMachine(t.id));
          for (const id of [14, 15]) ok(g.buyPen(id)); a.refresh(); a.save();
        });
        for (const tab of ['buildings', 'animals']) {
          await shop(page, tab);
          const ids = tab === 'buildings' ? catalog.machineTypes.map(t => 'shop-machine-' + t.id) : [12,13,14,15].map(id => 'shop-animal-' + id);
          for (const id of ids) { const c = await card(page, id); assert.equal(c.count, '1/2'); assert.match(c.reason, /10/); assert.equal(c.enabled, false); assert.equal(c.coin, true); assert.match(c.price, /^\d+$/); }
          await page.screenshot({ path: path.join(out, `${tab}-locked-${width}x${height}.png`) });
        }
        // Change only XP while Shop stays open: eligibility must update through its normal refresh.
        await page.evaluate(() => { testApp.game.state.xp = 2520; });
        await page.waitForFunction(() => testApp.ui.controls.get('shop-animal-12').getComponent(testCc.Button).interactable);
        for (const t of catalog.machineTypes) {
          await shop(page, 'buildings'); const id = 'shop-machine-' + t.id, before = await page.evaluate(() => testApp.game.state.coins), c = await card(page, id);
          assert.equal(c.price, String(t.buildSites[1].price)); await tap(page, id, true);
          assert.equal(await page.evaluate(() => testApp.game.state.coins), before - Number(c.price));
          await shop(page, 'buildings'); const full = await card(page, id); assert.equal(full.count, '2/2'); assert.equal(full.enabled, false); assert.equal(full.coin, false);
        }
        for (const [first, second] of [[12,50], [13,51], [14,52], [15,53]]) {
          await shop(page, 'animals'); const id = 'shop-animal-' + first, c = await card(page, id), before = await page.evaluate(() => testApp.game.state.coins);
          await tap(page, id, true); assert.equal(await page.evaluate(() => testApp.game.state.coins), before - Number(c.price));
          assert.equal(await page.evaluate(id => testApp.game.residentPlot(id).residents.animals.length, second), 1);
          await shop(page, 'animals'); const full = await card(page, id); assert.equal(full.count, '2/2'); assert.equal(full.enabled, false);
        }
        await page.screenshot({ path: path.join(out, `animals-full-${width}x${height}.png`) });
        const machines = await page.evaluate(() => testApp.game.state.machines.map(m => ({ id: m.id, buildingId: m.buildingId, name: testApp.game.machineName(m) })));
        assert.equal(machines.length, 16);
        for (const m of machines) {
          await site(page, m.buildingId, true); const p = await panel(page); assert.equal(p.view, 'factory', m.buildingId); assert.equal(p.machine, m.id); assert.equal(p.title, m.name);
          if (m.buildingId === 'bakery-2') await page.screenshot({ path: path.join(out, `bakery-2-${width}x${height}.png`) });
        }
        for (const id of [12,13,14,15,50,51,52,53]) {
          await page.evaluate(id => { testApp.close(); testApp.map.focusBuilding('pen:' + id); }, id); await plot(page, id, true);
          const p = await panel(page); assert.equal(p.view, 'livestock'); assert.equal(p.pen, id); assert.match(p.title, new RegExp(id >= 50 ? '2$' : '1$'));
        }
        // Real care controls on pen 2 must neither expand nor feed pen 1.
        await page.evaluate(() => { testApp.close(); testApp.map.focusBuilding('pen:50'); }); await plot(page, 50, true);
        const first = await page.evaluate(() => JSON.stringify(testApp.game.residentPlot(12).residents));
        await tap(page, 'unlock-pen-slot-1', true);
        assert.equal(await page.evaluate(() => testApp.panels.card.getComponentsInChildren(testCc.Label).find(l => l.node.name === 'HerdCount').string), '2/5 con');
        const animal = await page.evaluate(() => testApp.game.residentPlot(50).residents.animals[0].id);
        await tap(page, 'animal-' + animal, true); await tap(page, 'boost-animal-' + animal, true); await tap(page, 'animal-' + animal, true);
        assert.equal(await page.evaluate(() => JSON.stringify(testApp.game.residentPlot(12).residents)), first);
        await page.screenshot({ path: path.join(out, `chicken-2-${width}x${height}.png`) });
        // Built list exposes both instances and routes by saved machine ID.
        await page.evaluate(() => { testApp.close(); testApp.open('industries'); });
        const secondBakery = machines.find(m => m.buildingId === 'bakery-2'); await tap(page, 'building-instance-' + secondBakery.id, true);
        assert.equal((await panel(page)).machine, secondBakery.id);
        await tap(page, 'choose-recipe', true); await tap(page, 'select-recipe-100207', true); await tap(page, 'recipe-ingredient-0', true);
        const sources = await page.evaluate(() => [...testApp.ui.controls].filter(([id]) => id.startsWith('ingredient-source-')).map(([id,n]) => ({ id, text: n.getComponentsInChildren(testCc.Label).map(l => l.string).join(' ') })));
        assert.ok(sources.some(s => /1/.test(s.text))); assert.ok(sources.some(s => /2/.test(s.text)), 'source list offers second instances');
        await tap(page, 'ingredients-back', true); assert.equal((await panel(page)).machine, secondBakery.id);
        await page.evaluate(() => { testApp.close(); testApp.game.state.xp = 0; testApp.save(); });
        await boot(page, server.url);
        assert.deepEqual(await page.evaluate(() => [testApp.game.state.version, testApp.game.state.plots.length, testApp.game.state.machines.length, testApp.game.state.plots.filter(p => p.residents).length, testApp.game.residentPlot(50).residents.capacity]), [7,54,16,8,2]);
        assert.deepEqual(events.errors, []); results.push({ width, height, passed: true, machines: 16, pens: 8 }); console.log('PASS', width, height);
      } finally { await context.close(); }
    }
    fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(results, null, 2) + '\n');
  } finally { await browser.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
