"""Import exact Golden Island building, crafting, inventory and shop UI sprites.

Run with a Python environment containing UnityPy and Pillow:
  python cocos/tools/import-island-ui.py --source reference/golden-island
Runtime and check-island-ui.cjs need only the resulting committed Cocos bundle.
"""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import uuid

REPO = Path(__file__).resolve().parents[2]
PROJECT = REPO / 'cocos'
OUT = PROJECT / 'assets/farm/bundles/golden-island-ui'
NS = uuid.UUID('e6e0d75a-b54a-493d-8765-a93a5fa084ba')
# Resolve through the prefab's Image component: sprite names alone are ambiguous.
SPRITES = {
    'window': 'InventoryUI/Popup',
    'buildingWindow': 'UpgradeHouseUI/Popup/PanelRequirement',
    'close': 'UpgradeHouseUI/Popup/PanelRequirement/ButtonClose',
    'card': 'UpgradeHouseUI/Popup/PanelRequirement/UpgradeElements/UpgradeHouseElement',
    'inset': 'PopupMissingMultiple/Popup/BG',
    'panelInfo': 'UpgradeHouseUI/Popup/PanelInfo',
    'green': 'UpgradeHouseUI/Popup/PanelRequirement/ButtonUpgradeAll',
    'slot': 'Crafting/Popup/SlotCrafting/Slot1',
    'recipe': 'Crafting/Popup/ListTool/ToolUI',
    'selected': 'Crafting/Popup/ListTool/ToolUI/Select',
    'material': 'Crafting/Popup/ToolDetails/Material1',
    'info': 'Crafting/Popup/ToolDetails',
    'tab': 'InventoryUI/Popup/TabResource/OpenResource',
    'tabInactive': 'InventoryUI/Popup/ButtonOpenResourceTab',
    'progress': 'InventoryUI/Popup/SliderCapacity/Background',
    'progressFill': 'InventoryUI/Popup/SliderCapacity/Fill Area/Fill/BackgroundGreen',
    'shopTab': 'BuildingUI/All/Btn/BtnBuilding',
    'shopTabOpen': 'BuildingUI/All/HeadingIcon/Building/HeaderBuilding/Open',
    'shopRim': 'BuildingUI/All/HeadingIcon/Building/HeaderBuilding/Open/Left',
    'shopBuilding': 'BuildingUI/All/HeadingIcon/Building/IconBuilding',
    'shopAnimal': 'BuildingUI/All/HeadingIcon/Animal/IconAnimal',
    'shopCardLocked': 'HouseBuildingUI',
    # The unlocked shop card uses the same sprite PPtr as the existing `card`.
    'shopPrice': 'AnimalBuildingUI/Price',
    'shopLock': 'AnimalBuildingUI/Lock/Icon',
    'shopQuantity': 'AnimalBuildingUI/BgUnlock/QuantityBG',
    'navShop': 'GameplayMainUI/SafeArea/PanelBot/GroupLeft/Building',
}


def write(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    contents = data if isinstance(data, bytes) else (json.dumps(data, ensure_ascii=False, indent=2) + '\n').encode()
    if not path.exists() or path.read_bytes() != contents:
        path.write_bytes(contents)


def ident(key):
    return str(uuid.uuid5(NS, 'golden-island-ui/' + key))


def asset_meta(importer, key, version, user=None, files=None):
    return dict(ver=version, importer=importer, imported=True, uuid=ident(key),
                files=files if files is not None else ['.json'], subMetas={}, userData=user or {})


def png_meta(key, size, border):
    data = copy.deepcopy(json.loads((PROJECT / 'assets/farm/bundles/farm-town/images/egg.png.meta').read_text()))
    old_id, image_id = data['uuid'], ident(key + '/image')

    def replace(v):
        if isinstance(v, str):
            return v.replace(old_id, image_id).replace('egg', key)
        if isinstance(v, list):
            return [replace(x) for x in v]
        if isinstance(v, dict):
            return {k: replace(x) for k, x in v.items()}
        return v

    data = replace(data)
    frame = data['subMetas']['f9941']['userData']
    w, h = size
    left, bottom, right, top = border
    frame.update(width=w, height=h, rawWidth=w, rawHeight=h, offsetX=0, offsetY=0, trimX=0, trimY=0,
                 pivotX=.5, pivotY=.5, trimType='none', borderLeft=left, borderBottom=bottom,
                 borderRight=right, borderTop=top)
    frame['vertices'] = dict(rawPosition=[-w/2, -h/2, 0, w/2, -h/2, 0, -w/2, h/2, 0, w/2, h/2, 0],
                             indexes=[0, 1, 2, 2, 1, 3], uv=[0, h, w, h, 0, 0, w, 0],
                             nuv=[0, 0, 1, 0, 0, 1, 1, 1], minPos=[-w/2, -h/2, 0], maxPos=[w/2, h/2, 0])
    return data


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', type=Path, required=True)
    source = parser.parse_args().source.resolve()
    import UnityPy
    UnityPy.config.FALLBACK_UNITY_VERSION = '2022.3.0f1'
    bundle = next((source / 'apk/assets/aa/Android').glob('duplicateassetisolation*.bundle'))
    env = UnityPy.load(str(bundle))

    def deref(p):
        return p.read() if p is not None and p.m_PathID else None

    def reader(o):
        return getattr(o, 'object_reader', None) or getattr(o, 'reader', None)

    def script(o):
        s = deref(getattr(o, 'm_Script', None))
        return getattr(s, 'm_ClassName', '') or getattr(s, 'm_Name', '')

    def transform(go):
        return next((t for c in go.m_Component if (t := deref(c.component)).__class__.__name__ == 'RectTransform'), None)

    root_names = {p.split('/')[0] for p in SPRITES.values()}
    nodes = {}

    def walk(t, parent=''):
        go = deref(t.m_GameObject)
        p = parent + '/' + go.m_Name if parent else go.m_Name
        nodes[p] = (go, t)
        for c in t.m_Children:
            child = deref(c)
            if child.__class__.__name__ == 'RectTransform':
                walk(child, p)

    for o in env.objects:
        if o.type.name != 'GameObject':
            continue
        go = o.read()
        if go.m_Name not in root_names:
            continue
        t = transform(go)
        if t is not None and t.m_Father.m_PathID == 0:
            walk(t)

    images = {}
    for key, source_path in SPRITES.items():
        go, t = nodes[source_path]
        comp = next(c for p in go.m_Component if (c := deref(p.component)).__class__.__name__ == 'MonoBehaviour' and script(c) == 'Image')
        sprite = deref(comp.m_Sprite)
        image = sprite.image
        dest = OUT / 'images' / (key + '.png')
        import io
        encoded = io.BytesIO()
        image.save(encoded, format='PNG')
        contents = encoded.getvalue()
        write(dest, contents)
        width, height = image.size
        source_border = [getattr(sprite.m_Border, k) for k in 'xyzw']
        offset = sprite.m_RD.textureRectOffset
        rect = sprite.m_Rect
        border = [max(0, source_border[0] - offset.x), max(0, source_border[1] - offset.y),
                  max(0, source_border[2] - (rect.width - offset.x - width)),
                  max(0, source_border[3] - (rect.height - offset.y - height))]
        # popup1's authored vertical borders overlap (79 + 74 > 136).
        # Keep their ratio and one center pixel so Cocos never samples a negative center.
        adjustments = []
        for a, b, extent in [(0, 2, width), (1, 3, height)]:
            total = border[a] + border[b]
            if total >= extent:
                factor = (extent - 1) / total
                border[a] *= factor
                border[b] *= factor
                adjustments.append('Overlapping source borders normalized proportionally with one center pixel.')
        write(Path(str(dest) + '.meta'), png_meta(key, image.size, border))
        image_reader = reader(sprite)
        images[key] = dict(resource='images/' + key, size=list(image.size), border=border,
                           sha256=hashlib.sha256(contents).hexdigest(), sourceName=sprite.m_Name,
                           sourceNode=source_path, sourcePathId=str(image_reader.path_id),
                           sourceAssetFile=image_reader.assets_file.name, sourceBorder=source_border,
                           sourceRect=[rect.width, rect.height], sourceOffset=[offset.x, offset.y],
                           sourceNodeSize=[t.m_SizeDelta.x, t.m_SizeDelta.y])
        if adjustments:
            images[key]['borderAdjustment'] = adjustments

    previous = json.loads((OUT / 'manifest.json').read_text()) if (OUT / 'manifest.json').exists() else {}
    for obsolete in previous.get('images', {}).keys() - images.keys():
        # Delete only former generated entries in this dedicated bundle, including their metadata.
        if not obsolete.isidentifier():
            raise ValueError('Unexpected generated image key: ' + obsolete)
        for suffix in ('.png', '.png.meta'):
            (OUT / 'images' / (obsolete + suffix)).unlink(missing_ok=True)
    write(OUT / 'manifest.json', dict(schemaVersion=1,
          source='Golden Island 1.0.24 / com.golden.island.survivors.farm.royal',
          sourceBundle=bundle.name, sourceBundleSHA256=hashlib.sha256(bundle.read_bytes()).hexdigest(),
          sourceAssetFile='CAB-e15518adb41e06a21dbd3b2317d9b019', images=images))
    write(OUT / 'manifest.json.meta', asset_meta('json', 'manifest', '2.0.1'))
    write(Path(str(OUT) + '.meta'), asset_meta('directory', 'directory', '1.2.0',
          dict(isBundle=True, bundleName='golden-island-ui', priority=2, isRemoteBundle=False), []))
    write(OUT / 'images.meta', asset_meta('directory', 'images', '1.2.0', files=[]))
    print(f'Imported {len(images)} native Golden Island UI sprites into {OUT.relative_to(REPO)}')


if __name__ == '__main__':
    main()
