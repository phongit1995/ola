'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, observe } = require('./browser-support.cjs');
const out = process.env.COCOS_TEST_OUTPUT ? path.resolve(process.env.COCOS_TEST_OUTPUT) : path.resolve(__dirname, '../artifacts/scene-authoring');

// Stop immediately before activation: this is the authored scene, before any gameplay-created nodes.
function beforeLaunch(cc, mode) {
  cc.director.once(cc.Director.EVENT_BEFORE_SCENE_LAUNCH, scene => {
    const app = scene.getChildByName('Canvas').getComponent('GameApp');
    globalThis.authoredFarm = { app, map: app.map.authoredMap, hud: app.hud.node, shopButton: app.hud.shopButton };
    if (mode === 'editor') {
      app.onLoad = () => {};
      app.onDestroy = () => {};
    } else {
      app.map.world.setScale(.57, .41, 1);
      app.hud.shopButton.setPosition(-208, 0);
      app.hud.shopButton.getComponentInChildren(cc.Label).fontSize = 23;
    }
    globalThis.sceneCc = cc;
  });
}

(async () => {
  const server = await serve(); let browser;
  fs.mkdirSync(out, { recursive: true });
  try {
    browser = await launch();
    for (const mode of ['editor', 'runtime']) {
      const page = await browser.newPage({ viewport: { width: 390, height: 844 }, hasTouch: true });
      const observed = observe(page);
      await page.route('**/application.js', async route => {
        const response = await route.fetch(), text = await response.text();
        assert.ok(text.includes('return cc.game.run();'));
        await route.fulfill({ response, body: text.replace('return cc.game.run();', `(${beforeLaunch.toString()})(cc, '${mode}'); return cc.game.run();`) });
      });
      try {
        if (mode === 'editor') {
          await page.goto(server.url);
          await page.waitForFunction(() => globalThis.authoredFarm?.map.getComponentsInChildren(sceneCc.Sprite).filter(s => s.spriteFrame).length > 400, undefined, { timeout: 60000 });
          await page.evaluate(() => sceneCc.profiler.hideStats());
          const native = await page.evaluate(() => {
            const { app, map, hud } = authoredFarm;
            return { initialized: app.initialized, storage: localStorage.length,
              mapActive: map.activeInHierarchy, hudActive: hud.activeInHierarchy,
              fields: map.getComponent('FarmMapLayout').fields.length,
              labels: hud.getComponentsInChildren(sceneCc.Label).map(l => l.string),
              sprites: map.getComponentsInChildren(sceneCc.Sprite).filter(s => s.spriteFrame).length };
          });
          assert.equal(native.initialized, false); assert.equal(native.storage, 0);
          assert.equal(native.mapActive, true); assert.equal(native.hudActive, true); assert.equal(native.fields, 40);
          for (const text of ['500', '10', 'Shop', 'Kho 0', 'Nhà máy']) assert.ok(native.labels.includes(text), text + ' exists without gameplay');
          await page.screenshot({ path: path.join(out, 'authored-scene.png') });
          console.log('Authored scene renders 40 fields, scenery, wallets and navigation without gameplay or save access.');
        } else {
          await boot(page, server.url); await tap(page, 'welcome-start', true);
          const reused = await page.evaluate(() => {
            const a = testApp;
            return { sameMap: a.map.authoredMap === authoredFarm.map, sameHud: a.hud.node === authoredFarm.hud,
              sameButton: a.ui.controls.get('shop') === authoredFarm.shopButton,
              roots: a.node.children.filter(n => n.name === 'GameRoot').length,
              huds: a.root.getComponentsInChildren('HudView').length,
              x: a.hud.shopButton.position.x, font: a.hud.shopButton.getComponentInChildren(testCc.Label).fontSize,
              buttons: a.hud.shopButton.getComponents(testCc.Button).length, targets: a.map.targets().length };
          });
          assert.deepEqual(reused, { sameMap: true, sameHud: true, sameButton: true, roots: 1, huds: 1, x: -208, font: 23, buttons: 1, targets: 42 });
          const geometry = await page.evaluate(() => {
            const m = testApp.map, fields = m.authoredMap.getComponent('FarmMapLayout').fields;
            const crops = testApp.game.state.plots.filter(p => p.group === 'crop').sort((a, b) => a.id - b.id);
            const targets = new Map(m.targets().map(t => [t.id, t]));
            return fields.map((anchor, i) => {
              const t = anchor.getComponent(testCc.UITransform), target = targets.get(crops[i].id);
              return { id: target.id,
                hitWidth: target.w * m.world.worldScale.x, hitHeight: target.h * m.world.worldScale.y,
                visibleWidth: t.width * anchor.worldScale.x, visibleHeight: t.height * anchor.worldScale.y };
            });
          });
          for (const g of geometry) {
            assert.ok(Math.abs(g.hitWidth - g.visibleWidth) < .01, `field ${g.id} hit width matches its artwork after Editor scaling`);
            assert.ok(Math.abs(g.hitHeight - g.visibleHeight) < .01, `field ${g.id} hit height matches its artwork after Editor scaling`);
          }
          await tap(page, 'inventory', true); assert.equal(await page.evaluate(() => farmCocos.ui().view), 'inventory');
          await tap(page, 'close-panel', true); await tap(page, 'factory', true); assert.equal(await page.evaluate(() => farmCocos.ui().view), 'factory');
          await tap(page, 'close-panel', true); await tap(page, 'pause-menu', true); assert.equal(await page.evaluate(() => farmCocos.ui().paused), true);
          await tap(page, 'resume', true); await tap(page, 'pause-menu', true); await tap(page, 'home', true);
          await page.screenshot({ path: path.join(out, 'runtime-scene.png') });
          console.log('Runtime reuses the authored map and HUD, preserves Inspector edits and binds each navigation button once.');
        }
        assert.deepEqual(observed.errors, []);
      } catch (error) { await page.screenshot({ path: path.join(out, mode + '-failure.png') }); throw error; }
      finally { await page.close(); }
    }
  } finally { await browser?.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
