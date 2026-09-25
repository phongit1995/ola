"""Deterministic Cocos prefab writer used by the Farm Town husbandry importer.

Keep the namespace stable: generated node and asset UUIDs are serialized references.
This module only supplies serialization helpers; it does not replace the game catalog.
"""
import hashlib
import json
import math
from pathlib import Path
import uuid

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'assets/farm/bundles/farm-town'
NS = uuid.UUID('62994cbe-391d-45f9-aa63-71664f3ca6ef')
def uid(key): return str(uuid.uuid5(NS, key))
def read(p): return json.loads(p.read_text(encoding='utf-8'))
def write(p, data):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
def meta(p, kind, version, data=None):
    p=p.resolve()
    write(Path(str(p)+'.meta'), dict(ver=version, importer=kind, imported=True,
        uuid=uid(p.relative_to(ROOT).as_posix()), files=['.json'] if kind in ['json','prefab'] else [], subMetas={}, userData=data or {}))

class Prefab:
    def __init__(self, key):
        self.key=key
        self.data=[dict(__type__='cc.Prefab',_name=key,_objFlags=0,_native='',data={'__id__':1},optimizationPolicy=0,persistent=False)]
        self.root=self.node(key)
    def add(self, data):
        ref={'__id__':len(self.data)};self.data.append(data);return ref
    def node(self, name, parent=None, pos=(0,0), scale=(1,1), angle=0):
        n=dict(__type__='cc.Node',_name=name,_objFlags=0,_parent=parent,_children=[],_active=True,_components=[],_prefab=None,
            _lpos=dict(__type__='cc.Vec3',x=pos[0],y=pos[1],z=0),_lscale=dict(__type__='cc.Vec3',x=scale[0],y=scale[1],z=1),
            _lrot=dict(__type__='cc.Quat',x=0,y=0,z=math.sin(angle/2),w=math.cos(angle/2)),
            _euler=dict(__type__='cc.Vec3',x=0,y=0,z=angle*180/math.pi),_layer=33554432,_id='')
        r=self.add(n)
        n['_prefab']=self.add(dict(__type__='cc.PrefabInfo',root={'__id__':1},asset={'__id__':0},fileId=uid(self.key+str(r))))
        if parent:self.data[parent['__id__']]['_children'].append(r)
        return r
    def component(self, node, data):
        data.update(_name='',_objFlags=0,node=node,_enabled=True,_id='')
        data['__prefab']=self.add(dict(__type__='cc.CompPrefabInfo',fileId=uid(self.key+str(len(self.data)))))
        self.data[node['__id__']]['_components'].append(self.add(data))
    def size(self, node, w, h):
        self.component(node, dict(__type__='cc.UITransform',_contentSize=dict(__type__='cc.Size',width=w,height=h),_anchorPoint=dict(__type__='cc.Vec2',x=.5,y=.5)))
    def sprite(self, parent, name, info, pos, size, color=None):
        n=self.node(name,parent,pos);self.size(n,*size)
        rgba={k:round(255*(color or {}).get(k,1)) for k in 'rgba'}
        self.component(n,dict(__type__='cc.Sprite',_srcBlendFactor=2,_dstBlendFactor=4,_color=dict(__type__='cc.Color',**rgba),
            _customMaterial=None,_spriteFrame={'__uuid__':info['uuid']+'@f9941','__expectedType__':'cc.SpriteFrame'},_type=0,_fillType=0,_sizeMode=0,
            _fillCenter=dict(__type__='cc.Vec2',x=0,y=0),_fillStart=0,_fillRange=0,_isTrimmedMode=True,_useGrayscale=False,_atlas=None))
        return n
    def save(self):
        self.size(self.root,200,160)
        p=OUT/'prefabs'/(self.key+'.prefab');write(p,self.data);meta(p,'prefab','1.1.50',dict(syncNodeName=self.key))
        return dict(resource='prefabs/'+self.key,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
