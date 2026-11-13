import type { TFunction } from 'i18next';
import {
  SMILEY_ALIASES,
  buildSmileyMap,
  buildSmileyPanel,
  buildSmileyRegex,
  formatKen,
  formatRewardKen,
  isKenKind,
  isValidNickname,
  isVipDaysKind,
  isVipItemKind,
  mapFriendsToContacts,
  nicknameTierLabel,
  normalizeDevice,
  normalizeNickname,
  transferAmountDigits,
  transferErrorText,
  ApiError,
  vipHistoryIconTypeId,
  vipHistorySourceKey,
  vipRemainingText,
} from '@ola/shared/lib';
import { HTTP_STATUS, VIP_TRANSFER_BLOCKED_ERROR } from '@ola/shared/constants';
import type { Friend } from '@ola/shared/types';

describe('normalizeDevice', () => {
  it('maps empty and unknown values to pc', () => {
    expect(normalizeDevice()).toBe('pc');
    expect(normalizeDevice('')).toBe('pc');
    expect(normalizeDevice('toaster')).toBe('pc');
  });

  it('keeps known device types and resolves aliases', () => {
    expect(normalizeDevice('phone')).toBe('phone');
    expect(normalizeDevice('winphone')).toBe('winphone');
    expect(normalizeDevice('ios')).toBe('apple');
    expect(normalizeDevice('android')).toBe('android');
    expect(normalizeDevice('web')).toBe('pc');
  });
});

describe('mapFriendsToContacts', () => {
  const now = new Date(2026, 10, 13, 12, 0, 0).getTime();
  const base: Friend = {
    id: 'u1',
    username: 'alice',
    fullName: 'Alice',
    isOnline: true,
    deviceType: 'ios',
  } as Friend;

  it('builds a contact from a friend', () => {
    const [contact] = mapFriendsToContacts([base], 'vi', now);
    expect(contact).toMatchObject({
      id: 'u1',
      name: 'alice',
      fullName: 'Alice',
      online: true,
      deviceType: 'apple',
      lastActive: undefined,
      vip: false,
      group: 'friend',
    });
    expect(typeof contact?.color).toBe('string');
  });

  it('groups friends with a birthday today', () => {
    const [contact] = mapFriendsToContacts(
      [{ ...base, dateOfBirth: '2000-11-13' } as Friend],
      'vi',
      now,
    );
    expect(contact?.group).toBe('birthday');
  });
});

describe('nickname helpers', () => {
  it('normalizes input', () => {
    expect(normalizeNickname('  @AbcD ')).toBe('abcd');
  });

  it('validates length and pattern', () => {
    expect(isValidNickname('a')).toBe(false);
    expect(isValidNickname('ab')).toBe(true);
    expect(isValidNickname('a1')).toBe(true);
    expect(isValidNickname('1a')).toBe(false);
    expect(isValidNickname('a'.repeat(20))).toBe(true);
    expect(isValidNickname('a'.repeat(21))).toBe(false);
  });

  it('labels tiers', () => {
    const t = ((key: string, opts: Record<string, number>) =>
      `${key}:${JSON.stringify(opts)}`) as unknown as TFunction;
    const tier = (minLength: number) => ({ minLength, cost: 0 });
    expect(nicknameTierLabel(t, tier(2), tier(3))).toBe('changeNickname.tierLabel:{"n":2}');
    expect(nicknameTierLabel(t, tier(3), tier(6))).toBe(
      'changeNickname.tierRange:{"from":3,"to":5}',
    );
    expect(nicknameTierLabel(t, tier(6), undefined)).toBe(
      'changeNickname.tierLabelPlus:{"n":6}',
    );
  });
});

describe('vip history helpers', () => {
  it('maps source keys', () => {
    expect(vipHistorySourceKey('egg')).toBe('egg');
    expect(vipHistorySourceKey('day_transfer_in')).toBe('day_transfer_in');
    expect(vipHistorySourceKey('mystery')).toBe('other');
  });

  it('extracts icon type id from package name', () => {
    expect(vipHistoryIconTypeId('VIP #12')).toBe(12);
    expect(vipHistoryIconTypeId('VIP Gold')).toBeNull();
  });
});

describe('spin wheel helpers', () => {
  it('formats reward ken', () => {
    expect(formatRewardKen(12000)).toBe('12K');
    expect(formatRewardKen(12500)).toBe('12.5K');
    expect(formatRewardKen(9999)).toBe(formatKen(9999));
  });

  it('classifies segment kinds', () => {
    expect(isKenKind('ken_fixed')).toBe(true);
    expect(isKenKind('ken_random')).toBe(true);
    expect(isKenKind('vip_days')).toBe(false);
    expect(isVipDaysKind('vip_days')).toBe(true);
    expect(isVipItemKind('vip_item')).toBe(true);
    expect(isVipItemKind('vip_random')).toBe(true);
    expect(isVipItemKind('miss')).toBe(false);
  });
});

describe('smiley codes', () => {
  const images = SMILEY_ALIASES.map((_, index) => `img${index}`);
  const map = buildSmileyMap(images);
  const regex = buildSmileyRegex(Object.keys(map));

  it('uses the first alias as the panel code', () => {
    const panel = buildSmileyPanel(images);
    expect(panel[0]).toEqual({ image: 'img0', code: ':-)' });
    expect(panel).toHaveLength(SMILEY_ALIASES.length);
  });

  it('maps every alias to its image', () => {
    expect(map[':)']).toBe('img0');
    expect(map[':P']).toBe('img1');
    expect(map['(Y)']).toBe(images[34]);
  });

  it('matches longest codes first and emoji tokens', () => {
    expect('hi :-)) :) [e:12] :(('.match(regex)).toEqual([':-))', ':)', '[e:12]', ':((']);
  });

  it('only covers the images it was given', () => {
    expect(Object.values(buildSmileyMap(['only']))).toEqual(['only', 'only']);
  });
});

describe('transfer helpers', () => {
  const t = ((key: string) => key) as unknown as TFunction;
  const keys = {
    network: 'net',
    unauthorized: 'pwd',
    forbidden: 'forbid',
    blocked: 'blocked',
  } as unknown as Parameters<typeof transferErrorText>[2];
  const apiError = (status: number, message = 'server says no') => new ApiError(status, message);

  it('keeps digits only, max 12', () => {
    expect(transferAmountDigits('1.000a2')).toBe('10002');
    expect(transferAmountDigits('1234567890123456')).toBe('123456789012');
  });

  it('maps transfer errors', () => {
    expect(transferErrorText(t, apiError(0), keys)).toBe('net');
    expect(transferErrorText(t, apiError(HTTP_STATUS.unauthorized), keys)).toBe('pwd');
    expect(transferErrorText(t, apiError(400, VIP_TRANSFER_BLOCKED_ERROR), keys)).toBe('blocked');
    expect(transferErrorText(t, apiError(HTTP_STATUS.forbidden), keys)).toBe('forbid');
    expect(transferErrorText(t, apiError(500), keys)).toBe('server says no');
  });

  it('treats the blocked message as forbidden when no blocked key', () => {
    const withoutBlocked = { ...keys, blocked: undefined };
    expect(
      transferErrorText(t, apiError(HTTP_STATUS.forbidden, VIP_TRANSFER_BLOCKED_ERROR), withoutBlocked),
    ).toBe('forbid');
  });
});

describe('vipRemainingText', () => {
  const t = ((key: string, opts?: Record<string, number>) =>
    opts == null ? key : `${key}:${JSON.stringify(opts)}`) as unknown as TFunction;
  const now = Date.UTC(2026, 10, 13, 0, 0, 0);
  const at = (ms: number) => new Date(now + ms).toISOString();

  it('uses remaining days without an end time', () => {
    expect(vipRemainingText(t, null, 3, now)).toBe('vip.daysLeft:{"count":3}');
    expect(vipRemainingText(t, null, 0, now)).toBe('vip.noVip');
    expect(vipRemainingText(t, 'not-a-date', null, now)).toBe('vip.noVip');
  });

  it('formats time left from the end time', () => {
    expect(vipRemainingText(t, at(-1), 5, now)).toBe('vip.expired');
    expect(vipRemainingText(t, at(36 * 3_600_000), null, now)).toBe('vip.daysLeft:{"count":2}');
    expect(vipRemainingText(t, at(2 * 3_600_000 + 5 * 60_000), null, now)).toBe(
      'vip.hoursMinutesLeft:{"hours":2,"minutes":5}',
    );
    expect(vipRemainingText(t, at(3 * 3_600_000), null, now)).toBe('vip.hoursLeft:{"count":3}');
    expect(vipRemainingText(t, at(10 * 60_000), null, now)).toBe('vip.minutesLeft:{"count":10}');
    expect(vipRemainingText(t, at(30_000), null, now)).toBe('vip.expiringSoon');
  });
});
