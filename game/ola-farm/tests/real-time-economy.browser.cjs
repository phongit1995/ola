'use strict';
// Real UI with a controlled wall clock; no waiting for hours in the test runner.
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {serve,launch,boot,tap,plot,state,observe}=require('./browser-support.cjs');
const out=path.resolve(__dirname,'../artifacts/real-time-economy/browser');
(async()=>{
 fs.mkdirSync(out,{recursive:true});const server=await serve(),browser=await launch(),reports=[];
 try{
  for(const viewport of [{width:390,height:844},{width:844,height:390},{width:1280,height:720}]){
   const context=await browser.newContext({viewport,hasTouch:true});const page=await context.newPage(),errors=observe(page);
   // Use a mutable clock source across reloads; rendering retains its real animation clock.
   await context.addInitScript(()=>{const actualNow=Date.now.bind(Date);Date.now=()=>actualNow()+Number(localStorage.getItem('test-wall-offset')||0);});
   try{
    await boot(page,server.url);await tap(page,'welcome-start',true);
    await plot(page,0,true);
    const cropControls=await page.evaluate(()=>farmCocos.controls().filter(c=>c.id.startsWith('plant-')).map(c=>[c.id,c.enabled]));
    assert.equal(cropControls.length,8);assert.deepEqual(cropControls.filter(c=>c[1]).map(c=>c[0]),['plant-1']);
    const locked=await page.evaluate(()=>farmCocos.labels().filter(l=>/^Lv /.test(l.text)).map(l=>l.text));
    assert.ok(locked.includes('Lv 2'));assert.ok(locked.includes('Lv 24'));
    await page.screenshot({path:path.join(out,`${viewport.width}-locked-seeds.png`)});
    await tap(page,'plant-1',true);let s=await state(page);assert.equal(s.coins,480);assert.equal(s.plots[0].snapshot.duration,300);assert.equal(s.xp,0);
    // Suspend via the application lifecycle and return after five real minutes.
    await page.evaluate(()=>{testApp.onHide();localStorage.setItem('test-wall-offset','300000');testApp.onShow();});
    s=await state(page);assert.ok(s.plots[0].ready<=s.time);assert.equal(s.inventory['raw:1']??0,0);
    await plot(page,0,true);s=await state(page);assert.equal(s.inventory['raw:1'],3);assert.equal(s.xp,2);
    await tap(page,'pause-menu',true);
    const menu=await page.evaluate(()=>({labels:farmCocos.labels().map(l=>l.text),controls:farmCocos.controls().map(c=>c.id),speed:farmCocos.ui().speed}));
    assert.equal(menu.speed,1);assert.ok(!menu.controls.includes('speed-6'));assert.ok(!menu.controls.includes('speed-12'));assert.ok(menu.labels.some(l=>l.includes('Thời gian thực')));
    await page.screenshot({path:path.join(out,`${viewport.width}-real-time-menu.png`)});
    await tap(page,'resume',true);await tap(page,'inventory',true);await tap(page,'stock-raw:1',true);await tap(page,'sale-max',true);
    assert.ok((await page.evaluate(()=>farmCocos.labels().map(l=>l.text))).some(t=>t==='24 xu'));
    await tap(page,'sale-confirm',true);s=await state(page);assert.equal(s.coins,504);assert.equal(s.xp,2);
    // Isolated threshold fixture: retain this actual farm, set only XP, then use native controls.
    await page.evaluate(()=>{testApp.close();testApp.game.state.xp=80;testApp.session.save();testApp.refresh();});
    await plot(page,1,true);
    const corn=await page.evaluate(()=>farmCocos.controls().find(c=>c.id==='plant-10'));assert.equal(corn.enabled,true);
    await tap(page,'plant-10',true);s=await state(page);assert.equal(s.plots[1].snapshot.duration,900);assert.equal(s.coins,474);
    await page.evaluate(()=>{testApp.onHide();localStorage.setItem('test-wall-offset','1200000');});
    await page.reload();await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});
    s=await state(page);assert.ok(s.plots[1].ready<=s.time);assert.equal(s.inventory['farm40:corn']??0,0);assert.equal(s.coins,474);
    const settled=s.time;await page.reload();await page.waitForFunction(()=>globalThis.farmCocos,undefined,{timeout:60000});s=await state(page);
    assert.ok(s.time>=settled&&s.time-settled<60);assert.equal(s.inventory['farm40:corn']??0,0);assert.equal(s.coins,474);
    assert.deepEqual(errors.errors,[]);reports.push({viewport,passed:true,crops:8,unlockedInitially:1,offlineCropReady:true,duplicateRewards:false});
   }catch(error){await page.screenshot({path:path.join(out,`${viewport.width}-failure.png`)});throw error;}
   finally{await context.close();}
  }
  fs.writeFileSync(path.join(out,'results.json'),JSON.stringify({passed:true,method:'Actual native controls; wall clock offset and one explicit XP threshold fixture; not real human wait-time measurement.',reports},null,2)+'\n');console.log(JSON.stringify(reports));
 }finally{await browser.close();await server.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
