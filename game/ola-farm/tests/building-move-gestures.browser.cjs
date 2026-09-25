'use strict';
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const {serve,launch,boot,observe,build}=require('./browser-support.cjs');
require('tsx/cjs');
const {FARM_LAYOUT,buildingPosition,checkLayout,movedLayout,snapPosition}=require('../assets/farm/scripts/core/BuildingPlacement.ts');
const out=path.resolve(__dirname,'../artifacts/building-move');
function validPosition(id,layout){
 const origin=buildingPosition(id,layout);
 for(let r=2;r<=30;r++)for(const [dx,dy]of [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,1],[1,-1],[-1,-1]]){
  const p=snapPosition({x:origin.x+dx*r*36,y:origin.y+dy*r*18});
  if(!checkLayout(movedLayout(layout,id,p)).error)return p;
 }
 throw Error('No valid fixture position for '+id);
}
(async()=>{
 const server=await serve(),browser=await launch(),page=await browser.newPage({viewport:{width:390,height:844},hasTouch:true}),observed=observe(page);
 try{
  await boot(page,server.url);const cdp=await page.context().newCDPSession(page);
  const fixture=await page.evaluate(()=>{testApp.game.dismissGuide();testApp.close();testApp.save();return farmCocos.pack();});
  const validBarn=validPosition('barn',fixture.free.buildingLayout);
  const barnGround=FARM_LAYOUT.buildings.find(b=>b.id==='barn').footprints[0];
  const center=polygon=>polygon.reduce((p,q)=>({x:p.x+q.x/polygon.length,y:p.y+q.y/polygon.length}),{x:0,y:0});
  const offset=center(barnGround),origin=buildingPosition('barn',fixture.free.buildingLayout);
  const blocked=FARM_LAYOUT.obstacles.filter(o=>/^R\d/.test(o.id)).map(o=>{const p=center(o.polygon);return snapPosition({x:p.x-offset.x,y:p.y-offset.y});})
   .sort((a,b)=>Math.hypot(a.x-origin.x,a.y-origin.y)-Math.hypot(b.x-origin.x,b.y-origin.y))
   .find(p=>/ruộng/.test(checkLayout(movedLayout(fixture.free.buildingLayout,'barn',p)).error||''));
  assert.ok(blocked,'The rejected drop crosses a real field reservation');
  async function reset(){await page.evaluate(pack=>{testApp.importText(JSON.stringify(pack));testApp.map.focusBuilding('barn');},fixture);await page.waitForTimeout(100);}
  async function pixel(p){const q=await page.evaluate(p=>{const cc=testCc,q=testApp.map.world.getComponent(cc.UITransform).convertToWorldSpaceAR(new cc.Vec3(p.x,p.y)),vp=cc.view.getViewportRect(),c=cc.view.getCanvasSize();return{x:(vp.x+q.x*cc.view.getScaleX())/c.width,y:1-(vp.y+q.y*cc.view.getScaleY())/c.height};},p);const b=await page.locator('#GameCanvas').boundingBox();return{x:b.x+q.x*b.width,y:b.y+q.y*b.height};}
  async function touch(type,points){await cdp.send('Input.dispatchTouchEvent',{type,touchPoints:points.map((p,i)=>({...p,id:i+1}))});}
  async function draft(to=validBarn,id='barn'){
   const start=await page.evaluate(id=>{const b=farmCocos.buildings().find(b=>b.buildingId===id);return{x:b.x,y:b.y};},id),origin=await page.evaluate(id=>testApp.map.movement.position(id),id);
   const end={x:start.x+to.x-origin.x,y:start.y+to.y-origin.y};
   // Fit both pointer endpoints before input; moved defaults can be far from the blocked field.
   await page.evaluate(({from,to})=>{const m=testApp.map,c=m.camera,free=m.height-m.inset.top-m.inset.bottom;
    const scale=Math.min(1.1,m.width*.55/(Math.abs(to.x-from.x)+240),free*.55/(Math.abs(to.y-from.y)+240));
    c.lookAt((from.x+to.x)/2,(from.y+to.y)/2,scale/c.scale,'manual',(m.inset.bottom-m.inset.top)/2);m.update();
   },{from:start,to:end});await page.waitForTimeout(80);
   const a=await pixel(start),b=await pixel(end),canvas=await page.locator('#GameCanvas').boundingBox();
   for(const p of [a,b])assert.ok(p.x>canvas.x+30&&p.x<canvas.x+canvas.width-70&&p.y>canvas.y+30&&p.y<canvas.y+canvas.height-30,'Both gesture endpoints and pinch space fit the canvas');
   await touch('touchStart',[a]);await page.waitForFunction(id=>farmCocos.map().movement.selected===id,id);
   await touch('touchMove',[b]);await page.waitForTimeout(30);
   assert.deepEqual(await page.evaluate(()=>farmCocos.map().movement.candidate),to);return b;
  }
  async function unchanged(layout=fixture.free.buildingLayout){assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),layout);assert.equal(await page.evaluate(()=>farmCocos.map().movement.active),false);}
  await reset();let end=await draft(blocked);assert.match(await page.evaluate(()=>farmCocos.map().movement.error),/ruộng/);
  await touch('touchEnd',[]);await unchanged();assert.equal(await page.evaluate(()=>farmCocos.ui().paused),false);
  // Cancel an active draft; a later pointer release must never place it.
  for(const event of ['cancel','escape','resize','hide','modal','import','wheel']){
   await reset();end=await draft();assert.equal(await page.evaluate(()=>farmCocos.map().movement.canPlace),true);const roads=await page.evaluate(()=>farmCocos.map().roads);
   if(event==='cancel')await touch('touchCancel',[]);
   if(event==='escape')await page.keyboard.press('Escape');
   if(event==='resize')await page.setViewportSize({width:844,height:390});
   if(event==='hide')await page.evaluate(()=>{testApp.onHide();testApp.onShow();});
   if(event==='modal')await page.evaluate(()=>testApp.open('inventory'));
   if(event==='import')await page.evaluate(pack=>testApp.importText(JSON.stringify(pack)),fixture);
   if(event==='wheel'){await page.mouse.move(end.x,end.y);await page.mouse.wheel(0,-100);}
   await page.waitForTimeout(120);if(event!=='cancel')await touch('touchEnd',[]);await unchanged();assert.deepEqual(await page.evaluate(()=>farmCocos.map().roads),roads);
   if(event==='resize'){await page.setViewportSize({width:390,height:844});await page.waitForTimeout(150);}
  }
  // Second finger cancels a valid draft and continues immediately as pinch zoom.
  await reset();end=await draft();const zoom=await page.evaluate(()=>farmCocos.map().zoom),second={x:end.x+45,y:end.y+10};
  await touch('touchStart',[end,second]);await unchanged();
  await touch('touchMove',[{x:end.x-15,y:end.y},{x:second.x+15,y:second.y}]);
  await touch('touchEnd',[{x:end.x-15,y:end.y}]);await page.waitForTimeout(550);await unchanged();
  await touch('touchEnd',[]);assert.notEqual(await page.evaluate(()=>farmCocos.map().zoom),zoom);
  // Failed drop retains live state; retry commits the exact pending position once.
  await reset();const roads=await page.evaluate(()=>farmCocos.map().roads);await draft();
  await page.evaluate(()=>{globalThis.restoreStorage=Storage.prototype.setItem;Storage.prototype.setItem=function(k,v){if(k==='ola-farm-cocos-simple-v1')throw Error('test quota');return restoreStorage.call(this,k,v);};});
  await touch('touchEnd',[]);await unchanged();assert.equal(await page.evaluate(()=>farmCocos.ui().storageFailed),true);
  assert.deepEqual(await page.evaluate(()=>testApp.session.pendingPack.free.buildingLayout.positions.barn),validBarn);
  await page.evaluate(()=>{Storage.prototype.setItem=restoreStorage;testApp.retrySave();testApp.map.update();});
  const retried=await page.evaluate(()=>({position:farmCocos.snapshot().buildingLayout.positions.barn,node:testApp.map.facilities.find(t=>t.id==='barn').node.position}));
  assert.deepEqual(retried.position,validBarn);assert.equal(retried.node.x,validBarn.x);assert.equal(retried.node.y,validBarn.y);
  assert.deepEqual(await page.evaluate(()=>farmCocos.map().roads),roads);
  // Consecutive direct drops retain prior placements and the authored roads.
  for(const id of ['farm-house','bakery-1']){
   const layout=await page.evaluate(()=>farmCocos.snapshot().buildingLayout),next=validPosition(id,layout);
   assert.ok(next);await page.evaluate(id=>testApp.map.focusBuilding(id),id);await page.waitForTimeout(80);await draft(next,id);await touch('touchEnd',[]);
   await unchanged(movedLayout(layout,id,next));assert.deepEqual(await page.evaluate(()=>farmCocos.map().roads),roads);
  }
  // Use the barn beside the mill: the enlarged bakery no longer fits this scenery gap.
  // Require real sprite overlap as well as valid ground and the correct draw order.
  const measured=await page.evaluate(()=>{const m=testApp.map,cc=testCc,world=m.world.getComponent(cc.UITransform);
   const bounds=node=>{const boxes=node.getComponentsInChildren(cc.Sprite).filter(s=>s.spriteFrame).map(s=>s.node.getComponent(cc.UITransform).getBoundingBoxToWorld());
    const a=world.convertToNodeSpaceAR(new cc.Vec3(Math.min(...boxes.map(b=>b.xMin)),Math.min(...boxes.map(b=>b.yMin)))),b=world.convertToNodeSpaceAR(new cc.Vec3(Math.max(...boxes.map(b=>b.xMax)),Math.max(...boxes.map(b=>b.yMax))));return{left:a.x,right:b.x,bottom:a.y,top:b.y};};
   return{barn:bounds(m.facilities.find(b=>b.id==='barn').node),mill:bounds(m.standingScenery.find(e=>e.node.name==='MainObject-xay gio').node),origin:m.movement.position('barn'),layout:farmCocos.snapshot().buildingLayout};});
  const mill=FARM_LAYOUT.obstacles.find(o=>o.id==='MainObject-xay gio'),millCenter=center(mill.polygon),barnDefinition=FARM_LAYOUT.buildings.find(b=>b.id==='barn');
  const candidates=[];
  for(let dx=-16;dx<=16;dx++)for(let dy=-16;dy<=16;dy++)candidates.push(snapPosition({x:millCenter.x+dx*36,y:millCenter.y+dy*18}));
  const depthPosition=candidates.sort((a,b)=>Math.hypot(a.x-millCenter.x,a.y-millCenter.y)-Math.hypot(b.x-millCenter.x,b.y-millCenter.y)).find(p=>{
   const x=p.x-measured.origin.x,y=p.y-measured.origin.y,b=measured.barn,w=measured.mill;
   return p.y+barnDefinition.depthOffset>millCenter.y&&Math.min(b.right+x,w.right)-Math.max(b.left+x,w.left)>10&&Math.min(b.top+y,w.top)-Math.max(b.bottom+y,w.bottom)>10&&!checkLayout(movedLayout(measured.layout,'barn',p)).error;
  });assert.ok(depthPosition,'A valid ground position overlaps the fixed mill artwork');
  await page.evaluate(p=>{testApp.beginArrangement();if(!testApp.act({type:'moveBuilding',building:'barn',position:p}))throw Error('Depth fixture failed');testApp.close();testApp.map.focusBuilding('barn');testApp.map.update();},depthPosition);
  const depth=await page.evaluate(()=>{const m=testApp.map,b=m.facilities.find(t=>t.id==='barn').node,w=m.standingScenery.find(e=>e.node.name==='MainObject-xay gio').node;return{sharedParent:b.parent===w.parent,building:b.getSiblingIndex(),windmill:w.getSiblingIndex(),visible:b.activeInHierarchy&&w.activeInHierarchy};});
  assert.equal(depth.sharedParent,true);assert.equal(depth.visible,true);assert.ok(depth.building<depth.windmill);
  // Creator 3.8.8's web touch handler calls preventDefault even on non-cancelable touchcancel.
  // Chromium reports that engine warning for the deliberately cancelled CDP gesture above.
  const cancelWarning='Ignored attempt to cancel a touchcancel event with cancelable=false, for example because scrolling is in progress and cannot be interrupted.';
  const errors=observed.errors.filter(e=>e!==cancelWarning),warnings=observed.errors.filter(e=>e===cancelWarning);
  fs.mkdirSync(out,{recursive:true});await page.screenshot({path:path.join(out,'fixed-scenery-depth.png')});assert.deepEqual(errors,[]);
  const report={passed:true,build,fixtures:{validBarn,blocked,depthPosition},invalidDropReverts:true,activeCancellationCases:7,pinchCancelsAndZooms:true,quotaRollbackAndRetry:true,consecutiveDrops:true,roadsFixed:true,fixedSceneryOcclusion:depth,errors,warnings};
  fs.writeFileSync(path.join(out,'gestures-validation.json'),JSON.stringify(report,null,2)+'\n');console.log(report);
 }finally{await browser.close();await server.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
