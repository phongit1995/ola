'use strict';
// Check the rendered source art and placement outline together, then drag every
// production building with real input and verify the saved position after reload.
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { serve, launch, boot, observe } = require('./browser-support.cjs');
const unregister = require('tsx/cjs/api').register();
const { FARM_LAYOUT, buildingPosition, movedLayout, snapPosition, checkLayout } = require('../assets/farm/scripts/core/BuildingPlacement.ts');
unregister();
require('esbuild').stop();
const geometry = JSON.parse(fs.readFileSync(path.join(__dirname, '../source-assets/farm-beautify/machine-footprints.json'), 'utf8'));
const output = process.env.COCOS_MACHINE_PLACEMENT_OUT || path.resolve(__dirname, '../artifacts/machine-move-audit/verified');
const near = (a, b, message) => assert.ok(Math.abs(a - b) < 0.1, `${message}: ${a} vs ${b}`);

function destination(id, state) {
  const origin = buildingPosition(id, state.buildingLayout);
  for (let radius = 1; radius <= 12; radius++) {
    for (const [dx, dy] of [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1]]) {
      const p = snapPosition({ x: origin.x + dx * radius * 36, y: origin.y + dy * radius * 18 });
      if ((p.x !== origin.x || p.y !== origin.y) && !checkLayout(movedLayout(state.buildingLayout, id, p), state).error) return p;
    }
  }
  throw Error('No nearby placement for ' + id);
}

async function pixel(page, point) {
  const position = await page.evaluate(point => {
    const cc = testCc;
    const p = testApp.map.world.getComponent(cc.UITransform).convertToWorldSpaceAR(new cc.Vec3(point.x, point.y));
    const vp = cc.view.getViewportRect(), canvas = cc.view.getCanvasSize();
    return { x: (vp.x + p.x * cc.view.getScaleX()) / canvas.width, y: 1 - (vp.y + p.y * cc.view.getScaleY()) / canvas.height };
  }, point);
  const canvas = await page.locator('#GameCanvas').boundingBox();
  assert.ok(position.x > 0 && position.x < 1 && position.y > 0 && position.y < 1, 'Pointer stays inside the canvas');
  return { x: canvas.x + position.x * canvas.width, y: canvas.y + position.y * canvas.height };
}

async function inspect(page, id) {
  return page.evaluate(id => {
    const m = testApp.map, cc = testCc, building = m.town.buildings.get(id);
    const bounds = building.node.getComponentsInChildren(cc.Sprite)
      .filter(s => s.node.activeInHierarchy && s.spriteFrame)
      .map(s => s.node.getComponent(cc.UITransform).getBoundingBoxToWorld());
    const graphics = m.placementOutline.getComponent(cc.Graphics);
    const outline = graphics?.impl?.paths.slice(0, graphics.impl.pathLength).map(p => p.points.map(q => ({ x: q.x, y: q.y }))) ?? [];
    return {
      position: { x: building.node.position.x, y: building.node.position.y },
      width: (Math.max(...bounds.map(b => b.xMax)) - Math.min(...bounds.map(b => b.xMin))) / m.camera.displayScale,
      scale: building.node.scale.x,
      active: building.node.activeInHierarchy,
      outlineVisible: m.placementOutline.activeInHierarchy,
      outline,
      movement: farmCocos.map().movement,
      camera: m.camera.state(),
    };
  }, id);
}

function matchesOutline(actual, id, position) {
  const expected = FARM_LAYOUT.buildings.find(b => b.id === id).footprints;
  assert.equal(actual.outlineVisible, true, id + ': placement outline is visible');
  assert.equal(actual.outline.length, expected.length, id + ': polygon count');
  expected.forEach((polygon, index) => {
    const points = actual.outline[index];
    // Graphics may retain a duplicate closing point after tessellation.
    for (const p of polygon) assert.ok(points.some(q => Math.abs(q.x - p.x - position.x) < .1 && Math.abs(q.y - p.y - position.y) < .1), id + ': source ground vertex follows the rendered building');
    for (const q of points) assert.ok(polygon.some(p => Math.abs(q.x - p.x - position.x) < .1 && Math.abs(q.y - p.y - position.y) < .1), id + ': no obsolete silhouette vertex remains in the outline');
  });
}

(async () => {
  fs.mkdirSync(output, { recursive: true });
  const server = await serve(), browser = await launch(), results = [];
  const viewports = [[1280, 900, false], [390, 844, true], [844, 390, true]];
  const cases = process.env.COCOS_MACHINE_PLACEMENT_VIEWPORT
    ? viewports.filter(([w, h]) => `${w}x${h}` === process.env.COCOS_MACHINE_PLACEMENT_VIEWPORT) : viewports;
  assert.ok(cases.length, 'Known viewport');
  try {
    for (const [width, height, touch] of cases) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true });
      const page = await context.newPage(), observed = observe(page);
      const cdp = await context.newCDPSession(page);
      let current = '';
      try {
        await boot(page, server.url);
        const fixture = await page.evaluate(() => {
          const a = testApp, g = a.game, ok = r => { if (r.error) throw Error(r.error); };
          ok(g.dismissGuide()); a.close();
          g.state.xp = 100000000; g.state.coins = 1000000;
          g.state.husbandry = { version: 1, feedReceived: true, eggsCollected: true, milkCollected: true, burgerCollected: true };
          for (const type of g.machineTypes) while (g.machineConstructionOffer(type.id).count < g.machineLimit(type.id)) ok(g.buyMachine(type.id));
          a.save(); a.refresh();
          return farmCocos.pack();
        });
        assert.equal(fixture.free.machines.length, 16, 'Both houses of every machine type are covered');
        const machines = await page.evaluate(() => testApp.game.state.machines.map(m => ({ id: m.buildingId, prefab: testApp.game.machineTypes.find(t => t.id === m.type).prefab })));
        let state = fixture.free;
        const viewportResults = [];
        for (const { id, prefab } of machines) {
          current = id;
          await page.evaluate(id => {
            const a = testApp; a.close(); a.paused = true;
            a.map.focusBuilding(id); a.map.update();
          }, id);
          const original = buildingPosition(id, state.buildingLayout), target = destination(id, state);
          const body = await page.evaluate(id => {
            const t = testApp.map.buildingTargets().find(t => t.buildingId === id);
            return { x: t.x, y: t.y };
          }, id);
          const from = await pixel(page, body), to = await pixel(page, { x: body.x + target.x - original.x, y: body.y + target.y - original.y });
          const before = await inspect(page, id);
          near(before.width, geometry.machines[prefab].targetWidth, id + ': full art width remains unchanged');
          near(before.scale, geometry.machines[prefab].scale, id + ': source scale');
          if (touch) await cdp.send('Input.dispatchTouchEvent', { type: 'touchStart', touchPoints: [{ ...from, id: 1 }] });
          else { await page.mouse.move(from.x, from.y); await page.mouse.down(); }
          await page.waitForFunction(id => farmCocos.map().movement.selected === id, id, { timeout: 2500 });
          await page.waitForFunction(() => testApp.map.placementOutline.activeInHierarchy);
          const held = await inspect(page, id);
          assert.deepEqual(held.position, original, id + ': holding does not shift the model');
          matchesOutline(held, id, original);
          for (let step = 1; step <= 6; step++) {
            const p = { x: from.x + (to.x - from.x) * step / 6, y: from.y + (to.y - from.y) * step / 6 };
            if (touch) await cdp.send('Input.dispatchTouchEvent', { type: 'touchMove', touchPoints: [{ ...p, id: 1 }] });
            else await page.mouse.move(p.x, p.y);
          }
          await page.waitForFunction(target => farmCocos.map().movement.candidate?.x === target.x && farmCocos.map().movement.candidate?.y === target.y, target);
          await page.waitForFunction(({ id, target }) => {
            const p = testApp.map.town.buildings.get(id).node.position;
            return p.x === target.x && p.y === target.y;
          }, { id, target });
          const dragged = await inspect(page, id);
          assert.equal(dragged.movement.error, null, id + ': valid floor placement');
          assert.deepEqual(dragged.position, target, id + ': model follows the candidate');
          matchesOutline(dragged, id, target);
          assert.deepEqual(dragged.camera, before.camera, id + ': drag preserves camera');
          near(dragged.width, before.width, id + ': dragging does not resize the art');
          if (!id.endsWith('-2')) await page.screenshot({ path: path.join(output, `${id}-${width}x${height}.png`) });
          if (touch) await cdp.send('Input.dispatchTouchEvent', { type: 'touchEnd', touchPoints: [] });
          else await page.mouse.up();
          await page.waitForFunction(() => !farmCocos.map().movement.active);
          const saved = await page.evaluate(() => farmCocos.pack());
          assert.deepEqual(saved.free.buildingLayout.positions[id], target, id + ': release saves position');
          assert.equal(saved.free.coins, fixture.free.coins, id + ': moving is free');
          state = saved.free;
          viewportResults.push({ width, height, touch, id, prefab, artWidth: dragged.width, target, outlineVertices: dragged.outline[0].length, reloaded: false });
        }
        await boot(page, server.url);
        const reloaded = await page.evaluate(ids => ({
          positions: Object.fromEntries(ids.map(id => [id, testApp.map.movement.position(id)])),
          layout: farmCocos.snapshot().buildingLayout,
        }), machines.map(m => m.id));
        assert.deepEqual(reloaded.layout, state.buildingLayout, 'All 16 placements survive one reload together');
        for (const result of viewportResults) {
          assert.deepEqual(reloaded.positions[result.id], result.target, result.id + ': position survives reload');
          result.reloaded = true;
        }
        results.push(...viewportResults);
        assert.deepEqual(observed.errors, [], 'No browser/runtime errors');
        console.log(`${width}x${height}: all 16 production buildings keep size, ground outline, drag and reload alignment`);
      } catch (error) {
        await page.screenshot({ path: path.join(output, `failure-${current}-${width}x${height}.png`) });
        throw error;
      } finally { await context.close(); }
    }
    fs.writeFileSync(path.join(output, 'validation.json'), JSON.stringify({ passed: true, cases: results.length, results }, null, 2) + '\n');
  } finally { await browser.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
