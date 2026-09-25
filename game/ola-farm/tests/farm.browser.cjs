'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path'), http = require('node:http');
const { chromium } = require('playwright');
const build = process.env.COCOS_TEST_BUILD ? path.resolve(process.env.COCOS_TEST_BUILD) : path.resolve(__dirname, '../build/farm-web-mobile'), artifacts = path.resolve(__dirname, '../artifacts/cocos40');
const key = 'ola-farm-cocos-simple-v1', legacyKey = 'ola-farm-cocos-40-v1';
const types = { '.html':'text/html', '.js':'text/javascript', '.json':'application/json', '.png':'image/png', '.css':'text/css', '.wasm':'application/wasm' };
const server = http.createServer((req,res) => {
  if(req.url === '/favicon.ico') { res.writeHead(204).end(); return; }
  let file; try { file = path.resolve(build, '.' + decodeURIComponent(new URL(req.url,'http://localhost').pathname)); } catch { res.writeHead(400).end(); return; }
  if(file === build) file = path.join(build,'index.html');
  if(!file.startsWith(build+path.sep)||!fs.existsSync(file)||!fs.statSync(file).isFile()) {res.writeHead(404).end();return;}
  res.writeHead(200,{'Content-Type':types[path.extname(file)]||'application/octet-stream'});fs.createReadStream(file).pipe(res);
});
(async()=>{
  if(!fs.existsSync(path.join(build,'index.html')))throw Error('Build cocos/build-configs/farm-web-mobile.json first.');
  await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
  const browser=await chromium.launch({headless:true,...(process.env.PLAYWRIGHT_CHANNEL?{channel:process.env.PLAYWRIGHT_CHANNEL}:{})});
  fs.mkdirSync(artifacts,{recursive:true});
  try {
    for(const [name,viewport,touch] of [['desktop',{width:1280,height:720},false],['touch',{width:844,height:390},true],['portrait',{width:390,height:844},true]]) {
      if(process.env.COCOS_FARM_VIEWPORT&&!process.env.COCOS_FARM_VIEWPORT.split(',').includes(name))continue;
      const context=await browser.newContext({viewport,hasTouch:touch,isMobile:touch}),page=await context.newPage(),errors=[];
      await context.addInitScript(key=>{const next=sessionStorage.getItem('next-farm-fixture');if(next){localStorage.setItem(key,next);sessionStorage.removeItem('next-farm-fixture');}},key);
      page.on('pageerror',e=>errors.push(e.message));page.on('console',m=>{if(m.type()==='error')errors.push(m.text());});
      page.on('response',r=>{if(r.status()>=400)errors.push('HTTP '+r.status()+' '+r.url());});
      const state=()=>page.evaluate(()=>farmCocos.snapshot());
      async function tap(kind,id) {
        await page.waitForFunction(()=>!farmCocos.ui().animating);
        const target=await page.evaluate(([kind,id])=>{const t=farmCocos[kind]().find(t=>t.id===id);return kind==='targets'?t?.screen:t;},[kind,id]);
        assert.ok(target,kind+'/'+id);
        const box=await page.locator('#GameCanvas').boundingBox(),x=box.x+box.width*target.x,y=box.y+box.height*target.y;
        assert.ok(x>=0&&x<=viewport.width&&y>=0&&y<=viewport.height,`${id} outside viewport: ${x},${y}`);
        if(touch)await page.touchscreen.tap(x,y);else await page.mouse.click(x,y);
        await page.waitForTimeout(70);await page.waitForFunction(()=>!farmCocos.ui().animating);
      }
      try {
        await page.goto('http://127.0.0.1:'+server.address().port);
        // Hiding and showing the tab while assets still load must not throw; the session starts frozen or running accordingly.
        await page.waitForFunction(async()=>{try{await System.import('cc');return true;}catch{return false;}},undefined,{timeout:45000});
        await page.evaluate(async()=>{const cc=await System.import('cc');cc.game.emit(cc.Game.EVENT_HIDE);cc.game.emit(cc.Game.EVENT_SHOW);});
        await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:45000});
        await tap('controls','welcome-start');
        let s=await state(); assert.equal(s.plots.length,50);assert.equal(s.coins,500);
        assert.equal(s.plots.filter(p=>p.group==='crop'&&p.unlocked).length,40);
        assert.deepEqual(await page.evaluate(()=>({prefab:farmCocos.map().prefab,instances:farmCocos.map().cropInstances})),{prefab:'Farm',instances:40});
        assert.equal(await page.evaluate(()=>farmCocos.controls().some(c=>c.id==='city')),false);
        assert.deepEqual(await page.evaluate(()=>farmCocos.assets()),{files:201,townImages:417,townPrefabs:21,errors:[]});
        // Isolated layout fixture funds a full field; production starter coins remain 500.
        const fixture=await page.evaluate(()=>farmCocos.pack());fixture.free.coins=5000;
        for(const p of fixture.free.plots)if(p.group==='crop')Object.assign(p,{crop:null,snapshot:null,boosted:false});
        await page.evaluate(([legacy,fixture])=>{sessionStorage.setItem('next-farm-fixture',JSON.stringify(fixture));localStorage.setItem(legacy,'keep-original');},[legacyKey,fixture]);
        await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);
        await page.screenshot({path:path.join(artifacts,name+'-soil.png')});
        const crops=(await state()).plots.filter(p=>p.group==='crop');
        const selected=name==='desktop'?crops:[crops[12],crops[39]];
        for(const p of selected) {
          await tap('targets',p.id);assert.equal(await page.evaluate(()=>farmCocos.ui().selected),p.id);
          await tap('controls','plant-1');assert.equal((await state()).plots.find(x=>x.id===p.id).crop,1);
        }
        assert.equal((await state()).coins,5000-selected.length*20);
        await page.screenshot({path:path.join(artifacts,name+'-planted.png')});
        const last=crops[39].id;
        await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);
        assert.equal((await state()).plots.find(p=>p.id===last).crop,1);
        assert.equal(await page.evaluate(legacy=>localStorage.getItem(legacy),legacyKey),'keep-original');
        await tap('targets',last);
        // The bubble over the selected plot carries the gem button; it costs one gem per started minute of waiting.
        await tap('controls','finish-'+last);assert.equal((await state()).diamonds,8);
        await page.waitForFunction(id=>{const s=farmCocos.snapshot();return s.time>=s.plots.find(p=>p.id===id).ready;},last,{timeout:40000});
        const harvested=(await state()).harvested;
        await tap('targets',last);assert.equal((await state()).plots.find(p=>p.id===last).crop,null);assert.ok((await state()).harvested>harvested);
        const z=await page.evaluate(()=>farmCocos.map().zoom),coins=(await state()).coins;
        const x=viewport.width*.5,y=viewport.height*.45;
        if(touch) {
          const cdp=await context.newCDPSession(page);
          await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{x:x-20,y,id:1},{x:x+20,y,id:2}]});
          await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{x:x-32,y,id:1},{x:x+32,y,id:2}]});
          await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});await cdp.detach();
          assert.ok(await page.evaluate(z=>farmCocos.map().zoom>z,z));
        } else {await page.mouse.move(x,y);await page.mouse.down();await page.mouse.move(x-80,y+20,{steps:6});await page.mouse.up();}
        assert.equal((await state()).coins,coins);
        await tap('controls','pause-menu');await tap('controls','home');await tap('controls','factory');assert.equal(await page.evaluate(()=>farmCocos.ui().view),'factory');
        await tap('controls','close-panel');await tap('controls','inventory');
        assert.equal(await page.evaluate(()=>farmCocos.ui().view),'inventory');
        assert.equal(await page.evaluate(()=>farmCocos.controls().some(c=>['missions','tasks','city','staff','zoom-in','zoom-out','zoom-reset','camera-home','fullscreen','focus-crop','focus-pen','focus-pond'].includes(c.id))),false);
        assert.ok(await page.evaluate(()=>farmCocos.controls().some(c=>c.id==='shop')), 'The current HUD retains its Shop entry');
        await tap('controls','close-panel');
        await tap('controls','pause-menu');await tap('controls','plots');
        assert.equal(await page.evaluate(()=>farmCocos.controls().find(c=>c.id==='plot-0').enabled),true);
        await tap('controls','plot-0');
        assert.equal(await page.evaluate(()=>farmCocos.ui().paused),false);
        assert.equal(await page.evaluate(()=>farmCocos.ui().view),'');
        // Only an empty plot opens the footer; a growing one just keeps its bubble, so close it through the app.
        if(await page.evaluate(()=>farmCocos.ui().selected!==null)) {
          if(await page.evaluate(()=>farmCocos.controls().some(c=>c.id==='close-cell')))await tap('controls','close-cell');
          else await page.evaluate(async()=>{const cc=await System.import('cc');cc.director.getScene().getChildByName('Canvas').getComponent('GameApp').closeCell();});
        }
        // Plot-list rows use the same routing as map taps: a ripe bed is harvested, a resident pen opens the herd.
        if((await state()).plots.find(p=>p.id===0).crop===null){await tap('targets',0);await tap('controls','plant-1');}
        await page.evaluate(async()=>{const cc=await System.import('cc'),app=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp');app.game.tick(200);app.refresh();});
        const wheatBefore=(await state()).inventory['raw:1']??0;
        await tap('controls','pause-menu');await tap('controls','plots');await tap('controls','plot-0');
        assert.equal((await state()).plots.find(p=>p.id===0).crop,null,'plot list harvests a ripe bed');
        assert.equal((await state()).inventory['raw:1'],wheatBefore+3,'harvest from the list reaches the barn');
        assert.equal(await page.evaluate(()=>farmCocos.ui().selected),null);
        await page.evaluate(async()=>{const cc=await System.import('cc');cc.director.getScene().getChildByName('Canvas').getComponent('GameApp').tapPlot(12);});
        assert.equal(await page.evaluate(()=>farmCocos.ui().view),'','resident pens open the herd quickbar');
        await tap('controls','herd-manage');assert.equal(await page.evaluate(()=>farmCocos.ui().view),'livestock');await tap('controls','close-panel');
        await tap('controls','pause-menu');await tap('controls','home');
        // Full mature field fixture for the visual review, retained only in this test context.
        const full=await page.evaluate(()=>farmCocos.pack());
        full.free.time=200;
        full.free.plots.filter(p=>p.group==='crop').forEach((p,i)=>{const id=[1,3,4,10][i%4],f=require('../tools/load-farm-catalog.cjs').loadFarmCatalog().farm.find(f=>f.id===id);Object.assign(p,{crop:id,started:0,ready:100,boosted:false,snapshot:{output:{key:f.itemKey??'raw:'+id,quantity:f.yields[p.level-1]},harvestXP:3*f.yields[p.level-1],paidCoins:f.price,refundCoins:Math.floor(f.price*.3),duration:f.duration,rescue:false}});});
        await page.evaluate(full=>sessionStorage.setItem('next-farm-fixture',JSON.stringify(full)),full);
        await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);
        await page.screenshot({path:path.join(artifacts,name+'-full.png')});
        // Zooming out stops at the forest edge: the camera never leaves the authored map.
        // Scroll on open grass; the full mature field intentionally has interactive harvest bubbles.
        await page.mouse.move(viewport.width*.88,viewport.height*.42);
        // Each wheel event changes zoom one step, independent of its delta magnitude.
        for(let i=0;i<40;i++) {
          await page.mouse.wheel(0,120);await page.waitForTimeout(40);
          if(await page.evaluate(()=>Math.abs(farmCocos.map().zoom-farmCocos.map().minZoom)<1e-6))break;
        }
        const far=await page.evaluate(()=>farmCocos.map());assert.ok(far.minZoom>0,'portrait view needs a minimum zoom');
        if(!touch)assert.ok(Math.abs(far.zoom-far.minZoom)<1e-6,'wheel zoom clamps at minZoom');
        await page.screenshot({path:path.join(artifacts,name+'-overview.png')});
        if(name==='desktop') {
          await tap('controls','pause-menu');await tap('controls','help');
          for(let i=0;i<12;i++) {
            const {p,u}=await page.evaluate(()=>({p:farmCocos.controls().find(c=>c.id==='import'),u:farmCocos.ui()}));
            const panelHeight=Math.min(800,u.height-55),scale=u.viewport.height/u.height/u.canvas.height;
            const center=1-(u.viewport.y/u.canvas.height+(u.height/2-5)*scale),half=(panelHeight-195)*scale/2;
            if(p&&p.y>center-half+p.h*scale/2+0.01&&p.y<center+half-p.h*scale/2-0.01)break;
            await page.mouse.move(640,400);await page.mouse.wheel(0,150);await page.waitForTimeout(100);
          }
          const imported=await page.evaluate(()=>farmCocos.pack());
          imported.free.plots.filter(p=>p.cell===null).forEach(p=>p.id+=1000);
          const chooser=page.waitForEvent('filechooser');await tap('controls','import');
          await (await chooser).setFiles({name:'farm.json',mimeType:'application/json',buffer:Buffer.from(JSON.stringify(imported))});
          await page.waitForFunction(()=>farmCocos.snapshot().plots.some(p=>p.id===1049));
          assert.equal(await page.evaluate(()=>farmCocos.map().cropInstances),40);
          assert.equal(await page.evaluate(()=>farmCocos.targets().length),42, 'Only the two constructed yards have input targets');
          await tap('controls','pause-menu');await tap('controls','restart');await tap('controls','confirm');
          assert.equal((await state()).coins,500);assert.equal((await state()).plots.length,50);
          assert.equal(await page.evaluate(()=>farmCocos.map().cropInstances),40);
          assert.equal(await page.evaluate(legacy=>localStorage.getItem(legacy),legacyKey),'keep-original');
          await page.setViewportSize({width:390,height:844});
          await page.waitForFunction(()=>farmCocos.ui().width===720);
          assert.equal(await page.evaluate(()=>farmCocos.targets().length),42);
          assert.equal(await page.evaluate(()=>farmCocos.map().cropInstances),40);
        }
        assert.deepEqual(errors,[]);console.log(name+': 40 fields, prefab instances, plant/harvest, save, input and panels OK');
      } catch(error) {await page.screenshot({path:path.join(artifacts,name+'-failure.png')});throw error;}
      finally {await context.close();}
    }
  } finally {await browser.close();await new Promise(resolve=>{server.close(resolve);server.closeAllConnections?.();});}
})().catch(error=>{console.error(error);process.exitCode=1;server.close();});
