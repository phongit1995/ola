import {
  formatDateSlashDMY,
  formatOlaDateSeparator,
  formatOlaTime,
} from '@ola/shared/lib';

function localDate(
  year: number,
  month: number,
  day: number,
  hour: number = 12,
  minute: number = 0,
): Date {
  return new Date(year, month - 1, day, hour, minute, 0, 0);
}

describe('legacy Ola datetime formatting', () => {
  it('formats full ISO dates without leaking the time suffix', () => {
    expect(formatDateSlashDMY(localDate(1990, 1, 1).toISOString())).toBe('01/01/1990');
  });

  it('uses the APK relative-time thresholds for messages from today', () => {
    const now = localDate(2026, 8, 7, 12).getTime();

    expect(formatOlaTime(new Date(now - 30_000).toISOString(), 'vi', now)).toBe(
      'vừa tức thì',
    );
    expect(formatOlaTime(new Date(now - 5 * 60_000).toISOString(), 'vi', now)).toBe(
      '5 phút',
    );
    expect(formatOlaTime(new Date(now - 2 * 3_600_000).toISOString(), 'vi', now)).toBe(
      '2 giờ',
    );
    expect(formatOlaTime(localDate(2026, 8, 7, 5).toISOString(), 'vi', now)).toBe(
      '05:00 hôm nay',
    );
  });

  it('uses APK weekday and numeric-date branches across calendar weeks', () => {
    const friday = localDate(2026, 8, 7, 12).getTime();
    const monday = localDate(2026, 8, 3, 10, 15).toISOString();
    expect(formatOlaTime(monday, 'vi', friday)).toBe('10:15 thứ Hai');

    const nextMonday = localDate(2026, 8, 10, 12).getTime();
    const previousFriday = localDate(2026, 8, 7, 10, 15).toISOString();
    expect(formatOlaTime(previousFriday, 'vi', nextMonday)).toBe(
      '10:15 thứ Sáu 07/08',
    );

    const priorYear = localDate(2025, 12, 31, 10, 15).toISOString();
    expect(formatOlaTime(priorYear, 'vi', nextMonday)).toBe(
      '10:15 thứ Tư 31/12/2025',
    );
  });

  it('formats chat separators like the APK', () => {
    const friday = localDate(2026, 8, 7, 12).getTime();

    expect(formatOlaDateSeparator(localDate(2026, 8, 7).toISOString(), 'vi', friday)).toBe(
      'HÔM NAY',
    );
    expect(formatOlaDateSeparator(localDate(2026, 8, 6).toISOString(), 'vi', friday)).toBe(
      'HÔM QUA',
    );

    const nextMonday = localDate(2026, 8, 10, 12).getTime();
    expect(formatOlaDateSeparator(localDate(2026, 8, 7).toISOString(), 'vi', nextMonday)).toBe(
      'THỨ SÁU 07/08',
    );
    expect(formatOlaDateSeparator(localDate(2026, 8, 9).toISOString(), 'vi', nextMonday)).toBe(
      'CHỦ NHẬT 09/08',
    );
  });
});
