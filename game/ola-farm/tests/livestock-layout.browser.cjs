'use strict';
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const {serve,launch,boot,plot,tap,observe,build}=require('./browser-support.cjs');
const catalog=require('../tools/load-farm-catalog.cjs').loadFarmCatalog();
const out=process.env.COCOS_LIVESTOCK_OUT?path.resolve(process.env.COCOS_LIVESTOCK_OUT):path.resolve(__dirname,'../artifacts/herd-horizontal/runtime');
const allCases=[[320,568],[393,585],[568,320],[844,390],[1280,720]];
const requested=(process.env.COCOS_LIVESTOCK_CASE??'').split(',').map(s=>s.trim()).filter(Boolean);
assert.ok(requested.every(v=>allCases.some(([w,h])=>v===`${w}x${h}`)),'Unsupported COCOS_LIVESTOCK_CASE');
const cases=requested.length?allCases.filter(([w,h])=>requested.includes(`${w}x${h}`)):allCases;
const right=r=>r.x+r.w,bottom=r=>r.y+r.h;
const inside=(a,b,pad=0)=>a.x>=b.x+pad-.3&&a.y>=b.y+pad-.3&&right(a)<=right(b)-pad+.3&&bottom(a)<=bottom(b)-pad+.3;
const intersection=(a,b)=>{const x=Math.max(a.x,b.x),y=Math.max(a.y,b.y);return{x,y,w:Math.max(0,Math.min(right(a),right(b))-x),h:Math.max(0,Math.min(bottom(a),bottom(b))-y)};};
const overlap=(a,b)=>{const r=intersection(a,b);return r.w>.5&&r.h>.5;};
async function snap(page){return page.evaluate(()=>({coins:testApp.game.state.coins,inventory:JSON.parse(JSON.stringify(testApp.game.state.inventory)),pens:testApp.game.state.plots.filter(p=>p.group==='pen').map(p=>({id:p.id,residents:JSON.parse(JSON.stringify(p.residents))}))}));}
const pen=(s,id)=>s.pens.find(p=>p.id===id).residents;
const quantity=(s,key)=>s.inventory[key]??0;
const expansionFees=[0,45,75,120,180];
const touchClients=new WeakMap(),scrollEvidence=new WeakMap();
async function mapHerd(page,id){return page.evaluate(id=>{
 const a=testApp,cc=testCc,canvas=document.querySelector('#GameCanvas').getBoundingClientRect(),size=cc.view.getCanvasSize(),vp=cc.view.getViewportRect();
 const sx=cc.view.getScaleX()/size.width*canvas.width,sy=cc.view.getScaleY()/size.height*canvas.height;
 const residents=[...a.map.town.animals].filter(([,v])=>v.pen===id).map(([animal,v])=>{
  const sprites=v.visual.getComponentsInChildren(cc.Sprite).filter(s=>s.node.activeInHierarchy&&s.spriteFrame);
  const points=sprites.flatMap(s=>{const q=s.node.getComponent(cc.UITransform);return[[0,0],[1,0],[1,1],[0,1]].map(([x,y])=>q.convertToWorldSpaceAR(new cc.Vec3((x-q.anchorX)*q.width,(y-q.anchorY)*q.height,0))).map(p=>({x:vp.x/size.width*canvas.width+p.x*sx,y:canvas.height-vp.y/size.height*canvas.height-p.y*sy}));});
  const x=Math.min(...points.map(p=>p.x)),y=Math.min(...points.map(p=>p.y));return{animal,slot:v.slot,active:v.node.activeInHierarchy,sprites:sprites.length,bounds:{x,y,w:Math.max(...points.map(p=>p.x))-x,h:Math.max(...points.map(p=>p.y))-y}};
 });
 return{id,slots:farmCocos.map().town.herds.find(h=>h.id===id).slots.slice().sort((a,b)=>a.animal-b.animal),residents,canvas:{x:0,y:0,w:canvas.width,h:canvas.height}};
},id);}
function fiveMapResidents(info){assert.equal(info.residents.length,5);assert.deepEqual(info.slots.map(s=>s.slot).sort(),[0,1,2,3,4]);for(const animal of info.residents){assert.ok(animal.active&&animal.sprites>0,'Every occupied slot has a rendered resident');assert.ok(inside(animal.bounds,info.canvas),'All five resident models fit the focused canvas');}}
async function inspect(page){return page.evaluate(()=>{
 const a=testApp,cc=testCc,quick=a.panels.view==='',root=quick?a.herdBar.node:a.panels.card;
 const canvas=document.querySelector('#GameCanvas').getBoundingClientRect(),size=cc.view.getCanvasSize(),vp=cc.view.getViewportRect();
 const sx=cc.view.getScaleX()/size.width*canvas.width,sy=cc.view.getScaleY()/size.height*canvas.height;
 const rect=n=>{const t=n.getComponent(cc.UITransform),p=n.worldPosition,s=n.worldScale;return{x:vp.x/size.width*canvas.width+(p.x-t.width*t.anchorX*s.x)*sx,y:canvas.height-vp.y/size.height*canvas.height-(p.y+t.height*(1-t.anchorY)*s.y)*sy,w:t.width*s.x*sx,h:t.height*s.y*sy};};
 const mask=n=>{for(let p=n.parent;p&&p!==root.parent;p=p.parent)if(p.getComponent(cc.Mask))return rect(p);return null;};
 const key=s=>Object.keys(a.art.islandUi.images).find(k=>(s?.spriteFrame?._uuid===testUiFrames.island[k]||s?.spriteFrame===a.art.frame('island-ui/'+k)));
 const controls=[...a.ui.controls].filter(([,n])=>n.activeInHierarchy&&n.isChildOf(root)).map(([id,n])=>({id,...rect(n),mask:mask(n),enabled:n.getComponent(cc.Button)?.interactable!==false,text:n.getComponentsInChildren(cc.Label).filter(l=>l.node.activeInHierarchy).map(l=>l.string).join('\n')}));
 const labels=root.getComponentsInChildren(cc.Label).filter(l=>l.node.activeInHierarchy).map(l=>{const raster=Math.max(1,l.fontSize<100?Math.min(l.textStyle.fontScale,100/l.fontSize):l.textStyle.fontScale);return{name:l.node.name,text:l.string,font:l.font?.name,cssFont:l.actualFontSize/raster*l.node.worldScale.y*sy,...rect(l.node),mask:mask(l.node)};});
 const frame=root.getChildByName(quick?'HerdBarFrame':'LivestockFrame'),scroll=quick?null:a.panels.scroll;
 const slots=root.getComponentsInChildren(cc.UITransform).filter(t=>t.node.activeInHierarchy&&/^herd-slot-[0-4]$/.test(t.node.name)).map(t=>({index:Number(t.node.name.slice(-1)),...rect(t.node),text:t.node.getComponentsInChildren(cc.Label).filter(l=>l.node.activeInHierarchy).map(l=>l.string).join('\n'),status:t.node.getComponentsInChildren(cc.Label).find(l=>l.node.name==='SlotStatus')?.string,product:!!t.node.getChildByName('SlotProduct')?.activeInHierarchy})).sort((a,b)=>a.index-b.index);
 const portraits=root.getComponentsInChildren(cc.UITransform).filter(t=>t.node.activeInHierarchy&&t.node.name==='AnimalPortrait').map(t=>{
  // Layered animal prefabs have nested transforms; worldScale alone cannot describe their rendered bounds.
  const sprites=t.node.getComponentsInChildren(cc.Sprite).filter(s=>s.node.activeInHierarchy&&s.spriteFrame);
  const points=sprites.flatMap(s=>{const q=s.node.getComponent(cc.UITransform);return[[0,0],[1,0],[1,1],[0,1]].map(([x,y])=>q.convertToWorldSpaceAR(new cc.Vec3((x-q.anchorX)*q.width,(y-q.anchorY)*q.height,0))).map(p=>({x:vp.x/size.width*canvas.width+p.x*sx,y:canvas.height-vp.y/size.height*canvas.height-p.y*sy}));});
  const x=Math.min(...points.map(p=>p.x)),y=Math.min(...points.map(p=>p.y));return{box:rect(t.node),art:{x,y,w:Math.max(...points.map(p=>p.x))-x,h:Math.max(...points.map(p=>p.y))-y},layers:sprites.length};});
 return{quick,view:a.panels.view,penId:a.panels.penId,management:a.panels.livestockManagement,root:root.name,bounds:rect(root),frameKey:key(frame?.getComponent(cc.Sprite)),
  canvas:{x:0,y:0,w:canvas.width,h:canvas.height},controls,labels,portraits,slots,
  scroll:scroll?{...rect(scroll.node),mask:rect(scroll.content.parent),max:scroll.getMaxScrollOffset(),offset:scroll.getScrollOffset(),horizontal:scroll.horizontal,vertical:scroll.vertical,cssScaleX:scroll.node.worldScale.x*sx}:null,camera:a.map.cameraState()};
});}
function geometry(info){
 assert.ok(inside(info.bounds,info.canvas),'Herd UI fits the canvas');
 assert.equal(info.root,info.quick?'LivestockQuickBar':'GoldenIslandDialog');assert.equal(info.frameKey,info.quick?'info':'buildingWindow');
 assert.ok(info.labels.filter(l=>l.text).every(l=>/Poetsen/i.test(l.font)),'Herd UI uses scoped Poetsen font');
 if(info.quick){assert.ok(info.bounds.w<=560.3&&Math.abs(info.bounds.h-112)<.3,'Quickbar retains compact CSS size');assert.ok(Math.abs(info.canvas.h-bottom(info.bounds)-12)<.3,'Quickbar sits12CSS above bottom');}
 else{assert.ok(info.bounds.w<=760.3&&info.bounds.h<=360.3,'Five-slot modal fits the supported CSS envelope');assert.equal(info.controls.filter(c=>c.id.startsWith('choose-pen-')).length,0,'A pen modal has no species tabs');if(info.slots.length){assert.equal(info.scroll.horizontal,true);assert.equal(info.scroll.vertical,false);for(const slot of info.slots){assert.ok(Math.abs(slot.y-info.slots[0].y)<.3,'Five cards share one horizontal row');assert.ok(Math.abs(slot.w-144)<.3,'Each slot card retains its144CSS width');if(slot.index)assert.ok(Math.abs(slot.x-right(info.slots[slot.index-1])-10)<.3,'Cards retain10CSS gaps');assert.ok(slot.y>=info.scroll.mask.y-.3&&bottom(slot)<=bottom(info.scroll.mask)+.3,'Slot cards fit the row vertically');}assert.ok(info.scroll.max.x*info.scroll.cssScaleX>1,'Five144CSS cards overflow the supported viewport horizontally');}}
 const visible=[];
 for(const c of info.controls){assert.ok(c.w>=43.9&&c.h>=43.9,c.id+': target remains44CSS');
  if(!c.mask){assert.ok(inside(c,c.id==='close-panel'?info.canvas:info.bounds,c.id==='close-panel'?4:info.quick?6:12),c.id+': fixed action fits its frame');visible.push(c);}
  else{const part=intersection(c,c.mask);if(part.w>.5&&part.h>.5)visible.push({...c,...part});}
 }
 for(let i=0;i<visible.length;i++)for(let j=i+1;j<visible.length;j++)assert.ok(!overlap(visible[i],visible[j]),visible[i].id+' overlaps '+visible[j].id);
 for(const p of info.portraits){assert.ok(p.layers>0&&p.art.w>10&&p.art.h>20,'Animal portrait renders real layered artwork');assert.ok(inside(p.art,p.box),'Visible animal fits its portrait box');}
 for(const l of info.labels.filter(l=>l.text&&(!l.mask||inside(l,l.mask))))assert.ok(l.cssFont>=9.5,l.name+': text remains readable, got'+l.cssFont+'CSS');
 return info;
}
function recordScroll(page,evidence){const entries=scrollEvidence.get(page)??[];entries.push(evidence);scrollEvidence.set(page,entries);}
async function swipeRow(page,direction,distance){
 const before=await inspect(page),state=await snap(page),m=before.scroll.mask,canvas=await page.locator('#GameCanvas').boundingBox();
 let cdp=touchClients.get(page);if(!cdp){cdp=await page.context().newCDPSession(page);touchClients.set(page,cdp);}
 const amount=Math.min(distance,m.w-40),x=canvas.x+(direction==='left'?right(m)-18:m.x+18),y=canvas.y+m.y+Math.min(24,m.h/3),delta=direction==='left'?-amount:amount;
 await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{id:1,x,y}]});
 for(let i=1;i<=8;i++){await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{id:1,x:x+delta*i/8,y}]});await page.waitForTimeout(16);}
 await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});
 // Let elastic edge overshoot bounce back before stopping inertia; freezing it outside the legal range
 // would make a later render's legitimate clamp look like a lost scroll position.
 // Test and stop in the same browser task: a separate evaluate leaves a frame in which
 // inertia can cross the edge after the legal-range test but before stopAutoScroll.
 await page.waitForFunction(()=>{const s=testApp.panels.scroll;if(!s)return false;const x=s.getScrollOffset().x;if(x>.1||x<-s.getMaxScrollOffset().x-.1)return false;s.stopAutoScroll();return true;},undefined,{timeout:3000});
 // No scroll position is assigned by this helper.
 await page.waitForTimeout(65);
 const after=await inspect(page);assert.ok(after.scroll.offset.x<=.11&&after.scroll.offset.x>=-after.scroll.max.x-.11,'The swipe measurement must stay inside the legal scroll range');assert.deepEqual(after.camera,before.camera,'Dragging the slot row cannot move the map');assert.deepEqual(await snap(page),state,'Swiping slot cards cannot buy or feed animals');
 recordScroll(page,{kind:'swipe',direction,before:before.scroll.offset,after:after.scroll.offset,mapUnchanged:true,gameplayUnchanged:true});return after;
}
async function revealBox(page,id,isSlot=false){
 for(let i=0;i<40;i++){
  const info=await inspect(page),c=isSlot?info.slots.find(s=>s.index===id):info.controls.find(c=>c.id===id);assert.ok(c,String(id));const m=isSlot?info.scroll.mask:c.mask;
  if(!m||inside(c,m)){assert.ok(inside(c,info.bounds,info.quick?6:8),String(id)+': revealed action/card fits its frame');return info;}
  const clippedRight=Math.max(0,right(c)-right(m)),clippedLeft=Math.max(0,m.x-c.x);
  assert.ok(clippedRight>0||clippedLeft>0,'The horizontal row must not clip controls vertically');
  await swipeRow(page,clippedRight>0?'left':'right',Math.max(3,Math.min(m.w-40,Math.max(clippedRight,clippedLeft)+2)));
 }
 throw Error('Cannot fully reveal '+id);
}
const reveal=(page,id)=>revealBox(page,id,false);
async function preservedScroll(page,before,reason){
 if(!before.scroll)return;
 await page.waitForTimeout(300);const after=await inspect(page);assert.ok(after.scroll,reason+': row remains present');
 const delta=Math.abs(after.scroll.offset.x-before.scroll.offset.x)*before.scroll.cssScaleX;
 recordScroll(page,{kind:'preserved',reason,before:before.scroll.offset,after:after.scroll.offset,deltaCSS:delta,max:after.scroll.max});
 assert.ok(delta<=.8,reason+': horizontal offset changed by '+delta+'CSS');assert.ok(Math.abs(after.scroll.offset.y-before.scroll.offset.y)*before.scroll.cssScaleX<=.8,reason+': vertical offset changed');
}
async function click(page,id){const before=await reveal(page,id);await tap(page,id,true);if(/^(unlock-pen-slot-|animal-|sell-animal-|buy-animal-)/.test(id)||['feed-all','collect-all-animals','manage-herd','care-herd'].includes(id))await preservedScroll(page,before,id);}
async function traverseSlots(page){
 const first=await inspect(page);geometry(first);for(const slot of [0,1,2,3,4,3,2,1,0])geometry(await revealBox(page,slot,true));
 const evidence=scrollEvidence.get(page)??[];
 if(first.scroll.max.x*first.scroll.cssScaleX>1){assert.ok(evidence.some(e=>e.kind==='swipe'&&e.direction==='left'));assert.ok(evidence.some(e=>e.kind==='swipe'&&e.direction==='right'));}
}
async function openLockedPenFixture(page,id){await page.evaluate(id=>{const a=testApp;a.close();a.panels.penId=id;a.panels.livestockManagement=false;a.open('livestock');},id);}
async function waitEnabled(page,id,enabled){await page.waitForFunction(({id,enabled})=>farmCocos.controls().some(c=>c.id===id&&c.enabled===enabled),{id,enabled});}
async function openPen(page,id){await page.evaluate(id=>{testApp.close();testApp.map.focusBuilding('pen:'+id);},id);await page.waitForTimeout(80);await plot(page,id,true);await page.waitForFunction(id=>farmCocos.ui().selected===id,id);}
async function advance(page,seconds,id){const before=await inspect(page);await page.evaluate(seconds=>{const a=testApp;a.game.tick(seconds);a.game.validate();a.save();a.refresh();},seconds);await waitEnabled(page,id,true);await preservedScroll(page,before,'timer-ready');}
async function disabledTap(page,id){const before=await snap(page),info=await reveal(page,id),c=info.controls.find(c=>c.id===id);assert.equal(c.enabled,false);const b=await page.locator('#GameCanvas').boundingBox();await page.touchscreen.tap(b.x+c.x+c.w/2,b.y+c.y+c.h/2);await page.waitForTimeout(90);assert.deepEqual(await snap(page),before,id+': disabled input cannot mutate the herd or inventory');}


function slots(info, residents) {
 assert.deepEqual(info.slots.map(s=>s.index),[0,1,2,3,4],'Every owned pen displays all five slot cards');
 assert.equal(info.portraits.length,residents.animals.length);const names={layer:'gà','dairy-cow':'bò',pig:'heo',sheep:'cừu'};assert.deepEqual(info.labels.filter(l=>/^Chuồng /.test(l.text)).map(l=>l.text),['Chuồng '+names[residents.species]],'The modal describes only its selected pen');
 const locked=info.controls.filter(c=>c.id.startsWith('unlock-pen-slot-'));
 assert.deepEqual(locked.map(c=>Number(c.id.split('-').at(-1))).sort(),Array.from({length:5-residents.capacity},(_,i)=>i+residents.capacity));
 for(const button of locked)if(Number(button.id.split('-').at(-1))!==residents.capacity)assert.equal(button.enabled,false,'Later slots cannot bypass sequential unlock');
 for(const animal of residents.animals)assert.ok(Number.isInteger(animal.slot)&&animal.slot>=0&&animal.slot<residents.capacity,'Every resident persists its own open slot');
}
async function reload(page){
 await boot(page,page.url());
}
async function rapidUnlock(page,id){
 const info=await reveal(page,id),c=info.controls.find(c=>c.id===id),canvas=await page.locator('#GameCanvas').boundingBox();
 assert.equal(c.enabled,true);await page.mouse.click(canvas.x+c.x+c.w/2,canvas.y+c.y+c.h/2,{clickCount:2,delay:15});
 await page.waitForTimeout(120);await preservedScroll(page,info,id+' rapid-repeat');
}
async function funds(page,coins){await page.evaluate(coins=>{const a=testApp;a.game.state.coins=coins;a.save();a.refresh();},coins);}
async function restoreAndCheck(page,before,id){
 await page.evaluate(()=>testApp.save());await reload(page);assert.deepEqual(await snap(page),before,'Reload preserves coins, inventory, all slot IDs and jobs');
 await openPen(page,id);return mapHerd(page,id);
}

(async()=>{
 fs.mkdirSync(out,{recursive:true});
 const report={buildPath:build,startedAt:new Date().toISOString(),caseFilter:requested,
  fixture:'Fresh500 coins and zero feed check starter1+4locked slots and progression. Explicit20000 coins, milestones and later20 feed/species isolate real UI actions. All purchases, sequential unlocks, individual/bulk feed/collect, sale and slot refill use pointer input; only timers advance explicitly. Reload reuses this isolated context storage.',
  results:[],passed:false,cleanup:{serverClosed:false,browserClosed:false}};
 const save=()=>fs.writeFileSync(path.join(out,'results.json'),JSON.stringify(report,null,2)+'\n');save();const server=await serve();let browser;
 try {
  browser=await launch();
  for(const[width,height]of cases){
   const context=await browser.newContext({viewport:{width,height},hasTouch:true,isMobile:width<1000}),page=await context.newPage(),events=observe(page);
   const result={width,height,states:[],species:[],passed:false};report.results.push(result);save();
   const capture=async name=>{await page.waitForTimeout(140);const info=await inspect(page);result.states.push({name,...info});save();geometry(info);await page.screenshot({path:path.join(out,`${name}-${width}x${height}.png`)});return info;};
   try {
    await boot(page,server.url);await page.evaluate(()=>{testApp.game.dismissGuide();testApp.close();});await openPen(page,12);
    const fresh=await snap(page);assert.equal(fresh.coins,500);assert.equal(quantity(fresh,'farm40:chicken-feed'),0);
    await capture('fresh-quickbar');await disabledTap(page,'herd-feed');await disabledTap(page,'herd-collect');
    const camera=(await inspect(page)).camera,b=await page.locator('#GameCanvas').boundingBox(),q=(await inspect(page)).bounds;
    await page.mouse.move(b.x+q.x+q.w/2,b.y+q.y+8);await page.mouse.wheel(0,120);await page.mouse.down();await page.mouse.move(b.x+q.x+q.w/2+25,b.y+q.y+9,{steps:3});await page.mouse.up();assert.deepEqual((await inspect(page)).camera,camera,'Quickbar blocks map gestures');
    await click(page,'herd-manage');let info=await capture('fresh-one-open-four-locked');assert.equal(info.management,false,'Quickbar opens care slots directly');slots(info,pen(fresh,12));await traverseSlots(page);await capture('row-after-swipe-both-directions');
    await click(page,'manage-herd');info=await capture('fresh-selling');assert.ok(!info.controls.some(c=>/^animal-\d+$/.test(c.id)),'Selling mode has no feed/collect action');await click(page,'care-herd');
    for(const id of[14,15]){await openLockedPenFixture(page,id);const locked=await capture('locked-pen-'+id);assert.equal(locked.controls.find(c=>c.id==='purchase-pen').enabled,false);assert.equal(pen(await snap(page),id),null);await disabledTap(page,'purchase-pen');}
    await page.evaluate(()=>{const a=testApp,g=a.game;g.state.coins=20000;g.state.xp=620;g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};g.validate();a.save();a.refresh();});
    for(const id of[14,15]){
     await openLockedPenFixture(page,id);await waitEnabled(page,'purchase-pen',true);
     const definition=catalog.residentPens.find(p=>p.cell===id),type=catalog.livestock.find(s=>s.key===definition.species),before=await snap(page),price=definition.purchasePrice+type.price;
     await click(page,'purchase-pen');const after=await snap(page);assert.equal(after.coins,before.coins-price);assert.equal(pen(after,id).capacity,1);assert.equal(pen(after,id).animals.length,1);assert.equal(pen(after,id).animals[0].slot,0);
     slots(await capture(type.key+'-pen-includes-first-animal'),pen(after,id));
    }
    for(const definition of catalog.residentPens){
     const id=definition.cell,species=catalog.livestock.find(s=>s.key===definition.species);
     await openPen(page,id);await capture(species.key+'-quickbar');await click(page,'herd-manage');
     let before=await snap(page);assert.equal(pen(before,id).capacity,1);assert.equal(pen(before,id).animals.length,1);slots(await inspect(page),pen(before,id));
     const firstPrice=expansionFees[1]+species.price;await funds(page,firstPrice-1);await waitEnabled(page,'unlock-pen-slot-1',false);await disabledTap(page,'unlock-pen-slot-1');await funds(page,20000);
     const purchases=[];
     for(let slot=1;slot<5;slot++){
      const control='unlock-pen-slot-'+slot,price=expansionFees[slot]+species.price;await waitEnabled(page,control,true);
      const visible=await inspect(page),button=visible.controls.find(c=>c.id===control);assert.ok(button.text.includes(String(price)),'Locked slot displays the complete slot-plus-animal price');
      before=await snap(page);if(slot===1)await rapidUnlock(page,control);else await click(page,control);
      await page.waitForFunction(({id,capacity})=>testApp.game.residentPlot(id).residents.capacity===capacity,{id,capacity:slot+1});
      const after=await snap(page),old=pen(before,id),current=pen(after,id);
      assert.equal(after.coins,before.coins-price,'Unlocking one slot charges its bundle exactly once');assert.equal(current.capacity,slot+1);assert.equal(current.animals.length,slot+1);
      assert.deepEqual(current.animals.filter(a=>old.animals.some(b=>b.id===a.id)),old.animals,'An unlock preserves existing resident IDs and slots');
      const added=current.animals.filter(a=>!old.animals.some(b=>b.id===a.id));assert.equal(added.length,1);assert.equal(added[0].slot,slot);assert.equal(added[0].job,null);
      slots(await capture(species.key+'-opened-slot-'+(slot+1)),current);purchases.push({slot,price,animal:added[0].id,rapidRepeat:slot===1});
     }
     before=await snap(page);assert.equal(await page.evaluate(id=>!!testApp.game.expandPen(id).error,id),true,'Domain also rejects capacity beyond five');assert.deepEqual(await snap(page),before);assert.ok(!(await inspect(page)).controls.some(c=>c.id.startsWith('unlock-pen-slot-')));
     await openPen(page,id);const initialMap=await mapHerd(page,id);fiveMapResidents(initialMap);await page.screenshot({path:path.join(out,`${species.key}-five-on-map-${width}x${height}.png`)});
     await page.evaluate(key=>{const a=testApp;a.game.state.inventory[key]=20;a.save();a.refresh();},species.feed);await click(page,'herd-manage');
     const ids=pen(await snap(page),id).animals.slice().sort((a,b)=>a.slot-b.slot).map(a=>a.id);
     before=await snap(page);await click(page,'animal-'+ids[4]);let fed=await snap(page);assert.equal(quantity(fed,species.feed),quantity(before,species.feed)-1);assert.ok(pen(fed,id).animals.find(a=>a.id===ids[4]).job);assert.equal(pen(fed,id).animals.filter(a=>!a.job).length,4);
     const mixed=await capture(species.key+'-one-eating-four-hungry');assert.equal(mixed.slots[4].status,'Đang ăn');assert.ok(mixed.slots.slice(0,4).every(s=>s.status==='Đói'));assert.ok(Math.abs(mixed.scroll.offset.x)*mixed.scroll.cssScaleX>1,'Feeding checks preservation at a nonzero scroll offset');await click(page,'feed-all');fed=await snap(page);assert.equal(quantity(fed,species.feed),quantity(before,species.feed)-5);assert.ok(pen(fed,id).animals.every(a=>a.job));await waitEnabled(page,'feed-all',false);await disabledTap(page,'feed-all');assert.ok((await capture(species.key+'-five-eating')).slots.every(s=>s.status==='Đang ăn'));
     const loadedMap=await restoreAndCheck(page,fed,id);fiveMapResidents(loadedMap);assert.deepEqual(loadedMap.slots,initialMap.slots,'Map slots survive reload with running jobs');await click(page,'herd-manage');
     await click(page,'manage-herd');for(const animalId of ids)await waitEnabled(page,'sell-animal-'+animalId,false);await disabledTap(page,'sell-animal-'+ids[0]);await click(page,'care-herd');
     await revealBox(page,4,true);await advance(page,species.duration+1,'collect-all-animals');const readySlots=await capture(species.key+'-five-ready'),readyLabel=({layer:'Có trứng','dairy-cow':'Có sữa',pig:'Có thịt',sheep:'Có len'})[species.key];assert.ok(readySlots.slots.every(s=>s.status===readyLabel&&s.product),'Each ready slot displays its own named product and icon');const output=quantity(await snap(page),species.output);await click(page,'animal-'+ids[0]);assert.equal(quantity(await snap(page),species.output),output+species.quantity);await click(page,'collect-all-animals');assert.equal(quantity(await snap(page),species.output),output+5*species.quantity);assert.ok(pen(await snap(page),id).animals.every(a=>!a.job));await waitEnabled(page,'collect-all-animals',false);await disabledTap(page,'collect-all-animals');
     await openPen(page,id);assert.deepEqual((await mapHerd(page,id)).slots,initialMap.slots);before=await snap(page);await click(page,'herd-feed');assert.equal(quantity(await snap(page),species.feed),quantity(before,species.feed)-5);await advance(page,species.duration+1,'herd-collect');await capture(species.key+'-quickbar-five-ready');const ready=await snap(page);await click(page,'herd-collect');assert.equal(quantity(await snap(page),species.output),quantity(ready,species.output)+5*species.quantity);
     await click(page,'herd-manage');await click(page,'manage-herd');before=await snap(page);const removed=ids[2];await click(page,'sell-animal-'+removed);let sold=await snap(page);assert.equal(sold.coins,before.coins+Math.floor(species.price/2));assert.equal(pen(sold,id).capacity,5);assert.equal(pen(sold,id).animals.length,4);assert.ok(!pen(sold,id).animals.some(a=>a.slot===2));slots(await capture(species.key+'-empty-paid-slot'),pen(sold,id));
     const gapMap=await restoreAndCheck(page,sold,id);assert.deepEqual(gapMap.slots,initialMap.slots.filter(s=>s.animal!==removed),'Removing a middle resident preserves four slots through reload');await click(page,'herd-manage');
     before=await snap(page);await click(page,'buy-animal-2');const replaced=await snap(page);assert.equal(replaced.coins,before.coins-species.price);assert.equal(pen(replaced,id).capacity,5);assert.equal(pen(replaced,id).animals.length,5);
     const replacement=pen(replaced,id).animals.find(a=>!pen(before,id).animals.some(b=>b.id===a.id));assert.ok(replacement);assert.equal(replacement.slot,2);assert.deepEqual(pen(replaced,id).animals.filter(a=>a.id!==replacement.id),pen(before,id).animals);
     const replacementMap=await restoreAndCheck(page,replaced,id);fiveMapResidents(replacementMap);assert.deepEqual(replacementMap.slots.filter(s=>s.animal!==replacement.id),initialMap.slots.filter(s=>s.animal!==removed),'Refill and reload preserve all four surviving positions');
     await click(page,'herd-manage');await click(page,'find-animal-feed');assert.equal(await page.evaluate(()=>testApp.panels.view),'factory');const feedRecipe=catalog.products.find(r=>(r.outputs??[{key:'goods:'+r.id}]).some(o=>o.key===species.feed));assert.equal(await page.evaluate(()=>testApp.panels.selectedRecipeId),feedRecipe.id);
     result.species.push({species:species.key,pen:id,purchases,insufficientFundsBlocked:true,maxFiveBlocked:true,individualAndBulkFeed:true,individualAndBulkCollect:true,quickbarFeedCollect:true,exactInventoryChanges:true,jobAndSlotReload:true,saleAndRefillPreserveSlots:true,initialMap,replacementMap,feedSourceRecipe:feedRecipe.id});save();
    }
    assert.equal(result.species.length,4);assert.deepEqual(events.errors,[]);result.errors=[];result.scrollChecks=scrollEvidence.get(page)??[];result.passed=true;console.log(`${width}x${height}: five slots, four species, bundled purchases, real actions and persistent positions PASS`);
   }catch(error){result.error=String(error);result.stack=error.stack;result.errors=events.errors;result.scrollChecks=scrollEvidence.get(page)??[];result.diagnostic=await inspect(page).catch(e=>({error:String(e)}));await page.screenshot({path:path.join(out,`failure-${width}x${height}.png`)});console.error(`${width}x${height}: ${error}`);}
   finally{save();await context.close();}
  }
  assert.ok(report.results.every(r=>r.passed),'Every selected livestock viewport must pass');report.passed=true;
 }catch(error){report.error=String(error);report.stack=error.stack;throw error;}
 finally{await server.close();report.cleanup.serverClosed=true;save();if(browser)await browser.close();report.cleanup.browserClosed=true;report.finishedAt=new Date().toISOString();save();}
})().catch(e=>{console.error(e);process.exitCode=1;});
