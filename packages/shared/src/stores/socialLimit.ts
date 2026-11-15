import i18n from 'i18next';
import { useEffect, useRef } from 'react';
import { create } from 'zustand';
import { SOCIAL_LIMIT_ERROR_CODES } from '../constants/socialLimit';
import { toApiError } from '../lib/apiError';
import { isVipActive } from '../lib/vip';
import { useAuthStore } from './auth/authStore';

export type SocialLimitKind = 'newChat' | 'friendRequest';

export interface SocialLimitNotice {
  kind: SocialLimitKind;
  limit: number | null;
  isVip: boolean;
}

interface SocialLimitState {
  notice: SocialLimitNotice | null;
  buySeq: number;
  close: () => void;
  requestBuy: () => void;
}

export const useSocialLimitStore = create<SocialLimitState>((set) => ({
  notice: null,
  buySeq: 0,
  close: () => set({ notice: null }),
  requestBuy: () => set((state) => ({ notice: null, buySeq: state.buySeq + 1 })),
}));

export function useCloseOnSocialLimitBuy(onClose: () => void): void {
  const buySeq = useSocialLimitStore((state) => state.buySeq);
  const seen = useRef(buySeq);
  const closeRef = useRef(onClose);
  closeRef.current = onClose;
  useEffect(() => {
    if (buySeq === seen.current) return;
    seen.current = buySeq;
    closeRef.current();
  }, [buySeq]);
}

function kindOf(code: string | undefined): SocialLimitKind | null {
  if (code === SOCIAL_LIMIT_ERROR_CODES.newChat) return 'newChat';
  if (code === SOCIAL_LIMIT_ERROR_CODES.friendRequest) return 'friendRequest';
  return null;
}

function readDetails(details: unknown): { limit: number | null; isVip: boolean | null } {
  if (details == null || typeof details !== 'object') return { limit: null, isVip: null };
  const record = details as Record<string, unknown>;
  const limit = typeof record.limit === 'number' && record.limit > 0 ? record.limit : null;
  const isVip = typeof record.isVip === 'boolean' ? record.isVip : null;
  return { limit, isVip };
}

export function socialLimitNoticeOf(error: unknown): SocialLimitNotice | null {
  const apiError = toApiError(error);
  const kind = kindOf(apiError.code);
  if (kind == null) return null;
  const details = readDetails(apiError.details);
  return {
    kind,
    limit: details.limit,
    isVip: details.isVip ?? isVipActive(useAuthStore.getState().user?.vipEndTime),
  };
}

export function showSocialLimitNotice(error: unknown): boolean {
  const notice = socialLimitNoticeOf(error);
  if (notice == null) return false;
  useSocialLimitStore.setState({ notice });
  return true;
}

function usageMessage({ kind, limit }: SocialLimitNotice): string {
  if (kind === 'newChat') {
    return limit != null
      ? i18n.t('socialLimit.newChat', { limit })
      : i18n.t('socialLimit.newChatReached');
  }
  return limit != null
    ? i18n.t('socialLimit.friendRequest', { limit })
    : i18n.t('socialLimit.friendRequestReached');
}

export function socialLimitMessage(notice: SocialLimitNotice): string {
  const next = notice.isVip ? i18n.t('socialLimit.tomorrow') : i18n.t('socialLimit.vipHint');
  return `${usageMessage(notice)} ${next}`;
}
