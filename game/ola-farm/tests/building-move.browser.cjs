'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, observe } = require('./browser-support.cjs');
require('tsx/cjs');
const { FARM_LAYOUT, EMPTY_LAYOUT, buildingPosition, checkLayout, movedLayout, snapPosition } = require('../assets/farm/scripts/core/BuildingPlacement.ts');
const { farmRoadLayout } = require('../assets/farm/scripts/core/FarmRoadLayout.ts');
const out = path.resolve(__dirname, '../artifacts/building-move');
function alternative(id) {
  const p = buildingPosition(id);
  for (let r = 2; r <= 12; r++) for (const [dx,dy] of [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,1],[1,-1],[-1,-1]]) {
    const q = snapPosition({x:p.x+dx*r*36,y:p.y+dy*r*18});
    if (!checkLayout(movedLayout(EMPTY_LAYOUT,id,q)).error) return q;
  }
  throw Error('No alternative '+id);
}
(async () => {
  const server = await serve(), browser = await launch(), results = [];
  fs.mkdirSync(out, { recursive: true });
  try {
    for (const [width,height,touch] of [[1280,720,false],[390,844,true],[844,390,true],[320,568,true]]) {
      const page = await browser.newPage({viewport:{width,height},hasTouch:touch}), observed = observe(page);
      const cdp = touch ? await page.context().newCDPSession(page) : null;
      await boot(page,server.url);
      assert.deepEqual((await page.evaluate(()=>farmCocos.map().roads.tiles)).sort((a,b)=>a.id.localeCompare(b.id)),farmRoadLayout(FARM_LAYOUT).tiles.map(({id,x,y,asset})=>({id,x,y,asset})).sort((a,b)=>a.id.localeCompare(b.id)),'runtime retains the authored road tiles');
      const fixture = await page.evaluate(() => {
        const a=testApp,g=a.game,ok=r=>{if(r.error)throw Error(r.error)};
        ok(g.dismissGuide());a.close();a.paused=true;g.state.coins=10000;g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};for(const item of g.items)g.state.inventory[item.key]=100;
        for(const t of g.machineTypes)if(!g.state.machines.some(m=>m.type===t.id))ok(g.buyMachine(t.id));
        for(const cell of [14,15])ok(g.buyPen(cell));
        g.state.xp=210;
        for(const cell of [12,13,14,15]){while(g.state.plots[cell].residents.capacity<3)ok(g.expandPen(cell));while(g.state.plots[cell].residents.animals.length<3)ok(g.buyAnimal(cell));ok(g.feedAnimals(cell));}
        ok(g.plant(0,10));ok(g.expandQueue(0));ok(g.expandQueue(0));ok(g.produce(7,0));g.tick(g.product(7).duration);ok(g.produce(9,0));ok(g.produce(10,0));a.save();a.map.update();
        return farmCocos.pack();
      });
      const fields = await page.evaluate(() => testApp.map.model.plotPositions().filter(p=>p.plot.group==='crop').map(p=>({id:p.plot.id,matrix:p.cell.matrix,widget:p.cell.widget})));
      const readDecor = () => page.evaluate(()=>{const m=testApp.map;return m.decor.filter(e=>!m.marginScenery.includes(e.node)).map(e=>({name:e.node.name,x:e.node.position.x,y:e.node.position.y}));});
      const decor = await readDecor();
      async function pixel(p) {
        const normalized = await page.evaluate(p => {
          const cc=testCc,t=testApp.map.world.getComponent(cc.UITransform),v=t.convertToWorldSpaceAR(new cc.Vec3(p.x,p.y)),vp=cc.view.getViewportRect(),c=cc.view.getCanvasSize();
          return {x:(vp.x+v.x*cc.view.getScaleX())/c.width,y:1-(vp.y+v.y*cc.view.getScaleY())/c.height};
        }, p);
        const b=await page.locator('#GameCanvas').boundingBox();return {x:b.x+normalized.x*b.width,y:b.y+normalized.y*b.height};
      }
      async function drag(id,to) {
        const hit = await page.evaluate(id => {
          const p=testApp.map.movement.position(id),t=farmCocos.buildings().find(b=>b.buildingId===id);
          return {from:{x:t?.x??p.x,y:t?.y??p.y+10},origin:{x:p.x,y:p.y}};
        }, id);
        const a=await pixel(hit.from),b=await pixel({x:hit.from.x+to.x-hit.origin.x,y:hit.from.y+to.y-hit.origin.y});
        assert.ok(a.x>0&&a.x<width&&a.y>0&&a.y<height, 'visible drag start '+id);
        if(touch)await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{...a,id:1}]});else {await page.mouse.move(a.x,a.y);await page.mouse.down();}
        for(let i=1;i<=8;i++){const p={x:a.x+(b.x-a.x)*i/8,y:a.y+(b.y-a.y)*i/8};if(touch)await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{...p,id:1}]});else await page.mouse.move(p.x,p.y);await page.waitForTimeout(12);}
        const movement=await page.evaluate(()=>farmCocos.map().movement);assert.equal(movement.selected,id,'real input selects '+id);
        if(touch)await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});else await page.mouse.up();
        await page.waitForTimeout(250);
        return movement;
      }
      for (const building of FARM_LAYOUT.buildings) {
        const id=building.id,p=alternative(id);
        await page.evaluate(pack=>{testApp.importText(JSON.stringify(pack));testApp.paused=true;testApp.map.update();},fixture);
        await tap(page,'pause-menu',touch);await tap(page,'arrange',touch);
        await page.evaluate(id=>testApp.map.focusBuilding(id),id);await page.waitForTimeout(80);
        const before=await page.evaluate(()=>farmCocos.snapshot()),camera=await page.evaluate(()=>farmCocos.map().camera);
        const draft=await drag(id,p);
        assert.equal(draft.error,null,id+': valid preview');assert.equal(draft.canPlace,true,id+': valid immediately');assert.deepEqual(draft.candidate,p);
        assert.deepEqual((await page.evaluate(()=>farmCocos.snapshot())).buildingLayout.positions[id],p,'release commits');
        await page.evaluate(()=>testApp.session.tick(3));assert.deepEqual(await page.evaluate(id=>JSON.parse(localStorage.getItem('ola-farm-cocos-simple-v1')).free.buildingLayout.positions[id],id),p,'autosave retains drop');
        const saved=await page.evaluate(()=>farmCocos.snapshot());assert.deepEqual(saved.buildingLayout.positions[id],p);assert.deepEqual({...saved,buildingLayout:before.buildingLayout},before,'moving preserves all production state');
        assert.deepEqual(await page.evaluate(()=>farmCocos.map().camera),camera,'building drag leaves camera still');
        assert.deepEqual(await page.evaluate(()=>testApp.map.model.plotPositions().filter(p=>p.plot.group==='crop').map(p=>({id:p.plot.id,matrix:p.cell.matrix,widget:p.cell.widget}))),fields,'all forty field transforms stay fixed');
        const rendered=await page.evaluate(id=>{
          const m=testApp.map,cc=testCc,positions=m.model.plotPositions(),p=m.movement.position(id);
          const node=id.startsWith('pen:')?m.town.yards.get(positions.find(p=>'pen:'+p.plot.cell===id).plot.id).node:m.town.buildings.get(id)?.node??m.facilities.find(t=>t.id===id).node;
          return {x:node.position.x,y:node.position.y,active:node.activeInHierarchy,roads:farmCocos.map().roads.tiles.length,animals:[...m.town.animals].map(([id,v])=>({id,x:v.node.position.x,y:v.node.position.y,active:v.node.activeInHierarchy}))};
        },id);
        assert.equal(rendered.x,p.x);assert.equal(rendered.y,p.y);assert.equal(rendered.active,true,'moved node stays visible');assert.equal(rendered.roads,farmRoadLayout(FARM_LAYOUT).tiles.length);assert.equal(rendered.animals.length,12);
        assert.deepEqual(await readDecor(),decor,'scenery stays at authored positions');
        await tap(page,'move-finish',touch);assert.equal(await page.evaluate(()=>farmCocos.ui().paused),true,'arrange restores prior pause');
        const pack=await page.evaluate(()=>farmCocos.pack());await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);
        await page.evaluate(async()=>{globalThis.testCc=await System.import('cc');globalThis.testApp=testCc.director.getScene().getChildByName('Canvas').getComponent('GameApp');testApp.paused=true;});
        assert.deepEqual((await page.evaluate(()=>farmCocos.snapshot())).buildingLayout,pack.free.buildingLayout,'layout reload '+id);
        await page.evaluate(id=>{testApp.paused=false;testApp.map.focusBuilding(id)},id);await page.waitForTimeout(60);
        if(building.kind!=='pen'){
          const t=await page.evaluate(id=>farmCocos.buildings().find(t=>t.buildingId===id),id),b=await page.locator('#GameCanvas').boundingBox();
          if(touch)await page.touchscreen.tap(b.x+t.screen.x*b.width,b.y+t.screen.y*b.height);else await page.mouse.click(b.x+t.screen.x*b.width,b.y+t.screen.y*b.height);
          await page.waitForTimeout(100);assert.equal(await page.evaluate(()=>farmCocos.ui().view),id==='farm-house'?'pause':id==='barn'?'inventory':'factory','moved building hit target '+id);
        }else{
          const t=await page.evaluate(id=>farmCocos.targets().find(p=>'pen:'+p.cell===id),id),b=await page.locator('#GameCanvas').boundingBox();
          if(touch)await page.touchscreen.tap(b.x+t.screen.x*b.width,b.y+t.screen.y*b.height);else await page.mouse.click(b.x+t.screen.x*b.width,b.y+t.screen.y*b.height);
          await page.waitForTimeout(100);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'','pen tap opens its map bar');assert.equal(await page.evaluate(()=>farmCocos.controls().some(c=>c.id==='herd-manage')),true,'moved pen map controls');await tap(page,'herd-manage',touch);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'livestock','moved pen management target');
        }
        console.log(`${width}x${height}: ${id} drag/drop/reload/tap passed`);
      }
      // Invalid drops revert. Resize and hide preserve previously completed drops.
      await page.evaluate(pack=>{testApp.importText(JSON.stringify(pack));testApp.paused=true;testApp.map.update();},fixture);
      await tap(page,'pause-menu',touch);await tap(page,'arrange',touch);await page.evaluate(()=>testApp.map.focusBuilding('barn'));
      // The house is visible beside the barn at this zoom; dragging to a distant field would leave the canvas.
      const draft=await drag('barn',{x:-396,y:414});assert.ok(draft.error,JSON.stringify(draft));assert.equal(draft.canPlace,false);
      assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),EMPTY_LAYOUT);
      assert.equal(await page.evaluate(()=>farmCocos.map().movement.selected),null);
      await page.keyboard.press('Escape');assert.equal(await page.evaluate(()=>farmCocos.ui().layoutEditing),false);
      await tap(page,'pause-menu',touch);await tap(page,'arrange',touch);await page.evaluate(()=>testApp.map.focusBuilding('barn'));
      await drag('barn',alternative('barn'));const candidate=await page.evaluate(()=>farmCocos.snapshot().buildingLayout);
      await page.setViewportSize({width:height,height:width});await page.waitForTimeout(250);assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),candidate);
      await page.setViewportSize({width,height});await page.waitForTimeout(180);await page.screenshot({path:path.join(out,`preview-${width}x${height}.png`)});
      await page.evaluate(()=>testApp.onHide());assert.equal(await page.evaluate(()=>farmCocos.map().movement.active),false);assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),candidate);
      assert.deepEqual(observed.errors,[]);results.push({width,height,touch,buildings:14,passed:true,errors:observed.errors});await page.close();
    }
    fs.writeFileSync(path.join(out,'browser-validation.json'),JSON.stringify({passed:true,viewports:results},null,2)+'\n');
  } finally {await browser.close();await server.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
