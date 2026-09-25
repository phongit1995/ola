#!/usr/bin/env python3
"""Derive map reservations from imported yard floor/fence pixels, without changing their art."""
from pathlib import Path
from PIL import Image
import hashlib
import json

ROOT = Path(__file__).resolve().parents[1]
ART = ROOT / 'assets/farm/bundles/farm-town'
FIELD_WIDTH = 196
TARGET_FIELD_WIDTHS = 4
SOURCE_YARD_WIDTH = 190
SCALE = FIELD_WIDTH * TARGET_FIELD_WIDTHS / SOURCE_YARD_WIDTH
ALPHA = 16
YARDS = {'pen:12': 'yard-coop', 'pen:13': 'yard-cowshed', 'pen:14': 'yard-pigpen', 'pen:15': 'yard-sheepfold'}


def multiply(a, b):
    return [a[0]*b[0]+a[2]*b[1], a[1]*b[0]+a[3]*b[1], a[0]*b[2]+a[2]*b[3], a[1]*b[2]+a[3]*b[3],
            a[0]*b[4]+a[2]*b[5]+a[4], a[1]*b[4]+a[3]*b[5]+a[5]]


def convex_hull(points):
    points = sorted(set(points))
    def cross(o, a, b):
        return (a[0]-o[0])*(b[1]-o[1])-(a[1]-o[1])*(b[0]-o[0])
    def half(points):
        result = []
        for p in points:
            while len(result) > 1 and cross(result[-2], result[-1], p) <= 0:
                result.pop()
            result.append(p)
        return result[:-1]
    return half(points) + half(reversed(points))


def derive(key, images):
    prefab = ART / 'prefabs' / (key + '.prefab')
    nodes = json.loads(prefab.read_text())
    sources = {str(prefab.relative_to(ROOT)): hashlib.sha256(prefab.read_bytes()).hexdigest()}
    points = []

    def visit(node, parent, part=''):
        pos, size, q = node['_lpos'], node['_lscale'], node['_lrot']
        z, w = q['z'], q['w']
        matrix = multiply(parent, [(1-2*z*z)*size['x'], 2*w*z*size['x'], -2*w*z*size['y'],
                                   (1-2*z*z)*size['y'], pos['x'], pos['y']])
        if node['_name'].startswith(('podlozka', 'zabor')):
            part = node['_name']
        components = [nodes[r['__id__']] for r in node['_components']]
        sprite = next((c for c in components if c['__type__'] == 'cc.Sprite'), None)
        ui = next((c for c in components if c['__type__'] == 'cc.UITransform'), None)
        if sprite and part:
            file = images[sprite['_spriteFrame']['__uuid__'].split('@')[0]]
            sources[str(file.relative_to(ROOT))] = hashlib.sha256(file.read_bytes()).hexdigest()
            image = Image.open(file).convert('RGBA')
            width, height = image.size
            pixels = image.getchannel('A').load()
            for y in range(height):
                for x in range(width):
                    if pixels[x, y] < ALPHA:
                        continue
                    edge = x in (0, width-1) or y in (0, height-1)
                    if not edge and all(pixels[x+dx, y+dy] >= ALPHA for dx, dy in [(1,0), (-1,0), (0,1), (0,-1)]):
                        continue
                    for xx, yy in [(x,y), (x+1,y), (x,y+1), (x+1,y+1)]:
                        vx = (xx/width-ui['_anchorPoint']['x'])*ui['_contentSize']['width']
                        vy = (1-yy/height-ui['_anchorPoint']['y'])*ui['_contentSize']['height']
                        points.append((round(matrix[0]*vx+matrix[2]*vy+matrix[4], 3),
                                       round(matrix[1]*vx+matrix[3]*vy+matrix[5], 3)))
        for child in node['_children']:
            visit(nodes[child['__id__']], matrix, part)

    root = next(n for n in nodes if n.get('__type__') == 'cc.Node' and n['_name'] == key)
    visit(root, [SCALE, 0, 0, SCALE, 0, 0])
    return {'prefab': key, 'sources': sources, 'polygon': [{'x': x, 'y': y} for x, y in convex_hull(points)]}


def main():
    images = {json.loads(p.read_text())['uuid']: p.with_suffix('') for p in (ART / 'images').glob('*.png.meta')}
    result = {'version': 1, 'fieldWidth': FIELD_WIDTH, 'targetFieldWidths': TARGET_FIELD_WIDTHS,
              'sourceYardWidth': SOURCE_YARD_WIDTH, 'displayScale': SCALE, 'alphaThreshold': ALPHA,
              'method': 'Convex hull of opaque floor and fence pixels after prefab transforms. Roofs, shelters and animals are excluded; the reservation includes visible fence height to keep adjoining yards apart.',
              'pens': {id: derive(key, images) for id, key in YARDS.items()}}
    output = ROOT / 'source-assets/farm-beautify/pen-footprints.json'
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print('Derived four floor/fence reservations at display scale', SCALE)


if __name__ == '__main__':
    main()
