# Nguồn APK và dữ liệu trích xuất

> **Trong Ola chỉ có project Cocos** (`game/ola-farm/`). Các thư mục khảo sát nhắc tới dưới đây (`hf/`, `reference/`, `assets/`, `data/unity/`, `scripts/`, `extract_hf.py`, `artifacts/`) và lịch sử Git của chúng nằm ở repo farm-game gốc (`/Volumes/D/GAME/farm-game`), không được đưa sang Ola.

Game Cocos dùng asset đã nhập trong `game/ola-farm/assets/`. Bản HTML cũ đã được gỡ; `assets/` và `data/unity/` ở gốc giữ tài nguyên đã trích xuất để tra cứu nguồn. Chạy, kiểm thử và build Cocos không cần gói APK cũ. Xem [asset pipeline Cocos](cocos/asset-pipeline.md) khi chỉnh hoặc nhập lại tài nguyên.

## Nguồn cục bộ

`hf/` giữ các file Happy Farm mà công cụ khảo sát và xuất dữ liệu còn đọc:

- `hf/extracted/assets/bin/Data/data.unity3d`: nguồn asset Unity.
- `hf/extracted/assets/bin/Data/Managed/Metadata/global-metadata.dat`: metadata dùng khi phân tích dữ liệu Unity.
- `hf/extracted/lib/arm64-v8a/libil2cpp.so`: mã native dùng trong các công cụ khảo sát.

`reference/` giữ dữ liệu Farm Town, Farm City và Golden Island để khảo sát/nhập lại asset. Hai thư mục này là dữ liệu cục bộ được Git bỏ qua. Asset đã nhập và hồ sơ nguồn phục vụ game hiện tại nằm trong `game/ola-farm/assets/` và `game/ola-farm/source-assets/`.

`python3 extract_hf.py --help` hướng dẫn xuất lại asset Happy Farm. Mặc định công cụ đọc thư mục Unity trên và ghi vào `artifacts/extracted-assets`; dùng `--source` hoặc `--output` để chọn vị trí khác.

Các công cụ trong `scripts/` vẫn phục vụ khảo sát nguồn và chỉ xuất báo cáo JSON thay cho bundle JavaScript của preview đã gỡ:

| Công cụ | Báo cáo trong `artifacts/` |
| --- | --- |
| `build_config.py` | `game-data.json`, đọc XML trong `assets/text/` bằng Python chuẩn |
| `audit_unity_scene.py` | `unity-scene-audit.json`; vẫn xuất ảnh nguồn vào `data/unity/` |
| `build_unity_runtime.py` | `unity-runtime-audit.json` |
| `audit_farm_ui.py` | `farm-ui-source.json`, `farm-ui-audit.json` |
| `build_panel_ui.py` | `panels/source.json`, `panels/ui.json` |

Chạy bằng `python scripts/<tên-file>.py` từ gốc repo khi cần khảo sát. Các script đọc bundle cần nguồn `hf/` và UnityPy; chúng không phải bước build Cocos.

## Gói nguồn cũ

`bundle.zip.001`, `.002`, `.003` từng là ba phần của **một** ZIP, chứa `happyfarm_demo_ver2.apk` và APK đã giải nén trong `hf/`. Gói bị chia nhỏ để mỗi file dưới giới hạn 100 MB của GitHub. Bộ ZIP khoảng 216 MiB này đã được bỏ khỏi cây làm việc vì game và công cụ build không đọc nó.

Nếu cần APK gốc hoặc toàn bộ dữ liệu giải nén cũ, gói nguồn vẫn nằm trong commit `727040679729a1db026b8d5a684889412d4780c9` của lịch sử Git. Có thể lấy lại cả ba phần từ commit đó, ghép theo thứ tự `.001` → `.002` → `.003`, rồi giải nén vào thư mục riêng để tra cứu.

Các bản sao lưu trong `artifacts/` cần được kiểm tra nội dung trước khi xóa. Ví dụ `artifacts/farm40-scope-transition/full-before-simple.tar.gz` giữ nguồn của bản game trước khi thu gọn, gồm nhiều file không còn trong cây làm việc hiện tại.
