'use strict';
// Inspector-equivalent source edits, real native input, and refresh/resize behavior for the map's two UI prefabs.
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const {serve,launch,boot,tap,plot,observe,build}=require('./browser-support.cjs');
const out=path.resolve(process.env.COCOS_TEST_OUTPUT||path.join(__dirname,'../artifacts/prefab-split/map-ui'));
const near=(a,b,message)=>assert.ok(Math.abs(a-b)<.02,`${message}: ${a} / ${b}`);
(async()=>{
 const server=await serve(),browser=await launch(),rounds=[];fs.mkdirSync(out,{recursive:true});
 let context;
 try{
  context=await browser.newContext({viewport:{width:393,height:585},hasTouch:true,deviceScaleFactor:1});
  const page=await context.newPage(),observed=observe(page);await boot(page,server.url);
  const source=await page.evaluate(()=>{
   const a=testApp,cc=testCc;a.game.dismissGuide();a.close();a.closeCell();a.game.state.coins=20000;
   const pen=a.game.state.plots.find(p=>p.id===12),species=a.game.catalog.livestock.find(s=>s.key==='layer');
   a.game.state.inventory[species.feed]=5;
   const herd=a.ui.prefabs.herdQuickBar,bubble=a.ui.prefabs.plotBubble;
   const h=herd.data.getComponent('HerdQuickBarView'),b=bubble.data.getComponent('PlotBubbleView');
   if(!h||!b)throw Error('Both map UI assets must contain the authored view components');
   h.frame.color=new cc.Color(221,238,245,255);h.summary.color=new cc.Color(143,49,118,255);
   h.summary.fontSize+=1;h.summary.node.setPosition(h.summary.node.position.x+3,h.summary.node.position.y);
   h.titles[0].color=new cc.Color(122,44,142,255);h.titles[0].fontSize+=1;h.titles[0].node.setPosition(2,h.titles[0].node.position.y);
   b.cropName.color=new cc.Color(130,49,132,255);b.cropName.fontSize+=2;b.cropName.node.setPosition(7,b.cropName.node.position.y);
   b.time.fontSize+=1;b.ready.getChildByName('ReadyFrame').getComponent(cc.Sprite).color=new cc.Color(225,241,220,255);
   herd.compileCreateFunction();bubble.compileCreateFunction();
   globalThis.mapUiActionLog=[];const act=a.act.bind(a);a.act=(action,...rest)=>{mapUiActionLog.push(action.type);return act(action,...rest);};
   a.refresh();a.map.focusBuilding('pen:12');a.map.update(0);
   return {herdUuid:herd._uuid,bubbleUuid:bubble._uuid,summaryFont:h.summary.fontSize,summaryX:h.summary.node.position.x,
    feedFont:h.titles[0].fontSize,bubbleFont:b.cropName.fontSize,timeFont:b.time.fontSize,feed:species.feed,output:species.output,
    editMode:'Loaded prefab asset data edited and compileCreateFunction refreshed, simulating Editor reimport; live instances are not patched.'};
  });
  await plot(page,12,true);
  async function herd(stage){
   const actual=await page.evaluate(()=>{
    const a=testApp,cc=testCc,v=a.herdBar?.node.getComponent('HerdQuickBarView');if(!v)throw Error('Missing live authored care bar');
    const rgba=c=>[c.r,c.g,c.b,c.a],u=a.width/cc.view.getFrameSize().width;
    const r=v.node.getComponent(cc.UITransform);
    return {uuid:v.node.uuid,prefab:v.node.prefab?.asset?._uuid,u,width:r.width/u,height:r.height/u,
     summaryColor:rgba(v.summary.color),summaryFont:v.summary.fontSize,summaryX:v.summary.node.position.x/u,frameColor:rgba(v.frame.color),
     feedTitleColor:rgba(v.titles[0].color),feedTitleFont:v.titles[0].fontSize,feedTitleX:v.titles[0].node.position.x/u,
     owned:v.ownedActions.activeInHierarchy,build:v.buildActions.activeInHierarchy,
     controls:farmCocos.controls().filter(c=>c.id.startsWith('herd-')).map(c=>({...c,w:c.w/u,h:c.h/u})),
     actionLog:[...mapUiActionLog]};
   });
   assert.equal(actual.prefab,source.herdUuid,stage+': linked care-bar instance');
   assert.deepEqual(actual.summaryColor,[143,49,118,255]);assert.deepEqual(actual.frameColor,[221,238,245,255]);
   assert.deepEqual(actual.feedTitleColor,[122,44,142,255],stage+': custom title tint survives enabled/disabled state');
   assert.equal(actual.summaryFont,Math.ceil(source.summaryFont*actual.u));assert.equal(actual.feedTitleFont,Math.ceil(source.feedFont*actual.u));
   near(actual.summaryX,source.summaryX,stage+': Inspector summary position');near(actual.feedTitleX,2,stage+': Inspector button label position');
   near(actual.height,112,stage+': care bar height');assert.ok(actual.owned&&!actual.build);
   assert.deepEqual(actual.controls.map(c=>c.id),['herd-feed','herd-collect','herd-manage']);
   for(const c of actual.controls){assert.ok(c.w>=44-.02&&c.h>=44-.02,c.id+': native CSS target');assert.ok(c.x>0&&c.x<1&&c.y>0&&c.y<1,c.id+': target inside canvas');}
   rounds.push({stage,...actual});return actual;
  }
  const first=await herd('hungry-393');
  await page.evaluate(()=>{for(let i=0;i<5;i++)testApp.refresh();});
  assert.equal((await herd('refresh-393')).uuid,first.uuid,'unchanged refresh reuses the bound bar');
  for(const viewport of [{width:568,height:320},{width:1280,height:720},{width:393,height:585}]){
   await page.setViewportSize(viewport);await page.waitForTimeout(450);await herd('resize-'+viewport.width);
   await page.screenshot({path:path.join(out,'herd-edited-'+viewport.width+'x'+viewport.height+'.png')});
  }
  await tap(page,'herd-feed',true);await herd('fed');
  const fed=await page.evaluate(({feed})=>({stock:testApp.game.quantity(feed),jobs:testApp.game.state.plots.find(p=>p.id===12).residents.animals.filter(a=>a.job).length,calls:mapUiActionLog.filter(t=>t==='feedAnimals').length}),source);
  assert.deepEqual(fed,{stock:4,jobs:1,calls:1},'one native click dispatches one feed after every refresh/resize');
  const preCollect=await page.evaluate(({output})=>{const a=testApp,p=a.game.state.plots.find(p=>p.id===12);a.game.state.time=Math.max(...p.residents.animals.map(a=>a.job?.ready||0))+1;a.refresh();a.map.update(0);return a.game.quantity(output);},source);
  await herd('ready');await tap(page,'herd-collect',true);await herd('collected');
  assert.deepEqual(await page.evaluate(({output})=>({quantity:testApp.game.quantity(output),calls:mapUiActionLog.filter(t=>t==='collectAnimals').length}),source),{quantity:preCollect+1,calls:1});
  await tap(page,'herd-manage',true);assert.equal(await page.evaluate(()=>testApp.panels.view),'livestock');assert.equal(await page.evaluate(()=>testApp.panels.penId),12);
  await tap(page,'close-panel',true);
  await page.evaluate(()=>{const a=testApp;a.closeCell();const result=a.game.plant(49,1);if(result.error)throw Error(result.error);a.refresh();a.map.focusHome();a.map.update(0);});
  await plot(page,49,true);
  async function bubble(kind,stage,id=49){
   const actual=await page.evaluate(({id})=>{
    const a=testApp,cc=testCc,v=a.map.bubbles.views.get(id);if(!v)throw Error('Missing bubble '+id);
    const b=v.root.getComponent('PlotBubbleView'),rgba=c=>[c.r,c.g,c.b,c.a];
    return {uuid:v.root.uuid,prefab:v.root.prefab?.asset?._uuid,kind:v.kind,nameColor:rgba(b.cropName.color),nameFont:b.cropName.fontSize,nameX:b.cropName.node.position.x,
     timeFont:b.time.fontSize,readyTint:rgba(b.ready.getChildByName('ReadyFrame').getComponent(cc.Sprite).color),
     branches:[b.locked.active,b.ready.active,b.growing.active],parentBlocks:!!v.root.getComponent(cc.BlockInputEvents),
     frames:v.root.getComponentsInChildren(cc.Sprite).every(s=>!!s.spriteFrame)};
   },{id});
   assert.equal(actual.prefab,source.bubbleUuid);assert.equal(actual.kind,kind);assert.equal(actual.parentBlocks,false);assert.equal(actual.frames,true);
   assert.deepEqual(actual.nameColor,[130,49,132,255]);assert.equal(actual.nameFont,source.bubbleFont);near(actual.nameX,7,'Inspector bubble name position');assert.equal(actual.timeFont,source.timeFont);
   assert.deepEqual(actual.readyTint,[225,241,220,255]);assert.deepEqual(actual.branches,[kind==='locked',kind==='ready',kind==='growing']);
   rounds.push({stage,...actual});return actual;
  }
  const growing=await bubble('growing','growing-393');
  await page.evaluate(()=>{for(let i=0;i<5;i++){testApp.refresh();testApp.map.update(0);}});
  assert.equal((await bubble('growing','growing-refresh')).uuid,growing.uuid,'countdown refresh keeps static bubble nodes');
  for(const viewport of [{width:568,height:320},{width:1280,height:720},{width:393,height:585}]){
   await page.setViewportSize(viewport);await page.waitForTimeout(450);await bubble('growing','growing-resize-'+viewport.width);
   await page.screenshot({path:path.join(out,'bubble-edited-'+viewport.width+'x'+viewport.height+'.png')});
  }
  const beforeBoost=await page.evaluate(()=>({diamonds:testApp.game.state.diamonds,price:testApp.game.boostPrice(testApp.game.state.plots.find(p=>p.id===49))}));
  await tap(page,'finish-49',true);await bubble('ready','ready-edited');
  assert.deepEqual(await page.evaluate(()=>({diamonds:testApp.game.state.diamonds,calls:mapUiActionLog.filter(t=>t==='boost').length})),{diamonds:beforeBoost.diamonds-beforeBoost.price,calls:1});
  const beforeHarvest=await page.evaluate(()=>testApp.game.quantity('raw:1'));await tap(page,'harvest-49',true);
  assert.deepEqual(await page.evaluate(()=>({stock:testApp.game.quantity('raw:1'),crop:testApp.game.state.plots.find(p=>p.id===49).crop,calls:mapUiActionLog.filter(t=>t==='harvest').length})),{stock:beforeHarvest+3,crop:null,calls:1});
  await page.evaluate(()=>{const a=testApp;const result=a.game.plant(0,1);if(result.error)throw Error(result.error);a.refresh();a.map.focusHome();a.map.update(0);});await plot(page,0,true);
  await bubble('growing','cancel-source',0);await tap(page,'cancel-0',true);
  assert.deepEqual(await page.evaluate(()=>({crop:testApp.game.state.plots.find(p=>p.id===0).crop,calls:mapUiActionLog.filter(t=>t==='cancel').length})),{crop:null,calls:1});
  assert.deepEqual(observed.errors,[]);
  fs.writeFileSync(path.join(out,'results.json'),JSON.stringify({passed:true,build,source,rounds,actions:await page.evaluate(()=>mapUiActionLog),errors:observed.errors},null,2)+'\n');
  console.log('Map UI prefabs: source styles/positions, three viewports, refresh and five single-dispatch native actions passed.');
 }finally{await context?.close();await server.close();await browser.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
