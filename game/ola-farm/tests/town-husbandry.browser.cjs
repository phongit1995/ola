'use strict';
// Integration fixture: seed coins and the accepted crop harvests only. Buying, recipes,
// feeding and collection use real pointer input. A controlled clock avoids minute-long waits;
// motion is separately observed across real rendered frames, including paused/reduced motion.
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const {serve,launch,boot,tap,plot,site,state,observe,build}=require('./browser-support.cjs');
const catalog=require('../tools/load-farm-catalog.cjs').loadFarmCatalog();
const cropBaseline=require('./fixtures/simple-farm-catalog-v1.json');
const out=process.env.TOWN_HUSBANDRY_ARTIFACT_DIR?path.resolve(process.env.TOWN_HUSBANDRY_ARTIFACT_DIR):path.resolve(__dirname,'../artifacts/town-husbandry-runtime');
const recipe=id=>catalog.products.find(r=>r.id===id),outputs=r=>r.outputs??[{key:'goods:'+r.id,quantity:1}];
const inputs=r=>r.ingredients.map(i=>({key:i.key??'raw:'+i.id,quantity:i.quantity}));
const amount=(s,key)=>s.inventory[key]??0;

(async()=>{
 fs.mkdirSync(out,{recursive:true});
 const buildConfig=path.join(build,'assets/farm-town/config.json'),buildStamp=fs.statSync(buildConfig).mtimeMs;
 const server=await serve(),browser=await launch(),context=await browser.newContext({viewport:{width:390,height:844},hasTouch:true,isMobile:true});
 const page=await context.newPage(),observed=observe(page),steps=[],checks={};
 const snap=()=>state(page),click=id=>tap(page,id,true),controls=()=>page.evaluate(()=>farmCocos.controls());
 const note=(action,details={})=>{steps.push({action,...details});console.log(action,JSON.stringify(details));fs.writeFileSync(path.join(out,'progress.json'),JSON.stringify({status:'running',steps},null,2));};
 async function close(){await page.evaluate(()=>testApp.close());}
 async function advance(seconds){
  assert.ok(Number.isFinite(seconds)&&seconds>=0);
  await page.evaluate(seconds=>{testApp.game.tick(seconds);testApp.game.validate();testApp.save();testApp.refresh();testApp.map.update();},seconds);
  await page.waitForTimeout(120);
 }
 async function openPen(id){
  await close();await page.evaluate(id=>testApp.map.focusBuilding('pen:'+id),id);await page.waitForTimeout(80);await plot(page,id,true);
  await page.waitForFunction(id=>farmCocos.ui().selected===id,id);
 }
 async function manage(id){
  await openPen(id);await click('herd-manage');
  assert.deepEqual(await page.evaluate(()=>({pen:testApp.panels.penId,tabs:farmCocos.controls().filter(c=>c.id.startsWith('choose-pen-')).map(c=>c.id)})),{pen:id,tabs:[]});
  if((await controls()).some(c=>c.id==='manage-herd'))await click('manage-herd');
 }
 async function fillPen(id){
  await manage(id);
  for(let guard=0;guard<6;guard++){
   const p=(await snap()).plots.find(p=>p.id===id).residents;
   if(p.animals.length===3)break;
   if(p.animals.length===p.capacity)await click('unlock-pen-slot-'+p.capacity);
   else await click('buy-animal-'+Array.from({length:p.capacity},(_,i)=>i).find(slot=>!p.animals.some(a=>a.slot===slot)));
  }
  assert.equal((await snap()).plots.find(p=>p.id===id).residents.animals.length,3);
 }
 async function buyPen(id){
  const before=await snap(),definition=catalog.residentPens.find(p=>p.cell===id);
  await close();await click('shop');await click('shop-tab-animals');await click('shop-animal-'+id);
  const after=await snap(),p=after.plots.find(p=>p.id===id);
  assert.equal(after.coins,before.coins-definition.purchasePrice-catalog.livestock.find(a=>a.key===definition.species).price);
  assert.equal(p.unlocked,true);assert.equal(p.residents.capacity,1);assert.equal(p.residents.animals.length,1,'A purchased yard includes its first animal');assert.equal(p.residents.animals[0].slot,0);
  await fillPen(id);note('buy-pen-and-three-residents',{id,species:p.residents.species});
 }
 async function openMachine(type){
  const t=catalog.machineTypes.find(t=>t.id===type);
  if(!(await snap()).machines.some(m=>m.type===type)){
   const before=(await snap()).coins;await close();await click('shop');await click('shop-tab-buildings');await click('shop-machine-'+type);assert.equal((await snap()).coins,before-t.purchasePrices[0]);
  }
  await site(page,t.buildingIds[0],true);const m=(await snap()).machines.find(m=>m.type===type);
  await page.waitForFunction(()=>farmCocos.ui().view==='factory');return m;
 }
 async function selectRecipe(id){
  if((await controls()).some(c=>c.id==='produce-'+id))return;
  await click('choose-recipe');await click('select-recipe-'+id);
  assert.ok((await controls()).some(c=>c.id==='produce-'+id));
 }
 async function enqueue(id){
  const r=recipe(id),m=await openMachine(r.machine);await selectRecipe(id);const before=await snap();
  await click('produce-'+id);const after=await snap(),a=after.machines.find(n=>n.id===m.id),b=before.machines.find(n=>n.id===m.id);
  assert.ok([a.job,...a.waiting].filter(Boolean).some(j=>j.product===id),'Recipe queued through the visible button');
  assert.equal(a.waiting.length+!!a.job,b.waiting.length+!!b.job+1);
  for(const i of inputs(r))assert.equal(amount(after,i.key),amount(before,i.key)-i.quantity,'One input debit: '+i.key);
  return m;
 }
 async function collectMachine(id){
  const before=await snap(),m=before.machines.find(m=>m.id===id);assert.ok(m.tray.length);
  const expected={};for(const batch of m.tray)for(const item of batch.outputs)expected[item.key]=(expected[item.key]??0)+item.quantity;
  await click('collect-'+id);const after=await snap();assert.equal(after.machines.find(m=>m.id===id).tray.length,0);
  for(const [key,quantity] of Object.entries(expected))assert.equal(amount(after,key),amount(before,key)+quantity,'Collect-all credits '+key+' once');
  assert.equal(after.xp,before.xp+m.tray.reduce((sum,batch)=>sum+batch.xp,0));
  assert.equal((await controls()).find(c=>c.id==='collect-'+id).enabled,false);
  return {batches:m.tray.length,products:m.tray.map(b=>b.product),expected};
 }
 async function produce(id){const r=recipe(id),m=await enqueue(id);await advance(r.duration+1);await collectMachine(m.id);note('recipe-collected',{id,name:r.name});}
 async function feed(id){
  await openPen(id);const before=await snap(),pen=before.plots.find(p=>p.id===id).residents,t=catalog.livestock.find(t=>t.key===pen.species),hungry=pen.animals.filter(a=>!a.job);
  assert.ok(hungry.length);await click('herd-feed');const after=await snap(),herd=after.plots.find(p=>p.id===id).residents;
  assert.equal(amount(after,t.feed),amount(before,t.feed)-hungry.length);
  assert.deepEqual(herd.animals.map(a=>a.id),pen.animals.map(a=>a.id));assert.ok(herd.animals.every(a=>a.job));
 }
 async function collectHerd(id){
  await openPen(id);const before=await snap(),pen=before.plots.find(p=>p.id===id).residents,t=catalog.livestock.find(t=>t.key===pen.species),ready=pen.animals.filter(a=>a.job&&a.job.ready<=before.time);
  assert.ok(ready.length);await click('herd-collect');const after=await snap(),herd=after.plots.find(p=>p.id===id).residents;
  assert.deepEqual(herd.animals.map(a=>a.id),pen.animals.map(a=>a.id),'Collection retains the whole herd and resident IDs');
  assert.ok(herd.animals.every(a=>!a.job));assert.equal(amount(after,t.output),amount(before,t.output)+ready.length*t.quantity);
  note('herd-collected',{id,species:pen.species,residents:herd.animals.map(a=>a.id),output:t.output});
 }
 async function revealControl(id){
  // Includes disabled locked-slot buttons: reveal them for geometry checks without attempting a purchase.
  for(let attempt=0;attempt<60;attempt++){
   const info=await page.evaluate(id=>{
    const cc=testCc,node=testApp.ui.controls.get(id);if(!node?.activeInHierarchy)throw Error('Missing '+id);
    const rect=n=>{const t=n.getComponent(cc.UITransform),p=n.worldPosition,s=n.worldScale;return{x:p.x-t.width*t.anchorX*s.x,y:p.y-t.height*t.anchorY*s.y,w:t.width*s.x,h:t.height*s.y};};
    let mask=null;for(let p=node.parent;p;p=p.parent)if(p.getComponent(cc.Mask))mask=rect(p);
    if(!mask)return{clipped:false};const b=rect(node);
    const left=Math.max(0,mask.x-b.x),right=Math.max(0,b.x+b.w-mask.x-mask.w),below=Math.max(0,mask.y-b.y),above=Math.max(0,b.y+b.h-mask.y-mask.h),horizontal=left>1||right>1;
    const vp=cc.view.getViewportRect(),canvas=cc.view.getCanvasSize();
    return{clipped:horizontal||below>1||above>1,direction:horizontal?(right>0?-1:1):(below>0?1:-1),delta:Math.max(4,Math.min(120,Math.max(left,right,below,above)*2+4)),
     x:(vp.x+(mask.x+mask.w/2)*cc.view.getScaleX())/canvas.width,y:1-(vp.y+(mask.y+mask.h/2)*cc.view.getScaleY())/canvas.height};
   },id);
   if(!info.clipped){await page.evaluate(()=>testApp.panels.scroll?.stopAutoScroll());return;}
   const box=await page.locator('#GameCanvas').boundingBox();await page.mouse.move(box.x+info.x*box.width,box.y+info.y*box.height);
   await page.mouse.wheel(0,info.direction*info.delta);await page.waitForTimeout(90);
  }
  throw Error('Control remains clipped: '+id);
 }
 async function assertTouchTargets(ids){
  const canvas=await page.locator('#GameCanvas').boundingBox();
  assert.deepEqual((await controls()).filter(c=>ids.includes(c.id)).map(c=>c.id).sort(),ids.slice().sort(),'Expected controls are present');
  const buttons=[];
  for(const id of ids){
   await revealControl(id);
   const b=await page.evaluate(id=>{
    const cc=testCc,vp=cc.view.getViewportRect(),size=cc.view.getCanvasSize(),c=farmCocos.controls().find(c=>c.id===id),masks=[];
    for(let n=testApp.ui.controls.get(id).parent;n;n=n.parent)if(n.getComponent(cc.Mask)){
     const t=n.getComponent(cc.UITransform),p=n.worldPosition,s=n.worldScale;
     masks.push({left:(vp.x+(p.x-t.width*t.anchorX*s.x)*cc.view.getScaleX())/size.width,right:(vp.x+(p.x+t.width*(1-t.anchorX)*s.x)*cc.view.getScaleX())/size.width,
      top:1-(vp.y+(p.y+t.height*(1-t.anchorY)*s.y)*cc.view.getScaleY())/size.height,bottom:1-(vp.y+(p.y-t.height*t.anchorY*s.y)*cc.view.getScaleY())/size.height});
    }
    return{...c,masks,cssScaleX:cc.view.getScaleX()/size.width,cssScaleY:cc.view.getScaleY()/size.height};
   },id);
   buttons.push(b);const w=b.w*b.cssScaleX*canvas.width,h=b.h*b.cssScaleY*canvas.height;
   assert.ok(w>=43.8&&h>=43.8,b.id+' needs at least 44 CSS px; got '+w+'×'+h);
   const x=b.x*canvas.width,y=b.y*canvas.height;
   assert.ok(x-w/2>=-.5&&x+w/2<=canvas.width+.5&&y-h/2>=-.5&&y+h/2<=canvas.height+.5,b.id+' extends outside canvas');
   for(const mask of b.masks)assert.ok(x-w/2>=mask.left*canvas.width-1&&x+w/2<=mask.right*canvas.width+1
    &&y-h/2>=mask.top*canvas.height-1&&y+h/2<=mask.bottom*canvas.height+1,b.id+' is fully visible inside its scroll mask');
  }
  return buttons.map(b=>({id:b.id,width:b.w*b.cssScaleX*canvas.width,height:b.h*b.cssScaleY*canvas.height}));
 }
 async function reloadPreserves(){
  const before=await snap();await close();await page.reload();await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});
  await page.evaluate(async()=>{globalThis.testCc=await System.import('cc');globalThis.testApp=testCc.director.getScene().getChildByName('Canvas').getComponent('GameApp');});
  const restored=await snap();for(const key of ['coins','diamonds','xp','inventory','plots','machines','nextId','husbandry','buildingLayout'])assert.deepEqual(restored[key],before[key],key+' survives reload without duplicate rewards');
 }
 try{
  await boot(page,server.url);
  const loaded=await page.evaluate(()=>({catalog:testApp.game.catalog,assets:farmCocos.assets()}));
  assert.deepEqual(loaded.catalog.farm,cropBaseline.farm);assert.equal(loaded.catalog.livestock.length,4);assert.equal(loaded.catalog.machineTypes.length,8);assert.equal(loaded.catalog.products.length,23);assert.equal(loaded.catalog.items.length,35);assert.equal(loaded.assets.townPrefabs,21);assert.deepEqual(loaded.assets.errors,[]);
  await click('welcome-start');
  await page.evaluate(()=>{const g=testApp.game;g.state.coins=20000;for(const crop of g.catalog.farm)g.state.inventory[crop.itemKey??'raw:'+crop.id]=100;g.validate();testApp.save();testApp.refresh();});
  const initial=await snap();assert.deepEqual(initial.husbandry,{version:1,feedReceived:false,eggsCollected:false,milkCollected:false,burgerCollected:false});
  const cropPlots=initial.plots.filter(p=>p.group==='crop');
  // Unbuilt pens and machines are offered by Shop; their hidden map anchors are not selectable.
  await close();await click('shop');await click('shop-tab-animals');await assertTouchTargets(['shop-animal-14']);assert.equal((await controls()).find(c=>c.id==='shop-animal-14').enabled,false);
  await click('shop-tab-buildings');await assertTouchTargets(['shop-machine-1021']);assert.equal((await controls()).find(c=>c.id==='shop-machine-1021').enabled,false);checks.lockedPigAndLoom=true;
  await fillPen(12);await fillPen(13);
  await produce(24);await produce(25);
  await feed(12);await feed(13);await advance(181);await collectHerd(12);await collectHerd(13);
  assert.equal((await snap()).husbandry.feedReceived,true);assert.equal((await snap()).husbandry.eggsCollected,true);assert.equal((await snap()).husbandry.milkCollected,true);
  await buyPen(14);await produce(105003);await feed(14);await advance(241);await collectHerd(14);
  // Mixed ready tray: two bread batches for the burger and one grape bread. All paid queue slots use UI.
  const bakery=await openMachine(1);await click('expand-queue');await click('expand-queue');
  await enqueue(7);await enqueue(7);await enqueue(9);await advance(recipe(7).duration*2+recipe(9).duration+2);
  checks.mixedTray=await collectMachine(bakery.id);assert.equal(checks.mixedTray.batches,3);assert.deepEqual(checks.mixedTray.products,[7,7,9]);
  await reloadPreserves();checks.mixedCollectionReload=true;
  await produce(22);await produce(101604);assert.equal((await snap()).husbandry.burgerCollected,true);
  await produce(101902);await buyPen(15);await produce(105004);await feed(15);await advance(361);await collectHerd(15);await produce(102101);
  const complete=await snap();assert.equal(amount(complete,'town:burger'),1);assert.equal(amount(complete,'town:pie_potato'),1);assert.equal(amount(complete,'town:woolly'),1);assert.equal(amount(complete,'town:wool'),1);
  assert.deepEqual(complete.plots.filter(p=>p.group==='crop'),cropPlots,'Livestock/factory play leaves every accepted crop plot unchanged');
  await reloadPreserves();checks.fullChainAndPersistentHerds=true;checks.cropBaselineUnchanged=true;

  // A missing wool ingredient leads to the correct herd and returns to the pinned loom recipe.
  const navigationInventory=(await snap()).inventory,loomTarget=await openMachine(1021);await selectRecipe(102101);
  await click('pin-recipe');await click('recipe-ingredient-0');
  assert.equal(await page.evaluate(()=>farmCocos.ui().view),'ingredients');
  const sheepSource=await page.evaluate(()=>farmCocos.controls().filter(c=>c.id.startsWith('ingredient-source-')).find(c=>testApp.ui.controls.get(c.id).getComponentsInChildren(testCc.Label).some(l=>l.string.includes('Cừu')))?.id);
  assert.ok(sheepSource,'Wool lists the sheep herd as its source');await click(sheepSource);
  assert.deepEqual(await page.evaluate(()=>({view:farmCocos.ui().view,pen:testApp.panels.penId})),{view:'livestock',pen:15});
  await click('close-panel');await click('return-production');
  assert.deepEqual(await page.evaluate(()=>({view:farmCocos.ui().view,machine:testApp.panels.machineId,recipe:testApp.panels.selectedRecipeId})),{view:'factory',machine:loomTarget.id,recipe:102101});
  await click('pin-recipe');assert.deepEqual((await snap()).inventory,navigationInventory);checks.pinnedWoolHerdReturn=true;

  // Drag and pinch beginning over a herd do not feed, collect or place a building.
  await openPen(12);await close();await page.evaluate(()=>testApp.map.focusBuilding('pen:12'));await page.waitForTimeout(80);
  const cdp=await context.newCDPSession(page),beforeGesture=await snap(),box=await page.locator('#GameCanvas').boundingBox();
  const p=await page.evaluate(()=>farmCocos.targets().find(p=>p.id===12).screen),point={x:box.x+p.x*box.width,y:box.y+p.y*box.height};
  const touch=(type,points)=>cdp.send('Input.dispatchTouchEvent',{type,touchPoints:points.map((p,i)=>({...p,id:i+1}))});
  await touch('touchStart',[point]);await touch('touchMove',[{x:point.x+75,y:point.y+25}]);await touch('touchEnd',[]);await page.waitForTimeout(80);
  await page.evaluate(()=>testApp.map.focusBuilding('pen:12'));await page.waitForTimeout(80);
  const q=await page.evaluate(()=>farmCocos.targets().find(p=>p.id===12).screen),start={x:box.x+q.x*box.width,y:box.y+q.y*box.height},zoom=await page.evaluate(()=>farmCocos.map().zoom);
  await touch('touchStart',[start,{x:start.x+45,y:start.y+10}]);await touch('touchMove',[{x:start.x-18,y:start.y},{x:start.x+70,y:start.y+10}]);await touch('touchEnd',[]);await page.waitForTimeout(100);
  const afterGesture=await snap();for(const key of ['inventory','plots','buildingLayout'])assert.deepEqual(afterGesture[key],beforeGesture[key],key+' is untouched by navigation gestures');
  assert.equal(await page.evaluate(()=>farmCocos.map().movement.active),false);assert.notEqual(await page.evaluate(()=>farmCocos.map().zoom),zoom);checks.dragAndPinchDoNotFeed=true;

  // Layout evidence down to 320 CSS px on both orientations; all new care/production actions remain usable.
  checks.touchTargets={};
  for(const [name,width,height] of [['portrait',390,844],['landscape',844,390],['small',320,568],['small-landscape',568,320]]){
   await page.setViewportSize({width,height});await page.waitForTimeout(400);
   await openPen(14);checks.touchTargets[name+'Quickbar']=await assertTouchTargets(['herd-feed','herd-collect','herd-manage']);
   await page.screenshot({path:path.join(out,name+'-herd-quickbar.png')});
   await click('herd-manage');assert.deepEqual(await page.evaluate(()=>({pen:testApp.panels.penId,tabs:farmCocos.controls().filter(c=>c.id.startsWith('choose-pen-')).map(c=>c.id)})),{pen:14,tabs:[]});
   checks.touchTargets[name+'Care']=await assertTouchTargets(['feed-all','collect-all-animals','manage-herd','close-panel']);
   const careIds=(await snap()).plots.find(p=>p.id===14).residents.animals.map(a=>'animal-'+a.id);
   checks.touchTargets[name+'CareSlots']=await assertTouchTargets(careIds);
   const portraits=await page.evaluate(()=>{const cc=testCc,canvas=cc.view.getCanvasSize(),sx=cc.view.getScaleX()/canvas.width,sy=cc.view.getScaleY()/canvas.height;
    return testApp.panels.card.getComponentsInChildren(cc.UITransform).filter(t=>t.node.name==='AnimalPortrait').map(t=>{
     const boxes=t.node.getComponentsInChildren(cc.Sprite).filter(s=>s.spriteFrame).map(s=>s.node.getComponent(cc.UITransform).getBoundingBoxToWorld());
     return {width:(Math.max(...boxes.map(b=>b.xMax))-Math.min(...boxes.map(b=>b.xMin)))*sx,height:(Math.max(...boxes.map(b=>b.yMax))-Math.min(...boxes.map(b=>b.yMin)))*sy};});});
   const portraitCanvas=await page.locator('#GameCanvas').boundingBox();assert.equal(portraits.length,3);
   for(const portrait of portraits){assert.ok(Math.min(portrait.width*portraitCanvas.width,portrait.height*portraitCanvas.height)>=24&&Math.max(portrait.width*portraitCanvas.width,portrait.height*portraitCanvas.height)>=32,'Animal portraits fit the visible body, not the empty prefab canvas');}
   checks[name+'Portraits']=portraits.map(p=>({width:p.width*portraitCanvas.width,height:p.height*portraitCanvas.height}));
   await page.screenshot({path:path.join(out,name+'-herd-care.png')});
   await click('manage-herd');const saleIds=(await snap()).plots.find(p=>p.id===14).residents.animals.map(a=>'sell-animal-'+a.id);checks.touchTargets[name+'Management']=await assertTouchTargets(['care-herd','unlock-pen-slot-3','unlock-pen-slot-4',...saleIds]);
   const loom=await openMachine(1021);await selectRecipe(102101);
   const queueControls=(await controls()).filter(c=>c.id==='expand-queue'||c.id.startsWith('queue-slot-')||c.id.startsWith('queue-locked-')).map(c=>c.id);
   assert.equal(queueControls.length,5,'All five queue slots remain visible');
   checks.touchTargets[name+'Factory']=await assertTouchTargets(['collect-'+loom.id,'choose-recipe','produce-102101','close-panel','all-buildings','pin-recipe','recipe-ingredient-0',...queueControls]);
   await page.screenshot({path:path.join(out,name+'-loom.png')});
   await click('pin-recipe');await click('close-panel');checks.touchTargets[name+'Return']=await assertTouchTargets(['return-production']);
   await click('return-production');assert.equal(await page.evaluate(()=>testApp.panels.selectedRecipeId),102101);await click('pin-recipe');
  }

  // Removing the middle resident preserves the other two map slots; a new animal reuses the gap.
  await manage(14);
  const slotsBefore=await page.evaluate(()=>farmCocos.map().town.herds.find(h=>h.id===14).slots);
  const removed=slotsBefore.find(s=>s.slot===1).animal;
  await click('sell-animal-'+removed);
  const slotsAfterSale=await page.evaluate(()=>farmCocos.map().town.herds.find(h=>h.id===14).slots);
  assert.deepEqual(slotsAfterSale,slotsBefore.filter(s=>s.animal!==removed));
  await click('buy-animal-1');
  const slotsAfterBuy=await page.evaluate(()=>farmCocos.map().town.herds.find(h=>h.id===14).slots);
  assert.equal(slotsAfterBuy.length,3);assert.equal(slotsAfterBuy.find(s=>!slotsBefore.some(old=>old.animal===s.animal)).slot,1);
  checks.stableSlotsAfterSaleAndReplacement=true;

  // A separate visual fixture keeps every production mechanism and each herd active together.
  // These injected items are excluded from the playthrough/economy assertions above.
  await page.setViewportSize({width:1280,height:900});await page.waitForTimeout(350);await close();
  await page.evaluate(()=>{const g=testApp.game,ok=r=>{if(r.error)throw Error(r.error);};g.state.coins=10000;for(const item of g.items)g.state.inventory[item.key]=100;
   for(const t of g.machineTypes){if(!g.state.machines.some(m=>m.type===t.id))ok(g.buyMachine(t.id));const m=g.state.machines.find(m=>m.type===t.id);if(m.tray.length)ok(g.collectAll(m.id));if(!m.job){const r=g.catalog.products.find(r=>r.machine===t.id);ok(g.produce(r.id,m.id));}}
   for(const p of g.state.plots.filter(p=>p.residents))ok(g.feedAnimals(p.id));g.validate();testApp.save();testApp.motion=true;testApp.map.model.motion=true;testApp.map.focusHome();testApp.map.update();
  });
  const anatomy=()=>page.evaluate(()=>{const town=testApp.map.town,parts=n=>(n.getChildByName('Model')?.children??[]).map(p=>[p.name,p.position.x,p.position.y,p.angle]);return{
   animals:Array.from(town.animals,([id,v])=>({id,species:v.prefab,active:v.node.activeInHierarchy,parts:parts(v.visual)})),
   machines:Array.from(town.buildings,([id,v])=>({id,key:v.visualKey,active:v.node.activeInHierarchy,parts:parts(v.model)})),
   diagnostics:farmCocos.map().town,time:testApp.game.state.time};});
  const first=await anatomy();await page.waitForTimeout(750);const next=await anatomy();
  assert.ok(next.time>first.time,'Farm clock actually advances rendered motion');assert.equal(next.animals.length,12);assert.equal(next.machines.length,8);
  for(const group of ['animals','machines'])for(const a of first[group]){assert.equal(a.active,true,a.id+' visible in whole-farm fixture');const b=next[group].find(n=>n.id===a.id);assert.ok(a.parts.length>1,a.id+' has a multipart gameplay prefab');assert.notDeepEqual(b.parts,a.parts,a.id+' changes an anatomical/machine part while working');}
  checks.motion={animals:first.animals.map(a=>a.species),machines:first.machines.map(m=>m.key)};
  assert.equal(first.diagnostics.herds.length,4,'Per-pen diagnostics required for front-fence coverage');
  assert.ok(next.diagnostics.presentationTime>first.diagnostics.presentationTime,'Presentation clock advances independently of recipe duration');
  const yardEvidence=await page.evaluate(()=>{const town=testApp.map.town,cc=testCc;return Array.from(town.yards,([id,y])=>{
   const residents=Array.from(town.animals.values()).filter(a=>a.pen===id),frameCount=n=>n.getComponentsInChildren(cc.Sprite).filter(s=>s.spriteFrame).length;
   return {id,key:y.key,frontActive:y.front.activeInHierarchy,backActive:y.node.activeInHierarchy,frontOrder:y.front.getSiblingIndex(),backOrder:y.node.getSiblingIndex(),
    frontFences:y.frontNames,frontFrames:frameCount(y.front),yardFrames:frameCount(y.node)+frameCount(y.front),sourceFrames:frameCount(testApp.art.prefabs.get(y.key).data),
    residents:residents.map(a=>({slot:a.slot,x:a.node.position.x-y.node.position.x,y:a.node.position.y-y.node.position.y,order:a.node.getSiblingIndex(),
     sharedParent:a.node.parent===y.front.parent&&a.node.parent===y.node.parent,frames:frameCount(a.visual),sourceFrames:frameCount(testApp.art.prefabs.get(a.prefab).data)}))};});});
  for(const yard of yardEvidence){
   assert.equal(yard.frontActive,true);assert.equal(yard.backActive,true);assert.ok(yard.frontFences.length>=2,yard.key+' has separate foreground fences');
   assert.equal(yard.frontFrames,yard.frontFences.length);assert.equal(yard.yardFrames,yard.sourceFrames,'Splitting fence layers must not lose source sprites');
   assert.deepEqual(yard.residents.map(r=>r.slot).sort(),[0,1,2]);
   for(const resident of yard.residents){assert.ok(resident.sharedParent);assert.ok(resident.order>yard.backOrder&&resident.order<yard.frontOrder,'Resident draws between yard and front fences');
    assert.ok(Math.abs(resident.x)<80&&resident.y>-22&&resident.y<35,'Resident foot stays within the yard');assert.equal(resident.frames,resident.sourceFrames,'Complete source anatomy is rendered');}
  }
  assert.deepEqual(yardEvidence.find(y=>y.id===14).frontFences.slice().sort(),['zabor_l-31','zabor_p-28']);
  for(const name of ['zabor_z-37','zabor_x-39','zabor_m-46'])assert.ok(yardEvidence.find(y=>y.id===15).frontFences.includes(name));
  checks.herds=yardEvidence;
  await page.screenshot({path:path.join(out,'desktop-four-herds-eight-machines.png')});
  await page.evaluate(()=>{testApp.paused=true;});const paused=await anatomy();await page.waitForTimeout(300);const still=await anatomy();
  assert.equal(still.time,paused.time);assert.equal(still.diagnostics.presentationTime,paused.diagnostics.presentationTime);assert.deepEqual(still.animals,paused.animals);assert.deepEqual(still.machines,paused.machines);assert.deepEqual(still.diagnostics.residents,paused.diagnostics.residents);checks.pauseFreezesMotion=true;
  await page.evaluate(()=>{testApp.paused=false;testApp.motion=false;testApp.map.model.motion=false;testApp.map.update();});const reduced=await anatomy();await page.waitForTimeout(300);const reducedAfter=await anatomy();
  assert.deepEqual(reducedAfter.animals,reduced.animals);assert.deepEqual(reducedAfter.machines,reduced.machines);checks.reducedMotionStable=true;
  assert.equal(fs.statSync(buildConfig).mtimeMs,buildStamp,'Creator rebuilt the shared output during this browser run; rerun against a stable build');
  assert.deepEqual(observed.errors,[]);
  const report={passed:true,buildStamp,profile:{crops:8,species:4,machines:8,recipes:23,items:35},fixture:{initialCoins:20000,initialInventory:'accepted crop outputs only',clock:'explicit controlled advances; real rendered frames checked separately',visualFixtureAfterEconomyChecks:true},checks,steps,errors:observed.errors};
  fs.writeFileSync(path.join(out,'results.json'),JSON.stringify(report,null,2)+'\n');console.log('Town husbandry: full gated UI chain, persistent residents, mixed collect-all/reload, phone layouts and articulated motion passed.');
 }catch(error){
  await page.screenshot({path:path.join(out,'failure.png')}).catch(()=>{});
  fs.writeFileSync(path.join(out,'results.json'),JSON.stringify({passed:false,error:error.stack,steps,checks,state:await snap().catch(()=>null),ui:await page.evaluate(()=>farmCocos.ui()).catch(()=>null),errors:observed.errors},null,2)+'\n');throw error;
 }finally{await context.close();await browser.close();await server.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
