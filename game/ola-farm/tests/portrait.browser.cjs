'use strict';
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict'),http=require('node:http');
const {chromium}=require('playwright');
const build=process.env.COCOS_TEST_BUILD?path.resolve(process.env.COCOS_TEST_BUILD):path.resolve(__dirname,'../build/farm-web-mobile'),artifacts=path.resolve(__dirname,'../artifacts/cocos-portrait');
const config=require('../build-configs/farm-web-mobile.json');
assert.equal(config.packages['web-mobile'].orientation,'auto');
const server=http.createServer((req,res)=>{
  if(req.url==='/favicon.ico'){res.writeHead(204).end();return;}
  const file=path.resolve(build,'.'+decodeURIComponent(new URL(req.url,'http://localhost').pathname));
  const target=file===build?path.join(build,'index.html'):file;
  if(!target.startsWith(build+path.sep)||!fs.existsSync(target)||!fs.statSync(target).isFile()){res.writeHead(404).end();return;}
  res.setHeader('Content-Type',({'.html':'text/html','.js':'text/javascript','.json':'application/json','.css':'text/css','.wasm':'application/wasm'})[path.extname(target)]||'application/octet-stream');fs.createReadStream(target).pipe(res);
});
(async()=>{
  await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
  const browser=await chromium.launch({headless:true,...(process.env.PLAYWRIGHT_CHANNEL?{channel:process.env.PLAYWRIGHT_CHANNEL}:{})});
  fs.mkdirSync(artifacts,{recursive:true});
  try{
    for(const [name,width,height,mobile] of [['small',360,640,true],['phone',390,844,true],['tall',430,932,true],['tablet',768,1024,true],['desktop',1280,720,false],['turned-phone',844,390,true],['ultrawide',3840,1080,false]]){
      if(process.env.COCOS_PORTRAIT_VIEWPORT&&process.env.COCOS_PORTRAIT_VIEWPORT!==name)continue;
      const context=await browser.newContext({viewport:{width,height},hasTouch:mobile,isMobile:mobile,deviceScaleFactor:mobile?2:1});
      const page=await context.newPage(),errors=[];
      page.on('pageerror',e=>errors.push(e.message));page.on('console',m=>{if(m.type()==='error')errors.push(m.text());});
      async function tap(id){
        await page.waitForFunction(()=>!farmCocos.ui().animating);
        const p=await page.evaluate(id=>farmCocos.controls().find(c=>c.id===id),id);assert.ok(p,'control '+id);
        const box=await page.locator('#GameCanvas').boundingBox();
        if(mobile)await page.touchscreen.tap(box.x+p.x*box.width,box.y+p.y*box.height);else await page.mouse.click(box.x+p.x*box.width,box.y+p.y*box.height);
        await page.waitForTimeout(70);await page.waitForFunction(()=>!farmCocos.ui().animating);
      }
      async function layout(){
        const u=await page.evaluate(()=>farmCocos.ui());
        assert.equal(u.fullBleed,true);assert.equal(Math.min(u.width,u.height),720);
        assert.ok(Math.abs(u.viewport.width-u.canvas.width)<2&&Math.abs(u.viewport.height-u.canvas.height)<2,'game fills the whole canvas, no letterbox');
        const box=await page.locator('#GameCanvas').boundingBox(),dims=await page.evaluate(()=>({w:innerWidth,h:innerHeight}));
        assert.ok(Math.abs(box.width/box.height-dims.w/dims.h)<.02,'canvas keeps the window aspect; no CSS rotation');
        assert.ok(Math.abs(u.width/u.height-dims.w/dims.h)<.02,'design size follows the window aspect');
        const controls=await page.evaluate(()=>farmCocos.controls());
        const rects=controls.map(c=>({id:c.id,x:c.x,y:c.y,w:c.w/u.width*u.viewport.width/u.canvas.width,h:c.h/u.height*u.viewport.height/u.canvas.height}));
        for(let i=0;i<rects.length;i++){
          const a=rects[i];assert.ok(a.x-a.w/2>=0&&a.x+a.w/2<=1&&a.y-a.h/2>=0&&a.y+a.h/2<=1,'button fits '+a.id);
          for(const b of rects.slice(i+1))assert.ok(Math.abs(a.x-b.x)>=(a.w+b.w)/2-.002||Math.abs(a.y-b.y)>=(a.h+b.h)/2-.002,`buttons overlap ${a.id}/${b.id}`);
        }
        return u;
      }
      try{
        await page.goto('http://127.0.0.1:'+server.address().port);await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:45000});
        await tap('welcome-start');
        const u=await layout();
        const map=await page.evaluate(()=>farmCocos.map()),home=map.camera;
        assert.equal(home.mode,'home');
        // Every active field and configured pen sits between header and navigation on any aspect: a window wider or taller
        // than the authored map zooms out past it and the runtime forests the visible margin instead of showing grass.
        const f=u.viewport.height/u.canvas.height/u.height,top=u.viewport.y/u.canvas.height,minY=top+104*f,maxY=1-(top+196*f);
        const targets=await page.evaluate(()=>farmCocos.targets());assert.equal(targets.length,42);
        assert.ok(targets.every(t=>t.screen.x>0&&t.screen.x<1&&t.screen.y>=minY-.01&&t.screen.y<=maxY+.01),'all 42 built slots visible at home');
        assert.ok(map.zoom>=map.minZoom-1e-6&&map.minZoom>0,'opening view respects the minimum zoom');
        // The margin also reserves the fitted home's pan offset, even when map zoom already fits.
        const authored=require('../assets/farm/prefabs/items/catalog.json').decorInstances,b=map.bounds;
        const mapFit=Math.max(1,u.width/((b.right-b.left)*map.scale),u.height/((b.top-b.bottom)*map.scale));
        if(map.minZoom<mapFit-1e-6 || map.reach.left<b.left || map.reach.right>b.right || map.reach.bottom<b.bottom || map.reach.top>b.top)
          assert.ok(map.decor.marginScenery>0,'zoom and home pan beyond the authored map have a forest margin');
        assert.equal(map.decor.standing,authored+map.decor.marginScenery);
        assert.ok(map.decor.instances.every(s=>s.linked&&s.frame),'every standing tree and prop is a linked prefab with art');
        assert.equal(map.decor.species.length,12,'the same twelve species continue into the margin');
        assert.equal(await page.evaluate(()=>farmCocos.controls().some(c=>['zoom-in','zoom-out','zoom-reset','camera-home','fullscreen','focus-crop','focus-pen','focus-pond'].includes(c.id))),false,'camera rows removed');
        await page.screenshot({path:path.join(artifacts,name+'-home.png')});
        // Pinch or wheel leaves the opening view; the manual camera survives rotation.
        const box=await page.locator('#GameCanvas').boundingBox(),cx=box.x+box.width/2,cy=box.y+box.height*.45;
        if(mobile){
          const cdp=await context.newCDPSession(page);
          await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{x:cx-20,y:cy,id:1},{x:cx+20,y:cy,id:2}]});
          await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{x:cx-40,y:cy,id:1},{x:cx+40,y:cy,id:2}]});
          await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});await cdp.detach();
        } else {await page.mouse.move(cx,cy);for(let i=0;i<3;i++){await page.mouse.wheel(0,-300);await page.waitForTimeout(40);}}
        await page.waitForTimeout(150);
        const manual=await page.evaluate(()=>farmCocos.map().camera);
        assert.equal(manual.mode,'manual');assert.ok(manual.displayScale>home.displayScale,'zoomed in past the opening view');
        const before=await page.evaluate(()=>farmCocos.snapshot());
        await page.setViewportSize({width:height,height:width});
        await page.waitForTimeout(600);await layout();
        const rotatedMap=await page.evaluate(()=>farmCocos.map()),after=rotatedMap.camera;
        const expectedScale=Math.max(manual.displayScale,rotatedMap.minZoom*rotatedMap.scale);
        assert.equal(after.mode,'manual');assert.ok(Math.abs(after.displayScale-expectedScale)<.02,'camera retains display scale or clamps to the resized minimum');
        // Rotation can expose a forest edge. Preserve the old center wherever it still fits,
        // otherwise choose the nearest center that keeps the resized viewport inside the reachable map.
        const rotatedUi=await page.evaluate(()=>({width:farmCocos.ui().width,height:farmCocos.ui().height})),reach=rotatedMap.reach,bounds=rotatedMap.bounds;
        for(const [axis,low,high,extent] of [['x','left','right','width'],['y','bottom','top','height']]){
          const center=(bounds[low]+bounds[high])/2,half=rotatedUi[extent]/(2*after.displayScale);
          const min=Math.min(center,reach[low]+half),max=Math.max(center,reach[high]-half);
          const expected=Math.max(min,Math.min(max,manual[axis]));
          assert.ok(Math.abs(after[axis]-expected)<.02,'camera preserves center or clamps at forest edge: '+axis);
        }
        assert.equal((await page.evaluate(()=>farmCocos.snapshot())).coins,before.coins);
        await tap('factory');assert.equal(await page.evaluate(()=>farmCocos.ui().view),'factory');
        await page.setViewportSize({width,height});await page.waitForTimeout(600);
        assert.equal(await page.evaluate(()=>farmCocos.ui().view),'factory');
        await tap('close-panel');await tap('pause-menu');await tap('home');
        assert.equal(await page.evaluate(()=>farmCocos.map().camera.mode),'home');
        await page.reload();await page.waitForFunction(()=>globalThis.farmCocos);
        assert.equal(await page.evaluate(()=>farmCocos.map().camera.mode),'home');
        assert.deepEqual(errors,[]);console.log(name+': full-bleed HUD, opening view, zoom gesture, resize/rotation and reload OK');
      }catch(e){await page.screenshot({path:path.join(artifacts,name+'-failure.png')});throw e;}
      finally{await context.close();}
    }
  }finally{await browser.close();await new Promise(resolve=>{server.close(resolve);server.closeAllConnections?.();});}
})().catch(e=>{console.error(e);process.exitCode=1;server.close();});
