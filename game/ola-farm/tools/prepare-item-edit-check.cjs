'use strict';
// A disposable project proves edits propagate from prefab sources, without changing the working assets.
const fs=require('node:fs'),path=require('node:path');
const source=path.resolve(__dirname,'..'),project=path.join(source,'artifacts','cocos-item-edit-'+Date.now());
fs.mkdirSync(project,{recursive:true});
for(const folder of ['assets','settings','build-configs'])fs.cpSync(path.join(source,folder),path.join(project,folder),{recursive:true});
for(const file of ['package.json','tsconfig.json'])fs.copyFileSync(path.join(source,file),path.join(project,file));
const items=path.join(project,'assets/farm/prefabs/items');
function edit(file,select,offset){const target=path.join(items,file),p=JSON.parse(fs.readFileSync(target,'utf8'));select(p)._lpos.x+=offset;fs.writeFileSync(target,JSON.stringify(p,null,2)+'\n');}
const forest=JSON.parse(fs.readFileSync(path.join(project,'assets/farm/data/farm-decor/forest.json'),'utf8'));
const tree=forest.species[0].id;
edit('scenery/'+tree+'.prefab',p=>p.find(n=>n.__type__==='cc.Node'&&n._name==='Visual'),17);
edit('crops/Wheat.prefab',p=>p[p.find(n=>n.__type__==='cc.Node'&&n._name==='Stage3')._children[0].__id__],11);
// Exercise both a region's authored root pose and one placement inside it after runtime depth flattening.
const regionFile=path.join(project,'assets/farm/prefabs/map/ForestNE.prefab'),region=JSON.parse(fs.readFileSync(regionFile,'utf8'));
const regionRoot=region[region[0].data.__id__];regionRoot._lpos.x+=13;
region[regionRoot._children[0].__id__]._lpos.x+=23;
fs.writeFileSync(regionFile,JSON.stringify(region,null,2)+'\n');
const hiddenFile=path.join(project,'assets/farm/prefabs/map/ForestNW.prefab'),hidden=JSON.parse(fs.readFileSync(hiddenFile,'utf8'));
hidden[hidden[0].data.__id__]._active=false;
fs.writeFileSync(hiddenFile,JSON.stringify(hidden,null,2)+'\n');
console.log(project);
