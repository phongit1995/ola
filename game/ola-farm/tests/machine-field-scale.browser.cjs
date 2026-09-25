'use strict';
// Presentation fixture: real body/badge/purchase/production input; resources are seeded
// only after checking the fresh 3-built/5-absent map. This is not an economy playthrough.
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, plot, observe, build } = require('./browser-support.cjs');
const out = process.env.COCOS_MACHINE_UI_OUT ? path.resolve(process.env.COCOS_MACHINE_UI_OUT) : path.resolve(__dirname, '../artifacts/machine-size-review/ui-runtime');

async function inspect(page) {
  return page.evaluate(() => {
    const a = testApp, cc = testCc, map = a.map, element = document.querySelector('#GameCanvas').getBoundingClientRect();
    const vp = cc.view.getViewportRect(), canvas = cc.view.getCanvasSize(), display = map.camera.displayScale;
    const x = v => (vp.x + v * cc.view.getScaleX()) / canvas.width * element.width;
    const y = v => element.height - (vp.y + v * cc.view.getScaleY()) / canvas.height * element.height;
    const box = n => n.getComponent(cc.UITransform).getBoundingBoxToWorld();
    const sprites = n => n.getComponentsInChildren(cc.Sprite).filter(s => s.node.activeInHierarchy && s.spriteFrame).map(s => box(s.node));
    const union = b => ({ left: Math.min(...b.map(b => b.xMin)), right: Math.max(...b.map(b => b.xMax)), bottom: Math.min(...b.map(b => b.yMin)), top: Math.max(...b.map(b => b.yMax)) });
    const css = b => ({ left: x(b.left), right: x(b.right), top: y(b.top), bottom: y(b.bottom) });
    const frameList = root => root.getComponentsInChildren(cc.Sprite).filter(s => s.spriteFrame).map(s => {
      const names = []; for (let n = s.node; n && n !== root; n = n.parent) names.unshift(n.name);
      return names.join('/') + ':' + s.spriteFrame.uuid;
    }).sort();
    const pose = model => (model.getChildByName('Model')?.children || []).map(n => ({ name: n.name, x: n.position.x, y: n.position.y, angle: n.angle }));
    const machines = a.game.machineTypes.map(type => {
      const key = type.buildingIds?.[0] || type.buildingId, v = map.town.buildings.get(key), m = a.game.state.machines.find(m => m.buildingId === key);
      if (!v) return {type:type.id,key,prefab:type.prefab,owned:!!m,present:false,artBounds:map.town.machineArtBounds(type.prefab,map.movement.position(key)),sourceFrames:frameList(a.art.prefabs.get(type.prefab).data)};
      const boxes = sprites(v.node), bounds = union(boxes), p = map.movement.position(key), badge = box(v.badge);
      const full = union([...boxes, badge]);
      return { type: type.id, key, prefab: type.prefab, owned: !!m, present:true, node: v.node.uuid, model: v.model.uuid, scale: v.node.scale.x, opacity: v.opacity.opacity, active: v.node.activeInHierarchy, bounds: css(bounds), full: css(full), worldWidth: (bounds.right - bounds.left) / display, worldHeight: (bounds.top - bounds.bottom) / display, artBounds: map.town.machineArtBounds(type.prefab, p), badgeText: v.label.string, badge: css(union([badge])), frames: frameList(v.model), sourceFrames: frameList(a.art.prefabs.get(type.prefab).data), pose: pose(v.model), motionParts: v.motion.parts.length, legacyPaper: v.node.getComponentsInChildren(cc.UITransform).some(t => t.node.name === 'BuildingSite') };
    });
    const crop = map.model.plotPositions().find(p => p.plot.group === 'crop');
    const cropBounds = map.model.widgetBounds([{ ...crop.cell.widget, matrix: crop.cell.matrix }]);
    const sheep = map.town.yards.get(15), sheepBounds = sheep ? union([...sprites(sheep.node), ...sprites(sheep.front)]) : null;
    const homeObjects = [
      ...[...map.itemRenderer.crops].map(([id, v]) => ({ id: 'crop:' + id, ...css(union(sprites(v.root))) })),
      ...[...map.town.yards].map(([id, v]) => ({ id: 'pen:' + id, ...css(union([...sprites(v.node), ...sprites(v.front), box(v.badge)])) })),
      ...machines.filter(m=>m.present).map(m => ({ id: m.key, ...m.full })),
    ];
    return { machines, cropWidth: cropBounds.right - cropBounds.left, sheepWidth: sheepBounds ? (sheepBounds.right - sheepBounds.left) / display : null, camera: map.cameraState(), cameraDetails: { homeFit: map.homeFit(), modelBounds: map.model.bounds, modelCenter: map.model.center, reach: map.camera.reach, scale: map.camera.scale, minZoom: map.camera.minZoom, width: map.width, height: map.height, inset: map.inset, pan: { x: map.camera.pan.x, y: map.camera.pan.y } }, selectedMachine: map.selectedMachine, homeObjects, free: { left: 0, right: element.width, top: 104 / a.height * element.height, bottom: element.height - 196 / a.height * element.height }, padding: 24 / a.width * element.width, canvas: { width: element.width, height: element.height } };
  });
}

function fits(b, free, padding = 0) {
  return Number.isFinite(b.left) && b.left >= free.left + padding - 1 && b.right <= free.right - padding + 1 && b.top >= free.top + padding - 1 && b.bottom <= free.bottom - padding + 1;
}
function sameCamera(a, b, reason) {
  assert.equal(a.mode, b.mode, reason);
  for (const key of ['x', 'y', 'displayScale']) assert.ok(Math.abs(a[key] - b[key]) < .0001, reason + ': ' + key);
}
async function home(page) { await page.evaluate(() => { testApp.close(); testApp.focusHome(); }); await page.waitForTimeout(100); }
async function revealBuilding(page, key) {
  const moved = await page.evaluate(key => {
    const m = testApp.map, c = m.camera, type = testApp.game.machineTypes.find(t => t.buildingIds.includes(key));
    const b = m.town.machineArtBounds(type.prefab, m.movement.position(key)), state = c.state(), s = c.displayScale;
    const fits = (b.left - state.x) * s >= -m.width / 2 + 24 && (b.right - state.x) * s <= m.width / 2 - 24
      && (b.bottom - state.y) * s >= -m.height / 2 + m.inset.bottom + 24 && (b.top - state.y) * s <= m.height / 2 - m.inset.top - 24;
    if (fits) return false;
    // Home now covers the central farm. Pan to outer workshops without lowering the zoom limit.
    c.panBy((state.x - (b.left + b.right) / 2) * s, (state.y - (b.bottom + b.top) / 2) * s + (m.inset.bottom - m.inset.top) / 2);
    m.update(); return true;
  }, key);
  if (moved) await page.waitForTimeout(100);
}
async function touchBuilding(page, key, badge = false, reveal = true) {
  if (reveal) await revealBuilding(page, key);
  const target = await page.evaluate(({ key, badge }) => {
    if (!badge) return farmCocos.buildings().find(b => b.buildingId === key).screen;
    const n = testApp.map.town.buildings.get(key).badge, p = n.worldPosition, cc = testCc, vp = cc.view.getViewportRect(), canvas = cc.view.getCanvasSize();
    return { x: (vp.x + p.x * cc.view.getScaleX()) / canvas.width, y: 1 - (vp.y + p.y * cc.view.getScaleY()) / canvas.height };
  }, { key, badge });
  const canvas = await page.locator('#GameCanvas').boundingBox();
  assert.ok(target.x > 0 && target.x < 1 && target.y > 0 && target.y < 1, key + ' input visible');
  await page.touchscreen.tap(canvas.x + target.x * canvas.width, canvas.y + target.y * canvas.height); await page.waitForTimeout(140);
}
async function route(page, machine) {
  await page.waitForFunction(({ type }) => farmCocos.ui().view === 'factory' && testApp.game.state.machines.find(m => m.id === testApp.panels.machineId)?.type === type, machine);
}
async function hold(page, key, fraction) {
  await page.evaluate(key => { testApp.close(); testApp.map.focusBuilding(key); }, key); await page.waitForTimeout(120);
  const data = await inspect(page), m = data.machines.find(m => m.key === key), canvas = await page.locator('#GameCanvas').boundingBox();
  const x = canvas.x + m.bounds.left + (m.bounds.right - m.bounds.left) * fraction, y = canvas.y + (m.bounds.top + m.bounds.bottom) / 2;
  await page.mouse.move(x, y); await page.mouse.down(); await page.waitForTimeout(560);
  const selected = await page.evaluate(() => ({ active: testApp.map.movement.active, selected: testApp.map.movement.selected }));
  await page.mouse.up(); await page.waitForTimeout(120);
  assert.equal(selected.active, true, key + ' hold enters arrangement'); assert.equal(selected.selected, key, key + ' hold selects correct model');
}

(async () => {
  fs.mkdirSync(out, { recursive: true }); const server = await serve(), browser = await launch(), results = [];
  const save = detail => fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify({ buildPath: build, testedAt: new Date().toISOString(), runnerCleanup: 'Close owned Chromium, then close the local test server and its remaining connections.', results, ...detail }, null, 2) + '\n');
  save({ passed: false, status: 'running' });
  try {
    for (const [width, height] of [[568, 320], [390, 844], [320, 568], [844, 390]]) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true, isMobile: true });
      const page = await context.newPage(), observed = observe(page), result = { width, height, routes: [], purchases: [], working: [] };
      try {
        await boot(page, server.url); await page.evaluate(() => { testApp.game.dismissGuide(); testApp.close(); testApp.focusHome(); testApp.refresh(); }); await page.waitForTimeout(140);
        const fresh = await inspect(page); result.fresh = fresh;
        assert.equal(fresh.machines.length, 8); assert.equal(fresh.machines.filter(m => m.owned).length, 3); assert.equal(fresh.machines.filter(m => !m.owned).length, 5);
        assert.equal(fresh.machines.filter(m=>m.present).length,3);assert.ok(fresh.machines.every(m=>m.present===m.owned));assert.equal(fresh.sheepWidth,null);
        const freshCentral=fresh.homeObjects.filter(o=>o.id.startsWith('crop:')||o.id.startsWith('pen:'));
        assert.equal(freshCentral.length,42);assert.deepEqual(freshCentral.filter(o=>o.id.startsWith('pen:')).map(o=>o.id),['pen:12','pen:13']);
        for(const o of freshCentral)assert.ok(fits(o,fresh.free),'Fresh fields and constructed yards fit Home: '+JSON.stringify(o));
        const hiddenInput=await page.evaluate(()=>({targets:testApp.map.targets().filter(p=>p.cell===14||p.cell===15),buildings:testApp.map.buildingTargets().map(b=>b.buildingId),rejected:testApp.game.machineTypes.filter(t=>!testApp.game.state.machines.some(m=>m.type===t.id)).map(t=>!testApp.map.focusBuilding(t.buildingIds[0]))}));
        assert.deepEqual(hiddenInput.targets,[]);assert.equal(hiddenInput.buildings.length,5);assert.ok(hiddenInput.rejected.every(Boolean));
        for(const m of fresh.machines.filter(m=>!m.owned))assert.ok(!hiddenInput.buildings.includes(m.key),'no invisible machine input '+m.key);
        await page.screenshot({path:path.join(out,`home-fresh-${width}x${height}.png`)});
        // Seed resources/progression and construct both future pens as a geometry fixture.
        // All five new machines below are bought by real input through the Shop cards.
        await page.evaluate(()=>{const a=testApp,g=a.game;g.state.coins=20000;g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};for(const item of g.items)g.state.inventory[item.key]=100;for(const id of [14,15]){const r=g.buyPen(id);if(r.error)throw Error(r.error);}a.refresh();a.focusHome();});
        for(const m of fresh.machines.filter(m=>!m.owned)){
          await home(page);await tap(page,'shop',true);await tap(page,'shop-tab-buildings',true);await tap(page,'shop-machine-'+m.type,true);
          await page.waitForFunction(key=>farmCocos.ui().view===''&&testApp.map.town.buildings.has(key),m.key);await page.waitForTimeout(140);
          const purchased=await inspect(page),owned=purchased.machines.find(n=>n.key===m.key);
          assert.ok(owned.owned&&owned.present&&owned.active);assert.equal(owned.opacity,255);assert.ok(Math.abs(owned.worldWidth-784)<.1);
          assert.deepEqual(owned.artBounds,m.artBounds,'shop purchase uses the saved reserved site');assert.deepEqual(owned.frames,m.sourceFrames,'the purchased model keeps every source sprite');
          assert.equal(purchased.selectedMachine,m.key);assert.ok(owned.badgeText.includes('Chạm mở'));
          assert.ok(fits(owned.full,purchased.free,purchased.padding),'purchase focuses full source model and badge');
          await page.evaluate(()=>testApp.refresh());await page.waitForTimeout(100);const refreshed=(await inspect(page)).machines.find(n=>n.key===m.key);
          assert.equal(refreshed.node,owned.node);assert.equal(refreshed.model,owned.model);assert.equal(refreshed.scale,owned.scale);assert.deepEqual(refreshed.pose,owned.pose,'new idle model stays idle');
          result.purchases.push({key:m.key,model:owned.model,width:owned.worldWidth,absentBefore:true,opacityAfter:owned.opacity,badge:owned.badgeText,retainedAfterRefresh:true});
        }
        await home(page);const before=await inspect(page);result.allBuilt=before;
        assert.equal(before.cropWidth, 196); assert.ok(Math.abs(before.sheepWidth - 784) < .1);assert.ok(before.machines.every(m=>m.owned&&m.present));
        assert.equal(before.homeObjects.length, 52);
        const central = before.homeObjects.filter(o => o.id.startsWith('crop:') || o.id.startsWith('pen:'));
        assert.equal(central.length, 44);
        for (const o of central) assert.ok(fits(o, before.free), 'Central Home shows all fields/yards and badges: ' + JSON.stringify(o));
        console.log(`${width}×${height}: central 44 field/yard bounds fit HUD/footer; outer machines remain reachable by pan`);
        for (const initial of before.machines) {
          await revealBuilding(page, initial.key);
          const m = (await inspect(page)).machines.find(m => m.key === initial.key);
          assert.ok(m.active && !m.legacyPaper, m.key + ' full prefab visible, no paper site');
          assert.ok(Math.abs(m.worldWidth - 784) < .1, m.key + ': actual width ' + m.worldWidth);
          assert.equal(m.opacity, 255); assert.deepEqual(m.frames, m.sourceFrames, m.key + ' preserves every source sprite');
        }
        await home(page);
        await page.screenshot({ path: path.join(out, `home-all-built-${width}x${height}.png`) });
        const crop = await page.evaluate(() => testApp.game.state.plots.find(p => p.group === 'crop' && p.unlocked && p.crop === null).id);
        await plot(page, crop, true); sameCamera(await page.evaluate(() => testApp.map.cameraState()), before.camera, 'Crop tap keeps camera'); result.cropCameraPreserved = true;
        for (const m of before.machines) {
          await home(page); await touchBuilding(page, m.key); await route(page, m);
          const focused = await inspect(page), current = focused.machines.find(n => n.key === m.key);
          assert.equal(focused.selectedMachine, m.key); assert.equal(focused.camera.mode, 'manual');
          assert.ok(fits(current.full, focused.free, focused.padding), m.key + ' focus includes full art and expanded badge: ' + JSON.stringify(current.full));
          await tap(page, 'close-panel', true);
          await home(page); await touchBuilding(page, m.key, true); await route(page, m);
          await tap(page, 'close-panel', true);
          const manual = await page.evaluate(() => { testApp.map.camera.panBy(12, 10); return testApp.map.cameraState(); });
          // This case deliberately retains the player's offset; its body target is already visible.
          await page.waitForTimeout(80); await touchBuilding(page, m.key, false, false); await route(page, m);
          sameCamera(await page.evaluate(() => testApp.map.cameraState()), manual, 'Machine touch keeps manual camera');
          await tap(page, 'close-panel', true);
          result.routes.push({ type: m.type, key: m.key, fullFocus: current.full, badge: current.badgeText, body: true, badgeTap: true, manual: true });
        }
        await hold(page, before.machines[0].key, .5); await hold(page, before.machines.find(m => m.prefab === 'grill').key, .95);
        result.holdCenterAndEdge = true;
        // One recipe per machine verifies articulated parts after scaling, without replaying
        // the separately approved 23-recipe economy test on every viewport.
        if (width === 390) for (const m of before.machines) {
          await home(page); await touchBuilding(page, m.key); await route(page, { ...m, owned: true });
          const recipe = await page.evaluate(type => testApp.game.catalog.products.find(r => r.machine === type).id, m.type);
          await tap(page, 'choose-recipe', true); await tap(page, 'select-recipe-' + recipe, true); await tap(page, 'produce-' + recipe, true);
          const first = (await inspect(page)).machines.find(n => n.key === m.key); await page.waitForTimeout(230);
          const later = (await inspect(page)).machines.find(n => n.key === m.key);
          assert.ok(first.motionParts > 0); assert.notDeepEqual(later.pose, first.pose, m.key + ' working source parts move');
          result.working.push({ type: m.type, recipe, motionParts: first.motionParts });
        }
        await home(page); await page.screenshot({ path: path.join(out, `home-owned-${width}x${height}.png`) });
        await page.evaluate(() => { testApp.close(); testApp.map.focusBuilding('industry-loom'); }); await page.waitForTimeout(120);
        await page.screenshot({ path: path.join(out, `loom-focus-${width}x${height}.png`) });
        assert.deepEqual(observed.errors, []); result.errors = []; results.push(result); save({ passed: false, status: 'running' });
        console.log(`${width}×${height}: hidden fresh sites, 5 real Shop purchases, 8 full prefabs/784 width, body/badge routes, focus, hold and camera passed`);
      } catch (error) {
        await page.screenshot({ path: path.join(out, `failure-${width}x${height}.png`) });
        save({ passed: false, error: String(error), current: result, latest: await inspect(page).catch(() => null), errors: observed.errors }); throw error;
      } finally { await context.close(); }
    }
    save({ passed: true, viewportCount: results.length, machineRoutes: results.reduce((n, r) => n + r.routes.length, 0), purchases: results.reduce((n, r) => n + r.purchases.length, 0), workingMachines: results.reduce((n, r) => n + r.working.length, 0), errors: [] });
  } finally {
    await browser.close(); await server.close();
    const report = JSON.parse(fs.readFileSync(path.join(out, 'results.json'), 'utf8'));
    report.cleanupComplete = true; fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(report, null, 2) + '\n');
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
