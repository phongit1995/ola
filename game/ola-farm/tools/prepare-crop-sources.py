#!/usr/bin/env python3
"""Copy audited crop PNGs without editing pixels; build a self-contained source pack.

python3 cocos/tools/prepare-crop-sources.py            # requires local Farm Town audit
python3 cocos/tools/prepare-crop-sources.py --check    # only requires the checked-in pack
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import zlib

PROJECT = Path(__file__).resolve().parents[1]
REPO = PROJECT.parent
DEST = PROJECT / 'source-assets/farm-town/crops'
GROUPS = {'field': 'Cây ruộng', 'orchard': 'Cây / bụi ăn quả', 'flowers': 'Bụi hoa'}
EARLY = {'corn': 'C1 — ngô và bắp cải', 'cabbage': 'C1 — ngô và bắp cải'}
FOOD = {'beet', 'carrot', 'potato', 'pumpkin'}
TEXTILE = {'cotton', 'flax', 'cane'}


def dumps(value):
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()


def digest(data):
    return hashlib.sha256(data).hexdigest()


def png_size(data):
    """Validate PNG framing/CRC, IHDR and compressed data without third-party deps."""
    assert data[:8] == b'\x89PNG\r\n\x1a\n', 'Invalid PNG signature'
    offset = 8
    dimensions = None
    compressed = bytearray()
    ended = False
    while offset < len(data):
        length = struct.unpack('>I', data[offset:offset + 4])[0]
        kind = data[offset + 4:offset + 8]
        body = data[offset + 8:offset + 8 + length]
        assert len(body) == length
        checksum = struct.unpack('>I', data[offset + 8 + length:offset + 12 + length])[0]
        assert zlib.crc32(kind + body) & 0xffffffff == checksum, 'PNG CRC mismatch'
        if kind == b'IHDR':
            assert offset == 8 and length == 13
            dimensions = list(struct.unpack('>II', body[:8]))
            assert all(n > 0 for n in dimensions)
        if kind == b'IDAT':
            compressed.extend(body)
        offset += length + 12
        if kind == b'IEND':
            assert length == 0 and offset == len(data)
            ended = True
            break
    assert dimensions and compressed and ended
    assert zlib.decompress(compressed), 'Empty PNG pixels'
    return dimensions


def batch(key, group):
    if group == 'orchard':
        return 'C4 — vườn táo đầu tiên' if key == 'apple_tree' else 'C5 — mở rộng vườn quả'
    if group == 'flowers':
        return 'C6 — hoa và chuỗi trang trí'
    if key in {'wheat', 'tomato'}:
        return 'REF — đối chiếu, giữ art Farm hiện có'
    if key in EARLY:
        return EARLY[key]
    if key in FOOD:
        return 'C2 — đường và thức ăn heo/cừu'
    if key in TEXTILE:
        return 'C3 — dệt may và đường mía'
    return 'C5 — món ăn mở rộng'


def phase_label(role):
    role_lower = role.lower()
    if role_lower.startswith('grow'):
        return 'Mọc — ' + role
    if role_lower.startswith('ready'):
        return 'Chín / có sản phẩm — ' + role
    if role_lower.startswith('harvest'):
        return 'Thu / còn sản phẩm — ' + role
    if role_lower.startswith('dead'):
        return 'Cạn lượt / kết thúc — ' + role
    return 'Nghỉ / mặc định — ' + role


def prepare(source):
    audit = json.loads((source / 'agriculture-audit.json').read_text())
    catalog = json.loads((source / 'catalog.json').read_text())
    vi = json.loads((source / 'localization-vi.json').read_text())
    exported = json.loads((source / 'export/manifest.json').read_text())
    checked = json.loads((source / 'agriculture-source-checks.json').read_text())
    assert audit['sourceApkSHA256'] == checked['apkSHA256']
    verified = {i['path']: i for i in checked['images']}
    sprite_records = {p: r for r in exported['records'] if r['type'] == 'Sprite' for p in r.get('exports', [])}
    items = {i['id']: i for i in catalog['items']}
    entities = {e['name']: e for e in audit['entities']}
    title = lambda key: vi.get(key, key)
    outputs = {}
    crop_records = []

    def put(relative, content):
        if relative in outputs:
            assert outputs[relative] == content, 'Conflicting output: ' + relative
        outputs[relative] = content

    entries = []
    for crop in audit['crops']:
        entries.append({
            'key': crop['name'], 'group': 'field', 'title': crop['titleVi'],
            'icon': crop['icon'], 'recipe': crop['recipe'], 'sourceConfig': crop['itemSource'],
            'prefab': entities['garden_bed']['prefab'], 'controllers': [crop['viewMapping']['controller']],
            'staticSprites': [], 'view': {k: v for k, v in crop['viewMapping'].items() if k != 'controller'},
            'behavior': None,
        })
    for e in audit['entities']:
        if e['group'] not in {'orchard', 'flower'}:
            continue
        entries.append({
            'key': e['name'], 'group': 'flowers' if e['group'] == 'flower' else 'orchard',
            'title': e['titleVi'], 'icon': e['icon'], 'recipe': e['recipes'][0],
            'sourceConfig': e['source'], 'prefab': e['prefab'],
            'controllers': e['visualAudit']['controllers'], 'staticSprites': e['visualAudit']['staticSprites'],
            'view': e['visualAudit']['views'], 'behavior': e['behaviorAudit'],
        })
    entries.sort(key=lambda e: (list(GROUPS).index(e['group']), e['recipe']['level'], e['key']))
    for entry in entries:
        folder = entry['group'] + '/' + entry['key']
        images = {}
        by_source = {}

        def copy_image(source_path, filename=None):
            if source_path in by_source:
                return by_source[source_path]
            record = sprite_records[source_path]
            raw = (source / source_path).read_bytes()
            sha = digest(raw)
            assert sha == verified[source_path]['sha256'], 'Source image changed: ' + source_path
            size = png_size(raw)
            assert size == [record['width'], record['height']]
            if filename is None:
                slug = re.sub(r'[^a-zA-Z0-9_-]+', '-', record['name']).strip('-').lower()
                identity = digest((record['file'] + ':' + str(record['id'])).encode())[:10]
                filename = 'images/' + slug + '--' + identity + '.png'
            put(folder + '/' + filename, raw)
            images[filename] = {
                'path': filename, 'bytes': len(raw), 'sha256': sha, 'size': size,
                'source': {'exportPath': source_path, 'file': record['file'], 'pathId': record['id'], 'spriteName': record['name']},
                'unitySprite': {key: record.get(key) for key in ['rect', 'pivot', 'pixelsToUnits', 'border', 'textureRectOffset']},
            }
            by_source[source_path] = filename
            return filename

        icon = copy_image(entry['icon'], 'icon.png')
        recipe = entry['recipe']
        product_icon = copy_image(recipe['output']['icon'], 'product.png')
        static_images = [copy_image(s['image']) for s in entry['staticSprites']]
        phases = []
        for controller in entry['controllers']:
            for index, role in enumerate(controller['roles']):
                clip = role['clip']
                references = [copy_image(s['image']) for s in clip['sprites']]
                phases.append({
                    'key': controller['name'] + ':' + str(index) + ':' + role['role'],
                    'role': role['role'], 'labelVi': phase_label(role['role']),
                    'images': list(dict.fromkeys(references)),
                    'emptyReason': None if references else 'Clip không có tham chiếu thay Sprite; cần đối chiếu transform và hình gán sẵn. Không phải ảnh bị xuất thiếu.',
                    'controller': {k: controller[k] for k in ['name', 'file', 'id', 'type']},
                    'clip': {**{k: clip[k] for k in ['name', 'file', 'id', 'type']}, 'exportPath': clip['source'], 'sha256': digest((source / clip['source']).read_bytes())},
                })
        product = items[recipe['output']['id']]
        ingredient_info = [{**{k: i[k] for k in ['id', 'name', 'quantity']}, 'titleVi': title(i['name'])} for i in recipe['ingredients']]
        consumers = []
        for candidate in catalog['recipes']:
            uses = [i for i in candidate['ingredients'] if i['id'] == product['id'] and i['quantity'] > 0]
            if uses:
                consumers.append({
                    'entity': candidate['entity'], 'entityTitleVi': title(candidate['entity']),
                    'recipeIndex': candidate['index'], 'output': candidate['output']['name'],
                    'outputTitleVi': title(candidate['output']['name']), 'inputQuantity': uses[0]['quantity'],
                    'sourceConfig': candidate['source'], 'bundleParameter': candidate['bundleParameter'],
                })
        behavior = entry['behavior']['settings'] if entry['behavior'] else None
        life = None
        if behavior:
            tool = items[behavior['itemRequired']]
            life = {
                'unlimited': bool(behavior['unlimitedLives']), 'cyclesToStart': behavior['livesMax'],
                'clearTool': {'id': tool['id'], 'name': tool['name'], 'titleVi': title(tool['name']), 'quantity': behavior['itemCount']},
                'guaranteedClearDrops': [{'id': i['_id'], 'name': items[i['_id']]['name'], 'titleVi': title(items[i['_id']]['name']), 'quantity': i['count']} for i in behavior['DroppedItems']],
            }
        compatibility = 'new-field-crop' if entry['group'] == 'field' else 'new-perennial-system'
        if entry['key'] in {'wheat', 'tomato'}:
            compatibility = 'reference-only-keep-current-art'
        info = {
            'schemaVersion': 1, 'key': entry['key'], 'group': entry['group'], 'titleVi': entry['title'],
            'status': 'source-images-prepared', 'runtimeEnabled': False,
            'plannedBatch': batch(entry['key'], entry['group']), 'farmCompatibility': compatibility,
            'icon': icon, 'productIcon': product_icon,
            'product': {'sourceItemId': product['id'], 'key': product['name'], 'titleVi': title(product['name'])},
            'source': {'apkSHA256': audit['sourceApkSHA256'], 'config': entry['sourceConfig'], 'prefab': entry['prefab'], 'view': entry['view']},
            'sourceRecipe': {
                'config': recipe['source'], 'index': recipe['index'], 'entity': recipe['entity'],
                'durationSeconds': recipe['time'], 'level': recipe['level'], 'quantityPerCycle': recipe['output']['quantity'],
                'ingredients': ingredient_info, 'condition': recipe['condition'], 'bundleParameter': recipe['bundleParameter'],
            },
            'sourceItemFields': {'level': product['level'], 'basicPrice': product['price'], 'xpOnUse': product['xpOnUse']},
            'sourceLifeCycle': life, 'sourceConsumers': consumers,
            'images': list(images.values()), 'staticImages': static_images, 'phases': phases,
            'notes': [
                'Giữ nguyên byte PNG xuất từ nguồn đã kiểm tra, chưa ghép mảnh/chuyển animation Cocos.',
                'Role ready1…ready5/harvest… là role controller nguồn, không được coi là các frame liên tiếp hoặc tự hiểu là cấp ruộng.',
                'Giá/thời gian/XP nguồn chỉ để đối chiếu; chưa là cân bằng Farm, chưa nối vào save/runtime.',
            ],
        }
        put(folder + '/crop.json', dumps(info))
        lines = [
            '# ' + entry['title'] + ' — `' + entry['key'] + '`', '',
            '[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)', '',
            '**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: ' + info['plannedBatch'] + '.', '',
            '![Icon](' + icon + ')', '',
            '| Thuộc tính | Dữ liệu nguồn |', '| --- | --- |',
            '| Nhóm | ' + GROUPS[entry['group']] + ' |',
            '| Sản phẩm | ' + info['product']['titleVi'] + ' (`' + product['name'] + '`, source ID ' + str(product['id']) + ') |',
            '| Thu mỗi đợt nguồn | ' + f"{recipe['output']['quantity']:g}" + ' |',
            '| Thời gian nguồn | ' + str(recipe['time']) + ' giây |',
            '| Cấp công thức / item nguồn | ' + str(recipe['level']) + ' / ' + str(product['level']) + ' |',
            '| Chi phí mỗi lượt nguồn | ' + (' + '.join(f"{i['quantity']:g} {i['titleVi']}" for i in ingredient_info) or 'Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng') + ' |',
            '| `BasicPrice` / `ExpOnUse` nguồn | ' + f"{product['price']:g} / {product['xpOnUse']:g}" + ' — chưa khẳng định là giá bán/XP thu hoạch Farm |',
            '| Tệp PNG riêng trong thư mục | ' + str(len(images)) + ' |',
        ]
        if life:
            lines += [
                '| Số lượt bắt đầu mọc nguồn | ' + str(life['cyclesToStart']) + ' |',
                '| Dụng cụ dọn cây | ' + f"{life['clearTool']['quantity']:g} {life['clearTool']['titleVi']}" + ' |',
                '| Drop bảo đảm khi dọn | ' + (', '.join(f"{i['quantity']:g} {i['titleVi']}" for i in life['guaranteedClearDrops']) or 'Không có') + ' |',
            ]
        lines += ['', 'Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.', '', '**Ảnh theo role / giai đoạn nguồn**', '', 'Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.', '', '| Role nguồn | Clip | Các mảnh PNG |', '| --- | --- | --- |']
        if static_images:
            lines.append('| Gán sẵn trong prefab | — | ' + ', '.join(f'[ảnh {n + 1}]({p})' for n, p in enumerate(static_images)) + ' |')
        for phase in phases:
            refs = ', '.join(f'[mảnh {n + 1}]({p})' for n, p in enumerate(phase['images'])) or 'Không có Sprite PPtr trong clip; xem ghi chú JSON'
            lines.append('| `' + phase['role'] + '` | `' + phase['clip']['name'] + '` | ' + refs + ' |')
        lines += ['', '**Công thức nguồn dùng sản phẩm này**', '', '| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |', '| --- | --- | ---: | --- |']
        for consumer in consumers:
            lines.append(f"| {consumer['entityTitleVi']} (`{consumer['entity']}`) | {consumer['outputTitleVi']} | {consumer['inputQuantity']:g} | {consumer['bundleParameter'] or 'Không có nhãn bundle'} |")
        if not consumers:
            lines.append('| Chưa có công thức tiêu thụ trong tập 177 công thức | Cần nối đơn hàng/bán hoặc nguồn bổ sung trước khi bật nội dung | — | — |')
        lines += ['', '**Trước khi đưa vào game**', '',
                  'Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. ' + ('Giữ hình và ID giống hiện tại, dùng bộ nguồn này để đối chiếu.' if compatibility.startswith('reference') else 'Không dùng source ID số làm ID Farm tự động.'), '',
                  'Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.',
        ]
        put(folder + '/README.md', ('\n'.join(lines) + '\n').encode())
        crop_records.append({'folder': folder, 'manifest': folder + '/crop.json', 'readme': folder + '/README.md', **info})

    counts = {group: sum(c['group'] == group for c in crop_records) for group in GROUPS}
    assert counts == {'field': 14, 'orchard': 10, 'flowers': 6}
    png_paths = [p for p in outputs if p.endswith('.png')]
    summary = {
        'schemaVersion': 1, 'status': 'source-images-prepared', 'runtimeEnabled': False,
        'sourceApkSHA256': audit['sourceApkSHA256'],
        'auditSHA256': digest((source / 'agriculture-audit.json').read_bytes()),
        'counts': counts, 'pngFiles': len(png_paths), 'pngBytes': sum(len(outputs[p]) for p in png_paths),
        'uniqueImageHashes': len({digest(outputs[p]) for p in png_paths}),
        'crops': [{k: c[k] for k in ['key', 'titleVi', 'group', 'folder', 'manifest', 'readme', 'plannedBatch', 'farmCompatibility', 'product']} for c in crop_records],
        'existingFarmFieldCrops': ['wheat', 'tomato', 'grapes', 'strawberry'],
        'newFieldCandidates': [c['key'] for c in crop_records if c['farmCompatibility'] == 'new-field-crop'],
        'notes': ['Crops use semantic source keys, not production save IDs.', 'Per-crop PNGs remain byte-identical to audited exports.', 'Original Unity clip bodies/hierarchies remain in the audit; this pack contains referenced PNGs and mapping metadata.'],
    }
    put('catalog.json', dumps(summary))
    readme = [
        '# Bộ ảnh cây trồng Farm Town cho Farm', '',
        '**Bộ ảnh và hồ sơ nguồn để tra cứu, giữ nguyên PNG đã xuất.** Bộ này nằm ngoài `cocos/assets/`, được theo dõi trong Git và không tự đi vào tài nguyên build Cocos.', '',
        '[Xem toàn bộ ảnh](index.html) · [Danh mục JSON](catalog.json) · [Asset pipeline](../../../docs/cocos/asset-pipeline.md) · [Cơ chế trồng/nuôi](../../../docs/cocos/farm-town-husbandry-runtime.md)', '',
        f"Có **30 loại**: 14 cây ruộng, 10 cây/bụi quả, 6 bụi hoa; **{summary['pngFiles']} tệp PNG** ({summary['pngBytes']:,} byte). Một số hình dùng chung giữa nhiều loại, giữ bản sao trong từng thư mục để có thể chọn một loại độc lập.", '',
        'Các nhãn `plannedBatch`, `newFieldCandidates` và `existingFarmFieldCrops` ghi lại phân nhóm lúc khảo sát, không phải kế hoạch hay danh sách giống hiện đang chơi. `runtimeEnabled: false` nghĩa là bộ nguồn này không tự được đóng gói. Runtime hiện có 8 giống trong `cocos/assets/farm/bundles/farm-town/catalog.json`; dùng luật chơi hiện hành ở liên kết phía trên. Bụi dâu nguồn không tự thay cây dâu trên ruộng.', '',
        '```text', 'crops/', '  catalog.json', '  index.html', '  field/<key>/', '  orchard/<key>/', '  flowers/<key>/', '    icon.png       # icon giống/cây trong bảng chọn', '    product.png    # icon sản phẩm nếu khác icon cây', '    images/*.png   # mảnh hình trên map, giữ nguyên pixel', '    crop.json      # phase, nguồn/hash/pivot, công thức và nơi tiêu thụ', '    README.md      # chi tiết loại bằng tiếng Việt', '```', '',
        'Ảnh không phải prefab hoàn chỉnh. Không ghép mọi mảnh cùng lúc, không hiểu các role `ready1…ready5` thành năm cấp cây và không đổi đuôi clip Unity thành `.anim` Cocos. `crop.json` lưu cả role không có Sprite PPtr để tránh giấu các trạng thái cần xử lý tiếp.', '',
    ]
    for group, label in GROUPS.items():
        readme += ['**' + label + '**', '', '| Loại / thư mục | Sản phẩm | Nhãn khảo sát gốc | PNG |', '| --- | --- | --- | ---: |']
        for crop in crop_records:
            if crop['group'] == group:
                readme.append(f"| [{crop['titleVi']}]({crop['readme']}) — `{crop['key']}` | {crop['product']['titleVi']} | {crop['plannedBatch']} | {len(crop['images'])} |")
        readme.append('')
    readme += ['**Kiểm tra và tạo lại**', '',
               '```sh', 'python3 cocos/tools/prepare-crop-sources.py --check', '```', '',
               'Lệnh kiểm tra dùng Python chuẩn, không cần APK, Pillow, UnityPy, Cocos Editor hay thư mục `artifacts/`. Kiểm tra checksum/kích thước PNG, manifest, ảnh của từng phase và đường dẫn tài liệu.', '',
               'Tạo lại bộ ảnh từ khảo sát tại máy này:', '',
               '```sh', 'python3 cocos/tools/prepare-crop-sources.py --source artifacts/farm-town', '```', '',
               'Lệnh tạo yêu cầu các báo cáo `agriculture-audit.json`, `catalog.json`, `localization-vi.json`, `agriculture-source-checks.json`, manifest/sprite/clip đã xuất. Chạy lại không đổi byte; nếu file đích đã sửa khác nội dung sinh ra, lệnh dừng trước khi ghi để giữ chỉnh sửa đó.', '',
               'Các giá, thời lượng, cấp và XP trong hồ sơ là số liệu **APK mod 5.16 nguồn**. Bảng cân bằng Farm nằm trong tài liệu runtime hiện hành. Nguồn: SHA-256 `' + audit['sourceApkSHA256'] + '`.', '',
               'Khi một loại đã dựng và kiểm tra xong, đưa đúng tập phụ thuộc cần dùng vào `cocos/assets/farm/bundles/…`, tạo/giữ `.meta` bằng pipeline Cocos và cập nhật manifest runtime. Bộ ảnh này không tự sửa map, catalog, save hoặc `package.json`.',
    ]
    put('README.md', ('\n'.join(readme) + '\n').encode())
    html = (PROJECT / 'tools/crop-sources.template.html').read_text()
    payload = json.dumps({'summary': summary, 'crops': crop_records}, ensure_ascii=True).replace('<', '\\u003c')
    put('index.html', html.replace('/* CROP_DATA */{}', payload).encode())

    # Preflight all destinations before mutating any existing file.
    for relative, raw in outputs.items():
        path = DEST / relative
        if path.exists() and path.read_bytes() != raw:
            raise RuntimeError('Destination differs; keep/review existing edits before regenerating: ' + str(path))
    for relative, raw in outputs.items():
        path = DEST / relative
        if not path.exists():
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(raw)
    return summary


def check():
    root = DEST.resolve()
    summary = json.loads((root / 'catalog.json').read_text())
    assert summary['schemaVersion'] == 1 and summary['runtimeEnabled'] is False
    assert summary['counts'] == {'field': 14, 'orchard': 10, 'flowers': 6}
    assert len(summary['crops']) == 30 and len(summary['newFieldCandidates']) == 12
    assert len({c['key'] for c in summary['crops']}) == 30
    expected = set()
    png_bytes = 0
    hashes = set()
    phase_count = 0
    for record in summary['crops']:
        base = (root / record['folder']).resolve()
        assert base.is_relative_to(root)
        crop = json.loads((root / record['manifest']).read_text())
        assert crop['key'] == record['key'] and crop['runtimeEnabled'] is False
        assert crop['source']['apkSHA256'] == summary['sourceApkSHA256']
        assert crop['sourceRecipe']['durationSeconds'] > 0
        by_path = {im['path']: im for im in crop['images']}
        assert len(by_path) == len(crop['images'])
        for image in crop['images']:
            path = (base / image['path']).resolve()
            assert path.is_relative_to(base) and path.suffix == '.png'
            raw = path.read_bytes()
            assert len(raw) == image['bytes'] and digest(raw) == image['sha256'], str(path)
            assert png_size(raw) == image['size'], str(path)
            expected.add(path)
            hashes.add(image['sha256'])
            png_bytes += len(raw)
        for reference in [crop['icon'], crop['productIcon'], *crop['staticImages']]:
            assert reference in by_path
        for phase in crop['phases']:
            assert all(p in by_path for p in phase['images'])
            assert phase['images'] or phase['emptyReason']
            phase_count += 1
        if crop['group'] == 'field':
            for prefix in ['grow', 'ready', 'harvest']:
                assert any(p['role'].lower().startswith(prefix) and p['images'] for p in crop['phases']), (crop['key'], prefix)
        else:
            # Some trees use Idle/Ready/Harvest defaults with a static sprite rig.
            # Do not invent grow roles or require sprite swaps for transform clips.
            assert crop['staticImages'] or any(p['images'] for p in crop['phases'])
            for prefix in ['ready', 'harvest', 'dead']:
                assert any(p['role'].lower().startswith(prefix) for p in crop['phases']), (crop['key'], prefix)
        if crop['group'] != 'field':
            assert crop['sourceLifeCycle']['cyclesToStart'] > 0
        for target in re.findall(r'\]\(([^)]+)\)', (base / 'README.md').read_text()):
            assert (base / target).is_file(), target
    assert expected == set(root.rglob('*.png')), 'Unexpected or missing PNGs'
    assert len(expected) == summary['pngFiles'] and png_bytes == summary['pngBytes']
    assert len(hashes) == summary['uniqueImageHashes']
    for target in re.findall(r'\]\(([^)]+)\)', (root / 'README.md').read_text()):
        assert (root / target).is_file(), target
    html = (root / 'index.html').read_text()
    assert '/* CROP_DATA */{}' not in html
    return {'crops': 30, 'groups': summary['counts'], 'pngFiles': len(expected), 'pngBytes': png_bytes, 'uniqueImageHashes': len(hashes), 'sourcePhaseMappings': phase_count, 'runtimeEnabled': False}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=REPO / 'artifacts/farm-town')
    parser.add_argument('--check', action='store_true', help='Verify the prepared pack without source audit/APK')
    args = parser.parse_args()
    if not args.check:
        prepare(args.source.resolve())
    print(json.dumps(check(), ensure_ascii=False, indent=2))
