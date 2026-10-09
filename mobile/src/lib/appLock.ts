import type { ParseKeys } from 'i18next';
import { randomUuid } from '@ola/shared/lib';
import { sha256Hex } from './sha256';

export const PIN_LENGTH = 4;
export const MAX_PIN_ATTEMPTS = 5;
export const LOCKOUT_BASE_MS = 30_000;
export const LOCKOUT_MAX_MS = 5 * 60_000;

export const AUTO_LOCK_OPTIONS = [0, 60, 300, 900] as const;
export type AutoLockSeconds = (typeof AUTO_LOCK_OPTIONS)[number];

export type BiometryType =
  | ''
  | 'faceId'
  | 'touchId'
  | 'fingerprint'
  | 'face'
  | 'iris'
  | 'biometric';

export type BiometricOutcome = 'success' | 'cancel' | 'failed' | 'lockout' | 'unavailable';

const BIOMETRY_TYPES: BiometryType[] = [
  'faceId',
  'touchId',
  'fingerprint',
  'face',
  'iris',
  'biometric',
];

const BIOMETRIC_OUTCOMES: BiometricOutcome[] = [
  'success',
  'cancel',
  'failed',
  'lockout',
  'unavailable',
];

const BIOMETRY_LABEL_KEYS: Record<Exclude<BiometryType, ''>, ParseKeys> = {
  faceId: 'appLock.methodFaceId',
  touchId: 'appLock.methodTouchId',
  fingerprint: 'appLock.methodFingerprint',
  face: 'appLock.methodFace',
  iris: 'appLock.methodIris',
  biometric: 'appLock.methodBiometric',
};

export function normalizeBiometryType(value: unknown): BiometryType {
  return BIOMETRY_TYPES.includes(value as BiometryType) ? (value as BiometryType) : '';
}

export function normalizeBiometricOutcome(value: unknown): BiometricOutcome {
  return BIOMETRIC_OUTCOMES.includes(value as BiometricOutcome)
    ? (value as BiometricOutcome)
    : 'failed';
}

export function biometryLabelKey(type: BiometryType): ParseKeys {
  return type === '' ? BIOMETRY_LABEL_KEYS.biometric : BIOMETRY_LABEL_KEYS[type];
}

export function isFaceBiometry(type: BiometryType): boolean {
  return type === 'faceId' || type === 'face';
}

export function isValidPin(pin: string): boolean {
  return pin.length === PIN_LENGTH && /^\d+$/.test(pin);
}

export function createPinSalt(): string {
  return randomUuid().replace(/-/g, '');
}

export function hashPin(pin: string, salt: string): string {
  return sha256Hex(`${salt}:${pin}`);
}

export function pinMatches(pin: string, salt: string, hash: string): boolean {
  return hash !== '' && hashPin(pin, salt) === hash;
}

export function lockoutDurationMs(failedAttempts: number): number {
  if (failedAttempts < MAX_PIN_ATTEMPTS) return 0;
  const multiplier = 2 ** (failedAttempts - MAX_PIN_ATTEMPTS);
  return Math.min(LOCKOUT_BASE_MS * multiplier, LOCKOUT_MAX_MS);
}

export function remainingAttempts(failedAttempts: number): number {
  return Math.max(MAX_PIN_ATTEMPTS - failedAttempts, 0);
}

export function shouldLockAfterBackground(
  backgroundAt: number | null,
  now: number,
  autoLockSeconds: AutoLockSeconds
): boolean {
  if (backgroundAt == null) return false;
  return now - backgroundAt >= autoLockSeconds * 1000;
}
