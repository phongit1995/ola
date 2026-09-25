'use strict';
// UI fixture only: economy/progression is verified by core and the separate real-input chain test.
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { serve, launch, boot, tap, plot, observe, build } = require('./browser-support.cjs');
const out = process.env.PRODUCTION_UI_ARTIFACT_DIR ? path.resolve(process.env.PRODUCTION_UI_ARTIFACT_DIR) : path.resolve(__dirname, '../artifacts/farm-town-runtime/production-ui');
const cases = [[320, 568, 1], [320, 568, 2], [568, 320, 1], [360, 640, 1], [390, 844, 1], [844, 390, 1]];
const selectedCases = process.env.COCOS_PRODUCTION_UI_CASE ? cases.filter(([w, h, dpr]) => `${w}x${h}-dpr${dpr}` === process.env.COCOS_PRODUCTION_UI_CASE) : cases;
assert.ok(selectedCases.length, 'Unknown COCOS_PRODUCTION_UI_CASE');

async function reveal(page, id) {
  // Scroll over the selected control's actual viewport, which can occupy only part of the modal.
  for (let attempt = 0; attempt < 40; attempt++) {
    const info = await page.evaluate(id => {
      const a = testApp, cc = testCc, target = a.ui.controls.get(id);
      if (!target?.activeInHierarchy) throw Error('Missing control ' + id + ' in ' + a.panels.view);
      const rect = node => { const t = node.getComponent(cc.UITransform), p = node.worldPosition, s = node.worldScale; return { x: p.x, y: p.y, w: t.width * s.x, h: t.height * s.y }; };
      let mask = null; for (let node = target.parent; node; node = node.parent) if (node.getComponent(cc.Mask)) mask = rect(node);
      const b = rect(target);
      if (!mask) return { clipped: false };
      const below = Math.max(0, mask.y - mask.h / 2 - b.y + b.h / 2), above = Math.max(0, b.y + b.h / 2 - mask.y - mask.h / 2);
      const left = Math.max(0, mask.x - mask.w / 2 - b.x + b.w / 2), right = Math.max(0, b.x + b.w / 2 - mask.x - mask.w / 2);
      const horizontal = left > 1 || right > 1, clipped = below > 1 || above > 1 || horizontal;
      const viewport = cc.view.getViewportRect(), canvas = cc.view.getCanvasSize();
      return { clipped, direction: horizontal ? right > 0 ? -1 : 1 : below > 0 ? 1 : -1, delta: Math.max(4, Math.min(120, Math.max(below, above, left, right) * 2 + 4)), x: (viewport.x + mask.x * cc.view.getScaleX()) / canvas.width, y: 1 - (viewport.y + mask.y * cc.view.getScaleY()) / canvas.height };
    }, id);
    if (!info.clipped) return;
    const canvas = await page.locator('#GameCanvas').boundingBox();
    await page.mouse.move(canvas.x + info.x * canvas.width, canvas.y + info.y * canvas.height);
    await page.mouse.wheel(0, info.direction * info.delta); await page.waitForTimeout(90);
  }
  throw Error('Could not reveal ' + id);
}
async function click(page, id) { await reveal(page, id); await tap(page, id, true); }
async function openHerd(page, id) {
  if (await page.evaluate(() => !!testApp.panels.view)) await click(page, 'close-panel');
  await page.evaluate(id => { testApp.map.focusBuilding('pen:' + id); testApp.map.update(); }, id);
  await page.waitForTimeout(80); await plot(page, id, true);
  await page.waitForFunction(id => farmCocos.ui().selected === id, id); await click(page, 'herd-manage');
  assert.deepEqual(await page.evaluate(() => ({ view: farmCocos.ui().view, pen: testApp.panels.penId,
    tabs: farmCocos.controls().filter(c => c.id.startsWith('choose-pen-')).map(c => c.id) })), { view: 'livestock', pen: id, tabs: [] });
}
async function select(page, recipe) { await click(page, 'choose-recipe'); await click(page, 'select-recipe-' + recipe); }
async function source(page, text) {
  const id = await page.evaluate(text => [...testApp.ui.controls].find(([id, n]) => id.startsWith('ingredient-source-') && n.getComponentsInChildren(testCc.Label).some(label => label.string.includes(text)))?.[0], text);
  assert.ok(id, 'ingredient source ' + text); await click(page, id);
}
async function visibleTargets(page, ids) {
  const measured = await page.evaluate(ids => {
    const cc = testCc, canvas = cc.view.getCanvasSize(), scale = { x: cc.view.getScaleX(), y: cc.view.getScaleY() };
    const box = document.querySelector('#GameCanvas').getBoundingClientRect(), viewport = cc.view.getViewportRect();
    return ids.map(id => {
      const t = farmCocos.controls().find(t => t.id === id); if (!t) throw Error('Missing ' + id);
      const masks = [];
      for (let n = testApp.ui.controls.get(id).parent; n; n = n.parent) if (n.getComponent(cc.Mask)) {
        const ui = n.getComponent(cc.UITransform), p = n.worldPosition, s = n.worldScale;
        masks.push({ left: (viewport.x + (p.x - ui.width * ui.anchorX * s.x) * scale.x) / canvas.width * box.width,
          right: (viewport.x + (p.x + ui.width * (1 - ui.anchorX) * s.x) * scale.x) / canvas.width * box.width,
          top: box.height - (viewport.y + (p.y + ui.height * (1 - ui.anchorY) * s.y) * scale.y) / canvas.height * box.height,
          bottom: box.height - (viewport.y + (p.y - ui.height * ui.anchorY * s.y) * scale.y) / canvas.height * box.height });
      }
      return { id, x: t.x * box.width, y: t.y * box.height, width: t.w * scale.x / canvas.width * box.width, height: t.h * scale.y / canvas.height * box.height, canvas: { width: box.width, height: box.height }, masks };
    });
  }, ids);
  for (const t of measured) {
    assert.ok(t.width >= 43.9 && t.height >= 43.9, `${t.id}: target ${t.width}x${t.height} CSS px`);
    assert.ok(t.x - t.width / 2 >= -1 && t.y - t.height / 2 >= -1 && t.x + t.width / 2 <= t.canvas.width + 1 && t.y + t.height / 2 <= t.canvas.height + 1, t.id + ': fully inside screen');
    for (const mask of t.masks) assert.ok(t.x - t.width / 2 >= mask.left - 1 && t.x + t.width / 2 <= mask.right + 1
      && t.y - t.height / 2 >= mask.top - 1 && t.y + t.height / 2 <= mask.bottom + 1, t.id + ': fully inside its scroll mask');
  }
  for (let i = 0; i < measured.length; i++) for (let j = i + 1; j < measured.length; j++) {
    const a = measured[i], b = measured[j];
    const overlapX = (a.width + b.width) / 2 - Math.abs(a.x - b.x);
    const overlapY = (a.height + b.height) / 2 - Math.abs(a.y - b.y);
    assert.ok(overlapX <= 1 || overlapY <= 1, `${a.id} overlaps ${b.id}`);
  }
  return measured;
}
(async () => {
  fs.mkdirSync(out, { recursive: true }); const server = await serve(), browser = await launch(), results = [];
  fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ passed: false, status: 'running', buildPath: build }, null, 2) + '\n');
  try {
    for (const [width, height, deviceScaleFactor] of selectedCases) {
      const context = await browser.newContext({ viewport: { width, height }, deviceScaleFactor, hasTouch: true, isMobile: true });
      const page = await context.newPage(), observed = observe(page);
      try {
        await boot(page, server.url);
        await page.evaluate(() => {
          const a = testApp, g = a.game, ok = result => { if (result.error) throw Error(result.error); };
          g.dismissGuide(); a.close(); g.state.coins = 20000;
          g.state.husbandry = { version: 1, feedReceived: true, eggsCollected: true, milkCollected: true, burgerCollected: true };
          for (const item of g.items) g.state.inventory[item.key] = 100;
          for (const type of g.machineTypes) if (!g.state.machines.some(machine => machine.type === type.id)) ok(g.buyMachine(type.id));
          for (const id of [14, 15]) ok(g.buyPen(id));
          const pen = g.residentPlot(12);
          g.state.xp = 210;
          while (pen.residents.capacity < 3) ok(g.expandPen(12));
          if (pen.residents.animals.length !== 3) throw Error('Each slot unlock must include its resident');
          g.validate(); a.refresh();
          a.panels.machineId = g.state.machines.find(machine => machine.type === 1).id;
          a.panels.selectedRecipeId = 7; a.open('factory');
        });
        const fixedIds = ['all-buildings', 'close-panel', 'collect-' + await page.evaluate(() => testApp.panels.machineId), 'queue-slot-0', 'expand-queue', 'queue-locked-2', 'queue-locked-3', 'queue-locked-4', 'choose-recipe', 'produce-7'];
        const fixed = await visibleTargets(page, fixedIds);
        const dialog = await page.evaluate(() => ({ width: testApp.panels.width, height: testApp.panels.height, appWidth: testApp.width, appHeight: testApp.height,
          name: testApp.panels.card.name, x: testApp.panels.card.position.x, y: testApp.panels.card.position.y }));
        assert.equal(dialog.name, 'GoldenIslandDialog');
        assert.ok(Math.abs(dialog.x) < .01 && Math.abs(dialog.y) < .01, 'building modal is centered');
        assert.ok(dialog.width < dialog.appWidth && dialog.height < dialog.appHeight, 'building modal leaves space around the frame');
        if (width === 390) {
          // Design size remains 720×1440 here; CSS-sized targets still have to update.
          await page.setViewportSize({ width: 390, height: 780 }); await page.waitForTimeout(350);
          await page.setViewportSize({ width: 320, height: 640 }); await page.waitForTimeout(350);
          await visibleTargets(page, fixedIds);
          await page.setViewportSize({ width, height }); await page.waitForTimeout(350);
        }
        await select(page, 100207); assert.equal(await page.evaluate(() => testApp.panels.selectedRecipeId), 100207);
        await click(page, 'pin-recipe'); assert.equal(await page.evaluate(() => testApp.panels.pinnedRecipeId), 100207);
        const origin = await page.evaluate(() => testApp.panels.machineId);
        await click(page, 'recipe-ingredient-0'); assert.equal(await page.evaluate(() => farmCocos.ui().view), 'ingredients');
        await source(page, 'Đến ruộng'); assert.equal(await page.evaluate(() => farmCocos.ui().view), '');
        assert.equal(await page.evaluate(() => testApp.panels.recipeReturnMachineId), origin);
        // Return control is supplied by the map shell; its real button must restore exact target.
        const returnId = await page.evaluate(() => [...testApp.ui.controls].find(([id, n]) => n.activeInHierarchy && n.getComponentsInChildren(testCc.Label).some(label => label.string.includes('Về') && /Waffle|waffle|Bánh Quế|bánh quế/.test(label.string)))?.[0]);
        assert.ok(returnId, 'map exposes production return');
        if (width === 390) { await page.setViewportSize({ width: 320, height: 568 }); await page.waitForTimeout(350); }
        await visibleTargets(page, [returnId]); await click(page, returnId);
        assert.equal(await page.evaluate(() => testApp.panels.machineId), origin); assert.equal(await page.evaluate(() => testApp.panels.selectedRecipeId), 100207);
        if (width === 390) { await page.setViewportSize({ width, height }); await page.waitForTimeout(350); }
        await click(page, 'recipe-ingredient-0'); await source(page, 'Đường');
        assert.equal(await page.evaluate(() => farmCocos.ui().view), 'factory'); assert.equal(await page.evaluate(() => testApp.panels.selectedRecipeId), 107101);
        await visibleTargets(page, ['choose-recipe', 'produce-107101']);
        await click(page, 'factory-production-return');
        assert.equal(await page.evaluate(() => testApp.panels.machineId), origin); assert.equal(await page.evaluate(() => testApp.panels.selectedRecipeId), 100207);
        await page.screenshot({ path: path.join(out, `factory-${width}x${height}-dpr${deviceScaleFactor}.png`) });
        await openHerd(page, 12);
        const animalIds = await page.evaluate(() => testApp.game.residentPlot(12).residents.animals.map(animal => animal.id));
        const herdFixed = ['manage-herd', 'feed-all', 'collect-all-animals', 'close-panel'];
        await visibleTargets(page, herdFixed);
        assert.ok(!await page.evaluate(() => farmCocos.controls().some(t => t.id.startsWith('sell-animal-'))), 'care mode contains no sell buttons');
        for (const id of ['unlock-pen-slot-3', 'unlock-pen-slot-4']) { await reveal(page, id); await visibleTargets(page, [...herdFixed, id]); }
        await click(page, 'manage-herd'); await visibleTargets(page, ['care-herd']);
        await reveal(page, 'sell-animal-' + animalIds[0]); await visibleTargets(page, ['care-herd', 'sell-animal-' + animalIds[0]]);
        const portrait = await page.evaluate(() => {
          const cc = testCc, canvas = cc.view.getCanvasSize(), viewport = cc.view.getViewportRect();
          const screen = document.querySelector('#GameCanvas').getBoundingClientRect();
          const sx = cc.view.getScaleX() / canvas.width * screen.width, sy = cc.view.getScaleY() / canvas.height * screen.height;
          const parent = testApp.panels.card.getComponentsInChildren(cc.UITransform).find(transform => transform.node.activeInHierarchy && transform.node.name === 'AnimalPortrait').node;
          // Measure the node's own corners: a bounds method that includes children could hide overflowing art.
          const ownBox = node => {
            const t = node.getComponent(cc.UITransform), points = [];
            for (const x of [-t.anchorX * t.width, (1 - t.anchorX) * t.width])
              for (const y of [-t.anchorY * t.height, (1 - t.anchorY) * t.height]) points.push(t.convertToWorldSpaceAR(new cc.Vec3(x, y, 0)));
            return { xMin: Math.min(...points.map(p => p.x)), xMax: Math.max(...points.map(p => p.x)), yMin: Math.min(...points.map(p => p.y)), yMax: Math.max(...points.map(p => p.y)) };
          };
          const union = boxes => {
            if (!boxes.length) throw Error('Animal portrait has no visible sprite parts');
            return { xMin: Math.min(...boxes.map(b => b.xMin)), xMax: Math.max(...boxes.map(b => b.xMax)), yMin: Math.min(...boxes.map(b => b.yMin)), yMax: Math.max(...boxes.map(b => b.yMax)) };
          };
          const css = b => ({ left: screen.x + viewport.x / canvas.width * screen.width + b.xMin * sx,
            right: screen.x + viewport.x / canvas.width * screen.width + b.xMax * sx,
            top: screen.y + screen.height - viewport.y / canvas.height * screen.height - b.yMax * sy,
            bottom: screen.y + screen.height - viewport.y / canvas.height * screen.height - b.yMin * sy,
            width: (b.xMax - b.xMin) * sx, height: (b.yMax - b.yMin) * sy });
          const sprites = parent.getComponentsInChildren(cc.Sprite).filter(sprite => sprite.node.activeInHierarchy && sprite.spriteFrame);
          const species = testApp.game.residentPlot(testApp.panels.penId).residents.species;
          const type = testApp.game.catalog.livestock.find(animal => animal.key === species);
          const source = testApp.art.prefabs.get(type.prefab).data;
          // Prefab assets are outside the scene, so inspect authored active flags instead of activeInHierarchy.
          const authoredActive = node => { for (let n = node; n; n = n.parent) { if (!n.active) return false; if (n === source) return true; } return false; };
          const sourceBox = union(source.getComponentsInChildren(cc.Sprite).filter(sprite => sprite.spriteFrame && authoredActive(sprite.node)).map(sprite => ownBox(sprite.node)));
          return { ...css(union(sprites.map(sprite => ownBox(sprite.node)))), container: css(ownBox(parent)),
            sourceAspect: (sourceBox.xMax - sourceBox.xMin) / (sourceBox.yMax - sourceBox.yMin), sprites: sprites.length };
        });
        assert.ok(portrait.width >= 18 && portrait.height >= 32,
          'animal art remains readable in CSS pixels: ' + JSON.stringify(portrait));
        assert.ok(portrait.left >= portrait.container.left - .75 && portrait.right <= portrait.container.right + .75
          && portrait.top >= portrait.container.top - .75 && portrait.bottom <= portrait.container.bottom + .75,
        'rendered animal parts stay inside the portrait container: ' + JSON.stringify(portrait));
        assert.ok(Math.abs((portrait.width / portrait.height) / portrait.sourceAspect - 1) < .02,
          'portrait preserves the authored animal aspect without stretching: ' + JSON.stringify(portrait));
        assert.ok(!await page.evaluate(() => farmCocos.controls().some(t => /^animal-\d+$/.test(t.id))), 'management has no collect/feed buttons beside sell');
        await reveal(page, 'sell-animal-' + animalIds[0]); await visibleTargets(page, ['sell-animal-' + animalIds[0]]);
        await page.screenshot({ path: path.join(out, `herd-${width}x${height}-dpr${deviceScaleFactor}.png`) });
        for (const [id, title] of [[13, 'Chuồng bò'], [14, 'Chuồng heo'], [15, 'Chuồng cừu']]) {
          await openHerd(page, id); assert.ok(await page.evaluate(title => farmCocos.labels().some(label => label.text === title), title));
        }
        await page.evaluate(() => { testApp.panels.machineTypeId = 1021; testApp.open('industry'); });
        await reveal(page, 'purchase-industry'); await visibleTargets(page, ['purchase-industry']);
        assert.deepEqual(observed.errors, []);
        results.push({ width, height, deviceScaleFactor, fixed, dialog, recipeSelection: true, pinMapReturn: true, ingredientMachineReturn: true, separateHerdManagement: true, allFourSpecies: true });
        console.log(`${width}x${height} DPR ${deviceScaleFactor}: centered modal, 44 px controls, selected recipe/source/pin return and herd management passed`);
      } catch (error) {
        await page.screenshot({ path: path.join(out, `failure-${width}x${height}-dpr${deviceScaleFactor}.png`) });
        fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ passed: false, buildPath: build, results, error: String(error) }, null, 2) + '\n');
        throw error;
      }
      finally { await context.close(); }
    }
    fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ passed: true, buildPath: build, testedAt: new Date().toISOString(), results }, null, 2) + '\n');
  } finally { await browser.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
