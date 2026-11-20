import { toRoomMemberList } from '@ola/shared/stores/room/roomHelpers';
import type { RoomMember } from '@ola/shared/types';

const mockAuthState: { user: { id: string } | null } = { user: { id: 'me' } };

jest.mock('@ola/shared/stores/auth/authStore', () => ({
  useAuthStore: { getState: () => mockAuthState },
}));

const VIP_END = '2999-01-01T00:00:00Z';
const EXPIRED = '2000-01-01T00:00:00Z';

function member(username: string, vipEndTime?: string, vipUsed?: string): RoomMember {
  return { userId: username, username, vipEndTime, vipUsed } as RoomMember;
}

function names(members: RoomMember[]) {
  return members.map((item) => item.username);
}

describe('room member order', () => {
  beforeEach(() => {
    mockAuthState.user = { id: 'me' };
  });

  it('puts the viewer first, then VIP days, then shorter names, then join order', () => {
    const list = toRoomMemberList([
      member('normal_one'),
      member('five5', VIP_END),
      member('tri'),
      member('normal_vip', VIP_END, '1'),
      member('me'),
      member('ab', VIP_END),
      member('vip', VIP_END, '2'),
      member('cd'),
      member('one', VIP_END),
    ]);
    expect(names(list)).toEqual([
      'me',
      'ab',
      'vip',
      'one',
      'five5',
      'normal_vip',
      'cd',
      'tri',
      'normal_one',
    ]);
  });

  it('counts VIP days even without a VIP card worn', () => {
    expect(names(toRoomMemberList([member('long_name'), member('daysonly', VIP_END)]))).toEqual([
      'daysonly',
      'long_name',
    ]);
  });

  it('re-ranks a member whose VIP expired after the server answered', () => {
    expect(names(toRoomMemberList([member('long_name', EXPIRED, '1'), member('ab')]))).toEqual([
      'ab',
      'long_name',
    ]);
  });

  it('keeps the badge tied to the worn card', () => {
    const [withCard, daysOnly] = toRoomMemberList([
      member('ab', VIP_END, '1'),
      member('cd', VIP_END),
    ]);
    expect(withCard.vipTypeId).toBe(1);
    expect(daysOnly.vipTypeId).toBeNull();
  });

  it('does not move anyone to the top when logged out', () => {
    mockAuthState.user = null;
    expect(names(toRoomMemberList([member('me'), member('ab', VIP_END)]))).toEqual(['ab', 'me']);
  });
});
