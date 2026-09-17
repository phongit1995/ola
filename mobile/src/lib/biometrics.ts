import NativeOlaAppLock from '@components/specs/NativeOlaAppLock';
import {
  normalizeBiometricOutcome,
  normalizeBiometryType,
  type BiometricOutcome,
  type BiometryType,
} from './appLock';

let promptActive = false;

export function isBiometricPromptActive(): boolean {
  return promptActive;
}

export async function getBiometryType(): Promise<BiometryType> {
  if (NativeOlaAppLock == null) return '';
  try {
    return normalizeBiometryType(await NativeOlaAppLock.biometryType());
  } catch {
    return '';
  }
}

export async function authenticateBiometric(
  title: string,
  cancelLabel: string,
  subtitle = ''
): Promise<BiometricOutcome> {
  if (NativeOlaAppLock == null) return 'unavailable';
  promptActive = true;
  try {
    return normalizeBiometricOutcome(
      await NativeOlaAppLock.authenticate(title, subtitle, cancelLabel)
    );
  } catch {
    return 'failed';
  } finally {
    promptActive = false;
  }
}
