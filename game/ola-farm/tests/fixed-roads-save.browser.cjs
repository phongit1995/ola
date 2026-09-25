'use strict';
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {serve,launch,boot,observe,build}=require('./browser-support.cjs');
require('tsx/cjs');
const {FarmGame}=require('../assets/farm/scripts/core/FarmGame.ts');
const {farmPack}=require('../assets/farm/scripts/core/FarmSave.ts');
const {FARM_LAYOUT,EMPTY_LAYOUT,buildingPosition,checkLayout,assertPreviousBuildingLayout}=require('../assets/farm/scripts/core/BuildingPlacement.ts');
const catalog=require('../tools/load-farm-catalog.cjs').loadFarmCatalog();
const out=path.resolve(__dirname,'../artifacts/fixed-roads'),key='ola-farm-cocos-simple-v1';
function fixture(custom){
 const g=new FarmGame(catalog),ok=result=>assert.equal(result.error,undefined);g.dismissGuide();g.state.coins=10000;
 g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};
 for(const t of g.machineTypes)if(!g.state.machines.some(m=>m.type===t.id))ok(g.buyMachine(t.id));
 for(const item of g.items)g.state.inventory[item.key]=100;
 ok(g.plant(0,10));ok(g.expandQueue(0));ok(g.produce(9,0));ok(g.produce(10,0));ok(g.feedAnimals(12));
 // Historical custom coordinates remain a frozen v1 fixture, never generated from current defaults.
 g.state.buildingLayout={version:1,positions:custom?{barn:{x:347,y:290},'bakery-1':{x:684,y:162}}:{}};
 assertPreviousBuildingLayout(g.state.buildingLayout);
 return farmPack(g.state,{speed:1,sound:false,music:false});
}
(async()=>{
 const server=await serve(),browser=await launch(),results=[];fs.mkdirSync(out,{recursive:true});
 try{
  for(const [width,height]of [[1280,720],[390,844],[844,390],[320,568]])for(const custom of [false,true]){
   const old=fixture(custom),raw=JSON.stringify(old,null,2)+'  \n',expected=new FarmGame(catalog,old.free).state.buildingLayout;
   const page=await browser.newPage({viewport:{width,height},hasTouch:true}),observed=observe(page);
   await page.addInitScript(({key,raw})=>{if(!sessionStorage.getItem('seeded')){localStorage.setItem(key,raw);sessionStorage.setItem('seeded','1');}},{key,raw});
   await boot(page,server.url);
   await page.evaluate(()=>{testApp.paused=true;testApp.focusHome();testApp.map.update();});
   const actual=await page.evaluate(key=>{
    const m=testApp.map,positions=m.model.plotPositions();
    return{state:farmCocos.snapshot(),failed:farmCocos.ui().storageFailed,source:localStorage.getItem(key+'.before-fixed-roads-v2'),machineSource:localStorage.getItem(key+'.before-large-machines-v5'),roads:farmCocos.map().roads,
     rendered:farmCocos.map().layout.map(b=>{const node=b.id.startsWith('pen:')?m.town.yards.get(positions.find(p=>'pen:'+p.plot.cell===b.id).plot.id).node:m.town.buildings.get(b.id)?.node??m.facilities.find(t=>t.id===b.id).node;return{id:b.id,x:node.position.x,y:node.position.y};})};
   },key);
   assert.equal(actual.failed,false);assert.deepEqual(actual.state.buildingLayout,expected);assert.equal(actual.source,raw);assert.equal(actual.machineSource,raw);assert.equal(actual.roads.tiles.length,0);
   assert.deepEqual({...actual.state,time:old.free.time,buildingLayout:old.free.buildingLayout},old.free);assert.equal(checkLayout(actual.state.buildingLayout).error,null);
   assert.equal(actual.rendered.length,FARM_LAYOUT.buildings.length);
   for(const b of FARM_LAYOUT.buildings)assert.deepEqual(actual.rendered.find(p=>p.id===b.id),{id:b.id,...buildingPosition(b.id,expected)});
   if(!custom)assert.deepEqual(expected,EMPTY_LAYOUT);else{
    assert.deepEqual(buildingPosition('barn',expected),old.free.buildingLayout.positions.barn,'valid custom barn remains exact');
    assert.notDeepEqual(buildingPosition('bakery-1',expected),old.free.buildingLayout.positions['bakery-1'],'enlarged bakery yields to that unchanged barn');
   }
   await page.screenshot({path:path.join(out,`migrated-${custom?'custom':'default'}-${width}x${height}.png`)});
   await page.evaluate(()=>{testApp.save();testApp.save();});await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);
   assert.deepEqual(await page.evaluate(()=>farmCocos.snapshot().buildingLayout),expected);assert.equal(await page.evaluate(key=>localStorage.getItem(key+'.before-fixed-roads-v2'),key),raw);assert.equal(await page.evaluate(key=>localStorage.getItem(key+'.before-large-machines-v5'),key),raw);
   assert.deepEqual(observed.errors,[]);results.push({width,height,custom,passed:true,renderedBuildings:actual.rendered.length,layoutVersion:expected.version,preservedAssets:true,sourceBackup:true,machineMigrationBackup:true,errors:observed.errors});await page.close();
   console.log(`${width}x${height}: ${custom?'custom':'default'} v1 save migrated, rendered and reloaded`);
  }
  fs.writeFileSync(path.join(out,'save-validation.json'),JSON.stringify({passed:true,build,cases:results},null,2)+'\n');
 }finally{await browser.close();await server.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
