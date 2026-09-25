'use strict';
// Geometry fixture only: source art/camera remain untouched; opening pens and management
// uses real touch input. Progression/economy is covered by the separate starter suite.
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { serve, launch, boot, tap, plot, observe, build } = require('./browser-support.cjs');
const out = process.env.HERD_FOCUS_ARTIFACT_DIR ? path.resolve(process.env.HERD_FOCUS_ARTIFACT_DIR) : path.resolve(__dirname, '../artifacts/herd-field-scale-review/finalfocus');
const output = path.join(out, 'focus-results.json');
const expectedYardWidth = Number(process.env.HERD_EXPECTED_YARD_WIDTH || 784);
const expectedResidentScale = Number(process.env.HERD_EXPECTED_RESIDENT_SCALE || 3);
assert.ok(Number.isFinite(expectedYardWidth) && expectedYardWidth > 0, 'Valid expected yard width');
assert.ok(Number.isFinite(expectedResidentScale) && expectedResidentScale > 0, 'Valid expected resident scale');

async function measureHome(page) {
  return page.evaluate(() => {
    const a = testApp, cc = testCc, map = a.map, model = map.model, element = document.querySelector('#GameCanvas').getBoundingClientRect();
    const positions = model.plotPositions().filter(p => a.game.isActivePlot(p.plot));
    const crops = positions.filter(p => p.plot.group === 'crop');
    const cropBounds = model.widgetBounds([{ ...crops[0].cell.widget, matrix: crops[0].cell.matrix }]);
    const cropWorldWidth = cropBounds.right - cropBounds.left;
    const cssPerWorld = map.camera.displayScale / a.width * element.width;
    const viewport = cc.view.getViewportRect(), canvas = cc.view.getCanvasSize();
    const x = value => (viewport.x + value * cc.view.getScaleX()) / canvas.width * element.width;
    const y = value => element.height - (viewport.y + value * cc.view.getScaleY()) / canvas.height * element.height;
    const sprites = node => node.getComponentsInChildren(cc.Sprite).filter(sprite => sprite.node.activeInHierarchy && sprite.spriteFrame).map(sprite => sprite.node.getComponent(cc.UITransform).getBoundingBoxToWorld());
    const rect = boxes => ({ left: x(Math.min(...boxes.map(b => b.xMin))), right: x(Math.max(...boxes.map(b => b.xMax))), top: y(Math.max(...boxes.map(b => b.yMax))), bottom: y(Math.min(...boxes.map(b => b.yMin))) });
    const pens = [...map.town.yards].map(([id, yard]) => {
      const boxes = [...sprites(yard.node), ...sprites(yard.front)];
      const designWidth = Math.max(...boxes.map(b => b.xMax)) - Math.min(...boxes.map(b => b.xMin));
      const worldWidth = designWidth / map.camera.displayScale;
      return { id, worldWidth, cssWidth: worldWidth * cssPerWorld, cropWidthRatio: worldWidth / cropWorldWidth };
    });
    const objects = [
      ...[...map.itemRenderer.crops].map(([id, crop]) => ({ id: 'crop:' + id, ...rect(sprites(crop.root)) })),
      ...[...map.town.yards].map(([id, yard]) => ({ id: 'pen:' + id, ...rect([...sprites(yard.node), ...sprites(yard.front), yard.badge.getComponent(cc.UITransform).getBoundingBoxToWorld()]) })),
      ...[...map.town.buildings].map(([id, building]) => ({ id: 'machine:' + id, ...rect(sprites(building.node)) })),
    ];
    const free = { left: 0, right: element.width, top: 104 / a.height * element.height, bottom: element.height - 196 / a.height * element.height };
    const fit = map.homeFit(), worldBounds = fit.bounds;
    return { camera: map.camera.state(), worldBounds, boundsSize: { width: worldBounds.right - worldBounds.left, height: worldBounds.top - worldBounds.bottom }, cropWorldWidth, cropCssWidth: cropWorldWidth * cssPerWorld, cropCount: crops.length, penCount: pens.length, machineTypeCount: a.game.machineTypes.length, pens, objects, free };
  });
}

async function measure(page, id) {
  return page.evaluate(id => {
    const a = testApp, cc = testCc, yard = a.map.town.yards.get(id);
    if (!yard?.node.activeInHierarchy || !yard.front.activeInHierarchy || !yard.badge.activeInHierarchy) throw Error('Hidden yard/front/badge for ' + id);
    const box = node => node.getComponent(cc.UITransform).getBoundingBoxToWorld();
    const spriteBoxes = node => node.getComponentsInChildren(cc.Sprite).filter(sprite => sprite.node.activeInHierarchy && sprite.spriteFrame).map(sprite => box(sprite.node));
    const union = boxes => ({ left: Math.min(...boxes.map(b => b.xMin)), right: Math.max(...boxes.map(b => b.xMax)), bottom: Math.min(...boxes.map(b => b.yMin)), top: Math.max(...boxes.map(b => b.yMax)) });
    const viewport = cc.view.getViewportRect(), canvas = cc.view.getCanvasSize(), element = document.querySelector('#GameCanvas').getBoundingClientRect();
    const x = value => (viewport.x + value * cc.view.getScaleX()) / canvas.width * element.width;
    const y = value => element.height - (viewport.y + value * cc.view.getScaleY()) / canvas.height * element.height;
    const css = b => ({ left: x(b.left), right: x(b.right), top: y(b.top), bottom: y(b.bottom) });
    const back = spriteBoxes(yard.node), front = spriteBoxes(yard.front), badge = box(yard.badge);
    const badgeTransform = yard.badge.getComponent(cc.UITransform);
    const residents = [...a.map.town.animals.values()].filter(animal => animal.pen === id && animal.node.activeInHierarchy);
    const animals = residents.flatMap(animal => spriteBoxes(animal.node));
    const body = css(union([...back, ...front])), badgeBounds = css(union([badge]));
    const bounds = css(union([...back, ...front, badge, ...animals]));
    const bar = box(a.herdBar.node), paddingX = 24 / a.width * element.width, paddingY = 24 / a.height * element.height;
    const free = { left: paddingX, right: element.width - paddingX, top: 104 / a.height * element.height + paddingY, bottom: y(bar.yMax) - paddingY };
    const targets = ['herd-feed', 'herd-collect', 'herd-manage'].map(id => {
      const node = a.ui.controls.get(id); if (!node?.activeInHierarchy) throw Error('Missing ' + id);
      const b = css(union([box(node)]));
      return { id, ...b, width: b.right - b.left, height: b.bottom - b.top };
    });
    const crop = a.map.model.plotPositions().find(p => p.plot.group === 'crop');
    const cropBounds = a.map.model.widgetBounds([{ ...crop.cell.widget, matrix: crop.cell.matrix }]);
    const cropWorldWidth = cropBounds.right - cropBounds.left;
    const worldWidth = (body.right - body.left) / element.width * a.width / a.map.camera.displayScale;
    return { id, species: a.game.residentPlot(id).residents.species, yardScale: yard.node.scale.x, frontScale: yard.front.scale.x, worldWidth, cropWorldWidth, cropWidthRatio: worldWidth / cropWorldWidth, residentScales: residents.map(animal => animal.node.scale.x), camera: farmCocos.map().camera, badgeSize: { width: badgeTransform.width, height: badgeTransform.height }, selected: a.selected, residentCount: residents.length, spriteCounts: { back: back.length, front: front.length, animals: animals.length }, body, badge: badgeBounds, bounds, free, gaps: { left: bounds.left - free.left, right: free.right - bounds.right, top: bounds.top - free.top, bottom: free.bottom - bounds.bottom }, quickbar: css(union([bar])), targets, canvas: { width: element.width, height: element.height } };
  }, id);
}

function verify(result) {
  assert.ok(Math.abs(result.worldWidth - expectedYardWidth) < .1, `Yard width ${result.worldWidth} matches ${expectedYardWidth} map units`);
  assert.equal(result.frontScale, result.yardScale, 'Front fence follows yard scale');
  for (const scale of result.residentScales) assert.ok(Math.abs(scale - expectedResidentScale) < .001, 'Residents use the expected scale');
  assert.equal(result.selected, result.id, 'Real touch selects the intended pen');
  assert.equal(result.residentCount, 3, 'All three residents rendered');
  assert.ok(result.spriteCounts.back > 0 && result.spriteCounts.front > 0 && result.spriteCounts.animals > 0, 'Measure actual visible sprites');
  // Inspect the local authored badge: camera zoom can make its world box smaller.
  // Collapsed badges are 74×42; selected badges must keep the complete 160×66 face.
  assert.deepEqual(result.badgeSize, { width: 160, height: 66 }, 'Selected badge is expanded');
  for (const [side, gap] of Object.entries(result.gaps)) assert.ok(gap >= -1, `${result.species}: ${side} clips padded free area by ${-gap} CSS px`);
  for (const t of result.targets) {
    assert.ok(t.width >= 43.9 && t.height >= 43.9, `${t.id}: target ${t.width}×${t.height} CSS px`);
    assert.ok(t.left >= -1 && t.right <= result.canvas.width + 1 && t.top >= -1 && t.bottom <= result.canvas.height + 1, t.id + ' fits canvas');
  }
  for (let i = 0; i < result.targets.length; i++) for (let j = i + 1; j < result.targets.length; j++) {
    const a = result.targets[i], b = result.targets[j];
    const overlapX = Math.min(a.right, b.right) - Math.max(a.left, b.left), overlapY = Math.min(a.bottom, b.bottom) - Math.max(a.top, b.top);
    assert.ok(overlapX <= 1 || overlapY <= 1, `${a.id} overlaps ${b.id}`);
  }
}

function sameCamera(actual, expected, reason) {
  assert.equal(actual.mode, expected.mode, reason + ': mode');
  for (const key of ['x', 'y', 'displayScale']) assert.ok(Math.abs(actual[key] - expected[key]) < .0001, reason + ': ' + key);
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const server = await serve(), browser = await launch(), results = [], home = [];
  const save = detail => fs.writeFileSync(output, JSON.stringify({ buildPath: build, testedAt: new Date().toISOString(), expectedYardWidth, expectedResidentScale, home, results, ...detail }, null, 2) + '\n');
  save({ passed: false, status: 'running' });
  try {
    for (const [width, height] of [[390, 844], [320, 568], [844, 390], [568, 320]]) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true, isMobile: true });
      const page = await context.newPage(), observed = observe(page);
      let latestCase = null;
      try {
        await boot(page, server.url);
        await page.evaluate(() => { testApp.game.dismissGuide(); testApp.close(); testApp.focusHome(); testApp.refresh(); });
        await page.waitForTimeout(150);
        const opening = { width, height, phase: 'fresh', ...await measureHome(page) };
        home.push(opening);
        await page.screenshot({ path: path.join(out, `focus-home-${width}x${height}.png`) });
        assert.equal(opening.cropCount, 40); assert.equal(opening.penCount, 2); assert.equal(opening.machineTypeCount, 8);
        assert.deepEqual(opening.pens.map(p=>p.id),[12,13]);
        assert.equal(opening.objects.filter(o=>o.id.startsWith('machine:')).length,3,'future workshops have no map model');
        assert.deepEqual(await page.evaluate(()=>farmCocos.targets().filter(p=>p.cell===14||p.cell===15)),[],'unopened pens have no invisible input target');
        // Record overview problems while still checking independent care views; never turn
        // a camera-fit failure into a pass merely because focused controls remain usable.
        const central = opening.objects.filter(object => object.id.startsWith('crop:') || object.id.startsWith('pen:'));
        assert.equal(central.length, 42, 'Fresh Home shows 40 fields and only the two constructed yards');
        opening.failures = central.filter(object => !(Number.isFinite(object.left) && object.left >= opening.free.left - 1 && object.right <= opening.free.right + 1 && object.top >= opening.free.top - 1 && object.bottom <= opening.free.bottom + 1));
        if (opening.failures.length) console.log(`${width}×${height}: home art clipping: ${JSON.stringify(opening.failures)}`);
        await page.evaluate(() => {
          const a = testApp, g = a.game, ok = result => { if (result.error) throw Error(result.error); };
          g.dismissGuide(); a.close(); g.state.coins = 20000;
          g.state.husbandry = { version: 1, feedReceived: true, eggsCollected: true, milkCollected: true, burgerCollected: true };
          for (const id of [14, 15]) if (!g.residentPlot(id).residents) ok(g.buyPen(id));
          g.state.xp = 210;
          for (const id of [12, 13, 14, 15]) {
            const pen = g.residentPlot(id).residents;
            while (pen.capacity < 3) ok(g.expandPen(id));
            while (pen.animals.length < 3) ok(g.buyAnimal(id));
          }
          a.session.paused = false; g.validate(); a.refresh();
        });
        await page.evaluate(()=>testApp.focusHome());await page.waitForTimeout(120);
        const builtHome={width,height,phase:'all-pens',...await measureHome(page)};
        assert.equal(builtHome.penCount,4);
        const builtCentral=builtHome.objects.filter(o=>o.id.startsWith('crop:')||o.id.startsWith('pen:'));
        assert.equal(builtCentral.length,44);
        builtHome.failures=builtCentral.filter(o=>!(Number.isFinite(o.left)&&o.left>=builtHome.free.left-1&&o.right<=builtHome.free.right+1&&o.top>=builtHome.free.top-1&&o.bottom<=builtHome.free.bottom+1));
        home.push(builtHome);await page.screenshot({path:path.join(out,`focus-home-all-pens-${width}x${height}.png`)});
        const crop = await page.evaluate(() => {
          testApp.close(); testApp.focusHome();
          return { id: testApp.game.state.plots.find(p => p.group === 'crop' && p.unlocked && p.crop === null).id, camera: testApp.map.cameraState() };
        });
        await page.waitForTimeout(120); await plot(page, crop.id, true);
        assert.equal(await page.evaluate(() => farmCocos.ui().selected), crop.id, 'Crop still opens its own footer');
        sameCamera(await page.evaluate(() => testApp.map.cameraState()), crop.camera, 'Crop tap preserves home camera');
        home[home.length - 1].cropTapPreservesCamera = true;
        for (const id of [12, 13, 14, 15]) {
          // Begin at the real opening view: the touch must select AND focus the pen.
          await page.evaluate(() => { testApp.close(); testApp.focusHome(); });
          await page.waitForTimeout(120); await plot(page, id, true);
          await page.waitForFunction(id => farmCocos.ui().selected === id && !!testApp.herdBar?.node.activeInHierarchy, id);
          await page.waitForTimeout(180);
          const result = { width, height, ...await measure(page, id) };
          latestCase = result;
          assert.equal(result.camera.mode, 'manual', 'Pen touch from home enters the fitted care view');
          result.realTouchFromHome = true;
          await page.screenshot({ path: path.join(out, `focus-${width}x${height}-pen-${id}.png`) });
          verify(result);
          await tap(page, 'herd-manage', true);
          await page.waitForFunction(id => farmCocos.ui().view === 'livestock' && testApp.panels.penId === id && !testApp.panels.livestockManagement, id);
          result.realTouchManagement = true;
          await tap(page, 'close-panel', true);
          assert.equal(await page.evaluate(() => farmCocos.ui().view), '', 'Management closes by real touch');
          // A player-adjusted angle must remain theirs when they touch the pen again.
          const manual = await page.evaluate(() => { testApp.map.camera.panBy(16, 12); return testApp.map.cameraState(); });
          await page.waitForTimeout(100); await plot(page, id, true);
          assert.equal(await page.evaluate(() => farmCocos.ui().selected), id);
          sameCamera(await page.evaluate(() => testApp.map.cameraState()), manual, 'Manual camera survives pen touch');
          result.manualCameraPreserved = true;
          results.push(result); save({ passed: false, status: 'running' });
          console.log(`${width}×${height}, pen ${id}: real home tap focuses yard/front/badge; 44 px management and manual camera passed`);
        }
        assert.deepEqual(observed.errors, [], 'No browser errors');
      } catch (error) {
        await page.screenshot({ path: path.join(out, `focus-failure-${width}x${height}.png`) });
        save({ passed: false, error: String(error), latestCase, errors: observed.errors }); throw error;
      } finally { await context.close(); }
    }
    const homeFailures = home.filter(opening => opening.failures.length).map(({ width, height, failures }) => ({ width, height, failures }));
    save({ passed: !homeFailures.length, cases: results.length, homeFailures, errors: [] });
    assert.deepEqual(homeFailures, [], 'Central fields and yards must fit between HUD/footer on every viewport');
  } finally { await browser.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
