import type { TFunction } from 'i18next';
import {
  ApiError,
  EMAIL_UNAVAILABLE_STATUS,
  eggRewardText,
  emojiToken,
  emojiTokenIndex,
  formatCountdownMMSS,
  formatDateSlashDMY,
  formatLikeCount,
  groupPhotosByMonth,
  isBlockedRelationship,
  isEmojiToken,
  pointerTickDeg,
  verifyEmailErrorKey,
  vipName,
} from '@ola/shared/lib';
import { EGG_CATEGORY_KIND, RELATIONSHIP_STATUS } from '@ola/shared/constants';

const t = ((key: string, options?: { days?: number }) =>
  options?.days != null ? `${key}:${options.days}` : key) as unknown as TFunction;

describe('formatCountdownMMSS', () => {
  it('rounds up to whole seconds and never goes negative', () => {
    expect(formatCountdownMMSS(0)).toBe('00:00');
    expect(formatCountdownMMSS(1)).toBe('00:01');
    expect(formatCountdownMMSS(61_000)).toBe('01:01');
    expect(formatCountdownMMSS(-500)).toBe('00:00');
    expect(formatCountdownMMSS(600_000)).toBe('10:00');
  });
});

describe('formatDateSlashDMY', () => {
  it('accepts epoch milliseconds like the old marriage formatter', () => {
    const ms = new Date(2026, 0, 5, 10, 0).getTime();
    expect(formatDateSlashDMY(ms)).toBe('05/01/2026');
    expect(formatDateSlashDMY(new Date(2026, 0, 5).toISOString())).toBe('05/01/2026');
  });
});

describe('formatLikeCount', () => {
  it('caps at 9+', () => {
    expect(formatLikeCount(0)).toBe('0');
    expect(formatLikeCount(9)).toBe('9');
    expect(formatLikeCount(10)).toBe('9+');
  });
});

describe('groupPhotosByMonth', () => {
  it('groups consecutive photos of the same month and keeps the global index', () => {
    const photos = [
      { url: 'a', createdAt: new Date(2026, 10, 20).toISOString() },
      { url: 'b', createdAt: new Date(2026, 10, 2).toISOString() },
      { url: 'c', createdAt: new Date(2026, 9, 30).toISOString() },
    ];
    const groups = groupPhotosByMonth(photos, 'en');
    expect(groups.map((g) => g.key)).toEqual(['2026-10', '2026-9']);
    expect(groups[0]!.label).toBe('November 2026');
    expect(groups[0]!.items).toEqual([
      { url: 'a', index: 0 },
      { url: 'b', index: 1 },
    ]);
    expect(groups[1]!.items).toEqual([{ url: 'c', index: 2 }]);
  });
});

describe('eggRewardText', () => {
  it('prefers VIP name, then label, then KEN and VIP days', () => {
    expect(eggRewardText(t, EGG_CATEGORY_KIND.vipIcon, { vipTypeId: 1, label: 'x' } as never)).toBe(
      vipName(1),
    );
    expect(eggRewardText(t, EGG_CATEGORY_KIND.ken, { label: 'Lucky', kenAmount: 5 } as never)).toBe('Lucky');
    expect(eggRewardText(t, EGG_CATEGORY_KIND.ken, { kenAmount: 5000 } as never)).toBe('5,000 Ken');
    expect(eggRewardText(t, EGG_CATEGORY_KIND.vipDays, { vipDays: 7 } as never)).toBe(
      'eggGame.gifts.vipDaysLabel:7',
    );
    expect(eggRewardText(t, EGG_CATEGORY_KIND.nothing, {} as never)).toBe('');
  });
});

describe('pointerTickDeg', () => {
  it('returns 0 for empty wheels and a negative tick inside a slice', () => {
    expect(pointerTickDeg(10, 0)).toBe(0);
    expect(pointerTickDeg(30, 60)).toBe(-0);
    expect(pointerTickDeg(60, 60)).toBeCloseTo(-15 * 0.25);
  });
});

describe('verifyEmailErrorKey', () => {
  it('maps server messages to i18n keys', () => {
    expect(verifyEmailErrorKey(new Error('x'))).toBe('verifyEmail.errGeneric');
    expect(verifyEmailErrorKey(new ApiError(EMAIL_UNAVAILABLE_STATUS, 'down'))).toBe(
      'verifyEmail.errUnavailable',
    );
    expect(verifyEmailErrorKey(new ApiError(400, 'Email domain not allowed'))).toBe(
      'verifyEmail.errDomainNotAllowed',
    );
    expect(verifyEmailErrorKey(new ApiError(400, 'invalid verification request'))).toBe(
      'verifyEmail.errCodeExpired',
    );
    expect(verifyEmailErrorKey(new ApiError(400, 'Invalid verification code'))).toBe(
      'verifyEmail.errCodeInvalid',
    );
  });
});

describe('isBlockedRelationship', () => {
  it('is true only for the two blocked states', () => {
    expect(isBlockedRelationship(RELATIONSHIP_STATUS.blockedByMe)).toBe(true);
    expect(isBlockedRelationship(RELATIONSHIP_STATUS.blockedByThem)).toBe(true);
    expect(isBlockedRelationship(RELATIONSHIP_STATUS.friend)).toBe(false);
    expect(isBlockedRelationship(undefined)).toBe(false);
  });
});

describe('emoji tokens', () => {
  it('builds, detects and parses tokens', () => {
    expect(emojiToken(3)).toBe('[e:3]');
    expect(isEmojiToken('[e:12]')).toBe(true);
    expect(isEmojiToken('[e:123]')).toBe(false);
    expect(emojiTokenIndex('[e:7]')).toBe(7);
    expect(emojiTokenIndex('hi')).toBeNull();
  });
});
