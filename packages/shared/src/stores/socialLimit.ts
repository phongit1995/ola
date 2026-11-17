import i18n from 'i18next';
import { useCallback, useEffect, useRef } from 'react';
import { create } from 'zustand';
import { SOCIAL_LIMIT_ERROR_CODES } from '../constants/socialLimit';
import { toApiError } from '../lib/apiError';
import { isVipActive } from '../lib/vip';
import { SocialLimitService } from '../services/socialLimit.service';
import type { PostQuotaResult } from '../types/api/socialLimit.type';
import { useAuthStore } from './auth/authStore';

export type SocialLimitKind = 'newChat' | 'friendRequest' | 'mePost' | 'momentPost';

export type PostLimitKind = Extract<SocialLimitKind, 'mePost' | 'momentPost'>;

const POST_QUOTA_FIELD: Record<PostLimitKind, 'me' | 'moment'> = {
  mePost: 'me',
  momentPost: 'moment',
};

export interface SocialLimitNotice {
  kind: SocialLimitKind;
  limit: number | null;
  canBuyVip: boolean;
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
  const match = Object.entries(SOCIAL_LIMIT_ERROR_CODES).find(([, value]) => value === code);
  return match ? (match[0] as SocialLimitKind) : null;
}

interface LimitDetails {
  limit: number | null;
  isVip: boolean | null;
  upgradable: boolean | null;
}

function readDetails(details: unknown): LimitDetails {
  if (details == null || typeof details !== 'object') return { limit: null, isVip: null, upgradable: null };
  const record = details as Record<string, unknown>;
  const limit = typeof record.limit === 'number' && record.limit > 0 ? record.limit : null;
  const isVip = typeof record.isVip === 'boolean' ? record.isVip : null;
  const upgradable = typeof record.upgradable === 'boolean' ? record.upgradable : null;
  return { limit, isVip, upgradable };
}

export function socialLimitNoticeOf(error: unknown): SocialLimitNotice | null {
  const apiError = toApiError(error);
  const kind = kindOf(apiError.code);
  if (kind == null) return null;
  const details = readDetails(apiError.details);
  const isVip = details.isVip ?? isVipActive(useAuthStore.getState().user?.vipEndTime);
  return { kind, limit: details.limit, canBuyVip: details.upgradable ?? !isVip };
}

export async function checkPostQuota(kind: PostLimitKind): Promise<boolean> {
  let result: PostQuotaResult;
  try {
    result = await SocialLimitService.postQuotas();
  } catch {
    return true;
  }
  const quota = result[POST_QUOTA_FIELD[kind]];
  if (quota.limit <= 0 || quota.used < quota.limit) return true;
  useSocialLimitStore.setState({ notice: { kind, limit: quota.limit, canBuyVip: quota.upgradable } });
  return false;
}

export function usePostQuotaGate(kind: PostLimitKind, open: () => void): () => void {
  const checking = useRef(false);
  const openRef = useRef(open);
  openRef.current = open;
  return useCallback(() => {
    if (checking.current) return;
    checking.current = true;
    void checkPostQuota(kind)
      .then((allowed) => {
        if (allowed) openRef.current();
      })
      .finally(() => {
        checking.current = false;
      });
  }, [kind]);
}

export function showSocialLimitNotice(error: unknown): boolean {
  const notice = socialLimitNoticeOf(error);
  if (notice == null) return false;
  useSocialLimitStore.setState({ notice });
  return true;
}

function usageMessage({ kind, limit }: SocialLimitNotice): string {
  return limit != null
    ? i18n.t(`socialLimit.${kind}`, { limit })
    : i18n.t(`socialLimit.${kind}Reached`);
}

export function socialLimitMessage(notice: SocialLimitNotice): string {
  const next = notice.canBuyVip ? i18n.t('socialLimit.vipHint') : i18n.t('socialLimit.tomorrow');
  return `${usageMessage(notice)} ${next}`;
}
