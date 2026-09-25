'use strict';
const fs = require('node:fs'), path = require('node:path'), assert = require('node:assert/strict');
const { serve, launch, boot, tap, plot, site, state, observe } = require('./browser-support.cjs');
const { loadFarmCatalog } = require('../tools/load-farm-catalog.cjs');
const catalog = loadFarmCatalog(), out = path.resolve(__dirname, '../artifacts/timing-config');

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const server = await serve(), browser = await launch(), results = [];
  try {
    for (const edited of [false, true]) {
      const context = await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true });
      const page = await context.newPage(), observed = observe(page);
      let replacedAssets = 0;
      // Freeze wall time to inspect exact countdown labels; Cocos animation frames remain live.
      await context.addInitScript(() => { Date.now = () => 1900000000000; });
      if (edited) await context.route('**/assets/farm-town/**/*.json', async route => {
        const response = await route.fetch(), data = await response.json();
        const edit = value => {
          if (!value || typeof value !== 'object') return;
          if (value.version === 1 && typeof value.boostSecondsPerGem === 'number' && value.crops?.wheat?.durationSeconds && value.animals?.layer && value.recipes?.['7']) {
            value.crops.wheat.durationSeconds = 123;
            value.animals.layer.durationSeconds = 321;
            value.recipes['7'].durationSeconds = 456;
            value.boostSecondsPerGem = 60;
            replacedAssets++;
          } else Object.values(value).forEach(edit);
        };
        edit(data);
        await route.fulfill({ response, body: JSON.stringify(data) });
      });
      try {
        await boot(page, server.url); await tap(page, 'welcome-start', true);
        const loaded = await page.evaluate(() => {
          const catalog = testApp.game.catalog;
          return { crops: catalog.farm.map(c => [c.id, c.duration]), animals: catalog.livestock.map(a => [a.key, a.duration]),
            recipes: catalog.products.map(r => [r.id, r.duration]), boost: catalog.boostSecondsPerGem };
        });
        assert.deepEqual(loaded, {
          crops: catalog.farm.map(c => [c.id, edited && c.id === 1 ? 123 : c.duration]),
          animals: catalog.livestock.map(a => [a.key, edited && a.key === 'layer' ? 321 : a.duration]),
          recipes: catalog.products.map(r => [r.id, edited && r.id === 7 ? 456 : r.duration]),
          boost: edited ? 60 : catalog.boostSecondsPerGem,
        });
        if (edited) assert.equal(replacedAssets, 1, 'the actual JSON asset response was edited once');
        await plot(page, 0, true); await tap(page, 'plant-1', true);
        let farm = await state(page);
        assert.equal(farm.plots[0].snapshot.duration, edited ? 123 : catalog.farm[0].duration);
        assert.equal(farm.coins, 480);
        if (edited) {
          await plot(page, 0, true);
          const labels = await page.evaluate(() => farmCocos.labels().map(label => label.text));
          assert.ok(labels.includes('02:03'), 'the crop bubble renders timing.json seconds');
          assert.equal(await page.evaluate(() => testApp.game.boostPrice(testApp.game.state.plots[0])), 3);
          // Only ingredients are supplied by the fixture; gameplay, catalog and timers stay unmodified.
          await page.evaluate(() => {
            testApp.game.state.inventory = { 'raw:1': 20, 'farm40:chicken-feed': 1 };
            testApp.session.save(); testApp.refresh();
          });
          await site(page, 'bakery-1', true); await tap(page, 'produce-7', true);
          farm = await state(page); assert.equal(farm.machines.find(m => m.type === 1).job.duration, 456);
          await page.evaluate(() => { testApp.close(); testApp.map.focusBuilding('pen:12'); });
          await plot(page, 12, true); await tap(page, 'feed-all', true);
          farm = await state(page); const job = farm.plots[12].residents.animals[0].job;
          assert.equal(job.ready - job.started, 321);
        }
        assert.deepEqual(observed.errors, []);
        await page.screenshot({ path: path.join(out, edited ? 'edited-timing.png' : 'default-timing.png') });
        results.push({ edited, replacedAssets, passed: true, loaded });
      } catch (error) {
        await page.screenshot({ path: path.join(out, 'failure.png') }); throw error;
      } finally { await context.close(); }
    }
    fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ passed: true,
      method: 'Default build versus an edited timing JsonAsset response; fixed wall clock and ingredient-only fixture; native planting, production and feeding.', results }, null, 2) + '\n');
    console.log('Timing JSON: default values and edited crop/animal/recipe/boost values pass in the built game.');
  } finally { await browser.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
