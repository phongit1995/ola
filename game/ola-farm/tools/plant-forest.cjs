'use strict';
// Regenerates authored forest, border rocks and ground details from the current layout.
// Both this tool and the runtime use ForestLayout.ts and the same forest.json; re-running is byte-identical.
const unregister = require('tsx/cjs/api').register();
const fs=require('node:fs'),path=require('node:path');
const {stableId,mapComponentTypes}=require('./cocos-ids.cjs');
const {appendNested,assertGraph}=require('./prefab-graph.cjs');
const {forestPlacements,rockPlacements,insideClearing}=require('../assets/farm/scripts/map/layout/ForestLayout.ts');
const {FARM_LAYOUT}=require('../assets/farm/scripts/core/FarmLayoutData.ts');
const {farmRoadLayout}=require('../assets/farm/scripts/core/FarmRoadLayout.ts');
unregister();
require('esbuild').stop();
const root=path.resolve(__dirname,'..'),file=path.join(root,'assets/farm/prefabs/map/scenes.prefab'),check=process.argv.includes('--check');
const read=f=>JSON.parse(fs.readFileSync(path.join(root,f),'utf8'));
const p=read('assets/farm/prefabs/map/scenes.prefab'),registry=read('assets/farm/data/farm-decor/manifest.json');
const config=read('source-assets/farm-beautify/layout.json'),catalog=read('assets/farm/prefabs/items/catalog.json');
const byId=new Map(registry.images.map(i=>[i.id,i]));
const get=r=>p[r.__id__],ref=__id__=>({__id__}),rootId=p[0].data.__id__,map=p[rootId];
const groups=Object.fromEntries(map._children.map(r=>[get(r)._name,r.__id__]));
const rootInfo=get(map._prefab),types=mapComponentTypes();
const id=key=>stableId('farm-beautify/'+key);
const farmGraph={objects:p,rootId,rootInfo};
function node(name,parent,x=0,y=0,scale=1,graph=farmGraph){
 const a=graph.objects,n=a.length;
 a.push({__type__:'cc.Node',_name:name,_objFlags:0,_parent:parent===null?null:ref(parent),_children:[],_active:true,_components:[],_prefab:ref(n+1),_lpos:{__type__:'cc.Vec3',x,y,z:0},_lrot:{__type__:'cc.Quat',x:0,y:0,z:0,w:1},_lscale:{__type__:'cc.Vec3',x:scale,y:scale,z:1},_layer:33554432,_euler:{__type__:'cc.Vec3',x:0,y:0,z:0},_id:''});
 a.push({__type__:'cc.PrefabInfo',root:ref(graph.rootId),asset:ref(0),fileId:id(name)});
 if(parent!==null)a[parent]._children.push(ref(n));return n;
}
function transform(n,w,h,anchor=[.5,.5],graph=farmGraph){
 const a=graph.objects,i=a.length;a[n]._components.push(ref(i));
 a.push({__type__:'cc.UITransform',_name:'',_objFlags:0,node:ref(n),_enabled:true,__prefab:ref(i+1),_id:'',_contentSize:{__type__:'cc.Size',width:w,height:h},_anchorPoint:{__type__:'cc.Vec2',x:anchor[0],y:anchor[1]}});
 a.push({__type__:'cc.CompPrefabInfo',fileId:id(a[n]._name+'/transform')});
}
const regionNames=['ForestNE','ForestNW','ForestSE','ForestSW','Border0','Border1','Border2','Border3'];
const regions=new Map(regionNames.map(name=>{
 const graph={objects:[{...p[0],_name:name,data:ref(1)}],rootId:1,uuid:stableId('farm-region/'+name)};
 node(name,null,0,0,1,graph);transform(1,1,1,[.5,.5],graph);
 graph.rootInfo=graph.objects[2];graph.rootInfo.nestedPrefabInstanceRoots=[];
 return [name,graph];
}));
function regionName(data){
 if(data.zone==='rock-border')return 'Border'+data.id.split('-')[1];
 if(!['forest','forest-rocks','forest-edge'].includes(data.zone))return null;
 const c=config.forest.clearing;
 return 'Forest'+(data.y>=(c.bottom+c.top)/2?'N':'S')+(data.x>=(c.left+c.right)/2?'E':'W');
}
const removed=new Set();
function removeTree(n){removed.add(n);for(const r of p[n]._children??[])removeTree(r.__id__);}
// Only generated groups are replaced. Kept facilities retain both fileIds and component references.
for(const r of p[groups.Scenery]._children)if(['BroadleafTree','PineTree'].includes(get(r)._name))removeTree(r.__id__);
p[groups.Scenery]._children=p[groups.Scenery]._children.filter(r=>!removed.has(r.__id__));
for(const name of ['GroundDecor','Decor']){
 if(groups[name]===undefined){groups[name]=node(name,rootId);transform(groups[name],1,1);}
 else{for(const r of p[groups[name]]._children)removeTree(r.__id__);p[groups[name]]._children=[];}
}
rootInfo.nestedPrefabInstanceRoots=rootInfo.nestedPrefabInstanceRoots.filter(r=>!removed.has(r.__id__));
map._children=['Grass','GroundDecor','Scenery','Decor','Fields','Livestock','Buildings'].map(name=>ref(groups[name]));
const placements=[];
function place(data,group='Decor'){
 const item=byId.get(data.asset);if(!item)throw Error('Unknown decor '+data.asset);
 const region=regionName(data),graph=region?regions.get(region):farmGraph;
 if(!graph)throw Error('Unknown region '+region);
 const a=graph.objects,name=data.id,n=node(name,region?graph.rootId:groups[group],data.x,data.y,data.scale??1,graph);
 transform(n,item.width,item.height,item.anchor,graph);
 const nested=a.length;
 a.push({__type__:'cc.Node',_name:item.id,_objFlags:0,_parent:ref(n),_children:[],_active:true,_components:[],_prefab:ref(nested+1),_lpos:{__type__:'cc.Vec3',x:0,y:0,z:0},_lrot:{__type__:'cc.Quat',x:0,y:0,z:0,w:1},_lscale:{__type__:'cc.Vec3',x:1,y:1,z:1},_layer:33554432,_euler:{__type__:'cc.Vec3',x:0,y:0,z:0},_id:''});
 a.push({__type__:'cc.PrefabInfo',root:ref(nested),asset:{__uuid__:item.uuid,__expectedType__:'cc.Prefab'},fileId:item.rootId,instance:ref(nested+2)});
 a.push({__type__:'cc.PrefabInstance',fileId:id(name+'/instance'),prefabRootNode:ref(graph.rootId),mountedChildren:[],mountedComponents:[],propertyOverrides:[],removedComponents:[]});
 a[n]._children.push(ref(nested));graph.rootInfo.nestedPrefabInstanceRoots.push(ref(nested));
 placements.push({...data,group});
}
const grass=p[groups.Grass],mapSize=map._components.map(get).find(o=>o.__type__==='cc.UITransform')._contentSize;
// Keep all four border corners and a strip of forest inside the authored map and the camera's reachable ground.
// The floor comes from layout.json, never from the size already in the prefab: reading back what this tool wrote
// makes the map grow a little on every run and never shrink again.
const clearing=config.forest.clearing,base=config.forest.map;
mapSize.width=Math.max(base.width,Math.ceil(2*Math.max(grass._lpos.x-clearing.left+400,clearing.right-grass._lpos.x+400)));
mapSize.height=Math.max(base.height,Math.ceil(2*Math.max(grass._lpos.y-clearing.bottom+400,clearing.top-grass._lpos.y+400)));
Object.assign(grass._components.map(get).find(o=>o.__type__==='cc.UITransform')._contentSize,{width:mapSize.width,height:mapSize.height});
const bounds={left:grass._lpos.x-mapSize.width/2,right:grass._lpos.x+mapSize.width/2,bottom:grass._lpos.y-mapSize.height/2,top:grass._lpos.y+mapSize.height/2};
const trees=forestPlacements(bounds,config.forest);
for(const t of trees)place({...t,asset:config.forest.species[t.species].id,zone:'forest'});
const rocks=rockPlacements(bounds,config.forest);
for(const rock of rocks)place({...rock,asset:config.forest.rocks.types[rock.kind].id});
// A sparse understory. Types and positions are tied to tree IDs, not how many groups happen to exist in the prefab.
for(let i=0;i<trees.length;i+=5){const t=trees[i],x=t.x+56,y=t.y-32;if(insideClearing(x,y,config.forest))continue;place({id:t.id+'-bush',asset:i%2?'DecorDarkBush':'DecorLightBush',x,y,scale:.65,zone:'forest-edge'});}
for(const q of config.props)place(q,byId.get(q.asset).category==='ground'?'GroundDecor':'Decor');
const roads=farmRoadLayout(FARM_LAYOUT);for(const tile of roads.tiles)place(tile,'GroundDecor');
const meadows=[[-235,530],[-604,361],[-700,-455],[-290,-695],[47,-825],[420,-870],[737,-669],[1190,-125],[1230,339],[1110,664],[325,420],[527,340]];
for(const [i,[x,y]]of meadows.entries()){
 place({id:'MeadowFlowers-'+i,asset:'DecorMeadowFlowers',x,y,scale:.9,zone:'meadow'},'GroundDecor');
 place({id:'GroundLeaves-'+i,asset:'DecorGroundLeaves',x:x+39,y:y-28,scale:.9,zone:'meadow'},'GroundDecor');
}
// Only explicitly retained ground patches are authored; deleted grass/meadow patches cannot respawn.
for(const patch of config.groundPatches??[])place(patch,'GroundDecor');
for(const name of ['GroundDecor','Decor'])p[groups[name]]._children.sort((a,b)=>get(b)._lpos.y-get(a)._lpos.y||get(a)._lpos.x-get(b)._lpos.x);
const regionRoots=[];
for(const [name,graph]of regions){
 const a=graph.objects;
 a[graph.rootId]._children.sort((x,y)=>a[y.__id__]._lpos.y-a[x.__id__]._lpos.y||a[x.__id__]._lpos.x-a[y.__id__]._lpos.x);
 regionRoots.push(ref(appendNested(p,{parentId:groups.Decor,ownerRootId:rootId,prefabUuid:graph.uuid,sourceRootFileId:graph.rootInfo.fileId,instanceKey:id(name+'/region-instance'),name})));
}

const library=map._components.map(get).find(c=>c.__type__===types.FarmItemLibrary);
library.scenery=config.forest.species.map(s=>({__uuid__:byId.get(s.id).uuid,__expectedType__:'cc.Prefab'}));
library.rocks=config.forest.rocks.types.map(s=>({__uuid__:byId.get(s.id).uuid,__expectedType__:'cc.Prefab'}));
library.forestConfig={__uuid__:stableId('farm-decor/forest'),__expectedType__:'cc.JsonAsset'};
const layout=map._components.map(get).find(c=>c.__type__===types.FarmMapLayout);
layout.decor=ref(groups.Decor);layout.groundDecor=ref(groups.GroundDecor);layout.decorRegions=regionRoots;
// Compact unreachable objects, including replaced nested instance records; references remain deterministic.
const reachable=new Set(),stack=[0];
const scan=o=>{if(!o||typeof o!=='object')return;if(Number.isInteger(o.__id__))stack.push(o.__id__);for(const [k,v]of Object.entries(o))if(k!=='__id__')scan(v);};
while(stack.length){const n=stack.pop();if(reachable.has(n))continue;reachable.add(n);scan(p[n]);}
const order=[...reachable].sort((a,b)=>a-b),remap=new Map(order.map((id,i)=>[id,i])),output=order.map(n=>p[n]);
const fix=o=>{if(!o||typeof o!=='object')return;if(Number.isInteger(o.__id__)){if(!remap.has(o.__id__))throw Error('Dangling prefab reference');o.__id__=remap.get(o.__id__);}for(const [k,v]of Object.entries(o))if(k!=='__id__')fix(v);};output.forEach(fix);
const fileIds=output.filter(o=>(o.__type__==='cc.PrefabInfo'&&o.asset?.__id__===0)||['cc.PrefabInstance','cc.CompPrefabInfo'].includes(o.__type__)).map(o=>o.fileId);
if(new Set(fileIds).size!==fileIds.length)throw Error('Duplicate generated fileIds');
const write=(file,data)=>{const next=JSON.stringify(data,null,2)+'\n';if(!fs.existsSync(file)||fs.readFileSync(file,'utf8')!==next){if(check)throw Error('Stale forest output: '+path.relative(root,file));fs.mkdirSync(path.dirname(file),{recursive:true});fs.writeFileSync(file,next);}};
assertGraph(output,{file});
write(file,output);
const regionDir=path.join(root,'assets/farm/prefabs/map');
write(regionDir+'.meta',{ver:'1.2.0',importer:'directory',imported:true,uuid:stableId('farm-region/directory'),files:[],subMetas:{},userData:{}});
for(const [name,graph]of regions){
 const regionFile=path.join(regionDir,name+'.prefab');assertGraph(graph.objects,{file:regionFile});write(regionFile,graph.objects);
 write(regionFile+'.meta',{ver:'1.1.50',importer:'prefab',imported:true,uuid:graph.uuid,files:['.json'],subMetas:{},userData:{syncNodeName:name}});
}

catalog.sceneryInstances=p[groups.Scenery]._children.length;catalog.forest={generatedBy:'tools/plant-forest.cjs',seed:config.forest.seed,rootSize:{width:mapSize.width,height:mapSize.height},clearing:config.forest.clearing,trees:trees.length,keptInside:catalog.sceneryInstances};
catalog.decorInstances=placements.filter(p=>p.group==='Decor').length;catalog.groundDecorInstances=placements.filter(p=>p.group==='GroundDecor').length;
write(path.join(root,'assets/farm/prefabs/items/catalog.json'),catalog);
const report={schemaVersion:1,forestTrees:trees.length,rocks:{border:rocks.filter(r=>r.zone==='rock-border').length,forest:rocks.filter(r=>r.zone==='forest-rocks').length},standing:catalog.decorInstances,ground:catalog.groundDecorInstances,legacyScenery:catalog.sceneryInstances,roads:{tiles:roads.tiles.length,links:roads.links},placements};
write(path.join(root,'source-assets/farm-beautify/placements.json'),report);
console.log(`Eight linked regions; forest ${trees.length}; standing decor ${report.standing}; ground ${report.ground}; roads ${roads.tiles.length} connect ${roads.links.length} destinations.`);
