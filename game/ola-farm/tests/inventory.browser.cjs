'use strict';
// Real input regression for the Farm Town modal replacement, including resident herd actions.
const fs=require('node:fs'),path=require('node:path'),http=require('node:http'),assert=require('node:assert/strict');
const {chromium}=require('playwright');
const build=process.env.COCOS_TEST_BUILD?path.resolve(process.env.COCOS_TEST_BUILD):path.resolve(__dirname,'../build/farm-web-mobile'),out=process.env.COCOS_TEST_OUTPUT?path.resolve(process.env.COCOS_TEST_OUTPUT):path.resolve(__dirname,'../artifacts/cocos-inventory');
const reportName=process.env.COCOS_INVENTORY_VIEWPORT?'checks-'+process.env.COCOS_INVENTORY_VIEWPORT+'.json':'checks.json';
const server=http.createServer((req,res)=>{
  if(req.url==='/favicon.ico')return res.writeHead(204).end();
  const file=path.resolve(build,'.'+new URL(req.url,'http://localhost').pathname),target=file===build?path.join(build,'index.html'):file;
  if(!target.startsWith(build+path.sep)||!fs.existsSync(target)||!fs.statSync(target).isFile())return res.writeHead(404).end();
  res.setHeader('Content-Type',({'.html':'text/html','.js':'text/javascript','.json':'application/json','.css':'text/css','.wasm':'application/wasm','.png':'image/png'})[path.extname(target)]||'application/octet-stream');fs.createReadStream(target).pipe(res);
});
(async()=>{
  fs.mkdirSync(out,{recursive:true});await new Promise(r=>server.listen(0,'127.0.0.1',r));
  const browser=await chromium.launch({headless:true,...(process.env.PLAYWRIGHT_CHANNEL?{channel:process.env.PLAYWRIGHT_CHANNEL}:{})}),results=[];
  try{for(const [name,width,height,touch] of [['desktop',1280,720,false],['portrait',390,844,true],['landscape',844,390,true],['small',320,568,true]]){
    if(process.env.COCOS_INVENTORY_VIEWPORT&&process.env.COCOS_INVENTORY_VIEWPORT!==name)continue;
    const context=await browser.newContext({viewport:{width,height},hasTouch:touch,isMobile:touch}),page=await context.newPage(),errors=[];
    page.on('pageerror',e=>errors.push(e.message));page.on('console',m=>{if(m.type()==='error')errors.push(m.text());});page.on('response',r=>{if(r.status()>=400)errors.push('HTTP '+r.status()+' '+r.url());});
    const state=()=>page.evaluate(()=>farmCocos.snapshot()),view=()=>page.evaluate(()=>farmCocos.ui().view);
    async function tap(id){
      let target;
      for(let tries=0;tries<50;tries++){
        await page.waitForFunction(async()=>{const cc=await System.import('cc'),a=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp'),s=a.panels.scroll;return !s||!s.isAutoScrolling()&&!s.isScrolling();});
        target=await page.evaluate(async id=>{
          const cc=await System.import('cc'),app=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp'),n=app.ui.controls.get(id);
          if(!n)throw Error('Missing control '+id);
          const box=n=>{const t=n.getComponent(cc.UITransform),p=n.worldPosition,s=n.worldScale;return {x:p.x-t.width*t.anchorX*s.x,y:p.y-t.height*t.anchorY*s.y,width:t.width*s.x,height:t.height*s.y};};
          const b=box(n);let clip=null;
          for(let p=n.parent;p;p=p.parent)if(p.getComponent(cc.Mask))clip=box(p);
          return {...farmCocos.controls().find(t=>t.id===id),clipped:clip&&(b.y<clip.y||b.y+b.height>clip.y+clip.height),direction:clip&&b.y+b.height/2<clip.y+clip.height/2?1:-1};
        },id);
        if(!target.clipped)break;
        const box=await page.locator('#GameCanvas').boundingBox();await page.mouse.move(box.x+box.width/2,box.y+box.height/2);await page.mouse.wheel(0,target.direction*130);await page.waitForTimeout(90);
      }
      assert.ok(!target.clipped,'clipped '+id);assert.ok(target.x>0&&target.x<1&&target.y>0&&target.y<1,id+' outside canvas');
      const box=await page.locator('#GameCanvas').boundingBox(),x=box.x+target.x*box.width,y=box.y+target.y*box.height;
      if(touch)await page.touchscreen.tap(x,y);else await page.mouse.click(x,y);await page.waitForTimeout(130);
    }
    async function building(id){const t=await page.evaluate(id=>farmCocos.buildings().find(t=>t.id===id),id);assert.ok(t);const box=await page.locator('#GameCanvas').boundingBox();await page.mouse.click(box.x+t.screen.x*box.width,box.y+t.screen.y*box.height);await page.waitForTimeout(130);}
    async function picture(suffix){await page.screenshot({path:path.join(out,name+'-'+suffix+'.png')});}
    try{
      await page.goto('http://127.0.0.1:'+server.address().port);await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:45000});
      assert.match(await page.title(), /(?:^|\| )Ola Farm$/);
      await page.evaluate(async()=>{
        const cc=await System.import('cc'),a=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp'),g=a.game;
        g.dismissGuide();a.close();g.state.coins=10000;for(const p of g.state.plots.filter(p=>p.group==='crop'))Object.assign(p,{crop:null,snapshot:null,boosted:false,started:0,ready:0});for(const item of g.items)g.state.inventory[item.key]=20;
        const ok=r=>{if(r.error)throw Error(r.error);};g.state.xp=210;ok(g.expandPen(12));ok(g.expandPen(12));if(g.residentPlot(12).residents.animals.length!==3)throw Error('Two slot unlocks include two animals');g.validate();a.speed=12;a.save();a.refresh();a.map.update();
      });
      assert.ok(!await page.evaluate(()=>farmCocos.controls().some(control=>['unlock-14','unlock-15'].includes(control.id))),'future animal pens do not expose crop gem-unlock buttons');
      await building('farm-house');assert.equal(await view(),'pause');await tap('close-panel');assert.equal(await page.evaluate(()=>farmCocos.ui().paused),false);
      await building('barn');assert.equal(await view(),'inventory');await picture('raw');
      const camera=await page.evaluate(()=>farmCocos.map().camera),before=await state();
      await tap('tab-goods');const fixed=await page.evaluate(()=>farmCocos.controls().find(t=>t.id==='tab-goods'));
      // Drag over a stock icon scrolls the list; it must not sell/select or move the map.
      const box=await page.locator('#GameCanvas').boundingBox();await page.mouse.move(box.x+box.width*.4,box.y+box.height*.55);await page.mouse.down();await page.mouse.move(box.x+box.width*.4,box.y+box.height*.40,{steps:12});await page.mouse.up();await page.waitForTimeout(300);
      assert.equal(await view(),'inventory');assert.deepEqual((await state()).inventory,before.inventory);assert.deepEqual(await page.evaluate(()=>farmCocos.map().camera),camera);
      assert.deepEqual(await page.evaluate(()=>farmCocos.controls().find(t=>t.id==='tab-goods')),fixed);
      await tap('stock-farm40:cow-feed');assert.equal(await view(),'inventory-item');await tap('sale-plus');assert.ok(await page.evaluate(()=>farmCocos.labels().some(l=>l.text==='2')));
      await tap('sale-minus');await tap('sale-max');await picture('sale');const preSale=await state();await tap('sale-confirm');
      assert.equal(await view(),'inventory');assert.equal((await state()).inventory['farm40:cow-feed'],0);assert.equal((await state()).coins,preSale.coins+20*14);
      await tap('tab-goods');await tap('stock-farm40:cow-feed');assert.equal(await page.evaluate(()=>farmCocos.controls().find(t=>t.id==='sale-confirm').enabled),false);await tap('back-stock');
      await tap('tab-goods');await page.setViewportSize({width:height,height:width});await page.waitForTimeout(600);assert.equal(await page.evaluate(async()=>{const cc=await System.import('cc');return cc.director.getScene().getChildByName('Canvas').getComponent('GameApp').panels.inventoryTab;}),'goods');
      await picture('rotated');await page.setViewportSize({width,height});await page.waitForTimeout(600);await tap('close-panel');
      await page.keyboard.press('Space');await tap('inventory');await tap('stock-raw:1');assert.equal(await page.evaluate(()=>farmCocos.controls().find(t=>t.id==='sale-confirm').enabled),false);const paused=await state();await tap('sale-confirm');assert.equal((await state()).coins,paused.coins);await page.keyboard.press('Escape');await page.keyboard.press('Space');
      // Per-animal and whole-herd commands consume exactly one feed bag per hungry animal.
      const pen=await page.evaluate(()=>farmCocos.targets().find(t=>t.id===12).screen);await page.mouse.click(pen.x*width,pen.y*height);await page.waitForTimeout(150);assert.equal(await view(),'');await tap('herd-manage');assert.equal(await view(),'livestock');
      const animal=(await state()).plots[12].residents.animals[0].id,feed=(await state()).inventory['farm40:chicken-feed'];await tap('animal-'+animal);await tap('feed-all');
      assert.equal((await state()).inventory['farm40:chicken-feed'],feed-3);assert.equal(await page.evaluate(()=>farmCocos.controls().find(t=>t.id==='feed-all').enabled),false);await picture('herd');
      await page.waitForFunction(()=>{const s=farmCocos.snapshot();return s.plots[12].residents.animals.every(a=>a.job&&a.job.ready<=s.time);},undefined,{timeout:20000});
      await page.waitForFunction(()=>farmCocos.controls().find(control=>control.id==='collect-all-animals')?.enabled===true);
      const eggs=(await state()).inventory['farm40:egg'];await tap('collect-all-animals');assert.equal((await state()).inventory['farm40:egg'],eggs+3);assert.equal((await state()).plots[12].residents.animals.length,3);
      await tap('close-panel');await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);assert.equal((await state()).inventory['farm40:egg'],eggs+3);assert.equal((await state()).plots[12].residents.animals.length,3);
      assert.ok(!(await page.evaluate(()=>farmCocos.labels())).some(l=>/Farm\s*40|40 ruộng/i.test(l.text)));assert.deepEqual(errors,[]);
      results.push({name,passed:true,buildingClicks:true,itemSale:true,herdActions:true,rotation:true,dragShield:true,reload:true,errors});console.log(name+': building clicks, grid, quantity sale, herd actions, drag shielding, rotation and reload passed');
    }catch(e){await picture('failure');fs.writeFileSync(path.join(out,reportName),JSON.stringify({passed:false,buildPath:build,results,error:String(e)},null,2)+'\n');throw e;}finally{await context.close();}
  }
  fs.writeFileSync(path.join(out,reportName),JSON.stringify({passed:true,buildPath:build,testedAt:new Date().toISOString(),results},null,2)+'\n');
  }finally{await browser.close();await new Promise(r=>{server.close(r);server.closeAllConnections?.();});}
})().catch(e=>{console.error(e);process.exitCode=1;server.close();});
