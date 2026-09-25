'use strict';
// Real render/input checks for imported scenery, source pivots, shared forest and depth/culling.
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),http=require('node:http');
const {chromium}=require('playwright');
const build=process.env.COCOS_TEST_BUILD?path.resolve(process.env.COCOS_TEST_BUILD):path.resolve(__dirname,'../build/farm-web-mobile'),out=process.env.COCOS_DECOR_OUT?path.resolve(process.env.COCOS_DECOR_OUT):path.resolve(__dirname,'../artifacts/farm-beautify');
const server=http.createServer((req,res)=>{if(req.url==='/favicon.ico')return res.writeHead(204).end();let file=path.resolve(build,'.'+decodeURIComponent(new URL(req.url,'http://localhost').pathname));if(file===build)file=path.join(build,'index.html');if(!file.startsWith(build+path.sep)||!fs.existsSync(file)||!fs.statSync(file).isFile())return res.writeHead(404).end();res.setHeader('Content-Type',({'.html':'text/html','.js':'text/javascript','.json':'application/json','.png':'image/png','.css':'text/css','.wasm':'application/wasm'})[path.extname(file)]||'application/octet-stream');fs.createReadStream(file).pipe(res)});
(async()=>{
 await new Promise(r=>server.listen(0,'127.0.0.1',r));const browser=await chromium.launch({headless:true,channel:process.env.PLAYWRIGHT_CHANNEL||'chromium'}),errors=[],results=[];
 fs.mkdirSync(out,{recursive:true});
 try {
  const page=await browser.newPage({viewport:{width:1280,height:720},hasTouch:true});
  page.on('pageerror',e=>errors.push(e.message));page.on('console',m=>{if(m.type()==='error')errors.push(m.text())});page.on('response',r=>{if(r.status()>=400)errors.push(r.status()+' '+r.url())});
  await page.goto('http://127.0.0.1:'+server.address().port);await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});
  await page.evaluate(async()=>{const cc=await System.import('cc');globalThis.decorApp=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp');decorApp.game.dismissGuide();decorApp.close();decorApp.refresh();decorApp.map.focusHome();});
  const catalog=JSON.parse(fs.readFileSync(path.resolve(__dirname,'../assets/farm/prefabs/items/catalog.json')));
  const source=JSON.parse(fs.readFileSync(path.resolve(__dirname,'../source-assets/farm-beautify/manifest.json')));
  const ground=await page.evaluate(()=>decorApp.map.groundDecor.length);
  assert.equal(ground,catalog.groundDecorInstances);
  const contract=await page.evaluate(()=>({items:decorApp.game.items.length,recipes:decorApp.game.catalog.products.length,crops:decorApp.game.catalog.farm.length,plots:decorApp.game.state.plots.length,targets:farmCocos.targets().length}));
  assert.deepEqual(contract,{items:35,recipes:23,crops:8,plots:50,targets:42});
  const fresh=await page.evaluate(()=>({yards:[...decorApp.map.town.yards.keys()],machines:[...decorApp.map.town.buildings.keys()].sort(),owned:decorApp.game.state.machines.map(m=>m.buildingId).sort(),buildings:farmCocos.buildings().length}));
  assert.deepEqual(fresh.yards,[12,13]);assert.equal(fresh.machines.length,3);assert.deepEqual(fresh.machines,fresh.owned);assert.equal(fresh.buildings,5,'only owned machines and the two facilities have hit targets');
  // Source geometry fixture: construct the full neighborhood with domain purchases before
  // checking all ten building taps, all four yards, source pivots, culling and painter order.
  await page.evaluate(()=>{const a=decorApp,g=a.game,ok=r=>{if(r.error)throw Error(r.error);};g.state.coins=20000;g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};for(const id of [14,15])ok(g.buyPen(id));for(const t of g.machineTypes)if(!g.state.machines.some(m=>m.type===t.id))ok(g.buyMachine(t.id));a.refresh();a.map.focusHome();a.map.update();});
  assert.deepEqual(await page.evaluate(()=>({yards:decorApp.map.town.yards.size,machines:decorApp.map.town.buildings.size,targets:farmCocos.targets().length})),{yards:4,machines:8,targets:44});
  const previews=await page.evaluate(()=>decorApp.map.layout.livestock.flatMap(n=>n.children.map(c=>c.activeInHierarchy)));
  assert.deepEqual(previews,[],'obsolete editor pen and pond previews are removed from the authored map');
  // Source pivots must reach the instantiated sprite, including noncentral and trimmed road pivots.
  const poses=await page.evaluate(async()=>{const cc=await System.import('cc'),m=decorApp.map;return [...m.decor,...m.groundDecor].filter(e=>!m.marginScenery.includes(e.node)).map(e=>{const item=e.node.children[0],visual=item.getChildByName('Visual'),t=item.getComponent(cc.UITransform);return {asset:item.name,x:visual.position.x,y:visual.position.y,anchor:[t.anchorX,t.anchorY],frame:!!visual.getComponent(cc.Sprite).spriteFrame}})});
  for(const pose of poses){const asset=source.images.find(a=>a.id===pose.asset);assert.ok(asset&&pose.frame);assert.ok(Math.abs(pose.x-(.5-asset.anchor[0])*asset.width)<.002);assert.ok(Math.abs(pose.y-(.5-asset.anchor[1])*asset.height)<.002);}
  const removedPatches=new Set(['GiPatchMeadow1','GiPatchMeadow2','GiPatchMeadow3','GiPatchGrass1','GiPatchGrass2','GiPatchGrass3']);
  assert.ok(poses.every(p=>!removedPatches.has(p.asset)),'removed grass/meadow patches never appear in the map');
  const authored=JSON.parse(fs.readFileSync(path.resolve(__dirname,'../source-assets/farm-beautify/placements.json')));
  const roads=authored.placements.filter(p=>p.zone==='roads');
  const roadPoses=await page.evaluate(()=>decorApp.map.groundDecor.filter(e=>e.node.name.startsWith('Road-')).map(e=>({id:e.node.name,x:e.node.position.x,y:e.node.position.y,scale:e.node.scale.x,scaleY:e.node.scale.y})));
  assert.deepEqual(roadPoses,roads.map(p=>({id:p.id,x:p.x,y:p.y,scale:p.scale,scaleY:p.scale})));
  assert.deepEqual(roads,[],'no road placements remain in the authored map');
  assert.deepEqual(roadPoses,[],'no road nodes remain at runtime');
  assert.ok(poses.every(p=>!p.asset.startsWith('DecorRoad')));
  const border=authored.placements.filter(p=>p.zone==='rock-border'),borderKinds=new Set(border.map(p=>p.asset));
  const borderImages=source.images.filter(a=>borderKinds.has(a.id)).map(a=>({...a,src:'data:image/png;base64,'+fs.readFileSync(path.resolve(__dirname,'..',a.runtimeImage)).toString('base64')}));
  const borderRaster=await page.evaluate(async({border,assets})=>{
   const images=new Map(await Promise.all(assets.map(a=>new Promise(resolve=>{const img=new Image();img.onload=()=>{const c=document.createElement('canvas');c.width=a.width;c.height=a.height;const ctx=c.getContext('2d');ctx.drawImage(img,0,0);resolve([a.id,{...a,pixels:ctx.getImageData(0,0,c.width,c.height).data}]);};img.src=a.src}))));
   const box=p=>{const a=images.get(p.asset);return {a,left:p.x-a.width*a.anchor[0]*p.scale,right:p.x+a.width*(1-a.anchor[0])*p.scale,bottom:p.y-a.height*a.anchor[1]*p.scale,top:p.y+a.height*(1-a.anchor[1])*p.scale};};
   let minOverlap=Infinity,worstPair=[];
   for(let i=0;i<border.length;i++){
    const p=border[i],q=border[(i+1)%border.length],a=box(p),b=box(q);let overlap=0;
    for(let y=Math.ceil(Math.max(a.bottom,b.bottom));y<Math.min(a.top,b.top);y++)for(let x=Math.ceil(Math.max(a.left,b.left));x<Math.min(a.right,b.right);x++){
     const alpha=(s,scale)=>s.a.pixels[(Math.floor((s.top-y)/scale)*s.a.width+Math.floor((x-s.left)/scale))*4+3];
     if(alpha(a,p.scale)>=180&&alpha(b,q.scale)>=180)overlap++;
    }
    if(overlap<minOverlap){minOverlap=overlap;worstPair=[p.id,q.id];}
   }
   return {pairs:border.length,kinds:images.size,minOverlap,worstPair};
  },{border,assets:borderImages});
  assert.equal(borderRaster.kinds,6);
  assert.ok(borderRaster.minOverlap>0,'mixed stones remain visibly connected at every join, including corners: '+JSON.stringify(borderRaster));
  const viewpoints=[['desktop',{width:1280,height:720}],['portrait',{width:390,height:844}],['landscape',{width:844,height:390}],['small',{width:320,height:568}]];
  for(const [name,viewport]of viewpoints){
   await page.setViewportSize(viewport);await page.waitForTimeout(180);await page.evaluate(()=>{decorApp.map.focusHome();decorApp.map.update()});
   const map=await page.evaluate(()=>farmCocos.map());
   assert.equal(map.decor.standing,catalog.decorInstances+map.decor.marginScenery);
   assert.equal(new Set(map.decor.instances.map(i=>i.name)).size,map.decor.standing,'one scenery object per stable grid identity');
   assert.ok(map.decor.instances.every(i=>i.frame&&i.linked));assert.equal(map.decor.species.length,12);
   const display=map.camera.displayScale;
   assert.ok(display>0&&map.decor.active>0&&map.decor.active<map.decor.standing);
   results.push({name,standing:map.decor.standing,active:map.decor.active,margin:map.decor.marginScenery,render:map.render,textures:map.decor.textures});
   await page.screenshot({path:path.join(out,'checked-'+name+'.png')});
  }
  await page.setViewportSize({width:1280,height:720});await page.waitForTimeout(180);await page.evaluate(()=>decorApp.map.focusHome());
  async function clickControl(id){const t=await page.evaluate(id=>farmCocos.controls().find(t=>t.id===id),id);assert.ok(t,id);const b=await page.locator('#GameCanvas').boundingBox();await page.mouse.click(b.x+t.x*b.width,b.y+t.y*b.height);await page.waitForTimeout(100);}
  const sites=await page.evaluate(()=>farmCocos.buildings().map(t=>({buildingId:t.buildingId,expected:typeof t.id==='number'?'factory':t.view.split(':')[0]})));
  assert.equal(sites.length,10);
  for(const site of sites){
   await page.evaluate(id=>{decorApp.map.focusBuilding(id);decorApp.map.update();},site.buildingId);await page.waitForTimeout(100);
   const t=await page.evaluate(id=>farmCocos.buildings().find(t=>t.buildingId===id),site.buildingId),b=await page.locator('#GameCanvas').boundingBox();
   await page.mouse.click(b.x+t.screen.x*b.width,b.y+t.screen.y*b.height);await page.waitForTimeout(100);
   assert.equal(await page.evaluate(()=>farmCocos.ui().view),site.expected,'decor leaves the '+site.buildingId+' tap target accessible');
   await clickControl('close-panel');
  }
  // A canopy stays visible when the root has left the viewport, then disappears only once its bounds leave.
  const cull=await page.evaluate(()=>{
   const m=decorApp.map,s=m.camera.scale*m.camera.maxZoom,c=m.camera,halfW=m.width/(2*s),halfH=m.height/(2*s),maxX=Math.max(0,(c.reach.right-c.reach.left)/2-halfW);
   // The enlarged clearing has no trees at the old hardcoded central strip. Pick a real
   // canopy whose two edge positions can both be reached without hitting the camera clamp.
   const t=m.decor.filter(e=>e.node.name.startsWith('Forest-')&&e.bounds.yMax>e.node.position.y+24
    &&Math.abs(e.node.position.x-c.center.x)<maxX-1&&e.node.position.y+12>=c.reach.bottom
    &&e.bounds.yMax+12+2*halfH<c.reach.top).sort((a,b)=>Math.hypot(a.node.position.x-c.center.x,a.node.position.y-c.center.y)-Math.hypot(b.node.position.x-c.center.x,b.node.position.y-c.center.y))[0];
   if(!t)throw Error('No reachable tree canopy in culling fixture');
   const place=bottom=>{m.camera.lookAt(t.node.position.x,bottom+m.height/(2*s),m.camera.maxZoom,'manual');m.update();return {bottom:(-m.height/2-m.world.position.y)/m.camera.displayScale,active:t.node.activeInHierarchy};};
   return {root:t.node.position.y,top:t.bounds.yMax,partlyVisible:place(t.node.position.y+12),fullyOutside:place(t.bounds.yMax+12)};
  });
  assert.ok(cull.root<cull.partlyVisible.bottom&&cull.top>cull.partlyVisible.bottom);assert.equal(cull.partlyVisible.active,true);assert.equal(cull.fullyOutside.active,false);
  await page.evaluate(()=>{const a=decorApp,g=a.game;g.state.coins=100000;for(const [i,p]of g.state.plots.filter(p=>p.group==='crop').entries()){const r=g.plant(p.id,g.catalog.farm[i%8].id);if(r.error)throw Error(r.error)}a.refresh();a.map.focusHome();a.map.update();});
  const depth=await page.evaluate(()=>{const m=decorApp.map,items=[...m.decor.map(e=>({y:e.node.position.y,index:e.node.getSiblingIndex()})),...m.liveRoot.children.filter(n=>n.name.startsWith('Crop-')).map(n=>({y:n.position.y,index:n.getSiblingIndex()}))];items.sort((a,b)=>b.y-a.y||a.index-b.index);return items.every((x,i)=>i===0||x.index>items[i-1].index)});
  assert.ok(depth,'standing decor and crops share a single ground-based draw order');
  await page.evaluate(()=>{decorApp.game.validate();decorApp.save()});const saved=await page.evaluate(()=>farmCocos.pack());
  await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);assert.equal((await page.evaluate(()=>farmCocos.pack())).free.plots.filter(p=>p.crop!==null).length,40);assert.equal(saved.free.plots.length,50);
  assert.deepEqual(errors,[]);
  const report={passed:true,build,fresh,sourceImages:source.images.length,pivotsChecked:poses.length,roadsRemoved:true,borderRaster,removedPatches:[...removedPatches],contract,viewports:results,siteTaps:sites.length,culling:cull,depthOrder:depth,saveReload:true,errors};
  fs.writeFileSync(path.join(out,'browser-validation.json'),JSON.stringify(report,null,2)+'\n');console.log('Decor: source pivots, four viewports, ten building taps, canopy culling, depth order and save/reload OK.');
 } finally {await browser.close();await new Promise(r=>{server.close(r);server.closeAllConnections?.();});}
})().catch(e=>{console.error(e);server.close();process.exitCode=1});
