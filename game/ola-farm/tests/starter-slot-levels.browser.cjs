'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, plot, site, observe } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/starter-slot-levels');
const levels = [5, 10, 15, 20];

async function snapshot(page) {
  return page.evaluate(() => { const s = JSON.parse(JSON.stringify(testApp.game.state)); delete s.time; return s; });
}
async function xp(page, required, before = false) {
  await page.evaluate(({ required, before }) => {
    const g = testApp.game, c = g.catalog.economy.experience.curve; let total = 0;
    for (let n = 1; n < required; n++) total += c.baseXP + c.linearXP * (n - 1) + c.quadraticXP * Math.max(0, n - c.quadraticAfterLevel) ** 2;
    g.state.xp = total - Number(before);
  }, { required, before });
  // Eligibility must refresh naturally while the same panel remains open.
  await page.waitForTimeout(350);
}
async function inspect(page, kind) {
  return page.evaluate(kind => {
    const a = testApp, cc = testCc, chicken = kind === 'chicken';
    const body = a.panels.card.getComponentInChildren(chicken ? 'LivestockBodyView' : 'FactoryBodyView');
    if (!body) throw Error('Missing runtime body for ' + kind);
    const owner = chicken ? a.game.residentPlot(12).residents : a.game.state.machines.find(m => m.type === 5);
    const nodes = chicken ? body.scroll.content.children : body.queue.children;
    const idFor = node => [...a.ui.controls].find(([, n]) => n === node)?.[0] ?? null;
    return { capacity: owner.capacity, animals: chicken ? owner.animals.length : null, coins: a.game.state.coins,
      level: a.game.progress.level, nullLayoutNodes: body.layoutNodes.map((n, i) => !n ? i : -1).filter(i => i >= 0),
      slots: nodes.map(node => {
        const v = node.getComponent(chicken ? 'HerdSlotView' : 'FactoryQueueSlotView');
        if (!v) return { missingView: true, name: node.name };
        const action = chicken ? v.actionButton : node;
        return { id: idFor(action), enabled: action.getComponent(cc.Button).interactable,
          label: chicken ? action.getChildByName('Title').getComponent(cc.Label).string : v.add.string,
          price: chicken ? action.getChildByName('Title').getComponent(cc.Label).string : v.price.string,
          locked: chicken ? v.lock.activeInHierarchy : v.price.node.activeInHierarchy,
          coin: chicken ? v.purchaseIcon.activeInHierarchy : v.coin.activeInHierarchy };
      }) };
  }, kind);
}
async function reveal(page, id) {
  let target;
  for (let attempt = 0; attempt < 60; attempt++) {
    target = await page.evaluate(id => {
      const a = testApp, cc = testCc, node = a.ui.controls.get(id);
      if (!node?.activeInHierarchy) throw Error('Missing runtime control ' + id);
      const rect = n => { const t = n.getComponent(cc.UITransform), p = n.worldPosition, s = n.worldScale;
        return { x: p.x - t.width * t.anchorX * s.x, y: p.y - t.height * t.anchorY * s.y, w: t.width * s.x, h: t.height * s.y }; };
      const b = rect(node); let clip;
      for (let p = node.parent; p; p = p.parent) if (p.getComponent(cc.Mask)) clip = rect(p);
      const below = clip ? Math.max(0, clip.y - b.y) : 0, above = clip ? Math.max(0, b.y + b.h - clip.y - clip.h) : 0;
      const left = clip ? Math.max(0, clip.x - b.x) : 0, right = clip ? Math.max(0, b.x + b.w - clip.x - clip.w) : 0;
      const horizontal = left > 1 || right > 1, viewport = cc.view.getViewportRect(), canvas = cc.view.getCanvasSize();
      const scrollAt = clip ? { x: (viewport.x + (clip.x + clip.w / 2) * cc.view.getScaleX()) / canvas.width,
        y: 1 - (viewport.y + (clip.y + clip.h / 2) * cc.view.getScaleY()) / canvas.height } : { x: .5, y: .5 };
      return { ...farmCocos.controls().find(c => c.id === id), clipped: Math.max(below, above, left, right) > 1,
        direction: horizontal ? right > 0 ? -1 : 1 : below > 0 ? 1 : -1,
        delta: Math.max(4, Math.min(120, Math.max(below, above, left, right) * 2 + 4)), scrollAt };
    }, id);
    if (!target.clipped) break;
    const canvas = await page.locator('#GameCanvas').boundingBox();
    await page.mouse.move(canvas.x + target.scrollAt.x * canvas.width, canvas.y + target.scrollAt.y * canvas.height);
    await page.mouse.wheel(0, target.direction * target.delta); await page.waitForTimeout(85);
  }
  assert.equal(target.clipped, false, id + ' is fully visible before input');
  await page.evaluate(() => testApp.panels.scroll?.stopAutoScroll());
  target = await page.evaluate(id => farmCocos.controls().find(c => c.id === id), id);
  assert.ok(target.x > 0 && target.x < 1 && target.y > 0 && target.y < 1);
  const canvas = await page.locator('#GameCanvas').boundingBox();
  return { x: canvas.x + target.x * canvas.width, y: canvas.y + target.y * canvas.height, enabled: target.enabled };
}
async function pointer(page, position) { await page.touchscreen.tap(position.x, position.y); await page.waitForTimeout(140); }
function lockedSlot(slot, level, kind) {
  assert.equal(slot.enabled, false); assert.equal(slot.locked, true);
  assert.equal(slot.label, kind === 'chicken' ? `Level ${level}` : `Lv ${level}`);
  assert.equal(slot.coin, kind !== 'chicken');
}
async function open(page, kind) {
  if (kind === 'chicken') {
    await page.evaluate(() => { testApp.close(); testApp.map.focusBuilding('pen:12'); });
    await plot(page, 12, true);
  } else await site(page, 'feed-1', true);
  assert.equal(await page.evaluate(() => testApp.panels.view), kind === 'chicken' ? 'livestock' : 'factory');
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const external = process.env.COCOS_TEST_URL;
  const server = external ? { url: external, close: async () => {} } : await serve();
  const browser = await launch(), results = []; let failed = false;
  try {
    const cases = [[393, 585], [1280, 720]].filter(([w, h]) => !process.env.COCOS_UI_VIEWPORT || process.env.COCOS_UI_VIEWPORT === `${w}x${h}`);
    assert.ok(cases.length, 'Known viewport required');
    for (const [width, height] of cases) {
      // Isolated temporary contexts never attach to or reset the user's profile.
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
        const configured = await page.evaluate(() => ({ chicken: testApp.game.catalog.economy.animals.layer.slots.map(s => s.requiredLevel),
          feedmill: testApp.game.catalog.economy.machines.feedmill.queueSlots.map(s => s.requiredLevel) }));
        assert.deepEqual(configured, { chicken: levels, feedmill: levels }, 'Preview must import the current slot levels');
        await page.evaluate(() => {
          const a = testApp; a.game.dismissGuide(); a.close();
          for (const action of [{ type: 'buyMachine', machineType: 5 }, { type: 'buyPen', plot: 12 }]) {
            const r = a.session.dispatch(action); if (!r.ok) throw Error(r.result.error || 'Construction failed');
          }
          if (a.game.progress.level !== 1 || a.game.state.coins !== 80) throw Error('Both starter types must build naturally at level 1');
          a.game.state.coins = 100000; a.save(); a.refresh();
        });
        console.log(`READY ${width}x${height}: real level-1 construction and imported slot levels`);
        for (const kind of ['chicken', 'feedmill']) {
          const errorStart = events.errors.length;
          try {
            await xp(page, 1); await open(page, kind);
            let shown = await inspect(page, kind);
            assert.deepEqual(shown.nullLayoutNodes, [], kind + ': authored layout nodes must resolve before slot rendering');
            assert.equal(shown.capacity, 1);
            for (let slot = 1; slot < 5; slot++) lockedSlot(shown.slots[slot], levels[slot - 1], kind);
            await page.locator('#GameCanvas').screenshot({ path: path.join(out, `${kind}-locked-${width}x${height}.png`) });
            const transactions = [];
            for (let slot = 1; slot < 5; slot++) {
              const required = levels[slot - 1], id = kind === 'chicken' ? 'unlock-pen-slot-' + slot : 'expand-queue';
              await xp(page, required, true); shown = await inspect(page, kind); lockedSlot(shown.slots[slot], required, kind);
              const rejected = await snapshot(page), disabled = await reveal(page, id);
              assert.equal(disabled.enabled, false); await pointer(page, disabled);
              assert.deepEqual(await snapshot(page), rejected, kind + ': real disabled pointer leaves ownership/wallet unchanged');
              await xp(page, required); const eligible = await inspect(page, kind), action = eligible.slots[slot];
              assert.equal(action.enabled, true, kind + ': XP alone refreshes the currently open panel');
              assert.equal(action.coin, true);
              const price = await page.evaluate(({ kind, slot }) => kind === 'chicken' ? testApp.game.penSlotPrice(12, slot)
                : testApp.game.queueSlotPrice(testApp.game.state.machines.find(m => m.type === 5).id, slot), { kind, slot });
              if (slot === 1) assert.equal(price, kind === 'chicken' ? 165 : 60);
              assert.equal(action.price, String(price)); if (kind === 'feedmill') assert.equal(action.label, '+');
              const before = await snapshot(page), position = await reveal(page, id); await pointer(page, position);
              const bought = await inspect(page, kind);
              assert.equal(bought.capacity, slot + 1); if (kind === 'chicken') assert.equal(bought.animals, slot + 1);
              assert.equal(bought.coins, before.coins - price); assert.equal(bought.slots[slot].locked, false);
              if (slot < 4) lockedSlot(bought.slots[slot + 1], levels[slot], kind);
              const once = await snapshot(page); await pointer(page, position);
              assert.deepEqual(await snapshot(page), once, kind + ': repeat pointer at the purchased slot cannot charge again');
              transactions.push({ slot: slot + 1, requiredLevel: required, price, capacity: bought.capacity });
              if (slot === 1) await page.locator('#GameCanvas').screenshot({ path: path.join(out, `${kind}-slot2-${width}x${height}.png`) });
            }
            await xp(page, 1); await page.evaluate(() => { testApp.close(); testApp.save(); });
            const paid = await snapshot(page); await start();
            assert.deepEqual(await snapshot(page), paid, kind + ': paid slots survive lower XP and reload');
            await open(page, kind); shown = await inspect(page, kind);
            assert.equal(shown.capacity, 5); if (kind === 'chicken') assert.equal(shown.animals, 5);
            assert.ok(shown.slots.every(s => !s.locked)); assert.deepEqual(events.errors.slice(errorStart), []);
            await tap(page, 'close-panel', true);
            results.push({ width, height, kind, passed: true, transactions, paidSlotsRetainedAtLevel1: true });
            console.log(`PASS ${width}x${height} ${kind}: 5/10/15/20, disabled input, exact debits, once-only purchase and reload`);
          } catch (error) {
            failed = true;
            const diagnosis = await page.evaluate(kind => {
              const body = testApp.panels.card?.getComponentInChildren(kind === 'chicken' ? 'LivestockBodyView' : 'FactoryBodyView');
              return { view: testApp.panels.view, nullLayoutNodes: body?.layoutNodes.map((n, i) => !n ? i : -1).filter(i => i >= 0) ?? null,
                controls: farmCocos.controls().map(c => c.id) };
            }, kind).catch(() => null);
            await page.screenshot({ path: path.join(out, `${kind}-failure-${width}x${height}.png`) }).catch(() => {});
            results.push({ width, height, kind, passed: false, error: String(error), diagnosis, errors: [...new Set(events.errors.slice(errorStart))] });
            console.error(`FAIL ${width}x${height} ${kind}: ${error}`);
            // Close a broken panel so the independent other viewport/branch can still be verified.
            await page.evaluate(() => testApp.close()).catch(() => {});
          }
        }
      } catch (error) {
        failed = true; results.push({ width, height, passed: false, error: String(error), errors: [...new Set(events.errors)] });
        console.error(`FAIL boot ${width}x${height}: ${error}`);
      } finally { await context.close(); }
    }
  } finally {
    fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ passed: !failed, results }, null, 2) + '\n');
    await browser.close(); await server.close();
  }
  if (failed) process.exitCode = 1;
})().catch(error => { console.error(error); process.exitCode = 1; });
