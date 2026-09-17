import { useCallback, useEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { AppState } from 'react-native';
import { toast } from '@ola/shared/lib';
import { useAppLockStore } from '@store/appLockStore';
import { biometryLabelKey, remainingAttempts, type BiometryType } from '@lib/appLock';
import { authenticateBiometric, getBiometryType, isBiometricPromptActive } from '@lib/biometrics';
import { PinEntryView } from './PinEntryView';

const REPROMPT_GUARD_MS = 1000;

interface PinVerifyProps {
  title: string;
  allowBiometric?: boolean;
  autoPrompt?: boolean;
  onSuccess: () => void;
  onCancel?: () => void;
  footer?: ReactNode;
}

export function PinVerify({
  title,
  allowBiometric = false,
  autoPrompt = false,
  onSuccess,
  onCancel,
  footer,
}: PinVerifyProps) {
  const { t } = useTranslation();
  const verifyPin = useAppLockStore((s) => s.verifyPin);
  const failedAttempts = useAppLockStore((s) => s.failedAttempts);
  const lockoutUntil = useAppLockStore((s) => s.lockoutUntil);
  const biometricEnabled = useAppLockStore((s) => s.biometricEnabled);
  const [biometryType, setBiometryType] = useState<BiometryType>('');
  const [now, setNow] = useState(() => Date.now());
  const [failedHere, setFailedHere] = useState(false);
  const lastPromptEndRef = useRef(0);
  const wentBackgroundRef = useRef(false);
  const onSuccessRef = useRef(onSuccess);
  onSuccessRef.current = onSuccess;

  const canUseBiometric = allowBiometric && biometricEnabled && biometryType !== '';
  const lockedOut = lockoutUntil > now;

  useEffect(() => {
    let active = true;
    void getBiometryType().then((type) => {
      if (active) setBiometryType(type);
    });
    return () => {
      active = false;
    };
  }, []);

  useEffect(() => {
    if (!lockedOut) return;
    const timer = setInterval(() => setNow(Date.now()), 1000);
    return () => clearInterval(timer);
  }, [lockedOut]);

  const promptBiometric = useCallback(async () => {
    if (isBiometricPromptActive() || Date.now() - lastPromptEndRef.current < REPROMPT_GUARD_MS) {
      return;
    }
    const outcome = await authenticateBiometric(
      t('appLock.promptTitle'),
      t('appLock.promptCancel'),
      t('appLock.promptSubtitle')
    );
    lastPromptEndRef.current = Date.now();
    if (outcome === 'success') onSuccessRef.current();
    else if (outcome === 'lockout') toast.info(t('appLock.biometricLockout'));
    else if (outcome === 'failed') toast.error(t('appLock.biometricFailed'));
  }, [t]);

  useEffect(() => {
    if (!autoPrompt || !canUseBiometric) return;
    void promptBiometric();
    const subscription = AppState.addEventListener('change', (state) => {
      if (state === 'background' && !isBiometricPromptActive()) {
        wentBackgroundRef.current = true;
      } else if (state === 'active' && wentBackgroundRef.current) {
        wentBackgroundRef.current = false;
        void promptBiometric();
      }
    });
    return () => subscription.remove();
  }, [autoPrompt, canUseBiometric, promptBiometric]);

  function handleSubmit(pin: string): boolean {
    if (lockedOut) return false;
    const ok = verifyPin(pin);
    if (ok) {
      setFailedHere(false);
      onSuccess();
      return true;
    }
    setFailedHere(true);
    setNow(Date.now());
    return false;
  }

  let errorText: string | null = null;
  if (lockedOut) {
    errorText = t('appLock.lockedOut', { seconds: Math.ceil((lockoutUntil - now) / 1000) });
  } else if (failedHere && failedAttempts > 0) {
    errorText = `${t('appLock.wrongPin')} · ${t('appLock.attemptsLeft', {
      count: remainingAttempts(failedAttempts),
    })}`;
  }

  return (
    <PinEntryView
      title={title}
      subtitle={
        canUseBiometric
          ? t('appLock.useBiometric', { method: t(biometryLabelKey(biometryType)) })
          : undefined
      }
      errorText={errorText}
      disabled={lockedOut}
      biometryType={canUseBiometric ? biometryType : ''}
      onBiometric={canUseBiometric ? () => void promptBiometric() : undefined}
      onSubmit={handleSubmit}
      onCancel={onCancel}
      footer={footer}
    />
  );
}
