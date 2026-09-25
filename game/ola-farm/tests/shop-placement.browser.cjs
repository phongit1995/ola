'use strict';
// Seed only purchase access/resources; moving into empty shop ground and buying the machine
// use real touch input. The final pack is checked again after a normal browser reload.
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, observe, build } = require('./browser-support.cjs');
const unregisterTsx = require('tsx/cjs/api').register();
const { buildingPosition, checkLayout, movedLayout, snapPosition } = require('../assets/farm/scripts/core/BuildingPlacement.ts');
// The geometry imports are synchronous; keep their temporary TypeScript loader scoped
// to those imports and release its service before starting the browser.
unregisterTsx(); require('esbuild').stop();
const out = process.env.COCOS_SHOP_PLACEMENT_OUT ? path.resolve(process.env.COCOS_SHOP_PLACEMENT_OUT) : path.resolve(__dirname, '../artifacts/shop-placement');
const key = 'industry-loom';
const assets = state => ({
  inventory: state.inventory, nextId: state.nextId, planted: state.planted,
  plots: state.plots.map(p => ({ id:p.id, cell:p.cell, crop:p.crop, started:p.started, ready:p.ready, residents:p.residents })),
  machineIds: state.machines.map(m => [m.id, m.type, m.buildingId]),
});

(async () => {
  fs.mkdirSync(out, { recursive:true });
  const server = await serve(), browser = await launch(), results = [];
  const save = detail => fs.writeFileSync(path.join(out, 'validation.json'), JSON.stringify({ build, results, ...detail }, null, 2) + '\n');
  try {
    for (const [width,height] of [[390,844],[844,390]]) {
      const context = await browser.newContext({ viewport:{width,height}, hasTouch:true, isMobile:true });
      const page = await context.newPage(), observed = observe(page), cdp = await context.newCDPSession(page);
      try {
        await boot(page, server.url);
        const before = await page.evaluate(() => {
          const a=testApp,g=a.game;g.dismissGuide();a.close();
          g.state.coins=20000;g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};
          for(const item of g.items)g.state.inventory[item.key]=100;
          for(const result of [g.plant(0,g.catalog.farm[0].id),g.feedAnimals(12)])if(result.error)throw Error(result.error);
          g.validate();a.save();a.refresh();a.focusHome();return farmCocos.pack().free;
        });
        const destination = snapPosition(buildingPosition(key, before.buildingLayout));
        assert.equal(checkLayout(movedLayout(before.buildingLayout,'barn',destination),before).error,null,'the former ghost site is free ground');
        assert.ok(checkLayout(movedLayout(before.buildingLayout,'barn',destination)).error,'the same spot would have been blocked by the former hidden reservation');
        const hidden = await page.evaluate(key => ({model:testApp.map.town.buildings.has(key),target:testApp.map.buildingTargets().some(b=>b.buildingId===key),focus:testApp.map.focusBuilding(key)}),key);
        assert.deepEqual(hidden,{model:false,target:false,focus:false});
        const points = await page.evaluate(destination => {
          const m=testApp.map,c=m.camera,target=m.buildingTargets().find(b=>b.buildingId==='barn'),origin=m.movement.position('barn');
          const from={x:target.x,y:target.y},to={x:target.x+destination.x-origin.x,y:target.y+destination.y-origin.y};
          const scale=Math.min(1.1,m.width*.7/(Math.abs(to.x-from.x)+240),(m.height-m.inset.top-m.inset.bottom)*.7/(Math.abs(to.y-from.y)+240));
          c.lookAt((from.x+to.x)/2,(from.y+to.y)/2,scale/c.scale,'manual',(m.inset.bottom-m.inset.top)/2);m.update();return{from,to};
        }, destination);
        await page.waitForTimeout(100);
        const pixel = async p => {
          const q=await page.evaluate(p=>{const cc=testCc,m=testApp.map,q=m.world.getComponent(cc.UITransform).convertToWorldSpaceAR(new cc.Vec3(p.x,p.y)),v=cc.view.getViewportRect(),s=cc.view.getCanvasSize();return{x:(v.x+q.x*cc.view.getScaleX())/s.width,y:1-(v.y+q.y*cc.view.getScaleY())/s.height};},p);
          const b=await page.locator('#GameCanvas').boundingBox();assert.ok(q.x>.03&&q.x<.97&&q.y>.1&&q.y<.85,'real drag endpoint fits playable canvas');return{x:b.x+q.x*b.width,y:b.y+q.y*b.height,id:1};
        };
        const from=await pixel(points.from),to=await pixel(points.to);
        await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[from]});
        await page.waitForFunction(()=>farmCocos.map().movement.selected==='barn');
        for(let i=1;i<=8;i++)await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{x:from.x+(to.x-from.x)*i/8,y:from.y+(to.y-from.y)*i/8,id:1}]});
        const draft=await page.evaluate(()=>farmCocos.map().movement);
        assert.deepEqual(draft.candidate,destination);assert.equal(draft.error,null);assert.equal(draft.canPlace,true);
        await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});
        await page.waitForFunction(p=>!farmCocos.map().movement.active&&farmCocos.snapshot().buildingLayout.positions.barn?.x===p.x&&farmCocos.snapshot().buildingLayout.positions.barn?.y===p.y,destination);
        const moved=await page.evaluate(()=>farmCocos.pack().free);assert.equal(moved.coins,before.coins);assert.deepEqual(assets(moved),assets(before));
        assert.deepEqual(buildingPosition(key,moved.buildingLayout),buildingPosition(key,before.buildingLayout),'unused saved preference is retained until purchase');
        await page.screenshot({path:path.join(out,`barn-on-former-site-${width}x${height}.png`)});
        const purchase=await page.evaluate(key=>{const g=testApp.game,t=g.machineTypes.find(t=>t.buildingIds.includes(key));return{type:t.id,price:g.machinePurchasePrice(t.id)};},key);
        await tap(page,'shop',true);await tap(page,'shop-tab-buildings',true);await tap(page,'shop-machine-'+purchase.type,true);
        await page.waitForFunction(key=>farmCocos.ui().view===''&&testApp.map.town.buildings.has(key),key);await page.waitForTimeout(120);
        const bought=await page.evaluate(()=>{testApp.game.validate();testApp.save();return farmCocos.pack().free;});
        const placed=buildingPosition(key,bought.buildingLayout);
        assert.notDeepEqual(placed,buildingPosition(key,before.buildingLayout));assert.deepEqual(placed,snapPosition(placed));
        assert.deepEqual(buildingPosition('barn',bought.buildingLayout),destination);assert.equal(checkLayout(bought.buildingLayout,bought).error,null);
        assert.equal(bought.coins,before.coins-purchase.price);assert.deepEqual(assets({...bought,machines:bought.machines.filter(m=>m.buildingId!==key)}),assets(before));
        assert.equal(bought.machines.filter(m=>m.buildingId===key).length,1);
        await page.screenshot({path:path.join(out,`shop-placed-loom-${width}x${height}.png`)});
        await boot(page,server.url);await page.evaluate(key=>{testApp.close();testApp.map.focusBuilding(key);testApp.refresh();},key);await page.waitForTimeout(120);
        const reloaded=await page.evaluate(key=>({state:farmCocos.pack().free,position:testApp.map.movement.position(key),visible:testApp.map.town.buildings.get(key)?.node.activeInHierarchy,target:testApp.map.buildingTargets().some(b=>b.buildingId===key)}),key);
        assert.deepEqual(reloaded.state.buildingLayout,bought.buildingLayout);assert.equal(reloaded.state.coins,bought.coins);assert.deepEqual(assets(reloaded.state),assets(bought));
        assert.deepEqual(reloaded.position,placed);assert.equal(reloaded.visible,true);assert.equal(reloaded.target,true);assert.deepEqual(observed.errors,[]);
        results.push({width,height,hidden,destination,placed,price:purchase.price,realDrag:true,realShopPurchase:true,saveReload:true,errors:[]});save({passed:false,status:'running'});
        console.log(`${width}x${height}: real barn drag into former site, automatic Shop placement, exact charge and reload passed`);
      } catch(error) {
        await page.screenshot({path:path.join(out,`failure-${width}x${height}.png`)});save({passed:false,error:String(error),errors:observed.errors});throw error;
      } finally {await context.close();}
    }
    save({passed:true,viewports:results.length});
  } finally {await browser.close();await server.close();const p=path.join(out,'validation.json');if(fs.existsSync(p)){const r=JSON.parse(fs.readFileSync(p));r.cleanupComplete=true;fs.writeFileSync(p,JSON.stringify(r,null,2)+'\n');}}
})().catch(error=>{console.error(error);process.exitCode=1;});
