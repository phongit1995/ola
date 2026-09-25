#!/usr/bin/env python3
"""Measure full machine art; derive placement outlines from its ground, excluding building height."""
from pathlib import Path
from PIL import Image
import hashlib
import importlib.util
import json
import math

ROOT = Path(__file__).resolve().parents[1]
ART = ROOT / 'assets/farm/bundles/farm-town'
spec = importlib.util.spec_from_file_location('pen_geometry', Path(__file__).with_name('pen-ground-footprints.py'))
geometry = importlib.util.module_from_spec(spec)
spec.loader.exec_module(geometry)
TARGET_WIDTH = geometry.FIELD_WIDTH * geometry.TARGET_FIELD_WIDTHS
ALPHA = geometry.ALPHA
OVERRIDES = ROOT / 'source-assets/farm-beautify/machine-ground-overrides.json'


def bounds(points):
    return {'left': min(p[0] for p in points), 'right': max(p[0] for p in points),
            'bottom': min(p[1] for p in points), 'top': max(p[1] for p in points)}


def below(polygon, limit):
    """Reconstruct the former reservation only to keep quantization inside its edges."""
    result = []
    for i, p in enumerate(polygon):
        q = polygon[(i + 1) % len(polygon)]
        if p[1] <= limit:
            result.append(p)
        if (p[1] <= limit) != (q[1] <= limit):
            t = (limit - p[1]) / (q[1] - p[1])
            result.append((p[0] + (q[0] - p[0]) * t, limit))
    return result


def quantize_ground(polygon, reservation, scale):
    """Round inward at former edges so even boundary-touching saved layouts stay valid."""
    # Integer thousandths make containment exact, including diagonal edges.
    def lattice(p):
        return tuple(round(round(v * scale, 3) * 1000) for v in p)
    boundary = [lattice(p) for p in reservation]
    def inside(p):
        return all((b[0]-a[0])*(p[1]-a[1])-(b[1]-a[1])*(p[0]-a[0]) >= 0
                   for a, b in zip(boundary, boundary[1:] + boundary[:1]))
    center = tuple(sum(p[i] for p in polygon) / len(polygon) for i in (0, 1))
    result = []
    for point in polygon:
        candidate = lattice(point)
        dx, dy = center[0]-point[0], center[1]-point[1]
        length = math.hypot(dx, dy)
        for step in range(1, 101):
            if inside(candidate):
                break
            # Move at most 0.1 world unit; ordinary rounding needs only 1–3 steps.
            amount = step * .001 / (scale * length)
            candidate = lattice((point[0] + dx * amount, point[1] + dy * amount))
        if not inside(candidate):
            raise ValueError('Ground polygon extends beyond the former reservation')
        result.append(candidate)
    return [{'x': x / 1000, 'y': y / 1000} for x, y in geometry.convex_hull(result)]


def derive(key, images, provenance, override=None):
    prefab = ART / 'prefabs' / (key + '.prefab')
    nodes = json.loads(prefab.read_text())
    sources = {str(prefab.relative_to(ROOT)): hashlib.sha256(prefab.read_bytes()).hexdigest()}
    quads, opaque, floor, authored = [], [], [], []
    floor_layers = []

    def visit(node, parent, layer=''):
        if not node['_active']:
            return
        pos, size, q = node['_lpos'], node['_lscale'], node['_lrot']
        z, w = q['z'], q['w']
        matrix = geometry.multiply(parent, [(1-2*z*z)*size['x'], 2*w*z*size['x'], -2*w*z*size['y'],
                                            (1-2*z*z)*size['y'], pos['x'], pos['y']])
        if node['_name'] not in ('Model', 'Basis', 'Visual', key):
            layer = node['_name']
        components = [nodes[r['__id__']] for r in node['_components']]
        sprite = next((c for c in components if c['__type__'] == 'cc.Sprite'), None)
        ui = next((c for c in components if c['__type__'] == 'cc.UITransform'), None)
        if sprite:
            if not ui:
                raise ValueError('Sprite has no UITransform: ' + key + '/' + layer)
            def transform(xx, yy):
                vx = (xx-ui['_anchorPoint']['x'])*ui['_contentSize']['width']
                vy = (1-yy-ui['_anchorPoint']['y'])*ui['_contentSize']['height']
                return (matrix[0]*vx+matrix[2]*vy+matrix[4], matrix[1]*vx+matrix[3]*vy+matrix[5])
            quads.extend(transform(x, y) for x, y in [(0,0), (1,0), (0,1), (1,1)])
            file = images[sprite['_spriteFrame']['__uuid__'].split('@')[0]]
            sources[str(file.relative_to(ROOT))] = hashlib.sha256(file.read_bytes()).hexdigest()
            image = Image.open(file).convert('RGBA')
            width, height = image.size
            if override and layer == override['layer']:
                if authored or list(image.size) != override['imageSize']:
                    raise ValueError('Ground reference layer changed: ' + key + '/' + layer)
                authored.extend(transform(p['x']/width, p['y']/height) for p in override['polygon'])
                sources[str(OVERRIDES.relative_to(ROOT))] = hashlib.sha256(OVERRIDES.read_bytes().replace(b'\r\n', b'\n')).hexdigest()
            pixels = image.getchannel('A').load()
            points = []
            for y in range(height):
                for x in range(width):
                    if pixels[x, y] < ALPHA:
                        continue
                    edge = x in (0, width-1) or y in (0, height-1)
                    if not edge and all(pixels[x+dx, y+dy] >= ALPHA for dx, dy in [(1,0), (-1,0), (0,1), (0,-1)]):
                        continue
                    points.extend(transform(xx/width, yy/height) for xx, yy in [(x,y), (x+1,y), (x,y+1), (x+1,y+1)])
            opaque.extend(points)
            if layer.startswith(('podlozka', 'podlpzka')):
                floor_layers.append(layer)
                floor.extend(points)
        for child in node['_children']:
            visit(nodes[child['__id__']], matrix, layer)

    root = next(n for n in nodes if n.get('__type__') == 'cc.Node' and n['_name'] == key)
    visit(root, [1, 0, 0, 1, 0, 0])
    source_bounds = bounds(quads)
    source_width = source_bounds['right'] - source_bounds['left']
    width_source = 'prefab-transforms'
    if provenance.get('bounds') and provenance.get('scale'):
        declared = (provenance['bounds'][2] - provenance['bounds'][0]) * provenance['scale']
        if abs(declared - source_width) > .001:
            raise ValueError('Manifest width does not match prefab: ' + key)
        source_width = declared
        width_source = 'manifest-verified-against-prefab'
    if source_width <= 0 or not opaque:
        raise ValueError('Missing machine art: ' + key)
    scale = TARGET_WIDTH / source_width
    if override:
        if len(authored) < 3:
            raise ValueError('Missing authored machine ground: ' + key)
        hull = geometry.convex_hull(authored)
        method = override['method']
    elif floor:
        hull = geometry.convex_hull(floor)
        method = 'Convex hull of opaque floor pixels after prefab transforms; roofs, machinery and wall height are excluded.'
    else:
        raise ValueError('Machine has no floor sprite; author its ground plane in machine-ground-overrides.json: ' + key)
    reservation = geometry.convex_hull(opaque)
    if floor:
        reservation = below(reservation, max(p[1] for p in floor))
    return {'prefab': key, 'sourceWidth': source_width, 'widthSource': width_source, 'sourceBounds': source_bounds,
            'targetWidth': TARGET_WIDTH, 'scale': scale, 'bounds': {k: v * scale for k, v in source_bounds.items()},
            'sources': sources, 'floorLayers': floor_layers, 'groundMethod': method,
            'polygon': quantize_ground(hull, reservation, scale)}


def main():
    images = {json.loads(p.read_text())['uuid']: p.with_suffix('') for p in (ART / 'images').glob('*.png.meta')}
    catalog = json.loads((ART / 'catalog.json').read_text())
    manifest = json.loads((ART / 'manifest.json').read_text())
    overrides = json.loads(OVERRIDES.read_text())['machines']
    result = {'version': 1, 'targetWidth': TARGET_WIDTH, 'fieldWidth': geometry.FIELD_WIDTH,
              'targetFieldWidths': geometry.TARGET_FIELD_WIDTHS, 'alphaThreshold': ALPHA,
              'machines': {t['prefab']: derive(t['prefab'], images, manifest['provenance'].get(t['prefab'], {}), overrides.get(t['prefab'])) for t in catalog['machineTypes']}}
    output = ROOT / 'source-assets/farm-beautify/machine-footprints.json'
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    for key, data in result['machines'].items():
        print(key, 'native width', data['sourceWidth'], 'scale', data['scale'], 'ground', bounds([(p['x'], p['y']) for p in data['polygon']]))


if __name__ == '__main__':
    main()
