'use strict';
const fs = require('node:fs'), path = require('node:path'), http = require('node:http'), assert = require('node:assert/strict');
const { chromium } = require('playwright');
const build = process.env.COCOS_TEST_BUILD ? path.resolve(process.env.COCOS_TEST_BUILD) : path.resolve(__dirname, '../build/farm-web-mobile'), out = process.env.COCOS_TEST_OUTPUT ? path.resolve(process.env.COCOS_TEST_OUTPUT) : path.resolve(__dirname, '../artifacts/cocos-footer');
const server = http.createServer((req, res) => {
  if (req.url === '/favicon.ico') return res.writeHead(204).end();
  let file = path.resolve(build, '.' + new URL(req.url, 'http://localhost').pathname);
  if (file === build) file = path.join(build, 'index.html');
  if (!file.startsWith(build + path.sep) || !fs.existsSync(file)) return res.writeHead(404).end();
  res.setHeader('Content-Type', ({ '.html': 'text/html', '.js': 'text/javascript', '.json': 'application/json', '.css': 'text/css', '.wasm': 'application/wasm' })[path.extname(file)] || 'application/octet-stream');
  fs.createReadStream(file).pipe(res);
});
const near = (a, b, message) => assert.ok(Math.abs(a - b) < .1, `${message}: ${a}, ${b}`);
(async () => {
  await new Promise(r => server.listen(0, '127.0.0.1', r)); fs.mkdirSync(out, { recursive: true });
  const browser = await chromium.launch({ headless: true, ...(process.env.PLAYWRIGHT_CHANNEL ? { channel: process.env.PLAYWRIGHT_CHANNEL } : {}) }), results = [];
  try {
    for (const [name, width, height, touch] of [['desktop', 1280, 720, false], ['portrait', 390, 844, true], ['landscape', 844, 390, true], ['small', 320, 568, true]]) {
      if (process.env.COCOS_FOOTER_CASE && process.env.COCOS_FOOTER_CASE !== name) continue;
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: touch, isMobile: touch, deviceScaleFactor: 1 });
      const page = await context.newPage(), errors = [];
      page.on('pageerror', e => errors.push(e.message));
      page.on('console', m => { if (m.type() === 'error' || m.type() === 'warning' && /letter|character|font/i.test(m.text())) errors.push(m.text()); });
      const state = () => page.evaluate(() => farmCocos.snapshot());
      const settle = async () => { await page.waitForTimeout(90); await page.waitForFunction(() => !farmCocos.ui().animating); };
      async function position(kind, id) {
        const p = await page.evaluate(([kind, id]) => { const p = farmCocos[kind]().find(c => c.id === id); return kind === 'targets' ? p?.screen : p; }, [kind, id]); assert.ok(p, kind + '/' + id);
        const box = await page.locator('#GameCanvas').boundingBox();
        return { x: box.x + p.x * box.width, y: box.y + p.y * box.height };
      }
      async function tap(kind, id) {
        const p = await position(kind, id);
        if (touch) await page.touchscreen.tap(p.x, p.y); else await page.mouse.click(p.x, p.y);
        await settle();
      }
      async function drag(a, b) {
        if (touch) {
          const cdp = await context.newCDPSession(page);
          await cdp.send('Input.dispatchTouchEvent', { type: 'touchStart', touchPoints: [{ ...a, id: 1 }] });
          for (let i = 1; i <= 8; i++) { await cdp.send('Input.dispatchTouchEvent', { type: 'touchMove', touchPoints: [{ x: a.x + (b.x - a.x) * i / 8, y: a.y + (b.y - a.y) * i / 8, id: 1 }] }); await page.waitForTimeout(15); }
          await cdp.send('Input.dispatchTouchEvent', { type: 'touchEnd', touchPoints: [] }); await cdp.detach();
        } else { await page.mouse.move(a.x, a.y); await page.mouse.down(); await page.mouse.move(b.x, b.y, { steps: 8 }); await page.mouse.up(); }
        await settle();
      }
      async function inspect() {
        return page.evaluate(() => {
          const cc = footerCc, app = footerApp, footer = app.root.getChildByName('CellMenu').getChildByName('PlotFooter');
          const rect = n => { const t = n.getComponent(cc.UITransform), s = n.worldScale, p = n.worldPosition; return { x: p.x - t.width * t.anchorX * s.x, y: p.y - t.height * t.anchorY * s.y, w: t.width * s.x, h: t.height * s.y }; };
          return { ui: farmCocos.ui(), box: footer ? rect(footer) : null, navigation: app.hud.navigation.active,
            labels: footer ? footer.getComponentsInChildren(cc.Label).map(l => ({ name: l.node.name, text: l.string, size: l.fontSize, actual: l.actualFontSize, font: l.font?.name, box: rect(l.node) })) : [],
            bubbles: app.map.bubbles.diagnostics(), controls: farmCocos.controls(),
            toast: app.toastBox.active ? rect(app.toastBox) : null, targets: farmCocos.targets() };
        });
      }
      /** Bubble controls live on the map and follow the camera; only the seed picker is pinned to the footer. */
      const onMap = id => /^(finish|cancel|harvest|unlock)-\d+$/.test(id);
      function geometry(d) {
        near(d.box.y, 8, 'footer is anchored to screen bottom'); assert.ok(d.box.x >= 0 && d.box.x + d.box.w <= d.ui.width);
        assert.ok(d.box.y + d.box.h <= 184.1 && !d.navigation);
        assert.ok(!d.controls.some(c => ['shop', 'inventory', 'factory'].includes(c.id)), 'navigation replaced while choosing');
        // Seed tiles scroll sideways, so only the ones on screen sit inside the strip.
        for (const c of d.controls.filter(c => !['pause-menu','coins-plus','gems-plus','orders-hud'].includes(c.id) && !onMap(c.id) && !c.id.startsWith('plant-'))) {
          const x = c.x * d.ui.width, y = (1 - c.y) * d.ui.height;
          assert.ok(x - c.w / 2 >= d.box.x - 1 && x + c.w / 2 <= d.box.x + d.box.w + 1 && y - c.h / 2 >= d.box.y - 1 && y + c.h / 2 <= d.box.y + d.box.h + 1, 'footer hit area fits: ' + c.id);
        }
        for (const l of d.labels.filter(l => l.text)) assert.ok(l.actual >= l.size * .9, 'text is readable without excessive shrinking: ' + l.text);
        const first = d.controls.find(c => c.id.startsWith('plant-'));
        assert.ok(first && first.x * d.ui.width - first.w / 2 >= d.box.x - 1, 'the strip starts inside the screen');
        if (d.toast) assert.ok(d.toast.y >= d.box.y + d.box.h, 'planting feedback stays above footer');
      }
      try {
        await page.goto('http://127.0.0.1:' + server.address().port); await page.waitForFunction(() => globalThis.farmCocos, undefined, { timeout: 45000 });
        await page.evaluate(async () => {
          globalThis.footerCc = await System.import('cc');
          globalThis.footerApp = footerCc.director.getScene().getChildByName('Canvas').getComponent('GameApp');
          footerApp.game.dismissGuide(); footerApp.close(); footerApp.game.state.plots.filter(p=>p.group==='crop').forEach(p => Object.assign(p,{crop:null,snapshot:null,boosted:false})); footerApp.game.state.coins = 1000; footerApp.refresh();
        });
        await tap('targets', 49); let d = await inspect(); geometry(d);
        const holdBefore=await state(),holdPoint=await position('controls','plant-1');
        const holdSession=touch?await context.newCDPSession(page):null;
        if(holdSession)await holdSession.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{...holdPoint,id:1}]});
        else{await page.mouse.move(holdPoint.x,holdPoint.y);await page.mouse.down();}
        await page.waitForTimeout(100);await page.keyboard.press('Escape');await page.waitForTimeout(600);
        if(holdSession){await holdSession.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});await holdSession.detach();}else await page.mouse.up();
        assert.deepEqual(errors,[],'Closing the seed picker cancels its pending long-press timer');
        assert.equal((await inspect()).box,null);assert.equal((await state()).coins,holdBefore.coins);assert.equal((await state()).plots.find(p=>p.id===49).crop,null);
        await tap('targets',49);d=await inspect();geometry(d);
        // Every seed of the group is reachable by scrolling; nothing is hidden behind a page button any more.
        assert.deepEqual(d.controls.filter(c => c.id.startsWith('plant-')).map(c => c.id), ['plant-1', 'plant-10', 'plant-11', 'plant-4', 'plant-3', 'plant-1128', 'plant-1129', 'plant-1010']);
        assert.ok(!d.controls.some(c => ['seed-next', 'close-cell'].includes(c.id)), 'no page or close button on the strip');
        assert.ok(d.targets.every(t => (1 - t.screen.y) * d.ui.height > 184), 'home view keeps every plot above footer');
        await page.screenshot({ path: path.join(out, name + '-seeds.png') });
        const button = await position('controls', 'plant-1'), preDrag = await state();
        await drag(button, { x: button.x + 20, y: button.y - 20 }); assert.equal((await state()).coins, preDrag.coins, 'dragging a choice does not plant');
        await tap('controls', 'plant-1'); const planted = await state(); d = await inspect();
        assert.equal(planted.coins, preDrag.coins - 20); assert.equal(planted.plots.find(p => p.id === 49).crop, 1); assert.equal(d.ui.selected, 49);
        assert.ok(await page.evaluate(() => footerApp.map.world.getComponentsInChildren(footerCc.Label).some(l => l.node.name === 'PlotFeedback' && l.string === '-20' && l.font instanceof footerCc.BitmapFont)), 'Unity-style seed cost feedback');
        // Planting hands the plot over to its own bubble: the footer closes and the navigation comes back.
        assert.equal(d.box, null, 'no footer over a growing plot'); assert.ok(d.navigation);
        const bubble = d.bubbles.find(b => b.id === 49);
        assert.equal(bubble.kind, 'growing'); assert.match(bubble.time, /^\d\d:\d\d$/); assert.equal(bubble.price, '2');
        assert.ok(d.controls.some(c => c.id === 'finish-49') && d.controls.some(c => c.id === 'cancel-49'));
        await page.screenshot({ path: path.join(out, name + '-growing.png') });
        const beforeTick = bubble;
        await page.evaluate(() => footerApp.game.tick(24)); await settle(); d = await inspect();
        assert.notEqual(d.bubbles.find(b => b.id === 49).time, beforeTick.time, 'the countdown runs down');
        await drag({ x: width * .5, y: height * .4 }, { x: width * .5 - 45, y: height * .4 + 15 });
        await page.setViewportSize({ width: height, height: width }); await page.waitForTimeout(650); d = await inspect(); assert.equal(d.ui.selected, 49);
        await page.setViewportSize({ width, height }); await page.waitForTimeout(650);
        await tap('controls', 'finish-49'); assert.equal((await state()).diamonds, planted.diamonds - 2);
        await page.waitForFunction(() => farmCocos.controls().some(c => c.id === 'harvest-49'), undefined, { timeout: 5000 });
        d = await inspect(); assert.equal(d.bubbles.find(b => b.id === 49).kind, 'ready');
        await page.screenshot({ path: path.join(out, name + '-ready.png') });
        const preHarvest = await state(); await tap('controls', 'harvest-49'); const harvested = await state();
        assert.equal(harvested.inventory['raw:1'], (preHarvest.inventory['raw:1'] || 0) + 3); assert.equal(harvested.plots.find(p => p.id === 49).crop, null);
        assert.equal(await page.evaluate(() => farmCocos.ui().selected), null); await tap('controls', 'pause-menu'); await tap('controls', 'home');
        await tap('targets', 0); await tap('controls', 'plant-10'); const preCancel = await state(); await tap('controls', 'cancel-0');
        assert.equal((await state()).plots[0].crop, null); assert.equal((await state()).coins, preCancel.coins + 3);
        // Digging the crop out closes the cell by itself, so the next tap goes straight to the resident pen.
        assert.equal(await page.evaluate(() => farmCocos.ui().selected), null); await tap('targets', 12);
        assert.equal(await page.evaluate(()=>farmCocos.ui().view),'');
        assert.equal(await page.evaluate(()=>farmCocos.ui().selected),12);
        for(const id of ['herd-feed','herd-collect','herd-manage'])assert.ok((await page.evaluate(()=>farmCocos.controls())).some(c=>c.id===id),'resident pen opens its map care bar: '+id);
        await tap('controls','herd-manage');
        assert.equal(await page.evaluate(()=>farmCocos.ui().view),'livestock');
        assert.ok(!(await page.evaluate(()=>farmCocos.controls())).some(c=>c.id.startsWith('plant-')||c.id.startsWith('species-')||c.id==='batch-mode'));
        await tap('controls','close-panel');
        const activeTargets=await page.evaluate(()=>farmCocos.targets());
        for(const id of [14,15])assert.ok(!activeTargets.some(t=>t.id===id),'unbuilt pen has no map input target: '+id);
        assert.ok(!activeTargets.some(t=>[16,17,18,19,20,21].includes(t.id)),'unconfigured legacy pens and ponds remain inactive');
        assert.ok(!(await page.evaluate(()=>farmCocos.controls())).some(c=>['unlock-14','unlock-15'].includes(c.id)),'future pen sites never expose obsolete crop-unlock bubbles');
        await page.evaluate(() => { footerApp.game.state.coins = 0; footerApp.game.state.diamonds = 0; });
        await tap('targets', 0); assert.ok((await inspect()).controls.filter(c => c.id.startsWith('plant-')).every(c => !c.enabled));
        await tap('controls', 'plant-1'); assert.equal((await state()).plots[0].crop, null);
        await page.evaluate(() => { footerApp.game.state.coins = 100; }); await settle(); await tap('controls', 'plant-1');
        assert.equal((await inspect()).controls.find(c => c.id === 'finish-0').enabled, false, 'no gems, no finishing');
        await tap('controls', 'pause-menu'); assert.equal(await page.evaluate(() => farmCocos.ui().selected), null); await tap('controls', 'resume');
        await tap('controls', 'inventory'); await tap('controls', 'close-panel');
        await tap('controls', 'factory'); await tap('controls', 'close-panel');
        // The free seed follows the same paused/input gate as paid seeds.
        await page.evaluate(() => {
          const a = footerApp, g = a.game; a.close(); g.state.coins = 0;
          for (const key of Object.keys(g.state.inventory)) g.state.inventory[key] = 0;
          for (const plot of g.state.plots) {
            Object.assign(plot, { crop: null, snapshot: null, started: 0, ready: 0, boosted: false });
            for (const animal of plot.residents?.animals ?? []) animal.job = null;
          }
          for (const machine of g.state.machines) { machine.job = null; machine.waiting = []; machine.tray = []; }
          g.validate(); a.focusHome(); a.refresh();
        });
        await tap('targets', 0);
        assert.equal((await inspect()).controls.find(c => c.id === 'rescue')?.enabled, true);
        await page.keyboard.press('Space'); await settle();
        assert.equal((await inspect()).controls.find(c => c.id === 'rescue')?.enabled, false, 'Paused free seed is disabled like paid seeds');
        const pausedRescue = await state(); await tap('controls', 'rescue'); assert.deepEqual(await state(), pausedRescue);
        await page.keyboard.press('Space'); await settle(); await tap('controls', 'rescue');
        assert.equal((await state()).plots.find(p => p.id === 0).crop, 1); assert.equal((await state()).coins, 0);
        assert.deepEqual(errors, []); results.push({ name, viewport: [width, height], footerAnchored: true, bubbles: true, planting: true, countdown: true, finishAndHarvest: true, cancelRefund: true, seedGroups: true, disabledActions: true, navigationRestored: true, rotation: true, gestures: true, seedHoldCancelledOnClose: true, errors });
        fs.writeFileSync(path.join(out, 'checks.json'), JSON.stringify(results, null, 2) + '\n'); console.log(name + ': seed footer, plot bubbles, countdown, finish/harvest, refund, input and navigation OK');
      } catch (e) { await page.screenshot({ path: path.join(out, name + '-failure.png') }); throw e; }
      finally { await context.close(); }
    }
  } finally { await browser.close(); await new Promise(r => server.close(r)); }
})().catch(e => { console.error(e); process.exitCode = 1; });
