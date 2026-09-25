'use strict';
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {serve,launch,boot,tap,plot,site,state,observe}=require('./browser-support.cjs');
const out=path.resolve(__dirname,'../artifacts/economy-config');
const labels=page=>page.evaluate(()=>farmCocos.labels().map(l=>l.text));
const enabled=(page,id)=>page.evaluate(id=>farmCocos.controls().find(c=>c.id===id)?.enabled,id);
async function home(page){await page.evaluate(()=>{testApp.close();testApp.focusHome();});}
async function pen(page){await page.evaluate(()=>{testApp.close();testApp.map.focusBuilding('pen:12');});await plot(page,12,true);}
(async()=>{
 fs.mkdirSync(out,{recursive:true});const server=await serve(),browser=await launch(),reports=[];
 try{for(const viewport of [{width:390,height:844},{width:844,height:390},{width:1280,height:720}]){
  const context=await browser.newContext({viewport,hasTouch:true}),page=await context.newPage(),errors=observe(page);let replacements=0;
  await context.addInitScript(()=>{Date.now=()=>1900000000000;});
  await context.route('**/assets/farm-town/**/*.json',async route=>{
   const response=await route.fetch(),data=await response.json();
   function edit(v){if(!v||typeof v!=='object')return;
    if(v.version===1&&v.startingWallet&&v.fields&&v.machines?.bakery){
     v.startingWallet={coins:5000,diamonds:8,xp:0};v.experience.curve.baseXP=10;
     Object.assign(v.fields['1'],{initiallyUnlocked:false,unlockPrice:123,requiredLevel:2});
     v.machines.grill.sites[0]={price:333,requiredLevel:2};v.machines.bakery.queueSlots[0]={price:29,requiredLevel:2};
     v.animals.layer.purchasePrice=31;v.animals.layer.slots[0]={price:17,requiredLevel:2};
     v.pens['pen:50'].sitePrice=444;v.pens['pen:50'].requiredLevel=2;
     v.crops.wheat.seedPrice=7;v.items['raw:1'].sellPrice=4;replacements++;
    }else Object.values(v).forEach(edit);
   }edit(data);await route.fulfill({response,body:JSON.stringify(data)});
  });
  try{
   await boot(page,server.url);await tap(page,'welcome-start',true);assert.equal(replacements,1);
   let s=await state(page);assert.equal(s.coins,5000);assert.equal(s.diamonds,8);assert.equal(s.plots[1].unlocked,false);
   assert.ok((await labels(page)).includes('0/10'),'HUD uses the configured XP curve');
   await plot(page,1,true);assert.equal(await enabled(page,'confirm'),false);assert.ok((await labels(page)).some(t=>t.includes('123 xu')&&t.includes('level 2')));
   await tap(page,'cancel-confirm',true);await site(page,'bakery-1',true);
   assert.equal(await enabled(page,'expand-queue'),false);assert.ok((await labels(page)).includes('Lv 2'));assert.ok((await labels(page)).includes('29'));
   await pen(page);assert.equal(await enabled(page,'unlock-pen-slot-1'),false);assert.ok((await labels(page)).includes('Level 2'));
   // Threshold fixture sets only earned XP; prices, locks and purchases come from the edited JSON asset.
   await page.evaluate(()=>{testApp.close();testApp.game.state.xp=10;testApp.session.save();testApp.refresh();});
   await home(page);await plot(page,1,true);await tap(page,'confirm',true);
   s=await state(page);assert.equal(s.coins,4877);assert.equal(s.plots[1].unlocked,true);
   await plot(page,1,true);await tap(page,'plant-1',true);s=await state(page);assert.equal(s.coins,4870);assert.equal(s.plots[1].snapshot.paidCoins,7);
   await site(page,'bakery-1',true);await tap(page,'expand-queue',true);s=await state(page);assert.equal(s.coins,4841);assert.equal(s.machines[0].capacity,2);
   await pen(page);assert.ok((await labels(page)).includes('48'));await tap(page,'unlock-pen-slot-1',true);s=await state(page);assert.equal(s.coins,4793);assert.equal(s.plots[12].residents.capacity,2);
   await page.screenshot({path:path.join(out,`${viewport.width}-pen-slots.png`)});
   await page.evaluate(()=>{testApp.close();testApp.open('shop',{shopTab:'buildings',shopItem:'shop-machine-2'});});
   assert.ok((await labels(page)).includes('333'));await tap(page,'shop-machine-2',true);s=await state(page);assert.equal(s.coins,4460);assert.ok(s.machines.some(m=>m.type===2));
   await page.evaluate(()=>{testApp.close();testApp.open('shop',{shopTab:'animals',shopItem:'shop-animal-12'});});
   assert.ok((await labels(page)).includes('475'));await tap(page,'shop-animal-12',true);s=await state(page);assert.equal(s.coins,3985);assert.equal(s.plots[50].residents.animals.length,1);
   const saved=s;await page.reload();await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});s=await state(page);
   assert.equal(s.coins,saved.coins);assert.equal(s.plots[1].unlocked,true);assert.equal(s.plots[12].residents.capacity,2);assert.equal(s.machines[0].capacity,2);assert.ok(s.machines.some(m=>m.type===2));assert.equal(s.plots[50].residents.animals.length,1);
   assert.deepEqual(errors.errors,[]);reports.push({viewport,passed:true,landPrice:123,queuePrice:29,penSlotWithAnimal:48,machinePrice:333,secondPenWithAnimal:475,reloadPreserved:true});
  }catch(error){await page.screenshot({path:path.join(out,`${viewport.width}-failure.png`)});throw error;}finally{await context.close();}
 }}finally{await browser.close();await server.close();}
 fs.writeFileSync(path.join(out,'results.json'),JSON.stringify({passed:true,method:'Edited economy JsonAsset response; fixed clock and one XP threshold fixture; native land/seed/queue/pen/Shop purchases and reload.',reports},null,2)+'\n');console.log(JSON.stringify(reports));
})().catch(error=>{console.error(error);process.exitCode=1;});
