"""Add Farm Town pigs, sheep, pens and loom without rebuilding the accepted crop bundle.

Requires Python 3.13, UnityPy 1.25.3 and Pillow. Run:
  python cocos/tools/import-town-husbandry.py --source artifacts/farm-town
Reads the audited Unity assets and already exported PNGs; never modifies source pixels.
The source hierarchy is projected into the same isometric basis as existing Cocos art.
This imports a static layered pose, not Unity Animator curves. Runtime motion is separate.
"""
import argparse
import copy
import hashlib
import importlib.util
import json
import math
from pathlib import Path

import UnityPy
from PIL import Image

TOOLS = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('town_prefab_writer', TOOLS / 'farm-town-prefab.py')
writer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(writer)
ROOT, OUT = writer.ROOT, writer.OUT
read, write, uid = writer.read, writer.write, writer.uid
TARGETS = [('pig', 'pig', 60), ('sheep', 'sheep', 56),
           ('yard-pigpen', 'pigpen', 190), ('yard-sheepfold', 'sheepfold', 190),
           ('industry-loom', 'loom', 205)]
ITEMS = ['feed_pig', 'beacon', 'burger', 'pie_potato', 'feed_goat', 'wool', 'woolly']


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def cross(a, b):
    return [a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0]]


def project(p):
    return [(p[0] - p[2]) * math.sqrt(.5),
            (p[0] + p[2]) * math.sqrt(.125) + p[1] * math.sqrt(.75)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--report', type=Path, default=ROOT.parent / 'artifacts/town-husbandry-assets/import-report.json')
    args = parser.parse_args()
    source = args.source.resolve()
    manifest = read(OUT / 'manifest.json')
    baseline = copy.deepcopy(manifest)
    target_keys = {key for key, _, _ in TARGETS}
    image_prefixes = tuple(key + '-' for key in target_keys)
    icon_keys = {'industry-item-' + key for key in ITEMS} | {'industry-factory-loom'}
    preserved = {}
    for group, suffix in [('images', '.png'), ('prefabs', '.prefab')]:
        for key, info in baseline[group].items():
            if key in target_keys or key in icon_keys or key.startswith(image_prefixes):
                continue
            for path in [OUT / (info['resource'] + suffix), Path(str(OUT / (info['resource'] + suffix)) + '.meta')]:
                preserved[path] = digest(path)
    records = {(r['file'], r['id']): r for r in read(source / 'export/manifest.json')['records']}
    audit = read(source / 'agriculture-audit.json')
    entities = {e['name']: e for e in audit['entities'] + audit['yards']}
    catalog = read(source / 'catalog.json')
    items = {i['name']: i for i in catalog['items']}
    env = UnityPy.load(str(source / 'apk/assets/bin/Data'))
    files = {o.assets_file.name: o.assets_file for o in env.objects}

    def deref(p, file):
        return UnityPy.classes.PPtr(**p, assetsfile=file).deref() if p['m_PathID'] else None

    def asset(key, record):
        exported = record['exports'][0]
        src, dest = source / exported, OUT / 'images' / (key + '.png')
        w, h = Image.open(src).size
        base = uid(dest.relative_to(ROOT).as_posix())
        sub = {}
        texture = dict(wrapModeS='clamp-to-edge', wrapModeT='clamp-to-edge', minfilter='linear', magfilter='linear',
                       mipfilter='none', anisotropy=0, isUuid=True, imageUuidOrDatabaseUri=base, visible=False)
        sprite = dict(trimType='none', trimThreshold=1, rotated=False, offsetX=0, offsetY=0, trimX=0, trimY=0,
                      width=w, height=h, rawWidth=w, rawHeight=h, borderTop=0, borderBottom=0, borderLeft=0, borderRight=0,
                      packable=True, pixelsToUnit=100, pivotX=.5, pivotY=.5, meshType=0, isUuid=True,
                      imageUuidOrDatabaseUri=base + '@6c48a', atlasUuid='')
        for sid, kind, version, data in [('6c48a', 'texture', '1.0.22', texture), ('f9941', 'sprite-frame', '1.0.12', sprite)]:
            sub[sid] = dict(importer=kind, uuid=base + '@' + sid, displayName=key, id=sid,
                            name='spriteFrame' if sid == 'f9941' else 'texture', userData=data, ver=version,
                            imported=True, files=['.json'], subMetas={})
        dest.write_bytes(src.read_bytes())
        write(Path(str(dest) + '.meta'), dict(ver='1.0.27', importer='image', imported=True, uuid=base,
              files=['.json', '.png'], subMetas=sub, userData=dict(type='sprite-frame',
              fixAlphaTransparencyArtifacts=False, hasAlpha=True, redirect=base + '@6c48a')))
        info = dict(resource='images/' + key, uuid=base, size=[w, h], sha256=digest(src), source=exported,
                    spriteSource=dict(file=record['file'], id=record['id'], name=record['name']))
        manifest['images'][key] = info
        return info

    def icon(key, icon_path):
        matched = [r for r in records.values() if r['type'] == 'Sprite' and icon_path in r.get('exports', [])]
        assert len(matched) == 1, (key, icon_path)
        return asset(key, matched[0])

    for name in ITEMS:
        icon('industry-item-' + name, items[name]['icon'])
    icon('industry-factory-loom', entities['loom']['icon'])

    results = []
    for key, source_name, target_width in TARGETS:
        entity = entities[source_name]
        pref = entity['prefab']
        root_go = files[pref['file']].objects[pref['id']]
        transforms, renders = {}, []

        def walk(go, parent=None, active=True, path=''):
            data = go.read_typetree()
            active = active and bool(data['m_IsActive'])
            path = path + '/' + data['m_Name']
            children, transform, renderers = [], None, []
            for comp in data['m_Component']:
                obj = deref(comp['component'], go.assets_file)
                if obj.type.name in ['Transform', 'RectTransform']:
                    transform = obj
                    td = obj.read_typetree()
                    children = [deref(p, obj.assets_file) for p in td['m_Children']]
                elif obj.type.name == 'SpriteRenderer':
                    renderers.append(obj)
            assert transform is not None, path
            tkey = (transform.assets_file.name, transform.path_id)
            transforms[tkey] = dict(data=transform.read_typetree(), parent=parent, path=path)
            for obj in renderers:
                rd = obj.read_typetree()
                if active and rd['m_Enabled'] and rd['m_Sprite']['m_PathID']:
                    renders.append((obj, rd, tkey, data['m_Name'], path))
            for child in children:
                walk(deref(child.read_typetree()['m_GameObject'], child.assets_file), tkey, active, path)

        walk(root_go)

        def world(tkey, p):
            while tkey is not None:
                tr = transforms[tkey]
                data = tr['data']
                scale, q = data['m_LocalScale'], data['m_LocalRotation']
                p = [p[i] * scale[k] for i, k in enumerate('xyz')]
                u = [q[k] for k in 'xyz']
                uv = cross(u, p)
                uuv = cross(u, uv)
                p = [p[i] + 2 * (q['w'] * uv[i] + uuv[i]) for i in range(3)]
                if tr['parent'] is not None:
                    p = [p[i] + data['m_LocalPosition'][k] for i, k in enumerate('xyz')]
                tkey = tr['parent']
            return p

        bounds = [math.inf, math.inf, -math.inf, -math.inf]
        layers = []
        for obj, renderer, tkey, name, source_path in renders:
            sp_obj = deref(renderer['m_Sprite'], obj.assets_file)
            sp = sp_obj.read_typetree()
            rec = records[(sp_obj.assets_file.name, sp_obj.path_id)]
            info = asset(key + '-' + str(obj.path_id), rec)
            tx, ty = project(world(tkey, [0, 0, 0]))
            ax, ay = project(world(tkey, [-1 if renderer['m_FlipX'] else 1, 0, 0]))
            bx, by = project(world(tkey, [0, -1 if renderer['m_FlipY'] else 1, 0]))
            a, b, c, d = ax - tx, ay - ty, bx - tx, by - ty
            rect, trim, pivot, ppu = sp['m_Rect'], sp['m_RD']['textureRectOffset'], sp['m_Pivot'], sp['m_PixelsToUnits']
            w, h = [value / ppu for value in info['size']]
            x = (trim['x'] - pivot['x'] * rect['width']) / ppu
            y = (trim['y'] - pivot['y'] * rect['height']) / ppu
            for xx, yy in [(x, y), (x + w, y), (x, y + h), (x + w, y + h)]:
                px, py = a * xx + c * yy + tx, b * xx + d * yy + ty
                bounds = [min(bounds[0], px), min(bounds[1], py), max(bounds[2], px), max(bounds[3], py)]
            wp = world(tkey, [0, 0, 0])
            layers.append(dict(id=obj.path_id, name=name, node=name + '-' + str(obj.path_id), sourcePath=source_path,
                matrix=[a, b, c, d, tx, ty], center=[x + w / 2, y + h / 2], size=[w, h], image=info['resource'],
                color=renderer['m_Color'], order=renderer['m_SortingOrder'],
                depth=(wp[0] + wp[2]) * math.sqrt(.375) - wp[1] * .5))
        assert layers, key
        scale = target_width / (bounds[2] - bounds[0])
        prefab = writer.Prefab(key)
        model = prefab.node('Model', prefab.root, (-(bounds[0] + bounds[2]) / 2 * scale, -bounds[1] * scale - 30), (scale, scale))
        layers.sort(key=lambda layer: (layer['order'], -layer['depth']))
        for layer in layers:
            a, b, c, d, tx, ty = layer['matrix']
            theta = .5 * math.atan2(2 * (a * c + b * d), a * a + b * b - c * c - d * d)
            ct, st = math.cos(theta), math.sin(theta)
            ux, uy = a * ct + c * st, b * ct + d * st
            sx = math.hypot(ux, uy)
            assert sx > 1e-8, (key, layer['name'])
            sy = (a * d - b * c) / sx
            outer = prefab.node(layer['node'], model, (tx, ty), (sx, sy), math.atan2(uy, ux))
            inner = prefab.node('Basis', outer, angle=-theta)
            info = manifest['images'][layer['image'].removeprefix('images/')]
            prefab.sprite(inner, 'Visual', info, layer['center'], layer['size'], layer['color'])
        manifest['prefabs'][key] = prefab.save()
        provenance = dict(kind='projected-hierarchy', source=pref, entity=entity['source'],
            sourceApkSHA256=audit['sourceApkSHA256'], bounds=bounds, scale=scale, layers=layers,
            animation='Static source hierarchy projected without source pixel changes. Cocos runtime supplies state motion; no Unity Animator replay.')
        manifest['provenance'][key] = provenance
        results.append(dict(key=key, source=pref, width=target_width, layers=len(layers), bounds=bounds, scale=scale))
        print(key, len(layers), 'layers', flush=True)
    for path, original in preserved.items():
        assert digest(path) == original, 'Existing asset changed: ' + str(path)
    for group in ['images', 'prefabs', 'provenance']:
        for key, info in baseline[group].items():
            if key not in target_keys and key not in icon_keys and not key.startswith(image_prefixes):
                assert manifest[group][key] == info, 'Existing manifest record changed: ' + key
    write(OUT / 'manifest.json', manifest)
    report = dict(source=str(source), sourceApkSHA256=audit['sourceApkSHA256'], prefabs=results,
        preservedFiles=len(preserved), counts=dict(images=len(manifest['images']), prefabs=len(manifest['prefabs'])),
        icons={key: manifest['images'][key] for key in sorted(icon_keys)})
    write(args.report, report)
    print(json.dumps(dict(report=str(args.report), **report['counts'], preservedFiles=len(preserved))))


if __name__ == '__main__':
    main()
