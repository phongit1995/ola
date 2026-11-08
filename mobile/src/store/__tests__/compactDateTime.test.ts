import { formatCompactDateTime } from '@ola/shared/lib';

const NOW = new Date(2026, 10, 7, 12, 0).getTime();

describe('formatCompactDateTime', () => {
  it('bỏ năm khi cùng năm hiện tại', () => {
    expect(formatCompactDateTime(new Date(2026, 0, 2, 9, 5).toISOString(), NOW)).toBe('02/01 09:05');
  });

  it('giữ năm khi khác năm', () => {
    expect(formatCompactDateTime(new Date(2025, 11, 31, 23, 59).toISOString(), NOW)).toBe('31/12/2025 23:59');
  });

  it('trả rỗng khi ngày không hợp lệ', () => {
    expect(formatCompactDateTime('khong-phai-ngay', NOW)).toBe('');
  });
});
