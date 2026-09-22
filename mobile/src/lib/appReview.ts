import { Linking, Platform } from 'react-native';
import DeviceInfo from 'react-native-device-info';
import InAppReview from 'react-native-in-app-review';
import { getKeyValueStorage } from '@ola/shared/platform';
import {
  IOS_APP_STORE_ID,
  appStoreReviewUrl,
  appStoreWebReviewUrl,
  playStoreAppUrl,
  playStoreWebUrl,
} from '@constants/appStore';
import { trackEvent } from '@lib/telemetry';

const STATE_KEY = 'ola.app-review.v1';
const DAY_MS = 24 * 60 * 60 * 1000;
const MIN_DAYS_SINCE_FIRST_RUN = 3;
const MIN_MOMENTS_BEFORE_PROMPT = 3;
const MIN_DAYS_BETWEEN_PROMPTS = 60;
const MAX_PROMPTS_PER_INSTALL = 3;

export const APP_REVIEW_TRIGGERS = {
  kenTreasure: 'ken_treasure',
  eggWin: 'egg_win',
} as const;

export type AppReviewTrigger =
  (typeof APP_REVIEW_TRIGGERS)[keyof typeof APP_REVIEW_TRIGGERS];

interface AppReviewState {
  firstSeenAt: number;
  moments: number;
  prompts: number;
  lastPromptAt: number;
}

const INITIAL_STATE: AppReviewState = {
  firstSeenAt: 0,
  moments: 0,
  prompts: 0,
  lastPromptAt: 0,
};

function readNumber(source: Record<string, unknown>, key: keyof AppReviewState): number {
  const value = source[key];
  return typeof value === 'number' && Number.isFinite(value) ? value : 0;
}

function readState(): AppReviewState {
  try {
    const raw = getKeyValueStorage().getItem(STATE_KEY);
    if (raw == null) return INITIAL_STATE;
    const parsed: unknown = JSON.parse(raw);
    if (typeof parsed !== 'object' || parsed == null) return INITIAL_STATE;
    const source = parsed as Record<string, unknown>;
    return {
      firstSeenAt: readNumber(source, 'firstSeenAt'),
      moments: readNumber(source, 'moments'),
      prompts: readNumber(source, 'prompts'),
      lastPromptAt: readNumber(source, 'lastPromptAt'),
    };
  } catch {
    return INITIAL_STATE;
  }
}

function writeState(state: AppReviewState): void {
  try {
    getKeyValueStorage().setItem(STATE_KEY, JSON.stringify(state));
  } catch {
    return;
  }
}

function canPrompt(state: AppReviewState, now: number): boolean {
  if (state.prompts >= MAX_PROMPTS_PER_INSTALL) return false;
  if (state.moments < MIN_MOMENTS_BEFORE_PROMPT) return false;
  if (now - state.firstSeenAt < MIN_DAYS_SINCE_FIRST_RUN * DAY_MS) return false;
  if (state.lastPromptAt !== 0 && now - state.lastPromptAt < MIN_DAYS_BETWEEN_PROMPTS * DAY_MS) {
    return false;
  }
  return true;
}

async function requestNativeReview(): Promise<boolean> {
  try {
    if (!InAppReview.isAvailable()) return false;
    const pending = InAppReview.RequestInAppReview();
    if (pending == null) return false;
    await pending;
    return true;
  } catch {
    return false;
  }
}

function storeListingUrls(): string[] {
  if (Platform.OS === 'android') {
    const packageId = DeviceInfo.getBundleId();
    return [playStoreAppUrl(packageId), playStoreWebUrl(packageId)];
  }
  if (Platform.OS === 'ios' && IOS_APP_STORE_ID !== '') {
    return [appStoreReviewUrl(IOS_APP_STORE_ID), appStoreWebReviewUrl(IOS_APP_STORE_ID)];
  }
  return [];
}

async function openStoreListing(): Promise<boolean> {
  for (const url of storeListingUrls()) {
    try {
      await Linking.openURL(url);
      return true;
    } catch {
      continue;
    }
  }
  return false;
}

export function initAppReview(): void {
  const state = readState();
  if (state.firstSeenAt !== 0) return;
  writeState({ ...state, firstSeenAt: Date.now() });
}

// Gọi ở những khoảnh khắc người dùng vừa nhận được thứ gì đó vui, KHÔNG gọi lúc
// mở app: cả Apple lẫn Google đều giới hạn số lần hiện popup và không báo lại
// kết quả, nên mỗi lần bắn đi là một lượt bị tiêu.
export function maybeAskForReview(trigger: AppReviewTrigger): void {
  const now = Date.now();
  const previous = readState();
  const next: AppReviewState = {
    ...previous,
    firstSeenAt: previous.firstSeenAt === 0 ? now : previous.firstSeenAt,
    moments: previous.moments + 1,
  };
  if (!canPrompt(next, now)) {
    writeState(next);
    return;
  }
  writeState({ ...next, prompts: next.prompts + 1, lastPromptAt: now });
  trackEvent('app_review_prompt', { trigger });
  void requestNativeReview();
}

export async function openAppReview(): Promise<boolean> {
  trackEvent('app_review_manual', { platform: Platform.OS });
  if (await openStoreListing()) return true;
  return requestNativeReview();
}
