import { useCallback, useEffect, useState } from 'react';
import i18n from 'i18next';
import { DEFAULT_MEGAPHONE_CONFIG } from '../../constants/megaphone';
import { toApiError } from '../../lib/apiError';
import {
  megaphoneErrorText,
  megaphoneLength,
  megaphoneWaitMinutes,
  normalizeMegaphoneContent,
} from '../../lib/megaphone';
import { randomUuid } from '../../lib/randomUuid';
import { toast } from '../../lib/toast';
import { MegaphoneService } from '../../services/megaphone.service';
import type { MegaphoneConfig } from '../../types/api/megaphone.type';
import type {
  MegaphoneComposer,
  MegaphoneComposerOptions,
  MegaphoneComposerStep,
} from '../../types/client/megaphone.type';
import { setAuthUserKen, useAuthStore } from '../auth/authStore';
import { useMegaphoneStore } from './megaphoneStore';

export type { MegaphoneComposer, MegaphoneComposerOptions } from '../../types/client/megaphone.type';

const COOLDOWN_TICK_MS = 1000;
const OWN_MEGAPHONE_PLAY_DELAY_MS = 500;
const REFRESH_CONFIG_CODES = new Set(['MEGAPHONE_COOLDOWN', 'MEGAPHONE_DAILY_LIMIT', 'MEGAPHONE_QUEUE_FULL']);

interface LoadedConfig {
  config: MegaphoneConfig;
  cooldownUntil: number;
}

export function useMegaphoneComposer({ onClose, onSent }: MegaphoneComposerOptions): MegaphoneComposer {
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const [loaded, setLoaded] = useState<LoadedConfig | null>(null);
  const [loadError, setLoadError] = useState(false);
  const [content, setContent] = useState('');
  const [step, setStep] = useState<MegaphoneComposerStep>('compose');
  const [submitting, setSubmitting] = useState(false);
  const [requestId, setRequestId] = useState(randomUuid);
  const [now, setNow] = useState(() => Date.now());

  const loadConfig = useCallback(async () => {
    try {
      const config = await MegaphoneService.config();
      const fetchedAt = Date.now();
      setLoaded({ config, cooldownUntil: fetchedAt + config.cooldownRemaining * 1000 });
      setNow(fetchedAt);
      setLoadError(false);
    } catch {
      setLoadError(true);
    }
  }, []);

  useEffect(() => {
    const timer = setTimeout(() => void loadConfig(), 0);
    return () => clearTimeout(timer);
  }, [loadConfig]);

  const config = loaded?.config ?? DEFAULT_MEGAPHONE_CONFIG;
  const cooldownLeft = loaded != null ? Math.max(0, Math.ceil((loaded.cooldownUntil - now) / 1000)) : 0;

  useEffect(() => {
    if (cooldownLeft <= 0) return;
    const timer = setTimeout(() => setNow(Date.now()), COOLDOWN_TICK_MS);
    return () => clearTimeout(timer);
  }, [cooldownLeft, now]);

  const normalizedContent = normalizeMegaphoneContent(content);
  const length = megaphoneLength(content);
  const remaining = config.maxLength - length;
  const tooLong = remaining < 0;
  const affordable = balance >= config.kenPrice;
  const dailyLeft = Math.max(0, config.dailyLimit - config.todayCount);
  const canSend =
    loaded != null &&
    config.enabled &&
    length > 0 &&
    !tooLong &&
    affordable &&
    cooldownLeft === 0 &&
    dailyLeft > 0 &&
    !submitting;

  async function submit() {
    setSubmitting(true);
    try {
      const result = await MegaphoneService.send({
        content: normalizedContent,
        clientRequestId: requestId,
      });
      setAuthUserKen(result.kenBalance);
      toast.success(
        result.waitSeconds > 0
          ? i18n.t('megaphone.sentQueued', { minutes: megaphoneWaitMinutes(result.waitSeconds) })
          : i18n.t('megaphone.sent')
      );
      onSent?.(result);
      onClose();
      if (result.waitSeconds === 0) {
        setTimeout(() => useMegaphoneStore.getState().play(result.megaphone), OWN_MEGAPHONE_PLAY_DELAY_MS);
      }
    } catch (error) {
      const apiError = toApiError(error);
      toast.error(megaphoneErrorText(i18n.t, apiError));
      setStep('compose');
      if (apiError.code != null && REFRESH_CONFIG_CODES.has(apiError.code)) void loadConfig();
    } finally {
      setSubmitting(false);
    }
  }

  return {
    config,
    loaded: loaded != null,
    loadError,
    content,
    normalizedContent,
    length,
    remaining,
    tooLong,
    balance,
    affordable,
    cooldownLeft,
    dailyLeft,
    waitMinutes: config.queueWaitSeconds > 0 ? megaphoneWaitMinutes(config.queueWaitSeconds) : 0,
    step,
    submitting,
    canSend,
    changeContent: (value) => {
      setContent(value);
      setRequestId(randomUuid());
    },
    requestSend: () => {
      if (canSend) setStep('confirm');
    },
    confirmSend: () => {
      if (!submitting) void submit();
    },
    cancelConfirm: () => setStep('compose'),
  };
}
