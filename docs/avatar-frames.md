# Avatar frames

Danh mục 731 khung avatar nằm ở `packages/shared/src/lib/avatarFrames.json`, dùng chung cho admin, web và mobile. `assets/avatar_frames/frames.json` là bản sao giống hệt; sửa danh mục thì sửa cả hai file. Ảnh webp 160×160 (giữ animation) nằm trên S3 ở `ola/avatar_frames/`.

```json
{
  "id": "001",
  "name": "Carrot",
  "file": "001.webp",
  "url": "https://s3.vn-hcm-1.vietnix.cloud/ola/avatar_frames/001.webp"
}
```

```ts
import { AVATAR_FRAMES, avatarFrameById } from '@ola/shared/lib/avatarFrame';
```

- Import qua `@ola/shared/lib/avatarFrame`, không qua barrel `@ola/shared/lib`, để màn không dùng frame khỏi phải kéo theo file JSON.
- `id` là chuỗi, trùng tên file, không được đổi hay đánh lại. Server chỉ lưu `frameId`.
- Đã bỏ 28 mẫu sticker che kín avatar và 7 dòng trùng file.
- 6 frame chưa có tên: `100`, `256`, `555`, `657`, `658`, `707`.
- Hiển thị: khung rộng bằng 1,2 lần chỗ avatar, avatar bằng 66% khung, khung đè lên trên avatar.
- Chỉ gắn frame cho avatar của user (`user.avatar`) trong Me, không gắn cho `VipAvatar` hay icon.

Bộ gốc 264px (759 ảnh, gồm cả sticker): https://drive.google.com/open?id=1nXDcAOplfoXxIkIsV1aYswPrvp4tcpYE
