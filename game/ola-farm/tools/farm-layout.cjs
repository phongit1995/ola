'use strict';
// Authored positions are read from linked map anchors. Buildings and fixed scenery stay independent.
const fs = require('node:fs'), path = require('node:path');
const { mapComponentTypes, stableId } = require('./cocos-ids.cjs');
const root = path.resolve(__dirname, '..'), check = process.argv.includes('--check');
const read = p => JSON.parse(fs.readFileSync(path.join(root, p), 'utf8'));
const prefab = read('assets/farm/prefabs/map/scenes.prefab'), types = mapComponentTypes();
// New sites are real Editor anchors. Existing authored positions win on subsequent generations.
const secondSites = read('source-assets/farm-beautify/second-buildings.json').sites;
for (const site of secondSites) {
  if (prefab.some(n => n.__type__ === 'cc.Node' && n._name === site.node)) continue;
  const sourceName = site.source.startsWith('pen:') ? 'Cell' + site.source.slice(4) : site.source;
  const source = prefab.findIndex(n => n.__type__ === 'cc.Node' && n._name === sourceName), start = prefab.length;
  if (source < 0) throw Error('Missing source anchor: ' + sourceName);
  const remap = value => {
    if (Array.isArray(value)) return value.map(remap);
    if (!value || typeof value !== 'object') return value;
    if ('__id__' in value) return { __id__: value.__id__ >= source && value.__id__ < source + 4 ? start + value.__id__ - source : value.__id__ };
    return Object.fromEntries(Object.entries(value).map(([key, v]) => [key, key === 'fileId' ? stableId('second-building/' + site.id + '/' + v) : remap(v)]));
  };
  const blocks = remap(prefab.slice(source, source + 4));
  blocks[0]._name = site.node; Object.assign(blocks[0]._lpos, site.position);
  prefab[blocks[0]._parent.__id__]._children.push({ __id__: start }); prefab.push(...blocks);
}
const layout = prefab.find(p => p.__type__ === types.FarmMapLayout);
const nodes = prefab.filter(p => p.__type__ === 'cc.Node');
const node = name => { const matches = nodes.filter(n => n._name === name); if (matches.length !== 1) throw Error('Missing/duplicate anchor: ' + name); return matches[0]; };
const position = n => ({ x: n._lpos.x, y: n._lpos.y });
const diamond = (x,y,w,h) => [{x,y:y+h/2},{x:x+w/2,y},{x,y:y-h/2},{x:x-w/2,y}];
const penFootprints = read('source-assets/farm-beautify/pen-footprints.json');
const machineFootprints = read('source-assets/farm-beautify/machine-footprints.json');
const machinePresentation = {};
const buildings = [];
for (const [id, name, kind, anchor, w, h, cy, ex, ey] of [
  ['farm-house','Nhà','facility','MainObject-nha',260,110,-103,-95,-145],
  ['barn','Kho','facility','MainObject-kho',185,85,-40,0,-108],
  ['pen:12','Chuồng gà','pen','Cell12',160,90,-5,45,65],
  ['pen:13','Chuồng bò','pen','Cell13',170,95,-5,-50,65],
  ['pen:14','Chuồng heo','pen','Cell14',170,95,-5,-50,65],
  ['pen:15','Chuồng cừu','pen','Cell15',170,95,-5,-50,65],
]) buildings.push({id,name,kind,node:anchor,position:position(node(anchor)),footprints:[diamond(0,cy,w,h)],entrance:{x:ex,y:ey},depthOffset:kind==='facility'?cy:0});
// Source-derived floor/fence silhouettes reserve the full enlarged yard, independently of save migration.
for (const building of buildings.filter(b => b.kind === 'pen')) {
  const pen = penFootprints.pens[building.id]; if (!pen?.polygon?.length) throw Error('Missing yard footprint: ' + building.id);
  building.footprints = [pen.polygon];
}
for (const site of secondSites.filter(site => site.id.startsWith('pen:'))) {
  const source = buildings.find(b => b.id === site.source);
  buildings.push({ ...source, id: site.id, name: source.name + ' 2', node: site.node, position: position(node(site.node)) });
}
layout.additionalPens = secondSites.filter(site => site.id.startsWith('pen:')).map(site => ({ __id__: prefab.indexOf(node(site.node)) }));
buildings.find(b=>b.id==='farm-house').footprints.push(diamond(-140,-75,60,50));
const catalog = require('./load-farm-catalog.cjs').loadFarmCatalog();
for (const ref of prefab[layout.buildings.__id__]._children) {
  const n = prefab[ref.__id__], id=n._name, type=catalog.machineTypes.find(t=>t.buildSites?.some(site=>site.buildingId===id) || t.buildingIds?.includes(id));
  if (!type) throw Error('Unknown machine anchor: '+id);
  const geometry = machineFootprints.machines[type.prefab];
  if (!geometry?.polygon?.length || !geometry.bounds || !['left','right','bottom','top'].every(k=>Number.isFinite(geometry.bounds[k])) || !(geometry.sourceWidth>0) || !(geometry.scale>0) || geometry.targetWidth!==penFootprints.fieldWidth*penFootprints.targetFieldWidths || Math.abs(geometry.scale*geometry.sourceWidth-geometry.targetWidth)>1e-6) throw Error('Missing/invalid machine geometry: '+type.prefab);
  const {scale,sourceWidth,targetWidth,bounds}=geometry;
  machinePresentation[type.prefab]={scale,sourceWidth,targetWidth,bounds};
  buildings.push({id,name:type.name,kind:'machine',node:id,position:position(n),footprints:[geometry.polygon],entrance:{x:0,y:Math.min(...geometry.polygon.map(p=>p.y))-30},depthOffset:0});
}
if (buildings.length !== 26) throw Error('Expected 26 buildings, including house and barn');
const obstacles = layout.fields.map(ref => { const n=prefab[ref.__id__], ui=n._components.map(r=>prefab[r.__id__]).find(c=>c.__type__==='cc.UITransform'); return {id:n._name,polygon:diamond(n._lpos.x,n._lpos.y,ui._contentSize.width*n._lscale.x,ui._contentSize.height*n._lscale.y)}; });
for (const [name,w,h,cy] of [['MainObject-ao ca',500,290,0],['MainObject-gieng',210,95,-75],['MainObject-xay gio',205,90,-115],['MainObject-chuong cho',135,70,-55]]) {
  const p=position(node(name)); obstacles.push({id:name,polygon:diamond(p.x,p.y+cy,w,h)});
}
const decor=[];
for (const prop of read('source-assets/farm-beautify/layout.json').props) {
  const n=node(prop.id), p=position(n);
  // Ground contact excludes the height of flowers, hay and fences above the grass.
  const w=prop.id.includes('fence')?85:prop.id==='barn-cart'?110:40, h=prop.id.includes('fence')?38:prop.id==='barn-cart'?45:18;
  decor.push({id:prop.id,polygon:diamond(p.x,p.y,w,h)});
}
const forest=read('source-assets/farm-beautify/layout.json').forest;
const roadPlan=read('source-assets/farm-beautify/roads.json');
const manifest={version:1,snap:{x:36,y:18},bounds:forest.clearing,buildings,obstacles,decor,fieldEntrance:{x:-200,y:20},roadPlan};
function write(rel,text){const file=path.join(root,rel);if(check){if(!fs.existsSync(file)||fs.readFileSync(file,'utf8').replace(/\r\n/g,'\n')!==text.replace(/\r\n/g,'\n'))throw Error('Stale layout output: '+rel);}else {fs.mkdirSync(path.dirname(file),{recursive:true});fs.writeFileSync(file,text);}}
write('assets/farm/data/farm-layout/layout.json',JSON.stringify(manifest,null,2)+'\n');
write('assets/farm/data/farm-layout/layout.json.meta',JSON.stringify({ver:'2.0.1',importer:'json',imported:true,uuid:stableId('farm-layout/layout-v1'),files:['.json'],subMetas:{},userData:{}},null,2)+'\n');
// Collision/save geometry is available synchronously, without importing map presentation.
write('assets/farm/scripts/core/generated/FarmLayoutManifest.ts',
  "// Generated by tools/farm-layout.cjs. Edit source geometry, map anchors or roads.json, then regenerate.\n" +
  "import type { FarmLayoutManifest } from '../types/BuildingTypes';\n" +
  'export const FARM_LAYOUT: FarmLayoutManifest = ' + JSON.stringify(manifest,null,2) + ';\n');
// Visual scale and bounds belong to the map layer; bounds already include the display scale.
write('assets/farm/scripts/map/generated/BuildingPresentationData.ts',
  "// Generated by tools/farm-layout.cjs from pen-footprints.json and machine-footprints.json.\n" +
  "import type { MapBounds } from '../../render/types/MapTypes';\n" +
  'export const HERD_DISPLAY_SCALE = ' + penFootprints.displayScale + ';\n' +
  'export const MACHINE_PRESENTATION: Readonly<Record<string, { scale: number; sourceWidth: number; targetWidth: number; bounds: MapBounds }>> = ' +
  JSON.stringify(machinePresentation,null,2) + ';\n');
const library=prefab.find(p=>p.__type__===types.FarmItemLibrary);
library.roads=Array.from({length:16},(_,i)=>({__uuid__:read('assets/farm/prefabs/items/scenery/DecorRoad'+String(i).padStart(2,'0')+'.prefab.meta').uuid,__expectedType__:'cc.Prefab'}));
write('assets/farm/prefabs/map/scenes.prefab',JSON.stringify(prefab,null,2)+'\n');
console.log('Farm layout: 26 movable buildings/sites, 40 fixed fields, '+decor.length+' independent props.');
