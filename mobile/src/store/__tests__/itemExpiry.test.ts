import {
  isAvatarFrameTransferable,
  isItemExpired,
  isItemExpiringSoon,
  isVipIconTransferable,
  itemExpiryLabel,
  itemExpiryTickMs,
  withoutExpiredItems,
} from '@ola/shared/lib';

const NOW = Date.UTC(2026, 10, 18, 10, 0, 0);
const iso = (offsetMs: number) => new Date(NOW + offsetMs).toISOString();
const HOUR = 3_600_000;
const t = ((key: string, options?: Record<string, number>) => `${key}:${JSON.stringify(options ?? {})}`) as never;

describe('itemExpiry', () => {
  it('detects expired and expiring items', () => {
    expect(isItemExpired(undefined, NOW)).toBe(false);
    expect(isItemExpired(iso(-1), NOW)).toBe(true);
    expect(isItemExpired(iso(HOUR), NOW)).toBe(false);
    expect(isItemExpiringSoon(iso(HOUR), NOW)).toBe(true);
    expect(isItemExpiringSoon(iso(48 * HOUR), NOW)).toBe(false);
  });

  it('formats remaining time', () => {
    expect(itemExpiryLabel(t, iso(3 * 24 * HOUR), NOW)).toBe('itemExpiry.days:{"count":3}');
    expect(itemExpiryLabel(t, iso(2 * 24 * HOUR + 5 * HOUR + 30 * 60_000), NOW)).toBe('itemExpiry.dayHour:{"days":2,"hours":5}');
    expect(itemExpiryLabel(t, iso(5 * HOUR + 4 * 60_000 + 9_000), NOW)).toBe('05:04:09');
    expect(itemExpiryLabel(t, iso(20 * 60_000 + 5_500), NOW)).toBe('20:05');
    expect(itemExpiryLabel(t, iso(-1), NOW)).toBeNull();
    expect(itemExpiryLabel(t, null, NOW)).toBeNull();
  });

  it('ticks every second only within the last day', () => {
    expect(itemExpiryTickMs(iso(5 * HOUR), NOW)).toBe(1000);
    expect(itemExpiryTickMs(iso(48 * HOUR), NOW)).toBe(60_000);
    expect(itemExpiryTickMs(null, NOW)).toBe(60_000);
  });

  it('drops expired items only', () => {
    const items = [{ id: 'a' }, { id: 'b', expiresAt: iso(-1) }, { id: 'c', expiresAt: iso(HOUR) }];
    expect(withoutExpiredItems(items, NOW).map((item) => item.id)).toEqual(['a', 'c']);
  });

  it('uses the locked flag and falls back to source for old servers', () => {
    expect(isVipIconTransferable({ source: 'purchase', locked: false })).toBe(true);
    expect(isVipIconTransferable({ source: 'purchase', locked: true })).toBe(false);
    expect(isVipIconTransferable({ source: 'admin', locked: false, expiresAt: iso(HOUR) })).toBe(false);
    expect(isVipIconTransferable({ source: 'gift_code' })).toBe(false);
    expect(isAvatarFrameTransferable({ source: 'purchase' })).toBe(true);
  });
});
