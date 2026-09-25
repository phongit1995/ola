'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, observe } = require('./browser-support.cjs');
const unregisterTsx = require('tsx/cjs/api').register();
const { FARM_LAYOUT, EMPTY_LAYOUT, buildingPosition, checkLayout, movedLayout, snapPosition } = require('../assets/farm/scripts/core/BuildingPlacement.ts');
const { FarmGame } = require('../assets/farm/scripts/core/FarmGame.ts');
const catalog = require('../tools/load-farm-catalog.cjs').loadFarmCatalog();
unregisterTsx(); require('esbuild').stop();
const out = process.env.COCOS_TEST_OUTPUT ? path.resolve(process.env.COCOS_TEST_OUTPUT) : path.resolve(__dirname, '../artifacts/building-long-press');
function alternative(id) {
  const p = buildingPosition(id);
  for (let r = 2; r <= 12; r++) for (const [dx,dy] of [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,1],[1,-1],[-1,-1]]) {
    const q = snapPosition({x:p.x+dx*r*36,y:p.y+dy*r*18});
    if (!checkLayout(movedLayout(EMPTY_LAYOUT,id,q)).error) return q;
  }
  throw Error('No valid position for '+id);
}
(async () => {
  const server = await serve(), browser = await launch(), results = [];
  fs.mkdirSync(out,{recursive:true});
  try {
    const cases = [[1280,720,false],[390,844,true],[844,390,true],[320,568,true]];
    const selected = process.env.COCOS_BUILDING_HOLD_CASE ? cases.filter(([w,h]) => `${w}x${h}` === process.env.COCOS_BUILDING_HOLD_CASE) : cases;
    assert.ok(selected.length, 'Unknown COCOS_BUILDING_HOLD_CASE');
    for (const [width,height,touch] of selected) {
      const page = await browser.newPage({viewport:{width,height},hasTouch:true}), observed = observe(page);
      const cdp = await page.context().newCDPSession(page);
      await boot(page,server.url);
      const fixture = await page.evaluate(() => {
        const a=testApp,g=a.game,ok=r=>{if(r.error)throw Error(r.error);};ok(g.dismissGuide());a.close();g.state.coins=10000;g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};
        for(const t of g.machineTypes)if(!g.state.machines.some(m=>m.type===t.id))ok(g.buyMachine(t.id));
        for(const item of g.items)g.state.inventory[item.key]=100;
        for(const id of [14,15]){ok(g.buyPen(id));ok(g.feedAnimals(id));}
        ok(g.plant(0,10));ok(g.expandQueue(0));ok(g.produce(9,0));ok(g.produce(10,0));ok(g.feedAnimals(12));
        a.save();return farmCocos.pack();
      });
      async function reset(id='barn',pack=fixture) {
        await page.evaluate(({id,pack})=>{testApp.importText(JSON.stringify(pack));testApp.map.focusBuilding(id);testApp.map.update();}, {id,pack});
        await page.waitForTimeout(80);
        assert.equal(await page.evaluate(()=>farmCocos.ui().paused),false,'start running, without pause menu');
      }
      async function pixel(p) {
        const normalized=await page.evaluate(p=>{const cc=testCc,q=testApp.map.world.getComponent(cc.UITransform).convertToWorldSpaceAR(new cc.Vec3(p.x,p.y)),vp=cc.view.getViewportRect(),c=cc.view.getCanvasSize();return {x:(vp.x+q.x*cc.view.getScaleX())/c.width,y:1-(vp.y+q.y*cc.view.getScaleY())/c.height};},p);
        const b=await page.locator('#GameCanvas').boundingBox();return{x:b.x+normalized.x*b.width,y:b.y+normalized.y*b.height};
      }
      async function target(id) {
        const point=await page.evaluate(id=>{const b=farmCocos.buildings().find(b=>b.buildingId===id),p=testApp.map.movement.position(id);return{x:b?.x??p.x,y:b?.y??p.y+10};},id);
        return {world:point,screen:await pixel(point)};
      }
      async function down(p) {if(touch)await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{...p,id:1}]});else {await page.mouse.move(p.x,p.y);await page.mouse.down();}}
      async function move(p) {if(touch)await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{...p,id:1}]});else await page.mouse.move(p.x,p.y);}
      async function up() {if(touch)await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});else await page.mouse.up();}
      async function inactive() {assert.equal(await page.evaluate(()=>farmCocos.map().movement.active),false);}
      async function scenery() {return page.evaluate(()=>{const m=testApp.map,read=e=>({id:e.node.uuid,name:e.node.name,x:e.node.position.x,y:e.node.position.y,asset:e.node.children[0]?.name});return{decor:m.decor.map(read),ground:m.groundDecor.map(read)};});}
      const fields=await page.evaluate(()=>testApp.map.model.plotPositions().filter(p=>p.plot.group==='crop').map(p=>({id:p.plot.id,matrix:p.cell.matrix,widget:p.cell.widget})));
      for (const building of FARM_LAYOUT.buildings) {
        const id=building.id,p=alternative(id);await reset(id);
        const t=await target(id),camera=await page.evaluate(()=>farmCocos.map().camera),original=buildingPosition(id),fixed=await scenery();
        await down(t.screen);
        await page.waitForFunction(id=>farmCocos.map().movement.selected===id,id,{timeout:2500});
        const selected=await page.evaluate(()=>({ui:farmCocos.ui(),move:farmCocos.map().movement,state:farmCocos.snapshot()}));
        assert.equal(selected.ui.view,'','hold opens no panel');assert.equal(selected.ui.layoutEditing,true);assert.equal(selected.ui.paused,false);
        assert.deepEqual(selected.move.candidate,original,'activation does not jump to the finger');
        const end=await pixel({x:t.world.x+p.x-original.x,y:t.world.y+p.y-original.y});
        for(let i=1;i<=7;i++){await move({x:t.screen.x+(end.x-t.screen.x)*i/7,y:t.screen.y+(end.y-t.screen.y)*i/7});await page.waitForTimeout(12);}
        const draft=await page.evaluate(()=>farmCocos.map().movement);
        assert.equal(draft.selected,id);assert.equal(draft.canPlace,true,JSON.stringify(draft));assert.deepEqual(draft.candidate,p,'same held pointer drags without a second press');
        assert.deepEqual(await scenery(),fixed,'trees, props and road nodes never move or rebuild during drag');
        assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot()),selected.state,'production clock and assets freeze while held');
        assert.equal(await page.evaluate(()=>farmCocos.controls().some(c=>c.id==='move-confirm'||c.id==='move-finish')),false,'direct hold has no confirmation or finish button');
        if(id==='farm-house')await page.screenshot({path:path.join(out,`drag-${width}x${height}.png`)});
        await up();
        assert.equal(await page.evaluate(()=>farmCocos.ui().view),'','release never opens the building');
        await inactive();assert.equal(await page.evaluate(()=>farmCocos.ui().layoutEditing),false);
        assert.deepEqual(await page.evaluate(()=>farmCocos.map().camera),camera,'hold and drag leave camera still');
        const committed=await page.evaluate(()=>farmCocos.snapshot());assert.deepEqual(committed.buildingLayout.positions[id],p);
        assert.deepEqual({...committed,time:selected.state.time,buildingLayout:selected.state.buildingLayout},selected.state);
        assert.deepEqual(await page.evaluate(()=>JSON.parse(localStorage.getItem('ola-farm-cocos-simple-v1')).free.buildingLayout),committed.buildingLayout,'release persists before autosave');
        assert.deepEqual(await scenery(),fixed,'placing leaves every scenery position and road node intact');
        assert.deepEqual(await page.evaluate(()=>testApp.map.model.plotPositions().filter(p=>p.plot.group==='crop').map(p=>({id:p.plot.id,matrix:p.cell.matrix,widget:p.cell.widget}))),fields);
        assert.equal(await page.evaluate(()=>farmCocos.ui().paused),false);
        await page.waitForTimeout(90);assert.ok((await page.evaluate(()=>farmCocos.snapshot().time))>committed.time,'game resumes on release without any other action');
        assert.equal((await page.evaluate(()=>farmCocos.map().roads)).tiles.length,0,'removed roads stay absent after placement');
      }
      console.log(`${width}x${height}: continuous long press and drag passed for all 14 buildings`);
      // A badge can overlap another building's body without their placement footprints colliding.
      // Its painted target owns a tap; holding/dragging there must never pick the building below it.
      await reset('industry-pie_bakery');
      const badge = await page.evaluate(() => {
        const a=testApp,m=a.map,r=a.game.moveBuilding('barn',{x:1692,y:774});if(r.error)throw Error(r.error);
        m.selectedMachine=null;m.update();
        const b=m.town.machineBadges.find(b=>b.building==='industry-pie_bakery'),point={x:b.x,y:b.y};
        m.camera.lookAt(point.x,point.y,1/m.camera.scale,'manual');m.update();
        return {point,top:m.town.topBadgeTarget(point),under:m.moveTarget(new testCc.Vec3(point.x,point.y)),layout:a.game.state.buildingLayout,camera:m.cameraState()};
      });
      assert.deepEqual(badge.top,{building:'industry-pie_bakery'});assert.equal(badge.under,'barn','Fixture puts a real barn body under the pie badge');
      const badgeScreen=await pixel(badge.point);await down(badgeScreen);await page.waitForTimeout(600);await inactive();
      await move({x:badgeScreen.x-30,y:badgeScreen.y+12});await up();await inactive();
      assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),badge.layout,'Dragging the badge never moves the barn');
      assert.notDeepEqual(await page.evaluate(()=>farmCocos.map().camera),badge.camera,'Dragging still pans the map');
      await page.evaluate(point=>{const m=testApp.map;m.camera.lookAt(point.x,point.y,1/m.camera.scale,'manual');m.update();},badge.point);
      await down(await pixel(badge.point));await page.waitForTimeout(600);await inactive();await up();await page.waitForTimeout(100);
      assert.equal(await page.evaluate(()=>farmCocos.ui().view),'factory');
      assert.equal(await page.evaluate(()=>testApp.game.state.machines.find(m=>m.id===testApp.panels.machineId).buildingId),'industry-pie_bakery','Releasing a held badge opens its own factory');
      // Tap remains distinct from holding on every class of object.
      for(const [id,view] of [['farm-house','pause'],['barn','inventory'],['bakery-1','factory'],['pen:12',''],['pen:13',''],['pen:14',''],['pen:15','']]) {
        await reset(id);const t=await target(id);await down(t.screen);await page.waitForTimeout(45);await up();await page.waitForTimeout(560);
        await inactive();assert.equal(await page.evaluate(()=>farmCocos.ui().view),view,'short tap '+id);if(id.startsWith('pen:')){assert.equal(await page.evaluate(()=>farmCocos.controls().some(c=>c.id==='herd-manage')),true);await tap(page,'herd-manage',touch);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'livestock');}
      }
      // Moving early cancels the timer permanently for that pointer, even if it stops afterwards.
      await reset();let t=await target('barn'),camera=await page.evaluate(()=>farmCocos.map().pan);
      await down(t.screen);await move({x:t.screen.x+24,y:t.screen.y+12});await page.waitForTimeout(600);await inactive();await up();
      assert.notDeepEqual(await page.evaluate(()=>farmCocos.map().pan),camera);assert.equal(await page.evaluate(()=>farmCocos.ui().view),'');
      // Hidden unowned sites and purchase placement are covered by shop-placement.browser.cjs.
      await reset();await page.evaluate(()=>{const m=testApp.map,p=m.model.plotPositions().find(p=>p.plot.group==='crop'&&p.plot.id===0);m.camera.lookAt(p.x,p.y,1/m.camera.scale,'manual');});
      const field=await page.evaluate(()=>{const p=testApp.map.targets().find(p=>p.id===0);return {x:p.x,y:p.y};});await down(await pixel(field));await page.waitForTimeout(600);await inactive();await up();
      assert.equal(await page.evaluate(()=>farmCocos.snapshot().plots[0].crop),fixture.free.plots[0].crop);
      // Drag a building across the field edge. It must return to its saved position.
      await reset('barn');t=await target('barn');const fieldDrop=snapPosition({x:-13,y:20}),barn=buildingPosition('barn');
      const dropWorld={x:t.world.x+fieldDrop.x-barn.x,y:t.world.y+fieldDrop.y-barn.y};
      // The authored barn is farther from the fields now. Frame the complete gesture before touching it.
      await page.evaluate(({from,to})=>{
        const m=testApp.map,c=m.camera,free=m.height-m.inset.top-m.inset.bottom;
        const scale=Math.min(1.1,m.width*.6/(Math.abs(to.x-from.x)+160),free*.55/(Math.abs(to.y-from.y)+160));
        c.lookAt((from.x+to.x)/2,(from.y+to.y)/2,scale/c.scale,'manual',(m.inset.bottom-m.inset.top)/2);m.update();
      },{from:t.world,to:dropWorld});
      await page.waitForTimeout(80);t=await target('barn');const dropScreen=await pixel(dropWorld),canvas=await page.locator('#GameCanvas').boundingBox();
      for(const p of [t.screen,dropScreen])assert.ok(p.x>canvas.x+16&&p.x<canvas.x+canvas.width-16&&p.y>canvas.y+16&&p.y<canvas.y+canvas.height-16,'the complete rejected drag is inside the canvas');
      assert.match(checkLayout(movedLayout(EMPTY_LAYOUT,'barn',fieldDrop)).error,/ruộng/,'drop fixture crosses a real field reservation');
      await down(t.screen);await page.waitForFunction(()=>farmCocos.map().movement.selected==='barn');
      await move(dropScreen);await page.waitForTimeout(35);
      assert.match(await page.evaluate(()=>farmCocos.map().movement.error),/ruộng/);
      await page.screenshot({path:path.join(out,`field-blocked-${width}x${height}.png`)});
      await up();await inactive();assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),EMPTY_LAYOUT);
      // No delayed activation survives a modal, replacement, hide/show, Escape or resize.
      for(const event of ['modal','import','hide','escape','resize','failure']) {
        await reset();t=await target('barn');await down(t.screen);await page.waitForTimeout(100);
        if(event==='modal')await page.evaluate(()=>testApp.open('inventory'));
        if(event==='import')await page.evaluate(pack=>testApp.importText(JSON.stringify(pack)),fixture);
        if(event==='hide')await page.evaluate(()=>{testApp.onHide();testApp.onShow();});
        if(event==='escape')await page.keyboard.press('Escape');
        if(event==='resize'){await page.setViewportSize({width:height,height:width});}
        if(event==='failure')await page.evaluate(()=>{const write=Storage.prototype.setItem;Storage.prototype.setItem=function(k,v){if(k==='ola-farm-cocos-simple-v1')throw Error('quota');return write.call(this,k,v);};testApp.save();Storage.prototype.setItem=write;testApp.retrySave();});
        await page.waitForTimeout(600);await inactive();await up();
        if(event==='resize'){await page.setViewportSize({width,height});await page.waitForTimeout(150);}
      }
      // Touch pinch cancels a pending hold; there is no re-arming when the second finger lifts.
      await reset();t=await target('barn');camera=await page.evaluate(()=>farmCocos.map().zoom);
      const second={x:t.screen.x+45,y:t.screen.y+10};
      await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{...t.screen,id:1}]});await page.waitForTimeout(100);
      await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{...t.screen,id:1},{...second,id:2}]});
      await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{x:t.screen.x-15,y:t.screen.y,id:1},{x:second.x+15,y:second.y,id:2}]});
      await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[{...t.screen,id:1}]});await page.waitForTimeout(600);await inactive();
      await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});assert.notEqual(await page.evaluate(()=>farmCocos.map().zoom),camera);
      // Holding then releasing without dragging neither opens nor commits anything.
      await reset();t=await target('barn');await down(t.screen);await page.waitForFunction(()=>farmCocos.map().movement.active);await up();
      assert.equal(await page.evaluate(()=>farmCocos.ui().view),'');assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),EMPTY_LAYOUT);
      await page.screenshot({path:path.join(out,`hold-${width}x${height}.png`)});
      await inactive();
      // Previously paused games stay paused; the existing menu entry continues to work.
      await page.evaluate(()=>testApp.paused=true);t=await target('barn');await down(t.screen);await page.waitForFunction(()=>farmCocos.map().movement.active);await up();await inactive();
      assert.equal(await page.evaluate(()=>farmCocos.ui().paused),true);await tap(page,'pause-menu',touch);await tap(page,'arrange',touch);assert.equal(await page.evaluate(()=>farmCocos.map().movement.active),true);await tap(page,'move-finish',touch);
      // Loading an actual v1 save preserves valid positions and the original bytes after road removal.
      const old=JSON.parse(JSON.stringify(fixture));old.free.buildingLayout={version:1,positions:{barn:{x:347,y:290}}};
      const raw=JSON.stringify(old,null,2)+'  \n',expected=new FarmGame(catalog,old.free).state.buildingLayout;
      // Install the historical source before boot, after the previous page's hide/autosave handler.
      await page.addInitScript(raw=>{if(!sessionStorage.getItem('fixed-roads-migration-fixture')){localStorage.setItem('ola-farm-cocos-simple-v1',raw);sessionStorage.setItem('fixed-roads-migration-fixture','1');}},raw);
      await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);
      const migrated=await page.evaluate(()=>({state:farmCocos.snapshot(),ui:farmCocos.ui(),source:localStorage.getItem('ola-farm-cocos-simple-v1.before-fixed-roads-v2'),roads:farmCocos.map().roads}));
      assert.equal(migrated.ui.storageFailed,false);assert.deepEqual(migrated.state.buildingLayout,expected);assert.equal(migrated.source,raw);
      assert.deepEqual({...migrated.state,time:old.free.time,buildingLayout:old.free.buildingLayout},old.free);
      assert.equal(migrated.roads.tiles.length,0);assert.equal(checkLayout(migrated.state.buildingLayout).error,null);
      await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),expected);
      assert.deepEqual(observed.errors,[]);results.push({width,height,touch,longPressBuildings:14,instantDrop:true,sceneryFixed:true,roadsRemoved:true,fieldDropRejected:true,oldLayoutMigratedAndBackedUp:true,shortTaps:7,earlyPan:true,overlappingMachineBadgeOwnsInput:true,cancelOnLifecycleChanges:true,pinch:true,fieldsFixed:true,pausedStateRestored:true,errors:observed.errors});
      console.log(`${width}x${height}: hold-drag all 14, short taps, camera, cancellation, save and resume passed`);await page.close();
    }
    fs.writeFileSync(path.join(out,'validation.json'),JSON.stringify({passed:true,viewports:results},null,2)+'\n');
  } finally {await browser.close();await server.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
