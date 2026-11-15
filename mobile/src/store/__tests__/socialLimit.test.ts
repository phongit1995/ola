import { SOCIAL_LIMIT_ERROR_CODES } from '@ola/shared/constants';
import { configureKeyValueStorage } from '@ola/shared/platform';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import {
  showSocialLimitNotice,
  socialLimitMessage,
  socialLimitNoticeOf,
  useSocialLimitStore,
} from '@ola/shared/stores/socialLimit';
import type { AuthUser } from '@ola/shared/types';

jest.mock('@ola/shared/services/user.service', () => ({ UserService: {} }));

jest.mock('i18next', () => ({
  __esModule: true,
  default: {
    t: (key: string, options?: { limit?: number }) =>
      options?.limit != null ? `${key}:${options.limit}` : key,
  },
}));

function limitError(code?: string, details?: unknown) {
  return {
    isAxiosError: true,
    message: 'limit',
    response: { status: 429, data: { error: 'limit', code, details } },
  };
}

function signIn(vipEndTime: string | null) {
  useAuthStore.setState({ user: { id: 'u1', vipEndTime } as AuthUser });
}

describe('social limit notice', () => {
  beforeAll(() => {
    configureKeyValueStorage({ getItem: () => null, setItem: () => undefined, removeItem: () => undefined });
  });

  beforeEach(() => {
    useSocialLimitStore.setState({ notice: null, buySeq: 0 });
    signIn(null);
  });

  it('shows the count and asks non-VIP users to upgrade', () => {
    const notice = socialLimitNoticeOf(
      limitError(SOCIAL_LIMIT_ERROR_CODES.newChat, { limit: 5, isVip: false }),
    );
    expect(notice).toEqual({ kind: 'newChat', limit: 5, isVip: false });
    expect(socialLimitMessage(notice!)).toBe('socialLimit.newChat:5 socialLimit.vipHint');
  });

  it('tells VIP users to come back tomorrow', () => {
    const notice = socialLimitNoticeOf(
      limitError(SOCIAL_LIMIT_ERROR_CODES.friendRequest, { limit: 20, isVip: true }),
    );
    expect(socialLimitMessage(notice!)).toBe('socialLimit.friendRequest:20 socialLimit.tomorrow');
  });

  it('falls back to a generic line and the local VIP state without details', () => {
    signIn(new Date(Date.now() + 86_400_000).toISOString());
    const notice = socialLimitNoticeOf(limitError(SOCIAL_LIMIT_ERROR_CODES.newChat));
    expect(notice).toEqual({ kind: 'newChat', limit: null, isVip: true });
    expect(socialLimitMessage(notice!)).toBe('socialLimit.newChatReached socialLimit.tomorrow');
  });

  it('opens the dialog only for limit errors and signals a purchase', () => {
    expect(showSocialLimitNotice(limitError())).toBe(false);
    expect(showSocialLimitNotice(new Error('boom'))).toBe(false);
    expect(useSocialLimitStore.getState().notice).toBeNull();

    expect(showSocialLimitNotice(limitError(SOCIAL_LIMIT_ERROR_CODES.newChat, { limit: 5, isVip: false }))).toBe(true);
    expect(useSocialLimitStore.getState().notice?.kind).toBe('newChat');

    useSocialLimitStore.getState().requestBuy();
    expect(useSocialLimitStore.getState()).toMatchObject({ notice: null, buySeq: 1 });
  });
});
