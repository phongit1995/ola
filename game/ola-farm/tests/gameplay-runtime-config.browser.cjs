'use strict';
const fs = require('node:fs'), path = require('node:path'), assert = require('node:assert/strict');
const { serve, launch, boot, tap, plot, site, state, observe } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/gameplay-runtime-config');
const enabled = (page,id) => page.evaluate(id => farmCocos.controls().find(c => c.id === id)?.enabled,id);
const labels = page => page.evaluate(() => farmCocos.labels().map(l => l.text));

(async () => {
  fs.mkdirSync(out,{ recursive:true });
  const server = await serve(), browser = await launch(), results = [];
  try {
    for (const viewport of [{width:390,height:844},{width:844,height:390},{width:1280,height:720}]) {
      const context = await browser.newContext({ viewport, hasTouch:true }), page = await context.newPage(), observed = observe(page);
      const replacements = { gameplay:0, runtime:0 };
      await context.addInitScript(() => { globalThis.testNow = 1900000000000; Date.now = () => globalThis.testNow; });
      await context.route('**/assets/farm-town/**/*.json', async route => {
        const response = await route.fetch(), data = await response.json();
        function edit(v) {
          if (!v || typeof v !== 'object') return;
          if (v.version === 1 && v.startingInventory && v.gates && v.animals?.layer) {
            v.showWelcome = false; v.startingInventory = { 'raw:1':10, 'farm40:chicken-feed':5 };
            Object.assign(v.animals.layer, { maxPens:1, maxCapacity:3, startingCapacity:2, startingAnimals:2, feedPerAnimal:2 });
            Object.assign(v.machines.bakery, { maxBuildings:1, maxQueueCapacity:3, startingCapacity:2, trayCapacity:1 });
            v.gates.crafts = { mode:'all', requirements:[{ items:['goods:7'], quantity:1, label:'nhận bánh mì' }] };
            replacements.gameplay++;
          } else if (v.version === 1 && v.session && v.input && v.camera) {
            v.session.maxOfflineSeconds = 700; v.session.autosaveSeconds = 9;
            v.audio.musicVolume = .08; v.audio.effectVolume = .12;
            v.ui.toastSeconds = 1.2; v.ui.refreshSeconds = .1; v.ui.motionEnabled = false;
            v.input.longPressSeconds = .9; v.input.buttonDragSlop = 18; v.input.wheelZoomStep = 1.2;
            v.camera.maxZoom = 6; v.camera.maxDisplayScale = 1.7; v.assets.loadConcurrency = 3;
            replacements.runtime++;
          } else Object.values(v).forEach(edit);
        }
        edit(data); await route.fulfill({ response, body:JSON.stringify(data) });
      });
      try {
        await boot(page,server.url); assert.deepEqual(replacements,{gameplay:1,runtime:1});
        let s = await state(page);
        assert.equal(s.guideDismissed,true); assert.equal(s.machines[0].capacity,2);
        assert.equal(s.plots[12].residents.capacity,2); assert.equal(s.plots[12].residents.animals.length,2);
        const presentation = await page.evaluate(() => ({ motion:testApp.motion, music:testApp.audio.music.volume,
          effects:testApp.audio.effects.volume, zoom:testApp.map.camera.maxZoom, scale:testApp.map.camera.scale,
          runtime:testApp.game.catalog.runtime }));
        assert.equal(presentation.motion,false); assert.equal(presentation.music,.08); assert.equal(presentation.effects,.12);
        assert.equal(presentation.zoom,Math.max(6,1.7/presentation.scale));
        assert.equal(presentation.runtime.assets.loadConcurrency,3);
        await page.evaluate(() => testApp.open('help'));
        assert.ok((await labels(page)).some(t=>t.includes('Công việc tiếp tục tối đa 11:40 mỗi lần vắng mặt.')));
        await page.evaluate(() => testApp.close());
        assert.equal(await page.evaluate(() => testApp.game.machineUnlockStatus(1021).unlocked),false);
        await plot(page,0,true); await tap(page,'plant-1',true);
        await site(page,'bakery-1',true);
        assert.equal(await page.evaluate(() => testApp.ui.controls.get('produce-7').getComponent('FarmButton').dragSlop),18);
        assert.equal(await page.evaluate(() => testApp.panels.node.getComponentInChildren('FactoryBodyView').queue.children.filter(n=>n.active).length),3);
        await tap(page,'produce-7',true); await tap(page,'produce-7',true);
        await page.evaluate(() => { testApp.close(); testApp.map.focusBuilding('pen:12'); });
        await plot(page,12,true);
        assert.equal(await page.evaluate(() => testApp.panels.node.getComponentInChildren('LivestockBodyView').scroll.content.children.filter(n=>n.active).length),3);
        assert.ok((await labels(page)).some(t=>t.includes('4 phần cám')));
        const firstAnimal = s.plots[12].residents.animals[0].id;
        await tap(page,'animal-'+firstAnimal,true); assert.equal((await state(page)).inventory['farm40:chicken-feed'],3);
        await tap(page,'feed-all',true); assert.equal((await state(page)).inventory['farm40:chicken-feed'],1);
        await page.evaluate(() => { testApp.close(); testApp.open('shop',{shopTab:'animals',shopItem:'shop-animal-12'}); });
        assert.equal(await enabled(page,'shop-animal-12'),false); assert.ok((await labels(page)).includes('Đã đủ 1 nhà'));
        await page.evaluate(() => { testApp.close(); testApp.session.suspend(); globalThis.testNow += 3600000; testApp.session.resume(); });
        s = await state(page); assert.equal(s.time,700); assert.equal(s.machines[0].tray.length,1);
        assert.equal(s.machines[0].waiting.length,1); assert.equal(s.machines[0].job,null);
        await site(page,'bakery-1',true); assert.ok((await labels(page)).includes('Khay đã đầy'));
        await tap(page,'collect-0',true); assert.equal(await page.evaluate(()=>testApp.game.machineUnlockStatus(1021).unlocked),true);
        assert.equal((await state(page)).machines[0].job.started,700);
        await page.evaluate(() => testApp.toast('Kiểm tra thời gian thông báo'));
        assert.equal(await page.evaluate(()=>testApp.toastView.visible),true);
        await page.waitForTimeout(1500); assert.equal(await page.evaluate(()=>testApp.toastView.visible),false);
        const before = await state(page); await boot(page,server.url);
        assert.deepEqual(await state(page),before); assert.equal((await state(page)).time,700);
        assert.deepEqual(observed.errors,[]);
        await page.screenshot({path:path.join(out,`${viewport.width}-configured.png`)});
        results.push({ viewport, passed:true, configuredHerd:2, feedPerAnimal:2, visiblePenSlots:3, visibleQueueSlots:3, trayCapacity:1, offlineCap:700, reloadPreserved:true });
      } catch (error) { await page.screenshot({path:path.join(out,`${viewport.width}-failure.png`)}); throw error; }
      finally { await context.close(); }
    }
    fs.writeFileSync(path.join(out,'results.json'),JSON.stringify({passed:true,method:'Edited actual gameplay/runtime JSON asset responses; all stock comes from configured startup; native planting, production, feeding, collection, gate unlock, toast timing and save reload.',results},null,2)+'\n');
    console.log(JSON.stringify(results));
  } finally { await browser.close(); await server.close(); }
})().catch(error=>{console.error(error);process.exitCode=1;});
