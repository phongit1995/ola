'use strict';
// Explicit UI fixture in fresh browser contexts; production actions themselves use real input.
const assert = require('node:assert/strict');
const fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, site, observe, build } = require('./browser-support.cjs');
const out = process.env.COCOS_BAKERY_OUT ? path.resolve(process.env.COCOS_BAKERY_OUT)
  : path.resolve(__dirname, '../artifacts/bakery-layout/runtime');
const allCases = [[320, 568], [393, 585], [568, 320], [844, 390], [1280, 720]];
const requested = (process.env.COCOS_BAKERY_CASE ?? '').split(',').map(s => s.trim()).filter(Boolean);
assert.ok(requested.every(v => allCases.some(([w, h]) => v === `${w}x${h}`)), 'Unsupported COCOS_BAKERY_CASE');
const cases = requested.length ? allCases.filter(([w, h]) => requested.includes(`${w}x${h}`)) : allCases;

async function inspect(page) {
  return page.evaluate(() => {
    const a = testApp, cc = testCc, canvas = document.querySelector('#GameCanvas').getBoundingClientRect();
    const size = cc.view.getCanvasSize(), viewport = cc.view.getViewportRect();
    const sx = cc.view.getScaleX() / size.width * canvas.width, sy = cc.view.getScaleY() / size.height * canvas.height;
    const rect = n => {
      const t = n.getComponent(cc.UITransform), p = n.worldPosition, s = n.worldScale;
      return { left: viewport.x / size.width * canvas.width + (p.x - t.width * t.anchorX * s.x) * sx,
        top: canvas.height - viewport.y / size.height * canvas.height - (p.y + t.height * (1 - t.anchorY) * s.y) * sy,
        width: t.width * s.x * sx, height: t.height * s.y * sy };
    };
    // TTF actualFontSize is a raster size in Creator3.8, including its clamped texture scale.
    const fontRasterScale = l => Math.max(1, l.fontSize < 100 ? Math.min(l.textStyle.fontScale, 100 / l.fontSize) : l.textStyle.fontScale);
    const fontCSS = l => l.actualFontSize / fontRasterScale(l) * l.node.worldScale.y * sy;
    const nativeKey = sprite => Object.keys(a.art.islandUi.images).find(key => (sprite?.spriteFrame?._uuid === testUiFrames.island[key] || sprite?.spriteFrame === a.art.frame('island-ui/' + key)));
    const card = a.panels.card, scroll = a.panels.scroll;
    const chrome = card.getChildByName('FactoryDialogFrame')?.getComponent('FactoryDialogFrameView');
    const heading = chrome?.title;
    const closeArt = chrome?.closeFace;
    const machine = a.game.state.machines.find(m => m.id === a.panels.machineId);
    const controls = [...a.ui.controls].filter(([, n]) => n.activeInHierarchy && n.isChildOf(card)).map(([id, n]) => {
      let mask = null; for (let p = n.parent; p && p !== card; p = p.parent) if (p.getComponent(cc.Mask)) mask = rect(p);
      return { id, ...rect(n), mask, enabled: n.getComponent(cc.Button)?.interactable !== false,
        text: n.getComponentsInChildren(cc.Label).filter(l => l.node.activeInHierarchy).map(l => l.string).join('\n'),
        queuePrice: n.getComponentsInChildren(cc.Label).find(l => l.node.name === 'QueuePrice')?.string,
        queueCoin: n.getComponentsInChildren(cc.Sprite).some(s => s.node.activeInHierarchy && s.node.name === 'QueueCoin'
          && (s.spriteFrame?._uuid === testUiFrames.town.coin || s.spriteFrame === a.art.frame('town-ui/coin'))),
        skins: n.getComponentsInChildren(cc.Sprite).map(nativeKey).filter(Boolean),
        spriteFrames: n.getComponentsInChildren(cc.Sprite).filter(s => s.node.activeInHierarchy && s.spriteFrame).map(s => s.spriteFrame._uuid) };
    });
    return { view: a.panels.view, cardName: card.name, card: rect(card), canvas: { width: canvas.width, height: canvas.height },
      header: heading && { ...rect(heading.node), text: heading.string, font: heading.font?.name, fontCSS: fontCSS(heading),
        configuredFontCSS: heading.fontSize * heading.node.worldScale.y * sy,
        rasterPixelCSS: heading.node.worldScale.y * sy / fontRasterScale(heading),
        rgba: [heading.color.r, heading.color.g, heading.color.b, heading.color.a], outline: heading.enableOutline,
        closeArt: closeArt && { ...rect(closeArt.node), skin: nativeKey(closeArt) } },
      frame: chrome && { ...rect(chrome.node), skin: nativeKey(chrome.background) },
      controls, hero: card.getComponentsInChildren(cc.UITransform).filter(t => t.node.activeInHierarchy && t.node.name === 'RecipeHero').map(t => rect(t.node))[0],
      progress: card.getComponentsInChildren(cc.UITransform).filter(t => t.node.activeInHierarchy && t.node.name === 'ProductionProgress').map(t => rect(t.node))[0],
      labels: card.getComponentsInChildren(cc.Label).filter(l => l.node.activeInHierarchy)
        .map(l => ({ name: l.node.name, text: l.string, font: l.font?.name, fontCSS: fontCSS(l), ...rect(l.node) })),
      scroll: scroll && { name: scroll.node.name, ...rect(scroll.node), mask: rect(scroll.content.parent),
        contentHeight: scroll.content.getComponent(cc.UITransform).height, offset: scroll.getScrollOffset(), max: scroll.getMaxScrollOffset(),
        count: card.getComponentsInChildren(cc.ScrollView).length, horizontal: scroll.horizontal, vertical: scroll.vertical },
      camera: a.map.cameraState(), selectedRecipe: a.panels.selectedRecipeId, recipesExpanded: a.panels.factoryRecipesExpanded,
      machine: JSON.parse(JSON.stringify(machine)), coins: a.game.state.coins,
      wheat: a.game.quantity('raw:1'), bread: a.game.quantity('goods:7') };
  });
}

const right = r => r.left + r.width, bottom = r => r.top + r.height;
const inside = (inner, outer, margin = 0) => inner.left >= outer.left + margin - .25 && inner.top >= outer.top + margin - .25
  && right(inner) <= right(outer) - margin + .25 && bottom(inner) <= bottom(outer) - margin + .25;
const overlap = (a, b) => Math.min(right(a), right(b)) - Math.max(a.left, b.left) > .5
  && Math.min(bottom(a), bottom(b)) - Math.max(a.top, b.top) > .5;
const fixed = id => /^(?:all-buildings|close-panel|choose-recipe|expand-queue)$/.test(id)
  || /^(?:collect-|produce-|queue-slot-|queue-locked-|cancel-job-)/.test(id);

function geometry(info) {
  assert.equal(info.view, 'factory'); assert.equal(info.cardName, 'GoldenIslandDialog');
  assert.equal(info.frame?.skin, 'buildingWindow');
  assert.ok(inside(info.card, { left: 0, top: 0, ...info.canvas }), 'Factory card fits the screen');
  assert.ok(Math.abs(info.card.left + info.card.width / 2 - info.canvas.width / 2) < 1
    && Math.abs(info.card.top + info.card.height / 2 - info.canvas.height / 2) < 1, 'Factory remains centered');
  assert.equal(info.scroll.count, 1); assert.equal(info.scroll.name, 'RecipeScroll');
  assert.equal(info.scroll.horizontal, false); assert.equal(info.scroll.vertical, true);
  const targets = info.controls.filter(c => fixed(c.id));
  for (const id of ['close-panel', 'all-buildings', 'choose-recipe', 'collect-' + info.machine.id, 'produce-' + info.selectedRecipe])
    assert.ok(targets.some(c => c.id === id), 'Preserved action ' + id);
  assert.equal(targets.filter(t => /^(?:queue-slot-|queue-locked-|cancel-job-|expand-queue$)/.test(t.id)).length, 5, 'All five queue positions remain available');
  for (const t of targets) {
    assert.ok(t.width >= 43.9 && t.height >= 43.9, `${t.id}: minimum44CSS target (${t.width}×${t.height})`);
    if (t.id === 'close-panel' || t.id === 'all-buildings')
      assert.ok(inside(t, { left: 0, top: 0, ...info.canvas }, 4), t.id + ': native header target keeps4CSS canvas margin');
    else assert.ok(inside(t, info.card, 12), t.id + ': body target is inset at least12CSS inside the card');
    assert.equal(t.mask, null, t.id + ': fixed actions stay outside scrolling content');
  }
  for (let i = 0; i < targets.length; i++) for (let j = i + 1; j < targets.length; j++)
    assert.ok(!overlap(targets[i], targets[j]), targets[i].id + ' overlaps ' + targets[j].id);
  const h = info.header, close = targets.find(t => t.id === 'close-panel'), back = targets.find(t => t.id === 'all-buildings');
  const near = (actual, expected, message, tolerance = .05) => assert.ok(Math.abs(actual - expected) <= tolerance, `${message}: ${actual} vs ${expected}`);
  assert.ok(h?.closeArt, 'Prefab header title and original close sprite exist');
  near(h.left + h.width / 2, info.card.left + info.card.width / 2, 'Title centered on the card');
  near(h.top + h.height / 2 - info.card.top, 17.2347, 'Original title center offset');
  near(h.height, 26.775, 'Original title box height');
  near(h.configuredFontCSS, 20.16, 'Original title font');
  near(h.fontCSS, 20.16, 'Rendered title font allows one raster pixel of Cocos SHRINK quantization', h.rasterPixelCSS + .01);
  assert.deepEqual(h.rgba, [188, 66, 47, 255]); assert.equal(h.outline, false); assert.match(h.font, /Poetsen/i);
  assert.equal(h.closeArt.skin, 'close'); near(h.closeArt.width, 38.64, 'Original X artwork width'); near(h.closeArt.height, 36.96, 'Original X artwork height');
  assert.ok(inside(close, info.card), 'Close target stays inside the dialog border');
  assert.ok(inside(h.closeArt, close), 'Close artwork stays inside its touch target');
  near(right(info.card) - right(close), 0, 'Close Widget keeps its right inset');
  near(close.top - info.card.top, 18, 'Close Widget keeps its top inset');
  near(back.left + back.width / 2 - info.card.left, 64, 'Machine navigation stays inside the native orange cap');
  near(back.top + back.height / 2 - info.card.top, 17.2347, 'Machine navigation aligns with the original title');
  assert.ok(!overlap(back, h) && h.left - right(back) >= 3.9, 'Machine navigation leaves at least4CSS before the title box');
  assert.ok(!targets.some(t => /Ô trống/.test(t.text)), 'Empty queue positions do not repeat placeholder sentences');
  assert.ok(info.labels.every(l => /Poetsen/i.test(l.font)), 'Factory labels use the scoped Golden Island font');
  if (info.machine.job) {
    const queueCount = info.labels.find(l => l.name === 'QueueCount');
    assert.ok(info.progress && queueCount, 'Running production shows its progress bar and queue count');
    assert.ok(!overlap(info.progress, queueCount), 'Production progress does not cover the queue count');
    assert.ok(queueCount.top - bottom(info.progress) >= 1, 'Progress bar and queue count retain at least1CSS vertical gap');
  }
  const title = info.labels.find(l => l.name === 'RecipeTitle'), pin = info.controls.find(c => c.id === 'pin-recipe' || c.id === 'factory-production-return');
  if (title && pin) assert.ok(!overlap(title, pin), 'Recipe title leaves room for its pin/return action');
  if (info.hero && title) assert.ok(!overlap(info.hero, title), 'Product artwork leaves the recipe title clear');
  for (const t of targets.filter(t => t.id === 'expand-queue' || t.id.startsWith('queue-locked-'))) {
    assert.match(t.queuePrice, /^\d+$/, 'Queue unlock shows a numeric price');
    assert.equal(t.queueCoin, true, 'Queue unlock keeps the existing currency icon beside its price');
  }
  return targets;
}

function revealedTarget(info, id) {
  const t = info.controls.find(t => t.id === id); assert.ok(t, id);
  assert.ok(t.width >= 43.9 && t.height >= 43.9, id + ': scrolling target remains44CSS');
  assert.ok(inside(t, info.card, 12), id + ': scrolling target stays inside the card');
  if (t.mask) assert.ok(inside(t, t.mask), id + ': entire target is visible through the mask');
  for (const action of info.controls.filter(c => fixed(c.id))) assert.ok(!overlap(t, action), id + ' overlaps fixed ' + action.id);
  return t;
}

async function reveal(page, id) {
  for (let attempt = 0; attempt < 60; attempt++) {
    const info = await inspect(page), t = info.controls.find(c => c.id === id); assert.ok(t, id);
    if (!t.mask || inside(t, t.mask)) return info;
    const below = Math.max(0, bottom(t) - bottom(t.mask)), above = Math.max(0, t.mask.top - t.top);
    const canvas = await page.locator('#GameCanvas').boundingBox();
    await page.mouse.move(canvas.x + t.mask.left + t.mask.width / 2, canvas.y + t.mask.top + t.mask.height / 2);
    await page.mouse.wheel(0, (below > 0 ? 1 : -1) * Math.max(4, Math.min(90, 2 * Math.max(below, above))));
    await page.waitForTimeout(90);
  }
  throw Error('Cannot fully reveal ' + id);
}

async function shield(page) {
  const before = await inspect(page), canvas = await page.locator('#GameCanvas').boundingBox();
  await page.mouse.move(canvas.x + 3, canvas.y + canvas.height / 2); await page.mouse.wheel(0, 120);
  await page.mouse.down(); await page.mouse.move(canvas.x + 7, canvas.y + canvas.height / 2 + 35, { steps: 4 }); await page.mouse.up();
  await page.waitForTimeout(120);
  assert.deepEqual((await inspect(page)).camera, before.camera, 'Modal blocks map wheel and drag');
  const s = before.scroll;
  await page.mouse.move(canvas.x + s.left + s.width / 2, canvas.y + s.top + s.height / 2);
  await page.mouse.wheel(0, 160); await page.waitForTimeout(250);
  if (s.max.y <= 1) await page.waitForFunction(y => Math.abs(testApp.panels.scroll.getScrollOffset().y - y) < 1, s.offset.y);
  const after = await inspect(page); assert.deepEqual(after.camera, before.camera, 'Recipe scrolling leaves map unchanged');
  if (s.max.y > 1) assert.ok(after.scroll.offset.y > s.offset.y + .5, 'Overflowing recipe content responds to wheel input');
  else assert.ok(Math.abs(after.scroll.offset.y - s.offset.y) < 1, 'Fitting content settles without an offset');
  return { mapBlocked: true, maxScroll: s.max.y, contentMoved: s.max.y > 1 };
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const results = [], cleanup = { serverClosed: false, browserClosed: false };
  const report = { buildPath: build, startedAt: new Date().toISOString(), caseFilter: requested,
    fixture: 'Fresh isolated storage;20,000coins, bakery expanded to4 via domain API,84wheat. Production/queue/collection and recipe selection use real input. Only completion time is advanced explicitly.',
    passed: false, status: 'running', results, cleanup };
  const save = () => fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(report, null, 2) + '\n');
  save(); const server = await serve(); let browser;
  try {
    browser = await launch();
    for (const [width, height] of cases) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true, isMobile: width < 1000 });
      const page = await context.newPage(), observed = observe(page);
      const result = { width, height, states: [], passed: false }; results.push(result); save();
      const capture = async name => {
        await page.waitForTimeout(140);
        const info = await inspect(page); result.states.push({ name, ...info }); save(); geometry(info);
        await page.screenshot({ path: path.join(out, `${name}-${width}x${height}.png`) }); return info;
      };
      try {
        await boot(page, server.url);
        await page.evaluate(() => {
          const a = testApp, g = a.game; g.dismissGuide(); a.close(); g.state.coins = 20000;
          const m = g.state.machines.find(m => m.type === 1);
          while (m.capacity < 4) { const r = g.expandQueue(m.id); if (r.error) throw Error(r.error); }
          g.state.inventory['raw:1'] = 84; g.validate(); a.save(); a.refresh();
          a.panels.selectedRecipeId = 7; a.panels.factoryRecipesExpanded = false;
        });
        await site(page, 'bakery-1', true);
        const idle = await capture('idle'); assert.equal(idle.machine.capacity, 4); assert.equal(idle.wheat, 84);
        assert.equal(idle.machine.job, null); assert.equal(idle.machine.waiting.length, 0); assert.equal(idle.machine.tray.length, 0);
        const idleCollect = idle.controls.find(c => c.id === 'collect-' + idle.machine.id);
        assert.equal(idleCollect.enabled, false); assert.ok(idleCollect.skins.includes('info') && !idleCollect.skins.includes('green'), 'Idle collection uses a quiet inactive face');
        assert.equal(idle.controls.find(c => c.id === 'expand-queue').queuePrice, '320');
        const ingredient = revealedTarget(await reveal(page, 'recipe-ingredient-0'), 'recipe-ingredient-0');
        assert.ok(ingredient.width >= idle.scroll.width * .88, 'A single ingredient uses one full row instead of half the recipe area');

        await tap(page, 'produce-7', true); await tap(page, 'produce-7', true);
        const running = await capture('running-and-waiting');
        assert.equal(running.machine.job.product, 7); assert.equal(running.machine.waiting.length, 1);
        assert.equal(running.machine.waiting[0].product, 7); assert.equal(running.wheat, 80);
        await tap(page, 'cancel-job-' + running.machine.waiting[0].id, true);
        assert.equal((await inspect(page)).wheat, 82, 'Cancelling a waiting bread refunds exactly2wheat');
        await page.evaluate(() => { const a = testApp; a.game.tick(46); a.game.validate(); a.save(); a.refresh(); });
        await page.waitForFunction(id => farmCocos.controls().some(c => c.id === id && c.enabled === true), 'collect-' + idle.machine.id);
        const ready = await capture('ready-to-collect');
        assert.equal(ready.machine.tray.length, 1);
        const readyCollect = ready.controls.find(c => c.id === 'collect-' + idle.machine.id);
        assert.equal(readyCollect.enabled, true); assert.ok(readyCollect.skins.includes('green'), 'Completed goods activate the green collection button');
        await tap(page, 'collect-' + idle.machine.id, true);
        await page.waitForFunction(id => farmCocos.controls().some(c => c.id === id && c.enabled === false), 'collect-' + idle.machine.id);
        const collected = await capture('collected'); assert.equal(collected.bread, idle.bread + 1); assert.equal(collected.machine.tray.length, 0);
        const disabledCollect = collected.controls.find(c => c.id === 'collect-' + idle.machine.id);
        assert.equal(disabledCollect.enabled, false);
        const canvas = await page.locator('#GameCanvas').boundingBox();
        await page.touchscreen.tap(canvas.x + disabledCollect.left + disabledCollect.width / 2, canvas.y + disabledCollect.top + disabledCollect.height / 2);
        assert.equal((await inspect(page)).bread, collected.bread, 'A second disabled collect cannot duplicate goods');

        await tap(page, 'choose-recipe', true); const picker = await capture('recipe-picker');
        assert.equal(picker.recipesExpanded, true); assert.equal(picker.controls.filter(c => c.id.startsWith('select-recipe-')).length, 5);
        result.shield = await shield(page);
        await tap(page, 'select-recipe-100207', true);
        const waffle = await capture('four-ingredients-top'); assert.equal(waffle.selectedRecipe, 100207);
        assert.equal(waffle.controls.filter(c => c.id.startsWith('recipe-ingredient-')).length, 4);
        result.ingredientTargets = [];
        for (let i = 0; i < 4; i++) {
          const info = await reveal(page, 'recipe-ingredient-' + i);
          result.ingredientTargets.push(revealedTarget(info, 'recipe-ingredient-' + i));
        }
        await capture('four-ingredients-bottom');
        const beforeExpansion = await inspect(page); await tap(page, 'expand-queue', true);
        const expanded = await capture('five-queue-slots');
        assert.equal(expanded.machine.capacity, 5); assert.equal(expanded.coins, beforeExpansion.coins - 320, 'Final queue slot retains its320coin price');
        assert.ok(!expanded.controls.some(c => c.id === 'expand-queue'));
        result.transactions = { twoBreadQueued: true, waitingRefund: 2, collectedExactlyOnce: true, finalQueuePrice: 320 };
        assert.deepEqual(observed.errors, []); result.errors = []; result.passed = true;
        console.log(`${width}×${height}: bakery states,44CSS targets,12CSS frame insets,queue/refund/collect,picker/four ingredients PASS`);
      } catch (error) {
        result.error = String(error); result.stack = error.stack; result.errors = observed.errors;
        result.diagnostic = await inspect(page).catch(e => ({ error: String(e) }));
        await page.screenshot({ path: path.join(out, `failure-${width}x${height}.png`) });
        console.error(`${width}×${height}: ${error}`);
      } finally { save(); await context.close(); }
    }
    assert.ok(results.every(r => r.passed), 'Every selected bakery viewport must pass; see results.json');
    report.passed = true; report.status = 'complete';
  } catch (error) { report.error = String(error); report.stack = error.stack; report.status = 'failed'; throw error; }
  finally {
    await server.close(); cleanup.serverClosed = true; save();
    if (browser) await browser.close(); cleanup.browserClosed = true; report.finishedAt = new Date().toISOString(); save();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
