'use strict';
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),http=require('node:http');
const {chromium}=require('playwright');
const build=path.resolve(process.env.COCOS_ITEM_BUILD||process.env.COCOS_TEST_BUILD||path.join(__dirname,'../build/farm-web-mobile'));
const source=path.resolve(process.env.COCOS_ITEM_SOURCE||path.join(__dirname,'../assets/farm/prefabs/items'));
const artifacts=path.resolve(process.env.COCOS_TEST_OUTPUT||path.join(__dirname,'../artifacts/cocos-items'));fs.mkdirSync(artifacts,{recursive:true});
const server=http.createServer((req,res)=>{
  if(req.url==='/favicon.ico'){res.writeHead(204).end();return;}
  const file=path.resolve(build,'.'+decodeURIComponent(new URL(req.url,'http://localhost').pathname));
  const target=file===build?path.join(build,'index.html'):file;
  if(!target.startsWith(build+path.sep)||!fs.existsSync(target)||!fs.statSync(target).isFile()){res.writeHead(404).end();return;}
  res.setHeader('Content-Type',({'.html':'text/html','.js':'text/javascript','.json':'application/json','.wasm':'application/wasm','.png':'image/png','.css':'text/css'})[path.extname(target)]||'application/octet-stream');fs.createReadStream(target).pipe(res);
});
const visualX=(file)=>{const p=JSON.parse(fs.readFileSync(path.join(source,file),'utf8'));return p.find(n=>n.__type__==='cc.Node'&&n._name==='Visual')._lpos.x;};
(async()=>{
  await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
  const browser=await chromium.launch({headless:true,...(process.env.PLAYWRIGHT_CHANNEL?{channel:process.env.PLAYWRIGHT_CHANNEL}:{})});
  try{
    const context=await browser.newContext({viewport:{width:1280,height:720}}),page=await context.newPage(),errors=[];
    await context.addInitScript(()=>{const next=sessionStorage.getItem('item-fixture');if(next){localStorage.setItem('ola-farm-cocos-simple-v1',next);sessionStorage.removeItem('item-fixture');}});
    page.on('pageerror',e=>errors.push(e.message));page.on('console',m=>{if(m.type()==='error')errors.push(m.text());});
    await page.goto('http://127.0.0.1:'+server.address().port);await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:45000});
    let map=await page.evaluate(()=>farmCocos.map());
    const catalog=JSON.parse(fs.readFileSync(path.join(source,'catalog.json'),'utf8')),authored=JSON.parse(fs.readFileSync(path.join(source,'../map/scenes.prefab'),'utf8'));
    const scenery=authored.find(n=>n.__type__==='cc.Node'&&n._name==='Scenery');
    const authoredItems=scenery._children.flatMap(r=>authored[r.__id__]._children.map(c=>authored[c.__id__]));
    const linkedItems=authoredItems.filter(n=>authored[n._prefab?.__id__]?.asset?.__uuid__);
    assert.equal(linkedItems.length,catalog.sceneryInstances,'authored nested scenery count');
    assert.deepEqual(map.sceneryItems.map(n=>n.name).sort(),authoredItems.map(n=>n._name).sort(),'all source scenery survives facility/standing-object reparenting');
    const farmUuid=JSON.parse(fs.readFileSync(path.join(source,'../map/scenes.prefab.meta'),'utf8')).uuid;
    const liveIdentities=await page.evaluate(async()=>{
      const cc=await System.import('cc'),m=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp').map;
      const holders=[...m.layout.scenery.children,...m.movableFacilities.map(e=>e.node),...m.standingScenery.map(e=>e.node)];
      return holders.flatMap(n=>n.children.map(c=>({name:c.name,uuid:c.prefab?.asset?._uuid}))).sort((a,b)=>a.name.localeCompare(b.name));
    });
    const expectedIdentities=authoredItems.map(n=>({name:n._name,uuid:authored[n._prefab?.__id__]?.asset?.__uuid__||farmUuid})).sort((a,b)=>a.name.localeCompare(b.name));
    assert.deepEqual(liveIdentities,expectedIdentities,'nested prefab and authored windmill blade identities survive reparenting');
    assert.ok(map.sceneryItems.every(s=>s.frame),'every scenery object, including windmill blades, renders');
    const assetsRoot=path.resolve(source,'../../..');
    const forest=JSON.parse(fs.readFileSync(path.join(assetsRoot,'farm/data/farm-decor/forest.json'),'utf8'));
    const editedSpecies=forest.species[0].id;
    const trees=await page.evaluate(async species=>{
      const cc=await System.import('cc'),app=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp');
      return app.map.decor.filter(e=>e.node.children[0]?.name===species).map(e=>({name:e.node.children[0].name,visualX:e.node.children[0].getChildByName('Visual')?.position.x}));
    },editedSpecies);
    assert.ok(trees.length>0,'source edit target has actual instantiated forest trees');
    assert.ok(trees.every(s=>s.visualX===visualX('scenery/'+editedSpecies+'.prefab')),'authored tree offsets reach all live instances');
    assert.equal(map.decor.standing,catalog.decorInstances+map.decor.marginScenery);
    assert.ok(map.decor.instances.length>0&&map.decor.instances.every(s=>s.linked&&s.frame));
    assert.deepEqual(map.decor.species,forest.species.map(s=>s.id),'all configured forest species load in order');
    const regionDir=path.resolve(source,'../map'),regionFiles=fs.readdirSync(regionDir).filter(f=>/^(Border|Forest).*\.prefab$/.test(f));
    assert.equal(regionFiles.length,8,'eight editable authored forest/border regions');
    const expectedRegions=regionFiles.map(file=>{
      const data=JSON.parse(fs.readFileSync(path.join(regionDir,file),'utf8')),root=data[data[0].data.__id__];
      return {name:root._name,uuid:JSON.parse(fs.readFileSync(path.join(regionDir,file+'.meta'),'utf8')).uuid,
        placements:root._children.map(r=>{const n=data[r.__id__];return {id:n._name,x:root._lpos.x+n._lpos.x*root._lscale.x,y:root._lpos.y+n._lpos.y*root._lscale.y,scaleX:n._lscale.x*root._lscale.x,scaleY:n._lscale.y*root._lscale.y,enabled:root._active&&n._active};})};
    });
    const liveRegions=await page.evaluate(async()=>{
      const cc=await System.import('cc'),m=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp').map;
      return {regions:m.layout.decorRegions.map(n=>({name:n.name,uuid:n.prefab?.asset?._uuid,children:n.children.length})),
        placements:m.decor.map(e=>({id:e.node.name,x:e.node.position.x,y:e.node.position.y,scaleX:e.node.scale.x,scaleY:e.node.scale.y,parent:e.node.parent===m.liveRoot,active:e.node.activeInHierarchy}))};
    });
    assert.deepEqual(liveRegions.regions.map(({children,...r})=>r).sort((a,b)=>a.name.localeCompare(b.name)),expectedRegions.map(({placements,...r})=>r).sort((a,b)=>a.name.localeCompare(b.name)),'each source region remains a native prefab instance');
    assert.ok(liveRegions.regions.every(r=>r.children===0),'region containers do not become depth-sorted draw objects');
    const livePlacements=new Map(liveRegions.placements.map(p=>[p.id,p]));
    for(const expected of expectedRegions.flatMap(r=>r.placements)){
      const actual=livePlacements.get(expected.id);assert.ok(actual?.parent,expected.id+' has the shared draw parent');
      for(const key of ['x','y','scaleX','scaleY'])assert.ok(Math.abs(actual[key]-expected[key])<.003,expected.id+'/'+key+' inherits the edited region source after reparenting');
      if(!expected.enabled)assert.equal(actual.active,false,expected.id+' keeps the source region/placement disabled after culling');
    }
    const starter=await page.evaluate(()=>farmCocos.pack());
    const crops=require('../tools/load-farm-catalog.cjs').loadFarmCatalog().farm;
    for(let level=1;level<=4;level++)for(const stage of [1,2,3]){
      const fixture=structuredClone(starter);fixture.free.time=1000;fixture.free.guideDismissed=true;
      fixture.free.plots.filter(p=>p.group==='crop').forEach((p,i)=>{
        const f=crops[i%crops.length],started=1000-f.duration*({1:.1,2:.6,3:1.1}[stage]);
        Object.assign(p,{level,crop:f.id,started,ready:started+f.duration,boosted:false,snapshot:{output:{key:f.itemKey??'raw:'+f.id,quantity:f.yields[level-1]},harvestXP:3*f.yields[level-1],paidCoins:f.price,refundCoins:Math.floor(f.price*.3),duration:f.duration,rescue:false}});
      });
      await page.evaluate(f=>sessionStorage.setItem('item-fixture',JSON.stringify(f)),fixture);await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);
      await page.keyboard.press('Space');await page.waitForTimeout(60);
      map=await page.evaluate(()=>farmCocos.map());
      assert.equal(map.items.cropInstances,40);assert.ok(map.items.stages.every(s=>s.stage==='Stage'+stage&&s.frame));
      assert.equal(new Set(map.items.stages.map(s=>s.plant)).size,8,'all eight crop prefabs instantiate');assert.equal(map.town.animals.length,2);
      const visibleStages=await page.evaluate(async()=>{
        const cc=await System.import('cc'),app=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp');
        return [...app.map.itemRenderer.crops.values()].map(v=>{
          const stage=v.shell.currentPlant.children.find(n=>n.active),sprites=stage.getComponentsInChildren(cc.Sprite);
          return {name:stage.name,count:sprites.length,frames:sprites.every(s=>!!s.spriteFrame)};
        });
      });
      assert.equal(visibleStages.length,40);
      assert.ok(visibleStages.every(v=>v.name==='Stage'+stage&&v.count>0&&v.frames),'every planted growth stage contains actual resolved sprites');
      if(level===4&&stage===3){
        await page.keyboard.press('Space');await page.waitForTimeout(60);
        await page.screenshot({path:path.join(artifacts,process.env.COCOS_ITEM_EDIT_TEST?'edited-prefabs.png':'animals-level4.png')});
      }
    }
    if(process.env.COCOS_ITEM_EDIT_TEST){
      const plant=JSON.parse(fs.readFileSync(path.join(source,'crops/Wheat.prefab'),'utf8'));
      const stage3=plant.find(n=>n.__type__==='cc.Node'&&n._name==='Stage3');
      const expected=plant[stage3._children[0].__id__]._lpos.x;
      const wheat=map.items.stages.filter(s=>s.plant==='Wheat');
      assert.ok(wheat.length>0,'edited Wheat source has live crop instances');
      assert.ok(wheat.every(s=>s.visualX===expected),'edited wheat visual reaches every planted instance');
    }
    assert.deepEqual(errors,[]);console.log(`${catalog.items.length} library prefabs; ${forest.species.length} forest species; ${catalog.sceneryInstances} scenery placements; all eight crops at four plot levels render in three growth stages; two resident animals persist.`);
    fs.writeFileSync(path.join(artifacts,'validation.json'),JSON.stringify({passed:true,buildPath:build,source,sourceEdit:!!process.env.COCOS_ITEM_EDIT_TEST,sceneryInstances:linkedItems.length,forestSpecies:forest.species.length,regions:expectedRegions.length,regionPlacements:expectedRegions.flatMap(r=>r.placements).length,editedTree:editedSpecies,treeInstances:trees.length,cropStageCases:12,plotsPerCase:40,errors},null,2)+'\n');
    await context.close();
  }finally{await browser.close();await new Promise(resolve=>{server.close(resolve);server.closeAllConnections?.();});}
})().catch(e=>{console.error(e);process.exitCode=1;server.close();});
