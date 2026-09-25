'use strict';
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { serve, launch, boot, tap, plot, state, observe } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/land-purchase');

async function offer(page) {
  return page.evaluate(() => {
    const card = testApp.panels.card, cc = testCc;
    const label = name => card.getComponentsInChildren(cc.Label).find(l => l.node.name === name)?.string;
    const sprite = name => {
      const s = card.getComponentsInChildren(cc.Sprite).find(s => s.node.name === name && s.node.activeInHierarchy);
      return s ? !!s.spriteFrame?.texture : null;
    };
    return {
      view: testApp.panels.view,
      text: label('LandOffer'), reason: label('LandRequirement'), wallet: label('LandWallet'),
      lock: sprite('LandLock'), coin: sprite('LandCoin'),
      enabled: farmCocos.controls().find(c => c.id === 'confirm')?.enabled,
      labels: card.getComponentsInChildren(cc.Label).filter(l => l.node.activeInHierarchy).map(l => ({
        text: l.string, size: l.fontSize, actual: l.actualFontSize,
      })),
    };
  });
}
async function land(page) {
  return page.evaluate(() => ({
    targets: farmCocos.targets().filter(p => testApp.game.state.plots.find(q => q.id === p.id)?.group === 'crop'),
    stages: farmCocos.map().items.stages,
    authoredPreviews: testApp.map.layout.fields.flatMap(n => n.getComponentsInChildren(testCc.Sprite))
      .filter(s => s.node.activeInHierarchy).length,
  }));
}
async function settle(page) { await page.waitForTimeout(400); }
async function screenshot(page, name) {
  await page.locator('#GameCanvas').screenshot({ path: path.join(out, name + '.png') });
}
async function disabledClick(page) {
  const p = await page.evaluate(() => farmCocos.controls().find(c => c.id === 'confirm'));
  assert.equal(p.enabled, false);
  const box = await page.locator('#GameCanvas').boundingBox();
  await page.touchscreen.tap(box.x + p.x * box.width, box.y + p.y * box.height);
  await settle(page);
}
async function fixture(page, { level, coins, owned }) {
  // Only test preparation changes wallet/XP/old-save ownership. All purchases below use real pointer input.
  await page.evaluate(({ level, coins, owned }) => {
    const g = testApp.game;
    if (level !== undefined) {
      const c = g.catalog.economy.experience.curve;
      g.state.xp = 0;
      for (let l = 1; l < level; l++)
        g.state.xp += c.baseXP + c.linearXP * (l - 1) + c.quadraticXP * Math.max(0, l - c.quadraticAfterLevel) ** 2;
    }
    if (coins !== undefined) g.state.coins = coins;
    if (owned !== undefined) {
      const fields = g.state.plots.filter(p => p.group === 'crop').sort((a, b) => a.id - b.id);
      fields.forEach((p, i) => {
        p.unlocked = i < owned;
        if (!p.unlocked) Object.assign(p, { crop: null, snapshot: null, started: 0, ready: 0, boosted: false });
      });
    }
    testApp.session.save();
  }, { level, coins, owned });
  await settle(page);
}
async function home(page) {
  await page.evaluate(() => { testApp.close(); testApp.focusHome(); });
  await settle(page);
}
async function focusPlot(page, id) {
  await page.evaluate(id => {
    testApp.close();
    const p = testApp.map.model.plotPositions().find(p => p.plot.id === id);
    const c = testApp.map.camera;
    c.lookAt(p.x, p.y, c.minZoom, 'manual');
  }, id);
  await settle(page);
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const external = process.env.COCOS_TEST_URL;
  const server = external ? { url: external, close: async () => {} } : await serve();
  const browser = await launch(), reports = [];
  try {
    const sizes = [[393, 585], [1280, 720], [320, 568], [844, 390]]
      .filter(([w, h]) => !process.env.COCOS_UI_VIEWPORT || process.env.COCOS_UI_VIEWPORT === `${w}x${h}`);
    for (const [width, height] of sizes) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true });
      const page = await context.newPage(), events = observe(page), tag = `${width}x${height}`;
      try {
        await boot(page, server.url);
        if (external && await page.locator('#view-select').count()) {
          await page.locator('#view-select').click();
          await page.locator('[data-device="FullScreen"]').click();
        }
        await tap(page, 'welcome-start', true);
        await settle(page);
        let s = await state(page), d = await land(page);
        assert.equal(s.plots.filter(p => p.group === 'crop' && p.unlocked).length, 6);
        assert.deepEqual(d.targets.map(p => p.id), [0, 1, 2, 3, 4, 5, 6]);
        assert.equal(d.authoredPreviews, 0, 'Editor soils cannot reveal future plots or duplicate the live renderer');
        assert.deepEqual(d.stages.filter(p => p.soil === 'Soil0').map(p => p.id), [6]);
        assert.ok(d.stages.filter(p => p.id < 6).every(p => p.soil === 'Soil1'));
        await screenshot(page, tag + '-fresh');

        // Real map input, no opening the panel directly from the debug API.
        await plot(page, 6, true);
        let o = await offer(page);
        assert.equal(o.view, 'improve');
        assert.equal(o.text, 'Cần level 2');
        assert.equal(o.enabled, false);
        assert.ok(o.lock); assert.equal(o.coin, null);
        assert.ok(o.labels.some(l => l.text === 'Mua ô đất #7'));
        const prefabCard = await page.evaluate(() => {
          const panel = testApp.panels.card;
          const view = panel.parent.getComponent('LandPurchaseView');
          if (!view) throw Error('Land purchase must instantiate its dedicated editable prefab');
          const scale = panel.worldScale.x * testCc.view.getScaleX() / window.devicePixelRatio;
          const size = panel.getComponent(testCc.UITransform);
          return { uuid: panel.uuid, width: size.width * scale, height: size.height * scale,
            hero: !!panel.getChildByName('NewGreenLand')?.getComponent(testCc.Sprite)?.spriteFrame?.texture };
        });
        assert.ok(prefabCard.hero);
        assert.ok(prefabCard.width <= width - 20 && prefabCard.height <= height - 20, 'Compact prefab fits the screen');
        const originalCoins = s.coins;
        await disabledClick(page);
        assert.equal((await state(page)).coins, originalCoins);
        assert.equal((await state(page)).plots.find(p => p.id === 6).unlocked, false);
        await screenshot(page, tag + '-locked');

        // An open offer must change from level lock to a coin price without closing it.
        await fixture(page, { level: 2, coins: 1999 });
        o = await offer(page);
        assert.equal(o.text, '2,000 xu'); assert.ok(o.coin); assert.equal(o.lock, null);
        assert.equal(o.enabled, false); assert.match(o.wallet, /1 xu/);
        await disabledClick(page);
        assert.equal((await state(page)).coins, 1999);
        await screenshot(page, tag + '-poor');

        await fixture(page, { coins: 2100 });
        assert.equal(await page.evaluate(() => testApp.panels.card.uuid), prefabCard.uuid, 'Live updates reuse authored nodes');
        assert.equal((await offer(page)).enabled, true);
        if (width === 393) {
          await page.setViewportSize({ width: height, height: width });
          await page.waitForTimeout(700);
          assert.equal((await offer(page)).text, '2,000 xu');
          assert.equal(await page.evaluate(() => testApp.panels.card.uuid), prefabCard.uuid, 'Rotation preserves the prefab instance');
          await page.setViewportSize({ width, height });
          await page.waitForTimeout(700);
          assert.equal((await offer(page)).enabled, true);
        }
        await screenshot(page, tag + '-ready');
        await tap(page, 'confirm', true);
        await settle(page);
        s = await state(page); d = await land(page);
        assert.equal(s.coins, 100);
        assert.equal(d.authoredPreviews, 0);
        assert.equal(s.plots.filter(p => p.group === 'crop' && p.unlocked).length, 7);
        assert.equal(d.stages.find(p => p.id === 6).soil, 'Soil1');
        assert.deepEqual(d.stages.filter(p => p.soil === 'Soil0').map(p => p.id), [7]);
        assert.deepEqual(d.targets.map(p => p.id), [0, 1, 2, 3, 4, 5, 6, 7]);
        assert.equal(await page.evaluate(() => testApp.panels.view), '');
        await screenshot(page, tag + '-purchased');
        await plot(page, 7, true);
        assert.equal((await offer(page)).text, 'Cần level 4');
        await tap(page, 'cancel-confirm', true);
        await plot(page, 6, true);
        await tap(page, 'plant-1', true);
        s = await state(page);
        assert.equal(s.coins, 80); assert.equal(s.plots.find(p => p.id === 6).crop, 1);
        await boot(page, server.url); await settle(page);
        s = await state(page); d = await land(page);
        assert.equal(s.coins, 80); assert.equal(s.plots.find(p => p.id === 6).crop, 1);
        assert.deepEqual(d.stages.filter(p => p.soil === 'Soil0').map(p => p.id), [7]);

        // The user's four-owned-plots example works too when loading that ownership state.
        await fixture(page, { owned: 4 }); await home(page);
        d = await land(page);
        assert.deepEqual(d.targets.map(p => p.id), [0, 1, 2, 3, 4]);
        assert.deepEqual(d.stages.filter(p => p.soil === 'Soil0').map(p => p.id), [4]);

        // A real legacy/all-but-one ownership fixture checks the highest price and final marker removal.
        await fixture(page, { owned: 39, level: 68, coins: 10250100 });
        await home(page); await focusPlot(page, 49); await plot(page, 49, true);
        o = await offer(page);
        assert.equal(o.text, '10,250,000 xu'); assert.equal(o.enabled, true);
        assert.ok(o.labels.some(l => l.text === 'Mua ô đất #40'));
        assert.ok(o.labels.filter(l => l.text).every(l => l.actual >= l.size * 0.9), 'Price and text remain legible');
        await screenshot(page, tag + '-last-price');
        await tap(page, 'close-panel', true);
        assert.equal(await page.evaluate(() => testApp.panels.view), '');
        await plot(page, 49, true);
        assert.equal((await offer(page)).text, '10,250,000 xu');
        await tap(page, 'confirm', true); await settle(page);
        s = await state(page); d = await land(page);
        assert.equal(s.coins, 100); assert.equal(d.targets.length, 40);
        assert.equal(d.stages.filter(p => p.soil === 'Soil0').length, 0);
        await boot(page, server.url); await settle(page);
        s = await state(page); d = await land(page);
        assert.equal(s.plots.filter(p => p.group === 'crop' && p.unlocked).length, 40);
        assert.equal(s.coins, 100); assert.equal(d.stages.filter(p => p.soil === 'Soil0').length, 0);
        assert.deepEqual(events.errors, []);
        reports.push({ viewport: { width, height }, passed: true, firstPrice: 2000, lastPrice: 10250000,
          sequentialMarker: true, liveLevelAndWallet: true, purchaseAndPlant: true, reload: true, legacyOwnership: true });
        console.log('PASS ' + tag);
      } catch (error) {
        await screenshot(page, tag + '-failure').catch(() => {});
        console.error('UI at failure', await offer(page).catch(() => null));
        throw error;
      } finally { await context.close(); }
    }
  } finally { await browser.close(); await server.close(); }
  fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ passed: true, reports }, null, 2) + '\n');
})().catch(error => { console.error(error); process.exitCode = 1; });
