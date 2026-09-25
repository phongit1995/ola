'use strict';
// Real wall-clock soak. PERF_SECONDS is only for short preflights, never a 30-minute claim.
const fs=require('node:fs'),path=require('node:path'),http=require('node:http'),os=require('node:os'),crypto=require('node:crypto');
const {execFileSync}=require('node:child_process'),{chromium}=require('playwright');
const root=path.resolve(__dirname,'..'),build=process.env.COCOS_TEST_BUILD?path.resolve(process.env.COCOS_TEST_BUILD):path.join(root,'build/farm-web-mobile'),out=process.env.COCOS_TEST_OUTPUT?path.resolve(process.env.COCOS_TEST_OUTPUT):path.resolve(root,'../artifacts/simple-farm');
const seconds=Number(process.env.PERF_SECONDS??1800),chunk=Math.min(30,seconds);
// Full Chromium uses the browser's normal graphics backend; headless-shell falls back to CPU rendering on this Mac.
const browserChannel=process.env.PLAYWRIGHT_CHANNEL||'chromium';
const server=http.createServer((req,res)=>{if(req.url==='/favicon.ico')return res.writeHead(204).end();const file=path.resolve(build,'.'+decodeURIComponent(new URL(req.url,'http://localhost').pathname)),p=file===build?path.join(build,'index.html'):file;if(!p.startsWith(build+path.sep)||!fs.existsSync(p)||!fs.statSync(p).isFile())return res.writeHead(404).end();res.setHeader('Content-Type',({'.html':'text/html','.js':'text/javascript','.json':'application/json','.wasm':'application/wasm','.png':'image/png','.css':'text/css'})[path.extname(p)]||'application/octet-stream');fs.createReadStream(p).pipe(res);});
function fingerprint(){const hash=crypto.createHash('sha256');function visit(dir){for(const name of fs.readdirSync(dir).sort()){const p=path.join(dir,name);if(fs.statSync(p).isDirectory())visit(p);else{hash.update(path.relative(root,p));hash.update(fs.readFileSync(p));}}}visit(path.join(root,'assets'));return hash.digest('hex');}
(async()=>{
 const sourceHash=fingerprint();await new Promise(r=>server.listen(0,'127.0.0.1',r));const browser=await chromium.launch({headless:true,channel:browserChannel,args:['--enable-precise-memory-info']});const errors=[],samples=[];fs.mkdirSync(out,{recursive:true});
 const filename=path.join(out,seconds>=1800?'performance-30min.json':'performance-preflight.json');
 try{
  const page=await browser.newPage({viewport:{width:1280,height:720},hasTouch:true});page.on('pageerror',e=>errors.push(e.message));page.on('console',m=>{if(m.type()==='error')errors.push(m.text());});page.on('response',r=>{if(r.status()>=400)errors.push(r.status()+' '+r.url());});
  const loadStart=performance.now();await page.goto('http://127.0.0.1:'+server.address().port);await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});const loadMs=performance.now()-loadStart;
  const fixture=await page.evaluate(async()=>{
   const cc=await System.import('cc'),a=cc.director.getScene().getChildByName('Canvas').getComponent('GameApp'),g=a.game;globalThis.soakApp=a;
   const ok=r=>{if(r.error)throw Error(r.error);};ok(g.dismissGuide());a.close();g.state.coins=1000000;g.state.xp=100000;for(const i of g.items)g.state.inventory[i.key]=100000;
   // This funded stress fixture unlocks the full current catalog; it does not measure progression.
   g.state.husbandry={version:1,feedReceived:true,eggsCollected:true,milkCollected:true,burgerCollected:true};
   for(const p of g.state.plots.filter(p=>p.group==='crop'))Object.assign(p,{crop:null,snapshot:null,started:0,ready:0,boosted:false});
   for(const t of g.machineTypes)while(g.machinePurchasePrice(t.id)!==null)ok(g.buyMachine(t.id));
   const crops=g.catalog.farm.filter(f=>f.group==='crop');g.state.plots.filter(p=>p.group==='crop').forEach((p,i)=>ok(g.plant(p.id,crops[i%crops.length].id)));
   g.state.xp=620;
   for(const definition of g.catalog.residentPens){const p=g.state.plots.find(p=>p.cell===definition.cell&&p.group==='pen');if(!p.residents)ok(g.buyPen(p.id));while(p.residents.capacity<5)ok(g.expandPen(p.id,p.residents.capacity));ok(g.feedAnimals(p.id));}
   for(const m of g.state.machines){while(m.capacity<5)ok(g.expandQueue(m.id));const r=g.catalog.products.find(r=>r.machine===m.type);while(g.canQueue(m))ok(g.produce(r.id,m.id));}
   g.validate();a.refresh();a.map.update();a.save();
   globalThis.soakActivity=()=>{
    const g=a.game;
    const harvested=[];for(const p of g.state.plots)if(g.isReady(p)){harvested.push([p.id,p.crop]);ok(g.harvest(p.id));}
    a.map.update();for(const [id,crop] of harvested)ok(g.plant(id,crop));
    for(const p of g.state.plots.filter(p=>p.residents)){if(p.residents.animals.some(x=>x.job&&x.job.ready<=g.state.time))ok(g.collectAnimals(p.id));if(p.residents.animals.some(x=>!x.job))ok(g.feedAnimals(p.id));}
    for(const m of g.state.machines){while(m.tray.length)ok(g.collect(m.id));const r=g.catalog.products.find(r=>r.machine===m.type);while(g.canQueue(m)&&g.has(r.ingredients.map(i=>({key:i.key??'raw:'+i.id,quantity:i.quantity}))))ok(g.produce(r.id,m.id));}
    g.validate();a.save();a.refresh();
   };
   return {fields:40,species:g.state.plots.filter(p=>p.residents).length,residents:g.state.plots.reduce((n,p)=>n+(p.residents?.animals.length??0),0),machines:g.state.machines.length,queueSlots:g.state.machines.reduce((n,m)=>n+m.capacity,0),sites:farmCocos.buildings().length};
  });
  await page.waitForTimeout(2000);
  await page.evaluate(()=>{const state={dt:[],last:0,running:true};globalThis.soakFrames=state;function frame(t){if(state.last)state.dt.push(t-state.last);state.last=t;if(state.running)requestAnimationFrame(frame);}requestAnimationFrame(frame);});
  const cdp=await page.context().newCDPSession(page),initialHeap=await cdp.send('Runtime.getHeapUsage');const start=performance.now();
  const hardware={model:process.platform==='darwin'?execFileSync('sysctl',['-n','hw.model'],{encoding:'utf8'}).trim():os.hostname(),cpu:os.cpus()[0].model,ramBytes:os.totalmem(),platform:os.platform(),arch:os.arch(),browser:browser.version(),browserChannel,renderer:await page.evaluate(()=>{const gl=document.querySelector('canvas').getContext('webgl2');if(!gl)return 'unavailable';const ext=gl.getExtension('WEBGL_debug_renderer_info');return ext?gl.getParameter(ext.UNMASKED_RENDERER_WEBGL):gl.getParameter(gl.RENDERER);})};
  while((performance.now()-start)/1000<seconds){
   await new Promise(r=>setTimeout(r,Math.min(chunk*1000,Math.max(1,seconds*1000-(performance.now()-start)))));
   const frames=await page.evaluate(()=>{const values=soakFrames.dt;soakFrames.dt=[];return values;}),heap=await cdp.send('Runtime.getHeapUsage'),elapsed=(performance.now()-start)/1000;
   frames.sort((a,b)=>a-b);const sum=frames.reduce((a,b)=>a+b,0),sample={elapsedSeconds:elapsed,frames:frames.length,fps:frames.length*1000/sum,p95Ms:frames[Math.floor(frames.length*.95)]??null,maxMs:frames.at(-1)??null,heapBytes:heap.usedSize,viewport:page.viewportSize()};samples.push(sample);
   fs.writeFileSync(filename,JSON.stringify({status:'running',sourceHash,hardware,loadMs,fixture,initialHeap,samples,errors},null,2));console.log(JSON.stringify(sample));
   if(elapsed>=seconds)break;
   await page.evaluate(()=>soakActivity());
   if(samples.length%5===0){const portrait=samples.length%10===5;await page.setViewportSize(portrait?{width:390,height:844}:{width:1280,height:720});}
   await page.evaluate(i=>{soakApp.close();const sites=['bakery-1','industry-pie_bakery','industry-popcorn_factory','feed-1'];if(i%5===0)soakApp.map.focusHome();else soakApp.map.focusBuilding(sites[i%4]);},samples.length);
  }
  await page.evaluate(()=>{soakFrames.running=false;soakApp.game.validate();});const elapsedSeconds=(performance.now()-start)/1000,finalHeap=await cdp.send('Runtime.getHeapUsage'),unchanged=sourceHash===fingerprint();
  const passed=seconds>=1800&&elapsedSeconds>=1800&&unchanged&&!errors.length&&samples.every(s=>s.fps>=30&&s.p95Ms<=33.5);
  const report={status:seconds>=1800?'completed':'preflight-only',passed,elapsedSeconds,sourceUnchanged:unchanged,sourceHash,hardware,loadMs,fixture,initialHeap,finalHeap,samples,errors,note:'Headless Chromium on the named host. Portrait viewports emulate layout; this is not a measurement from an Android/iOS device. Uses real wall time at game speed 1, with all 40 fields, 8 machines, 20 resident animals across 4 species and ongoing harvest/feed/queue activity.'};
  fs.writeFileSync(filename,JSON.stringify(report,null,2));await page.screenshot({path:path.join(out,seconds>=1800?'performance-30min.png':'performance-preflight.png')});console.log(JSON.stringify({status:report.status,passed,elapsedSeconds,errors}));if(seconds>=1800&&!passed)process.exitCode=1;
 }finally{await browser.close();await new Promise(r=>{server.close(r);server.closeAllConnections?.();});}
})().catch(e=>{console.error(e);process.exitCode=1;server.close();});
