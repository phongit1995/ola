"""Export the bitmap fonts referenced by Unity's farm timer and wallet labels.

Requires UnityPy. Input is the supplied bundle's extracted data.unity3d.
The generated .fnt and .png are checked in; playing/building Cocos does not require UnityPy.
"""
from pathlib import Path
import struct
import UnityPy

ROOT = Path(__file__).resolve().parents[2]
env = UnityPy.load(str(ROOT / 'hf/extracted/assets/bin/Data/data.unity3d'))
scene = next(o.assets_file for o in env.objects if o.assets_file.name == 'level2')
out = ROOT / 'cocos/assets/farm/fonts/farm'
out.mkdir(parents=True, exist_ok=True)

for label_id, name, texture_name, dimension in [(1635, 'FarmLabel', 'fontNew1', 590), (1147, 'WalletLabel', 'fontNew3', 405)]:
    # These UILabels store their UIFont reference at byte 180 in this bundle's NGUI layout.
    fid, pid = struct.unpack_from('<iq', scene.objects[label_id].get_raw_data(), 180)
    font = UnityPy.classes.PPtr(m_FileID=fid, m_PathID=pid, assetsfile=scene).deref()
    raw = font.get_raw_data()
    size, base, width, height = struct.unpack_from('<4i', raw, 60)
    length, = struct.unpack_from('<i', raw, 76)
    offset = (80 + length + 3) // 4 * 4
    count, = struct.unpack_from('<i', raw, offset)
    offset += 4
    glyphs, kernings = [], []
    for _ in range(count):
        index, x, y, w, h, ox, oy, advance, channel, pairs = struct.unpack_from('<10i', raw, offset)
        offset += 40
        assert pairs % 2 == 0
        kerning = struct.unpack_from('<' + 'i' * pairs, raw, offset)
        offset += pairs * 4
        glyphs.append(f'char id={index} x={x} y={y} width={w} height={h} xoffset={ox} yoffset={oy} xadvance={advance} page=0 chnl=15')
        kernings.extend(f'kerning first={kerning[i]} second={index} amount={kerning[i+1]}' for i in range(0, pairs, 2))
    assert (size, width, height, count) == (60, dimension, dimension, 221)
    fid, pid = struct.unpack_from('<iq', raw, 32)
    material = UnityPy.classes.PPtr(m_FileID=fid, m_PathID=pid, assetsfile=font.assets_file).read()
    texture = dict(material.m_SavedProperties.m_TexEnvs)['_MainTex'].m_Texture.read()
    assert texture.m_Name == texture_name and (texture.m_Width, texture.m_Height) == (width, height)
    texture.image.save(out / f'{name}.png')
    lines = [f'info face="Unity {texture_name}" size={size} bold=0 italic=0 charset="" unicode=1 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=0,0',
             f'common lineHeight={size} base={base} scaleW={width} scaleH={height} pages=1 packed=0',
             f'page id=0 file="{name}.png"', f'chars count={count}', *glyphs,
             f'kernings count={len(kernings)}', *kernings]
    (out / f'{name}.fnt').write_text('\n'.join(lines) + '\n', encoding='utf8')
    print(f'Exported {count} original glyphs from {font.assets_file.name}:{font.path_id} / {texture_name}')
