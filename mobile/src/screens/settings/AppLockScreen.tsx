import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Platform, ScrollView, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { toast } from '@ola/shared/lib';
import { PinEntryModal, type PinEntryMode } from '@components/applock/PinEntryModal';
import { ListOptionDialog } from '@components/ui/ListOptionDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import type { RootStackParamList } from '@navigation/types';
import type { ROOT_ROUTES } from '@navigation/routes';
import {
  AUTO_LOCK_OPTIONS,
  biometryLabelKey,
  type AutoLockSeconds,
  type BiometryType,
} from '@lib/appLock';
import { authenticateBiometric, getBiometryType } from '@lib/biometrics';
import { useAppLockStore } from '@store/appLockStore';
import { LinkRow, SectionIcon, SettingRow, SettingsCard, ToggleSwitch } from './components';

const iconPrivacy = require('@assets/icons/settings/icon-privacy.webp');

type Purpose = 'enable' | 'disable' | 'change-verify' | 'change-create';

interface PinFlow {
  purpose: Purpose;
  mode: PinEntryMode;
}

const FLOW_BY_PURPOSE: Record<Purpose, PinEntryMode> = {
  enable: 'create',
  disable: 'verify',
  'change-verify': 'verify',
  'change-create': 'create',
};

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.AppLock>;

export function AppLockScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const enabled = useAppLockStore((s) => s.enabled);
  const biometricEnabled = useAppLockStore((s) => s.biometricEnabled);
  const autoLockSeconds = useAppLockStore((s) => s.autoLockSeconds);
  const [biometryType, setBiometryType] = useState<BiometryType>('');
  const [flow, setFlow] = useState<PinFlow | null>(null);
  const [autoLockOpen, setAutoLockOpen] = useState(false);
  const [authenticating, setAuthenticating] = useState(false);
  const pendingRef = useRef<(() => void) | null>(null);
  const lastFlowRef = useRef<PinFlow | null>(null);
  if (flow != null) lastFlowRef.current = flow;
  const shownFlow = flow ?? lastFlowRef.current;

  useEffect(() => {
    let active = true;
    void getBiometryType().then((type) => {
      if (active) setBiometryType(type);
    });
    return () => {
      active = false;
    };
  }, []);

  const runPending = useCallback(() => {
    const action = pendingRef.current;
    pendingRef.current = null;
    action?.();
  }, []);

  function closeFlow(then?: () => void) {
    pendingRef.current = then ?? null;
    setFlow(null);
    if (then != null && Platform.OS !== 'ios') requestAnimationFrame(runPending);
  }

  function openFlow(purpose: Purpose) {
    setFlow({ purpose, mode: FLOW_BY_PURPOSE[purpose] });
  }

  function handleFlowSuccess(pin: string) {
    const store = useAppLockStore.getState();
    switch (flow?.purpose) {
      case 'enable':
        store.setPin(pin);
        closeFlow(() => toast.success(t('appLock.enabledToast')));
        break;
      case 'disable':
        store.disable();
        closeFlow(() => toast.success(t('appLock.disabledToast')));
        break;
      case 'change-verify':
        closeFlow(() => openFlow('change-create'));
        break;
      case 'change-create':
        store.setPin(pin);
        closeFlow(() => toast.success(t('appLock.pinChanged')));
        break;
      default:
        closeFlow();
    }
  }

  async function toggleBiometric() {
    if (biometricEnabled) {
      useAppLockStore.getState().setBiometricEnabled(false);
      return;
    }
    if (authenticating) return;
    setAuthenticating(true);
    const outcome = await authenticateBiometric(
      t('appLock.promptTitle'),
      t('dialog.cancel'),
      t('appLock.promptSubtitle')
    );
    setAuthenticating(false);
    if (outcome === 'success') {
      useAppLockStore.getState().setBiometricEnabled(true);
      toast.success(t('appLock.biometricOn', { method: t(biometryLabelKey(biometryType)) }));
    } else if (outcome === 'lockout') toast.info(t('appLock.biometricLockout'));
    else if (outcome === 'unavailable') toast.error(t('appLock.biometricUnavailable'));
    else if (outcome === 'failed') toast.error(t('appLock.biometricFailed'));
  }

  function autoLockLabel(seconds: AutoLockSeconds): string {
    return seconds === 0
      ? t('appLock.autoLockImmediate')
      : t('appLock.autoLockMinutes', { count: seconds / 60 });
  }

  const biometryAvailable = biometryType !== '';
  const methodLabel = t(biometryLabelKey(biometryType));
  const flowTitle =
    shownFlow?.purpose === 'change-verify' ? t('appLock.currentPin') : t('appLock.enterPin');

  return (
    <View className="flex-1" style={{ backgroundColor: '#eef0f2' }}>
      <ScreenHeader title={t('appLock.title')} centerTitle onBack={() => navigation.goBack()} />
      <ScrollView
        className="flex-1"
        contentContainerClassName="gap-4 px-4 py-4"
        contentContainerStyle={{ paddingBottom: Math.max(insets.bottom, 16) }}
      >
        <SettingsCard icon={<SectionIcon src={iconPrivacy} />} title={t('appLock.securityTitle')}>
          <SettingRow label={t('appLock.enable')} hint={t('appLock.enableHint')} last={!enabled}>
            <ToggleSwitch on={enabled} onChange={() => openFlow(enabled ? 'disable' : 'enable')} />
          </SettingRow>
          {enabled && (
            <>
              <LinkRow label={t('appLock.changePin')} onPress={() => openFlow('change-verify')} />
              <SettingRow
                label={t('appLock.biometric', { method: methodLabel })}
                hint={biometryAvailable ? undefined : t('appLock.biometricUnavailable')}
              >
                <ToggleSwitch
                  on={biometricEnabled && biometryAvailable}
                  disabled={!biometryAvailable || authenticating}
                  onChange={() => void toggleBiometric()}
                />
              </SettingRow>
              <LinkRow
                label={t('appLock.autoLock')}
                value={autoLockLabel(autoLockSeconds)}
                last
                onPress={() => setAutoLockOpen(true)}
              />
            </>
          )}
        </SettingsCard>
      </ScrollView>

      <PinEntryModal
        visible={flow != null}
        mode={shownFlow?.mode ?? 'verify'}
        title={flowTitle}
        allowBiometric={shownFlow?.mode === 'verify'}
        onSuccess={handleFlowSuccess}
        onCancel={() => closeFlow()}
        onDismiss={runPending}
      />
      <ListOptionDialog
        visible={autoLockOpen}
        title={t('appLock.autoLock')}
        onClose={() => setAutoLockOpen(false)}
        options={AUTO_LOCK_OPTIONS.map((seconds) => ({
          key: String(seconds),
          label: `${autoLockLabel(seconds)}${seconds === autoLockSeconds ? ' ✓' : ''}`,
          onSelect: () => useAppLockStore.getState().setAutoLockSeconds(seconds),
        }))}
      />
    </View>
  );
}
