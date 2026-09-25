'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, observe, build } = require('./browser-support.cjs');
const out = process.env.COCOS_CAMERA_OUT ? path.resolve(process.env.COCOS_CAMERA_OUT) : path.resolve(__dirname, '../artifacts/camera-limits');
const close = (a, b, reason) => assert.ok(Math.abs(a - b) < 1e-5, `${reason}: ${a} ≈ ${b}`);
async function measure(page) {
 return page.evaluate(() => {
  const a=testApp,m=a.map,cc=testCc,e=document.querySelector('#GameCanvas').getBoundingClientRect(),vp=cc.view.getViewportRect(),canvas=cc.view.getCanvasSize();
  const x=v=>(vp.x+v*cc.view.getScaleX())/canvas.width*e.width,y=v=>e.height-(vp.y+v*cc.view.getScaleY())/canvas.height*e.height;
  const sprites=n=>n.getComponentsInChildren(cc.Sprite).filter(s=>s.node.activeInHierarchy&&s.spriteFrame).map(s=>s.node.getComponent(cc.UITransform).getBoundingBoxToWorld());
  const rect=boxes=>({left:x(Math.min(...boxes.map(b=>b.xMin))),right:x(Math.max(...boxes.map(b=>b.xMax))),top:y(Math.max(...boxes.map(b=>b.yMax))),bottom:y(Math.min(...boxes.map(b=>b.yMin)))});
  const objects=[...[...m.itemRenderer.crops].map(([id,v])=>({id:'crop:'+id,...rect(sprites(v.root))})),...[...m.town.yards].map(([id,v])=>({id:'pen:'+id,...rect([...sprites(v.node),...sprites(v.front),v.badge.getComponent(cc.UITransform).getBoundingBoxToWorld()])}))];
  const fit=m.homeFit(),full={...fit.bounds};
  for(const type of a.game.machineTypes){const id=type.buildingIds[0],b=m.town.machineBounds(type.prefab,m.movement.position(id));full.left=Math.min(full.left,b.left);full.right=Math.max(full.right,b.right);full.bottom=Math.min(full.bottom,b.bottom);full.top=Math.max(full.top,b.top);}
  const formerWholeFarmScale=Math.min(m.width/(full.right-full.left+90),(m.height-m.inset.top-m.inset.bottom)/(full.top-full.bottom+90));
  const crop=m.model.plotPositions().find(p=>p.plot.group==='crop'),b=m.model.widgetBounds([{...crop.cell.widget,matrix:crop.cell.matrix}]);
  return{camera:m.cameraState(),zoom:m.camera.zoom,minZoom:m.camera.minZoom,scale:m.camera.scale,homeZoom:fit.zoom,homeBounds:fit.bounds,formerWholeFarmScale,fieldCssWidth:(b.right-b.left)*m.camera.displayScale/a.width*e.width,objects,free:{left:0,right:e.width,top:104/a.height*e.height,bottom:e.height-196/a.height*e.height}};
 });
}
function homeFits(state, penCount=4) {
 assert.equal(state.camera.mode,'home');close(state.zoom,state.minZoom,'Home uses zoom-out limit');close(state.homeZoom,state.minZoom,'Limit comes from actual central bounds');
 assert.equal(state.objects.filter(o=>o.id.startsWith('crop:')).length,40);assert.equal(state.objects.filter(o=>o.id.startsWith('pen:')).length,penCount);
 for(const b of state.objects)assert.ok(Number.isFinite(b.left)&&b.left>=state.free.left-1&&b.right<=state.free.right+1&&b.top>=state.free.top-1&&b.bottom<=state.free.bottom+1,`${b.id} fits central Home: ${JSON.stringify(b)}`);
 assert.ok(state.camera.displayScale>state.formerWholeFarmScale*1.2,'The limit is materially closer than the former whole-farm/forest view');
}
(async()=>{
 fs.mkdirSync(out,{recursive:true});const server=await serve(),browser=await launch(),results=[];
 const save=extra=>fs.writeFileSync(path.join(out,'validation.json'),JSON.stringify({build,results,...extra},null,2)+'\n');
 try{
  for(const [width,height]of [[1280,720],[390,844],[320,568],[844,390],[568,320]]){
   const context=await browser.newContext({viewport:{width,height},hasTouch:true,isMobile:true}),page=await context.newPage(),observed=observe(page),cdp=await context.newCDPSession(page);
   const result={width,height};
   try{
    await boot(page,server.url);await page.evaluate(()=>{testApp.game.dismissGuide();testApp.close();testApp.focusHome();testApp.refresh();});await page.waitForTimeout(160);
    result.fresh=await measure(page);homeFits(result.fresh,2);
    const freshSites=await page.evaluate(()=>{const a=testApp,m=a.map,hidden=[...a.game.machineTypes.filter(t=>!a.game.state.machines.some(x=>x.type===t.id)).map(t=>t.buildingIds[0]),'pen:14','pen:15'],camera=m.cameraState();return{yards:[...m.town.yards.keys()],machines:[...m.town.buildings.keys()].sort(),owned:a.game.state.machines.map(x=>x.buildingId).sort(),targets:m.targets().length,hiddenFocus:hidden.map(id=>({id,focused:m.focusBuilding(id)})),cameraUnchanged:JSON.stringify(camera)===JSON.stringify(m.cameraState())};});
    assert.deepEqual(freshSites.yards,[12,13]);assert.equal(freshSites.targets,42);assert.equal(freshSites.machines.length,3);assert.deepEqual(freshSites.machines,freshSites.owned);assert.ok(freshSites.hiddenFocus.every(x=>!x.focused)&&freshSites.cameraUnchanged);result.freshSites=freshSites;
    await page.screenshot({path:path.join(out,`fresh-home-${width}x${height}.png`)});
    // Geometry fixture: construct the full farm through domain purchases so all eight outer
    // workshops and all four yards still exercise the strongest pan/fit boundary below.
    await page.evaluate(()=>{const a=testApp,g=a.game,ok=r=>{if(r.error)throw Error(r.error);};g.state.coins=20000;g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};for(const id of [14,15])ok(g.buyPen(id));for(const t of g.machineTypes)if(!g.state.machines.some(m=>m.type===t.id))ok(g.buyMachine(t.id));a.refresh();a.focusHome();});await page.waitForTimeout(120);
    result.home=await measure(page);homeFits(result.home);await page.screenshot({path:path.join(out,`home-${width}x${height}.png`)});
    async function wheel(delta,count){const box=await page.locator('#GameCanvas').boundingBox();await page.mouse.move(box.x+box.width*.94,box.y+box.height*.46);for(let i=0;i<count;i++){await page.mouse.wheel(0,delta);await page.waitForTimeout(22);}await page.waitForTimeout(90);}
    await wheel(120,30);const atFloor=await measure(page);close(atFloor.zoom,atFloor.minZoom,'Repeated real wheel-out clamps');assert.deepEqual(atFloor.camera,result.home.camera,'Rejected wheel-out preserves automatic Home and center');
    await wheel(-120,5);assert.ok((await measure(page)).zoom>atFloor.minZoom,'Real wheel-in remains available');
    const box=await page.locator('#GameCanvas').boundingBox(),center={x:box.x+box.width*.5,y:box.y+box.height*.43},distance=Math.min(100,box.width*.28);
    const touches=d=>[{x:center.x-d,y:center.y,id:1},{x:center.x+d,y:center.y,id:2}];
    await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:touches(distance)});await page.waitForTimeout(40);await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:touches(3)});await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});await page.waitForTimeout(100);
    const pinched=await measure(page);close(pinched.zoom,pinched.minZoom,'Real pinch-out clamps at central Home limit');result.wheelAndPinchClamped=true;
    await wheel(-120,5);
    await page.mouse.move(box.x+box.width*.83,box.y+box.height*.48);await page.mouse.down();await page.mouse.move(box.x+box.width*.75,box.y+box.height*.54,{steps:4});await page.mouse.up();await page.waitForTimeout(100);
    const manual=await measure(page);assert.equal(manual.camera.mode,'manual');
    await page.setViewportSize({width:height,height:width});await page.waitForTimeout(650);const rotated=await measure(page);
    close(rotated.camera.displayScale,Math.max(manual.camera.displayScale,rotated.minZoom*rotated.scale),'Manual resize preserves scale unless new floor requires closer');
    close(rotated.camera.x,manual.camera.x,'Manual resize preserves map x');close(rotated.camera.y,manual.camera.y,'Manual resize preserves map y');assert.equal(rotated.camera.mode,'manual');
    await page.evaluate(()=>{testApp.close();testApp.focusHome();});await page.waitForTimeout(100);homeFits(await measure(page));
    await wheel(120,5);assert.equal((await measure(page)).camera.mode,'home');
    await page.setViewportSize({width,height});await page.waitForTimeout(650);homeFits(await measure(page));result.homeAndManualResize=true;
    // The closer floor must still allow panning to every workshop around the central farm.
    result.reached=[];
    const types=await page.evaluate(()=>testApp.game.machineTypes.map(t=>({id:t.buildingIds[0],prefab:t.prefab})));
    for(const type of types){
     await page.evaluate(type=>{const m=testApp.map,c=m.camera,p=m.movement.position(type.id),b=m.town.machineArtBounds(type.prefab,p),state=c.state();
      c.panBy((state.x-(b.left+b.right)/2)*c.displayScale,(state.y-(b.bottom+b.top)/2)*c.displayScale+(m.inset.bottom-m.inset.top)/2);m.update();},type);
     await page.waitForTimeout(70);
     const reached=await page.evaluate(type=>{const m=testApp.map,c=m.camera,b=m.town.machineBounds(type.prefab,m.movement.position(type.id)),state=c.state(),s=c.displayScale;return{bounds:{left:(b.left-state.x)*s,right:(b.right-state.x)*s,bottom:(b.bottom-state.y)*s,top:(b.top-state.y)*s},free:{left:-m.width/2,right:m.width/2,bottom:-m.height/2+m.inset.bottom,top:m.height/2-m.inset.top},zoom:c.zoom,minZoom:c.minZoom,active:m.town.buildings.get(type.id).node.activeInHierarchy};},type);
     const {bounds:b,free:f}=reached;
     assert.ok(reached.active&&b.left>=f.left-1&&b.right<=f.right+1&&b.bottom>=f.bottom-1&&b.top<=f.top+1,type.id+' art and badge remain reachable by pan: '+JSON.stringify(reached));close(reached.zoom,reached.minZoom,'Panning never bypasses the floor');result.reached.push(type.id);
    }
    assert.deepEqual(observed.errors,[]);result.errors=[];results.push(result);save({passed:false,status:'running'});console.log(`${width}x${height}: central Home, wheel/pinch limits, manual resize and pan to all8 workshops passed`);
   }catch(error){await page.screenshot({path:path.join(out,`failure-${width}x${height}.png`)});save({passed:false,error:String(error),current:result,latest:await measure(page),errors:observed.errors});throw error;}
   finally{await context.close();}
  }
  save({passed:true,viewports:results.length,errors:[]});
 }finally{
  await browser.close();await server.close();
  const reportPath=path.join(out,'validation.json');
  if(fs.existsSync(reportPath)){const report=JSON.parse(fs.readFileSync(reportPath,'utf8'));report.cleanupComplete=true;fs.writeFileSync(reportPath,JSON.stringify(report,null,2)+'\n');}
 }
})().catch(error=>{console.error(error);process.exitCode=1;});
