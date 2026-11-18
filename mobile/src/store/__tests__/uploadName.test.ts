import { uploadNameForType } from '@ola/shared/lib';

describe('uploadNameForType', () => {
  it('đổi đuôi HEIC khi file thật là JPEG', () => {
    expect(uploadNameForType('IMG_5097.HEIC', 'image/jpeg')).toBe('IMG_5097.jpg');
  });

  it('giữ tên khi đuôi đã khớp định dạng', () => {
    expect(uploadNameForType('photo.jpeg', 'image/jpeg')).toBe('photo.jpeg');
    expect(uploadNameForType('photo.JPG', 'image/jpeg')).toBe('photo.JPG');
    expect(uploadNameForType('sticker.webp', 'image/webp')).toBe('sticker.webp');
  });

  it('thêm đuôi khi tên không có đuôi', () => {
    expect(uploadNameForType('photo', 'image/png')).toBe('photo.png');
  });

  it('không đụng tới định dạng không gửi nguyên được', () => {
    expect(uploadNameForType('anim.heic', 'image/heic')).toBe('anim.heic');
  });
});
