'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, plot, tap, observe } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/animal-boost');

async function inspect(page, id) {
  return page.evaluate(id => {
    const a = testApp, cc = testCc, v = a.panels.card.getComponentInChildren('LivestockBodyView');
    const s = a.game.state, animal = s.plots[12].residents.animals.find(x => x.id === id);
    const slot = v.scroll.content.children[animal.slot].getComponent('HerdSlotView');
    const display = v.element(v.owned, 'FeedStockDisplay'), icon = v.element(display, 'FeedIcon');
    const text = v.element(display, 'FeedStock'), shell = a.panels.card.parent.getComponent('DialogShellView');
    const u = a.width / cc.view.getFrameSize().width;
    const box = node => {
      const t = node.getComponent(cc.UITransform), p = node.worldPosition, z = node.worldScale;
      return { x: (p.x - t.width * t.anchorX * z.x) / u, y: (p.y - t.height * t.anchorY * z.y) / u,
        w: t.width * z.x / u, h: t.height * z.y / u };
    };
    const action = slot.actionButton;
    return { status: slot.status.string, action: action.getChildByName('Title').getComponent(cc.Label).string,
      enabled: action.getComponent(cc.Button).interactable, actionId: action.name,
      clockVisible: slot.clockIcon.activeInHierarchy, gemVisible: slot.boostIcon.activeInHierarchy,
      clockFrame: slot.clockIcon.getComponent(cc.Sprite).spriteFrame.uuid,
      gemFrame: slot.boostIcon.getComponent(cc.Sprite).spriteFrame.uuid,
      feedText: text.getComponent(cc.Label).string, diamonds: s.diamonds, eggs: a.game.quantity('farm40:egg'),
      feed: a.game.quantity('farm40:chicken-feed'), ready: animal.job?.ready <= s.time,
      feedBox: box(display), icon: box(icon), stock: box(text), herdCount: box(v.element(display, 'HerdCount')), scroll: box(v.scroll.node),
      footer: box(v.element(v.careActions, 'feed-all')), close: box(shell.closeButton), card: box(shell.card),
      quickBar: !!a.menu.getChildByName('LivestockQuickBar') };
  }, id);
}
function layout(s) {
  assert.equal(s.quickBar, false);
  assert.ok(s.scroll.y - (s.feedBox.y + s.feedBox.h) >= 7.9, 'feed row below scroll with padding');
  assert.ok(s.feedBox.y - (s.footer.y + s.footer.h) >= 7.9, 'feed row above footer with padding');
  assert.ok(Math.min(s.icon.y, s.stock.y, s.herdCount.y) - (s.footer.y + s.footer.h) >= 3.9, 'feed content and herd count clear footer');
  assert.ok(Math.max(s.icon.w, s.icon.h) >= 55.9, 'large feed icon');
  assert.ok(s.icon.y - s.feedBox.y >= 7.9 && s.feedBox.y + s.feedBox.h - s.icon.y - s.icon.h >= 7.9, 'vertical icon padding');
  assert.ok(s.stock.x - s.icon.x - s.icon.w >= 9.9, 'feed quantity clears icon');
  assert.ok(s.close.x >= s.card.x && s.close.x + s.close.w <= s.card.x + s.card.w + .2, 'X inside panel');
  assert.ok(s.close.w >= 43.9 && s.close.h >= 43.9, 'X has a touch target');
  assert.ok(s.close.y - (s.scroll.y + s.scroll.h) >= 3.9, 'X clears animal cards');
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const server = await serve(); let browser;
  const results = [];
  try {
    browser = await launch();
    const cases = [[393, 585], [568, 320], [1280, 720]].filter(([w,h]) => !process.env.COCOS_UI_VIEWPORT || process.env.COCOS_UI_VIEWPORT === `${w}x${h}`);
    assert.ok(cases.length, 'Unknown COCOS_UI_VIEWPORT');
    for (const [width, height] of cases) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true });
      const page = await context.newPage(), events = observe(page);
      try {
        await boot(page, server.url);
        const id = await page.evaluate(() => {
          const a = testApp; a.game.dismissGuide(); a.close();
          a.game.state.inventory['farm40:chicken-feed'] = 3; a.game.state.diamonds = 1;
          a.session.setSpeed(1); a.save(); a.refresh(); a.map.focusBuilding('pen:12');
          return a.game.state.plots[12].residents.animals[0].id;
        });
        await plot(page, 12, true);
        assert.equal(await page.evaluate(() => testApp.panels.view), 'livestock');
        await tap(page, 'animal-' + id, true);
        let s = await inspect(page, id); layout(s);
        assert.match(s.status, /^\d+:\d{2}$/); assert.equal(s.action, '2');
        assert.equal(s.clockVisible, true); assert.equal(s.gemVisible, true);
        assert.equal(s.clockFrame, '55b73db1-4a5a-b0b3-34a3-a46177270a7e@f9941');
        assert.equal(s.gemFrame, '72041700-95c1-3128-dfa9-ba5a85069218@f9941');
        assert.equal(s.actionId, 'boost-animal-' + id); assert.equal(s.enabled, false);
        assert.equal(s.feed, 2); assert.equal(s.eggs, 0);
        const initialStatus = s.status;
        await page.waitForFunction(initial => {
          return testApp.panels.card.getComponentInChildren('HerdSlotView').status.string !== initial;
        }, initialStatus);
        // Advance the simulation across the price threshold; normal refresh must update affordability.
        await page.evaluate(() => testApp.game.tick(61));
        await page.waitForFunction(id => {
          const n = testApp.ui.controls.get('boost-animal-' + id);
          return n?.getComponent(testCc.Button).interactable && n.getChildByName('Title').getComponent(testCc.Label).string === '1';
        }, id);
        s = await inspect(page, id); layout(s);
        await page.screenshot({ path: path.join(out, `boost-${width}x${height}.png`) });
        await tap(page, 'boost-animal-' + id, true);
        s = await inspect(page, id);
        assert.equal(s.diamonds, 0); assert.equal(s.eggs, 0); assert.equal(s.ready, true);
        assert.equal(s.action, 'Nhận trứng'); assert.equal(s.status, 'Có trứng');
        assert.equal(s.clockVisible, false); assert.equal(s.gemVisible, false);
        await tap(page, 'close-panel', true);
        assert.equal(await page.evaluate(() => testApp.panels.view), '');
        await boot(page, server.url); // Fresh scene with persisted boosted job.
        await page.evaluate(() => { testApp.close(); testApp.map.focusBuilding('pen:12'); });
        await plot(page, 12, true);
        s = await inspect(page, id); assert.equal(s.diamonds, 0); assert.equal(s.ready, true);
        await tap(page, 'animal-' + id, true);
        s = await inspect(page, id); assert.equal(s.eggs, 1); assert.equal(s.action, 'Cho ăn');
        await tap(page, 'feed-all', true);
        s = await inspect(page, id); assert.equal(s.feed, 1); assert.equal(s.enabled, false);
        await page.evaluate(() => testApp.game.tick(121));
        await tap(page, 'collect-all-animals', true);
        s = await inspect(page, id); assert.equal(s.eggs, 2); assert.equal(s.diamonds, 0); layout(s);
        await tap(page, 'close-panel', true);
        assert.equal(await page.evaluate(() => testApp.panels.view), '');
        assert.deepEqual(events.errors, []);
        results.push({ width, height, passed: true });
        console.log('PASS', width, height);
      } finally { await context.close(); }
    }
    fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(results, null, 2));
  } finally { await browser?.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
