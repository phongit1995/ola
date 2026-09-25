"""Copy audited Farm Town UI sprites without altering pixels.

python3 cocos/tools/import-town-ui.py --source artifacts/farm-town
Borders are translated from Unity's untrimmed rectangle to exported PNG space.
The runtime bundle is self-contained; the APK/export is only needed to regenerate.
"""
import argparse
import hashlib
import json
from pathlib import Path
import uuid

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'assets/farm/bundles/farm-town-ui'
NS = uuid.UUID('9ba5c0d7-691c-4abc-b62d-1ab05aa0c041')
SPRITES = dict(window=589, heading=293, blue=227, green=141, close=290,
    talk=561, bubble=624, count=631, brown=319, tab=303, light=501,
    inset=156, paper=633, progress=370, progressFill=812, timer=197,
    lock=165, plus=802, minus=258, coin=144, next=611, production=664,
    productionLine=829, arrow=686)

def write(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')

def meta(path, importer, version, user=None):
    write(Path(str(path)+'.meta'), dict(ver=version, importer=importer, imported=True,
        uuid=str(uuid.uuid5(NS, path.relative_to(ROOT).as_posix())),
        files=['.json'] if importer=='json' else [], subMetas={}, userData=user or {}))

def main():
    parser=argparse.ArgumentParser(); parser.add_argument('--source', type=Path, required=True)
    source=parser.parse_args().source
    records=json.loads((source/'export/manifest.json').read_text())['records']
    images={}
    for key, ident in SPRITES.items():
        r=next(r for r in records if r['file']=='sharedassets0.assets' and r['type']=='Sprite' and r['id']==ident)
        data=(source/r['exports'][0]).read_bytes(); dest=OUT/'images'/(key+'.png')
        dest.parent.mkdir(parents=True,exist_ok=True); dest.write_bytes(data)
        w,h=r['width'],r['height']; b=r['border']; off=r['textureRectOffset']; rect=r['rect']
        borders=[max(0,b['x']-off['x']),max(0,b['y']-off['y']),
                 max(0,b['z']-(rect['width']-off['x']-w)),max(0,b['w']-(rect['height']-off['y']-h))]
        images[key]=dict(resource='images/'+key, size=[w,h], border=borders,
            sha256=hashlib.sha256(data).hexdigest(), source=r['exports'][0],
            sourceName=r['name'], sourceId=ident, sourceBorder=b, sourceRect=rect, sourceOffset=off)
    # Cocos creates texture subassets for the copied images on import.
    meta(OUT,'directory','1.2.0',dict(isBundle=True,bundleName='farm-town-ui',priority=2,isRemoteBundle=False))
    meta(OUT/'images','directory','1.2.0')
    write(OUT/'manifest.json',dict(source='Farm Town / sharedassets0.assets',
        apkSha256='4233a96b74efe5ec1b73b91e5846f5c0309b7b96c402851abf23ddad438ece5b',images=images))
    meta(OUT/'manifest.json','json','2.0.0')
    print(f'Copied {len(images)} Farm Town UI sprites to {OUT}')

if __name__=='__main__': main()
