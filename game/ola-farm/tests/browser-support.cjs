'use strict';
const fs=require('node:fs'),path=require('node:path'),http=require('node:http'),assert=require('node:assert/strict');
const {chromium}=require('playwright');
const build=process.env.COCOS_TEST_BUILD?path.resolve(process.env.COCOS_TEST_BUILD):path.resolve(__dirname,'../build/farm-web-mobile');
async function serve(){
 const server=http.createServer((req,res)=>{if(req.url==='/favicon.ico')return res.writeHead(204).end();let file;try{file=path.resolve(build,'.'+decodeURIComponent(new URL(req.url,'http://localhost').pathname));}catch{return res.writeHead(400).end();}if(file===build)file=path.join(build,'index.html');if(!file.startsWith(build+path.sep)||!fs.existsSync(file)||!fs.statSync(file).isFile())return res.writeHead(404).end();res.setHeader('Content-Type',({'.html':'text/html','.js':'text/javascript','.json':'application/json','.wasm':'application/wasm','.png':'image/png','.css':'text/css'})[path.extname(file)]||'application/octet-stream');fs.createReadStream(file).pipe(res);});
 await new Promise(r=>server.listen(0,'127.0.0.1',r));return {url:'http://127.0.0.1:'+server.address().port,close:()=>new Promise(r=>{server.close(r);server.closeAllConnections?.();})};
}
const launch=()=>chromium.launch({headless:true,...(process.env.PLAYWRIGHT_CHANNEL?{channel:process.env.PLAYWRIGHT_CHANNEL}:{})});
const state=page=>page.evaluate(()=>farmCocos.snapshot());
function skinFrames(bundle) {
 const directory=path.resolve(__dirname,'../assets/farm/bundles',bundle);
 const manifest=JSON.parse(fs.readFileSync(path.join(directory,'manifest.json'),'utf8'));
 return Object.fromEntries(Object.entries(manifest.images).map(([key,info])=>[key,JSON.parse(fs.readFileSync(path.join(directory,info.resource+'.png.meta'),'utf8')).uuid+'@f9941']));
}
async function boot(page,url){await page.goto(url);await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});await page.evaluate(async frames=>{globalThis.testCc=await System.import('cc');globalThis.testApp=testCc.director.getScene().getChildByName('Canvas').getComponent('GameApp');globalThis.testUiFrames=frames;},{island:skinFrames('golden-island-ui'),town:skinFrames('farm-town-ui')});}
async function tap(page,id,touch=false){
 // Domain timers can finish before the panel's next 250 ms refresh enables its button.
 // Wait for the user-visible action, rather than tapping the previous disabled state.
 await page.waitForFunction(id=>farmCocos.controls().some(c=>c.id===id&&c.enabled!==false),id,{timeout:10000});
 let target;
 for(let tries=0;tries<60;tries++){
  target=await page.evaluate(id=>{
   const a=testApp,cc=testCc,n=a.ui.controls.get(id);if(!n?.activeInHierarchy)throw Error('Missing control '+id+' in '+a.panels.view);
   const box=n=>{const t=n.getComponent(cc.UITransform),p=n.worldPosition,s=n.worldScale;return {x:p.x-t.width*t.anchorX*s.x,y:p.y-t.height*t.anchorY*s.y,w:t.width*s.x,h:t.height*s.y};};
   const b=box(n);let clip=null;for(let p=n.parent;p;p=p.parent)if(p.getComponent(cc.Mask))clip=box(p);
   const viewport=cc.view.getViewportRect(),canvas=cc.view.getCanvasSize();
   const scrollAt=clip?{x:(viewport.x+(clip.x+clip.w/2)*cc.view.getScaleX())/canvas.width,y:1-(viewport.y+(clip.y+clip.h/2)*cc.view.getScaleY())/canvas.height}:null;
   const below=clip?Math.max(0,clip.y-b.y):0,above=clip?Math.max(0,b.y+b.h-clip.y-clip.h):0;
   const left=clip?Math.max(0,clip.x-b.x):0,right=clip?Math.max(0,b.x+b.w-clip.x-clip.w):0;
   const horizontal=left>1||right>1;
   return {...farmCocos.controls().find(t=>t.id===id),clipped:!!clip&&(below>1||above>1||horizontal),direction:horizontal?(right>0?-1:1):(below>0?1:-1),scrollDelta:Math.max(4,Math.min(120,Math.max(below,above,left,right)*2+4)),scrollAt};
  },id);
  if(!target.clipped)break;
  // Cocos applies wheel Y to its enabled axis; horizontal cards and vertical rows use opposite reveal directions.
  // A fixed160 delta overshoots a nearly visible control.
  const b=await page.locator('#GameCanvas').boundingBox();await page.mouse.move(b.x+b.width*(target.scrollAt?.x??.5),b.y+b.height*(target.scrollAt?.y??.5));await page.mouse.wheel(0,target.direction*target.scrollDelta);await page.waitForTimeout(85);
 }
 assert.ok(!target.clipped,'Control remains clipped: '+id);assert.ok(target.x>0&&target.x<1&&target.y>0&&target.y<1,'Control outside canvas: '+id);
 await page.evaluate(()=>testApp.panels.scroll?.stopAutoScroll());
 // Stopping inertia may adjust the location, so read it again immediately before input.
 target=await page.evaluate(id=>farmCocos.controls().find(t=>t.id===id),id);
 const b=await page.locator('#GameCanvas').boundingBox(),x=b.x+target.x*b.width,y=b.y+target.y*b.height;
 if(touch)await page.touchscreen.tap(x,y);else await page.mouse.click(x,y);await page.waitForTimeout(90);
}
async function plot(page,id,touch=false){const p=await page.evaluate(id=>farmCocos.targets().find(p=>p.id===id)?.screen,id);assert.ok(p,'plot '+id);const b=await page.locator('#GameCanvas').boundingBox();assert.ok(p.x>0&&p.x<1&&p.y>0&&p.y<1);if(touch)await page.touchscreen.tap(b.x+p.x*b.width,b.y+p.y*b.height);else await page.mouse.click(b.x+p.x*b.width,b.y+p.y*b.height);await page.waitForTimeout(90);}
async function site(page,key,touch=false){await page.evaluate(key=>{testApp.close();testApp.map.focusBuilding(key);},key);await page.waitForTimeout(60);const p=await page.evaluate(key=>farmCocos.buildings().find(p=>p.buildingId===key)?.screen,key);assert.ok(p,key);const b=await page.locator('#GameCanvas').boundingBox();if(touch)await page.touchscreen.tap(b.x+p.x*b.width,b.y+p.y*b.height);else await page.mouse.click(b.x+p.x*b.width,b.y+p.y*b.height);await page.waitForTimeout(90);}
function observe(page){const errors=[],requests=[];page.on('pageerror',e=>errors.push(e.message));page.on('console',m=>{if(m.type()==='error')errors.push(m.text());});page.on('response',r=>{requests.push(r.url());if(r.status()>=400)errors.push(r.status()+' '+r.url());});return {errors,requests};}
module.exports={serve,launch,boot,tap,plot,site,state,observe,build};
