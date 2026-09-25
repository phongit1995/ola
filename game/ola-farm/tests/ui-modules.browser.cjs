'use strict';
// Inspector edits are applied to loaded prefab source data before its first instance is created.
// Every context has fresh isolated storage; only this explicitly documented UI fixture is funded.
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const {serve,launch,boot,tap,plot,site,observe,build}=require('./browser-support.cjs');
const out=path.resolve(process.env.COCOS_UI_MODULES_OUT||path.join(__dirname,'../artifacts/prefab-split/ui-modules'));
const allCases=[[393,585],[568,320],[1280,720]],requested=(process.env.COCOS_UI_MODULES_CASE||'').split(',').filter(Boolean);
assert.ok(requested.every(k=>allCases.some(v=>v.join('x')===k)),'Unknown UI module viewport');
const cases=requested.length?allCases.filter(v=>requested.includes(v.join('x'))):allCases;
const herdSlotUuid=JSON.parse(fs.readFileSync(path.join(__dirname,'../assets/farm/prefabs/ui/HerdSlot.prefab.meta'))).uuid;
async function fixture(page){return page.evaluate(herdUuid=>{
 const a=testApp,cc=testCc,find=(n,name)=>n.name===name?n:n.children.map(c=>find(c,name)).find(Boolean),g=a.game;
 g.dismissGuide();a.close();g.state.coins=20000;g.state.inventory['raw:1']=84;g.state.inventory[g.catalog.livestock.find(t=>t.key==='layer').feed]=10;g.validate();a.save();a.refresh();
 const f=a.ui.prefabs.factoryBody.data.getComponent('FactoryBodyView');
 find(f.node,'RecipeHero').setPosition(35,-36);
 find(f.node,'RecipeTitle').getComponent(cc.Label).fontSize=19;
 const face=find(f.collect,'ButtonFace').getComponent(cc.Sprite);face.color=new cc.Color(63,145,199);face.spriteFrame=a.art.frame('island-ui/material');
 const leaf=cc.assetManager.assets.get(herdUuid);if(!leaf?.data)throw Error('HerdSlot dependency not loaded');
 // Loaded parent assets already contain expanded nested instances; edit those authored
 // instance overrides as the Inspector does, before the body is instantiated.
 const herd=a.ui.prefabs.livestockBody.data.getComponent('LivestockBodyView');
 for(const h of herd.node.getComponentsInChildren('HerdSlotView')){h.status.color=new cc.Color(69,126,199);h.number.fontSize=13;h.face.spriteFrame=a.art.frame('island-ui/card');}
 const picker=a.ui.prefabs.seedPicker.data.getComponent('SeedPickerView');picker.tileSpacing=153;
 const tiles=[picker.tilePrefab.data.getComponent('SeedTileView'),...picker.node.getComponentsInChildren('SeedTileView')];
 for(const tile of tiles){tile.cost.fontSize=28;tile.cost.color=new cc.Color(44,99,155);tile.node.getComponentInChildren(cc.Sprite).color=new cc.Color(180,225,195);}
 a.panels.selectedRecipeId=7;a.panels.factoryRecipesExpanded=false;
 return {factorySource:f.node.uuid,herdSource:leaf.data.uuid,seedSource:picker.node.uuid};
 },herdSlotUuid);}
async function factoryState(page){return page.evaluate(()=>{
 const a=testApp,cc=testCc,v=a.panels.card.getComponentInChildren('FactoryBodyView'),u=a.width/cc.view.getFrameSize().width;
 const hero=v.element(v.recipe,'RecipeHero'),title=v.element(v.recipe,'RecipeTitle').getComponent(cc.Label),face=v.element(v.collect,'ButtonFace').getComponent(cc.Sprite);
 const m=a.game.state.machines.find(m=>m.id===a.panels.machineId);
 return {root:v.node.uuid,shell:a.panels.card.uuid,hero:hero.uuid,heroX:hero.position.x/u,titleFont:title.fontSize,expectedTitleFont:Math.ceil(19*u),face:[face.color.r,face.color.g,face.color.b],customFrame:face.spriteFrame===a.art.frame('island-ui/material'),queue:v.queue.children.map(n=>({uuid:n.uuid,linked:!!n.prefab?.asset,view:!!n.getComponent('FactoryQueueSlotView')})),scroll:{horizontal:v.scroll.horizontal,vertical:v.scroll.vertical},wheat:a.game.quantity('raw:1'),job:m.job,waiting:m.waiting.length};
 });}
function verifyFactory(s){assert.ok(Math.abs(s.heroX-35)<1e-6,'Inspector hero X survives responsive placement');assert.equal(s.titleFont,s.expectedTitleFont,'Inspector font survives data binding');assert.deepEqual(s.face,[63,145,199]);assert.equal(s.customFrame,true,'Inspector custom button artwork survives idle/working state');assert.equal(s.queue.length,5);assert.ok(s.queue.every(x=>x.linked&&x.view));assert.deepEqual(s.scroll,{horizontal:false,vertical:true});}
async function herdState(page){return page.evaluate(()=>{
 const a=testApp,cc=testCc,v=a.panels.card.getComponentInChildren('LivestockBodyView'),u=a.width/cc.view.getFrameSize().width,p=a.game.residentPlot(12).residents;
 return {root:v.node.uuid,shell:a.panels.card.uuid,slots:v.scroll.content.children.map(n=>{const x=n.getComponent('HerdSlotView');return {uuid:n.uuid,name:n.name,linked:!!n.prefab?.asset,numberFont:x.number.fontSize,expectedFont:Math.ceil(13*u),color:[x.status.color.r,x.status.color.g,x.status.color.b],customFrame:x.face.spriteFrame===a.art.frame('island-ui/card'),status:x.status.string};}),scroll:{horizontal:v.scroll.horizontal,vertical:v.scroll.vertical},capacity:p.capacity,animals:p.animals.map(x=>({id:x.id,slot:x.slot,job:x.job})),coins:a.game.state.coins,expansionPrice:a.game.penExpansionPrice(12),feed:a.game.quantity(a.game.catalog.livestock.find(t=>t.key==='layer').feed)};
 });}
function verifyHerd(s){assert.equal(s.slots.length,5);for(const x of s.slots){assert.ok(x.linked);assert.equal(x.numberFont,x.expectedFont);assert.equal(x.customFrame,true);}assert.deepEqual(s.slots[0].color,[69,126,199]);assert.deepEqual(s.scroll,{horizontal:true,vertical:false});}
async function resize(page,width,height){await page.setViewportSize({width,height});await page.waitForFunction(width=>testCc.view.getFrameSize().width===width&&testApp.panels.frameWidth===width,width);await page.waitForTimeout(80);}
async function hold(page,id){const t=await page.evaluate(id=>farmCocos.controls().find(t=>t.id===id),id),b=await page.locator('#GameCanvas').boundingBox();assert.ok(t);const cdp=await page.context().newCDPSession(page);try{await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{id:1,x:b.x+t.x*b.width,y:b.y+t.y*b.height}]});await page.waitForTimeout(500);await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});await page.waitForTimeout(50);}finally{await cdp.detach();}}
(async()=>{
 fs.mkdirSync(out,{recursive:true});const server=await serve();let browser;const results=[],cleanup={serverClosed:false,browserClosed:false};
 const report={buildPath:build,startedAt:new Date().toISOString(),fixture:'Fresh isolated contexts,20000coins,84wheat,10chickenfeed; loaded prefab Inspector edits only. Production,feeding,slot purchase and planting use real input.',results,cleanup,passed:false};
 const save=()=>fs.writeFileSync(path.join(out,'results.json'),JSON.stringify(report,null,2)+'\n');save();
 try{browser=await launch();for(const [width,height]of cases){const context=await browser.newContext({viewport:{width,height},hasTouch:true,isMobile:width<1000}),page=await context.newPage(),observed=observe(page),r={width,height,passed:false};results.push(r);save();try{
  await boot(page,server.url);r.sources=await fixture(page);await site(page,'bakery-1',true);
  const before=await factoryState(page);verifyFactory(before);r.factoryBefore=before;
  await page.evaluate(()=>{for(let i=0;i<3;i++)testApp.panels.render();});await tap(page,'choose-recipe',true);await tap(page,'choose-recipe',true);
  await tap(page,'produce-7',true);const working=await factoryState(page);verifyFactory(working);assert.equal(working.root,before.root);assert.equal(working.shell,before.shell);assert.equal(working.hero,before.hero);assert.equal(working.wheat,before.wheat-2,'one production click debits ingredients once after rebinding');assert.equal(working.waiting,0);assert.equal(working.job.product,7);r.factoryWorking=working;
  const target=width<500?[568,320]:[393,585];await resize(page,...target);const rotated=await factoryState(page);verifyFactory(rotated);assert.equal(rotated.root,before.root);assert.deepEqual(rotated.queue.map(x=>x.uuid),before.queue.map(x=>x.uuid));r.factoryResized=rotated;await page.screenshot({path:path.join(out,`factory-inspector-${width}x${height}.png`)});
  await page.evaluate(()=>{testApp.close();testApp.map.focusBuilding('pen:12');});await page.waitForTimeout(80);await plot(page,12,true);await tap(page,'herd-manage',true);
  const herdBefore=await herdState(page);verifyHerd(herdBefore);r.herdBefore=herdBefore;
  await page.evaluate(()=>{for(let i=0;i<3;i++)testApp.panels.render();});await tap(page,'animal-'+herdBefore.animals[0].id,true);
  const feeding=await herdState(page);verifyHerd(feeding);assert.equal(feeding.root,herdBefore.root);assert.equal(feeding.feed,herdBefore.feed-1,'one feeding click consumes one feed after rebinding');assert.ok(feeding.animals[0].job);assert.deepEqual(feeding.slots.map(x=>x.uuid),herdBefore.slots.map(x=>x.uuid));
  await tap(page,'unlock-pen-slot-1',true);const expanded=await herdState(page);verifyHerd(expanded);assert.equal(expanded.capacity,2);assert.equal(expanded.animals.length,2);assert.equal(expanded.coins,feeding.coins-feeding.expansionPrice,'slot purchase debits bundled price exactly once');assert.deepEqual(expanded.slots.map(x=>x.uuid),herdBefore.slots.map(x=>x.uuid));r.herdExpanded=expanded;
  await resize(page,width,height);const herdResized=await herdState(page);verifyHerd(herdResized);assert.equal(herdResized.root,herdBefore.root);r.herdResized=herdResized;await page.screenshot({path:path.join(out,`herd-inspector-${width}x${height}.png`)});
  const selected=await page.evaluate(()=>{testApp.close();testApp.focusHome();return testApp.game.state.plots.find(p=>p.group==='crop'&&p.unlocked&&!p.crop).id;});await page.waitForTimeout(80);await plot(page,selected,true);
  r.seed=await page.evaluate(()=>{const a=testApp,cc=testCc,v=a.footer.node.getComponent('SeedPickerView'),tiles=v.scroll.content.children.filter(n=>n.getComponent('SeedTileView')),s=tiles[0].getComponent('SeedTileView');return {spacing:tiles[1].position.x-tiles[0].position.x,count:tiles.length,costFont:s.cost.fontSize,costColor:[s.cost.color.r,s.cost.color.g,s.cost.color.b],linked:tiles.every(n=>!!n.prefab?.asset),horizontal:v.scroll.horizontal,vertical:v.scroll.vertical,coins:a.game.state.coins};});
  assert.equal(r.seed.spacing,153);assert.equal(r.seed.count,8);assert.equal(r.seed.costFont,28);assert.deepEqual(r.seed.costColor,[44,99,155]);assert.ok(r.seed.linked);assert.equal(r.seed.horizontal,true);assert.equal(r.seed.vertical,false);
  await hold(page,'plant-1');assert.equal(await page.evaluate(()=>testApp.footer.node.getComponent('SeedPickerView').info.active),true);assert.equal(await page.evaluate(id=>testApp.game.state.plots.find(p=>p.id===id).crop,selected),null,'reading the authored seed card does not plant');await page.screenshot({path:path.join(out,`seed-inspector-${width}x${height}.png`)});
  await tap(page,'plant-1',true);assert.equal(await page.evaluate(id=>testApp.game.state.plots.find(p=>p.id===id).crop,selected),1);assert.equal(await page.evaluate(()=>testApp.game.state.coins),r.seed.coins-20);assert.deepEqual(observed.errors,[]);r.errors=observed.errors;r.passed=true;console.log(`${width}x${height}: authored cards/bodies/seed strip,Inspector persistence,stable instances and single transactions PASS`);
 }catch(error){r.error=String(error);r.stack=error.stack;r.errors=observed.errors;await page.screenshot({path:path.join(out,`failure-${width}x${height}.png`)});console.error(`${width}x${height}: ${error.stack}`);}finally{await context.close();save();}}
 report.passed=results.length===cases.length&&results.every(r=>r.passed);assert.ok(report.passed,'Every UI module viewport must pass');
 }catch(error){report.error=String(error);process.exitCode=1;}finally{await server.close();cleanup.serverClosed=true;if(browser){await browser.close();cleanup.browserClosed=true;}report.finishedAt=new Date().toISOString();save();}
})().catch(error=>{console.error(error);process.exitCode=1;});
