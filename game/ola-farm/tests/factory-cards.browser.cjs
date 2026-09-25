'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, plot, site, state, observe } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/factory-cards');
const cases = [[393,585],[568,320],[1280,720]];

async function cards(page) {
  return page.evaluate(() => {
    const a = testApp, cc = testCc, v = a.panels.card.getComponentInChildren('FactoryBodyView');
    const active = type => v.node.getComponentsInChildren(type).filter(c => c.node.activeInHierarchy);
    const u = a.width / cc.view.getFrameSize().width;
    return { root:v.node.uuid, recipe:a.panels.selectedRecipeId,
      previewsHidden:[...v.choicePreviews,...v.ingredientPreviews].every(n=>!n.active),
      choices:active('RecipeChoiceView').map(c=>({id:c.node.name,uuid:c.node.uuid,name:c.recipeName.string,
        linked:!!c.node.prefab?.asset,font:c.recipeName.fontSize/u,color:[c.recipeName.color.r,c.recipeName.color.g,c.recipeName.color.b],
        iconX:c.product.node.position.x/u,selected:c.selected.active})),
      ingredients:active('IngredientItemView').map(c=>({id:c.node.name,uuid:c.node.uuid,name:c.itemName.string,stock:c.stock.string,
        linked:!!c.node.prefab?.asset,font:c.stock.fontSize/u,nameX:c.itemName.node.position.x/u})),
      controls:farmCocos.controls().map(c=>c.id),
    };
  });
}

(async () => {
  fs.mkdirSync(out,{recursive:true});
  const server = await serve(), browser = await launch(), reports = [];
  try {
    for (const [width,height] of cases) {
      const context = await browser.newContext({viewport:{width,height},hasTouch:true}), page = await context.newPage(), observed = observe(page);
      await context.addInitScript(()=>{globalThis.testNow=1900000000000;Date.now=()=>globalThis.testNow;});
      try {
        await boot(page,server.url); await tap(page,'welcome-start',true); await site(page,'bakery-1',true);
        let shown = await cards(page); assert.equal(shown.ingredients.length,1); assert.ok(shown.previewsHidden);
        assert.ok(shown.ingredients.every(c=>c.linked));
        await page.screenshot({path:path.join(out,`${width}-recipe.png`)});
        await tap(page,'choose-recipe',true); shown = await cards(page);
        assert.equal(shown.choices.length,5); assert.ok(shown.choices.every(c=>c.linked));
        assert.ok(shown.choices.some(c=>c.name.includes('Chưa mở')));
        await page.screenshot({path:path.join(out,`${width}-choices.png`)});

        // Isolated scalability fixture: two additional bakery recipes, six real item keys,
        // and edits to loaded prefab source data, as made in the Inspector before instantiation.
        const fixture = await page.evaluate(() => {
          const a=testApp,cc=testCc; a.close();
          const f=a.ui.prefabs.factoryBody.data.getComponent('FactoryBodyView');
          const choice=f.recipeChoicePrefab.data.getComponent('RecipeChoiceView');
          choice.recipeName.fontSize=14; choice.recipeName.color=new cc.Color(44,99,155);
          choice.product.node.setPosition(7,12);
          const ingredient=f.ingredientItemPrefab.data.getComponent('IngredientItemView');
          ingredient.stock.fontSize=14; ingredient.itemName.node.setPosition(25,11);
          // The default screenshots instantiated these assets already. Creator caches their
          // creation functions, so rebuild those functions after this source-edit fixture.
          f.recipeChoicePrefab.compileCreateFunction(); f.ingredientItemPrefab.compileCreateFunction();
          const g=a.game, bread=g.product(7), keys=g.catalog.items.slice(0,6).map(i=>i.key);
          const inputs=keys.map((key,i)=>({key,quantity:i+1}));
          g.catalog.products.push({...bread,id:910001,key:'test:extra-bread',name:'Món thử 6'},
            {...bread,id:910002,key:'test:six-ingredients',name:'Món thử 7',ingredients:inputs});
          g.state.coins=20000;g.state.xp=1e8;
          for(const key of keys)g.state.inventory[key]=30;
          g.state.inventory[keys[5]]=0;g.state.inventory['farm40:chicken-feed']=5;
          g.validate();a.save();a.refresh();return {inputs};
        });
        await site(page,'bakery-1',true); await tap(page,'choose-recipe',true);
        const expanded=await cards(page); assert.equal(expanded.choices.length,7); assert.ok(expanded.previewsHidden);
        for(const c of expanded.choices){assert.ok(c.linked);assert.ok(Math.abs(c.font-14)<1,JSON.stringify(c));assert.deepEqual(c.color,[44,99,155]);assert.ok(Math.abs(c.iconX-7)<1e-4);}
        await tap(page,'select-recipe-910002',true); shown=await cards(page);
        assert.equal(shown.recipe,910002);assert.equal(shown.ingredients.length,6);assert.equal(shown.choices.length,0);
        assert.ok(!shown.controls.some(id=>id.startsWith('select-recipe-')),'hidden choices leave no registered controls');
        assert.ok(shown.ingredients[5].stock.includes('Thiếu'));
        for(const c of shown.ingredients){assert.ok(c.linked);assert.ok(Math.abs(c.font-14)<1);assert.ok(Math.abs(c.nameX-25)<1e-4);}
        await tap(page,'recipe-ingredient-5',true);
        assert.equal(await page.evaluate(()=>testApp.panels.view),'ingredients');
        await tap(page,'ingredients-back',true); assert.equal((await cards(page)).recipe,910002);
        await page.evaluate(inputs=>{for(const input of inputs)testApp.game.state.inventory[input.key]=30;testApp.refresh();testApp.panels.refresh(true);},fixture.inputs);
        const before=await state(page), stable=await cards(page);
        await page.evaluate(()=>{for(let i=0;i<3;i++)testApp.panels.render();});
        assert.deepEqual((await cards(page)).ingredients.map(c=>c.uuid),stable.ingredients.map(c=>c.uuid));
        await tap(page,'produce-910002',true);
        const after=await state(page), bakery=after.machines.find(m=>m.type===1);
        assert.equal(bakery.job.product,910002);assert.equal(bakery.waiting.length,0);
        for(const input of fixture.inputs)assert.equal(after.inventory[input.key],before.inventory[input.key]-input.quantity,'a rebound click charges exactly once');
        await tap(page,'choose-recipe',true);await tap(page,'select-recipe-7',true);
        const small=await cards(page);assert.equal(small.ingredients.length,1);
        assert.equal(small.controls.filter(id=>id.startsWith('recipe-ingredient-')).length,1,'surplus ingredient controls are removed');
        assert.equal(small.ingredients[0].uuid,stable.ingredients[0].uuid,'existing cards are reused when a list shrinks');
        const rotated=width<500?{width:568,height:320}:{width:393,height:585};
        await page.setViewportSize(rotated);
        await page.waitForFunction(width=>testCc.view.getFrameSize().width===width&&testApp.panels.frameWidth===width,rotated.width);
        const resized=await cards(page);assert.equal(resized.root,small.root);assert.equal(resized.ingredients[0].uuid,small.ingredients[0].uuid);
        assert.ok(Math.abs(resized.ingredients[0].nameX-25)<1e-4);assert.ok(Math.abs(resized.ingredients[0].font-14)<1);
        await tap(page,'choose-recipe',true);assert.equal((await cards(page)).choices.length,7);
        await page.screenshot({path:path.join(out,`${width}-expanded-inspector.png`)});

        // The cleaned livestock prefab still feeds/collects through native controls.
        await page.evaluate(()=>{testApp.close();testApp.map.focusBuilding('pen:12');});await plot(page,12,true);
        const dead=await page.evaluate(()=>{const v=testApp.panels.card.getComponentInChildren('LivestockBodyView');
          const names=[];function walk(n){names.push(n.name);n.children.forEach(walk);}walk(v.node);
          return names.filter(n=>['HerdCount','SellActions','manage-herd','care-herd','herd-production-return','FeedSourceArrow'].includes(n));});
        assert.deepEqual(dead,[]);let farm=await state(page),feed=farm.inventory['farm40:chicken-feed'];
        await tap(page,'feed-all',true);assert.equal((await state(page)).inventory['farm40:chicken-feed'],feed-1);
        await page.evaluate(()=>{testApp.session.suspend();globalThis.testNow+=1800000;testApp.session.resume();testApp.panels.refresh(true);});
        const eggs=(await state(page)).inventory['farm40:egg']??0;
        await tap(page,'collect-all-animals',true);assert.equal((await state(page)).inventory['farm40:egg'],eggs+1);
        assert.deepEqual(observed.errors,[]);
        reports.push({width,height,passed:true,recipes:7,ingredients:6,inspectorPreserved:true,stableCards:true,singleCharge:true,livestockCare:true});
        console.log(`${width}x${height}: extracted cards, dynamic lists, Inspector edits, resize, navigation and livestock PASS`);
      } catch(error) {await page.screenshot({path:path.join(out,`${width}-failure.png`)});throw error;}
      finally {await context.close();}
    }
    fs.writeFileSync(path.join(out,'results.json'),JSON.stringify({passed:true,method:'Native input on the current build; explicit in-memory catalog/stock fixture and loaded prefab Inspector edits. Source config files remain unchanged.',reports},null,2)+'\n');
  } finally {await browser.close();await server.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
