'use strict';
// Fresh playthrough: gameplay changes only through UI, real timers at the built-in 12x speed.
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {serve,launch,boot,tap,plot,site,state,observe}=require('./browser-support.cjs');
const catalog=require('../tools/load-farm-catalog.cjs').loadFarmCatalog(),out=path.resolve(__dirname,'../artifacts/simple-farm');
const inputs=r=>r.ingredients.map(i=>({key:i.key??'raw:'+i.id,quantity:i.quantity})),outputs=r=>r.outputs??[{key:'goods:'+r.id,quantity:1}],cropKey=f=>f.itemKey??'raw:'+f.id;
(async()=>{
 fs.mkdirSync(out,{recursive:true});const server=await serve(),browser=await launch(),context=await browser.newContext({viewport:{width:390,height:844},hasTouch:true,isMobile:true});
 const old='{"version":3,"marker":"keep-full-farm-source"}\n',oldBackup='full-backup-bytes';
 await context.addInitScript(([old,backup])=>{if(!sessionStorage.getItem('seeded-old-save')){localStorage.setItem('happy-farm-cocos-40-v1',old);localStorage.setItem('happy-farm-cocos-40-v1.backup',backup);sessionStorage.setItem('seeded-old-save','1');}},[old,oldBackup]);
 const page=await context.newPage(),observed=observe(page),steps=[],seen=new Set(),grown=new Set(),raised=new Set();const started=performance.now();
 const snap=()=>state(page),qty=async key=>(await snap()).inventory[key]??0;
 const click=id=>tap(page,id,true);
 const close=()=>page.evaluate(()=>testApp.close());
 function log(action,extra={}){steps.push({action,...extra,elapsedSeconds:(performance.now()-started)/1000});fs.writeFileSync(path.join(out,'starter-progress.json'),JSON.stringify({status:'running',steps},null,2));console.log(action,JSON.stringify(extra));}
 async function home(){await close();await click('pause-menu');await click('home');}
 async function openPen(id){await close();await page.evaluate(id=>testApp.focusBuilding('pen:'+id),id);await page.waitForTimeout(80);await plot(page,id,true);}
 async function sell(key,count=1){await close();await click('inventory');const item=catalog.items.find(i=>i.key===key);await click('tab-'+item.tab);await click('stock-'+key);for(let n=1;n<count;n++)await click('sale-plus');await click('sale-confirm');}
 // The seed strip scrolls sideways, so bring the wanted tile into the viewport before tapping it.
 const reveal=async id=>{await page.evaluate(id=>{const footer=testApp.root.getChildByName('CellMenu').getChildByName('PlotFooter');if(!footer)return;const strip=footer.getChildByName('SeedStrip'),content=strip.getChildByName('Viewport').getChildByName('Content'),tile=content.getChildByName('plant-'+id);if(!tile)return;const view=strip.getComponent(testCc.UITransform).width,full=content.getComponent(testCc.UITransform).width;strip.getComponent(testCc.ScrollView).scrollToOffset(new testCc.Vec2(Math.max(0,Math.min(full-view,tile.position.x-view/2)),0),0);},id);await page.waitForTimeout(120);};
 async function grow(f){await fund(f.price);await home();await plot(page,0,true);await reveal(f.id);await click('plant-'+f.id);assert.equal((await snap()).plots[0].crop,f.id);await page.waitForFunction(()=>{const s=farmCocos.snapshot(),p=s.plots[0];return p.crop!==null&&p.ready<=s.time;},undefined,{timeout:f.duration/12*1000+20000});await click('harvest-0');grown.add(f.id);}
 async function produce(r){await unlock(r.unlock);await buyMachine(r.machine);const s=await snap(),m=s.machines.find(m=>m.type===r.machine),t=catalog.machineTypes.find(t=>t.id===r.machine);assert.ok(m,'owned machine '+r.machine);await site(page,t.buildingIds[0],true);if(await page.evaluate(()=>farmCocos.ui().view==='industry'))await click('purchase-industry');if(await page.evaluate(()=>testApp.panels.selectedRecipeId)!==r.id){await click('choose-recipe');await click('select-recipe-'+r.id);}await click('produce-'+r.id);
  assert.ok((await snap()).machines.find(n=>n.id===m.id).job?.product===r.id,'started '+r.name);
  await page.waitForFunction(([id,product])=>farmCocos.snapshot().machines.find(m=>m.id===id).tray.some(t=>t.product===product),[m.id,r.id],{timeout:r.duration/12*1000+20000});await click('collect-'+m.id);seen.add(r.id);
 }
 async function fund(price){let guard=0;while((await snap()).coins<price+20){assert.ok(++guard<100);if(await qty('raw:1')<2){assert.ok((await snap()).coins>=20);await home();await plot(page,0,true);await reveal(1);await click('plant-1');await page.waitForFunction(()=>{const s=farmCocos.snapshot();return s.plots[0].ready<=s.time;},undefined,{timeout:30000});await click('harvest-0');grown.add(1);}await produce(catalog.products.find(r=>r.id===7));await sell('goods:7');log('earn-bread',{coins:(await snap()).coins});}}
 async function prepare(r,depth=0){await unlock(r.unlock);await buyMachine(r.machine);let guard=0;while(true){const s=await snap();if(inputs(r).every(i=>(s.inventory[i.key]??0)>=i.quantity))return;assert.ok(++guard<20,r.name);for(const q of inputs(r))await ensure(q.key,q.quantity,depth);}}
 async function ensure(key,count,depth=0){assert.ok(depth<12,key);let guard=0;while(await qty(key)<count){assert.ok(++guard<100,key);const f=catalog.farm.find(f=>cropKey(f)===key),animal=catalog.livestock.find(a=>a.output===key);
  if(f)await grow(f);
  else if(animal){await buyAnimal(animal);await ensure(animal.feed,1,depth+1);const pen=(await snap()).plots.find(p=>p.residents?.species===animal.key),id=pen.residents.animals[0].id;await openPen(pen.id);await click('herd-manage');await click('animal-'+id);assert.ok((await snap()).plots.find(p=>p.id===pen.id).residents.animals.find(a=>a.id===id).job,'feed started');await page.waitForFunction(id=>{const s=farmCocos.snapshot(),a=s.plots.flatMap(p=>p.residents?.animals??[]).find(a=>a.id===id);return a.job&&a.job.ready<=s.time;},id,{timeout:animal.duration/12*1000+20000});const before=await qty(key);await click('animal-'+id);assert.equal(await qty(key),before+animal.quantity,'animal product collected');raised.add(animal.key);}
  else {const r=catalog.products.find(r=>outputs(r).some(i=>i.key===key));assert.ok(r,key);await prepare(r,depth+1);await produce(r);}
 }}

 async function unlock(gate){
  if(!gate)return;const progress=(await snap()).husbandry;
  if(gate==='husbandry'){
   if(!progress.feedReceived)await ensure('farm40:chicken-feed',1);
   if(!progress.eggsCollected)await ensure('farm40:egg',1);
   if(!progress.milkCollected)await ensure('raw:7',1);
  }else if(gate==='crafts'&&!progress.burgerCollected){const burger=catalog.products.find(r=>r.id===101604);await prepare(burger);await produce(burger);log('unlock-crafts');}
 }
 async function buyMachine(id){
  if((await snap()).machines.some(m=>m.type===id))return;
  const type=catalog.machineTypes.find(t=>t.id===id);await unlock(type.unlock);await fund(type.purchasePrices[0]);await close();await click('shop');await click('shop-tab-buildings');
  const before=(await snap()).coins;await click('shop-machine-'+id);assert.equal((await snap()).coins,before-type.purchasePrices[0]);assert.ok((await snap()).machines.some(m=>m.type===id));log('buy-machine',{id,coins:(await snap()).coins});
 }
 async function buyAnimal(animal){
  const definition=catalog.residentPens.find(p=>p.species===animal.key);let pen=(await snap()).plots.find(p=>p.cell===definition.cell&&p.group==='pen');
  if(!pen.residents){await unlock(definition.unlock);const price=definition.purchasePrice+animal.price;await fund(price);await close();await click('shop');await click('shop-tab-animals');const before=(await snap()).coins;await click('shop-animal-'+pen.id);pen=(await snap()).plots.find(p=>p.id===pen.id);assert.equal((await snap()).coins,before-price,'building a pen includes exactly one animal debit');assert.equal(pen.residents.capacity,1);assert.equal(pen.residents.animals.length,1,'purchased pen includes its first animal');log('buy-pen-with-animal',{species:animal.key,plot:pen.id});}
  if(!pen.residents.animals.length){await fund(animal.price);await close();await click('shop');await click('shop-tab-animals');await click('shop-animal-'+pen.id);assert.equal((await snap()).plots.find(p=>p.id===pen.id).residents.animals.length,1);log('buy-animal',{species:animal.key});}
 }
 try{
  await boot(page,server.url);const initial=await snap();assert.equal(initial.coins,500);assert.equal(initial.diamonds,10);assert.deepEqual(initial.inventory,{});assert.equal(initial.machines.length,3);assert.equal(initial.contentProfile,'simple-1');assert.equal(await page.evaluate(()=>farmCocos.ui().view),'welcome');assert.ok(await page.evaluate(()=>farmCocos.labels().some(l=>l.text.includes('Bản lưu nông trại cũ'))));await click('welcome-start');
  await click('pause-menu');await click('speed-12');await click('resume');assert.equal(await page.evaluate(()=>farmCocos.ui().speed),12);
  await grow(catalog.farm.find(f=>f.id===1));await produce(catalog.products.find(r=>r.id===7));await sell('goods:7');assert.equal((await snap()).coins,516);assert.equal(await qty('raw:1'),1);log('first-bread',{coins:516});await page.screenshot({path:path.join(out,'starter-first-sale.png')});
  for(const id of [1071,2,1020,1019])await buyMachine(id);
  for(const r of catalog.products){await prepare(r);await produce(r);for(const o of outputs(r))await sell(o.key,o.quantity);log('recipe',{id:r.id,name:r.name,coins:(await snap()).coins});}
  await home();const final=await snap();assert.equal(seen.size,23);assert.equal(grown.size,8);assert.equal(raised.size,4);assert.equal(final.machines.length,8);assert.equal(final.plots.filter(p=>p.residents).length,4);assert.equal(final.diamonds,10);assert.ok(final.coins>=20);
  await page.screenshot({path:path.join(out,'starter-complete.png')});await page.reload();await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});const restored=await snap();assert.equal(restored.coins,final.coins);assert.deepEqual(restored.inventory,final.inventory);assert.deepEqual(restored.machines,final.machines);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'');assert.deepEqual(await page.evaluate(()=>[localStorage.getItem('happy-farm-cocos-40-v1'),localStorage.getItem('happy-farm-cocos-40-v1.backup')]),[old,oldBackup]);
  assert.ok(observed.requests.every(url=>!url.includes('farm-town-industries')&&!url.includes('farm-town-agriculture')));assert.deepEqual(observed.errors,[]);
  const report={passed:true,elapsedSeconds:(performance.now()-started)/1000,initialCoins:500,firstSaleCoins:516,finalCoins:final.coins,diamonds:final.diamonds,crops:grown.size,recipes:seen.size,machines:8,purchases:5,animalSpecies:raised.size,purchasedPens:2,allGameplayThroughUi:true,speed:12,injectedCoinsOrItems:false,oldSaveAndBackupUnchanged:true,reload:true,steps,errors:observed.errors};fs.writeFileSync(path.join(out,'starter-results.json'),JSON.stringify(report,null,2));console.log(JSON.stringify({passed:true,recipes:23,finalCoins:final.coins,elapsedSeconds:report.elapsedSeconds}));
 }catch(error){await page.screenshot({path:path.join(out,'starter-failure.png')});fs.writeFileSync(path.join(out,'starter-results.json'),JSON.stringify({passed:false,error:error.stack,steps,state:await snap(),ui:await page.evaluate(()=>farmCocos.ui()),errors:observed.errors},null,2));throw error;}
 finally{await context.close();await browser.close();await server.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
