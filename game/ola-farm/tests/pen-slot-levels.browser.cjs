'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, plot, tap, observe } = require('./browser-support.cjs');
const catalog = require('../tools/load-farm-catalog.cjs').loadFarmCatalog();
const out = path.resolve(__dirname, '../artifacts/pen-slot-levels');

async function inspect(page, plotId) {
  return page.evaluate(plotId => {
    const a = testApp, cc = testCc, body = a.panels.card.getComponentInChildren('LivestockBodyView');
    const pen = a.game.state.plots.find(p => p.id === plotId).residents;
    const u = a.width / cc.view.getFrameSize().width;
    const box = node => {
      const t = node.getComponent(cc.UITransform), p = node.worldPosition, scale = node.worldScale;
      const l = (p.x - t.width * t.anchorX * scale.x) / u, b = (p.y - t.height * t.anchorY * scale.y) / u;
      const w = t.width * scale.x / u, h = t.height * scale.y / u;
      return { l, r: l + w, b, t: b + h, w, h };
    };
    return { capacity: pen.capacity, animals: pen.animals.length, coins: a.game.state.coins,
      frame: box(a.panels.card), viewport: box(body.scroll.content.parent),
      fixedActions: [box(body.element(body.careActions,'feed-all')),box(body.element(body.careActions,'collect-all-animals'))],
      herdCountVisible: body.node.getComponentsInChildren(cc.Label).some(l=>l.node.activeInHierarchy && /^\d+\/\d+ con$/.test(l.string)),
      slots: body.scroll.content.children.map(node => {
        const v = node.getComponent('HerdSlotView'), title = v.actionButton.getChildByName('Title');
        return { status: v.status.string, price: title.getComponent(cc.Label).string,
          enabled: v.actionButton.getComponent(cc.Button).interactable,
          lockVisible: v.lock.activeInHierarchy, coinVisible: v.purchaseIcon.activeInHierarchy,
          gemVisible: v.boostIcon.activeInHierarchy, coinFrame: v.purchaseIcon.getComponent(cc.Sprite).spriteFrame.uuid,
          cell: box(node), lock: box(v.lock), number: box(v.number.node), statusBox: box(v.status.node),
          action: box(v.actionButton), priceBox: box(title), coin: box(v.purchaseIcon) };
      }) };
  }, plotId);
}

function verifyLocked(s, plotId) {
  assert.equal(s.herdCountVisible, false, 'the repeated herd count is removed');
  for (const b of [...s.fixedActions,s.viewport]) {
    assert.ok(b.l >= s.frame.l + 24 && b.r <= s.frame.r - 24, 'content stays inside the side borders');
    assert.ok(b.b >= s.frame.b + 24 && b.t <= s.frame.t - 48, 'content clears the rounded bottom and title');
  }
  const visible = s.slots.filter(v=>v.cell.l < s.viewport.r-.5 && v.cell.r > s.viewport.l+.5);
  assert.ok(visible.length >= 2, 'narrow screens fit two complete cards');
  assert.ok(visible.every(v=>v.cell.l >= s.viewport.l-.2 && v.cell.r <= s.viewport.r+.2), 'initial cards fit without clipped text');
  for (let slot = 1; slot < 5; slot++) {
    const v = s.slots[slot], small = v.cell.h < 176;
    assert.equal(v.status, 'Chưa đủ cấp');
    assert.equal(v.price, `Level ${slot + 1}`);
    assert.equal(v.enabled, false); assert.equal(v.lockVisible, true);
    assert.equal(v.coinVisible, false); assert.equal(v.gemVisible, false);
    assert.equal(v.coinFrame, '944e84bc-66e4-4bde-b6ff-43975d0d8c07@f9941');
    assert.ok(Math.abs(v.lock.w - (small ? 36 : 48)) < .2);
    assert.ok(Math.abs(v.lock.h - (small ? 40.5 : 54)) < .2);
    assert.ok(v.priceBox.l >= v.action.l && v.priceBox.r <= v.action.r, 'required level fits the action');
    assert.ok(v.statusBox.b >= v.action.t + 3.8, 'required level clears action');
    if (small) {
      assert.ok(v.lock.r + 3.8 <= v.statusBox.l && v.lock.r + 3.8 <= v.number.l, 'large lock clears text');
      assert.ok(v.lock.b >= v.action.t + 3.8, 'large lock clears action');
    } else {
      assert.ok(v.lock.t + 3.8 <= v.number.b, 'large lock clears slot number');
      assert.ok(v.statusBox.t + 3.8 <= v.lock.b, 'large lock clears level');
    }
  }
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const server = await serve(); let browser;
  const results = [];
  try {
    browser = await launch();
    const cases = [[320, 568], [393, 585], [568, 320], [1280, 720]].filter(([w,h]) => !process.env.COCOS_UI_VIEWPORT || process.env.COCOS_UI_VIEWPORT === `${w}x${h}`);
    assert.ok(cases.length, 'Unknown COCOS_UI_VIEWPORT');
    for (const [width, height] of cases) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true });
      const page = await context.newPage(), events = observe(page);
      try {
        await boot(page, server.url);
        await page.evaluate(() => { testApp.game.dismissGuide(); testApp.close(); testApp.game.state.coins = 10000; testApp.save(); });
        for (const plotId of [12, 13]) {
          await page.evaluate(id => { testApp.close(); testApp.game.state.xp = 0; testApp.refresh(); testApp.map.focusBuilding('pen:' + id); }, plotId);
          await plot(page, plotId, true);
          assert.equal(await page.evaluate(() => testApp.panels.view), 'livestock');
          const before = await inspect(page, plotId); fs.writeFileSync(path.join(out,`geometry-${plotId}-${width}x${height}.json`),JSON.stringify(before,null,2)); verifyLocked(before, plotId);
          await page.screenshot({ path: path.join(out, `${plotId === 12 ? 'chicken' : 'cow'}-${width}x${height}.png`) });
          // Only XP changes: the open panel must refresh eligibility without a reopen or forced render.
          await page.evaluate(() => { testApp.game.state.xp = 80; });
          await page.waitForFunction(() => testApp.ui.controls.get('unlock-pen-slot-1')?.getComponent(testCc.Button).interactable);
          const eligible = await inspect(page, plotId);
          assert.equal(eligible.slots[1].status, 'Chưa mở'); assert.equal(eligible.slots[2].price, 'Level 3');
          const config = catalog.economy.animals[plotId === 12 ? 'layer' : 'dairy-cow'], price = config.purchasePrice + config.slots[0].price;
          assert.equal(eligible.slots[1].price, String(price)); assert.equal(eligible.slots[1].coinVisible, true);
          await tap(page, 'unlock-pen-slot-1', true);
          const bought = await inspect(page, plotId);
          assert.equal(bought.capacity, 2); assert.equal(bought.animals, 2);
          assert.equal(bought.coins, before.coins - price);
          assert.equal(bought.slots[1].status, 'Đói'); assert.equal(bought.slots[1].price, 'Cho ăn');
          assert.equal(bought.slots[1].lockVisible, false); assert.equal(bought.slots[1].coinVisible, false);
          results.push({ width, height, plotId, passed: true, locked: before.slots.slice(1) });
          console.log('PASS', width, height, plotId === 12 ? 'chicken' : 'cow');
          await tap(page, 'close-panel', true);
        }
        await page.evaluate(() => { testApp.game.state.xp = 0; testApp.save(); });
        await boot(page, server.url);
        for (const plotId of [12, 13]) {
          await page.evaluate(id => { testApp.close(); testApp.map.focusBuilding('pen:' + id); }, plotId);
          await plot(page, plotId, true);
          const restored = await inspect(page, plotId);
          assert.equal(restored.capacity, 2); assert.equal(restored.animals, 2);
          assert.equal(restored.slots[1].lockVisible, false); assert.equal(restored.slots[1].coinVisible, false);
          assert.equal(restored.slots[1].status, 'Đói');
          await tap(page, 'close-panel', true);
        }
        // Reproduce the reported three-cow state and inspect the last two locked cards.
        if (width === 393) {
          await page.evaluate(()=>{testApp.game.state.xp=210;testApp.game.state.coins=10000;testApp.map.focusBuilding('pen:13');});
          await plot(page,13,true); await tap(page,'unlock-pen-slot-2',true);
          await page.evaluate(()=>testApp.panels.scroll.scrollToRight(0));
          const last = await inspect(page,13);
          assert.equal(last.animals,3); assert.equal(last.herdCountVisible,false);
          assert.equal(last.slots[3].price,'Level 4'); assert.equal(last.slots[4].price,'Level 5');
          for (const v of last.slots.slice(3)) assert.ok(v.cell.l>=last.viewport.l-.2&&v.cell.r<=last.viewport.r+.2);
          await page.screenshot({path:path.join(out,'cow-three-last-slots-393x585.png')});
          await tap(page,'close-panel',true); await page.evaluate(()=>{testApp.game.state.xp=0;});
        }
        // Shop now constructs a separate pen; animal slot expansion remains inside each pen.
        await page.evaluate(() => { testApp.panels.shopTab = 'animals'; testApp.open('shop'); });
        const cards = await page.evaluate(() => testApp.panels.card.getComponentsInChildren('ShopCardView').filter(v => [12,13].some(id => testApp.ui.controls.get('shop-animal-' + id) === v.priceButton)).map(v => ({
          id: [12,13].find(id=>testApp.ui.controls.get('shop-animal-'+id)===v.priceButton), enabled: v.priceButton.getComponent(testCc.Button).interactable, reason: v.description.string, count: v.quantity.string
        })));
        for (const card of cards) { assert.equal(card.enabled, false); assert.equal(card.reason, `Cần level ${catalog.residentPens.find(p=>p.plotId===(card.id===12?50:51)).requiredLevel}`); assert.equal(card.count, '1/2'); }
        assert.deepEqual(events.errors, []);
      } finally { await context.close(); }
    }
    fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(results, null, 2));
  } finally { await browser?.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
