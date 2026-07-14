import { getApp } from '@react-native-firebase/app';
import {
  getAnalytics,
  logEvent,
  logScreenView,
  setUserId as setAnalyticsUserId,
} from '@react-native-firebase/analytics';
import type { Analytics } from '@react-native-firebase/analytics';
import {
  getCrashlytics,
  log as crashlyticsLog,
  recordError,
  setCrashlyticsCollectionEnabled,
  setUserId as setCrashlyticsUserId,
} from '@react-native-firebase/crashlytics';
import type { Crashlytics } from '@react-native-firebase/crashlytics';

export type TelemetryParams = Record<string, string | number | boolean>;

let analyticsInstance: Analytics | null = null;
let crashlyticsInstance: Crashlytics | null = null;

function analytics(): Analytics {
  analyticsInstance ??= getAnalytics(getApp());
  return analyticsInstance;
}

function crashlytics(): Crashlytics {
  crashlyticsInstance ??= getCrashlytics();
  return crashlyticsInstance;
}

function fireAndForget(action: () => Promise<unknown> | void): void {
  void (async () => action())().catch(() => undefined);
}

export function initTelemetry(): void {
  if (__DEV__) {
    fireAndForget(() => setCrashlyticsCollectionEnabled(crashlytics(), true));
  }
}

export function trackEvent(name: string, params?: TelemetryParams): void {
  fireAndForget(() => logEvent(analytics(), name, params));
}

export function trackScreen(name: string): void {
  fireAndForget(() => logScreenView(analytics(), { screen_name: name, screen_class: name }));
}

export function setTelemetryUser(userId: string | null): void {
  fireAndForget(() => setAnalyticsUserId(analytics(), userId));
  fireAndForget(() => setCrashlyticsUserId(crashlytics(), userId ?? ''));
}

export function logBreadcrumb(message: string): void {
  fireAndForget(() => crashlyticsLog(crashlytics(), message));
}

export function recordAppError(error: unknown, context?: string): void {
  fireAndForget(() => {
    if (context != null) crashlyticsLog(crashlytics(), context);
    recordError(crashlytics(), error instanceof Error ? error : new Error(String(error)));
  });
}
