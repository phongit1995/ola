'use strict';
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {serve,launch,boot,observe}=require('./browser-support.cjs');
const out=path.resolve(__dirname,'../artifacts/simple-farm');
(async()=>{const server=await serve(),browser=await launch(),page=await browser.newPage({viewport:{width:390,height:844}}),observed=observe(page);
try{
 await boot(page,server.url);
 const signatures=await page.evaluate(()=>{
  const a=testApp,g=a.game,cc=testCc,ok=r=>{if(r.error)throw Error(r.error);};ok(g.dismissGuide());a.close();g.state.xp=80;ok(g.expandPen(12,1));a.save();a.map.update();
  const sprites=n=>n.getComponentsInChildren(cc.Sprite).map(s=>s.spriteFrame?.uuid).filter(Boolean).sort();
  const before=sprites(a.map.town.animals.get(3).visual),expected=sprites(a.art.prefabs.get('dairy-cow').data);
  const pack=farmCocos.pack();pack.free.plots[12].residents.animals.pop();pack.free.plots[13].residents.capacity=2;pack.free.plots[13].residents.animals.push({id:3,slot:1,job:null});
  a.importText(JSON.stringify(pack));if(a.storageFailed)throw Error('Import failed');a.map.update();
  return {before,expected,actual:sprites(a.map.town.animals.get(3).visual),profile:a.game.state.contentProfile};
 });
 assert.notDeepEqual(signatures.before,signatures.expected);assert.deepEqual(signatures.actual,signatures.expected,'importing a cow with an ID previously used by a hen must replace the rendered prefab');
 const before=await page.evaluate(()=>{
  const a=testApp,g=a.game,ok=r=>{if(r.error)throw Error(r.error);};g.state.coins=10000;g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};for(const item of g.items)g.state.inventory[item.key]=100;
  for(const id of [14,15]){ok(g.buyPen(id));ok(g.feedAnimals(id));}ok(g.buyMachine(1021));ok(g.produce(102101));
  ok(g.plant(0,10));ok(g.feedAnimals(12));ok(g.feedAnimals(13));ok(g.expandQueue(0));ok(g.expandQueue(0));ok(g.produce(7,0));g.tick(g.product(7).duration);ok(g.produce(9,0));ok(g.produce(10,0));
  a.paused=true;a.save();a.map.update();return farmCocos.snapshot();
 });
 assert.equal(before.machines[0].tray.length,1);assert.equal(before.machines[0].waiting.length,1);assert.ok(before.machines[0].job);assert.ok(before.plots[0].crop);assert.ok(before.plots[12].residents.animals[0].job);
 // Pause at the first update after initialization so reload can be compared without real-time drift.
 await page.addInitScript(()=>{const handle=setInterval(async()=>{if(!globalThis.farmCocos)return;clearInterval(handle);const cc=await System.import('cc'),a=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp');a.paused=true;},1);});
 await page.reload();await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});
 const restored=await page.evaluate(()=>farmCocos.snapshot());for(const k of ['coins','diamonds','inventory','plots','machines','nextId','husbandry'])assert.deepEqual(restored[k],before[k],k+' survives reload');
 assert.deepEqual(observed.errors,[]);fs.mkdirSync(out,{recursive:true});fs.writeFileSync(path.join(out,'save-runtime-checks.json'),JSON.stringify({passed:true,importReplacesDifferentAnimalPrefab:true,renderedSpritesMatchCow:true,reload:{growingCrop:true,feedingAnimals:true,fourSpecies:true,workingLoom:true,husbandryProgress:true,workingRecipe:true,waitingRecipe:true,readyTray:true,inventoryAndWallet:true},errors:observed.errors},null,2)+'\n');console.log('Save import renders the correct species; crops, residents, working/waiting/tray jobs and wallet survive reload.');
}finally{await browser.close();await server.close();}})().catch(e=>{console.error(e);process.exitCode=1;});
