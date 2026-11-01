import { configureKeyValueStorage } from '@ola/shared/platform';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { MomentService } from '@ola/shared/services/moment.service';
import type { AuthState, Moment } from '@ola/shared/types';

jest.mock('@ola/shared/services/moment.service', () => ({
  MomentService: { react: jest.fn(), mine: jest.fn() },
}));
jest.mock('@ola/shared/services/user.service', () => ({ UserService: {} }));

const HOUR_MS = 60 * 60 * 1000;
const memory = new Map<string, string>();

configureKeyValueStorage({
  getItem: (key) => memory.get(key) ?? null,
  setItem: (key, value) => void memory.set(key, value),
  removeItem: (key) => void memory.delete(key),
});
const react = MomentService.react as jest.Mock;
const mine = MomentService.mine as jest.Mock;

function signIn(id: string) {
  useAuthStore.setState({ user: { id } as AuthState['user'] });
}

function processing(id: string, expiresInMs: number): Moment {
  return {
    id,
    status: 'processing',
    expiresAt: new Date(Date.now() + expiresInMs).toISOString(),
  } as unknown as Moment;
}

beforeEach(() => {
  jest.useFakeTimers();
  react.mockReset();
  mine.mockReset();
  useMomentStore.getState().reset();
  signIn('user-a');
});

afterEach(() => {
  jest.useRealTimers();
});

describe('moment reactions across accounts', () => {
  it('keeps the next account reaction when the previous account reply arrives late', async () => {
    let answerA: (value: { type: string; count: number }) => void = () => undefined;
    react.mockReturnValueOnce(new Promise((resolve) => (answerA = resolve)));
    react.mockResolvedValue({ type: 'LIKE', count: 1 });

    useMomentStore.getState().react('moment-1', 'LIKE');
    const flushA = useMomentStore.getState().flushReactions();

    useMomentStore.getState().reset();
    signIn('user-b');
    useMomentStore.getState().react('moment-1', 'LIKE');

    answerA({ type: 'LIKE', count: 99 });
    await flushA;
    await useMomentStore.getState().flushReactions();

    expect(react).toHaveBeenCalledTimes(2);
    expect(react).toHaveBeenLastCalledWith('moment-1', 'LIKE', 1);
  });
});

describe('moment processing poll', () => {
  it('does not report a video that simply expired while processing as failed', async () => {
    useMomentStore.setState({
      mine: [processing('expired', -HOUR_MS), processing('dropped', HOUR_MS), processing('still', HOUR_MS)],
    });
    mine.mockResolvedValue({ moments: [processing('still', HOUR_MS)] });

    await expect(useMomentStore.getState().refreshMine()).resolves.toEqual(['dropped']);
  });
});
