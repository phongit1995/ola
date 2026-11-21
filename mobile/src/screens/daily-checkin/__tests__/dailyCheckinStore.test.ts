import { DailyCheckinService } from '@ola/shared/services/dailyCheckin.service';
import { useDailyCheckinStore } from '@ola/shared/stores/daily-checkin/dailyCheckinStore';
import type { DailyCheckinActionResult, DailyCheckinStatus } from '@ola/shared/types';

jest.mock('@ola/shared/services/dailyCheckin.service', () => ({
  DailyCheckinService: { status: jest.fn(), checkIn: jest.fn(), open: jest.fn() },
}));

jest.mock('@ola/shared/stores/appConfigStore', () => ({
  loadAppConfig: jest.fn(async () => null),
}));

jest.mock('@ola/shared/stores/auth/authStore', () => ({
  registerOnLogout: jest.fn(),
  useAuthStore: { getState: () => ({ user: { id: 'u1' }, refreshUser: jest.fn() }) },
}));

jest.mock('@ola/shared/stores/megaphone/megaphoneTicketStore', () => ({
  useMegaphoneTicketStore: { getState: () => ({ loaded: false, load: jest.fn() }) },
}));

const status = DailyCheckinService.status as jest.Mock;
const checkIn = DailyCheckinService.checkIn as jest.Mock;

function statusWith(checkedInToday: boolean): DailyCheckinStatus {
  return {
    enabled: true,
    checkedInToday,
    slot: 1,
    slots: [{ slot: 1, box: 'none', status: checkedInToday ? 'none' : 'today', requireVip: false }],
    endsAt: new Date(Date.now() + 3_600_000).toISOString(),
  } as unknown as DailyCheckinStatus;
}

function deferred<T>() {
  let resolve!: (value: T) => void;
  const promise = new Promise<T>((r) => {
    resolve = r;
  });
  return { promise, resolve };
}

describe('daily check-in store', () => {
  beforeEach(() => {
    status.mockReset();
    checkIn.mockReset();
    useDailyCheckinStore.getState().reset();
  });

  it('ignores a status load that started before a successful check-in', async () => {
    const stale = deferred<DailyCheckinStatus>();
    status.mockReturnValueOnce(stale.promise);
    const loading = useDailyCheckinStore.getState().load({ force: true });

    checkIn.mockResolvedValueOnce({ status: statusWith(true), slot: 1 } as DailyCheckinActionResult);
    await expect(useDailyCheckinStore.getState().checkIn()).resolves.toBe('done');
    expect(useDailyCheckinStore.getState().status?.checkedInToday).toBe(true);

    stale.resolve(statusWith(false));
    await loading;
    expect(useDailyCheckinStore.getState().status?.checkedInToday).toBe(true);
  });

  it('applies a status load that started after the check-in', async () => {
    checkIn.mockResolvedValueOnce({ status: statusWith(false), slot: 1 } as DailyCheckinActionResult);
    await useDailyCheckinStore.getState().checkIn();
    status.mockResolvedValueOnce(statusWith(true));
    await useDailyCheckinStore.getState().load({ force: true });
    expect(useDailyCheckinStore.getState().status?.checkedInToday).toBe(true);
  });
});
