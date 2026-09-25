'use strict';
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {serve,launch,boot,tap,plot,state,observe}=require('./browser-support.cjs');
const catalog=require('../tools/load-farm-catalog.cjs').loadFarmCatalog();
const out=process.env.COCOS_PROFILE_OUT?path.resolve(process.env.COCOS_PROFILE_OUT):path.resolve(__dirname,'../artifacts/simple-farm'),key='ola-farm-cocos-simple-v1',oldKey='ola-farm-cocos-40-v1';
(async()=>{
 fs.mkdirSync(out,{recursive:true});const server=await serve(),browser=await launch(),results=[];
 try{
  for(const [width,height,touch] of (process.env.COCOS_PROFILE_CASE==='recovery'?[]:[[320,568,true],[390,844,true],[844,390,true],[768,1024,true],[1440,900,false]])){
   const context=await browser.newContext({viewport:{width,height},hasTouch:touch,isMobile:touch}),page=await context.newPage(),observed=observe(page),click=id=>tap(page,id,touch);
   try{
    await boot(page,server.url);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'welcome');await click('welcome-start');
    assert.equal(await page.evaluate(()=>farmCocos.targets().length),42);assert.equal(await page.evaluate(()=>farmCocos.buildings().length),5);
    const initial=await state(page);assert.equal(initial.coins,500);assert.equal(initial.machines.length,3);assert.equal(initial.plots.filter(p=>p.residents).length,2);
    // The seed footer is one scrollable strip now, so every crop is listed at once and there is no page or close button.
    await plot(page,0,touch);const crops=await page.evaluate(()=>farmCocos.controls().filter(c=>c.id.startsWith('plant-')).map(c=>Number(c.id.slice(6))));assert.deepEqual([...new Set(crops)].sort((a,b)=>a-b),catalog.farm.map(f=>f.id).sort((a,b)=>a-b));await page.evaluate(()=>testApp.closeCell());
    await click('inventory');for(const [tab,count] of [['raw',12],['goods',23]]){await click('tab-'+tab);assert.equal(await page.evaluate(()=>farmCocos.controls().filter(c=>c.id.startsWith('stock-')).length),count);}
    await page.screenshot({path:path.join(out,`scope-stock-${width}x${height}.png`)});await click('close-panel');await click('factory');
    // Production lists three built machines; Shop keeps all eight cards, with owned counts and five unbuilt offers.
    if(await page.evaluate(()=>farmCocos.ui().view==='factory'))await click('all-buildings');
    assert.equal(await page.evaluate(()=>farmCocos.controls().filter(c=>c.id.startsWith('building-type-')).length),3);
    for(const t of catalog.machineTypes.filter(t=>initial.machines.some(m=>m.type===t.id))){await click('building-type-'+t.id);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'factory');await click('all-buildings');}
    await click('open-building-shop');assert.equal(await page.evaluate(()=>farmCocos.ui().view),'shop');
    assert.equal(await page.evaluate(()=>farmCocos.controls().filter(c=>c.id.startsWith('shop-machine-')).length),8);
    const shopOwnership=await page.evaluate(()=>testApp.game.machineTypes.map(type=>{
     const action=testApp.ui.controls.get('shop-machine-'+type.id),view=action.parent.getComponent('ShopCardView');
     return {type:type.id,owned:testApp.game.state.machines.some(m=>m.type===type.id),quantity:view.quantity.string,label:view.priceLabel.string,enabled:testCc.Button&&action.getComponent(testCc.Button).interactable};
    }));
    assert.equal(shopOwnership.filter(c=>c.owned).length,3);assert.equal(shopOwnership.filter(c=>!c.owned).length,5);
    for(const card of shopOwnership){assert.equal(card.quantity,card.owned?'1/1':'0/1');if(card.owned){assert.equal(card.label,'Đã xây');assert.equal(card.enabled,false);}}
    const ownedTarget=await page.evaluate(()=>farmCocos.controls().find(c=>c.id==='shop-machine-5')),shopCanvas=await page.locator('#GameCanvas').boundingBox();
    assert.equal(ownedTarget.enabled,false);assert.ok(ownedTarget.x>0&&ownedTarget.x<1&&ownedTarget.y>0&&ownedTarget.y<1);
    if(touch)await page.touchscreen.tap(shopCanvas.x+shopCanvas.width*ownedTarget.x,shopCanvas.y+shopCanvas.height*ownedTarget.y);else await page.mouse.click(shopCanvas.x+shopCanvas.width*ownedTarget.x,shopCanvas.y+shopCanvas.height*ownedTarget.y);
    await page.waitForTimeout(90);assert.equal((await state(page)).coins,500);assert.deepEqual((await state(page)).machines,initial.machines);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'shop');
    assert.equal(await page.evaluate(()=>farmCocos.controls().find(c=>c.id==='shop-machine-1021').enabled),false);assert.ok(await page.evaluate(()=>farmCocos.labels().some(l=>l.text.includes('Nhận burger'))));await click('shop-dismiss');await click('factory');await click('all-buildings');
    // Missing wheat, egg and sugar show real sources including the unowned sugar machine.
    await click('building-type-1');await click('choose-recipe');await click('select-recipe-100207');await click('produce-100207');assert.equal(await page.evaluate(()=>farmCocos.ui().view),'ingredients');
    const labels=await page.evaluate(()=>farmCocos.labels().map(l=>l.text));assert.ok(labels.some(t=>t.includes('Đến ruộng · Lúa mì')));assert.ok(labels.some(t=>t.includes('Gà đẻ trứng')));assert.ok(labels.some(t=>t.includes('Chưa mua · 350 xu')));
    const sources=await page.evaluate(()=>farmCocos.controls().filter(c=>c.id.startsWith('ingredient-source-')).map(c=>c.id));
    await click(sources[2]);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'shop');assert.ok(await page.evaluate(()=>farmCocos.labels().some(l=>l.text === 'Máy đường')));
    await page.screenshot({path:path.join(out,`scope-machine-${width}x${height}.png`)});await click('shop-dismiss');
    assert.ok(await page.evaluate(()=>farmCocos.controls().every(c=>!['orders','quests','level'].includes(c.id))));
    assert.deepEqual((await state(page)).inventory,{});assert.equal((await state(page)).coins,500);
    await click('factory');await click('expand-queue');assert.equal((await state(page)).coins,440);assert.equal((await state(page)).machines[0].capacity,2);await click('close-panel');await click('pause-menu');await click('home');await plot(page,12,touch);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'');await click('herd-manage');await click('unlock-pen-slot-1');assert.equal((await state(page)).coins,315,'45 xu for the slot plus80 xu for its chicken are debited together');assert.equal((await state(page)).plots[12].residents.animals.length,2);await click('close-panel');
    await page.reload();await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});const restored=await state(page);assert.equal(restored.coins,315);assert.equal(restored.machines[0].capacity,2);assert.equal(restored.plots[12].residents.capacity,2);assert.equal(restored.plots[12].residents.animals.length,2);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'');
    assert.ok(observed.requests.every(u=>!u.includes('farm-town-industries')&&!u.includes('farm-town-agriculture')));assert.deepEqual(observed.errors,[]);
    results.push({width,height,touch,passed:true,crops:8,items:35,machines:8,livestock:4,starterAnimals:2,shopOwnership,ownedShopPurchaseBlocked:true,lockedLoom:true,ingredientLinks:true,queueAndPenPurchases:true,reload:true,errors:observed.errors});console.log(`${width}x${height}: scope, catalog, stock and ingredient links passed`);
   }catch(e){await page.screenshot({path:path.join(out,`scope-failure-${width}.png`)});throw e;}finally{await context.close();}
  }
  const context=await browser.newContext({viewport:{width:390,height:844},hasTouch:true}),page=await context.newPage(),observed=observe(page);
  await context.addInitScript(([key,oldKey])=>{
   localStorage.setItem(oldKey,'old full farm bytes\n');localStorage.setItem(oldKey+'.backup','old full backup bytes\n');
   globalThis.blockSave=true;globalThis.blockPlantSave=false;const write=Storage.prototype.setItem;Storage.prototype.setItem=function(k,v){if(k===key&&(globalThis.blockSave||globalThis.blockPlantSave&&JSON.parse(v).free?.plots?.[0]?.crop===1))throw new DOMException('Test quota exceeded','QuotaExceededError');return write.call(this,k,v);};
  },[key,oldKey]);
  try{
   await boot(page,server.url);assert.equal(await page.evaluate(()=>farmCocos.ui().storageFailed),true);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'help');assert.equal(await page.evaluate(key=>localStorage.getItem(key),key),null);
   const click=id=>tap(page,id,true);const download=page.waitForEvent('download');await click('export-legacy');const file=await download;assert.equal(fs.readFileSync(await file.path(),'utf8'),'old full farm bytes\n');
   await page.evaluate(()=>globalThis.blockSave=false);await click('retry-save');assert.equal(await page.evaluate(()=>farmCocos.ui().storageFailed),false);assert.equal((await state(page)).coins,500);await click('close-panel');
   // Fail the planting transaction itself; an earlier autosave must not consume this fault.
   await plot(page,0,true);await page.evaluate(()=>globalThis.blockPlantSave=true);await click('plant-1');assert.equal((await state(page)).coins,500);assert.equal((await state(page)).plots[0].crop,null);assert.equal(await page.evaluate(()=>farmCocos.ui().storageFailed),true);
   assert.deepEqual(await page.evaluate(()=>({coins:testApp.session.pendingPack.free.coins,crop:testApp.session.pendingPack.free.plots[0].crop})),{coins:480,crop:1});
   await page.keyboard.press('Escape');await click('pause-menu');await click('help');await page.evaluate(()=>{globalThis.blockSave=false;globalThis.blockPlantSave=false;});await click('retry-save');assert.equal((await state(page)).coins,480);assert.equal((await state(page)).plots[0].crop,1);await click('retry-save');assert.equal((await state(page)).coins,480);
   // Import through the real browser file chooser; wrong profiles may not replace any saved bytes.
   await page.evaluate(()=>{testApp.paused=true;testApp.save();testApp.save();});const before=await page.evaluate(()=>({...localStorage}));const chooser=page.waitForEvent('filechooser');await click('import');await (await chooser).setFiles({name:'old-farm.json',mimeType:'application/json',buffer:Buffer.from(JSON.stringify({version:3,current:'free',free:{version:4},settings:{speed:1,sound:false}}))});await page.waitForTimeout(100);
   assert.deepEqual(await page.evaluate(()=>({...localStorage})),before);assert.ok(await page.evaluate(()=>farmCocos.labels().some(l=>l.text.includes('Không thể nhập'))));
   assert.deepEqual(await page.evaluate(oldKey=>[localStorage.getItem(oldKey),localStorage.getItem(oldKey+'.backup')],oldKey),['old full farm bytes\n','old full backup bytes\n']);
   const pack=await page.evaluate(()=>farmCocos.pack());await page.evaluate(([key,pack])=>{globalThis.blockSave=false;localStorage.setItem(key,JSON.stringify(pack));},[key,pack]);
   // Hide/show and speed settings use actual app lifecycle, without assigning simulated time.
   await click('close-panel');if(await page.evaluate(()=>farmCocos.ui().paused))await page.keyboard.press('Space');assert.equal(await page.evaluate(()=>farmCocos.ui().paused),false);
   const rateChecks=[];for(const speed of [1,6,12]){await click('pause-menu');await click('speed-'+speed);await click('resume');assert.equal(await page.evaluate(()=>farmCocos.ui().speed),speed);assert.equal(await page.evaluate(()=>farmCocos.ui().paused),false);const start=await page.evaluate(()=>({time:farmCocos.snapshot().time,wall:performance.now()}));await page.waitForTimeout(1000);const end=await page.evaluate(()=>({time:farmCocos.snapshot().time,wall:performance.now()})),rate=(end.time-start.time)/((end.wall-start.wall)/1000);assert.ok(Math.abs(rate-speed)<speed*.35,`speed ${speed}: observed ${rate}`);rateChecks.push({speed,observedRate:rate});}
   await page.evaluate(()=>testApp.onHide());const hidden=(await state(page)).time;await page.waitForTimeout(1200);assert.equal((await state(page)).time,hidden);const wake=await page.evaluate(()=>{const before=testApp.game.state.time;testApp.onShow();testApp.update(1000);return [before,testApp.game.state.time];});assert.equal(wake[0],wake[1]);await page.waitForTimeout(750);assert.ok((await state(page)).time>hidden+3,'simulation resumes after showing the running game');
   assert.deepEqual(observed.errors,[]);results.push({recovery:true,startupQuota:true,transactionQuota:true,retryExactlyOnce:true,oldExportUnchanged:true,wrongProfileImportPreservesBytes:true,speeds:[1,6,12],measuredRates:rateChecks,wasRunningBeforeHide:true,resumesAfterShow:true,noOfflineTime:true,passed:true});
   console.log('Save failure, retry, preserved old bytes, rejected import and hide/show passed');
  }finally{await context.close();}
  fs.writeFileSync(path.join(out,process.env.COCOS_PROFILE_CASE==='recovery'?'recovery-checks.json':'profile-checks.json'),JSON.stringify({passed:true,results},null,2)+'\n');
 }finally{await browser.close();await server.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
